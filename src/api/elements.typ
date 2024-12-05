#import "../_deps.typ" as deps
#import "../core/themes.typ": themable
#import "../util/utils.typ"

/// Create a frame around some content.
/// #info-alert[Uses #package("showybox") and can take any arguments the
/// #cmd-[showybox] command can take.]
/// #example[```
/// #frame(title:"Some lorem text")[#lorem(10)]
/// ```]
///
/// ..args (any): Arguments for #package[Showybox].
/// -> content
#let frame(..args) = themable(theme => deps.showybox.showybox(
  frame: (
    border-color: theme.primary,
    title-color: theme.primary,
    thickness: .75pt,
    radius: 4pt,
    inset: 8pt,
  ),
  ..args,
))

/// An alert box to highlight some content.
/// #example[```
/// #alert(color:purple, width:4cm)[#lorem(10)]
/// ```]
/// - color (color): Color of the alert.
/// - width (length, ratio): Width of the alert box.
/// - size (length): Size of the text.
/// - body (content): Content of the alert.
/// - ..style (any): Style arguments to be passed to #builtin[block].
/// -> content
#let alert(
  color: blue,
  width: 100%,
  size: .88em,
  ..style,
  body,
) = block(
  stroke: (left: 2pt + color, rest: 0pt),
  fill: color.lighten(88%),
  inset: 8pt,
  width: width,
  ..style,
  text(size: size, fill: color.darken(60%), body),
)


#let info-alert = alert.with(color: rgb(23, 162, 184))
#let warning-alert = alert.with(color: rgb(255, 193, 7))
#let error-alert = alert.with(color: rgb(220, 53, 69))
#let success-alert = alert.with(color: rgb(40, 167, 69))

/// Show a package name.
/// - #shortex(`#package("codelst")`)
///
/// - name (string): Name of the package.
#let package(name) = themable(theme => text(theme.emph.package, smallcaps(name)))

/// Show a module name.
/// - #shortex(`#module("util")`)
///
/// - name (string): Name of the module.
#let module(name) = themable(theme => text(theme.emph.module, utils.rawi(name)))

/// Highlight human names (with first- and lastnames).
/// - #shortex(`#name("Jonas Neugebauer")`)
/// - #shortex(`#name("J.", last:"Neugebauer")`)
///
/// - name (string): First or full name.
/// - last (string): Optional last name.
/// -> content
#let name(name, last: none) = {
  if last == none {
    let parts = utils.get-text(name).split(" ")
    last = parts.pop()
    name = parts.join(" ")
  }
  [#name #smallcaps(last)]
}

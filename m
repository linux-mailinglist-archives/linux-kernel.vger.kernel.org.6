Return-Path: <linux-kernel+bounces-545726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFBA4F0C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0E9170C58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2A277020;
	Tue,  4 Mar 2025 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AGaw/b4J"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64761FCFE4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128813; cv=none; b=k4WYx3wnazQvPWwJGZY/0p0AARKCDPo6w5m8VG7RruR46w3ipzboiHYb/kmP0mqjYRW+ZIK0Sm7uUmnQYVR+hPH2Ybl99Y8rsNA+ilOjZ/GCZjxlhQlZlheXLk9ovcmEms7faHczCx4HUmUbYqGs/IUrWBRgWU2YgF83bxFyF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128813; c=relaxed/simple;
	bh=8by4uimyFoyXJGZcecfwkUJiUsNUtUQiVah/S9pRgus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8ieyHx0j0fPCVlQ9pGlI/MYns5WbUxM2yqITO+mekG0zatzktbmlOmTk+sIVZphbWIhS2PY5quKRuz3K24y7HA0i7yBeNkknrhQyvpW6JPGrFU0KAJURoU/R/1MP2R7Xc1uzOflMFj6O0nIty0ZoPmxpffbBNxHjafjg/6Pt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AGaw/b4J; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128802; x=1741388002;
	bh=8gdvHyGsWVtgRydE1JVmSupdmorZGmqHiO9RKAFLfKc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AGaw/b4JmlSdIoHUxPF24GhabDfXi5ODHhQArRIoQqhws89c427PTD0D1oUvemJnz
	 XuWiUZeSMYUxAeUjnk1e49C1C4cmqW7GfTduBD5VK1PgOFyKp6YV9BjUAODnqYNZwL
	 mX9kbRw6T83+xMVJwHksDYIknPqArBzVlMUZo6pnzrvLLjDShW+uWaTgE67ubG338i
	 mdadwxq6kcvUYwElpwsBw5aUzm4V4GamQCKJGjK4xJBreiHZCanfxBKZ2PJtwFTGKe
	 Xut6MN1LgQHy1sCmTGA/MLeR4nUXozhWvYcaj+ySpXg19o1sqHSIc4BD5a0eWrYu8d
	 FL707SVcAm/1w==
Date: Tue, 04 Mar 2025 22:53:16 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 02/22] rust: move pin-init API into its own directory
Message-ID: <20250304225245.2033120-3-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ca44fc0c1a9c1c4308a740606722b0701e1b76ab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In preparation of splitting off the pin-init crate from the kernel
crate, move all pin-init API code (including proc-macros) into
`rust/pin-init`.

Moved modules have their import path adjusted via the `#[path =3D "..."]`
attribute. This allows the files to still be imported in the kernel
crate even though the files are in different directories.

Code that is moved out of files (but the file itself stays where it is)
is imported via the `include!` macro. This also allows the code to be
moved while still being part of the kernel crate.

Note that this commit moves the generics parsing code out of the GPL-2.0
file `rust/macros/helpers.rs` into the Apache-2.0 OR MIT file
`rust/pin_init/internal/src/helpers.rs`. I am the sole author of that
code and it already is available with that license at [1].
The same is true for the entry-points of the proc-macros `pin_data`,
`pinned_drop` and `derive_zeroable` in `rust/macros/lib.rs` that are
moved to `rust/pin_data/internal/src/lib.rs`. Although there are some
smaller patches that fix the doctests.

Link: https://github.com/Rust-for-Linux/pinned-init [1]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/lib.rs                            |   1 +
 rust/macros/helpers.rs                        | 146 +----------------
 rust/macros/lib.rs                            | 124 +--------------
 rust/pin-init/internal/src/helpers.rs         | 147 ++++++++++++++++++
 rust/pin-init/internal/src/lib.rs             | 122 +++++++++++++++
 .../internal/src}/pin_data.rs                 |   0
 .../internal/src}/pinned_drop.rs              |   0
 .../internal/src}/zeroable.rs                 |   0
 .../init =3D> pin-init/src}/__internal.rs       |   0
 rust/{kernel/init.rs =3D> pin-init/src/lib.rs}  |   0
 rust/{kernel/init =3D> pin-init/src}/macros.rs  |   0
 11 files changed, 275 insertions(+), 265 deletions(-)
 create mode 100644 rust/pin-init/internal/src/helpers.rs
 create mode 100644 rust/pin-init/internal/src/lib.rs
 rename rust/{macros =3D> pin-init/internal/src}/pin_data.rs (100%)
 rename rust/{macros =3D> pin-init/internal/src}/pinned_drop.rs (100%)
 rename rust/{macros =3D> pin-init/internal/src}/zeroable.rs (100%)
 rename rust/{kernel/init =3D> pin-init/src}/__internal.rs (100%)
 rename rust/{kernel/init.rs =3D> pin-init/src/lib.rs} (100%)
 rename rust/{kernel/init =3D> pin-init/src}/macros.rs (100%)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..c1b781371ba3 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -50,6 +50,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fs;
+#[path =3D "../pin-init/src/lib.rs"]
 pub mod init;
 pub mod io;
 pub mod ioctl;
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index 563dcd2b7ace..8e07703fcc16 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -70,148 +70,4 @@ pub(crate) fn expect_end(it: &mut token_stream::IntoIte=
r) {
     }
 }
=20
-/// Parsed generics.
-///
-/// See the field documentation for an explanation what each of the fields=
 represents.
-///
-/// # Examples
-///
-/// ```rust,ignore
-/// # let input =3D todo!();
-/// let (Generics { decl_generics, impl_generics, ty_generics }, rest) =3D=
 parse_generics(input);
-/// quote! {
-///     struct Foo<$($decl_generics)*> {
-///         // ...
-///     }
-///
-///     impl<$impl_generics> Foo<$ty_generics> {
-///         fn foo() {
-///             // ...
-///         }
-///     }
-/// }
-/// ```
-pub(crate) struct Generics {
-    /// The generics with bounds and default values (e.g. `T: Clone, const=
 N: usize =3D 0`).
-    ///
-    /// Use this on type definitions e.g. `struct Foo<$decl_generics> ...`=
 (or `union`/`enum`).
-    pub(crate) decl_generics: Vec<TokenTree>,
-    /// The generics with bounds (e.g. `T: Clone, const N: usize`).
-    ///
-    /// Use this on `impl` blocks e.g. `impl<$impl_generics> Trait for ...=
`.
-    pub(crate) impl_generics: Vec<TokenTree>,
-    /// The generics without bounds and without default values (e.g. `T, N=
`).
-    ///
-    /// Use this when you use the type that is declared with these generic=
s e.g.
-    /// `Foo<$ty_generics>`.
-    pub(crate) ty_generics: Vec<TokenTree>,
-}
-
-/// Parses the given `TokenStream` into `Generics` and the rest.
-///
-/// The generics are not present in the rest, but a where clause might rem=
ain.
-pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTr=
ee>) {
-    // The generics with bounds and default values.
-    let mut decl_generics =3D vec![];
-    // `impl_generics`, the declared generics with their bounds.
-    let mut impl_generics =3D vec![];
-    // Only the names of the generics, without any bounds.
-    let mut ty_generics =3D vec![];
-    // Tokens not related to the generics e.g. the `where` token and defin=
ition.
-    let mut rest =3D vec![];
-    // The current level of `<`.
-    let mut nesting =3D 0;
-    let mut toks =3D input.into_iter();
-    // If we are at the beginning of a generic parameter.
-    let mut at_start =3D true;
-    let mut skip_until_comma =3D false;
-    while let Some(tt) =3D toks.next() {
-        if nesting =3D=3D 1 && matches!(&tt, TokenTree::Punct(p) if p.as_c=
har() =3D=3D '>') {
-            // Found the end of the generics.
-            break;
-        } else if nesting >=3D 1 {
-            decl_generics.push(tt.clone());
-        }
-        match tt.clone() {
-            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
-                if nesting >=3D 1 && !skip_until_comma {
-                    // This is inside of the generics and part of some bou=
nd.
-                    impl_generics.push(tt);
-                }
-                nesting +=3D 1;
-            }
-            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
-                // This is a parsing error, so we just end it here.
-                if nesting =3D=3D 0 {
-                    break;
-                } else {
-                    nesting -=3D 1;
-                    if nesting >=3D 1 && !skip_until_comma {
-                        // We are still inside of the generics and part of=
 some bound.
-                        impl_generics.push(tt);
-                    }
-                }
-            }
-            TokenTree::Punct(p) if skip_until_comma && p.as_char() =3D=3D =
',' =3D> {
-                if nesting =3D=3D 1 {
-                    impl_generics.push(tt.clone());
-                    impl_generics.push(tt);
-                    skip_until_comma =3D false;
-                }
-            }
-            _ if !skip_until_comma =3D> {
-                match nesting {
-                    // If we haven't entered the generics yet, we still wa=
nt to keep these tokens.
-                    0 =3D> rest.push(tt),
-                    1 =3D> {
-                        // Here depending on the token, it might be a gene=
ric variable name.
-                        match tt.clone() {
-                            TokenTree::Ident(i) if at_start && i.to_string=
() =3D=3D "const" =3D> {
-                                let Some(name) =3D toks.next() else {
-                                    // Parsing error.
-                                    break;
-                                };
-                                impl_generics.push(tt);
-                                impl_generics.push(name.clone());
-                                ty_generics.push(name.clone());
-                                decl_generics.push(name);
-                                at_start =3D false;
-                            }
-                            TokenTree::Ident(_) if at_start =3D> {
-                                impl_generics.push(tt.clone());
-                                ty_generics.push(tt);
-                                at_start =3D false;
-                            }
-                            TokenTree::Punct(p) if p.as_char() =3D=3D ',' =
=3D> {
-                                impl_generics.push(tt.clone());
-                                ty_generics.push(tt);
-                                at_start =3D true;
-                            }
-                            // Lifetimes begin with `'`.
-                            TokenTree::Punct(p) if p.as_char() =3D=3D '\''=
 && at_start =3D> {
-                                impl_generics.push(tt.clone());
-                                ty_generics.push(tt);
-                            }
-                            // Generics can have default values, we skip t=
hese.
-                            TokenTree::Punct(p) if p.as_char() =3D=3D '=3D=
' =3D> {
-                                skip_until_comma =3D true;
-                            }
-                            _ =3D> impl_generics.push(tt),
-                        }
-                    }
-                    _ =3D> impl_generics.push(tt),
-                }
-            }
-            _ =3D> {}
-        }
-    }
-    rest.extend(toks);
-    (
-        Generics {
-            impl_generics,
-            decl_generics,
-            ty_generics,
-        },
-        rest,
-    )
-}
+include!("../pin-init/internal/src/helpers.rs");
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 60a0226bad42..7ff82c82ce0c 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -12,9 +12,12 @@
 mod helpers;
 mod module;
 mod paste;
+#[path =3D "../pin-init/internal/src/pin_data.rs"]
 mod pin_data;
+#[path =3D "../pin-init/internal/src/pinned_drop.rs"]
 mod pinned_drop;
 mod vtable;
+#[path =3D "../pin-init/internal/src/zeroable.rs"]
 mod zeroable;
=20
 use proc_macro::TokenStream;
@@ -232,106 +235,6 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream =
{
     concat_idents::concat_idents(ts)
 }
=20
-/// Used to specify the pinning information of the fields of a struct.
-///
-/// This is somewhat similar in purpose as
-/// [pin-project-lite](https://crates.io/crates/pin-project-lite).
-/// Place this macro on a struct definition and then `#[pin]` in front of =
the attributes of each
-/// field you want to structurally pin.
-///
-/// This macro enables the use of the [`pin_init!`] macro. When pin-initia=
lizing a `struct`,
-/// then `#[pin]` directs the type of initializer that is required.
-///
-/// If your `struct` implements `Drop`, then you need to add `PinnedDrop` =
as arguments to this
-/// macro, and change your `Drop` implementation to `PinnedDrop` annotated=
 with
-/// `#[`[`macro@pinned_drop`]`]`, since dropping pinned values requires ex=
tra care.
-///
-/// # Examples
-///
-/// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use std::{sync::Mutex, process::Command};
-/// # use kernel::macros::pin_data;
-/// #[pin_data]
-/// struct DriverData {
-///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-/// }
-/// ```
-///
-/// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use std::{sync::Mutex, process::Command};
-/// # use core::pin::Pin;
-/// # pub struct Info;
-/// # mod bindings {
-/// #     pub unsafe fn destroy_info(_ptr: *mut super::Info) {}
-/// # }
-/// use kernel::macros::{pin_data, pinned_drop};
-///
-/// #[pin_data(PinnedDrop)]
-/// struct DriverData {
-///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-///     raw_info: *mut Info,
-/// }
-///
-/// #[pinned_drop]
-/// impl PinnedDrop for DriverData {
-///     fn drop(self: Pin<&mut Self>) {
-///         unsafe { bindings::destroy_info(self.raw_info) };
-///     }
-/// }
-/// # fn main() {}
-/// ```
-///
-/// [`pin_init!`]: ../kernel/macro.pin_init.html
-//  ^ cannot use direct link, since `kernel` is not a dependency of `macro=
s`.
-#[proc_macro_attribute]
-pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
-    pin_data::pin_data(inner, item)
-}
-
-/// Used to implement `PinnedDrop` safely.
-///
-/// Only works on structs that are annotated via `#[`[`macro@pin_data`]`]`=
.
-///
-/// # Examples
-///
-/// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use macros::{pin_data, pinned_drop};
-/// # use std::{sync::Mutex, process::Command};
-/// # use core::pin::Pin;
-/// # mod bindings {
-/// #     pub struct Info;
-/// #     pub unsafe fn destroy_info(_ptr: *mut Info) {}
-/// # }
-/// #[pin_data(PinnedDrop)]
-/// struct DriverData {
-///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-///     raw_info: *mut bindings::Info,
-/// }
-///
-/// #[pinned_drop]
-/// impl PinnedDrop for DriverData {
-///     fn drop(self: Pin<&mut Self>) {
-///         unsafe { bindings::destroy_info(self.raw_info) };
-///     }
-/// }
-/// ```
-#[proc_macro_attribute]
-pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
-    pinned_drop::pinned_drop(args, input)
-}
-
 /// Paste identifiers together.
 ///
 /// Within the `paste!` macro, identifiers inside `[<` and `>]` are concat=
enated together to form a
@@ -472,23 +375,4 @@ pub fn paste(input: TokenStream) -> TokenStream {
     tokens.into_iter().collect()
 }
=20
-/// Derives the [`Zeroable`] trait for the given struct.
-///
-/// This can only be used for structs where every field implements the [`Z=
eroable`] trait.
-///
-/// # Examples
-///
-/// ```ignore
-/// use kernel::macros::Zeroable;
-///
-/// #[derive(Zeroable)]
-/// pub struct DriverData {
-///     id: i64,
-///     buf_ptr: *mut u8,
-///     len: usize,
-/// }
-/// ```
-#[proc_macro_derive(Zeroable)]
-pub fn derive_zeroable(input: TokenStream) -> TokenStream {
-    zeroable::derive(input)
-}
+include!("../pin-init/internal/src/lib.rs");
diff --git a/rust/pin-init/internal/src/helpers.rs b/rust/pin-init/internal=
/src/helpers.rs
new file mode 100644
index 000000000000..2f4fc75c014e
--- /dev/null
+++ b/rust/pin-init/internal/src/helpers.rs
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+/// Parsed generics.
+///
+/// See the field documentation for an explanation what each of the fields=
 represents.
+///
+/// # Examples
+///
+/// ```rust,ignore
+/// # let input =3D todo!();
+/// let (Generics { decl_generics, impl_generics, ty_generics }, rest) =3D=
 parse_generics(input);
+/// quote! {
+///     struct Foo<$($decl_generics)*> {
+///         // ...
+///     }
+///
+///     impl<$impl_generics> Foo<$ty_generics> {
+///         fn foo() {
+///             // ...
+///         }
+///     }
+/// }
+/// ```
+pub(crate) struct Generics {
+    /// The generics with bounds and default values (e.g. `T: Clone, const=
 N: usize =3D 0`).
+    ///
+    /// Use this on type definitions e.g. `struct Foo<$decl_generics> ...`=
 (or `union`/`enum`).
+    pub(crate) decl_generics: Vec<TokenTree>,
+    /// The generics with bounds (e.g. `T: Clone, const N: usize`).
+    ///
+    /// Use this on `impl` blocks e.g. `impl<$impl_generics> Trait for ...=
`.
+    pub(crate) impl_generics: Vec<TokenTree>,
+    /// The generics without bounds and without default values (e.g. `T, N=
`).
+    ///
+    /// Use this when you use the type that is declared with these generic=
s e.g.
+    /// `Foo<$ty_generics>`.
+    pub(crate) ty_generics: Vec<TokenTree>,
+}
+
+/// Parses the given `TokenStream` into `Generics` and the rest.
+///
+/// The generics are not present in the rest, but a where clause might rem=
ain.
+pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTr=
ee>) {
+    // The generics with bounds and default values.
+    let mut decl_generics =3D vec![];
+    // `impl_generics`, the declared generics with their bounds.
+    let mut impl_generics =3D vec![];
+    // Only the names of the generics, without any bounds.
+    let mut ty_generics =3D vec![];
+    // Tokens not related to the generics e.g. the `where` token and defin=
ition.
+    let mut rest =3D vec![];
+    // The current level of `<`.
+    let mut nesting =3D 0;
+    let mut toks =3D input.into_iter();
+    // If we are at the beginning of a generic parameter.
+    let mut at_start =3D true;
+    let mut skip_until_comma =3D false;
+    while let Some(tt) =3D toks.next() {
+        if nesting =3D=3D 1 && matches!(&tt, TokenTree::Punct(p) if p.as_c=
har() =3D=3D '>') {
+            // Found the end of the generics.
+            break;
+        } else if nesting >=3D 1 {
+            decl_generics.push(tt.clone());
+        }
+        match tt.clone() {
+            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
+                if nesting >=3D 1 && !skip_until_comma {
+                    // This is inside of the generics and part of some bou=
nd.
+                    impl_generics.push(tt);
+                }
+                nesting +=3D 1;
+            }
+            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
+                // This is a parsing error, so we just end it here.
+                if nesting =3D=3D 0 {
+                    break;
+                } else {
+                    nesting -=3D 1;
+                    if nesting >=3D 1 && !skip_until_comma {
+                        // We are still inside of the generics and part of=
 some bound.
+                        impl_generics.push(tt);
+                    }
+                }
+            }
+            TokenTree::Punct(p) if skip_until_comma && p.as_char() =3D=3D =
',' =3D> {
+                if nesting =3D=3D 1 {
+                    impl_generics.push(tt.clone());
+                    impl_generics.push(tt);
+                    skip_until_comma =3D false;
+                }
+            }
+            _ if !skip_until_comma =3D> {
+                match nesting {
+                    // If we haven't entered the generics yet, we still wa=
nt to keep these tokens.
+                    0 =3D> rest.push(tt),
+                    1 =3D> {
+                        // Here depending on the token, it might be a gene=
ric variable name.
+                        match tt.clone() {
+                            TokenTree::Ident(i) if at_start && i.to_string=
() =3D=3D "const" =3D> {
+                                let Some(name) =3D toks.next() else {
+                                    // Parsing error.
+                                    break;
+                                };
+                                impl_generics.push(tt);
+                                impl_generics.push(name.clone());
+                                ty_generics.push(name.clone());
+                                decl_generics.push(name);
+                                at_start =3D false;
+                            }
+                            TokenTree::Ident(_) if at_start =3D> {
+                                impl_generics.push(tt.clone());
+                                ty_generics.push(tt);
+                                at_start =3D false;
+                            }
+                            TokenTree::Punct(p) if p.as_char() =3D=3D ',' =
=3D> {
+                                impl_generics.push(tt.clone());
+                                ty_generics.push(tt);
+                                at_start =3D true;
+                            }
+                            // Lifetimes begin with `'`.
+                            TokenTree::Punct(p) if p.as_char() =3D=3D '\''=
 && at_start =3D> {
+                                impl_generics.push(tt.clone());
+                                ty_generics.push(tt);
+                            }
+                            // Generics can have default values, we skip t=
hese.
+                            TokenTree::Punct(p) if p.as_char() =3D=3D '=3D=
' =3D> {
+                                skip_until_comma =3D true;
+                            }
+                            _ =3D> impl_generics.push(tt),
+                        }
+                    }
+                    _ =3D> impl_generics.push(tt),
+                }
+            }
+            _ =3D> {}
+        }
+    }
+    rest.extend(toks);
+    (
+        Generics {
+            impl_generics,
+            decl_generics,
+            ty_generics,
+        },
+        rest,
+    )
+}
diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
new file mode 100644
index 000000000000..0a2761cc793c
--- /dev/null
+++ b/rust/pin-init/internal/src/lib.rs
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+/// Used to specify the pinning information of the fields of a struct.
+///
+/// This is somewhat similar in purpose as
+/// [pin-project-lite](https://crates.io/crates/pin-project-lite).
+/// Place this macro on a struct definition and then `#[pin]` in front of =
the attributes of each
+/// field you want to structurally pin.
+///
+/// This macro enables the use of the [`pin_init!`] macro. When pin-initia=
lizing a `struct`,
+/// then `#[pin]` directs the type of initializer that is required.
+///
+/// If your `struct` implements `Drop`, then you need to add `PinnedDrop` =
as arguments to this
+/// macro, and change your `Drop` implementation to `PinnedDrop` annotated=
 with
+/// `#[`[`macro@pinned_drop`]`]`, since dropping pinned values requires ex=
tra care.
+///
+/// # Examples
+///
+/// ```ignore
+/// # #![feature(lint_reasons)]
+/// # use kernel::prelude::*;
+/// # use std::{sync::Mutex, process::Command};
+/// # use kernel::macros::pin_data;
+/// #[pin_data]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
+/// }
+/// ```
+///
+/// ```ignore
+/// # #![feature(lint_reasons)]
+/// # use kernel::prelude::*;
+/// # use std::{sync::Mutex, process::Command};
+/// # use core::pin::Pin;
+/// # pub struct Info;
+/// # mod bindings {
+/// #     pub unsafe fn destroy_info(_ptr: *mut super::Info) {}
+/// # }
+/// use kernel::macros::{pin_data, pinned_drop};
+///
+/// #[pin_data(PinnedDrop)]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
+///     raw_info: *mut Info,
+/// }
+///
+/// #[pinned_drop]
+/// impl PinnedDrop for DriverData {
+///     fn drop(self: Pin<&mut Self>) {
+///         unsafe { bindings::destroy_info(self.raw_info) };
+///     }
+/// }
+/// # fn main() {}
+/// ```
+///
+/// [`pin_init!`]: ../kernel/macro.pin_init.html
+//  ^ cannot use direct link, since `kernel` is not a dependency of `macro=
s`.
+#[proc_macro_attribute]
+pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
+    pin_data::pin_data(inner, item)
+}
+
+/// Used to implement `PinnedDrop` safely.
+///
+/// Only works on structs that are annotated via `#[`[`macro@pin_data`]`]`=
.
+///
+/// # Examples
+///
+/// ```ignore
+/// # #![feature(lint_reasons)]
+/// # use kernel::prelude::*;
+/// # use macros::{pin_data, pinned_drop};
+/// # use std::{sync::Mutex, process::Command};
+/// # use core::pin::Pin;
+/// # mod bindings {
+/// #     pub struct Info;
+/// #     pub unsafe fn destroy_info(_ptr: *mut Info) {}
+/// # }
+/// #[pin_data(PinnedDrop)]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
+///     raw_info: *mut bindings::Info,
+/// }
+///
+/// #[pinned_drop]
+/// impl PinnedDrop for DriverData {
+///     fn drop(self: Pin<&mut Self>) {
+///         unsafe { bindings::destroy_info(self.raw_info) };
+///     }
+/// }
+/// ```
+#[proc_macro_attribute]
+pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
+    pinned_drop::pinned_drop(args, input)
+}
+
+/// Derives the [`Zeroable`] trait for the given struct.
+///
+/// This can only be used for structs where every field implements the [`Z=
eroable`] trait.
+///
+/// # Examples
+///
+/// ```ignore
+/// use kernel::macros::Zeroable;
+///
+/// #[derive(Zeroable)]
+/// pub struct DriverData {
+///     id: i64,
+///     buf_ptr: *mut u8,
+///     len: usize,
+/// }
+/// ```
+#[proc_macro_derive(Zeroable)]
+pub fn derive_zeroable(input: TokenStream) -> TokenStream {
+    zeroable::derive(input)
+}
diff --git a/rust/macros/pin_data.rs b/rust/pin-init/internal/src/pin_data.=
rs
similarity index 100%
rename from rust/macros/pin_data.rs
rename to rust/pin-init/internal/src/pin_data.rs
diff --git a/rust/macros/pinned_drop.rs b/rust/pin-init/internal/src/pinned=
_drop.rs
similarity index 100%
rename from rust/macros/pinned_drop.rs
rename to rust/pin-init/internal/src/pinned_drop.rs
diff --git a/rust/macros/zeroable.rs b/rust/pin-init/internal/src/zeroable.=
rs
similarity index 100%
rename from rust/macros/zeroable.rs
rename to rust/pin-init/internal/src/zeroable.rs
diff --git a/rust/kernel/init/__internal.rs b/rust/pin-init/src/__internal.=
rs
similarity index 100%
rename from rust/kernel/init/__internal.rs
rename to rust/pin-init/src/__internal.rs
diff --git a/rust/kernel/init.rs b/rust/pin-init/src/lib.rs
similarity index 100%
rename from rust/kernel/init.rs
rename to rust/pin-init/src/lib.rs
diff --git a/rust/kernel/init/macros.rs b/rust/pin-init/src/macros.rs
similarity index 100%
rename from rust/kernel/init/macros.rs
rename to rust/pin-init/src/macros.rs
--=20
2.47.2




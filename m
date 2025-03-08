Return-Path: <linux-kernel+bounces-552447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D8FA579EA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05591175C36
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD8C1E1DF9;
	Sat,  8 Mar 2025 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NiwcKVKo"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF41E1E0A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431926; cv=none; b=bcizjzc5kD3wrfPBOEtx9oVEItA5oiJGdkLzP1HZdbo5bEADf0ycDHhkVh+Tvkg720Yvpz6eLQEsl3pPcVE8/EqYyWjVNHn2UVxxcsnTpOkNIsCaaQpd2NoZ5yU3RuMYB3cohKdN9VqzF6tnBjekzIav0eGWVZKtV00a+OzswSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431926; c=relaxed/simple;
	bh=NTd/71OaQDAh3w+3jCiDTWwfeD5og5aX4apsozmjBbk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=golLnxBld3YQ7/j7nTR1MVq7NgIxittKnXKuvMQoMcQxGGR3mVIkydjSLU1gZqXhCKQ493ajxz43LMkcghZvCKQ+1DobBvXZSsvE0yd/8YY678hX3b3N26Wjz1FZqsPseryy7Vib0nGn50GAGGktjwqLAyDVhxc86EFAG+kZc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NiwcKVKo; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431921; x=1741691121;
	bh=S8S9G74ebZ/2gU3oM1lvCW6nw560h98X0LN0DFxXK0E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NiwcKVKo+0+xVxQbXGgxXDdmNr/WU5Nmpdh3t/O5oTUG857gThcMMTCeGY1/Hwfor
	 49EbWanWqhjr/peo1KF1KZ8UbitUqlDTeSYeCnPFV057Zdl4aEkGHoYHTxU19QlgeD
	 +LW8XNPMIZx45dUzj03jw37q+BYPgcBhlauze6OwbUsaxY//x5xlVIqdFIkHYSTm5k
	 AVnA2TbfRamcEHF9l+M0u/ATLEtE7rc4O0JBlBAOIuCnff4bgg7ps1dtbKs1kPFgUZ
	 Rql0PO6YABBgqfoBWZoxIsQuKoSsdlboiwxAIL60j2YIRBh941VxtU4Rpg93XXfX4B
	 F2Dild/BD1sJg==
Date: Sat, 08 Mar 2025 11:05:17 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/22] rust: pin-init: synchronize documentation with the user-space version
Message-ID: <20250308110339.2997091-18-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7cfbed361ed837472b515f4eaf4e41db491e5f63
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Synchronize documentation and examples with the user-space version.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/pin-init/src/__internal.rs |   8 +-
 rust/pin-init/src/lib.rs        | 141 +++++++++++++++++++++++---------
 rust/pin-init/src/macros.rs     |  20 ++---
 3 files changed, 115 insertions(+), 54 deletions(-)

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index cac293fd4bec..7f7744d48575 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
-//! This module contains API-internal items for pin-init.
+//! This module contains library internal items.
 //!
-//! These items must not be used outside of
-//! - `kernel/init.rs`
-//! - `macros/pin_data.rs`
-//! - `macros/pinned_drop.rs`
+//! These items must not be used outside of this crate and the pin-init-in=
ternal crate located at
+//! `../internal`.
=20
 use super::*;
=20
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 58b77a158c34..a00288133ae3 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -1,10 +1,37 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
-//! API to safely and fallibly initialize pinned `struct`s using in-place =
constructors.
+//! Library to safely and fallibly initialize pinned `struct`s using in-pl=
ace constructors.
+//!
+//! [Pinning][pinning] is Rust's way of ensuring data does not move.
 //!
 //! It also allows in-place initialization of big `struct`s that would oth=
erwise produce a stack
 //! overflow.
 //!
+//! This library's main use-case is in [Rust-for-Linux]. Although this ver=
sion can be used
+//! standalone.
+//!
+//! There are cases when you want to in-place initialize a struct. For exa=
mple when it is very big
+//! and moving it from the stack is not an option, because it is bigger th=
an the stack itself.
+//! Another reason would be that you need the address of the object to ini=
tialize it. This stands
+//! in direct conflict with Rust's normal process of first initializing an=
 object and then moving
+//! it into it's final memory location. For more information, see
+//! <https://rust-for-linux.com/the-safe-pinned-initialization-problem>.
+//!
+//! This library allows you to do in-place initialization safely.
+//!
+//! ## Nightly Needed for `alloc` feature
+//!
+//! This library requires the [`allocator_api` unstable feature] when the =
`alloc` feature is
+//! enabled and thus this feature can only be used with a nightly compiler=
. When enabling the
+//! `alloc` feature, the user will be required to activate `allocator_api`=
 as well.
+//!
+//! [`allocator_api` unstable feature]: https://doc.rust-lang.org/nightly/=
unstable-book/library-features/allocator-api.html
+//!
+//! The feature is enabled by default, thus by default `pin-init` will req=
uire a nightly compiler.
+//! However, using the crate on stable compilers is possible by disabling =
`alloc`. In practice this
+//! will require the `std` feature, because stable compilers have neither =
`Box` nor `Arc` in no-std
+//! mode.
+//!
 //! # Overview
 //!
 //! To initialize a `struct` with an in-place constructor you will need tw=
o things:
@@ -17,12 +44,17 @@
 //! - a custom function/macro returning an in-place constructor provided b=
y someone else,
 //! - using the unsafe function [`pin_init_from_closure()`] to manually cr=
eate an initializer.
 //!
-//! Aside from pinned initialization, this API also supports in-place cons=
truction without pinning,
-//! the macros/types/functions are generally named like the pinned variant=
s without the `pin`
-//! prefix.
+//! Aside from pinned initialization, this library also supports in-place =
construction without
+//! pinning, the macros/types/functions are generally named like the pinne=
d variants without the
+//! `pin_` prefix.
 //!
 //! # Examples
 //!
+//! Throughout the examples we will often make use of the `CMutex` type wh=
ich can be found in
+//! `../examples/mutex.rs`. It is essentially a userland rebuild of the `s=
truct mutex` type from
+//! the Linux kernel. It also uses a wait list and a basic spinlock. Impor=
tantly the wait list
+//! requires it to be pinned to be locked and thus is a prime candidate fo=
r using this library.
+//!
 //! ## Using the [`pin_init!`] macro
 //!
 //! If you want to use [`PinInit`], then you will have to annotate your `s=
truct` with
@@ -36,7 +68,7 @@
 //! # #![feature(allocator_api)]
 //! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 //! # use core::pin::Pin;
-//! use pin_init::*;
+//! use pin_init::{pin_data, pin_init, InPlaceInit};
 //!
 //! #[pin_data]
 //! struct Foo {
@@ -80,8 +112,8 @@
 //!
 //! ## Using a custom function/macro that returns an initializer
 //!
-//! Many types from the kernel supply a function/macro that returns an ini=
tializer, because the
-//! above method only works for types where you can access the fields.
+//! Many types that use this library supply a function/macro that returns =
an initializer, because
+//! the above method only works for types where you can access the fields.
 //!
 //! ```rust,ignore
 //! # #![feature(allocator_api)]
@@ -132,7 +164,7 @@
 //!
 //! ```rust,ignore
 //! # #![feature(extern_types)]
-//! use pin_init::*;
+//! use pin_init::{pin_data, pinned_drop, PinInit, PinnedDrop, pin_init_fr=
om_closure};
 //! use core::{
 //!     ptr::addr_of_mut,
 //!     marker::PhantomPinned,
@@ -141,8 +173,11 @@
 //!     mem::MaybeUninit,
 //! };
 //! mod bindings {
+//!     #[repr(C)]
+//!     pub struct foo {
+//!         /* fields from C ... */
+//!     }
 //!     extern "C" {
-//!         pub type foo;
 //!         pub fn init_foo(ptr: *mut foo);
 //!         pub fn destroy_foo(ptr: *mut foo);
 //!         #[must_use =3D "you must check the error return code"]
@@ -200,6 +235,10 @@
 //! }
 //! ```
 //!
+//! For more information on how to use [`pin_init_from_closure()`], take a=
 look at the uses inside
+//! the `kernel` crate. The [`sync`] module is a good starting point.
+//!
+//! [`sync`]: https://rust.docs.kernel.org/kernel/sync/index.html
 //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
 //! [structurally pinned fields]:
 //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
@@ -214,11 +253,10 @@
 )]
 #![cfg_attr(not(kernel), doc =3D "[`Arc<T>`]: alloc::alloc::sync::Arc")]
 #![cfg_attr(not(kernel), doc =3D "[`Box<T>`]: alloc::alloc::boxed::Box")]
-//! [`impl PinInit<Foo>`]: PinInit
-//! [`impl PinInit<T, E>`]: PinInit
-//! [`impl Init<T, E>`]: Init
-//! [`pin_data`]: crate::pin_data
-//! [`pin_init!`]: crate::pin_init!
+//! [`impl PinInit<Foo>`]: crate::PinInit
+//! [`impl PinInit<T, E>`]: crate::PinInit
+//! [`impl Init<T, E>`]: crate::Init
+//! [Rust-for-Linux]: https://rust-for-linux.com/
=20
 #![cfg_attr(not(RUSTC_LINT_REASONS_IS_STABLE), feature(lint_reasons))]
 #![cfg_attr(
@@ -404,8 +442,6 @@
 /// A normal `let` binding with optional type annotation. The expression i=
s expected to implement
 /// [`PinInit`]/[`Init`] with the error type [`Infallible`]. If you want t=
o use a different error
 /// type, then use [`stack_try_pin_init!`].
-///
-/// [`stack_try_pin_init!`]: crate::stack_try_pin_init!
 #[macro_export]
 macro_rules! stack_pin_init {
     (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
@@ -542,10 +578,10 @@ macro_rules! stack_try_pin_init {
 ///
 /// # Init-functions
 ///
-/// When working with this API it is often desired to let others construct=
 your types without
-/// giving access to all fields. This is where you would normally write a =
plain function `new`
-/// that would return a new instance of your type. With this API that is a=
lso possible.
-/// However, there are a few extra things to keep in mind.
+/// When working with this library it is often desired to let others const=
ruct your types without
+/// giving access to all fields. This is where you would normally write a =
plain function `new` that
+/// would return a new instance of your type. With this library that is al=
so possible. However,
+/// there are a few extra things to keep in mind.
 ///
 /// To create an initializer function, simply declare it like this:
 ///
@@ -674,22 +710,22 @@ macro_rules! stack_try_pin_init {
 ///     #[pin]
 ///     pin: PhantomPinned,
 /// }
-/// pin_init!(&this in Buf {
+///
+/// let init =3D pin_init!(&this in Buf {
 ///     buf: [0; 64],
 ///     // SAFETY: TODO.
 ///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
 ///     pin: PhantomPinned,
 /// });
-/// pin_init!(Buf {
+/// let init =3D pin_init!(Buf {
 ///     buf: [1; 64],
 ///     ..Zeroable::zeroed()
 /// });
 /// ```
 ///
-/// [`try_pin_init!`]: crate::try_pin_init
 /// [`NonNull<Self>`]: core::ptr::NonNull
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `__internal` inside of `init/__internal.rs`.
+// module `macros` inside of `macros.rs`.
 #[macro_export]
 macro_rules! pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -719,7 +755,8 @@ macro_rules! pin_init {
 /// ```rust,ignore
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
-/// use pin_init::*;
+/// use pin_init::{pin_data, try_pin_init, PinInit, InPlaceInit, zeroed};
+///
 /// #[pin_data]
 /// struct BigBuf {
 ///     big: Box<[u8; 1024 * 1024 * 1024]>,
@@ -730,7 +767,7 @@ macro_rules! pin_init {
 /// impl BigBuf {
 ///     fn new() -> impl PinInit<Self, Error> {
 ///         try_pin_init!(Self {
-///             big: Box::init(init::zeroed())?,
+///             big: Box::init(zeroed())?,
 ///             small: [0; 1024 * 1024],
 ///             ptr: core::ptr::null_mut(),
 ///         }? Error)
@@ -739,7 +776,7 @@ macro_rules! pin_init {
 /// # let _ =3D Box::pin_init(BigBuf::new());
 /// ```
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `__internal` inside of `init/__internal.rs`.
+// module `macros` inside of `macros.rs`.
 #[macro_export]
 macro_rules! try_pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -772,9 +809,30 @@ macro_rules! try_pin_init {
 /// This initializer is for initializing data in-place that might later be=
 moved. If you want to
 /// pin-initialize, use [`pin_init!`].
 ///
-/// [`try_init!`]: crate::try_init!
+/// # Examples
+///
+/// ```rust
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # use pin_init::InPlaceInit;
+/// use pin_init::{init, Init, zeroed};
+///
+/// struct BigBuf {
+///     small: [u8; 1024 * 1024],
+/// }
+///
+/// impl BigBuf {
+///     fn new() -> impl Init<Self> {
+///         init!(Self {
+///             small <- zeroed(),
+///         })
+///     }
+/// }
+/// # let _ =3D Box::init(BigBuf::new());
+/// ```
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `__internal` inside of `init/__internal.rs`.
+// module `macros` inside of `macros.rs`.
 #[macro_export]
 macro_rules! init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -804,7 +862,9 @@ macro_rules! init {
 /// ```rust,ignore
 /// # #![feature(allocator_api)]
 /// # use core::alloc::AllocError;
-/// use pin_init::*;
+/// # use pin_init::InPlaceInit;
+/// use pin_init::{try_init, Init, zeroed};
+///
 /// struct BigBuf {
 ///     big: Box<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
@@ -818,10 +878,10 @@ macro_rules! init {
 ///         }? AllocError)
 ///     }
 /// }
+/// # let _ =3D Box::init(BigBuf::new());
 /// ```
-/// [`try_pin_init!`]: crate::try_pin_init
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `__internal` inside of `init/__internal.rs`.
+// module `macros` inside of `macros.rs`.
 #[macro_export]
 macro_rules! try_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -847,7 +907,8 @@ macro_rules! try_init {
 ///
 /// This will succeed:
 /// ```ignore
-/// use pin_init::assert_pinned;
+/// use pin_init::{pin_data, assert_pinned};
+///
 /// #[pin_data]
 /// struct MyStruct {
 ///     #[pin]
@@ -859,7 +920,8 @@ macro_rules! try_init {
 ///
 /// This will fail:
 /// ```compile_fail,ignore
-/// use pin_init::assert_pinned;
+/// use pin_init::{pin_data, assert_pinned};
+///
 /// #[pin_data]
 /// struct MyStruct {
 ///     some_field: u64,
@@ -872,7 +934,9 @@ macro_rules! try_init {
 /// work around this, you may pass the `inline` parameter to the macro. Th=
e `inline` parameter can
 /// only be used when the macro is invoked from a function body.
 /// ```ignore
-/// use pin_init::assert_pinned;
+/// # use core::pin::Pin;
+/// use pin_init::{pin_data, assert_pinned};
+///
 /// #[pin_data]
 /// struct Foo<T> {
 ///     #[pin]
@@ -1056,14 +1120,15 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>:=
 PinInit<T, E> {
     ///
     /// ```rust,ignore
     /// # #![expect(clippy::disallowed_names)]
-    /// use pin_init::{init_from_closure, zeroed};
+    /// use pin_init::{init, zeroed, Init};
+    ///
     /// struct Foo {
     ///     buf: [u8; 1_000_000],
     /// }
     ///
     /// impl Foo {
     ///     fn setup(&mut self) {
-    ///         pr_info!("Setting up foo");
+    ///         println!("Setting up foo");
     ///     }
     /// }
     ///
@@ -1302,8 +1367,6 @@ pub trait InPlaceWrite<T> {
 /// # Safety
 ///
 /// This trait must be implemented via the [`pinned_drop`] proc-macro attr=
ibute on the impl.
-///
-/// [`pinned_drop`]: crate::pinned_drop
 pub unsafe trait PinnedDrop: __internal::HasPinData {
     /// Executes the pinned destructor of this type.
     ///
diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index d41c4f198c42..361623324d5c 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
 //! This module provides the macros that actually implement the proc-macro=
s `pin_data` and
-//! `pinned_drop`. It also contains `__init_internal` the implementation o=
f the `{try_}{pin_}init!`
-//! macros.
+//! `pinned_drop`. It also contains `__init_internal`, the implementation =
of the
+//! `{try_}{pin_}init!` macros.
 //!
 //! These macros should never be called directly, since they expect their =
input to be
 //! in a certain format which is internal. If used incorrectly, these macr=
os can lead to UB even in
@@ -11,16 +11,17 @@
 //! This architecture has been chosen because the kernel does not yet have=
 access to `syn` which
 //! would make matters a lot easier for implementing these as proc-macros.
 //!
+//! Since this library and the kernel implementation should diverge as lit=
tle as possible, the same
+//! approach has been taken here.
+//!
 //! # Macro expansion example
 //!
 //! This section is intended for readers trying to understand the macros i=
n this module and the
-//! `pin_init!` macros from `init.rs`.
+//! `[try_][pin_]init!` macros from `lib.rs`.
 //!
 //! We will look at the following example:
 //!
 //! ```rust,ignore
-//! # use pin_init::*;
-//! # use core::pin::Pin;
 //! #[pin_data]
 //! #[repr(C)]
 //! struct Bar<T> {
@@ -45,7 +46,7 @@
 //! #[pinned_drop]
 //! impl PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>) {
-//!         pr_info!("{self:p} is getting dropped.");
+//!         println!("{self:p} is getting dropped.");
 //!     }
 //! }
 //!
@@ -75,7 +76,6 @@
 //! Here is the definition of `Bar` from our example:
 //!
 //! ```rust,ignore
-//! # use pin_init::*;
 //! #[pin_data]
 //! #[repr(C)]
 //! struct Bar<T> {
@@ -251,7 +251,7 @@
 //!                     // is an error later. This `DropGuard` will drop t=
he field when it gets
 //!                     // dropped and has not yet been forgotten.
 //!                     let __t_guard =3D unsafe {
-//!                         ::pinned_init::__internal::DropGuard::new(::co=
re::addr_of_mut!((*slot).t))
+//!                         ::pin_init::__internal::DropGuard::new(::core:=
:addr_of_mut!((*slot).t))
 //!                     };
 //!                     // Expansion of `x: 0,`:
 //!                     // Since this can be an arbitrary expression we ca=
nnot place it inside
@@ -412,7 +412,7 @@
 //! #[pinned_drop]
 //! impl PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>) {
-//!         pr_info!("{self:p} is getting dropped.");
+//!         println!("{self:p} is getting dropped.");
 //!     }
 //! }
 //! ```
@@ -423,7 +423,7 @@
 //! // `unsafe`, full path and the token parameter are added, everything e=
lse stays the same.
 //! unsafe impl ::pin_init::PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>, _: ::pin_init::__internal::OnlyCallF=
romDrop) {
-//!         pr_info!("{self:p} is getting dropped.");
+//!         println!("{self:p} is getting dropped.");
 //!     }
 //! }
 //! ```
--=20
2.47.2




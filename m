Return-Path: <linux-kernel+bounces-545741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C5A4F0D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3250F189544E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799DA27C857;
	Tue,  4 Mar 2025 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gZBbWutE"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8427C859
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128954; cv=none; b=ipuBvD2EbDtrXjAZbtN0LCkMQ+L5GLUH35yt9HSiA96QJ4xshQngFWdlBGsBsR0BffWawfIVw131FPl5lJ4QijgoRMSHt5+sXtm5iMpF+JrkV/+SnWIkMqS2Ks2uXr8C1bo76XjMak6o4tsjc4J8tDqS2Mk+809VOYEPXSQFQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128954; c=relaxed/simple;
	bh=tzMFDEdkmSWt0mdJxcFFgvwVzUrpTR5vOdaPCMHjdDQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSO7aRU2Ws0JYJ4WUT1TuPgkpK8DG+Ba8FpAcQky4mYD2+wSdWpG3jPNADydnNq8UT8OrSQwO0VBQqM8sCkGTSAEftP80ZAEwq3Aw47uP8kcHutJ/87Q3osIqBHQt0mzOoNn0qu6VOPBKM71u//ZqpKocXRFJlsceO1rpagUp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gZBbWutE; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128949; x=1741388149;
	bh=77SkAgzdtAJxeWfNTRQabZve9YMcgs5HIT1w10L7PaI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gZBbWutEfkt+LSaUkoeG+ch3ExMY902FAC2VrIh9a7079nI/fawBEJnLevi/8/jTf
	 LBsVNi5WNa8ypNKV8EPchrVPP4cw/f1/odkCNagVk1xL7iMOwB6NlW/kHtbJ44InNz
	 oLcy63Y2AU+t7hYqU44EthIcJJNrTqwiSdG8CO6C77Dwx8ZIX4zCIEzCVYFs2wW2Ku
	 /8Tmx2aiDrsMd8YDaerbwvSgrbqmL/RtTIwQFgDsTGZtBqgBOjovAFo1svRFdwvSP5
	 V2TwWA6l9nNwevoFCi0ogoer9NdKY5MzulU2ECblXCFKqlW5vmxXn2dzcg5RFgLMpc
	 VRZtlEvSZOM9Q==
Date: Tue, 04 Mar 2025 22:55:42 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/22] rust: pin-init: synchronize documentation with the user-space version
Message-ID: <20250304225245.2033120-18-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5a9396391c16ec2fce667ce49858b106ab06d9f1
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
---
 rust/pin-init/src/__internal.rs |   8 +-
 rust/pin-init/src/lib.rs        | 143 +++++++++++++++++++++++---------
 rust/pin-init/src/macros.rs     |  20 ++---
 3 files changed, 116 insertions(+), 55 deletions(-)

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 27d4a8619c04..5336d659685d 100644
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
index 1fdca35906a0..fb64cddd1a72 100644
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
@@ -89,7 +121,7 @@
 //! # use pin_init::*;
 //! # use std::sync::Arc;
 //! # use core::pin::Pin;
-//! let mtx: Result<Pin<Arc<Mutex<usize>>>, _> =3D Arc::pin_init(CMutex::n=
ew(42));
+//! let mtx: Result<Pin<Arc<CMutex<usize>>>, _> =3D Arc::pin_init(CMutex::=
new(42));
 //! ```
 //!
 //! To declare an init macro/function you just return an [`impl PinInit<T,=
 E>`]:
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
@@ -200,17 +235,20 @@
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
 //! [stack]: crate::stack_pin_init
 //! [`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.Arc.htm=
l
 //! [`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.Box.ht=
ml
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
@@ -396,8 +434,6 @@
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
@@ -534,10 +570,10 @@ macro_rules! stack_try_pin_init {
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
@@ -666,22 +702,22 @@ macro_rules! stack_try_pin_init {
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
@@ -711,7 +747,8 @@ macro_rules! pin_init {
 /// ```rust,ignore
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
-/// use pin_init::*;
+/// use pin_init::{pin_data, try_pin_init, PinInit, InPlaceInit, zeroed};
+///
 /// #[pin_data]
 /// struct BigBuf {
 ///     big: Box<[u8; 1024 * 1024 * 1024]>,
@@ -722,7 +759,7 @@ macro_rules! pin_init {
 /// impl BigBuf {
 ///     fn new() -> impl PinInit<Self, Error> {
 ///         try_pin_init!(Self {
-///             big: Box::init(init::zeroed())?,
+///             big: Box::init(zeroed())?,
 ///             small: [0; 1024 * 1024],
 ///             ptr: core::ptr::null_mut(),
 ///         }? Error)
@@ -731,7 +768,7 @@ macro_rules! pin_init {
 /// # let _ =3D Box::pin_init(BigBuf::new());
 /// ```
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
-// module `__internal` inside of `init/__internal.rs`.
+// module `macros` inside of `macros.rs`.
 #[macro_export]
 macro_rules! try_pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -764,9 +801,30 @@ macro_rules! try_pin_init {
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
@@ -796,7 +854,9 @@ macro_rules! init {
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
@@ -810,10 +870,10 @@ macro_rules! init {
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
@@ -839,7 +899,8 @@ macro_rules! try_init {
 ///
 /// This will succeed:
 /// ```ignore
-/// use pin_init::assert_pinned;
+/// use pin_init::{pin_data, assert_pinned};
+///
 /// #[pin_data]
 /// struct MyStruct {
 ///     #[pin]
@@ -851,7 +912,8 @@ macro_rules! try_init {
 ///
 /// This will fail:
 /// ```compile_fail,ignore
-/// use pin_init::assert_pinned;
+/// use pin_init::{pin_data, assert_pinned};
+///
 /// #[pin_data]
 /// struct MyStruct {
 ///     some_field: u64,
@@ -864,7 +926,9 @@ macro_rules! try_init {
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
@@ -1032,14 +1096,15 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>:=
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
@@ -1278,8 +1343,6 @@ pub trait InPlaceWrite<T> {
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




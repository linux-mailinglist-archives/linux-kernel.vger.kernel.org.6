Return-Path: <linux-kernel+bounces-552451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9615BA579EF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F319189B175
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292FD1EB5DE;
	Sat,  8 Mar 2025 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gyvK+9fe"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8B1C84CC
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431943; cv=none; b=p2k9tLcwqOsfdyqnEllKLhqskdBzaulxCkPWPHMqB5SJKyFCpvsgoS12XJhNkXWXyX9i50gk9aot9HtZ2UmOevgTkuMn2r5AkUjWhy6Gsug77npEBTzgszoD0795vZbeJWc3042QhxPP2RQODMYCU3lX/InhJVTQHLkCs4NGkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431943; c=relaxed/simple;
	bh=tNmtAs23cZgCYHOjrfW2R0JyHw/M48jl1+U0hatzjYE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvAU+fsUgY5aTTVEJmiN9rWXATtxUYRj+/wImoLx6tifVNyb4YQAxzyjb+iIixI5OhBodc8QGYVHVQE0GFeWQ7maljHJUEliTpzmw3Q4dA30lGbiu2TjXxFE3ruyt0rzCYIZSfQdxm7xc7VqlkcmPS/N6V5Kfmj1YmJpTzCtvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gyvK+9fe; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431938; x=1741691138;
	bh=WwGTjrqF8SWd3cWyw7RHe3iSjz50LtYjJ3fxW31+soE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gyvK+9fekH7b93rdoB7MfY6xVzj3ZnrcVf0QwQLnNMIm9byDmfpYzwvq53jySmZmp
	 LdaVVooaFQVcfJiRHzUHLKtjqu0wADmjhU/nEDnFXqlSPKcKodVWPkp3WuLsvIqmvd
	 mnMVCDXI88F6J9tTe7sXvX+1r97rvFlPih5L3lGSrs1QeaBXzIMF+QnSSJzYjxCbMZ
	 kkXwms1pYuOXAt5SJ5n67NL0saYtqqnUrpAcw+3Df5KN4/1Xs11sd7yNzPgIuMFKDS
	 IYcuPlIxidBFj2kqUpPgMAAeCH9yJhPVC+M9TAPzNZfzpWMQHcJb3raxbyBL7y2YAm
	 OFBBcvShEZjSQ==
Date: Sat, 08 Mar 2025 11:05:35 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/22] rust: pin-init: re-enable doctests
Message-ID: <20250308110339.2997091-22-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bf36d8fd8119e9ab3e62544c93508f9d0525451b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The pin-init crate is now compiled in a standalone fashion, so revert
the earlier commit that disabled the doctests in pin-init in order to
avoid build errors while transitioning the crate into a standalone
version.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/pin-init/src/lib.rs | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 45880ffa81bb..f36b8f8e8730 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -63,7 +63,7 @@
 //! [`pin_init!`]. The syntax is almost the same as normal `struct` initia=
lizers. The difference is
 //! that you need to write `<-` instead of `:` for fields that you want to=
 initialize in-place.
 //!
-//! ```rust,ignore
+//! ```rust
 //! # #![expect(clippy::disallowed_names)]
 //! # #![feature(allocator_api)]
 //! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
@@ -87,7 +87,7 @@
 //! `foo` now is of the type [`impl PinInit<Foo>`]. We can now use any sma=
rt pointer that we like
 //! (or just the stack) to actually initialize a `Foo`:
 //!
-//! ```rust,ignore
+//! ```rust
 //! # #![expect(clippy::disallowed_names)]
 //! # #![feature(allocator_api)]
 //! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
@@ -115,7 +115,7 @@
 //! Many types that use this library supply a function/macro that returns =
an initializer, because
 //! the above method only works for types where you can access the fields.
 //!
-//! ```rust,ignore
+//! ```rust
 //! # #![feature(allocator_api)]
 //! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 //! # use pin_init::*;
@@ -126,7 +126,7 @@
 //!
 //! To declare an init macro/function you just return an [`impl PinInit<T,=
 E>`]:
 //!
-//! ```rust,ignore
+//! ```rust
 //! # #![feature(allocator_api)]
 //! # use pin_init::*;
 //! # #[path =3D "../examples/error.rs"] mod error; use error::Error;
@@ -162,7 +162,7 @@
 //! - you may assume that `slot` will stay pinned even after the closure r=
eturns until `drop` of
 //!   `slot` gets called.
 //!
-//! ```rust,ignore
+//! ```rust
 //! # #![feature(extern_types)]
 //! use pin_init::{pin_data, pinned_drop, PinInit, PinnedDrop, pin_init_fr=
om_closure};
 //! use core::{
@@ -306,7 +306,7 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// use pin_init::pin_data;
@@ -323,7 +323,7 @@
 /// }
 /// ```
 ///
-/// ```ignore
+/// ```
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// # mod bindings { pub struct info; pub unsafe fn destroy_info(_: *mut i=
nfo) {} }
@@ -357,7 +357,7 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// # mod bindings { pub struct info; pub unsafe fn destroy_info(_: *mut i=
nfo) {} }
@@ -391,7 +391,7 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```
 /// use pin_init::Zeroable;
 ///
 /// #[derive(Zeroable)]
@@ -407,7 +407,7 @@
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
@@ -459,7 +459,7 @@ macro_rules! stack_pin_init {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
@@ -486,7 +486,7 @@ macro_rules! stack_pin_init {
 /// println!("a: {}", &*foo.a.lock());
 /// ```
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
@@ -539,7 +539,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// The syntax is almost identical to that of a normal `struct` initialize=
r:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::pin::Pin;
 /// #[pin_data]
@@ -583,7 +583,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// To create an initializer function, simply declare it like this:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -609,7 +609,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// Users of `Foo` can now create it like this:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # use pin_init::*;
 /// # use core::pin::Pin;
@@ -637,7 +637,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// They can also easily embed it into their own `struct`s:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -696,7 +696,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// For instance:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
 /// #[pin_data]
@@ -750,7 +750,7 @@ macro_rules! pin_init {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
 /// use pin_init::{pin_data, try_pin_init, PinInit, InPlaceInit, zeroed};
@@ -857,7 +857,7 @@ macro_rules! init {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![feature(allocator_api)]
 /// # use core::alloc::AllocError;
 /// # use pin_init::InPlaceInit;
@@ -904,7 +904,7 @@ macro_rules! try_init {
 /// # Example
 ///
 /// This will succeed:
-/// ```ignore
+/// ```
 /// use pin_init::{pin_data, assert_pinned};
 ///
 /// #[pin_data]
@@ -917,7 +917,7 @@ macro_rules! try_init {
 /// ```
 ///
 /// This will fail:
-/// ```compile_fail,ignore
+/// ```compile_fail
 /// use pin_init::{pin_data, assert_pinned};
 ///
 /// #[pin_data]
@@ -931,7 +931,7 @@ macro_rules! try_init {
 /// Some uses of the macro may trigger the `can't use generic parameters f=
rom outer item` error. To
 /// work around this, you may pass the `inline` parameter to the macro. Th=
e `inline` parameter can
 /// only be used when the macro is invoked from a function body.
-/// ```ignore
+/// ```
 /// # use core::pin::Pin;
 /// use pin_init::{pin_data, assert_pinned};
 ///
@@ -1018,7 +1018,7 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>=
: Sized {
     ///
     /// # Examples
     ///
-    /// ```rust,ignore
+    /// ```rust
     /// # #![feature(allocator_api)]
     /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
     /// # use pin_init::*;
@@ -1116,7 +1116,7 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: P=
inInit<T, E> {
     ///
     /// # Examples
     ///
-    /// ```rust,ignore
+    /// ```rust
     /// # #![expect(clippy::disallowed_names)]
     /// use pin_init::{init, zeroed, Init};
     ///
@@ -1229,7 +1229,7 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E>=
 {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// use pin_init::init_array_from_fn;
 /// let array: Box<[usize; 1_000]> =3D Box::init(init_array_from_fn(|i| i)=
).unwrap();
@@ -1267,7 +1267,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// # use pin_init::*;
@@ -1343,7 +1343,7 @@ pub trait InPlaceWrite<T> {
 ///
 /// Use [`pinned_drop`] to implement this trait safely:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// # use pin_init::*;
--=20
2.47.2




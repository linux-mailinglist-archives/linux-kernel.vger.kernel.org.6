Return-Path: <linux-kernel+bounces-545746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2AA4F0DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AED11896A40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7127F4E4;
	Tue,  4 Mar 2025 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f1HIWtQo"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4627EC87
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128987; cv=none; b=JvykLt4jOFfIe3O9YY/xRLiRaosDhb7/4Qrkn8QnHqiL0Fl2rTEUiATcYPZyUwNTOhz7CsMoZdC/YR3mr9ftZf/hG5FORs6KoDK/gCqVu5CmGdMSNNUGOTwo4vucZbECl8YcGOGi2UXqpHsHSrJXFDHhV70i6DMc5QjW89I324o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128987; c=relaxed/simple;
	bh=M8OgODGdQqTRMk2Q+gdXm0Va/zhTsygk3nj94mR1Uno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mF2oIgWeBzL0GWn/QVfODC2fqepaN0vdhet0Eu7kFNPlTxcZd0aT4wALPJ17/b8SqoOjfJ8FYGG2QqhxbBL2rKqs0tzZs9k3OX++y9Eihw36zPoJ0w9W/XF8YwnWmg8Tu/CYAYMbEQaHRIpecxzJFUEoec9oIxAEoWaG7zVFRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f1HIWtQo; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128982; x=1741388182;
	bh=pWNIUX8Z9RI2xxmBWkX3MMiK3qeHpWXJj9elbTGJyVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=f1HIWtQowuyqKswzZHLfMLv0PjQMeiRDuZIpzHwLq854SQmmjYj3sUcPJ4zRLzqyr
	 lgHoHIDA/T8hC4jmV3s9XBtMzVUxkxPwodzU7Wcfmnr4LJhb5ac4RvR/mFhqFSwhle
	 a1p5UOwNh4UrfeQU1xxYwfMD+lhjk0Xnxi5yjQnBZU2aL7nM6c9YEtc7Fo6NWSGqkv
	 J1N9uLHu/EP6PYXrt9QkywD3o8brWaCcMlyT2YxPZooEoePjUTe9byt0Zop3BiTPuk
	 dC+ELpXBBTPlOZtAkEO3MbQhWNR9HaUNb7TEMNGDi6KB46XEyievgtL2+4S+FDs4Mr
	 ikZ2SLYfhjnMA==
Date: Tue, 04 Mar 2025 22:56:18 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/22] rust: pin-init: re-enable doctests
Message-ID: <20250304225245.2033120-22-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e6282f0da02ca908a4dee266d21986215776194c
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
---
 rust/pin-init/src/lib.rs | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 3d57760a3cee..cb015b118283 100644
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
@@ -298,7 +298,7 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// use pin_init::pin_data;
@@ -315,7 +315,7 @@
 /// }
 /// ```
 ///
-/// ```ignore
+/// ```
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// # mod bindings { pub struct info; pub unsafe fn destroy_info(_: *mut i=
nfo) {} }
@@ -349,7 +349,7 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// # mod bindings { pub struct info; pub unsafe fn destroy_info(_: *mut i=
nfo) {} }
@@ -383,7 +383,7 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```
 /// use pin_init::Zeroable;
 ///
 /// #[derive(Zeroable)]
@@ -399,7 +399,7 @@
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
@@ -451,7 +451,7 @@ macro_rules! stack_pin_init {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
@@ -478,7 +478,7 @@ macro_rules! stack_pin_init {
 /// println!("a: {}", &*foo.a.lock());
 /// ```
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
@@ -531,7 +531,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// The syntax is almost identical to that of a normal `struct` initialize=
r:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::pin::Pin;
 /// #[pin_data]
@@ -575,7 +575,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// To create an initializer function, simply declare it like this:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -601,7 +601,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// Users of `Foo` can now create it like this:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![expect(clippy::disallowed_names)]
 /// # use pin_init::*;
 /// # use core::pin::Pin;
@@ -629,7 +629,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// They can also easily embed it into their own `struct`s:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -688,7 +688,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// For instance:
 ///
-/// ```rust,ignore
+/// ```rust
 /// # use pin_init::*;
 /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
 /// #[pin_data]
@@ -742,7 +742,7 @@ macro_rules! pin_init {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
 /// use pin_init::{pin_data, try_pin_init, PinInit, InPlaceInit, zeroed};
@@ -849,7 +849,7 @@ macro_rules! init {
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![feature(allocator_api)]
 /// # use core::alloc::AllocError;
 /// # use pin_init::InPlaceInit;
@@ -896,7 +896,7 @@ macro_rules! try_init {
 /// # Example
 ///
 /// This will succeed:
-/// ```ignore
+/// ```
 /// use pin_init::{pin_data, assert_pinned};
 ///
 /// #[pin_data]
@@ -909,7 +909,7 @@ macro_rules! try_init {
 /// ```
 ///
 /// This will fail:
-/// ```compile_fail,ignore
+/// ```compile_fail
 /// use pin_init::{pin_data, assert_pinned};
 ///
 /// #[pin_data]
@@ -923,7 +923,7 @@ macro_rules! try_init {
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
@@ -1002,7 +1002,7 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>=
: Sized {
     ///
     /// # Examples
     ///
-    /// ```rust,ignore
+    /// ```rust
     /// # #![feature(allocator_api)]
     /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
     /// # use pin_init::*;
@@ -1092,7 +1092,7 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: P=
inInit<T, E> {
     ///
     /// # Examples
     ///
-    /// ```rust,ignore
+    /// ```rust
     /// # #![expect(clippy::disallowed_names)]
     /// use pin_init::{init, zeroed, Init};
     ///
@@ -1205,7 +1205,7 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E>=
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
@@ -1243,7 +1243,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 ///
 /// # Examples
 ///
-/// ```rust,ignore
+/// ```rust
 /// # #![feature(allocator_api)]
 /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 /// # use pin_init::*;
@@ -1319,7 +1319,7 @@ pub trait InPlaceWrite<T> {
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




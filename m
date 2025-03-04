Return-Path: <linux-kernel+bounces-545725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28776A4F0C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2C47A7289
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F724C069;
	Tue,  4 Mar 2025 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mr3x46CM"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27019251791
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128802; cv=none; b=cMggrzR/0tsRwzkmj5gH1MlmrU9ClctcGtq/YK3wK5y8ektICMnQLUrPrbz3Vl7PubryQIOI00PpHrUKrsjH4Wh46Q6gaYJbZElkl8CirzlPfQuQCKBsSsirGK2vgv+ZSoVA8MpBO2l//ZPYKXLqn/osqW8r9ipQeAA2XfKZlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128802; c=relaxed/simple;
	bh=JiJ2q5YKgHyyOrMvpAEUS9rpy2+f0gLEV/yv4C8+nu0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4ea4m7qlqqg398bn5axvuox1sS47qAAXqe/bkseaf3Ud5MM/2QDI03d3BQGg524vVXRvsHAuKrWEsrBirvGdfe3Ct3tCUobNXrUhY4V343MxZNLLXOt5923RQiBW1J4+ab7mRtSywTSPflVTQrTA2PSEssntsn1uOSNDpjj9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mr3x46CM; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128791; x=1741387991;
	bh=u6gUuLSn4Y9MS6Ky1c7aJrKO9OQwDI66LMPe+RaVXbI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mr3x46CML9JBI4r5vKnFzCdw73txRIVBt/lRs2XLAruWnB66jtYTYqHS2Bu5EovAB
	 csLwp7uznIbbk89u0cOvPL+TFjdCWF6W4aDCVojHWlGM3x4YLZxa8pWzlwZBOPeYDe
	 tzVZHTY0WsTgYfsDY0OWTk2zjfIgEzUNPBmia4Iu/vuHc9qmvO38wscpXEh9CPGmh3
	 6yQcp2vtg70RWkR8Gh+NZe5tuGSvySrcUd72kRTxdo6dl76NOcas2UAiLAwdcS0p1P
	 Vwdw/84wp3OKnfBPsUy0Ab+xVSIVfB+BZ8ACjthj3dJJSMVfG+zP9wdled1+hG4ICu
	 2SUukhbdt6peQ==
Date: Tue, 04 Mar 2025 22:53:03 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/22] rust: init: disable doctests
Message-ID: <20250304225245.2033120-2-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 14c1a55ae96c2fe02fa5d122ef06a327f690a348
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is the first commit in a series that splits off the pin-init crate
from the kernel crate.

The build system cannot handle doctests in the kernel crate in files
outside of `rust/kernel/`. Since subsequent commits will move files out
of that directory, but will still compile them as part of the kernel
crate, ignore all doctests in the to-be-moved files.

The tests will be re-enabled later when the separation into its own
crate has been completed, since then the doctests of that new crate will
be handled as normal host doctests.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs | 40 ++++++++++++++++++++--------------------
 rust/macros/lib.rs  |  8 ++++----
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 7fd1ea8265a5..aa8df0595585 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -34,7 +34,7 @@
 //! [`pin_init!`]. The syntax is almost the same as normal `struct` initia=
lizers. The difference is
 //! that you need to write `<-` instead of `:` for fields that you want to=
 initialize in-place.
 //!
-//! ```rust
+//! ```rust,ignore
 //! # #![expect(clippy::disallowed_names)]
 //! use kernel::sync::{new_mutex, Mutex};
 //! # use core::pin::Pin;
@@ -54,7 +54,7 @@
 //! `foo` now is of the type [`impl PinInit<Foo>`]. We can now use any sma=
rt pointer that we like
 //! (or just the stack) to actually initialize a `Foo`:
 //!
-//! ```rust
+//! ```rust,ignore
 //! # #![expect(clippy::disallowed_names)]
 //! # use kernel::sync::{new_mutex, Mutex};
 //! # use core::pin::Pin;
@@ -78,7 +78,7 @@
 //! Many types from the kernel supply a function/macro that returns an ini=
tializer, because the
 //! above method only works for types where you can access the fields.
 //!
-//! ```rust
+//! ```rust,ignore
 //! # use kernel::sync::{new_mutex, Arc, Mutex};
 //! let mtx: Result<Arc<Mutex<usize>>> =3D
 //!     Arc::pin_init(new_mutex!(42, "example::mtx"), GFP_KERNEL);
@@ -86,7 +86,7 @@
 //!
 //! To declare an init macro/function you just return an [`impl PinInit<T,=
 E>`]:
 //!
-//! ```rust
+//! ```rust,ignore
 //! # use kernel::{sync::Mutex, new_mutex, init::PinInit, try_pin_init};
 //! #[pin_data]
 //! struct DriverData {
@@ -119,7 +119,7 @@
 //! - you may assume that `slot` will stay pinned even after the closure r=
eturns until `drop` of
 //!   `slot` gets called.
 //!
-//! ```rust
+//! ```rust,ignore
 //! # #![expect(unreachable_pub, clippy::disallowed_names)]
 //! use kernel::{init, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
@@ -236,7 +236,7 @@
 ///
 /// # Examples
 ///
-/// ```rust
+/// ```rust,ignore
 /// # #![expect(clippy::disallowed_names)]
 /// # use kernel::{init, macros::pin_data, pin_init, stack_pin_init, init:=
:*, sync::Mutex, new_mutex};
 /// # use core::pin::Pin;
@@ -382,7 +382,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// The syntax is almost identical to that of a normal `struct` initialize=
r:
 ///
-/// ```rust
+/// ```rust,ignore
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// #[pin_data]
@@ -426,7 +426,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// To create an initializer function, simply declare it like this:
 ///
-/// ```rust
+/// ```rust,ignore
 /// # use kernel::{init, pin_init, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -452,7 +452,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// Users of `Foo` can now create it like this:
 ///
-/// ```rust
+/// ```rust,ignore
 /// # #![expect(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
@@ -480,7 +480,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// They can also easily embed it into their own `struct`s:
 ///
-/// ```rust
+/// ```rust,ignore
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -539,7 +539,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// For instance:
 ///
-/// ```rust
+/// ```rust,ignore
 /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
 /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
 /// #[pin_data]
@@ -602,7 +602,7 @@ macro_rules! pin_init {
 ///
 /// # Examples
 ///
-/// ```rust
+/// ```rust,ignore
 /// use kernel::{init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
@@ -705,7 +705,7 @@ macro_rules! init {
 ///
 /// # Examples
 ///
-/// ```rust
+/// ```rust,ignore
 /// use kernel::{alloc::KBox, init::{PinInit, zeroed}, error::Error};
 /// struct BigBuf {
 ///     big: KBox<[u8; 1024 * 1024 * 1024]>,
@@ -761,7 +761,7 @@ macro_rules! try_init {
 /// # Example
 ///
 /// This will succeed:
-/// ```
+/// ```ignore
 /// use kernel::assert_pinned;
 /// #[pin_data]
 /// struct MyStruct {
@@ -787,7 +787,7 @@ macro_rules! try_init {
 /// Some uses of the macro may trigger the `can't use generic parameters f=
rom outer item` error. To
 /// work around this, you may pass the `inline` parameter to the macro. Th=
e `inline` parameter can
 /// only be used when the macro is invoked from a function body.
-/// ```
+/// ```ignore
 /// use kernel::assert_pinned;
 /// #[pin_data]
 /// struct Foo<T> {
@@ -865,7 +865,7 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: =
Sized {
     ///
     /// # Examples
     ///
-    /// ```rust
+    /// ```rust,ignore
     /// # #![expect(clippy::disallowed_names)]
     /// use kernel::{types::Opaque, init::pin_init_from_closure};
     /// #[repr(C)]
@@ -977,7 +977,7 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: Pin=
Init<T, E> {
     ///
     /// # Examples
     ///
-    /// ```rust
+    /// ```rust,ignore
     /// # #![expect(clippy::disallowed_names)]
     /// use kernel::{types::Opaque, init::{self, init_from_closure}};
     /// struct Foo {
@@ -1089,7 +1089,7 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E>=
 {
 ///
 /// # Examples
 ///
-/// ```rust
+/// ```rust,ignore
 /// use kernel::{alloc::KBox, error::Error, init::init_array_from_fn};
 /// let array: KBox<[usize; 1_000]> =3D
 ///     KBox::init::<Error>(init_array_from_fn(|i| i), GFP_KERNEL)?;
@@ -1134,7 +1134,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 ///
 /// # Examples
 ///
-/// ```rust
+/// ```rust,ignore
 /// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mut=
ex};
 /// let array: Arc<[Mutex<usize>; 1_000]> =3D
 ///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i)), GFP_KERNE=
L)?;
@@ -1323,7 +1323,7 @@ fn write_pin_init<E>(mut self, init: impl PinInit<T, =
E>) -> Result<Pin<Self::Ini
 ///
 /// Use [`pinned_drop`] to implement this trait safely:
 ///
-/// ```rust
+/// ```rust,ignore
 /// # use kernel::sync::Mutex;
 /// use kernel::macros::pinned_drop;
 /// use core::pin::Pin;
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index d61bc6a56425..60a0226bad42 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -248,7 +248,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```
+/// ```ignore
 /// # #![feature(lint_reasons)]
 /// # use kernel::prelude::*;
 /// # use std::{sync::Mutex, process::Command};
@@ -261,7 +261,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// }
 /// ```
 ///
-/// ```
+/// ```ignore
 /// # #![feature(lint_reasons)]
 /// # use kernel::prelude::*;
 /// # use std::{sync::Mutex, process::Command};
@@ -302,7 +302,7 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) =
-> TokenStream {
 ///
 /// # Examples
 ///
-/// ```
+/// ```ignore
 /// # #![feature(lint_reasons)]
 /// # use kernel::prelude::*;
 /// # use macros::{pin_data, pinned_drop};
@@ -478,7 +478,7 @@ pub fn paste(input: TokenStream) -> TokenStream {
 ///
 /// # Examples
 ///
-/// ```
+/// ```ignore
 /// use kernel::macros::Zeroable;
 ///
 /// #[derive(Zeroable)]
--=20
2.47.2




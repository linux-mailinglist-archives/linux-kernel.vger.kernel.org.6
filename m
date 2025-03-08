Return-Path: <linux-kernel+bounces-552431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB380A579D9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D503B3C77
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9371B0F1B;
	Sat,  8 Mar 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QwfRIDRq"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE661A239A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431840; cv=none; b=fIHuVzXnAsyxQifHQmINSBXBk++kTmlx55uwYppX0eaQhpJhnrxW0fPZ5WVlvx+R5vont59Ziac+5pZgsvFfok4FY9nuaADiidD7vcC9yJ7qXHwykrUN8hTfyp+plCp6Khc1ybRbG/J/1ugykGLUmdPJ4jQp+XV4+ToYlpPMwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431840; c=relaxed/simple;
	bh=aUNCJpwhjsn8h9QBooCEqCRolZSpf270gAdlSqEICoE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUO4JUCnd/aIkg3g0hGTqoc9HD4sZ1Gqar5n8A0uwm2qLswm50HlSTN6y9NSExs+VdR1LcwhtSR++t/bPT6GyIgLh6BVxR+2nBEFjbfMI2PYtaSSXeRnvu8KnOrZc/eFkhkt9d44+K1wVmdOA4cRTESiic4EfR2cDEGpM6Khdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QwfRIDRq; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431833; x=1741691033;
	bh=eqPfz6eKU6ZIdgA0Z2vFtOPAZqMLvv98PhGEm6nhdog=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QwfRIDRq0xr6+E6TjyNHMuwUqueqJMkHxeZBIgZ/SyPNN+mo5jmN4YAIdqVo0AZUt
	 zyp4hpy3TKjLSa4Xr4ck/41uzYjt9jj2YF5Tyr++O+wfccbkXuQMyXp9rxJuFnMhci
	 4jp2vSzxktKFnDbdGJDoKtoZKEKaVxrZbzJvOtOKrfiPFzIIda0vV4rRdormGkh5r4
	 EtWCLnuOQnGoVk7rV5Bp62OZrefkq4IoJ2Jb0ZNwr6CvNmh35M+6IGARRVdWsmJUyb
	 QLSPnTbqJeR7q76mgC5TmV1ILyAbG6J/o+wgzGEwkVkMTSv739C4+s1w6bwuDMFjDe
	 ERhMI4SV90Jsg==
Date: Sat, 08 Mar 2025 11:03:51 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/22] rust: init: disable doctests
Message-ID: <20250308110339.2997091-2-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b515976f04c95b1c126773ad6a3ada163a9479e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The build system cannot handle doctests in the kernel crate in files
outside of `rust/kernel/`. Subsequent commits will move files out of
that directory, but will still compile them as part of the kernel crate.
Thus ignore all doctests in the to-be-moved files.

Leave tests disabled until they are separated into their own crate and
they stop causing breakage.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
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




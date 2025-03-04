Return-Path: <linux-kernel+bounces-545735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC25A4F0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9FE1743F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B31278114;
	Tue,  4 Mar 2025 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ex2cotwI"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B227817F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128892; cv=none; b=pxEWXon7yl8BCQkH0AxubtxhtNI6i2wHw5x2vnL7X74RVjmtyR/W/x8P4a4Jn2QUT1WuVPxktTX5IXHjV9jvfZ21UcRqTAcQJ0NL9v7/VYQts58Ecmh3Zx8zGvCcMUbnuCGg7az09B7swYF9xMUCxjSBhVUn2li6NhMYF0mnIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128892; c=relaxed/simple;
	bh=TO5BnnDnHUfTCeGbt8YuhMNFWPs42EV19qbukkol4xI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcwU2sIYM+V9aYLM3B1/dyp8kbe2VB3I0qlsUPOP9fhXXs+nRgacIhhT50tFmsHzWszW39nR1zRJR3qXO1TXs3Kcx16iP+AszuUd1vHDMTj7s1TkeNaaGuTszIPuxuJPv9mofeKbm6PVEUIjTjmmxLxIDSXd2Z1EIxVYe7MSDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ex2cotwI; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128888; x=1741388088;
	bh=K4xJxZy3FYip6uQiCdwN1wbyCJp0x/JtHdY0ruacr/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ex2cotwIspq0x0kwPprtKhtjJx5x8v2m0G729mdrBOEkm20muWAr9XyAN530SKDec
	 hZyXasFpIbkYTuQbH7ut6XQFp8dgoGO206Q+C4QPY9VeLDD1z4Mc1bicjriU3qfReD
	 NPJaQkOAKE+8JNpH5lp59fowCBHsFxr7WoX9fkBy9A4l6mpoRjHPMjrvnp/K76yiai
	 EOEDbLeXr/HHZxojVjDmVFx00EgMWW1Rl0E5/fPANoYYtT5o3OGtzWGrRyAANs7Eg9
	 ad8o1xi1CdUkM99wBWWVSC6fHMs2s/sUdiX7frLJCr2XzZVU+eilaEU2dNwWSa/+ZX
	 rlHvQYOhZUiDA==
Date: Tue, 04 Mar 2025 22:54:41 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/22] rust: pin-init: fix documentation links
Message-ID: <20250304225245.2033120-12-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 830e8bc7b75db9c4193842f4f668cfbb029fba68
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Before switching to compile the `pin-init` crate directly, change
any links that would be invalid to links that are valid both before and
after the switch.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/sync/condvar.rs     |  2 +-
 rust/pin-init/src/__internal.rs |  4 ++--
 rust/pin-init/src/lib.rs        | 19 +++++++++++--------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 7df565038d7d..5aa7fa7c7002 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -37,7 +37,7 @@ macro_rules! new_condvar {
 /// spuriously.
 ///
 /// Instances of [`CondVar`] need a lock class and to be pinned. The recom=
mended way to create such
-/// instances is with the [`pin_init`](crate::pin_init) and [`new_condvar`=
] macros.
+/// instances is with the [`pin_init`](crate::pin_init!) and [`new_condvar=
`] macros.
 ///
 /// # Examples
 ///
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 74329cc3262c..0db800819681 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -135,7 +135,7 @@ unsafe fn __init_data() -> Self::InitData {
 ///
 /// If `self.is_init` is true, then `self.value` is initialized.
 ///
-/// [`stack_pin_init`]: kernel::stack_pin_init
+/// [`stack_pin_init`]: crate::stack_pin_init
 pub struct StackInit<T> {
     value: MaybeUninit<T>,
     is_init: bool,
@@ -156,7 +156,7 @@ impl<T> StackInit<T> {
     /// Creates a new [`StackInit<T>`] that is uninitialized. Use [`stack_=
pin_init`] instead of this
     /// primitive.
     ///
-    /// [`stack_pin_init`]: kernel::stack_pin_init
+    /// [`stack_pin_init`]: crate::stack_pin_init
     #[inline]
     pub fn uninit() -> Self {
         Self {
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index fd2c4fdd0ca4..4e1c57a358c2 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -10,7 +10,7 @@
 //! To initialize a `struct` with an in-place constructor you will need tw=
o things:
 //! - an in-place constructor,
 //! - a memory location that can hold your `struct` (this can be the [stac=
k], an [`Arc<T>`],
-//!   [`KBox<T>`] or any other smart pointer that supports this library).
+//!   [`Box<T>`] or any other smart pointer that supports this library).
 //!
 //! To get an in-place constructor there are generally three options:
 //! - directly creating an in-place constructor using the [`pin_init!`] ma=
cro,
@@ -204,7 +204,8 @@
 //! [structurally pinned fields]:
 //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
 //! [stack]: crate::stack_pin_init
-//! [`Arc<T>`]: crate::sync::Arc
+//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
+//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
 //! [`impl PinInit<Foo>`]: PinInit
 //! [`impl PinInit<T, E>`]: PinInit
 //! [`impl Init<T, E>`]: Init
@@ -661,7 +662,7 @@ macro_rules! stack_try_pin_init {
 /// });
 /// ```
 ///
-/// [`try_pin_init!`]: kernel::try_pin_init
+/// [`try_pin_init!`]: crate::try_pin_init
 /// [`NonNull<Self>`]: core::ptr::NonNull
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
@@ -885,7 +886,7 @@ macro_rules! assert_pinned {
 /// A pin-initializer for the type `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`KBox<T>`], [`Arc<T>`] or even the stack (see [`stack_pin_init!`])=
.
+/// be [`Box<T>`], [`Arc<T>`] or even the stack (see [`stack_pin_init!`]).
 ///
 /// Also see the [module description](self).
 ///
@@ -902,7 +903,8 @@ macro_rules! assert_pinned {
 ///     - `slot` is not partially initialized.
 /// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
 ///
-/// [`Arc<T>`]: crate::sync::Arc
+/// [`Arc<T>`]: ../kernel/sync/struct.Arc.html
+/// [`Box<T>`]: ../kernel/sync/struct.KBox.html
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
     /// Initializes `slot`.
@@ -968,7 +970,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(=
), E> {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`KBox<T>`], [`Arc<T>`] or even the stack (see [`stack_pin_init!`])=
. Because
+/// be [`Box<T>`], [`Arc<T>`] or even the stack (see [`stack_pin_init!`]).=
 Because
 /// [`PinInit<T, E>`] is a super trait, you can use every function that ta=
kes it as well.
 ///
 /// Also see the [module description](self).
@@ -992,7 +994,8 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(=
), E> {
 /// Contrary to its supertype [`PinInit<T, E>`] the caller is allowed to
 /// move the pointee after initialization.
 ///
-/// [`Arc<T>`]: crate::sync::Arc
+/// [`Arc<T>`]: ../kernel/sync/struct.Arc.html
+/// [`Box<T>`]: ../kernel/sync/struct.KBox.html
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait Init<T: ?Sized, E =3D Infallible>: PinInit<T, E> {
     /// Initializes `slot`.
@@ -1272,7 +1275,7 @@ pub trait InPlaceWrite<T> {
 ///
 /// This trait must be implemented via the [`pinned_drop`] proc-macro attr=
ibute on the impl.
 ///
-/// [`pinned_drop`]: kernel::macros::pinned_drop
+/// [`pinned_drop`]: crate::macros::pinned_drop
 pub unsafe trait PinnedDrop: __internal::HasPinData {
     /// Executes the pinned destructor of this type.
     ///
--=20
2.47.2




Return-Path: <linux-kernel+bounces-552441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EEA579E4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79BE3B5DB5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73221DCB09;
	Sat,  8 Mar 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M4tO/4OX"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8711B4244;
	Sat,  8 Mar 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431896; cv=none; b=EkbbRj2HvBc4SWMeF6ejyBb0+MfQHoLhW87BBVCuEKWi4I1Bd8DWTo+UQBfjLlv83xB+FkpoN4EXwE+JAOGX3hII29BobBGPdSBGi6Gu0mIqOVvUjv2fSl4RudbGghepMT3VmvylK7R0avJJZ+O/H34NgwLwntF+u909ArT3hW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431896; c=relaxed/simple;
	bh=JI5QBU+Jrm3L271lb+q7k97VRnVITm1YwgGwUGpHPj0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgyDTzhj/nTkrqxjuU6FZjHblpL9HCcXaaMijZl7vhJZj5DANzMx15ri90oTuYh9TLXM8m4UDTe4SW7/vGBpC4Vc/tbniuVjb9sCRxyLTYWgwf9x3uQX5Q+y7uSuJWrZJR6xcTgxIQ8gxtXzXjpBhxApiU9+jn4Zq8H7lrh+K7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M4tO/4OX; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431892; x=1741691092;
	bh=izS4C7tGXA7R7El8Flwozi/57QpQOoH2j1c1kd1UCSw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=M4tO/4OXNfDs4WOO8dKkwG+p+BwiPmCYWwZHUQiTHUXn8Xckn2mkse0nXM1dbE6Rc
	 Z4vzSQOGeGjgK/ldATxrzp6mSjh8Q4IVPUgELA8f8sQru63iYuHXaK6BnyxhzYKKtt
	 YSpP2TClJy1xedH3h6rB0/aMATa/8cgFNpRDtgH8t7iLqp9unSuU7uejaZ/pJzRpDn
	 EadFRZi/FtCbWWo37Ob3r9Ii5ROM0ajRCDIrUO6agLlJ6OspQN9Jk7zIjZ/BQcZMrZ
	 gJJOZVa9Z3vMACily4r5rAafFbqKrgiUY+gXWNruryvGIUGT5FiJXJXQ89bbOFg4Mj
	 3dmN7yuQ7EhwA==
Date: Sat, 08 Mar 2025 11:04:48 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/22] rust: pin-init: fix documentation links
Message-ID: <20250308110339.2997091-12-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f6a52026010a82c5c779869f9185356c8179161a
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
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
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
index ca6be982b522..47954bc1dc2f 100644
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
+//! [`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.Arc.html
+//! [`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/struct.Box.=
html
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
+/// [`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.Arc.html
+/// [`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/struct.Box.=
html
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
+/// [`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.Arc.html
+/// [`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/struct.Box.=
html
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




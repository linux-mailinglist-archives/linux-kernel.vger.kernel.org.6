Return-Path: <linux-kernel+bounces-545740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA6A4F0D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABBD1894FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B327933A;
	Tue,  4 Mar 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ay+5jpvW"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860D27814D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128944; cv=none; b=lzePvRHR0Qpp4w75EoSXNzn6Lj9jEHOluREcO2O51BjYvD5kBcp1wqkt4vRVcWmZhLQZyt8p4NifOCQyW6M22gdh6pye9LIOzrdEsjlMlIJEOl1m1t62cpfPhNZE4D76Bsl5IGcVtDSJiWd3sarrjLkGeof2yIAPiNj0sULoK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128944; c=relaxed/simple;
	bh=uqEyEPDotXvtJzeKLj/eAzWpoRWvMtgSlKKYeeLAmfA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXtuJkT8TR6WfcT8pg6GGL+/E2/jOeU+eOsz31MLAJ1zglJHJByzO9y3m9MKW/jhEi0SB5l2iRdGIA0e8HSR1z7EbFBFJgsnvpUgHqxzJMbTnLwGr0X9pwkNE08C0RZum1+LbVNoTxSjX83zDR2UMnLE7wOvGIOHZvNBpUGCMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ay+5jpvW; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128937; x=1741388137;
	bh=rs2RvKRRsFxZQ+lB46GxRZMmqcNdd5I1fjeY7ecljiE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ay+5jpvWFqctwpD4GKVOZWUt5etDs9EBSfSMPsgPLPhfI9pYDJLLEbAIs3AJyUJoz
	 kPlv5JGcxq5K+lfIhrJXnXz4ynk7izPvlhTDarP2PXwkKC0iHotlfu3DwBRTth32F7
	 db9UrGvnWFltTaqakDZ/N3nQNXJfa1fD1o1rbKC9LtatcL27LQHNxkP5ojuUNROJf5
	 Kt8+NyGBZNjHydwWt/R5AhaS7nJmxGVzBO2oMiehu7aNd7sRSpZFRvYIOFA7qsREMq
	 NZQcEr/3eQiNrlgtouXEdZdKEk+4L9yzeEeacZYeyFkINnnO2xxE1WROBGoBCq9cyJ
	 s8e00as0u4fZw==
Date: Tue, 04 Mar 2025 22:55:32 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 16/22] rust: pin-init: add `std` and `alloc` support from the user-space version
Message-ID: <20250304225245.2033120-17-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 820cd589efe73fb85b8f74ed946b918314860e8d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

To synchronize the kernel's version of pin-init with the user-space
version, introduce support for `std` and `alloc`. While the kernel uses
neither, the user-space version has to support both. Thus include the
required `#[cfg]`s and additional code.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/src/__internal.rs |  27 ++++++
 rust/pin-init/src/alloc.rs      | 158 ++++++++++++++++++++++++++++++++
 rust/pin-init/src/lib.rs        |  17 ++--
 3 files changed, 196 insertions(+), 6 deletions(-)
 create mode 100644 rust/pin-init/src/alloc.rs

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 74086365a18a..27d4a8619c04 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -186,6 +186,33 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinIni=
t<T, E>) -> Result<Pin<&mu
     }
 }
=20
+#[test]
+fn stack_init_reuse() {
+    use ::std::{borrow::ToOwned, println, string::String};
+    use core::pin::pin;
+
+    #[derive(Debug)]
+    struct Foo {
+        a: usize,
+        b: String,
+    }
+    let mut slot: Pin<&mut StackInit<Foo>> =3D pin!(StackInit::uninit());
+    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
+        slot.as_mut().init(crate::init!(Foo {
+            a: 42,
+            b: "Hello".to_owned(),
+        }));
+    let value =3D value.unwrap();
+    println!("{value:?}");
+    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
+        slot.as_mut().init(crate::init!(Foo {
+            a: 24,
+            b: "world!".to_owned(),
+        }));
+    let value =3D value.unwrap();
+    println!("{value:?}");
+}
+
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotten to prevent the drop.
diff --git a/rust/pin-init/src/alloc.rs b/rust/pin-init/src/alloc.rs
new file mode 100644
index 000000000000..e16baa3b434e
--- /dev/null
+++ b/rust/pin-init/src/alloc.rs
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+#[cfg(all(feature =3D "alloc", not(feature =3D "std")))]
+use alloc::{boxed::Box, sync::Arc};
+#[cfg(feature =3D "alloc")]
+use core::alloc::AllocError;
+use core::{mem::MaybeUninit, pin::Pin};
+#[cfg(feature =3D "std")]
+use std::sync::Arc;
+
+#[cfg(not(feature =3D "alloc"))]
+type AllocError =3D core::convert::Infallible;
+
+use crate::{
+    init_from_closure, pin_init_from_closure, InPlaceWrite, Init, PinInit,=
 ZeroableOption,
+};
+
+pub extern crate alloc;
+
+// SAFETY: All zeros is equivalent to `None` (option layout optimization g=
uarantee).
+//
+// In this case we are allowed to use `T: ?Sized`, since all zeros is the =
`None` variant and there
+// is no problem with a VTABLE pointer being null.
+unsafe impl<T: ?Sized> ZeroableOption for Box<T> {}
+
+/// Smart pointer that can initialize memory in-place.
+pub trait InPlaceInit<T>: Sized {
+    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
+    /// type.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>;
+
+    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
+    /// type.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn pin_init(init: impl PinInit<T>) -> Result<Pin<Self>, AllocError> {
+        // SAFETY: We delegate to `init` and only change the error type.
+        let init =3D unsafe {
+            pin_init_from_closure(|slot| match init.__pinned_init(slot) {
+                Ok(()) =3D> Ok(()),
+                Err(i) =3D> match i {},
+            })
+        };
+        Self::try_pin_init(init)
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    where
+        E: From<AllocError>;
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn init(init: impl Init<T>) -> Result<Self, AllocError> {
+        // SAFETY: We delegate to `init` and only change the error type.
+        let init =3D unsafe {
+            init_from_closure(|slot| match init.__init(slot) {
+                Ok(()) =3D> Ok(()),
+                Err(i) =3D> match i {},
+            })
+        };
+        Self::try_init(init)
+    }
+}
+
+#[cfg(feature =3D "alloc")]
+macro_rules! try_new_uninit {
+    ($type:ident) =3D> {
+        $type::try_new_uninit()?
+    };
+}
+#[cfg(all(feature =3D "std", not(feature =3D "alloc")))]
+macro_rules! try_new_uninit {
+    ($type:ident) =3D> {
+        $type::new_uninit()
+    };
+}
+
+impl<T> InPlaceInit<T> for Box<T> {
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        try_new_uninit!(Box).write_pin_init(init)
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        try_new_uninit!(Box).write_init(init)
+    }
+}
+
+impl<T> InPlaceInit<T> for Arc<T> {
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this =3D try_new_uninit!(Arc);
+        let Some(slot) =3D Arc::get_mut(&mut this) else {
+            // SAFETY: the Arc has just been created and has no external r=
eferences
+            unsafe { core::hint::unreachable_unchecked() }
+        };
+        let slot =3D slot.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized and this is the only `=
Arc` to that data.
+        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this =3D try_new_uninit!(Arc);
+        let Some(slot) =3D Arc::get_mut(&mut this) else {
+            // SAFETY: the Arc has just been created and has no external r=
eferences
+            unsafe { core::hint::unreachable_unchecked() }
+        };
+        let slot =3D slot.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() })
+    }
+}
+
+impl<T> InPlaceWrite<T> for Box<MaybeUninit<T>> {
+    type Initialized =3D Box<T>;
+
+    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Init=
ialized, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() })
+    }
+
+    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin=
<Self::Initialized>, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() }.into())
+    }
+}
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 55d8953620f0..1fdca35906a0 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -204,8 +204,8 @@
 //! [structurally pinned fields]:
 //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
 //! [stack]: crate::stack_pin_init
-//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
-//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
+//! [`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.Arc.htm=
l
+//! [`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.Box.ht=
ml
 //! [`impl PinInit<Foo>`]: PinInit
 //! [`impl PinInit<T, E>`]: PinInit
 //! [`impl Init<T, E>`]: Init
@@ -239,6 +239,11 @@
 #[doc(hidden)]
 pub mod macros;
=20
+#[cfg(any(feature =3D "std", feature =3D "alloc"))]
+mod alloc;
+#[cfg(any(feature =3D "std", feature =3D "alloc"))]
+pub use alloc::InPlaceInit;
+
 /// Used to specify the pinning information of the fields of a struct.
 ///
 /// This is somewhat similar in purpose as
@@ -914,8 +919,8 @@ macro_rules! assert_pinned {
 ///     - `slot` is not partially initialized.
 /// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
 ///
-/// [`Arc<T>`]: ../kernel/sync/struct.Arc.html
-/// [`Box<T>`]: ../kernel/sync/struct.KBox.html
+/// [`Arc<T>`]: alloc::alloc::sync::Arc
+/// [`Box<T>`]: alloc::alloc::boxed::Box
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
     /// Initializes `slot`.
@@ -1005,8 +1010,8 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result=
<(), E> {
 /// Contrary to its supertype [`PinInit<T, E>`] the caller is allowed to
 /// move the pointee after initialization.
 ///
-/// [`Arc<T>`]: ../kernel/sync/struct.Arc.html
-/// [`Box<T>`]: ../kernel/sync/struct.KBox.html
+/// [`Arc<T>`]: alloc::alloc::sync::Arc
+/// [`Box<T>`]: alloc::alloc::boxed::Box
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait Init<T: ?Sized, E =3D Infallible>: PinInit<T, E> {
     /// Initializes `slot`.
--=20
2.47.2




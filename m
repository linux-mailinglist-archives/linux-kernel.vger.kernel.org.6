Return-Path: <linux-kernel+bounces-545732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5DA4F0C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3407217320D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C648278142;
	Tue,  4 Mar 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b86ilMnV"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EA27780E;
	Tue,  4 Mar 2025 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128867; cv=none; b=B48gel3T9AOBAtD5BqUM18rXRKqDeG36uiRtjzCHCFSHRWxY5qM+kRGJGfwsBxBHcyzo4mJ5SH4UkyXB/mhSperGDRhz/onyon92qtHRb2BQK40jPrsHMopksvpCU6TDatfLd9XktBK08aCRQQi7xB+0x8Hja86G7ziVhm6GlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128867; c=relaxed/simple;
	bh=9GhlzRR41lfRqDFPBH5CVc4Ofy7nMggSWDiG6KzKlEQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/VagM4/aO733MmYgthNcEpFahX7Uo+a9ew5g1h4Uav2YmhNE86gkGcWKnj0hbwH7XENVP8gClKYIsrZ5gBg+spT8rUUvkttlIDF2n01cjsym9ILXDzRkb8B3i94Z9dKpu/7xA7TKE4U3G4kx9jFbgsmQVgP4geFGCc5ddgVAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b86ilMnV; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128862; x=1741388062;
	bh=TsdZ8Ph5JpGgKaxzyHPu9Sekfgy8arXyCxS+9VGdX0k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=b86ilMnVR9hieyv0NGgdT1mesYh6T1r+yesUIVwKF97wfduJlMfV9Q+OhJvElnTgo
	 lHkffAWyv4hZLXL6Xh1ZhO2rcXDbgtpsoS2I/5lSIYKuCU/Pdpuw/4+jRnD7scrL8V
	 PSXFjGeWGRa7Vf28n+yK4mRbehWMQrLqZjUeWLqzOjPtW8B8I09j7xz5VppetNs2db
	 PW2IK6R4lC9t/Hh9kVIKphEFU7VNwO9i5iVzEQ9nniVpBk4JNOCHQrY6RNcvu3CliM
	 CIGkasH9y/1f5vmSiN+jL+rR26/X8ELPfH6aq7Kp3pqAAKutssooDVjAxUC1FuZWPX
	 1mub5JvPmXsTA==
Date: Tue, 04 Mar 2025 22:54:16 +0000
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/22] rust: pin-init: move `InPlaceInit` and impls of `InPlaceWrite` into the kernel crate
Message-ID: <20250304225245.2033120-9-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 500433488c61479f8ed2210ac155a37742190803
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In order to make pin-init a standalone crate, move kernel-specific code
directly into the kernel crate. This includes the `InPlaceInit<T>`
trait, its implementations and the implementations of `InPlaceWrite` for
`Arc` and `UniqueArc`. All of these use the kernel's error type which
will become unavailable in pin-init.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/alloc/kbox.rs |   3 +-
 rust/kernel/init.rs       |  55 +++++++++++++++++
 rust/kernel/prelude.rs    |   3 +-
 rust/kernel/sync/arc.rs   |  65 +++++++++++++++++++-
 rust/pin-init/src/lib.rs  | 125 ++------------------------------------
 5 files changed, 127 insertions(+), 124 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index cb4ebea3b074..39a3ea7542da 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -15,7 +15,8 @@
 use core::ptr::NonNull;
 use core::result::Result;
=20
-use crate::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
+use crate::init::{InPlaceWrite, Init, PinInit};
+use crate::init_ext::InPlaceInit;
 use crate::types::ForeignOwnable;
=20
 /// The kernel's [`Box`] type -- a heap allocation for a single value of t=
ype `T`.
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index d80eccf29100..d8eb6d7873b7 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -134,6 +134,61 @@
 //! }
 //! ```
=20
+use crate::{
+    alloc::{AllocError, Flags},
+    error::{self, Error},
+    init::{init_from_closure, pin_init_from_closure, Init, PinInit},
+};
+
+/// Smart pointer that can initialize memory in-place.
+pub trait InPlaceInit<T>: Sized {
+    /// Pinned version of `Self`.
+    ///
+    /// If a type already implicitly pins its pointee, `Pin<Self>` is unne=
cessary. In this case use
+    /// `Self`, otherwise just use `Pin<Self>`.
+    type PinnedSelf;
+
+    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
+    /// type.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<S=
elf::PinnedSelf, E>
+    where
+        E: From<AllocError>;
+
+    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
+    /// type.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Resul=
t<Self::PinnedSelf>
+    where
+        Error: From<E>,
+    {
+        // SAFETY: We delegate to `init` and only change the error type.
+        let init =3D unsafe {
+            pin_init_from_closure(|slot| init.__pinned_init(slot).map_err(=
|e| Error::from(e)))
+        };
+        Self::try_pin_init(init, flags)
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>;
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        // SAFETY: We delegate to `init` and only change the error type.
+        let init =3D unsafe {
+            init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| =
Error::from(e)))
+        };
+        Self::try_init(init, flags)
+    }
+}
+
 /// Construct an in-place fallible initializer for `struct`s.
 ///
 /// This macro defaults the error to [`Error`]. If you need [`Infallible`]=
, then use
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 4123d478c351..6b9e068b3710 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -37,6 +37,7 @@
=20
 pub use super::{str::CStr, ThisModule};
=20
-pub use super::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
+pub use super::init::{InPlaceWrite, Init, PinInit};
+pub use super::init_ext::InPlaceInit;
=20
 pub use super::current;
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3cefda7a4372..31c26b692c6d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -19,7 +19,8 @@
 use crate::{
     alloc::{AllocError, Flags, KBox},
     bindings,
-    init::{self, InPlaceInit, Init, PinInit},
+    init::{self, InPlaceWrite, Init, PinInit},
+    init_ext::InPlaceInit,
     try_init,
     types::{ForeignOwnable, Opaque},
 };
@@ -202,6 +203,26 @@ unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {=
}
 // the reference count reaches zero and `T` is dropped.
 unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
=20
+impl<T> InPlaceInit<T> for Arc<T> {
+    type PinnedSelf =3D Self;
+
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<S=
elf::PinnedSelf, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::try_pin_init(init, flags).map(|u| u.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::try_init(init, flags).map(|u| u.into())
+    }
+}
+
 impl<T> Arc<T> {
     /// Constructs a new reference counted instance of `T`.
     pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
@@ -659,6 +680,48 @@ pub struct UniqueArc<T: ?Sized> {
     inner: Arc<T>,
 }
=20
+impl<T> InPlaceInit<T> for UniqueArc<T> {
+    type PinnedSelf =3D Pin<Self>;
+
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<S=
elf::PinnedSelf, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::new_uninit(flags)?.write_pin_init(init)
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        UniqueArc::new_uninit(flags)?.write_init(init)
+    }
+}
+
+impl<T> InPlaceWrite<T> for UniqueArc<MaybeUninit<T>> {
+    type Initialized =3D UniqueArc<T>;
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
+
 impl<T> UniqueArc<T> {
     /// Tries to allocate a new [`UniqueArc`] instance.
     pub fn new(value: T, flags: Flags) -> Result<Self, AllocError> {
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 1308b7af7ec9..49e31228c14a 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -10,7 +10,7 @@
 //! To initialize a `struct` with an in-place constructor you will need tw=
o things:
 //! - an in-place constructor,
 //! - a memory location that can hold your `struct` (this can be the [stac=
k], an [`Arc<T>`],
-//!   [`UniqueArc<T>`], [`KBox<T>`] or any other smart pointer that implem=
ents [`InPlaceInit`]).
+//!   [`KBox<T>`] or any other smart pointer that supports this library).
 //!
 //! To get an in-place constructor there are generally three options:
 //! - directly creating an in-place constructor using the [`pin_init!`] ma=
cro,
@@ -212,10 +212,7 @@
 //! [`pin_init!`]: crate::pin_init!
=20
 use crate::{
-    alloc::{AllocError, Flags, KBox},
-    error::{self, Error},
-    sync::Arc,
-    sync::UniqueArc,
+    alloc::KBox,
     types::{Opaque, ScopeGuard},
 };
 use core::{
@@ -891,8 +888,7 @@ macro_rules! assert_pinned {
 /// A pin-initializer for the type `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`KBox<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`=
stack_pin_init!`]). Use
-/// the [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T=
>`] on this.
+/// be [`KBox<T>`], [`Arc<T>`] or even the stack (see [`stack_pin_init!`])=
.
 ///
 /// Also see the [module description](self).
 ///
@@ -910,7 +906,6 @@ macro_rules! assert_pinned {
 /// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
 ///
 /// [`Arc<T>`]: crate::sync::Arc
-/// [`Arc::pin_init`]: crate::sync::Arc::pin_init
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
     /// Initializes `slot`.
@@ -976,8 +971,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(=
), E> {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`KBox<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`=
stack_pin_init!`]). Use
-/// the [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] =
on this. Because
+/// be [`KBox<T>`], [`Arc<T>`] or even the stack (see [`stack_pin_init!`])=
. Because
 /// [`PinInit<T, E>`] is a super trait, you can use every function that ta=
kes it as well.
 ///
 /// Also see the [module description](self).
@@ -1238,95 +1232,6 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Resul=
t<(), E> {
     }
 }
=20
-/// Smart pointer that can initialize memory in-place.
-pub trait InPlaceInit<T>: Sized {
-    /// Pinned version of `Self`.
-    ///
-    /// If a type already implicitly pins its pointee, `Pin<Self>` is unne=
cessary. In this case use
-    /// `Self`, otherwise just use `Pin<Self>`.
-    type PinnedSelf;
-
-    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
-    /// type.
-    ///
-    /// If `T: !Unpin` it will not be able to move afterwards.
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<S=
elf::PinnedSelf, E>
-    where
-        E: From<AllocError>;
-
-    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
-    /// type.
-    ///
-    /// If `T: !Unpin` it will not be able to move afterwards.
-    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Resul=
t<Self::PinnedSelf>
-    where
-        Error: From<E>,
-    {
-        // SAFETY: We delegate to `init` and only change the error type.
-        let init =3D unsafe {
-            pin_init_from_closure(|slot| init.__pinned_init(slot).map_err(=
|e| Error::from(e)))
-        };
-        Self::try_pin_init(init, flags)
-    }
-
-    /// Use the given initializer to in-place initialize a `T`.
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>;
-
-    /// Use the given initializer to in-place initialize a `T`.
-    fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
-    where
-        Error: From<E>,
-    {
-        // SAFETY: We delegate to `init` and only change the error type.
-        let init =3D unsafe {
-            init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| =
Error::from(e)))
-        };
-        Self::try_init(init, flags)
-    }
-}
-
-impl<T> InPlaceInit<T> for Arc<T> {
-    type PinnedSelf =3D Self;
-
-    #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<S=
elf::PinnedSelf, E>
-    where
-        E: From<AllocError>,
-    {
-        UniqueArc::try_pin_init(init, flags).map(|u| u.into())
-    }
-
-    #[inline]
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>,
-    {
-        UniqueArc::try_init(init, flags).map(|u| u.into())
-    }
-}
-
-impl<T> InPlaceInit<T> for UniqueArc<T> {
-    type PinnedSelf =3D Pin<Self>;
-
-    #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<S=
elf::PinnedSelf, E>
-    where
-        E: From<AllocError>,
-    {
-        UniqueArc::new_uninit(flags)?.write_pin_init(init)
-    }
-
-    #[inline]
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>,
-    {
-        UniqueArc::new_uninit(flags)?.write_init(init)
-    }
-}
-
 /// Smart pointer containing uninitialized memory and that can write a val=
ue.
 pub trait InPlaceWrite<T> {
     /// The type `Self` turns into when the contents are initialized.
@@ -1343,28 +1248,6 @@ pub trait InPlaceWrite<T> {
     fn write_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Sel=
f::Initialized>, E>;
 }
=20
-impl<T> InPlaceWrite<T> for UniqueArc<MaybeUninit<T>> {
-    type Initialized =3D UniqueArc<T>;
-
-    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Init=
ialized, E> {
-        let slot =3D self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() })
-    }
-
-    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin=
<Self::Initialized>, E> {
-        let slot =3D self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() }.into())
-    }
-}
-
 /// Trait facilitating pinned destruction.
 ///
 /// Use [`pinned_drop`] to implement this trait safely:
--=20
2.47.2




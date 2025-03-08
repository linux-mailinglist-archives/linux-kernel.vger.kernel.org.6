Return-Path: <linux-kernel+bounces-552445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86637A579E8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A1F189AF36
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B701C701B;
	Sat,  8 Mar 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MgCiIW9s"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DB1C5F3F;
	Sat,  8 Mar 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431921; cv=none; b=WrWkgL/4ciLkl42Mg/0bKJdS3ng6+Yu34Gh9x1fKQH8RGyZfDfYpFer1tYAvpqBRVezoJC1594qXalBiIiLJxEi4JpBTVhw3AG4+d5jq7qFkjemrLg1mI0cCcBioqegI1d8bAxibB01uYh3jCGxOPWh0nAKgb20Uhn+Z4gD6Kqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431921; c=relaxed/simple;
	bh=t//auXkNA7CWWXjMgHqncFQybRPoRvKrGpTPJjwbwz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gylzgWrR4GIguTLgm8KI5OjH70fnQRvoK0Wqp+Z6YTqAGaqWCffFwatHl6sivgQBD7eHNiwUXmwVIs3wWTNXIoq7TDwZE8vXp3b3Cxr15oWD4fREvVB0cxLUPlAyBsBlI5nssTIqYuJXteE6ioLZ/QODvwanZxJPLa+JJDQUj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MgCiIW9s; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431917; x=1741691117;
	bh=YKDu9abTdC1pFV8eXsGsLjLlywgJYKWwJqxyuw/Qhd0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=MgCiIW9srkV2oaxE/Wy7fFrtMlaQhfYROHdZmMqZP1jM4xO+aBy1RP9Bh3mU1k1wi
	 sU9nS2Q4hGf//s84YsgjS8evBjoJlL/FS0oFYB0SfnMyA53uj7m5/zP6UY8v8bJ8NM
	 Ncw1JnFJpUjOFC7C6XUvlYXW7X/McohnkETky6I153e2rhg/m424uThPPRJw4Wc8Is
	 8XQZROZ2qUk/j3F3BFEei5ffpzi2b4XYlwSZtLYngobZnId7eEuhUVToHEgA/NWh8t
	 8Un2qqS09xkBetdISuiniAwhV1wSEJmqPU8H12qDk/Ez0C2P2Ls2LIDekZx+UR1Wbv
	 ll5ooQyevcbOA==
Date: Sat, 08 Mar 2025 11:05:12 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 16/22] rust: pin-init: add `std` and `alloc` support from the user-space version
Message-ID: <20250308110339.2997091-17-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6e1fdb06ba2b56d70cad1bf5c0bcc602e1af8f50
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
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/pin-init/src/__internal.rs |  27 ++++++
 rust/pin-init/src/alloc.rs      | 158 ++++++++++++++++++++++++++++++++
 rust/pin-init/src/lib.rs        |  41 +++++++--
 3 files changed, 220 insertions(+), 6 deletions(-)
 create mode 100644 rust/pin-init/src/alloc.rs

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 8a53f55e1bbf..cac293fd4bec 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -189,6 +189,33 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinIni=
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
index 41bfb35c7a2c..58b77a158c34 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -204,8 +204,16 @@
 //! [structurally pinned fields]:
 //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
 //! [stack]: crate::stack_pin_init
-//! [`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.Arc.html
-//! [`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/struct.Box.=
html
+#![cfg_attr(
+    kernel,
+    doc =3D "[`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.A=
rc.html"
+)]
+#![cfg_attr(
+    kernel,
+    doc =3D "[`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/st=
ruct.Box.html"
+)]
+#![cfg_attr(not(kernel), doc =3D "[`Arc<T>`]: alloc::alloc::sync::Arc")]
+#![cfg_attr(not(kernel), doc =3D "[`Box<T>`]: alloc::alloc::boxed::Box")]
 //! [`impl PinInit<Foo>`]: PinInit
 //! [`impl PinInit<T, E>`]: PinInit
 //! [`impl Init<T, E>`]: Init
@@ -239,6 +247,11 @@
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
@@ -914,8 +927,16 @@ macro_rules! assert_pinned {
 ///     - `slot` is not partially initialized.
 /// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
 ///
-/// [`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.Arc.html
-/// [`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/struct.Box.=
html
+#[cfg_attr(
+    kernel,
+    doc =3D "[`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.A=
rc.html"
+)]
+#[cfg_attr(
+    kernel,
+    doc =3D "[`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/st=
ruct.Box.html"
+)]
+#[cfg_attr(not(kernel), doc =3D "[`Arc<T>`]: alloc::alloc::sync::Arc")]
+#[cfg_attr(not(kernel), doc =3D "[`Box<T>`]: alloc::alloc::boxed::Box")]
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
     /// Initializes `slot`.
@@ -1005,8 +1026,16 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Resul=
t<(), E> {
 /// Contrary to its supertype [`PinInit<T, E>`] the caller is allowed to
 /// move the pointee after initialization.
 ///
-/// [`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.Arc.html
-/// [`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/struct.Box.=
html
+#[cfg_attr(
+    kernel,
+    doc =3D "[`Arc<T>`]: https://rust.docs.kernel.org/kernel/sync/struct.A=
rc.html"
+)]
+#[cfg_attr(
+    kernel,
+    doc =3D "[`Box<T>`]: https://rust.docs.kernel.org/kernel/alloc/kbox/st=
ruct.Box.html"
+)]
+#[cfg_attr(not(kernel), doc =3D "[`Arc<T>`]: alloc::alloc::sync::Arc")]
+#[cfg_attr(not(kernel), doc =3D "[`Box<T>`]: alloc::alloc::boxed::Box")]
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait Init<T: ?Sized, E =3D Infallible>: PinInit<T, E> {
     /// Initializes `slot`.
--=20
2.47.2




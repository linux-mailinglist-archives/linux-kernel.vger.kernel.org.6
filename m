Return-Path: <linux-kernel+bounces-339618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7549867DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08701F257DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDE414E2ED;
	Wed, 25 Sep 2024 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hn8oUkjN"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7414EC5D;
	Wed, 25 Sep 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297600; cv=none; b=WPd5fRx4vKTBTXk9D9tlUwbaYOYZHlxhqh4RfSJU+KXNSWBbvvlzdO6rFfEhrUfohJntrAQofDOJyUArfJFB/zpH+mw1k33/lkfrSOvWdEVeVMLULkIibFSY6uo+ye4Nh76rYvc50zprw9HyZ1xLBiRgRQf4A+QEnqFVs52ibOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297600; c=relaxed/simple;
	bh=nHKVM6jVyy6XtdH6RPwIDEYx+HH5nQo6nYpf3OuSyK8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkcs2NGdFCHPFHqvRk89HUu3nTXz7quGkgX9W9M16FhOFBu4R08+n4hjx8nLogB0EJdni33hrxhiIwhh/WCFEAfqqyWPCd4d4/tjqyR1YHJA1nNuyvzuGCoRMNjGHHJHtbLVNF+HJ1wpKInyWVWkWlWSXcySli119faDn5wBlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hn8oUkjN; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727297590; x=1727556790;
	bh=qiyKQWQNCUk2/ZfZxnftGeTOeoA1CywONUeEx4QsYLk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hn8oUkjNo93Eddg21mTQCTGQ9EattnlDUVbm6mq6EZa4zpzjymwMjJRjuV7B9E0KI
	 H/X0imRE8EzteTef04LxtzzA+Qavtz78KO3Nb3QtLQ4gxtlcYORkXoKyUznnGjzrTm
	 1wfPTNjXyE1cv92SpDpyFqoz6QJRllupWj20A5Jzn2cvc3EOVUIlyoOaGw1MH9dIaE
	 s9/JvZCia312M1M+cCoQRRnGX3LhIlt9N6RUkSq9cnOhvhnw5zhmqhtz/+7OImERVU
	 DdaNO/AHy2micNmfZU4tIrWejHnd/U9l22dsA70mE38gQppV31/KnW1Cp9LK36LCYK
	 UXYsB0WGcG1cQ==
Date: Wed, 25 Sep 2024 20:53:05 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 1/2] rust: add untrusted data abstraction
Message-ID: <20240925205244.873020-2-benno.lossin@proton.me>
In-Reply-To: <20240925205244.873020-1-benno.lossin@proton.me>
References: <20240925205244.873020-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3f67bea4faef9b3cbced77f3a1778216b81cf81c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When reading data from userspace, hardware or other external untrusted
sources, the data must be validated before it is used for logic within
the kernel. This abstraction provides a generic newtype wrapper
`Untrusted`; it prevents direct access to the inner type. The only way
to use the underlying data is to call `.validate()` on such a value.

Doing so utilizes the new `Validate` trait that is responsible for all
of the validation logic. This trait gives access to the inner value of
`Untrusted` by means of another newtype wrapper `Unvalidated`. In
contrast to `Untrusted`, `Unvalidated` allows direct access and
additionally provides several helper functions for slices.

Having these two different newtype wrappers is an idea from Simona
Vetter. It has several benefits: it fully prevents safe access to the
underlying value of `Untrusted` without going through the `Validate`
API. Additionally, it allows one to grep for validation logic by simply
looking for `Unvalidated<`.

Any API that reads data from an untrusted source should return
`Untrusted<T>` where `T` is the type of the underlying untrusted data.
This generic allows other abstractions to return their custom type
wrapped by `Untrusted`, signaling to the caller that the data must be
validated before use. This allows those abstractions to be used both in
a trusted and untrusted manner, increasing their generality.
Additionally, using the arbitrary self types feature, APIs can be
designed to explicitly read untrusted data:

    impl MyCustomDataSource {
        pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
    }

Cc: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/validate.rs | 602 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 603 insertions(+)
 create mode 100644 rust/kernel/validate.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f10b06a78b9d..3125936eae45 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -54,6 +54,7 @@
 pub mod time;
 pub mod types;
 pub mod uaccess;
+pub mod validate;
 pub mod workqueue;
=20
 #[doc(hidden)]
diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
new file mode 100644
index 000000000000..b325349e7dc3
--- /dev/null
+++ b/rust/kernel/validate.rs
@@ -0,0 +1,604 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for handling and validating untrusted data.
+//!
+//! # Overview
+//!
+//! Untrusted data is marked using the [`Untrusted<T>`] type. See [Rationa=
le](#rationale) for the
+//! reasons to mark untrusted data throught the kernel. It is a totally op=
aque wrapper, it is not
+//! possible to read the data inside; but it is possible to [`Untrusted::w=
rite`] into it.
+//!
+//! The only way to "access" the data inside an [`Untrusted<T>`] is to [`U=
ntrusted::validate`] it;
+//! turning it into a different form using the [`Validate`] trait. That tr=
ait receives the data in
+//! the form of [`Unvalidated<T>`], which in contrast to [`Untrusted<T>`],=
 allows access to the
+//! underlying data. It additionally provides several utility functions to=
 simplify validation.
+//!
+//! # Rationale
+//!
+//! When reading data from an untrusted source, it must be validated befor=
e it can be used for
+//! logic. For example, this is a very bad idea:
+//!
+//! ```
+//! # fn read_bytes_from_network() -> Box<[u8]> {
+//! #     Box::new([1, 0], kernel::alloc::flags::GFP_KERNEL).unwrap()
+//! # }
+//! let bytes: Box<[u8]> =3D read_bytes_from_network();
+//! let data_index =3D bytes[0];
+//! let data =3D bytes[usize::from(data_index)];
+//! ```
+//!
+//! While this will not lead to a memory violation (because the array inde=
x checks the bounds), it
+//! might result in a kernel panic. For this reason, all untrusted data mu=
st be wrapped in
+//! [`Untrusted<T>`]. This type only allows validating the data or passing=
 it along, since copying
+//! data from one userspace buffer into another is allowed for untrusted d=
ata.
+
+use crate::init::Init;
+use core::{
+    mem::MaybeUninit,
+    ops::{Index, IndexMut},
+    ptr, slice,
+};
+
+/// Untrusted data of type `T`.
+///
+/// When reading data from userspace, hardware or other external untrusted=
 sources, the data must
+/// be validated before it is used for logic within the kernel. To do so, =
the [`validate()`]
+/// function exists and uses the [`Validate`] trait.
+///
+/// Also see the [module] description.
+///
+/// [`validate()`]: Self::validate
+/// [module]: self
+#[repr(transparent)]
+pub struct Untrusted<T: ?Sized>(Unvalidated<T>);
+
+impl<T: ?Sized> Untrusted<T> {
+    /// Marks the given value as untrusted.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// # mod bindings { pub(crate) unsafe fn read_foo_info() -> [u8; 4] {=
 todo!() } };
+    /// fn read_foo_info() -> Untrusted<[u8; 4]> {
+    ///     // SAFETY: just an FFI call without preconditions.
+    ///     Untrusted::new(unsafe { bindings::read_foo_info() })
+    /// }
+    /// ```
+    pub fn new(value: T) -> Self
+    where
+        T: Sized,
+    {
+        Self(Unvalidated::new(value))
+    }
+
+    /// Marks the value behind the reference as untrusted.
+    ///
+    /// # Examples
+    ///
+    /// In this imaginary example there exists the `foo_hardware` struct o=
n the C side, as well as
+    /// a `foo_hardware_read` function that reads some data directly from =
the hardware.
+    /// ```
+    /// use kernel::{error, types::Opaque, validate::Untrusted};
+    /// use core::ptr;
+    ///
+    /// # #[allow(non_camel_case_types)]
+    /// # mod bindings {
+    /// #     pub(crate) struct foo_hardware;
+    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardwa=
re, _len: &mut usize) -> *mut u8 {
+    /// #         todo!()
+    /// #     }
+    /// # }
+    /// struct Foo(Opaque<bindings::foo_hardware>);
+    ///
+    /// impl Foo {
+    ///     fn read(&mut self, mut len: usize) -> Result<&Untrusted<[u8]>>=
 {
+    ///         // SAFETY: just an FFI call without preconditions.
+    ///         let data: *mut u8 =3D unsafe { bindings::foo_hardware_read=
(self.0.get(), &mut len) };
+    ///         let data =3D error::from_err_ptr(data)?;
+    ///         let data =3D ptr::slice_from_raw_parts(data, len);
+    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid=
 for reads as long as the
+    ///         // `foo_hardware` object exists. That function updated the
+    ///         let data =3D unsafe { &*data };
+    ///         Ok(Untrusted::new_ref(data))
+    ///     }
+    /// }
+    /// ```
+    pub fn new_ref(value: &T) -> &Self {
+        let ptr: *const T =3D value;
+        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and cont=
ain a `T`.
+        let ptr =3D ptr as *const Self;
+        // SAFETY: `ptr` came from a shared reference valid for `'a`.
+        unsafe { &*ptr }
+    }
+
+    /// Marks the value behind the reference as untrusted.
+    ///
+    /// # Examples
+    ///
+    /// In this imaginary example there exists the `foo_hardware` struct o=
n the C side, as well as
+    /// a `foo_hardware_read` function that reads some data directly from =
the hardware.
+    /// ```
+    /// use kernel::{error, types::Opaque, validate::Untrusted};
+    /// use core::ptr;
+    ///
+    /// # #[allow(non_camel_case_types)]
+    /// # mod bindings {
+    /// #     pub(crate) struct foo_hardware;
+    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardwa=
re, _len: &mut usize) -> *mut u8 {
+    /// #         todo!()
+    /// #     }
+    /// # }
+    /// struct Foo(Opaque<bindings::foo_hardware>);
+    ///
+    /// impl Foo {
+    ///     fn read(&mut self, mut len: usize) -> Result<&mut Untrusted<[u=
8]>> {
+    ///         // SAFETY: just an FFI call without preconditions.
+    ///         let data: *mut u8 =3D unsafe { bindings::foo_hardware_read=
(self.0.get(), &mut len) };
+    ///         let data =3D error::from_err_ptr(data)?;
+    ///         let data =3D ptr::slice_from_raw_parts_mut(data, len);
+    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid=
 for reads as long as the
+    ///         // `foo_hardware` object exists. That function updated the
+    ///         let data =3D unsafe { &mut *data };
+    ///         Ok(Untrusted::new_mut(data))
+    ///     }
+    /// }
+    /// ```
+    pub fn new_mut(value: &mut T) -> &mut Self {
+        let ptr: *mut T =3D value;
+        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and cont=
ain a `T`.
+        let ptr =3D ptr as *mut Self;
+        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
+        unsafe { &mut *ptr }
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> Resu=
lt<V, V::Err> {
+        V::validate(&self.0)
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
+        &'a mut self,
+    ) -> Result<V, V::Err> {
+        V::validate(&mut self.0)
+    }
+
+    /// Sets the underlying untrusted value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// let mut untrusted =3D Untrusted::new(42);
+    /// untrusted.write(24);
+    /// ```
+    pub fn write(&mut self, value: impl Init<T>) {
+        let ptr: *mut T =3D &mut self.0 .0;
+        // SAFETY: `ptr` came from a mutable reference and the value is ov=
erwritten before it is
+        // read.
+        unsafe { ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` came from a mutable reference and the initializer=
 cannot error.
+        match unsafe { value.__init(ptr) } {
+            Ok(()) =3D> {}
+        }
+    }
+
+    /// Turns a slice of untrusted values into an untrusted slice of value=
s.
+    pub fn transpose_slice(slice: &[Untrusted<T>]) -> &Untrusted<[T]>
+    where
+        T: Sized,
+    {
+        let ptr =3D slice.as_ptr().cast::<T>();
+        // SAFETY: `ptr` and `len` come from the same slice reference.
+        let slice =3D unsafe { slice::from_raw_parts(ptr, slice.len()) };
+        Untrusted::new_ref(slice)
+    }
+
+    /// Turns a slice of uninitialized, untrusted values into an untrusted=
 slice of uninitialized
+    /// values.
+    pub fn transpose_slice_uninit(
+        slice: &[MaybeUninit<Untrusted<T>>],
+    ) -> &Untrusted<[MaybeUninit<T>]>
+    where
+        T: Sized,
+    {
+        let ptr =3D slice.as_ptr().cast::<MaybeUninit<T>>();
+        // SAFETY: `ptr` and `len` come from the same mutable slice refere=
nce.
+        let slice =3D unsafe { slice::from_raw_parts(ptr, slice.len()) };
+        Untrusted::new_ref(slice)
+    }
+
+    /// Turns a slice of uninitialized, untrusted values into an untrusted=
 slice of uninitialized
+    /// values.
+    pub fn transpose_slice_uninit_mut(
+        slice: &mut [MaybeUninit<Untrusted<T>>],
+    ) -> &mut Untrusted<[MaybeUninit<T>]>
+    where
+        T: Sized,
+    {
+        // CAST: `MaybeUninit<T>` and `MaybeUninit<Untrusted<T>>` have the=
 same layout.
+        let ptr =3D slice.as_mut_ptr().cast::<MaybeUninit<T>>();
+        // SAFETY: `ptr` and `len` come from the same mutable slice refere=
nce.
+        let slice =3D unsafe { slice::from_raw_parts_mut(ptr, slice.len())=
 };
+        Untrusted::new_mut(slice)
+    }
+}
+
+impl<T> Untrusted<MaybeUninit<T>> {
+    /// Sets the underlying untrusted value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// let mut untrusted =3D Untrusted::new(42);
+    /// untrusted.write(24);
+    /// ```
+    pub fn write_uninit<E>(&mut self, value: impl Init<T, E>) -> Result<&m=
ut Untrusted<T>, E> {
+        let ptr: *mut MaybeUninit<T> =3D &mut self.0 .0;
+        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
+        let ptr =3D ptr.cast::<T>();
+        // SAFETY: `ptr` came from a reference and if `Err` is returned, t=
he underlying memory is
+        // considered uninitialized.
+        unsafe { value.__init(ptr) }.map(|()| {
+            let this =3D self.0.raw_mut();
+            // SAFETY: we initialized the memory above.
+            Untrusted::new_mut(unsafe { this.assume_init_mut() })
+        })
+    }
+}
+
+impl<T> Untrusted<[MaybeUninit<T>]> {
+    /// Sets the underlying untrusted value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// let mut untrusted =3D Untrusted::new(42);
+    /// untrusted.write(24);
+    /// ```
+    pub fn write_uninit_slice<E>(
+        &mut self,
+        value: impl Init<[T], E>,
+    ) -> Result<&mut Untrusted<[T]>, E> {
+        let ptr: *mut [MaybeUninit<T>] =3D &mut self.0 .0;
+        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
+        let ptr =3D ptr as *mut [T];
+        // SAFETY: `ptr` came from a reference and if `Err` is returned, t=
he underlying memory is
+        // considered uninitialized.
+        unsafe { value.__init(ptr) }.map(|()| {
+            let this =3D self.0.raw_mut().as_mut_ptr();
+            // CAST: `MaybeUninit<T>` is `repr(transparent)`.
+            let this =3D this.cast::<T>();
+            // SAFETY: `this` and `len` came from the same slice reference=
.
+            let this =3D unsafe { slice::from_raw_parts_mut(this, self.0.l=
en()) };
+            Untrusted::new_mut(this)
+        })
+    }
+}
+
+/// Marks types that can be used as input to [`Validate::validate`].
+pub trait ValidateInput: private::Sealed + Sized {}
+
+mod private {
+    pub trait Sealed {}
+}
+
+impl<'a, T: ?Sized> private::Sealed for &'a Unvalidated<T> {}
+impl<'a, T: ?Sized> ValidateInput for &'a Unvalidated<T> {}
+
+impl<'a, T: ?Sized> private::Sealed for &'a mut Unvalidated<T> {}
+impl<'a, T: ?Sized> ValidateInput for &'a mut Unvalidated<T> {}
+
+/// Validates untrusted data.
+///
+/// # Examples
+///
+/// The simplest way to validate data is to just implement `Validate<&Unva=
lidated<[u8]>>` for the
+/// type that you wish to validate:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::{CStr, CString},
+///     validate::{Unvalidated, Validate},
+/// };
+///
+/// struct Data {
+///     flags: u8,
+///     name: CString,
+/// }
+///
+/// impl Validate<&Unvalidated<[u8]>> for Data {
+///     type Err =3D Error;
+///
+///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self:=
:Err> {
+///         let raw =3D unvalidated.raw();
+///         let (&flags, name) =3D raw.split_first().ok_or(EINVAL)?;
+///         let name =3D CStr::from_bytes_with_nul(name)?.to_cstring()?;
+///         Ok(Data { flags, name })
+///     }
+/// }
+/// ```
+///
+/// This approach copies the data and requires allocation. If you want to =
avoid the allocation and
+/// copying the data, you can borrow from the input like this:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::CStr,
+///     validate::{Unvalidated, Validate},
+/// };
+///
+/// struct Data<'a> {
+///     flags: u8,
+///     name: &'a CStr,
+/// }
+///
+/// impl<'a> Validate<&'a Unvalidated<[u8]>> for Data<'a> {
+///     type Err =3D Error;
+///
+///     fn validate(unvalidated: &'a Unvalidated<[u8]>) -> Result<Self, Se=
lf::Err> {
+///         let raw =3D unvalidated.raw();
+///         let (&flags, name) =3D raw.split_first().ok_or(EINVAL)?;
+///         let name =3D CStr::from_bytes_with_nul(name)?;
+///         Ok(Data { flags, name })
+///     }
+/// }
+/// ```
+///
+/// If you need to in-place validate your data, you currently need to reso=
rt to `unsafe`:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::CStr,
+///     validate::{Unvalidated, Validate},
+/// };
+/// use core::mem;
+///
+/// // Important: use `repr(C)`, this ensures a linear layout of this type=
.
+/// #[repr(C)]
+/// struct Data {
+///     version: u8,
+///     flags: u8,
+///     _reserved: [u8; 2],
+///     count: u64,
+///     // lots of other fields...
+/// }
+///
+/// impl Validate<&Unvalidated<[u8]>> for &Data {
+///     type Err =3D Error;
+///
+///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self:=
:Err> {
+///         let raw =3D unvalidated.raw();
+///         if raw.len() < mem::size_of::<Data>() {
+///             return Err(EINVAL);
+///         }
+///         // can only handle version 0
+///         if raw[0] !=3D 0 {
+///             return Err(EINVAL);
+///         }
+///         // version 0 only uses the lower 4 bits of flags
+///         if raw[1] & 0xf0 !=3D 0 {
+///             return Err(EINVAL);
+///         }
+///         let ptr =3D raw.as_ptr();
+///         // CAST: `Data` only contains integers and has `repr(C)`.
+///         let ptr =3D ptr.cast::<Data>();
+///         // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
+///         Ok(unsafe { &*ptr })
+///     }
+/// }
+/// ```
+///
+/// To be able to modify the parsed data, while still supporting zero-copy=
, you can implement
+/// `Validate<&mut Unvalidated<[u8]>>`:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::CStr,
+///     validate::{Unvalidated, Validate},
+/// };
+/// use core::mem;
+///
+/// // Important: use `repr(C)`, this ensures a linear layout of this type=
.
+/// #[repr(C)]
+/// struct Data {
+///     version: u8,
+///     flags: u8,
+///     _reserved: [u8; 2],
+///     count: u64,
+///     // lots of other fields...
+/// }
+///
+/// impl Validate<&mut Unvalidated<[u8]>> for &Data {
+///     type Err =3D Error;
+///
+///     fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, S=
elf::Err> {
+///         let raw =3D unvalidated.raw_mut();
+///         if raw.len() < mem::size_of::<Data>() {
+///             return Err(EINVAL);
+///         }
+///         match raw[0] {
+///             0 =3D> {},
+///             1 =3D> {
+///                 // version 1 implicitly sets the first bit.
+///                 raw[1] |=3D 1;
+///             },
+///             // can only handle version 0 and 1
+///             _ =3D> return Err(EINVAL),
+///         }
+///         // version 0 and 1 only use the lower 4 bits of flags
+///         if raw[1] & 0xf0 !=3D 0 {
+///             return Err(EINVAL);
+///         }
+///         if raw[1] =3D=3D 0 {}
+///         let ptr =3D raw.as_ptr();
+///         // CAST: `Data` only contains integers and has `repr(C)`.
+///         let ptr =3D ptr.cast::<Data>();
+///         // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
+///         Ok(unsafe { &*ptr })
+///     }
+/// }
+/// ```
+pub trait Validate<I: ValidateInput>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Validate the given untrusted data and parse it into the output typ=
e.
+    fn validate(unvalidated: I) -> Result<Self, Self::Err>;
+}
+
+/// Unvalidated data of type `T`.
+#[repr(transparent)]
+pub struct Unvalidated<T: ?Sized>(T);
+
+impl<T: ?Sized> Unvalidated<T> {
+    fn new(value: T) -> Self
+    where
+        T: Sized,
+    {
+        Self(value)
+    }
+
+    fn new_ref(value: &T) -> &Self {
+        let ptr: *const T =3D value;
+        // CAST: `Self` is `repr(transparent)` and contains a `T`.
+        let ptr =3D ptr as *const Self;
+        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
+        unsafe { &*ptr }
+    }
+
+    fn new_mut(value: &mut T) -> &mut Self {
+        let ptr: *mut T =3D value;
+        // CAST: `Self` is `repr(transparent)` and contains a `T`.
+        let ptr =3D ptr as *mut Self;
+        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
+        unsafe { &mut *ptr }
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate_ref<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> =
Result<V, V::Err> {
+        V::validate(self)
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
+        &'a mut self,
+    ) -> Result<V, V::Err> {
+        V::validate(self)
+    }
+
+    /// Gives immutable access to the underlying value.
+    pub fn raw(&self) -> &T {
+        &self.0
+    }
+
+    /// Gives mutable access to the underlying value.
+    pub fn raw_mut(&mut self) -> &mut T {
+        &mut self.0
+    }
+}
+
+impl<T, I> Index<I> for Unvalidated<[T]>
+where
+    I: slice::SliceIndex<[T]>,
+{
+    type Output =3D Unvalidated<I::Output>;
+
+    fn index(&self, index: I) -> &Self::Output {
+        Unvalidated::new_ref(self.0.index(index))
+    }
+}
+
+impl<T, I> IndexMut<I> for Unvalidated<[T]>
+where
+    I: slice::SliceIndex<[T]>,
+{
+    fn index_mut(&mut self, index: I) -> &mut Self::Output {
+        Unvalidated::new_mut(self.0.index_mut(index))
+    }
+}
+
+/// Immutable unvalidated slice iterator.
+pub struct Iter<'a, T>(slice::Iter<'a, T>);
+
+/// Mutable unvalidated slice iterator.
+pub struct IterMut<'a, T>(slice::IterMut<'a, T>);
+
+impl<'a, T> Iterator for Iter<'a, T> {
+    type Item =3D &'a Unvalidated<T>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.0.next().map(Unvalidated::new_ref)
+    }
+}
+
+impl<'a, T> IntoIterator for &'a Unvalidated<[T]> {
+    type Item =3D &'a Unvalidated<T>;
+    type IntoIter =3D Iter<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        Iter(self.0.iter())
+    }
+}
+
+impl<'a, T> Iterator for IterMut<'a, T> {
+    type Item =3D &'a mut Unvalidated<T>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.0.next().map(Unvalidated::new_mut)
+    }
+}
+
+impl<'a, T> IntoIterator for &'a mut Unvalidated<[T]> {
+    type Item =3D &'a mut Unvalidated<T>;
+    type IntoIter =3D IterMut<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        IterMut(self.0.iter_mut())
+    }
+}
+
+impl<T> Unvalidated<[T]> {
+    /// Returns the number of elements in the underlying slice.
+    pub fn len(&self) -> usize {
+        self.0.len()
+    }
+
+    /// Returns true if the underlying slice has a length of 0.
+    pub fn is_empty(&self) -> bool {
+        self.0.is_empty()
+    }
+
+    /// Iterates over all items and validates each of them individually.
+    pub fn validate_iter<'a, V: Validate<&'a Unvalidated<T>>>(
+        &'a self,
+    ) -> impl Iterator<Item =3D Result<V, V::Err>> + 'a {
+        self.into_iter().map(|item| V::validate(item))
+    }
+
+    /// Iterates over all items and validates each of them individually.
+    pub fn validate_iter_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
+        &'a mut self,
+    ) -> impl Iterator<Item =3D Result<V, V::Err>> + 'a {
+        self.into_iter().map(|item| V::validate(item))
+    }
+}
--=20
2.46.0




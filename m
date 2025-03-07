Return-Path: <linux-kernel+bounces-550830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62788A56498
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B90175045
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AD1211276;
	Fri,  7 Mar 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IQz4K2r2"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D320E02A;
	Fri,  7 Mar 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341885; cv=none; b=eKsvFSORBxxCYDOTI570P1R46hrY8920M9K2p+0kLImkzhotpX6CMHnFf1MI61K3kK5ixFzhJkeulQFzQQHSqt2JREf/L8O+512nm8fZ44uPW0nDR+9BqLgYvbatWwkcr5gJaNe4m/LhaxXD7LO+Qqbf5s6LmX9IiAN048rNAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341885; c=relaxed/simple;
	bh=kRTzWQygEG5Ns1HqePZuYB9UCZNysEaq22FudaRwL6E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIAr6sPpkYs4tjupfeMA8NbHYwO22HGnz+RJNJYffffStlCvBYt09wXFcAMiKNGhDmEPW8j8eg4Se0bDktZdT6YhDCziuvgs+z5q9Pctlhr3VHK8+lP9Uf/npEErNxJkTDb9BXz/chMWkpGX+IFobTnpN/GPXzeQnSqENqdAmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IQz4K2r2; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741341879; x=1741601079;
	bh=0soWOnUPmUJEv0zAHpPwiKg0s8n+VOyuLKHVFYcokyE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=IQz4K2r28VKvG9K7I/UzGpHlywImDu7CPJstCYDBNvKvOcYDLcyFDiyTab35Fkw9A
	 wCdiZYgnsvazRfjAS9DtbkMs/X4Z7+O2KHXnZppxSfVg2SebducnZ/S+H/PDBMz7F3
	 VpaMunKa7lzPSx99VbaFZyOLT/r4BMsXH34A+oJmqaokFIgywhyQ+bz9JEYWDBkymq
	 gFN7b2zsbtNq/7iOON6K2jWebKZcmzvjs/IvD5sOtLqC/LJrfAUDTqoKBOOR7PdddK
	 FMsl4gZzK5M168OKAi/lGrEfBRebhxO4icNYrIiCcWUSUVy7xx/u3D/mvijp11t0tu
	 9vtdNJrspX3jQ==
Date: Fri, 07 Mar 2025 10:04:33 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v5 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
Message-ID: <20250307-unique-ref-v5-4-bffeb633277e@pm.me>
In-Reply-To: <20250307-unique-ref-v5-0-bffeb633277e@pm.me>
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 4909219767ac13eea0b39a877baa4bf244193cca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Types implementing one of these traits
can safely convert between an ARef<T> and an Owned<T>.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 268 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 268 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index e6f3308f931d90718d405443c3034a216388e0af..0acf95d322b6a213728916f0c7f=
4095aa3f0e0f0 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -552,6 +552,12 @@ fn from(b: &T) -> Self {
     }
 }
=20
+impl<T: OwnableRefCounted> From<Owned<T>> for ARef<T> {
+    fn from(b: Owned<T>) -> Self {
+        T::into_shared(b)
+    }
+}
+
 impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the =
reference
@@ -669,6 +675,268 @@ fn drop(&mut self) {
     }
 }
=20
+/// A trait for objects that can be wrapped in either one of the reference=
 types
+/// [`Owned`] and [`ARef`].
+///
+/// # Safety
+///
+/// - The same safety requirements as for [`Ownable`] and [`RefCounted`] a=
pply.
+/// - the uniqueness invariant of [`Owned`] is upheld until dropped.
+/// - [`try_from_shared()`](OwnableRefCounted::into_shared) only returns a=
n
+///   [`Owned`] if exactly one [`ARef`] exists.
+/// - [`into_shared()`](OwnableRefCounted::into_shared) set the reference =
count
+///   to the value which the returned [`ARef`] expects for an object with =
a single reference
+///   in existence. This implies that if [`into_shared()`](OwnableRefCount=
ed::into_shared)
+///   is left on the default implementation, which just rewraps the underl=
ying object,
+///   the reference count needs not to be modified when converting a [`Own=
ed`] to an [`ARef`].
+///
+/// # Examples
+///
+/// A minimal example implementation of [`OwnableRefCounted`],
+/// [`Ownable`] and its usage with [`ARef`] and [`Owned`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// use core::cell::Cell;
+/// use core::ptr::NonNull;
+/// use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// use kernel::types::{
+///     ARef, RefCounted, Owned, Ownable, OwnableRefCounted,
+/// };
+///
+/// struct Foo {
+///     refcount: Cell<usize>,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>, AllocError> {
+///         // Use a KBox to handle the actual allocation
+///         let result =3D KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         // SAFETY: we just allocated the `Foo`, thus it is valid
+///         Ok(unsafe { Owned::from_raw(NonNull::new(KBox::into_raw(result=
)).unwrap()) })
+///     }
+/// }
+///
+/// // SAFETY: we increment and decrement correctly and only free the `Foo=
`
+/// // when the refcount reaches zero
+/// unsafe impl RefCounted for Foo {
+///     fn inc_ref(&self) {
+///         self.refcount.replace(self.refcount.get() + 1);
+///     }
+///     unsafe fn dec_ref(this: NonNull<Self>) {
+///         // SAFETY: the underlying object is always valid when the func=
tion is called
+///         let refcount =3D unsafe { &this.as_ref().refcount };
+///         let new_refcount =3D refcount.get() - 1;
+///         if new_refcount =3D=3D 0 {
+///             // Foo will be dropped when KBox goes out of scope
+///             // SAFETY: the `Box<Foo>` is still alive as the old refcou=
nt is 1
+///             unsafe { KBox::from_raw(this.as_ptr()) };
+///         } else {
+///             refcount.replace(new_refcount);
+///         }
+///     }
+/// }
+///
+/// // SAFETY: we only convert into an `Owned` when the refcount is 1
+/// unsafe impl OwnableRefCounted for Foo {
+///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<S=
elf>> {
+///         if this.refcount.get() =3D=3D 1 {
+///             // SAFETY: the `Foo` is still alive as the refcount is 1
+///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
+///         } else {
+///             Err(this)
+///         }
+///     }
+/// }
+///
+/// // SAFETY: we are not `AlwaysRefCounted`
+/// unsafe impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // SAFETY: using `dec_ref()` from `RefCounted` to release is o=
kay,
+///         // as the refcount is always 1 for an `Owned<Foo>`
+///         unsafe{ Foo::dec_ref(this) };
+///     }
+/// }
+///
+/// let foo =3D Foo::new().unwrap();
+/// let mut foo =3D ARef::from(foo);
+/// {
+///     let bar =3D foo.clone();
+///     assert!(Owned::try_from(bar).is_err());
+/// }
+/// assert!(Owned::try_from(foo).is_ok());
+/// ```
+pub unsafe trait OwnableRefCounted: RefCounted + Ownable + Sized {
+    /// Checks if the [`ARef`] is unique and convert it
+    /// to an [`Owned`] it that is that case.
+    /// Otherwise it returns again an [`ARef`] to the same
+    /// underlying object.
+    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>=
>;
+    /// Converts the [`Owned`] into an [`ARef`].
+    fn into_shared(this: Owned<Self>) -> ARef<Self> {
+        // SAFETY: safe by the conditions on implementing the trait
+        unsafe { ARef::from_raw(Owned::into_raw(this)) }
+    }
+}
+
+/// This trait allows to implement all of [`Ownable`], [`RefCounted`] and
+/// [`OwnableRefCounted`] together in a simplified way,
+/// only requiring to provide the methods [`inc_ref()`](SimpleOwnableRefCo=
unted::inc_ref),
+/// [`dec_ref()`](SimpleOwnableRefCounted::dec_ref),
+/// and [`is_unique()`](SimpleOwnableRefCounted::is_unique).
+///
+/// For non-standard cases where conversion between [`Ownable`] and [`RefC=
ounted`] needs
+/// or [`Ownable::release()`] and [`RefCounted::dec_ref()`] cannot be the =
same method,
+/// [`Ownable`], [`RefCounted`] and [`OwnableRefCounted`] should be implem=
ented manually.
+///
+/// # Safety
+///
+/// - The same safety requirements as for [`Ownable`] and [`RefCounted`] a=
pply.
+/// - [`is_unique`](SimpleOwnableRefCounted::is_unique) must only return `=
true`
+///   in case only one [`ARef`] exists and it is impossible for one to be =
obtained
+///   other than by cloning an existing [`ARef`] or converting an [`Owned`=
] to an [`ARef`].
+/// - It is safe to convert an unique [`ARef`] into an [`Owned`]
+///   simply by re-wrapping the underlying object without modifying the re=
fcount.
+///
+/// # Examples
+///
+/// A minimal example implementation of [`SimpleOwnableRefCounted`]
+/// and its usage with [`ARef`] and [`Owned`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// use core::cell::Cell;
+/// use core::ptr::NonNull;
+/// use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// use kernel::types::{
+///     ARef, SimpleOwnableRefCounted, Owned,
+/// };
+///
+/// struct Foo {
+///     refcount: Cell<usize>,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>, AllocError> {
+///         // Use a KBox to handle the actual allocation
+///         let result =3D KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         // SAFETY: we just allocated the `Foo`, thus it is valid
+///         Ok(unsafe { Owned::from_raw(NonNull::new(KBox::into_raw(result=
)).unwrap()) })
+///     }
+/// }
+///
+/// // SAFETY: we implement the trait correctly by ensuring
+/// // - the `Foo` is only dropped then the refcount is zero
+/// // - `is_unique()` only returns `true` when the refcount is 1
+/// unsafe impl SimpleOwnableRefCounted for Foo {
+///     fn inc_ref(&self) {
+///         self.refcount.replace(self.refcount.get() + 1);
+///     }
+///     unsafe fn dec_ref(this: NonNull<Self>) {
+///         // SAFETY: the underlying object is always valid when the func=
tion is called
+///         let refcount =3D unsafe { &this.as_ref().refcount };
+///         let new_refcount =3D refcount.get() - 1;
+///         if new_refcount =3D=3D 0 {
+///             // Foo will be dropped when KBox goes out of scope
+///             // SAFETY: the `Box<Foo>` is still alive as the old refcou=
nt is 1
+///             unsafe { KBox::from_raw(this.as_ptr()) };
+///         } else {
+///             refcount.replace(new_refcount);
+///         }
+///     }
+///     fn is_unique(&self) -> bool {
+///         self.refcount.get() =3D=3D 1
+///     }
+/// }
+///
+/// let foo =3D Foo::new().unwrap();
+/// let mut foo =3D ARef::from(foo);
+/// {
+///     let bar =3D foo.clone();
+///     assert!(Owned::try_from(bar).is_err());
+/// }
+/// assert!(Owned::try_from(foo).is_ok());
+/// ```
+pub unsafe trait SimpleOwnableRefCounted {
+    /// Checks if exactly one [`ARef`] to the object exists.
+    /// In case the object is [`Sync`] the check needs to be race-free.
+    fn is_unique(&self) -> bool;
+    /// Increments the reference count on the object.
+    fn inc_ref(&self);
+
+    /// Decrements the reference count on the object
+    /// when the [`SimpleOwnableRefCounted`] is dropped.
+    ///
+    /// Frees the object when the count reaches zero.
+    ///
+    /// # Safety
+    ///
+    /// The safety constraints for [`RefCounted::dec_ref`] and
+    /// [`Ownable::release`] both apply to this method, as it will be used
+    /// to implement both of these traits.
+    unsafe fn dec_ref(obj: NonNull<Self>);
+}
+
+// TODO: enable this when compiler supports it (>=3D1.85)
+// #[diagnostic::do_not_recommend]
+// SAFETY: safe by the requirements on implementation of [`SimpleOwnableRe=
fCounted`]
+unsafe impl<T: SimpleOwnableRefCounted> OwnableRefCounted for T {
+    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>=
> {
+        if T::is_unique(&*this) {
+            // SAFETY: safe by the requirements on implementation of [`Sim=
pleOwnable`]
+            Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
+        } else {
+            Err(this)
+        }
+    }
+}
+
+// TODO: enable this when compiler supports it (>=3D1.85)
+// #[diagnostic::do_not_recommend]
+// SAFETY: safe by the requirements on implementation of [`SimpleOwnableRe=
fCounted`]
+unsafe impl<T: SimpleOwnableRefCounted> Ownable for T {
+    unsafe fn release(this: NonNull<Self>) {
+        // SAFETY: safe by the requirements on implementation
+        // of [`SimpleOwnableRefCounted::dec_ref()`]
+        unsafe { SimpleOwnableRefCounted::dec_ref(this) };
+    }
+}
+
+// TODO: enable this when compiler supports it (>=3D1.85)
+// #[diagnostic::do_not_recommend]
+// SAFETY: safe by the requirements on implementation of [`SimpleOwnableRe=
fCounted`]
+unsafe impl<T: SimpleOwnableRefCounted> RefCounted for T {
+    fn inc_ref(&self) {
+        SimpleOwnableRefCounted::inc_ref(self);
+    }
+    unsafe fn dec_ref(this: NonNull<Self>) {
+        // SAFETY: safe by the requirements on implementation
+        // of [`SimpleOwnableRefCounted::dec_ref()`]
+        unsafe { SimpleOwnableRefCounted::dec_ref(this) };
+    }
+}
+
+impl<T: OwnableRefCounted> TryFrom<ARef<T>> for Owned<T> {
+    type Error =3D ARef<T>;
+    /// Tries to convert the [`ARef`] to an [`Owned`]
+    /// by calling [`try_from_shared()`](OwnableRefCounted::try_from_share=
d).
+    /// In case the [`ARef`] is not unique it returns again an [`ARef`] to=
 the same
+    /// underlying object.
+    fn try_from(b: ARef<T>) -> Result<Owned<T>, Self::Error> {
+        T::try_from_shared(b)
+    }
+}
+
 /// A sum type that always holds either a value of type `L` or `R`.
 ///
 /// # Examples

--=20
2.48.1




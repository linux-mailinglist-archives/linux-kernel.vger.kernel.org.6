Return-Path: <linux-kernel+bounces-558856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C3A5EC22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4241783F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1341FECBA;
	Thu, 13 Mar 2025 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="g7chGb21"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E91FDE2D;
	Thu, 13 Mar 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849236; cv=none; b=gJkPgEz7ygUGJuGbq9eajf8ADAad1P4UuZDyZwBrzK67EcaOfaiNgVqgnwDzDVThHkTqH/x4KkYG0Yl63zHr50J1xfpZzdlkvaL6RDU4BY3hctvO9rIv21mytBDVvoJS+0klp3R+85q5C1+AX0I1HAR94uGzjvCew53MffRbRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849236; c=relaxed/simple;
	bh=Cs1OcLhyLR2AMiK04+bdFA7d0YH8Jo+aOwzCX7qRITA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw1et0t1NvaKfnsE+YylgnGA7Bv+7S8GMCi9RiwMZ49mDUBPi7p5O2D0K+lq9NTF4ZrNIAjbKIbP2GbpMtcp/pkKKt2KpDrpaRgJWprg2456SGjOahCij5XJ7JZqftr3/KoWe7za7/m4kyFiCvqYGJeM4ixRi2K7zscwK3XI2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=g7chGb21; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741849232; x=1742108432;
	bh=q68/axSjn/RKjxdFDHLzObIGlgRlUlb0I6KrYmG5Hs8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=g7chGb21BRmgTcOMqRIm1GmsirD2JHo9lNEiPNLVgqCLASKFAhFdBcAaTIsD0M+3c
	 ZRxEHRl8g8P6rOhODv5iQS5qL5UY0h7PGVGGn5mscMwr6aBM8DZtpxqzJ/eVeHFQwc
	 sXLykyy8qeNf1LT+rw19dHHFmB8o2uTkcNugdeDCUq22Va3szOKRKo/YK7TGl6IdEn
	 qxv9j/qDOQ+Nxv9OoKY7yRRl6LFn2C18DDaX3DU4gGOT69ZZieRXJrVc2wWmgRrvSG
	 5swg/CQFj/umXbx5RhIjqJ/vezDuNIVqSBifLZ9AAMo87TAYEVBicvRu2MPaF2MKKB
	 jbUn6GI88Pa3g==
Date: Thu, 13 Mar 2025 07:00:26 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v8 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
Message-ID: <20250313-unique-ref-v8-4-3082ffc67a31@pm.me>
In-Reply-To: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
References: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: d700f938e92b50a7f9214c050496712730e5d4d6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Types implementing one of these traits can safely convert between an
ARef<T> and an Owned<T>.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 250 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 250 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 5a96da714348cc2369969200e6070972226c00fe..cca3d65782eecc7e2ada91f116e=
b885391c454bf 100644
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
@@ -669,6 +675,250 @@ fn drop(&mut self) {
     }
 }
=20
+/// A trait for objects that can be wrapped in either one of the reference=
 types [`Owned`] and
+/// [`ARef`].
+///
+/// # Safety
+///
+/// Implementers must ensure that:
+///
+/// - Both the safety requirements for [`Ownable`] and [`RefCounted`] are =
fulfilled.
+/// - The uniqueness invariant of [`Owned`] is upheld until dropped.
+/// - [`try_from_shared()`](OwnableRefCounted::into_shared) only returns a=
n [`Owned`] if exactly
+///   one [`ARef`] exists.
+/// - [`into_shared()`](OwnableRefCounted::into_shared) set the reference =
count to the value which
+///   the returned [`ARef`] expects for an object with a single reference
+///   in existence. This implies that if [`into_shared()`](OwnableRefCount=
ed::into_shared) is left
+///   on the default implementation, which just rewraps the underlying obj=
ect, the reference count
+///   needs not to be modified when converting a [`Owned`] to an [`ARef`].
+///
+/// # Examples
+///
+/// A minimal example implementation of [`OwnableRefCounted`], [`Ownable`]=
 and its usage with
+/// [`ARef`] and [`Owned`] looks like this:
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
+///         // Use a `KBox` to handle the actual allocation.
+///         let result =3D KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result =3D NonNull::new(KBox::into_raw(result))
+///             .expect("Raw pointer to newly allocation KBox is null, thi=
s should never happen.");
+///         // SAFETY: We just allocated the `Foo`, thus it is valid.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// // SAFETY: We increment and decrement each time the respective functio=
n is called and only free
+/// // the `Foo` when the refcount reaches zero.
+/// unsafe impl RefCounted for Foo {
+///     fn inc_ref(&self) {
+///         self.refcount.replace(self.refcount.get() + 1);
+///     }
+///
+///     unsafe fn dec_ref(this: NonNull<Self>) {
+///         // SAFETY: The underlying object is always valid when the func=
tion is called.
+///         let refcount =3D unsafe { &this.as_ref().refcount };
+///         let new_refcount =3D refcount.get() - 1;
+///         if new_refcount =3D=3D 0 {
+///             // The `Foo` will be dropped when `KBox` goes out of scope=
.
+///             // SAFETY: The `Box<Foo>` is still alive as the old refcou=
nt is 1.
+///             unsafe { KBox::from_raw(this.as_ptr()) };
+///         } else {
+///             refcount.replace(new_refcount);
+///         }
+///     }
+/// }
+///
+/// // SAFETY: We only convert into an `Owned` when the refcount is 1.
+/// unsafe impl OwnableRefCounted for Foo {
+///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<S=
elf>> {
+///         if this.refcount.get() =3D=3D 1 {
+///             // SAFETY: The `Foo` is still alive as the refcount is 1.
+///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
+///         } else {
+///             Err(this)
+///         }
+///     }
+/// }
+///
+/// // SAFETY: We are not `AlwaysRefCounted`.
+/// unsafe impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // SAFETY: Using `dec_ref()` from `RefCounted` to release is o=
kay, as the refcount is
+///         // always 1 for an `Owned<Foo>`.
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
+    /// Checks if the [`ARef`] is unique and convert it to an [`Owned`] it=
 that is that case.
+    /// Otherwise it returns again an [`ARef`] to the same underlying obje=
ct.
+    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>=
>;
+    /// Converts the [`Owned`] into an [`ARef`].
+
+    fn into_shared(this: Owned<Self>) -> ARef<Self> {
+        // SAFETY: Safe by the requirements on implementing the trait.
+        unsafe { ARef::from_raw(Owned::into_raw(this)) }
+    }
+}
+
+/// This trait allows to implement [`Ownable`] and [`OwnableRefCounted`] t=
ogether in a simplified
+/// way, only requiring to implement [`RefCounted`] and providing the meth=
od
+/// [`is_unique()`](SimpleOwnableRefCounted::is_unique).
+///
+/// For non-standard cases where conversion between [`Ownable`] and [`RefC=
ounted`] does not allow
+/// [`Ownable::release()`] and [`RefCounted::dec_ref()`] to be the same me=
thod, [`Ownable`]
+/// and [`OwnableRefCounted`] should be implemented separately.
+///
+/// # Safety
+///
+/// Implementers must ensure that:
+///
+/// - The safety requirements for [`Ownable`] are fulfilled and [`RefCount=
ed::dec_ref()`] can
+///   be used for [`Ownable::release()`].
+/// - [`is_unique`](SimpleOwnableRefCounted::is_unique) must only return `=
true` in case only one
+///   [`ARef`] exists and it is impossible for one to be obtained other th=
an by cloning an existing
+///   [`ARef`] or converting an [`Owned`] to an [`ARef`].
+/// - It is safe to convert an unique [`ARef`] into an [`Owned`] simply by=
 re-wrapping the
+///   underlying object without modifying the refcount.
+///
+/// # Examples
+///
+/// A minimal example implementation of [`RefCounted`] and [`SimpleOwnable=
RefCounted`]
+/// and its usage with [`ARef`] and [`Owned`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// use core::cell::Cell;
+/// use core::ptr::NonNull;
+/// use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// use kernel::types::{
+///     ARef, Owned, RefCounted, SimpleOwnableRefCounted,
+/// };
+///
+/// struct Foo {
+///     refcount: Cell<usize>,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>, AllocError> {
+///         // Use a KBox to handle the actual allocation.
+///         let result =3D KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result =3D NonNull::new(KBox::into_raw(result))
+///             .expect("Raw pointer to newly allocation KBox is null, thi=
s should never happen.");
+///         // SAFETY: We just allocated the `Foo`, thus it is valid.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// // SAFETY: we ensure that:
+/// // - The `Foo` is only dropped when the refcount is zero.
+/// // - `is_unique()` only returns `true` when the refcount is 1.
+/// unsafe impl RefCounted for Foo {
+///     fn inc_ref(&self) {
+///         self.refcount.replace(self.refcount.get() + 1);
+///     }
+///
+///     unsafe fn dec_ref(this: NonNull<Self>) {
+///         // SAFETY: The underlying object is always valid when the func=
tion is called.
+///         let refcount =3D unsafe { &this.as_ref().refcount };
+///         let new_refcount =3D refcount.get() - 1;
+///         if new_refcount =3D=3D 0 {
+///             // The `Foo` will be dropped when KBox goes out of scope.
+///             // SAFETY: The `Box<Foo>` is still alive as the old refcou=
nt is 1.
+///             unsafe { KBox::from_raw(this.as_ptr()) };
+///         } else {
+///             refcount.replace(new_refcount);
+///         }
+///     }
+/// }
+///
+/// // SAFETY: we ensure that:
+/// // - `is_unique()` only returns `true` when the refcount is 1.
+/// unsafe impl SimpleOwnableRefCounted for Foo {
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
+pub unsafe trait SimpleOwnableRefCounted: RefCounted {
+    /// Checks if exactly one [`ARef`] to the object exists. In case the o=
bject is [`Sync`], the
+    /// check needs to be race-free.
+    fn is_unique(&self) -> bool;
+}
+
+#[cfg_attr(RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]
+// SAFETY: Safe by the requirements on implementation of [`SimpleOwnableRe=
fCounted`].
+unsafe impl<T: SimpleOwnableRefCounted> OwnableRefCounted for T {
+    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>=
> {
+        if T::is_unique(&*this) {
+            // SAFETY: Safe by the requirements on implementation of [`Sim=
pleOwnable`].
+            Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
+        } else {
+            Err(this)
+        }
+    }
+}
+
+#[cfg_attr(RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]
+// SAFETY: Safe by the requirements on implementation of [`SimpleOwnableRe=
fCounted`].
+unsafe impl<T: SimpleOwnableRefCounted> Ownable for T {
+    unsafe fn release(this: NonNull<Self>) {
+        // SAFETY: Safe by the requirements on implementation of
+        // [`SimpleOwnableRefCounted::dec_ref()`].
+        unsafe { RefCounted::dec_ref(this) };
+    }
+}
+
+impl<T: OwnableRefCounted> TryFrom<ARef<T>> for Owned<T> {
+    type Error =3D ARef<T>;
+    /// Tries to convert the [`ARef`] to an [`Owned`] by calling
+    /// [`try_from_shared()`](OwnableRefCounted::try_from_shared). In case=
 the [`ARef`] is not
+    /// unique, it returns again an [`ARef`] to the same underlying object=
.
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




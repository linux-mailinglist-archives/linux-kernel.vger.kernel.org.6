Return-Path: <linux-kernel+bounces-541810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7417BA4C1E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4029A7A7876
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B898212B0B;
	Mon,  3 Mar 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SgnOldzW"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1120D4E9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008593; cv=none; b=Shc2XfZyccu/NOwvr2mavRgqo2saH0Z/4k6Z0TN7+xkJcq5IUtxURyDeh3+WaCag8BQbc2Z1j1Tol+3edQM00nIKlDGWm5LlTqXdZvaTv7R2Cr47vdCMMD4t1oB9dHM7yzZYbjlkAMcKeSb75icZ193uXb3TilE+HGdUj9AMMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008593; c=relaxed/simple;
	bh=NrdJo26KQh3b790DFEqFYieh4I/prfzTjrAwF9mSdfU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCLIvm6a58pra8xL4nyEdGy9oNXzQnhYV5ChkCxnCU5TJ1TiI9hW2RsE2muCkVUxIG+QbXBe57cfTn3BWEkPXD6tgGTKDUr3psnbuzabwPByQxR/eWpYK+loTdnPMlgPZ88/HV6BhrgMTbVHyALrjwsvuT343v7O4kTmL08TFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SgnOldzW; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741008583; x=1741267783;
	bh=/XgtVqY4KDWTqVLe9+6g9N6y0aNNsLDXq9cR3/HS/F0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=SgnOldzWbNKU1yM90pkG8sY/kFq/itD9cML6VFODUyYJpSAavFuQAmy2xGJoHDBQE
	 sjrrZOWJ7JhsHI+iqP97pLuBqnpocejA4+hOswXNpNLXysciHMQ1MAQDDcFfSWCbQD
	 WOzfufi1FnGhWFEA8kaSDitGsgEZmiPr7eh2Md9Ih5IfYhoE3eDGnjLwnBTi6YKfHP
	 PaMP8nkVSHoHYQMYYFfCtW3t6MAHVF0abXDAX4f6Sf8UATv5ORCPC+6DuWUBtX6W38
	 1bfvmMn4eK/Lch+vXbxvf9rncBFli0NyWsY/DP46iKwbc5snfMecg/aEq1DhejhpUN
	 iO1p9NuS55OSw==
Date: Mon, 03 Mar 2025 13:29:36 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8Wuud2UQX6Yukyr@mango>
In-Reply-To: <87frjxncsx.fsf@kernel.org>
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid> <MFrukGViddXfhKeURDySTWCDW6Pk8Oo5keozdVg9hehiS3P4FVHKv4d-Fwn87yprBUeyTHcY6T1k9htIhPzc9Q==@protonmail.internalid> <Z8H6EUy1HqLrzytE@laptop> <87frjxncsx.fsf@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: b04de80b592cf8e8854333dcec18cb6aa8725227
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 5bdbcd54855fed6ad9ae6bcc53dba3aab2c6c6b1 Mon Sep 17 00:00:00 2001
From: Oliver Mangold <oliver.mangold@pm.me>
Date: Fri, 21 Feb 2025 08:36:46 +0100
Subject: [PATCH] rust: adding UniqueRefCounted and UniqueRef types

Add `UniqueRef` as a variant of `ARef` that is guaranteed to be unique.
This is useful when mutable access to the underlying type is required
and we can guarantee uniqueness, and when APIs that would normally take
an `ARef` require uniqueness.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 315 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 315 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 55ddd50e8aaa..7ea0a266caa5 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -543,6 +543,12 @@ fn from(b: &T) -> Self {
     }
 }
=20
+impl<T: UniqueRefCounted> From<UniqueRef<T>> for ARef<T> {
+    fn from(b: UniqueRef<T>) -> Self {
+        UniqueRefCounted::unique_to_shared(b)
+    }
+}
+
 impl<T: AlwaysRefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the =
reference we're about to
@@ -551,6 +557,315 @@ fn drop(&mut self) {
     }
 }
=20
+/// Types that are [`AlwaysRefCounted`] and can be safely converted to an =
[`UniqueRef`]
+///
+/// # Safety
+///
+/// Implementers must ensure that the methods of the trait
+/// change the reference count of the underlying object such that:
+/// - the uniqueness invariant is upheld, i.e. it is not possible
+///   to obtain another reference by any means (other than through the [`U=
niqueRef`])
+///   until the [`UniqueRef`] is dropped or converted to an [`ARef`].
+/// - [`dec_ref()`](UniqueRefCounted::dec_ref) correctly frees the underly=
ing object.
+/// - [`unique_to_shared()`](UniqueRefCounted::unique_to_shared) set the r=
eference count
+///   to the value which the returned [`ARef`] expects for an object with =
a single reference
+///   in existence. This implies that if [`unique_to_shared()`](UniqueRefC=
ounted::unique_to_shared)
+///   is left on the default implementation, which just rewraps the underl=
ying object,
+///   the reference count needs not to be
+///   modified when converting a [`UniqueRef`] to an [`ARef`].
+///
+/// # Examples
+///
+/// A minimal example implementation of [`AlwaysRefCounted`] and
+/// [`UniqueRefCounted`] and their usage
+/// with [`ARef`] and [`UniqueRef`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// use core::cell::Cell;
+/// use core::ptr::NonNull;
+/// use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// use kernel::types::{
+///     ARef, AlwaysRefCounted, UniqueRef, UniqueRefCounted,
+/// };
+///
+/// struct Foo {
+///     refcount: Cell<usize>,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<UniqueRef<Self>, AllocError> {
+///         // Use a KBox to handle the actual allocation
+///         let result =3D KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         // SAFETY: we just allocated the `Foo`, thus it is valid
+///         Ok(unsafe { UniqueRef::from_raw(NonNull::new(KBox::into_raw(re=
sult)).unwrap()) })
+///     }
+/// }
+///
+/// // SAFETY: we increment and decrement correctly and only free the Foo
+/// // when the refcount reaches zero
+/// unsafe impl AlwaysRefCounted for Foo {
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
+/// // SAFETY: we only convert into an `UniqueRef` when the refcount is 1
+/// unsafe impl UniqueRefCounted for Foo {
+///     fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self=
>, ARef<Self>> {
+///         if this.refcount.get() =3D=3D 1 {
+///             // SAFETY: the `Foo` is still alive as the refcount is 1
+///             Ok(unsafe { UniqueRef::from_raw(ARef::into_raw(this)) })
+///         } else {
+///             Err(this)
+///         }
+///     }
+/// }
+///
+/// let foo =3D Foo::new().unwrap();
+/// let mut foo =3D ARef::from(foo);
+/// {
+///     let bar =3D foo.clone();
+///     assert!(UniqueRef::try_from(bar).is_err());
+/// }
+/// assert!(UniqueRef::try_from(foo).is_ok());
+/// ```
+pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
+    /// Checks if the [`ARef`] is unique and convert it
+    /// to an [`UniqueRef`] it that is that case.
+    /// Otherwise it returns again an [`ARef`] to the same
+    /// underlying object.
+    fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self>, A=
Ref<Self>>;
+    /// Converts the [`UniqueRef`] into an [`ARef`].
+    fn unique_to_shared(this: UniqueRef<Self>) -> ARef<Self> {
+        // SAFETY: safe by the conditions on implementing the trait
+        unsafe { ARef::from_raw(UniqueRef::into_raw(this)) }
+    }
+    /// Decrements the reference count on the object when the [`UniqueRef`=
] is dropped.
+    ///
+    /// Frees the object when the count reaches zero.
+    ///
+    /// It defaults to [`AlwaysRefCounted::dec_ref`],
+    /// but overriding it may be useful, e.g. in case of non-standard refc=
ounting
+    /// schemes.
+    ///
+    /// # Safety
+    ///
+    /// The same safety constraints as for [`AlwaysRefCounted::dec_ref`] a=
pply,
+    /// but as the reference is unique, it can be assumed that the functio=
n
+    /// will not be called twice. In case the default implementation is no=
t
+    /// overridden, it has to be ensured that the call to [`AlwaysRefCount=
ed::dec_ref`]
+    /// can be used for an [`UniqueRef`], too.
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: correct by function safety requirements
+        unsafe { AlwaysRefCounted::dec_ref(obj) };
+    }
+}
+
+/// This trait allows to implement [`UniqueRefCounted`] in a simplified wa=
y,
+/// only requiring to provide an [`is_unique()`](SimpleUniqueRefCounted::i=
s_unique) method.
+///
+/// # Safety
+///
+/// - The same safety requirements as for [`UniqueRefCounted`] apply.
+/// - [`is_unique`](SimpleUniqueRefCounted::is_unique) must only return `t=
rue`
+///   in case only one [`ARef`] exists and it is impossible for one to be =
obtained
+///   other than by cloning an existing [`ARef`] or converting an [`Unique=
Ref`] to an [`ARef`].
+/// - It is safe to convert an unique [`ARef`] into an [`UniqueRef`]
+///   simply by re-wrapping the underlying object without modifying the re=
fcount.
+///
+/// # Examples
+///
+/// A minimal example implementation of [`AlwaysRefCounted`] and
+/// [`SimpleUniqueRefCounted`] and their usage
+/// with [`ARef`] and [`UniqueRef`] looks like this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// use core::cell::Cell;
+/// use core::ptr::NonNull;
+/// use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// use kernel::types::{
+///     ARef, AlwaysRefCounted, SimpleUniqueRefCounted, UniqueRef,
+/// };
+///
+/// struct Foo {
+///     refcount: Cell<usize>,
+/// }
+///
+/// impl Foo {
+///     fn new() -> Result<UniqueRef<Self>, AllocError> {
+///         // Use a KBox to handle the actual allocation
+///         let result =3D KBox::new(
+///             Foo {
+///                 refcount: Cell::new(1),
+///             },
+///             flags::GFP_KERNEL,
+///         )?;
+///         // SAFETY: we just allocated the `Foo`, thus it is valid
+///         Ok(unsafe { UniqueRef::from_raw(NonNull::new(KBox::into_raw(re=
sult)).unwrap()) })
+///     }
+/// }
+///
+/// // SAFETY: we just allocated the `Foo`, thus it is valid
+/// unsafe impl AlwaysRefCounted for Foo {
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
+/// // SAFETY: We check the refcount as required. Races are impossible as =
the object is not `Sync`.
+/// unsafe impl SimpleUniqueRefCounted for Foo {
+///     fn is_unique(&self) -> bool {
+///         self.refcount.get() =3D=3D 1
+///     }
+/// }
+///
+/// let foo =3D Foo::new().unwrap();
+/// let mut foo =3D ARef::from(foo);
+/// {
+///     let bar =3D foo.clone();
+///     assert!(UniqueRef::try_from(bar).is_err());
+/// }
+/// assert!(UniqueRef::try_from(foo).is_ok());
+/// ```
+pub unsafe trait SimpleUniqueRefCounted: AlwaysRefCounted + Sized {
+    /// Checks if exactly one [`ARef`] to the object exists.
+    /// In case the object is [`Sync`] the check needs to be race-free.
+    fn is_unique(&self) -> bool;
+}
+
+// SAFETY: safe by the requirements on implementation of `[SimpleUniqueRef=
Counted`]
+unsafe impl<T: SimpleUniqueRefCounted> UniqueRefCounted for T {
+    fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self>, A=
Ref<Self>> {
+        if this.is_unique() {
+            // SAFETY: safe by the requirements on implementation of `[Sim=
pleUniqueRefCounted`]
+            Ok(unsafe { UniqueRef::from_raw(ARef::into_raw(this)) })
+        } else {
+            Err(this)
+        }
+    }
+}
+
+/// An unique, owned reference to an [`AlwaysRefCounted`] object.
+///
+/// It works the same ways as [`ARef`] but ensures that the reference is u=
nique
+/// and thus can be dereferenced mutably.
+///
+/// # Invariants
+///
+/// - The pointer stored in `ptr` is non-null and valid for the lifetime o=
f the [`UniqueRef`]
+///   instance. In particular, the [`UniqueRef`] instance owns an incremen=
t
+///   on the underlying object's reference count.
+/// - No other [`UniqueRef`] or [`ARef`] to the underlying object exist
+///   while the [`UniqueRef`] is live.
+pub struct UniqueRef<T: UniqueRefCounted> {
+    ptr: NonNull<T>,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: It is safe to send `UniqueRef<T>` to another thread
+// when the underlying `T` is `Send` because it effectively means a transf=
er of ownership,
+// equivalently to sending a `Box<T>`.
+unsafe impl<T: UniqueRefCounted + Send> Send for UniqueRef<T> {}
+
+// SAFETY: It is safe to send `&UniqueRef<T>` to another thread when the u=
nderlying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is=
 `Sync`).
+unsafe impl<T: UniqueRefCounted + Sync> Sync for UniqueRef<T> {}
+
+impl<T: UniqueRefCounted> UniqueRef<T> {
+    /// Creates a new instance of [`UniqueRef`].
+    ///
+    /// It takes over an increment of the reference count on the underlyin=
g object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the reference count is set to such a valu=
e
+    /// that a call to [`dec_ref()`](UniqueRefCounted::dec_ref) will relea=
se the underlying object
+    /// in the way which is expected when the last reference is dropped.
+    /// Callers must not use the underlying object anymore --
+    /// it is only safe to do so via the newly created [`UniqueRef`].
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: The safety requirements guarantee that the new insta=
nce now owns the
+        // increment on the refcount.
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+
+    /// Consumes the [`UniqueRef`], returning a raw pointer.
+    ///
+    /// This function does not change the refcount. After calling this fun=
ction, the caller is
+    /// responsible for the refcount previously managed by the [`UniqueRef=
`].
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+}
+
+impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
+    type Target =3D T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: UniqueRefCounted> DerefMut for UniqueRef<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: UniqueRefCounted> TryFrom<ARef<T>> for UniqueRef<T> {
+    type Error =3D ARef<T>;
+    /// Tries to convert the [`ARef`] to an [`UniqueRef`]
+    /// by calling [`try_shared_to_unique()`](UniqueRefCounted::try_shared=
_to_unique).
+    /// In case the [`ARef`] is not unique it returns again an [`ARef`] to=
 the same
+    /// underlying object.
+    fn try_from(b: ARef<T>) -> Result<UniqueRef<T>, Self::Error> {
+        UniqueRefCounted::try_shared_to_unique(b)
+    }
+}
+
+impl<T: UniqueRefCounted> Drop for UniqueRef<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that the [`UniqueRef`] ow=
ns the reference
+        // we're about to decrement.
+        unsafe { UniqueRefCounted::dec_ref(self.ptr) };
+    }
+}
+
 /// A sum type that always holds either a value of type `L` or `R`.
 ///
 /// # Examples
--=20

This should address all issues that have been raised with v2:

- Added a default implementation for unique_to_shared() which does a simple
  rewrap of the underlying object.
- Added a SimpleUniqueRefCounted trait which requires only to implement
  is_unique() as Beno=C3=AEt asked for. Maybe the feature is not worth
  the extra code, though. For me keeping it or removing would be both fine.
- Removed the unsound conversion from &T to UniqueRef, as spotted by Beno=
=C3=AEt.
- Relaxed the requirements for Send and Sync, to be identical to the ones
  for Box. See comment below.
- Added Examples for both UniqueRefCounted and SimpleUniqueRefCounted
  as asked for by Boqun Feng.
  For me they compile and run without errors as KUnits.
- Changed the commit message like suggested by Andreas.

@Beno=C3=AEt: I think you are right about Send and Sync.
What gave me a bit of a headache is if Send really does not require
the underlying object to be Sync, as the refcount itself -
which is part of the object - might be touched concurrently in a case
like with tag_to_req(), but I think one would not implement
something like that without having a synchronized refcount.

Best regards,

Oliver



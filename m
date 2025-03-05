Return-Path: <linux-kernel+bounces-546684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D502BA4FDA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5EB3ACBDF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0B1F416D;
	Wed,  5 Mar 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Wq+Lg65s"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FE1487DD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174318; cv=none; b=LSl4aWcP7UJt2QWcVrLEg9qlAmjKGd7mKPiHNkxN4wm6IRprqueZsVKu2EA+kmGHMaORQx/mflDSa7iB8wBw8QvfA2+ONwqA3YFpjj9W59lyJCS/bJ9wBbRkpWQHSwvvH5Z08DPvM2WWsbH3xWawGjsEPBKAhlsRProDmc8+VEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174318; c=relaxed/simple;
	bh=vCEYt8RKiOT83dhEUAN8HLq6L89EMeh2H5UOWAh8jDg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=k/mllI9GbGZz8p5Ptaxo3w/Zr+tPZve+DaClAN006QFbH3Ex4gBpV1UQqVCHJp//iJRWwhXAD2HnzOJhr1Bu1nK7b5/49LASB9C7ageJfZdGDLfY5reDGZO6/wCqaM/mfPwl3hIuwIBJPPERofUiAnPtOUKsNFf6L2QnyAID6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Wq+Lg65s; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741174313; x=1741433513;
	bh=Xp4tvIIMmSFw0Iure+pEkI3RHw+3oa/nlmkQMD38e+M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Wq+Lg65sCuztT9MleXBA8yMp2F+XyBSnlDEt7odlYVOchizblrwyc1/+Up3vwMJsP
	 Z8TtSZLZI8TZB/J6y2vXeY8CysVsDiVNUShVPelTtYfqwKwK0HLi5JlFQj2F8h73OZ
	 23GVe62iCzlN0L55+ue0/cOntB/dBp4uy/MLYrDcxJT+aU5w/iW7iGJW+NIYflc+U+
	 6gWWLJ/9+zcSX7BlsUsgE+xl9EVzChDERV/6U9dnWIWd5r7gW8usMD+klxYs2GTBJj
	 fPBNw42zKrFYKrlucbxxNETkZGAZWtA83+eIh+/P64EsdZofz8p4KJ9xvX5u1tewwx
	 cRm+wDz/1C5RA==
Date: Wed, 05 Mar 2025 11:31:44 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: f904140da0b74f284a06a2fce8aa2232c3786504
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add `UniqueRef` as a variant of `ARef` that is guaranteed to be unique.
This is useful when mutable access to the underlying type is required
and we can guarantee uniqueness, and when APIs that would normally take
an `ARef` require uniqueness.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
Changes in v4:
- Just a minor change in naming by request from Andreas Hindborg,
  try_shared_to_unique() -> try_from_shared(),
  unique_to_shared() -> into_shared(),
  which is more in line with standard Rust naming conventions.
- Link to v3: https://lore.kernel.org/r/Z8Wuud2UQX6Yukyr@mango
---
 rust/kernel/types.rs | 315 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 315 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 55ddd50e8aaa075ac33d5f1088a7f72df05f74f4..6f8f0b8863ffdac336985fbad60=
882ad0699f0fa 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -543,6 +543,12 @@ fn from(b: &T) -> Self {
     }
 }
=20
+impl<T: UniqueRefCounted> From<UniqueRef<T>> for ARef<T> {
+    fn from(b: UniqueRef<T>) -> Self {
+        UniqueRefCounted::into_shared(b)
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
+/// - [`into_shared()`](UniqueRefCounted::into_shared) set the reference c=
ount
+///   to the value which the returned [`ARef`] expects for an object with =
a single reference
+///   in existence. This implies that if [`into_shared()`](UniqueRefCounte=
d::into_shared)
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
+///     fn try_from_shared(this: ARef<Self>) -> Result<UniqueRef<Self>, AR=
ef<Self>> {
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
+    fn try_from_shared(this: ARef<Self>) -> Result<UniqueRef<Self>, ARef<S=
elf>>;
+    /// Converts the [`UniqueRef`] into an [`ARef`].
+    fn into_shared(this: UniqueRef<Self>) -> ARef<Self> {
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
+    fn try_from_shared(this: ARef<Self>) -> Result<UniqueRef<Self>, ARef<S=
elf>> {
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
+    /// by calling [`try_from_shared()`](UniqueRefCounted::try_from_shared=
).
+    /// In case the [`ARef`] is not unique it returns again an [`ARef`] to=
 the same
+    /// underlying object.
+    fn try_from(b: ARef<T>) -> Result<UniqueRef<T>, Self::Error> {
+        UniqueRefCounted::try_from_shared(b)
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

---
base-commit: 4b2ee22fe32ea9b255926effbb6f26450607c391
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--=20
Oliver Mangold <oliver.mangold@pm.me>




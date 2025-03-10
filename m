Return-Path: <linux-kernel+bounces-553771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD1A58E94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0CC16BF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75721224885;
	Mon, 10 Mar 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Rlh78OEX"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9C224247
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596630; cv=none; b=f7YfMxBtPX+JhYdSSc+ri8rPDAQeGW44A87e1+Pl2nagKe4d4BHv+AG2T9ysJe94CwZMaaGltelllVvexk657JgB7M0MHyfd3WuIIN7aqsyDl4gkss0TaVqIZRZ+9K+UFgtHtNj/jKIYN6n0HNuPXCI8J8zejPBnBHWU2EzAIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596630; c=relaxed/simple;
	bh=TJugW9qRmuA5oYe1TVo0wUzv7Efg6z9e8snaknO8MGs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MB7ozhNaF6OMdGkck3pkIpYToswq5NrnDUkiLK5eWRsZfrYXDiJ3qHFwD8T1C3u2DxWXu5wKreIxRd/Xaccriz/7yO0pIMe1j0Vg0KCJb0+a2fXW6VmmDy2GrVJ+oPkOIfxvtc+COdDmqtpfXIwYNZLDT+LEknVqdEcCGnmdxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Rlh78OEX; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741596626; x=1741855826;
	bh=2lDf8dq/WG7sVxkTl4G1A2xfuBb4q1lzSGrMrbLyXs8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Rlh78OEXweCjqLKga0CZAFG7OH+TOWZIl23nXmxD2m637dEJWQnoNzQNskZvKb/Eb
	 VJDPwQkOIvz26VDhPQGLZ0+u/0uZZui0aiHNYJntS6ffllHiNN2qsnhPa+wCHhxizi
	 ObdUyysF1HzwcSiqV1PzWqgVJQJ3H1OtYynhrqHCk+ilRnvhjm5RIvTUfAHD0d9csa
	 2zY0nRSStBgqOnJstthfUDik7NTIhiG9rKiUaLUeKOJPprkUAVHu85IcTBRSYAluta
	 hrOV0I4sNSylV1m/l/RkhvSJVyH+VwgDu5Cc2k4m/ypSC7SB7DY/45ptXwXzshgHtv
	 jNmFs/6vb6tZw==
Date: Mon, 10 Mar 2025 08:50:18 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v6 5/5] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
Message-ID: <20250310-unique-ref-v6-5-1ff53558617e@pm.me>
In-Reply-To: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 9e5e326aa850c459a871db217c0e085bd092fe9c
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
 rust/kernel/types.rs | 275 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 275 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index e6f3308f931d90718d405443c3034a216388e0af..3e703701b2bccf1a440f4064b6d=
d90afb204d937 100644
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
@@ -669,6 +675,275 @@ fn drop(&mut self) {
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
+/// Implementers must ensure that:
+///
+/// - Both the safety requirements as for [`Ownable`] and [`RefCounted`] a=
re fulfilled.
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
+/// unsafe impl SimpleOwnableRefCounted for Foo {
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
+///
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
+    /// Checks if exactly one [`ARef`] to the object exists. In case the o=
bject is [`Sync`], the
+    /// check needs to be race-free.
+    fn is_unique(&self) -> bool;
+
+    /// Increments the reference count on the object.
+    fn inc_ref(&self);
+
+    /// Decrements the reference count on the object when the [`SimpleOwna=
bleRefCounted`] is
+    /// dropped.
+    ///
+    /// Frees the object when the count reaches zero.
+    ///
+    /// # Safety
+    ///
+    /// The safety constraints for [`RefCounted::dec_ref`] and [`Ownable::=
release`] both apply to
+    /// this method, as it will be used to implement both of these traits.
+    unsafe fn dec_ref(obj: NonNull<Self>);
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
+        unsafe { SimpleOwnableRefCounted::dec_ref(this) };
+    }
+}
+
+#[cfg_attr(RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]
+// SAFETY: Safe by the requirements on implementation of [`SimpleOwnableRe=
fCounted`].
+unsafe impl<T: SimpleOwnableRefCounted> RefCounted for T {
+    fn inc_ref(&self) {
+        SimpleOwnableRefCounted::inc_ref(self);
+    }
+
+    unsafe fn dec_ref(this: NonNull<Self>) {
+        // SAFETY: Safe by the requirements on implementation of
+        // [`SimpleOwnableRefCounted::dec_ref()`].
+        unsafe { SimpleOwnableRefCounted::dec_ref(this) };
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




Return-Path: <linux-kernel+bounces-539112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE6A4A10D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C4B189589C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F9D26B2C8;
	Fri, 28 Feb 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="E7V44dQg"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E941BD9CB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765723; cv=none; b=WwJsAPIpCn1rhidfCAxxMkOrmdEDS19uXFZm9R//gWnmcZAXDcIgW3IHacvU0U0GoEy4EwJK5FhnZCd/DkhBrw7pcb7Tx4Lr8BLfb8wcbrX/msOLzKSVGMJhRLdf9QdQy1x9snj1EB/DamwBGjteQp8VL9i1hdNOMXanv+BQJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765723; c=relaxed/simple;
	bh=tGoVlJytR2bIn3Q801VixJcecBc+oi5+nUp+zhP98yY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oInEujVErgURuLQpMhumE6DL2tEIzawwaowqWou2jgnmEuNU5m4Kt2EOYLzKWApRdk3ZZ1NMmkXKJdqqOaaai6hiAHU2xlnsMoGZWwKm4VXaVknYRyRA8wu7I2P4mkbq8EMVNDJ1HCwFOeJPlYrbBUXk+LmGeeJAohkHkh/0FEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=E7V44dQg; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740765719; x=1741024919;
	bh=p8kz9RZUm+wJ1OhcTmelop5bUBDHgYrfkmvif7oWuIo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=E7V44dQghekfwOIyPnqHCrEVw9Vfy23wlaAoIwBST9uYS0h8rAAJdxNNPrMl7Okv6
	 NHoK6Z74z+agNIlAmq3LvHcnUAGlIwe5QlYLqojvnKgCKkbJ0K1apIHDSskjfPX26O
	 eZM6Tnf+m5/4z8HC7HZ8LWLkpkUweTGFMSpsfX0d9jvTM3il48oGPxKrRDlW6ipqxs
	 Djk/mgnuJPqDv7aKvQyy9S9koZ0uTeMbNJKgX/RdKeXhXeZlApEiatDqd3f5GJlznP
	 OVmLyRsfatYW784UpkxKHQQ9FSFwQ2v39yRU0GRRRf+49P8j5UNdxN8SPjkjWgIXFi
	 yVCUuNFUgWdSw==
Date: Fri, 28 Feb 2025 18:01:55 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8H6EUy1HqLrzytE@laptop>
In-Reply-To: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 42ac763f99b7fabcdb593d9c879036024c36957e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For usage with block-mq, a variant of ARef
which is guaranteed to be unique would be useful.
As chances are it is useful in general, This implements it
as kernel::types::UniqueRef.
The difference between ARef and UniqueRef
is basically the same as between Arc and UniqueArc.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 153 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 55ddd50e8aaa..72a973d9e1c7 100644
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
@@ -551,6 +557,153 @@ fn drop(&mut self) {
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
+/// - [`UniqueRefCounted::dec_ref`] correctly frees the underlying object.
+/// - [`UniqueRefCounted::unique_to_shared`] set the reference count to th=
e value
+/// - that the returned [`ARef`] expects for an object with a single refer=
ence
+///   in existence.
+pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
+    /// Checks if the [`ARef`] is unique and convert it
+    /// to an [`UniqueRef`] it that is that case.
+    /// Otherwise it returns again an [`ARef`] to the same
+    /// underlying object.
+    fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self>, A=
Ref<Self>>;
+    /// Converts the [`UniqueRef`] into an [`ARef`].
+    fn unique_to_shared(this: UniqueRef<Self>) -> ARef<Self>;
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
+/// - No other references to the underlying object exist while the [`Uniqu=
eRef`] is live.
+pub struct UniqueRef<T: UniqueRefCounted> {
+    ptr: NonNull<T>,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: It is safe to send `UniqueRef<T>` to another thread
+// when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`)=
; additionally, it needs
+// `T` to be `Send` because any thread that has an `UniqueRef<T>` may ulti=
mately access `T` using a
+// mutable reference, for example, when the reference count reaches zero a=
nd `T` is dropped.
+unsafe impl<T: UniqueRefCounted + Sync + Send> Send for UniqueRef<T> {}
+
+// SAFETY: It is safe to send `&UniqueRef<T>` to another thread when the u=
nderlying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is=
 `Sync`); additionally,
+// it needs `T` to be `Send` because any thread that has a `&UniqueRef<T>`=
 may clone it and get an
+// `UniqueRef<T>` on that thread, so the thread may ultimately access `T`
+// using a mutable reference, for example, when the reference count reache=
s zero and `T` is dropped.
+unsafe impl<T: UniqueRefCounted + Sync + Send> Sync for UniqueRef<T> {}
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
+    /// that a call to [`UniqueRefCounted::dec_ref`] will release the unde=
rlying object
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
+impl<T: UniqueRefCounted> From<&T> for UniqueRef<T> {
+    /// Converts the [`UniqueRef`] into an [`ARef`]
+    /// by calling [`UniqueRefCounted::unique_to_shared`] on it.
+    fn from(b: &T) -> Self {
+        b.inc_ref();
+        // SAFETY: We just incremented the refcount above.
+        unsafe { Self::from_raw(NonNull::from(b)) }
+    }
+}
+
+impl<T: UniqueRefCounted> TryFrom<ARef<T>> for UniqueRef<T> {
+    type Error =3D ARef<T>;
+    /// Tries to convert the [`ARef`] to an [`UniqueRef`]
+    /// by calling [`UniqueRefCounted::try_shared_to_unique`].
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
2.48.1

Best regards,

Oliver



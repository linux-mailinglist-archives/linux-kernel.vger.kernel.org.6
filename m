Return-Path: <linux-kernel+bounces-525303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F4A3EDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D354188F9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A161FBCAD;
	Fri, 21 Feb 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="emJEO8gl"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636C45009;
	Fri, 21 Feb 2025 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125085; cv=none; b=Ap1W396epa1TntxfXpdj9NAvk+tO8SnjM8oFIrp8RpeVqSy/TUUca5iIWrLVC+Zy8TVPlDZ4Zh3X4wul+4ZXfYBHMLcgriyliOZXGoIK2Av/GKKTaBSusl5yZAGc1dlCgfDaBCgAOhzprx7ifKf/0jiw0/bVAjbyzCsTuSyH3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125085; c=relaxed/simple;
	bh=1jDuaZhpY3OAoCtRoNYbxRb877unFdjhCXXR4q6yBjE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BZP2IlyJcP+BGANZKjETRJHBGmjfV80ktesV3d8iMdq8d5l4tPCDg/B2dJcdvjg2XVZHH8E6UZe5pz0tR5HVe/DfsdehqK6BO1mggx2oUdm/pM19MqpSTu4U0guvvzv6yF1M3opI4fX9IdOGPKMEdCCDWF/DKzgTw+Z09k02YFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=emJEO8gl; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740125081; x=1740384281;
	bh=s4MaT8EpzLOIrBMu7LxBFgCvBxyFVd7XYAuYGPCa9zs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=emJEO8gl2XY7/Afsy2yxXVkH9fJntP+AOZ3QVXnP8d78aUJ5JBdSltkh32ii999Jg
	 HatY4M8FGuNEW795+imQPqTrBU1kLukO6wXJYDy77Z5S2kNCs9II/geTC6xGKhBoSu
	 QS8/2SL76uGmGsbFqcWqu3nrJ1oWGgz/OagjsQ+rFrhhOmhxP9Cfw8OOTiIRBOq9sL
	 wU739bowzsmdOZF2r3dIiGdsLjoUgM9p8b+J6Tz1qYiIqSoVngfAgge/4l6wIpgCUc
	 ocpYk7UMJPOpUMYenRnRL3Vfj+2yVtLEPV8TJysvkTNFH4/ATPC8Bjbs0JcQQli2/A
	 sgnwQ/kX0nw1g==
Date: Fri, 21 Feb 2025 08:04:34 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH] Rust: Implement a unique reference type URef supplementing ARef
Message-ID: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 7a8d7fefe8c1e88d106d46b24ce25bf2360a8609
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For usage with block-mq, we found that having a variant of ARef which is gu=
aranteed to be unique is useful. As chances are it is useful in general, I =
implemented it as kernel::types::URef. The difference between ARef and URef=
 is basically the same as between Arc and UniqueArc.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/block/mq/request.rs | 97 +++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++------------------------------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 55ddd50e8aaa..80dc9edef1b9 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -543,6 +543,12 @@ fn from(b: &T) -> Self {
     }
 }
=20
+impl<T: UniqueRefCounted> From<URef<T>> for ARef<T> {
+    fn from(b: URef<T>) -> Self {
+        UniqueRefCounted::unique_to_shared(b)
+    }
+}
+
 impl<T: AlwaysRefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the =
reference we're about to
@@ -551,6 +557,119 @@ fn drop(&mut self) {
     }
 }
=20
+/// Types that are `AlwaysRefCounted` and can be safely converted to an `U=
Ref`
+///
+pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
+    /// Checks if the the [ARef] is unique and convert it
+    /// to an [URef] it that is that case.
+    /// Otherwise it returns again an [ARef] to the same
+    /// underlying object.
+    fn try_shared_to_unique(this: ARef<Self>) -> Result<URef<Self>,ARef<Se=
lf>>;
+    /// Converts the [URef] into an [ARef].
+    fn unique_to_shared(this: URef<Self>) -> ARef<Self>;
+}
+
+/// An unique owned reference to an always-reference-counted object.
+///
+/// It works the same ways as [`ARef`] but ensures that the reference is u=
nique
+/// and thus can be dereferenced mutably.
+///
+/// # Invariants
+///
+/// The pointer stored in `ptr` is non-null and valid for the lifetime of =
the [`ARef`] instance. In
+/// particular, the [`ARef`] instance owns an increment on the underlying =
object's reference count.
+pub struct URef<T: UniqueRefCounted> {
+    ptr: NonNull<T>,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: It is safe to send `URef<T>` to another thread when the underly=
ing `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`)=
; additionally, it needs
+// `T` to be `Send` because any thread that has an `URef<T>` may ultimatel=
y access `T` using a
+// mutable reference, for example, when the reference count reaches zero a=
nd `T` is dropped.
+unsafe impl<T: UniqueRefCounted + Sync + Send> Send for URef<T> {}
+
+// SAFETY: It is safe to send `&URef<T>` to another thread when the underl=
ying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is=
 `Sync`); additionally,
+// it needs `T` to be `Send` because any thread that has a `&URef<T>` may =
clone it and get an
+// `URef<T>` on that thread, so the thread may ultimately access `T` using=
 a mutable reference, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: UniqueRefCounted + Sync + Send> Sync for URef<T> {}
+
+impl<T: UniqueRefCounted> URef<T> {
+    /// Creates a new instance of [`URef`].
+    ///
+    /// It takes over an increment of the reference count on the underlyin=
g object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the reference count is set to such a valu=
e
+    /// that a call to AlwaysRefCounted::dec_ref() will release the underl=
ying object
+    /// in the way which is expected when the last reference is dropped.
+    /// Callers must not use the underlying object anymore --
+    /// it is only safe to do so via the newly created [`URef`].
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
+    /// Consumes the `URef`, returning a raw pointer.
+    ///
+    /// This function does not change the refcount. After calling this fun=
ction, the caller is
+    /// responsible for the refcount previously managed by the `URef`.
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+}
+
+impl<T: UniqueRefCounted> Deref for URef<T> {
+    type Target =3D T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: UniqueRefCounted> DerefMut for URef<T> {
+
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: UniqueRefCounted> From<&T> for URef<T> {
+    /// Converts the [URef] into an [ARef] by calling [UniqueRefCounted::u=
nique_to_shared] on it.
+    fn from(b: &T) -> Self {
+        b.inc_ref();
+        // SAFETY: We just incremented the refcount above.
+        unsafe { Self::from_raw(NonNull::from(b)) }
+    }
+}
+
+impl<T: UniqueRefCounted> TryFrom<ARef<T>> for URef<T> {
+    type Error =3D ARef<T>;
+    /// Tries to convert the [ARef] to an [URef] by calling [UniqueRefCoun=
ted::try_shared_to_unique].
+    /// In case the [ARef] is not unique it returns again an [ARef] to the=
 same
+    /// underlying object.
+    fn try_from(b: ARef<T>) -> Result<URef<T>,Self::Error> {
+        UniqueRefCounted::try_shared_to_unique(b)
+    }
+}
+
+impl<T: UniqueRefCounted> Drop for URef<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that the `URef` owns the =
reference we're about to
+        // decrement.
+        unsafe { T::dec_ref(self.ptr) };
+    }
+}
+
 /// A sum type that always holds either a value of type `L` or `R`.
 ///
 /// # Examples
---



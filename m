Return-Path: <linux-kernel+bounces-550826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0EA56494
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399E51749D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549B20DD4B;
	Fri,  7 Mar 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="L2Wdp+g8"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CE1C84B5;
	Fri,  7 Mar 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341858; cv=none; b=jrbl6sIL/VZpJXCi+W1ByC38GH3WBiNkfxiVCyiZKrdRBOHel14Kt07az2bRlpD0h+0bsIujilhLmbjLkOLWeoDeekB007WBjWr+qhYMuf/EpJfd/oVglciLj7P4jWXnAabLLYBdfc0V6wPAF39mJ1E3S8cTqOWUkZdyJzMenGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341858; c=relaxed/simple;
	bh=vUYJIpzrPPNsd45VqzFVWUJNCTyAKU0dXIDQudSDGKU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+KbHRlvLW64syfBSxr7w7CDuz4dFsCmYd5SQQOx9+JeM+a0Vy03BlzofGbFaCQCvgXxCtcaC6uSdaRL3Ga7vnBge3bbGLLMYm11tAcadIX0teJVCX+VuuspRsprtK2D6OhkE4h7sJ36iHnwruGpIUl0F6y34TdOFORIz+k3ve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=L2Wdp+g8; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741341853; x=1741601053;
	bh=2Zpu6E3/Y16UltqXkAaLIudQV1ASZITnWKAwSutW1Y8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=L2Wdp+g8AQLlqdlfTxkjFb+QkKuQ8r4HpikKK7oR615X7CAkQCIG0r0+rWJgdawSa
	 iZ2D9DuOgAwiVdg7S3/o2E1o9jMsQPOu4Re5/m6mR7AJWt9gq8QoaLqVUWnGO3Isf9
	 /cMlGga2GqW0AyJG+BElasQN7F2wY9uz2rfzNBCRDAz2TZ7zOrR/MVz7DQwiNqPkNj
	 aSpCFH0OMf+PgH+CtgVdLKeByHLZkvz1EypDSnVRMUMbHUa0vPN1WYSlq0V0miCXFs
	 ISTSEv8rUHEFyHgtS3PBjtrGzNEnCe/dPE0ib4PizNg5Xcb3hjd45bWZ6Nd2cMEWdJ
	 bADZod7BjhJ/Q==
Date: Fri, 07 Mar 2025 10:04:09 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v5 1/4] rust: types: Add Ownable/Owned types
Message-ID: <20250307-unique-ref-v5-1-bffeb633277e@pm.me>
In-Reply-To: <20250307-unique-ref-v5-0-bffeb633277e@pm.me>
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 2fb0fc540ab07853945857e8c687b233bec6e4ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Asahi Lina <lina@asahilina.net>

By analogy to AlwaysRefCounted and ARef, an Ownable type is a (typically
C FFI) type that *may* be owned by Rust, but need not be. Unlike
AlwaysRefCounted, this mechanism expects the reference to be unique
within Rust, and does not allow cloning.

Conceptually, this is similar to a KBox<T>, except that it delegates
resource management to the T instead of using a generic allocator.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/types.rs | 110 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 110 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 55ddd50e8aaa075ac33d5f1088a7f72df05f74f4..0cae5ba6607f0a86d2f0e3494f9=
56f6daad78067 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -551,6 +551,116 @@ fn drop(&mut self) {
     }
 }
=20
+/// Types that may be owned by Rust code or borrowed, but have a lifetime =
managed by C code.
+///
+/// It allows such types to define their own custom destructor function to=
 be called when
+/// a Rust-owned reference is dropped.
+///
+/// This is usually implemented by wrappers to existing structures on the =
C side of the code.
+///
+/// # Safety
+///
+/// Implementers must ensure that any objects borrowed directly as `&T` st=
ay alive for the duration
+/// of the lifetime, and that any objects owned by Rust as `Owned<T>`) sta=
y alive while that owned
+/// reference exists, until the [`Ownable::release()`] trait method is cal=
led.
+pub unsafe trait Ownable {
+    /// Releases the object (frees it or returns it to foreign ownership).
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the object is no longer referenced after =
this call.
+    unsafe fn release(this: NonNull<Self>);
+}
+
+/// A subtrait of Ownable that asserts that an `Owned<T>` Rust reference i=
s not only unique
+/// within Rust and keeps the `T` alive, but also guarantees that the C co=
de follows the
+/// usual mutable reference requirements. That is, the kernel will never m=
utate the
+/// `T` (excluding internal mutability that follows the usual rules) while=
 Rust owns it.
+///
+/// When this type is implemented for an [`Ownable`] type, it allows `Owne=
d<T>` to be
+/// dereferenced into a &mut T.
+///
+/// # Safety
+///
+/// Implementers must ensure that the kernel never mutates the underlying =
type while
+/// Rust owns it.
+pub unsafe trait OwnableMut: Ownable {}
+
+/// An owned reference to an ownable kernel object.
+///
+/// The object is automatically freed or released when an instance of [`Ow=
ned`] is
+/// dropped.
+///
+/// # Invariants
+///
+/// The pointer stored in `ptr` is non-null and valid for the lifetime of =
the [`Owned`] instance.
+pub struct Owned<T: Ownable> {
+    ptr: NonNull<T>,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: It is safe to send `Owned<T>` to another thread when the underl=
ying `T` is `Send` because
+// it effectively means sending a unique `&mut T` pointer (which is safe b=
ecause `T` is `Send`).
+unsafe impl<T: Ownable + Send> Send for Owned<T> {}
+
+// SAFETY: It is safe to send `&Owned<T>` to another thread when the under=
lying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is=
 `Sync`).
+unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
+
+impl<T: Ownable> Owned<T> {
+    /// Creates a new instance of [`Owned`].
+    ///
+    /// It takes over ownership of the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the underlying object is acquired and can=
 be considered owned by
+    /// Rust.
+    pub(crate) unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: The safety requirements guarantee that the new insta=
nce now owns the
+        // reference.
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+
+    /// Consumes the `Owned`, returning a raw pointer.
+    ///
+    /// This function does not actually relinquish ownership of the object=
.
+    /// After calling this function, the caller is responsible for ownersh=
ip previously managed
+    /// by the `Owned`.
+    #[allow(dead_code)]
+    pub(crate) fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+}
+
+impl<T: Ownable> Deref for Owned<T> {
+    type Target =3D T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: Ownable + OwnableMut> DerefMut for Owned<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid,
+        // and that we can safely return a mutable reference to it.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: Ownable> Drop for Owned<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that the `Owned` owns the=
 object we're about to
+        // release.
+        unsafe { T::release(self.ptr) };
+    }
+}
+
 /// A sum type that always holds either a value of type `L` or `R`.
 ///
 /// # Examples

--=20
2.48.1




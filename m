Return-Path: <linux-kernel+bounces-558847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE173A5EC08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1898175B67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF81FC10F;
	Thu, 13 Mar 2025 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="b9nxJkr1"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A041FBE80;
	Thu, 13 Mar 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849215; cv=none; b=a0W/nv9kXbWJvWmTliY0g5XfRakrRfWSBA29Y8c75JulMC5eCE2g5t1iIlXwr09E07BM4uRDfxh99D3bTqrz/SNSNhKJNxTlCoFW7YXndoRohWhOUb3IRtz0NF64hX/mQZRQw2yLb14aVFnlo1InPELuMj9eqcDn4Pgu7b18Blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849215; c=relaxed/simple;
	bh=jnFn2vcB5VWw0rZqsKmCyDWaFtK3hja6aZdpBwbKEy8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0fte6QM/EAUqyXUfvK9jMyxlSiQOI2JzjRYxZKe4lfq42E2dOEdxuYV1bUWaezBwXylZ4TqopcRcxL5mJ1BdCVmukreavGjqKRQvz2KjV2WFDkXKhS8d2A+chP389WH4AuFEOUYgXeZZhUyZH9lgAnoCq4r0lTiNbKw32zsbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=b9nxJkr1; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741849209; x=1742108409;
	bh=4HsT2cKX2K3tPRqJkqJjiIIHXeC79sujqS8iGVYQ9sM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=b9nxJkr13l05aFWMpb3tTCfcYbNT+6fhQTjr4GrlGPy/dGQdO1HyiPX6KrZ0Z9b5x
	 Q4drN5cBwqeLq0MwKhsgu4QOo3fsiy19riACcEbgpotxp690GlNZcT4dbmnR2qlU7/
	 aXZEMRP6lRPWzME9VN2nhYdZ6pMgClG6tRmgKXOYA0HaPbIeecZNYuqTy1yi9BA7qI
	 mjipRadvqfcr9oD/iCgUYmKImp/a0odncDDHW5ctyc1w1Dpjy6p6cuvSAoLjYYQX0E
	 zd7WeCgsgsUAeIhHUJwYNG8zNM2cBUDJEv7C2TwQgozw5tqgP91TRdtT3iWS6fg32y
	 Hs3sZpUzGw7KQ==
Date: Thu, 13 Mar 2025 07:00:04 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v8 1/4] rust: types: Add Ownable/Owned types
Message-ID: <20250313-unique-ref-v8-1-3082ffc67a31@pm.me>
In-Reply-To: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
References: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 6a764f87ee32e6c517908ae92f0b857b918e3080
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

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asah=
ilina.net/
Signed-off-by: Asahi Lina <lina@asahilina.net>
[ om: make from_raw() and into_raw() public, small fixes to documentation ]
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 109 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 109 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 55ddd50e8aaa075ac33d5f1088a7f72df05f74f4..65f6d0721f5f23c8db79c6735dc=
7d5e1ac984ea7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -551,6 +551,115 @@ fn drop(&mut self) {
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
+/// of the lifetime, and that any objects owned by Rust as [`Owned<T>`] st=
ay alive while that owned
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
+/// A subtrait of Ownable that asserts that an [`Owned<T>`] Rust reference=
 is not only unique
+/// within Rust and keeps the `T` alive, but also guarantees that the C co=
de follows the
+/// usual mutable reference requirements. That is, the kernel will never m=
utate the
+/// `T` (excluding internal mutability that follows the usual rules) while=
 Rust owns it.
+///
+/// When this type is implemented for an [`Ownable`] type, it allows [`Own=
ed<T>`] to be
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
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: The safety requirements guarantee that the new insta=
nce now owns the
+        // reference.
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+
+    /// Consumes the [`Owned`], returning a raw pointer.
+    ///
+    /// This function does not actually relinquish ownership of the object=
.
+    /// After calling this function, the caller is responsible for ownersh=
ip previously managed
+    /// by the [`Owned`].
+    pub fn into_raw(me: Self) -> NonNull<T> {
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
+impl<T: OwnableMut> DerefMut for Owned<T> {
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




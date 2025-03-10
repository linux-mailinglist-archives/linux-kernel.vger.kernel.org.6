Return-Path: <linux-kernel+bounces-554044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD4A5921F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41563A3465
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73271DA614;
	Mon, 10 Mar 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="knASrLgj"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90622A1CB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604257; cv=none; b=Eb6XOekuUEI3GsEdeU4vSlc4bkx34wgkn6I997hCH421R7HyYZIcSdIf7xku7NK38Y7LJLceVzWqB3U2OFr9VsPQgSYfHBxhUenMUO8SNLTO/1lEciEMd0AsTr+GFUggp/wXmRo33XgMWUg2m/gSlZ95My4CziaETxAARJPCUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604257; c=relaxed/simple;
	bh=G4g8+U+HLV4Gx1vaKDqvgQtTExOBv2TMnZblyvutss0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gyk27tVfPTgudkjhqENX8/N+5zYPdwVyeSlJvIfoD4IpbRcKjR8+EBM8+ljwnt0lpnJ7XZ/dKU1nYMLXL+RIK4rzK/l+ymDwNcnDcB/agrzxWWqq/z6jxlcctUao4oAmVJd7r9gO0Tsp8Wvx8Hs7mzVQpC135TZ7EBKUeh21uW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=knASrLgj; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741604251; x=1741863451;
	bh=lqhztZytrydlxEcGl7cfjWRcRjfcWBDgUsWbhxkDSEI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=knASrLgj1v8ROp3wXvA26lKrUi+NziM5cDZGRFksM8MQg1BhHL3PblArEbIYWxc/X
	 +06FMgKiDFiW2v93uy/H6ciJ10JruwFguhpSd/8P0g/AD9hr1ROXmEzw8Nkyr33Udn
	 NGyg5+4l7mmiJE6vqgEeiMGo12xIpoQIhrBN9eGNRxkOqsa6ulU5pytq7Sk4+BwSJ6
	 7FnVPwFHb25esTjh89l5rlZtoEPdLliATwGN9ytFyTXmWC2tcpRwcrAgdjT5gavKap
	 1gh+tM8d1t4sNTQkgwENyi87iA0O+WzCHoSb3b92eqLi20GKLxZMCvNTIrvca+kOoP
	 Z8SRQcMBnKfew==
Date: Mon, 10 Mar 2025 10:57:24 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v7 1/4] rust: types: Add Ownable/Owned types
Message-ID: <20250310-unique-ref-v7-1-4caddb78aa05@pm.me>
In-Reply-To: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: dc6aa8198b4e735e3bc33238a886717b525866ae
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
Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 109 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 109 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 55ddd50e8aaa075ac33d5f1088a7f72df05f74f4..e0ce3646a4d3b70c069322a9b0f=
25c00265a2af8 100644
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
+    /// Consumes the `Owned`, returning a raw pointer.
+    ///
+    /// This function does not actually relinquish ownership of the object=
.
+    /// After calling this function, the caller is responsible for ownersh=
ip previously managed
+    /// by the `Owned`.
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




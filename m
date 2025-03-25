Return-Path: <linux-kernel+bounces-575238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C403A6FA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28C816C762
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE1256C94;
	Tue, 25 Mar 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OcZtAOkv"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5C256C82
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903823; cv=none; b=uHay3IYjAdFv0QsryPBS/Zh14mbHiEIi8ChZMBCUErx/mJcEsbZtUh4CBLyytUDprq60xKmsnN8olL3/RyapWG5VlY0MMvQb/vVW5wXLGS6QNJDFOlltNUgeew0HlCFtAQQZGnhhSLsCqrP6YMsMWJO+rvAS3bvaR8c1fxE+Lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903823; c=relaxed/simple;
	bh=KCA2sIAGxHHkgBLyC+jPdzMRzvM7WkLP3HCzEJqfGaM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCb7coWZK58ktgSYXVB0mil2157i9k00jI65aG5v6zphAFW8ZJCFCK6hsfFj6rfDOAfyn+l/dU3KlX3hagNA4m6vV03DRAIRKztXY35xpMxtX7IQWiyaJ3KOiPmfG0Q7bdIrzQH0xgVETemGMOzf8WaMFl+FHd7izZ49Vh/DcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OcZtAOkv; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1742903819; x=1743163019;
	bh=jAchpJYz/gFgXntQllfuI6BSuOQvP9/pEZ9/46jt7AE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OcZtAOkvPvTVbge2cb03RW9gbOpWpxnGCbm8+1Q3I+sRLqVLvvPW4hJoxSv4GNRBT
	 Zf7wfuV9LABRkxeEdNvVshuDDC0EVSlJ086kaZRqaPp7YkNWsIYtoZEAuSbZpYr9mk
	 y3zgLSK834rmgVEAK8FOcZw4u6Urs2OiIEyatsdeBsXM7aUlPRALF9t6zfHufYD+A0
	 gdwPHwy4uhe6bg2qUQ+v3NYezzl7jpGFwwt8dkP1shIUPB4keGNVxphL73f38NbDCZ
	 Lfoxxiq3YZsnqW5wvSLOmympIRWzOkEaAJaKzp9aG2TEgSRPDuGDtAMKoHFEfecTf/
	 PkwuuBfrxXltA==
Date: Tue, 25 Mar 2025 11:56:51 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v9 1/5] rust: types: Add Ownable/Owned types
Message-ID: <20250325-unique-ref-v9-1-e91618c1de26@pm.me>
In-Reply-To: <20250325-unique-ref-v9-0-e91618c1de26@pm.me>
References: <20250325-unique-ref-v9-0-e91618c1de26@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 8225556763920ffca83c7b02e84b7c83bfe74180
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
[ om:
  - split code into separate file and `pub use` it from types.rs
  - make from_raw() and into_raw() public
  - fixes to documentation
]
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/lib.rs     |   1 +
 rust/kernel/ownable.rs | 117 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/types.rs   |   2 +
 3 files changed, 120 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7697c60b2d1a670c436246d422de3b22b1520956..52c294bbf8ded260540e0bc0749=
9257bce91383c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -61,6 +61,7 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+pub mod ownable;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/ownable.rs b/rust/kernel/ownable.rs
new file mode 100644
index 0000000000000000000000000000000000000000..f4bebea23ce1d62f5597e35199c=
a38ea07b293db
--- /dev/null
+++ b/rust/kernel/ownable.rs
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Owned reference types.
+
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::{Deref, DerefMut},
+    ptr::NonNull,
+};
+
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
+/// Implementers must ensure that:
+/// - Any objects owned by Rust as [`Owned<T>`] stay alive while that owne=
d reference exists (i.e.
+///   until the [`release()`](Ownable::release) trait method is called).
+/// - That the C code follows the usual mutable reference requirements. Th=
at is, the kernel will
+///   never mutate the [`Ownable`] (excluding internal mutability that fol=
lows the usual rules)
+///   while Rust owns it.
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
+/// A subtrait of Ownable that asserts that an [`Owned<T>`] or `&mut Owned=
<T>` Rust reference
+/// may be dereferenced into a `&mut T`.
+///
+/// # Safety
+///
+/// Implementers must ensure that access to a `&mut T` is safe, implying t=
hat it is okay to call
+/// [`core::mem::swap`] on the `Ownable`. This excludes pinned types (mean=
ing: most kernel types).
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
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2bbaab83b9d65da667a07e85b3c89c7fa881b53c..2cddbd3a2873b601419f7628c38=
6431a63cb9692 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,6 +11,8 @@
     ptr::NonNull,
 };
=20
+pub use crate::ownable::{Ownable, OwnableMut, Owned};
+
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`=
Self::into_foreign`] and

--=20
2.49.0




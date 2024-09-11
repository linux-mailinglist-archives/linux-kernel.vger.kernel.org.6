Return-Path: <linux-kernel+bounces-325706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE7E975D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52651C20FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA451BB6B8;
	Wed, 11 Sep 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP0oko47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE3149002;
	Wed, 11 Sep 2024 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095306; cv=none; b=q7x8CfLpe6+6fLeMk73LS7JDG3Rg5FFAs3ajnWUuZ/nN1DinOJKsPngOTXy3ZECz1qbpG/Y5Jp4xyUnXaq9+NH+AHijJc1s8AFCXHbRExIGzTdBn2gqhtC8s9RYNHUUhc47SsTF+CldhH7mQwBjcnjEyt33YnMonPoF314jcTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095306; c=relaxed/simple;
	bh=YJ+3Hmuf4lg4RSyjGhOmEDyEN9eOYFpIUvOB6gUqpsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWBoRaJDU/uzcOx2WjDo2fNoxkoXUlVVCmvx5VvqThlCeIyx44Vj8FuUkXVtAqGLqEn1iXiPqbtiU1K9qbcdnyNNEDSWx0I33u/RyVBAjuP2PPytwLMQ/5iz4EkWCTys4k0JtN4fl84ObnAkb6iaj6Xnz3cQIxvVRCcOt+BzzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP0oko47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65187C4CECD;
	Wed, 11 Sep 2024 22:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095306;
	bh=YJ+3Hmuf4lg4RSyjGhOmEDyEN9eOYFpIUvOB6gUqpsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PP0oko47af8i3c5/Hy4kVN84YWSFkT4p5u/bF6oMUDUOZRQfFG0aMXubN+SNpeYQl
	 cctwMTAnRRXh1rDSCnD52PpqzOTQ8w3HGFwhoqSWbCCXY6aeRmN1FhE64VK72pQ2j5
	 ydR9BBdGMz8nUgJnI5R/AVyqMLrm1FRRz3vPpsyXc0byHV2UD41PKjPn/A5YR59pLq
	 JZlF/t+zbfPr1eW0CAOx1/tMzOxJl1uF5rGQM7OdGcNzE19DB/60OCTs4r65NJkf87
	 KT1UlGA/9BV/3iuLjtUoQTHY49o5fI3MBDBfB5Mt+5RXpSYXbJKaq6fMc7wKLgnoAm
	 9dA6oIh6GatmA==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v7 01/26] rust: alloc: add `Allocator` trait
Date: Thu, 12 Sep 2024 00:52:37 +0200
Message-ID: <20240911225449.152928-2-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911225449.152928-1-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel specific `Allocator` trait, that in contrast to the one in
Rust's core library doesn't require unstable features and supports GFP
flags.

Subsequent patches add the following trait implementors: `Kmalloc`,
`Vmalloc` and `KVmalloc`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1966bd407017..6c21bd2edad9 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -86,3 +87,114 @@ pub mod flags {
     /// small allocations.
     pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
 }
+
+/// The kernel's [`Allocator`] trait.
+///
+/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffers described
+/// via [`Layout`].
+///
+/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
+/// an object instance.
+///
+/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
+/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
+/// of `self` parameter.
+///
+/// # Safety
+///
+/// - A memory allocation returned from an allocator must remain valid until it is explicitly freed.
+///
+/// - Any pointer to a valid memory allocation must be valid to be passed to any other [`Allocator`]
+///   function of the same type.
+///
+/// - Implementers must ensure that all trait functions abide by the guarantees documented in the
+///   `# Guarantees` sections.
+//
+// Note that `Allocator::{realloc,free}` don't have an `old_layout` argument (like stdlib's
+// corresponding `Allocator` trait functions have), since the implemented (kernel) allocators
+// neither need nor honor such an argument. Thus, it would be misleading to make this API require it
+// anyways.
+//
+// More generally, this trait isn't intended for implementers to encode a lot of semantics, but
+// rather provide a thin generalization layer for the kernel's allocators.
+//
+// Depending on future requirements, the requirements for this trait may change as well and
+// implementing allocators that need to encode more semantics may become desirable.
+pub unsafe trait Allocator {
+    /// Allocate memory based on `layout` and `flags`.
+    ///
+    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
+    /// constraints (i.e. minimum size and alignment as specified by `layout`).
+    ///
+    /// This function is equivalent to `realloc` when called with `None`.
+    ///
+    /// # Guarantees
+    ///
+    /// When the return value is `Ok(ptr)`, then `ptr` is
+    /// - valid for reads and writes for `layout.size()` bytes, until it is passed to
+    ///   [`Allocator::free`] or [`Allocator::realloc`],
+    /// - aligned to `layout.align()`,
+    ///
+    /// Additionally, `Flags` are honored as documented in
+    /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
+        // new memory allocation.
+        unsafe { Self::realloc(None, layout, flags) }
+    }
+
+    /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
+    ///
+    /// If the requested size is zero, `realloc` behaves equivalent to `free`.
+    ///
+    /// If the requested size is larger than the size of the existing allocation, a successful call
+    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
+    /// may also be larger.
+    ///
+    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
+    /// may not shrink the buffer; this is implementation specific to the allocator.
+    ///
+    /// On allocation failure, the existing buffer, if any, remains valid.
+    ///
+    /// The buffer is represented as `NonNull<[u8]>`.
+    ///
+    /// # Safety
+    ///
+    /// If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation created
+    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
+    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
+    ///
+    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
+    /// created.
+    ///
+    /// # Guarantees
+    ///
+    /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
+    /// it additionally guarantees that:
+    /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
+    ///   and old size,
+    ///   and old size, i.e.
+    ///   `ret_ptr[0..min(layout.size(), old_size)] == p[0..min(layout.size(), old_size)]`, where
+    ///   `old_size` is the size of the allocation that `p` points at.
+    /// - when the return value is `Err(AllocError)`, then `p` is still valid.
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError>;
+
+    /// Free an existing memory allocation.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator` and
+    /// must not be a dangling pointer.
+    ///
+    /// The memory allocation at `ptr` must never again be read from or written to.
+    unsafe fn free(ptr: NonNull<u8>) {
+        // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
+        // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
+        // smaller than or equal to the alignment previously used with this allocation.
+        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
+    }
+}
-- 
2.46.0



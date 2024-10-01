Return-Path: <linux-kernel+bounces-346176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031098C0F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65F4B23B10
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31E1C9EB7;
	Tue,  1 Oct 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx6rOwgd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD527448;
	Tue,  1 Oct 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794822; cv=none; b=ETjD5R0SS7x5lIx50RdlsfxfqvaKK4l4FJsisHE60muAopRHPdGVofFo/5/N1C2txWmMxbUYikgPXdUYCyvcdHM5IooyNN8p3rOuHfpyDBgcj+rN2qvV3C6xRtmoYTtJfILZtH3QRR5lnfzs1N/25a33dhYY1ILGW66Jl6DaRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794822; c=relaxed/simple;
	bh=LFLXrXtZbe/puBmhEZdj7dt2Ld/jyYgOKMUua1Snsrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi1INc+da1iiDDKjFzPxvzE4hcCIsIMTnr76GqIw8a9pnwmyERWNnb3NaiuArtcGMd2pYJyRWxHCNJmh2JlDNX15WzXD9rOEliGCa1oIll7I1nNIAO17Hk4JvXrO3+c06Ymx8UvQhJ2CLi7SVKKaj5Z4bjWbnpIz5EEAJ7/yopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx6rOwgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33311C4CED2;
	Tue,  1 Oct 2024 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794822;
	bh=LFLXrXtZbe/puBmhEZdj7dt2Ld/jyYgOKMUua1Snsrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hx6rOwgdkDdyOk+OI9PzxJNX6LUO2zgzRz35qMibhc3q4YyFPr8Kmn34CMWbb63Ua
	 AT42hkFApCUfTVKZt+yfhrDVTORR9wIhiAxhX1K6zz3dHMTWRLrzNSRdCuKAKiPx5s
	 AqaUT/nGfK8qJP/eshnYf5wQwXaOkFM3GdTp0l0jMLw0FpgYFz+xtHV/7iiC+YVniN
	 iM8ANXoUsH3OEaK12KT5Gvd2kXqTcPl3ETot+dhr0UEoRGafIJtgX33acLod/naref
	 BwluFtf9g7NEsetCGFDUtNQjzcvYiWAeOSGUv/QkXZkpCFwNV24UZ4gZFnPY7BZzpH
	 oCJH8aO/gXHng==
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
Subject: [PATCH v8 01/29] rust: alloc: add `Allocator` trait
Date: Tue,  1 Oct 2024 16:59:36 +0200
Message-ID: <20241001150008.183102-2-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
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
 rust/kernel/alloc.rs | 101 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1966bd407017..4deeea3488be 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -86,3 +87,103 @@ pub mod flags {
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
+        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags) }
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
+    /// - If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation
+    ///   created by this [`Allocator`]; if `old_layout` is zero-sized `p` does not need to be a
+    ///   pointer returned by this [`Allocator`].
+    /// - `ptr` is allowed to be `None`; in this case a new memory allocation is created and
+    ///   `old_layout` is ignored.
+    /// - `old_layout` must match the `Layout` the allocation has been created with.
+    ///
+    /// # Guarantees
+    ///
+    /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
+    /// it additionally guarantees that:
+    /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
+    ///   and old size, i.e. `ret_ptr[0..min(layout.size(), old_layout.size())] ==
+    ///   p[0..min(layout.size(), old_layout.size())]`.
+    /// - when the return value is `Err(AllocError)`, then `ptr` is still valid.
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError>;
+
+    /// Free an existing memory allocation.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` must point to an existing and valid memory allocation created by this [`Allocator`];
+    ///   if `old_layout` is zero-sized `p` does not need to be a pointer returned by this
+    ///   [`Allocator`].
+    /// - `layout` must match the `Layout` the allocation has been created with.
+    /// - The memory allocation at `ptr` must never again be read from or written to.
+    unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
+        // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
+        // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
+        // smaller than or equal to the alignment previously used with this allocation.
+        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), layout, Flags(0)) };
+    }
+}
-- 
2.46.1



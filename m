Return-Path: <linux-kernel+bounces-350668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D919907FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B22F1F224FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A41DEC1A;
	Fri,  4 Oct 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAW1ky8v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CB1CACF4;
	Fri,  4 Oct 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056531; cv=none; b=SkCy397lqIZj923eRNllT5opyqM8kA4n0gryD4PERC7vjsdNYiDszTGD0kroMv8cMKkp1F+zXMdkF8vv5hcCZuD3g0+Og0VsIt1CIhrxm6AMfiF/a1R8X51GaC9L/Lg810S8EOlfpeu+H+7HA1lViREjkInY5MRtu80jvxV5SCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056531; c=relaxed/simple;
	bh=o9fTnK5hDeL2M1Gfsa2jfEjky3P6Jc8p9pXGxlscHLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpNfC2tWMmaFcticknfrm7M1GDqs8Ib/wqI/3xsFHzurep3pWzpLBlBqeYfmJLy4ZwZfx9e3zVg03wBm9dpujCyPcqgpZpkoZyqYR3NHVuMAapp5HYrjdSZbuMOoP1PrwfATFn2cu7EQwXOHfxSn8kUD0MlZd2HS1uIiO6VmsqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAW1ky8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F96C4CECF;
	Fri,  4 Oct 2024 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056530;
	bh=o9fTnK5hDeL2M1Gfsa2jfEjky3P6Jc8p9pXGxlscHLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAW1ky8v40yQnljYx1biN48PIk0ApY4J635Fj6cnMGkG86MNyra/loqlO2s+zH+ge
	 HvnR6t1PEzGwWaD3RYS+E0Z4Ur6dNVxfI0JtDUIkPbXfZnS7l8g35iNhuaoUM0GdbD
	 B/ywyJ5atXiiYow9VJFJCeetohINI3hbGhKZcIt92FBQBSFt2n6bb9W6k6X+ydxD+X
	 k0L4x7kU17neqJDvrAxNE26LuXeI55q02amzcu6HpucIujT7a8BgE/kJbcXbuO7Rhd
	 VufrwlMnPdbR8gnGDIUXl24001WgLhqYUHtiW+KvoHHC2OXo9mL6syokthlkVXz8/n
	 MNZlQVYgzrjXw==
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
Subject: [PATCH v9 01/29] rust: alloc: add `Allocator` trait
Date: Fri,  4 Oct 2024 17:41:05 +0200
Message-ID: <20241004154149.93856-2-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
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



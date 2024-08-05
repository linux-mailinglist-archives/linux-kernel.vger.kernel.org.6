Return-Path: <linux-kernel+bounces-274892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C419947DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07026B2544F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9D16B739;
	Mon,  5 Aug 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/S0kpnJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466D15E5C0;
	Mon,  5 Aug 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871330; cv=none; b=Rq2d5WfiFPcoctweVfhmYAuQoQ1JS32tJyvH/b6mbJLVZe5XwJXIinLT7/1Qffy9ZEbB7j3/vXhlh4G2qokaw+JZB1tsaQbsGsq4umY5dvEQLxseJxmKde0beLsbkQolA8nOcfWmEaC9LiCEmMrKis560NdSS9ArkCvkk2nhDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871330; c=relaxed/simple;
	bh=7OXF+mdH/VtP3EJJlqmokN5UjBwgO5IftFjHmEHegv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MA7uAG48bi54HPY35XWvfzzqq7iUACgK5HXR5/XD06ys4rMditWa5atYVMVMayiKCw/yIBkufBZms5+BBxDrXC5n+Y8NpzfmtPIrBxXw5D97G7TEwrrRgE6WK1T5CMMiVv/03GycOXyxsQLtn7VViIM3OZeoHQaMXCdN6+lAq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/S0kpnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FE0C4AF10;
	Mon,  5 Aug 2024 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871330;
	bh=7OXF+mdH/VtP3EJJlqmokN5UjBwgO5IftFjHmEHegv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/S0kpnJEA53HZxx/ByKgPAnMqA2hpXuuhUkXibFqKo49ZEoH76Oj4hJ8SqrD3aqT
	 ohaViLeqbOK0gaZsi/YhrEPpZXklRe02xuggdqQSFZM7frZqBv26bR1J7bFaq3GfZr
	 kCFuJqcRX6kpxTcvMNk1xoMkNxQpXXosWPQGfg/G4D24VbC0zsc9n3E1NFT6mukVqo
	 TaHwHMYBskm5uZKwmvD4+BhLRnXthAhNxE0EtTCneiAwCmfULUVtNOZQpZ7/OvOZSz
	 hp4bWiQFIIkrm7CnkC811aoijDzacgxc6d8ngbYyU7Kdo4HynY54SZYCf7p2cgxEBy
	 Q1M+GE4r/RV1A==
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
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 21/28] rust: alloc: remove `GlobalAlloc` and `krealloc_aligned`
Date: Mon,  5 Aug 2024 17:19:40 +0200
Message-ID: <20240805152004.5039-22-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have all the `Allocator`s and the kernel `Box` and `Vec`
implementations in place, remove `GlobalAlloc` and `krealloc_aligned`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 63 ++--------------------------------
 1 file changed, 2 insertions(+), 61 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 91ff21372a8f..6abd55694422 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -2,8 +2,8 @@
 
 //! Allocator support.
 
-use super::{flags::*, Flags};
-use core::alloc::{GlobalAlloc, Layout};
+use super::Flags;
+use core::alloc::Layout;
 use core::ptr;
 use core::ptr::NonNull;
 
@@ -40,27 +40,6 @@ fn aligned_size(new_layout: Layout) -> usize {
     layout.size()
 }
 
-/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
-///
-/// # Safety
-///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
-    // SAFETY:
-    // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
-    //   function safety requirement.
-    // - `size` is greater than 0 since it's from `layout.size()` (which cannot be zero according
-    //   to the function safety requirement)
-    unsafe {
-        bindings::krealloc(
-            ptr as *const core::ffi::c_void,
-            aligned_size(new_layout),
-            flags.0,
-        ) as *mut u8
-    }
-}
-
 /// # Invariants
 ///
 /// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
@@ -129,41 +108,6 @@ unsafe fn realloc(
     }
 }
 
-unsafe impl GlobalAlloc for Kmalloc {
-    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL) }
-    }
-
-    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
-        unsafe {
-            bindings::kfree(ptr as *const core::ffi::c_void);
-        }
-    }
-
-    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
-        // SAFETY:
-        // - `new_size`, when rounded up to the nearest multiple of `layout.align()`, will not
-        //   overflow `isize` by the function safety requirement.
-        // - `layout.align()` is a proper alignment (i.e. not zero and must be a power of two).
-        let layout = unsafe { Layout::from_size_align_unchecked(new_size, layout.align()) };
-
-        // SAFETY:
-        // - `ptr` is either null or a pointer allocated by this allocator by the function safety
-        //   requirement.
-        // - the size of `layout` is not zero because `new_size` is not zero by the function safety
-        //   requirement.
-        unsafe { krealloc_aligned(ptr, layout, GFP_KERNEL) }
-    }
-
-    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL | __GFP_ZERO) }
-    }
-}
-
 unsafe impl Allocator for Vmalloc {
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
@@ -204,9 +148,6 @@ unsafe fn realloc(
     }
 }
 
-#[global_allocator]
-static ALLOCATOR: Kmalloc = Kmalloc;
-
 // See <https://github.com/rust-lang/rust/pull/86844>.
 #[no_mangle]
 static __rust_no_alloc_shim_is_unstable: u8 = 0;
-- 
2.45.2



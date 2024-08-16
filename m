Return-Path: <linux-kernel+bounces-288757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E28953E35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92E61C21D26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45012DD90;
	Fri, 16 Aug 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co2Cxo/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE912CDB0;
	Fri, 16 Aug 2024 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767262; cv=none; b=KYyU67UGi/J++BXJ6ZtVwmuJm2Qz3xEpGUJZOon0JToTZjPWBjOmQquksZb/oXkK4CgrgptOEq5nVDJxWZWkW/dVOocX1pEFyeKZKZE7S5V8/BHYRMUNAKsXJIMwq6yV4iVkbPU34aRGBSYn0o4d1+rCfKhhqC6slvkw84DI/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767262; c=relaxed/simple;
	bh=bQS+R7rUpUCrHg7w7Wbs4uih1faovavqPA1dZK4lOE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU/M5Sc5f1IZVJLUwsjQzBaLoqfA/oF4v0pRxYS8sA5xAyQrsvMn+mm/H/3r2YRpo9r0gKw52raJQcqacwWVsNBQv4L2Ir0aP5jO71jKhyCIrG3gpiI2UIdU6z4fWHzZXoWAr0BIc9Jhsz674lgRu9iwZ3eMls4SCppGCXtSHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co2Cxo/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181A4C4AF09;
	Fri, 16 Aug 2024 00:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767261;
	bh=bQS+R7rUpUCrHg7w7Wbs4uih1faovavqPA1dZK4lOE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=co2Cxo/87VbXdBwuqojeKmzm23LO/RIK14f+FTu+LF+rprPRCXT1tDINHnYhyjnCt
	 SMao0AWgVzzXC3OLvkzmIycax/C7a0Me8IzH4XSHoSVYrGzD+0Ly/fgqfy1UB/L4XP
	 yDLZfq7gI55st1vASvGOaQqaHp2mfSwwB2KQU7C4Qu2+qz5DYsQA0054VeSdBfRSdF
	 tOwcSDxZ1RJ9zwxXORqx3C/RBxVpHy9cObcopIwOK4aRSTV13Ggief/V6FpgiMOiFK
	 w1JrC6/279Gd+5vkJED2Rq33iguFOL3+0v7aWmKz0376Sxz9W8WoE7eWYmB2KOY+TK
	 0Ieyst9xxUVeA==
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
Subject: [PATCH v6 22/26] rust: alloc: implement `Cmalloc` in module allocator_test
Date: Fri, 16 Aug 2024 02:11:04 +0200
Message-ID: <20240816001216.26575-23-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far the kernel's `Box` and `Vec` types can't be used by userspace
test cases, since all users of those types (e.g. `CString`) use kernel
allocators for instantiation.

In order to allow userspace test cases to make use of such types as
well, implement the `Cmalloc` allocator within the allocator_test module
and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
allocator uses libc's realloc() function as allocator backend.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator_test.rs | 178 ++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index 1b2642c547ec..7fff308d02dc 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -2,20 +2,184 @@
 
 #![allow(missing_docs)]
 
-use super::{AllocError, Allocator, Flags};
+use super::{flags::*, AllocError, Allocator, Flags};
 use core::alloc::Layout;
+use core::cmp;
+use core::mem;
+use core::ptr;
 use core::ptr::NonNull;
 
-pub struct Kmalloc;
+pub struct Cmalloc;
+pub type Kmalloc = Cmalloc;
 pub type Vmalloc = Kmalloc;
 pub type KVmalloc = Kmalloc;
 
-unsafe impl Allocator for Kmalloc {
+extern "C" {
+    #[link_name = "aligned_alloc"]
+    fn libc_aligned_alloc(align: usize, size: usize) -> *mut core::ffi::c_void;
+
+    #[link_name = "free"]
+    fn libc_free(ptr: *mut core::ffi::c_void);
+}
+
+struct CmallocData {
+    // The actual size as requested through `Cmalloc::alloc` or `Cmalloc::realloc`.
+    size: usize,
+    // The offset from the pointer returned to the caller of `Cmalloc::alloc` or `Cmalloc::realloc`
+    // to the actual base address of the allocation.
+    offset: usize,
+}
+
+impl Cmalloc {
+    /// Adjust the size and alignment such that we can additionally store `CmallocData` right
+    /// before the actual data described by `layout`.
+    ///
+    /// Example:
+    ///
+    /// For `CmallocData` assume an alignment of 8 and a size of 16.
+    /// For `layout` assume and alignment of 16 and a size of 64.
+    ///
+    /// 0                16               32                                               96
+    /// |----------------|----------------|------------------------------------------------|
+    ///        empty         CmallocData                         data
+    ///
+    /// For this example the returned `Layout` has an alignment of 32 and a size of 96.
+    fn layout_adjust(layout: Layout) -> Result<Layout, AllocError> {
+        let layout = layout.pad_to_align();
+
+        // Ensure that `CmallocData` fits into half the alignment. Additionally, this guarantees
+        // that advancing a pointer aligned to `align` by `align / 2` we still satisfy or exceed
+        // the alignment requested through `layout`.
+        let align = cmp::max(
+            layout.align(),
+            mem::size_of::<CmallocData>().next_power_of_two(),
+        ) * 2;
+
+        // Add the additional space required for `CmallocData`.
+        let size = layout.size() + mem::size_of::<CmallocData>();
+
+        Ok(Layout::from_size_align(size, align)
+            .map_err(|_| AllocError)?
+            .pad_to_align())
+    }
+
+    fn alloc_store_data(layout: Layout) -> Result<NonNull<u8>, AllocError> {
+        let requested_size = layout.size();
+
+        let layout = Self::layout_adjust(layout)?;
+        let min_align = layout.align() / 2;
+
+        // SAFETY: Returns either NULL or a pointer to a memory allocation that satisfies or
+        // exceeds the given size and alignment requirements.
+        let raw_ptr = unsafe { libc_aligned_alloc(layout.align(), layout.size()) } as *mut u8;
+
+        let priv_ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+
+        // SAFETY: Advance the pointer by `min_align`. The adjustments from `Self::layout_adjust`
+        // ensure that after this operation the original size and alignment requirements are still
+        // satisfied or exceeded.
+        let ptr = unsafe { priv_ptr.as_ptr().add(min_align) };
+
+        // SAFETY: `min_align` is greater than or equal to the size of `CmallocData`, hence we
+        // don't exceed the allocation boundaries.
+        let data_ptr: *mut CmallocData = unsafe { ptr.sub(mem::size_of::<CmallocData>()) }.cast();
+
+        let data = CmallocData {
+            size: requested_size,
+            offset: min_align,
+        };
+
+        // SAFETY: `data_ptr` is properly aligned and within the allocation boundaries reserved for
+        // `CmallocData`.
+        unsafe { data_ptr.write(data) };
+
+        NonNull::new(ptr).ok_or(AllocError)
+    }
+
+    /// # Safety
+    ///
+    /// `ptr` must have been previously allocated with `Self::alloc_store_data`.
+    unsafe fn data<'a>(ptr: NonNull<u8>) -> &'a CmallocData {
+        // SAFETY: `Self::alloc_store_data` stores the `CmallocData` right before the address
+        // returned to callers of `Self::alloc_store_data`.
+        let data_ptr: *mut CmallocData =
+            unsafe { ptr.as_ptr().sub(mem::size_of::<CmallocData>()) }.cast();
+
+        // SAFETY: The `CmallocData` has been previously stored at this offset with
+        // `Self::alloc_store_data`.
+        unsafe { &*data_ptr }
+    }
+
+    /// # Safety
+    ///
+    /// This function must not be called more than once for the same allocation.
+    ///
+    /// `ptr` must have been previously allocated with `Self::alloc_store_data`.
+    unsafe fn free_read_data(ptr: NonNull<u8>) {
+        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
+        let data = unsafe { Self::data(ptr) };
+
+        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
+        let priv_ptr = unsafe { ptr.as_ptr().sub(data.offset) };
+
+        // SAFETY: `priv_ptr` has previously been allocatored with this `Allocator`.
+        unsafe { libc_free(priv_ptr.cast()) };
+    }
+}
+
+unsafe impl Allocator for Cmalloc {
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        if layout.size() == 0 {
+            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
+        }
+
+        let ptr = Self::alloc_store_data(layout)?;
+
+        if flags.contains(__GFP_ZERO) {
+            // SAFETY: `Self::alloc_store_data` guarantees that `ptr` points to memory of at least
+            // `layout.size()` bytes.
+            unsafe { ptr.as_ptr().write_bytes(0, layout.size()) };
+        }
+
+        Ok(NonNull::slice_from_raw_parts(ptr, layout.size()))
+    }
+
     unsafe fn realloc(
-        _ptr: Option<NonNull<u8>>,
-        _layout: Layout,
-        _flags: Flags,
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        panic!();
+        let src: NonNull<u8> = if let Some(src) = ptr {
+            src.cast()
+        } else {
+            return Self::alloc(layout, flags);
+        };
+
+        if layout.size() == 0 {
+            // SAFETY: `src` has been created by `Self::alloc_store_data`.
+            unsafe { Self::free_read_data(src) };
+
+            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
+        }
+
+        let dst = Self::alloc(layout, flags)?;
+
+        // SAFETY: `src` has been created by `Self::alloc_store_data`.
+        let data = unsafe { Self::data(src) };
+
+        // SAFETY: `src` has previously been allocated with this `Allocator`; `dst` has just been
+        // newly allocated. Copy up to the smaller of both sizes.
+        unsafe {
+            ptr::copy_nonoverlapping(
+                src.as_ptr(),
+                dst.as_ptr().cast(),
+                cmp::min(layout.size(), data.size),
+            )
+        };
+
+        // SAFETY: `src` has been created by `Self::alloc_store_data`.
+        unsafe { Self::free_read_data(src) };
+
+        Ok(dst)
     }
 }
-- 
2.46.0



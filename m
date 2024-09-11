Return-Path: <linux-kernel+bounces-325709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE9975D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CB1C225B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9781BC9FE;
	Wed, 11 Sep 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/+6QwRq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F821BC9F1;
	Wed, 11 Sep 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095322; cv=none; b=MET0s65W3hh8VVmaLUjlsYOTamjYdEg6mH22l9Vp0RM2U28px3qkDdcTYHUNOOboZn2X+tHUtIy1CWNe67lSrRHgau/VWWAbMyntCqncn1vuH+DM9RtJv1KZfF4fknb37h+nGS/5ZQH5f3K5pVGhJVIwYnkq723B3rAehfxXZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095322; c=relaxed/simple;
	bh=lbiLQnErRGDrQbj4pxfkEOD42vZ0I0vTG1uGJ1op8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqK9dAxqdw+qgcIAnxoJRE8a+TrHgxqOScrNxqdonD0QZKbKY9GyM70DQhpxa3AYWw4N7K9U5DNikQOzKYkzoEAoave3D4utG4PbGjatnQtDnnYQGqrSz9Db6lLxHMUZM6fDgD9DKonR/TbppW/ug/t39pJ6OhQvCW3dUQdlpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/+6QwRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E35FC4CEC5;
	Wed, 11 Sep 2024 22:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095322;
	bh=lbiLQnErRGDrQbj4pxfkEOD42vZ0I0vTG1uGJ1op8G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/+6QwRqD1gJeXD0nTRAi39kPwchUeku9kzbofccjkCxU8yKJ5xJQ9NbBWGzIY1J7
	 9bJDgYS9aUM5Kt1EmpIupw1BwMb8FinYpT9XninnRN7iEZEWbNW2TysnpXm+OukEZx
	 ZuZ/IbeVMnIEZXNXgxVoCjP1tM91eAhZrdpDSq0CRNFAv/gKPqJs/6WbtW0xrFEJOs
	 pr8NENuo8oo+1kjNBNQeVnArUGCnEjf4wxB+KRDyGNa17RP0LqHvduThVsdqPJMDLT
	 x9NQtar2HyN8X5z4mqq6zfCPrH6DElkh9WCtMtjG8kcWiEEs/UhfpS/gCeJYmZxwoK
	 Q2wE3EZLWULFA==
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
Subject: [PATCH v7 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Date: Thu, 12 Sep 2024 00:52:40 +0200
Message-ID: <20240911225449.152928-5-dakr@kernel.org>
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

Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
typically used for objects smaller than page size.

All memory allocations made with `Kmalloc` end up in `krealloc()`.

It serves as allocator for the subsequently introduced types `KBox` and
`KVec`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs           |  2 +-
 rust/kernel/alloc/allocator.rs | 89 +++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 6c21bd2edad9..535ed1527034 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -4,7 +4,7 @@
 
 #[cfg(not(test))]
 #[cfg(not(testlib))]
-mod allocator;
+pub mod allocator;
 pub mod box_ext;
 pub mod vec_ext;
 
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e32182f91167..7a93442187a1 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -1,12 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 
 //! Allocator support.
+//!
+//! Documentation for the kernel's memory allocators can found in the "Memory Allocation Guide"
+//! linked below. For instance, this includes the concept of "get free page" (GFP) flags and the
+//! typical application of the different kernel allocators.
+//!
+//! Reference: <https://docs.kernel.org/core-api/memory-allocation.html>
 
 use super::{flags::*, Flags};
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
+use core::ptr::NonNull;
 
-struct Kmalloc;
+use crate::alloc::{AllocError, Allocator};
+use crate::bindings;
+
+/// The contiguous kernel allocator.
+///
+/// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
+/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, which is hardware specific.
+///
+/// For more details see [self].
+pub struct Kmalloc;
 
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
@@ -36,6 +52,77 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
 }
 
+/// # Invariants
+///
+/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
+struct ReallocFunc(
+    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
+);
+
+impl ReallocFunc {
+    // INVARIANT: `krealloc` satisfies the type invariants.
+    const KREALLOC: Self = Self(bindings::krealloc);
+
+    /// # Safety
+    ///
+    /// This method has the same safety requirements as [`Allocator::realloc`].
+    ///
+    /// # Guarantees
+    ///
+    /// This method has the same guarantees as `Allocator::realloc`. Additionally
+    /// - it accepts any pointer to a valid memory allocation allocated by this function.
+    /// - memory allocated by this function remains valid until it is passed to this function.
+    unsafe fn call(
+        &self,
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let size = aligned_size(layout);
+        let ptr = match ptr {
+            Some(ptr) => ptr.as_ptr(),
+            None => ptr::null(),
+        };
+
+        // SAFETY:
+        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus only requires that
+        //   `ptr` is NULL or valid.
+        // - `ptr` is either NULL or valid by the safety requirements of this function.
+        //
+        // GUARANTEE:
+        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.
+        // - Those functions provide the guarantees of this function.
+        let raw_ptr = unsafe {
+            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
+            self.0(ptr.cast(), size, flags.0).cast()
+        };
+
+        let ptr = if size == 0 {
+            NonNull::dangling()
+        } else {
+            NonNull::new(raw_ptr).ok_or(AllocError)?
+        };
+
+        Ok(NonNull::slice_from_raw_parts(ptr, size))
+    }
+}
+
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for Kmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
+        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
+    }
+}
+
 unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-- 
2.46.0



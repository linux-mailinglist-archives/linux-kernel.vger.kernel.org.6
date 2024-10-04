Return-Path: <linux-kernel+bounces-350671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D79907FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B031F22C77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A811E075B;
	Fri,  4 Oct 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVUR/08O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CA1DF845;
	Fri,  4 Oct 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056548; cv=none; b=Y/KUDW2xkk5gadx9BnVLjskO5MJGELGAhyGDt/Nxlykp8inwDwNhhC0C42NzuxbS6FbWtlFSiC2WVnGYW/GFxAjO9EXV4Bjd85xnbP/hiczOGAVOSkt5KpI0q4um0+HWdSlUb/KS7Iy2wy9nvTVmPLnAAaWHtC36XpaL7ly4SWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056548; c=relaxed/simple;
	bh=FjNpQ7WplEuJvZRXB9OKv92SNKAtpq7ActsyiT3/uto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQwg+Z0zFpeeDMPoHSrE3vZkuIRdFf5yKpVe23c66KDvf1mryFDcaLjlHT+5RH9/raHAPYw2afmtM1Hmz2isGGlsyrisVENafgt5+ZVcfuYmkKDqDJJe9WE3bBWVKA11F3kB4ZY8+4g+0nqH5lHU8HBLBLshaE+t9bTQsvm7S50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVUR/08O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F86C4CEC7;
	Fri,  4 Oct 2024 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056547;
	bh=FjNpQ7WplEuJvZRXB9OKv92SNKAtpq7ActsyiT3/uto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVUR/08O9+E1CNbbgPERgJT5Kwjss1sEY4YsIYtAHtUWpluZl24F8r65XdahkgBbQ
	 KqsJ+pcUshMVHutDmTwYlUonLQLcUfNl0AiCnazXFGf5qr5JpfCGDIwiJ6KsyGztRX
	 iQ3m3d/gWQT517HOJkSJcM4RfkInPGO+pW6mf3AjXK49jOp5beuavcWBoODmsUgU34
	 0PGUzUgE+v+RuLOz6Fk71tEy5IFx3IW1U+B6bVzWR6AjgLdjB9HMIuHFI+1N1mTxYn
	 LQgA3F8cbXRDpAqi9uZyXziN5ChX3v8E2XeIQS2IbA78gm/hlC+0097YdthT8KcV56
	 rpe/FpWijamSA==
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
Subject: [PATCH v9 04/29] rust: alloc: implement `ReallocFunc`
Date: Fri,  4 Oct 2024 17:41:08 +0200
Message-ID: <20241004154149.93856-5-dakr@kernel.org>
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

`ReallocFunc` is an abstraction for the kernel's realloc derivates, such
as `krealloc`, `vrealloc` and `kvrealloc`.

All of the named functions share the same function signature and
implement the same semantics. The `ReallocFunc` abstractions provides a
generalized wrapper around those, to trivialize the implementation of
`Kmalloc`, `Vmalloc` and `KVmalloc` in subsequent patches.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs           |  8 ++++
 rust/kernel/alloc/allocator.rs | 70 ++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 4deeea3488be..da49c5306431 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -187,3 +187,11 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
         let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), layout, Flags(0)) };
     }
 }
+
+/// Returns a properly aligned dangling pointer from the given `layout`.
+pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
+    let ptr = layout.align() as *mut u8;
+
+    // SAFETY: `layout.align()` (and hence `ptr`) is guaranteed to be non-zero.
+    unsafe { NonNull::new_unchecked(ptr) }
+}
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 3b1c735ba409..e5bac90046a4 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -1,10 +1,20 @@
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
+
+use crate::alloc::AllocError;
+use crate::bindings;
 
 struct Kmalloc;
 
@@ -36,6 +46,66 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
 }
 
+/// # Invariants
+///
+/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
+struct ReallocFunc(
+    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
+);
+
+#[expect(dead_code)]
+impl ReallocFunc {
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
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let size = aligned_size(layout);
+        let ptr = match ptr {
+            Some(ptr) => {
+                if old_layout.size() == 0 {
+                    ptr::null()
+                } else {
+                    ptr.as_ptr()
+                }
+            }
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
+            crate::alloc::dangling_from_layout(layout)
+        } else {
+            NonNull::new(raw_ptr).ok_or(AllocError)?
+        };
+
+        Ok(NonNull::slice_from_raw_parts(ptr, size))
+    }
+}
+
 // SAFETY: TODO.
 unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-- 
2.46.1



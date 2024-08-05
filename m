Return-Path: <linux-kernel+bounces-274873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C635E947DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026231C21E54
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879715B57F;
	Mon,  5 Aug 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMxxVbqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22ED15B54F;
	Mon,  5 Aug 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871236; cv=none; b=Si6M6gZPx+LKcPyifliRkZxOxFU57w1nhM5lzfa5Wy5sMnAEdxL1PnkgfY1TaQYo/87IdPWnx6tGvkORJrUtKw+4VvNS2NqDYJJJOlmrEHHZV1uRNmM+sDBT1JbxGBldKUeoz2RmjiztKhHx3ECMgJ+nqGLDXwy99jODxxCPR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871236; c=relaxed/simple;
	bh=KUN3egAY7JyTXEWIOlIzv3zwwD5pg50NL+IK/lAWQ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOcUEyJ8JQOIw8/F1GviuZj5wBSc7GdzduN6PTBpu721HuVeUwZgcAC9bEDlRo5v/HhVYTHP1nOan5uHGDUka7hTVTw7h6zbDAYiJcxUNTMj0yfR2iWiuCnfp4rUpiuMlJw0Qgwmo/hqegpUumku6SlOHBYDmbL68wp7Wtpuw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMxxVbqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697CAC32782;
	Mon,  5 Aug 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871235;
	bh=KUN3egAY7JyTXEWIOlIzv3zwwD5pg50NL+IK/lAWQ2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMxxVbqZsYS6nje0qCRhq8ZjYYic641hDJRMsjp6Pa5Ba7wKckgxEzzaVkWT4c7E4
	 tY9hyufAZRqbEWsqp+jP1c0nJdb4JIGFs6/3mKu6g0HwA3prX2eDxZWIHeieyQ7zkw
	 msTYgDTMoxrHx9Kfdysi8sOAVZmA8GbTMIvk/Gatky1A38ZHuV4WLGPyEQIChmxeM/
	 sdjY4dYgVjDkpONE5ArmejxyhKkv7F8zgYza4kcdEJpyQzUSNLaPCoiPAFpq2MqJK4
	 s5qsHODvwWTrJn3dJcGxBsVJWuLDQ9HO9Ln6kp/S5ofY9gnIuFimqfJCsRSx9VFpSO
	 V4zwpKrFBpwrA==
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
Subject: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Date: Mon,  5 Aug 2024 17:19:23 +0200
Message-ID: <20240805152004.5039-5-dakr@kernel.org>
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

Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
typically used for objects smaller than page size.

All memory allocations made with `Kmalloc` end up in `krealloc()`.

It serves as allocator for the subsequently introduced types `KBox` and
`KVec`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                 |  3 +-
 rust/kernel/alloc.rs           |  2 +-
 rust/kernel/alloc/allocator.rs | 68 +++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 92d3c03ae1bd..9f7275493365 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -193,8 +193,7 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
 
-void * __must_check __realloc_size(2)
-rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
+void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 {
 	return krealloc(objp, new_size, flags);
 }
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 8a71a589469d..bc01a17df5e0 100644
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
index 2c1eae25da84..c6ad1dd59dd0 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -5,8 +5,16 @@
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
+/// The contiguous kernel allocator only ever allocates physically contiguous memory through
+/// `bindings::krealloc`.
+pub struct Kmalloc;
 
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
@@ -40,6 +48,64 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     }
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
+    fn krealloc() -> Self {
+        Self(bindings::krealloc)
+    }
+
+    /// # Safety
+    ///
+    /// This method has the exact same safety requirements as `Allocator::realloc`.
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
+        // SAFETY: `ptr` is valid by the safety requirements of this function.
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
+unsafe impl Allocator for Kmalloc {
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let realloc = ReallocFunc::krealloc();
+
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { realloc.call(ptr, layout, flags) }
+    }
+}
+
 unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-- 
2.45.2



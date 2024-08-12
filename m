Return-Path: <linux-kernel+bounces-283588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2CD94F69F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC831F239D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EABB193072;
	Mon, 12 Aug 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax0ovfo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF2192B89;
	Mon, 12 Aug 2024 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487070; cv=none; b=ohtu7BL4R2ZyXn3w5nll4ZHO0wIqi/79pCqLXOIvb3ynovnigI18hO00SIv+1VgSstWZuhxzHk8XzQZLiWodxFpjCm4vdsxZZ9u+OcgSdcx5oThV3Q9StbkaHGpxXT1PZ1DJSVQQWW25Y0nCQKUIHCL6WaiaRZC1+DGkzT2Szkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487070; c=relaxed/simple;
	bh=gb9gRmfntU6sLvTnzwOy0nZzExJzcMuzdJXh+XZXxrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecQdvdPl8fUi1+5Dc0TBvit+uwWUg4Q+g8sZCdb7QoDexB+d5dCT3Sd8Ure6KyAbkPxmwz+4U4uCDEZEgmO7dP46ymfrHV+rgL8O2EfefOJDZtgrb1YsaOYD3ZwTSlJab7vgLmAyaRNzrsnOeTaw+NiKhMVoRyVzmkyPVECp4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax0ovfo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61ADC4AF09;
	Mon, 12 Aug 2024 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487069;
	bh=gb9gRmfntU6sLvTnzwOy0nZzExJzcMuzdJXh+XZXxrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ax0ovfo+JPuw2LDf+OJPpzMSsXQE9YksuOJXuCo+WmnrW8NlGUwys0w3f+ygfqrio
	 28tnbwcxAKYNJidKiK73kPcgYOc6OCZK1i6y2SxKcgsiDpu8N1EYsTOhK4wawo2hLx
	 7GCa3TWWOFDAZVPaF+qPrr9g3pcy8XO77lCAchTLje0bB8y2vjHl8+wlBQ7ev3qVsU
	 5+46tl5L6he6oy/hfmoF53lwjEIN5lkT7hJHA0CUNtw/edL+OwQ7p+0rhTSM9Io9Av
	 v+Fr10KAWwevX78GGFCLCpub/wgqkPU0baB6gUAY0fL3TZH2iMpz0J+I3zivupq8N1
	 OdkMYTzQx2l7Q==
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
Subject: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Date: Mon, 12 Aug 2024 20:22:50 +0200
Message-ID: <20240812182355.11641-5-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
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
 rust/kernel/alloc/allocator.rs | 63 +++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 4 deletions(-)

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
index 194745498a75..b732720cfb95 100644
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
index e32182f91167..b46883d87715 100644
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
@@ -36,6 +44,59 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
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
+    /// This method has the same safety requirements as `Allocator::realloc`.
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
+        // SAFETY: `ptr` is either NULL or valid by the safety requirements of this function.
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
+        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
+        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
+    }
+}
+
 unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-- 
2.45.2



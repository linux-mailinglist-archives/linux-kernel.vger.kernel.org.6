Return-Path: <linux-kernel+bounces-274875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CAF947DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020B21C213EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956E15D5B3;
	Mon,  5 Aug 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXd667Z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE915C15A;
	Mon,  5 Aug 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871246; cv=none; b=BFe9J6lHY+bhnuEQxO3ZgHdELLT5Xu3aNVYeJdUQfwc/XEboFJuBDO2TRjNfZEFPC3NMuZ+esdNzIhtI69CL7Wbn2mgOa6znBORGDWeXL24QIV3LpQgHg0XVJKEYhPi2ZT3wqN04qnI+4izSSTrdc+NVUGl3Ulho4+Kiin2q82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871246; c=relaxed/simple;
	bh=pL/2tk9r+RNw9Wnwj5An+62HaTNk3XqGiHLSI686pwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt8RWpgad/oemVRgMO1TpZVo3C5tjMEMIB5rcuIBJUnoummGd5SS1ybT0viBctw3V1vh4rjeTqMIrS2z7Z5mKvLWiup/MXKjpyx5eu7uWFLq4IUM0kj4RLU3sdZ4Nyat+mHxelq8qxDdezp1W48Gif6d0rR5EtV0TsA2r/VnNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXd667Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8143FC4AF10;
	Mon,  5 Aug 2024 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871246;
	bh=pL/2tk9r+RNw9Wnwj5An+62HaTNk3XqGiHLSI686pwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXd667Z+v76rsJOSJiwugYw609RU4d6zvS4IpyxU3I92MkwzAqckdCues4v2T1H3A
	 vkNdhCTwWgRMUDvgFaBOa4CrrpzOesoJFqdWJ6s5Ur+j1mSjOVvnC6CHSRNSy02wF8
	 1vz1ux3aD2y8DiGsV6Qy6v9tyQP7p4fpsN4M8C4TPWzqAxiQ5Ghaigs4Ib6+QGFBDY
	 HwBY/mF2ukc7pbEUUFvR6HJnpCx4dqW2N7+r/MBeru8bfevLcarBnon3YJlxnqLRVo
	 OFkXc6ZGL7uSiXg29DTUz8afCaANoREEuu2D9NqxQ8XEIYAb8hSoHDax9s9v8CgShz
	 wB6sBGnyImjxg==
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
Subject: [PATCH v4 06/28] rust: alloc: implement `Vmalloc` allocator
Date: Mon,  5 Aug 2024 17:19:25 +0200
Message-ID: <20240805152004.5039-7-dakr@kernel.org>
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

Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
allocator, typically used for larger objects, (much) larger than page
size.

All memory allocations made with `Vmalloc` end up in `vrealloc()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  7 +++++++
 rust/kernel/alloc/allocator.rs      | 32 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 40 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 9f7275493365..7406943f887d 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -33,6 +33,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/vmalloc.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
@@ -199,6 +200,12 @@ void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
+void *rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return vrealloc(p, size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index c6ad1dd59dd0..bb55895cbd03 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -9,6 +9,7 @@
 
 use crate::alloc::{AllocError, Allocator};
 use crate::bindings;
+use crate::pr_warn;
 
 /// The contiguous kernel allocator.
 ///
@@ -16,6 +17,12 @@
 /// `bindings::krealloc`.
 pub struct Kmalloc;
 
+/// The virtually contiguous kernel allocator.
+///
+/// The vmalloc allocator allocates pages from the page level allocator and maps them into the
+/// contiguous kernel virtual space.
+pub struct Vmalloc;
+
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -61,6 +68,11 @@ fn krealloc() -> Self {
         Self(bindings::krealloc)
     }
 
+    // INVARIANT: `vrealloc` satisfies the type invariants.
+    fn vrealloc() -> Self {
+        Self(bindings::vrealloc)
+    }
+
     /// # Safety
     ///
     /// This method has the exact same safety requirements as `Allocator::realloc`.
@@ -141,6 +153,26 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
     }
 }
 
+unsafe impl Allocator for Vmalloc {
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let realloc = ReallocFunc::vrealloc();
+
+        // TODO: Support alignments larger than PAGE_SIZE.
+        if layout.align() > bindings::PAGE_SIZE {
+            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
+            return Err(AllocError);
+        }
+
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { realloc.call(ptr, layout, flags) }
+    }
+}
+
 #[global_allocator]
 static ALLOCATOR: Kmalloc = Kmalloc;
 
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index 4785efc474a7..e7bf2982f68f 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -7,6 +7,7 @@
 use core::ptr::NonNull;
 
 pub struct Kmalloc;
+pub type Vmalloc = Kmalloc;
 
 unsafe impl Allocator for Kmalloc {
     unsafe fn realloc(
-- 
2.45.2



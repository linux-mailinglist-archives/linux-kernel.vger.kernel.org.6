Return-Path: <linux-kernel+bounces-288741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2216F953E23
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3692823C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA535321D;
	Fri, 16 Aug 2024 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivbEzzrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC586257B;
	Fri, 16 Aug 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767177; cv=none; b=rAGex1CmgwkDpSE23FYesQ+HqK45qcDOdWmQheUI2D690ZYL8LON/OGLuVLSCbopdxzUqHim3W7XyFUQ+j3kkVbzj4tqPW+b0ce0vFWscrGVCyHBjXcA/nMG0JjvPfL+p08Z4BZsB8lXDpOHB168M2V1QOu+llCnhNaWnZbOxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767177; c=relaxed/simple;
	bh=hX4ulOq19dU7ZAikDhvlf8QJavajKpr4Y1F7LrLQguk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlz+qcBt+EwvVraTTY+UBADrI8brNa8tJMXZqiD0TsE4oOccG+IbMJsa+WtymNt+Ah7iu1Xp0c8btzZedB3hcfNzATAe/8n+DnMzvIqByw2RpYDvng2al8mYOSii7UqqiH+t9HrG7CJSofnMF3Jjct1Fcz/1nmWT+NbHMpMP914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivbEzzrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F230AC32786;
	Fri, 16 Aug 2024 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767176;
	bh=hX4ulOq19dU7ZAikDhvlf8QJavajKpr4Y1F7LrLQguk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivbEzzrL5ZD6557M5uq0jSgcjAt5wWYtmCbIQ9K7oSjxLS807foNstdYN4j+jMGpP
	 lSwcGuFd6VKoIx0D3B/gSvm3oc582Z6pZRPv+S80DVcnUvzIlmM4YKWx39BMgSzj6D
	 dMOLVSiWZJBF3w2cu5cgWBghkp8xwFSWkr0HKatrCBRK+S20NXI8Y6ovt29z/BYZhx
	 /ZgS/fANOeqkwB8g+kl175jYA+jQf8rGp5C0G1/4w3805JTs39UyDfPmK2t28nPuFV
	 UVutHfCih2dJpohwcLfc/JOYLznPNMIJvo7XMk60wrDDhIsPGogxBLJ3n8D0wpaXTA
	 s4ye2rlW5fzYw==
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
Subject: [PATCH v6 06/26] rust: alloc: implement `Vmalloc` allocator
Date: Fri, 16 Aug 2024 02:10:48 +0200
Message-ID: <20240816001216.26575-7-dakr@kernel.org>
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

Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
allocator, typically used for larger objects, (much) larger than page
size.

All memory allocations made with `Vmalloc` end up in `vrealloc()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  8 ++++++++
 rust/kernel/alloc/allocator.rs      | 32 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 41 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 41df5b1a6de6..96f8b37a668b 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -36,6 +36,7 @@
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/vmalloc.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
@@ -248,6 +249,13 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
+void * __must_check __realloc_size(2)
+rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return vrealloc(p, size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
+
 void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
 			      struct rb_node **rb_link)
 {
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 78e7d5488843..09a322e9168d 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -15,6 +15,7 @@
 
 use crate::alloc::{AllocError, Allocator};
 use crate::bindings;
+use crate::pr_warn;
 
 /// The contiguous kernel allocator.
 ///
@@ -24,6 +25,15 @@
 /// For more details see [self].
 pub struct Kmalloc;
 
+/// The virtually contiguous kernel allocator.
+///
+/// `Vmalloc` allocates pages from the page level allocator and maps them into the contiguous kernel
+/// virtual space. It is typically used for large allocations. The memory allocated with this
+/// allocator is not physically contiguous.
+///
+/// For more details see [self].
+pub struct Vmalloc;
+
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -63,6 +73,9 @@ impl ReallocFunc {
     // INVARIANT: `krealloc` satisfies the type invariants.
     const KREALLOC: Self = Self(bindings::krealloc);
 
+    // INVARIANT: `vrealloc` satisfies the type invariants.
+    const VREALLOC: Self = Self(bindings::vrealloc);
+
     /// # Safety
     ///
     /// This method has the same safety requirements as [`Allocator::realloc`].
@@ -141,6 +154,25 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
     }
 }
 
+unsafe impl Allocator for Vmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // TODO: Support alignments larger than PAGE_SIZE.
+        if layout.align() > bindings::PAGE_SIZE {
+            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
+            return Err(AllocError);
+        }
+
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, flags) }
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
2.46.0



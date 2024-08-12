Return-Path: <linux-kernel+bounces-283590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869894F6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D915DB22803
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56A1953BD;
	Mon, 12 Aug 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFvp3rUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9D194C73;
	Mon, 12 Aug 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487080; cv=none; b=c6CAXRcmwuO1ktwmneYQOY1X3SZRlWygDWAQhJVOrg+aCfXLTZEg7lARXnzSIRhtO/XnfR7Iwb/CYdauLINyuOMBKOgSJUi0IaYlPzJ9KdMBH3Hgh3GeXnxSjDVwI9zqTHmLTYo5hWCIDChZKnjpi6fdoLbDzd5I4SQip8XuQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487080; c=relaxed/simple;
	bh=h5pfzEktHmh1N0L77l+cZ8kzDdEbRgd13sQHut0w7XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfcR/hNTouGmEFCwE64tBsHxDRnRBMGTQLCPpmdFLtUaRwQHf8TtuoPyL3Td3N3AajKl1BA21m4AN9oU5JGO5/Z0Q7xvpE7/MbSTGaXW9kZilEJF4/PGHFDYZhqXSJAeC1ngp2aWZ7a7dH6/4ktu5o9cOWQ0qgbw3sLMTek8fMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFvp3rUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975EFC4AF0F;
	Mon, 12 Aug 2024 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487080;
	bh=h5pfzEktHmh1N0L77l+cZ8kzDdEbRgd13sQHut0w7XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFvp3rUVlsJ+UIxsUGlMKE8VTsD2Aq8HQxJ6wXype4vyAHL2JtkK3mOcnqC2DvnGf
	 RmFkZ/Axmc1yYu1S60+J355btuuhvCl8k6va48DkEb1AE+kv7+2ACKRPMVx/RA1Grm
	 8ju+i4zFpn3C6CpUsSopqqg9VC2Kra0gRKGL1W4dTZsSFnQcsgfnAGX3XZd6bP7Y1Q
	 XOhWkTqlAKYoyI90KBpS3koeohXNoO4UW7OLvdIrC0VU1eFvFuJRTaJnyUP/w1XMaZ
	 +Zcszs4mggLiSYZhQUaYYRApDVKuKQNFVkwynM6kBwM8NIb1v+WthEPX/Jcg0D/T4v
	 rZ4s5Ccnx/0jw==
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
Subject: [PATCH v5 06/26] rust: alloc: implement `Vmalloc` allocator
Date: Mon, 12 Aug 2024 20:22:52 +0200
Message-ID: <20240812182355.11641-7-dakr@kernel.org>
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

Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
allocator, typically used for larger objects, (much) larger than page
size.

All memory allocations made with `Vmalloc` end up in `vrealloc()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  7 +++++++
 rust/kernel/alloc/allocator.rs      | 28 ++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 36 insertions(+)

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
index b46883d87715..fdda22c6983f 100644
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
@@ -55,6 +62,9 @@ impl ReallocFunc {
     // INVARIANT: `krealloc` satisfies the type invariants.
     const KREALLOC: Self = Self(bindings::krealloc);
 
+    // INVARIANT: `vrealloc` satisfies the type invariants.
+    const VREALLOC: Self = Self(bindings::vrealloc);
+
     /// # Safety
     ///
     /// This method has the same safety requirements as `Allocator::realloc`.
@@ -132,6 +142,24 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
     }
 }
 
+unsafe impl Allocator for Vmalloc {
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
2.45.2



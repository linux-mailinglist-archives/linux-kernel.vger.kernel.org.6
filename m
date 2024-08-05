Return-Path: <linux-kernel+bounces-274876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31E947DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC69D1C21332
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD015E5D6;
	Mon,  5 Aug 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJAyHZFL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CF15E5BD;
	Mon,  5 Aug 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871252; cv=none; b=UaAiwqNnHZ0jMTjy4WCImnr/7L57xLRP9st4z4XbWMkwOOJUbXbEg6W7AZEmLTpcmSuTj9f4QkrpJWReZVjGhxPkfVhouIXVkmqIiDofLmzo8Q+T/V5DhUdexnPAYEq8bJMFw41V+7WnwyI8M7A3YxXrAJ6TKHLbv6uIYVqdZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871252; c=relaxed/simple;
	bh=4X9wSdLX4mWoeYIrAd5wlz1K/X7N03r6vTnYVQGkAO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HexsrV6JQSldxAXoy64AUaQw8iWFYtyyt5fHD+BIhsBe92WEtosxATNjKLxv1/xAdCPncfyizuOXX19gGruL20dygvFNY3onAv/eW+w3Z8cZStehf0BCawcWCxyCh1V+QowZTv/WBgHYmlL9uFCsJ/wwRs/HrPb86qiQTKX0QAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJAyHZFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13970C4AF0B;
	Mon,  5 Aug 2024 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871252;
	bh=4X9wSdLX4mWoeYIrAd5wlz1K/X7N03r6vTnYVQGkAO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJAyHZFLBa7Fe6Up0rMI4tOEodUpG6ICWZsYB2kS9icTwHsv0wtG66ktGFCoOjyxY
	 pXCRPWZeor7R6vBE9LRo5MJNRiM4BLH8xXJI0PIBnIyvPd/YHQmtjyKZ9m/jKa8bTL
	 VZd48fllVOFNugpuOyQOJWmnk7hjLZQPVN0ha/0JFtJrb6oF/A0kXmCcBG17FIZtWn
	 1xTk0MDC4qqfztXrPzUFAVOzBguUtCZHmg1pKUEEQCZqyIslqywKAbJ2MBEq+2ZAFG
	 ZKjqokDjnAsjTlUD/6tbLaa5ffRzlKIlpoxxiV/EsMBdEOW2q5N3RO8OhT02M4Fvay
	 jHkfPN2IYfWaQ==
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
Subject: [PATCH v4 07/28] rust: alloc: implement `KVmalloc` allocator
Date: Mon,  5 Aug 2024 17:19:26 +0200
Message-ID: <20240805152004.5039-8-dakr@kernel.org>
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

Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
allocate memory wth `kmalloc` first and, on failure, falls back to
`vmalloc`.

All memory allocations made with `KVmalloc` end up in
`kvrealloc_noprof()`; all frees in `kvfree()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  6 ++++++
 rust/kernel/alloc/allocator.rs      | 31 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 38 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 7406943f887d..3285a85765ff 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -206,6 +206,12 @@ void *rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
 
+void *rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return kvrealloc(p, size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kvrealloc);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index bb55895cbd03..91ff21372a8f 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -23,6 +23,12 @@
 /// contiguous kernel virtual space.
 pub struct Vmalloc;
 
+/// The kvmalloc kernel allocator.
+///
+/// Attempt to allocate physically contiguous memory, but upon failure, fall back to non-contiguous
+/// (vmalloc) allocation.
+pub struct KVmalloc;
+
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -73,6 +79,11 @@ fn vrealloc() -> Self {
         Self(bindings::vrealloc)
     }
 
+    // INVARIANT: `vrealloc` satisfies the type invariants.
+    fn kvrealloc() -> Self {
+        Self(bindings::kvrealloc)
+    }
+
     /// # Safety
     ///
     /// This method has the exact same safety requirements as `Allocator::realloc`.
@@ -173,6 +184,26 @@ unsafe fn realloc(
     }
 }
 
+unsafe impl Allocator for KVmalloc {
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let realloc = ReallocFunc::kvrealloc();
+
+        // TODO: Support alignments larger than PAGE_SIZE.
+        if layout.align() > bindings::PAGE_SIZE {
+            pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
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
index e7bf2982f68f..1b2642c547ec 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -8,6 +8,7 @@
 
 pub struct Kmalloc;
 pub type Vmalloc = Kmalloc;
+pub type KVmalloc = Kmalloc;
 
 unsafe impl Allocator for Kmalloc {
     unsafe fn realloc(
-- 
2.45.2



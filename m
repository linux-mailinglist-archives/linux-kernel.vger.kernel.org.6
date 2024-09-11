Return-Path: <linux-kernel+bounces-325712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9F975D72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6945B1F235D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE11BD032;
	Wed, 11 Sep 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh382Oa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11071A3047;
	Wed, 11 Sep 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095338; cv=none; b=Yr40C07Bew9OK9sUgl09mAvpt+IEUs2TMHK8OwA42t2LZX1uCz9W7O6sftQcnHRHtSlVyOW05xBR2OeZBgaO6EMCMVBYRCHH0tesUGYqN3xATSDwbTR4XZQQSP9WG0YzYqlCjO10FeC6CySsN6IYX1zWkQ55ygta63i90ITGvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095338; c=relaxed/simple;
	bh=7ud9iFBT5EcUDGEvKd041Y+gvEKEu7RxRlS2eA0UCRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSi1pUX/QrcNjeauKfe6Ag6m+Q9/v8kidULDAGMfXEI0LxYUMwdphc7vhM+QOnuf5WdLlJSJBL1N0b2Y6CmEVQCUQDOaIpxqdh2gD3seoSk6qlAVxkXfXVpU23UUHC2yRE0oi/fpOkDyLdRspEcq2sXhEevaL/6KCEpaXbezVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh382Oa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1C7C4CEC5;
	Wed, 11 Sep 2024 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095338;
	bh=7ud9iFBT5EcUDGEvKd041Y+gvEKEu7RxRlS2eA0UCRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sh382Oa/l5uE2UTx21wKubJ27EmXt/WljM5TDLCvic0zWfZUvcq0zujcO0gwtq8UN
	 frSY8H4qkNT32280yR8hCKXi+tJGkeGY5mHW8l5aOYU7V8gfphjJJ6SzFh3O7D/j4d
	 UEgK+aCBsDu+hr6gEL8aTYlWF8nBFRgQaAsgPEnw2kJaHBgWUB+fyqREO+OOM0I+jY
	 mV50Hr2ANdJESRoToUkBIfUIggcAVBckovKxkAdC4hTFOLLzCn75rA54hGe/eF7wxp
	 H6JsuRM16TZWPBhgK0nnGbrkA087+fbnAGT9hNcDPE2UU1L7Y3IY/+sfiWnwIIUTdx
	 86+gU0pe6L42g==
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
Subject: [PATCH v7 07/26] rust: alloc: implement `KVmalloc` allocator
Date: Thu, 12 Sep 2024 00:52:43 +0200
Message-ID: <20240911225449.152928-8-dakr@kernel.org>
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

Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
allocate memory wth `kmalloc` first and, on failure, falls back to
`vmalloc`.

All memory allocations made with `KVmalloc` end up in
`kvrealloc_noprof()`; all frees in `kvfree()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/slab.c                 |  6 +++++
 rust/kernel/alloc/allocator.rs      | 35 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 42 insertions(+)

diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
index f043e087f9d6..a842bfbddcba 100644
--- a/rust/helpers/slab.c
+++ b/rust/helpers/slab.c
@@ -7,3 +7,9 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 {
 	return krealloc(objp, new_size, flags);
 }
+
+void * __must_check __realloc_size(2)
+rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return kvrealloc(p, size, flags);
+}
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 0f2bc702e8e4..a5d7e66a68db 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -34,6 +34,15 @@
 /// For more details see [self].
 pub struct Vmalloc;
 
+/// The kvmalloc kernel allocator.
+///
+/// `KVmalloc` attempts to allocate memory with `Kmalloc` first, but falls back to `Vmalloc` upon
+/// failure. This allocator is typically used when the size for the requested allocation is not
+/// known and may exceed the capabilities of `Kmalloc`.
+///
+/// For more details see [self].
+pub struct KVmalloc;
+
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -76,6 +85,9 @@ impl ReallocFunc {
     // INVARIANT: `vrealloc` satisfies the type invariants.
     const VREALLOC: Self = Self(bindings::vrealloc);
 
+    // INVARIANT: `kvrealloc` satisfies the type invariants.
+    const KVREALLOC: Self = Self(bindings::kvrealloc);
+
     /// # Safety
     ///
     /// This method has the same safety requirements as [`Allocator::realloc`].
@@ -194,6 +206,29 @@ unsafe fn realloc(
     }
 }
 
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for KVmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // TODO: Support alignments larger than PAGE_SIZE.
+        if layout.align() > bindings::PAGE_SIZE {
+            pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
+            return Err(AllocError);
+        }
+
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, flags) }
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
2.46.0



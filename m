Return-Path: <linux-kernel+bounces-288742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326F953E24
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BB4B26D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220B3BB30;
	Fri, 16 Aug 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQZzPoe9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513262BB0D;
	Fri, 16 Aug 2024 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767182; cv=none; b=bE2bynoyQZ8thL+vn8LzFY2ET6qn75++LBEKawYLdWKeIox3QW4rXLSgyXCG7dhB7kFViGRSl5E0ZP76sfBXn9GHa5JSk+rSRQ1XOw+jGExD/7kYktJaUo9HjEeQXMP4qlGyDmBR5v54EBjQ3C2Il2K50MVN7Nel2+OUGc8sovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767182; c=relaxed/simple;
	bh=aTI9CEsgYyrzlstHqemFJKjddMy0vpbtXP30W2anE+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3YQjYGYd7NkbYBgzufcbWZ/3m0diVADVYLu2PcI2MAECIxzH4mVdv83nqRsjzTDNYrxAyd7owFd7ycJaSsb/YorVhdI1YT4YnbgfunwKumhpxnfsUehkiat/0Mpuo9t6HY7aLFQXxQB6CQ7k5unIhiDwiVIM2qelPwnqYfVLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQZzPoe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C41C32786;
	Fri, 16 Aug 2024 00:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767182;
	bh=aTI9CEsgYyrzlstHqemFJKjddMy0vpbtXP30W2anE+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQZzPoe97D+j/WBU1u+3YngiwpWqgLo/aAIXWVe+iB8QGj1vygnofidHkGK6NnMD7
	 BVS4b9/lkbFii1pXNCEfa8Z2jbz2iaRVZvV1KOdGF2uhpj906RfBaFhIoF2IV14pPP
	 tE2k4VDoEtGSx4xwS5O+8O7H7ScuoGirsRIyNoVp7mqmymOEOQ2TCA244+StOBxnau
	 lkbE7M70hQtDF/cOKYr3eVKg+5KAa1lSq9yRbRQMO0kIItZHqYJ8eEMfxmw9FONO42
	 4xIdX1eEodyTFZ/kkx9/L/EExQ19aqDlS+3hqOFnUB2C73KrT/RUqrxLLWGunTmEGi
	 utML9JoiTM+dQ==
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
Subject: [PATCH v6 07/26] rust: alloc: implement `KVmalloc` allocator
Date: Fri, 16 Aug 2024 02:10:49 +0200
Message-ID: <20240816001216.26575-8-dakr@kernel.org>
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

Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
allocate memory wth `kmalloc` first and, on failure, falls back to
`vmalloc`.

All memory allocations made with `KVmalloc` end up in
`kvrealloc_noprof()`; all frees in `kvfree()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  7 +++++++
 rust/kernel/alloc/allocator.rs      | 31 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 39 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 96f8b37a668b..9a7604e3a749 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -256,6 +256,13 @@ rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
 
+void * __must_check __realloc_size(2)
+rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return kvrealloc(p, size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kvrealloc);
+
 void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
 			      struct rb_node **rb_link)
 {
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 09a322e9168d..0183fbac1ada 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -34,6 +34,15 @@
 /// For more details see [self].
 pub struct Vmalloc;
 
+/// The kvmalloc kernel allocator.
+///
+/// `KVmalloc` attempts to allocate memory with `Kmalloc` first, but falls back to `Vmalloc` upon
+/// failure. This allocator is typically used when the size for the requsted allocation is not
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
@@ -173,6 +185,25 @@ unsafe fn realloc(
     }
 }
 
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



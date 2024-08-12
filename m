Return-Path: <linux-kernel+bounces-283591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38BC94F6A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD03283D22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814C198858;
	Mon, 12 Aug 2024 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2PRrRzm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A5197A6E;
	Mon, 12 Aug 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487086; cv=none; b=BLfnXBSQtBJ7LFe7n5j5zn/AItAxHPG2bYxhMbhiWd7EUa+MKFGpqSBZ6tQ2RqBKRo9nU6fqYXQozfDwKiL11aPoKS79E1XRXEescLK1/E/YiKdMEoAqjwSumPjiZW/PSlx8e+tE3ik6dUtxSgSqW7U29zqqKlCOqa7tXU88/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487086; c=relaxed/simple;
	bh=ITHOVb+qmodDUzbraOhMnm/IPfqxkdSYWt9L0/6UUHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFoVUrnS/6fJFr4UK2EedIpkgtf/ZYDkdnLsVKvvLY37ygWcBsEE4lYdW5TFnpySIVRgyJBq+Dp48IpclfOi5XGr1G/Bcj9AJlEsU7LAy9l4qLdTP1zdlR+hwA9VXjScgNKNyp6ZD9TfYwMsnvR3CDVtSDo4AbxB4BC9jdJlzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2PRrRzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB5C4AF0C;
	Mon, 12 Aug 2024 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487085;
	bh=ITHOVb+qmodDUzbraOhMnm/IPfqxkdSYWt9L0/6UUHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2PRrRzm+sxi6h0mbRIbj3sVO7A7/Rs9qf3CP6nSz1dh8f0SNA64zrjrpVVLruHlQ
	 3BFVUU3jvJcUVpqzGx4jNLWpDl+hSQupHUBTsfko5zSpxspOjFOgtOUUF6QLp4Eu2R
	 P2Jwf3jgK2PvwPhtagm2rdrcySOoF9SrhGJL6HMf4A9loJ4iyl2lfIaFtfpx7L7asW
	 tBaeenOsbRAjdWleNZtLtRAzjqOFlzIb6Hq34YSFJ6Ol265wgDMcjQOv+/pj/DQ+nK
	 RVxXOrl8/btgq+is4+yhBy3Pohr5grqiaqeVr6zRrI98GAQel/Rdo/n6yQDvwAgyEi
	 vs0Zb3VCnxxqQ==
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
Subject: [PATCH v5 07/26] rust: alloc: implement `KVmalloc` allocator
Date: Mon, 12 Aug 2024 20:22:53 +0200
Message-ID: <20240812182355.11641-8-dakr@kernel.org>
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

Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
allocate memory wth `kmalloc` first and, on failure, falls back to
`vmalloc`.

All memory allocations made with `KVmalloc` end up in
`kvrealloc_noprof()`; all frees in `kvfree()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  6 ++++++
 rust/kernel/alloc/allocator.rs      | 27 +++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 34 insertions(+)

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
index fdda22c6983f..243d8c49a57b 100644
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
@@ -65,6 +71,9 @@ impl ReallocFunc {
     // INVARIANT: `vrealloc` satisfies the type invariants.
     const VREALLOC: Self = Self(bindings::vrealloc);
 
+    // INVARIANT: `kvrealloc` satisfies the type invariants.
+    const KVREALLOC: Self = Self(bindings::kvrealloc);
+
     /// # Safety
     ///
     /// This method has the same safety requirements as `Allocator::realloc`.
@@ -160,6 +169,24 @@ unsafe fn realloc(
     }
 }
 
+unsafe impl Allocator for KVmalloc {
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
2.45.2



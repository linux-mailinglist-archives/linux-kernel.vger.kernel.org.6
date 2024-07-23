Return-Path: <linux-kernel+bounces-260279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD8793A54F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485E1B232E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2D15A84E;
	Tue, 23 Jul 2024 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0fy4oHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AB158A37;
	Tue, 23 Jul 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758292; cv=none; b=HvAVv5ZZrGCHPUjWYrn2goqdK4rUxaGI5VM0eAvHipOXa5AUZXIVfWOqT/Vws9877WIwBu7ixsImm0ZKSS2WpmcsrR3LyTM2zl/SQ6l+a1qevo57rQYqAn6Z983o9/YeIYV9+noduAyogT9ZgZCEd0qqiZp5YJbh6XF+PFoQvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758292; c=relaxed/simple;
	bh=VoSgcZBnVOwLP7rZy/xS0BTIj35SmIvHWDRctFLWgt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsZhtdqXvTdvj545xeCLpA5qdD2L5rjL46YzmqNG5lXxAjqQswpXfjKmntlPniPxRDRckB3IMfwey+U0dzMBVY4YuusVXvPAzC22/5hgieyhUzPXSaQUzejowIS7jd4eR6UsgfNZZgUKIc+Or0pdjzarrz8YE9aKdSeEM5Oa+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0fy4oHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E755C4AF09;
	Tue, 23 Jul 2024 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758292;
	bh=VoSgcZBnVOwLP7rZy/xS0BTIj35SmIvHWDRctFLWgt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0fy4oHgiIxm8fq1X97zoBznf3/NVarogrH+h0ecVwl2+FDYFNOUrCCy0ZNOG3Jm0
	 adQ50MkRsjoHOEd+Oc5uFHJbeibMZYhLLVzoVHjQD25QlzgVmqhoZkDozm+er2h1Pf
	 7q8u9sl1Bkhpo/f2FPlzT0E6H1kdmmhQQN9/yEevF+Z6pu97nY9WgN4drWO/N8wkRH
	 Owu/UB9CgoG4HYoAfjgEMhUAl8uEkBtoBGlPL9NZwcBJ1gZsAqASGeeFsNxkoyk/KV
	 8cR5UTpSHU1s+WRfjTz6fAp3R5Pf/bE8F7tvuYMOu6vKAFuoLWE83As6FHoGyF8fus
	 oo9UN0/r3MqtA==
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
Subject: [PATCH v2 07/23] rust: alloc: implement `KVmalloc` allocator
Date: Tue, 23 Jul 2024 20:09:56 +0200
Message-ID: <20240723181024.21168-8-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723181024.21168-1-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  7 +++++++
 rust/kernel/alloc/allocator.rs      | 24 ++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 32 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 5ca7e4872ee8..19a5e4a0c7ee 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -173,6 +173,13 @@ rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
 
+void * __must_check __realloc_size(2)
+rust_helper_kvrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return kvrealloc(p, size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kvrealloc);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e9a3d0694f41..1e53f149db96 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -22,6 +22,12 @@
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
@@ -68,6 +74,10 @@ fn vrealloc() -> Self {
         Self(bindings::vrealloc)
     }
 
+    fn kvrealloc() -> Self {
+        Self(bindings::kvrealloc)
+    }
+
     // SAFETY: `call` has the exact same safety requirements as `Allocator::realloc`.
     unsafe fn call(
         &self,
@@ -160,6 +170,20 @@ unsafe fn realloc(
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
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { realloc.call(ptr, layout, flags) }
+    }
+}
+
 #[global_allocator]
 static ALLOCATOR: Kmalloc = Kmalloc;
 
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index b2d7db492ba6..f0e96016b196 100644
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



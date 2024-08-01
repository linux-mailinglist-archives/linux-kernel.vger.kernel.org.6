Return-Path: <linux-kernel+bounces-270013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A8D9439F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17D81F21053
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992413699B;
	Thu,  1 Aug 2024 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o21YFXJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2841339B1;
	Thu,  1 Aug 2024 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470851; cv=none; b=CEA4A/wqNnwuMYGa4aR8rewYMx8cl3kriOjilZOxO7/HnxRz4Bl1F5FUJHZb0YNwrt8TtBxJBwWAaWVhqDOhD9tSLmhnHWZoaVTPtpFkzX+wrvMUgB2FKNecGYsS2YyHqcuvd4CtVaYIGrQL15wo4nkNQo//YlMgvSKoxJEmDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470851; c=relaxed/simple;
	bh=vpuQqVGdruui4OBsLFoLlveSHdy3R+nqUtK2TdTuy/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk0x5s7C3wWnQ5MQ2k+Ng1OiEfiUhvwGsRP9BLFVPyZQ8UwSuuGvDCoSCleQiZ9MiW3bFnpRnThtQbboy5g3tSpqx4hA94wcqHE+xT5HXXZvaDM5c2Gndc/I86LxlGvXv0rXiNpPdwkujXfvyqJxPK9apD+iAgMcNqq7UbXs46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o21YFXJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D3C4AF0C;
	Thu,  1 Aug 2024 00:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470850;
	bh=vpuQqVGdruui4OBsLFoLlveSHdy3R+nqUtK2TdTuy/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o21YFXJiH68ZpPo4iNUPdphpPPYfsKEMZCBCPzYfh/vAR0GDVtj+LZXIeMANyxArZ
	 DYmzdHQYBRD/8fWd0BDotHVm7vBfvinT+cAleKi4RuY1WeTjiypprJp8xXL3X7hvC1
	 wYKQbfVhD0UBCMKzN63FlFziuaYEFp0jtmFStkbopTbpLaMJ5wym9m8dp2rErXd9B8
	 RWelDLz8llXjECN6gmrbJyaIlQYkO7UPZt4XOMvFuzbu6IZsoyuzfq2yBO7rcbQ7US
	 m2Nd22NIm9TLiDaj+/MGiESojJ1k2/+xGn77288VwrVUKIYRdcS9Yqo1070D8C5Ymt
	 5RgT0hTUW7mDA==
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
Subject: [PATCH v3 07/25] rust: alloc: implement `KVmalloc` allocator
Date: Thu,  1 Aug 2024 02:02:06 +0200
Message-ID: <20240801000641.1882-8-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
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
index 4c628986f0c9..4ad7dc347523 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -208,6 +208,13 @@ rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
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



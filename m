Return-Path: <linux-kernel+bounces-350676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E6990804
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C651F22F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A5721C16D;
	Fri,  4 Oct 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKjQ8ZPm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB901C75E7;
	Fri,  4 Oct 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056574; cv=none; b=DxfaTyZTmHU80+yYH9OXFBnn15pTNMoypr/6G6h60guO/e1cFUKKdGg/RRJ9h5Q51Uxfs6dF80vK7BI9416QS8EcRhUwJ7MHmw1FP52hOwou8w9sIcuQtzp5LUIUTuX+1E1ST9+DwAz7Sx3HQAltuklWFxqTDx/r1ABmwVYfMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056574; c=relaxed/simple;
	bh=bmN7ni692A736mVNYrpUELQFpNi/F1V47sEOIzb2Zxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRBP0LamQjWnWZ04bW+wnEQMU3robQLRkB5d8E5a7EB6kWATQ7xCwhbNhtU6NSr05xE2xHft5vVDbq+B2GnhFDYp9tidW85epsHrtGFKgFhhvtFNh/Yem7mUjnE75h5BrDlTp1NmJhaqvmCfBYCZclR+Iv9zPlG7aBgxZOq++TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKjQ8ZPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD91C4CEC7;
	Fri,  4 Oct 2024 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056574;
	bh=bmN7ni692A736mVNYrpUELQFpNi/F1V47sEOIzb2Zxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKjQ8ZPmnVtLHqr4nor207d5+lle0HUgclARf5EncF5XP8/iOOzpJ08rCz3Zf3K/q
	 K+XtuJ8Un3vl+Adb3MVI6prusot2SL+Z/UwzTKQLoqlt68BtrM+123fOkwQXTrMhjH
	 89pD77I6HL94tZs/5aC52cRVLNRIILom+coxCtCDk1R+Aa19I135JJNEoC1pJr39Ar
	 jOyml3k76DlaNKTwO6U9mfO1p/9EVrZug5sZopte54z/yzrBOhwDmvAnReyaZ8g4K/
	 VepMZe3eyDzdjg5iHBnqXzIHbrRBxVCc7ia98DqMjjvONZjKWXFbGZjnCfAsNdrKVh
	 f/C5KfKLN6ySQ==
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
Subject: [PATCH v9 09/29] rust: alloc: implement `KVmalloc` allocator
Date: Fri,  4 Oct 2024 17:41:13 +0200
Message-ID: <20241004154149.93856-10-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/slab.c                 |  6 +++++
 rust/kernel/alloc/allocator.rs      | 36 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 43 insertions(+)

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
index 5742ce7d0453..d9043ca42ce5 100644
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
@@ -205,6 +217,30 @@ unsafe fn realloc(
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
+        old_layout: Layout,
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
+        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
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
2.46.1



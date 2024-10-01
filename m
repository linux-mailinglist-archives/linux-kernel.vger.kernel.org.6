Return-Path: <linux-kernel+bounces-346184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADC98C0FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CC5287B61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A51CC14A;
	Tue,  1 Oct 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEC2PB2q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133ED1CB307;
	Tue,  1 Oct 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794860; cv=none; b=C+1CCslMpfw1G5oUboJ8gTsRA4FKn5WQJy0CYZbreRBeOBHdg4LRJN61FguyFqZaOVb+NNbR/kQjOxgc/xArLmVdVu9rxBvupQVrZydkPRDSHyCfr+rxXw7rgTeMB2KH+OwmwIxk/dNPDa7tp6LEO223c+d7naAtnSh4ioJ2Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794860; c=relaxed/simple;
	bh=HLcg425F90NHvfln7+CkNFLbyp+1IauQlWGwrTXVWkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vtbo1aHckyMGtPO036s19BGdPGSFL7f4cbsqrEzofPcj9HKZTlG8enq0LTHgul/gmvzjJVakOXlDTcft7GIKEjuo6WBX4q+WQ4IFtQ9AjwDhhT4BTH6lGqAzjo+76qQigWNwL8KiGD8UKZLhlTFfkvKiAj/9J/f6vmzYRsuUrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEC2PB2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F07C4CEC6;
	Tue,  1 Oct 2024 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794859;
	bh=HLcg425F90NHvfln7+CkNFLbyp+1IauQlWGwrTXVWkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEC2PB2qqWlaxBrCYs0tyLDHvYQfQynYdKreOHCr6nywYxT6IzPfGdvyLLVujp+1c
	 IDSftsjEYeaOIcOKZp5tq+lv+9qQkWTeM9RUsOZeFduP3EpcAUZfRSbC0APhvmic8K
	 9NlxqiCYYaxMtFvZhXV8SBZCR4GCD07CTRhc52RKjG3gkNmQ4w+7uS4jrzwBd37x3k
	 pf5ch8ng/WAb8VeDeZmI+Vres6Sbx77xHRWw1bvS2A1qHj9EJeWEGkCR+YviUl2Jn8
	 00cTL1V7LwXT2aG58SmKOypU6fCUb+q+aHxLoIj3SbF97PG3K4613T1gEFvGesC+er
	 PQvO1BPB05kow==
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
Subject: [PATCH v8 08/29] rust: alloc: implement `Vmalloc` allocator
Date: Tue,  1 Oct 2024 16:59:43 +0200
Message-ID: <20241001150008.183102-9-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/helpers.c              |  1 +
 rust/helpers/vmalloc.c              |  9 +++++++
 rust/kernel/alloc/allocator.rs      | 37 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 4 files changed, 48 insertions(+)
 create mode 100644 rust/helpers/vmalloc.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..20a0c69d5cc7 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -22,5 +22,6 @@
 #include "spinlock.c"
 #include "task.c"
 #include "uaccess.c"
+#include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/vmalloc.c b/rust/helpers/vmalloc.c
new file mode 100644
index 000000000000..80d34501bbc0
--- /dev/null
+++ b/rust/helpers/vmalloc.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/vmalloc.h>
+
+void * __must_check __realloc_size(2)
+rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return vrealloc(p, size, flags);
+}
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 4f3c3ab7c7a2..f341e9ed5b7c 100644
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
@@ -166,6 +179,30 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
     }
 }
 
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for Vmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
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
+        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags) }
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
2.46.1



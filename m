Return-Path: <linux-kernel+bounces-325711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B421F975D71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D34282979
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE81BD009;
	Wed, 11 Sep 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Trml8k+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1C187334;
	Wed, 11 Sep 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095333; cv=none; b=EFXzr7OpsehD+iVgpw85Uf4iNo0f34KowGbOSZChp1XR7YN4HlBIAV4PissKJxfuWlLBr2c+WPQ9N3ajhwvFEJePTsLxno1JH2YE6TRFpBryitMU7fGtOeYV0z0WToldaLAi0ZG27EJCibWHIWLgzvBmxMcyVGOqZPdR9wPueCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095333; c=relaxed/simple;
	bh=kZOIx3Co/Hq0ECAauxmLflkd+d0Tj2aHN+O0afOlvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHmkhLFoekzPVhuxv9lbSXjX+x0WsZSue8IJMFMERhJcl5R/gKbVitnbwFzD+o3JQwnw6pT4wGiQxz8kXilpGp0XXsj0tyc8wsieo4jW5OxAWbqUHU86nkTMqPQAQvTEqFvx5gmgCLhSyAdjuRNixwgqBVmLCCCWJ1jCtBH/rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Trml8k+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0846BC4CEC0;
	Wed, 11 Sep 2024 22:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095332;
	bh=kZOIx3Co/Hq0ECAauxmLflkd+d0Tj2aHN+O0afOlvOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Trml8k+nqKDeTUNPT+Q0B0wvV+B+DWgxGKE7UnVOvVcv9HfLKATNF6fhsj47h9iXV
	 nrywaauzGj4lgxa7f7xhiOeXOhOa4jhrhk0aJbt2WS6uE25MeEEb7ECReBtdm3z5V+
	 Ghk+wMz+UjV+GGyGsr2rDdhFuUsui+3bn6x0M3o5H/hSH0WPiIh7e1qQJuC1D7eLkZ
	 NtvqlCiNNBLhQsJxc5teRL1Zt83GIbrLUF67Cp2BFree4q129nsPVzUKeBg55kn5zH
	 Hv2jMnY9qjlGlbH4yr5yCJJreEwShKO/DEWm2xC+eWRG4VjsvB5JBP7aOayJ0bq+ZT
	 zfV95Op4i3MLg==
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
Subject: [PATCH v7 06/26] rust: alloc: implement `Vmalloc` allocator
Date: Thu, 12 Sep 2024 00:52:42 +0200
Message-ID: <20240911225449.152928-7-dakr@kernel.org>
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

Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
allocator, typically used for larger objects, (much) larger than page
size.

All memory allocations made with `Vmalloc` end up in `vrealloc()`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/helpers.c              |  1 +
 rust/helpers/vmalloc.c              |  9 ++++++++
 rust/kernel/alloc/allocator.rs      | 36 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 4 files changed, 47 insertions(+)
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
index 7a93442187a1..0f2bc702e8e4 100644
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
@@ -158,6 +171,29 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
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



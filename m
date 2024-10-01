Return-Path: <linux-kernel+bounces-346181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF198C0FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737931F229D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A831CB534;
	Tue,  1 Oct 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKjAMs00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FE1C9ECA;
	Tue,  1 Oct 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794849; cv=none; b=T5EFMV/2US6kjZMUwrIhDV8Boms0FpUqAnr6UnwOkAvuBa0znGkTCdN7kixLhGA69AZemWKZhaBBXOZWAJf7YZXpGqmIG8AOPiK7ZCL/ePIVOTycFjaS84Wfvs5AaWXZGejdQgWy/DI2e4UrNqYX9Zv3UsIWaLjzFQVtN3hszKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794849; c=relaxed/simple;
	bh=LpkjNNodsESQX/WH+zGgYq9+ft7IaGarSymkz3GKdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N36716IU7/dAZweecbpHLYBzGAfEiAKgHc+mMWJ9sDgXWpdhURNh8nKHZnjw9u2RbxFxd4Vp9iOCAuxq0qE9KnNsVIoudXLFbZxP3EuXJfmIyHwp/4cyrKvdMNSIM3lbfEkUVEP/B3lXSwua/6kUTACW5hsbQXL9MF81TRHpo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKjAMs00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B144C4CED2;
	Tue,  1 Oct 2024 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794848;
	bh=LpkjNNodsESQX/WH+zGgYq9+ft7IaGarSymkz3GKdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKjAMs00KvN55r37SyGM4QVoo7q+wPKTB0KrHiVJx+r0UGrHFtGwN1Yajw5GL9Qbs
	 BB47x+26Q5zDuMCc7Z6iS1by4ZQVrjAmcqG5WB354Wn5wdD/YQrCoiOBfmRDoWEzgS
	 wPOWrfw9e+HqxQKjTBJWU4mR7fyMMhwWxV4oLWhgX3zKTR7PFyoFiX5dLkDZZ1kmVd
	 DF2uzhaxykw0AXrgL49xD283mOwBcGZDn9OGv9NyLWUldBgin+l3Bw9HkmlmoL/7OM
	 idDCJ/8oiY1FKg+1EJh1sgupAr6nTB7eXXWRRiJN+YkiGDwTuwhg39iyw2G/UwJel2
	 cvqdQJxR99h6A==
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
Subject: [PATCH v8 06/29] rust: alloc: implement `Allocator` for `Kmalloc`
Date: Tue,  1 Oct 2024 16:59:41 +0200
Message-ID: <20241001150008.183102-7-dakr@kernel.org>
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

Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
typically used for objects smaller than page size.

All memory allocations made with `Kmalloc` end up in `krealloc()`.

It serves as allocator for the subsequently introduced types `KBox` and
`KVec`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 1f28b004b447..4f3c3ab7c7a2 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -13,10 +13,16 @@
 use core::ptr;
 use core::ptr::NonNull;
 
-use crate::alloc::AllocError;
+use crate::alloc::{AllocError, Allocator};
 use crate::bindings;
 
-struct Kmalloc;
+/// The contiguous kernel allocator.
+///
+/// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
+/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, which is hardware specific.
+///
+/// For more details see [self].
+pub struct Kmalloc;
 
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
@@ -53,8 +59,10 @@ struct ReallocFunc(
     unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
 );
 
-#[expect(dead_code)]
 impl ReallocFunc {
+    // INVARIANT: `krealloc` satisfies the type invariants.
+    const KREALLOC: Self = Self(bindings::krealloc);
+
     /// # Safety
     ///
     /// This method has the same safety requirements as [`Allocator::realloc`].
@@ -106,6 +114,23 @@ unsafe fn call(
     }
 }
 
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for Kmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
+        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
+    }
+}
+
 unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-- 
2.46.1



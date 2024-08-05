Return-Path: <linux-kernel+bounces-274871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E31947DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D2F2816B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF911514E1;
	Mon,  5 Aug 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X77UjPV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59613CFAA;
	Mon,  5 Aug 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871226; cv=none; b=knCo0hcCsAKacOtAv5vQeT+aB/UP3OlnBS6TEigVEr2mpqCOrBtzWI3IiPo+Yi39mEM2QV8cCZv+d/d3BJm+IpsVnbAJPM2r/MbKxQo6f7ExVjGU8RngRgbq1DsNsb5BJnbLqkVRZ6gkFRYYrDdrQDsvsm1KduTeBreKc+ZGjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871226; c=relaxed/simple;
	bh=PKEwZd3yHqQQqT8mEHKKvphM2Pe67I1NR1OPtC0T0To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGAu4ghJvji412UdmsXfnHfHPuI+Z42S3JV5h8/l4MX0XXhv9nh89YgFizDn7OEOWtFcgi9fokz/qK6j4aycPfKiwLWWMvypdHbM4HFkwTI6b0FVreuOeFBi3gf66HBjaN/mW1OjO9OmuosDWwNWX4Kzgznj9vkJSLH0MjWQn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X77UjPV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53277C32782;
	Mon,  5 Aug 2024 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871224;
	bh=PKEwZd3yHqQQqT8mEHKKvphM2Pe67I1NR1OPtC0T0To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X77UjPV25pEFDWaPq84AeyqAqV6uAdZksZPYQUqppUCz33XeJi1l7MK10KLbf0tbV
	 1gzJyR/gqXeboD6/+PfujdxjK/K4YorMQKV2i+6CtJjJTkdm31OPPP4WGDsy4wM/wE
	 iCsc/dfVvk0YM4EQNp02su+KeYPCYvQp/Qz0O3UCPWA81wABOZR3++cXO71S3jytsL
	 3j2+CK5sJAdYdHLX5ornikWobgm9ufjXlj46zb+RBB1jQm+QeqMSgCABFndl+5xVe8
	 aMqMS0NjQ8nrvu61TGZ05I78vnCyrNNzHV9terWU4iL/PgCi/NJd09luI4ht5nHBGL
	 uSXgPuiwLcsJA==
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
Subject: [PATCH v4 02/28] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Mon,  5 Aug 2024 17:19:21 +0200
Message-ID: <20240805152004.5039-3-dakr@kernel.org>
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

Separate `aligned_size` from `krealloc_aligned`.

Subsequent patches implement `Allocator` derivates, such as `Kmalloc`,
that require `aligned_size` and replace the original `krealloc_aligned`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e6ea601f38c6..e7b7eba84acb 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -8,27 +8,36 @@
 
 struct KernelAllocator;
 
-/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
-///
-/// # Safety
-///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
+/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
+fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
 
     // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
     // which together with the slab guarantees means the `krealloc` will return a properly aligned
     // object (see comments in `kmalloc()` for more information).
-    let size = layout.size();
+    layout.size()
+}
 
+/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
+///
+/// # Safety
+///
+/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
+/// - `new_layout` must have a non-zero size.
+pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
     // SAFETY:
     // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
     //   function safety requirement.
     // - `size` is greater than 0 since it's from `layout.size()` (which cannot be zero according
     //   to the function safety requirement)
-    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
+    unsafe {
+        bindings::krealloc(
+            ptr as *const core::ffi::c_void,
+            aligned_size(new_layout),
+            flags.0,
+        ) as *mut u8
+    }
 }
 
 unsafe impl GlobalAlloc for KernelAllocator {
-- 
2.45.2



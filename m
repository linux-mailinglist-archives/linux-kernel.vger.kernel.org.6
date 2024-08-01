Return-Path: <linux-kernel+bounces-270007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7589439E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AF51C20BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F615C0;
	Thu,  1 Aug 2024 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caZue2SC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E85634;
	Thu,  1 Aug 2024 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470823; cv=none; b=EhlTVEb0DQAI05PVqNopomFrpljbLTp6HBWiV9Z9Sk9+hM5/QkxFOv5+XujVeauu1HRi/Ugz37KD+WAXZSSFh0acQHMlBElV5MgF1OhLX5+vbYCskOIniUjg30FVyk+JcXn/pwI/efKkCFeMnMAEqYmVMbQ6vfaa7rQg6CVZNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470823; c=relaxed/simple;
	bh=EF5TVGHtjh4ZWyprrgf/Kmvg5Hex1RNnX1bjJzrWn+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlrKXbT5Xnok/H+l3LKbTjBZ69SlbHaEvOzH+sitcwB7ttHCeSLFQqdNUDtYS+shNjaZNoQPVWu3dvfGpeXlUwgjYpx1S5AB/Q5gYdGrYiiY+iDURzs4Eru+fq7sHm3+fFuJZqtIrjnV54zjNkFdv+/2mALijnK000uQAH5vmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caZue2SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492AAC32786;
	Thu,  1 Aug 2024 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470823;
	bh=EF5TVGHtjh4ZWyprrgf/Kmvg5Hex1RNnX1bjJzrWn+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caZue2SCBQ/qK9rQ+EruSBuRQ8G1EK1zbXMqxoKz6hYHoeDLfVV3Gxkt91OXG61Jc
	 jboqn22gfBqYo8AszpXaPezc0qwmvpK59IAAnLbnK6j7bfBlMWU3ZESLJvEMvHoSsV
	 90go6u9n/yUL1GwZdoiiSaeWK1rQer+UGHh0Jpy7eHRVTcLnOFrVgHogxeDuZ4WL/c
	 61FPwrDO2wlP4l87Exc3c4iwlqLRe37EFWUI8qmB+poi8TY0THXzlmbvDQ4hliWjjX
	 HtyGuALr4g8rvlLIDZ4FPHixvzc8lLtbwt9NMN7Sel4SVPjU4LDA5ljn57FjrJnAoW
	 KEZMZ4RqRCpBA==
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
Subject: [PATCH v3 02/25] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Thu,  1 Aug 2024 02:02:01 +0200
Message-ID: <20240801000641.1882-3-dakr@kernel.org>
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

Separate `aligned_size` from `krealloc_aligned`.

Subsequent patches implement `Allocator` derivates, such as `Kmalloc`,
that require `aligned_size` and replace the original `krealloc_aligned`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e6ea601f38c6..6e133780a4a1 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -8,27 +8,35 @@
 
 struct KernelAllocator;
 
-/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
-///
-/// # Safety
-///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
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



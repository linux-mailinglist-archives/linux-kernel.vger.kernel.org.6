Return-Path: <linux-kernel+bounces-260273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F293A547
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4866B227A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14E5158D61;
	Tue, 23 Jul 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6jovfZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC304158851;
	Tue, 23 Jul 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758265; cv=none; b=nC9mqAhnM3w5jt8Pv2Ol3C3IAFh8kz0dGOg4yK3Ruh8ttg/VZgGGmcmNTLefT8FgN8EaniC3MVn5YTAmIVeqfb3BtaMNT/Fjj6259/h9opnNOx14EUHxG10ImHplXrWNH3ZleyU/jVEjl6tH7lwmzcq8Q0oCFQyE0ixrFS6fayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758265; c=relaxed/simple;
	bh=EF5TVGHtjh4ZWyprrgf/Kmvg5Hex1RNnX1bjJzrWn+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDtigKdDaLk1OwoqVq2s98Axe2oAleYZ3XPZTJhPHlm50wnHlC6WmEc5O8tKtyb0M0vGYIGKgD80q5ac5kzZidEjUJXEO4L8qhfhTgLBAyc7akcbiKc2f76G9U71E6a0dlUKrRhU5/LkgjeaAJt3ui1AzIhlphDkBgoUyq4ItJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6jovfZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F59C4AF0B;
	Tue, 23 Jul 2024 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758264;
	bh=EF5TVGHtjh4ZWyprrgf/Kmvg5Hex1RNnX1bjJzrWn+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6jovfZmXmWU2u+CRVnM/WkrcdUz8kYHbBGAcB9lI6dbRqsuZp2V0ciRIaazVMLjy
	 h8xvO988V8AjJvelD6vG/yuVh9BMRh1mA9kRWBQd8FqeHurCI46aZHyjv41Ycz3PSM
	 1eqKfbB6b7PdalMqqALZsnr3nuT4kIz29Dz0lX3jN3RW9frxXIICZgEQVNjKxiBo27
	 8Zhd9Y37MKGAHnXc9NI1sKCoTiQArx70KB19Q0NqLtw+SQUHP8xeCjV+vqfqXXBVIk
	 5Wq+ITwkanPAzm9XMDqxtswIgIak5p4Uq8ZiXnN8NEkaHYJ6SxCsrfVvpnybX7ZV9Y
	 L1NIl3l8yVmEw==
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
Subject: [PATCH v2 02/23] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Tue, 23 Jul 2024 20:09:51 +0200
Message-ID: <20240723181024.21168-3-dakr@kernel.org>
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



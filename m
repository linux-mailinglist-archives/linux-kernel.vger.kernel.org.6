Return-Path: <linux-kernel+bounces-288737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30640953E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04301F23FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CFB1A288;
	Fri, 16 Aug 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAnPVWFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05713C8E0;
	Fri, 16 Aug 2024 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767156; cv=none; b=YukPgTxUQ66tLj1HXhaKwHUQB5MvazRD4Jx8h6rUG4GvNTZogZiXHmRmDf/gt2X5zjOOGFjxRihA1y+CHvkin6pmRNPZG6NtwjMoPnPeik6gVn1Me9pA3qulyn1hFS+5+mWkcjLcScgAIH4h5AGFIT0HAsYjNcLkNCtJEjxmlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767156; c=relaxed/simple;
	bh=7ZQlD+OTbqqlfuCqgP0DzO8fypflRQev63uVtG65Y8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+p73N7IT8M3+zQRRE3o5fqtO6ZCjvNi1iUIlZz2+e+Z6P3R7oGF7wBQG1BSWkcFQvtMQ7oA96jMxeAv2OWHdZclFQvXHoZg1Yf0V9MU4brZXQ5/k1jrz4BdIXOlfsyXMPNIem9cjJ32WzZUXlOqmmUUOK7taRiKhx8H8KMMwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAnPVWFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B7FC4AF0C;
	Fri, 16 Aug 2024 00:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767155;
	bh=7ZQlD+OTbqqlfuCqgP0DzO8fypflRQev63uVtG65Y8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAnPVWFalHNdYwWYd3lbE6b3W6p6ZwKVuxqnVgvpj9tEBAPTdFpARBsEqVS554dCY
	 x0NhR+80UCX503tsN/Zl4/5G8uk/MKNgqcFT4kWeEu9VLnfV06EaQhZKUAjwt3YzO8
	 vzu91NxYDN+XFsqD5RCW5KkUiqljpYr1hJ4u1Gw6lvWT7yR21vtHY503Aipp8Yn2bJ
	 e6eagH4QRRJwFA8Rj2WOeKezAP0hVOu5hguQmpfKLWUaEpZcSo/xOSJO8NsfsICceo
	 DP86xC/KOTAyZM1b6xPeL3iy5L8iqk0m5Fi74PkNr01jms09tq4gemNVH3g3Wj5BhF
	 b+Pk0RFEyXfBg==
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
Subject: [PATCH v6 02/26] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Fri, 16 Aug 2024 02:10:44 +0200
Message-ID: <20240816001216.26575-3-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e6ea601f38c6..c83b6dff896d 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -8,6 +8,17 @@
 
 struct KernelAllocator;
 
+/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
+fn aligned_size(new_layout: Layout) -> usize {
+    // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
+    let layout = new_layout.pad_to_align();
+
+    // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
+    // which together with the slab guarantees means the `krealloc` will return a properly aligned
+    // object (see comments in `kmalloc()` for more information).
+    layout.size()
+}
+
 /// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
 ///
 /// # Safety
@@ -15,13 +26,7 @@
 /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
 /// - `new_layout` must have a non-zero size.
 pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
-    // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
-    let layout = new_layout.pad_to_align();
-
-    // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
-    // which together with the slab guarantees means the `krealloc` will return a properly aligned
-    // object (see comments in `kmalloc()` for more information).
-    let size = layout.size();
+    let size = aligned_size(new_layout);
 
     // SAFETY:
     // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
-- 
2.46.0



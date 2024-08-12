Return-Path: <linux-kernel+bounces-283586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60194F69C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CCA1F23465
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15159190045;
	Mon, 12 Aug 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0I8hd5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546F1891D6;
	Mon, 12 Aug 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487059; cv=none; b=DR6/P0ylGzpFUc89acYhMOAKYJzNFmvA5n+iMlVtJl7FyxLIMCYZOCnaHon4NuWMnj4NFnvRtKrR26tVoJ6KkJOey7EJ7XoOBadFeNXuws7Qrit3P1/o2ryovJZqE/YoOXRqgL1USG0rBzCBbGAeuat4OPkDb04qklijzC1RJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487059; c=relaxed/simple;
	bh=p++mQr6O15JhVUHtMmsU1D7fc1KQnWeRmH3GDyn4naw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB0hdadmCD4CYF4PNNHP2T7D9VVHhqwPfn2AsO9vvbx2P0SfKjN9H0oFhsH3d7C9F5rICMAHN1CijVyesishgs+CZMFBUsTzyvyyyhzJc96QGbytZLiIWcDD2TYV5pNFQ9G/9FNB2DwmW4yfUH+R33jWVuZUy+9zcYgxTedNnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0I8hd5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08F9C4AF0D;
	Mon, 12 Aug 2024 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487058;
	bh=p++mQr6O15JhVUHtMmsU1D7fc1KQnWeRmH3GDyn4naw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0I8hd5AqEtUJ1AqcltnJQJXgDifadIagb8OT4ht7RND3/LIpX13gvQjzt3gLQowI
	 ftjf2eUBi+kRnz1lX7eL9vGAeiEQ8VSt/93xhlmq3bo51SkTTtLhVlA1JeSJlhL1vO
	 kKy1fu1ZpAWRTSx0A6dHnPwjSFST7YO372xKlpVClxYIjCcUPHvkSj+fQ1ApyURzYL
	 iEsA/zOqK25c8hP18hXK60sIIPLcYcpYrmTHnk0vQhpz7wJPKOG5cBX2AXOvB7Pt59
	 OuPvw6w4Pra2zExwy8Z5Xaqski4YFdaIJkkvFVea5Z2LMfKRfUtJYYqefeQFClV0Vt
	 gsbOh1+Jy/6+Q==
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
Subject: [PATCH v5 02/26] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Mon, 12 Aug 2024 20:22:48 +0200
Message-ID: <20240812182355.11641-3-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
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
2.45.2



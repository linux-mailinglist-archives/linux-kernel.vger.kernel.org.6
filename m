Return-Path: <linux-kernel+bounces-346177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB798C0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B5728630E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5881CB300;
	Tue,  1 Oct 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGo62r01"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAB84047;
	Tue,  1 Oct 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794827; cv=none; b=UOL1KpndvZpgrFAICW+HG29nPsIczg/sRkD/xrFqfcntZ+CwLIJ1ms5S4HgVwho4cT43OVv4obs2ClBV9fDxni5ayqeY44v2yBjC4r7OwElYg6Q4PUO0tiYBsieegopyJIcfgNpUNZjkGibHcLzDS2zLS9K5AibWgC8lrD9YPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794827; c=relaxed/simple;
	bh=jkwVy/FbAq0lpqNfRj/9CuxBTqWwT6EE++N0UM3hdBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boCr0uOTO3S3UbJ8c3A/4SmlZBkbjmvgHiDMae+lq5QBrTC3f+nr3tudrWBpffYiLKibeGxVqBNVEe340g/Iq1g0NAlQHzU1Xvwu1+WNAhtTEEQdmhoLSdu7W+e8lHN72WJy/CEN3GcgVudvGcJg83S9Ta0yTwbmrZlPafzL23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGo62r01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88260C4CECF;
	Tue,  1 Oct 2024 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794827;
	bh=jkwVy/FbAq0lpqNfRj/9CuxBTqWwT6EE++N0UM3hdBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGo62r01HZ4eL65H3mCyFpgGOTQKvCWr2+bW2JgJ1Ko1mMbKZlA6duZ2ud2iVEtpT
	 KQ88lS2emAf0fKqC2+u4I6M43AEqks4SCWnLzlBrL5mT9m/Y/oO8bsz/MoBt+bQEcS
	 EMRYn/Vpns3NG8LnnIhww9TPSL00Q3jwY4NY1jogyeFSs8GfWp9qiyqrnY1Frp4cGK
	 B9fSPlq066mUidESfW6zuiumnHN8q9tIdADqjrj167+nDyhNLvOr3KISdUBHFa00gw
	 jc/Sp+9Mlyc7xwtZwaMWE1DUFxev08Lz/pZYwgLLfKvcYzGEiW0npAYhoX662y1GUh
	 lWrI0YugSlX7g==
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
Subject: [PATCH v8 02/29] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Tue,  1 Oct 2024 16:59:37 +0200
Message-ID: <20241001150008.183102-3-dakr@kernel.org>
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

Separate `aligned_size` from `krealloc_aligned`.

Subsequent patches implement `Allocator` derivates, such as `Kmalloc`,
that require `aligned_size` and replace the original `krealloc_aligned`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
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
2.46.1



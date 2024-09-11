Return-Path: <linux-kernel+bounces-325707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B014A975D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599991F235EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF891BBBFA;
	Wed, 11 Sep 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/WgSl3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56E1AED49;
	Wed, 11 Sep 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095312; cv=none; b=HPAUZjy91fK3IQPX97SfWWkB1HEmgbFVZGChSbZMQ5AAkqTqlKqeRRTeBV6JrtFZe8/Y1GxE5xqIsboZsJZSUooDKSG3JhCiHbimTS55Kzv0U0UPUE8cl64OYGULIbMx3Pg6sieovGQCaqAFNH8weF+sb22zytCPxLgFyGjzLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095312; c=relaxed/simple;
	bh=KguwORfCY7YFKN8ylS2gRnroFHbMzQZYk2Q9X4DUkvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGbW9TII+TXAeKOEHe+8QkbYVVlocw40QpwrnfjpbDJzClIAQHN/DLFtjwf2qyFUh3RlNjGgS0AEeadPEXpZwmfzODTwk/ERU0iZZi+2st4znolgjCogc81rAOiLuNiPuJ3pFbXQZGlaGD0hUfLNWyw61Ip/yzRIuAih6magvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/WgSl3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D95C4CECF;
	Wed, 11 Sep 2024 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095311;
	bh=KguwORfCY7YFKN8ylS2gRnroFHbMzQZYk2Q9X4DUkvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/WgSl3S/dVR8lPldARNWqtzBxXX0S7eYokMIzvH+tUsNddrFOKgY8H7hg3IL8v7J
	 5v3sEjSAvsQtbpDLlySeaWqNttFjmU7ML31CGvfUsC/plF1j/aqfY37ymrpz7dLwr4
	 m8SN45KADpIY+l8OIBaofroxoa8zToBc0GZpMJXQ/2HCUq50F82aulAVsB08GbMIFM
	 FNi8Phjw2JIHJl0FBTLH8aa4ZAiEFoRbkkVQJyW3tWl7BSKy9ThyabCKX9zCaNhquT
	 vId+Sd/uYzs29X0EN8pG29Xhh5iduiyOOXP7EIzE8u8Tqx/zcgaocb/94BA3Zze16h
	 aGi5EIDGU9qFQ==
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
Subject: [PATCH v7 02/26] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Thu, 12 Sep 2024 00:52:38 +0200
Message-ID: <20240911225449.152928-3-dakr@kernel.org>
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
2.46.0



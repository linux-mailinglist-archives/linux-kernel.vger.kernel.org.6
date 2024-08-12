Return-Path: <linux-kernel+bounces-283587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF894F69D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC01C21229
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89878191F8D;
	Mon, 12 Aug 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwDjo9Cz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97591917C0;
	Mon, 12 Aug 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487064; cv=none; b=PxbCJtSYWDRFsW9ub4Fap1Ttk2qmD4n63pce+atfCILlY1JCLsSqynO146Q5fPPEW9quip0kLoaJZ1aNgk688fOJFtO78PzZRoL0YKtvjtdV2cd6rAhiO7gdxOq39zGoLzkgQ9eZQ2vClfJl4BfrI3H++RJSAqN58yVmVvvL7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487064; c=relaxed/simple;
	bh=8oAuOdisYUjDdGnujzu+qdpGOC9b4wPMkAAnWfvuI7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQGOGfeuAfjIjhRGduUvgCZ9D/zRqSF6/E1uU6qJPj8s4q1e6Z/MB9ncPbCC1G2QjQuzrjDOA4aoYhrZnG+fICUCyMYN6A3bM3H8ZMmtZqK0VvFelXgUZs73hv1S8CY2rzLWXNranKnWstcl8shawipkdcoTd9O9eGjQ7Hx7Dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwDjo9Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A19C4AF0F;
	Mon, 12 Aug 2024 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487064;
	bh=8oAuOdisYUjDdGnujzu+qdpGOC9b4wPMkAAnWfvuI7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwDjo9Cz4msrN2OFv+80NjQx4rMmA203HaSKUMopmbA9GF9wV37pGy0wmAtVUds1f
	 KMhgSVyZ3/x3j2p/33Ix6HNljGcAKQlS+dFv8JEmhsHX80rI7/JAXQKKrfMmP2e5tH
	 TTHy+3GPqdb2nFkTn4mLZKS0VspwdWH3/BdIKLZPMkqeR2xc4tgsPcMLywfYnui0fN
	 mILcDkSB2mO9sY5G80rk+PeTOoAPDCQz3Vxlv2N1H6RhptAoytES93kq/BrFwUJRCa
	 EnW1AdyGLUeQjxjWCaTInoiz4pVCEB5o2ZpTdlTiAMi03PmlgvurTvgjpWC+2J4RC7
	 a9LV7QnrU4Ngw==
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
Subject: [PATCH v5 03/26] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Date: Mon, 12 Aug 2024 20:22:49 +0200
Message-ID: <20240812182355.11641-4-dakr@kernel.org>
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

Subsequent patches implement `Vmalloc` and `KVmalloc` allocators, hence
align `KernelAllocator` to this naming scheme.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index c83b6dff896d..e32182f91167 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -6,7 +6,7 @@
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
 
-struct KernelAllocator;
+struct Kmalloc;
 
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
@@ -36,7 +36,7 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
 }
 
-unsafe impl GlobalAlloc for KernelAllocator {
+unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
         // requirement.
@@ -72,7 +72,7 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
 }
 
 #[global_allocator]
-static ALLOCATOR: KernelAllocator = KernelAllocator;
+static ALLOCATOR: Kmalloc = Kmalloc;
 
 // See <https://github.com/rust-lang/rust/pull/86844>.
 #[no_mangle]
-- 
2.45.2



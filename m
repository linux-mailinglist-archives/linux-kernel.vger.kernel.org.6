Return-Path: <linux-kernel+bounces-288738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D0953E20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0081C219F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD70AD39;
	Fri, 16 Aug 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne94WL1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDEB10E4;
	Fri, 16 Aug 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767161; cv=none; b=MeABo4zuimsAsJkWcAocbk1q6RhFzoKmzOD55ycYTkYJvTr6W1ck0rs8R5aYBEPat8jhnXrXfhiaxTZSUbuEyoKKOgRthfVozhb/b22EVOJ4zegvGfO7cOOAfObb8ubOD8jY155zmgd5Aw2O0Slrw+gTg3Dh7lVTbUtS2q9H1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767161; c=relaxed/simple;
	bh=Ul5b1CTJ9tob+sYMI0uOwgqpbhRR4cA87hpBjRrp3KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBTw7I6S/KUvamm/xP9K83sfXhWZJ0Lk+sQl3LVFkFw1JONEOpm4bF5VyhNgffg8Xl0VFyVRVQX89MKHbRXZeIYvCC6fnK+ZZLoktut0NWlV5GZsd+yunprto86Ah4EQmY8YTID1+46VyaYvBI1Rj5CfzKzsashvePGn6T2fNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne94WL1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4ACC4AF0E;
	Fri, 16 Aug 2024 00:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767160;
	bh=Ul5b1CTJ9tob+sYMI0uOwgqpbhRR4cA87hpBjRrp3KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ne94WL1V890QjFloYBA4pmcsK1kTJW/b0HtCFvQl+YVAByoQSFc2VMznmdoDkS4D0
	 0EfR5GYsJQkhnF+Avj43Zq9zmRhhmVXGfC2IxoB7jmCgB3fx/sqJIwFjNUh6dwj6DN
	 e9KBqyqVWRqVra2FOjv9Sx1BWS+kLGvDCeIlYaWcMphAOgXKsZhEr5eav53HRgxYwR
	 dmSOkJtgf28m/KgG4IRnRdj36p59EFR4iSzIHQSP6IjGAUZpojWgFiMYTUp+Tt5jhh
	 od0smleLkl310st+/eWgw2HoN5ArGPO+Wm+Rz3lZc3rdQ382Lq95vqZSudTx3FJT7w
	 zQL4UXHY0emqQ==
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
Subject: [PATCH v6 03/26] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Date: Fri, 16 Aug 2024 02:10:45 +0200
Message-ID: <20240816001216.26575-4-dakr@kernel.org>
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
2.46.0



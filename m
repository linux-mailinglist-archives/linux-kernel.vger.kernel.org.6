Return-Path: <linux-kernel+bounces-350670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB7E9908D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0127B2C86E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F31DF875;
	Fri,  4 Oct 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLntNC5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5911DF845;
	Fri,  4 Oct 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056542; cv=none; b=V7u8Qq/FJaX3cCWP3rF6RQEq9GRhtyLWcYztLx92BnGJ6GTeqkNLpqV8NuU/1gFa8xxs+QO3ZodFkbniTDSSEuc/yvkiyGFTf7Q21pUN98zwiDOceX3HTC9sJSAKgPGsGNm9qqwm674hE7FTYXWfAyFZp0D4uXD3ATamkt3awjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056542; c=relaxed/simple;
	bh=axTTg7SsxXZNqW4CxUpwgLYR5awaQab7skyekwlvxHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOENmvO5bS3fYkesiEc2kg2oe8TKdivd4q78tWnUQDefd6YDFppORm4ChfAisf8kBBAZbBjcxoHHMM8KJks2hqJMHok9BtM+odmzeqHvaxge7up1Rjpmb/Sja2yYVJwUZ9QKgwupbZUnWpm4cufG1N4sh++oh3Fu0Lcc5CmkylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLntNC5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD86C4CED1;
	Fri,  4 Oct 2024 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056541;
	bh=axTTg7SsxXZNqW4CxUpwgLYR5awaQab7skyekwlvxHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLntNC5GMO+JfUfJ8T+RToF/Q6zkfE7Zbk6QFUt/YDBi5fmDfvLnGjdsh/MmTD6nx
	 JdHKLGahSiq+PTzPUi+dCZGcIHqfbnVbuAcjTZ+PuzemKlxbCcLs3jiVBtSFySOR3+
	 YqyOojHVpAFhUvR2z+/RUrIhKXbEnBB/mHKYMZp2SO2cs2APgp5zQiiPWue5mVIFyE
	 aXhBqMr1Qbv9cGHI8RT7aaniTTWQL2W5hf5PlOIoHmtFHf/g+m6yLGcWsbhLsOqzOa
	 RDJy4UgSrxf0zlREhw+BujKjRga7rESHFswoiVECMil4ZVX2lXo4rTVqzM2W0zOmeH
	 EILZDqjGCWlUw==
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
Subject: [PATCH v9 03/29] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Date: Fri,  4 Oct 2024 17:41:07 +0200
Message-ID: <20241004154149.93856-4-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
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
index 765f72d5bc21..3b1c735ba409 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -6,7 +6,7 @@
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
 
-struct KernelAllocator;
+struct Kmalloc;
 
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
@@ -37,7 +37,7 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
 }
 
 // SAFETY: TODO.
-unsafe impl GlobalAlloc for KernelAllocator {
+unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
         // requirement.
@@ -74,7 +74,7 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
 }
 
 #[global_allocator]
-static ALLOCATOR: KernelAllocator = KernelAllocator;
+static ALLOCATOR: Kmalloc = Kmalloc;
 
 // See <https://github.com/rust-lang/rust/pull/86844>.
 #[no_mangle]
-- 
2.46.1



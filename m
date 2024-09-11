Return-Path: <linux-kernel+bounces-325708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1E5975D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF35FB2251E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B21BC081;
	Wed, 11 Sep 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCGcTqnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530831BA276;
	Wed, 11 Sep 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095317; cv=none; b=YeYsSCX2DWUDbB0DTcquKHKX1KVqrZPtR9pmp2XySk7IWxT4TnX2tDlHo7fTSdNN9eae2aA0VMMQLIY8g14WIpSOdRzJfTWsLLmk8/avVShAuTXFjJWV8GugeMb7htV1eLUN65DlK0USCifxKSIx0P3F0OW7b0YTBWXTv+yTIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095317; c=relaxed/simple;
	bh=Ul5b1CTJ9tob+sYMI0uOwgqpbhRR4cA87hpBjRrp3KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGfVH1q9/RJf6QMSziZ9GmB4vVSQM81hLylJ0neojSTH+lu2gIOOR6IabNO2VpQvpSgHETlw93hjXCdE4Ujio6TLGWASylGZeATfOEylykAkDcJO65KBYR/NwdvxEfSEoibMPqA1AFVHh7i/EsQ3ET0YeiEikcbtz+F+7cKeJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCGcTqnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1039CC4CECE;
	Wed, 11 Sep 2024 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095316;
	bh=Ul5b1CTJ9tob+sYMI0uOwgqpbhRR4cA87hpBjRrp3KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCGcTqnlJVTcLOAmbSEUKqOazK/xR4SmyhHf6E6yLxfNTUBqg888J/jQNW3zoXMsW
	 BI7/fwKW0MKhxs3jEBmYWCiX4BhCu3aKf0fLOGyIKRsM56Bnyr3XrrFXy62AfbCpLW
	 8UF1PfSA3yeN2oduAomH1dIhBJa9dBiM9jJu8L/NJ+IvW3gY6y7K6YmVvjs0Wkm3Da
	 7EZiR7QheKaarwwp8Fxdn7RjH/jtPFM9neQDEJW/KBl4n37/fZAZM94WAfK9n0Ka8B
	 0vTcbjzPGHt2Hv76tpvxptGeMIwheH2dMcELkpMpl4R7rMMGQd0pYO6WbbhSgsk/34
	 zCnCFGDSpWd7w==
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
Subject: [PATCH v7 03/26] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Date: Thu, 12 Sep 2024 00:52:39 +0200
Message-ID: <20240911225449.152928-4-dakr@kernel.org>
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



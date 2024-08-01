Return-Path: <linux-kernel+bounces-270009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEB9439E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03291C21578
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2C32C8B;
	Thu,  1 Aug 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBYmOPoB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D226AD3;
	Thu,  1 Aug 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470829; cv=none; b=gvi5TCVgudQQo7MMUuayBQrsKI3gxiASatSvCH4coJrcJaiDKM+ItANC5T6hanpb+TaqRpgv1WOwyHu8YiTEdZxodmUJa8pBVqSNEx8HwFTmTr7oUhsnXUddBOXr+8zvQqFz2+lfcyk+meMgvMZPy/xyG12J0HwQyBZFSKAZQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470829; c=relaxed/simple;
	bh=aW/HcnaSGCL2MNKjQfZpCrQAc7Fxs7Kovj68XjWpzPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD/LcmlizsH3qdLq2AWvZzDAnPvhUvZr5rkixD9cd99PbKhWLANmh+/4D2f0oC+HIyDR5QtpL3Llz3oX9zPC4xIFP+xafcSV+sPzN6K7Ru5hxLUW8RT/OkiSwNWhqGrM9VcxfKrMf/Ym9jDlhGA8WgGFTJqQJImtokFfE1kGau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBYmOPoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2ABC4AF0C;
	Thu,  1 Aug 2024 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470828;
	bh=aW/HcnaSGCL2MNKjQfZpCrQAc7Fxs7Kovj68XjWpzPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBYmOPoByXs5xNTmUlHB+YhPa15GwpymwwL3KlcJuVBlUgTtc2hF2vc3WDtmW/n4s
	 AtGeSVMmAW6XLXAA4x9LOYxMQcMf4rX3jwCcLcnPffYQKthc1Ui8NedRYGZvLXuGf8
	 tPEnDcanlJB1nFStDAxtV+TwXU5Avnikrs9qSnrxRYD2nMbwPzs7d2sQ5CnhDvQZm1
	 r4m4DohrnpYXvGpWZDX/P+SFcDLTPVmdDBM/Ufv01jPXdUX/Kj0pDvT693dRN31G+L
	 KoLAFANNovd+tWyzyHNoyUH7yWgCbFaSpcBitHT3xZmwW+Dcc99tLsI3aB5jt8aZeX
	 tixOGPlXJavbg==
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
Subject: [PATCH v3 03/25] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Date: Thu,  1 Aug 2024 02:02:02 +0200
Message-ID: <20240801000641.1882-4-dakr@kernel.org>
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

Subsequent patches implement `Vmalloc` and `KVmalloc` allocators, hence
align `KernelAllocator` to this naming scheme.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 6e133780a4a1..10774c51ae26 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -6,7 +6,7 @@
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
 
-struct KernelAllocator;
+struct Kmalloc;
 
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -39,7 +39,7 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     }
 }
 
-unsafe impl GlobalAlloc for KernelAllocator {
+unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
         // requirement.
@@ -75,7 +75,7 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
 }
 
 #[global_allocator]
-static ALLOCATOR: KernelAllocator = KernelAllocator;
+static ALLOCATOR: Kmalloc = Kmalloc;
 
 // See <https://github.com/rust-lang/rust/pull/86844>.
 #[no_mangle]
-- 
2.45.2



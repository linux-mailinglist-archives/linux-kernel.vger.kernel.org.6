Return-Path: <linux-kernel+bounces-346178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1398C0F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5863E2866E7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AA1CB31F;
	Tue,  1 Oct 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSUQr0fi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041084047;
	Tue,  1 Oct 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794833; cv=none; b=oXQtnptszSTIqBBIJR/LHXgyNlECRCzAU1wPOScWkfDoRfPT7lDD7YITSVEoUkG0cczxCIfIkUGaluPEwbTtic4tz7z2vXzfd9Pni59Y5yWKtMNJ9+JJz80hzSC3k2lZ8QpNXbQ1Hj06ARfcqlKTXGDmqQHHjwjVxAZbYRjVRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794833; c=relaxed/simple;
	bh=QNiYbpuM4lhKU5PUzac8sp1oQTQY1U9z8BelyYqtrhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdsX2uc95QPbCju+MUR9Y/3b7DRZaDtsX2pEMSCA86uMIWpdLqaqozJ1ACtjQnR5S8WuX2ue/UviBSwnoTXw8JtjFKqjMfLYUAQdL0x1I+kucrCgK9xFZ0I5a4p+Oay7cxplctKAkfZpJlEEpxhcxyOjsab0VIgVledGeXKWrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSUQr0fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27FDC4CED2;
	Tue,  1 Oct 2024 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794832;
	bh=QNiYbpuM4lhKU5PUzac8sp1oQTQY1U9z8BelyYqtrhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSUQr0fiwqq9quB2232UQ5QYNfe5VMt5SueyMP+/RzqnRG1+0LKVAwJaWDK0LQ4QA
	 VORCLeljJzcuaQYXFY8LeK02zyxGdvvsRdfpQvaTf1pBHFBn7ntBc4Mm3Dv80lc4Bf
	 hNQQKtpH9zjDHnKWkdVZm5E21wUNSgOAilw6yHFRZG/t96WaLGSWSK0i3Tuvna++2Y
	 QknYitfbqiDAjvv7Y0hVG3094W2M3xubi7S/VPz7JYANbYmKC5g7mvrhL1P3Om6SUo
	 rAE3s7lYN5C/fcV91ivOHGz45xmZT/+nDlshYHSQJbozezcudk10KNqtHAWt7J+Zet
	 ct0LaTl5bcEEw==
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
Subject: [PATCH v8 03/29] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Date: Tue,  1 Oct 2024 16:59:38 +0200
Message-ID: <20241001150008.183102-4-dakr@kernel.org>
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
2.46.1



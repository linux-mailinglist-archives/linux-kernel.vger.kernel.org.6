Return-Path: <linux-kernel+bounces-563756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D5A647C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C2E1890B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB1224B03;
	Mon, 17 Mar 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xhfCFjhj"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15F2236FC;
	Mon, 17 Mar 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204467; cv=none; b=bmZNS1sQ5fEjGZ49Yi69QGuOiWCp9ukCAXnFHyZFJxctzcmvq0ejohjcCoBSaG8zxtesmM7VE4Jq3cCetOE0qVEOpnyVAwCq6H7nN1ewqK2T9ewPBQDUGUfZCxQWZtMV/3sx8o89dvkUeyRhx3+lTn3zvDh1yGLs2IuAYg2lPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204467; c=relaxed/simple;
	bh=EFrzB9n6hijOkeb2lyBndIAZnvP8anhnOgTluUvD300=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOiajARUlLiedf4iEszgNm0/iO7oWiun+qiIuVICI1EmUbh5N7hzoEGqGDlAqTxFEpAoCsHbZXpYSkHI5XUPSs4XlayavpjqpPzoYDCSqwgpZSc+olhW3MuQ2xWrjJ42yhU0Kpivd6/z3GaNcCqGpUa1DSwKUO/oc6ejjJ405Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xhfCFjhj; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742204460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m0XSCnSukterJAo4E10iYkPySrScWtoaWdoov5OHuTo=;
	b=xhfCFjhjUh11wsPpQQRCxJvI+8n/7UjQIM6gtj8fQGPitN38/M1YWROr6Tnd3N45K7EDbr
	xMHaBiJcdaK59+3tjfnceNTDDMWTtnU46xzVYsT2ASol5eZ3yziw7TxIaGn534fZxSDSPT
	W5+2tLX+riCc+2N1uVHRBmlPr4QvNzo=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@Gmail.com>
Subject: [PATCH] rust: page:: optimize rust symbol generation for Page
Date: Mon, 17 Mar 2025 17:40:04 +0800
Message-ID: <20250317094004.2622640-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@hotmail.com>

When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
with ARCH=arm64, the following symbols are generated:

$nm vmlinux | grep ' _R'.*Page | rustfilt
ffff8000805b6f98 T <kernel::page::Page>::alloc_page
ffff8000805b715c T <kernel::page::Page>::fill_zero_raw
ffff8000805b720c T <kernel::page::Page>::copy_from_user_slice_raw
ffff8000805b6fb4 T <kernel::page::Page>::read_raw
ffff8000805b7088 T <kernel::page::Page>::write_raw
ffff8000805b72fc T <kernel::page::Page as core::ops::drop::Drop>::drop

These Rust symbols are trivial wrappers around the C functions
alloc_pages, kunmap_local and __free_pages.
It doesn't make sense to go through a trivial wrapper for these
functions, so mark them inline.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
---
 rust/kernel/page.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index f6126aca33a6..e75cbc5cafd4 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -69,6 +69,7 @@ impl Page {
     /// let page = Page::alloc_page(GFP_KERNEL | __GFP_ZERO)?;
     /// # Ok::<(), kernel::alloc::AllocError>(())
     /// ```
+    #[inline]
     pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
         // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
         // is always safe to call this method.
@@ -170,6 +171,7 @@ fn with_pointer_into_page<T>(
     /// * Callers must ensure that `dst` is valid for writing `len` bytes.
     /// * Callers must ensure that this call does not race with a write to the same page that
     ///   overlaps with this read.
+    #[inline]
     pub unsafe fn read_raw(&self, dst: *mut u8, offset: usize, len: usize) -> Result {
         self.with_pointer_into_page(offset, len, move |src| {
             // SAFETY: If `with_pointer_into_page` calls into this closure, then
@@ -192,6 +194,7 @@ pub unsafe fn read_raw(&self, dst: *mut u8, offset: usize, len: usize) -> Result
     /// * Callers must ensure that `src` is valid for reading `len` bytes.
     /// * Callers must ensure that this call does not race with a read or write to the same page
     ///   that overlaps with this write.
+    #[inline]
     pub unsafe fn write_raw(&self, src: *const u8, offset: usize, len: usize) -> Result {
         self.with_pointer_into_page(offset, len, move |dst| {
             // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
@@ -212,6 +215,7 @@ pub unsafe fn write_raw(&self, src: *const u8, offset: usize, len: usize) -> Res
     ///
     /// Callers must ensure that this call does not race with a read or write to the same page that
     /// overlaps with this write.
+    #[inline]
     pub unsafe fn fill_zero_raw(&self, offset: usize, len: usize) -> Result {
         self.with_pointer_into_page(offset, len, move |dst| {
             // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
@@ -235,6 +239,7 @@ pub unsafe fn fill_zero_raw(&self, offset: usize, len: usize) -> Result {
     ///
     /// Callers must ensure that this call does not race with a read or write to the same page that
     /// overlaps with this write.
+    #[inline]
     pub unsafe fn copy_from_user_slice_raw(
         &self,
         reader: &mut UserSliceReader,
@@ -251,6 +256,7 @@ pub unsafe fn copy_from_user_slice_raw(
 }
 
 impl Drop for Page {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: By the type invariants, we have ownership of the page and can free it.
         unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
-- 
2.43.0



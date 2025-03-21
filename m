Return-Path: <linux-kernel+bounces-570882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16602A6B5C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A6D483587
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21C1F0E4C;
	Fri, 21 Mar 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HU3zTDFk"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426391EFFAD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544153; cv=none; b=dDRYX3PB1RGq2Ds29N8SpxmfOGRaQG6N/Z7gVQ/PVbI0PTwjzJ5Soxh/ctutOj/aAu/Mm80uOXp7VjT1mH/T3n6uxi2nGbz1fJar+DJgMDPL2gY5sSC18c4E329021wNipIiF1e1AY8x7Pc1unGRtZV6T7JNbgoMq9ZPG7udgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544153; c=relaxed/simple;
	bh=E/3xA5TSRplkqcvUWy2xH8YWhw0I/szCKQFmgqO5W1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtoYu3wmOjt+daK9Th2BXPQw2CYatdomK0b8/BbbARXQ+8uBIIjuu3PhtODftg0PoDP71haFqP0SsCFT/EnyREc7CndsTVJKB2usPzS87bq5x6i21hJUuxM79vgdDXSfWEp/9PbGQHVuwwCYd417fImoWVioxfpwCE4Y9qQVeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HU3zTDFk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742544139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M5i/nd2YL8RmqyaRGqU7qQe2+6A4Zpd/zpAtI9MB0u4=;
	b=HU3zTDFkcJOvYJTXaZJQ7JFJNmvrrrYlYjO5+jHb0byL1Rsq6z90YZH/783BxGh/e+zCBd
	vYLD/e+w/1DHmaxsn+Xqm05oG4ppONLzJGnOr5DU/gIjCxSvnd887GKG5piCGJX1+Ag4Qd
	1jeC+BvlUXpW/oGq3zTVbow/MiqDRy4=
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
Subject: [PATCH v2] rust: page:: optimize rust symbol generation for Page
Date: Fri, 21 Mar 2025 16:01:24 +0800
Message-ID: <20250321080124.484647-1-kunwu.chan@linux.dev>
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

These Rust symbols(alloc_page and drop) are trivial wrappers around the C
functions alloc_pages and __free_pages. It doesn't make sense to go
through a trivial wrapper for these functions, so mark them inline.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

---
Changes in v2:
- mark inline only for 'alloc_page' and 'drop'
- reword commit msg
---
 rust/kernel/page.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index f6126aca33a6..7c1b17246ed5 100644
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
@@ -251,6 +252,7 @@ pub unsafe fn copy_from_user_slice_raw(
 }
 
 impl Drop for Page {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: By the type invariants, we have ownership of the page and can free it.
         unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
-- 
2.43.0



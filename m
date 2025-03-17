Return-Path: <linux-kernel+bounces-563297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7924AA63CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A256188D9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1D414F125;
	Mon, 17 Mar 2025 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pdn2Eod9"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F554A24
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180715; cv=none; b=g6/xxKHc3+EwmTM+fYrNyIHxSfoMQ9dH//1UHK7XdrEDjrVGOAoW2GbRl4TlPxUWh6T/8lvrOv/wXE2yWS8nQv8OzH4xz7CSgIWdnBI6ySlHgyKXpjPSwgtdvh/+fwlgWh/yuEogqEPJyDMqERqJ6OkHDKx9Gdgh3vhC6ZcrvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180715; c=relaxed/simple;
	bh=tBWBQE8HpIVxEM5ccFjyfDv7HEXOnZryVAg4L2+2jpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S74xvyBq9OtJO8CUf4qFj0ImwjZ7zwCj6hOJBQrQoOQf6L8sH+wlosfIQYh3l96dCowTez0udO+worFwEPr0tR7kLe6JKJwJDhblDxJBhwo+5DJik8mLa7FfyKeWhC21huTCgLmeqknnNcBmMup06nRiA07Nco3uLFpcqifdYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pdn2Eod9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742180701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Gbw6EKbf2YDxk0S0ZIvcC7DhAFGYFGm30Q2QhYZ0bQ=;
	b=Pdn2Eod9REoIp2XQsoSuEg+GQZcCmherQGIQ029OAGNm0onEZZ+2hIVvF/w+/Ijvfmj5f3
	VfD8FcNWrplk+I/ZU8XRTElqFLadAmytmqu49hOS1gYv+SgiE2CfgPxJzED6Zrx0rGvoQ/
	QnEbjcSkQZMHVrrW+u13QTx/s9tPRRQ=
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
Subject: [PATCH v2] rust: optimize rust symbol generation for SeqFile
Date: Mon, 17 Mar 2025 11:04:18 +0800
Message-ID: <20250317030418.2371265-1-kunwu.chan@linux.dev>
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

$nm vmlinux | grep ' _R'.*SeqFile | rustfilt
ffff8000805b78ac T <kernel::seq_file::SeqFile>::call_printf

This Rust symbol is trivial wrappers around the C functions seq_printf.
It doesn't make sense to go through a trivial wrapper for its functions,
so mark it inline.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

---
Changes in v2:
 - Add link and Suggested-by
 - Reword commit msg
---
 rust/kernel/seq_file.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 04947c672979..efc4dd09850a 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -30,6 +30,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
     }
 
     /// Used by the [`seq_print`] macro.
+    #[inline]
     pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
         // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
         unsafe {
-- 
2.43.0



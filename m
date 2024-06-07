Return-Path: <linux-kernel+bounces-206695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD45900CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C331C21429
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33468154422;
	Fri,  7 Jun 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gxJTMEjj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nofRIHje"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB719D89B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791738; cv=none; b=cKyvjZjI0m0DjCkpJo4czbn2HwbeEH4QvTl/um+j5CTHKBLD6hf5asbUywGCqJkdu5E2Lr94hsyR1lNrEYgWkNm6ZT5qwJiCD0MYVgWkYZtcSt5PeC/rAuR0LTF9Eb+poVKWUCSJwvTumpAIfN1mP2fxPrUGkkroOJMwmnhOvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791738; c=relaxed/simple;
	bh=4itJeOheO3JCFGYjJsZp2HHj1O9EEO4G3V4kY2AsiVY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQJDACHUU8r+Y4IrleV/8QDP6UtEPmE+O5NlZlYOQDFkGtRREKwRfR1sbRzuQK5OonHyWbAPfX8EWP+TK9TYEDm4zSy0Raz3fNctEC+ktUVVnbRKMsfyEv2jroDySTHOgXeOsjtHsEw+9SghgCrXrVhKYpZegFd8PvAnbFDzYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gxJTMEjj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nofRIHje; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAfTfmpszFUN8R3pQgNHXaFB8SYv5tBzsg3wc1Daekc=;
	b=gxJTMEjjVsWUXg8QWo8gxk6k6dsK1gOSK8tiVKXP5qTp34PYDSnja7IWgElhx75fYN8tr7
	l602j9hesKQoFFE2N+sl62RFmCbIAC0er2w8jwhGeizfJq0wTou/jxVaJ1FadOiltK1VKX
	mcw5Rniv4bObsJlZxU8kgMXDshp4S1YlKAr9hSGIYjtvYhtc0GdU02f39XNFsYilbM8wPw
	8312nbySFzXFPtx2L5HiG5xwvnjOED8vhNJIuLQKM0leerlH6gIu/tvcYgkthd7LTenxky
	hpaTZounjSwIpPUegA0PssykWkUF8peu71Z3b+LJhdcbDj53w6X7d92mtiyK2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAfTfmpszFUN8R3pQgNHXaFB8SYv5tBzsg3wc1Daekc=;
	b=nofRIHje+QL9kJv7xuUmmYgeTzznlDF8UquGUkvpWA1FtPDrwMFpZchdLaVXLfcVSs9T73
	K/C9iB3wE69jeUCg==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
Date: Fri,  7 Jun 2024 22:22:09 +0200
Message-Id: <dba0409518b14ee83b346e099b1f7f934daf7b74.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XIP_OFFSET is the hard-coded offset of writable data section within the
kernel.

By hard-coding this value, the read-only section of the kernel (which is
placed before the writable data section) is restricted in size.

As a preparation to remove this hard-coded macro XIP_OFFSET entirely, stop
using XIP_OFFSET in XIP_FIXUP_OFFSET. Instead, use CONFIG_PHYS_RAM_BASE and
_sdata to do the same thing.

While at it, also add a description for XIP_FIXUP_OFFSET.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/xip_fixup.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
index b65bf6306f69..9ed2cfae09e0 100644
--- a/arch/riscv/include/asm/xip_fixup.h
+++ b/arch/riscv/include/asm/xip_fixup.h
@@ -9,8 +9,19 @@
 
 #ifdef CONFIG_XIP_KERNEL
 .macro XIP_FIXUP_OFFSET reg
-        REG_L t0, _xip_fixup
+	/* Fix-up address in Flash into address in RAM early during boot before
+	 * MMU is up. Because generated code "thinks" data is in Flash, but it
+	 * is actually in RAM (actually data is also in Flash, but Flash is
+	 * read-only, thus we need to use the data residing in RAM).
+	 *
+	 * The start of data in Flash is _sdata and the start of data in RAM is
+	 * CONFIG_PHYS_RAM_BASE. So this fix-up essentially does this:
+	 * reg += CONFIG_PHYS_RAM_BASE - _start
+	 */
+	li t0, CONFIG_PHYS_RAM_BASE
         add \reg, \reg, t0
+	la t0, _sdata
+	sub \reg, \reg, t0
 .endm
 .macro XIP_FIXUP_FLASH_OFFSET reg
 	la t0, __data_loc
@@ -19,7 +30,6 @@
 	add \reg, \reg, t0
 .endm
 
-_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
 _xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
 #else
 .macro XIP_FIXUP_OFFSET reg
-- 
2.39.2



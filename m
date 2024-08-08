Return-Path: <linux-kernel+bounces-279488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44B94BDE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD137B259E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB58190061;
	Thu,  8 Aug 2024 12:43:22 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7B18FDA3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121002; cv=none; b=svdAsSCd+CNnZK/NvT9TEvg/rrrzEPOZjP1Y/+cMGd7CcuwM+R9etBJ/N79DT568bo7akJ3/mevwKUjWKfRyKns2LphGF0qddfDbdkYFCXo98+CeU/aZOsCGTVaIxuWqYxZgnPeOYTSo1s7HSFEGmssZfeyfnJTg6u4u8cqoXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121002; c=relaxed/simple;
	bh=FM5nTZCbakU/OFTUkZ/UmUGvxQS3+8cm7+rI1a5Gsk8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=slrIqdSDnwv89M/TFahIB287m6VhfaEsEGJFFV/JMKoZleX3UWNG2u9egYaNApx2QhkejHFenzsd9tECNCfJA46kGA3VKiJwgnci8E6kEHUUWUN6MESIDGYwne0xlk6j+6y0Y99RjLcnSJCbCUl5Gbt2LhUtpBFdyBDVOLRholg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wfmsr47jJz1T6t0;
	Thu,  8 Aug 2024 20:42:56 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DF4B1800FF;
	Thu,  8 Aug 2024 20:43:18 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 Aug
 2024 20:43:17 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <arnd@arndb.de>, <mail2hgg@gmail.com>,
	<afd@ti.com>, <rmk+kernel@armlinux.org.uk>, <linus.walleij@linaro.org>,
	<akpm@linux-foundation.org>, <eric.devolder@oracle.com>,
	<masahiroy@kernel.org>, <liuyuntao12@huawei.com>
Subject: [PATCH] arm: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION
Date: Thu, 8 Aug 2024 12:35:56 +0000
Message-ID: <20240808123556.681609-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500010.china.huawei.com (7.202.181.71)

There is a build issue with LD segmentation fault, while
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled, as bellow.

scripts/link-vmlinux.sh: line 49:  3796 Segmentation fault
 (core dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive
 ${objs} ${wl}--no-whole-archive ${wl}--start-group
 ${libs} ${wl}--end-group ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}

The error occurs in older versions of the GNU ld with version earlier
than 2.36. It makes most sense to have a minimum LD version as
a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION and eliminate
the impact of ".reloc  .text, R_ARM_NONE, ." when
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.

Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
Reported-by: Harith George <mail2hgg@gmail.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
Link: https://lore.kernel.org/all/14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com/
---
 arch/arm/Kconfig             |  2 +-
 arch/arm/kernel/entry-armv.S | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54b2bb817a7f..173159e93c99 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -117,7 +117,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index f01d23a220e6..cd443faf8645 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -29,6 +29,12 @@
 #include "entry-header.S"
 #include <asm/probes.h>
 
+#ifdef CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION
+#define RELOC_TEXT_NONE (.reloc  .text, R_ARM_NONE, .)
+#else
+#define RELOC_TEXT_NONE
+#endif
+
 /*
  * Interrupt handling.
  */
@@ -1065,7 +1071,7 @@ vector_addrexcptn:
 	.globl	vector_fiq
 
 	.section .vectors, "ax", %progbits
-	.reloc  .text, R_ARM_NONE, .
+	RELOC_TEXT_NONE
 	W(b)	vector_rst
 	W(b)	vector_und
 ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_swi		)
@@ -1079,7 +1085,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, .L__vector_swi		)
 
 #ifdef CONFIG_HARDEN_BRANCH_HISTORY
 	.section .vectors.bhb.loop8, "ax", %progbits
-	.reloc  .text, R_ARM_NONE, .
+	RELOC_TEXT_NONE
 	W(b)	vector_rst
 	W(b)	vector_bhb_loop8_und
 ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_loop8_swi	)
@@ -1092,7 +1098,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, .L__vector_bhb_loop8_swi	)
 	W(b)	vector_bhb_loop8_fiq
 
 	.section .vectors.bhb.bpiall, "ax", %progbits
-	.reloc  .text, R_ARM_NONE, .
+	RELOC_TEXT_NONE
 	W(b)	vector_rst
 	W(b)	vector_bhb_bpiall_und
 ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_bpiall_swi	)
-- 
2.34.1



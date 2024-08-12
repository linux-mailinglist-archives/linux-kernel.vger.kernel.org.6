Return-Path: <linux-kernel+bounces-282755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB40A94E835
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79633282641
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9357165EF0;
	Mon, 12 Aug 2024 08:05:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2D15C150
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449953; cv=none; b=ZkEovIqrRacXJyxKbxhpki6TYv6MY6IfVaG4/uf36MuBtzLF7ZZVujFXANlpNGX+/6CfueBWmVl5aInHIA7jO0p849U7TNnGlc+UzHYWryQJhkcJ7gBiaNC+WtdoZp4AjK4rHD1I1RY9KVwOwpWkrWchN2RHflk1knkFJiVms84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449953; c=relaxed/simple;
	bh=MLi1utGB0qJgfWKuS9YfyIw8SZmmrip3Wo/QGBMUuJQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XxIX/GsuNmAm14PL1zIAKxgWKZmFC6nN+ZuHczqiIRIbV4K5yK7cvyT1U1ful2+8pa64DlpIhgXNsTlG8DfyVB10nQKA5H/Xr+lkXI8jZUsKXZ0+F+cVFcwTiIy/lPFM+AwWB0hlN8eKzw9m7o/oO4gLEFFX0L9YHvvf6peV7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wj6V62d81zpTS2;
	Mon, 12 Aug 2024 16:03:58 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DCDB5180101;
	Mon, 12 Aug 2024 16:05:15 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Aug
 2024 16:05:15 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <arnd@arndb.de>, <mail2hgg@gmail.com>,
	<afd@ti.com>, <rmk+kernel@armlinux.org.uk>, <linus.walleij@linaro.org>,
	<akpm@linux-foundation.org>, <eric.devolder@oracle.com>,
	<masahiroy@kernel.org>, <liuyuntao12@huawei.com>
Subject: [PATCH] arm: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION
Date: Mon, 12 Aug 2024 07:57:50 +0000
Message-ID: <20240812075750.711240-1-liuyuntao12@huawei.com>
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
Tested-by: Harith George <mail2hgg@gmail.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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



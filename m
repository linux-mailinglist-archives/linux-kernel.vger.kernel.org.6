Return-Path: <linux-kernel+bounces-218849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B290890C6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA277B21BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCF1A3BAA;
	Tue, 18 Jun 2024 08:17:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0413A272;
	Tue, 18 Jun 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698623; cv=none; b=IdivjpTPa7dUk1aLYZaz3Eb4/gXdwZNSSSSeg1GdRIZBIGwlN1VjqdHoeGkIM4RpzcX/0rd9Y5mAp+g75NpmPz55cbCIg6kWtDHhbtyODcJ9MvIeB943Y1XpkYZAw6K/kfn5fotAnpPtzLTNA1EbL8JY1cKDtB9yiYoOCNq4dxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698623; c=relaxed/simple;
	bh=AoCa38aUdmoE9HAww4InUUIsc7qU2hFPBdkuMc9lwrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbE2YXg8syTRrU3iQtSYq4agX5CGkIxyA4fYS0wZSeY71IKbyEJRt4yd68bDgRxOZtVHsAPfbaOt8wGmMXMs9o7F4W0bO4WaicY7LPHZ/TjVfOopeSPCHA1tsVGlOjZDvCYgDB82Woqnu68QjtRD7EYBs0gMHH/urnMDjA9+3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B628C4AF1D;
	Tue, 18 Jun 2024 08:17:01 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add writecombine support for DMW-based ioremap()
Date: Tue, 18 Jun 2024 16:16:54 +0800
Message-ID: <20240618081654.3997038-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, only TLB-based ioremap() support writecombine, so add the
counterpart for DMW-based ioremap() with help of DMW2. The base address
(WRITECOMBINE_BASE) is configured as 0xa000000000000000.

DMW3 is unused by kernel now, however firmware may leave garbage in them
and interfere kernel's address mapping. So clear it as necessary.

BTW, centralize the DMW configuration to macro SETUP_DMWINS.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/addrspace.h   |  4 ++++
 arch/loongarch/include/asm/io.h          | 10 ++++++++--
 arch/loongarch/include/asm/loongarch.h   | 10 +++++++++-
 arch/loongarch/include/asm/stackframe.h  | 11 +++++++++++
 arch/loongarch/kernel/head.S             | 12 ++----------
 arch/loongarch/power/suspend_asm.S       |  6 +-----
 drivers/firmware/efi/libstub/loongarch.c |  2 ++
 7 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index 7bd47d65bf7a..fe198b473f84 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -37,6 +37,10 @@ extern unsigned long vm_map_base;
 #define UNCACHE_BASE		CSR_DMW0_BASE
 #endif
 
+#ifndef WRITECOMBINE_BASE
+#define WRITECOMBINE_BASE	CSR_DMW2_BASE
+#endif
+
 #define DMW_PABITS	48
 #define TO_PHYS_MASK	((1ULL << DMW_PABITS) - 1)
 
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index c2f9979b2979..5e95a60df180 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -25,10 +25,16 @@ extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 					 unsigned long prot_val)
 {
-	if (prot_val & _CACHE_CC)
+	switch (prot_val & _CACHE_MASK) {
+	case _CACHE_CC:
 		return (void __iomem *)(unsigned long)(CACHE_BASE + offset);
-	else
+	case _CACHE_SUC:
 		return (void __iomem *)(unsigned long)(UNCACHE_BASE + offset);
+	case _CACHE_WUC:
+		return (void __iomem *)(unsigned long)(WRITECOMBINE_BASE + offset);
+	default:
+		return NULL;
+	}
 }
 
 #define ioremap(offset, size)		\
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index eb09adda54b7..c430df595376 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -877,7 +877,7 @@
 #define LOONGARCH_CSR_DMWIN2		0x182	/* 64 direct map win2: MEM */
 #define LOONGARCH_CSR_DMWIN3		0x183	/* 64 direct map win3: MEM */
 
-/* Direct Map window 0/1 */
+/* Direct Map window 0/1/2/3 */
 #define CSR_DMW0_PLV0		_CONST64_(1 << 0)
 #define CSR_DMW0_VSEG		_CONST64_(0x8000)
 #define CSR_DMW0_BASE		(CSR_DMW0_VSEG << DMW_PABITS)
@@ -889,6 +889,14 @@
 #define CSR_DMW1_BASE		(CSR_DMW1_VSEG << DMW_PABITS)
 #define CSR_DMW1_INIT		(CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_DMW1_PLV0)
 
+#define CSR_DMW2_PLV0		_CONST64_(1 << 0)
+#define CSR_DMW2_MAT		_CONST64_(2 << 4)
+#define CSR_DMW2_VSEG		_CONST64_(0xa000)
+#define CSR_DMW2_BASE		(CSR_DMW2_VSEG << DMW_PABITS)
+#define CSR_DMW2_INIT		(CSR_DMW2_BASE | CSR_DMW2_MAT | CSR_DMW2_PLV0)
+
+#define CSR_DMW3_INIT		0x0
+
 /* Performance Counter registers */
 #define LOONGARCH_CSR_PERFCTRL0		0x200	/* 32 perf event 0 config */
 #define LOONGARCH_CSR_PERFCNTR0		0x201	/* 64 perf event 0 count value */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index d9eafd3ee3d1..66736837085b 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -38,6 +38,17 @@
 	cfi_restore \reg \offset \docfi
 	.endm
 
+	.macro SETUP_DMWINS temp
+	li.d	\temp, CSR_DMW0_INIT	# WUC, PLV0, 0x8000 xxxx xxxx xxxx
+	csrwr	\temp, LOONGARCH_CSR_DMWIN0
+	li.d	\temp, CSR_DMW1_INIT	# CAC, PLV0, 0x9000 xxxx xxxx xxxx
+	csrwr	\temp, LOONGARCH_CSR_DMWIN1
+	li.d	\temp, CSR_DMW2_INIT	# WUC, PLV0, 0xa000 xxxx xxxx xxxx
+	csrwr	\temp, LOONGARCH_CSR_DMWIN2
+	li.d	\temp, CSR_DMW3_INIT	# 0x0, unused
+	csrwr	\temp, LOONGARCH_CSR_DMWIN3
+	.endm
+
 /* Jump to the runtime virtual address. */
 	.macro JUMP_VIRT_ADDR temp1 temp2
 	li.d	\temp1, CACHE_BASE
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 4677ea8fa8e9..fdb831dc64df 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -44,11 +44,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
 SYM_CODE_START(kernel_entry)			# kernel entry point
 
 	/* Config direct window and set PG */
-	li.d		t0, CSR_DMW0_INIT	# UC, PLV0, 0x8000 xxxx xxxx xxxx
-	csrwr		t0, LOONGARCH_CSR_DMWIN0
-	li.d		t0, CSR_DMW1_INIT	# CA, PLV0, 0x9000 xxxx xxxx xxxx
-	csrwr		t0, LOONGARCH_CSR_DMWIN1
-
+	SETUP_DMWINS	t0
 	JUMP_VIRT_ADDR	t0, t1
 
 	/* Enable PG */
@@ -124,11 +120,7 @@ SYM_CODE_END(kernel_entry)
  * function after setting up the stack and tp registers.
  */
 SYM_CODE_START(smpboot_entry)
-	li.d		t0, CSR_DMW0_INIT	# UC, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN0
-	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN1
-
+	SETUP_DMWINS	t0
 	JUMP_VIRT_ADDR	t0, t1
 
 #ifdef CONFIG_PAGE_SIZE_4KB
diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
index e2fc3b4e31f0..c28ad52b7baf 100644
--- a/arch/loongarch/power/suspend_asm.S
+++ b/arch/loongarch/power/suspend_asm.S
@@ -73,11 +73,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
 	 * Reload all of the registers and return.
 	 */
 SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
-	li.d		t0, CSR_DMW0_INIT	# UC, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN0
-	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
-	csrwr		t0, LOONGARCH_CSR_DMWIN1
-
+	SETUP_DMWINS	t0
 	JUMP_VIRT_ADDR	t0, t1
 
 	/* Enable PG */
diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index d0ef93551c44..3782d0a187d1 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -74,6 +74,8 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	/* Config Direct Mapping */
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
+	csr_write64(CSR_DMW2_INIT, LOONGARCH_CSR_DMWIN2);
+	csr_write64(CSR_DMW3_INIT, LOONGARCH_CSR_DMWIN3);
 
 	real_kernel_entry = (void *)kernel_entry_address(kernel_addr, image);
 
-- 
2.43.0



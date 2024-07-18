Return-Path: <linux-kernel+bounces-255952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA09346F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24859B22DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7960537FF;
	Thu, 18 Jul 2024 03:50:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEEB3E467
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274655; cv=none; b=n9MfXJXgyAFGevSHtCDjbKYJz7gpMJGYl5TSPhXa3oFQle79nIw7H8BBPCX9i/OZq+hg+8onLuaE010fgP+lKsh8VcRoCAMHkdMV6KmKQWDnYqg3t2uz4L8yJ2RthRWwySISG8nOJLpJvCXYykabAxVnYQp1MLlHlsWl6v42t0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274655; c=relaxed/simple;
	bh=gy9A20lnG3pP6r6xE3X4+301VNj3pLy98wlQHCj6+nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UK7mdAgH21yvgP6evGMpTXkG+Q0GVIwD0n2FLBQBt2ZofkMBv2ZJXIlF5qzRk+zNvWxolf34IjqQgL1KAlj+IPpqGvZ571LTypJPbqGPjsw5bv+1TjllI7DElv5cy4s5tQkE1aD1L3wNYUNctbdWI6qbrLp2JjiZGx8DcPLkdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WPf1Z1J4nzdhdQ;
	Thu, 18 Jul 2024 11:49:06 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 42D43180105;
	Thu, 18 Jul 2024 11:50:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 11:50:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <arnd@arndb.de>, <afd@ti.com>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>,
	<javierm@redhat.com>, <deller@gmx.de>, <robh@kernel.org>,
	<hbathini@linux.ibm.com>, <thunder.leizhen@huawei.com>,
	<chenjiahao16@huawei.com>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 3/3] ARM: Use generic interface to simplify crashkernel reservation
Date: Thu, 18 Jul 2024 11:54:44 +0800
Message-ID: <20240718035444.2977105-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718035444.2977105-1-ruanjinjie@huawei.com>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently, x86, arm64, riscv and loongarch has been switched to generic
crashkernel reservation, which is also ready for 32bit system.
So with the help of function parse_crashkernel() and generic
reserve_crashkernel_generic(), arm32 crashkernel reservation can also
be simplified by steps:

1) Add a new header file <asm/crash_reserve.h>, and define CRASH_ALIGN,
   CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX in it;

2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
   reserve_crashkernel_generic();

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/arm/Kconfig.

The old reserve_crashkernel() can be removed.

Following test cases have been performed as expected on QEMU vexpress-a9
(1GB system memory):

1) crashkernel=4G,high				// invalid
2) crashkernel=1G,high				// invalid
3) crashkernel=1G,high crashkernel=0M,low	// invalid
4) crashkernel=256M,high			// invalid
5) crashkernel=256M,low				// invalid
6) crashkernel=256M crashkernel=256M,high	// high is ignored, ok
7) crashkernel=256M crashkernel=256M,low	// low is ignored, ok
8) crashkernel=256M,high crashkernel=256M,low	// invalid
9) crashkernel=256M,high crashkernel=4G,low	// invalid
10) crashkernel=256M				// ok
11) crashkernel=512M				// ok
12) crashkernel=256M@0x88000000			// ok
13) crashkernel=256M@0x78000000			// ok
14) crashkernel=512M@0x78000000			// ok

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Update the commit message.
---
 arch/arm/Kconfig                     |  3 ++
 arch/arm/include/asm/crash_reserve.h | 24 +++++++++++
 arch/arm/kernel/setup.c              | 63 ++++------------------------
 3 files changed, 36 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/include/asm/crash_reserve.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f434afff4a2c..3f198ae63950 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1597,6 +1597,9 @@ config ATAGS_PROC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_RESERVE
+
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
 	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
diff --git a/arch/arm/include/asm/crash_reserve.h b/arch/arm/include/asm/crash_reserve.h
new file mode 100644
index 000000000000..85c9298bd3b7
--- /dev/null
+++ b/arch/arm/include/asm/crash_reserve.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ARM_CRASH_RESERVE_H
+#define _ARM_CRASH_RESERVE_H
+
+/*
+ * The crash region must be aligned to 128MB to avoid
+ * zImage relocating below the reserved region.
+ */
+#define CRASH_ALIGN			(128 << 20)
+
+#define CRASH_ADDR_LOW_MAX		crash_addr_low_max()
+#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
+
+static inline unsigned long crash_addr_low_max(void)
+{
+	unsigned long long crash_max = idmap_to_phys((u32)~0);
+	unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
+
+	return (crash_max > lowmem_max) ? lowmem_max : crash_max;
+}
+
+
+#define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+#endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e6a857bf0ce6..fc0ada003f6d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -979,13 +979,6 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
-#ifdef CONFIG_CRASH_RESERVE
-/*
- * The crash region must be aligned to 128MB to avoid
- * zImage relocating below the reserved region.
- */
-#define CRASH_ALIGN	(128 << 20)
-
 static inline unsigned long long get_total_mem(void)
 {
 	unsigned long total;
@@ -994,60 +987,25 @@ static inline unsigned long long get_total_mem(void)
 	return total << PAGE_SHIFT;
 }
 
-/**
- * reserve_crashkernel() - reserves memory are for crash kernel
- *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by a dump capture kernel when
- * primary kernel is crashing.
- */
-static void __init reserve_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base;
+	unsigned long long crash_size, crash_base, low_size = 0;
 	unsigned long long total_mem;
+	bool high = false;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
-				NULL, NULL);
+				&low_size, &high);
 	/* invalid value specified or crashkernel=0 */
 	if (ret || !crash_size)
 		return;
 
-	if (crash_base <= 0) {
-		unsigned long long crash_max = idmap_to_phys((u32)~0);
-		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
-		if (crash_max > lowmem_max)
-			crash_max = lowmem_max;
-
-		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-						       CRASH_ALIGN, crash_max);
-		if (!crash_base) {
-			pr_err("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long crash_max = crash_base + crash_size;
-		unsigned long long start;
-
-		start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
-						  crash_base, crash_max);
-		if (!start) {
-			pr_err("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
-
-	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
-		(unsigned long)(crash_size >> 20),
-		(unsigned long)(crash_base >> 20),
-		(unsigned long)(total_mem >> 20));
-
-	/* The crashk resource must always be located in normal mem */
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	reserve_crashkernel_generic(boot_command_line, crash_size, crash_base, low_size, high);
 
 	if (arm_has_idmap_alias()) {
 		/*
@@ -1064,9 +1022,6 @@ static void __init reserve_crashkernel(void)
 		insert_resource(&iomem_resource, &crashk_boot_res);
 	}
 }
-#else
-static inline void reserve_crashkernel(void) {}
-#endif /* CONFIG_CRASH_RESERVE*/
 
 void __init hyp_mode_check(void)
 {
@@ -1189,7 +1144,7 @@ void __init setup_arch(char **cmdline_p)
 	if (!is_smp())
 		hyp_mode_check();
 
-	reserve_crashkernel();
+	arch_reserve_crashkernel();
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-- 
2.34.1



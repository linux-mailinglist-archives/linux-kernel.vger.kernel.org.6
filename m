Return-Path: <linux-kernel+bounces-175785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2138C24F1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1DE1C22A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEE4C2ED;
	Fri, 10 May 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfukOgBU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5101BC40
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344364; cv=none; b=PmD+cHXzdWJ1aEfP/irflo0rO8b/YPwtH11nmySwmWjYT2qzdE6e/1HBFDV7MDvSC+cB6Hj0rhZdKONei/r52LxBo64LRF9XjP5o+MsaCEoDDNSEEAdGwP1EN4fweS+aLafLOH4HUXZIf2vYOw2TMVvSqnfvghs9XC89Q2IuRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344364; c=relaxed/simple;
	bh=1JVkWGBb4xNq9JLM6nGc3zJQhaIPb9BuvKd9NEhVO5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDKgE4nrFn4c6L/SjPeEnM4Qcr/0hwubmNBpFb4e/MXyBlVPDgbqWPlbbfzHOhjbIP+oxUpK4bkX/Umf15x6MFPD88d+HVfexXd87QGUqdJvY7cLvAfvsxa6hGf+IIjyeVUup2vZ9h3+zZI6+ETJYwwF8P2B7IFX0adTA/W+V+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfukOgBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E7C113CC;
	Fri, 10 May 2024 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715344364;
	bh=1JVkWGBb4xNq9JLM6nGc3zJQhaIPb9BuvKd9NEhVO5s=;
	h=From:To:Cc:Subject:Date:From;
	b=jfukOgBU5Go3kzsy1k79tgR7SJC3YN3gh6koQv+WG2sKoVEL5ilt8DDFOsR0mpQYf
	 x0MERiBfFJcfSKRbnoUlCRYsgBdOh+kQKu9otcQhQke5kUtDbGMlrFSl98Xij3N/Rk
	 sTt2HBxY2ZEvJXQdJglLrgnl/9dgQgNRm7i4PD254ysUax/CiLDgkjJ+VzijBsnP2j
	 wqqpAV1BOXMXHfY0AM2hCTq9r/Cg6C5ykg3oC9fpOsq3Ya+CC14PJ9vKDjhpxAEmDJ
	 VyFcqBmYseKZCogmZKn3sd0NZ15Q0JDuX4Ab6wSbPhXVWpZb+qbBlTNrnOEeiMVh/8
	 R44ebbdmQJYNA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm: vexpress: Remove obsolete RTSM DCSCB support
Date: Fri, 10 May 2024 07:32:35 -0500
Message-ID: <20240510123238.3904779-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm Versatile DCSCB support is unused as the compatible
"arm,rtsm,dcscb" is unused in any .dts file. It was only ever
implemented on a s/w model (RTSM).

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/configs/vexpress_defconfig   |   1 -
 arch/arm/mach-versatile/Kconfig       |   9 --
 arch/arm/mach-versatile/Makefile      |   3 -
 arch/arm/mach-versatile/dcscb.c       | 173 --------------------------
 arch/arm/mach-versatile/dcscb_setup.S |  33 -----
 5 files changed, 219 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/dcscb.c
 delete mode 100644 arch/arm/mach-versatile/dcscb_setup.S

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index 96ad442089bd..cdb6065e04fd 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -14,7 +14,6 @@ CONFIG_CPUSETS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_VEXPRESS=y
-CONFIG_ARCH_VEXPRESS_DCSCB=y
 CONFIG_ARCH_VEXPRESS_TC2_PM=y
 CONFIG_SMP=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index e029270c2687..513618078440 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -278,15 +278,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	  build a working kernel, you must also enable relevant core
 	  tile support or Flattened Device Tree based support options.
 
-config ARCH_VEXPRESS_DCSCB
-	bool "Dual Cluster System Control Block (DCSCB) support"
-	depends on MCPM
-	select ARM_CCI400_PORT_CTRL
-	help
-	  Support for the Dual Cluster System Configuration Block (DCSCB).
-	  This is needed to provide CPU and cluster power management
-	  on RTSM implementing big.LITTLE.
-
 config ARCH_VEXPRESS_SPC
 	bool "Versatile Express Serial Power Controller (SPC)"
 	select PM_OPP
diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index 27d712bcf1af..d819fb2fc450 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -16,9 +16,6 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= realview.o
 
 # vexpress
 obj-$(CONFIG_ARCH_VEXPRESS)		:= v2m.o
-obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
-CFLAGS_dcscb.o				+= -march=armv7-a
-CFLAGS_REMOVE_dcscb.o			= -pg
 obj-$(CONFIG_ARCH_VEXPRESS_SPC)		+= spc.o
 CFLAGS_REMOVE_spc.o			= -pg
 obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
diff --git a/arch/arm/mach-versatile/dcscb.c b/arch/arm/mach-versatile/dcscb.c
deleted file mode 100644
index d8797350996d..000000000000
--- a/arch/arm/mach-versatile/dcscb.c
+++ /dev/null
@@ -1,173 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * dcscb.c - Dual Cluster System Configuration Block
- *
- * Created by:	Nicolas Pitre, May 2012
- * Copyright:	(C) 2012-2013  Linaro Limited
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/errno.h>
-#include <linux/of_address.h>
-#include <linux/vexpress.h>
-#include <linux/arm-cci.h>
-
-#include <asm/mcpm.h>
-#include <asm/proc-fns.h>
-#include <asm/cacheflush.h>
-#include <asm/cputype.h>
-#include <asm/cp15.h>
-
-#include "vexpress.h"
-
-#define RST_HOLD0	0x0
-#define RST_HOLD1	0x4
-#define SYS_SWRESET	0x8
-#define RST_STAT0	0xc
-#define RST_STAT1	0x10
-#define EAG_CFG_R	0x20
-#define EAG_CFG_W	0x24
-#define KFC_CFG_R	0x28
-#define KFC_CFG_W	0x2c
-#define DCS_CFG_R	0x30
-
-static void __iomem *dcscb_base;
-static int dcscb_allcpus_mask[2];
-
-static int dcscb_cpu_powerup(unsigned int cpu, unsigned int cluster)
-{
-	unsigned int rst_hold, cpumask = (1 << cpu);
-
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	if (cluster >= 2 || !(cpumask & dcscb_allcpus_mask[cluster]))
-		return -EINVAL;
-
-	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-	rst_hold &= ~(cpumask | (cpumask << 4));
-	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
-	return 0;
-}
-
-static int dcscb_cluster_powerup(unsigned int cluster)
-{
-	unsigned int rst_hold;
-
-	pr_debug("%s: cluster %u\n", __func__, cluster);
-	if (cluster >= 2)
-		return -EINVAL;
-
-	/* remove cluster reset and add individual CPU's reset */
-	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-	rst_hold &= ~(1 << 8);
-	rst_hold |= dcscb_allcpus_mask[cluster];
-	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
-	return 0;
-}
-
-static void dcscb_cpu_powerdown_prepare(unsigned int cpu, unsigned int cluster)
-{
-	unsigned int rst_hold;
-
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	BUG_ON(cluster >= 2 || !((1 << cpu) & dcscb_allcpus_mask[cluster]));
-
-	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-	rst_hold |= (1 << cpu);
-	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
-}
-
-static void dcscb_cluster_powerdown_prepare(unsigned int cluster)
-{
-	unsigned int rst_hold;
-
-	pr_debug("%s: cluster %u\n", __func__, cluster);
-	BUG_ON(cluster >= 2);
-
-	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-	rst_hold |= (1 << 8);
-	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
-}
-
-static void dcscb_cpu_cache_disable(void)
-{
-	/* Disable and flush the local CPU cache. */
-	v7_exit_coherency_flush(louis);
-}
-
-static void dcscb_cluster_cache_disable(void)
-{
-	/* Flush all cache levels for this cluster. */
-	v7_exit_coherency_flush(all);
-
-	/*
-	 * A full outer cache flush could be needed at this point
-	 * on platforms with such a cache, depending on where the
-	 * outer cache sits. In some cases the notion of a "last
-	 * cluster standing" would need to be implemented if the
-	 * outer cache is shared across clusters. In any case, when
-	 * the outer cache needs flushing, there is no concurrent
-	 * access to the cache controller to worry about and no
-	 * special locking besides what is already provided by the
-	 * MCPM state machinery is needed.
-	 */
-
-	/*
-	 * Disable cluster-level coherency by masking
-	 * incoming snoops and DVM messages:
-	 */
-	cci_disable_port_by_cpu(read_cpuid_mpidr());
-}
-
-static const struct mcpm_platform_ops dcscb_power_ops = {
-	.cpu_powerup		= dcscb_cpu_powerup,
-	.cluster_powerup	= dcscb_cluster_powerup,
-	.cpu_powerdown_prepare	= dcscb_cpu_powerdown_prepare,
-	.cluster_powerdown_prepare = dcscb_cluster_powerdown_prepare,
-	.cpu_cache_disable	= dcscb_cpu_cache_disable,
-	.cluster_cache_disable	= dcscb_cluster_cache_disable,
-};
-
-extern void dcscb_power_up_setup(unsigned int affinity_level);
-
-static int __init dcscb_init(void)
-{
-	struct device_node *node;
-	unsigned int cfg;
-	int ret;
-
-	if (!cci_probed())
-		return -ENODEV;
-
-	node = of_find_compatible_node(NULL, NULL, "arm,rtsm,dcscb");
-	if (!node)
-		return -ENODEV;
-	dcscb_base = of_iomap(node, 0);
-	of_node_put(node);
-	if (!dcscb_base)
-		return -EADDRNOTAVAIL;
-	cfg = readl_relaxed(dcscb_base + DCS_CFG_R);
-	dcscb_allcpus_mask[0] = (1 << (((cfg >> 16) >> (0 << 2)) & 0xf)) - 1;
-	dcscb_allcpus_mask[1] = (1 << (((cfg >> 16) >> (1 << 2)) & 0xf)) - 1;
-
-	ret = mcpm_platform_register(&dcscb_power_ops);
-	if (!ret)
-		ret = mcpm_sync_init(dcscb_power_up_setup);
-	if (ret) {
-		iounmap(dcscb_base);
-		return ret;
-	}
-
-	pr_info("VExpress DCSCB support installed\n");
-
-	/*
-	 * Future entries into the kernel can now go
-	 * through the cluster entry vectors.
-	 */
-	vexpress_flags_set(__pa_symbol(mcpm_entry_point));
-
-	return 0;
-}
-
-early_initcall(dcscb_init);
diff --git a/arch/arm/mach-versatile/dcscb_setup.S b/arch/arm/mach-versatile/dcscb_setup.S
deleted file mode 100644
index 92d1fd9d7f6a..000000000000
--- a/arch/arm/mach-versatile/dcscb_setup.S
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Created by:  Dave Martin, 2012-06-22
- * Copyright:   (C) 2012-2013  Linaro Limited
- */
-
-#include <linux/linkage.h>
-
-
-ENTRY(dcscb_power_up_setup)
-
-	cmp	r0, #0			@ check affinity level
-	beq	2f
-
-/*
- * Enable cluster-level coherency, in preparation for turning on the MMU.
- * The ACTLR SMP bit does not need to be set here, because cpu_resume()
- * already restores that.
- *
- * A15/A7 may not require explicit L2 invalidation on reset, dependent
- * on hardware integration decisions.
- * For now, this code assumes that L2 is either already invalidated,
- * or invalidation is not required.
- */
-
-	b	cci_enable_port_for_self
-
-2:	@ Implementation-specific local CPU setup operations should go here,
-	@ if any.  In this case, there is nothing to do.
-
-	bx	lr
-
-ENDPROC(dcscb_power_up_setup)
-- 
2.43.0



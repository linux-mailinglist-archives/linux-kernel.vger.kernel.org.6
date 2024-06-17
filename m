Return-Path: <linux-kernel+bounces-217195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AA90ACBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537E61F21BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A59194C8B;
	Mon, 17 Jun 2024 11:18:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2427D194C63
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623137; cv=none; b=sXQgXGN+klJKN6Xeo/Q5nigBbUqqVih1IQB/Qy0phizBCwXzvXdc5PLpGsdh5sprgFIIuFsvOWSpOJiOtpik98Oq/TY848+WAVACvKaKcJlWX8uYOzbccdIDhSRhGbeAVOSp+/IWie+8+MYScK25pT4BV8KdV/zCtEZQKwrZm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623137; c=relaxed/simple;
	bh=gGg1ACS6SzmZqkleD+cBDo1nyBYn60WMARK6bfiGgng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJUZQJyoWsxr32KHYgKq4cYN8pnrTQjTKERMAomGShfXZwEiJXue8icHjYZNCbZb31F5qI0GPr7x5DVQyW1ZjDIl3XkbFobHUpnMp7WzzH4WHp55ApY4u2tXFUgpRHEk/bss5/BdDMPMCfDSPQzFaH+aXkVjrnajPTnqqO8tJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CBC7152B;
	Mon, 17 Jun 2024 04:19:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 531BD3F6A8;
	Mon, 17 Jun 2024 04:18:53 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: alexandru.elisei@arm.com,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH v2 3/5] irqchip/gic-v3: Make distributor priorities variables
Date: Mon, 17 Jun 2024 12:18:39 +0100
Message-Id: <20240617111841.2529370-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617111841.2529370-1-mark.rutland@arm.com>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In subsequent patches the GICv3 driver will choose the regular interrupt
priority at boot time.

In preparation for using dynamic priorities, place the priorities in
variables and update the code to pass these as parameters. Users of
GICD_INT_DEF_PRI_X4 are modified to replicate the priority byte using
REPEAT_BYTE_U32().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-common.c       | 10 ++++++----
 drivers/irqchip/irq-gic-common.h       |  4 ++--
 drivers/irqchip/irq-gic-v3-its.c       | 11 ++++++-----
 drivers/irqchip/irq-gic-v3.c           | 19 +++++++++++--------
 drivers/irqchip/irq-gic.c              |  8 ++++----
 drivers/irqchip/irq-hip04.c            |  4 ++--
 include/linux/irqchip/arm-gic-common.h |  4 ----
 include/linux/irqchip/arm-gic-v3.h     |  2 +-
 8 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 4ed17620dc4d7..c776f9142610e 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/kernel.h>
 
 #include "irq-gic-common.h"
 
@@ -87,7 +88,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	return ret;
 }
 
-void gic_dist_config(void __iomem *base, int gic_irqs)
+void gic_dist_config(void __iomem *base, int gic_irqs, u8 priority)
 {
 	unsigned int i;
 
@@ -102,7 +103,8 @@ void gic_dist_config(void __iomem *base, int gic_irqs)
 	 * Set priority on all global interrupts.
 	 */
 	for (i = 32; i < gic_irqs; i += 4)
-		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GIC_DIST_PRI + i);
+		writel_relaxed(REPEAT_BYTE_U32(priority),
+			       base + GIC_DIST_PRI + i);
 
 	/*
 	 * Deactivate and disable all SPIs. Leave the PPI and SGIs
@@ -116,7 +118,7 @@ void gic_dist_config(void __iomem *base, int gic_irqs)
 	}
 }
 
-void gic_cpu_config(void __iomem *base, int nr)
+void gic_cpu_config(void __iomem *base, int nr, u8 priority)
 {
 	int i;
 
@@ -135,6 +137,6 @@ void gic_cpu_config(void __iomem *base, int nr)
 	 * Set priority on PPI and SGI interrupts
 	 */
 	for (i = 0; i < nr; i += 4)
-		writel_relaxed(GICD_INT_DEF_PRI_X4,
+		writel_relaxed(REPEAT_BYTE_U32(priority),
 					base + GIC_DIST_PRI + i * 4 / 4);
 }
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index c230175dd584c..e8eab72ef1954 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -21,8 +21,8 @@ struct gic_quirk {
 
 int gic_configure_irq(unsigned int irq, unsigned int type,
                        void __iomem *base);
-void gic_dist_config(void __iomem *base, int gic_irqs);
-void gic_cpu_config(void __iomem *base, int nr);
+void gic_dist_config(void __iomem *base, int gic_irqs, u8 priority);
+void gic_cpu_config(void __iomem *base, int nr, u8 priority);
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
 void gic_enable_of_quirks(const struct device_node *np,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3c755d5dad6e6..42e63272154e0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -59,7 +59,7 @@ static u32 lpi_id_bits;
 #define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
 
-#define LPI_PROP_DEFAULT_PRIO	GICD_INT_DEF_PRI
+static u8 __ro_after_init lpi_prop_prio;
 
 /*
  * Collection structure - just an ID, and a redistributor address to
@@ -1926,7 +1926,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 	/* and restore the physical one */
 	irqd_clr_forwarded_to_vcpu(d);
 	its_send_mapti(its_dev, d->hwirq, event);
-	lpi_update_config(d, 0xff, (LPI_PROP_DEFAULT_PRIO |
+	lpi_update_config(d, 0xff, (lpi_prop_prio |
 				    LPI_PROP_ENABLED |
 				    LPI_PROP_GROUP1));
 
@@ -2181,8 +2181,8 @@ static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 
 static void gic_reset_prop_table(void *va)
 {
-	/* Priority 0xa0, Group-1, disabled */
-	memset(va, LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1, LPI_PROPBASE_SZ);
+	/* Regular IRQ priority, Group-1, disabled */
+	memset(va, lpi_prop_prio | LPI_PROP_GROUP1, LPI_PROPBASE_SZ);
 
 	/* Make sure the GIC will observe the written configuration */
 	gic_flush_dcache_to_poc(va, LPI_PROPBASE_SZ);
@@ -5650,7 +5650,7 @@ int __init its_lpi_memreserve_init(void)
 }
 
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
-		    struct irq_domain *parent_domain)
+		    struct irq_domain *parent_domain, u8 irq_prio)
 {
 	struct device_node *of_node;
 	struct its_node *its;
@@ -5660,6 +5660,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 
 	gic_rdists = rdists;
 
+	lpi_prop_prio = irq_prio;
 	its_parent = parent_domain;
 	of_node = to_of_node(handle);
 	if (of_node)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d95dda2383fb5..d884d94c6f4d0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
+#include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -36,7 +37,8 @@
 
 #include "irq-gic-common.h"
 
-#define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
+static u8 dist_prio_irq __ro_after_init = GICD_INT_DEF_PRI;
+static u8 dist_prio_nmi __ro_after_init = GICD_INT_DEF_PRI & ~0x80;
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
@@ -556,7 +558,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		desc->handle_irq = handle_fasteoi_nmi;
 	}
 
-	gic_irq_set_prio(d, GICD_INT_NMI_PRI);
+	gic_irq_set_prio(d, dist_prio_nmi);
 
 	return 0;
 }
@@ -591,7 +593,7 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		desc->handle_irq = handle_fasteoi_irq;
 	}
 
-	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
+	gic_irq_set_prio(d, dist_prio_irq);
 }
 
 static bool gic_arm64_erratum_2941627_needed(struct irq_data *d)
@@ -753,7 +755,7 @@ static bool gic_rpr_is_nmi_prio(void)
 	if (!gic_supports_nmi())
 		return false;
 
-	return unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI));
+	return unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(dist_prio_nmi));
 }
 
 static bool gic_irqnr_is_special(u32 irqnr)
@@ -937,10 +939,11 @@ static void __init gic_dist_init(void)
 		writel_relaxed(0, base + GICD_ICFGRnE + i / 4);
 
 	for (i = 0; i < GIC_ESPI_NR; i += 4)
-		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
+		writel_relaxed(REPEAT_BYTE_U32(dist_prio_irq),
+			       base + GICD_IPRIORITYRnE + i);
 
 	/* Now do the common stuff */
-	gic_dist_config(base, GIC_LINE_NR);
+	gic_dist_config(base, GIC_LINE_NR, dist_prio_irq);
 
 	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
 	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
@@ -1282,7 +1285,7 @@ static void gic_cpu_init(void)
 	for (i = 0; i < gic_data.ppi_nr + SGI_NR; i += 32)
 		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
 
-	gic_cpu_config(rbase, gic_data.ppi_nr + SGI_NR);
+	gic_cpu_config(rbase, gic_data.ppi_nr + SGI_NR, dist_prio_irq);
 	gic_redist_wait_for_rwp();
 
 	/* initialise system registers */
@@ -2066,7 +2069,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 	gic_cpu_pm_init();
 
 	if (gic_dist_supports_lpis()) {
-		its_init(handle, &gic_data.rdists, gic_data.domain);
+		its_init(handle, &gic_data.rdists, gic_data.domain, dist_prio_irq);
 		its_cpu_init();
 		its_lpi_memreserve_init();
 	} else {
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 87255bde960fc..3be7bd8cd8cde 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -479,7 +479,7 @@ static void gic_dist_init(struct gic_chip_data *gic)
 	for (i = 32; i < gic_irqs; i += 4)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
-	gic_dist_config(base, gic_irqs);
+	gic_dist_config(base, gic_irqs, GICD_INT_DEF_PRI);
 
 	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
 }
@@ -516,7 +516,7 @@ static int gic_cpu_init(struct gic_chip_data *gic)
 				gic_cpu_map[i] &= ~cpu_mask;
 	}
 
-	gic_cpu_config(dist_base, 32);
+	gic_cpu_config(dist_base, 32, GICD_INT_DEF_PRI);
 
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
@@ -608,7 +608,7 @@ void gic_dist_restore(struct gic_chip_data *gic)
 			dist_base + GIC_DIST_CONFIG + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
-		writel_relaxed(GICD_INT_DEF_PRI_X4,
+		writel_relaxed(REPEAT_BYTE_U32(GICD_INT_DEF_PRI),
 			dist_base + GIC_DIST_PRI + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
@@ -697,7 +697,7 @@ void gic_cpu_restore(struct gic_chip_data *gic)
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_CONFIG + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(32, 4); i++)
-		writel_relaxed(GICD_INT_DEF_PRI_X4,
+		writel_relaxed(REPEAT_BYTE_U32(GICD_INT_DEF_PRI),
 					dist_base + GIC_DIST_PRI + i * 4);
 
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, cpu_base + GIC_CPU_PRIMASK);
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 5285150fd9096..31c3f70a5d5e1 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -260,7 +260,7 @@ static void __init hip04_irq_dist_init(struct hip04_irq_data *intc)
 	for (i = 32; i < nr_irqs; i += 2)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + ((i * 2) & ~3));
 
-	gic_dist_config(base, nr_irqs);
+	gic_dist_config(base, nr_irqs, GICD_INT_DEF_PRI);
 
 	writel_relaxed(1, base + GIC_DIST_CTRL);
 }
@@ -287,7 +287,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 		if (i != cpu)
 			hip04_cpu_map[i] &= ~cpu_mask;
 
-	gic_cpu_config(dist_base, 32);
+	gic_cpu_config(dist_base, 32, GICD_INT_DEF_PRI);
 
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
 	writel_relaxed(1, base + GIC_CPU_CTRL);
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 1177f3a1aed5d..fc0246cc05ac2 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -10,10 +10,6 @@
 #include <linux/irqchip/arm-vgic-info.h>
 
 #define GICD_INT_DEF_PRI		0xa0
-#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
-					(GICD_INT_DEF_PRI << 16) |\
-					(GICD_INT_DEF_PRI << 8) |\
-					GICD_INT_DEF_PRI)
 
 struct irq_domain;
 struct fwnode_handle;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 728691365464c..70c0948f978eb 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -638,7 +638,7 @@ struct fwnode_handle;
 int __init its_lpi_memreserve_init(void);
 int its_cpu_init(void);
 int its_init(struct fwnode_handle *handle, struct rdists *rdists,
-	     struct irq_domain *domain);
+	     struct irq_domain *domain, u8 irq_prio);
 int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
 
 static inline bool gic_enable_sre(void)
-- 
2.30.2



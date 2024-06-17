Return-Path: <linux-kernel+bounces-217194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ABB90ACBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D99284202
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150A194C67;
	Mon, 17 Jun 2024 11:18:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78E194ADD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623135; cv=none; b=Es5gzlcoYISkq96VsX4ksqlIkuIemLSnAw5hig8tiL3O5aG6sqEXv78/qbWZFD0rtwadlB8UEGzStflOu7TfygH1ccrHpP1Jvbbr4+d4p9KjUUkT3sh663YyLsE45T68+kvSA9kLb8DKkf4YMdJ8LtIf3JTOviwSALTAf3K+CPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623135; c=relaxed/simple;
	bh=XW0ey+7Xr49sNv7VbTaZiBIsgkjNPz9CoFlLYmIURkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxonyZE679mYY88Sljspq/v9ssVskwHN5jzWVeEgfMAkDQQViq3lmZWJT9yclfMIIQ9GevcGz1FaRdnZvF86oG3U1pzSW0KL5wqZHZs3ddc37+sA+F79kD/D0Qdc6nSrKKoUy1U1WljNBKKQhy34t1fQRvE7qK3HYWzb1+2E8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 455DE1516;
	Mon, 17 Jun 2024 04:19:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BA913F6A8;
	Mon, 17 Jun 2024 04:18:51 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: alexandru.elisei@arm.com,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH v2 2/5] irqchip/gic-common: Remove sync_access callback
Date: Mon, 17 Jun 2024 12:18:38 +0100
Message-Id: <20240617111841.2529370-3-mark.rutland@arm.com>
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

The gic_configure_irq(), gic_dist_config(), and gic_cpu_config()
functions each take an optional "sync_access" callback, but in almost
all cases this is not used. The only user is the GICv3 driver's
gic_cpu_init() function, which uses gic_redist_wait_for_rwp() as the
"sync_access" callback for gic_cpu_config().

It would be simpler and clearer to remove the callback and have the
GICv3 driver call gic_redist_wait_for_rwp() explicitly after
gic_cpu_config().

Remove the "sync_access" callback, and call gic_redist_wait_for_rwp()
explicitly in the GICv3 driver.

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
 drivers/irqchip/irq-gic-common.c | 16 +++-------------
 drivers/irqchip/irq-gic-common.h |  7 +++----
 drivers/irqchip/irq-gic-v3.c     |  7 ++++---
 drivers/irqchip/irq-gic.c        |  6 +++---
 drivers/irqchip/irq-hip04.c      |  6 +++---
 5 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index afd6a1841715a..4ed17620dc4d7 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -45,7 +45,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 }
 
 int gic_configure_irq(unsigned int irq, unsigned int type,
-		       void __iomem *base, void (*sync_access)(void))
+		       void __iomem *base)
 {
 	u32 confmask = 0x2 << ((irq % 16) * 2);
 	u32 confoff = (irq / 16) * 4;
@@ -84,14 +84,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
-	if (sync_access)
-		sync_access();
-
 	return ret;
 }
 
-void gic_dist_config(void __iomem *base, int gic_irqs,
-		     void (*sync_access)(void))
+void gic_dist_config(void __iomem *base, int gic_irqs)
 {
 	unsigned int i;
 
@@ -118,12 +114,9 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 		writel_relaxed(GICD_INT_EN_CLR_X32,
 			       base + GIC_DIST_ENABLE_CLEAR + i / 8);
 	}
-
-	if (sync_access)
-		sync_access();
 }
 
-void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
+void gic_cpu_config(void __iomem *base, int nr)
 {
 	int i;
 
@@ -144,7 +137,4 @@ void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
 	for (i = 0; i < nr; i += 4)
 		writel_relaxed(GICD_INT_DEF_PRI_X4,
 					base + GIC_DIST_PRI + i * 4 / 4);
-
-	if (sync_access)
-		sync_access();
 }
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index f407cce9ecaaa..c230175dd584c 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -20,10 +20,9 @@ struct gic_quirk {
 };
 
 int gic_configure_irq(unsigned int irq, unsigned int type,
-                       void __iomem *base, void (*sync_access)(void));
-void gic_dist_config(void __iomem *base, int gic_irqs,
-		     void (*sync_access)(void));
-void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void));
+                       void __iomem *base);
+void gic_dist_config(void __iomem *base, int gic_irqs);
+void gic_cpu_config(void __iomem *base, int nr);
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
 void gic_enable_of_quirks(const struct device_node *np,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc8..d95dda2383fb5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -670,7 +670,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
 
-	ret = gic_configure_irq(index, type, base + offset, NULL);
+	ret = gic_configure_irq(index, type, base + offset);
 	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI INTID%ld is secure or misconfigured\n", irq);
@@ -940,7 +940,7 @@ static void __init gic_dist_init(void)
 		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
 
 	/* Now do the common stuff */
-	gic_dist_config(base, GIC_LINE_NR, NULL);
+	gic_dist_config(base, GIC_LINE_NR);
 
 	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
 	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
@@ -1282,7 +1282,8 @@ static void gic_cpu_init(void)
 	for (i = 0; i < gic_data.ppi_nr + SGI_NR; i += 32)
 		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
 
-	gic_cpu_config(rbase, gic_data.ppi_nr + SGI_NR, gic_redist_wait_for_rwp);
+	gic_cpu_config(rbase, gic_data.ppi_nr + SGI_NR);
+	gic_redist_wait_for_rwp();
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 98aa383e39db1..87255bde960fc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -303,7 +303,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
+	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG);
 	if (ret && gicirq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI%ld is secure or misconfigured\n", gicirq - 16);
@@ -479,7 +479,7 @@ static void gic_dist_init(struct gic_chip_data *gic)
 	for (i = 32; i < gic_irqs; i += 4)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
-	gic_dist_config(base, gic_irqs, NULL);
+	gic_dist_config(base, gic_irqs);
 
 	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
 }
@@ -516,7 +516,7 @@ static int gic_cpu_init(struct gic_chip_data *gic)
 				gic_cpu_map[i] &= ~cpu_mask;
 	}
 
-	gic_cpu_config(dist_base, 32, NULL);
+	gic_cpu_config(dist_base, 32);
 
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 46161f6ff289d..5285150fd9096 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -130,7 +130,7 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&irq_controller_lock);
 
-	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL);
+	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG);
 	if (ret && irq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
@@ -260,7 +260,7 @@ static void __init hip04_irq_dist_init(struct hip04_irq_data *intc)
 	for (i = 32; i < nr_irqs; i += 2)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + ((i * 2) & ~3));
 
-	gic_dist_config(base, nr_irqs, NULL);
+	gic_dist_config(base, nr_irqs);
 
 	writel_relaxed(1, base + GIC_DIST_CTRL);
 }
@@ -287,7 +287,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 		if (i != cpu)
 			hip04_cpu_map[i] &= ~cpu_mask;
 
-	gic_cpu_config(dist_base, 32, NULL);
+	gic_cpu_config(dist_base, 32);
 
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
 	writel_relaxed(1, base + GIC_CPU_CTRL);
-- 
2.30.2



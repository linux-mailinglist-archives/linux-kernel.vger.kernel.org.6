Return-Path: <linux-kernel+bounces-567587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26DA6881D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157477AA2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5D256C85;
	Wed, 19 Mar 2025 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lch0q9mJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7A256C65
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376685; cv=none; b=Y7x7gnBdugzXpSw2A9cGsdjBpiw600fhb08mJNF7bgcqzEoHuzQ7pCpiIlb28vo/hpaOAIjdEbgjIol+CpMQC5ZPXbpQzSSAHDUqKxvlAXrVTGwJqz2Vfk9uVK+9Za+916afqVGoohvddm5ONfg2OVEt9m7nKGYHD3KrnmpNSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376685; c=relaxed/simple;
	bh=IRPy6rdQAf8FH/TYZqrfLoaXvOKxAtAADXQKa7/vbmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tweAYa4Dso0On7jtOfImJj8W9uB722ZtZ23MbwiTp4lD2Ycf0ANN/5c43b7MM6WF82pRwWdOVEWTK/DBUCcKAhiiWSJ4rUGVRaVbh41ekCSQEt2prhgVpquMwz0up5ZLyMibz9lOIvKe7tqkrNOj8G2ikuy8TxtpqPKC1DEuJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lch0q9mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3BEC4CEEA;
	Wed, 19 Mar 2025 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376684;
	bh=IRPy6rdQAf8FH/TYZqrfLoaXvOKxAtAADXQKa7/vbmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lch0q9mJZEHRTrKV1pGlv6crfvvguqWqaywvDVeUuQ5Kri/RQi8b2Ng3Eqgt1rPn4
	 ZZ8M7tEMphO9VPKS6Gc23v9o+U+lmU6hEF2Bri3hGhISPU0q2v3Yv5UejnpU6e/Ixi
	 3DEzK7AFej9W0dReVe42kwP2V6V4aoRCJk9ULHh1g2TSnNNNvxJv9gZyzJeiFmCoYi
	 iZUY8TV7GjKp1PSAu3NJTeDAOdg3fT2ruJdaA/+iRA3Mq1+RgQrp298d5bfb7nMXTY
	 /5k4SD5GYQTJcpEIizD/mXD7nUlIhawj+knyrHbdTbB32VCZ65fHaPvvmXFwDsMiA9
	 WHZomiqtTKm7g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 14/57] irqdomain: arm: Switch to irq_domain_create_*()
Date: Wed, 19 Mar 2025 10:29:07 +0100
Message-ID: <20250319092951.37667-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/common/sa1111.c             |  6 +++---
 arch/arm/mach-exynos/suspend.c       |  5 ++---
 arch/arm/mach-imx/avic.c             |  4 ++--
 arch/arm/mach-imx/gpc.c              |  5 ++---
 arch/arm/mach-imx/tzic.c             |  4 ++--
 arch/arm/mach-omap1/irq.c            |  3 +--
 arch/arm/mach-omap2/omap-wakeupgen.c |  5 ++---
 arch/arm/mach-pxa/irq.c              |  5 ++---
 arch/arm/plat-orion/gpio.c           | 12 ++++++------
 9 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 9846f30990f7..02eda44a6faa 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -416,9 +416,9 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR0);
 	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR1);
 
-	sachip->irqdomain = irq_domain_add_linear(NULL, SA1111_IRQ_NR,
-						  &sa1111_irqdomain_ops,
-						  sachip);
+	sachip->irqdomain = irq_domain_create_linear(NULL, SA1111_IRQ_NR,
+						     &sa1111_irqdomain_ops,
+						     sachip);
 	if (!sachip->irqdomain) {
 		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
 		return -ENOMEM;
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index cac4e82f6c82..150a1e56dcae 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -209,9 +209,8 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, 0,
-					  node, &exynos_pmu_domain_ops,
-					  NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, 0, of_fwnode_handle(node),
+					     &exynos_pmu_domain_ops, NULL);
 	if (!domain) {
 		iounmap(pmu_base_addr);
 		pmu_base_addr = NULL;
diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index cf6546ddc7a3..3067c06b4b8e 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -201,8 +201,8 @@ static void __init mxc_init_irq(void __iomem *irqbase)
 	WARN_ON(irq_base < 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
-	domain = irq_domain_add_legacy(np, AVIC_NUM_IRQS, irq_base, 0,
-				       &irq_domain_simple_ops, NULL);
+	domain = irq_domain_create_legacy(of_fwnode_handle(np), AVIC_NUM_IRQS, irq_base, 0,
+					  &irq_domain_simple_ops, NULL);
 	WARN_ON(!domain);
 
 	for (i = 0; i < AVIC_NUM_IRQS / 32; i++, irq_base += 32)
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 5909088d5482..2e633569d2f8 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -245,9 +245,8 @@ static int __init imx_gpc_init(struct device_node *node,
 	if (WARN_ON(!gpc_base))
 	        return -ENOMEM;
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
-					  node, &imx_gpc_domain_ops,
-					  NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, GPC_MAX_IRQS, of_fwnode_handle(node),
+					     &imx_gpc_domain_ops, NULL);
 	if (!domain) {
 		iounmap(gpc_base);
 		return -ENOMEM;
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 8b3d98d288d9..50a5668e65d2 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -175,8 +175,8 @@ static int __init tzic_init_dt(struct device_node *np, struct device_node *p)
 	irq_base = irq_alloc_descs(-1, 0, TZIC_NUM_IRQS, numa_node_id());
 	WARN_ON(irq_base < 0);
 
-	domain = irq_domain_add_legacy(np, TZIC_NUM_IRQS, irq_base, 0,
-				       &irq_domain_simple_ops, NULL);
+	domain = irq_domain_create_legacy(of_fwnode_handle(np), TZIC_NUM_IRQS, irq_base, 0,
+					  &irq_domain_simple_ops, NULL);
 	WARN_ON(!domain);
 
 	for (i = 0; i < 4; i++, irq_base += 32)
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 9b587ecebb1c..bb1bc060ecd8 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -220,8 +220,7 @@ void __init omap1_init_irq(void)
 	omap_l2_irq = irq_base;
 	omap_l2_irq -= NR_IRQS_LEGACY;
 
-	domain = irq_domain_add_legacy(NULL, nr_irqs, irq_base, 0,
-				       &irq_domain_simple_ops, NULL);
+	domain = irq_domain_create_legacy(NULL, nr_irqs, irq_base, 0, &irq_domain_simple_ops, NULL);
 
 	pr_info("Total of %lu interrupts in %i interrupt banks\n",
 		nr_irqs, irq_bank_count);
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 6f0d6120c174..a66b1dc61571 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -585,9 +585,8 @@ static int __init wakeupgen_init(struct device_node *node,
 		wakeupgen_ops = &am43xx_wakeupgen_ops;
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, max_irqs,
-					  node, &wakeupgen_domain_ops,
-					  NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, max_irqs, of_fwnode_handle(node),
+					     &wakeupgen_domain_ops, NULL);
 	if (!domain) {
 		iounmap(wakeupgen_base);
 		return -ENOMEM;
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index d9cadd97748a..5bfce8aa4102 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -147,9 +147,8 @@ pxa_init_irq_common(struct device_node *node, int irq_nr,
 	int n;
 
 	pxa_internal_irq_nr = irq_nr;
-	pxa_irq_domain = irq_domain_add_legacy(node, irq_nr,
-					       PXA_IRQ(0), 0,
-					       &pxa_irq_ops, NULL);
+	pxa_irq_domain = irq_domain_create_legacy(of_fwnode_handle(node), irq_nr, PXA_IRQ(0), 0,
+						  &pxa_irq_ops, NULL);
 	if (!pxa_irq_domain)
 		panic("Unable to add PXA IRQ domain\n");
 	irq_set_default_domain(pxa_irq_domain);
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 595e9cb33c1d..a15f47450084 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -602,12 +602,12 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
-	ochip->domain = irq_domain_add_legacy(NULL,
-					      ochip->chip.ngpio,
-					      ochip->secondary_irq_base,
-					      ochip->secondary_irq_base,
-					      &irq_domain_simple_ops,
-					      ochip);
+	ochip->domain = irq_domain_create_legacy(NULL,
+						 ochip->chip.ngpio,
+						 ochip->secondary_irq_base,
+						 ochip->secondary_irq_base,
+						 &irq_domain_simple_ops,
+						 ochip);
 	if (!ochip->domain)
 		panic("%s: couldn't allocate irq domain (DT).\n",
 		      ochip->chip.label);
-- 
2.49.0



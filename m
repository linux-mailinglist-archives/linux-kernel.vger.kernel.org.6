Return-Path: <linux-kernel+bounces-567574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E84A68807
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17397A9674
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D62505D3;
	Wed, 19 Mar 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUeTYSk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C42528E0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376647; cv=none; b=IARmEi4KDwZsHE+mf0svJIFIPTUgf7sDpbuH0igIdqHaZRMDBdpgpnKDfkbTNqABpZTZ2MneR22IHSphRxFJFXS9QMB1tr3u3oqH3J4KNjzRfDsWRqDoATaqNMTW9vytAeKcEDA0tLrehNgSHZV+kMa7CeZVcx/o5qCiXSxQgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376647; c=relaxed/simple;
	bh=eZbTwRAzdJNBGCGMnrtjCFcr8FmrHrTiTPe6zNGCtLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBqasx5gEmr2ExVZkqpBJfSim2dwhtnAxgAYRMLMwA+7AMahQyc4t0COW9yftMIuFaFv/H6pUqLcp+BNwxgKPhdoLA0Gv+0Mx+nQ4jkDXE+jJqZ7+QJj2cBFiz1fjgGqIf4DpdBM3howeKmbGeE7+rKCMI0HKlbnsbLrwvFnLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUeTYSk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B678EC4CEEA;
	Wed, 19 Mar 2025 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376646;
	bh=eZbTwRAzdJNBGCGMnrtjCFcr8FmrHrTiTPe6zNGCtLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUeTYSk7BlN7RuZBo/WorRIBM/BOb660h2aHPrgZrlGiRrtZZIvYjWK3DtrFl2KZd
	 WzNfbm5yp3KWV2Gg6GS1ET5EP9A9/6bqHz1id1N931/ygdieG/oXcGyUSU36jntDi7
	 gGzyrGP9tHSM93tQVJLrySrjQbUzvt3lvT7QUNgId+9jwbdojk2NsOx6EWKIZEhj4u
	 YaOuAjZ+6njaL3r2pOrgR4kCJ+PF6Kp7TB2etEEx/MpSuKcbOBst9aQG4bLtYyb36k
	 cWFiToWBKlS2drbzVONK6d0+PohA+tFDbkH8KTeAaSzf+UFUtib8kr67CSTMt9g2x2
	 lYeaqLkq3heUg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Anatolij Gustschin <agust@denx.de>,
	Geoff Levand <geoff@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 02/57] irqdomain: Rename irq_set_default_host() to irq_set_default_domain()
Date: Wed, 19 Mar 2025 10:28:55 +0100
Message-ID: <20250319092951.37667-3-jirislaby@kernel.org>
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

Call the irq_domain consistently a domain, not host. Here, rename
irq_set_default_host() to irq_set_default_domain().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/arc/kernel/intc-arcv2.c                     | 2 +-
 arch/arc/kernel/intc-compact.c                   | 2 +-
 arch/arm/mach-pxa/irq.c                          | 2 +-
 arch/mips/cavium-octeon/octeon-irq.c             | 6 +++---
 arch/mips/sgi-ip27/ip27-irq.c                    | 2 +-
 arch/mips/sgi-ip30/ip30-irq.c                    | 2 +-
 arch/nios2/kernel/irq.c                          | 2 +-
 arch/powerpc/platforms/44x/uic.c                 | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        | 2 +-
 arch/powerpc/platforms/amigaone/setup.c          | 2 +-
 arch/powerpc/platforms/chrp/setup.c              | 2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 2 +-
 arch/powerpc/platforms/pasemi/setup.c            | 2 +-
 arch/powerpc/platforms/powermac/pic.c            | 2 +-
 arch/powerpc/platforms/ps3/interrupt.c           | 2 +-
 arch/powerpc/sysdev/ehv_pic.c                    | 2 +-
 arch/powerpc/sysdev/ipic.c                       | 2 +-
 arch/powerpc/sysdev/mpic.c                       | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c           | 2 +-
 arch/powerpc/sysdev/xive/common.c                | 2 +-
 arch/x86/kernel/apic/vector.c                    | 2 +-
 drivers/irqchip/irq-armada-370-xp.c              | 2 +-
 drivers/irqchip/irq-clps711x.c                   | 2 +-
 drivers/irqchip/irq-imx-gpcv2.c                  | 2 +-
 drivers/irqchip/irq-pic32-evic.c                 | 2 +-
 drivers/irqchip/irq-xilinx-intc.c                | 2 +-
 drivers/irqchip/irq-xtensa-mx.c                  | 2 +-
 drivers/irqchip/irq-xtensa-pic.c                 | 4 ++--
 include/linux/irqdomain.h                        | 2 +-
 kernel/irq/irqdomain.c                           | 8 ++++----
 30 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index f324f0e3341a..fea29d9d18d6 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -178,7 +178,7 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	 * Needed for primary domain lookup to succeed
 	 * This is a primary irqchip, and can never have a parent
 	 */
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 
 #ifdef CONFIG_SMP
 	irq_create_mapping(root_domain, IPI_IRQ);
diff --git a/arch/arc/kernel/intc-compact.c b/arch/arc/kernel/intc-compact.c
index 6885e422870e..1d2ff1c6a61b 100644
--- a/arch/arc/kernel/intc-compact.c
+++ b/arch/arc/kernel/intc-compact.c
@@ -121,7 +121,7 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	 * Needed for primary domain lookup to succeed
 	 * This is a primary irqchip, and can never have a parent
 	 */
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index a9ef71008147..d9cadd97748a 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -152,7 +152,7 @@ pxa_init_irq_common(struct device_node *node, int irq_nr,
 					       &pxa_irq_ops, NULL);
 	if (!pxa_irq_domain)
 		panic("Unable to add PXA IRQ domain\n");
-	irq_set_default_host(pxa_irq_domain);
+	irq_set_default_domain(pxa_irq_domain);
 
 	for (n = 0; n < irq_nr; n += 32) {
 		void __iomem *base = irq_base(n >> 5);
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 8425a6b38aa2..e6b4d9c0c169 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1505,7 +1505,7 @@ static int __init octeon_irq_init_ciu(
 
 	ciu_domain = irq_domain_add_tree(
 		ciu_node, &octeon_irq_domain_ciu_ops, dd);
-	irq_set_default_host(ciu_domain);
+	irq_set_default_domain(ciu_domain);
 
 	/* CIU_0 */
 	for (i = 0; i < 16; i++) {
@@ -2076,7 +2076,7 @@ static int __init octeon_irq_init_ciu2(
 
 	ciu_domain = irq_domain_add_tree(
 		ciu_node, &octeon_irq_domain_ciu2_ops, NULL);
-	irq_set_default_host(ciu_domain);
+	irq_set_default_domain(ciu_domain);
 
 	/* CUI2 */
 	for (i = 0; i < 64; i++) {
@@ -2929,7 +2929,7 @@ static int __init octeon_irq_init_ciu3(struct device_node *ciu_node,
 		/* Only do per CPU things if it is the CIU of the boot node. */
 		octeon_irq_ciu3_alloc_resources(ciu3_info);
 		if (node == 0)
-			irq_set_default_host(domain);
+			irq_set_default_domain(domain);
 
 		octeon_irq_use_ip4 = false;
 		/* Enable the CIU lines */
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 00e63e9ef61d..288d4d17eddd 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -297,7 +297,7 @@ void __init arch_init_irq(void)
 	if (WARN_ON(domain == NULL))
 		return;
 
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 
 	irq_set_percpu_devid(IP27_HUB_PEND0_IRQ);
 	irq_set_chained_handler_and_data(IP27_HUB_PEND0_IRQ, ip27_do_irq_mask0,
diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index 423c32cb66ed..9fb905e2cf14 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -313,7 +313,7 @@ void __init arch_init_irq(void)
 	if (!domain)
 		return;
 
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 
 	irq_set_percpu_devid(IP30_HEART_L0_IRQ);
 	irq_set_chained_handler_and_data(IP30_HEART_L0_IRQ, ip30_normal_irq,
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 6b7890e5f7af..8fa280660051 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -72,7 +72,7 @@ void __init init_IRQ(void)
 	domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
 	BUG_ON(!domain);
 
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 	of_node_put(node);
 	/* Load the initial ienable value */
 	ienable = RDCTL(CTL_IENABLE);
diff --git a/arch/powerpc/platforms/44x/uic.c b/arch/powerpc/platforms/44x/uic.c
index 8b03ae4cb3f6..31f760c2ec5d 100644
--- a/arch/powerpc/platforms/44x/uic.c
+++ b/arch/powerpc/platforms/44x/uic.c
@@ -291,7 +291,7 @@ void __init uic_init_tree(void)
 	if (!primary_uic)
 		panic("Unable to initialize primary UIC %pOF\n", np);
 
-	irq_set_default_host(primary_uic->irqhost);
+	irq_set_default_domain(primary_uic->irqhost);
 	of_node_put(np);
 
 	/* The scan again for cascaded UICs */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 1e0a5e9644dc..43c881d31ca6 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -453,7 +453,7 @@ void __init mpc52xx_init_irq(void)
 	if (!mpc52xx_irqhost)
 		panic(__FILE__ ": Cannot allocate the IRQ host\n");
 
-	irq_set_default_host(mpc52xx_irqhost);
+	irq_set_default_domain(mpc52xx_irqhost);
 
 	pr_info("MPC52xx PIC is up and running!\n");
 }
diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
index 2c8dc0886912..33f852a7625f 100644
--- a/arch/powerpc/platforms/amigaone/setup.c
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -109,7 +109,7 @@ static void __init amigaone_init_IRQ(void)
 
 	i8259_init(pic, int_ack);
 	ppc_md.get_irq = i8259_irq;
-	irq_set_default_host(i8259_get_host());
+	irq_set_default_domain(i8259_get_host());
 }
 
 static int __init request_isa_regions(void)
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 36ee3a5056a1..c1bfa4c3444c 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -486,7 +486,7 @@ static void __init chrp_find_8259(void)
 	i8259_init(pic, chrp_int_ack);
 	if (ppc_md.get_irq == NULL) {
 		ppc_md.get_irq = i8259_irq;
-		irq_set_default_host(i8259_get_host());
+		irq_set_default_domain(i8259_get_host());
 	}
 	if (chrp_mpic != NULL) {
 		cascade_irq = irq_of_parse_and_map(pic, 0);
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 4d9200bdba78..013d66304c31 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -190,7 +190,7 @@ void __init flipper_pic_probe(void)
 	flipper_irq_host = flipper_pic_init(np);
 	BUG_ON(!flipper_irq_host);
 
-	irq_set_default_host(flipper_irq_host);
+	irq_set_default_domain(flipper_irq_host);
 
 	of_node_put(np);
 }
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 0761d98e5be3..d03b41336901 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -228,7 +228,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 
-	irq_set_default_host(mpic->irqhost);
+	irq_set_default_domain(mpic->irqhost);
 }
 
 #else
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 2202bf77c7a3..03a7c51f2645 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -330,7 +330,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 	pmac_pic_host = irq_domain_add_linear(master, max_irqs,
 					      &pmac_pic_host_ops, NULL);
 	BUG_ON(pmac_pic_host == NULL);
-	irq_set_default_host(pmac_pic_host);
+	irq_set_default_domain(pmac_pic_host);
 
 	/* Get addresses of first controller if we have a node for it */
 	BUG_ON(of_address_to_resource(master, 0, &r));
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index af3fe9f04f24..95e96bd61a20 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -744,7 +744,7 @@ void __init ps3_init_IRQ(void)
 	struct irq_domain *host;
 
 	host = irq_domain_add_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
-	irq_set_default_host(host);
+	irq_set_default_domain(host);
 
 	for_each_possible_cpu(cpu) {
 		struct ps3_private *pd = &per_cpu(ps3_private, cpu);
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index 040827671d21..fb502b72fca1 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -291,5 +291,5 @@ void __init ehv_pic_init(void)
 	ehv_pic->coreint_flag = of_property_read_bool(np, "has-external-proxy");
 
 	global_ehv_pic = ehv_pic;
-	irq_set_default_host(global_ehv_pic->irqhost);
+	irq_set_default_domain(global_ehv_pic->irqhost);
 }
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 037b04bf9a9f..a35be0232978 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -757,7 +757,7 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	ipic_write(ipic->regs, IPIC_SEMSR, temp);
 
 	primary_ipic = ipic;
-	irq_set_default_host(primary_ipic->irqhost);
+	irq_set_default_domain(primary_ipic->irqhost);
 
 	ipic_write(ipic->regs, IPIC_SIMSR_H, 0);
 	ipic_write(ipic->regs, IPIC_SIMSR_L, 0);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d94cf36b0f65..4afbab83a2e2 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1520,7 +1520,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 
 	if (!(mpic->flags & MPIC_SECONDARY)) {
 		mpic_primary = mpic;
-		irq_set_default_host(mpic->irqhost);
+		irq_set_default_domain(mpic->irqhost);
 	}
 
 	return mpic;
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index d3a4156e8788..c3fa539a9898 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -472,7 +472,7 @@ static int __init xics_allocate_domain(void)
 		return -ENOMEM;
 	}
 
-	irq_set_default_host(xics_host);
+	irq_set_default_domain(xics_host);
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index a6c388bdf5d0..dc2e61837396 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1467,7 +1467,7 @@ static void __init xive_init_host(struct device_node *np)
 	xive_irq_domain = irq_domain_add_tree(np, &xive_irq_domain_ops, NULL);
 	if (WARN_ON(xive_irq_domain == NULL))
 		return;
-	irq_set_default_host(xive_irq_domain);
+	irq_set_default_domain(xive_irq_domain);
 }
 
 static void xive_cleanup_cpu_queues(unsigned int cpu, struct xive_cpu *xc)
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 72fa4bb78f0a..fee42a73d64a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -799,7 +799,7 @@ int __init arch_early_irq_init(void)
 	x86_vector_domain = irq_domain_create_tree(fn, &x86_vector_domain_ops,
 						   NULL);
 	BUG_ON(x86_vector_domain == NULL);
-	irq_set_default_host(x86_vector_domain);
+	irq_set_default_domain(x86_vector_domain);
 
 	BUG_ON(!alloc_cpumask_var(&vector_searchmask, GFP_KERNEL));
 
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index d7c5ef248474..6218e5d20b50 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -880,7 +880,7 @@ static int __init mpic_of_init(struct device_node *node, struct device_node *par
 	}
 
 	if (mpic_is_ipi_available(mpic)) {
-		irq_set_default_host(mpic->domain);
+		irq_set_default_domain(mpic->domain);
 		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP
 		err = mpic_ipi_init(mpic, node);
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 806ebb1de201..48c73c948ddf 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -191,7 +191,7 @@ static int __init _clps711x_intc_init(struct device_node *np,
 		goto out_irqfree;
 	}
 
-	irq_set_default_host(clps711x_intc->domain);
+	irq_set_default_domain(clps711x_intc->domain);
 	set_handle_irq(clps711x_irqh);
 
 #ifdef CONFIG_FIQ
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 8a0e82067924..095ae8e3217e 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -247,7 +247,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 		kfree(cd);
 		return -ENOMEM;
 	}
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 
 	/* Initially mask all interrupts */
 	for (i = 0; i < IMR_NUM; i++) {
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index eb6ca516a166..b546b1036e12 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -291,7 +291,7 @@ static int __init pic32_of_init(struct device_node *node,
 		gc->private = &priv[i];
 	}
 
-	irq_set_default_host(evic_irq_domain);
+	irq_set_default_domain(evic_irq_domain);
 
 	/*
 	 * External interrupts have software configurable edge polarity. These
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 7e08714d507f..38727e9cc713 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -233,7 +233,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		}
 	} else {
 		primary_intc = irqc;
-		irq_set_default_host(primary_intc->root_domain);
+		irq_set_default_domain(primary_intc->root_domain);
 		set_handle_irq(xil_intc_handle_irq);
 	}
 
diff --git a/drivers/irqchip/irq-xtensa-mx.c b/drivers/irqchip/irq-xtensa-mx.c
index 7f314e58f3ce..9b441d180299 100644
--- a/drivers/irqchip/irq-xtensa-mx.c
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -156,7 +156,7 @@ static void __init xtensa_mx_init_common(struct irq_domain *root_domain)
 {
 	unsigned int i;
 
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 	secondary_init_irq();
 
 	/* Initialize default IRQ routing to CPU 0 */
diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index f9d6fce4da33..9be7b7c5cd23 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -87,7 +87,7 @@ int __init xtensa_pic_init_legacy(struct device_node *interrupt_parent)
 	struct irq_domain *root_domain =
 		irq_domain_add_legacy(NULL, NR_IRQS - 1, 1, 0,
 				&xtensa_irq_domain_ops, &xtensa_irq_chip);
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 	return 0;
 }
 
@@ -97,7 +97,7 @@ static int __init xtensa_pic_init(struct device_node *np,
 	struct irq_domain *root_domain =
 		irq_domain_add_linear(np, NR_IRQS, &xtensa_irq_domain_ops,
 				&xtensa_irq_chip);
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 	return 0;
 }
 IRQCHIP_DECLARE(xtensa_irq_chip, "cdns,xtensa-pic", xtensa_pic_init);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 33ff41eef8f7..4b5c495b5710 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -352,7 +352,7 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					    void *host_data);
 struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 					    enum irq_domain_bus_token bus_token);
-void irq_set_default_host(struct irq_domain *host);
+void irq_set_default_domain(struct irq_domain *domain);
 struct irq_domain *irq_get_default_host(void);
 int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 			   irq_hw_number_t hwirq, int node,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2861f89880af..480fdc9e769e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -398,7 +398,7 @@ void irq_domain_remove(struct irq_domain *domain)
 	 * If the going away domain is the default one, reset it.
 	 */
 	if (unlikely(irq_default_domain == domain))
-		irq_set_default_host(NULL);
+		irq_set_default_domain(NULL);
 
 	mutex_unlock(&irq_domain_mutex);
 
@@ -573,7 +573,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
 
 /**
- * irq_set_default_host() - Set a "default" irq domain
+ * irq_set_default_domain() - Set a "default" irq domain
  * @domain: default domain pointer
  *
  * For convenience, it's possible to set a "default" domain that will be used
@@ -581,13 +581,13 @@ EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
  * platforms that want to manipulate a few hard coded interrupt numbers that
  * aren't properly represented in the device-tree.
  */
-void irq_set_default_host(struct irq_domain *domain)
+void irq_set_default_domain(struct irq_domain *domain)
 {
 	pr_debug("Default domain set to @0x%p\n", domain);
 
 	irq_default_domain = domain;
 }
-EXPORT_SYMBOL_GPL(irq_set_default_host);
+EXPORT_SYMBOL_GPL(irq_set_default_domain);
 
 /**
  * irq_get_default_host() - Retrieve the "default" irq domain
-- 
2.49.0



Return-Path: <linux-kernel+bounces-258735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CC938C36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D7B1C21333
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C5D16D31B;
	Mon, 22 Jul 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="cocUl2za"
Received: from smtpout43.security-mail.net (smtpout43.security-mail.net [85.31.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54BA16CD05
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641417; cv=none; b=a8Kjkr/EWOe16IdhXPgnZlBdtrh1Xdt7KZtuvqOicnoTWb/w0V7eiInmMNU3RE01Bis0cHLWdIuBG9xUfKteYuhF9bKmwn/eOdKSvdZCR8nStbGvCxMbFTp3vNBINNNoVEpG3z4WWRsXN6a6UhTZv37mUoKAmKTGTknoPPx9KWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641417; c=relaxed/simple;
	bh=f0O95pfNxRih9yCZu4XYDwcU7fm8dulNHBC/bzASeEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnB/tQSeg3EfdeNkqt9ilkKeHNkSUrqNjWjMS29fII7j7gZGgHctsLUIslhWtax1SyibqvJCPmVHARnJ3XuP3mFjvQYdxdIIOMPH9CTgESysx83B0Nzg5Ov/LRCO9HyKCPONiLxaT4tGDiq4g2na33mjzQuCHp+yMSDxmA1QIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=cocUl2za; arc=none smtp.client-ip=85.31.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx303.security-mail.net [127.0.0.1])
	by fx303.security-mail.net (Postfix) with ESMTP id 4FA4E30EF96
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641414;
	bh=f0O95pfNxRih9yCZu4XYDwcU7fm8dulNHBC/bzASeEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cocUl2za0D6G/5OQO1ABaUshnKmMPrdxmco/vgnBOP0IRDf1ps3CAz9Vt9J9PLTiv
	 uMsH0TbjNsEdLifrt+U8AwCPWI+fVAYzt4+DI9ScIyziY2TNdqq+3Dfjmu6fnSWz5X
	 rOHp7JS5wogwM/h2ILP9EP4zz60SVdsDxEjdgmaQ=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 1B4E430EF08; Mon, 22 Jul
 2024 11:43:34 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 8758930EEE1; Mon, 22 Jul
 2024 11:43:33 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 4971740317; Mon, 22 Jul
 2024 11:43:33 +0200 (CEST)
X-Secumail-id: <9700.669e29c5.84e85.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH v3 20/37] irqchip: Add irq-kvx-itgen driver
Date: Mon, 22 Jul 2024 11:41:31 +0200
Message-ID: <20240722094226.21602-21-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

The Kalray Coolidge SoC contains several interrupt generators (itgen).
The itgen is both an interrupt-controller and a msi-client.

Peripheral Controllers such as PCIe, I2C, SPI, GPIO, etc.
need to send interrupts to the Compute Clusters.
The purpose of this module is to forward interrupts to the compute clusters
through the AXI interconnect.

Features:
- up to 256 inputs.
- supports level interrupt inputs.
- five interrupt outputs (one per cluster).

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: new patch
- removed header include/linux/irqchip/irq-kvx-apic-gic.h
- header moved to drivers/irqchip/ but in another patch
- removed print on probe success

V2 -> V3:
- replace core intc by itgen in commit msg
- use dev_err_probe()
- typos
- add static qualifier
- update compatible
---
 drivers/irqchip/Kconfig         |   8 ++
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-kvx-itgen.c | 234 ++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/irqchip/irq-kvx-itgen.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 566425731b757..bf06506d611d5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -338,6 +338,14 @@ config KVX_APIC_GIC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 
+config KVX_ITGEN
+	bool
+	depends on KVX
+	select GENERIC_IRQ_IPI if SMP
+	select GENERIC_MSI_IRQ_DOMAIN
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+
 config INGENIC_IRQ
 	bool
 	depends on MACH_INGENIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f59255947c8ed..b2c514faf9bf7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
+obj-$(CONFIG_KVX_ITGEN)			+= irq-kvx-itgen.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
diff --git a/drivers/irqchip/irq-kvx-itgen.c b/drivers/irqchip/irq-kvx-itgen.c
new file mode 100644
index 0000000000000..67d76ab528ad6
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-itgen.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ *            Vincent Chardon
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+
+/* Parameters */
+#define KVX_ITGEN_PARAM_OFFSET			0x1100
+#define KVX_ITGEN_PARAM_IT_NUM_OFFSET		0x0
+
+/* Target configuration */
+#define KVX_ITGEN_CFG_ENABLE_OFFSET		0x8
+#define KVX_ITGEN_CFG_ELEM_SIZE		0x10
+#define KVX_ITGEN_CFG_TARGET_OFFSET		0x0
+#define KVX_ITGEN_CFG_TARGET_MAILBOX_SHIFT	0x0
+#define KVX_ITGEN_CFG_TARGET_MAILBOX_MASK	0x7FUL
+#define KVX_ITGEN_CFG_TARGET_CLUSTER_SHIFT	0x8
+#define KVX_ITGEN_CFG_TARGET_CLUSTER_MASK	0x700UL
+#define KVX_ITGEN_CFG_TARGET_SELECT_BIT_SHIFT	0x18
+#define KVX_ITGEN_CFG_TARGET_SELECT_BIT_MASK	0x3F000000UL
+
+#define MB_ADDR_CLUSTER_SHIFT	24
+#define MB_ADDR_MAILBOX_SHIFT	9
+
+/**
+ * struct kvx_itgen - kvx interrupt generator (MSI client)
+ * @base: base address of the itgen controller
+ * @domain: IRQ domain of the controller
+ * @pdev: Platform device associated to the controller
+ */
+struct kvx_itgen {
+	void __iomem *base;
+	struct irq_domain *domain;
+	struct platform_device *pdev;
+};
+
+static void __iomem *get_itgen_cfg_offset(struct kvx_itgen *itgen,
+						irq_hw_number_t hwirq)
+{
+	return itgen->base + KVX_ITGEN_CFG_TARGET_OFFSET +
+				hwirq * KVX_ITGEN_CFG_ELEM_SIZE;
+}
+
+static void __iomem *get_itgen_param_offset(struct kvx_itgen *itgen)
+{
+	return itgen->base + KVX_ITGEN_PARAM_OFFSET;
+}
+
+static void kvx_itgen_enable(struct irq_data *data, u32 value)
+{
+	struct kvx_itgen *itgen = irq_data_get_irq_chip_data(data);
+	void __iomem *enable_reg =
+		get_itgen_cfg_offset(itgen, irqd_to_hwirq(data)) +
+		KVX_ITGEN_CFG_ENABLE_OFFSET;
+
+	dev_dbg(&itgen->pdev->dev, "%sabling hwirq %d, addr %p\n",
+		 value ? "En" : "Dis",
+		 (int) irqd_to_hwirq(data),
+		 enable_reg);
+	writel(value, enable_reg);
+}
+
+static void kvx_itgen_mask(struct irq_data *data)
+{
+	kvx_itgen_enable(data, 0x0);
+	irq_chip_mask_parent(data);
+}
+
+static void kvx_itgen_unmask(struct irq_data *data)
+{
+	kvx_itgen_enable(data, 0x1);
+	irq_chip_unmask_parent(data);
+}
+
+#ifdef CONFIG_SMP
+static int kvx_itgen_irq_set_affinity(struct irq_data *data,
+				      const struct cpumask *dest, bool force)
+{
+	return -ENOSYS;
+}
+#endif
+
+static struct irq_chip itgen_irq_chip = {
+	.name =			"kvx-itgen",
+	.irq_mask =		kvx_itgen_mask,
+	.irq_unmask =		kvx_itgen_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity =	kvx_itgen_irq_set_affinity,
+#endif
+};
+
+#define ITGEN_UNSUPPORTED_TYPES (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)
+
+static int kvx_itgen_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	int i, err;
+	struct irq_fwspec *fwspec = args;
+	int hwirq = fwspec->param[0];
+	int type = IRQ_TYPE_NONE;
+	struct kvx_itgen *itgen;
+
+	if (fwspec->param_count >= 2)
+		type = fwspec->param[1];
+
+	WARN_ON(type & ITGEN_UNSUPPORTED_TYPES);
+
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
+	if (err)
+		return err;
+
+	itgen = platform_msi_get_host_data(domain);
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+				      &itgen_irq_chip, itgen);
+		if (type == IRQ_TYPE_LEVEL_HIGH)
+			irq_set_handler(virq + i, handle_level_irq);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops itgen_domain_ops = {
+	.alloc		= kvx_itgen_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static void kvx_itgen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct irq_data *d = irq_get_irq_data(desc->irq);
+	struct kvx_itgen *itgen = irq_data_get_irq_chip_data(d);
+	uint32_t cfg_val = 0;
+	uintptr_t dest_addr = ((uint64_t) msg->address_hi << 32) |
+							msg->address_lo;
+	void __iomem *cfg = get_itgen_cfg_offset(itgen, irqd_to_hwirq(d));
+
+	/*
+	 * The address passed in the msi data is the address of the target
+	 * mailbox. The itgen however writes to the mailbox based on the mppa
+	 * id, cluster id and mailbox id instead of an address. So, extract
+	 * these information from the mailbox address.
+	 */
+
+	cfg_val |= (((kvx_sfr_get(PCR) & KVX_SFR_PCR_CID_MASK) >>
+				 KVX_SFR_PCR_CID_SHIFT)
+				<< KVX_ITGEN_CFG_TARGET_CLUSTER_SHIFT);
+	cfg_val |= ((dest_addr >> MB_ADDR_MAILBOX_SHIFT) &
+		     KVX_ITGEN_CFG_TARGET_MAILBOX_MASK)
+		    << KVX_ITGEN_CFG_TARGET_MAILBOX_SHIFT;
+
+	/*
+	 * msg->data contains the bit number to be written and is included in
+	 * the itgen config
+	 */
+	cfg_val |= ((msg->data << KVX_ITGEN_CFG_TARGET_SELECT_BIT_SHIFT)
+		    & KVX_ITGEN_CFG_TARGET_SELECT_BIT_MASK);
+
+	dev_dbg(&itgen->pdev->dev,
+		"Writing dest_addr %lx, value %x to cfg %p\n",
+		dest_addr, cfg_val, cfg);
+
+	writel(cfg_val, cfg);
+}
+
+static int
+kvx_itgen_device_probe(struct platform_device *pdev)
+{
+	struct kvx_itgen *itgen;
+	u32 it_count;
+	struct resource *mem;
+
+	itgen = devm_kzalloc(&pdev->dev, sizeof(*itgen), GFP_KERNEL);
+	if (!itgen)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	itgen->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(itgen->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(itgen->base),
+				     "Failed to ioremap itgen\n");
+
+	itgen->pdev = pdev;
+	it_count = readl(get_itgen_param_offset(itgen) +
+				KVX_ITGEN_PARAM_IT_NUM_OFFSET);
+
+	itgen->domain = platform_msi_create_device_domain(&pdev->dev,
+						   it_count,
+						   kvx_itgen_write_msg,
+						   &itgen_domain_ops,
+						   itgen);
+	if (!itgen->domain) {
+		dev_err(&pdev->dev, "Failed to create device domain\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, itgen);
+
+	return 0;
+}
+
+static const struct of_device_id itgen_of_match[] = {
+	{ .compatible = "kalray,coolidge-itgen" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, itgen_of_match);
+
+static struct platform_driver itgen_platform_driver = {
+	.driver = {
+		.name		= "kvx-itgen",
+		.of_match_table	= itgen_of_match,
+	},
+	.probe			= kvx_itgen_device_probe,
+};
+
+static int __init kvx_itgen_init(void)
+{
+	return platform_driver_register(&itgen_platform_driver);
+}
+
+arch_initcall(kvx_itgen_init);
-- 
2.45.2







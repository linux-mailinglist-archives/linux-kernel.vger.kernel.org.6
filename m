Return-Path: <linux-kernel+bounces-215384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB09091D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FDA1F23081
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D351B3740;
	Fri, 14 Jun 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aXs/qLFA"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0D1B1501;
	Fri, 14 Jun 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386389; cv=none; b=MX4lsS8qsapRw28CpUbD4VQ2FjAhIqtZV+iPxoBKuo5UZyNDO2P8HvM24rAm1evK3rAZQY0byZf5sqI22PThQbD0GZIa5iFmq+Oh8Mn4dmy0w/Ob8OI9LHEMyMleiTqoiCQjU8P/u5ns0V6HL+gyPepN+AS59C4E2xyr7NfD/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386389; c=relaxed/simple;
	bh=CWe0oZQPyDbfVPmObDFlAsPQWG37WLKuX2ihGGGO+4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEeU5o3EhlWRGhVlR0esLxzYVUIkNcKzMdiZ9UXEW/b/8PwDGOnViMEAPKglURmmlUuCiQ4rZOl585WZe1OxWtLqztG4CBm64pquzzwAhC26qd2ZpmWpUaPefOsvTDqHEo9hEJDWW3vkhUFipr6R3PAxZ/TCtzRX+lwITJYfc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aXs/qLFA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 49AFAFF808;
	Fri, 14 Jun 2024 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZXNMDg6B/jwDIo1HOXHFfQYGr4bKbfCUr5ihJamawc=;
	b=aXs/qLFAvGZ2xq+r0dWjFRUD1ieyHBUP5Z6hvHtlLuOXt+YqRKWgnoVEAaZ1l3qYnBUuLq
	OB9azasRI6eNJw8M8i3Pc7/tDgRWMkFkW1Cpx4sHYl6SSSEOyVuFjaxJ2r7uYT0ifmTNg0
	Fcx3xDMy8LDXbrS/eJaeRov+3Lmx/xyPMHym1XwCkR45Zn+cEXIiAAXkd5gQ0Dy/kpEDVa
	dNenYUNQk9/n38S+SlLJduaLf68S0OHU8pdgYvSFisAKO6V79+dWzxDm9ThJmefrH0ynir
	mJl5EHi1xS6PMWEr2wYTG+b3jKsKKz0yjas6qF0zsyRUjIPYgb30nNVFUpizUA==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 22/23] irqchip: Add support for LAN966x OIC
Date: Fri, 14 Jun 2024 19:32:23 +0200
Message-ID: <20240614173232.1184015-23-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The Microchip LAN966x outband interrupt controller (OIC) maps the
internal interrupt sources of the LAN966x device to an external
interrupt.
When the LAN966x device is used as a PCI device, the external interrupt
is routed to the PCI interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/irqchip/Kconfig           |  12 ++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-lan966x-oic.c | 278 ++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+)
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacb..348f34525d23 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -169,6 +169,18 @@ config IXP4XX_IRQ
 	select IRQ_DOMAIN
 	select SPARSE_IRQ
 
+config LAN966X_OIC
+	tristate "Microchip LAN966x OIC Support"
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	help
+	  Enable support for the LAN966x Outbound Interrupt Controller.
+	  This controller is present on the Microchip LAN966x PCI device and
+	  maps the internal interrupts sources to PCIe interrupt.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called irq-lan966x-oic.
+
 config MADERA_IRQ
 	tristate
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d99aaa8..9f6f88274bec 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
+obj-$(CONFIG_LAN966X_OIC)		+= irq-lan966x-oic.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
diff --git a/drivers/irqchip/irq-lan966x-oic.c b/drivers/irqchip/irq-lan966x-oic.c
new file mode 100644
index 000000000000..34a10f7615d5
--- /dev/null
+++ b/drivers/irqchip/irq-lan966x-oic.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip LAN966x outbound interrupt controller
+ *
+ * Copyright (c) 2024 Technology Inc. and its subsidiaries.
+ *
+ * Authors:
+ *	Horatiu Vultur <horatiu.vultur@microchip.com>
+ *	Clément Léger <clement.leger@bootlin.com>
+ *	Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct lan966x_oic_chip_regs {
+	int reg_off_ena_set;
+	int reg_off_ena_clr;
+	int reg_off_sticky;
+	int reg_off_ident;
+	int reg_off_map;
+};
+
+struct lan966x_oic_data {
+	void __iomem *regs;
+	int irq;
+};
+
+#define LAN966X_OIC_NR_IRQ 86
+
+/* Interrupt sticky status */
+#define LAN966X_OIC_INTR_STICKY		0x30
+#define LAN966X_OIC_INTR_STICKY1	0x34
+#define LAN966X_OIC_INTR_STICKY2	0x38
+
+/* Interrupt enable */
+#define LAN966X_OIC_INTR_ENA		0x48
+#define LAN966X_OIC_INTR_ENA1		0x4c
+#define LAN966X_OIC_INTR_ENA2		0x50
+
+/* Atomic clear of interrupt enable */
+#define LAN966X_OIC_INTR_ENA_CLR	0x54
+#define LAN966X_OIC_INTR_ENA_CLR1	0x58
+#define LAN966X_OIC_INTR_ENA_CLR2	0x5c
+
+/* Atomic set of interrupt */
+#define LAN966X_OIC_INTR_ENA_SET	0x60
+#define LAN966X_OIC_INTR_ENA_SET1	0x64
+#define LAN966X_OIC_INTR_ENA_SET2	0x68
+
+/* Mapping of source to destination interrupts (_n = 0..8) */
+#define LAN966X_OIC_DST_INTR_MAP(_n)	(0x78 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_MAP1(_n)	(0x9c + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_MAP2(_n)	(0xc0 + (_n) * 4)
+
+/* Currently active interrupt sources per destination (_n = 0..8) */
+#define LAN966X_OIC_DST_INTR_IDENT(_n)	(0xe4 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_IDENT1(_n)	(0x108 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_IDENT2(_n)	(0x12c + (_n) * 4)
+
+static unsigned int lan966x_oic_irq_startup(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct = irq_data_get_chip_type(data);
+	struct lan966x_oic_chip_regs *chip_regs = gc->private;
+	u32 map;
+
+	irq_gc_lock(gc);
+
+	/* Map the source interrupt to the destination */
+	map = irq_reg_readl(gc, chip_regs->reg_off_map);
+	map |= data->mask;
+	irq_reg_writel(gc, map, chip_regs->reg_off_map);
+
+	irq_gc_unlock(gc);
+
+	ct->chip.irq_ack(data);
+	ct->chip.irq_unmask(data);
+
+	return 0;
+}
+
+static void lan966x_oic_irq_shutdown(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct = irq_data_get_chip_type(data);
+	struct lan966x_oic_chip_regs *chip_regs = gc->private;
+	u32 map;
+
+	ct->chip.irq_mask(data);
+
+	irq_gc_lock(gc);
+
+	/* Unmap the interrupt */
+	map = irq_reg_readl(gc, chip_regs->reg_off_map);
+	map &= ~data->mask;
+	irq_reg_writel(gc, map, chip_regs->reg_off_map);
+
+	irq_gc_unlock(gc);
+}
+
+static int lan966x_oic_irq_set_type(struct irq_data *data,
+				    unsigned int flow_type)
+{
+	if (flow_type != IRQ_TYPE_LEVEL_HIGH) {
+		pr_err("lan966x oic doesn't support flow type %d\n", flow_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void lan966x_oic_irq_handler_domain(struct irq_domain *d, u32 first_irq)
+{
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, first_irq);
+	struct lan966x_oic_chip_regs *chip_regs = gc->private;
+	unsigned long ident;
+	unsigned int hwirq;
+
+	ident = irq_reg_readl(gc, chip_regs->reg_off_ident);
+	if (!ident)
+		return;
+
+	for_each_set_bit(hwirq, &ident, 32)
+		generic_handle_domain_irq(d, hwirq + first_irq);
+}
+
+static void lan966x_oic_irq_handler(struct irq_desc *desc)
+{
+	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	lan966x_oic_irq_handler_domain(d, 0);
+	lan966x_oic_irq_handler_domain(d, 32);
+	lan966x_oic_irq_handler_domain(d, 64);
+	chained_irq_exit(chip, desc);
+}
+
+static struct lan966x_oic_chip_regs lan966x_oic_chip_regs[3] = {
+	{
+		.reg_off_ena_set = LAN966X_OIC_INTR_ENA_SET,
+		.reg_off_ena_clr = LAN966X_OIC_INTR_ENA_CLR,
+		.reg_off_sticky  = LAN966X_OIC_INTR_STICKY,
+		.reg_off_ident   = LAN966X_OIC_DST_INTR_IDENT(0),
+		.reg_off_map     = LAN966X_OIC_DST_INTR_MAP(0),
+	}, {
+		.reg_off_ena_set = LAN966X_OIC_INTR_ENA_SET1,
+		.reg_off_ena_clr = LAN966X_OIC_INTR_ENA_CLR1,
+		.reg_off_sticky  = LAN966X_OIC_INTR_STICKY1,
+		.reg_off_ident   = LAN966X_OIC_DST_INTR_IDENT1(0),
+		.reg_off_map     = LAN966X_OIC_DST_INTR_MAP1(0),
+	}, {
+		.reg_off_ena_set = LAN966X_OIC_INTR_ENA_SET2,
+		.reg_off_ena_clr = LAN966X_OIC_INTR_ENA_CLR2,
+		.reg_off_sticky  = LAN966X_OIC_INTR_STICKY2,
+		.reg_off_ident   = LAN966X_OIC_DST_INTR_IDENT2(0),
+		.reg_off_map     = LAN966X_OIC_DST_INTR_MAP2(0),
+	}
+};
+
+static int lan966x_oic_chip_init(struct irq_chip_generic *gc)
+{
+	struct lan966x_oic_data *lan966x_oic = gc->domain->host_data;
+	struct lan966x_oic_chip_regs *chip_regs;
+
+	chip_regs = &lan966x_oic_chip_regs[gc->irq_base / 32];
+
+	gc->reg_base = lan966x_oic->regs;
+	gc->chip_types[0].regs.enable = chip_regs->reg_off_ena_set;
+	gc->chip_types[0].regs.disable = chip_regs->reg_off_ena_clr;
+	gc->chip_types[0].regs.ack = chip_regs->reg_off_sticky;
+	gc->chip_types[0].chip.irq_startup = lan966x_oic_irq_startup;
+	gc->chip_types[0].chip.irq_shutdown = lan966x_oic_irq_shutdown;
+	gc->chip_types[0].chip.irq_set_type = lan966x_oic_irq_set_type;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
+	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
+	gc->private = chip_regs;
+
+	/* Disable all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0U, chip_regs->reg_off_ena_clr);
+
+	return 0;
+}
+
+static void lan966x_oic_chip_exit(struct irq_chip_generic *gc)
+{
+	/* Disable and ack all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0U, gc->chip_types[0].regs.disable);
+	irq_reg_writel(gc, ~0U, gc->chip_types[0].regs.ack);
+}
+
+static int lan966x_oic_domain_init(struct irq_domain *d)
+{
+	struct lan966x_oic_data *lan966x_oic = d->host_data;
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler, d);
+
+	return 0;
+}
+
+static void lan966x_oic_domain_exit(struct irq_domain *d)
+{
+	struct lan966x_oic_data *lan966x_oic = d->host_data;
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
+}
+
+static int lan966x_oic_probe(struct platform_device *pdev)
+{
+	struct irq_domain_chip_generic_info dgc_info = {
+		.name		= "lan966x-oic",
+		.handler	= handle_level_irq,
+		.irqs_per_chip	= 32,
+		.num_ct		= 1,
+		.init		= lan966x_oic_chip_init,
+		.exit		= lan966x_oic_chip_exit,
+	};
+	struct irq_domain_info d_info = {
+		.fwnode		= of_node_to_fwnode(pdev->dev.of_node),
+		.domain_flags	= IRQ_DOMAIN_FLAG_DESTROY_GC,
+		.size		= LAN966X_OIC_NR_IRQ,
+		.hwirq_max	= LAN966X_OIC_NR_IRQ,
+		.ops		= &irq_generic_chip_ops,
+		.dgc_info	= &dgc_info,
+		.init		= lan966x_oic_domain_init,
+		.exit		= lan966x_oic_domain_exit,
+	};
+	struct lan966x_oic_data *lan966x_oic;
+	struct device *dev = &pdev->dev;
+	struct irq_domain *domain;
+
+	lan966x_oic = devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
+	if (!lan966x_oic)
+		return -ENOMEM;
+
+	lan966x_oic->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lan966x_oic->regs))
+		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs),
+				     "failed to map resource\n");
+
+	lan966x_oic->irq = platform_get_irq(pdev, 0);
+	if (lan966x_oic->irq < 0)
+		return dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
+
+	d_info.host_data = lan966x_oic;
+	domain = devm_irq_domain_instantiate(dev, &d_info);
+	if (IS_ERR(domain))
+		return dev_err_probe(dev, PTR_ERR(domain),
+				     "failed to instantiate the IRQ domain\n");
+	return 0;
+}
+
+static const struct of_device_id lan966x_oic_of_match[] = {
+	{ .compatible = "microchip,lan966x-oic" },
+	{} /* sentinel */
+};
+MODULE_DEVICE_TABLE(of, lan966x_oic_of_match);
+
+static struct platform_driver lan966x_oic_driver = {
+	.probe = lan966x_oic_probe,
+	.driver = {
+		.name = "lan966x-oic",
+		.of_match_table = lan966x_oic_of_match,
+	},
+};
+module_platform_driver(lan966x_oic_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("Microchip LAN966x OIC driver");
+MODULE_LICENSE("GPL");
-- 
2.45.0



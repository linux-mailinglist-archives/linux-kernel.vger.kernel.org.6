Return-Path: <linux-kernel+bounces-356960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E71996963
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C461E1C221AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2D3193094;
	Wed,  9 Oct 2024 11:58:33 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C5192D78;
	Wed,  9 Oct 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475112; cv=none; b=RjXcboxJ3f6pajBnBbxLPUb39le5eeR2eBeEtQe/VVEHINU1EfTTH9yd4kOaBA6Eh0zDvTHeuDxbDHc5DHkq3nBmSUKar5HO788HY9XVE5gZfbnokh27ROSvWrGmZB+6i0xC3G/1X+4aBDfmNzz8Sz5C4cNjIlr7IThtCzk1h3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475112; c=relaxed/simple;
	bh=cNcbx2JatCKrTve6SMRdZnMs3RXi+VAkE6JQhzgGYrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaN/h6mUVkjlcx0e7tBWJ8Iu0/o92jRWVWDMcEV9MmFMFd39GsJaCBjHYL8jkVCPh+tktmdZSpBk6AUjmmje9Wb6qw2UdAJVm9xNiPcOv1m9iRiK1zLTmBrbmlh8xiBQdr5tKZbOX2EpRJjjMzxmjPiTHvQoayBZ73HPonwWKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 9 Oct
 2024 19:58:18 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 9 Oct 2024 19:58:18 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Date: Wed, 9 Oct 2024 19:58:13 +0800
Message-ID: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009115813.2908803-1-kevin_chen@aspeedtech.com>
References: <20241009115813.2908803-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Support for the Aspeed Interrupt Controller found on Aspeed Silicon SoCs,
such as the AST2700, which is arm64 architecture.

To support ASPEED interrupt controller(INTC) maps the internal interrupt
sources of the AST27XX device to an parent interrupt controller.
---
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-aspeed-intc.c | 139 ++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e3679ec2b9f7..086911bf4db6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
+obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
new file mode 100644
index 000000000000..ef1c095ad09e
--- /dev/null
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+
+#define INTC_INT_ENABLE_REG	0x00
+#define INTC_INT_STATUS_REG	0x04
+#define IRQS_PER_WORD 32
+
+struct aspeed_intc_ic {
+	void __iomem		*base;
+	raw_spinlock_t		gic_lock;
+	raw_spinlock_t		intc_lock;
+	struct irq_domain	*irq_domain;
+};
+
+static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
+{
+	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long bit, status;
+
+	chained_irq_enter(chip, desc);
+
+	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
+		status = readl(intc_ic->base + INTC_INT_STATUS_REG);
+		for_each_set_bit(bit, &status, IRQS_PER_WORD) {
+			generic_handle_domain_irq(intc_ic->irq_domain, bit);
+			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_intc_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
+	unsigned int mask = readl(intc_ic->base + INTC_INT_ENABLE_REG) & ~BIT(data->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static void aspeed_intc_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
+	unsigned int unmask = readl(intc_ic->base + INTC_INT_ENABLE_REG) | BIT(data->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(unmask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static struct irq_chip aspeed_intc_chip = {
+	.name			= "ASPEED INTC",
+	.irq_mask		= aspeed_intc_irq_mask,
+	.irq_unmask		= aspeed_intc_irq_unmask,
+};
+
+static int aspeed_intc_ic_map_irq_domain(struct irq_domain *domain, unsigned int irq,
+					 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &aspeed_intc_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc_ic_irq_domain_ops = {
+	.map = aspeed_intc_ic_map_irq_domain,
+};
+
+static int __init aspeed_intc_ic_of_init(struct device_node *node,
+					 struct device_node *parent)
+{
+	struct aspeed_intc_ic *intc_ic;
+	int ret = 0;
+	int irq, i;
+
+	intc_ic = kzalloc(sizeof(*intc_ic), GFP_KERNEL);
+	if (!intc_ic)
+		return -ENOMEM;
+
+	intc_ic->base = of_iomap(node, 0);
+	if (!intc_ic->base) {
+		pr_err("Failed to iomap intc_ic base\n");
+		ret = -ENOMEM;
+		goto err_free_ic;
+	}
+	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
+	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
+
+	intc_ic->irq_domain = irq_domain_add_linear(node, 32,
+						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
+	if (!intc_ic->irq_domain) {
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	raw_spin_lock_init(&intc_ic->gic_lock);
+	raw_spin_lock_init(&intc_ic->intc_lock);
+
+	/* Check all the irq numbers valid. If not, unmaps all the base and frees the data. */
+	for (i = 0; i < of_irq_count(node); i++) {
+		irq = irq_of_parse_and_map(node, i);
+		if (!irq) {
+			pr_err("Failed to get irq number\n");
+			ret = -EINVAL;
+			goto err_iounmap;
+		}
+	}
+
+	for (i = 0; i < of_irq_count(node); i++) {
+		irq = irq_of_parse_and_map(node, i);
+			irq_set_chained_handler_and_data(irq, aspeed_intc_ic_irq_handler, intc_ic);
+	}
+
+	return 0;
+
+err_iounmap:
+	iounmap(intc_ic->base);
+err_free_ic:
+	kfree(intc_ic);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of_init);
-- 
2.34.1



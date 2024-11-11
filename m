Return-Path: <linux-kernel+bounces-403563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC639C373E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C3E1F21FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C11494A9;
	Mon, 11 Nov 2024 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eehK6ffx"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498A4B5C1;
	Mon, 11 Nov 2024 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297728; cv=none; b=eQX8q8NVlvXfpMv3W1phMNbNIYDOEIh1j+MalhaZset4hiY5BY6ilwvTRahgBLD6YCgH54/pOmCGVf91Q8M2qAVDiI5Z2JUNDNe1KhtqM6n3S0wLcocRANJ3vazhoiAb7A4q79i+49l/7rd3ln/KDrv2Ez9NKODtJuplrCRmxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297728; c=relaxed/simple;
	bh=Nunq7MnSPv4qHaqYemlbcRJmOW7gXkEcCPOBhtRAPWc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TedIjcm/1cv+tmb8pz0PKS1WmiAKSSN7HHRdw8cQi0rKHNkIPj0TwUMzbkskpGlefFxWytj0AbI9wa6dQ0JVpOnbf7a1D9GWF9ntz6uAyv6xaNv+ZgZOcmAtxgHy8x2yoTOxJtn1J+sGZ8af6O/flRWGbSWJo1X22/QnAf4mXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eehK6ffx; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-288d4da7221so2238323fac.1;
        Sun, 10 Nov 2024 20:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731297725; x=1731902525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+fPQhcktyhn766PuZ6e67L6+1wcYRMcJZUggR/XiQ0=;
        b=eehK6ffxPQlt5EP8dPecd2AuzQjGfXiyhHUkl3Sui0HAnaVHik9nlzzxmhocbOJXf4
         u2kdkRHj2Zh1ACADIa+JDy3pOtAfDpgewCefB274z6S1e8WOZBYqC1ghvfQjAKmrFE8M
         GJ9ot3Iabw00N2mPZgn6g4uJHsA6Jf9TU19F0PSWWYy9096j1Kvh931O2piEHo9a3BmR
         3vA27zXtFeoPUA7ZMeCTzS2YXfEWjLpiOpw0oZ53nDRrr6/C193F37SAPD/9hMuVyqIj
         2aENf1jW0RbChp+AG6WRy5iuxX4WyUQiBpOsXRvvLjTv1uvZi/ua7oVWcSUgLWLH7UE0
         dejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731297725; x=1731902525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+fPQhcktyhn766PuZ6e67L6+1wcYRMcJZUggR/XiQ0=;
        b=NiWR5uJsaIoKGYo8n0OMd2tqIgn/HrbUpFkQqW0QS/TcKIQwskZf+0EJo38qhtgO+o
         iPDUzpn8o1QWN1kDYEdDkJCj9mTB21Dto/ja6omLitZvSYiUx4rDZfUH6FCtPFfkC9wz
         9TeV3ipP0QMsgESh4EK5yEA9DqEXGHt3+hCSIt5L2VFlikmT6MqAQSY0Dap8VFVwYW8w
         2gOfw6WpzU24UE33gcJNcc6q+YU0CaPd2C1fEjnbgtN5k3auX4R4KQZBp1T9nd/grpfM
         sKDtft6CL3T2u9cdo/kH4JplOV0vb0EjDSey7Dxxg+FczFH08BO3hudVNw4QU3EjcC7O
         YPYw==
X-Forwarded-Encrypted: i=1; AJvYcCUCDXGxB/F4yq8KVBEiB4svsqKiNlo1xVTGes4AEp3LVI72h6W06OB+Y8+kLveFFglrjWdiwOtBmYKAlQjP@vger.kernel.org, AJvYcCVgiJlS0ysZbVvLEOBLWmHXng1zNLNp0w0tSr+cAE727r8YKCgAlk9C6ng8G7kEyan5cny13n4GyLsv@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7O3taUtJ4RXQ9ywMRZB+UsONE39wcmbigSvEY1lPoc+kVW8+
	qaRXZRDrQIqr/Nbkpeq6C0z4owWKz3NCyoiAO/X5e8bV/3u0vpFO
X-Google-Smtp-Source: AGHT+IE1+3vDt96wuzJHta3Nkt+aV05zWOrqsajEFRzvGnq1988dsLWPrG80m3LN6mFGflF/nyetBQ==
X-Received: by 2002:a05:6870:380d:b0:277:e08a:23a0 with SMTP id 586e51a60fabf-295602fd28cmr7803476fac.41.1731297723750;
        Sun, 10 Nov 2024 20:02:03 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a108e29f8sm2121721a34.47.2024.11.10.20.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:02:02 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt controller
Date: Mon, 11 Nov 2024 12:01:55 +0800
Message-Id: <8076fe2af9f2b007a42c986ed193ba50ff674bfa.1731296803.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731296803.git.unicorn_wang@outlook.com>
References: <cover.1731296803.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add driver for Sophgo SG2042 MSI interrupt controller.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/irqchip/Kconfig          |   8 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-sg2042-msi.c | 255 +++++++++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d82bcab233a1..76a38a4d62eb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -729,6 +729,14 @@ config MCHP_EIC
 	help
 	  Support for Microchip External Interrupt Controller.
 
+config SOPHGO_SG2042_MSI
+	bool "Sophgo SG2042 MSI controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Support for the Sophgo SG2042 MSI Controller.
+	  This on-chip interrupt controller enables MSI sources to be
+	  routed to the primary PLIC controller on SoC.
+
 config SUNPLUS_SP7021_INTC
 	bool "Sunplus SP7021 interrupt controller" if COMPILE_TEST
 	default SOC_SP7021
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e3679ec2b9f7..53617890268a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -125,4 +125,5 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
+obj-$(CONFIG_SOPHGO_SG2042_MSI)		+= irq-sg2042-msi.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
new file mode 100644
index 000000000000..79449f974ed5
--- /dev/null
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SG2042 MSI Controller
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct sg2042_msi_data {
+	void __iomem	*reg_clr; /* clear reg, see TRM, 10.1.33, GP_INTR0_CLR */
+
+	u64		doorbell_addr; /* see TRM, 10.1.32, GP_INTR0_SET */
+
+	u32		irq_first; /* The vector number that MSIs starts */
+	u32		num_irqs;  /* The number of vectors for MSIs */
+
+	unsigned long	*msi_map;
+	struct mutex	msi_map_lock; /* lock for msi_map */
+};
+
+static int sg2042_msi_allocate_hwirq(struct sg2042_msi_data *priv, int num_req)
+{
+	int first;
+
+	mutex_lock(&priv->msi_map_lock);
+
+	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
+					get_count_order(num_req));
+	if (first < 0) {
+		mutex_unlock(&priv->msi_map_lock);
+		return -ENOSPC;
+	}
+
+	mutex_unlock(&priv->msi_map_lock);
+
+	return priv->irq_first + first;
+}
+
+static void sg2042_msi_free_hwirq(struct sg2042_msi_data *priv,
+				  int hwirq, int num_req)
+{
+	int first = hwirq - priv->irq_first;
+
+	mutex_lock(&priv->msi_map_lock);
+	bitmap_release_region(priv->msi_map, first, get_count_order(num_req));
+	mutex_unlock(&priv->msi_map_lock);
+}
+
+static void sg2042_msi_irq_ack(struct irq_data *d)
+{
+	struct sg2042_msi_data *data  = irq_data_get_irq_chip_data(d);
+	int bit_off = d->hwirq - data->irq_first;
+
+	writel(1 << bit_off, (unsigned int *)data->reg_clr);
+
+	irq_chip_ack_parent(d);
+}
+
+static void sg2042_msi_irq_compose_msi_msg(struct irq_data *data,
+					   struct msi_msg *msg)
+{
+	struct sg2042_msi_data *priv = irq_data_get_irq_chip_data(data);
+
+	msg->address_hi = upper_32_bits(priv->doorbell_addr);
+	msg->address_lo = lower_32_bits(priv->doorbell_addr);
+	msg->data = 1 << (data->hwirq - priv->irq_first);
+
+	pr_debug("%s hwirq[%d]: address_hi[%#x], address_lo[%#x], data[%#x]\n",
+		 __func__,
+		 (int)data->hwirq, msg->address_hi, msg->address_lo, msg->data);
+}
+
+static struct irq_chip sg2042_msi_middle_irq_chip = {
+	.name			= "SG2042 MSI",
+	.irq_ack		= sg2042_msi_irq_ack,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
+};
+
+static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain,
+					  unsigned int virq, int hwirq)
+{
+	struct irq_fwspec fwspec;
+	struct irq_data *d;
+	int ret;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = hwirq;
+	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	d = irq_domain_get_irq_data(domain->parent, virq);
+	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+}
+
+static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain,
+					  unsigned int virq,
+					  unsigned int nr_irqs, void *args)
+{
+	struct sg2042_msi_data *priv = domain->host_data;
+	int hwirq, err, i;
+
+	hwirq = sg2042_msi_allocate_hwirq(priv, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto err_hwirq;
+
+		pr_debug("%s: virq[%d], hwirq[%d]\n",
+			 __func__, virq + i, (int)hwirq + i);
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &sg2042_msi_middle_irq_chip, priv);
+	}
+
+	return 0;
+
+err_hwirq:
+	sg2042_msi_free_hwirq(priv, hwirq, nr_irqs);
+	irq_domain_free_irqs_parent(domain, virq, i);
+
+	return err;
+}
+
+static void sg2042_msi_middle_domain_free(struct irq_domain *domain,
+					  unsigned int virq,
+					  unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct sg2042_msi_data *priv = irq_data_get_irq_chip_data(d);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	sg2042_msi_free_hwirq(priv, d->hwirq, nr_irqs);
+}
+
+static const struct irq_domain_ops pch_msi_middle_domain_ops = {
+	.alloc	= sg2042_msi_middle_domain_alloc,
+	.free	= sg2042_msi_middle_domain_free,
+};
+
+static int sg2042_msi_init_domains(struct sg2042_msi_data *priv,
+				   struct device_node *node)
+{
+	struct irq_domain *plic_domain, *middle_domain;
+	struct device_node *plic_node;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(node);
+
+	if (!of_find_property(node, "interrupt-parent", NULL)) {
+		pr_err("Can't find interrupt-parent!\n");
+		return -EINVAL;
+	}
+
+	plic_node = of_irq_find_parent(node);
+	if (!plic_node) {
+		pr_err("Failed to find the PLIC node!\n");
+		return -ENXIO;
+	}
+
+	plic_domain = irq_find_host(plic_node);
+	of_node_put(plic_node);
+	if (!plic_domain) {
+		pr_err("Failed to find the PLIC domain\n");
+		return -ENXIO;
+	}
+
+	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, priv->num_irqs,
+						    fwnode,
+						    &pch_msi_middle_domain_ops,
+						    priv);
+	if (!middle_domain) {
+		pr_err("Failed to create the MSI middle domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int sg2042_msi_probe(struct platform_device *pdev)
+{
+	struct sg2042_msi_data *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sg2042_msi_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
+	if (IS_ERR(data->reg_clr)) {
+		dev_err(&pdev->dev, "Failed to map clear register\n");
+		return PTR_ERR(data->reg_clr);
+	}
+
+	if (of_property_read_u64(pdev->dev.of_node, "sophgo,msi-doorbell-addr",
+				 &data->doorbell_addr)) {
+		dev_err(&pdev->dev, "Unable to parse MSI doorbell addr\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(pdev->dev.of_node, "sophgo,msi-base-vec",
+				 &data->irq_first)) {
+		dev_err(&pdev->dev, "Unable to parse MSI vec base\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(pdev->dev.of_node, "sophgo,msi-num-vecs",
+				 &data->num_irqs)) {
+		dev_err(&pdev->dev, "Unable to parse MSI vec number\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&data->msi_map_lock);
+
+	data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);
+	if (!data->msi_map)
+		return -ENOMEM;
+
+	return sg2042_msi_init_domains(data, pdev->dev.of_node);
+}
+
+static const struct of_device_id sg2042_msi_of_match[] = {
+	{ .compatible = "sophgo,sg2042-msi" },
+	{}
+};
+
+static struct platform_driver sg2042_msi_driver = {
+	.driver = {
+		.name = "sg2042-msi",
+		.of_match_table = of_match_ptr(sg2042_msi_of_match),
+	},
+	.probe = sg2042_msi_probe,
+};
+builtin_platform_driver(sg2042_msi_driver);
-- 
2.34.1



Return-Path: <linux-kernel+bounces-436873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7081E9E8BE6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233C0281462
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C01C1F3B;
	Mon,  9 Dec 2024 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6lbh9y0"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2B214A6A;
	Mon,  9 Dec 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728331; cv=none; b=hieTP+OM39zkNpEjJZ1nCY+deWTgodgmOFn5WbhVe98M0d7FBmAeW7IaIVzeBGyg5D5ZdqDGArvLknG1kTjI6AN3kCpmwp2D+6UBq9vMolHjCqZwblQQp/rIDyRRENTHGmdWUfNOaFIfAoNa8SGqwn9rn9sx01AT9vO7jfJYh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728331; c=relaxed/simple;
	bh=ldTUgjFVvCb2fC4JAqifCLNX6+YApSbQJDbyTf++Nbg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ar97FWVAiH83/L778/GToraXtJYEr/9N2JnVI31IqjEqQKOj8bK1w92bShoShIScHu5cYsbbmOw1T3Keows/u7e/1mCbMR9qpt+oQNFkJvvGAtcxTol5TqZSR8NZNBlyHciMNh8JsaYXULzCOO4oq6Gc6Z0wyXHH/GAKjZFkVpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6lbh9y0; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2be8023e1so167533eaf.1;
        Sun, 08 Dec 2024 23:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728329; x=1734333129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZQ8cjmGeH2omjQOFg/Y4/RVhyCVeY7LvUq7HoVDLNA=;
        b=A6lbh9y0D9HNZCatFdnr99sbkHzSS/+SGsW0uLy80plNV1VOknCO51sHFdPsk6COh9
         9q3JHAx5Ob8r2RrAtkJ0iF7lJwBXimWj8p4tOoRdSNhFt24n6zgZcms3cEbNFjNXUEll
         n59BAhcOEYI44wv4DVgvTeO0p9nihOcNkKDGe+LQU37oqHIyRy8MyYjkXEkoyu1+p7CG
         TbAIFQ4KiDagf/jDxK3RCo6wHMTwsQ1ocVC8iJTfAdn+Hr98nEf0yG4Z5OICK7nAQLOf
         dFq4JvkmStUlc8ElMhorgjhzP08Co6GR5LXuxbEREL7GYzEWE/eWJLLcHcVDjdo4/82Q
         vj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728329; x=1734333129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZQ8cjmGeH2omjQOFg/Y4/RVhyCVeY7LvUq7HoVDLNA=;
        b=YFzOL5ULNDQRVe9ltRk74fSWclddJ4djEUk+1nHbnGSdEr2nQFvP4bAQ7rgTUgifV8
         2+72hqJCB0zQ2wt/0uSGKLRGgYWmMwEVGeSOWqs8u/YWNFkZb7iYQEk1IUa1h/aVnHap
         n90uUVUO+/Vzc9I4EyzKyEjHxDV+fTYLt4bKHELm8x+dmUHKUv6BreLumnR2OhQmXLOt
         0v6iklpfdWmqCNHgsypKz7j2vwWIZxAai8XWB9qyhskiyDscMVtI8AqrIyGi41jgGlTM
         DXBMN0RBraHfQixr4VTIL0vmDqgexv+s6QlhbFZpGVl3qjO0CrNqNRduu659OpjW2wbr
         SCQw==
X-Forwarded-Encrypted: i=1; AJvYcCVCh6Qo3GKcG4Yo6Taes+Hf3P85OEdXGeKJkGOeoECdg+OIkZvmAoNIEjniwMbgkENK6u8xw3KGdCJ7@vger.kernel.org, AJvYcCWfMPtp05eDEYMTrrvRcLQT5IT7+OFiUU+8uq9pOrFf79YzqOK5fUFV2TCX8ImqupmF+1iTDA3xmFXUke7O@vger.kernel.org
X-Gm-Message-State: AOJu0YwfP8CC8fExNN5ftz3Y3KCt480B71k1FP0h7AB8epPG5ux/sExu
	uNqkCPRwTvZesQTbNK0ZBy0Ir2kRF2WLtjXjEx3f+oHeVdXbtyqwV1cV91ZY
X-Gm-Gg: ASbGncsBUbw067DcSWMqgDHTmMOki9yZUQQCp4KxUnHT33D/2CgrYXbZyLTGv+vca8R
	97CJKiVge0wzpluF4Y4Tz3sbkwPv0G3eNP1jZ5CJPS0R9JTu4Rqdalllejle/PE1GvlFHdxMo9C
	ksS41DasVa+ja7L1t76MZYSGe8bbtpEvm4wbFpFMLX2WXu76Mr+p1JLAlN7W1/Ry9Ei3PVNFi2c
	puBwHm9e0jBEJo6YA4ID531+5PRlj183QQiqig7jBe1hDmiqt9JJKr5+FvV
X-Google-Smtp-Source: AGHT+IEBoLa9cvZyfxoV+5TLivJeNvZCEqunJBtUgy0UO6Zk7+DZe+syCil5pQZlT/J3QZQvF8n/yw==
X-Received: by 2002:a05:6870:7b49:b0:29e:4c3e:a007 with SMTP id 586e51a60fabf-29f504621dcmr9316990fac.21.1733728328874;
        Sun, 08 Dec 2024 23:12:08 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2b98bc9d9sm421924eaf.18.2024.12.08.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:12:07 -0800 (PST)
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
Subject: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt controller
Date: Mon,  9 Dec 2024 15:12:00 +0800
Message-Id: <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733726057.git.unicorn_wang@outlook.com>
References: <cover.1733726057.git.unicorn_wang@outlook.com>
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
 drivers/irqchip/Kconfig          |  12 ++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-sg2042-msi.c | 285 +++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 9bee02db1643..161fb5df857f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -749,6 +749,18 @@ config MCHP_EIC
 	help
 	  Support for Microchip External Interrupt Controller.
 
+config SOPHGO_SG2042_MSI
+	bool "Sophgo SG2042 MSI Controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on PCI
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_MSI_LIB
+	select PCI_MSI
+	help
+	  Support for the Sophgo SG2042 MSI Controller.
+	  This on-chip interrupt controller enables MSI sources to be
+	  routed to the primary PLIC controller on SoC.
+
 config SUNPLUS_SP7021_INTC
 	bool "Sunplus SP7021 interrupt controller" if COMPILE_TEST
 	default SOC_SP7021
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 25e9ad29b8c4..dd60e597491d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -128,4 +128,5 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
+obj-$(CONFIG_SOPHGO_SG2042_MSI)		+= irq-sg2042-msi.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
new file mode 100644
index 000000000000..495ee2b45eb2
--- /dev/null
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SG2042 MSI Controller
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
+ */
+
+#include <linux/cleanup.h>
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
+#include "irq-msi-lib.h"
+
+#define SG2042_VECTOR_MIN	64
+#define SG2042_VECTOR_MAX	95
+
+struct sg2042_msi_data {
+	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+
+	u64		doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
+
+	u32		irq_first;	// The vector number that MSIs starts
+	u32		num_irqs;	// The number of vectors for MSIs
+
+	unsigned long	*msi_map;
+	struct mutex	msi_map_lock;	// lock for msi_map
+};
+
+static int sg2042_msi_allocate_hwirq(struct sg2042_msi_data *priv, int num_req)
+{
+	int first;
+
+	guard(mutex)(&priv->msi_map_lock);
+	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
+					get_count_order(num_req));
+	return first >= 0 ? priv->irq_first + first : -ENOSPC;
+}
+
+static void sg2042_msi_free_hwirq(struct sg2042_msi_data *priv,
+				  int hwirq, int num_req)
+{
+	int first = hwirq - priv->irq_first;
+
+	guard(mutex)(&priv->msi_map_lock);
+	bitmap_release_region(priv->msi_map, first, get_count_order(num_req));
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
+	pr_debug("%s hwirq[%ld]: address_hi[%#x], address_lo[%#x], data[%#x]\n",
+		 __func__, data->hwirq, msg->address_hi, msg->address_lo, msg->data);
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
+		pr_debug("%s: virq[%d], hwirq[%d]\n", __func__, virq + i, hwirq + i);
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
+static const struct irq_domain_ops sg2042_msi_middle_domain_ops = {
+	.alloc	= sg2042_msi_middle_domain_alloc,
+	.free	= sg2042_msi_middle_domain_free,
+	.select	= msi_lib_irq_domain_select,
+};
+
+#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				   MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
+
+static struct msi_parent_ops sg2042_msi_parent_ops = {
+	.required_flags		= SG2042_MSI_FLAGS_REQUIRED,
+	.supported_flags	= SG2042_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "SG2042-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
+static int sg2042_msi_init_domains(struct sg2042_msi_data *priv,
+				   struct device_node *node)
+{
+	struct fwnode_handle *fwnode = of_node_to_fwnode(node);
+	struct irq_domain *plic_domain, *middle_domain;
+	struct device_node *plic_node;
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
+						    &sg2042_msi_middle_domain_ops,
+						    priv);
+	if (!middle_domain) {
+		pr_err("Failed to create the MSI middle domain\n");
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
+
+	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	middle_domain->msi_parent_ops = &sg2042_msi_parent_ops;
+
+	return 0;
+}
+
+static int sg2042_msi_probe(struct platform_device *pdev)
+{
+	struct of_phandle_args args = {};
+	struct sg2042_msi_data *data;
+	int ret;
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
+	ret = of_parse_phandle_with_args(pdev->dev.of_node, "msi-ranges",
+					 "#interrupt-cells", 0, &args);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to parse MSI vec base\n");
+		return ret;
+	}
+	data->irq_first = (u32)args.args[0];
+
+	ret = of_property_read_u32_index(pdev->dev.of_node, "msi-ranges",
+					 args.args_count + 1, &data->num_irqs);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to parse MSI vec number\n");
+		return ret;
+	}
+
+	if (data->irq_first < SG2042_VECTOR_MIN ||
+	    (data->irq_first + data->num_irqs - 1) > SG2042_VECTOR_MAX) {
+		dev_err(&pdev->dev, "msi-ranges is incorrect!\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&data->msi_map_lock);
+
+	data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);
+	if (!data->msi_map)
+		return -ENOMEM;
+
+	ret = sg2042_msi_init_domains(data, pdev->dev.of_node);
+	if (ret)
+		bitmap_free(data->msi_map);
+
+	return ret;
+}
+
+static const struct of_device_id sg2042_msi_of_match[] = {
+	{ .compatible	= "sophgo,sg2042-msi" },
+	{}
+};
+
+static struct platform_driver sg2042_msi_driver = {
+	.driver = {
+		.name		= "sg2042-msi",
+		.of_match_table	= of_match_ptr(sg2042_msi_of_match),
+	},
+	.probe = sg2042_msi_probe,
+};
+builtin_platform_driver(sg2042_msi_driver);
-- 
2.34.1



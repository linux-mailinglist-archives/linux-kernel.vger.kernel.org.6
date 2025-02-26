Return-Path: <linux-kernel+bounces-532851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1FA452EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FBC19C2A57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FE216618;
	Wed, 26 Feb 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCQdCtWT"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E0219A79;
	Wed, 26 Feb 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536131; cv=none; b=swY9x3RU8KZmko/ahKUrGVVCdVg77fkZ8rTg1VYC2kquFEzoQTlLKcye7iYtYpj061IiiVDQUfBLhhIN44ub7Yxb6jNmb7gsNbtPZDIHe99zm5vFhu3bAstKxJBkW5a7I0q/YQ2w1WsUjphq7i5pgKtgcuL/G36XbJdWs8thQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536131; c=relaxed/simple;
	bh=R4NGN1mLxfJOfVOq2/PvkJAPjtmRo1siCKgn2kgU6ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VaosSMoSyezN9LfPTiayJOJjEJXnQSSw5UAurrgH5ZpVWH+BhvE2nxl3TmipYENJEShOCH8pEEol1HdbySlNwigZB0qO1uv4kekky1S6fanNUTkACwTx+cY97w/Vyc3VDIuirrXDf7gMXFR/WaDRR2dk+qfONX5v/Z2zXC6F77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCQdCtWT; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7272f3477e9so1930225a34.3;
        Tue, 25 Feb 2025 18:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740536129; x=1741140929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUmZvnb1tRiSqbV2BrYwnOfVYe6ZV5LXNUg2BqKjz48=;
        b=BCQdCtWTJpDbTZz61bC05XrwbULohTaA1gS+oaeOeM+IXY0WmXpMTE6SUgFAb/uMnO
         xY2EC5QhQgqr5YiXnIkaecOL0+Veh5cPfd1ONwljFYKSERp/O/A02p0be+36ULw3xibi
         ZXTzGpWWWJVjKeMl0prXujJBhcaVkNDj52h/EoXECtAdkvS6R+zV4gUShSAR1ic8gPLV
         qs78tWzq9XwBqKZwArGpmWREOtzmQZTJ1jHD+bE5KfIKjWDFFKTkmz1cZ3PeqU3jz7Ic
         qHiKsvrqWyVfrAC/0i3my+GNi4EoQkJhE5NV8Gkf+Otyc3E0mMEwh9zTlRlpwixYGHAK
         DBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536129; x=1741140929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUmZvnb1tRiSqbV2BrYwnOfVYe6ZV5LXNUg2BqKjz48=;
        b=cvEZ9pqqPBOfeKWssf9e0wBd3eieWZqareDymND08FTA2JQYQGD42saQu+B8V6fXgi
         JuQ4xXlQeZ1a/7xzHAZPL1WCpJDvkog/Y5IRGvj3JGF581uaTt2xxnS/4Cg7dhrzqbd+
         ZaYUdc63AalHKQVlMmzxaJkH0DoMtCAJiVtV04lvDp1+R5KHV1HFf/8O5JjTwkmI6fZQ
         fo893hskGGfDWBMGTB2w+L6OCB8IdA21j+ZlfMoERyX/3/5E5vjYCafuIXsGIWoyjN8n
         7hKo/McUsOJMuvZn8weiCMj0OPKKVEkaCwYb4ZM9ab7EL1k1Y0R4xGqK4LHEhD67CLB8
         mODw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ76QixuPTIic2vghEAQr8atY2O1ydQZGu0Lg00mPlE768Mnsb2dJRSclr8TQNVkk+9iMJkGMhJnUegOQr@vger.kernel.org, AJvYcCWbHg9kEbzPbEFr7OQHNXMlKTp0gy7g41Hjb642sxl+5vLqhSflYUgLChR0CUk5quwYjYsEXDxOOer+@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKGJblIr86pEML38Z6c01QsDZQ5QjXZ4VqiKjYwmewSHR059I
	y6xJZ51JlCWjbF0UYTA0r8id1xowPEAGjkZC0OhZ38jMnyH8VhP6
X-Gm-Gg: ASbGncuh527RxZJ6T5WqpPPFWSfgYEYHYKp4d2GnAJOgj0pao2W6CiKa+AaMFxVp5fb
	vtuFzjJefVFRlEDFKROHtETRnyVbjYgkR2GiMLIGC6Lvt/Cba11uDf6HIW858O3GTud/IFy+QoL
	+KzCVSMpdYCTYKyjk8eG+I0EPRTUF4xZk+UFFvklMPLpl29OWYnqOCyYoOL9yS4OWTHts0WHam0
	TQXFj/mfXYc+/yybbt+qymbpeXglunwzfBgCPFB69GD0HRiqG2OnZWSIltAm59zBt/nXL4tJV1v
	39ux+Hrk39PY4CB2bOqETA8VeZRL1FDRDzzB
X-Google-Smtp-Source: AGHT+IE+BOCYfr9QO3EfVjOBLzsZKPPxYogSm+kRRkFUHbnyJZsjyeWiwA417ugAXi8l2mp7JA54JQ==
X-Received: by 2002:a05:6830:3883:b0:727:4144:2bbb with SMTP id 46e09a7af769-7289d0facc8mr4486493a34.8.1740536128887;
        Tue, 25 Feb 2025 18:15:28 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c11128723csm661569fac.18.2025.02.25.18.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:15:27 -0800 (PST)
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
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: [PATCH v5 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt controller
Date: Wed, 26 Feb 2025 10:15:19 +0800
Message-Id: <3104216ca90a5f532bafb676c1c5b1efb19e94d1.1740535748.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740535748.git.unicorn_wang@outlook.com>
References: <cover.1740535748.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add driver for Sophgo SG2042 MSI interrupt controller.

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/irqchip/Kconfig          |  12 ++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-sg2042-msi.c | 258 +++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c11b9965c4ad..078ed8b55b34 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -752,6 +752,18 @@ config MCHP_EIC
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
index 000000000000..9c0a5f2777a4
--- /dev/null
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -0,0 +1,258 @@
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
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
+#define SG2042_MAX_MSI_VECTOR	32
+
+struct sg2042_msi_chipdata {
+	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+
+	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
+
+	u32		irq_first;	// The vector number that MSIs starts
+	u32		num_irqs;	// The number of vectors for MSIs
+
+	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
+	struct mutex	msi_map_lock;	// lock for msi_map
+};
+
+static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
+{
+	int first;
+
+	guard(mutex)(&data->msi_map_lock);
+	first = bitmap_find_free_region(data->msi_map, data->num_irqs,
+					get_count_order(num_req));
+	return first >= 0 ? first : -ENOSPC;
+}
+
+static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data,
+				  int hwirq, int num_req)
+{
+	guard(mutex)(&data->msi_map_lock);
+	bitmap_release_region(data->msi_map, hwirq, get_count_order(num_req));
+}
+
+static void sg2042_msi_irq_ack(struct irq_data *d)
+{
+	struct sg2042_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
+	int bit_off = d->hwirq;
+
+	writel(1 << bit_off, data->reg_clr);
+
+	irq_chip_ack_parent(d);
+}
+
+static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d,
+					   struct msi_msg *msg)
+{
+	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+
+	msg->address_hi = upper_32_bits(data->doorbell_addr);
+	msg->address_lo = lower_32_bits(data->doorbell_addr);
+	msg->data = 1 << d->hwirq;
+}
+
+static const struct irq_chip sg2042_msi_middle_irq_chip = {
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
+	struct sg2042_msi_chipdata *data = domain->host_data;
+	struct irq_fwspec fwspec;
+	struct irq_data *d;
+	int ret;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = data->irq_first + hwirq;
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
+	struct sg2042_msi_chipdata *data = domain->host_data;
+	int hwirq, err, i;
+
+	hwirq = sg2042_msi_allocate_hwirq(data, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto err_hwirq;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &sg2042_msi_middle_irq_chip, data);
+	}
+
+	return 0;
+
+err_hwirq:
+	sg2042_msi_free_hwirq(data, hwirq, nr_irqs);
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
+	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	sg2042_msi_free_hwirq(data, d->hwirq, nr_irqs);
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
+static const struct msi_parent_ops sg2042_msi_parent_ops = {
+	.required_flags		= SG2042_MSI_FLAGS_REQUIRED,
+	.supported_flags	= SG2042_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "SG2042-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
+static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
+				   struct irq_domain *plic_domain,
+				   struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct irq_domain *middle_domain;
+
+	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, data->num_irqs,
+						    fwnode,
+						    &sg2042_msi_middle_domain_ops,
+						    data);
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
+	struct fwnode_reference_args args = {};
+	struct sg2042_msi_chipdata *data;
+	struct device *dev = &pdev->dev;
+	struct irq_domain *plic_domain;
+	struct resource *res;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(struct sg2042_msi_chipdata), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
+	if (IS_ERR(data->reg_clr)) {
+		dev_err(dev, "Failed to map clear register\n");
+		return PTR_ERR(data->reg_clr);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "doorbell");
+	if (!res) {
+		dev_err(dev, "Failed get resource from set\n");
+		return -EINVAL;
+	}
+	data->doorbell_addr = res->start;
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
+						 "#interrupt-cells", 0, 0, &args);
+	if (ret) {
+		dev_err(dev, "Unable to parse MSI vec base\n");
+		return ret;
+	}
+	fwnode_handle_put(args.fwnode);
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
+						 NULL, args.nargs + 1,
+						 0, &args);
+	if (ret) {
+		dev_err(dev, "Unable to parse MSI vec number\n");
+		return ret;
+	}
+
+	plic_domain = irq_find_matching_fwnode(args.fwnode, DOMAIN_BUS_ANY);
+	fwnode_handle_put(args.fwnode);
+	if (!plic_domain) {
+		pr_err("Failed to find the PLIC domain\n");
+		return -ENXIO;
+	}
+
+	data->irq_first = (u32)args.args[0];
+	data->num_irqs = (u32)args.args[args.nargs - 1];
+
+	mutex_init(&data->msi_map_lock);
+
+	return sg2042_msi_init_domains(data, plic_domain, dev);
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
+		.of_match_table	= sg2042_msi_of_match,
+	},
+	.probe = sg2042_msi_probe,
+};
+builtin_platform_driver(sg2042_msi_driver);
-- 
2.34.1



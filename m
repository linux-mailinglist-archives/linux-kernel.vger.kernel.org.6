Return-Path: <linux-kernel+bounces-290618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E7955658
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CCB282C25
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FEE1422C7;
	Sat, 17 Aug 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YKWmoRiA"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BAC78C7D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882351; cv=none; b=ejxm2HghYVHIqZ4QK7EbopqLnNK8Ixov06Lya0Xu03itHSmgm29mNrP316KF/IDgDRZfQRn08Yq28zLXp+fcrozRtZDoIIByUAGN/unEFWTKlq55JliJjMEKrB3N/E/ohHe7bc26Ikhy6xQWgBNtFMmjjI4FOhe6PcoQyEaYjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882351; c=relaxed/simple;
	bh=dOWzhrVUea5QTLRZw69LR2Xjy/RzuTb92FtJOgBx1F4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O24LVZRt8+nr2Xt2SDyzUxqVJDY03FNlG88NVNIhCRwOKMSlxeE3afwFc330yZsK8jjeZoBlHERHaxi/JJSxx8rBX8+XOg6xmzDsy4Oa0gIlw5MK3uRJk+KzOJMvYKaKDppvNfgoYyncPg3QXFzTP64T739GJ6rVkLu+2IlJSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YKWmoRiA; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3dd25b2c3f2so1223199b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723882349; x=1724487149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj31dGP9/A+r5fCM9gPpkQfw10kOj0vPgr24AbFp3ic=;
        b=YKWmoRiAE0hWwbPb1TvSySw0glvWvIojjV7jO9JNDDGqfk5GIDjHu+f5zv0jsiHlSt
         I9YpKmLiOL3VNrnSfgUgkUVCVglXqumwDKMAy4g+c/d9Oci3b5ORVxf7QMD1/zuuQN3f
         zT/M5Gl1QGj2y8+s7Qz5dGgcut+LsD7+HlD8Pi6AI1ZaXBb2DPIN4o0MGV/PPIf3OWmn
         jTQWKn1jTh+MHmRfyyqReRx6gtaVPNOdX01gif8qDb4ajEc/TEx4XXZmKBBMNoOVkyi7
         pLkVY4ir/khnCmrWK+IixDFK/ofTPaz/5rIDVWyU96W6YJUVDPAYvG6cZSWSg6/f8RG1
         zB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723882349; x=1724487149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kj31dGP9/A+r5fCM9gPpkQfw10kOj0vPgr24AbFp3ic=;
        b=gSlQFESl9k0U8985lCIKj3Uv8M0295m/tAWTh+PHCTfVplTtZmG6PpDQ4XTJ+C6jIm
         h1RBaHywbchEsS+TPzVD8g85e8meKsFiK2hEdzV9AJ/cz7PcN577BLP66RYuyYHSaApw
         w9LF/jq/zSWveoslTfV6SIt/Vpj6F9X+SKMCucGuoxS58R998qJEP3X7VDHDvA0P6c+L
         fB35TOd//BbrND7LbG0A9FSXbO5rVy2ec5VdmRFiTGoJ86l37XwQnTLDpxcBHvSZkYkG
         DXupQ0xHLPBbDROrxAbJGazp+lj0/kcaTUIwtA9ISL0xGW+gUovfkEfu7vx29qxIj6qc
         5zFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUstMhQC8H5utjoeyTSjeRMkBQjQm9u6pvzVIvpM9969fQfy/qatMhQi5dNJl+jEeFSf5vR13HSMWaIlzT55OQBjoSSWT4qTebFk+nE
X-Gm-Message-State: AOJu0Yy7VqpXumGrtXtC0nFPfvTXsunKRaFW6L05mnww1hscLtPouiJy
	MimIuT3xNBeESnKMUy3EQj1/u45lqu6T2qMxrF+H3ZhTGfwa2RKc+9gF3VT9pyo=
X-Google-Smtp-Source: AGHT+IHqssMhtOLbi2vMTqbyauaqJlC2DfcHowAX1NoLKwBhGtV+l4Ms/4yCz9VdjP1LsJvAJ5M+fA==
X-Received: by 2002:a05:6808:1918:b0:3dd:86d:faf5 with SMTP id 5614622812f47-3dd3ad4298emr6864922b6e.15.1723882348671;
        Sat, 17 Aug 2024 01:12:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1d68dsm3777088b3a.178.2024.08.17.01.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 01:12:28 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2] irqchip/sifive-plic: Probe plic driver early for Allwinner D1 platform
Date: Sat, 17 Aug 2024 13:42:18 +0530
Message-Id: <20240817081218.2985171-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latest Linux RISC-V no longer boots on the Allwinner D1 platform
because the sun4i_timer driver fails to get an interrupt from PLIC.

The real fix requires enabling the SBI time extension in the platform
firmware (OpenSBI) and convert sun4i_timer into platform driver.
Unfortunately, the real fix involves changing multiple places and
can't be achieved in a short duration.

As a work-around, retrofit plic probing such that plic is probed
early only for the Allwinner D1 platform and probed as a regular
platform driver for rest of the RISC-V platforms. In the process,
partially revert some of the previous patches because PLIC device
pointer is not available in all probing paths.

More detailed discussion can found here:
https://lore.kernel.org/lkml/20240814145642.344485-1-emil.renner.berthing@canonical.com/

Fixes: e306a894bd51 ("irqchip/sifive-plic: Chain to parent IRQ after handlers are ready")
Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
Changes since v1:
 - Set suppress_bind_attrs for PLIC platform driver
---
 drivers/irqchip/irq-sifive-plic.c | 128 +++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 48 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..33395c5a9b5b 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#define pr_fmt(fmt) "riscv-plic: " fmt
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -63,7 +64,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
 
 struct plic_priv {
-	struct device *dev;
+	struct fwnode_handle *fwnode;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -378,8 +379,8 @@ static void plic_handle_irq(struct irq_desc *desc)
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
 		if (unlikely(err)) {
-			dev_warn_ratelimited(handler->priv->dev,
-					     "can't find mapping for hwirq %lu\n", hwirq);
+			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
+					    handler->priv->fwnode, hwirq);
 		}
 	}
 
@@ -408,15 +409,14 @@ static int plic_starting_cpu(unsigned int cpu)
 		enable_percpu_irq(plic_parent_irq,
 				  irq_get_trigger_type(plic_parent_irq));
 	else
-		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
+		pr_warn("%pfwP: cpu%d: parent irq not available\n",
+			handler->priv->fwnode, cpu);
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
 
 	return 0;
 }
 
-static const struct of_device_id plic_match[] = {
-	{ .compatible = "sifive,plic-1.0.0" },
-	{ .compatible = "riscv,plic0" },
+static const struct of_device_id plic_quirks_match[] = {
 	{ .compatible = "andestech,nceplic100",
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
 	{ .compatible = "thead,c900-plic",
@@ -424,38 +424,36 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
-static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
+static int plic_parse_nr_irqs_and_contexts(struct fwnode_handle *fwnode,
 					   u32 *nr_irqs, u32 *nr_contexts)
 {
-	struct device *dev = &pdev->dev;
 	int rc;
 
 	/*
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!is_of_node(fwnode))
 		return -EINVAL;
 
-	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,ndev", nr_irqs);
 	if (rc) {
-		dev_err(dev, "riscv,ndev property not available\n");
+		pr_err("%pfwP: riscv,ndev property not available\n", fwnode);
 		return rc;
 	}
 
-	*nr_contexts = of_irq_count(to_of_node(dev->fwnode));
+	*nr_contexts = of_irq_count(to_of_node(fwnode));
 	if (WARN_ON(!(*nr_contexts))) {
-		dev_err(dev, "no PLIC context available\n");
+		pr_err("%pfwP: no PLIC context available\n", fwnode);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
+static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 context,
 				     u32 *parent_hwirq, int *parent_cpu)
 {
-	struct device *dev = &pdev->dev;
 	struct of_phandle_args parent;
 	unsigned long hartid;
 	int rc;
@@ -464,10 +462,10 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!is_of_node(fwnode))
 		return -EINVAL;
 
-	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
+	rc = of_irq_parse_one(to_of_node(fwnode), context, &parent);
 	if (rc)
 		return rc;
 
@@ -480,48 +478,55 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
 	return 0;
 }
 
-static int plic_probe(struct platform_device *pdev)
+static int plic_probe(struct fwnode_handle *fwnode)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
-	struct device *dev = &pdev->dev;
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
+	void __iomem *regs;
 
-	if (is_of_node(dev->fwnode)) {
+	if (is_of_node(fwnode)) {
 		const struct of_device_id *id;
 
-		id = of_match_node(plic_match, to_of_node(dev->fwnode));
+		id = of_match_node(plic_quirks_match, to_of_node(fwnode));
 		if (id)
 			plic_quirks = (unsigned long)id->data;
+
+		regs = of_iomap(to_of_node(fwnode), 0);
+		if (!regs)
+			return -ENOMEM;
+	} else {
+		return -ENODEV;
 	}
 
-	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	error = plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_contexts);
 	if (error)
-		return error;
+		goto fail_free_regs;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		error = -ENOMEM;
+		goto fail_free_regs;
+	}
 
-	priv->dev = dev;
+	priv->fwnode = fwnode;
 	priv->plic_quirks = plic_quirks;
 	priv->nr_irqs = nr_irqs;
+	priv->regs = regs;
 
-	priv->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(!priv->regs))
-		return -EIO;
-
-	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
-	if (!priv->prio_save)
-		return -ENOMEM;
+	priv->prio_save = bitmap_zalloc(nr_irqs, GFP_KERNEL);
+	if (!priv->prio_save) {
+		error = -ENOMEM;
+		goto fail_free_priv;
+	}
 
 	for (i = 0; i < nr_contexts; i++) {
-		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		error = plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu);
 		if (error) {
-			dev_warn(dev, "hwirq for context%d not found\n", i);
+			pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
 			continue;
 		}
 
@@ -543,7 +548,7 @@ static int plic_probe(struct platform_device *pdev)
 		}
 
 		if (cpu < 0) {
-			dev_warn(dev, "Invalid cpuid for context %d\n", i);
+			pr_warn("%pfwP: Invalid cpuid for context %d\n", fwnode, i);
 			continue;
 		}
 
@@ -554,7 +559,7 @@ static int plic_probe(struct platform_device *pdev)
 		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			dev_warn(dev, "handler already present for context %d.\n", i);
+			pr_warn("%pfwP: handler already present for context %d.\n", fwnode, i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -568,8 +573,8 @@ static int plic_probe(struct platform_device *pdev)
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
-		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
-						    sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
+					       sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
 			goto fail_cleanup_contexts;
 done:
@@ -581,7 +586,7 @@ static int plic_probe(struct platform_device *pdev)
 		nr_handlers++;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
+	priv->irqdomain = irq_domain_add_linear(to_of_node(fwnode), nr_irqs + 1,
 						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto fail_cleanup_contexts;
@@ -619,13 +624,13 @@ static int plic_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
-		 nr_irqs, nr_handlers, nr_contexts);
+	pr_info("%pfwP: mapped %d interrupts with %d handlers for %d contexts.\n",
+		fwnode, nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 fail_cleanup_contexts:
 	for (i = 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+		if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu))
 			continue;
 		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
 			continue;
@@ -634,17 +639,44 @@ static int plic_probe(struct platform_device *pdev)
 		handler->present = false;
 		handler->hart_base = NULL;
 		handler->enable_base = NULL;
+		kfree(handler->enable_save);
 		handler->enable_save = NULL;
 		handler->priv = NULL;
 	}
-	return -ENOMEM;
+	bitmap_free(priv->prio_save);
+fail_free_priv:
+	kfree(priv);
+fail_free_regs:
+	iounmap(regs);
+	return error;
+}
+
+static int plic_platform_probe(struct platform_device *pdev)
+{
+	return plic_probe(pdev->dev.fwnode);
 }
 
+static const struct of_device_id plic_platform_match[] = {
+	{ .compatible = "sifive,plic-1.0.0" },
+	{ .compatible = "riscv,plic0" },
+	{ .compatible = "andestech,nceplic100" },
+	{}
+};
+
 static struct platform_driver plic_driver = {
 	.driver = {
 		.name		= "riscv-plic",
-		.of_match_table	= plic_match,
+		.of_match_table	= plic_platform_match,
+		.suppress_bind_attrs = true,
 	},
-	.probe = plic_probe,
+	.probe = plic_platform_probe,
 };
 builtin_platform_driver(plic_driver);
+
+static int __init plic_early_probe(struct device_node *node,
+				   struct device_node *parent)
+{
+	return plic_probe(&node->fwnode);
+}
+
+IRQCHIP_DECLARE(riscv, "thead,c900-plic", plic_early_probe);
-- 
2.34.1



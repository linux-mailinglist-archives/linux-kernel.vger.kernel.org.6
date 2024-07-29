Return-Path: <linux-kernel+bounces-265959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779393F829
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BBC1F2118B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7F192B8A;
	Mon, 29 Jul 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZPjXjJ3d"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18E192B7C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263073; cv=none; b=mWeNmN8TAAVfDf0jWfMpvQj6hH06ocEX5B3PiiJmrinqClMBnFU0ZXbG56DwciLqfqNpWCMtQ45XkrugwNAYQ5dTJcFXUUr4f4VG05kbD7NnNeqND06/U1krunm2yM5rVslM+zhieCyg/AY+kSVrpEuHRXlm39iCYPQ/4G94O94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263073; c=relaxed/simple;
	bh=2/ZdmE107x8GmnyshQvBoz8Rb8LNzY3O19gTIqskLDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1unE8/Buf6Jrq9WL6MvffoQ2JD9sga4hb94y3gyTRKRjiYo4J0WxVFUtsSsdxmMTmK5jL2UZcaj44bNgUUjT/tcFc59C0pyA4Oznq+nWABnEUtIXX6aE21edyx5eXbqEapbPkMOyEJ2d1iVZkvLw4fW1KQj5gp8Bf0hh5GOzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZPjXjJ3d; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so18394835ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263071; x=1722867871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0GXqbjRdlQgXLR20WsWn0Zb01kTXlGc4SKzlInZ9zY=;
        b=ZPjXjJ3dQSmyk5tdrCYcYbzr/i1bLUNRaCeHOKUHqZH1Fbbg+OZ/KvtGJLXW1K767N
         xy5mqACyWLJzOVDGojlVfERYfNnNt9phyUWkX7ELG3qGJ/2VMlU3A15FsF/xwt6hbpzY
         GiPPKBM0XPCpOjzJ9x55fIeEGSbcz0LjQNwDLZFm1SUsGdWveWHRgqE2SRDC51GmFcsJ
         L6nGvV05qIf8mCgHXMaJgGOQFQ4gVrmalPQH/odPi83WNBj9E4Nfkbs2e6DCNYEpS/0E
         qMet0n9tGm7kVJbkd5NWoFrQP1EBVGGSnlL35hjdaDJOuGlZ0Uf0mkM5vcUwNkFQwRzl
         0pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263071; x=1722867871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0GXqbjRdlQgXLR20WsWn0Zb01kTXlGc4SKzlInZ9zY=;
        b=HJNm0JVTQSodpvVvNQxXuFknGt2iU0e7N1KSI1sSILyd+8pMlUIR3VaDYefrThULcr
         7XhwKIdDmji2Ajj0vxZwMoaUMAhowytPOcpzfPys0s9eMKL5n05SHnmmugVcfcG5IBE8
         0qplWTe5MWGa0a/6kNgkTcBwDCM+OCz4Pl3Ioj1MZuJY81U8+OAqjD58JgZ1cDgUogid
         VmaYOUglDevSrVsVjSB4/AVwG1GSKo7BsDhY5h74RtqdV+BNOREPa1Ot7QHS+W0Uw6+Y
         VUEXFgQ58SvpO6NBbfwJWYUA+mQQZxestMSbfEHG4H1mq47NlNP/PLTGr9GAMXM0LS72
         y3wA==
X-Gm-Message-State: AOJu0YwVQfTZEuacO8DUJ1+IgnOIDSUCcJAynmLLWxamj6wDtPhT43BO
	2ShdCtRbJoTsxCotvQR8+BJgOpUgBgKMrvnuj7z8KcTwtXXg3GRJVQKiYU4UPdY7tkyxdombUrb
	lNdK8sQ==
X-Google-Smtp-Source: AGHT+IHN8Sao+YlrrwzuKpm8WQR4yfMRcvn309oxoZCX8m59egD+A5Fg/n7LZZJO/PhhxP1zIyPB4g==
X-Received: by 2002:a17:902:fb08:b0:1fd:a72a:f44 with SMTP id d9443c01a7336-1ff0482b8acmr45391535ad.17.1722263071002;
        Mon, 29 Jul 2024 07:24:31 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:24:30 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 17/17] irqchip/sifive-plic: Add ACPI support
Date: Mon, 29 Jul 2024 19:52:39 +0530
Message-ID: <20240729142241.733357-18-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-1-sunilvl@ventanamicro.com>
References: <20240729142241.733357-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI support in PLIC driver. Use the mapping created early during
boot to get details about the PLIC.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..12d60728329c 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -70,6 +71,8 @@ struct plic_priv {
 	unsigned long plic_quirks;
 	unsigned int nr_irqs;
 	unsigned long *prio_save;
+	u32 gsi_base;
+	int id;
 };
 
 struct plic_handler {
@@ -324,6 +327,10 @@ static int plic_irq_domain_translate(struct irq_domain *d,
 {
 	struct plic_priv *priv = d->host_data;
 
+	/* For DT, gsi_base is always zero. */
+	if (fwspec->param[0] >= priv->gsi_base)
+		fwspec->param[0] = fwspec->param[0] - priv->gsi_base;
+
 	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
 
@@ -424,18 +431,37 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+
+static const struct acpi_device_id plic_acpi_match[] = {
+	{ "RSCV0001", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, plic_acpi_match);
+
+#endif
 static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
-					   u32 *nr_irqs, u32 *nr_contexts)
+					   u32 *nr_irqs, u32 *nr_contexts,
+					   u32 *gsi_base, u32 *id)
 {
 	struct device *dev = &pdev->dev;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		rc = riscv_acpi_get_gsi_info(dev->fwnode, gsi_base, id, nr_irqs, NULL);
+		if (rc) {
+			dev_err(dev, "failed to find GSI mapping\n");
+			return rc;
+		}
+
+		*nr_contexts = acpi_get_plic_nr_contexts(*id);
+		if (WARN_ON(!*nr_contexts)) {
+			dev_err(dev, "no PLIC context available\n");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
 
 	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
 	if (rc) {
@@ -449,23 +475,29 @@ static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	*gsi_base = 0;
+	*id = 0;
+
 	return 0;
 }
 
 static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
-				     u32 *parent_hwirq, int *parent_cpu)
+				     u32 *parent_hwirq, int *parent_cpu, u32 id)
 {
 	struct device *dev = &pdev->dev;
 	struct of_phandle_args parent;
 	unsigned long hartid;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		hartid = acpi_get_ext_intc_parent_hartid(id, context);
+		if (hartid == INVALID_HARTID)
+			return -EINVAL;
+
+		*parent_cpu = riscv_hartid_to_cpuid(hartid);
+		*parent_hwirq = RV_IRQ_EXT;
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
 	if (rc)
@@ -489,6 +521,8 @@ static int plic_probe(struct platform_device *pdev)
 	u32 nr_irqs, parent_hwirq;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
+	int id, context_id;
+	u32 gsi_base;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -498,7 +532,7 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
-	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts, &gsi_base, &id);
 	if (error)
 		return error;
 
@@ -509,6 +543,8 @@ static int plic_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 	priv->nr_irqs = nr_irqs;
+	priv->gsi_base = gsi_base;
+	priv->id = id;
 
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(!priv->regs))
@@ -519,12 +555,22 @@ static int plic_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_contexts; i++) {
-		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu, priv->id);
 		if (error) {
 			dev_warn(dev, "hwirq for context%d not found\n", i);
 			continue;
 		}
 
+		if (is_of_node(dev->fwnode)) {
+			context_id = i;
+		} else {
+			context_id = acpi_get_plic_context(priv->id, i);
+			if (context_id == INVALID_CONTEXT) {
+				dev_warn(dev, "invalid context id for context%d\n", i);
+				continue;
+			}
+		}
+
 		/*
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
@@ -562,10 +608,10 @@ static int plic_probe(struct platform_device *pdev)
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
 		handler->hart_base = priv->regs + CONTEXT_BASE +
-			i * CONTEXT_SIZE;
+			context_id * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
-			i * CONTEXT_ENABLE_SIZE;
+			context_id * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
 		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
@@ -581,8 +627,8 @@ static int plic_probe(struct platform_device *pdev)
 		nr_handlers++;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
-						&plic_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_create_linear(dev->fwnode, nr_irqs + 1,
+						   &plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto fail_cleanup_contexts;
 
@@ -619,13 +665,18 @@ static int plic_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
+#endif
+
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 fail_cleanup_contexts:
 	for (i = 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu, priv->id))
 			continue;
 		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
 			continue;
@@ -644,6 +695,7 @@ static struct platform_driver plic_driver = {
 	.driver = {
 		.name		= "riscv-plic",
 		.of_match_table	= plic_match,
+		.acpi_match_table = ACPI_PTR(plic_acpi_match),
 	},
 	.probe = plic_probe,
 };
-- 
2.43.0



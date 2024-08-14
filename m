Return-Path: <linux-kernel+bounces-286697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6AF951DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3281F226C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17251BA883;
	Wed, 14 Aug 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qWKTCIXz"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347E1B9B3B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647424; cv=none; b=MEPBjKBTxuLexWp3iIuxjt+ZwAnhL4ic4rlAeOw51jZa11hgPdOMEiJf7V+Eu5WzD9sF3L9Te+JF3uwT7P98Tnh7i21PbUPsVFr0CRRgt31YdaBWmZZZKXCTo6TbxYSPsvLwrdSyts28MbPdHz+XfSQj1PKOS6wXGNYv1v0KsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647424; c=relaxed/simple;
	bh=CUrDPT8yIm9H7mP4RQEH7d9BPFr2CIu6wTUn6f/D5M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvPNgD/3A4U4VVHn4DCsyqSVypweSDPYP1qnXWW7PPWZsR0cbI6DS7BsFQhFdZSOJ4Yp9/941KgClHrOjUJyhq86xJXPPepY028WeHAMQPCcREYOEb4h0NB6qK2WlhjyDCUVIB1lfuYlKWSNXmPqV6quGFyn4E48HE0jrSMUupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qWKTCIXz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A76344597F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647417;
	bh=yjCwWNcb2RwBz1G+TBCUPH+94PCiJ1raP+HTH6kWRGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=qWKTCIXzF5FbcTl5TErntFpJRRt0vupjKJKQPx5CtjG6ItCDKQ2WueyyleigL+IWv
	 MF6pWbd2+zNfjKlDZ3iHqe/ZCQLLZm9WN6BfcJ++JvyQlVICjuKdbP5FYFIYrTEMfz
	 Houn23KiigVW27DEMEKpQo0VVsHjoKKa5LjUSZ99oAwZv+Ulc+ykfGaD1rFzPVCh3U
	 MaL5NzZ7PJLJMIO2Lyq5+JirYCzOURCZDL1nSPEDnwaz6qf8JTBSvQlWmbo9+aJco9
	 M3tzYCEIXE1ttHeHlMeO2n/Yy5lWywZZd1LyjfHBSR8bBpv30vVUhN0k8EwpqMJglQ
	 l8LlIBACmKIgQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7ab81eea72so539774466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647413; x=1724252213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjCwWNcb2RwBz1G+TBCUPH+94PCiJ1raP+HTH6kWRGU=;
        b=j4BppPOVQfVoS3TZX/1ShLetvCRrDeAgyG9e53hZEQvmCh8AsqE6RkmT4nqWk0kxkG
         NCRyuOSzOVOgX+fUlzdSOG8tDBBuek/fSd8KYn3splAlpQtnfy/9tVcamSOs7u9e1vnd
         susFTe7frdHUD0A/G+CD6YSst75EYWtFRQf080Eiuh22pksVXoRaCjzWPnWsdej8v4wk
         jhi0xYkfu+dmF4ebkN6C4R6aToa3kZCWqbqOhPWwRF0qHxfAr2UHVrY7Ah/CUQZifgpN
         W9UPiU66EidjCXlPQZm0Kde6Z/65x/az/gp6c3G+2d9lof2PRPrIaHlrXIUJ45E2kCfY
         NBCA==
X-Gm-Message-State: AOJu0YzL8MA3BOc5SKD/+Ws441x9qeDrUZ+qRLR1/eQi0veBFLpzQ3Pi
	9hfg8PGP9QVVlqJFmt14yp9jPQlDPog7J680XYEhj2DV/0ld2oDronUorjdVzdzq9Q70KP/+/yj
	66BNdSiziVB4KizNfmW5obOID9vfSf5tXCH/UyFN22cvuxW8np4hbGq2MGre3c9KFpwZDBChp0Z
	OfAbmg6bZqFQ==
X-Received: by 2002:a17:906:d24f:b0:a7a:ae85:f24d with SMTP id a640c23a62f3a-a83670156afmr183670166b.51.1723647412768;
        Wed, 14 Aug 2024 07:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHaDsSWoa2KsGlc6OyPJgRDW+q0rWS6QSZ3gIEWLEGWbf/cNuU3Zj/MyvRCW2i/aNyUts1xw==
X-Received: by 2002:a17:906:d24f:b0:a7a:ae85:f24d with SMTP id a640c23a62f3a-a83670156afmr183667066b.51.1723647412019;
        Wed, 14 Aug 2024 07:56:52 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:51 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 9/9] Revert "irqchip/sifive-plic: Convert PLIC driver into a platform driver"
Date: Wed, 14 Aug 2024 16:56:41 +0200
Message-ID: <20240814145642.344485-10-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 8ec99b033147ef3bb8f0a560c24eb1baec3bc0be.

This change makes the Allwinner D1 SoC lock up at boot as described in
the thread below.

Link: https://lore.kernel.org/linux-riscv/CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com/
Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 103 ++++++++++++------------------
 1 file changed, 41 insertions(+), 62 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index ac274e1166c3..bf0b40b0fad4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -64,7 +64,6 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
 
 struct plic_priv {
-	struct device *dev;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -413,50 +412,30 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static const struct of_device_id plic_match[] = {
-	{ .compatible = "sifive,plic-1.0.0" },
-	{ .compatible = "riscv,plic0" },
-	{ .compatible = "andestech,nceplic100",
-	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
-	{ .compatible = "thead,c900-plic",
-	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
-	{}
-};
-
-static int plic_probe(struct platform_device *pdev)
+static int __init __plic_init(struct device_node *node,
+			      struct device_node *parent,
+			      unsigned long plic_quirks)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
-	struct device *dev = &pdev->dev;
-	unsigned long plic_quirks = 0;
-	struct plic_handler *handler;
-	struct plic_priv *priv;
-	bool cpuhp_setup;
-	unsigned int cpu;
 	u32 nr_irqs;
-
-	if (is_of_node(dev->fwnode)) {
-		const struct of_device_id *id;
-
-		id = of_match_node(plic_match, to_of_node(dev->fwnode));
-		if (id)
-			plic_quirks = (unsigned long)id->data;
-	}
+	struct plic_priv *priv;
+	struct plic_handler *handler;
+	unsigned int cpu;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = of_iomap(to_of_node(dev->fwnode), 0);
+	priv->regs = of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
 		goto out_free_priv;
 	}
 
 	error = -EINVAL;
-	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
+	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
@@ -466,13 +445,13 @@ static int plic_probe(struct platform_device *pdev)
 	if (!priv->prio_save)
 		goto out_free_priority_reg;
 
-	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
+	nr_contexts = of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
 		goto out_free_priority_reg;
 
 	error = -ENOMEM;
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
-						&plic_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
+			&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto out_free_priority_reg;
 
@@ -482,7 +461,7 @@ static int plic_probe(struct platform_device *pdev)
 		int cpu;
 		unsigned long hartid;
 
-		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
+		if (of_irq_parse_one(node, i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
 			continue;
 		}
@@ -518,7 +497,7 @@ static int plic_probe(struct platform_device *pdev)
 
 		/* Find parent domain and register chained handler */
 		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq = irq_of_parse_and_map(to_of_node(dev->fwnode), i);
+			plic_parent_irq = irq_of_parse_and_map(node, i);
 			if (plic_parent_irq)
 				irq_set_chained_handler(plic_parent_irq,
 							plic_handle_irq);
@@ -560,29 +539,20 @@ static int plic_probe(struct platform_device *pdev)
 
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
-	 * and register syscore operations only once after context
-	 * handlers of all online CPUs are initialized.
+	 * and register syscore operations only when context handler
+	 * for current/boot CPU is present.
 	 */
-	if (!plic_cpuhp_setup_done) {
-		cpuhp_setup = true;
-		for_each_online_cpu(cpu) {
-			handler = per_cpu_ptr(&plic_handlers, cpu);
-			if (!handler->present) {
-				cpuhp_setup = false;
-				break;
-			}
-		}
-		if (cpuhp_setup) {
-			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
-					  "irqchip/sifive/plic:starting",
-					  plic_starting_cpu, plic_dying_cpu);
-			register_syscore_ops(&plic_irq_syscore_ops);
-			plic_cpuhp_setup_done = true;
-		}
+	handler = this_cpu_ptr(&plic_handlers);
+	if (handler->present && !plic_cpuhp_setup_done) {
+		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+				  "irqchip/sifive/plic:starting",
+				  plic_starting_cpu, plic_dying_cpu);
+		register_syscore_ops(&plic_irq_syscore_ops);
+		plic_cpuhp_setup_done = true;
 	}
 
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for %d contexts.\n",
-		to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_contexts);
+	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
+		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 out_free_enable_reg:
@@ -599,11 +569,20 @@ static int plic_probe(struct platform_device *pdev)
 	return error;
 }
 
-static struct platform_driver plic_driver = {
-	.driver = {
-		.name		= "riscv-plic",
-		.of_match_table	= plic_match,
-	},
-	.probe = plic_probe,
-};
-builtin_platform_driver(plic_driver);
+static int __init plic_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	return __plic_init(node, parent, 0);
+}
+
+IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
+IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+
+static int __init plic_edge_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
+}
+
+IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
-- 
2.43.0



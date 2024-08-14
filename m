Return-Path: <linux-kernel+bounces-286696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D06951DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038B2284F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A741BA882;
	Wed, 14 Aug 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DvMPA22Q"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AD1B9B42
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647424; cv=none; b=syIERgJIZWETTFvjkO1hBKQHFNNO3lBXHCoAqqjEmqFA9+zNfSR9oIJzV6u+Tbj60ILsK+phrLADEf5dULGvW4V7GDH+qSco8sQr1ZHcMRI1qTQ8P0M3k4GGQaT4vb35CQlDOAvqOn9PIA5gDYfJs+CoPWZ5+UV73dsxxaO1M1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647424; c=relaxed/simple;
	bh=jFb0kJivHus7me4yzLXhQc7uYeHwpNVBPGAKFo8Nlvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBswMN41X3x5fhxsgRfW3rsV6SotTX1YDoUaCI6rfxb2LE3DlygrunrdHZz44ve9NHedwXzpSVUN130X1d8u4NZJ58GHsgbZF6yAquPM4zpcq7NbcBU+3C0RIVLRnfQ6yd7CtA2TgpEKgerDNDn4COtQTrr1OAykOYruGk4nu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DvMPA22Q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0A53E45975
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647414;
	bh=IUM6jkgHqliS7TLynxdyuCPNYS9WvP3ZzPTH9v/4Y8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=DvMPA22Q7vDjQEEUVAKV2L1Qx+x6710NtIktpHoa5vyiwK83B1wO7vANqqCesUEls
	 5KPuAcYACZcB3Mt1axrMLDReTDlcJAHwiWaTk5Mrp9IbViQxWjN7ceeO7AdgpsjWsn
	 nX90hQHdJBoOYHVXNaC74XTrViyCamKDeKUWp7Sf+Nx4chaoJEQyDJaiSJC/ZMfxy+
	 yyKoh3dQiq4abFHiX9imv+Fi1BdQPdqLJ/52g1LM8ybL7I46zsuH6z6ynMDnaK/469
	 Mw+aTyhVeeo/gfYhThjv8tgJYuenU01WOa4oBsOahjt4NGFBp2TynRIgBMTPncF1EG
	 kxIk17K2KG2cA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a80c12dede1so136494066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647409; x=1724252209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUM6jkgHqliS7TLynxdyuCPNYS9WvP3ZzPTH9v/4Y8U=;
        b=xOAYO6UUVO28Y2DJ/aPIwJI/lhQ1kkKICZfBt+jsQKpdnDKkJgaXNvq9XtgEskV/a1
         rRQgPcxos5KlNTbuIKvjYZXI54rPmljIMuW/8VIg9HNKbDux/Z4usprgXa7PcWlEs3ut
         nPHmyyUhW7I49Ci8xg7QIIRBGoxZX5/qnS3SA2H9ys255H2SD/YLRIk6uNy66y65a2zh
         8YSzKdD+NKDRbgv6dGk0CDMCSwFgqrWO6eHguLwBgV+LRabt6E/DPtEFbnrx6EjAB0nm
         TUB5HnrW71Ql4cA2PoVreLPNLR8JNAtP9f54M593O9y6B9Fb4JfiYZuQKHGab9RQiPXY
         miiA==
X-Gm-Message-State: AOJu0YxXhvuVIyw3E3QXLkORbUIGAxK/YI2yvc+TViSP2LDr+pZ+xTJi
	dF0rZsEtSt0JFd8WA3S6RENKc9DaXLB+PmQSlW57lid0/EEgxBVmsZ25VawcS3CNratLzCEUlwD
	+D1PSQjbvvnUZgojfuJ9IWGId2ETMgiAVhdGrONUSAwMGp5su4tBAj/9++0YRRUOuRJpkkpAx2Y
	i9Uj0VViiaMQ==
X-Received: by 2002:a17:907:3201:b0:a7a:bcbc:f7f4 with SMTP id a640c23a62f3a-a836abb358emr234363366b.14.1723647409180;
        Wed, 14 Aug 2024 07:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEys6MrI5aQcVwmiLrXuNC8jHi0+dek+tdNfiAtj1CA05xQUkevZWjodULXyUBCHbZ9S/jcUg==
X-Received: by 2002:a17:907:3201:b0:a7a:bcbc:f7f4 with SMTP id a640c23a62f3a-a836abb358emr234359466b.14.1723647408318;
        Wed, 14 Aug 2024 07:56:48 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:47 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 5/9] Revert "irqchip/sifive-plic: Cleanup PLIC contexts upon irqdomain creation failure"
Date: Wed, 14 Aug 2024 16:56:37 +0200
Message-ID: <20240814145642.344485-6-emil.renner.berthing@canonical.com>
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

This reverts commit a15587277a246c388c83b1cd9cf7c1a868cd752f.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 73 +++++++++----------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index b4c4050a02fb..85e94b8f4c06 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -423,45 +423,17 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
-static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
-				     u32 *parent_hwirq, int *parent_cpu)
-{
-	struct device *dev = &pdev->dev;
-	struct of_phandle_args parent;
-	unsigned long hartid;
-	int rc;
-
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
-
-	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
-	if (rc)
-		return rc;
-
-	rc = riscv_of_parent_hartid(parent.np, &hartid);
-	if (rc)
-		return rc;
-
-	*parent_hwirq = parent.args[0];
-	*parent_cpu = riscv_hartid_to_cpuid(hartid);
-	return 0;
-}
-
 static int plic_probe(struct platform_device *pdev)
 {
-	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
+	int error = 0, nr_contexts, nr_handlers = 0, i;
 	struct device *dev = &pdev->dev;
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
-	u32 nr_irqs, parent_hwirq;
 	struct irq_domain *domain;
 	struct plic_priv *priv;
-	irq_hw_number_t hwirq;
 	bool cpuhp_setup;
+	unsigned int cpu;
+	u32 nr_irqs;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -497,9 +469,13 @@ static int plic_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	for (i = 0; i < nr_contexts; i++) {
-		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
-		if (error) {
-			dev_warn(dev, "hwirq for context%d not found\n", i);
+		struct of_phandle_args parent;
+		irq_hw_number_t hwirq;
+		int cpu;
+		unsigned long hartid;
+
+		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
+			dev_err(dev, "failed to parse parent for context %d.\n", i);
 			continue;
 		}
 
@@ -507,7 +483,7 @@ static int plic_probe(struct platform_device *pdev)
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent_hwirq != RV_IRQ_EXT) {
+		if (parent.args[0] != RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
 				void __iomem *enable_base = priv->regs +
@@ -520,6 +496,13 @@ static int plic_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		error = riscv_of_parent_hartid(parent.np, &hartid);
+		if (error < 0) {
+			dev_warn(dev, "failed to parse hart ID for context %d.\n", i);
+			continue;
+		}
+
+		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
 			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
@@ -557,7 +540,7 @@ static int plic_probe(struct platform_device *pdev)
 		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
 						    sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
-			goto fail_cleanup_contexts;
+			return -ENOMEM;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -570,7 +553,7 @@ static int plic_probe(struct platform_device *pdev)
 	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
 						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
-		goto fail_cleanup_contexts;
+		return -ENOMEM;
 
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
@@ -598,22 +581,6 @@ static int plic_probe(struct platform_device *pdev)
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
-
-fail_cleanup_contexts:
-	for (i = 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
-			continue;
-		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
-			continue;
-
-		handler = per_cpu_ptr(&plic_handlers, cpu);
-		handler->present = false;
-		handler->hart_base = NULL;
-		handler->enable_base = NULL;
-		handler->enable_save = NULL;
-		handler->priv = NULL;
-	}
-	return -ENOMEM;
 }
 
 static struct platform_driver plic_driver = {
-- 
2.43.0



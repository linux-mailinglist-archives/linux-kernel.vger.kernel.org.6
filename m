Return-Path: <linux-kernel+bounces-286695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE20951DED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853042841C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ECD1B8EBC;
	Wed, 14 Aug 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ViemlQ2Y"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728161B3F2A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647422; cv=none; b=fa6a2/lU7hXcBOUSa8bZX5MNFiBV2Uqd+/g8v7NX5qD9YrE8FmG/DBn0QwU20tT/8LK12sXwu7iYCA69agDJZ5AEdt2RciBYlEVVRqy7mbSefxSyiO9nzG3Gi1g+ZpA0hGGT+EvoQU/aNBi0flw7CL9urkljVl3ctXswagM+Fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647422; c=relaxed/simple;
	bh=nwazBVGfxZ/9u54Gd0Zb4NadF9mQjkkeEZastp8UmMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbtTkiSr7UvEukcz3TSyIR+G7S0RF6MdxgFtQekIzmezqYOEgJXNe0GN9Li7KwRP2uBITPKIzIwvB1O+g33WJHxf+CWD3x+Hzt4t10AM7vPv1XURa65biUP9Li6GmY+aFjzxrMFdDzu6IJoFZ1g/9MBe8aJmP0e7Tbsx+n3c7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ViemlQ2Y; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C6BCB45974
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647413;
	bh=2pXv+ysc8ToXtQ+ey2s0xoldhLum5hMAS4b7voRBoVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ViemlQ2YOSgh1JJYmM1iJrPSBanOkgjkOFSowMvtYPNgAP8o6JJgGeFeGXHL9TVCv
	 TboaTHQbegBVZqB59pBfh7DjvUYJvtnaXGDM9EiS9m0FI6xa/PdoSO+2TbaJsGe4C8
	 Et3HxPOm7mLIAWMTu97thd2VqsuhSP1K9EjFYc5oiqWS/EzAz6eZRfbpwTF7vpL4Ub
	 CsVMsxSoiXTOmwr7s4NKl0rV2AqBeEVPzjelUGMZmw1KtWSwMSq8HWdLgdggOunlY3
	 5B1JX/l3J1mkNszYdjoATpN9cae8OTX9do3WHdS3Toto12Cs4kmtEuS0VB8FkptcIY
	 jwGGeRrPUjedQ==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef3157ae4cso74104621fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647408; x=1724252208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pXv+ysc8ToXtQ+ey2s0xoldhLum5hMAS4b7voRBoVU=;
        b=a9rBOpHWQqwT7zCxStGeGdXpb7TBKEqXsYcof8iKUaqElkoBsmWRMes1frJa/yb9Su
         ieOfrKkUzk8hyF84LfmYybiRQyCxSe+g+QvCTlt/whymSBHvLfnpYeTv4LSR1Yru8rC2
         60zzPZnJBYqo4Tgml/k0XxNEGz9+a4vcNg9daKE3Q5X4M0uMQW1Le3p1aV3xHZ6PxhvC
         v2/fpuCAbGABZZ8LveQ+0fhMFlNMcFlVy8kdGhj8pNAu+tgEOiVlo7JqzzxxtOlWioST
         +zoH5I0nZS2bYvgu6OYbq/inAGXL/YyqdDszZ2UctcgnYNX0vj7K7k7M9ypBj+P+XJL9
         jCBw==
X-Gm-Message-State: AOJu0YwUPEjEwu2OtmE729r3/ATwH1mz944a6W+KGD6+G0NKKJj29nBQ
	npdbu0LpHr9icJ6CufAbERzTaT+m8ZULUDvJoSjQwrpQS/Qd4VZx4YIIRZBeXvOk+q+0sV12Tmo
	reOrYGil/2yhTFGL46YQSHsUfVYs74cu9b4tEhHssx/MJCsw7XvM30VCXvSU5Z1IgvWsXNZoGrk
	zTcVmlyKrhPg==
X-Received: by 2002:a05:6512:3191:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-532edbc05f7mr2571837e87.57.1723647408463;
        Wed, 14 Aug 2024 07:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF17QlVvCQ6SWsWAYWiNwbZ+WPFwxcRul+yZa2TRiM0FXs/GSQZrNmNRfbmzWrcCJByT8/6lw==
X-Received: by 2002:a05:6512:3191:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-532edbc05f7mr2571804e87.57.1723647407430;
        Wed, 14 Aug 2024 07:56:47 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.46
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
Subject: [PATCH v1 4/9] Revert "irqchip/sifive-plic: Parse number of interrupts and contexts early in plic_probe()"
Date: Wed, 14 Aug 2024 16:56:36 +0200
Message-ID: <20240814145642.344485-5-emil.renner.berthing@canonical.com>
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

This reverts commit 95652106478030f54620b1f0d28f78ab110b3212.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 43 +++++++------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbccd1da3ea1..b4c4050a02fb 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -423,34 +423,6 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
-static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
-					   u32 *nr_irqs, u32 *nr_contexts)
-{
-	struct device *dev = &pdev->dev;
-	int rc;
-
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
-
-	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
-	if (rc) {
-		dev_err(dev, "riscv,ndev property not available\n");
-		return rc;
-	}
-
-	*nr_contexts = of_irq_count(to_of_node(dev->fwnode));
-	if (WARN_ON(!(*nr_contexts))) {
-		dev_err(dev, "no PLIC context available\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
 				     u32 *parent_hwirq, int *parent_cpu)
 {
@@ -499,26 +471,31 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
-	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
-	if (error)
-		return error;
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
-	priv->nr_irqs = nr_irqs;
 
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(!priv->regs))
 		return -EIO;
 
+	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
+	if (WARN_ON(!nr_irqs))
+		return -EINVAL;
+
+	priv->nr_irqs = nr_irqs;
+
 	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
 		return -ENOMEM;
 
+	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
+	if (WARN_ON(!nr_contexts))
+		return -EINVAL;
+
 	for (i = 0; i < nr_contexts; i++) {
 		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
 		if (error) {
-- 
2.43.0



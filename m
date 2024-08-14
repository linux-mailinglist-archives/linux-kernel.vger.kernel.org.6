Return-Path: <linux-kernel+bounces-286694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B5951DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A511F227EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F41B8EA4;
	Wed, 14 Aug 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="O5MdLfox"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1801B5819
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647419; cv=none; b=O2i/TZQXS5kWccAWpy2/YpTp98jdBIk6gNTMm7OR2aPNPw1neumeQJkWsMe+wxSEvqXCZNYxAA5oqyPLejjkDCCq+QtWFL0LEfzU7cvJ4ICMJr2Ee9u1dykoQaTFjiGy+t5/jZ20Wul4dW+13jGpq8L/RjVl/O7b7h/B3xewOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647419; c=relaxed/simple;
	bh=47SxGc6Ly9ooOMdwSuNAFhw8qo3iP8cBfMjLZZZ1EcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tStTBhtAaT2fAMmPhUJ6uwNFwlmd5tawOekMo/xvApEK01H1zMj9zm6FUNSKTa9AQfWKeNQmM2UjmmdALO3tCOqv8T3II3Gfv7aX888R1AR967/G9eCKV2gEwx++smvPVMCliJKy1ETIWnzySYE/OiMeyBQleeEVbrZmDUYZ0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=O5MdLfox; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14543402EC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647414;
	bh=dOSvdt4T3jlTBcb6KodFmG9e7Ly2LfYMJaL7xOSj3eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=O5MdLfoxDMsn+z7g1iIcllQdF4f+9N26HbnnoSjKIDK0Tuz6Bhj75oabq4zs6+ju3
	 rot5PEZlaKYkTbDSYEVKI9Y147e0AZVSTS+vwMzTAoYhF47rJ6treaG4BpoD5Pm0dE
	 3GH0IB0o87VwUbW8vGArNMcZkFl7YdPj63Vhv9cRPCSbZA1+uAA5JND4eFJQewXKOu
	 GeBJtJy8SznHF5wPo/nJaGzwZSOWWV0QPv45xbdsrgQU8WUgT2NEwALub8talwcNBM
	 uaRbTofApRxxUV8KyyoKoYeGRLNxbQPjZ98tySULbxN7jsRgiX5u/aS3u38YCK/UFI
	 TG/GdHGv4G+Ig==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53214baf2aaso2561762e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647411; x=1724252211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOSvdt4T3jlTBcb6KodFmG9e7Ly2LfYMJaL7xOSj3eg=;
        b=Sgaec2Lc74UMadyk61+ZSOmk9ZHQlAWAYqybQeFVlCN81LbnfiTwCCZVbWszlsbKQe
         /Tl6nFMcWAupU+gKpGcP4q5DkMU1IOwrpnZvWYL562IRmUu8a+gO9a/gpsF8kSAYwtn5
         ByEk2lp79mUkGXXDYd8kILPUZ8Q/5irLmQKDKO7VuHowmB9fyFn0kATyRwWfC2BZca9T
         L4HhASb6ionYSF5ISDn53/0+X2hszSzmPRk5+Hf84pBQwDvWfGCjFNJklG3EkDf/JNjc
         zPJCzUulRgFhwPXSnwnL42sjOIrelgVv4DXx4UO6CDz2FPa+vz1i36xVRzWAdeuvK6jL
         IxbA==
X-Gm-Message-State: AOJu0YwlCo0lQV1vuapTWDMrAe7KTWBTmB+6aBHwYB1ijSj4LtCWd4rS
	iYpuc5ij1IjtS66ALN8Hjl3TMBFk1+wGfxhwkYuZXJPqczC036Kw5UYJYGgmt3Bt5/5I+ZWpl4K
	WppnK2HyAPGZJC+h1ytHaz84fRk+WpCXYrZ46csoydSJM7lUsRsAdGogSqhzt+9zu4eMTf7JFYJ
	/SjiqYYIsoHw==
X-Received: by 2002:a05:6512:3d9f:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-532edbbf2bbmr2673958e87.51.1723647411067;
        Wed, 14 Aug 2024 07:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgFXAwyHjES6E7fkIaDAnivwak2wjYQiuQb0rFCs3xDtd1HCvI2yY+1dmem8aEkcG4O8KaeA==
X-Received: by 2002:a05:6512:3d9f:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-532edbbf2bbmr2673932e87.51.1723647410263;
        Wed, 14 Aug 2024 07:56:50 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:49 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 7/9] Revert "irqchip/sifive-plic: Use devm_xyz() for managed allocation"
Date: Wed, 14 Aug 2024 16:56:39 +0200
Message-ID: <20240814145642.344485-8-emil.renner.berthing@canonical.com>
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

This reverts commit b68d0ff529a939a118ec52f271be8cad5d99e79a.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 49 +++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7dbc662a229c..7cf06bbb3098 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -442,30 +442,39 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(!priv->regs))
-		return -EIO;
+	priv->regs = of_iomap(to_of_node(dev->fwnode), 0);
+	if (WARN_ON(!priv->regs)) {
+		error = -EIO;
+		goto out_free_priv;
+	}
 
+	error = -EINVAL;
 	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
-		return -EINVAL;
+		goto out_iounmap;
 
 	priv->nr_irqs = nr_irqs;
 
-	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
+	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-		return -ENOMEM;
+		goto out_free_priority_reg;
 
 	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
 	if (WARN_ON(!nr_contexts))
-		return -EINVAL;
+		goto out_free_priority_reg;
+
+	error = -ENOMEM;
+	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
+						&plic_irqdomain_ops, priv);
+	if (WARN_ON(!priv->irqdomain))
+		goto out_free_priority_reg;
 
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
@@ -536,10 +545,10 @@ static int plic_probe(struct platform_device *pdev)
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
-		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
-						    sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
+						sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
-			return -ENOMEM;
+			goto out_free_enable_reg;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -549,11 +558,6 @@ static int plic_probe(struct platform_device *pdev)
 		nr_handlers++;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
-						&plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
-		return -ENOMEM;
-
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
 	 * and register syscore operations only once after context
@@ -580,6 +584,19 @@ static int plic_probe(struct platform_device *pdev)
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
+
+out_free_enable_reg:
+	for_each_cpu(cpu, cpu_present_mask) {
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		kfree(handler->enable_save);
+	}
+out_free_priority_reg:
+	kfree(priv->prio_save);
+out_iounmap:
+	iounmap(priv->regs);
+out_free_priv:
+	kfree(priv);
+	return error;
 }
 
 static struct platform_driver plic_driver = {
-- 
2.43.0



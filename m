Return-Path: <linux-kernel+bounces-286693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505BA951E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26641B2EC85
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B01B86E6;
	Wed, 14 Aug 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ITceZHZg"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A61B4C3C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647418; cv=none; b=B2LKA83JyJ2sXJT6BOoAA2wimYQcpCpHW8ZjyRHUUSM+NsvkJNBbTqpNDdSELFOFQOzvq6fwZOScGbkX0++4Djl03tWkEpnX9mMVUMcSLgVp3zGUZ9JIP9S+LEeHpKWuWtznXeTscIdkOhgsRZTKQIRMC3gFanCGUdTUtOJmYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647418; c=relaxed/simple;
	bh=CdcBG0N8OQFVmHpYyGVphYXRJmDh5Id4wrf1bGYEdR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcu/+NHoAPNwZAm5DEF0qGZLCHHPNegcGJy4PSTWSaLo28V90TAoq4AcxdG0IalS0BbNZ3nwv2EH+XUCg0butftSXcXjQ+qtt6AXNWjoZe5IXO3Ty41WdzGIr41McRXbvTLocJLXX5oW/iCsyHYBVHAPVMIcfdYfA9IlcFuowAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ITceZHZg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F2FF411F1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647412;
	bh=BLF9xhELpEDy4F+zOs829324v9jnXI7dzpQV04pN/74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ITceZHZgOdFQE+N7l25vYzCIePoaBUpjSvG2Gkp+KIQqzzoMhhNSnFBYEb6GgKNc+
	 ZHWEPRpW+/blsO9OsNgwbqxyj0dfOfC6/biquB+AKc/4VWbCCUlStv45ooA8y7ldTe
	 ePl/zi+gBvUO2iiKtBvTHyp7vd5GNxF4Fd132fs0kpTyuzyn++iHEKeSVxhwGArYyR
	 4e6KZgRbPRON+v0qjBbBApIWEhtiRASJsfOzwFjKNf2wrQPbFVRduT61zqTN4KYhB+
	 P9rAM0MtbeNZfCz5I0bG6yP4vREzuovNAcVkKP0cDyfTQMmTh3amXeqI0ZNCoou8TY
	 Yw41R47wR+fNQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7abaf0aecdso443801466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647407; x=1724252207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLF9xhELpEDy4F+zOs829324v9jnXI7dzpQV04pN/74=;
        b=Y893TRag3GFIDu6vqUrge7XI4+8x24o7M6Y7NTVZq66uKcuJXPgwdaPJu135e/PO0f
         aRDG6ehx59kx3vE9xR0+0p+DoDk3+9EgUojiECUPZhwSAtFeDtZbqlaCTmYYueeUOygi
         jpa6KhbRzFy+AH2yK7Qc2BC/BloRT3UvjAeV9kOoW9HRHk/ONDRb7Dj+F1aCETEnG9Iy
         SmzqJL4z3KJLNKOFurQy/mY96BsgxBgaFbH8jgH28oubXZQtzi0WT8s1eNF7TuLxYpCp
         iEPOobF21CEYMgLipM6HmZ07lnYDIWkLZAtGf2g/j5lhxYyCkaG2+cbE8SFSNpQL6MII
         0EnA==
X-Gm-Message-State: AOJu0Yx07XgsF1TtITxTH533vDKAZJ8H87oarMxH1NV8CXCnxws8rVl4
	L1cP8k4QiX9RvD+7WPwQYoreXj7termEYTcDZ2NuGurrRNXCprMOIY/XxJNge5NGV19tldTWzLe
	wBBo9Ft8oFZuW3czYh+5m9773bgGBqfiPjxhvJlcN2yqrIjqoeNOlP42Yw6fS0jS0WK1v7i3TMj
	LeD5rI5Gi0MQ==
X-Received: by 2002:a17:907:d2cc:b0:a7a:b73f:7584 with SMTP id a640c23a62f3a-a8366d5cb0bmr234839266b.34.1723647407411;
        Wed, 14 Aug 2024 07:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCL8sD4kYOs9Y0VCnij/xL6fidS5/kQa/PnagADzJKqqhOA3GoZ+LuJZSindcfAjitSTS30g==
X-Received: by 2002:a17:907:d2cc:b0:a7a:b73f:7584 with SMTP id a640c23a62f3a-a8366d5cb0bmr234836466b.34.1723647406648;
        Wed, 14 Aug 2024 07:56:46 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:46 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 3/9] Revert "irqchip/sifive-plic: Improve locking safety by using irqsave/irqrestore"
Date: Wed, 14 Aug 2024 16:56:35 +0200
Message-ID: <20240814145642.344485-4-emil.renner.berthing@canonical.com>
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

This reverts commit abb7205794900503d6358ef1fb645373753a794d.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f3d4cb9e34f7..cbccd1da3ea1 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -103,11 +103,9 @@ static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 
 static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&handler->enable_lock, flags);
+	raw_spin_lock(&handler->enable_lock);
 	__plic_toggle(handler->enable_base, hwirq, enable);
-	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
+	raw_spin_unlock(&handler->enable_lock);
 }
 
 static inline void plic_irq_toggle(const struct cpumask *mask,
@@ -244,7 +242,6 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 static int plic_irq_suspend(void)
 {
 	unsigned int i, cpu;
-	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
 
@@ -262,12 +259,12 @@ static int plic_irq_suspend(void)
 		if (!handler->present)
 			continue;
 
-		raw_spin_lock_irqsave(&handler->enable_lock, flags);
+		raw_spin_lock(&handler->enable_lock);
 		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg = handler->enable_base + i * sizeof(u32);
 			handler->enable_save[i] = readl(reg);
 		}
-		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
+		raw_spin_unlock(&handler->enable_lock);
 	}
 
 	return 0;
@@ -276,7 +273,6 @@ static int plic_irq_suspend(void)
 static void plic_irq_resume(void)
 {
 	unsigned int i, index, cpu;
-	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
 
@@ -294,12 +290,12 @@ static void plic_irq_resume(void)
 		if (!handler->present)
 			continue;
 
-		raw_spin_lock_irqsave(&handler->enable_lock, flags);
+		raw_spin_lock(&handler->enable_lock);
 		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg = handler->enable_base + i * sizeof(u32);
 			writel(handler->enable_save[i], reg);
 		}
-		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
+		raw_spin_unlock(&handler->enable_lock);
 	}
 }
 
-- 
2.43.0



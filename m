Return-Path: <linux-kernel+bounces-446119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A839F2012
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6E3161828
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4871A0721;
	Sat, 14 Dec 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="l+FhfqXr"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3B19A2B0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197189; cv=none; b=Ax54K2t2HUQt7BZZgztO4v1IMgJihY4MfA/3NfQCEf3c6QZdRruzHm1m2we6FFbSpO3DLjksnLHbXTuYVFGnSDEEb6hTvyo1A2UFnh4+1VZFQOwlAv0DulZYjbv8qZ2geg08QwbPFpmnTXaLCXvSEwTurndTCjC3VZnwWYvvVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197189; c=relaxed/simple;
	bh=PcKCiIKJzPJB4OrlTg224bcO8uJZAUgM9GlGe6uz0Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0UDOx6YWvTx8Y4IB9UOT2EylqaeVktULyY+2lBzYa/knZfQrJPvIdOOtItcJZb26u7ZTirGpbWxkkdF6pQ1CG2QeYJ3HWucDZz3BYVflO/5wHbmYUwp908PGo3BNgRnP5O0Rqo6sVBc3Ura6vBhcc1BU+EfAq0LpArPPvwQN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=l+FhfqXr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso2122478b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197185; x=1734801985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XpbAvyCPU7XjesnTrNMuPwq8s0Ofi62LAN8USKi2As=;
        b=l+FhfqXrdSVOkd0QUMyXkVFU7REXilQ834IoPlRLR5Ehr/MMZjDAPxG5qytbVfXamv
         sacRrXnLDmwALuZv2k9El4FMewyK52fzUi26umhkmSWBHSJu1O2dvZu9rowaDqgX57Tv
         dkxTptxHQfWORWWMeF9s6VyeHLX1T5dA2jsKKiNnvhxnr5bVLPitwS+Yya1Aa5ld/iMh
         7lRbiwATQy8fIzw3eGT63sq9HK+UHiVyrU+fd6ceUm2d6+K9ivmi4ZLsITJZcdJPeUmZ
         oM2v59Q/8CZg0+CBMJH4WoN4ZqtJErbQugts952o4g9g6RGxCZai8+iH2i0ss3I8ep9e
         lObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197185; x=1734801985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XpbAvyCPU7XjesnTrNMuPwq8s0Ofi62LAN8USKi2As=;
        b=hATQf1ZG6DX64SlsAwB6H/aSriPOBouR1/1A8IT2O/ElYdHo0wFo/xUGpptFYMtxWp
         rYTgytjkx4RIiy7hcHeYaj4FtLQzG7bmN54gGeBCatSXwaS2/Y6nFm1mnm81FQPP3ZSA
         oq3JcS2cIK9aG+1DMNb6QLlHFI87oXDmkVgHGbPZfyQ50oUdDfndhOafcLchNMJBnDpe
         ynpf1arQMz86X08hGM7uh8UVyEK3602dFooeo4CatNvTefcGPtGKgCqqW8fV4j89/8Lj
         VbbycYpsvW8qWI+SzpdcsylGo/swSOSaNzMQCohiNZHdhYjvjMHM79+FOo7FJxdbLp/b
         y6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUmYS1X6X8Q8YGDIXLLVV1PTzC4FnsxpbcpfXct3j8rlGdBIE3FffTxbBD2LYT9g8u/6gZtxpYLEYmn+x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxyIYAhiBejIIVHGeEr7H4vmfyVZ9clCxX2HIFP+WBljwC86H
	4wwdCoKCL9SX+Yzj+YeJvYpDl3l0KCAq5249tOLZAgnT2wVu92592D6NlZ/CJ5Y=
X-Gm-Gg: ASbGncvdPRxJvJWJa2x5huE2wPU7lA5HYGlgQ9kovZqlxuCmrziFaxXEwhxfH3dcUyr
	nxnztXCVMhcyZ326k43116QSjCyC+G7pOWPEhuebx7ezHkmhhUlGIwCdXcezukPhxTW4nwtPimm
	6/2/IMv7ZxjaOUG8cFOFLOs8t0iwurRbqshFCDtNlM7FZWRVhEUE5+o1V+PlVMhj6vqWHpRVraX
	QksU+zxWtsdB+h2wlOD1sWBCgj8LaUoKB/7ROeHB7uZu78kJtzSedzCtkWrYz9d0aORCfC6a0AO
	zu0O585NUvdOrrc=
X-Google-Smtp-Source: AGHT+IE1SPKm+gzJ6VGXDJy+q7RKdAC9iquVy8ivXNUGMyZxEqe5AtUA6j7vJ+xaqDvjxeC/PzggwA==
X-Received: by 2002:a17:90b:3c02:b0:2ee:5958:86d with SMTP id 98e67ed59e1d1-2f28fb6764amr10436246a91.9.1734197185565;
        Sat, 14 Dec 2024 09:26:25 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:25 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 03/11] irqchip/riscv-imsic: Set irq_set_affinity for IMSIC base
Date: Sat, 14 Dec 2024 22:55:41 +0530
Message-ID: <20241214172549.8842-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214172549.8842-1-apatel@ventanamicro.com>
References: <20241214172549.8842-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Jones <ajones@ventanamicro.com>

Instead of using imsic_irq_set_affinity() for leaf MSI domains,
use imsic_irq_set_affinity() for the non-leaf IMSIC base domain
and use irq_chip_set_affinity_parent() for leaf MSI domains.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index b44eb0b3990b..dc6f63f657e4 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -96,10 +96,9 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
-	struct irq_data *pd = d->parent_data;
 	struct imsic_vector tmp_vec;
 
-	old_vec = irq_data_get_irq_chip_data(pd);
+	old_vec = irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
 		return -ENOENT;
 
@@ -139,17 +138,17 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		tmp_vec.local_id = new_vec->local_id;
 
 		/* Point device to the temporary vector */
-		imsic_msi_update_msg(d, &tmp_vec);
+		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
 	}
 
 	/* Point device to the new vector */
-	imsic_msi_update_msg(d, new_vec);
+	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
 	/* Update irq descriptors with the new vector */
-	pd->chip_data = new_vec;
+	d->chip_data = new_vec;
 
-	/* Update effective affinity of parent irq data */
-	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+	/* Update effective affinity */
+	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
 
 	/* Move state of the old vector to the new vector */
 	imsic_vector_move(old_vec, new_vec);
@@ -162,6 +161,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.name			= "IMSIC",
 	.irq_mask		= imsic_irq_mask,
 	.irq_unmask		= imsic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
@@ -272,7 +274,7 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 #ifdef CONFIG_SMP
-		info->chip->irq_set_affinity = imsic_irq_set_affinity;
+		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
 		break;
 	default:
-- 
2.43.0



Return-Path: <linux-kernel+bounces-436427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D09E85B8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798721884D80
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A01547E3;
	Sun,  8 Dec 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TRI30TKi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40D154439
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670461; cv=none; b=d+Nwb50NBEt4sbSSEQbOR7Zr2reMhOlxVAXUf+xm+VgQ97Cby7vYCCo9B80f5fyMdi11LdFPeR2bvjsI/R4n9W9kuC5anZOoNGHYlo7e453uBUnVmbK1UBOf4W89vLMXQYtbSa34+SuRqakzxGYx0Tu6ubL3tM9AaArLQzD1pZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670461; c=relaxed/simple;
	bh=ECRfKt/zywXTJNgUL5IgZczz3+w5yQEB6eFMizakLMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaKc3XWg1DXrs3eV4bN48N0NspFOwuraAQSW9ZcBwHmTjh64Pw/OJreXtq4xYUuUQWnjyxdQE5x55P01Mbm3YlRVFXehLEi0FhwZX439JMlsiMqICJTOlDGYi1Elxh8jg3iHFVp+QR1Klmxe2pxpk5TyZRZtokLH8mBan2HnbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TRI30TKi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2155157c31fso27536045ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733670459; x=1734275259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkXmty9V9UumQmJiSKG/1C8V4fnfZ0RhcvZQ4ROkR2w=;
        b=TRI30TKig+uSwoxbx9eF4HfQhIvthhI4XVIvFjOLEkU42GmZA0FnKPaIjJaEx4QS54
         vU2vr6u+90Jpge0xXTUZFpJ7ue19OMpkLd0Mdr9MNiWeGvFgMc5ZJU8gPaGMToFXQm2x
         2JKV+s+icIcG1+euf11OjP74UtjZpD92GahBcQoNYZobjGr910Liey1/fap/AEEICE+n
         rHGfxuv2e0njimY6LxheaeduM6xEAaCjIWSsLXglHJhm1UYn1Lmib9FOnXJe+0XtvTzi
         wiOgYhxU1OwN20LxvjoWMcZM7KH+Awn4dfjihbWTS7R4P0VjKmb02QMij1Zw22oInXHR
         tIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733670459; x=1734275259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkXmty9V9UumQmJiSKG/1C8V4fnfZ0RhcvZQ4ROkR2w=;
        b=eXvB/8WLvDW0acOo5MO900E8ifqvNs+rvFHSQyAGJ0cyd2AqBWIhBTNHzVBA0PoCqk
         yphveqliWDqvSm0la5bVS20PB8Tl0IUrhEVouJbi4qdoHX/af5xHhGr9Lg3uqIskvKua
         hsZJ8aW565veu094NaU7VeeKslCvLY+22bjmClGsaOm0J3CkP8o63XOmQYZPj7RtH4MP
         SvuuZjq2vyRmrEQXIF+CJOsD0Hpiy7o2/YqtscYBOQnTcWeZhi/qRX3oQ8616s+oCSi+
         1Qc0P0GdPPIx4xeARBPYNgB15YJAfSOfHzDwqWBdxo+Utib7D+EOd40MOo0Vgfhyj/f4
         W8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8uR6L20H5Hx4A5pZI0iHBhFTibQzLwX9Mt+8+STdnXvs0ut2VMa92MU4wR3I/mHGYt/v4oOE/f7EpG5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrP4G7j61UGoR73rwBVygAj1iARqrWgX4HF5lDlJ3fZ5W7mlM/
	Bh36J1FnCmQLj723dlWH+XH0dHJ2bp5+o0xK0Nbs6bgLEGvJQyGWE9HJJu0BZXk=
X-Gm-Gg: ASbGnct9ggsqUeFLaQB7fjEm+GY2CqCIBnwHmaay7jI1BptabKaPrXat+lDwrggX1a4
	nppI7iBEfIvkvrmeKaJZ904l3xHFFlcIKB9lrh3k3YpkDOtnSynthQMEoGVKRsWjPAiCnZngQNs
	UZjvfwLMIz/0MYbUOmadIVET1f+8fZ+IWmaBNXsZc/jj5Nu1wrnYapAh95jBFV6a8vYsRJn4Hbc
	V/f1t4yUBXsmOhVbRdfTfD6MTEH9s9Go6e1N2sOXbKRfpjf5xjW0N5T0cHxgm9a9YJSj/T67GXG
	Fekl/jjmDHMcNIQ=
X-Google-Smtp-Source: AGHT+IEdCvop71IxVDmxbyI+VLG1bHMgUFJCX254kjusIKOtBxnkHakfEgU6KYI1lpBx+kU5iAXctw==
X-Received: by 2002:a17:902:ef48:b0:215:742e:5cff with SMTP id d9443c01a7336-216114e67eamr186694365ad.16.1733670458958;
        Sun, 08 Dec 2024 07:07:38 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([223.185.130.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216412293d2sm10274515ad.237.2024.12.08.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:07:38 -0800 (PST)
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
Subject: [PATCH 3/4] irqchip/riscv-imsic: Set irq_set_affinity for IMSIC base
Date: Sun,  8 Dec 2024 20:37:10 +0530
Message-ID: <20241208150711.297624-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208150711.297624-1-apatel@ventanamicro.com>
References: <20241208150711.297624-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Jones <ajones@ventanamicro.com>

Instead of using imsic_irq_set_affinity() for non-leaf MSI domains,
use imsic_irq_set_affinity() for the leaf IMSIC base domain and use
irq_chip_set_affinity_parent() for non-leaf MSI domains.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 707c7ccb4d08..33a8261e6017 100644
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



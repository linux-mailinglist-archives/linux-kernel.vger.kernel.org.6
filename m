Return-Path: <linux-kernel+bounces-436425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5F69E85B6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BEB164D96
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA943AB9;
	Sun,  8 Dec 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IE3zJvzI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E417BA5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670450; cv=none; b=etxresN+kDuhDszhoc1/CUvihcCSHNUJlvWFrDZt5QwPWPB8FbTszdzcplgDg0epvoP/R93Hvbor+E5dPH1F0ZecHzMr4xLdhoNliQL5cEnAFK9W9OtQlY74j99EGripEgOWiJpAKNYwjrIUXUdQEuAX2yg+eLZb12Afg/FNW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670450; c=relaxed/simple;
	bh=1H+iWfU5NlvI54+uFA8ySfgxCSD3NGISO91+xEb5R1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYAVE0VHogAYFIaw+jqByH5dPpl6O2LObLZ72i8wC0PN7fLUQJm3Gh1O8sBImV6H0KfaYTEXYq1u6kCSZcCu304jwaO5NXM/Ompbb3FsYrMNN36dIbNm7h1CfuT5PXRxCnYGUD6g1IiUr1NGdNNhJYkpge4CSlH8vfAmLsjizUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IE3zJvzI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216281bc30fso14198255ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733670448; x=1734275248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPiL+4+uUrxsUPNFNe0qcu/2Buvw2EBCmaBEkU4Ga+k=;
        b=IE3zJvzIwUWPclPrKm+NU5+DVZMaBrmq3YjHOSjtxmLZp+QKxWHjQItYVufB7SpN2d
         snGNRtFEr8LtgDPdRhMKc7HCi1tpmi2qsVPsXZ3L65VAG+bTw0SU4ZPKXCAfQjklzH0m
         3QZNYnkBljqGIPUYwhtZlqHRRfNASYPSmIwGg3RQq6a1ZTgvhQcdvyC/QzJ+KljpQFX2
         +kphJsraTPdR8fgBJ81QQXHvCN7U3U/3j2Jcv+lPIY2gUGSq4ubnLuvkIOTdLU1B0m1h
         etCY0DHkRa1JhXDB5SxhtkmVtVkxzmhJATpmsA7sJ7vYKjU3PaeiJQJiFa9Nnz1m1gRD
         xY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733670448; x=1734275248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPiL+4+uUrxsUPNFNe0qcu/2Buvw2EBCmaBEkU4Ga+k=;
        b=EBKte8JffyzJ62VzacLa1wN5zdmaolXqg94Cea/lPCMTYYq0BqIZtRBVcko5BoCfAs
         7oUDKeV3F0Q+0bUjGFtPQUzIuNy0cUgS5YeKEPtkCsm9xsTBTFyCOYlIc/wX7JIZBC3s
         uPmz5IT1pWMrOUlZgirPoYqxs2FYx8cgc5tjjvpGFJgPyKA/0j0xcomJGU7hGYFO1n1y
         KJd/MW8c0RbyjKEEb/bCA+l769DUUXqzdVElEeP97QjIazDIXn87OPJOmWVU77FvQzxz
         mTIu8w5LjIblirLMF6mg6qX2mPUmUp1necBq8H77RZ5tFYKCaUzCpT8Id3b0svR85l8C
         ScPA==
X-Forwarded-Encrypted: i=1; AJvYcCVyqsqLJk80s0xvHzWHsRtYfP+QEcfb3m5Arvnj/ezlBvnwOHv+bvd5aV4yeCLtfqE2k4I08BOb1uGTy0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdBTcx08SWezJPbJRziLaHF/KGadsfPmE0oKhgZzHItrtqgsF
	4CJBsMn1Q6Udh26PUFQILgI9LhBBuhpZeyQt0UekvIzjWmR2+dZ2+0kj/xMjV/Q=
X-Gm-Gg: ASbGncsbqIal5sTvV1y535OzR3ZQ0tdFdLkOHV0AUI+hqiJK6zseozc/2jXGogDzwOx
	t2Rsuh1a7zWMWIOJ+oKlpOBjgKFq0J7DmOOfGVyc/tNu3xF15atwxoftsNhFbquZBH1pftc7Jb2
	53fcY5l/oiXbVOtkS+nJ4uWeJbBuZgLap0yl1sSn6uYRW4nMhxp0DqZX+LPc6K1eoV5ILwqwO4c
	CluqgJrIQaSt5r5TGctMzYdrxI1UrkGl4wQeXpWlpS9Z+vXCddCURA0WKUMD85Nn0Kd0cAeXr0h
	q0LVFICVbZNHfOc=
X-Google-Smtp-Source: AGHT+IGeMHvOT6RCYMvwhhYpeZ8b5RyMdQq1g0U5HspyszP4RDGsvXBxsgKTLdGXoqrj8jvGvqY46w==
X-Received: by 2002:a17:902:ec90:b0:215:b5d6:5fa8 with SMTP id d9443c01a7336-21614d98c11mr163726535ad.22.1733670448046;
        Sun, 08 Dec 2024 07:07:28 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([223.185.130.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216412293d2sm10274515ad.237.2024.12.08.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:07:27 -0800 (PST)
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
Subject: [PATCH 1/4] irqchip/riscv-imsic: Handle non-atomic MSI updates for device
Date: Sun,  8 Dec 2024 20:37:08 +0530
Message-ID: <20241208150711.297624-2-apatel@ventanamicro.com>
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

Device having non-atomic MSI update might see an intermediate
state when changing target IMSIC vector from one CPU to another.

To handle such intermediate device state, update MSI address
and MSI data through separate MSI writes to the device.

Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for platform devices")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 27 ++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.c    | 27 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index c708780e8760..707c7ccb4d08 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -97,6 +97,7 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 {
 	struct imsic_vector *old_vec, *new_vec;
 	struct irq_data *pd = d->parent_data;
+	struct imsic_vector tmp_vec;
 
 	old_vec = irq_data_get_irq_chip_data(pd);
 	if (WARN_ON(!old_vec))
@@ -110,11 +111,37 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 	if (imsic_vector_get_move(old_vec))
 		return -EBUSY;
 
+	/*
+	 * Device having non-atomic MSI update might see an intermediate
+	 * state when changing target IMSIC vector from one CPU to another.
+	 *
+	 * To avoid losing interrupt to some intermediate state, do the
+	 * following (just like x86 APIC):
+	 *
+	 * 1) First write a temporary IMSIC vector to the device which
+	 * has MSI address same as the old IMSIC vector but MSI data
+	 * matches the new IMSIC vector.
+	 *
+	 * 2) Next write the new IMSIC vector to the device.
+	 *
+	 * Based on the above, the __imsic_local_sync() must check both
+	 * old MSI data and new MSI data on the old CPU for pending
+	 */
+
 	/* Get a new vector on the desired set of CPUs */
 	new_vec = imsic_vector_alloc(old_vec->hwirq, mask_val);
 	if (!new_vec)
 		return -ENOSPC;
 
+	if (new_vec->local_id != old_vec->local_id) {
+		/* Setup temporary vector */
+		tmp_vec.cpu = old_vec->cpu;
+		tmp_vec.local_id = new_vec->local_id;
+
+		/* Point device to the temporary vector */
+		imsic_msi_update_msg(d, &tmp_vec);
+	}
+
 	/* Point device to the new vector */
 	imsic_msi_update_msg(d, new_vec);
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b97e6cd89ed7..230b917136e6 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -126,8 +126,8 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 
 static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
-	struct imsic_local_config *mlocal;
-	struct imsic_vector *vec, *mvec;
+	struct imsic_local_config *tlocal, *mlocal;
+	struct imsic_vector *vec, *tvec, *mvec;
 	int i;
 
 	lockdep_assert_held(&lpriv->lock);
@@ -151,7 +151,28 @@ static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 		mvec = READ_ONCE(vec->move);
 		WRITE_ONCE(vec->move, NULL);
 		if (mvec && mvec != vec) {
-			if (__imsic_id_read_clear_pending(i)) {
+			/*
+			 * Device having non-atomic MSI update might see an
+			 * intermediate state so check both old ID and new ID
+			 * for pending interrupts.
+			 *
+			 * For details, refer imsic_irq_set_affinity().
+			 */
+
+			tvec = vec->local_id == mvec->local_id ?
+			       NULL : &lpriv->vectors[mvec->local_id];
+			if (tvec && __imsic_id_read_clear_pending(tvec->local_id)) {
+				/* Retrigger temporary vector if it was already in-use */
+				if (READ_ONCE(tvec->enable)) {
+					tlocal = per_cpu_ptr(imsic->global.local, tvec->cpu);
+					writel_relaxed(tvec->local_id, tlocal->msi_va);
+				}
+
+				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
+				writel_relaxed(mvec->local_id, mlocal->msi_va);
+			}
+
+			if (__imsic_id_read_clear_pending(vec->local_id)) {
 				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
-- 
2.43.0



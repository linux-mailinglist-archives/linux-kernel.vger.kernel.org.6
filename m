Return-Path: <linux-kernel+bounces-517218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F079FA37DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942FB1654E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E111A9B53;
	Mon, 17 Feb 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Lsc/XXV1"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01F1A314E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782752; cv=none; b=AYvzedQi5xOuyUivp2Y5w75iC5KZxW3ROGeK2pul/DfvT+Q9R5EGytc40Z2REeE2+noN9cvZ2Y427d3wtr4l2qdXIMDiDiqoBF70Zo/+zvB3mh1kiD75wQ0GgF6+Zj9VWrkQSPtpwdtgSztXobbIp+OLBu0HA1fMT9ZqjlmnPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782752; c=relaxed/simple;
	bh=tNahCfxLRgNIbiBla43nJrTI1GFGdO1edGYaRhyK8s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7YId8LG+F/YtNo51cs88f1qVnVes52zO5XZ5FVbNLuzZL7t3BheFRy6pKgYwMXubhwTi32tcAQcD9/9962/RzXxodTonmkZ3kMycaIXEuiCFGXjKRJRQwc6shJTjCRG9Fiv4UB+Nb9xxkfJMKi3/GoXvt/og2QUTXBHtVc2c3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Lsc/XXV1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22104c4de96so26085415ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782750; x=1740387550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEjndyBD35lV6nr6NSLWRRyly4db2axy7koFOHZTKsQ=;
        b=Lsc/XXV1YimBLdmnaKn9Zsl8BoUbUEzOLaw+rzRvc40/vl1ItqtahNyZ3MeAVQAj4/
         y9QEu7hRj1fTAaKvQiSXNTQORBJ2Q8MlVlAKZvqEPe719kzW+1YKOgJO3hdd7RXq4Kux
         0tAxqjVwLG0srjj8n9WcT1BodsGEnryDmLDMynT1ghaMojuIOZ6aPr4ZhNsankFCkjT8
         Vf1cpQNgOIgiAf/HAjEXrwE+r0DymDS46k6x90h4uuEMQrwn8oBWf+1wVM32sYn1CFgL
         cYwI++CAs963qvnk0ock1v+ez/lLjZjc07iaG2PAyBYr0RghMcyLi4WCBl3vDmHkKDWX
         7dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782750; x=1740387550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEjndyBD35lV6nr6NSLWRRyly4db2axy7koFOHZTKsQ=;
        b=TIwMcwSufeTi1UxVUTqTk6u1OvynXOrwmyeEueslCE/3eKTyvbNW23lGxQh/s1wLXm
         n8UksLQ84FiarBReD9yRoXuOCsLnb1qoZy4bRMUmMoiDpY5dVyujdDhZtQyMDPfYUkpa
         3bP0z66RmqRZjUItl0K2+IC5Fitbdf7jrNrF4N/GY7qQoEikPVoNpcgkqcg1QbKcuA4R
         mUGHSuGPdi/hXHRB1+MCpy+8ufw+W61CbmWuCoWNHk1cGwBY+eKA0rw0CXn0vXTYyGrg
         UAltry+k77JhZKjvYmHXsXObejdr0wNi5lMMoBSjUHgZpPWEXVpsJjt0wsTajeJA3kw1
         gUDA==
X-Forwarded-Encrypted: i=1; AJvYcCX9VS9JvKJiXU6KrAAFvDWQ2uVPF1LnxKuSgZx+670kLylCVDCRuR9bUrSMETgVYQursH6/TaRm80YqP5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+i9Lq5pM6ec1EZH4r8QfI4oPLzHbv3Rc07vhtSsgcQDoeavbo
	F5BGHOFi/h9hohjHIbYkx9cNpcPrOZ4j5Z6nxEuv0veytsu5P49zPvMkgh1zbwY=
X-Gm-Gg: ASbGncsqeNG15WkaWbgyBYUSYufH/a9w9DuwK3Sf32uSQw77DLa01mXL8O1zuvjc7se
	ubMU+Gfv5lcwv6kuoOZKEtrbGwup05UlMdccJ6PDcMmD8vzDA11QnYhDoa/QiX53TIPgp+EWSXS
	90otRCjekKvTLmiU7rVl72wxLbGAeIldooaaLJ0cRro1k8phOk4eGEeuPw8O/v0dXMF7XaRdng7
	KQlxcneYv81uD+73ckRpOXDb4AlKFbvaL45ZVLoODje5EtETLekY/xVI6k5nNL00TX6ydd3j+qB
	J+W5kLSy3FOmx2d7QquFvSQEOir7RqhzNyfq3tab1yTQIJkEZBtVQFI=
X-Google-Smtp-Source: AGHT+IH6Tjxl2D2mFXDe6LhFiNV1G6vUFczqpaUqf8nSRh0V0anC6B6P0c3HIggrJMZH7GpsMRQCQA==
X-Received: by 2002:a05:6a00:1392:b0:730:74f8:25b6 with SMTP id d2e1a72fcca58-7326179e8a0mr14044686b3a.6.1739782749571;
        Mon, 17 Feb 2025 00:59:09 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:59:08 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	Marc Zyngier <maz@kernel.org>,
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
Subject: [PATCH v6 10/10] irqchip/riscv-imsic: Special handling for non-atomic device MSI update
Date: Mon, 17 Feb 2025 14:26:56 +0530
Message-ID: <20250217085657.789309-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217085657.789309-1-apatel@ventanamicro.com>
References: <20250217085657.789309-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device having non-atomic MSI update might see an intermediate
state when changing target IMSIC vector from one CPU to another.

To avoid losing interrupt to such intermediate state, do the
following (just like x86 APIC):
 1) First write a temporary IMSIC vector to the device which
    has MSI address same as the old IMSIC vector but with MSI
    data matches the new IMSIC vector.
 2) Next write the new IMSIC vector to the device.

Based on the above, the __imsic_local_sync() must check pending
status of both old MSI data and new MSI data on the old CPU. In
addition, the movement of IMSIC vector for non-atomic device MSI
update must be done in interrupt context using IRQCHIP_MOVE_DEFERRED.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 73 +++++++++++++++++++++-
 drivers/irqchip/irq-riscv-imsic-state.c    | 31 +++++++--
 2 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 6bf5d63f614e..828102c46f51 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -64,6 +64,11 @@ static int imsic_irq_retrigger(struct irq_data *d)
 	return 0;
 }
 
+static void imsic_irq_ack(struct irq_data *d)
+{
+	irq_move_irq(d);
+}
+
 static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_msg *msg)
 {
 	phys_addr_t msi_addr;
@@ -97,6 +102,21 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
+	struct imsic_vector tmp_vec;
+
+	/*
+	 * Requirements for the downstream irqdomains (or devices):
+	 *
+	 * 1) Downstream irqdomains (or devices) with atomic MSI update can
+	 *    happily do imsic_irq_set_affinity() in the process-context on
+	 *    any CPU so the irqchip of such irqdomains must not set the
+	 *    IRQCHIP_MOVE_DEFERRED flag.
+	 *
+	 * 2) Downstream irqdomains (or devices) with non-atomic MSI update
+	 *    must do imsic_irq_set_affinity() in the interrupt-context upon
+	 *    next interrupt so the irqchip of such irqdomains must set the
+	 *    IRQCHIP_MOVE_DEFERRED flag.
+	 */
 
 	old_vec = irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
@@ -115,6 +135,33 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 	if (!new_vec)
 		return -ENOSPC;
 
+	/*
+	 * Device having non-atomic MSI update might see an intermediate
+	 * state when changing target IMSIC vector from one CPU to another.
+	 *
+	 * To avoid losing interrupt to such intermediate state, do the
+	 * following (just like x86 APIC):
+	 *
+	 * 1) First write a temporary IMSIC vector to the device which
+	 * has MSI address same as the old IMSIC vector but MSI data
+	 * matches the new IMSIC vector.
+	 *
+	 * 2) Next write the new IMSIC vector to the device.
+	 *
+	 * Based on the above, the __imsic_local_sync() must check pending
+	 * status of both old MSI data and new MSI data on the old CPU.
+	 */
+
+	if (!irq_can_move_in_process_context(d) &&
+	    new_vec->local_id != old_vec->local_id) {
+		/* Setup temporary vector */
+		tmp_vec.cpu = old_vec->cpu;
+		tmp_vec.local_id = new_vec->local_id;
+
+		/* Point device to the temporary vector */
+		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
+	}
+
 	/* Point device to the new vector */
 	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
@@ -171,6 +218,7 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_force_complete_move = imsic_irq_force_complete_move,
 #endif
 	.irq_retrigger		= imsic_irq_retrigger,
+	.irq_ack		= imsic_irq_ack,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -190,7 +238,7 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -ENOSPC;
 
 	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
-			    handle_simple_irq, NULL, NULL);
+			    handle_edge_irq, NULL, NULL);
 	irq_set_noprobe(virq);
 	irq_set_affinity(virq, cpu_online_mask);
 	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->cpu));
@@ -229,15 +277,36 @@ static const struct irq_domain_ops imsic_base_domain_ops = {
 #endif
 };
 
+static bool imsic_init_dev_msi_info(struct device *dev,
+				    struct irq_domain *domain,
+				    struct irq_domain *real_parent,
+				    struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->flags |= IRQCHIP_MOVE_DEFERRED;
+		break;
+	default:
+		break;
+	}
+
+	return true;
+}
+
 static const struct msi_parent_ops imsic_msi_parent_ops = {
 	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
 				  MSI_FLAG_PCI_MSIX,
 	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
 				  MSI_FLAG_USE_DEF_CHIP_OPS |
 				  MSI_FLAG_PCI_MSI_MASK_PARENT,
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
-	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+	.init_dev_msi_info	= imsic_init_dev_msi_info,
 };
 
 int imsic_irqdomain_init(void)
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index d0148e48ab05..3a2a381e4fa1 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -126,8 +126,8 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 
 static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
-	struct imsic_local_config *mlocal;
-	struct imsic_vector *vec, *mvec;
+	struct imsic_local_config *tlocal, *mlocal;
+	struct imsic_vector *vec, *tvec, *mvec;
 	bool ret = true;
 	int i;
 
@@ -169,13 +169,36 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 		 */
 		mvec = READ_ONCE(vec->move_next);
 		if (mvec) {
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
+			if (tvec &&
+			    !irq_can_move_in_process_context(irq_get_irq_data(vec->irq)) &&
+			    __imsic_id_read_clear_pending(tvec->local_id)) {
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
 
 			WRITE_ONCE(vec->move_next, NULL);
-			imsic_vector_free(&lpriv->vectors[i]);
+			imsic_vector_free(vec);
 		}
 
 skip:
-- 
2.43.0



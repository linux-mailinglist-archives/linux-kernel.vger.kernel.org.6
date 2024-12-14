Return-Path: <linux-kernel+bounces-446127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B89F201B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C31166A7D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B81AD9ED;
	Sat, 14 Dec 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dJ2yIitq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA81A8F6B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197243; cv=none; b=BM6refxZIfEMMwm77lZ3FgrSq1rabXDANzDABPb2G/QiwXpwV/M4C0LS53SOgwH+kbriU2TOpjdmdgZWN1C/scPyJvXif2mcRLwlHqnzasuVq3OhpFB1PT0YZYKNcPBpqiZNbK5B7NqO8XqIpxUVLlMdIDbvZ/5ivo7Wd2GHeR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197243; c=relaxed/simple;
	bh=y8LyhxLnr8gL59ez8smjdkMSejl79VB7Tc2egqGrEC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY2WThnjyvSBOkoUgGvUGpqiybd8RtlO+H8QVf3IE7py82rQuoLUIRzI08ywqfBLFbA+4QKxHgpVM1tgT5oAZEDmVFHpXjElL53wehvn1nBpnCAxIj7eQnrMZdXYKKzGAeGguT/Q18HZnGQnoqwTXYIkzdMe8GWZgnSGvnjGPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dJ2yIitq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163dc5155fso24614145ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197241; x=1734802041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q91PIdpY0ToxJxjWetgT5wSgNIKHhdsWJzKO3onxaMI=;
        b=dJ2yIitqwdqTpVAHBuU07bw2Zy2Jd2eAFyVmuyzfZ8IWrfhmVuWcjXKpOmUEfyQHMZ
         a4na4YOoPmd/G1gqpszkqqzN47jCUCjbuv2kVY8RcLy5DBYZJBbbl/7mtJZl/GEQ1Xf4
         kIzVTc76uGGSTZFnSlZkLQTikzIkWRmEtx5H252ExoqXOx1WGzWMZ1vTHh7/+J0L7Ili
         DjnPD4yWmolQKVrY0YYUNXaTIwKmDnl6r3AiZvfVwMxQZiUgwqZ2bpKb2Wr1phHz3AXB
         ozpnkVy0SpsCXBHM40b/+0IDC/SnO4qU3gr4XdptVlv3oLuCPBj7IpCfJgzTkowxFVH+
         BE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197241; x=1734802041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q91PIdpY0ToxJxjWetgT5wSgNIKHhdsWJzKO3onxaMI=;
        b=QwaU8xejheg96dev6JQYJS7Qj+n6IvI9KXJU/tm8CD6eYe1pCj/q7SG0ssTleiWJhX
         Ehv8jZor3HpJPJQotqW+YKMcOILXXxih8QCJVw8fELgWJrLJNZQ55ad4lOs5jm7t2Tmj
         ZBhwLh1HIf6ua/YE1sDK2alDbrGhCyNxeFCVhAkhjj5ZLan8haSu1MhnooaePJtyYsXe
         9AXpVgQqMHYpW+SdV95ChOqDedqd23Fw+6sPzxY2ZNKGpsco7VPouowOY2OgNxbVkQw1
         +wMobGROXLMIHxjYx7PnkDEmTDaYxjI1mLT3HF8BIvq3s5Q8ofHkyczbuHw3TgTlFhIe
         hmdg==
X-Forwarded-Encrypted: i=1; AJvYcCXB7OQJnR6A6rJZiXtCWNvZ+adpOkXuH4piiGmNHx/7d2jOzzEO15aCCbkCC5mQgepAUdMOK4gU8z1w5Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5fgNxhk61EP/YSHG8ovx65LdHTK7lNdvZ0+Z3NEK/2dkQtzD
	sPTWAXsMrhUIUdJxkxPf6iNaBiqxRCJQjvsCAz6Wdsa66P9c6R6AYnWC8ObRQFo=
X-Gm-Gg: ASbGncv4YFgU10J5OQJQUJdtgmyMi5KxLkLWXjOR6DjBhSjVvdq+20gHcXm70upDcd8
	actVdkC7DuAsx3gjrFaB7xgFi90x5Bi2r82XSA1zZDye0vnu5c56/DmOO/aLcrX8o9fncqWzJXS
	yJh8uASB2+Ui/uyr45vtyIspPBskvqF89RMBIYUruJGz68I90f9OrY35zCJK5NXllbO66sN3GsP
	OwNwwTYsL7Zb5AfOnSIargTdTBJt1J4KqZpqi/P9xOINHT1LJiN4f7q7Ua1jpBa0yOEFBGD0T9U
	5yluC6AZtpqzKBE=
X-Google-Smtp-Source: AGHT+IHMsJ5YCvABWOrU64w2NgYzPATagi+l1J7ESIDXSbMnwGULGsvQOBHQ97Lfbn1IK/p1gbun3A==
X-Received: by 2002:a17:902:ecc1:b0:216:46f4:7e30 with SMTP id d9443c01a7336-21892a42024mr107832805ad.43.1734197240770;
        Sat, 14 Dec 2024 09:27:20 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:27:20 -0800 (PST)
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
Subject: [PATCH v2 11/11] irqchip/riscv-imsic: Use IRQCHIP_MOVE_DEFERRED flag for PCI devices
Date: Sat, 14 Dec 2024 22:55:49 +0530
Message-ID: <20241214172549.8842-12-apatel@ventanamicro.com>
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

Devices (such as PCI) which have non-atomic MSI update should
migrate irq in the interrupt-context so use IRQCHIP_MOVE_DEFERRED
flag for corresponding irqchips.

The use of IRQCHIP_MOVE_DEFERRED further simplifies IMSIC vector
movement as follows:

1) No need to handle the intermediate state seen by devices with
   non-atomic MSI update because imsic_irq_set_affinity() is called
   in the interrupt-context with interrupt masked.
2) No need to check temporary vector when completing vector movement
   on the old CPU in __imsic_local_sync().
3) No need to call imsic_local_sync_all() from imsic_handle_irq()

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 74 ++++++++++++++--------
 drivers/irqchip/irq-riscv-imsic-state.c    | 25 +-------
 2 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index e6c81718ba78..eac7f358bbba 100644
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
@@ -97,7 +102,20 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
-	struct imsic_vector tmp_vec;
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
@@ -117,31 +135,13 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -ENOSPC;
 
 	/*
-	 * Device having non-atomic MSI update might see an intermediate
-	 * state when changing target IMSIC vector from one CPU to another.
-	 *
-	 * To avoid losing interrupt to some intermediate state, do the
-	 * following (just like x86 APIC):
-	 *
-	 * 1) First write a temporary IMSIC vector to the device which
-	 * has MSI address same as the old IMSIC vector but MSI data
-	 * matches the new IMSIC vector.
-	 *
-	 * 2) Next write the new IMSIC vector to the device.
-	 *
-	 * Based on the above, the __imsic_local_sync() must check both
-	 * old MSI data and new MSI data on the old CPU for pending
+	 * Downstream irqdomains (or devices) with non-atomic MSI update
+	 * may see an intermediate state when changing target IMSIC vector
+	 * from one CPU to another but using the IRQCHIP_MOVE_DEFERRED
+	 * flag this is taken care because imsic_irq_set_affinity() is
+	 * called in the interrupt-context with interrupt masked.
 	 */
 
-	if (new_vec->local_id != old_vec->local_id) {
-		/* Setup temporary vector */
-		tmp_vec.cpu = old_vec->cpu;
-		tmp_vec.local_id = new_vec->local_id;
-
-		/* Point device to the temporary vector */
-		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
-	}
-
 	/* Point device to the new vector */
 	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
@@ -198,6 +198,7 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_force_complete_move = imsic_irq_force_complete_move,
 #endif
 	.irq_retrigger		= imsic_irq_retrigger,
+	.irq_ack		= imsic_irq_ack,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -217,7 +218,7 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -ENOSPC;
 
 	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
-			    handle_simple_irq, NULL, NULL);
+			    handle_edge_irq, NULL, NULL);
 	irq_set_noprobe(virq);
 	irq_set_affinity(virq, cpu_online_mask);
 	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->cpu));
@@ -256,15 +257,36 @@ static const struct irq_domain_ops imsic_base_domain_ops = {
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
index aca769d915bf..c7649fb6bbe6 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -126,8 +126,8 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 
 static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
-	struct imsic_local_config *tlocal, *mlocal;
-	struct imsic_vector *vec, *tvec, *mvec;
+	struct imsic_local_config *mlocal;
+	struct imsic_vector *vec, *mvec;
 	bool ret = true;
 	int i;
 
@@ -170,27 +170,6 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 		 */
 		mvec = READ_ONCE(vec->move_next);
 		if (mvec) {
-			/*
-			 * Device having non-atomic MSI update might see an
-			 * intermediate state so check both old ID and new ID
-			 * for pending interrupts.
-			 *
-			 * For details, refer imsic_irq_set_affinity().
-			 */
-
-			tvec = vec->local_id == mvec->local_id ?
-			       NULL : &lpriv->vectors[mvec->local_id];
-			if (tvec && __imsic_id_read_clear_pending(tvec->local_id)) {
-				/* Retrigger temporary vector if it was already in-use */
-				if (READ_ONCE(tvec->enable)) {
-					tlocal = per_cpu_ptr(imsic->global.local, tvec->cpu);
-					writel_relaxed(tvec->local_id, tlocal->msi_va);
-				}
-
-				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
-				writel_relaxed(mvec->local_id, mlocal->msi_va);
-			}
-
 			if (__imsic_id_read_clear_pending(vec->local_id)) {
 				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
-- 
2.43.0



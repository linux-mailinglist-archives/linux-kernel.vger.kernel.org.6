Return-Path: <linux-kernel+bounces-215374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D249091B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E74C2830BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D061AED40;
	Fri, 14 Jun 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U29Lbg8g"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D11AC23A;
	Fri, 14 Jun 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386381; cv=none; b=nzc0SvVkI+LT8RE30INWDJsxuFjmiQi9HxYDUzafKdcBefXerhJkp04BgtPGzNtQwuiModUNDpCUOpxFtKVrktNn3azVGBWnpu0B+hSlGRh85gtwDmvPsh8eiNwpCsF7gJjriGnRFPwGHaAArsC27OqdDXIqApy5LrMbAPXGsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386381; c=relaxed/simple;
	bh=OnVrLoCi+6BDKzf8bzc7Tj+EtKoZ3Vjs17H87WX0m2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQz9sbKx+iieid5zDvLA3S0aMlq7uSwbNMY0TXE0Sp3AcSIpbc/I9HL6ePwj5JnK1oVfKACeJOcpdANxXRtYhvjFxSRzH3sTAkIEtVaZpvrOTjniGIe2Ov6kOP/aqCvsw6waJEi8phB4abfxEaPLiaj0KwIwaaC0L2TaW41+Tu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U29Lbg8g; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7D05EFF80E;
	Fri, 14 Jun 2024 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvqCnXtyoeDBoxsdNOPXYVVV6ciJIw8ShpzsPIPO4/M=;
	b=U29Lbg8gQry/i9Hq7FxqeVyrileRW/eaA/Rd7+mp309BaEWTi0oOaB7zkfRcwAKMAOSTXj
	jp7UI7NbB7kRVfi0HeUz/8u8vFHlM6Tl6ZfxNnt3lw2pwK4+sbBpi800EL8/heLedBc6g0
	yg+Tg6mkt2mMwfdfMlF/LQX+m+IdO4J28gcQ5WZ2nlOYH378mr7R4VUT1dwbL9jU1e6eq7
	+h9Le7z0MBNHc5F890Vtqyu/u+monmy3MGPCnGr0F9zrNeCFsF2/waQgFIPXE8I/EMn95o
	TeCZGXo1DI7ZRsppwr3ds/8LURxrU5b42+jo2Y0f7Dy1KG03RdodRA6z3CbLEQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 13/23] genirq/generic_chip: Introduce irq_domain_{alloc,remove}_generic_chips()
Date: Fri, 14 Jun 2024 19:32:14 +0200
Message-ID: <20240614173232.1184015-14-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The existing __irq_alloc_domain_generic_chips() use a bunch of
parameters to describe the generic chips that need to be allocated.

Adding more parameters and wrappers to hide new parameters in the
existing code lead to more and more code without any relevant values and
without any flexibility.

Introduce irq_domain_alloc_generic_chips() where the generic chips
description is done using the irq_domain_chip_generic_info structure
instead of the bunch of parameters to allow flexibility and easy
evolution.

Also introduce irq_domain_remove_generic_chips() to revert the
operations done by irq_domain_alloc_generic_chips().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irq.h       | 25 +++++++++++
 kernel/irq/generic-chip.c | 91 +++++++++++++++++++++++++++++----------
 2 files changed, 93 insertions(+), 23 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a217e1029c1d..58264b236cbf 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1117,6 +1117,27 @@ struct irq_domain_chip_generic {
 	struct irq_chip_generic	*gc[];
 };
 
+/**
+ * struct irq_domain_chip_generic_info - Generic chip information structure
+ * @name:		Name of the generic interrupt chip
+ * @handler:		Interrupt handler used by the generic interrupt chip
+ * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
+ * @num_ct:		Number of irq_chip_type instances associated with each
+ *			chip
+ * @irq_flags_to_clear:	IRQ_* bits to clear in the mapping function
+ * @irq_flags_to_set:	IRQ_* bits to set in the mapping function
+ * @gc_flags:		Generic chip specific setup flags
+ */
+struct irq_domain_chip_generic_info {
+	const char		*name;
+	irq_flow_handler_t	handler;
+	unsigned int		irqs_per_chip;
+	unsigned int		num_ct;
+	unsigned int		irq_flags_to_clear;
+	unsigned int		irq_flags_to_set;
+	enum irq_gc_flags	gc_flags;
+};
+
 /* Generic chip callback functions */
 void irq_gc_noop(struct irq_data *d);
 void irq_gc_mask_disable_reg(struct irq_data *d);
@@ -1153,6 +1174,10 @@ int devm_irq_setup_generic_chip(struct device *dev, struct irq_chip_generic *gc,
 
 struct irq_chip_generic *irq_get_domain_generic_chip(struct irq_domain *d, unsigned int hw_irq);
 
+int irq_domain_alloc_generic_chips(struct irq_domain *d,
+				   const struct irq_domain_chip_generic_info *info);
+void irq_domain_remove_generic_chips(struct irq_domain *d);
+
 int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 				     int num_ct, const char *name,
 				     irq_flow_handler_t handler,
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index d39a40bc542b..d9696f5dcc38 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -276,21 +276,14 @@ irq_gc_init_mask_cache(struct irq_chip_generic *gc, enum irq_gc_flags flags)
 }
 
 /**
- * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
- * @d:			irq domain for which to allocate chips
- * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
- * @num_ct:		Number of irq_chip_type instances associated with this
- * @name:		Name of the irq chip
- * @handler:		Default flow handler associated with these chips
- * @clr:		IRQ_* bits to clear in the mapping function
- * @set:		IRQ_* bits to set in the mapping function
- * @gcflags:		Generic chip specific setup flags
+ * irq_domain_alloc_generic_chips - Allocate generic chips for an irq domain
+ * @d:		irq domain for which to allocate chips
+ * @info:	Generic chip information
+ *
+ * Return: 0 on success, negative error code on failure
  */
-int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
-				     int num_ct, const char *name,
-				     irq_flow_handler_t handler,
-				     unsigned int clr, unsigned int set,
-				     enum irq_gc_flags gcflags)
+int irq_domain_alloc_generic_chips(struct irq_domain *d,
+				   const struct irq_domain_chip_generic_info *info)
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
@@ -304,23 +297,23 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	if (d->gc)
 		return -EBUSY;
 
-	numchips = DIV_ROUND_UP(d->revmap_size, irqs_per_chip);
+	numchips = DIV_ROUND_UP(d->revmap_size, info->irqs_per_chip);
 	if (!numchips)
 		return -EINVAL;
 
 	/* Allocate a pointer, generic chip and chiptypes for each chip */
-	gc_sz = struct_size(gc, chip_types, num_ct);
+	gc_sz = struct_size(gc, chip_types, info->num_ct);
 	dgc_sz = struct_size(dgc, gc, numchips);
 	sz = dgc_sz + numchips * gc_sz;
 
 	tmp = dgc = kzalloc(sz, GFP_KERNEL);
 	if (!dgc)
 		return -ENOMEM;
-	dgc->irqs_per_chip = irqs_per_chip;
+	dgc->irqs_per_chip = info->irqs_per_chip;
 	dgc->num_chips = numchips;
-	dgc->irq_flags_to_set = set;
-	dgc->irq_flags_to_clear = clr;
-	dgc->gc_flags = gcflags;
+	dgc->irq_flags_to_set = info->irq_flags_to_set;
+	dgc->irq_flags_to_clear = info->irq_flags_to_clear;
+	dgc->gc_flags = info->gc_flags;
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
@@ -328,11 +321,12 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	for (i = 0; i < numchips; i++) {
 		/* Store the pointer to the generic chip */
 		dgc->gc[i] = gc = tmp;
-		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
-				      NULL, handler);
+		irq_init_generic_chip(gc, info->name, info->num_ct,
+				      i * dgc->irqs_per_chip, NULL,
+				      info->handler);
 
 		gc->domain = d;
-		if (gcflags & IRQ_GC_BE_IO) {
+		if (dgc->gc_flags & IRQ_GC_BE_IO) {
 			gc->reg_readl = &irq_readl_be;
 			gc->reg_writel = &irq_writel_be;
 		}
@@ -345,6 +339,57 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_domain_alloc_generic_chips);
+
+/**
+ * irq_domain_remove_generic_chips - Remove generic chips from an irq domain
+ * @d: irq domain for which generic chips are to be removed
+ */
+void irq_domain_remove_generic_chips(struct irq_domain *d)
+{
+	struct irq_domain_chip_generic *dgc = d->gc;
+	unsigned int i;
+
+	if (!dgc)
+		return;
+
+	for (i = 0; i < dgc->num_chips; i++)
+		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
+
+	d->gc = NULL;
+	kfree(dgc);
+}
+EXPORT_SYMBOL_GPL(irq_domain_remove_generic_chips);
+
+/**
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
+ * @d:			irq domain for which to allocate chips
+ * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
+ * @num_ct:		Number of irq_chip_type instances associated with this
+ * @name:		Name of the irq chip
+ * @handler:		Default flow handler associated with these chips
+ * @clr:		IRQ_* bits to clear in the mapping function
+ * @set:		IRQ_* bits to set in the mapping function
+ * @gcflags:		Generic chip specific setup flags
+ */
+int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
+				     int num_ct, const char *name,
+				     irq_flow_handler_t handler,
+				     unsigned int clr, unsigned int set,
+				     enum irq_gc_flags gcflags)
+{
+	struct irq_domain_chip_generic_info info = {
+		.irqs_per_chip		= irqs_per_chip,
+		.num_ct			= num_ct,
+		.name			= name,
+		.handler		= handler,
+		.irq_flags_to_clear	= clr,
+		.irq_flags_to_set	= set,
+		.gc_flags		= gcflags,
+	};
+
+	return irq_domain_alloc_generic_chips(d, &info);
+}
 EXPORT_SYMBOL_GPL(__irq_alloc_domain_generic_chips);
 
 static struct irq_chip_generic *
-- 
2.45.0



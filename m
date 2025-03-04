Return-Path: <linux-kernel+bounces-545701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DAA4F065
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F1E3A6066
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E9827CB0C;
	Tue,  4 Mar 2025 22:25:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F027CB37;
	Tue,  4 Mar 2025 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127152; cv=none; b=lhg1CokLmfVa+lyKTCEwchLKLOK3Ihx/q4zGog9zxgjyPauvjkOSpw2/DmGyvr+VJL5ThTYCYcrJcuKMgwXjgM3l79JpOC9CgsPeYLg09/FFTLjik7NhD1/bG3bQ7g9kMgSG0rIbpqCWCZ5cznm/bqP9tW1y/tZfqDyXoZ9zLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127152; c=relaxed/simple;
	bh=tX3kKWCRvoT4Vij53L9eIvzqNnn73WvMjMDtLIj3X10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz7ZFEg3I2tqpiG/KbDCMKX97xBwYgSbev2s3A7gQWfGDypGUJnbEaDMOtVNmDs9106TFxANBpMPdg4nabWjpubEqliRotvgZlEQbUHDfr6GM3JGE8By7TRvEtAQamV27nApCjfQrv2deJewAl7osr4/E7CHwyROh981gBYHJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A7291E4D;
	Tue,  4 Mar 2025 14:26:04 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC513F5A1;
	Tue,  4 Mar 2025 14:25:48 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] irqchip/sunxi-nmi: Support Allwinner A523 NMI controller
Date: Tue,  4 Mar 2025 22:23:00 +0000
Message-ID: <20250304222309.29385-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304222309.29385-1-andre.przywara@arm.com>
References: <20250304222309.29385-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NMI controller in the Allwinner A523 is almost compatible to the
previous versions of this IP, but requires the extra bit 31 to be set in
the enable register to actually report the NMI.

Add a mask to allow such an enable bit to be specified, and add this to
the per-SoC data structure. As this struct was just for different register
offsets so far, it was consequently named "reg_offs", which is now no
longer applicable, so rename this to the more generic "data" on the way.

Also add the respective Allwinner A523 compatible string, and set bit 31
in its enable mask, to add support for this SoC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/irqchip/irq-sunxi-nmi.c | 50 ++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 0b43121520243..9380c3cafeeb5 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -48,30 +48,38 @@ enum {
 	SUNXI_SRC_TYPE_EDGE_RISING,
 };
 
-struct sunxi_sc_nmi_reg_offs {
+struct sunxi_sc_nmi_data {
 	u32 ctrl;
 	u32 pend;
 	u32 enable;
+	u32 enable_val;
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
+static const struct sunxi_sc_nmi_data sun6i_data __initconst = {
 	.ctrl	= SUN6I_NMI_CTRL,
 	.pend	= SUN6I_NMI_PENDING,
 	.enable	= SUN6I_NMI_ENABLE,
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun7i_reg_offs __initconst = {
+static const struct sunxi_sc_nmi_data sun7i_data __initconst = {
 	.ctrl	= SUN7I_NMI_CTRL,
 	.pend	= SUN7I_NMI_PENDING,
 	.enable	= SUN7I_NMI_ENABLE,
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst = {
+static const struct sunxi_sc_nmi_data sun9i_data __initconst = {
 	.ctrl	= SUN9I_NMI_CTRL,
 	.pend	= SUN9I_NMI_PENDING,
 	.enable	= SUN9I_NMI_ENABLE,
 };
 
+static const struct sunxi_sc_nmi_data sun55i_a523_data __initconst = {
+	.ctrl	= SUN9I_NMI_CTRL,
+	.pend	= SUN9I_NMI_PENDING,
+	.enable	= SUN9I_NMI_ENABLE,
+	.enable_val = BIT(31),
+};
+
 static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
 				      u32 val)
 {
@@ -143,7 +151,7 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 }
 
 static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
-					const struct sunxi_sc_nmi_reg_offs *reg_offs)
+					const struct sunxi_sc_nmi_data *data)
 {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
@@ -186,27 +194,28 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_eoi		= irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED |
+						  IRQCHIP_EOI_IF_HANDLED |
 						  IRQCHIP_SKIP_SET_WAKE;
-	gc->chip_types[0].regs.ack		= reg_offs->pend;
-	gc->chip_types[0].regs.mask		= reg_offs->enable;
-	gc->chip_types[0].regs.type		= reg_offs->ctrl;
+	gc->chip_types[0].regs.ack		= data->pend;
+	gc->chip_types[0].regs.mask		= data->enable;
+	gc->chip_types[0].regs.type		= data->ctrl;
 
 	gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
 	gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[1].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[1].regs.ack		= reg_offs->pend;
-	gc->chip_types[1].regs.mask		= reg_offs->enable;
-	gc->chip_types[1].regs.type		= reg_offs->ctrl;
+	gc->chip_types[1].regs.ack		= data->pend;
+	gc->chip_types[1].regs.mask		= data->enable;
+	gc->chip_types[1].regs.type		= data->ctrl;
 	gc->chip_types[1].handler		= handle_edge_irq;
 
 	/* Disable any active interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
+	sunxi_sc_nmi_write(gc, data->enable, data->enable_val);
 
 	/* Clear any pending NMI interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->pend, SUNXI_NMI_IRQ_BIT);
+	sunxi_sc_nmi_write(gc, data->pend, SUNXI_NMI_IRQ_BIT);
 
 	irq_set_chained_handler_and_data(irq, sunxi_sc_nmi_handle_irq, domain);
 
@@ -221,20 +230,27 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun6i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun6i_data);
 }
 IRQCHIP_DECLARE(sun6i_sc_nmi, "allwinner,sun6i-a31-sc-nmi", sun6i_sc_nmi_irq_init);
 
 static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun7i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun7i_data);
 }
 IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-a20-sc-nmi", sun7i_sc_nmi_irq_init);
 
 static int __init sun9i_nmi_irq_init(struct device_node *node,
 				     struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun9i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun9i_data);
 }
 IRQCHIP_DECLARE(sun9i_nmi, "allwinner,sun9i-a80-nmi", sun9i_nmi_irq_init);
+
+static int __init sun55i_nmi_irq_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return sunxi_sc_nmi_irq_init(node, &sun55i_a523_data);
+}
+IRQCHIP_DECLARE(sun55i_nmi, "allwinner,sun55i-a523-nmi", sun55i_nmi_irq_init);
-- 
2.46.3



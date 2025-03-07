Return-Path: <linux-kernel+bounces-550189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4926A55C64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E233C173290
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C618C03D;
	Fri,  7 Mar 2025 00:57:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA228188CD8;
	Fri,  7 Mar 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309056; cv=none; b=mgNneHj0NnD515hFj8NvFd8jNdi9Z4LbM78kjZXdZA92KpPDivJT6NUcLjItfUChfrc1/jNgc2whM7j5W9qD/CnvTq+7hbatRmFjSXdDjsUwnzkBkmI8cSuNGVQnAd5N7kE+3kMRSxKY6Xh/ryK6Kgvb1088sSBZC/DOGwc0UX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309056; c=relaxed/simple;
	bh=RzTn2/y3Rd3RoDPi/R/UfMlv8OCJ4DsZHO6sRVU7Xgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaXwGih/AFVvb4zzZQdcchG0rD4qdzkmbH72iy8EZZVwlPR70gI5Ogr6R7SVPZ4azjefxps69ACfaAxA55KrbngmGZI/6iMgRGTrWbQ7ZkoE9DVOy/YF6nuk+BHxGy9FtgKhSummESEQmj+nq3xaqArHq28VkKmg7iAKYyH2Dgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC97F22BE;
	Thu,  6 Mar 2025 16:57:46 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F5163F5A1;
	Thu,  6 Mar 2025 16:57:32 -0800 (PST)
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
Subject: [PATCH v3 06/15] irqchip/sunxi-nmi: Support Allwinner A523 NMI controller
Date: Fri,  7 Mar 2025 00:57:03 +0000
Message-ID: <20250307005712.16828-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250307005712.16828-1-andre.przywara@arm.com>
References: <20250307005712.16828-1-andre.przywara@arm.com>
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
longer applicable, so rename this to the more generic "data" on the way,
and move the existing offsets into a struct of its own.

Also add the respective Allwinner A523 compatible string, and set bit 31
in its enable mask, to add support for this SoC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/irqchip/irq-sunxi-nmi.c | 76 ++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 0b43121520243..b05904a147088 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -48,28 +48,38 @@ enum {
 	SUNXI_SRC_TYPE_EDGE_RISING,
 };
 
-struct sunxi_sc_nmi_reg_offs {
-	u32 ctrl;
-	u32 pend;
-	u32 enable;
+struct sunxi_sc_nmi_data {
+	struct {
+		u32 ctrl;
+		u32 pend;
+		u32 enable;
+	} reg_offs;
+	u32 enable_val;
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
-	.ctrl	= SUN6I_NMI_CTRL,
-	.pend	= SUN6I_NMI_PENDING,
-	.enable	= SUN6I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun6i_data __initconst = {
+	.reg_offs.ctrl		= SUN6I_NMI_CTRL,
+	.reg_offs.pend		= SUN6I_NMI_PENDING,
+	.reg_offs.enable	= SUN6I_NMI_ENABLE,
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun7i_reg_offs __initconst = {
-	.ctrl	= SUN7I_NMI_CTRL,
-	.pend	= SUN7I_NMI_PENDING,
-	.enable	= SUN7I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun7i_data __initconst = {
+	.reg_offs.ctrl		= SUN7I_NMI_CTRL,
+	.reg_offs.pend		= SUN7I_NMI_PENDING,
+	.reg_offs.enable	= SUN7I_NMI_ENABLE,
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst = {
-	.ctrl	= SUN9I_NMI_CTRL,
-	.pend	= SUN9I_NMI_PENDING,
-	.enable	= SUN9I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun9i_data __initconst = {
+	.reg_offs.ctrl		= SUN9I_NMI_CTRL,
+	.reg_offs.pend		= SUN9I_NMI_PENDING,
+	.reg_offs.enable	= SUN9I_NMI_ENABLE,
+};
+
+static const struct sunxi_sc_nmi_data sun55i_a523_data __initconst = {
+	.reg_offs.ctrl		= SUN9I_NMI_CTRL,
+	.reg_offs.pend		= SUN9I_NMI_PENDING,
+	.reg_offs.enable	= SUN9I_NMI_ENABLE,
+	.enable_val		= BIT(31),
 };
 
 static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
@@ -143,7 +153,7 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 }
 
 static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
-					const struct sunxi_sc_nmi_reg_offs *reg_offs)
+					const struct sunxi_sc_nmi_data *data)
 {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
@@ -186,27 +196,28 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
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
+	gc->chip_types[0].regs.ack		= data->reg_offs.pend;
+	gc->chip_types[0].regs.mask		= data->reg_offs.enable;
+	gc->chip_types[0].regs.type		= data->reg_offs.ctrl;
 
 	gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
 	gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[1].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[1].regs.ack		= reg_offs->pend;
-	gc->chip_types[1].regs.mask		= reg_offs->enable;
-	gc->chip_types[1].regs.type		= reg_offs->ctrl;
+	gc->chip_types[1].regs.ack		= data->reg_offs.pend;
+	gc->chip_types[1].regs.mask		= data->reg_offs.enable;
+	gc->chip_types[1].regs.type		= data->reg_offs.ctrl;
 	gc->chip_types[1].handler		= handle_edge_irq;
 
 	/* Disable any active interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
+	sunxi_sc_nmi_write(gc, data->reg_offs.enable, data->enable_val);
 
 	/* Clear any pending NMI interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->pend, SUNXI_NMI_IRQ_BIT);
+	sunxi_sc_nmi_write(gc, data->reg_offs.pend, SUNXI_NMI_IRQ_BIT);
 
 	irq_set_chained_handler_and_data(irq, sunxi_sc_nmi_handle_irq, domain);
 
@@ -221,20 +232,27 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
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



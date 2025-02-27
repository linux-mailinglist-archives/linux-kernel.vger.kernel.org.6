Return-Path: <linux-kernel+bounces-537259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B76A489C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8673B6670
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90B4270ED0;
	Thu, 27 Feb 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q/XU5a3A"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4C1C07E6;
	Thu, 27 Feb 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687757; cv=none; b=FZY7wJXrSvkuV6ZiBB7ljgdGFpuWdp9cv0BcMa5XhtVP0gwVZCXXk4pHSVavkLNaHLOWgJi1Nz5czgAY0MZp4CkIDGKXC+QvmdqMT0G9893jsnU2Ngcr76xVWYv2qUd8t+FbdlL3c+Yjb6evJKNsTg8OKqh72U4Tiu9NI6nXPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687757; c=relaxed/simple;
	bh=rbhrWLfbN/iHDAYvkA4DqppkfImUOQhKqaMxftZUO7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpgOEevnX3IGIXwN52jEI+D9tAFPwxO2zHOnQesOaXMOFwvovhEqgZiRzzCVtCg6ArcsgsKFrq08oAHopo8adGMbGR/a+xrJRP1qzEqoZpTsnR3/eyUX54KM9WEWCKgs2rWD/i8Zv1PV+R/YTR2kF+bW7UcwwxjD5JCapG8OR6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q/XU5a3A; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RKMDjO1958096
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Feb 2025 14:22:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740687733;
	bh=PvY8vqo+Sc7xLnuOcR8UDu8sTGqEi/shKhEi3DC002g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=q/XU5a3AmyilaV1602p6MrTg6bN2DR1roc1TCzfaB0dA88ceGKvCU4wLqAX42Sk5m
	 GYNYm7gYuxMdwPw1/8UqIySCpTO4N6C2Z7SyCc+7gBAu7Oui17uljvTfrNr4Ls4mRV
	 KiljherOxdkmXLjHAKluERCURPIhJQ1rngfMybIM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RKMDws125061;
	Thu, 27 Feb 2025 14:22:13 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 14:22:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 14:22:12 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RKMCls066416;
	Thu, 27 Feb 2025 14:22:12 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <c-vankar@ti.com>
Subject: [RFC PATCH 2/2] mux: mmio: Extend mmio-mux driver to configure mux with new DT property
Date: Fri, 28 Feb 2025 01:52:06 +0530
Message-ID: <20250227202206.2551305-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227202206.2551305-1-c-vankar@ti.com>
References: <20250227202206.2551305-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

MMIO mux driver is designed to parse "mux-reg-masks" and "idle-states"
property independently to configure mux registers. Drawback of this
approach is, while configuring mux-controller one need to specify every
register of memory space with offset and mask in "mux-reg-masks" and
register state to "idle-states", that would be more complex for devices
with large memory space.

Add support to extend the mmio mux driver to configure a specific register
or set of register in memory space.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/mux/mmio.c | 148 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 122 insertions(+), 26 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 30a952c34365..8937d0ea2b11 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -2,7 +2,7 @@
 /*
  * MMIO register bitfield-controlled multiplexer driver
  *
- * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
+ * Copyright (C) 2017-2025 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
  */
 
 #include <linux/bitops.h>
@@ -33,10 +33,84 @@ static const struct of_device_id mux_mmio_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids);
 
+static int reg_mux_get_controllers(const struct device_node *np, char *prop_name)
+{
+	int ret;
+
+	ret = of_property_count_u32_elems(np, prop_name);
+	if (ret == 0 || ret % 2)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static int reg_mux_get_controllers_extended(const struct device_node *np, char *prop_name)
+{
+	int ret;
+
+	ret = of_property_count_u32_elems(np, prop_name);
+	if (ret == 0 || ret % 3)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static int reg_mux_parse_dt(const struct device_node *np, bool *mux_reg_masks_state,
+			    int *num_fields)
+{
+	int ret;
+
+	if (*mux_reg_masks_state) {
+		ret = reg_mux_get_controllers_extended(np, "mux-reg-masks-state");
+		if (ret < 0)
+			return ret;
+		*num_fields = ret / 3;
+	} else {
+		ret = reg_mux_get_controllers(np, "mux-reg-masks");
+		if (ret < 0)
+			return ret;
+		*num_fields = ret / 2;
+	}
+	return ret;
+}
+
+static int mux_reg_set_parameters(const struct device_node *np, char *prop_name, u32 *reg,
+				  u32 *mask, int index)
+{
+	int ret;
+
+	ret = of_property_read_u32_index(np, prop_name,
+					 2 * index, reg);
+	if (!ret)
+		ret = of_property_read_u32_index(np, prop_name,
+						 2 * index + 1, mask);
+
+	return ret;
+}
+
+static int mux_reg_set_parameters_extended(const struct device_node *np, char *prop_name, u32 *reg,
+					   u32 *mask, u32 *state, int index)
+{
+	int ret;
+
+	ret = of_property_read_u32_index(np, prop_name,
+					 3 * index, reg);
+	if (!ret) {
+		ret = of_property_read_u32_index(np, prop_name,
+						 3 * index + 1, mask);
+		if (!ret)
+			ret = of_property_read_u32_index(np, prop_name,
+							 3 * index + 2, state);
+	}
+
+	return ret;
+}
+
 static int mux_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	bool mux_reg_masks_state = false;
 	struct regmap_field **fields;
 	struct mux_chip *mux_chip;
 	struct regmap *regmap;
@@ -59,15 +133,19 @@ static int mux_mmio_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "failed to get regmap\n");
 
-	ret = of_property_count_u32_elems(np, "mux-reg-masks");
-	if (ret == 0 || ret % 2)
-		ret = -EINVAL;
+	if (of_property_present(np, "mux-reg-masks-state"))
+		mux_reg_masks_state = true;
+
+	ret = reg_mux_parse_dt(np, &mux_reg_masks_state, &num_fields);
 	if (ret < 0) {
-		dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
-			ret);
+		if (mux_reg_masks_state)
+			dev_err(dev, "mux-reg-masks-state property missing or invalid: %d\n",
+				ret);
+		else
+			dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
+				ret);
 		return ret;
 	}
-	num_fields = ret / 2;
 
 	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
 				       sizeof(*fields));
@@ -79,19 +157,25 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	for (i = 0; i < num_fields; i++) {
 		struct mux_control *mux = &mux_chip->mux[i];
 		struct reg_field field;
-		s32 idle_state = MUX_IDLE_AS_IS;
+		s32 state, idle_state = MUX_IDLE_AS_IS;
 		u32 reg, mask;
 		int bits;
 
-		ret = of_property_read_u32_index(np, "mux-reg-masks",
-						 2 * i, &reg);
-		if (!ret)
-			ret = of_property_read_u32_index(np, "mux-reg-masks",
-							 2 * i + 1, &mask);
-		if (ret < 0) {
-			dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
-				i, ret);
-			return ret;
+		if (!mux_reg_masks_state) {
+			ret = mux_reg_set_parameters(np, "mux-reg-masks", &reg, &mask, i);
+			if (ret < 0) {
+				dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
+					i, ret);
+				return ret;
+			}
+		} else {
+			ret = mux_reg_set_parameters_extended(np, "mux-reg-masks-state", &reg,
+							      &mask, &state, i);
+			if (ret < 0) {
+				dev_err(dev, "bitfield %d: failed to read custom-states property: %d\n",
+					i, ret);
+				return ret;
+			}
 		}
 
 		field.reg = reg;
@@ -115,16 +199,28 @@ static int mux_mmio_probe(struct platform_device *pdev)
 		bits = 1 + field.msb - field.lsb;
 		mux->states = 1 << bits;
 
-		of_property_read_u32_index(np, "idle-states", i,
-					   (u32 *)&idle_state);
-		if (idle_state != MUX_IDLE_AS_IS) {
-			if (idle_state < 0 || idle_state >= mux->states) {
-				dev_err(dev, "bitfield: %d: out of range idle state %d\n",
-					i, idle_state);
-				return -EINVAL;
+		if (!mux_reg_masks_state) {
+			of_property_read_u32_index(np, "idle-states", i,
+						   (u32 *)&idle_state);
+			if (idle_state != MUX_IDLE_AS_IS) {
+				if (idle_state < 0 || idle_state >= mux->states) {
+					dev_err(dev, "bitfield: %d: out of range idle state %d\n",
+						i, idle_state);
+					return -EINVAL;
+				}
+
+				mux->idle_state = idle_state;
+			}
+		} else {
+			if (state != MUX_IDLE_AS_IS) {
+				if (state < 0 || state >= mux->states) {
+					dev_err(dev, "bitfield: %d: out of range idle state %d\n",
+						i, state);
+					return -EINVAL;
+				}
+
+				mux->idle_state = state;
 			}
-
-			mux->idle_state = idle_state;
 		}
 	}
 
-- 
2.34.1



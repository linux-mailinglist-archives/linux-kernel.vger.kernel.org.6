Return-Path: <linux-kernel+bounces-543819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C3A4DA4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E147716BB94
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6D1FFC74;
	Tue,  4 Mar 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iehOss9Y"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F41FFC48;
	Tue,  4 Mar 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083804; cv=none; b=tNk/8DUCQ9YKWeHJbUF9hAOr/aqXElzHBSpasN4qhJ/y2U280r1FcCbXJ4lSrZ6gUMu8012KRqq0G5hLDMZFV/LIGAvvbJ1huJJwpgepQWq65wxd52q/oc3/Vy6/hlHpMrdJ3I6ORwZMAbdahFo3WPHWNGGLRJdOqbCsidz3k/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083804; c=relaxed/simple;
	bh=tWESoQmUKjqJatR0UQ7XkYBJbE1qLLYMOf3E9UUsLdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6RHi2quUJMSREQdwijyRjQzafntm8INZLDkmWvcd82AhPLPZGoKwx6mRHim4ahXMUb9IVHX61aDezpEax6Yfh5JHthZWO1zeoZinnfuE2XXs4VHv+VsvTVNDqS3MP5l0ES++Lcn5VN8byEYex8b4LXba3gCSSQRMlMo5psZMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iehOss9Y; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524ANCOf3566948
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 04:23:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741083793;
	bh=FQjjI3qiDDpnex1JzGR5pZ/NsK/GrJhAy79gC5a5LLM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iehOss9Y3jTbtoj8w6Zdup68n//OZezJrSSzBey4+RKXqzhlMs3G33JNp+7I+eXxr
	 LhcbLFCQPJaOsBdItomVANts0Ae8Sa8jQKJgWVnaSQzUkH5rr3wOVe2CvB2T4U5UTj
	 aVP/+s5wLOtba85lcNfg6+SZLbgrWKmaEZkf0QPs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524ANChE016109
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 04:23:12 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 04:23:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 04:23:12 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524ANBFH061987;
	Tue, 4 Mar 2025 04:23:12 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Chintan Vankar
	<c-vankar@ti.com>
Subject: [RFC PATCH v2 2/2] mux: mmio: Extend mmio-mux driver to configure mux with new DT property
Date: Tue, 4 Mar 2025 15:53:06 +0530
Message-ID: <20250304102306.2977836-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304102306.2977836-1-c-vankar@ti.com>
References: <20250304102306.2977836-1-c-vankar@ti.com>
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

Link to v1:
https://lore.kernel.org/r/20250227202206.2551305-3-c-vankar@ti.com/

Changes from v1 to v2:
- Modified driver changes as pointed out by Andrew Davis.

 drivers/mux/mmio.c | 144 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 118 insertions(+), 26 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 30a952c34365..7253e6305ab8 100644
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
@@ -33,10 +33,83 @@ static const struct of_device_id mux_mmio_dt_ids[] = {
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
+	if (of_property_present(np, "mux-reg-masks-state")) {
+		*mux_reg_masks_state = true;
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
+	ret = of_property_read_u32_index(np, prop_name, 2 * index, reg);
+	if (!ret)
+		ret = of_property_read_u32_index(np, prop_name, 2 * index + 1, mask);
+
+	return ret;
+}
+
+static int mux_reg_set_parameters_extended(const struct device_node *np, char *prop_name, u32 *reg,
+					   u32 *mask, u32 *state, int index)
+{
+	int ret;
+
+	ret = of_property_read_u32_index(np, prop_name, 3 * index, reg);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u32_index(np, prop_name, 3 * index + 1, mask);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u32_index(np, prop_name, 3 * index + 2, state);
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
@@ -59,15 +132,16 @@ static int mux_mmio_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "failed to get regmap\n");
 
-	ret = of_property_count_u32_elems(np, "mux-reg-masks");
-	if (ret == 0 || ret % 2)
-		ret = -EINVAL;
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
@@ -79,19 +153,25 @@ static int mux_mmio_probe(struct platform_device *pdev)
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
@@ -115,16 +195,28 @@ static int mux_mmio_probe(struct platform_device *pdev)
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



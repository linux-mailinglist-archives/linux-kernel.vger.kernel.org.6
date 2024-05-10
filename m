Return-Path: <linux-kernel+bounces-175763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54C8C248D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07251C219BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC6171E4A;
	Fri, 10 May 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="R/4RG5DX"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F816F296;
	Fri, 10 May 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342818; cv=none; b=q4OZFfNVzDepReH4TpSbQfw7Q8pZXUrpIFG5u8MEgr7+uxPKrG8rNBWAkziCOpRSKw2BFMqC6BbDtX7EyQ+lwTckJ3R/OvazDeWfnsUrFl8FdcXFbaXFEUt6NnDSWdFbzmHD4H0hM44Qvmtt3i3P6RGk8fdV85afcDAy2HQsCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342818; c=relaxed/simple;
	bh=g4vwY7Rm39oLvhxj4PQq6HqNHGET+DLV/YkHzXIxdHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6bEMNhPBODdrpWtV3oVyPFHpzPvMAwJZrD8vEIn7Ftvw+N8WjV/Fake+Pv0YfywJnGoU2aKAikO75zUU208P9Hzk6WNky5uYDISimfwseR3ZkoRvravxXvVm3YLe2vG/wvQlnU9nlxqDZyP0PnYswbS+8RlTe+6d5gQdg+rRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=R/4RG5DX; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715342807;
	bh=kaxYcbrb/9Pnuq7HbvF6NNsDEjH/9/v3t51VOdwTq+s=; l=3451;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=R/4RG5DX87sAnovzHbiNuoNjR7l4h77JzrCqhUOLrcQLNyYOJhTUh61ZHTJRm7ABt
	 C2l1kPubmfUsqY87rZSfobdlPey8j7/zV38R0YWUvKRhT0/V4cp4eb+d4IPE3p4PfI
	 UAu9uVHAuFEhVZBMFCHxexMrWQp1HuILQjHKVIBmxFU3a1dMvCBjM33pPwr16oun3B
	 aq2iPnxrzWvSiFJ8sPyT9qp92frVNzL9hazZ/JUna3nJfdtC6MY3idOAE9j6CG9o/M
	 zSU9yQzutV3mXayvOb2WOL/HxWSNbbnJvYCECrT4otFlucgZhrwhe/A/46QgyHa151
	 PJVnKNp4PVYAg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213204:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:06:33 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:06:33 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:06:33 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v3 5/6] regulator: rtq2208: Fix LDO to be compatible with both fixed and adjustable vout
Date: Fri, 10 May 2024 20:06:24 +0800
Message-ID: <ed344f9e3b9a87e6f14fa6b1c061687d4c97240a.1715340537.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1715340537.git.alina_yu@richtek.com>
References: <cover.1715340537.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In this patch, LDO's adjustable and fixed Vout settings are compatible.
The LDO Vout ability depends on "richtek,fixed-microvolt".
If adjustable, the Vout can be set to either 1800mV or 3300mV.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
v3
- Add "richtek,fixed-microvolt" to specify LDO fixed voltage
- Check specified desc->fixed_uV matches with constraints->min_uV and constraints->max_uV
---
 drivers/regulator/rtq2208-regulator.c | 43 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 2e9387f..c2c1689 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -219,7 +219,7 @@ static const struct regulator_ops rtq2208_regulator_buck_ops = {
 	.set_suspend_mode = rtq2208_set_suspend_mode,
 };
 
-static const struct regulator_ops rtq2208_regulator_ldo_ops = {
+static const struct regulator_ops rtq2208_regulator_ldo_fix_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -228,6 +228,23 @@ static const struct regulator_ops rtq2208_regulator_ldo_ops = {
 	.set_suspend_disable = rtq2208_set_suspend_disable,
 };
 
+static const struct regulator_ops rtq2208_regulator_ldo_adj_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_suspend_enable = rtq2208_set_suspend_enable,
+	.set_suspend_disable = rtq2208_set_suspend_disable,
+};
+
+static const unsigned int rtq2208_ldo_volt_table[] = {
+	1800000,
+	3300000,
+};
+
 static struct of_regulator_match rtq2208_ldo_match[] = {
 	{.name = "ldo2", },
 	{.name = "ldo1", },
@@ -358,8 +375,9 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 {
 	struct device_node *np;
 	struct of_regulator_match *match;
-	struct rtq2208_regulator_desc *rdesc;
+	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
+	u32 fixed_uV;
 	int ret, i;
 
 	if (!dev->of_node)
@@ -379,13 +397,26 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(rtq2208_ldo_match); i++) {
 		match = rtq2208_ldo_match + i;
 		init_data = match->init_data;
-		rdesc = (struct rtq2208_regulator_desc *)match->driver_data;
+		desc = (struct regulator_desc *)match->desc;
 
-		if (!init_data || !rdesc)
+		if (!init_data || !desc)
 			continue;
 
-		if (init_data->constraints.min_uV == init_data->constraints.max_uV)
-			rdesc->desc.fixed_uV = init_data->constraints.min_uV;
+		/* specify working fixed voltage if the propery exists */
+		ret = of_property_read_u32(match->of_node, "richtek,fixed-microvolt", &fixed_uV);
+
+		if (!ret) {
+			if (fixed_uV != init_data->constraints.min_uV ||
+				fixed_uV != init_data->constraints.max_uV)
+				return -EINVAL;
+			desc->n_voltages = 1;
+			desc->fixed_uV = fixed_uV;
+			desc->ops = &rtq2208_regulator_ldo_fix_ops;
+		} else {
+			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
+			desc->volt_table = rtq2208_ldo_volt_table;
+			desc->ops = &rtq2208_regulator_ldo_adj_ops;
+		}
 	}
 
 	return 0;
-- 
2.7.4



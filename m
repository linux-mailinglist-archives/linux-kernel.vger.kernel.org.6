Return-Path: <linux-kernel+bounces-191794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EED8D1427
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BFB28226B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790D6F06E;
	Tue, 28 May 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="O0KrTrko"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E845014;
	Tue, 28 May 2024 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876095; cv=none; b=bysnd7RIgzEhUKvvt0XjHP+OO7N95eHsf+SYd5HvPcZ8pmKEKiQty7bnvpKoxZRs+SisKh3Gebv2okI6pWlVN4RhgKwZbQd2YVd/p4LwhkIQm9gOcH3wzwzFXqdggT5XUkuZPiTuByp0dqh75kMdU1G7miQSuFM9xbDcx7vdy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876095; c=relaxed/simple;
	bh=DCLWuz22A6LRbeXJ1nSq7JvGq1P/7r60FFqxWbn65g0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM8Yfp+4wJsq/6ksNvvJGssYGsnJDKqXYotpoE6eP0ohAEamVvis5c0WbXh93+sk5iXdWSaH4BQ1tHRu8aZq6gznHAXLLpAFgGIKqmgk4f1Xd+jIZaFvO+GnhMEmRIL9VBhP1lVlUJCoHurGaFQlg9ZgsCOmGLwW07OIg46JMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=O0KrTrko; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716876089;
	bh=tc82T5HcbQCEAfjp1FVhza6BdbP3ax5H8YaEorOdQi4=; l=3117;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=O0KrTrkoZhkLmW17gxBTjTHgxswnH327n7kwVx34Z2B96adJEZA9iSNEJwJfg333V
	 qnz9mGSqF5RCeQPJtLxnB6au1w3KZVD8A797TxOfzKE4PV6czRjICAax+IJceqw/Mb
	 5p1wVqyt128t7qoL+2kP3rg3d63n5vK7zSCYt+4H/XsLVPF/ndrhBH5WAzBWsUnLnN
	 qOGwkgEvS7cYTpwoad6Ryyu8CD3MRqGm/OOxKbRdhLaYm/9KA6KeIMHnnuDMQa+/QY
	 idvkOoh6PkoA39WxlAh3Nw5AbB7AR1U14PCF+hk4jOnXUO5JJKOuowTTxvW6VHhgI8
	 HOr8vJdrefXqA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213211:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 28 May 2024 14:01:21 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 14:01:20 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 14:01:20 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [RESEND 2/4] regulator: rtq2208: Fix LDO to be compatible with both fixed and adjustable vout
Date: Tue, 28 May 2024 14:01:14 +0800
Message-ID: <5ad4c7728c7fa7f6286db36b99d31c9d0f5d16c7.1716870419.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1716870419.git.alina_yu@richtek.com>
References: <cover.1716870419.git.alina_yu@richtek.com>
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
 drivers/regulator/rtq2208-regulator.c | 37 +++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index c31b6dc..f6afa4e 100644
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
@@ -331,7 +348,7 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 {
 	struct device_node *np;
 	struct of_regulator_match *match;
-	struct rtq2208_regulator_desc *rdesc;
+	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
 	int ret, i;
 
@@ -352,13 +369,21 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
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
+		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
+			desc->fixed_uV = init_data->constraints.min_uV;
+			desc->n_voltages = 1;
+			desc->fixed_uV = init_data->constraints.min_uV;
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



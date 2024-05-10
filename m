Return-Path: <linux-kernel+bounces-175760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB08C2487
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D247C1C244C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE017089C;
	Fri, 10 May 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Fmpp/4qf"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907916F828;
	Fri, 10 May 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342816; cv=none; b=UvmLQHqDtNwwrSVooVomqcP2HU3cS5bK0etNGr/L9O6vgbNa7vPtgnrOoZ5bkmr5IIcJ/paoJVL4Y4UwZdWtbykvtMFTF1bcg47JreQ/E0/+GhGuAI5XPK0LBjEZ58ok4UQv1LHbfnk1Lfv64o86gEsmIlXwSix6J/SgLZk5tIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342816; c=relaxed/simple;
	bh=ugfhxS6NfouHW0TkE1Zbx397Zm/0WaEpbf+orXPTHU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovA9l2l1mANP7tXFyDbJQaphPU+ec3GRRCT3cGATXfEWNlGZh6L7s3IX6XYs7jJPnfkKDtN6crrd6Trrtb9YQRhwn9arMapc1W91EcThi1WM8DHfxulT0QuXzK9qICO/0BTzmWTnFOMgUJDL8rsxNectdaZLf2B76FoucEWNBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Fmpp/4qf; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715342804;
	bh=CGiHV5oBAFTeIyuaYGSoPD1MsyxRCD2d/PDCN6B6NUE=; l=3946;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Fmpp/4qfpzEimJFNaGfsscGnfi5k7jIK64N0I8rApN/I4sd6a3iDAgVrerphlTu9q
	 jRxmp0HXI+ydad3u8R9SJZQ5tmgJnmFxOyoB9fL8129Y7XppmndgZpBcdRB8LyuO7J
	 2qrtQ0jmHR/GDLx0nwM+e4vtZAJPfGys5piRI+gswOtIcVmz+3x/qv5gVS8s7T3cw/
	 J/dqOw2KusMdzPWckwAlBMJ04zrEBKYofHHE/rv9Msr07EDdAMtifyGxbrb+E+wS1t
	 GGi6xtr15x3mzdDsRzAV0Qbw/ksu/WgeWuuQfQgu4EuNU1FNM7kkEVVCB1TJ6XtHxp
	 o3YVTJEicXnRQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213203:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:06:30 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:06:29 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:06:29 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v3 1/6] regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called
Date: Fri, 10 May 2024 20:06:20 +0800
Message-ID: <636cbe817ad61a18f291b5ec8938e79043b8a646.1715340537.git.alina_yu@richtek.com>
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

In this patch, a software bug has been fixed.
rtq2208_ldo_match is no longer a local variable.
It prevents invalid memory access when devm_of_regulator_put_matches
 is called.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
v3
- Move Fixes to the start of the series
---
 drivers/regulator/rtq2208-regulator.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 2d54844..dfa293a 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -224,6 +224,11 @@ static const struct regulator_ops rtq2208_regulator_ldo_ops = {
 	.set_suspend_disable = rtq2208_set_suspend_disable,
 };
 
+static struct of_regulator_match rtq2208_ldo_match[] = {
+	{.name = "ldo2", },
+	{.name = "ldo1", },
+};
+
 static unsigned int rtq2208_of_map_mode(unsigned int mode)
 {
 	switch (mode) {
@@ -335,8 +340,7 @@ static const struct linear_range rtq2208_vout_range[] = {
 	REGULATOR_LINEAR_RANGE(1310000, 181, 255, 10000),
 };
 
-static int rtq2208_of_get_fixed_voltage(struct device *dev,
-					struct of_regulator_match *rtq2208_ldo_match, int n_fixed)
+static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 {
 	struct device_node *np;
 	struct of_regulator_match *match;
@@ -351,14 +355,14 @@ static int rtq2208_of_get_fixed_voltage(struct device *dev,
 	if (!np)
 		np = dev->of_node;
 
-	ret = of_regulator_match(dev, np, rtq2208_ldo_match, n_fixed);
+	ret = of_regulator_match(dev, np, rtq2208_ldo_match, ARRAY_SIZE(rtq2208_ldo_match));
 
 	of_node_put(np);
 
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < n_fixed; i++) {
+	for (i = 0; i < ARRAY_SIZE(rtq2208_ldo_match); i++) {
 		match = rtq2208_ldo_match + i;
 		init_data = match->init_data;
 		rdesc = (struct rtq2208_regulator_desc *)match->driver_data;
@@ -373,8 +377,7 @@ static int rtq2208_of_get_fixed_voltage(struct device *dev,
 	return 0;
 }
 
-static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel,
-					int idx, struct of_regulator_match *rtq2208_ldo_match, int *ldo_idx)
+static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel, int idx)
 {
 	struct regulator_desc *desc;
 	static const struct {
@@ -432,10 +435,6 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 		desc->n_voltages = 1;
 		desc->active_discharge_reg = LDO_RG_SHIFT(curr_info->base, 2);
 
-		rtq2208_ldo_match[*ldo_idx].name = desc->name;
-		rtq2208_ldo_match[*ldo_idx].driver_data = rdesc;
-		rtq2208_ldo_match[(*ldo_idx)++].desc = desc;
-
 		rdesc->suspend_config_reg = curr_info->base;
 		rdesc->suspend_enable_mask = RTQ2208_LDO_EN_STR_MASK;
 	}
@@ -444,8 +443,7 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *regulator_idx_table,
 		struct rtq2208_regulator_desc *rdesc[RTQ2208_LDO_MAX], struct device *dev)
 {
-	struct of_regulator_match rtq2208_ldo_match[2];
-	int mtp_sel, ret, i, idx, ldo_idx = 0;
+	int mtp_sel, i, idx, ret;
 
 	/* get mtp_sel0 or mtp_sel1 */
 	mtp_sel = device_property_read_bool(dev, "richtek,mtp-sel-high");
@@ -457,11 +455,15 @@ static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *
 		if (!rdesc[i])
 			return -ENOMEM;
 
-		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx, rtq2208_ldo_match, &ldo_idx);
+		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx);
+
+		/* init ldo dvs ability */
+		if (idx >= RTQ2208_LDO2)
+			rtq2208_ldo_match[idx - RTQ2208_LDO2].desc = &rdesc[i]->desc;
 	}
 
 	/* init ldo fixed_uV */
-	ret = rtq2208_of_get_fixed_voltage(dev, rtq2208_ldo_match, ldo_idx);
+	ret = rtq2208_of_get_ldo_dvs_ability(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get ldo fixed_uV\n");
 
-- 
2.7.4



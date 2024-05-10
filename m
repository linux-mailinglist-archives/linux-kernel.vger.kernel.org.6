Return-Path: <linux-kernel+bounces-175761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC088C2489
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038F71F2630C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D4B1708BE;
	Fri, 10 May 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="uEsUTIqh"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518716F833;
	Fri, 10 May 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342817; cv=none; b=LwNCNCHwAVdq7pynbcZ/bMeGgoj98dnyoLhOfaoA5wUOnZjl4s742IIKGmZdGWuTaBdJTtI8Fypo2udZJ1D6Man3l9NgQHUDRPLIXZfh65UXkzjIhoLStGlssXUwkmgkhH9LjgNualAvdOiz8UdDmhu1uk8YUaL4DWrCQ90nXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342817; c=relaxed/simple;
	bh=SodOLMEczseNnZ3JbfHd9iSXYjJP7Qfm0BowqUDFc00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqxaQ4HMGoULv6NQ1ueE4RxNEO8xyaI6XAyY3IVRVmtmIxloV2w3BW27TsLz7RYyzTSF6dKWbgfZeIEEW/kVgJCrDCkEJYeUNRvGZlCnHRbVgwJZU/k9+vJPLHTOde8gMO56F7Xek9O1kj+Cv672f3ka+ArflQ8MTJPgyYGNbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=uEsUTIqh; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715342805;
	bh=gh5Lh7Hg/rcjFCRbEYF4ksiO92kWgeeyLMZW4KpRyc4=; l=4370;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=uEsUTIqhzYgzYo2wMa9KXU1+2jAOZV2M9CEgNkqS6D2hti44nrrmawdoeEpM48TYp
	 ULakRfDRYF3CGrtaW1HHX9mZZwrTK5GTrlBClYeoXJm1iLC9SX0b/GtQEMIi4DYbRK
	 lbaHJTJ6iqKs/zv7gonBU7f7Gdki/zdsdOD0BmHXEzughsgDf8mBfXYf/GU/quWDMw
	 38Y+TG3mlRcdnpQ0W5LOX9h5WujaLk8wj/Q6WvHhbqnW5+Xahi5ebin+4H2x8at34t
	 bcNdOvBQm7bV2avtNMI7+P2cS80AyVJ0GZUrQooXwfop8musI/VGBdsAwow6P91Nsh
	 DJ6wtZZ0k1w2Q==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213196:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:06:31 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:06:30 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:06:30 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v3 2/6] regulator: rtq2208: Fix LDO vsel setting
Date: Fri, 10 May 2024 20:06:21 +0800
Message-ID: <4886c4fdf645433ce436708479fd0375db0838dc.1715340537.git.alina_yu@richtek.com>
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

The LDO's Vout is adjustable if the hardware setting allows it,
 and it can be set either 1800mv or 3300mv.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
v3
- Seperate LDO vsel and discharge change to seperate patches
---
 drivers/regulator/rtq2208-regulator.c | 56 ++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index dfa293a..00da787 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -26,6 +26,7 @@
 #define RTQ2208_REG_BUCK_H_CFG0			0xA2
 #define RTQ2208_REG_LDO1_CFG			0xB1
 #define RTQ2208_REG_LDO2_CFG			0xC1
+#define RTQ2208_REG_LDO_DVS_CTRL		0xD0
 
 /* Mask */
 #define RTQ2208_BUCK_NR_MTP_SEL_MASK		GENMASK(7, 0)
@@ -40,6 +41,8 @@
 #define RTQ2208_EN_DIS_MASK			BIT(0)
 #define RTQ2208_BUCK_RAMP_SEL_MASK		GENMASK(2, 0)
 #define RTQ2208_HD_INT_MASK			BIT(0)
+#define RTQ2208_LDO1_VOSEL_SD_MASK		BIT(5)
+#define RTQ2208_LDO2_VOSEL_SD_MASK		BIT(7)
 
 /* Size */
 #define RTQ2208_VOUT_MAXNUM			256
@@ -323,14 +326,23 @@ static irqreturn_t rtq2208_irq_handler(int irqno, void *devid)
 	return IRQ_HANDLED;
 }
 
-#define RTQ2208_REGULATOR_INFO(_name, _base) \
-{ \
-	.name = #_name, \
-	.base = _base, \
+#define BUCK_INFO(_name, _id)						\
+{									\
+	.name = _name,							\
+	.base = RTQ2208_REG_BUCK_##_id##_CFG0,				\
+	.enable_reg = BUCK_RG_SHIFT(RTQ2208_REG_BUCK_##_id##_CFG0, 2),	\
+	.dis_reg = RTQ2208_REG_BUCK_##_id##_CFG0,			\
 }
-#define BUCK_RG_BASE(_id)	RTQ2208_REG_BUCK_##_id##_CFG0
+
+#define LDO_INFO(_name, _id)						\
+{									\
+	.name = _name,							\
+	.base = RTQ2208_REG_LDO##_id##_CFG,				\
+	.enable_reg = RTQ2208_REG_LDO##_id##_CFG,			\
+	.vsel_mask = RTQ2208_LDO##_id##_VOSEL_SD_MASK,			\
+}
+
 #define BUCK_RG_SHIFT(_base, _shift)	(_base + _shift)
-#define LDO_RG_BASE(_id)	RTQ2208_REG_LDO##_id##_CFG
 #define LDO_RG_SHIFT(_base, _shift)	(_base + _shift)
 #define	VSEL_SHIFT(_sel)	(_sel ? 3 : 1)
 #define MTP_SEL_MASK(_sel)	RTQ2208_BUCK_EN_NR_MTP_SEL##_sel##_MASK
@@ -383,17 +395,22 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 	static const struct {
 		char *name;
 		int base;
+		int enable_reg;
+		int dis_reg;
+		int dis_mask;
+		int dis_on;
+		int vsel_mask;
 	} regulator_info[] = {
-		RTQ2208_REGULATOR_INFO(buck-b, BUCK_RG_BASE(B)),
-		RTQ2208_REGULATOR_INFO(buck-c, BUCK_RG_BASE(C)),
-		RTQ2208_REGULATOR_INFO(buck-d, BUCK_RG_BASE(D)),
-		RTQ2208_REGULATOR_INFO(buck-a, BUCK_RG_BASE(A)),
-		RTQ2208_REGULATOR_INFO(buck-f, BUCK_RG_BASE(F)),
-		RTQ2208_REGULATOR_INFO(buck-g, BUCK_RG_BASE(G)),
-		RTQ2208_REGULATOR_INFO(buck-h, BUCK_RG_BASE(H)),
-		RTQ2208_REGULATOR_INFO(buck-e, BUCK_RG_BASE(E)),
-		RTQ2208_REGULATOR_INFO(ldo2, LDO_RG_BASE(2)),
-		RTQ2208_REGULATOR_INFO(ldo1, LDO_RG_BASE(1)),
+		BUCK_INFO("buck-b", B),
+		BUCK_INFO("buck-c", C),
+		BUCK_INFO("buck-d", D),
+		BUCK_INFO("buck-a", A),
+		BUCK_INFO("buck-f", F),
+		BUCK_INFO("buck-g", G),
+		BUCK_INFO("buck-h", H),
+		BUCK_INFO("buck-e", E),
+		LDO_INFO("ldo2", 2),
+		LDO_INFO("ldo1", 1),
 	}, *curr_info;
 
 	curr_info = regulator_info + idx;
@@ -408,12 +425,12 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 	desc->active_discharge_on = RTQ2208_EN_DIS_MASK;
 	desc->active_discharge_off = 0;
 	desc->active_discharge_mask = RTQ2208_EN_DIS_MASK;
+	desc->enable_reg = curr_info->enable_reg;
 
 	rdesc->mode_mask = RTQ2208_BUCK_NRMODE_MASK;
 
 	if (idx >= RTQ2208_BUCK_B && idx <= RTQ2208_BUCK_E) {
 		/* init buck desc */
-		desc->enable_reg = BUCK_RG_SHIFT(curr_info->base, 2);
 		desc->ops = &rtq2208_regulator_buck_ops;
 		desc->vsel_reg = curr_info->base + VSEL_SHIFT(mtp_sel);
 		desc->vsel_mask = RTQ2208_BUCK_NR_MTP_SEL_MASK;
@@ -430,10 +447,9 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 		rdesc->suspend_mode_mask = RTQ2208_BUCK_STRMODE_MASK;
 	} else {
 		/* init ldo desc */
-		desc->enable_reg = curr_info->base;
-		desc->ops = &rtq2208_regulator_ldo_ops;
-		desc->n_voltages = 1;
 		desc->active_discharge_reg = LDO_RG_SHIFT(curr_info->base, 2);
+		desc->vsel_reg = RTQ2208_REG_LDO_DVS_CTRL;
+		desc->vsel_mask = curr_info->vsel_mask;
 
 		rdesc->suspend_config_reg = curr_info->base;
 		rdesc->suspend_enable_mask = RTQ2208_LDO_EN_STR_MASK;
-- 
2.7.4



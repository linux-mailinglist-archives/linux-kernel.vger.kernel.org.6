Return-Path: <linux-kernel+bounces-175758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB48C2485
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7032B24AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F8017084C;
	Fri, 10 May 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="ZjZZtOMr"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FDC14F12B;
	Fri, 10 May 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342815; cv=none; b=MhD0TH0ImTWH2e7AUmG/h0hGpfP6WrzdkOQAbg+g+zSjly8wjvno8HQdhn+Y3bk5QiLSDke/NfeAI4NpViUJh48e7iwYQgzznhci1UWEQmfyxQe3a5bSoLmdQh53WB5BmcCRByLK5jlXoptAUbs5G1bURsTsPNuwGPJNRrOVYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342815; c=relaxed/simple;
	bh=Tf5eDTSwc8EbTpl4ozjcwy7DapiyJLkYoTlSUSGDLcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PATEezTDTDCPlwoiTQ5oRGbh2d1iLNQCczpjJQc/6Ugb0/YaKX2yA0lfD0ZYHEUqapQAsQ06ywIHVhFFFMTxSBrhkc2aoYOAtC3+wZHSq1IfJB5NrxSEAwWjW4+F44y9H4fKvN9R7r40FhLcxg7sspVoxvLdFDFUiHJpgSD3AnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=ZjZZtOMr; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715342805;
	bh=SL/RjOhtIhnXMH6vwoa+9BEm372k7ntr2/TkWKgZrZ0=; l=3203;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZjZZtOMrJGNs69C5YeecOKXpjN71O96jx/btRZ1x4gphc55+YDlalB4LwwyxBAFYS
	 /2hasy+p3CP01XjflbDNMRUhJE58E37O1j0os80FTVcmr2LdmmOScjUS+7n+WPkSpO
	 FftNxL014T6zUHBbELdscVe1FxBml9h2QsfiYJdpriwj+YX+ac90mCU+P8Fdcde1Ls
	 Q/dqxMfawSz1o6aTR1Do+05I/V347gH81svKvs9hylDCc9hgEmS5f0079AdF3R8coL
	 jqDyjRB7Rv/2yijaFYXCNSSAB4ZdzKsfeFYXDdAvJD0VuYRFAHSyg0Fm2BFEHOZvVw
	 HU1l2pqWgRkpw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213201:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:06:32 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:06:31 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:06:31 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v3 3/6] regulator: rtq2208: Fix LDO discharge register
Date: Fri, 10 May 2024 20:06:22 +0800
Message-ID: <a1248141d114fbaf0ce7b1ffe37d3fe023b1478b.1715340537.git.alina_yu@richtek.com>
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

Since the discharge register has been moved to another position,
the modification is to fit the new register setting.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
v3
- Seperate LDO vsel and discharge change to seperate patches
---
 drivers/regulator/rtq2208-regulator.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 00da787..cea8e77 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -41,7 +41,9 @@
 #define RTQ2208_EN_DIS_MASK			BIT(0)
 #define RTQ2208_BUCK_RAMP_SEL_MASK		GENMASK(2, 0)
 #define RTQ2208_HD_INT_MASK			BIT(0)
+#define RTQ2208_LDO1_DISCHG_EN_MASK		BIT(4)
 #define RTQ2208_LDO1_VOSEL_SD_MASK		BIT(5)
+#define RTQ2208_LDO2_DISCHG_EN_MASK		BIT(6)
 #define RTQ2208_LDO2_VOSEL_SD_MASK		BIT(7)
 
 /* Size */
@@ -339,11 +341,12 @@ static irqreturn_t rtq2208_irq_handler(int irqno, void *devid)
 	.name = _name,							\
 	.base = RTQ2208_REG_LDO##_id##_CFG,				\
 	.enable_reg = RTQ2208_REG_LDO##_id##_CFG,			\
+	.dis_mask = RTQ2208_LDO##_id##_DISCHG_EN_MASK,			\
+	.dis_on = RTQ2208_LDO##_id##_DISCHG_EN_MASK,			\
 	.vsel_mask = RTQ2208_LDO##_id##_VOSEL_SD_MASK,			\
 }
 
 #define BUCK_RG_SHIFT(_base, _shift)	(_base + _shift)
-#define LDO_RG_SHIFT(_base, _shift)	(_base + _shift)
 #define	VSEL_SHIFT(_sel)	(_sel ? 3 : 1)
 #define MTP_SEL_MASK(_sel)	RTQ2208_BUCK_EN_NR_MTP_SEL##_sel##_MASK
 
@@ -422,9 +425,7 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 	desc->owner = THIS_MODULE;
 	desc->type = REGULATOR_VOLTAGE;
 	desc->enable_mask = mtp_sel ? MTP_SEL_MASK(1) : MTP_SEL_MASK(0);
-	desc->active_discharge_on = RTQ2208_EN_DIS_MASK;
 	desc->active_discharge_off = 0;
-	desc->active_discharge_mask = RTQ2208_EN_DIS_MASK;
 	desc->enable_reg = curr_info->enable_reg;
 
 	rdesc->mode_mask = RTQ2208_BUCK_NRMODE_MASK;
@@ -438,8 +439,10 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 		desc->linear_ranges = rtq2208_vout_range;
 		desc->n_linear_ranges = ARRAY_SIZE(rtq2208_vout_range);
 		desc->ramp_reg = BUCK_RG_SHIFT(curr_info->base, 5);
-		desc->active_discharge_reg = curr_info->base;
 		desc->of_map_mode = rtq2208_of_map_mode;
+		desc->active_discharge_reg = curr_info->dis_reg;
+		desc->active_discharge_on = RTQ2208_EN_DIS_MASK;
+		desc->active_discharge_mask = RTQ2208_EN_DIS_MASK;
 
 		rdesc->mode_reg = BUCK_RG_SHIFT(curr_info->base, 2);
 		rdesc->suspend_config_reg = BUCK_RG_SHIFT(curr_info->base, 4);
@@ -447,9 +450,11 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 		rdesc->suspend_mode_mask = RTQ2208_BUCK_STRMODE_MASK;
 	} else {
 		/* init ldo desc */
-		desc->active_discharge_reg = LDO_RG_SHIFT(curr_info->base, 2);
 		desc->vsel_reg = RTQ2208_REG_LDO_DVS_CTRL;
 		desc->vsel_mask = curr_info->vsel_mask;
+		desc->active_discharge_reg = RTQ2208_REG_LDO_DVS_CTRL;
+		desc->active_discharge_on = curr_info->dis_on;
+		desc->active_discharge_mask = curr_info->dis_mask;
 
 		rdesc->suspend_config_reg = curr_info->base;
 		rdesc->suspend_enable_mask = RTQ2208_LDO_EN_STR_MASK;
-- 
2.7.4



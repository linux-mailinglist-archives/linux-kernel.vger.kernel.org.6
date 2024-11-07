Return-Path: <linux-kernel+bounces-400122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2681D9C093E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6432A2842A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E79212EFB;
	Thu,  7 Nov 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CSGQtXNs"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCF20ADDC;
	Thu,  7 Nov 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990979; cv=none; b=KWKZmQO0ChsMoGX773msB1lyxPmNhXct8GVbTcETLZ1mO/8K942IetQhNA4CP8dFLckez8rPGVgDCOkKacYvvVK8x9e2ktlY4sHB9ms4rtvvSxXeakII6o6UnKPyiH2zmj0oQ1nkdZQck3QUZMTghc2F1zZ7wmhGTnW2yXX8U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990979; c=relaxed/simple;
	bh=Un0Z0EVKulk0a8oe9sLnWY/NfJ8AKEkZhLsX8V+gASE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGwCHUu5IH+/L6x3c7s0vi+1AI4cuRDbmrtpV4UgljTafm3hzObQ3mIH13B8/KBKAVnlowOS9tGKeEoufKPL/PkmxhpAqlUYu9zVMrgK5RtPuXdTp0ND52oVPh1iBLz4NxMcgn31CzAqtTH0pxX4Cd66Yf/2vNGo07VCtFm9eNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CSGQtXNs; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BK0ff001253;
	Thu, 7 Nov 2024 15:49:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	AV/+6bQSjKfamtobRHSLeM/m0DwhYt5ZKh5uq1zC2gA=; b=CSGQtXNs2pj3/Or3
	HZXsuabQdDsq20L9cQn+d53mAxvzYRWbKR0CqBKqr+LOW24KeKhbzZm0HT+Pdsxm
	10L1H+QH5MJx2zC6TeVZpCGZGxBBx70v/hXLJ9E7FeJ15gUZfYYy0F8PgyYmRcSi
	Td9dAIZB0RJ802BrrZTf7fFu6emnDJsS+hXZ4bUZaPOJL3zq9/+yVYRSywP8KOr7
	3PMNp1MPa9UbfE+8R3Zm4v7NaAB/10SQOpBquCcwsiekLu5ntoTTh3vM4O2svQEB
	p5kAjX7uxVmnszpmLAcuzF0SGriKOozjbnjFHLR+Ms4Xao+PWmx2o90s968Pbl8C
	sruHPA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42r9765p3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 15:49:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 75EC040044;
	Thu,  7 Nov 2024 15:48:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A086626711E;
	Thu,  7 Nov 2024 15:47:38 +0100 (CET)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 7 Nov
 2024 15:47:38 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <linux-sound@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] ASoC: stm32: i2s: add stm32mp25 support
Date: Thu, 7 Nov 2024 15:47:12 +0100
Message-ID: <20241107144712.1305638-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
References: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add STM32MP25 support for STM32 I2S.

On STM32MP25 the I2S driver does not manage I2S kernel clock rate
by choosing its parent clock, depending on audio stream rate.

The driver requests a rate change on I2S kernel clock instead.
It tries to set the higher possible rate, which is a multiple of
the audio stream rate and which gives an accuracy of at least 1000 ppm.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_i2s.c | 211 ++++++++++++++++++++++++++++++++++----
 1 file changed, 189 insertions(+), 22 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index faa00103ee7f..19dc61008a75 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -200,10 +200,13 @@ enum i2s_datlen {
 
 #define STM32_I2S_NAME_LEN		32
 #define STM32_I2S_RATE_11K		11025
+#define STM32_I2S_MAX_SAMPLE_RATE_8K	192000
+#define STM32_I2S_MAX_SAMPLE_RATE_11K	176400
+#define STM32_I2S_CLK_RATE_TOLERANCE	1000 /* ppm */
 
 /**
  * struct stm32_i2s_data - private data of I2S
- * @regmap_conf: I2S register map configuration pointer
+ * @conf: I2S configuration pointer
  * @regmap: I2S register map pointer
  * @pdev: device data pointer
  * @dai_drv: DAI driver pointer
@@ -224,11 +227,14 @@ enum i2s_datlen {
  * @divider: prescaler division ratio
  * @div: prescaler div field
  * @odd: prescaler odd field
+ * @i2s_clk_flg: flag set while exclusivity on I2S kernel clock is active
  * @refcount: keep count of opened streams on I2S
  * @ms_flg: master mode flag.
+ * @set_i2s_clk_rate: set I2S kernel clock rate
+ * @put_i2s_clk_rate: put I2S kernel clock rate
  */
 struct stm32_i2s_data {
-	const struct regmap_config *regmap_conf;
+	const struct stm32_i2s_conf *conf;
 	struct regmap *regmap;
 	struct platform_device *pdev;
 	struct snd_soc_dai_driver *dai_drv;
@@ -249,8 +255,21 @@ struct stm32_i2s_data {
 	unsigned int divider;
 	unsigned int div;
 	bool odd;
+	bool i2s_clk_flg;
 	int refcount;
 	int ms_flg;
+	int (*set_i2s_clk_rate)(struct stm32_i2s_data *i2s, unsigned int rate);
+	void (*put_i2s_clk_rate)(struct stm32_i2s_data *i2s);
+};
+
+/**
+ * struct stm32_i2s_conf - I2S configuration
+ * @regmap_conf: regmap configuration pointer
+ * @get_i2s_clk_parent: get parent clock of I2S kernel clock
+ */
+struct stm32_i2s_conf {
+	const struct regmap_config *regmap_conf;
+	int (*get_i2s_clk_parent)(struct stm32_i2s_data *i2s);
 };
 
 struct stm32_i2smclk_data {
@@ -261,6 +280,8 @@ struct stm32_i2smclk_data {
 
 #define to_mclk_data(_hw) container_of(_hw, struct stm32_i2smclk_data, hw)
 
+static int stm32_i2s_get_parent_clk(struct stm32_i2s_data *i2s);
+
 static int stm32_i2s_calc_clk_div(struct stm32_i2s_data *i2s,
 				  unsigned long input_rate,
 				  unsigned long output_rate)
@@ -312,6 +333,33 @@ static int stm32_i2s_set_clk_div(struct stm32_i2s_data *i2s)
 				  cgfr_mask, cgfr);
 }
 
+static bool stm32_i2s_rate_accurate(struct stm32_i2s_data *i2s,
+				    unsigned int max_rate, unsigned int rate)
+{
+	struct platform_device *pdev = i2s->pdev;
+	u64 delta, dividend;
+	int ratio;
+
+	if (!rate) {
+		dev_err(&pdev->dev, "Unexpected null rate\n");
+		return false;
+	}
+
+	ratio = DIV_ROUND_CLOSEST(max_rate, rate);
+	if (!ratio)
+		return false;
+
+	dividend = mul_u32_u32(1000000, abs(max_rate - (ratio * rate)));
+	delta = div_u64(dividend, max_rate);
+
+	if (delta <= STM32_I2S_CLK_RATE_TOLERANCE)
+		return true;
+
+	dev_dbg(&pdev->dev, "Rate [%u] not accurate\n", rate);
+
+	return false;
+}
+
 static int stm32_i2s_set_parent_clock(struct stm32_i2s_data *i2s,
 				      unsigned int rate)
 {
@@ -332,6 +380,87 @@ static int stm32_i2s_set_parent_clock(struct stm32_i2s_data *i2s,
 	return ret;
 }
 
+static void stm32_i2s_put_parent_rate(struct stm32_i2s_data *i2s)
+{
+	if (i2s->i2s_clk_flg) {
+		i2s->i2s_clk_flg = false;
+		clk_rate_exclusive_put(i2s->i2sclk);
+	}
+}
+
+static int stm32_i2s_set_parent_rate(struct stm32_i2s_data *i2s,
+				     unsigned int rate)
+{
+	struct platform_device *pdev = i2s->pdev;
+	unsigned int i2s_clk_rate, i2s_clk_max_rate, i2s_curr_rate, i2s_new_rate;
+	int ret, div;
+
+	/*
+	 * Set maximum expected kernel clock frequency
+	 * - mclk on:
+	 *   f_i2s_ck = MCKDIV * mclk-fs * fs
+	 *   Here typical 256 ratio is assumed for mclk-fs
+	 * - mclk off:
+	 *   f_i2s_ck = MCKDIV * FRL * fs
+	 *   Where FRL=[16,32], MCKDIV=[1..256]
+	 *   f_i2s_ck = i2s_clk_max_rate * 32 / 256
+	 */
+	if (!(rate % STM32_I2S_RATE_11K))
+		i2s_clk_max_rate = STM32_I2S_MAX_SAMPLE_RATE_11K * 256;
+	else
+		i2s_clk_max_rate = STM32_I2S_MAX_SAMPLE_RATE_8K * 256;
+
+	if (!i2s->i2smclk)
+		i2s_clk_max_rate /= 8;
+
+	/* Request exclusivity, as the clock may be shared by I2S instances */
+	clk_rate_exclusive_get(i2s->i2sclk);
+	i2s->i2s_clk_flg = true;
+
+	/*
+	 * Check current kernel clock rate. If it gives the expected accuracy
+	 * return immediately.
+	 */
+	i2s_curr_rate = clk_get_rate(i2s->i2sclk);
+	if (stm32_i2s_rate_accurate(i2s, i2s_clk_max_rate, i2s_curr_rate))
+		return 0;
+
+	/*
+	 * Otherwise try to set the maximum rate and check the new actual rate.
+	 * If the new rate does not give the expected accuracy, try to set
+	 * lower rates for the kernel clock.
+	 */
+	i2s_clk_rate = i2s_clk_max_rate;
+	div = 1;
+	do {
+		/* Check new rate accuracy. Return if ok */
+		i2s_new_rate = clk_round_rate(i2s->i2sclk, i2s_clk_rate);
+		if (stm32_i2s_rate_accurate(i2s, i2s_clk_rate, i2s_new_rate)) {
+			ret = clk_set_rate(i2s->i2sclk, i2s_clk_rate);
+			if (ret) {
+				dev_err(&pdev->dev, "Error %d setting i2s_clk_rate rate. %s",
+					ret, ret == -EBUSY ?
+					"Active stream rates may be in conflict\n" : "\n");
+				goto err;
+			}
+
+			return 0;
+		}
+
+		/* Try a lower frequency */
+		div++;
+		i2s_clk_rate = i2s_clk_max_rate / div;
+	} while (i2s_clk_rate > rate);
+
+	/* no accurate rate found */
+	dev_err(&pdev->dev, "Failed to find an accurate rate");
+
+err:
+	stm32_i2s_put_parent_rate(i2s);
+
+	return -EINVAL;
+}
+
 static long stm32_i2smclk_round_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long *prate)
 {
@@ -635,12 +764,16 @@ static int stm32_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 				clk_rate_exclusive_put(i2s->i2smclk);
 				i2s->mclk_rate = 0;
 			}
+
+			if (i2s->put_i2s_clk_rate)
+				i2s->put_i2s_clk_rate(i2s);
+
 			return regmap_update_bits(i2s->regmap,
 						  STM32_I2S_CGFR_REG,
 						  I2S_CGFR_MCKOE, 0);
 		}
 		/* If master clock is used, set parent clock now */
-		ret = stm32_i2s_set_parent_clock(i2s, freq);
+		ret = i2s->set_i2s_clk_rate(i2s, freq);
 		if (ret)
 			return ret;
 		ret = clk_set_rate_exclusive(i2s->i2smclk, freq);
@@ -667,10 +800,11 @@ static int stm32_i2s_configure_clock(struct snd_soc_dai *cpu_dai,
 	u32 cgfr;
 	int ret;
 
-	if (!(rate % 11025))
-		clk_set_parent(i2s->i2sclk, i2s->x11kclk);
-	else
-		clk_set_parent(i2s->i2sclk, i2s->x8kclk);
+	if (!i2s->mclk_rate) {
+		ret = i2s->set_i2s_clk_rate(i2s, rate);
+		if (ret)
+			return ret;
+	}
 	i2s_clock_rate = clk_get_rate(i2s->i2sclk);
 
 	/*
@@ -915,6 +1049,14 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 
 	clk_disable_unprepare(i2s->i2sclk);
 
+	/*
+	 * Release kernel clock if following conditions are fulfilled
+	 * - Master clock is not used. Kernel clock won't be released trough sysclk
+	 * - Put handler is defined. Involve that clock is managed exclusively
+	 */
+	if (!i2s->i2smclk && i2s->put_i2s_clk_rate)
+		i2s->put_i2s_clk_rate(i2s);
+
 	spin_lock_irqsave(&i2s->irq_lock, flags);
 	i2s->substream = NULL;
 	spin_unlock_irqrestore(&i2s->irq_lock, flags);
@@ -1012,14 +1154,36 @@ static int stm32_i2s_dais_init(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct stm32_i2s_conf stm32_i2s_conf_h7 = {
+	.regmap_conf = &stm32_h7_i2s_regmap_conf,
+	.get_i2s_clk_parent = stm32_i2s_get_parent_clk,
+};
+
+static const struct stm32_i2s_conf stm32_i2s_conf_mp25 = {
+	.regmap_conf = &stm32_h7_i2s_regmap_conf
+};
+
 static const struct of_device_id stm32_i2s_ids[] = {
-	{
-		.compatible = "st,stm32h7-i2s",
-		.data = &stm32_h7_i2s_regmap_conf
-	},
+	{ .compatible = "st,stm32h7-i2s", .data = &stm32_i2s_conf_h7 },
+	{ .compatible = "st,stm32mp25-i2s", .data = &stm32_i2s_conf_mp25 },
 	{},
 };
 
+static int stm32_i2s_get_parent_clk(struct stm32_i2s_data *i2s)
+{
+	struct device *dev = &i2s->pdev->dev;
+
+	i2s->x8kclk = devm_clk_get(dev, "x8k");
+	if (IS_ERR(i2s->x8kclk))
+		return dev_err_probe(dev, PTR_ERR(i2s->x8kclk), "Cannot get x8k parent clock\n");
+
+	i2s->x11kclk = devm_clk_get(dev, "x11k");
+	if (IS_ERR(i2s->x11kclk))
+		return dev_err_probe(dev, PTR_ERR(i2s->x11kclk), "Cannot get x11k parent clock\n");
+
+	return 0;
+}
+
 static int stm32_i2s_parse_dt(struct platform_device *pdev,
 			      struct stm32_i2s_data *i2s)
 {
@@ -1031,8 +1195,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	i2s->regmap_conf = device_get_match_data(&pdev->dev);
-	if (!i2s->regmap_conf)
+	i2s->conf = device_get_match_data(&pdev->dev);
+	if (!i2s->conf)
 		return -EINVAL;
 
 	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -1052,15 +1216,18 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->i2sclk),
 				     "Could not get i2sclk\n");
 
-	i2s->x8kclk = devm_clk_get(&pdev->dev, "x8k");
-	if (IS_ERR(i2s->x8kclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->x8kclk),
-				     "Could not get x8k parent clock\n");
+	if (i2s->conf->get_i2s_clk_parent) {
+		i2s->set_i2s_clk_rate = stm32_i2s_set_parent_clock;
+	} else {
+		i2s->set_i2s_clk_rate = stm32_i2s_set_parent_rate;
+		i2s->put_i2s_clk_rate = stm32_i2s_put_parent_rate;
+	}
 
-	i2s->x11kclk = devm_clk_get(&pdev->dev, "x11k");
-	if (IS_ERR(i2s->x11kclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->x11kclk),
-				     "Could not get x11k parent clock\n");
+	if (i2s->conf->get_i2s_clk_parent) {
+		ret = i2s->conf->get_i2s_clk_parent(i2s);
+		if (ret)
+			return ret;
+	}
 
 	/* Register mclk provider if requested */
 	if (of_property_present(np, "#clock-cells")) {
@@ -1126,7 +1293,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 		return ret;
 
 	i2s->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "pclk",
-						i2s->base, i2s->regmap_conf);
+						i2s->base, i2s->conf->regmap_conf);
 	if (IS_ERR(i2s->regmap))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->regmap),
 				     "Regmap init error\n");
-- 
2.25.1



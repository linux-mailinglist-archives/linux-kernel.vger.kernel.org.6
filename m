Return-Path: <linux-kernel+bounces-280782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C194CF26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D60283C44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7120192B78;
	Fri,  9 Aug 2024 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoOD8p75"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BE191F94
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201292; cv=none; b=DyIfgR1mly50CsF/i2kPiYh3Gh2z+LrMdxK/C9CLp8opv0QsfLHkxdGQcpUW2WmdxWMaOfmoMlWNn3OCeJYTlttxnXAfVcG/83E2USe4QgGVIWIrCIUs8XV0g7PJPSZanokDvdFQLRQVAcf34jntKZ2wrRUWeYg1PutKqVWO1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201292; c=relaxed/simple;
	bh=MUOJttNLDDkaf3vn9kxvM207x74kpVe47iGW1tUIkIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iseWBsR6VU066wO6dXNJ8H1jqIuAuwa6nCGLAfmC/ouN+9mM7NBCRuR3MivC/byG+h1m/4A76jG1Uvu11qngtkr4bk2vfmQt6QgeBoWa99iPJIkAreLIRl58GlDO9Qyx9SWFy/SU6XymdB/+1o2G/fyvkeMT9XSzgFskRXj7sRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WoOD8p75; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3686b285969so1014034f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723201288; x=1723806088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/682q/IgmSx1ugjwpcrW1fYYFoT2Yei89ggcZ5WWfo8=;
        b=WoOD8p75yvavw9AdQB54DgMP5yWrgyHu3FyY6ulR1EHJ86fu9b4J+TzkI510Vii6Io
         +927POzYWALqqDv4wHeUyxeF2wPgEGMu3y5fHWVrox84xuHBOIUERhUG1yKitlE52HNW
         32XcFlujcOEX2+uYqTxSQmZR/mAejrFwNIV+Kfdwbu7My4vpnmQliI1MmUYbyCt1A/zp
         70JXD2kdp2yjAo5IPQ+OWlPYrV6tbKOmWxUJiGoeSjXkn2UCqMNHqNVG+VMDAYJZyEWR
         TVg0xBlVS/usCMH+OGJ8Vlsrofe9B92FXAHww14b2KIxwbo8huLp59tQrISqy/uyo1Sk
         cqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723201288; x=1723806088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/682q/IgmSx1ugjwpcrW1fYYFoT2Yei89ggcZ5WWfo8=;
        b=tHxqIrfOIrFSA8QPAZhuBMIaAoanp+8cjhzQ2vsbPWNk5Oftj7GSyB2qyY8e2wzMQG
         hRfRctQefGDGLX4+/HwNjEaV5EtBzAWaFqhLh+pxBGqZjygxgqRtFoWARylcXpk7rM4l
         gX1wiuCaZSMbR2ZVzodeIkwfrvkl17te5X7q19iKSgNvui43emeDDkxgdJ8Qn0Y7iPq6
         0RqyFZ52hGtE4qNUFRsGRSDX3xX2PZhHLLRkk5xAyYDXktPke7rI+Nl7lDwifaQh0Xm7
         diPjCtyPVRg64o4v1khng7EijlDQKTKkQmdpHDgKXBOi1YC5MCDeE4K/jTEDtW6MKkIv
         NJHA==
X-Forwarded-Encrypted: i=1; AJvYcCVm7j0DWpuzDn1mJa0AroLmcsX0vCW/DyK+TP7gRAuVbniyAxtvl1ruATTfFs/k/agtEvLQpXyqYFCx7KRwhiK3okOL7IOVATQwwFYD
X-Gm-Message-State: AOJu0Yy2CuO4gDlvBxL12fXDx8HJ47ze9MAj2lkD+tI/Zj4hD9Ar+ZtI
	f/UbI2AmfGawR1f8cN9OBGNWyMFHQ2mu23R0OyLpb1G725vKMcjOetOp+pEwcbc=
X-Google-Smtp-Source: AGHT+IEMw0S9h0YIYl4LyxIuHNAP7T9PX2ZjGuz2Ky4aelpGhhnCl3Hs3qzr8diKaTFhAHA9AO9+OA==
X-Received: by 2002:a5d:5f91:0:b0:367:8a84:7427 with SMTP id ffacd0b85a97d-36d5de93557mr1073255f8f.2.1723201288119;
        Fri, 09 Aug 2024 04:01:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d340acfdasm1815992f8f.13.2024.08.09.04.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:01:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] ASoC: codecs: wsa884x: Implement temperature reading and hwmon
Date: Fri,  9 Aug 2024 13:01:22 +0200
Message-ID: <20240809110122.137761-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read temperature of the speaker and expose it via hwmon interface, which
will be later used during calibration of speaker protection algorithms.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Replace Kconfig HWMON dependency in favor of
   IS_REACHABLE(CONFIG_HWMON) which solves Kernel Test Robot warning for
   !HWMON and HWMON=y && WSA884x=m

Changes in v2:
1. Add missing dependency on HWMON for y!=m builds (Kernel Test Robot
   report: undefined reference to
   `devm_hwmon_device_register_with_info').
---
 sound/soc/codecs/wsa884x.c | 201 +++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index 8db1380d1f10..86df5152c547 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -5,11 +5,14 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -301,8 +304,28 @@
 #define WSA884X_PA_FSM_MSK1		(WSA884X_DIG_CTRL0_BASE + 0x3b)
 #define WSA884X_PA_FSM_BYP_CTL		(WSA884X_DIG_CTRL0_BASE + 0x3c)
 #define WSA884X_PA_FSM_BYP0		(WSA884X_DIG_CTRL0_BASE + 0x3d)
+#define WSA884X_PA_FSM_BYP0_DC_CAL_EN_MASK		0x01
+#define WSA884X_PA_FSM_BYP0_DC_CAL_EN_SHIFT		0
+#define WSA884X_PA_FSM_BYP0_CLK_WD_EN_MASK		0x02
+#define WSA884X_PA_FSM_BYP0_CLK_WD_EN_SHIFT		1
+#define WSA884X_PA_FSM_BYP0_BG_EN_MASK			0x04
+#define WSA884X_PA_FSM_BYP0_BG_EN_SHIFT			2
+#define WSA884X_PA_FSM_BYP0_BOOST_EN_MASK		0x08
+#define WSA884X_PA_FSM_BYP0_BOOST_EN_SHIFT		3
+#define WSA884X_PA_FSM_BYP0_PA_EN_MASK			0x10
+#define WSA884X_PA_FSM_BYP0_PA_EN_SHIFT			4
+#define WSA884X_PA_FSM_BYP0_D_UNMUTE_MASK		0x20
+#define WSA884X_PA_FSM_BYP0_D_UNMUTE_SHIFT		5
+#define WSA884X_PA_FSM_BYP0_SPKR_PROT_EN_MASK		0x40
+#define WSA884X_PA_FSM_BYP0_SPKR_PROT_EN_SHIFT		6
+#define WSA884X_PA_FSM_BYP0_TSADC_EN_MASK		0x80
+#define WSA884X_PA_FSM_BYP0_TSADC_EN_SHIFT		7
 #define WSA884X_PA_FSM_BYP1		(WSA884X_DIG_CTRL0_BASE + 0x3e)
 #define WSA884X_TADC_VALUE_CTL		(WSA884X_DIG_CTRL0_BASE + 0x50)
+#define WSA884X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK	0x01
+#define WSA884X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_SHIFT	0
+#define WSA884X_TADC_VALUE_CTL_VBAT_VALUE_RD_EN_MASK	0x02
+#define WSA884X_TADC_VALUE_CTL_VBAT_VALUE_RD_EN_SHIFT	1
 #define WSA884X_TEMP_DETECT_CTL		(WSA884X_DIG_CTRL0_BASE + 0x51)
 #define WSA884X_TEMP_DIN_MSB		(WSA884X_DIG_CTRL0_BASE + 0x52)
 #define WSA884X_TEMP_DIN_LSB		(WSA884X_DIG_CTRL0_BASE + 0x53)
@@ -691,6 +714,17 @@
 		SNDRV_PCM_FMTBIT_S24_LE |\
 		SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
+/* Two-point trimming for temperature calibration */
+#define WSA884X_T1_TEMP			-10L
+#define WSA884X_T2_TEMP			150L
+
+/*
+ * Device will report senseless data in many cases, so discard any measurements
+ * outside of valid range.
+ */
+#define WSA884X_LOW_TEMP_THRESHOLD	5
+#define WSA884X_HIGH_TEMP_THRESHOLD	45
+
 struct wsa884x_priv {
 	struct regmap *regmap;
 	struct device *dev;
@@ -706,6 +740,13 @@ struct wsa884x_priv {
 	int active_ports;
 	int dev_mode;
 	bool hw_init;
+	/*
+	 * Protects temperature reading code (related to speaker protection) and
+	 * fields: temperature and pa_on.
+	 */
+	struct mutex sp_lock;
+	unsigned int temperature;
+	bool pa_on;
 };
 
 enum {
@@ -1660,6 +1701,10 @@ static int wsa884x_spkr_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		mutex_lock(&wsa884x->sp_lock);
+		wsa884x->pa_on = true;
+		mutex_unlock(&wsa884x->sp_lock);
+
 		wsa884x_spkr_post_pmu(component, wsa884x);
 
 		snd_soc_component_write_field(component, WSA884X_PDM_WD_CTL,
@@ -1671,6 +1716,10 @@ static int wsa884x_spkr_event(struct snd_soc_dapm_widget *w,
 		snd_soc_component_write_field(component, WSA884X_PDM_WD_CTL,
 					      WSA884X_PDM_WD_CTL_PDM_WD_EN_MASK,
 					      0x0);
+
+		mutex_lock(&wsa884x->sp_lock);
+		wsa884x->pa_on = false;
+		mutex_unlock(&wsa884x->sp_lock);
 		break;
 	}
 
@@ -1810,6 +1859,144 @@ static struct snd_soc_dai_driver wsa884x_dais[] = {
 	},
 };
 
+static int wsa884x_get_temp(struct wsa884x_priv *wsa884x, long *temp)
+{
+	unsigned int d1_msb = 0, d1_lsb = 0, d2_msb = 0, d2_lsb = 0;
+	unsigned int dmeas_msb = 0, dmeas_lsb = 0;
+	int d1, d2, dmeas;
+	unsigned int mask;
+	long val;
+	int ret;
+
+	guard(mutex)(&wsa884x->sp_lock);
+
+	if (wsa884x->pa_on) {
+		/*
+		 * Reading temperature is possible only when Power Amplifier is
+		 * off. Report last cached data.
+		 */
+		*temp = wsa884x->temperature;
+		return 0;
+	}
+
+	ret = pm_runtime_resume_and_get(wsa884x->dev);
+	if (ret < 0)
+		return ret;
+
+	mask = WSA884X_PA_FSM_BYP0_DC_CAL_EN_MASK |
+	       WSA884X_PA_FSM_BYP0_CLK_WD_EN_MASK |
+	       WSA884X_PA_FSM_BYP0_BG_EN_MASK |
+	       WSA884X_PA_FSM_BYP0_D_UNMUTE_MASK |
+	       WSA884X_PA_FSM_BYP0_SPKR_PROT_EN_MASK |
+	       WSA884X_PA_FSM_BYP0_TSADC_EN_MASK;
+	/*
+	 * Here and further do not care about read or update failures.
+	 * For example, before turning on Power Amplifier for the first
+	 * time, reading WSA884X_TEMP_DIN_MSB will always return 0.
+	 * Instead, check if returned value is within reasonable
+	 * thresholds.
+	 */
+	regmap_update_bits(wsa884x->regmap, WSA884X_PA_FSM_BYP0, mask, mask);
+
+	regmap_update_bits(wsa884x->regmap, WSA884X_TADC_VALUE_CTL,
+			   WSA884X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK,
+			   FIELD_PREP(WSA884X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK, 0x0));
+
+	regmap_read(wsa884x->regmap, WSA884X_TEMP_DIN_MSB, &dmeas_msb);
+	regmap_read(wsa884x->regmap, WSA884X_TEMP_DIN_LSB, &dmeas_lsb);
+
+	regmap_update_bits(wsa884x->regmap, WSA884X_TADC_VALUE_CTL,
+			   WSA884X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK,
+			   FIELD_PREP(WSA884X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK, 0x1));
+
+	regmap_read(wsa884x->regmap, WSA884X_OTP_REG_1, &d1_msb);
+	regmap_read(wsa884x->regmap, WSA884X_OTP_REG_2, &d1_lsb);
+	regmap_read(wsa884x->regmap, WSA884X_OTP_REG_3, &d2_msb);
+	regmap_read(wsa884x->regmap, WSA884X_OTP_REG_4, &d2_lsb);
+
+	regmap_update_bits(wsa884x->regmap, WSA884X_PA_FSM_BYP0, mask, 0x0);
+
+	dmeas = (((dmeas_msb & 0xff) << 0x8) | (dmeas_lsb & 0xff)) >> 0x6;
+	d1 = (((d1_msb & 0xff) << 0x8) | (d1_lsb & 0xff)) >> 0x6;
+	d2 = (((d2_msb & 0xff) << 0x8) | (d2_lsb & 0xff)) >> 0x6;
+
+	if (d1 == d2) {
+		/* Incorrect data in OTP? */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	val = WSA884X_T1_TEMP + (((dmeas - d1) * (WSA884X_T2_TEMP - WSA884X_T1_TEMP))/(d2 - d1));
+
+	dev_dbg(wsa884x->dev, "Measured temp %ld (dmeas=%d, d1=%d, d2=%d)\n",
+		val, dmeas, d1, d2);
+
+	if ((val > WSA884X_LOW_TEMP_THRESHOLD) &&
+	    (val < WSA884X_HIGH_TEMP_THRESHOLD)) {
+		wsa884x->temperature = val;
+		*temp = val;
+		ret = 0;
+	} else {
+		ret = -EAGAIN;
+	}
+
+out:
+	pm_runtime_mark_last_busy(wsa884x->dev);
+	pm_runtime_put_autosuspend(wsa884x->dev);
+
+	return ret;
+}
+
+static umode_t wsa884x_hwmon_is_visible(const void *data,
+					enum hwmon_sensor_types type, u32 attr,
+					int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int wsa884x_hwmon_read(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *temp)
+{
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = wsa884x_get_temp(dev_get_drvdata(dev), temp);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct hwmon_channel_info *const wsa884x_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops wsa884x_hwmon_ops = {
+	.is_visible	= wsa884x_hwmon_is_visible,
+	.read		= wsa884x_hwmon_read,
+};
+
+static const struct hwmon_chip_info wsa884x_hwmon_chip_info = {
+	.ops	= &wsa884x_hwmon_ops,
+	.info	= wsa884x_hwmon_info,
+};
+
 static void wsa884x_reset_powerdown(void *data)
 {
 	struct wsa884x_priv *wsa884x = data;
@@ -1866,6 +2053,8 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	if (!wsa884x)
 		return -ENOMEM;
 
+	mutex_init(&wsa884x->sp_lock);
+
 	for (i = 0; i < WSA884X_SUPPLIES_NUM; i++)
 		wsa884x->supplies[i].supply = wsa884x_supply_name[i];
 
@@ -1923,6 +2112,18 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	regcache_cache_only(wsa884x->regmap, true);
 	wsa884x->hw_init = true;
 
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon;
+
+		hwmon = devm_hwmon_device_register_with_info(dev, "wsa884x",
+							     wsa884x,
+							     &wsa884x_hwmon_chip_info,
+							     NULL);
+		if (IS_ERR(hwmon))
+			return dev_err_probe(dev, PTR_ERR(hwmon),
+					     "Failed to register hwmon sensor\n");
+	}
+
 	pm_runtime_set_autosuspend_delay(dev, 3000);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_mark_last_busy(dev);
-- 
2.43.0



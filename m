Return-Path: <linux-kernel+bounces-525132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8BA3EB3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C7A19C5E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8491F3FD7;
	Fri, 21 Feb 2025 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maf9e9SY"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A61D63DF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740108106; cv=none; b=DtEK+fFCyxeiU2Fj2I48OfiqsC3SfRDcI6qQAjLUWy7c5o2jwkA2B0XgfDeFXTtIXyBwdXiWUwwG32Fl3waZKbAtTvPX4sLh52nuj75Q6AqNSd/w/x73i5JOGum+Oxs51kfgef2hIIeKtKV2/tmMsvosnz2DA98yehRcsj7ZZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740108106; c=relaxed/simple;
	bh=9lQloC8xrSrvv0NL4PTcGbjNs7+WeOoNHlIVlv8UiaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhBmjrtKpU9TvkTZ0J3mgdMVoz14PMPNZr4P/PpDF39K7B+EtFkjDrsdpRYJpaN2+xOpKub5Aq802hMhEk7FVjZ04phUq2+Mr7gM+gBVDQ4kILdyiM6Z3lLf4YC3KfcKFe9ZzEZfKglwkSas5AapaovrTTFJ88vWyvIEMFrl7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=maf9e9SY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso16247855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740108103; x=1740712903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tav3PNxevwKiDqCQMCZ2Ad3WIauSHdQjU2aO6+32oKU=;
        b=maf9e9SYbNU4tmmkNDY0pNzgffVJvRG5p/GgN4wAj3GNzjwZBUEPoMtwmKVF8zNO2r
         aVvMBPLoPnV2uPpQJSpCySUUoGI+l6Ai5y1WyXKdtihKYHEC+jKRD5BQ6DxKNKSpWUuh
         ASlZ13R/KiKJmxHi3zqdlW3YKYaZ4oGnfWliHRsR/4ujbY59yCdgkFsfnUmh1/2avOKJ
         dSVfxEuJyUelIW3DcLixIH46xZqdK+dp0wWt0o1ByBpd3puX4AabrVWRTXv7P0z8RPPl
         2Ia1elAyMU2+p6A6GNJNUCiiBwD/G7sST3haX9yBkVhzjUkcYsGLD4Yr0KetgwmQa4qO
         Dxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740108103; x=1740712903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tav3PNxevwKiDqCQMCZ2Ad3WIauSHdQjU2aO6+32oKU=;
        b=J4k0CbpnpxdbiCCoEtZcWXsmIr59Ot0euT97la+ttz3U4ZQVbkhneU70qjfEdAEgEE
         Io0uxJ4QP8VV25ePvwxFEQp02qJsMMXH2RqziqQdcTltPfrOE5374a+s5jY73NQ9s9+C
         6/0jNSCxih5TYL8XO8mRleeIPjXJjp4DEjdre+2rSaF2bQFBUXLYvJM68ev78JBA1+Gq
         IxJb7UfQPjYUDJabel2UyFOGC2CYx4FJLFzTAV/rxg7BRtw+kr1YtsIKSxzHHHtcVUDO
         z7cXK1bvGqUJwiP6lX15AkfyWLgSxBLvKlCbzc/1O6+GgSPe00k93+Nm182gq4GwO2qp
         ieUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2fOXD78e5ZWQ28C9OGuhL8glHAqUZKM5h4WZyNhC9YCkaSUErNPIwPf/YRXmXIMZcsBHlYGVHTlX6C4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKa6H50yCrXH/O8No/FM5XctebsCjxB1DXGVz18ZxiAeY9nWz
	BRFJNBwD6BLSV129y1xX6NcEPgproeU6GBb936LWVUDh1tCXzdFcrh7glGEjglA=
X-Gm-Gg: ASbGnct2rLm4NJ4mtgkQyWdm37AmzczZEjeM3Zcxz49wyWuKmmPz807PnCQoltWQg6Q
	Er5M7CsowXZv1DjDBs7XVScNXR6h4j/3aAjyaq8t+SYQaJaLzaGIoNOKfY5gNQr4ZEZ6vKWiqsw
	ZeMA3iOqsK/2msZSJTYVCUh0teOTjflFdaVF5VQYz2RypbdqpziXSoi8w8shDylpWVsc7iuanE8
	Wvuvb8EyvqtpQmYaXA4Zw/VIfuK2UQgJGYbvcUuIz5Y8tuyxF7oE72i2HE/mQ9Pfx+uAKGS1QNn
	0rvf0aNLKv6NJ5H51U92RZyU+wA6cpW2vuOpyAthZu5f
X-Google-Smtp-Source: AGHT+IFHRKBF41ynLQkyGP19rFquObp3TYcaLCdzafxkPCgt8hie9i36wOi7U4rAgvAVyC9I9BlmXw==
X-Received: by 2002:a05:600c:524a:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-439ae1f1147mr12496995e9.15.1740108102943;
        Thu, 20 Feb 2025 19:21:42 -0800 (PST)
Received: from localhost.localdomain ([2.124.154.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f5b38sm3725615e9.24.2025.02.20.19.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:21:41 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Cc: krzysztof.kozlowski@linaro.org,
	steev@kali.org,
	perex@perex.cz,
	tiwai@suse.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2] ASoC: codecs: wsa883x: Implement temperature reading and hwmon
Date: Fri, 21 Feb 2025 03:21:41 +0000
Message-ID: <20250221032141.1206902-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read temperature of the amplifier and expose it via hwmon interface, which
will be later used during calibration of speaker protection algorithms.
The method is the same as for wsa884x and therefore this is based on
Krzysztof Kozlowski's approach implemented in commit 6b99dc62d940 ("ASoC:
codecs: wsa884x: Implement temperature reading and hwmon").

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---

Changes in v2:
- add temperature conversion to millidegrees of Celcius
  when amplifier is on to report correct data to hwmon;
- minor coding style fixes to make checkpatch --strict happy;
- correct typo (reference to wsa884x in the comment), small rewording.

 sound/soc/codecs/wsa883x.c | 194 +++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 47da5674d7c9..a5a6cb90bb43 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -156,8 +157,28 @@
 #define WSA883X_PA_FSM_ERR_COND         (WSA883X_DIG_CTRL_BASE + 0x0014)
 #define WSA883X_PA_FSM_MSK              (WSA883X_DIG_CTRL_BASE + 0x0015)
 #define WSA883X_PA_FSM_BYP              (WSA883X_DIG_CTRL_BASE + 0x0016)
+#define WSA883X_PA_FSM_BYP_DC_CAL_EN_MASK		0x01
+#define WSA883X_PA_FSM_BYP_DC_CAL_EN_SHIFT		0
+#define WSA883X_PA_FSM_BYP_CLK_WD_EN_MASK		0x02
+#define WSA883X_PA_FSM_BYP_CLK_WD_EN_SHIFT		1
+#define WSA883X_PA_FSM_BYP_BG_EN_MASK			0x04
+#define WSA883X_PA_FSM_BYP_BG_EN_SHIFT			2
+#define WSA883X_PA_FSM_BYP_BOOST_EN_MASK		0x08
+#define WSA883X_PA_FSM_BYP_BOOST_EN_SHIFT		3
+#define WSA883X_PA_FSM_BYP_PA_EN_MASK			0x10
+#define WSA883X_PA_FSM_BYP_PA_EN_SHIFT			4
+#define WSA883X_PA_FSM_BYP_D_UNMUTE_MASK		0x20
+#define WSA883X_PA_FSM_BYP_D_UNMUTE_SHIFT		5
+#define WSA883X_PA_FSM_BYP_SPKR_PROT_EN_MASK		0x40
+#define WSA883X_PA_FSM_BYP_SPKR_PROT_EN_SHIFT		6
+#define WSA883X_PA_FSM_BYP_TSADC_EN_MASK		0x80
+#define WSA883X_PA_FSM_BYP_TSADC_EN_SHIFT		7
 #define WSA883X_PA_FSM_DBG              (WSA883X_DIG_CTRL_BASE + 0x0017)
 #define WSA883X_TADC_VALUE_CTL          (WSA883X_DIG_CTRL_BASE + 0x0020)
+#define WSA883X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK	0x01
+#define WSA883X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_SHIFT	0
+#define WSA883X_TADC_VALUE_CTL_VBAT_VALUE_RD_EN_MASK	0x02
+#define WSA883X_TADC_VALUE_CTL_VBAT_VALUE_RD_EN_SHIFT	1
 #define WSA883X_TEMP_DETECT_CTL         (WSA883X_DIG_CTRL_BASE + 0x0021)
 #define WSA883X_TEMP_MSB                (WSA883X_DIG_CTRL_BASE + 0x0022)
 #define WSA883X_TEMP_LSB                (WSA883X_DIG_CTRL_BASE + 0x0023)
@@ -427,6 +448,17 @@
 		SNDRV_PCM_FMTBIT_S24_LE |\
 		SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
+/* Two-point trimming for temperature calibration */
+#define WSA883X_T1_TEMP			-10L
+#define WSA883X_T2_TEMP			150L
+
+/*
+ * Device will report senseless data in many cases, so discard any measurements
+ * outside of valid range.
+ */
+#define WSA883X_LOW_TEMP_THRESHOLD	5
+#define WSA883X_HIGH_TEMP_THRESHOLD	45
+
 struct wsa883x_priv {
 	struct regmap *regmap;
 	struct device *dev;
@@ -441,6 +473,13 @@ struct wsa883x_priv {
 	int active_ports;
 	int dev_mode;
 	int comp_offset;
+	/*
+	 * Protects temperature reading code (related to speaker protection) and
+	 * fields: temperature and pa_on.
+	 */
+	struct mutex sp_lock;
+	unsigned int temperature;
+	bool pa_on;
 };
 
 enum {
@@ -1186,6 +1225,10 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		mutex_lock(&wsa883x->sp_lock);
+		wsa883x->pa_on = true;
+		mutex_unlock(&wsa883x->sp_lock);
+
 		switch (wsa883x->dev_mode) {
 		case RECEIVER:
 			snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
@@ -1235,6 +1278,9 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 					      WSA883X_GLOBAL_PA_EN_MASK, 0);
 		snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
 					      WSA883X_PDM_EN_MASK, 0);
+		mutex_lock(&wsa883x->sp_lock);
+		wsa883x->pa_on = false;
+		mutex_unlock(&wsa883x->sp_lock);
 		break;
 	}
 	return 0;
@@ -1367,6 +1413,140 @@ static struct snd_soc_dai_driver wsa883x_dais[] = {
 	},
 };
 
+static int wsa883x_get_temp(struct wsa883x_priv *wsa883x, long *temp)
+{
+	unsigned int d1_msb = 0, d1_lsb = 0, d2_msb = 0, d2_lsb = 0;
+	unsigned int dmeas_msb = 0, dmeas_lsb = 0;
+	int d1, d2, dmeas;
+	unsigned int mask;
+	int ret, range;
+	long val;
+
+	guard(mutex)(&wsa883x->sp_lock);
+
+	if (wsa883x->pa_on) {
+		/*
+		 * Reading temperature is possible only when Power Amplifier is
+		 * off. Report last cached data.
+		 */
+		*temp = wsa883x->temperature * 1000;
+		return 0;
+	}
+
+	ret = pm_runtime_resume_and_get(wsa883x->dev);
+	if (ret < 0)
+		return ret;
+
+	mask = WSA883X_PA_FSM_BYP_DC_CAL_EN_MASK |
+	       WSA883X_PA_FSM_BYP_CLK_WD_EN_MASK |
+	       WSA883X_PA_FSM_BYP_BG_EN_MASK |
+	       WSA883X_PA_FSM_BYP_D_UNMUTE_MASK |
+	       WSA883X_PA_FSM_BYP_SPKR_PROT_EN_MASK |
+	       WSA883X_PA_FSM_BYP_TSADC_EN_MASK;
+
+	/*
+	 * Here and further do not care about read or update failures.
+	 * For example, before turning the amplifier on for the first
+	 * time, reading WSA883X_TEMP_DIN_MSB will always return 0.
+	 * Instead, check if returned value is within reasonable
+	 * thresholds.
+	 */
+	regmap_update_bits(wsa883x->regmap, WSA883X_PA_FSM_BYP, mask, mask);
+
+	regmap_update_bits(wsa883x->regmap, WSA883X_TADC_VALUE_CTL,
+			   WSA883X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK,
+			   FIELD_PREP(WSA883X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK, 0x0));
+
+	regmap_read(wsa883x->regmap, WSA883X_TEMP_MSB, &dmeas_msb);
+	regmap_read(wsa883x->regmap, WSA883X_TEMP_LSB, &dmeas_lsb);
+
+	regmap_update_bits(wsa883x->regmap, WSA883X_TADC_VALUE_CTL,
+			   WSA883X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK,
+			   FIELD_PREP(WSA883X_TADC_VALUE_CTL_TEMP_VALUE_RD_EN_MASK, 0x1));
+
+	regmap_read(wsa883x->regmap, WSA883X_OTP_REG_1, &d1_msb);
+	regmap_read(wsa883x->regmap, WSA883X_OTP_REG_2, &d1_lsb);
+	regmap_read(wsa883x->regmap, WSA883X_OTP_REG_3, &d2_msb);
+	regmap_read(wsa883x->regmap, WSA883X_OTP_REG_4, &d2_lsb);
+
+	regmap_update_bits(wsa883x->regmap, WSA883X_PA_FSM_BYP, mask, 0x0);
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
+	val = WSA883X_T1_TEMP + (((dmeas - d1) * (WSA883X_T2_TEMP - WSA883X_T1_TEMP)) / (d2 - d1));
+	range = WSA883X_HIGH_TEMP_THRESHOLD - WSA883X_LOW_TEMP_THRESHOLD;
+	if (in_range(val, WSA883X_LOW_TEMP_THRESHOLD, range)) {
+		wsa883x->temperature = val;
+		*temp = val * 1000;
+		ret = 0;
+	} else {
+		ret = -EAGAIN;
+	}
+out:
+	pm_runtime_mark_last_busy(wsa883x->dev);
+	pm_runtime_put_autosuspend(wsa883x->dev);
+
+	return ret;
+}
+
+static umode_t wsa883x_hwmon_is_visible(const void *data,
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
+static int wsa883x_hwmon_read(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *temp)
+{
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = wsa883x_get_temp(dev_get_drvdata(dev), temp);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct hwmon_channel_info *const wsa883x_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops wsa883x_hwmon_ops = {
+	.is_visible	= wsa883x_hwmon_is_visible,
+	.read		= wsa883x_hwmon_read,
+};
+
+static const struct hwmon_chip_info wsa883x_hwmon_chip_info = {
+	.ops	= &wsa883x_hwmon_ops,
+	.info	= wsa883x_hwmon_info,
+};
+
 static int wsa883x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
@@ -1402,6 +1582,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	wsa883x->sconfig.bps = 1;
 	wsa883x->sconfig.direction = SDW_DATA_DIR_RX;
 	wsa883x->sconfig.type = SDW_STREAM_PDM;
+	mutex_init(&wsa883x->sp_lock);
 
 	/**
 	 * Port map index starts with 0, however the data port for this codec
@@ -1424,6 +1605,19 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 				    "regmap_init failed\n");
 		goto err;
 	}
+
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon;
+
+		hwmon = devm_hwmon_device_register_with_info(dev, "wsa883x",
+							     wsa883x,
+							     &wsa883x_hwmon_chip_info,
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
2.47.2



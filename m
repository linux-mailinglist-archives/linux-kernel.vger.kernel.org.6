Return-Path: <linux-kernel+bounces-442436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9B9EDCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE001889B02
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03016F84F;
	Thu, 12 Dec 2024 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxdd05U+"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954651EEE6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964470; cv=none; b=cOcx/KBdCZPXOAk9ZnuUhYyar7IoCAAoF1XL1I8BzAlFnFLp+fC7GHDpxZ7ZVl5T1n0sNlhYKKAgs3bwSJafQmlu4CnrhNDakLEZCFvoowFZ23NndHaskPoyFfFUkBGt8a6CikGPcTLT7BcMUOuOxYqiXfG/6/2VHTp29Q0Kwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964470; c=relaxed/simple;
	bh=GNiCZMe+RW8jsYjQ3tAiNYLd0FE9HPQ8fTKML2yoad4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X657hwkBJIlAOVsj43J0cBnKGuVTDjZhC9dz9A+yl0cEGdufbud97HsCgSZ9i4dy1gWROAZlSIDPSaWO+VhWnG7pt3glCDgqrUwfjomk95OEsXmH6X9iwTyQXl7CPW85+3v4QcvR3PcE2rDTCjaA8+oUP1hw2s1JuHTAFkHYazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxdd05U+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43622267b2eso513415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733964465; x=1734569265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrjD1C7DWCCSENumePu2t3sjR50wPcC6aXcikSoHxpg=;
        b=gxdd05U+fcY5PqpYNeeuxIugzOi6xuAyXwKO9UPNF0HPOBlLiOcBS7qLNTLrFQZPkN
         azGfyGem3KUAGvIqLp1scSOwmnKd2TkKaMNkFhucStqgEwQzezbAeSzj6pMoVo8Sb0CN
         Xobq3wbyz4Hu/3rQdwqy+bxgvGsJAwgzNL/hUUPRJSDyRJJQoXLY3DO4CxGo/zryTTyl
         v8kNTaJBqPxp+LaO0hW/kHd5aU2m6ZVGe5QzwOEJqrnZ7jNcQz2ZzO8ROpICH9Xr3Hyj
         iQdCeCtQqiDcOJ6f7Agd/fxcXn3YnGWHq+mwlkitzCuF+ObHWLDBOBKsmtfAE0b5bjfm
         GcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964465; x=1734569265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrjD1C7DWCCSENumePu2t3sjR50wPcC6aXcikSoHxpg=;
        b=DF0wlJq+4QaxsPJYuM1JinjZENkaM09nvosjE9Ff8VU10pDF0BF2JFj+nPBoryeGix
         uprOZECP3ZJZB9VrQVrJLBhnOwBPHoaNB5dsbp4gyGwIQ9y4NZWROJINRMCu3EjH/Xwl
         lgIU/M4u7xfybhCaFDD5ssGg51F3HY02pLQbuLsCAIIMH2rnyRcyZgZl+72QlXqgwTrA
         Au63KyP9sYaudjCROzQIfODhNwuJYqptS51R7bfjP3DzM5SBLrSSdiOy2LohwRBRU7iE
         E8/CErC2AVRYMBalvj+bpPeV558MUIj4W4egq7WUFYgUPSb5NG7zbqExnLQzdOQuhHfN
         QC9A==
X-Forwarded-Encrypted: i=1; AJvYcCUyvec40JgwuzD3DUL+90CTOdXdEPblYcYT7PJ9+r1g8SjHbsowpO+lMSozRlDjWc9kuKd3XiVg9oKGYNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6O7JE+2ycErenoGDMfn/tJjFB0tq3A0FRU5SCeBugpArP1MV4
	jUZcXqTdXftmCsnse8raPYyBZ2wbz4p6D5wGdhYmY0l4v7KbFL2cuqkvHFTAW9s=
X-Gm-Gg: ASbGnct14bQTBaQfXfblaXbGhbhJyFBOaVRuxASbO6In6Aqfz8tbhFYWIBxtdlyqAQA
	LWN2daqN8UbjuMKLeNmcPITt99Ac0u3G4qQ974L0DVM1b4hRpKXvrEdwLyEWu9wFuF4ynKSfqdE
	M9GXOo5ly0t1j+99tU7R5upUlj16nC91sDja2q8HxoKt9h1FbgmsSuAq2BMOZnu5AEf+xI2s2Gn
	RGNNZ9WfcmFbNitZiXZPwgf6uo9AQAEs8yEigQ6WgahlaNB/+7achNKyhEIbqkFQgzu8vuX
X-Google-Smtp-Source: AGHT+IHe61DZMG3FgipyXReVwcoY5Aa1Hk5fRDtzl9H1XCItA8J0TpNmN/mbaTnfJoMTBh2/1CTqNQ==
X-Received: by 2002:a05:600c:468b:b0:434:fd15:3ac9 with SMTP id 5b1f17b1804b1-4361c3e3aacmr32236095e9.22.1733964464859;
        Wed, 11 Dec 2024 16:47:44 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ef4sm2459660f8f.39.2024.12.11.16.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:47:43 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] ASoC: codecs: wsa881x: split into common and soundwire drivers
Date: Thu, 12 Dec 2024 00:47:20 +0000
Message-ID: <20241212004727.2903846-8-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212004727.2903846-1-alexey.klimov@linaro.org>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required in order to introduce wsa881x driver that works
in analog mode and is configurable via i2c only.
Functional changes, if any, are kept to be minimal and common
parts or parts that can be shared are moved into wsa881x-common
helper driver.
The regmap config structure now contains 0x3000 offset as required
by soundwire spec.

While at this, also fix the typo in WSA881X_ADC_EN_SEL_IBIAS
register name and rename wsa881x_set_sdw_stream() to
wsa881x_set_stream().

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/Kconfig          |   4 +
 sound/soc/codecs/Makefile         |   2 +
 sound/soc/codecs/wsa881x-common.c | 123 ++++++++
 sound/soc/codecs/wsa881x-common.h | 406 ++++++++++++++++++++++++
 sound/soc/codecs/wsa881x.c        | 493 +-----------------------------
 5 files changed, 547 insertions(+), 481 deletions(-)
 create mode 100644 sound/soc/codecs/wsa881x-common.c
 create mode 100644 sound/soc/codecs/wsa881x-common.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f2df7c91e18..d1607384ea1b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2494,10 +2494,14 @@ config SND_SOC_WM9713
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
+config SND_SOC_WSA881X_COMMON
+	tristate
+
 config SND_SOC_WSA881X
 	tristate "WSA881X Codec"
 	depends on SOUNDWIRE
 	select REGMAP_SOUNDWIRE
+	select SND_SOC_WSA881X_COMMON
 	help
 	  This enables support for Qualcomm WSA8810/WSA8815 Class-D
 	  Smart Speaker Amplifier.
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d7ad795603c1..bde132fc9b37 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -400,6 +400,7 @@ snd-soc-wm9712-y := wm9712.o
 snd-soc-wm9713-y := wm9713.o
 snd-soc-wm-hubs-y := wm_hubs.o
 snd-soc-wsa881x-y := wsa881x.o
+snd-soc-wsa881x-common-y := wsa881x-common.o
 snd-soc-wsa883x-y := wsa883x.o
 snd-soc-wsa884x-y := wsa884x.o
 snd-soc-zl38060-y := zl38060.o
@@ -823,6 +824,7 @@ obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 obj-$(CONFIG_SND_SOC_WSA881X)	+= snd-soc-wsa881x.o
+obj-$(CONFIG_SND_SOC_WSA881X_COMMON)	+= snd-soc-wsa881x-common.o
 obj-$(CONFIG_SND_SOC_WSA883X)	+= snd-soc-wsa883x.o
 obj-$(CONFIG_SND_SOC_WSA884X)	+= snd-soc-wsa884x.o
 obj-$(CONFIG_SND_SOC_ZL38060)	+= snd-soc-zl38060.o
diff --git a/sound/soc/codecs/wsa881x-common.c b/sound/soc/codecs/wsa881x-common.c
new file mode 100644
index 000000000000..9f95830f0e83
--- /dev/null
+++ b/sound/soc/codecs/wsa881x-common.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+
+#include "wsa881x-common.h"
+
+int wsa881x_set_stream(struct snd_soc_dai *dai, void *stream, int direction)
+{
+#if IS_ENABLED(CONFIG_SND_SOC_WSA881X)
+	struct wsa881x_priv *wsa881x = dev_get_drvdata(dai->dev);
+
+	wsa881x->sruntime = stream;
+#endif
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wsa881x_set_stream);
+
+int wsa881x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *component = dai->component;
+
+	if (mute)
+		snd_soc_component_update_bits(component,
+					      WSA881X_SPKR_DRV_EN, 0x80, 0x00);
+	else
+		snd_soc_component_update_bits(component,
+					      WSA881X_SPKR_DRV_EN, 0x80, 0x80);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wsa881x_digital_mute);
+
+void wsa881x_init_common(struct wsa881x_priv *wsa881x)
+{
+	struct regmap *rm = wsa881x->regmap;
+	unsigned int val = 0;
+
+	/* Bring out of analog reset */
+	regmap_update_bits(rm, WSA881X_CDC_RST_CTL, 0x02, 0x02);
+
+	/* Bring out of digital reset */
+	regmap_update_bits(rm, WSA881X_CDC_RST_CTL, 0x01, 0x01);
+	regmap_update_bits(rm, WSA881X_CLOCK_CONFIG, 0x10, 0x10);
+	regmap_update_bits(rm, WSA881X_SPKR_OCP_CTL, 0x02, 0x02);
+	regmap_update_bits(rm, WSA881X_SPKR_MISC_CTL1, 0xC0, 0x80);
+	regmap_update_bits(rm, WSA881X_SPKR_MISC_CTL1, 0x06, 0x06);
+	regmap_update_bits(rm, WSA881X_SPKR_BIAS_INT, 0xFF, 0x00);
+	regmap_update_bits(rm, WSA881X_SPKR_PA_INT, 0xF0, 0x40);
+	regmap_update_bits(rm, WSA881X_SPKR_PA_INT, 0x0E, 0x0E);
+	regmap_update_bits(rm, WSA881X_BOOST_LOOP_STABILITY, 0x03, 0x03);
+	regmap_update_bits(rm, WSA881X_BOOST_MISC2_CTL, 0xFF, 0x14);
+	regmap_update_bits(rm, WSA881X_BOOST_START_CTL, 0x80, 0x80);
+	regmap_update_bits(rm, WSA881X_BOOST_START_CTL, 0x03, 0x00);
+	regmap_update_bits(rm, WSA881X_BOOST_SLOPE_COMP_ISENSE_FB, 0x0C, 0x04);
+	regmap_update_bits(rm, WSA881X_BOOST_SLOPE_COMP_ISENSE_FB, 0x03, 0x00);
+
+	regmap_read(rm, WSA881X_OTP_REG_0, &val);
+	if (val)
+		regmap_update_bits(rm, WSA881X_BOOST_PRESET_OUT1, 0xF0, 0x70);
+
+	regmap_update_bits(rm, WSA881X_BOOST_PRESET_OUT2, 0xF0, 0x30);
+	regmap_update_bits(rm, WSA881X_SPKR_DRV_EN, 0x08, 0x08);
+	regmap_update_bits(rm, WSA881X_BOOST_CURRENT_LIMIT, 0x0F, 0x08);
+	regmap_update_bits(rm, WSA881X_SPKR_OCP_CTL, 0x30, 0x30);
+	regmap_update_bits(rm, WSA881X_SPKR_OCP_CTL, 0x0C, 0x00);
+	regmap_update_bits(rm, WSA881X_OTP_REG_28, 0x3F, 0x3A);
+	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG1, 0xFF, 0xB2);
+	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG2, 0xFF, 0x05);
+}
+EXPORT_SYMBOL_GPL(wsa881x_init_common);
+
+int wsa881x_probe_common(struct wsa881x_priv **wsa881x, struct device *dev)
+{
+	struct wsa881x_priv *wsa;
+
+	wsa = devm_kzalloc(dev, sizeof(*wsa), GFP_KERNEL);
+	if (!wsa)
+		return -ENOMEM;
+
+	wsa->dev = dev;
+	wsa->sd_n = devm_gpiod_get_optional(dev, "powerdown",
+					    GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	if (IS_ERR(wsa->sd_n))
+		return dev_err_probe(dev, PTR_ERR(wsa->sd_n),
+				     "Shutdown Control GPIO not found\n");
+	/*
+	 * Backwards compatibility work-around.
+	 *
+	 * The SD_N GPIO is active low, however upstream DTS used always active
+	 * high.  Changing the flag in driver and DTS will break backwards
+	 * compatibility, so add a simple value inversion to work with both old
+	 * and new DTS.
+	 *
+	 * This won't work properly with DTS using the flags properly in cases:
+	 * 1. Old DTS with proper ACTIVE_LOW, however such case was broken
+	 *    before as the driver required the active high.
+	 * 2. New DTS with proper ACTIVE_HIGH (intended), which is rare case
+	 *    (not existing upstream) but possible. This is the price of
+	 *    backwards compatibility, therefore this hack should be removed at
+	 *    some point.
+	 */
+	wsa->sd_n_val = gpiod_is_active_low(wsa->sd_n);
+	if (!wsa->sd_n_val)
+		dev_warn(dev,
+			 "Using ACTIVE_HIGH for shutdown GPIO. Your DTB might be outdated or you use unsupported configuration for the GPIO.");
+
+	dev_set_drvdata(dev, wsa);
+	gpiod_direction_output(wsa->sd_n, !wsa->sd_n_val);
+
+	*wsa881x = wsa;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wsa881x_probe_common);
+
+MODULE_DESCRIPTION("WSA881x codec helper driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wsa881x-common.h b/sound/soc/codecs/wsa881x-common.h
new file mode 100644
index 000000000000..cf8643e1f7f7
--- /dev/null
+++ b/sound/soc/codecs/wsa881x-common.h
@@ -0,0 +1,406 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __WSA881x_COMMON_H__
+#define __WSA881x_COMMON_H__
+
+#include <linux/soundwire/sdw.h>
+#include <sound/soc.h>
+
+#define WSA881X_MAX_SWR_PORTS	4
+
+#define WSA881X_DIGITAL_BASE	0x0000
+#define WSA881X_ANALOG_BASE	0x0100
+
+/* Digital register address space */
+#define WSA881X_CHIP_ID0			(WSA881X_DIGITAL_BASE + 0x0000)
+#define WSA881X_CHIP_ID1			(WSA881X_DIGITAL_BASE + 0x0001)
+#define WSA881X_CHIP_ID2			(WSA881X_DIGITAL_BASE + 0x0002)
+#define WSA881X_CHIP_ID3			(WSA881X_DIGITAL_BASE + 0x0003)
+#define WSA881X_BUS_ID				(WSA881X_DIGITAL_BASE + 0x0004)
+#define WSA881X_CDC_RST_CTL			(WSA881X_DIGITAL_BASE + 0x0005)
+#define WSA881X_CDC_TOP_CLK_CTL			(WSA881X_DIGITAL_BASE + 0x0006)
+#define WSA881X_CDC_ANA_CLK_CTL			(WSA881X_DIGITAL_BASE + 0x0007)
+#define WSA881X_CDC_DIG_CLK_CTL			(WSA881X_DIGITAL_BASE + 0x0008)
+#define WSA881X_CLOCK_CONFIG			(WSA881X_DIGITAL_BASE + 0x0009)
+#define WSA881X_ANA_CTL				(WSA881X_DIGITAL_BASE + 0x000A)
+#define WSA881X_SWR_RESET_EN			(WSA881X_DIGITAL_BASE + 0x000B)
+#define WSA881X_RESET_CTL			(WSA881X_DIGITAL_BASE + 0x000C)
+#define WSA881X_TADC_VALUE_CTL			(WSA881X_DIGITAL_BASE + 0x000F)
+#define WSA881X_TEMP_DETECT_CTL			(WSA881X_DIGITAL_BASE + 0x0010)
+#define WSA881X_TEMP_MSB			(WSA881X_DIGITAL_BASE + 0x0011)
+#define WSA881X_TEMP_LSB			(WSA881X_DIGITAL_BASE + 0x0012)
+#define WSA881X_TEMP_CONFIG0			(WSA881X_DIGITAL_BASE + 0x0013)
+#define WSA881X_TEMP_CONFIG1			(WSA881X_DIGITAL_BASE + 0x0014)
+#define WSA881X_CDC_CLIP_CTL			(WSA881X_DIGITAL_BASE + 0x0015)
+#define WSA881X_SDM_PDM9_LSB			(WSA881X_DIGITAL_BASE + 0x0016)
+#define WSA881X_SDM_PDM9_MSB			(WSA881X_DIGITAL_BASE + 0x0017)
+#define WSA881X_CDC_RX_CTL			(WSA881X_DIGITAL_BASE + 0x0018)
+#define WSA881X_DEM_BYPASS_DATA0		(WSA881X_DIGITAL_BASE + 0x0019)
+#define WSA881X_DEM_BYPASS_DATA1		(WSA881X_DIGITAL_BASE + 0x001A)
+#define WSA881X_DEM_BYPASS_DATA2		(WSA881X_DIGITAL_BASE + 0x001B)
+#define WSA881X_DEM_BYPASS_DATA3		(WSA881X_DIGITAL_BASE + 0x001C)
+#define WSA881X_OTP_CTRL0			(WSA881X_DIGITAL_BASE + 0x001D)
+#define WSA881X_OTP_CTRL1			(WSA881X_DIGITAL_BASE + 0x001E)
+#define WSA881X_HDRIVE_CTL_GROUP1		(WSA881X_DIGITAL_BASE + 0x001F)
+#define WSA881X_INTR_MODE			(WSA881X_DIGITAL_BASE + 0x0020)
+#define WSA881X_INTR_MASK			(WSA881X_DIGITAL_BASE + 0x0021)
+#define WSA881X_INTR_STATUS			(WSA881X_DIGITAL_BASE + 0x0022)
+#define WSA881X_INTR_CLEAR			(WSA881X_DIGITAL_BASE + 0x0023)
+#define WSA881X_INTR_LEVEL			(WSA881X_DIGITAL_BASE + 0x0024)
+#define WSA881X_INTR_SET			(WSA881X_DIGITAL_BASE + 0x0025)
+#define WSA881X_INTR_TEST			(WSA881X_DIGITAL_BASE + 0x0026)
+#define WSA881X_PDM_TEST_MODE			(WSA881X_DIGITAL_BASE + 0x0030)
+#define WSA881X_ATE_TEST_MODE			(WSA881X_DIGITAL_BASE + 0x0031)
+#define WSA881X_PIN_CTL_MODE			(WSA881X_DIGITAL_BASE + 0x0032)
+#define WSA881X_PIN_CTL_OE			(WSA881X_DIGITAL_BASE + 0x0033)
+#define WSA881X_PIN_WDATA_IOPAD			(WSA881X_DIGITAL_BASE + 0x0034)
+#define WSA881X_PIN_STATUS			(WSA881X_DIGITAL_BASE + 0x0035)
+#define WSA881X_DIG_DEBUG_MODE			(WSA881X_DIGITAL_BASE + 0x0037)
+#define WSA881X_DIG_DEBUG_SEL			(WSA881X_DIGITAL_BASE + 0x0038)
+#define WSA881X_DIG_DEBUG_EN			(WSA881X_DIGITAL_BASE + 0x0039)
+#define WSA881X_SWR_HM_TEST1			(WSA881X_DIGITAL_BASE + 0x003B)
+#define WSA881X_SWR_HM_TEST2			(WSA881X_DIGITAL_BASE + 0x003C)
+#define WSA881X_TEMP_DETECT_DBG_CTL		(WSA881X_DIGITAL_BASE + 0x003D)
+#define WSA881X_TEMP_DEBUG_MSB			(WSA881X_DIGITAL_BASE + 0x003E)
+#define WSA881X_TEMP_DEBUG_LSB			(WSA881X_DIGITAL_BASE + 0x003F)
+#define WSA881X_SAMPLE_EDGE_SEL			(WSA881X_DIGITAL_BASE + 0x0044)
+#define WSA881X_IOPAD_CTL			(WSA881X_DIGITAL_BASE + 0x0045)
+#define WSA881X_SPARE_0				(WSA881X_DIGITAL_BASE + 0x0050)
+#define WSA881X_SPARE_1				(WSA881X_DIGITAL_BASE + 0x0051)
+#define WSA881X_SPARE_2				(WSA881X_DIGITAL_BASE + 0x0052)
+#define WSA881X_OTP_REG_0			(WSA881X_DIGITAL_BASE + 0x0080)
+#define WSA881X_OTP_REG_1			(WSA881X_DIGITAL_BASE + 0x0081)
+#define WSA881X_OTP_REG_2			(WSA881X_DIGITAL_BASE + 0x0082)
+#define WSA881X_OTP_REG_3			(WSA881X_DIGITAL_BASE + 0x0083)
+#define WSA881X_OTP_REG_4			(WSA881X_DIGITAL_BASE + 0x0084)
+#define WSA881X_OTP_REG_5			(WSA881X_DIGITAL_BASE + 0x0085)
+#define WSA881X_OTP_REG_6			(WSA881X_DIGITAL_BASE + 0x0086)
+#define WSA881X_OTP_REG_7			(WSA881X_DIGITAL_BASE + 0x0087)
+#define WSA881X_OTP_REG_8			(WSA881X_DIGITAL_BASE + 0x0088)
+#define WSA881X_OTP_REG_9			(WSA881X_DIGITAL_BASE + 0x0089)
+#define WSA881X_OTP_REG_10			(WSA881X_DIGITAL_BASE + 0x008A)
+#define WSA881X_OTP_REG_11			(WSA881X_DIGITAL_BASE + 0x008B)
+#define WSA881X_OTP_REG_12			(WSA881X_DIGITAL_BASE + 0x008C)
+#define WSA881X_OTP_REG_13			(WSA881X_DIGITAL_BASE + 0x008D)
+#define WSA881X_OTP_REG_14			(WSA881X_DIGITAL_BASE + 0x008E)
+#define WSA881X_OTP_REG_15			(WSA881X_DIGITAL_BASE + 0x008F)
+#define WSA881X_OTP_REG_16			(WSA881X_DIGITAL_BASE + 0x0090)
+#define WSA881X_OTP_REG_17			(WSA881X_DIGITAL_BASE + 0x0091)
+#define WSA881X_OTP_REG_18			(WSA881X_DIGITAL_BASE + 0x0092)
+#define WSA881X_OTP_REG_19			(WSA881X_DIGITAL_BASE + 0x0093)
+#define WSA881X_OTP_REG_20			(WSA881X_DIGITAL_BASE + 0x0094)
+#define WSA881X_OTP_REG_21			(WSA881X_DIGITAL_BASE + 0x0095)
+#define WSA881X_OTP_REG_22			(WSA881X_DIGITAL_BASE + 0x0096)
+#define WSA881X_OTP_REG_23			(WSA881X_DIGITAL_BASE + 0x0097)
+#define WSA881X_OTP_REG_24			(WSA881X_DIGITAL_BASE + 0x0098)
+#define WSA881X_OTP_REG_25			(WSA881X_DIGITAL_BASE + 0x0099)
+#define WSA881X_OTP_REG_26			(WSA881X_DIGITAL_BASE + 0x009A)
+#define WSA881X_OTP_REG_27			(WSA881X_DIGITAL_BASE + 0x009B)
+#define WSA881X_OTP_REG_28			(WSA881X_DIGITAL_BASE + 0x009C)
+#define WSA881X_OTP_REG_29			(WSA881X_DIGITAL_BASE + 0x009D)
+#define WSA881X_OTP_REG_30			(WSA881X_DIGITAL_BASE + 0x009E)
+#define WSA881X_OTP_REG_31			(WSA881X_DIGITAL_BASE + 0x009F)
+#define WSA881X_OTP_REG_63			(WSA881X_DIGITAL_BASE + 0x00BF)
+
+/* Analog Register address space */
+#define WSA881X_BIAS_REF_CTRL			(WSA881X_ANALOG_BASE + 0x0000)
+#define WSA881X_BIAS_TEST			(WSA881X_ANALOG_BASE + 0x0001)
+#define WSA881X_BIAS_BIAS			(WSA881X_ANALOG_BASE + 0x0002)
+#define WSA881X_TEMP_OP				(WSA881X_ANALOG_BASE + 0x0003)
+#define WSA881X_TEMP_IREF_CTRL			(WSA881X_ANALOG_BASE + 0x0004)
+#define WSA881X_TEMP_ISENS_CTRL			(WSA881X_ANALOG_BASE + 0x0005)
+#define WSA881X_TEMP_CLK_CTRL			(WSA881X_ANALOG_BASE + 0x0006)
+#define WSA881X_TEMP_TEST			(WSA881X_ANALOG_BASE + 0x0007)
+#define WSA881X_TEMP_BIAS			(WSA881X_ANALOG_BASE + 0x0008)
+#define WSA881X_TEMP_ADC_CTRL			(WSA881X_ANALOG_BASE + 0x0009)
+#define WSA881X_TEMP_DOUT_MSB			(WSA881X_ANALOG_BASE + 0x000A)
+#define WSA881X_TEMP_DOUT_LSB			(WSA881X_ANALOG_BASE + 0x000B)
+#define WSA881X_ADC_EN_MODU_V			(WSA881X_ANALOG_BASE + 0x0010)
+#define WSA881X_ADC_EN_MODU_I			(WSA881X_ANALOG_BASE + 0x0011)
+#define WSA881X_ADC_EN_DET_TEST_V		(WSA881X_ANALOG_BASE + 0x0012)
+#define WSA881X_ADC_EN_DET_TEST_I		(WSA881X_ANALOG_BASE + 0x0013)
+#define WSA881X_ADC_SEL_IBIAS			(WSA881X_ANALOG_BASE + 0x0014)
+#define WSA881X_ADC_EN_SEL_IBIAS		(WSA881X_ANALOG_BASE + 0x0015)
+#define WSA881X_SPKR_DRV_EN			(WSA881X_ANALOG_BASE + 0x001A)
+#define WSA881X_SPKR_DRV_GAIN			(WSA881X_ANALOG_BASE + 0x001B)
+#define WSA881X_PA_GAIN_SEL_MASK		BIT(3)
+#define WSA881X_PA_GAIN_SEL_REG			BIT(3)
+#define WSA881X_PA_GAIN_SEL_DRE			0
+#define WSA881X_SPKR_PAG_GAIN_MASK		GENMASK(7, 4)
+#define WSA881X_SPKR_DAC_CTL			(WSA881X_ANALOG_BASE + 0x001C)
+#define WSA881X_SPKR_DRV_DBG			(WSA881X_ANALOG_BASE + 0x001D)
+#define WSA881X_SPKR_PWRSTG_DBG			(WSA881X_ANALOG_BASE + 0x001E)
+#define WSA881X_SPKR_OCP_CTL			(WSA881X_ANALOG_BASE + 0x001F)
+#define WSA881X_SPKR_OCP_MASK			GENMASK(7, 6)
+#define WSA881X_SPKR_OCP_EN			BIT(7)
+#define WSA881X_SPKR_OCP_HOLD			BIT(6)
+#define WSA881X_SPKR_CLIP_CTL			(WSA881X_ANALOG_BASE + 0x0020)
+#define WSA881X_SPKR_BBM_CTL			(WSA881X_ANALOG_BASE + 0x0021)
+#define WSA881X_SPKR_MISC_CTL1			(WSA881X_ANALOG_BASE + 0x0022)
+#define WSA881X_SPKR_MISC_CTL2			(WSA881X_ANALOG_BASE + 0x0023)
+#define WSA881X_SPKR_BIAS_INT			(WSA881X_ANALOG_BASE + 0x0024)
+#define WSA881X_SPKR_PA_INT			(WSA881X_ANALOG_BASE + 0x0025)
+#define WSA881X_SPKR_BIAS_CAL			(WSA881X_ANALOG_BASE + 0x0026)
+#define WSA881X_SPKR_BIAS_PSRR			(WSA881X_ANALOG_BASE + 0x0027)
+#define WSA881X_SPKR_STATUS1			(WSA881X_ANALOG_BASE + 0x0028)
+#define WSA881X_SPKR_STATUS2			(WSA881X_ANALOG_BASE + 0x0029)
+#define WSA881X_BOOST_EN_CTL			(WSA881X_ANALOG_BASE + 0x002A)
+#define WSA881X_BOOST_EN_MASK			BIT(7)
+#define WSA881X_BOOST_EN			BIT(7)
+#define WSA881X_BOOST_CURRENT_LIMIT		(WSA881X_ANALOG_BASE + 0x002B)
+#define WSA881X_BOOST_PS_CTL			(WSA881X_ANALOG_BASE + 0x002C)
+#define WSA881X_BOOST_PRESET_OUT1		(WSA881X_ANALOG_BASE + 0x002D)
+#define WSA881X_BOOST_PRESET_OUT2		(WSA881X_ANALOG_BASE + 0x002E)
+#define WSA881X_BOOST_FORCE_OUT			(WSA881X_ANALOG_BASE + 0x002F)
+#define WSA881X_BOOST_LDO_PROG			(WSA881X_ANALOG_BASE + 0x0030)
+#define WSA881X_BOOST_SLOPE_COMP_ISENSE_FB	(WSA881X_ANALOG_BASE + 0x0031)
+#define WSA881X_BOOST_RON_CTL			(WSA881X_ANALOG_BASE + 0x0032)
+#define WSA881X_BOOST_LOOP_STABILITY		(WSA881X_ANALOG_BASE + 0x0033)
+#define WSA881X_BOOST_ZX_CTL			(WSA881X_ANALOG_BASE + 0x0034)
+#define WSA881X_BOOST_START_CTL			(WSA881X_ANALOG_BASE + 0x0035)
+#define WSA881X_BOOST_MISC1_CTL			(WSA881X_ANALOG_BASE + 0x0036)
+#define WSA881X_BOOST_MISC2_CTL			(WSA881X_ANALOG_BASE + 0x0037)
+#define WSA881X_BOOST_MISC3_CTL			(WSA881X_ANALOG_BASE + 0x0038)
+#define WSA881X_BOOST_ATEST_CTL			(WSA881X_ANALOG_BASE + 0x0039)
+#define WSA881X_SPKR_PROT_FE_GAIN		(WSA881X_ANALOG_BASE + 0x003A)
+#define WSA881X_SPKR_PROT_FE_CM_LDO_SET		(WSA881X_ANALOG_BASE + 0x003B)
+#define WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET1	(WSA881X_ANALOG_BASE + 0x003C)
+#define WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET2	(WSA881X_ANALOG_BASE + 0x003D)
+#define WSA881X_SPKR_PROT_ATEST1		(WSA881X_ANALOG_BASE + 0x003E)
+#define WSA881X_SPKR_PROT_ATEST2		(WSA881X_ANALOG_BASE + 0x003F)
+#define WSA881X_SPKR_PROT_FE_VSENSE_VCM		(WSA881X_ANALOG_BASE + 0x0040)
+#define WSA881X_SPKR_PROT_FE_VSENSE_BIAS_SET1	(WSA881X_ANALOG_BASE + 0x0041)
+#define WSA881X_BONGO_RESRV_REG1		(WSA881X_ANALOG_BASE + 0x0042)
+#define WSA881X_BONGO_RESRV_REG2		(WSA881X_ANALOG_BASE + 0x0043)
+#define WSA881X_SPKR_PROT_SAR			(WSA881X_ANALOG_BASE + 0x0044)
+#define WSA881X_SPKR_STATUS3			(WSA881X_ANALOG_BASE + 0x0045)
+
+/*
+ * Private data Structure for wsa881x. All parameters related to
+ * WSA881X codec needs to be defined here.
+ */
+struct wsa881x_priv {
+	struct regmap *regmap;
+	struct device *dev;
+
+#if IS_ENABLED(CONFIG_SND_SOC_WSA881X)
+	/* Soundwire interface */
+	struct sdw_slave *slave;
+	struct sdw_stream_config sconfig;
+	struct sdw_stream_runtime *sruntime;
+	struct sdw_port_config port_config[WSA881X_MAX_SWR_PORTS];
+	int active_ports;
+	bool port_prepared[WSA881X_MAX_SWR_PORTS];
+	bool port_enable[WSA881X_MAX_SWR_PORTS];
+#endif
+
+	struct gpio_desc *sd_n;
+	/*
+	 * Logical state for SD_N GPIO: high for shutdown, low for enable.
+	 * For backwards compatibility.
+	 */
+	unsigned int sd_n_val;
+};
+
+void wsa881x_init_common(struct wsa881x_priv *wsa881x);
+int wsa881x_probe_common(struct wsa881x_priv **wsa881x, struct device *dev);
+int wsa881x_digital_mute(struct snd_soc_dai *dai, int mute, int stream);
+int wsa881x_set_stream(struct snd_soc_dai *dai, void *stream, int direction);
+
+static inline bool wsa881x_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WSA881X_CHIP_ID0:
+	case WSA881X_CHIP_ID1:
+	case WSA881X_CHIP_ID2:
+	case WSA881X_CHIP_ID3:
+	case WSA881X_BUS_ID:
+	case WSA881X_CDC_RST_CTL:
+	case WSA881X_CDC_TOP_CLK_CTL:
+	case WSA881X_CDC_ANA_CLK_CTL:
+	case WSA881X_CDC_DIG_CLK_CTL:
+	case WSA881X_CLOCK_CONFIG:
+	case WSA881X_ANA_CTL:
+	case WSA881X_SWR_RESET_EN:
+	case WSA881X_RESET_CTL:
+	case WSA881X_TADC_VALUE_CTL:
+	case WSA881X_TEMP_DETECT_CTL:
+	case WSA881X_TEMP_MSB:
+	case WSA881X_TEMP_LSB:
+	case WSA881X_TEMP_CONFIG0:
+	case WSA881X_TEMP_CONFIG1:
+	case WSA881X_CDC_CLIP_CTL:
+	case WSA881X_SDM_PDM9_LSB:
+	case WSA881X_SDM_PDM9_MSB:
+	case WSA881X_CDC_RX_CTL:
+	case WSA881X_DEM_BYPASS_DATA0:
+	case WSA881X_DEM_BYPASS_DATA1:
+	case WSA881X_DEM_BYPASS_DATA2:
+	case WSA881X_DEM_BYPASS_DATA3:
+	case WSA881X_OTP_CTRL0:
+	case WSA881X_OTP_CTRL1:
+	case WSA881X_HDRIVE_CTL_GROUP1:
+	case WSA881X_INTR_MODE:
+	case WSA881X_INTR_MASK:
+	case WSA881X_INTR_STATUS:
+	case WSA881X_INTR_CLEAR:
+	case WSA881X_INTR_LEVEL:
+	case WSA881X_INTR_SET:
+	case WSA881X_INTR_TEST:
+	case WSA881X_PDM_TEST_MODE:
+	case WSA881X_ATE_TEST_MODE:
+	case WSA881X_PIN_CTL_MODE:
+	case WSA881X_PIN_CTL_OE:
+	case WSA881X_PIN_WDATA_IOPAD:
+	case WSA881X_PIN_STATUS:
+	case WSA881X_DIG_DEBUG_MODE:
+	case WSA881X_DIG_DEBUG_SEL:
+	case WSA881X_DIG_DEBUG_EN:
+	case WSA881X_SWR_HM_TEST1:
+	case WSA881X_SWR_HM_TEST2:
+	case WSA881X_TEMP_DETECT_DBG_CTL:
+	case WSA881X_TEMP_DEBUG_MSB:
+	case WSA881X_TEMP_DEBUG_LSB:
+	case WSA881X_SAMPLE_EDGE_SEL:
+	case WSA881X_IOPAD_CTL:
+	case WSA881X_SPARE_0:
+	case WSA881X_SPARE_1:
+	case WSA881X_SPARE_2:
+	case WSA881X_OTP_REG_0:
+	case WSA881X_OTP_REG_1:
+	case WSA881X_OTP_REG_2:
+	case WSA881X_OTP_REG_3:
+	case WSA881X_OTP_REG_4:
+	case WSA881X_OTP_REG_5:
+	case WSA881X_OTP_REG_6:
+	case WSA881X_OTP_REG_7:
+	case WSA881X_OTP_REG_8:
+	case WSA881X_OTP_REG_9:
+	case WSA881X_OTP_REG_10:
+	case WSA881X_OTP_REG_11:
+	case WSA881X_OTP_REG_12:
+	case WSA881X_OTP_REG_13:
+	case WSA881X_OTP_REG_14:
+	case WSA881X_OTP_REG_15:
+	case WSA881X_OTP_REG_16:
+	case WSA881X_OTP_REG_17:
+	case WSA881X_OTP_REG_18:
+	case WSA881X_OTP_REG_19:
+	case WSA881X_OTP_REG_20:
+	case WSA881X_OTP_REG_21:
+	case WSA881X_OTP_REG_22:
+	case WSA881X_OTP_REG_23:
+	case WSA881X_OTP_REG_24:
+	case WSA881X_OTP_REG_25:
+	case WSA881X_OTP_REG_26:
+	case WSA881X_OTP_REG_27:
+	case WSA881X_OTP_REG_28:
+	case WSA881X_OTP_REG_29:
+	case WSA881X_OTP_REG_30:
+	case WSA881X_OTP_REG_31:
+	case WSA881X_OTP_REG_63:
+	case WSA881X_BIAS_REF_CTRL:
+	case WSA881X_BIAS_TEST:
+	case WSA881X_BIAS_BIAS:
+	case WSA881X_TEMP_OP:
+	case WSA881X_TEMP_IREF_CTRL:
+	case WSA881X_TEMP_ISENS_CTRL:
+	case WSA881X_TEMP_CLK_CTRL:
+	case WSA881X_TEMP_TEST:
+	case WSA881X_TEMP_BIAS:
+	case WSA881X_TEMP_ADC_CTRL:
+	case WSA881X_TEMP_DOUT_MSB:
+	case WSA881X_TEMP_DOUT_LSB:
+	case WSA881X_ADC_EN_MODU_V:
+	case WSA881X_ADC_EN_MODU_I:
+	case WSA881X_ADC_EN_DET_TEST_V:
+	case WSA881X_ADC_EN_DET_TEST_I:
+	case WSA881X_ADC_SEL_IBIAS:
+	case WSA881X_ADC_EN_SEL_IBIAS:
+	case WSA881X_SPKR_DRV_EN:
+	case WSA881X_SPKR_DRV_GAIN:
+	case WSA881X_SPKR_DAC_CTL:
+	case WSA881X_SPKR_DRV_DBG:
+	case WSA881X_SPKR_PWRSTG_DBG:
+	case WSA881X_SPKR_OCP_CTL:
+	case WSA881X_SPKR_CLIP_CTL:
+	case WSA881X_SPKR_BBM_CTL:
+	case WSA881X_SPKR_MISC_CTL1:
+	case WSA881X_SPKR_MISC_CTL2:
+	case WSA881X_SPKR_BIAS_INT:
+	case WSA881X_SPKR_PA_INT:
+	case WSA881X_SPKR_BIAS_CAL:
+	case WSA881X_SPKR_BIAS_PSRR:
+	case WSA881X_SPKR_STATUS1:
+	case WSA881X_SPKR_STATUS2:
+	case WSA881X_BOOST_EN_CTL:
+	case WSA881X_BOOST_CURRENT_LIMIT:
+	case WSA881X_BOOST_PS_CTL:
+	case WSA881X_BOOST_PRESET_OUT1:
+	case WSA881X_BOOST_PRESET_OUT2:
+	case WSA881X_BOOST_FORCE_OUT:
+	case WSA881X_BOOST_LDO_PROG:
+	case WSA881X_BOOST_SLOPE_COMP_ISENSE_FB:
+	case WSA881X_BOOST_RON_CTL:
+	case WSA881X_BOOST_LOOP_STABILITY:
+	case WSA881X_BOOST_ZX_CTL:
+	case WSA881X_BOOST_START_CTL:
+	case WSA881X_BOOST_MISC1_CTL:
+	case WSA881X_BOOST_MISC2_CTL:
+	case WSA881X_BOOST_MISC3_CTL:
+	case WSA881X_BOOST_ATEST_CTL:
+	case WSA881X_SPKR_PROT_FE_GAIN:
+	case WSA881X_SPKR_PROT_FE_CM_LDO_SET:
+	case WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET1:
+	case WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET2:
+	case WSA881X_SPKR_PROT_ATEST1:
+	case WSA881X_SPKR_PROT_ATEST2:
+	case WSA881X_SPKR_PROT_FE_VSENSE_VCM:
+	case WSA881X_SPKR_PROT_FE_VSENSE_BIAS_SET1:
+	case WSA881X_BONGO_RESRV_REG1:
+	case WSA881X_BONGO_RESRV_REG2:
+	case WSA881X_SPKR_PROT_SAR:
+	case WSA881X_SPKR_STATUS3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool wsa881x_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WSA881X_CHIP_ID0:
+	case WSA881X_CHIP_ID1:
+	case WSA881X_CHIP_ID2:
+	case WSA881X_CHIP_ID3:
+	case WSA881X_BUS_ID:
+	case WSA881X_TEMP_MSB:
+	case WSA881X_TEMP_LSB:
+	case WSA881X_SDM_PDM9_LSB:
+	case WSA881X_SDM_PDM9_MSB:
+	case WSA881X_OTP_CTRL1:
+	case WSA881X_INTR_STATUS:
+	case WSA881X_ATE_TEST_MODE:
+	case WSA881X_PIN_STATUS:
+	case WSA881X_SWR_HM_TEST2:
+	case WSA881X_SPKR_STATUS1:
+	case WSA881X_SPKR_STATUS2:
+	case WSA881X_SPKR_STATUS3:
+	case WSA881X_OTP_REG_0:
+	case WSA881X_OTP_REG_1:
+	case WSA881X_OTP_REG_2:
+	case WSA881X_OTP_REG_3:
+	case WSA881X_OTP_REG_4:
+	case WSA881X_OTP_REG_5:
+	case WSA881X_OTP_REG_31:
+	case WSA881X_TEMP_DOUT_MSB:
+	case WSA881X_TEMP_DOUT_LSB:
+	case WSA881X_TEMP_OP:
+	case WSA881X_SPKR_PROT_SAR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+#endif /* __WSA881x_COMMON_H__ */
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index dd2d6661adc7..febe4d468174 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -15,172 +15,7 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
-#define WSA881X_DIGITAL_BASE		0x3000
-#define WSA881X_ANALOG_BASE		0x3100
-
-/* Digital register address space */
-#define WSA881X_CHIP_ID0			(WSA881X_DIGITAL_BASE + 0x0000)
-#define WSA881X_CHIP_ID1			(WSA881X_DIGITAL_BASE + 0x0001)
-#define WSA881X_CHIP_ID2			(WSA881X_DIGITAL_BASE + 0x0002)
-#define WSA881X_CHIP_ID3			(WSA881X_DIGITAL_BASE + 0x0003)
-#define WSA881X_BUS_ID				(WSA881X_DIGITAL_BASE + 0x0004)
-#define WSA881X_CDC_RST_CTL			(WSA881X_DIGITAL_BASE + 0x0005)
-#define WSA881X_CDC_TOP_CLK_CTL			(WSA881X_DIGITAL_BASE + 0x0006)
-#define WSA881X_CDC_ANA_CLK_CTL			(WSA881X_DIGITAL_BASE + 0x0007)
-#define WSA881X_CDC_DIG_CLK_CTL			(WSA881X_DIGITAL_BASE + 0x0008)
-#define WSA881X_CLOCK_CONFIG			(WSA881X_DIGITAL_BASE + 0x0009)
-#define WSA881X_ANA_CTL				(WSA881X_DIGITAL_BASE + 0x000A)
-#define WSA881X_SWR_RESET_EN			(WSA881X_DIGITAL_BASE + 0x000B)
-#define WSA881X_RESET_CTL			(WSA881X_DIGITAL_BASE + 0x000C)
-#define WSA881X_TADC_VALUE_CTL			(WSA881X_DIGITAL_BASE + 0x000F)
-#define WSA881X_TEMP_DETECT_CTL			(WSA881X_DIGITAL_BASE + 0x0010)
-#define WSA881X_TEMP_MSB			(WSA881X_DIGITAL_BASE + 0x0011)
-#define WSA881X_TEMP_LSB			(WSA881X_DIGITAL_BASE + 0x0012)
-#define WSA881X_TEMP_CONFIG0			(WSA881X_DIGITAL_BASE + 0x0013)
-#define WSA881X_TEMP_CONFIG1			(WSA881X_DIGITAL_BASE + 0x0014)
-#define WSA881X_CDC_CLIP_CTL			(WSA881X_DIGITAL_BASE + 0x0015)
-#define WSA881X_SDM_PDM9_LSB			(WSA881X_DIGITAL_BASE + 0x0016)
-#define WSA881X_SDM_PDM9_MSB			(WSA881X_DIGITAL_BASE + 0x0017)
-#define WSA881X_CDC_RX_CTL			(WSA881X_DIGITAL_BASE + 0x0018)
-#define WSA881X_DEM_BYPASS_DATA0		(WSA881X_DIGITAL_BASE + 0x0019)
-#define WSA881X_DEM_BYPASS_DATA1		(WSA881X_DIGITAL_BASE + 0x001A)
-#define WSA881X_DEM_BYPASS_DATA2		(WSA881X_DIGITAL_BASE + 0x001B)
-#define WSA881X_DEM_BYPASS_DATA3		(WSA881X_DIGITAL_BASE + 0x001C)
-#define WSA881X_OTP_CTRL0			(WSA881X_DIGITAL_BASE + 0x001D)
-#define WSA881X_OTP_CTRL1			(WSA881X_DIGITAL_BASE + 0x001E)
-#define WSA881X_HDRIVE_CTL_GROUP1		(WSA881X_DIGITAL_BASE + 0x001F)
-#define WSA881X_INTR_MODE			(WSA881X_DIGITAL_BASE + 0x0020)
-#define WSA881X_INTR_MASK			(WSA881X_DIGITAL_BASE + 0x0021)
-#define WSA881X_INTR_STATUS			(WSA881X_DIGITAL_BASE + 0x0022)
-#define WSA881X_INTR_CLEAR			(WSA881X_DIGITAL_BASE + 0x0023)
-#define WSA881X_INTR_LEVEL			(WSA881X_DIGITAL_BASE + 0x0024)
-#define WSA881X_INTR_SET			(WSA881X_DIGITAL_BASE + 0x0025)
-#define WSA881X_INTR_TEST			(WSA881X_DIGITAL_BASE + 0x0026)
-#define WSA881X_PDM_TEST_MODE			(WSA881X_DIGITAL_BASE + 0x0030)
-#define WSA881X_ATE_TEST_MODE			(WSA881X_DIGITAL_BASE + 0x0031)
-#define WSA881X_PIN_CTL_MODE			(WSA881X_DIGITAL_BASE + 0x0032)
-#define WSA881X_PIN_CTL_OE			(WSA881X_DIGITAL_BASE + 0x0033)
-#define WSA881X_PIN_WDATA_IOPAD			(WSA881X_DIGITAL_BASE + 0x0034)
-#define WSA881X_PIN_STATUS			(WSA881X_DIGITAL_BASE + 0x0035)
-#define WSA881X_DIG_DEBUG_MODE			(WSA881X_DIGITAL_BASE + 0x0037)
-#define WSA881X_DIG_DEBUG_SEL			(WSA881X_DIGITAL_BASE + 0x0038)
-#define WSA881X_DIG_DEBUG_EN			(WSA881X_DIGITAL_BASE + 0x0039)
-#define WSA881X_SWR_HM_TEST1			(WSA881X_DIGITAL_BASE + 0x003B)
-#define WSA881X_SWR_HM_TEST2			(WSA881X_DIGITAL_BASE + 0x003C)
-#define WSA881X_TEMP_DETECT_DBG_CTL		(WSA881X_DIGITAL_BASE + 0x003D)
-#define WSA881X_TEMP_DEBUG_MSB			(WSA881X_DIGITAL_BASE + 0x003E)
-#define WSA881X_TEMP_DEBUG_LSB			(WSA881X_DIGITAL_BASE + 0x003F)
-#define WSA881X_SAMPLE_EDGE_SEL			(WSA881X_DIGITAL_BASE + 0x0044)
-#define WSA881X_IOPAD_CTL			(WSA881X_DIGITAL_BASE + 0x0045)
-#define WSA881X_SPARE_0				(WSA881X_DIGITAL_BASE + 0x0050)
-#define WSA881X_SPARE_1				(WSA881X_DIGITAL_BASE + 0x0051)
-#define WSA881X_SPARE_2				(WSA881X_DIGITAL_BASE + 0x0052)
-#define WSA881X_OTP_REG_0			(WSA881X_DIGITAL_BASE + 0x0080)
-#define WSA881X_OTP_REG_1			(WSA881X_DIGITAL_BASE + 0x0081)
-#define WSA881X_OTP_REG_2			(WSA881X_DIGITAL_BASE + 0x0082)
-#define WSA881X_OTP_REG_3			(WSA881X_DIGITAL_BASE + 0x0083)
-#define WSA881X_OTP_REG_4			(WSA881X_DIGITAL_BASE + 0x0084)
-#define WSA881X_OTP_REG_5			(WSA881X_DIGITAL_BASE + 0x0085)
-#define WSA881X_OTP_REG_6			(WSA881X_DIGITAL_BASE + 0x0086)
-#define WSA881X_OTP_REG_7			(WSA881X_DIGITAL_BASE + 0x0087)
-#define WSA881X_OTP_REG_8			(WSA881X_DIGITAL_BASE + 0x0088)
-#define WSA881X_OTP_REG_9			(WSA881X_DIGITAL_BASE + 0x0089)
-#define WSA881X_OTP_REG_10			(WSA881X_DIGITAL_BASE + 0x008A)
-#define WSA881X_OTP_REG_11			(WSA881X_DIGITAL_BASE + 0x008B)
-#define WSA881X_OTP_REG_12			(WSA881X_DIGITAL_BASE + 0x008C)
-#define WSA881X_OTP_REG_13			(WSA881X_DIGITAL_BASE + 0x008D)
-#define WSA881X_OTP_REG_14			(WSA881X_DIGITAL_BASE + 0x008E)
-#define WSA881X_OTP_REG_15			(WSA881X_DIGITAL_BASE + 0x008F)
-#define WSA881X_OTP_REG_16			(WSA881X_DIGITAL_BASE + 0x0090)
-#define WSA881X_OTP_REG_17			(WSA881X_DIGITAL_BASE + 0x0091)
-#define WSA881X_OTP_REG_18			(WSA881X_DIGITAL_BASE + 0x0092)
-#define WSA881X_OTP_REG_19			(WSA881X_DIGITAL_BASE + 0x0093)
-#define WSA881X_OTP_REG_20			(WSA881X_DIGITAL_BASE + 0x0094)
-#define WSA881X_OTP_REG_21			(WSA881X_DIGITAL_BASE + 0x0095)
-#define WSA881X_OTP_REG_22			(WSA881X_DIGITAL_BASE + 0x0096)
-#define WSA881X_OTP_REG_23			(WSA881X_DIGITAL_BASE + 0x0097)
-#define WSA881X_OTP_REG_24			(WSA881X_DIGITAL_BASE + 0x0098)
-#define WSA881X_OTP_REG_25			(WSA881X_DIGITAL_BASE + 0x0099)
-#define WSA881X_OTP_REG_26			(WSA881X_DIGITAL_BASE + 0x009A)
-#define WSA881X_OTP_REG_27			(WSA881X_DIGITAL_BASE + 0x009B)
-#define WSA881X_OTP_REG_28			(WSA881X_DIGITAL_BASE + 0x009C)
-#define WSA881X_OTP_REG_29			(WSA881X_DIGITAL_BASE + 0x009D)
-#define WSA881X_OTP_REG_30			(WSA881X_DIGITAL_BASE + 0x009E)
-#define WSA881X_OTP_REG_31			(WSA881X_DIGITAL_BASE + 0x009F)
-#define WSA881X_OTP_REG_63			(WSA881X_DIGITAL_BASE + 0x00BF)
-
-/* Analog Register address space */
-#define WSA881X_BIAS_REF_CTRL			(WSA881X_ANALOG_BASE + 0x0000)
-#define WSA881X_BIAS_TEST			(WSA881X_ANALOG_BASE + 0x0001)
-#define WSA881X_BIAS_BIAS			(WSA881X_ANALOG_BASE + 0x0002)
-#define WSA881X_TEMP_OP				(WSA881X_ANALOG_BASE + 0x0003)
-#define WSA881X_TEMP_IREF_CTRL			(WSA881X_ANALOG_BASE + 0x0004)
-#define WSA881X_TEMP_ISENS_CTRL			(WSA881X_ANALOG_BASE + 0x0005)
-#define WSA881X_TEMP_CLK_CTRL			(WSA881X_ANALOG_BASE + 0x0006)
-#define WSA881X_TEMP_TEST			(WSA881X_ANALOG_BASE + 0x0007)
-#define WSA881X_TEMP_BIAS			(WSA881X_ANALOG_BASE + 0x0008)
-#define WSA881X_TEMP_ADC_CTRL			(WSA881X_ANALOG_BASE + 0x0009)
-#define WSA881X_TEMP_DOUT_MSB			(WSA881X_ANALOG_BASE + 0x000A)
-#define WSA881X_TEMP_DOUT_LSB			(WSA881X_ANALOG_BASE + 0x000B)
-#define WSA881X_ADC_EN_MODU_V			(WSA881X_ANALOG_BASE + 0x0010)
-#define WSA881X_ADC_EN_MODU_I			(WSA881X_ANALOG_BASE + 0x0011)
-#define WSA881X_ADC_EN_DET_TEST_V		(WSA881X_ANALOG_BASE + 0x0012)
-#define WSA881X_ADC_EN_DET_TEST_I		(WSA881X_ANALOG_BASE + 0x0013)
-#define WSA881X_ADC_SEL_IBIAS			(WSA881X_ANALOG_BASE + 0x0014)
-#define WSA881X_ADC_EN_SEL_IBAIS		(WSA881X_ANALOG_BASE + 0x0015)
-#define WSA881X_SPKR_DRV_EN			(WSA881X_ANALOG_BASE + 0x001A)
-#define WSA881X_SPKR_DRV_GAIN			(WSA881X_ANALOG_BASE + 0x001B)
-#define WSA881X_PA_GAIN_SEL_MASK		BIT(3)
-#define WSA881X_PA_GAIN_SEL_REG			BIT(3)
-#define WSA881X_PA_GAIN_SEL_DRE			0
-#define WSA881X_SPKR_PAG_GAIN_MASK		GENMASK(7, 4)
-#define WSA881X_SPKR_DAC_CTL			(WSA881X_ANALOG_BASE + 0x001C)
-#define WSA881X_SPKR_DRV_DBG			(WSA881X_ANALOG_BASE + 0x001D)
-#define WSA881X_SPKR_PWRSTG_DBG			(WSA881X_ANALOG_BASE + 0x001E)
-#define WSA881X_SPKR_OCP_CTL			(WSA881X_ANALOG_BASE + 0x001F)
-#define WSA881X_SPKR_OCP_MASK			GENMASK(7, 6)
-#define WSA881X_SPKR_OCP_EN			BIT(7)
-#define WSA881X_SPKR_OCP_HOLD			BIT(6)
-#define WSA881X_SPKR_CLIP_CTL			(WSA881X_ANALOG_BASE + 0x0020)
-#define WSA881X_SPKR_BBM_CTL			(WSA881X_ANALOG_BASE + 0x0021)
-#define WSA881X_SPKR_MISC_CTL1			(WSA881X_ANALOG_BASE + 0x0022)
-#define WSA881X_SPKR_MISC_CTL2			(WSA881X_ANALOG_BASE + 0x0023)
-#define WSA881X_SPKR_BIAS_INT			(WSA881X_ANALOG_BASE + 0x0024)
-#define WSA881X_SPKR_PA_INT			(WSA881X_ANALOG_BASE + 0x0025)
-#define WSA881X_SPKR_BIAS_CAL			(WSA881X_ANALOG_BASE + 0x0026)
-#define WSA881X_SPKR_BIAS_PSRR			(WSA881X_ANALOG_BASE + 0x0027)
-#define WSA881X_SPKR_STATUS1			(WSA881X_ANALOG_BASE + 0x0028)
-#define WSA881X_SPKR_STATUS2			(WSA881X_ANALOG_BASE + 0x0029)
-#define WSA881X_BOOST_EN_CTL			(WSA881X_ANALOG_BASE + 0x002A)
-#define WSA881X_BOOST_EN_MASK			BIT(7)
-#define WSA881X_BOOST_EN			BIT(7)
-#define WSA881X_BOOST_CURRENT_LIMIT		(WSA881X_ANALOG_BASE + 0x002B)
-#define WSA881X_BOOST_PS_CTL			(WSA881X_ANALOG_BASE + 0x002C)
-#define WSA881X_BOOST_PRESET_OUT1		(WSA881X_ANALOG_BASE + 0x002D)
-#define WSA881X_BOOST_PRESET_OUT2		(WSA881X_ANALOG_BASE + 0x002E)
-#define WSA881X_BOOST_FORCE_OUT			(WSA881X_ANALOG_BASE + 0x002F)
-#define WSA881X_BOOST_LDO_PROG			(WSA881X_ANALOG_BASE + 0x0030)
-#define WSA881X_BOOST_SLOPE_COMP_ISENSE_FB	(WSA881X_ANALOG_BASE + 0x0031)
-#define WSA881X_BOOST_RON_CTL			(WSA881X_ANALOG_BASE + 0x0032)
-#define WSA881X_BOOST_LOOP_STABILITY		(WSA881X_ANALOG_BASE + 0x0033)
-#define WSA881X_BOOST_ZX_CTL			(WSA881X_ANALOG_BASE + 0x0034)
-#define WSA881X_BOOST_START_CTL			(WSA881X_ANALOG_BASE + 0x0035)
-#define WSA881X_BOOST_MISC1_CTL			(WSA881X_ANALOG_BASE + 0x0036)
-#define WSA881X_BOOST_MISC2_CTL			(WSA881X_ANALOG_BASE + 0x0037)
-#define WSA881X_BOOST_MISC3_CTL			(WSA881X_ANALOG_BASE + 0x0038)
-#define WSA881X_BOOST_ATEST_CTL			(WSA881X_ANALOG_BASE + 0x0039)
-#define WSA881X_SPKR_PROT_FE_GAIN		(WSA881X_ANALOG_BASE + 0x003A)
-#define WSA881X_SPKR_PROT_FE_CM_LDO_SET		(WSA881X_ANALOG_BASE + 0x003B)
-#define WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET1	(WSA881X_ANALOG_BASE + 0x003C)
-#define WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET2	(WSA881X_ANALOG_BASE + 0x003D)
-#define WSA881X_SPKR_PROT_ATEST1		(WSA881X_ANALOG_BASE + 0x003E)
-#define WSA881X_SPKR_PROT_ATEST2		(WSA881X_ANALOG_BASE + 0x003F)
-#define WSA881X_SPKR_PROT_FE_VSENSE_VCM		(WSA881X_ANALOG_BASE + 0x0040)
-#define WSA881X_SPKR_PROT_FE_VSENSE_BIAS_SET1	(WSA881X_ANALOG_BASE + 0x0041)
-#define WSA881X_BONGO_RESRV_REG1		(WSA881X_ANALOG_BASE + 0x0042)
-#define WSA881X_BONGO_RESRV_REG2		(WSA881X_ANALOG_BASE + 0x0043)
-#define WSA881X_SPKR_PROT_SAR			(WSA881X_ANALOG_BASE + 0x0044)
-#define WSA881X_SPKR_STATUS3			(WSA881X_ANALOG_BASE + 0x0045)
+#include "wsa881x-common.h"
 
 #define SWRS_SCP_FRAME_CTRL_BANK(m)		(0x60 + 0x10 * (m))
 #define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m)	(0xE0 + 0x10 * (m))
@@ -191,7 +26,6 @@
 #define SWR_SLV_RD_BUF_LEN	8
 #define SWR_SLV_WR_BUF_LEN	32
 #define SWR_SLV_MAX_DEVICES	2
-#define WSA881X_MAX_SWR_PORTS   4
 #define WSA881X_VERSION_ENTRY_SIZE 27
 #define WSA881X_OCP_CTL_TIMER_SEC 2
 #define WSA881X_OCP_CTL_TEMP_CELSIUS 25
@@ -305,7 +139,7 @@ static struct reg_default wsa881x_defaults[] = {
 	{ WSA881X_ADC_EN_MODU_I, 0x00 },
 	{ WSA881X_ADC_EN_DET_TEST_V, 0x00 },
 	{ WSA881X_ADC_EN_DET_TEST_I, 0x00 },
-	{ WSA881X_ADC_EN_SEL_IBAIS, 0x10 },
+	{ WSA881X_ADC_EN_SEL_IBIAS, 0x10 },
 	{ WSA881X_SPKR_DRV_EN, 0x74 },
 	{ WSA881X_SPKR_DRV_DBG, 0x15 },
 	{ WSA881X_SPKR_PWRSTG_DBG, 0x00 },
@@ -439,204 +273,8 @@ static const struct sdw_port_config wsa881x_pconfig[WSA881X_MAX_SWR_PORTS] = {
 	},
 };
 
-static bool wsa881x_readable_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WSA881X_CHIP_ID0:
-	case WSA881X_CHIP_ID1:
-	case WSA881X_CHIP_ID2:
-	case WSA881X_CHIP_ID3:
-	case WSA881X_BUS_ID:
-	case WSA881X_CDC_RST_CTL:
-	case WSA881X_CDC_TOP_CLK_CTL:
-	case WSA881X_CDC_ANA_CLK_CTL:
-	case WSA881X_CDC_DIG_CLK_CTL:
-	case WSA881X_CLOCK_CONFIG:
-	case WSA881X_ANA_CTL:
-	case WSA881X_SWR_RESET_EN:
-	case WSA881X_RESET_CTL:
-	case WSA881X_TADC_VALUE_CTL:
-	case WSA881X_TEMP_DETECT_CTL:
-	case WSA881X_TEMP_MSB:
-	case WSA881X_TEMP_LSB:
-	case WSA881X_TEMP_CONFIG0:
-	case WSA881X_TEMP_CONFIG1:
-	case WSA881X_CDC_CLIP_CTL:
-	case WSA881X_SDM_PDM9_LSB:
-	case WSA881X_SDM_PDM9_MSB:
-	case WSA881X_CDC_RX_CTL:
-	case WSA881X_DEM_BYPASS_DATA0:
-	case WSA881X_DEM_BYPASS_DATA1:
-	case WSA881X_DEM_BYPASS_DATA2:
-	case WSA881X_DEM_BYPASS_DATA3:
-	case WSA881X_OTP_CTRL0:
-	case WSA881X_OTP_CTRL1:
-	case WSA881X_HDRIVE_CTL_GROUP1:
-	case WSA881X_INTR_MODE:
-	case WSA881X_INTR_MASK:
-	case WSA881X_INTR_STATUS:
-	case WSA881X_INTR_CLEAR:
-	case WSA881X_INTR_LEVEL:
-	case WSA881X_INTR_SET:
-	case WSA881X_INTR_TEST:
-	case WSA881X_PDM_TEST_MODE:
-	case WSA881X_ATE_TEST_MODE:
-	case WSA881X_PIN_CTL_MODE:
-	case WSA881X_PIN_CTL_OE:
-	case WSA881X_PIN_WDATA_IOPAD:
-	case WSA881X_PIN_STATUS:
-	case WSA881X_DIG_DEBUG_MODE:
-	case WSA881X_DIG_DEBUG_SEL:
-	case WSA881X_DIG_DEBUG_EN:
-	case WSA881X_SWR_HM_TEST1:
-	case WSA881X_SWR_HM_TEST2:
-	case WSA881X_TEMP_DETECT_DBG_CTL:
-	case WSA881X_TEMP_DEBUG_MSB:
-	case WSA881X_TEMP_DEBUG_LSB:
-	case WSA881X_SAMPLE_EDGE_SEL:
-	case WSA881X_IOPAD_CTL:
-	case WSA881X_SPARE_0:
-	case WSA881X_SPARE_1:
-	case WSA881X_SPARE_2:
-	case WSA881X_OTP_REG_0:
-	case WSA881X_OTP_REG_1:
-	case WSA881X_OTP_REG_2:
-	case WSA881X_OTP_REG_3:
-	case WSA881X_OTP_REG_4:
-	case WSA881X_OTP_REG_5:
-	case WSA881X_OTP_REG_6:
-	case WSA881X_OTP_REG_7:
-	case WSA881X_OTP_REG_8:
-	case WSA881X_OTP_REG_9:
-	case WSA881X_OTP_REG_10:
-	case WSA881X_OTP_REG_11:
-	case WSA881X_OTP_REG_12:
-	case WSA881X_OTP_REG_13:
-	case WSA881X_OTP_REG_14:
-	case WSA881X_OTP_REG_15:
-	case WSA881X_OTP_REG_16:
-	case WSA881X_OTP_REG_17:
-	case WSA881X_OTP_REG_18:
-	case WSA881X_OTP_REG_19:
-	case WSA881X_OTP_REG_20:
-	case WSA881X_OTP_REG_21:
-	case WSA881X_OTP_REG_22:
-	case WSA881X_OTP_REG_23:
-	case WSA881X_OTP_REG_24:
-	case WSA881X_OTP_REG_25:
-	case WSA881X_OTP_REG_26:
-	case WSA881X_OTP_REG_27:
-	case WSA881X_OTP_REG_28:
-	case WSA881X_OTP_REG_29:
-	case WSA881X_OTP_REG_30:
-	case WSA881X_OTP_REG_31:
-	case WSA881X_OTP_REG_63:
-	case WSA881X_BIAS_REF_CTRL:
-	case WSA881X_BIAS_TEST:
-	case WSA881X_BIAS_BIAS:
-	case WSA881X_TEMP_OP:
-	case WSA881X_TEMP_IREF_CTRL:
-	case WSA881X_TEMP_ISENS_CTRL:
-	case WSA881X_TEMP_CLK_CTRL:
-	case WSA881X_TEMP_TEST:
-	case WSA881X_TEMP_BIAS:
-	case WSA881X_TEMP_ADC_CTRL:
-	case WSA881X_TEMP_DOUT_MSB:
-	case WSA881X_TEMP_DOUT_LSB:
-	case WSA881X_ADC_EN_MODU_V:
-	case WSA881X_ADC_EN_MODU_I:
-	case WSA881X_ADC_EN_DET_TEST_V:
-	case WSA881X_ADC_EN_DET_TEST_I:
-	case WSA881X_ADC_SEL_IBIAS:
-	case WSA881X_ADC_EN_SEL_IBAIS:
-	case WSA881X_SPKR_DRV_EN:
-	case WSA881X_SPKR_DRV_GAIN:
-	case WSA881X_SPKR_DAC_CTL:
-	case WSA881X_SPKR_DRV_DBG:
-	case WSA881X_SPKR_PWRSTG_DBG:
-	case WSA881X_SPKR_OCP_CTL:
-	case WSA881X_SPKR_CLIP_CTL:
-	case WSA881X_SPKR_BBM_CTL:
-	case WSA881X_SPKR_MISC_CTL1:
-	case WSA881X_SPKR_MISC_CTL2:
-	case WSA881X_SPKR_BIAS_INT:
-	case WSA881X_SPKR_PA_INT:
-	case WSA881X_SPKR_BIAS_CAL:
-	case WSA881X_SPKR_BIAS_PSRR:
-	case WSA881X_SPKR_STATUS1:
-	case WSA881X_SPKR_STATUS2:
-	case WSA881X_BOOST_EN_CTL:
-	case WSA881X_BOOST_CURRENT_LIMIT:
-	case WSA881X_BOOST_PS_CTL:
-	case WSA881X_BOOST_PRESET_OUT1:
-	case WSA881X_BOOST_PRESET_OUT2:
-	case WSA881X_BOOST_FORCE_OUT:
-	case WSA881X_BOOST_LDO_PROG:
-	case WSA881X_BOOST_SLOPE_COMP_ISENSE_FB:
-	case WSA881X_BOOST_RON_CTL:
-	case WSA881X_BOOST_LOOP_STABILITY:
-	case WSA881X_BOOST_ZX_CTL:
-	case WSA881X_BOOST_START_CTL:
-	case WSA881X_BOOST_MISC1_CTL:
-	case WSA881X_BOOST_MISC2_CTL:
-	case WSA881X_BOOST_MISC3_CTL:
-	case WSA881X_BOOST_ATEST_CTL:
-	case WSA881X_SPKR_PROT_FE_GAIN:
-	case WSA881X_SPKR_PROT_FE_CM_LDO_SET:
-	case WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET1:
-	case WSA881X_SPKR_PROT_FE_ISENSE_BIAS_SET2:
-	case WSA881X_SPKR_PROT_ATEST1:
-	case WSA881X_SPKR_PROT_ATEST2:
-	case WSA881X_SPKR_PROT_FE_VSENSE_VCM:
-	case WSA881X_SPKR_PROT_FE_VSENSE_BIAS_SET1:
-	case WSA881X_BONGO_RESRV_REG1:
-	case WSA881X_BONGO_RESRV_REG2:
-	case WSA881X_SPKR_PROT_SAR:
-	case WSA881X_SPKR_STATUS3:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static bool wsa881x_volatile_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WSA881X_CHIP_ID0:
-	case WSA881X_CHIP_ID1:
-	case WSA881X_CHIP_ID2:
-	case WSA881X_CHIP_ID3:
-	case WSA881X_BUS_ID:
-	case WSA881X_TEMP_MSB:
-	case WSA881X_TEMP_LSB:
-	case WSA881X_SDM_PDM9_LSB:
-	case WSA881X_SDM_PDM9_MSB:
-	case WSA881X_OTP_CTRL1:
-	case WSA881X_INTR_STATUS:
-	case WSA881X_ATE_TEST_MODE:
-	case WSA881X_PIN_STATUS:
-	case WSA881X_SWR_HM_TEST2:
-	case WSA881X_SPKR_STATUS1:
-	case WSA881X_SPKR_STATUS2:
-	case WSA881X_SPKR_STATUS3:
-	case WSA881X_OTP_REG_0:
-	case WSA881X_OTP_REG_1:
-	case WSA881X_OTP_REG_2:
-	case WSA881X_OTP_REG_3:
-	case WSA881X_OTP_REG_4:
-	case WSA881X_OTP_REG_5:
-	case WSA881X_OTP_REG_31:
-	case WSA881X_TEMP_DOUT_MSB:
-	case WSA881X_TEMP_DOUT_LSB:
-	case WSA881X_TEMP_OP:
-	case WSA881X_SPKR_PROT_SAR:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static const struct regmap_config wsa881x_regmap_config = {
+	.reg_base = 0x3000,
 	.reg_bits = 32,
 	.val_bits = 8,
 	.cache_type = REGCACHE_MAPLE,
@@ -665,70 +303,15 @@ enum {
 	G_0DB,
 };
 
-/*
- * Private data Structure for wsa881x. All parameters related to
- * WSA881X codec needs to be defined here.
- */
-struct wsa881x_priv {
-	struct regmap *regmap;
-	struct device *dev;
-	struct sdw_slave *slave;
-	struct sdw_stream_config sconfig;
-	struct sdw_stream_runtime *sruntime;
-	struct sdw_port_config port_config[WSA881X_MAX_SWR_PORTS];
-	struct gpio_desc *sd_n;
-	/*
-	 * Logical state for SD_N GPIO: high for shutdown, low for enable.
-	 * For backwards compatibility.
-	 */
-	unsigned int sd_n_val;
-	int active_ports;
-	bool port_prepared[WSA881X_MAX_SWR_PORTS];
-	bool port_enable[WSA881X_MAX_SWR_PORTS];
-};
-
 static void wsa881x_init(struct wsa881x_priv *wsa881x)
 {
-	struct regmap *rm = wsa881x->regmap;
-	unsigned int val = 0;
-
 	regmap_register_patch(wsa881x->regmap, wsa881x_rev_2_0,
 			      ARRAY_SIZE(wsa881x_rev_2_0));
 
 	/* Enable software reset output from soundwire slave */
-	regmap_update_bits(rm, WSA881X_SWR_RESET_EN, 0x07, 0x07);
-
-	/* Bring out of analog reset */
-	regmap_update_bits(rm, WSA881X_CDC_RST_CTL, 0x02, 0x02);
-
-	/* Bring out of digital reset */
-	regmap_update_bits(rm, WSA881X_CDC_RST_CTL, 0x01, 0x01);
-	regmap_update_bits(rm, WSA881X_CLOCK_CONFIG, 0x10, 0x10);
-	regmap_update_bits(rm, WSA881X_SPKR_OCP_CTL, 0x02, 0x02);
-	regmap_update_bits(rm, WSA881X_SPKR_MISC_CTL1, 0xC0, 0x80);
-	regmap_update_bits(rm, WSA881X_SPKR_MISC_CTL1, 0x06, 0x06);
-	regmap_update_bits(rm, WSA881X_SPKR_BIAS_INT, 0xFF, 0x00);
-	regmap_update_bits(rm, WSA881X_SPKR_PA_INT, 0xF0, 0x40);
-	regmap_update_bits(rm, WSA881X_SPKR_PA_INT, 0x0E, 0x0E);
-	regmap_update_bits(rm, WSA881X_BOOST_LOOP_STABILITY, 0x03, 0x03);
-	regmap_update_bits(rm, WSA881X_BOOST_MISC2_CTL, 0xFF, 0x14);
-	regmap_update_bits(rm, WSA881X_BOOST_START_CTL, 0x80, 0x80);
-	regmap_update_bits(rm, WSA881X_BOOST_START_CTL, 0x03, 0x00);
-	regmap_update_bits(rm, WSA881X_BOOST_SLOPE_COMP_ISENSE_FB, 0x0C, 0x04);
-	regmap_update_bits(rm, WSA881X_BOOST_SLOPE_COMP_ISENSE_FB, 0x03, 0x00);
-
-	regmap_read(rm, WSA881X_OTP_REG_0, &val);
-	if (val)
-		regmap_update_bits(rm, WSA881X_BOOST_PRESET_OUT1, 0xF0, 0x70);
-
-	regmap_update_bits(rm, WSA881X_BOOST_PRESET_OUT2, 0xF0, 0x30);
-	regmap_update_bits(rm, WSA881X_SPKR_DRV_EN, 0x08, 0x08);
-	regmap_update_bits(rm, WSA881X_BOOST_CURRENT_LIMIT, 0x0F, 0x08);
-	regmap_update_bits(rm, WSA881X_SPKR_OCP_CTL, 0x30, 0x30);
-	regmap_update_bits(rm, WSA881X_SPKR_OCP_CTL, 0x0C, 0x00);
-	regmap_update_bits(rm, WSA881X_OTP_REG_28, 0x3F, 0x3A);
-	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG1, 0xFF, 0xB2);
-	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG2, 0xFF, 0x05);
+	regmap_update_bits(wsa881x->regmap, WSA881X_SWR_RESET_EN, 0x07, 0x07);
+
+	wsa881x_init_common(wsa881x);
 }
 
 static int wsa881x_component_probe(struct snd_soc_component *comp)
@@ -937,7 +520,7 @@ static int wsa881x_spkr_pa_event(struct snd_soc_dapm_widget *w,
 		if (wsa881x->port_prepared[WSA881X_PORT_VISENSE]) {
 			wsa881x_visense_txfe_ctrl(comp, true);
 			snd_soc_component_update_bits(comp,
-						      WSA881X_ADC_EN_SEL_IBAIS,
+						      WSA881X_ADC_EN_SEL_IBIAS,
 						      0x07, 0x01);
 			wsa881x_visense_adc_ctrl(comp, true);
 		}
@@ -1008,35 +591,11 @@ static int wsa881x_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int wsa881x_set_sdw_stream(struct snd_soc_dai *dai,
-				  void *stream, int direction)
-{
-	struct wsa881x_priv *wsa881x = dev_get_drvdata(dai->dev);
-
-	wsa881x->sruntime = stream;
-
-	return 0;
-}
-
-static int wsa881x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
-{
-	struct wsa881x_priv *wsa881x = dev_get_drvdata(dai->dev);
-
-	if (mute)
-		regmap_update_bits(wsa881x->regmap, WSA881X_SPKR_DRV_EN, 0x80,
-				   0x00);
-	else
-		regmap_update_bits(wsa881x->regmap, WSA881X_SPKR_DRV_EN, 0x80,
-				   0x80);
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops wsa881x_dai_ops = {
 	.hw_params = wsa881x_hw_params,
 	.hw_free = wsa881x_hw_free,
 	.mute_stream = wsa881x_digital_mute,
-	.set_stream = wsa881x_set_sdw_stream,
+	.set_stream = wsa881x_set_stream,
 };
 
 static struct snd_soc_dai_driver wsa881x_dais[] = {
@@ -1113,40 +672,13 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 {
 	struct wsa881x_priv *wsa881x;
 	struct device *dev = &pdev->dev;
+	int ret;
 
-	wsa881x = devm_kzalloc(dev, sizeof(*wsa881x), GFP_KERNEL);
-	if (!wsa881x)
-		return -ENOMEM;
-
-	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
-	if (IS_ERR(wsa881x->sd_n))
-		return dev_err_probe(dev, PTR_ERR(wsa881x->sd_n),
-				     "Shutdown Control GPIO not found\n");
-
-	/*
-	 * Backwards compatibility work-around.
-	 *
-	 * The SD_N GPIO is active low, however upstream DTS used always active
-	 * high.  Changing the flag in driver and DTS will break backwards
-	 * compatibility, so add a simple value inversion to work with both old
-	 * and new DTS.
-	 *
-	 * This won't work properly with DTS using the flags properly in cases:
-	 * 1. Old DTS with proper ACTIVE_LOW, however such case was broken
-	 *    before as the driver required the active high.
-	 * 2. New DTS with proper ACTIVE_HIGH (intended), which is rare case
-	 *    (not existing upstream) but possible. This is the price of
-	 *    backwards compatibility, therefore this hack should be removed at
-	 *    some point.
-	 */
-	wsa881x->sd_n_val = gpiod_is_active_low(wsa881x->sd_n);
-	if (!wsa881x->sd_n_val)
-		dev_warn(dev, "Using ACTIVE_HIGH for shutdown GPIO. Your DTB might be outdated or you use unsupported configuration for the GPIO.");
+	ret = wsa881x_probe_common(&wsa881x, dev);
+	if (ret)
+		return ret;
 
-	dev_set_drvdata(dev, wsa881x);
 	wsa881x->slave = pdev;
-	wsa881x->dev = dev;
 	wsa881x->sconfig.ch_count = 1;
 	wsa881x->sconfig.bps = 1;
 	wsa881x->sconfig.frame_rate = 48000;
@@ -1156,7 +688,6 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	pdev->prop.clk_stop_mode1 = true;
-	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
 	if (IS_ERR(wsa881x->regmap))
-- 
2.45.2



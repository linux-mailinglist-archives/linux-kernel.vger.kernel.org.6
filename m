Return-Path: <linux-kernel+bounces-181266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE58C79C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6D52826F2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B514D452;
	Thu, 16 May 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffmjIigc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02914E2DE;
	Thu, 16 May 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874567; cv=none; b=emPPh2jt+1aELKKh4Knrr9V+H55jZkubWjK+ppiJpNbAG659FwStWHDc2VATMi5nZf++2vCxw8eHKC0mgoIeYFIfvvdZGOr8nb+T27PGin8qDJYLdbqIZvb0/EQDDqVp9BmjzIDL0cqL5p6ardKEf5oJ6iHkXemz6AT9g9PHX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874567; c=relaxed/simple;
	bh=L1OmdelKiWK7aXJ30Feolp+tDRDOaxLZg/aACeZ9jOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcXeZx/DG2ZGT1R7HfsYlTKD8qsihtl9U/zFEZZVWOPFNk1+ycluZPyURiShJFC0jTJiLhHnXuvk8JQ8LWWKzmIJfY5Dddw70+PhMsdsU+Oz5QiIFHiHOkXCCkeQTC88X1n+w5irZxzUI6o5jdwsxgrGyDtc1xR/gvfDwQh867A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffmjIigc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59b178b75bso279134666b.0;
        Thu, 16 May 2024 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874563; x=1716479363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlNG2ig0xCzn4hWHGLSvJJhPcXRPCFCuvhEy8s/v1Cc=;
        b=ffmjIigcsGpjUSmF/sxwO6AhVdeJfeN6YEtyr5l+nQTqFj6t4Am32ORO1phpRHHHfC
         hlFAnz9ZQ6hqBOQxcn/9nUrd8FEB/5f9kICbj0JVwyvB78otygACY9FcktYei+gom+TT
         NbLVbZutaatuu5UVi10TwZgvFAbseod4lqg1tcXCd7cmN93uYQ6Ku3TJyKVRexaK8vK+
         uJOO8lKPM0mf166DBPkBgoV+uYAXleupEwitXNIppTv4zUTDry9FJNERzd7vQgZ5Lrhs
         U+cJMjoCAmX27XDE6NC3/dbWAw8+1P0W32uL77uhiJ1qBGJKRbT53EnPSFoE24vBnA5E
         vtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874563; x=1716479363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlNG2ig0xCzn4hWHGLSvJJhPcXRPCFCuvhEy8s/v1Cc=;
        b=wXJLxY7M7cS8IZ1HhSTpGUIYbGmZfdSwFmkPZrwybIf9IX7zwsFsCTWHSrywvZzddR
         3D7oqz7kJNlBrtvRLrsTneEKJ1beGIW734eEvjzDqdfGYP7RwB5kogjZrxS4t6kdxsFj
         U4WpJXGLjhdG8uWuR5Yh0KBU4Amfsc0zbuz3rth8ZpAy7l8tSZhlcH5mDyCV0ohm9Kpm
         EHrOpOdFdZuTKhFLfSx5zdFDoyWpzqcXcuz9XhTglUc54wcBHXYbWtPOZIs83B0MoFEf
         OTS/VQsGvUPEnYierShynmnveaEQa7jG61K2KYvSKkEN+CC1d4UQmkljltiIJ+5YW3zd
         BgJg==
X-Forwarded-Encrypted: i=1; AJvYcCUv2zhlQin55L83H8oPXXf49Sq2w+w706f3i1hQFVYmfofsMJN45byH0WM/kXhJ72X7QFZ/0Q3bbI32afqsWbdOhUtC78/FW2g0lPjdo3wvSL7OzmIg7RWnvaJJm/MnRtsYMeH8yBwnNg==
X-Gm-Message-State: AOJu0YwIG52cPbhS2ZrC1n8xrUW/Ghp0ocFnGa2cbnGF7PHMM9Dp2Vsl
	PB7281LFDDi9A2QycyrKYDofgp1FlMbDnQiOkvIRKC0vJnBdgjCx
X-Google-Smtp-Source: AGHT+IEac1CRj1+i+kfDcdqTYK2NtdDbw7H1UKvqrmnnACYUeSctRQrdjByRPi1BG6LkpuD0Bmk6aw==
X-Received: by 2002:a17:906:4086:b0:a59:c52b:9936 with SMTP id a640c23a62f3a-a5a2d5c85f1mr1330366266b.26.1715874562373;
        Thu, 16 May 2024 08:49:22 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a5ecd37a3sm613165766b.79.2024.05.16.08.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:22 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v2 2/2] ASoC: codecs: es8311: add everest es8311 codec support
Date: Thu, 16 May 2024 17:43:31 +0200
Message-ID: <20240516154800.125284-3-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516154800.125284-1-matteomartelli3@gmail.com>
References: <20240516154800.125284-1-matteomartelli3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Everest-semi ES8311 codec.

Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
interface and I2C control.

Supported features:
* Both master and slave mode. Master clock is optional in slave mode.
* Sample rates from 8KHz to 96KHz.
* Sample formats: S16_LE, S18_3LE, S20_3LE, S24_3LE, S24_LE and S32_LE.
* I2S formats: I2S, LEFT_J, DSP_A, DSP_B.
* BCLK and FSYNC clocks inversion.
* Component suspend/resume.
* ADC, PGA, DAC controls.
* ADC DSP controls: volume, fade (ramp rate), ALC, automute, HPF, EQ.
* DAC DSP controls: volume, fade (ramp rate), DRC, EQ.
* DAPM routes: capture path with input source selection (differential
  MIC/DMIC) and AIF channel source selection; playback path with DAC
  channel source selection.

Limitations:
* Support only for master clocks with a ratio of ADC (or DAC) clock to
  LRCLK equal to 256. This to keep the default ADC and DAC oversampling
  and ADC scale settings. Anyway all 8-96KHz sample rates are supported
  when the ratio of MCLK to sample rate is 32, 64, 128, 256, 384 or 512
  (upper limit due to max MCLK freq of 49.2MHz).
* Coefficients for ADC HPF and ADC/DAC EQ not supported.
* Digital mic supported but not tested.
* S18_3LE, S20_3LE and S24_3LE formats supported but not tested.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 sound/soc/codecs/Kconfig  |   4 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/es8311.c | 970 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/es8311.h | 162 +++++++
 4 files changed, 1138 insertions(+)
 create mode 100644 sound/soc/codecs/es8311.c
 create mode 100644 sound/soc/codecs/es8311.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f78ea2f86fa6..206b8210a2b4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1099,6 +1099,10 @@ config SND_SOC_ES83XX_DSM_COMMON
 	depends on ACPI
 	tristate
 
+config SND_SOC_ES8311
+	tristate "Everest Semi ES8311 CODEC"
+	depends on I2C
+
 config SND_SOC_ES8316
 	tristate "Everest Semi ES8316 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 7c075539dc47..5e284134228e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -119,6 +119,7 @@ snd-soc-dmic-objs := dmic.o
 snd-soc-es7134-objs := es7134.o
 snd-soc-es7241-objs := es7241.o
 snd-soc-es83xx-dsm-common-objs := es83xx-dsm-common.o
+snd-soc-es8311-objs := es8311.o
 snd-soc-es8316-objs := es8316.o
 snd-soc-es8326-objs := es8326.o
 snd-soc-es8328-objs := es8328.o
@@ -514,6 +515,7 @@ obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES7134)	+= snd-soc-es7134.o
 obj-$(CONFIG_SND_SOC_ES7241)	+= snd-soc-es7241.o
 obj-$(CONFIG_SND_SOC_ES83XX_DSM_COMMON)    += snd-soc-es83xx-dsm-common.o
+obj-$(CONFIG_SND_SOC_ES8311)    += snd-soc-es8311.o
 obj-$(CONFIG_SND_SOC_ES8316)    += snd-soc-es8316.o
 obj-$(CONFIG_SND_SOC_ES8326)    += snd-soc-es8326.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
diff --git a/sound/soc/codecs/es8311.c b/sound/soc/codecs/es8311.c
new file mode 100644
index 000000000000..b2ee2d04b0e4
--- /dev/null
+++ b/sound/soc/codecs/es8311.c
@@ -0,0 +1,970 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * es8311.c -- es8311 ALSA SoC audio driver
+ *
+ * Copyright (C) 2024 Matteo Martelli <matteomartelli3@gmail.com>
+ *
+ * Author: Matteo Martelli <matteomartelli3@gmail.com>
+ */
+
+#include "linux/array_size.h"
+#include "sound/pcm.h"
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include "es8311.h"
+
+#define ES8311_NUM_RATES 10
+#define ES8311_RATES (SNDRV_PCM_RATE_8000_96000)
+#define ES8311_FORMATS                                         \
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE |  \
+	 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_3LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct es8311_priv {
+	struct regmap *regmap;
+	struct clk *mclk;
+	unsigned long mclk_freq;
+	bool provider;
+	unsigned int rates[ES8311_NUM_RATES];
+	struct snd_pcm_hw_constraint_list constraints;
+};
+
+static const DECLARE_TLV_DB_SCALE(es8311_adc_vol_tlv, -9550, 50, 0);
+static const DECLARE_TLV_DB_SCALE(es8311_pga_gain_tlv, 0, 300, 0);
+static const DECLARE_TLV_DB_SCALE(es8311_adc_scale_tlv, 0, 600, 0);
+
+#define ES8311_DB_LRCK_STEPS \
+	"0.25db/4LRCK", \
+	"0.25db/8LRCK", \
+	"0.25db/16LRCK", \
+	"0.25db/32LRCK", \
+	"0.25db/64LRCK", \
+	"0.25db/128LRCK", \
+	"0.25db/256LRCK", \
+	"0.25db/512LRCK", \
+	"0.25db/1024LRCK", \
+	"0.25db/2048LRCK", \
+	"0.25db/4096LRCK", \
+	"0.25db/8192LRCK", \
+	"0.25db/16384LRCK", \
+	"0.25db/32768LRCK", \
+	"0.25db/65536LRCK",
+
+static const char *const es8311_level_winsize_txt[] = {
+	"0.25db/2LRCK",
+	ES8311_DB_LRCK_STEPS
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	es8311_alc_winsize, ES8311_ADC4,
+	ES8311_ADC4_ALC_WINSIZE_SHIFT, es8311_level_winsize_txt);
+static const DECLARE_TLV_DB_RANGE(es8311_level_tlv,
+	0, 1, TLV_DB_SCALE_ITEM(-3010, 600, 0),
+	2, 3, TLV_DB_SCALE_ITEM(-2060, 250, 0),
+	4, 5, TLV_DB_SCALE_ITEM(-1610, 160, 0),
+	6, 7, TLV_DB_SCALE_ITEM(-1320, 120, 0),
+	8, 9, TLV_DB_SCALE_ITEM(-1100, 90, 0),
+	10, 11, TLV_DB_SCALE_ITEM(-930, 80, 0),
+	12, 15, TLV_DB_SCALE_ITEM(-780, 60, 0),
+);
+
+static const char *const es8311_ramprate_txt[] = {
+	"Disabled",
+	ES8311_DB_LRCK_STEPS
+};
+static SOC_ENUM_SINGLE_DECL(
+	es8311_adc_ramprate, ES8311_ADC1,
+	ES8311_ADC1_RAMPRATE_SHIFT, es8311_ramprate_txt);
+
+static const char *const es8311_automute_winsize_txt[] = {
+	"2048 samples",
+	"4096 samples",
+	"6144 samples",
+	"8192 samples",
+	"10240 samples",
+	"12288 samples",
+	"14336 samples",
+	"16384 samples",
+	"18432 samples",
+	"20480 samples",
+	"22528 samples",
+	"24576 samples",
+	"26624 samples",
+	"28672 samples",
+	"30720 samples",
+	"32768 samples",
+};
+static SOC_ENUM_SINGLE_DECL(
+	es8311_automute_winsize, ES8311_ADC6,
+	ES8311_ADC6_AUTOMUTE_WS_SHIFT, es8311_automute_winsize_txt);
+static const DECLARE_TLV_DB_RANGE(es8311_automute_ng_tlv,
+	0, 7, TLV_DB_SCALE_ITEM(-9600, 600, 0),
+	8, 15, TLV_DB_SCALE_ITEM(-5100, 300, 0),
+);
+static const DECLARE_TLV_DB_SCALE(es8311_automute_vol_tlv, -2800, 400, 0);
+
+static const DECLARE_TLV_DB_SCALE(es8311_dac_vol_tlv, -9550, 50, 0);
+static SOC_ENUM_SINGLE_DECL(
+	es8311_drc_winsize, ES8311_DAC4,
+	ES8311_DAC4_DRC_WINSIZE_SHIFT, es8311_level_winsize_txt);
+static SOC_ENUM_SINGLE_DECL(
+	es8311_dac_ramprate, ES8311_DAC6,
+	ES8311_DAC6_RAMPRATE_SHIFT, es8311_ramprate_txt);
+
+static const char *const es8311_out_mode_txt[] = {
+	"Lineout",
+	"Headphones"
+};
+static SOC_ENUM_SINGLE_DECL(
+	es8311_out_mode, ES8311_SYS9,
+	ES8311_SYS9_HPSW_SHIFT, es8311_out_mode_txt);
+
+static const struct snd_kcontrol_new es8311_snd_controls[] = {
+	/* Capture path */
+	SOC_SINGLE_TLV("PGA Capture Volume", ES8311_SYS10,
+		       ES8311_SYS10_PGAGAIN_SHIFT, ES8311_SYS10_PGAGAIN_MAX, 0,
+		       es8311_pga_gain_tlv),
+	SOC_SINGLE("ADC Polarity Invert Capture Switch", ES8311_ADC2,
+		   ES8311_ADC2_INV_SHIFT, 1, 0),
+	SOC_SINGLE_TLV("ADC Scale Capture Volume", ES8311_ADC2,
+		       ES8311_ADC2_SCALE_SHIFT, ES8311_ADC2_SCALE_MAX, 0,
+		       es8311_adc_scale_tlv),
+	SOC_SINGLE_TLV("ADC Capture Volume", ES8311_ADC3,
+		       ES8311_ADC3_VOLUME_SHIFT, ES8311_ADC3_VOLUME_MAX, 0,
+		       es8311_adc_vol_tlv),
+	SOC_ENUM("ADC Capture Ramp Rate", es8311_adc_ramprate),
+	SOC_SINGLE("ADC Automute Capture Switch", ES8311_ADC4,
+		   ES8311_ADC4_AUTOMUTE_EN_SHIFT, 1, 0),
+	SOC_ENUM("ADC Automute Capture Winsize", es8311_automute_winsize),
+	SOC_SINGLE_TLV("ADC Automute Noise Gate Capture Volume", ES8311_ADC6,
+		       ES8311_ADC6_AUTOMUTE_NG_SHIFT,
+		       ES8311_ADC6_AUTOMUTE_NG_MAX, 0, es8311_automute_ng_tlv),
+	SOC_SINGLE_TLV("ADC Automute Capture Volume", ES8311_ADC7,
+		       ES8311_ADC7_AUTOMUTE_VOL_SHIFT,
+		       ES8311_ADC7_AUTOMUTE_VOL_MAX, 0,
+		       es8311_automute_vol_tlv),
+	SOC_SINGLE("ADC HPF Capture Switch", ES8311_ADC8, ES8311_ADC8_HPF_SHIFT,
+		   1, 0),
+	SOC_SINGLE("ADC EQ Capture Switch", ES8311_ADC8,
+		   ES8311_ADC8_EQBYPASS_SHIFT, 1, 1),
+	SOC_SINGLE("ALC Capture Switch", ES8311_ADC4, ES8311_ADC4_ALC_EN_SHIFT,
+		   1, 0),
+	SOC_SINGLE_TLV("ALC Capture Max Volume", ES8311_ADC5,
+		       ES8311_ADC5_ALC_MAXLEVEL_SHIFT,
+		       ES8311_ADC5_ALC_MAXLEVEL_MAX, 0, es8311_level_tlv),
+	SOC_SINGLE_TLV("ALC Capture Min Volume", ES8311_ADC5,
+		       ES8311_ADC5_ALC_MINLEVEL_SHIFT,
+		       ES8311_ADC5_ALC_MINLEVEL_MAX, 0, es8311_level_tlv),
+	SOC_ENUM("ALC Capture Winsize", es8311_alc_winsize),
+
+	/* Playback path */
+	SOC_SINGLE_TLV("DAC Playback Volume", ES8311_DAC2, 0,
+		       ES8311_DAC2_VOLUME_MAX, 0, es8311_dac_vol_tlv),
+	SOC_SINGLE("DRC Playback Switch", ES8311_DAC4, ES8311_DAC4_DRC_EN_SHIFT,
+		   1, 0),
+	SOC_SINGLE_TLV("DRC Playback Max Volume", ES8311_DAC5,
+		       ES8311_DAC5_DRC_MAXLEVEL_SHIFT,
+		       ES8311_DAC5_DRC_MAXLEVEL_MAX, 0, es8311_level_tlv),
+	SOC_SINGLE_TLV("DRC Playback Min Volume", ES8311_DAC5,
+		       ES8311_DAC5_DRC_MINLEVEL_SHIFT,
+		       ES8311_DAC5_DRC_MINLEVEL_MAX, 0, es8311_level_tlv),
+	SOC_ENUM("DRC Playback Winsize", es8311_drc_winsize),
+	SOC_ENUM("DAC Playback Ramp Rate", es8311_dac_ramprate),
+	SOC_SINGLE("DAC EQ Playback Switch", ES8311_DAC6,
+		   ES8311_DAC6_EQBYPASS_SHIFT, 1, 1),
+
+	SOC_ENUM("Output Mode", es8311_out_mode),
+};
+
+static const char *const es8311_diff_src_txt[] = {
+	"Disabled",
+	"MIC1P-MIC1N",
+};
+static SOC_ENUM_SINGLE_DECL(
+	es8311_diff_src_enum, ES8311_SYS10,
+	ES8311_SYS10_LINESEL_SHIFT, es8311_diff_src_txt);
+static const struct snd_kcontrol_new es8311_diff_src_mux =
+	SOC_DAPM_ENUM("Differential Source", es8311_diff_src_enum);
+
+static const char *const es8311_dmic_src_txt[] = {
+	"Disabled",
+	"DMIC from MIC1P",
+};
+static SOC_ENUM_SINGLE_DECL(
+	es8311_dmic_src_enum, ES8311_SYS10,
+	ES8311_SYS10_DMIC_ON_SHIFT, es8311_dmic_src_txt);
+static const struct snd_kcontrol_new es8311_dmic_src_mux =
+	SOC_DAPM_ENUM("Digital Mic Source", es8311_dmic_src_enum);
+
+static const char * const es8311_aif1tx_src_txt[] = {
+	"ADC + ADC",
+	"ADC + 0",
+	"0 + ADC",
+	"0 + 0",
+	"DACL + ADC",
+	"ADC + DACR",
+	"DACL + DACR",
+};
+static SOC_ENUM_SINGLE_DECL(
+	es8311_aif1tx_src_enum, ES8311_GPIO,
+	ES8311_GPIO_ADCDAT_SEL_SHIFT, es8311_aif1tx_src_txt);
+static const struct snd_kcontrol_new es8311_aif1tx_src_mux =
+	SOC_DAPM_ENUM("AIF1TX Source", es8311_aif1tx_src_enum);
+
+static const char * const es8311_dac_src_txt[] = {
+	"Left",
+	"Right"
+};
+static SOC_ENUM_SINGLE_DECL(
+	es8311_dac_src_enum, ES8311_SDP_IN,
+	ES8311_SDP_IN_SEL_SHIFT, es8311_dac_src_txt);
+static const struct snd_kcontrol_new es8311_dac_src_mux =
+	SOC_DAPM_ENUM("Mono DAC Source", es8311_dac_src_enum);
+
+static const struct snd_soc_dapm_widget es8311_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("Bias", ES8311_SYS3, ES8311_SYS3_PDN_IBIASGEN_SHIFT,
+			    1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Analog power", ES8311_SYS3,
+			    ES8311_SYS3_PDN_ANA_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Vref", ES8311_SYS3, ES8311_SYS3_PDN_VREF_SHIFT, 1,
+			    NULL, 0),
+
+	/* Capture path */
+	SND_SOC_DAPM_INPUT("DMIC"),
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_MUX("Differential Mux", SND_SOC_NOPM, 0, 0,
+			 &es8311_diff_src_mux),
+	SND_SOC_DAPM_SUPPLY("ADC Bias Gen", ES8311_SYS3,
+			    ES8311_SYS3_PDN_ADCBIASGEN_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC Vref Gen", ES8311_SYS3,
+			    ES8311_SYS3_PDN_ADCVREFGEN_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC Clock", ES8311_CLKMGR1,
+			    ES8311_CLKMGR1_CLKADC_ON_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC Analog Clock", ES8311_CLKMGR1,
+			    ES8311_CLKMGR1_ANACLKADC_ON_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("PGA", ES8311_SYS4, ES8311_SYS4_PDN_PGA_SHIFT, 1, NULL,
+			 0),
+	SND_SOC_DAPM_ADC("Mono ADC", NULL, ES8311_SYS4,
+			 ES8311_SYS4_PDN_MOD_SHIFT, 1),
+	SND_SOC_DAPM_MUX("Digital Mic Mux", SND_SOC_NOPM, 0, 0,
+			 &es8311_dmic_src_mux),
+	SND_SOC_DAPM_MUX("AIF1TX Source Mux", SND_SOC_NOPM, 0, 0,
+			 &es8311_aif1tx_src_mux),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, ES8311_SDP_OUT,
+			     ES8311_SDP_MUTE_SHIFT, 1),
+
+	/* Playback path */
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, ES8311_SDP_IN,
+			    ES8311_SDP_MUTE_SHIFT, 1),
+	SND_SOC_DAPM_MUX("Mono DAC Source Mux", SND_SOC_NOPM, 0, 0,
+			 &es8311_dac_src_mux),
+	SND_SOC_DAPM_DAC("Mono DAC", NULL, ES8311_SYS8,
+			 ES8311_SYS8_PDN_DAC_SHIFT, 1),
+	SND_SOC_DAPM_SUPPLY("DAC Clock", ES8311_CLKMGR1,
+			    ES8311_CLKMGR1_CLKDAC_ON_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC Analog Clock", ES8311_CLKMGR1,
+			    ES8311_CLKMGR1_ANACLKDAC_ON_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC Vref Gen", ES8311_SYS3,
+			    ES8311_SYS3_PDN_DACVREFGEN_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+};
+
+static const struct snd_soc_dapm_route es8311_dapm_routes[] = {
+	/* Capture Path */
+	{ "MIC1", NULL, "Bias" },
+	{ "MIC1", NULL, "Analog power" },
+	{ "MIC1", NULL, "Vref" },
+	{ "Differential Mux", "MIC1P-MIC1N", "MIC1" },
+	{ "PGA", NULL, "Differential Mux" },
+	{ "Mono ADC", NULL, "PGA" },
+	{ "Mono ADC", NULL, "ADC Bias Gen" },
+	{ "Mono ADC", NULL, "ADC Vref Gen" },
+	{ "Mono ADC", NULL, "ADC Clock" },
+	{ "Mono ADC", NULL, "ADC Analog Clock" },
+	{ "Digital Mic Mux", "Disabled", "Mono ADC" },
+	{ "Digital Mic Mux", "DMIC from MIC1P", "DMIC" },
+
+	{ "AIF1TX Source Mux", "ADC + ADC", "Digital Mic Mux" },
+	{ "AIF1TX Source Mux", "ADC + 0", "Digital Mic Mux" },
+	{ "AIF1TX Source Mux", "0 + ADC", "Digital Mic Mux" },
+	{ "AIF1TX Source Mux", "DACL + ADC", "Digital Mic Mux" },
+	{ "AIF1TX Source Mux", "ADC + DACR", "Digital Mic Mux" },
+
+	{ "AIF1TX", NULL, "AIF1TX Source Mux" },
+
+	/* Playback Path */
+	{ "Mono DAC Source Mux", "Left", "AIF1RX" },
+	{ "Mono DAC Source Mux", "Right", "AIF1RX" },
+	{ "Mono DAC", NULL, "Mono DAC Source Mux" },
+	{ "Mono DAC", NULL, "DAC Clock" },
+	{ "Mono DAC", NULL, "DAC Analog Clock" },
+	{ "OUT", NULL, "Mono DAC" },
+	{ "OUT", NULL, "Bias" },
+	{ "OUT", NULL, "Analog power" },
+	{ "OUT", NULL, "Vref" },
+	{ "OUT", NULL, "DAC Vref Gen" },
+};
+
+/* Bit clock divider values:
+ * from 1 to 20: the register takes the div value - 1
+ * above 20: the register takes the corresponding idx of the div value
+ *           in the following table + 20
+ */
+#define ES8311_BCLK_DIV_IDX_OFFSET 20
+static const unsigned int es8311_bclk_divs[] = {
+	22, 24, 25, 30, 32, 33, 34, 36, 44, 48, 66, 72
+};
+
+struct es8311_mclk_coeff {
+	unsigned int rate;
+	unsigned int mclk;
+	unsigned int div;
+	unsigned int mult;
+	unsigned int div_adc_dac;
+};
+
+#define ES8311_MCLK_MAX_FREQ 49200000
+
+/* Coefficients for common master clock frequencies based on clock table from
+ * documentation. Limited to have a ratio of adc (or dac) clock to lrclk equal
+ * to 256. This to keep the default adc and dac oversampling and adc scale
+ * settings. Internal mclk dividers and multipliers are dynamically adjusted to
+ * support, respectively, multiples (up to x8) and factors (/2,4,8) of listed
+ * mclks frequencies (see es8311_cmp_adj_mclk_coeff).
+ * All rates are supported when mclk/rate ratio is 32, 64, 128, 256, 384 or 512
+ * (upper limit due to max mclk freq of 49.2MHz).
+ */
+static const struct es8311_mclk_coeff es8311_mclk_coeffs[] = {
+	{ 8000, 2048000, 1, 1, 1 },
+	{ 8000, 6144000, 3, 1, 1 },
+	{ 8000, 18432000, 3, 1, 3 },
+	{ 11025, 2822400, 1, 1, 1 },
+	{ 11025, 8467200, 3, 1, 1 },
+	{ 16000, 4096000, 1, 1, 1 },
+	{ 16000, 12288000, 3, 1, 1 },
+	{ 16000, 18432000, 3, 2, 3 },
+	{ 22050, 5644800, 1, 1, 1 },
+	{ 22050, 16934400, 3, 1, 1 },
+	{ 32000, 8192000, 1, 1, 1 },
+	{ 32000, 12288000, 3, 2, 1 },
+	{ 32000, 18432000, 3, 4, 3 },
+	{ 44100, 11289600, 1, 1, 1 },
+	{ 44100, 33868800, 3, 1, 1 },
+	{ 48000, 12288000, 1, 1, 1 },
+	{ 48000, 18432000, 3, 2, 1 },
+	{ 64000, 8192000, 1, 2, 1 },
+	{ 64000, 12288000, 3, 4, 1 },
+	{ 88200, 11289600, 1, 2, 1 },
+	{ 88200, 33868800, 3, 2, 1 },
+	{ 96000, 12288000, 1, 2, 1 },
+	{ 96000, 18432000, 3, 4, 1 },
+};
+
+/* Compare coeff with provided mclk_freq and adjust it if needed.
+ * If frequencies match, return 0 and the unaltered coeff copy into out_coeff.
+ * If mclk_freq is a valid multiple or factor of coeff mclk freq, return 0 and
+ * the adjusted coeff copy into out_coeff.
+ * Return -EINVAL otherwise.
+ */
+static int es8311_cmp_adj_mclk_coeff(unsigned int mclk_freq,
+				     const struct es8311_mclk_coeff *coeff,
+				     struct es8311_mclk_coeff *out_coeff)
+{
+	if (WARN_ON_ONCE(!coeff))
+		return -EINVAL;
+
+	unsigned int div = coeff->div;
+	unsigned int mult = coeff->mult;
+	bool match = false;
+
+	if (coeff->mclk == mclk_freq) {
+		match = true;
+	} else if (mclk_freq % coeff->mclk == 0) {
+		div = mclk_freq / coeff->mclk;
+		div *= coeff->div;
+		if (div <= 8)
+			match = true;
+	} else if (coeff->mclk % mclk_freq == 0) {
+		mult = coeff->mclk / mclk_freq;
+		if (mult == 2 || mult == 4 || mult == 8) {
+			mult *= coeff->mult;
+			if (mult <= 8)
+				match = true;
+		}
+	}
+	if (!match)
+		return -EINVAL;
+	if (out_coeff) {
+		*out_coeff = *coeff;
+		out_coeff->div = div;
+		out_coeff->mult = mult;
+	}
+	return 0;
+}
+
+static int es8311_get_mclk_coeff(unsigned int mclk_freq, unsigned int rate,
+				 struct es8311_mclk_coeff *out_coeff)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(es8311_mclk_coeffs); i++) {
+		const struct es8311_mclk_coeff *coeff = &es8311_mclk_coeffs[i];
+
+		if (coeff->rate != rate)
+			continue;
+
+		int ret =
+			es8311_cmp_adj_mclk_coeff(mclk_freq, coeff, out_coeff);
+		if (ret == 0)
+			return 0;
+	}
+	return -EINVAL;
+}
+
+static void es8311_set_sysclk_constraints(unsigned int mclk_freq,
+					  struct es8311_priv *es8311)
+{
+	unsigned int count = 0;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(es8311_mclk_coeffs) &&
+	     count < ARRAY_SIZE(es8311->rates); i++) {
+		const struct es8311_mclk_coeff *coeff = &es8311_mclk_coeffs[i];
+
+		if (count > 0 && coeff->rate == es8311->rates[count - 1])
+			continue;
+
+		int ret = es8311_cmp_adj_mclk_coeff(mclk_freq, coeff, NULL);
+		if (ret == 0)
+			es8311->rates[count++] = coeff->rate;
+	}
+	if (count) {
+		es8311->constraints.list = es8311->rates;
+		es8311->constraints.count = count;
+	}
+}
+
+static int es8311_mute(struct snd_soc_dai *dai, int mute, int direction)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8311_priv *es8311 = snd_soc_component_get_drvdata(component);
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		unsigned int mask = ES8311_DAC1_DAC_DSMMUTE |
+				    ES8311_DAC1_DAC_DEMMUTE;
+		unsigned int val = mute ? mask : 0;
+
+		regmap_update_bits(es8311->regmap, ES8311_DAC1, mask, val);
+	}
+
+	return 0;
+}
+
+static int es8311_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8311_priv *es8311 = snd_soc_component_get_drvdata(component);
+
+	if (es8311->constraints.list) {
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   &es8311->constraints);
+	}
+
+	return 0;
+}
+
+static int es8311_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8311_priv *es8311 = snd_soc_component_get_drvdata(component);
+	unsigned int wl;
+	int par_width = params_width(params);
+
+	switch (par_width) {
+	case 16:
+		wl = ES8311_SDP_WL_16;
+		break;
+	case 18:
+		wl = ES8311_SDP_WL_18;
+		break;
+	case 20:
+		wl = ES8311_SDP_WL_20;
+		break;
+	case 24:
+		wl = ES8311_SDP_WL_24;
+		break;
+	case 32:
+		wl = ES8311_SDP_WL_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+	unsigned int width = (unsigned int)par_width;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		snd_soc_component_update_bits(component, ES8311_SDP_IN,
+					      ES8311_SDP_WL_MASK,
+					      wl << ES8311_SDP_WL_SHIFT);
+	} else {
+		snd_soc_component_update_bits(component, ES8311_SDP_OUT,
+					      ES8311_SDP_WL_MASK,
+					      wl << ES8311_SDP_WL_SHIFT);
+	}
+
+	if (es8311->mclk_freq > ES8311_MCLK_MAX_FREQ) {
+		dev_err(component->dev, "mclk frequency %lu too high\n",
+			es8311->mclk_freq);
+		return -EINVAL;
+	}
+
+	unsigned int mclk_freq = es8311->mclk_freq;
+	unsigned int rate = params_rate(params);
+	unsigned int clkmgr = ES8311_CLKMGR1_MCLK_ON;
+
+	if (!mclk_freq) {
+		if (es8311->provider) {
+			dev_err(component->dev,
+				"mclk not configured, cannot run as master\n");
+			return -EINVAL;
+		}
+		dev_dbg(component->dev,
+			"mclk not configured, use bclk as internal mclk\n");
+
+		clkmgr = ES8311_CLKMGR1_MCLK_SEL;
+
+		mclk_freq = rate * width * 2;
+	}
+
+	struct es8311_mclk_coeff coeff;
+	int ret = es8311_get_mclk_coeff(mclk_freq, rate, &coeff);
+	if (ret) {
+		dev_err(component->dev, "unable to find mclk coefficient\n");
+		return ret;
+	}
+
+	unsigned int mask = ES8311_CLKMGR1_MCLK_SEL | ES8311_CLKMGR1_MCLK_ON |
+			    ES8311_CLKMGR1_BCLK_ON;
+
+	clkmgr |= ES8311_CLKMGR1_BCLK_ON;
+	snd_soc_component_update_bits(component, ES8311_CLKMGR1, mask, clkmgr);
+
+	if (WARN_ON_ONCE(coeff.div == 0 || coeff.div > 8 ||
+			 coeff.div_adc_dac == 0 || coeff.div_adc_dac > 8))
+		return -EINVAL;
+
+	unsigned int mult;
+
+	switch (coeff.mult) {
+	case 1:
+		mult = 0;
+		break;
+	case 2:
+		mult = 1;
+		break;
+	case 4:
+		mult = 2;
+		break;
+	case 8:
+		mult = 3;
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return -EINVAL;
+	}
+
+	mask = ES8311_CLKMGR2_DIV_PRE_MASK | ES8311_CLKMGR2_MULT_PRE_MASK;
+	clkmgr = (coeff.div - 1) << ES8311_CLKMGR2_DIV_PRE_SHIFT |
+		 mult << ES8311_CLKMGR2_MULT_PRE_SHIFT;
+	snd_soc_component_update_bits(component, ES8311_CLKMGR2, mask, clkmgr);
+
+	mask = ES8311_CLKMGR5_ADC_DIV_MASK | ES8311_CLKMGR5_DAC_DIV_MASK;
+	clkmgr = (coeff.div_adc_dac - 1) << ES8311_CLKMGR5_ADC_DIV_SHIFT |
+		 (coeff.div_adc_dac - 1) << ES8311_CLKMGR5_DAC_DIV_SHIFT;
+	snd_soc_component_update_bits(component, ES8311_CLKMGR5, mask, clkmgr);
+
+	if (es8311->provider) {
+		unsigned int div_lrclk = mclk_freq / rate;
+
+		if (WARN_ON_ONCE(div_lrclk == 0 ||
+				 div_lrclk > ES8311_CLKMGR_LRCLK_DIV_MAX + 1))
+			return -EINVAL;
+
+		mask = ES8311_CLKMGR7_LRCLK_DIV_H_MASK;
+		clkmgr = (div_lrclk - 1) >> 8;
+		snd_soc_component_update_bits(component, ES8311_CLKMGR7, mask,
+					      clkmgr);
+		clkmgr = (div_lrclk - 1) & 0xFF;
+		snd_soc_component_write(component, ES8311_CLKMGR8, clkmgr);
+
+		if (div_lrclk % (2 * width) != 0) {
+			dev_err(component->dev,
+				"unable to divide mclk %u to generate bclk\n",
+				mclk_freq);
+			return -EINVAL;
+		}
+
+		unsigned int div_bclk = div_lrclk / (2 * width);
+
+		mask = ES8311_CLKMGR6_DIV_BCLK_MASK;
+		if (div_bclk <= ES8311_BCLK_DIV_IDX_OFFSET) {
+			clkmgr = div_bclk - 1;
+		} else {
+			unsigned int i;
+
+			for (i = 0; i < ARRAY_SIZE(es8311_bclk_divs); i++) {
+				if (es8311_bclk_divs[i] == div_bclk)
+					break;
+			}
+			if (i == ARRAY_SIZE(es8311_bclk_divs)) {
+				dev_err(component->dev,
+					"bclk divider %u not supported\n",
+					div_bclk);
+				return -EINVAL;
+			}
+
+			clkmgr = i + ES8311_BCLK_DIV_IDX_OFFSET;
+		}
+		snd_soc_component_update_bits(component, ES8311_CLKMGR6, mask,
+					      clkmgr);
+	}
+
+	return 0;
+}
+
+static int es8311_set_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
+			     unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct es8311_priv *es8311 = snd_soc_component_get_drvdata(component);
+
+	if (freq > ES8311_MCLK_MAX_FREQ) {
+		dev_err(component->dev, "invalid frequency %u: too high\n",
+			freq);
+		return -EINVAL;
+	}
+
+	if (es8311->mclk_freq == freq)
+		return 0;
+
+	es8311->mclk_freq = freq;
+	es8311->constraints.list = NULL;
+	es8311->constraints.count = 0;
+
+	if (freq == 0)
+		return 0;
+
+	int ret = clk_set_rate(es8311->mclk, freq);
+	if (ret) {
+		dev_err(component->dev, "unable to set mclk rate\n");
+		return ret;
+	}
+
+	es8311_set_sysclk_constraints(freq, es8311);
+
+	return ret;
+}
+
+static int es8311_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct es8311_priv *es8311 = snd_soc_component_get_drvdata(component);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
+		/* Master mode */
+		es8311->provider = true;
+
+		snd_soc_component_update_bits(component, ES8311_RESET,
+					      ES8311_RESET_MSC,
+					      ES8311_RESET_MSC);
+		break;
+	case SND_SOC_DAIFMT_CBC_CFC:
+		/* Slave mode */
+		es8311->provider = false;
+		snd_soc_component_update_bits(component, ES8311_RESET,
+					      ES8311_RESET_MSC, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	unsigned int sdp = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		sdp |= ES8311_SDP_FMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		sdp |= ES8311_SDP_FMT_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		dev_err(component->dev, "right justified mode not supported\n");
+		return -EINVAL;
+	case SND_SOC_DAIFMT_DSP_B:
+		sdp |= ES8311_SDP_LRP;
+		fallthrough;
+	case SND_SOC_DAIFMT_DSP_A:
+		sdp |= ES8311_SDP_FMT_DSP;
+		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+		case SND_SOC_DAIFMT_NB_NF:
+		case SND_SOC_DAIFMT_IB_NF:
+			break;
+		default:
+			dev_err(component->dev,
+				"inverted fsync not supported in dsp mode\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	unsigned int clkmgr = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		sdp |= ES8311_SDP_LRP;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		clkmgr |= ES8311_CLKMGR6_BCLK_INV;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		clkmgr |= ES8311_CLKMGR6_BCLK_INV;
+		sdp |= ES8311_SDP_LRP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	unsigned int mask = ES8311_CLKMGR6_BCLK_INV;
+
+	snd_soc_component_update_bits(component, ES8311_CLKMGR6, mask, clkmgr);
+
+	mask = ES8311_SDP_FMT_MASK | ES8311_SDP_LRP;
+	snd_soc_component_update_bits(component, ES8311_SDP_IN, mask, sdp);
+	snd_soc_component_update_bits(component, ES8311_SDP_OUT, mask, sdp);
+
+	return 0;
+}
+
+static int es8311_set_bias_level(struct snd_soc_component *component,
+				 enum snd_soc_bias_level level)
+{
+	struct es8311_priv *es8311 = snd_soc_component_get_drvdata(component);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			int ret = clk_prepare_enable(es8311->mclk);
+			if (ret) {
+				dev_err(component->dev,
+					"unable to prepare mclk\n");
+				return ret;
+			}
+
+			snd_soc_component_update_bits(
+				component, ES8311_SYS3,
+				ES8311_SYS3_PDN_VMIDSEL_MASK,
+				ES8311_SYS3_PDN_VMIDSEL_STARTUP_NORMAL_SPEED);
+		}
+
+		break;
+	case SND_SOC_BIAS_OFF:
+		clk_disable_unprepare(es8311->mclk);
+		snd_soc_component_update_bits(
+			component, ES8311_SYS3, ES8311_SYS3_PDN_VMIDSEL_MASK,
+			ES8311_SYS3_PDN_VMIDSEL_POWER_DOWN);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dai_ops es8311_dai_ops = {
+	.startup = es8311_startup,
+	.hw_params = es8311_hw_params,
+	.mute_stream = es8311_mute,
+	.set_sysclk = es8311_set_sysclk,
+	.set_fmt = es8311_set_dai_fmt,
+	.no_capture_mute = 1,
+};
+
+static struct snd_soc_dai_driver es8311_dai = {
+	.name = "es8311",
+	.playback = {
+		.stream_name = "AIF1 Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = ES8311_RATES,
+		.formats = ES8311_FORMATS,
+	},
+	.capture = {
+		.stream_name = "AIF1 Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = ES8311_RATES,
+		.formats = ES8311_FORMATS,
+	},
+	.ops = &es8311_dai_ops,
+	.symmetric_rate = 1,
+};
+
+static void es8311_reset(struct snd_soc_component *component, bool reset)
+{
+	/* Reset procedure:
+	 * (1) power down state machine and reset codec blocks then,
+	 * (2) after a short delay, power up state machine and leave reset mode.
+	 * Specific delay is not documented, using the same as es8316.
+	 */
+	unsigned int mask = ES8311_RESET_CSM_ON | ES8311_RESET_RST_MASK;
+
+	if (reset) {
+		/* Enter reset mode */
+		snd_soc_component_update_bits(component, ES8311_RESET, mask,
+					      ES8311_RESET_RST_MASK);
+	} else {
+		/* Leave reset mode */
+		usleep_range(5000, 5500);
+		snd_soc_component_update_bits(component, ES8311_RESET, mask,
+					      ES8311_RESET_CSM_ON);
+	}
+}
+
+static int es8311_suspend(struct snd_soc_component *component)
+{
+	struct es8311_priv *es8311;
+
+	es8311 = snd_soc_component_get_drvdata(component);
+
+	es8311_reset(component, true);
+
+	regcache_cache_only(es8311->regmap, true);
+	regcache_mark_dirty(es8311->regmap);
+
+	return 0;
+}
+
+static int es8311_resume(struct snd_soc_component *component)
+{
+	struct es8311_priv *es8311;
+
+	es8311 = snd_soc_component_get_drvdata(component);
+
+	es8311_reset(component, false);
+
+	regcache_cache_only(es8311->regmap, false);
+	regcache_sync(es8311->regmap);
+
+	return 0;
+}
+
+static int es8311_component_probe(struct snd_soc_component *component)
+{
+	struct es8311_priv *es8311;
+
+	es8311 = snd_soc_component_get_drvdata(component);
+
+	es8311->mclk = devm_clk_get_optional(component->dev, "mclk");
+	if (IS_ERR(es8311->mclk)) {
+		dev_err(component->dev, "invalid mclk\n");
+		return PTR_ERR(es8311->mclk);
+	}
+
+	es8311->mclk_freq = clk_get_rate(es8311->mclk);
+	if (es8311->mclk_freq > 0 && es8311->mclk_freq < ES8311_MCLK_MAX_FREQ)
+		es8311_set_sysclk_constraints(es8311->mclk_freq, es8311);
+
+	es8311_reset(component, true);
+	es8311_reset(component, false);
+
+	/* Set minimal power up time */
+	snd_soc_component_write(component, ES8311_SYS1, 0);
+	snd_soc_component_write(component, ES8311_SYS2, 0);
+
+	return 0;
+}
+
+static const struct regmap_config es8311_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ES8311_REG_MAX,
+	.cache_type = REGCACHE_MAPLE,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static const struct snd_soc_component_driver es8311_component_driver = {
+	.probe = es8311_component_probe,
+	.suspend = es8311_suspend,
+	.resume = es8311_resume,
+	.set_bias_level = es8311_set_bias_level,
+	.controls = es8311_snd_controls,
+	.num_controls = ARRAY_SIZE(es8311_snd_controls),
+	.dapm_widgets = es8311_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(es8311_dapm_widgets),
+	.dapm_routes = es8311_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(es8311_dapm_routes),
+	.use_pmdown_time = 1,
+	.endianness = 1,
+};
+
+static int es8311_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct es8311_priv *es8311;
+
+	struct device *dev = &i2c_client->dev;
+
+	es8311 = devm_kzalloc(dev, sizeof(*es8311), GFP_KERNEL);
+	if (es8311 == NULL)
+		return -ENOMEM;
+
+	es8311->regmap =
+		devm_regmap_init_i2c(i2c_client, &es8311_regmap_config);
+	if (IS_ERR(es8311->regmap))
+		return PTR_ERR(es8311->regmap);
+
+	i2c_set_clientdata(i2c_client, es8311);
+
+	return devm_snd_soc_register_component(dev, &es8311_component_driver,
+					       &es8311_dai, 1);
+}
+
+static const struct i2c_device_id es8311_id[] = { { "es8311", 0 }, {} };
+MODULE_DEVICE_TABLE(i2c, es8311_id);
+
+static const struct of_device_id es8311_of_match[] = {
+	{
+		.compatible = "everest,es8311",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, es8311_of_match);
+
+static struct i2c_driver es8311_i2c_driver = {
+	.driver = {
+		.name		= "es8311",
+		.of_match_table = es8311_of_match,
+	},
+	.probe = es8311_i2c_probe,
+	.id_table = es8311_id,
+};
+
+module_i2c_driver(es8311_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC ES8311 driver");
+MODULE_AUTHOR("Matteo Martelli <matteomartelli3@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/es8311.h b/sound/soc/codecs/es8311.h
new file mode 100644
index 000000000000..8a3105bb8443
--- /dev/null
+++ b/sound/soc/codecs/es8311.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * es8311.c -- es8311 ALSA SoC audio driver
+ *
+ * Copyright (C) 2024 Matteo Martelli <matteomartelli3@gmail.com>
+ *
+ * Author: Matteo Martelli <matteomartelli3@gmail.com>
+ */
+
+#ifndef _ES8311_H
+#define _ES8311_H
+
+#include <linux/bitops.h>
+
+#define ES8311_RESET 0x00
+#define ES8311_RESET_CSM_ON BIT(7)
+#define ES8311_RESET_MSC BIT(6)
+#define ES8311_RESET_RST_MASK GENMASK(4, 0)
+
+/* Clock Manager Registers */
+#define ES8311_CLKMGR1 0x01
+#define ES8311_CLKMGR1_MCLK_SEL BIT(7)
+#define ES8311_CLKMGR1_MCLK_ON BIT(5)
+#define ES8311_CLKMGR1_BCLK_ON BIT(4)
+#define ES8311_CLKMGR1_CLKADC_ON_SHIFT 3
+#define ES8311_CLKMGR1_CLKDAC_ON_SHIFT 2
+#define ES8311_CLKMGR1_ANACLKADC_ON_SHIFT 1
+#define ES8311_CLKMGR1_ANACLKDAC_ON_SHIFT 0
+#define ES8311_CLKMGR2 0x02
+#define ES8311_CLKMGR2_DIV_PRE_MASK GENMASK(7, 5)
+#define ES8311_CLKMGR2_DIV_PRE_SHIFT 5
+#define ES8311_CLKMGR2_DIV_PRE_MAX 0x07
+#define ES8311_CLKMGR2_MULT_PRE_MASK GENMASK(4, 3)
+#define ES8311_CLKMGR2_MULT_PRE_SHIFT 3
+#define ES8311_CLKMGR3 0x03
+#define ES8311_CLKMGR4 0x04
+#define ES8311_CLKMGR5 0x05
+#define ES8311_CLKMGR5_ADC_DIV_MASK GENMASK(7, 4)
+#define ES8311_CLKMGR5_ADC_DIV_SHIFT 4
+#define ES8311_CLKMGR5_DAC_DIV_MASK GENMASK(3, 0)
+#define ES8311_CLKMGR5_DAC_DIV_SHIFT 0
+#define ES8311_CLKMGR6 0x06
+#define ES8311_CLKMGR6_BCLK_INV BIT(5)
+#define ES8311_CLKMGR6_DIV_BCLK_MASK GENMASK(4, 0)
+#define ES8311_CLKMGR7 0x07
+#define ES8311_CLKMGR7_LRCLK_DIV_H_MASK GENMASK(3, 0)
+#define ES8311_CLKMGR8 0x08
+#define ES8311_CLKMGR_LRCLK_DIV_MAX 0x0FFF
+
+/* SDP Mode Registers */
+#define ES8311_SDP_IN 0x09
+#define ES8311_SDP_IN_SEL_SHIFT 7
+#define ES8311_SDP_OUT 0x0A
+/* Following values are the same for both SPD_IN and SDP_OUT */
+#define ES8311_SDP_MUTE_SHIFT 6
+#define ES8311_SDP_LRP BIT(5)
+#define ES8311_SDP_WL_MASK GENMASK(4, 2)
+#define ES8311_SDP_WL_SHIFT 2
+#define ES8311_SDP_WL_24 0x00
+#define ES8311_SDP_WL_20 0x01
+#define ES8311_SDP_WL_18 0x02
+#define ES8311_SDP_WL_16 0x03
+#define ES8311_SDP_WL_32 0x04
+#define ES8311_SDP_FMT_MASK GENMASK(1, 0)
+#define ES8311_SDP_FMT_I2S 0x00
+#define ES8311_SDP_FMT_LEFT_J 0x01
+#define ES8311_SDP_FMT_DSP 0x03
+
+/* System registers */
+#define ES8311_SYS1 0x0B
+#define ES8311_SYS2 0x0C
+#define ES8311_SYS3 0x0D
+#define ES8311_SYS3_PDN_ANA_SHIFT 7
+#define ES8311_SYS3_PDN_IBIASGEN_SHIFT 6
+#define ES8311_SYS3_PDN_ADCBIASGEN_SHIFT 5
+#define ES8311_SYS3_PDN_ADCVREFGEN_SHIFT 4
+#define ES8311_SYS3_PDN_DACVREFGEN_SHIFT 3
+#define ES8311_SYS3_PDN_VREF_SHIFT 2
+#define ES8311_SYS3_PDN_VMIDSEL_MASK GENMASK(1, 0)
+#define ES8311_SYS3_PDN_VMIDSEL_POWER_DOWN 0
+#define ES8311_SYS3_PDN_VMIDSEL_STARTUP_NORMAL_SPEED 1
+#define ES8311_SYS3_PDN_VMIDSEL_NORMAL_OPERATION 2
+#define ES8311_SYS3_PDN_VMIDSEL_STARTUP_FAST_SPEED 3
+#define ES8311_SYS4 0x0E
+#define ES8311_SYS4_PDN_PGA_SHIFT 6
+#define ES8311_SYS4_PDN_MOD_SHIFT 5
+#define ES8311_SYS5 0x0F
+#define ES8311_SYS6 0x10
+#define ES8311_SYS7 0x11
+#define ES8311_SYS8 0x12
+#define ES8311_SYS8_PDN_DAC_SHIFT 1
+#define ES8311_SYS9 0x13
+#define ES8311_SYS9_HPSW_SHIFT 4
+#define ES8311_SYS10 0x14
+#define ES8311_SYS10_DMIC_ON_SHIFT 6
+#define ES8311_SYS10_LINESEL_SHIFT 4
+#define ES8311_SYS10_PGAGAIN_SHIFT 0
+#define ES8311_SYS10_PGAGAIN_MAX 0x0A
+
+/* ADC Registers*/
+#define ES8311_ADC1 0x15
+#define ES8311_ADC1_RAMPRATE_SHIFT 4
+#define ES8311_ADC2 0x16
+#define ES8311_ADC2_INV_SHIFT 4
+#define ES8311_ADC2_SCALE_SHIFT 0
+#define ES8311_ADC2_SCALE_MAX 0x07
+#define ES8311_ADC3 0x17
+#define ES8311_ADC3_VOLUME_SHIFT 0
+#define ES8311_ADC3_VOLUME_MAX 0xFF
+#define ES8311_ADC4 0x18
+#define ES8311_ADC4_ALC_EN_SHIFT 7
+#define ES8311_ADC4_AUTOMUTE_EN_SHIFT 6
+#define ES8311_ADC4_ALC_WINSIZE_SHIFT 0
+#define ES8311_ADC5 0x19
+#define ES8311_ADC5_ALC_MAXLEVEL_SHIFT 4
+#define ES8311_ADC5_ALC_MAXLEVEL_MAX 0x0F
+#define ES8311_ADC5_ALC_MINLEVEL_SHIFT 0
+#define ES8311_ADC5_ALC_MINLEVEL_MAX 0x0F
+#define ES8311_ADC6 0x1A
+#define ES8311_ADC6_AUTOMUTE_WS_SHIFT 4
+#define ES8311_ADC6_AUTOMUTE_NG_SHIFT 0
+#define ES8311_ADC6_AUTOMUTE_NG_MAX 0x0F
+
+#define ES8311_ADC7 0x1B
+#define ES8311_ADC7_AUTOMUTE_VOL_SHIFT 5
+#define ES8311_ADC7_AUTOMUTE_VOL_MAX 0x07
+#define ES8311_ADC8 0x1C
+#define ES8311_ADC8_EQBYPASS_SHIFT 6
+#define ES8311_ADC8_HPF_SHIFT 5
+
+/* DAC Registers */
+#define ES8311_DAC1 0x31
+#define ES8311_DAC1_DAC_DSMMUTE BIT(6)
+#define ES8311_DAC1_DAC_DEMMUTE BIT(5)
+#define ES8311_DAC2 0x32
+#define ES8311_DAC2_VOLUME_MAX 0xFF
+#define ES8311_DAC3 0x33
+#define ES8311_DAC4 0x34
+#define ES8311_DAC4_DRC_EN_SHIFT 7
+#define ES8311_DAC4_DRC_WINSIZE_SHIFT 0
+#define ES8311_DAC5 0x35
+#define ES8311_DAC5_DRC_MAXLEVEL_SHIFT 4
+#define ES8311_DAC5_DRC_MAXLEVEL_MAX 0x0F
+#define ES8311_DAC5_DRC_MINLEVEL_SHIFT 0
+#define ES8311_DAC5_DRC_MINLEVEL_MAX 0x0F
+#define ES8311_DAC6 0x37
+#define ES8311_DAC6_RAMPRATE_SHIFT 4
+#define ES8311_DAC6_EQBYPASS_SHIFT 3
+
+/* GPIO Registers */
+#define ES8311_GPIO 0x44
+#define ES8311_GPIO_ADC2DAC_SEL_SHIFT 7
+#define ES8311_GPIO_ADCDAT_SEL_SHIFT 4
+
+/* Chip Info Registers */
+#define ES8311_CHIPID1 0xFD /* 0x83 */
+#define ES8311_CHIPID2 0xFE /* 0x11 */
+#define ES8311_CHIPVER 0xFF
+
+#define ES8311_REG_MAX 0xFF
+
+#endif
-- 
2.45.0



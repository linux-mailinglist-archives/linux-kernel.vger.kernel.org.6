Return-Path: <linux-kernel+bounces-367856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6659A07A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E471C27103
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2B2071F0;
	Wed, 16 Oct 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHbyvqxi"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D32071E5;
	Wed, 16 Oct 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075342; cv=none; b=inteC5oUykzH5j4gSBGS9Yz9WNjhip19hBROmtRCVbpjE0e2Nj64x0JYc6j9Z/u29o0hWXftIFZwLgScvNG3xsrmmFgQl2etcoKWqgKjlU2Kg4+lnE0pKMsRDdKHoGSTvPqQ3UBKqt9xg7l5G49lGdsxt7PROeyqcJAoki0fFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075342; c=relaxed/simple;
	bh=nB+IIbRrUHVtJUCNt4chBOpmyxxI/lmXkFQK5d/xEiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZEmf0rx4pV0+jKPcbq91e2MH0mS97T0CwBErJ/d0e9UgyZHEHXiGmXf2ffg1HlWO/4SrfCjuvCswMyuatmb+tfmX4XA2ig5KzRjOZXLRDgw/Z6EFL2n5O0rdZruj6y1NI8bnwpqQbrESnvJ0wd9OJ9Fc0SCh/5H8KsrhXf6t/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHbyvqxi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb7139d9dso36412685ad.1;
        Wed, 16 Oct 2024 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729075338; x=1729680138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gp3+cB1UtBjQ9qk78TSSlBdG20oJnke9hhHJlxi+TyU=;
        b=BHbyvqxiefsiPPOh8MFc215mV0Ic1AzwRaM1XZCJFTcigWjOEwDt8Fqwx3o6/FOyul
         d3sEEI8nzwh/3OFr9u37pSF1IC3bonNOhTJ+yydYmvG308XLM/8oek1e5a461tvyPzb6
         Hqs693Yf1CffdtngMcR/WXNs0bvU3GNvgW+wXORJJw4wxUURNjW5Hp9UnP7JcPi/Do4f
         WuTtUVSn0EmJeEiP6db+BCvlIGR2crIfkDE0c+QPpJssusWxZ1lHF4Mm8SZlsUdXOvIC
         o894PGnSTVWbfb71l/FqGkOQLkYwNNLPoKhFyOkMiXf5dHzLdSlf0K5Ue/bq1gK532bN
         KGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075338; x=1729680138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gp3+cB1UtBjQ9qk78TSSlBdG20oJnke9hhHJlxi+TyU=;
        b=iI8e89SLWNLX96iCOZo2iaJD6xTWOhf3SOZ+B+HVT5vNNYPROdHW2/UVkR2uaOXiAr
         CRoS594h/tZDW1THCL72Xs7U8Cq5KMoSjEPj+YEQrWpFmuxzywtHNoG7FDDT0I/MTjIv
         KcQUEt9tIBxfTHrc/i6hr+ND47JuRI11jPKNPOavQrTX6aTALCifWewOtw3zjr/wDn7V
         pozA4v7LuR0Fj7peXhEDqbZoATtJjmd/UE2ciij6z6avKUpGDCyaDnNfH3MFVFDlN/OL
         f8kLgri1UTIcoK2V/xgv4ZMrY7otYLhjXQD4GYQWOA9BhhtnG02Ie787kbd6vNYKWGBQ
         uNTg==
X-Forwarded-Encrypted: i=1; AJvYcCUdj/PiIHQg4PZnZudtJ7hFX1yXpSfwiRPfGgH7/W6FZ51fIUNZWbLmJhpPsbmDlWN1/XpvPOtTieGjpn0=@vger.kernel.org, AJvYcCUxpYqfYP+nQHIOsj99EeOmbE4uj1ptx1SM1ixtmkelaJ58n64BiA15Wdvaq33amvUPdSGKhg8dTq7kHT43@vger.kernel.org, AJvYcCXS1fipZzLISi37V4eUyzCqOfXiaY9XXmST77hQOso/k76NI920aVgwRIeAjG+YLH8YpcvBnZQ/M0AQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHW44zl0zIOsCVh5B6MY9dfe4YkaImGPApQmiGJE5DWBVKoUh
	VLHqLX7SVsKalb7UxMM8jVZ6KvyzfQdGO1Jj1VWQ4F883mAw34b8
X-Google-Smtp-Source: AGHT+IGNyhIF0ycVpUo/JY9TkqMmLt9iPWfhnQV3MVGWQSGkjG1rIqVCcNA3LUy6CNmI5pgXUbndUQ==
X-Received: by 2002:a17:902:d50d:b0:20b:a6f5:2780 with SMTP id d9443c01a7336-20d27e8c3b5mr44565995ad.17.1729075337251;
        Wed, 16 Oct 2024 03:42:17 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b2e4sm26319645ad.182.2024.10.16.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:42:16 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 16 Oct 2024 20:41:01 +1000
Subject: [PATCH 2/3] ASoC: cs42l84: Add new codec driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-cs42l84-v1-2-8d7e9d437d2d@gmail.com>
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
In-Reply-To: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 James Calligeros <jcalligeros99@gmail.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=45456;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=MHv6J1Tefc/rqF6A7Tqh6IXVbm58U88wT3Ku4QM2mI0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOn8M8rtJkgvYjZS7r95Jm+StaJ9V/pRr0d5m5LSH6duL
 d1bZXK1o5SFQYyLQVZMkWVDk5DHbCO2m/0ilXth5rAygQxh4OIUgInMzGNkWCIWMqWb5eb34D9q
 WzR1a2V/rt4Sqx98xDJ9+/Nfv9kzuRgZOsu3MT5stJzZ7fhZ9ujJzHXLUo38lOU+HjVfoearJve
 FCQA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

The CS42L84 is a codec from Cirrus Logic found in Apple Silicon Macs.
The chip continues Apple's long tradition of compelling vendors to
spin out bespoke SKUs that are based on existing IP but made subtly
incompatible with the publicly available part. CS42L84 is very similar
to CS42L42, but has a different regmap.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 MAINTAINERS                |    1 +
 sound/soc/codecs/Kconfig   |    7 ++
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/cs42l84.c | 1081 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l84.h |  210 ++++++++++++++++++++++++++++++++
 5 files changed, 1301 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5f85714dc4e8ca9c60b3f6963b2cec1ea33fdd0..fc321f5ac579ed01a66523430e0e8b9afaf4cb7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2136,6 +2136,7 @@ F:	Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
 F:	Documentation/devicetree/bindings/sound/apple,*
 F:	sound/soc/apple/*
 F:	sound/soc/codecs/cs42l83-i2c.c
+F:	sound/soc/codecs/cs42l84.*
 F:	sound/soc/codecs/ssm3515.c
 
 ARM/APPLE MACHINE SUPPORT
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6a6125e94d2dc094b10c6f2fb53dd447e831f23d..f5a9e596632c970eef7a385e09a55355ac41fbfc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -85,6 +85,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS42L52
 	imply SND_SOC_CS42L56
 	imply SND_SOC_CS42L73
+	imply SND_SOC_CS42L84
 	imply SND_SOC_CS4234
 	imply SND_SOC_CS4265
 	imply SND_SOC_CS4270
@@ -929,6 +930,12 @@ config SND_SOC_CS42L83
 	select REGMAP_I2C
 	select SND_SOC_CS42L42_CORE
 
+config SND_SOC_CS42L84
+	tristate "Cirrus Logic CS42L84 CODEC"
+	depends on I2C
+	select REGMAP
+	select REGMAP_I2C
+
 config SND_SOC_CS4234
 	tristate "Cirrus Logic CS4234 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index ac7d8b71b32b19a41366966065de450b947c9178..2c69df06677e54e149ca848ccaf412e4b9c0f2c2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -91,6 +91,7 @@ snd-soc-cs42l52-y := cs42l52.o
 snd-soc-cs42l56-y := cs42l56.o
 snd-soc-cs42l73-y := cs42l73.o
 snd-soc-cs42l83-i2c-y := cs42l83-i2c.o
+snd-soc-cs42l84-objs := cs42l84.o
 snd-soc-cs4234-y := cs4234.o
 snd-soc-cs4265-y := cs4265.o
 snd-soc-cs4270-y := cs4270.o
@@ -505,6 +506,7 @@ obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
 obj-$(CONFIG_SND_SOC_CS42L56)	+= snd-soc-cs42l56.o
 obj-$(CONFIG_SND_SOC_CS42L73)	+= snd-soc-cs42l73.o
 obj-$(CONFIG_SND_SOC_CS42L83)	+= snd-soc-cs42l83-i2c.o
+obj-$(CONFIG_SND_SOC_CS42L84)	+= snd-soc-cs42l84.o
 obj-$(CONFIG_SND_SOC_CS4234)	+= snd-soc-cs4234.o
 obj-$(CONFIG_SND_SOC_CS4265)	+= snd-soc-cs4265.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
diff --git a/sound/soc/codecs/cs42l84.c b/sound/soc/codecs/cs42l84.c
new file mode 100644
index 0000000000000000000000000000000000000000..dbbc76f41ccb958b068848426d1891b16aa84866
--- /dev/null
+++ b/sound/soc/codecs/cs42l84.c
@@ -0,0 +1,1081 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cs42l84.c -- CS42L84 ALSA SoC audio driver
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ *
+ * Based on sound/soc/codecs/cs42l42{.c,.h}
+ *   Copyright 2016 Cirrus Logic, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "cs42l84.h"
+#include "cirrus_legacy.h"
+
+struct cs42l84_private {
+	struct regmap *regmap;
+	struct device *dev;
+	struct gpio_desc *reset_gpio;
+	struct snd_soc_jack *jack;
+	struct mutex irq_lock;
+	u8 plug_state;
+	int pll_config;
+	int bclk;
+	u8 pll_mclk_f;
+	u32 srate;
+	u8 stream_use;
+	int hs_type;
+};
+
+static bool cs42l84_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS42L84_DEVID ... CS42L84_DEVID+5:
+	case CS42L84_TSRS_PLUG_INT_STATUS:
+	case CS42L84_PLL_LOCK_STATUS:
+	case CS42L84_TSRS_PLUG_STATUS:
+	case CS42L84_HS_DET_STATUS2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config cs42l84_regmap = {
+	.reg_bits = 16,
+	.val_bits = 8,
+
+	.volatile_reg = cs42l84_volatile_register,
+
+	.max_register = 0xffff,
+
+	.cache_type = REGCACHE_RBTREE,
+
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static int cs42l84_put_dac_vol(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kctl);
+	struct soc_mixer_control *mc = (struct soc_mixer_control *) kctl->private_value;
+	int vola, volb;
+	int ret, ret2, updated = 0;
+
+	vola = val->value.integer.value[0] + mc->min;
+	volb = val->value.integer.value[1] + mc->min;
+
+	if (vola < mc->min || vola > mc->max || volb < mc->min || volb > mc->max)
+		return -EINVAL;
+
+	ret = snd_soc_component_update_bits(component, CS42L84_FRZ_CTL,
+					    CS42L84_FRZ_CTL_ENGAGE,
+					    CS42L84_FRZ_CTL_ENGAGE);
+	if (ret < 0)
+		goto bail;
+	updated |= ret;
+
+	ret = snd_soc_component_update_bits(component, CS42L84_DAC_CHA_VOL_LSB,
+					    0xff, vola & 0xff);
+	if (ret < 0)
+		goto bail;
+	updated |= ret;
+
+	ret = snd_soc_component_update_bits(component, CS42L84_DAC_CHA_VOL_MSB,
+					    0xff, (vola >> 8) & 0x01);
+	if (ret < 0)
+		goto bail;
+	updated |= ret;
+
+	ret = snd_soc_component_update_bits(component, CS42L84_DAC_CHB_VOL_LSB,
+					    0xff, volb & 0xff);
+	if (ret < 0)
+		goto bail;
+	updated |= ret;
+
+	ret = snd_soc_component_update_bits(component, CS42L84_DAC_CHB_VOL_MSB,
+					    0xff, (volb >> 8) & 0x01);
+	if (ret < 0)
+		goto bail;
+	ret |= updated;
+
+bail:
+	ret2 = snd_soc_component_update_bits(component, CS42L84_FRZ_CTL,
+					     CS42L84_FRZ_CTL_ENGAGE, 0);
+	if (ret2 < 0 && ret >= 0)
+		ret = ret2;
+
+	return ret;
+}
+
+static int cs42l84_get_dac_vol(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kctl);
+	struct soc_mixer_control *mc = (struct soc_mixer_control *) kctl->private_value;
+	int vola, volb;
+	int ret;
+
+	ret = snd_soc_component_read(component, CS42L84_DAC_CHA_VOL_LSB);
+	if (ret < 0)
+		return ret;
+	vola = ret;
+
+	ret = snd_soc_component_read(component, CS42L84_DAC_CHA_VOL_MSB);
+	if (ret < 0)
+		return ret;
+	vola |= (ret & 1) << 8;
+
+	ret = snd_soc_component_read(component, CS42L84_DAC_CHB_VOL_LSB);
+	if (ret < 0)
+		return ret;
+	volb = ret;
+
+	ret = snd_soc_component_read(component, CS42L84_DAC_CHB_VOL_MSB);
+	if (ret < 0)
+		return ret;
+	volb |= (ret & 1) << 8;
+
+	if (vola & BIT(8))
+		vola |= ~((int)(BIT(8) - 1));
+	if (volb & BIT(8))
+		volb |= ~((int)(BIT(8) - 1));
+
+	val->value.integer.value[0] = vola - mc->min;
+	val->value.integer.value[1] = volb - mc->min;
+
+	return 0;
+}
+
+static const DECLARE_TLV_DB_SCALE(cs42l84_dac_tlv, -12800, 50, true);
+static const DECLARE_TLV_DB_SCALE(cs42l84_adc_tlv, -1200, 50, false);
+static const DECLARE_TLV_DB_SCALE(cs42l84_pre_tlv, 0, 1000, false);
+
+static const struct snd_kcontrol_new cs42l84_snd_controls[] = {
+	SOC_DOUBLE_R_S_EXT_TLV("DAC Playback Volume", CS42L84_DAC_CHA_VOL_LSB,
+			CS42L84_DAC_CHB_VOL_LSB, 0, -256, 24, 8, 0,
+			cs42l84_get_dac_vol, cs42l84_put_dac_vol, cs42l84_dac_tlv),
+	SOC_SINGLE_TLV("ADC Preamp Capture Volume", CS42L84_ADC_CTL1,
+			CS42L84_ADC_CTL1_PREAMP_GAIN_SHIFT, 2, 0, cs42l84_pre_tlv),
+	SOC_SINGLE_TLV("ADC PGA Capture Volume", CS42L84_ADC_CTL1,
+			CS42L84_ADC_CTL1_PGA_GAIN_SHIFT, 24, 0, cs42l84_adc_tlv),
+	SOC_SINGLE("ADC WNF Switch", CS42L84_ADC_CTL4,
+			CS42L84_ADC_CTL4_WNF_EN_SHIFT, 1, 0),
+	SOC_SINGLE("WNF Corner Frequency", CS42L84_ADC_CTL4,
+			CS42L84_ADC_CTL4_WNF_CF_SHIFT, 3, 0),
+	SOC_SINGLE("ADC HPF Switch", CS42L84_ADC_CTL4,
+			CS42L84_ADC_CTL4_HPF_EN_SHIFT, 1, 0),
+	SOC_SINGLE("HPF Corner Frequency", CS42L84_ADC_CTL4,
+			CS42L84_ADC_CTL4_HPF_CF_SHIFT, 3, 0),
+};
+
+static const char * const cs42l84_mux_text[] = {
+	"Blank", "ADC", "ASP RX CH1", "ASP RX CH2",
+};
+
+static const unsigned int cs42l84_mux_values[] = {
+	0b0000, 0b0111, 0b1101, 0b1110,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs42l84_daca_mux_enum,
+		CS42L84_BUS_DAC_SRC, CS42L84_BUS_DAC_SRC_DACA_SHIFT,
+		0b1111, cs42l84_mux_text, cs42l84_mux_values);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs42l84_dacb_mux_enum,
+		CS42L84_BUS_DAC_SRC, CS42L84_BUS_DAC_SRC_DACB_SHIFT,
+		0b1111, cs42l84_mux_text, cs42l84_mux_values);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(cs42l84_sdout1_mux_enum,
+		CS42L84_BUS_ASP_TX_SRC, CS42L84_BUS_ASP_TX_SRC_CH1_SHIFT,
+		0b1111, cs42l84_mux_text, cs42l84_mux_values);
+
+static const struct snd_kcontrol_new cs42l84_daca_mux_ctrl =
+	SOC_DAPM_ENUM("DACA Select", cs42l84_daca_mux_enum);
+
+static const struct snd_kcontrol_new cs42l84_dacb_mux_ctrl =
+	SOC_DAPM_ENUM("DACB Select", cs42l84_dacb_mux_enum);
+
+static const struct snd_kcontrol_new cs42l84_sdout1_mux_ctrl =
+	SOC_DAPM_ENUM("SDOUT1 Select", cs42l84_sdout1_mux_enum);
+
+static const struct snd_soc_dapm_widget cs42l84_dapm_widgets[] = {
+	/* Playback Path */
+	SND_SOC_DAPM_OUTPUT("HP"),
+	SND_SOC_DAPM_DAC("DAC", NULL, CS42L84_MSM_BLOCK_EN2, CS42L84_MSM_BLOCK_EN2_DAC_SHIFT, 0),
+	SND_SOC_DAPM_MUX("DACA Select", SND_SOC_NOPM, 0, 0, &cs42l84_daca_mux_ctrl),
+	SND_SOC_DAPM_MUX("DACB Select", SND_SOC_NOPM, 0, 0, &cs42l84_dacb_mux_ctrl),
+	SND_SOC_DAPM_AIF_IN("SDIN1", NULL, 0, CS42L84_ASP_RX_EN, CS42L84_ASP_RX_EN_CH1_SHIFT, 0),
+	SND_SOC_DAPM_AIF_IN("SDIN2", NULL, 1, CS42L84_ASP_RX_EN, CS42L84_ASP_RX_EN_CH2_SHIFT, 0),
+
+	/* Capture Path */
+	SND_SOC_DAPM_INPUT("HS"),
+	SND_SOC_DAPM_ADC("ADC", NULL, CS42L84_MSM_BLOCK_EN2, CS42L84_MSM_BLOCK_EN2_ADC_SHIFT, 0),
+	SND_SOC_DAPM_MUX("SDOUT1 Select", SND_SOC_NOPM, 0, 0, &cs42l84_sdout1_mux_ctrl),
+	SND_SOC_DAPM_AIF_OUT("SDOUT1", NULL, 0, CS42L84_ASP_TX_EN, CS42L84_ASP_TX_EN_CH1_SHIFT, 0),
+
+	/* Playback/Capture Requirements */
+	SND_SOC_DAPM_SUPPLY("BUS", CS42L84_MSM_BLOCK_EN2, CS42L84_MSM_BLOCK_EN2_BUS_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ASP", CS42L84_MSM_BLOCK_EN2, CS42L84_MSM_BLOCK_EN2_ASP_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("BCLK", CS42L84_ASP_CTL, CS42L84_ASP_CTL_BCLK_EN_SHIFT, 0, NULL, 0),
+};
+
+static const struct snd_soc_dapm_route cs42l84_audio_map[] = {
+	/* Playback Path */
+	{"HP", NULL, "DAC"},
+	{"DAC", NULL, "DACA Select"},
+	{"DAC", NULL, "DACB Select"},
+	{"DACA Select", "ASP RX CH1", "SDIN1"},
+	{"DACA Select", "ASP RX CH2", "SDIN2"},
+	{"DACB Select", "ASP RX CH1", "SDIN1"},
+	{"DACB Select", "ASP RX CH2", "SDIN2"},
+	{"SDIN1", NULL, "Playback"},
+	{"SDIN2", NULL, "Playback"},
+
+	{"ADC", NULL, "HS"},
+	{"SDOUT1 Select", "ADC", "ADC"},
+	{"SDOUT1", NULL, "SDOUT1 Select"},
+	{"Capture", NULL, "SDOUT1"},
+
+	/* Playback Requirements */
+	{"DAC", NULL, "BUS"},
+	{"SDIN1", NULL, "ASP"},
+	{"SDIN2", NULL, "ASP"},
+	{"SDIN1", NULL, "BCLK"},
+	{"SDIN2", NULL, "BCLK"},
+
+	/* Capture Requirements */
+	{"SDOUT1", NULL, "BUS"},
+	{"SDOUT1", NULL, "ASP"},
+	{"SDOUT1", NULL, "BCLK"},
+};
+
+static int cs42l84_set_jack(struct snd_soc_component *component, struct snd_soc_jack *jk, void *d)
+{
+	struct cs42l84_private *cs42l84 = snd_soc_component_get_drvdata(component);
+
+	/* Prevent race with interrupt handler */
+	mutex_lock(&cs42l84->irq_lock);
+	cs42l84->jack = jk;
+	snd_soc_jack_report(jk, cs42l84->hs_type, SND_JACK_HEADSET);
+	mutex_unlock(&cs42l84->irq_lock);
+
+	return 0;
+}
+
+static int cs42l84_component_probe(struct snd_soc_component *component)
+{
+	snd_soc_component_update_bits(component, CS42L84_ASP_CTL,
+			CS42L84_ASP_CTL_TDM_MODE, 0);
+	snd_soc_component_update_bits(component, CS42L84_HP_VOL_CTL,
+			CS42L84_HP_VOL_CTL_SOFT | CS42L84_HP_VOL_CTL_ZERO_CROSS,
+			CS42L84_HP_VOL_CTL_ZERO_CROSS);
+
+	/* TDM settings */
+	snd_soc_component_update_bits(component, CS42L84_ASP_RX_CH1_CTL1,
+			CS42L84_ASP_RX_CHx_CTL1_EDGE |
+			CS42L84_ASP_RX_CHx_CTL1_SLOT_START_LSB, 0);
+	snd_soc_component_update_bits(component, CS42L84_ASP_RX_CH1_CTL2,
+			CS42L84_ASP_RX_CHx_CTL2_SLOT_START_MSB, 0);
+	snd_soc_component_update_bits(component, CS42L84_ASP_RX_CH2_CTL1,
+			CS42L84_ASP_RX_CHx_CTL1_EDGE |
+			CS42L84_ASP_RX_CHx_CTL1_SLOT_START_LSB,
+			CS42L84_ASP_RX_CHx_CTL1_EDGE);
+	snd_soc_component_update_bits(component, CS42L84_ASP_RX_CH2_CTL2,
+			CS42L84_ASP_RX_CHx_CTL2_SLOT_START_MSB, 0);
+	snd_soc_component_update_bits(component, CS42L84_ASP_TX_CH1_CTL1,
+			CS42L84_ASP_RX_CHx_CTL1_EDGE | \
+			CS42L84_ASP_RX_CHx_CTL1_SLOT_START_LSB, 0);
+	snd_soc_component_update_bits(component, CS42L84_ASP_TX_CH1_CTL2,
+			CS42L84_ASP_RX_CHx_CTL2_SLOT_START_MSB, 0);
+	snd_soc_component_update_bits(component, CS42L84_ASP_TX_CH2_CTL1,
+			CS42L84_ASP_RX_CHx_CTL1_EDGE | \
+			CS42L84_ASP_RX_CHx_CTL1_SLOT_START_LSB,
+			CS42L84_ASP_RX_CHx_CTL1_EDGE);
+	snd_soc_component_update_bits(component, CS42L84_ASP_TX_CH2_CTL2,
+			CS42L84_ASP_RX_CHx_CTL2_SLOT_START_MSB, 0);
+	/* Routing defaults */
+	snd_soc_component_write(component, CS42L84_BUS_DAC_SRC,
+			0b1101 << CS42L84_BUS_DAC_SRC_DACA_SHIFT |
+			0b1110 << CS42L84_BUS_DAC_SRC_DACB_SHIFT);
+	snd_soc_component_write(component, CS42L84_BUS_ASP_TX_SRC,
+			0b0111 << CS42L84_BUS_ASP_TX_SRC_CH1_SHIFT);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_component_dev_cs42l84 = {
+	.set_jack		= cs42l84_set_jack,
+	.probe			= cs42l84_component_probe,
+	.controls		= cs42l84_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs42l84_snd_controls),
+	.dapm_widgets		= cs42l84_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs42l84_dapm_widgets),
+	.dapm_routes		= cs42l84_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(cs42l84_audio_map),
+	.endianness		= 1,
+};
+
+struct cs42l84_pll_params {
+	u32 bclk;
+	u8 mclk_src_sel;
+	u8 bclk_prediv;
+	u8 pll_div_int;
+	u32 pll_div_frac;
+	u8 pll_mode;
+	u8 pll_divout;
+	u32 mclk_int;
+};
+
+/*
+ * Common PLL Settings for given BCLK
+ */
+static const struct cs42l84_pll_params pll_ratio_table[] = {
+	{  3072000, 1, 0, 0x40, 0x000000, 0x03, 0x10, 12288000},
+	{  6144000, 1, 1, 0x40, 0x000000, 0x03, 0x10, 12288000},
+	{ 12288000, 0, 0, 0, 0, 0, 0,                 12288000},
+	{ 24576000, 1, 3, 0x40, 0x000000, 0x03, 0x10, 12288000},
+};
+
+static int cs42l84_pll_config(struct snd_soc_component *component)
+{
+	struct cs42l84_private *cs42l84 = snd_soc_component_get_drvdata(component);
+	int i;
+	u32 clk;
+	u32 fsync;
+
+	clk = cs42l84->bclk;
+
+	/* Don't reconfigure if there is an audio stream running */
+	if (cs42l84->stream_use) {
+		if (pll_ratio_table[cs42l84->pll_config].bclk == clk)
+			return 0;
+		else
+			return -EBUSY;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
+		if (pll_ratio_table[i].bclk == clk) {
+			cs42l84->pll_config = i;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(pll_ratio_table))
+		return -EINVAL;
+
+	/* Set up the LRCLK */
+	fsync = clk / cs42l84->srate;
+	if (((fsync * cs42l84->srate) != clk)
+			|| ((fsync % 2) != 0)) {
+		dev_err(component->dev,
+			"Unsupported bclk %d/sample rate %d\n",
+			clk, cs42l84->srate);
+		return -EINVAL;
+	}
+
+	/* Set the LRCLK period */
+	snd_soc_component_update_bits(component, CS42L84_ASP_FSYNC_CTL2,
+		CS42L84_ASP_FSYNC_CTL2_BCLK_PERIOD_LO,
+		FIELD_PREP(CS42L84_ASP_FSYNC_CTL2_BCLK_PERIOD_LO, fsync & 0x7f));
+	snd_soc_component_update_bits(component, CS42L84_ASP_FSYNC_CTL3,
+		CS42L84_ASP_FSYNC_CTL3_BCLK_PERIOD_HI,
+		FIELD_PREP(CS42L84_ASP_FSYNC_CTL3_BCLK_PERIOD_HI, fsync >> 7));
+
+	/* Save what the MCLK will be */
+	switch (pll_ratio_table[i].mclk_int) {
+	case 12000000:
+		cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_12MHZ;
+		break;
+	case 12288000:
+		cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_12_288KHZ;
+		break;
+	case 24000000:
+		cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_24MHZ;
+		break;
+	case 24576000:
+		cs42l84->pll_mclk_f = CS42L84_CCM_CTL1_MCLK_F_24_576KHZ;
+		break;
+	}
+
+	snd_soc_component_update_bits(component, CS42L84_PLL_CTL1, CS42L84_PLL_CTL1_EN, 0);
+
+	if (pll_ratio_table[i].mclk_src_sel) {
+		/* Configure PLL */
+		snd_soc_component_update_bits(component,
+			CS42L84_CCM_CTL3, CS42L84_CCM_CTL3_REFCLK_DIV,
+			FIELD_PREP(CS42L84_CCM_CTL3_REFCLK_DIV, pll_ratio_table[i].bclk_prediv));
+		snd_soc_component_write(component,
+			CS42L84_PLL_DIV_INT,
+			pll_ratio_table[i].pll_div_int);
+		snd_soc_component_write(component,
+			CS42L84_PLL_DIV_FRAC0,
+			pll_ratio_table[i].pll_div_frac);
+		snd_soc_component_write(component,
+			CS42L84_PLL_DIV_FRAC1,
+			pll_ratio_table[i].pll_div_frac >> 8);
+		snd_soc_component_write(component,
+			CS42L84_PLL_DIV_FRAC2,
+			pll_ratio_table[i].pll_div_frac >> 16);
+		snd_soc_component_update_bits(component,
+			CS42L84_PLL_CTL1, CS42L84_PLL_CTL1_MODE,
+			FIELD_PREP(CS42L84_PLL_CTL1_MODE, pll_ratio_table[i].pll_mode));
+		snd_soc_component_write(component,
+			CS42L84_PLL_DIVOUT,
+			pll_ratio_table[i].pll_divout);
+	}
+
+	return 0;
+}
+
+static int cs42l84_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_BC_FC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Bitclock/frame inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cs42l84_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs42l84_private *cs42l84 = snd_soc_component_get_drvdata(component);
+	int ret;
+	u32 ccm_samp_rate;
+
+	cs42l84->srate = params_rate(params);
+
+	ret = cs42l84_pll_config(component);
+	if (ret)
+		return ret;
+
+	switch (params_rate(params)) {
+	case 44100:
+		ccm_samp_rate = CS42L84_CCM_SAMP_RATE_RATE_44K1HZ;
+		break;
+	case 48000:
+		ccm_samp_rate = CS42L84_CCM_SAMP_RATE_RATE_48KHZ;
+		break;
+	case 88200:
+		ccm_samp_rate = CS42L84_CCM_SAMP_RATE_RATE_88K2HZ;
+		break;
+	case 96000:
+		ccm_samp_rate = CS42L84_CCM_SAMP_RATE_RATE_96KHZ;
+		break;
+	case 176400:
+		ccm_samp_rate = CS42L84_CCM_SAMP_RATE_RATE_176K4HZ;
+		break;
+	case 192000:
+		ccm_samp_rate = CS42L84_CCM_SAMP_RATE_RATE_192KHZ;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_component_write(component, CS42L84_CCM_SAMP_RATE, ccm_samp_rate);
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		snd_soc_component_write(component, CS42L84_ASP_RX_CH1_WIDTH,
+					params_width(params) - 1);
+		snd_soc_component_write(component, CS42L84_ASP_RX_CH2_WIDTH,
+					params_width(params) - 1);
+		break;
+
+	case SNDRV_PCM_STREAM_CAPTURE:
+		snd_soc_component_write(component, CS42L84_ASP_TX_CH1_WIDTH,
+					params_width(params) - 1);
+		snd_soc_component_write(component, CS42L84_ASP_TX_CH2_WIDTH,
+					params_width(params) - 1);
+		break;
+	}
+
+	return 0;
+}
+
+static int cs42l84_set_sysclk(struct snd_soc_dai *dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs42l84_private *cs42l84 = snd_soc_component_get_drvdata(component);
+	int i;
+
+	if (freq == 0) {
+		cs42l84->bclk = 0;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
+		if (pll_ratio_table[i].bclk == freq) {
+			cs42l84->bclk = freq;
+			return 0;
+		}
+	}
+
+	dev_err(component->dev, "BCLK %u not supported\n", freq);
+
+	return -EINVAL;
+}
+
+static int cs42l84_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs42l84_private *cs42l84 = snd_soc_component_get_drvdata(component);
+	unsigned int regval;
+	int ret;
+
+	if (mute) {
+		/* Mute the headphone */
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			snd_soc_component_update_bits(component, CS42L84_DAC_CTL1,
+						      CS42L84_DAC_CTL1_UNMUTE, 0);
+		cs42l84->stream_use &= ~(1 << stream);
+		if (!cs42l84->stream_use) {
+			/* Must disconnect PLL before stopping it */
+			snd_soc_component_write(component, CS42L84_CCM_CTL1,
+						CS42L84_CCM_CTL1_RCO);
+
+			usleep_range(150, 300);
+
+			snd_soc_component_update_bits(component, CS42L84_PLL_CTL1,
+							CS42L84_PLL_CTL1_EN, 0);
+
+			snd_soc_component_update_bits(component, CS42L84_CCM_CTL4,
+							CS42L84_CCM_CTL4_REFCLK_EN, 0);
+		}
+	} else {
+		if (!cs42l84->stream_use) {
+			/* SCLK must be running before codec unmute.
+			 *
+			 * Note carried over from CS42L42:
+			 *
+			 * PLL must not be started with ADC and HP both off
+			 * otherwise the FILT+ supply will not charge properly.
+			 * DAPM widgets power-up before stream unmute so at least
+			 * one of the "DAC" or "ADC" widgets will already have
+			 * powered-up.
+			 */
+
+			snd_soc_component_update_bits(component, CS42L84_CCM_CTL4,
+						      CS42L84_CCM_CTL4_REFCLK_EN,
+						      CS42L84_CCM_CTL4_REFCLK_EN);
+
+			if (pll_ratio_table[cs42l84->pll_config].mclk_src_sel) {
+				snd_soc_component_update_bits(component, CS42L84_PLL_CTL1,
+							      CS42L84_PLL_CTL1_EN,
+							      CS42L84_PLL_CTL1_EN);
+				/* TODO: should we be doing something with divout here? */
+
+				ret = regmap_read_poll_timeout(cs42l84->regmap,
+							       CS42L84_PLL_LOCK_STATUS,
+							       regval,
+							       (regval & CS42L84_PLL_LOCK_STATUS_LOCKED),
+							       CS42L84_PLL_LOCK_POLL_US,
+							       CS42L84_PLL_LOCK_TIMEOUT_US);
+				if (ret < 0)
+					dev_warn(component->dev, "PLL failed to lock: %d\n", ret);
+
+				if (regval & CS42L84_PLL_LOCK_STATUS_ERROR)
+					dev_warn(component->dev, "PLL lock error\n");
+
+				/* PLL must be running to drive glitchless switch logic */
+				snd_soc_component_update_bits(component,
+					CS42L84_CCM_CTL1,
+					CS42L84_CCM_CTL1_MCLK_SRC | CS42L84_CCM_CTL1_MCLK_FREQ,
+					FIELD_PREP(CS42L84_CCM_CTL1_MCLK_SRC, CS42L84_CCM_CTL1_MCLK_SRC_PLL)
+					| FIELD_PREP(CS42L84_CCM_CTL1_MCLK_FREQ, cs42l84->pll_mclk_f));
+				usleep_range(CS42L84_CLOCK_SWITCH_DELAY_US, CS42L84_CLOCK_SWITCH_DELAY_US*2);
+			} else {
+				snd_soc_component_update_bits(component,
+					CS42L84_CCM_CTL1,
+					CS42L84_CCM_CTL1_MCLK_SRC | CS42L84_CCM_CTL1_MCLK_FREQ,
+					FIELD_PREP(CS42L84_CCM_CTL1_MCLK_SRC, CS42L84_CCM_CTL1_MCLK_SRC_BCLK)
+					| FIELD_PREP(CS42L84_CCM_CTL1_MCLK_FREQ, cs42l84->pll_mclk_f));
+				usleep_range(CS42L84_CLOCK_SWITCH_DELAY_US, CS42L84_CLOCK_SWITCH_DELAY_US*2);
+			}
+		}
+		cs42l84->stream_use |= 1 << stream;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			/* Un-mute the headphone */
+			snd_soc_component_update_bits(component, CS42L84_DAC_CTL1,
+						      CS42L84_DAC_CTL1_UNMUTE,
+						      CS42L84_DAC_CTL1_UNMUTE);
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops cs42l84_ops = {
+	.hw_params	= cs42l84_pcm_hw_params,
+	.set_fmt	= cs42l84_set_dai_fmt,
+	.set_sysclk	= cs42l84_set_sysclk,
+	.mute_stream	= cs42l84_mute_stream,
+};
+
+#define CS42L84_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver cs42l84_dai = {
+		.name = "cs42l84",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000,
+			.formats = CS42L84_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000,
+			.formats = CS42L84_FORMATS,
+		},
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+		.ops = &cs42l84_ops,
+};
+
+struct cs42l84_irq_params {
+	u16 status_addr;
+	u16 mask_addr;
+	u8 mask;
+};
+
+static const struct cs42l84_irq_params irq_params_table[] = {
+	{CS42L84_TSRS_PLUG_INT_STATUS, CS42L84_TSRS_PLUG_INT_MASK,
+		CS42L84_TSRS_PLUG_VAL_MASK}
+};
+
+static void cs42l84_detect_hs(struct cs42l84_private *cs42l84)
+{
+	unsigned int reg;
+
+	/* Power up HSBIAS */
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_MISC_DET_CTL,
+		CS42L84_MISC_DET_CTL_HSBIAS_CTL | CS42L84_MISC_DET_CTL_DETECT_MODE,
+		FIELD_PREP(CS42L84_MISC_DET_CTL_HSBIAS_CTL, 3) | /* 2.7 V */
+		FIELD_PREP(CS42L84_MISC_DET_CTL_DETECT_MODE, 0));
+
+	/* Power up level detection circuitry */
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_MISC_DET_CTL,
+		CS42L84_MISC_DET_CTL_PDN_MIC_LVL_DET, 0);
+
+	/* TODO: Optimize */
+	msleep(50);
+
+	/* Connect HSBIAS in CTIA wiring */
+	/* TODO: Should likely be subject of detection */
+	regmap_write(cs42l84->regmap,
+		CS42L84_HS_SWITCH_CTL,
+		CS42L84_HS_SWITCH_CTL_REF_HS3 | \
+		CS42L84_HS_SWITCH_CTL_HSB_FILT_HS3 | \
+		CS42L84_HS_SWITCH_CTL_GNDHS_HS3 | \
+		CS42L84_HS_SWITCH_CTL_HSB_HS4);
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_HS_DET_CTL2,
+		CS42L84_HS_DET_CTL2_SET,
+		FIELD_PREP(CS42L84_HS_DET_CTL2_SET, 0));
+
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_MISC_DET_CTL,
+		CS42L84_MISC_DET_CTL_DETECT_MODE,
+		FIELD_PREP(CS42L84_MISC_DET_CTL_DETECT_MODE, 3));
+
+	/* TODO: Optimize */
+	msleep(50);
+
+	regmap_read(cs42l84->regmap, CS42L84_HS_DET_STATUS2, &reg);
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_MISC_DET_CTL,
+		CS42L84_MISC_DET_CTL_PDN_MIC_LVL_DET,
+		CS42L84_MISC_DET_CTL_PDN_MIC_LVL_DET);
+
+	switch (reg & 0b11) {
+	case 0b11: /* shorted */
+	case 0b00: /* open */
+		/* Power down HSBIAS */
+		regmap_update_bits(cs42l84->regmap,
+			CS42L84_MISC_DET_CTL,
+			CS42L84_MISC_DET_CTL_HSBIAS_CTL,
+			FIELD_PREP(CS42L84_MISC_DET_CTL_HSBIAS_CTL, 1)); /* 0.0 V */
+		break;
+	}
+
+	switch (reg & 0b11) {
+	case 0b10: /* load */
+		dev_dbg(cs42l84->dev, "Detected mic\n");
+		cs42l84->hs_type = SND_JACK_HEADSET;
+		snd_soc_jack_report(cs42l84->jack, SND_JACK_HEADSET,
+				SND_JACK_HEADSET);
+		break;
+
+	case 0b00: /* open */
+		dev_dbg(cs42l84->dev, "Detected open circuit on HS4\n");
+		fallthrough;
+	case 0b11: /* shorted */
+	default:
+		snd_soc_jack_report(cs42l84->jack, SND_JACK_HEADPHONE,
+				SND_JACK_HEADSET);
+		cs42l84->hs_type = SND_JACK_HEADPHONE;
+		dev_dbg(cs42l84->dev, "Detected bare headphone (no mic)\n");
+	}
+}
+
+static void cs42l84_revert_hs(struct cs42l84_private *cs42l84)
+{
+	/* Power down HSBIAS */
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_MISC_DET_CTL,
+		CS42L84_MISC_DET_CTL_HSBIAS_CTL | CS42L84_MISC_DET_CTL_DETECT_MODE,
+		FIELD_PREP(CS42L84_MISC_DET_CTL_HSBIAS_CTL, 1) | /* 0.0 V */
+		FIELD_PREP(CS42L84_MISC_DET_CTL_DETECT_MODE, 0));
+
+	/* Disconnect HSBIAS */
+	regmap_write(cs42l84->regmap,
+		CS42L84_HS_SWITCH_CTL,
+		CS42L84_HS_SWITCH_CTL_REF_HS3 | \
+		CS42L84_HS_SWITCH_CTL_REF_HS4 | \
+		CS42L84_HS_SWITCH_CTL_HSB_FILT_HS3 | \
+		CS42L84_HS_SWITCH_CTL_HSB_FILT_HS4 | \
+		CS42L84_HS_SWITCH_CTL_GNDHS_HS3 | \
+		CS42L84_HS_SWITCH_CTL_GNDHS_HS4);
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_HS_DET_CTL2,
+		CS42L84_HS_DET_CTL2_SET,
+		FIELD_PREP(CS42L84_HS_DET_CTL2_SET, 2));
+}
+
+static irqreturn_t cs42l84_irq_thread(int irq, void *data)
+{
+	struct cs42l84_private *cs42l84 = (struct cs42l84_private *)data;
+	unsigned int stickies[1];
+	unsigned int masks[1];
+	unsigned int reg;
+	u8 current_plug_status;
+	int i;
+
+	mutex_lock(&cs42l84->irq_lock);
+	/* Read sticky registers to clear interrupt */
+	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
+		regmap_read(cs42l84->regmap, irq_params_table[i].status_addr,
+				&(stickies[i]));
+		regmap_read(cs42l84->regmap, irq_params_table[i].mask_addr,
+				&(masks[i]));
+		stickies[i] = stickies[i] & (~masks[i]) &
+				irq_params_table[i].mask;
+	}
+
+	if ((~masks[0]) & irq_params_table[0].mask) {
+		regmap_read(cs42l84->regmap, CS42L84_TSRS_PLUG_STATUS, &reg);
+		current_plug_status = (((char) reg) &
+		      (CS42L84_TS_PLUG | CS42L84_TS_UNPLUG)) >>
+		      CS42L84_TS_PLUG_SHIFT;
+
+		switch (current_plug_status) {
+		case CS42L84_PLUG:
+			if (cs42l84->plug_state != CS42L84_PLUG) {
+				cs42l84->plug_state = CS42L84_PLUG;
+				dev_dbg(cs42l84->dev, "Plug event\n");
+
+				cs42l84_detect_hs(cs42l84);
+
+				/*
+				 * Check the tip sense status again, and possibly invalidate
+				 * the detection result
+				 *
+				 * Thanks to debounce, this should reliably indicate if the tip
+				 * was disconnected at any point during the detection procedure.
+				 */
+				regmap_read(cs42l84->regmap, CS42L84_TSRS_PLUG_STATUS, &reg);
+				current_plug_status = (((char) reg) &
+				      (CS42L84_TS_PLUG | CS42L84_TS_UNPLUG)) >>
+				      CS42L84_TS_PLUG_SHIFT;
+				if (current_plug_status != CS42L84_PLUG) {
+					dev_dbg(cs42l84->dev, "Wobbly connection, detection invalidated\n");
+					cs42l84->plug_state = CS42L84_UNPLUG;
+					cs42l84_revert_hs(cs42l84);
+				}
+			}
+			break;
+
+		case CS42L84_UNPLUG:
+			if (cs42l84->plug_state != CS42L84_UNPLUG) {
+				cs42l84->plug_state = CS42L84_UNPLUG;
+				dev_dbg(cs42l84->dev, "Unplug event\n");
+
+				cs42l84_revert_hs(cs42l84);
+				cs42l84->hs_type = 0;
+				snd_soc_jack_report(cs42l84->jack, 0,
+						    SND_JACK_HEADSET);
+			}
+			break;
+
+		default:
+			if (cs42l84->plug_state != CS42L84_TRANS)
+				cs42l84->plug_state = CS42L84_TRANS;
+		}
+	}
+	mutex_unlock(&cs42l84->irq_lock);
+
+	return IRQ_HANDLED;
+}
+
+static void cs42l84_set_interrupt_masks(struct cs42l84_private *cs42l84)
+{
+	regmap_update_bits(cs42l84->regmap, CS42L84_TSRS_PLUG_INT_MASK,
+			CS42L84_RS_PLUG | CS42L84_RS_UNPLUG |
+			CS42L84_TS_PLUG | CS42L84_TS_UNPLUG,
+			CS42L84_RS_PLUG | CS42L84_RS_UNPLUG);
+}
+
+static void cs42l84_setup_plug_detect(struct cs42l84_private *cs42l84)
+{
+	unsigned int reg;
+
+	/* Set up plug detection */
+	regmap_update_bits(cs42l84->regmap, CS42L84_MIC_DET_CTL4,
+			CS42L84_MIC_DET_CTL4_LATCH_TO_VP,
+			CS42L84_MIC_DET_CTL4_LATCH_TO_VP);
+	regmap_update_bits(cs42l84->regmap, CS42L84_TIP_SENSE_CTL2,
+			CS42L84_TIP_SENSE_CTL2_MODE,
+			FIELD_PREP(CS42L84_TIP_SENSE_CTL2_MODE, CS42L84_TIP_SENSE_CTL2_MODE_SHORT_DET));
+	regmap_update_bits(cs42l84->regmap, CS42L84_RING_SENSE_CTL,
+			CS42L84_RING_SENSE_CTL_INV | CS42L84_RING_SENSE_CTL_UNK1 |
+			CS42L84_RING_SENSE_CTL_RISETIME | CS42L84_RING_SENSE_CTL_FALLTIME,
+			CS42L84_RING_SENSE_CTL_INV | CS42L84_RING_SENSE_CTL_UNK1 |
+			FIELD_PREP(CS42L84_RING_SENSE_CTL_RISETIME, CS42L84_DEBOUNCE_TIME_125MS) |
+			FIELD_PREP(CS42L84_RING_SENSE_CTL_FALLTIME, CS42L84_DEBOUNCE_TIME_125MS));
+	regmap_update_bits(cs42l84->regmap, CS42L84_TIP_SENSE_CTL,
+			CS42L84_TIP_SENSE_CTL_INV |
+			CS42L84_TIP_SENSE_CTL_RISETIME | CS42L84_TIP_SENSE_CTL_FALLTIME,
+			CS42L84_TIP_SENSE_CTL_INV |
+			FIELD_PREP(CS42L84_TIP_SENSE_CTL_RISETIME, CS42L84_DEBOUNCE_TIME_500MS) |
+			FIELD_PREP(CS42L84_TIP_SENSE_CTL_FALLTIME, CS42L84_DEBOUNCE_TIME_125MS));
+	regmap_update_bits(cs42l84->regmap, CS42L84_MSM_BLOCK_EN3,
+			CS42L84_MSM_BLOCK_EN3_TR_SENSE,
+			CS42L84_MSM_BLOCK_EN3_TR_SENSE);
+
+	/* Save the initial status of the tip sense */
+	regmap_read(cs42l84->regmap, CS42L84_TSRS_PLUG_STATUS, &reg);
+	cs42l84->plug_state = (((char) reg) &
+		      (CS42L84_TS_PLUG | CS42L84_TS_UNPLUG)) >>
+		      CS42L84_TS_PLUG_SHIFT;
+
+	/* Set mic-detection threshold */
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_MIC_DET_CTL1, CS42L84_MIC_DET_CTL1_HS_DET_LEVEL,
+		FIELD_PREP(CS42L84_MIC_DET_CTL1_HS_DET_LEVEL, 0x2c)); /* ~1.9 V */
+
+	/* Disconnect HSBIAS (initially) */
+	regmap_write(cs42l84->regmap,
+		CS42L84_HS_SWITCH_CTL,
+		CS42L84_HS_SWITCH_CTL_REF_HS3 | \
+		CS42L84_HS_SWITCH_CTL_REF_HS4 | \
+		CS42L84_HS_SWITCH_CTL_HSB_FILT_HS3 | \
+		CS42L84_HS_SWITCH_CTL_HSB_FILT_HS4 | \
+		CS42L84_HS_SWITCH_CTL_GNDHS_HS3 | \
+		CS42L84_HS_SWITCH_CTL_GNDHS_HS4);
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_HS_DET_CTL2,
+		CS42L84_HS_DET_CTL2_SET | CS42L84_HS_DET_CTL2_CTL,
+		FIELD_PREP(CS42L84_HS_DET_CTL2_SET, 2) |
+		FIELD_PREP(CS42L84_HS_DET_CTL2_CTL, 0));
+	regmap_update_bits(cs42l84->regmap,
+		CS42L84_HS_CLAMP_DISABLE, 1, 1);
+
+}
+
+static int cs42l84_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct cs42l84_private *cs42l84;
+	int ret, devid;
+	unsigned int reg;
+
+	cs42l84 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l84_private),
+			       GFP_KERNEL);
+	if (!cs42l84)
+		return -ENOMEM;
+
+	cs42l84->dev = &i2c_client->dev;
+	i2c_set_clientdata(i2c_client, cs42l84);
+	mutex_init(&cs42l84->irq_lock);
+
+	cs42l84->regmap = devm_regmap_init_i2c(i2c_client, &cs42l84_regmap);
+	if (IS_ERR(cs42l84->regmap)) {
+		ret = PTR_ERR(cs42l84->regmap);
+		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Reset the Device */
+	cs42l84->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
+		"reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs42l84->reset_gpio)) {
+		ret = PTR_ERR(cs42l84->reset_gpio);
+		goto err_disable_noreset;
+	}
+
+	if (cs42l84->reset_gpio) {
+		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
+		gpiod_set_value_cansleep(cs42l84->reset_gpio, 1);
+	}
+	usleep_range(CS42L84_BOOT_TIME_US, CS42L84_BOOT_TIME_US * 2);
+
+	/* Request IRQ if one was specified */
+	if (i2c_client->irq) {
+		ret = request_threaded_irq(i2c_client->irq,
+					   NULL, cs42l84_irq_thread,
+					   IRQF_ONESHOT,
+					   "cs42l84", cs42l84);
+		if (ret == -EPROBE_DEFER) {
+			goto err_disable_noirq;
+		} else if (ret != 0) {
+			dev_err(&i2c_client->dev,
+				"Failed to request IRQ: %d\n", ret);
+			goto err_disable_noirq;
+		}
+	}
+
+	/* initialize codec */
+	devid = cirrus_read_device_id(cs42l84->regmap, CS42L84_DEVID);
+	if (devid < 0) {
+		ret = devid;
+		dev_err(&i2c_client->dev, "Failed to read device ID: %d\n", ret);
+		goto err_disable;
+	}
+
+	if (devid != CS42L84_CHIP_ID) {
+		dev_err(&i2c_client->dev,
+			"CS42L84 Device ID (%X). Expected %X\n",
+			devid, CS42L84_CHIP_ID);
+		ret = -EINVAL;
+		goto err_disable;
+	}
+
+	ret = regmap_read(cs42l84->regmap, CS42L84_REVID, &reg);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
+		goto err_shutdown;
+	}
+
+	dev_info(&i2c_client->dev,
+		 "Cirrus Logic CS42L84, Revision: %02X\n", reg & 0xFF);
+
+	/* Setup plug detection */
+	cs42l84_setup_plug_detect(cs42l84);
+
+	/* Mask/Unmask Interrupts */
+	cs42l84_set_interrupt_masks(cs42l84);
+
+	/* Register codec for machine driver */
+	ret = devm_snd_soc_register_component(&i2c_client->dev,
+			&soc_component_dev_cs42l84, &cs42l84_dai, 1);
+	if (ret < 0)
+		goto err_shutdown;
+
+	return 0;
+
+err_shutdown:
+	/* Nothing to do */
+
+err_disable:
+	if (i2c_client->irq)
+		free_irq(i2c_client->irq, cs42l84);
+
+err_disable_noirq:
+	gpiod_set_value_cansleep(cs42l84->reset_gpio, 0);
+err_disable_noreset:
+	return ret;
+}
+
+static void cs42l84_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs42l84_private *cs42l84 = i2c_get_clientdata(i2c_client);
+
+	if (i2c_client->irq)
+		free_irq(i2c_client->irq, cs42l84);
+
+	gpiod_set_value_cansleep(cs42l84->reset_gpio, 0);
+}
+
+static const struct of_device_id cs42l84_of_match[] = {
+	{ .compatible = "cirrus,cs42l84", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs42l84_of_match);
+
+static const struct i2c_device_id cs42l84_id[] = {
+	{"cs42l84", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs42l84_id);
+
+static struct i2c_driver cs42l84_i2c_driver = {
+	.driver = {
+		.name = "cs42l84",
+		.of_match_table = of_match_ptr(cs42l84_of_match),
+	},
+	.id_table = cs42l84_id,
+	.probe = cs42l84_i2c_probe,
+	.remove = cs42l84_i2c_remove,
+};
+
+module_i2c_driver(cs42l84_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS42L84 driver");
+MODULE_AUTHOR("Martin Povišer <povik+lin@cutebit.org>");
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_AUTHOR("James Calligeros <jcalligeros99@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l84.h b/sound/soc/codecs/cs42l84.h
new file mode 100644
index 0000000000000000000000000000000000000000..43ac658dc6ee5de943af144c64ffec3b13ad34a7
--- /dev/null
+++ b/sound/soc/codecs/cs42l84.h
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) The Asahi Linux Contributors
+ *
+ * Based on sound/soc/codecs/cs42l42.h
+ *
+ * Copyright 2016 Cirrus Logic, Inc.
+ */
+
+
+#ifndef __CS42L84_H__
+#define __CS42L84_H__
+
+#include <linux/bits.h>
+
+#define CS42L84_CHIP_ID				0x42a84
+
+#define CS42L84_DEVID				0x0000
+#define CS42L84_REVID				0x73fe
+#define CS42L84_FRZ_CTL				0x0006
+#define CS42L84_FRZ_CTL_ENGAGE			BIT(0)
+
+#define CS42L84_TSRS_PLUG_INT_STATUS		0x0400
+#define CS42L84_TSRS_PLUG_INT_MASK		0x0418
+#define CS42L84_RS_PLUG_SHIFT			0
+#define CS42L84_RS_PLUG				BIT(0)
+#define CS42L84_RS_UNPLUG			BIT(1)
+#define CS42L84_TS_PLUG_SHIFT			2
+#define CS42L84_TS_PLUG				BIT(2)
+#define CS42L84_TS_UNPLUG			BIT(3)
+#define CS42L84_TSRS_PLUG_VAL_MASK		GENMASK(3, 0)
+#define CS42L84_PLL_LOCK_STATUS			0x040e // probably bit 0x10
+#define CS42L84_PLL_LOCK_STATUS_LOCKED		BIT(4)
+#define CS42L84_PLL_LOCK_STATUS_ERROR		BIT(5)
+
+#define CS42L84_PLUG				3
+#define CS42L84_UNPLUG				0
+#define CS42L84_TRANS				1
+
+#define CS42L84_CCM_CTL1			0x0600
+#define CS42L84_CCM_CTL1_MCLK_SRC		GENMASK(1, 0)
+#define CS42L84_CCM_CTL1_MCLK_SRC_RCO		0
+#define CS42L84_CCM_CTL1_MCLK_SRC_MCLK		1
+#define CS42L84_CCM_CTL1_MCLK_SRC_BCLK		2
+#define CS42L84_CCM_CTL1_MCLK_SRC_PLL		3
+#define CS42L84_CCM_CTL1_MCLK_FREQ		GENMASK(3, 2)
+#define CS42L84_CCM_CTL1_MCLK_F_12MHZ		0b00
+#define CS42L84_CCM_CTL1_MCLK_F_24MHZ		0b01
+#define CS42L84_CCM_CTL1_MCLK_F_12_288KHZ	0b10
+#define CS42L84_CCM_CTL1_MCLK_F_24_576KHZ	0b11
+#define CS42L84_CCM_CTL1_RCO \
+	(FIELD_PREP(CS42L84_CCM_CTL1_MCLK_SRC, CS42L84_CCM_CTL1_MCLK_SRC_RCO) \
+	| FIELD_PREP(CS42L84_CCM_CTL1_MCLK_FREQ, CS42L84_CCM_CTL1_MCLK_F_12MHZ))
+
+#define CS42L84_CCM_SAMP_RATE			0x0601
+#define CS42L84_CCM_SAMP_RATE_RATE_48KHZ	4
+#define CS42L84_CCM_SAMP_RATE_RATE_96KHZ	5
+#define CS42L84_CCM_SAMP_RATE_RATE_192KHZ	6
+#define CS42L84_CCM_SAMP_RATE_RATE_44K1HZ	12
+#define CS42L84_CCM_SAMP_RATE_RATE_88K2HZ	13
+#define CS42L84_CCM_SAMP_RATE_RATE_176K4HZ	14
+#define CS42L84_CCM_CTL3			0x0602
+#define CS42L84_CCM_CTL3_REFCLK_DIV		GENMASK(2, 1)
+#define CS42L84_CCM_CTL4			0x0603
+#define CS42L84_CCM_CTL4_REFCLK_EN		BIT(0)
+
+#define CS42L84_CCM_ASP_CLK_CTRL		0x0608
+
+#define CS42L84_PLL_CTL1			0x0800
+#define CS42L84_PLL_CTL1_EN			BIT(0)
+#define CS42L84_PLL_CTL1_MODE			GENMASK(2, 1)
+#define CS42L84_PLL_DIV_FRAC0			0x0804
+#define CS42L84_PLL_DIV_FRAC1			0x0805
+#define CS42L84_PLL_DIV_FRAC2			0x0806
+#define CS42L84_PLL_DIV_INT			0x0807
+#define CS42L84_PLL_DIVOUT			0x0808
+
+#define CS42L84_RING_SENSE_CTL			0x1282
+#define CS42L84_RING_SENSE_CTL_INV		BIT(7)
+#define CS42L84_RING_SENSE_CTL_UNK1		BIT(6)
+#define CS42L84_RING_SENSE_CTL_FALLTIME		GENMASK(5, 3)
+#define CS42L84_RING_SENSE_CTL_RISETIME		GENMASK(2, 0)
+#define CS42L84_TIP_SENSE_CTL			0x1283
+#define CS42L84_TIP_SENSE_CTL_INV		BIT(7)
+#define CS42L84_TIP_SENSE_CTL_FALLTIME		GENMASK(5, 3)
+#define CS42L84_TIP_SENSE_CTL_RISETIME		GENMASK(2, 0)
+
+#define CS42L84_TSRS_PLUG_STATUS		0x1288
+
+#define CS42L84_TIP_SENSE_CTL2			0x1473
+#define CS42L84_TIP_SENSE_CTL2_MODE		GENMASK(7, 6)
+#define CS42L84_TIP_SENSE_CTL2_MODE_DISABLED	0b00
+#define CS42L84_TIP_SENSE_CTL2_MODE_DIG_INPUT	0b01
+#define CS42L84_TIP_SENSE_CTL2_MODE_SHORT_DET	0b11
+#define CS42L84_TIP_SENSE_CTL2_INV		BIT(5)
+
+#define CS42L84_MISC_DET_CTL			0x1474
+#define CS42L84_MISC_DET_CTL_DETECT_MODE	GENMASK(4, 3)
+#define CS42L84_MISC_DET_CTL_HSBIAS_CTL		GENMASK(2, 1)
+#define CS42L84_MISC_DET_CTL_PDN_MIC_LVL_DET	BIT(0)
+
+#define CS42L84_MIC_DET_CTL1			0x1475
+#define CS42L84_MIC_DET_CTL1_HS_DET_LEVEL	GENMASK(5, 0)
+
+#define CS42L84_MIC_DET_CTL4			0x1477
+#define CS42L84_MIC_DET_CTL4_LATCH_TO_VP	BIT(1)
+
+#define CS42L84_HS_DET_STATUS2			0x147d
+
+#define CS42L84_MSM_BLOCK_EN1			0x1800
+#define CS42L84_MSM_BLOCK_EN2			0x1801
+#define CS42L84_MSM_BLOCK_EN2_ASP_SHIFT 	6
+#define CS42L84_MSM_BLOCK_EN2_BUS_SHIFT 	5
+#define CS42L84_MSM_BLOCK_EN2_DAC_SHIFT 	4
+#define CS42L84_MSM_BLOCK_EN2_ADC_SHIFT     3
+#define CS42L84_MSM_BLOCK_EN3			0x1802
+#define CS42L84_MSM_BLOCK_EN3_TR_SENSE		BIT(3)
+
+#define CS42L84_HS_DET_CTL2			0x1811
+#define CS42L84_HS_DET_CTL2_CTL			GENMASK(7, 6)
+#define CS42L84_HS_DET_CTL2_SET			GENMASK(5, 4)
+#define CS42L84_HS_DET_CTL2_REF			BIT(3)
+#define CS42L84_HS_DET_CTL2_AUTO_TIME		GENMASK(1, 0)
+
+#define CS42L84_HS_SWITCH_CTL			0x1812
+#define CS42L84_HS_SWITCH_CTL_REF_HS3		BIT(7)
+#define CS42L84_HS_SWITCH_CTL_REF_HS4		BIT(6)
+#define CS42L84_HS_SWITCH_CTL_HSB_FILT_HS3	BIT(5)
+#define CS42L84_HS_SWITCH_CTL_HSB_FILT_HS4	BIT(4)
+#define CS42L84_HS_SWITCH_CTL_HSB_HS3		BIT(3)
+#define CS42L84_HS_SWITCH_CTL_HSB_HS4		BIT(2)
+#define CS42L84_HS_SWITCH_CTL_GNDHS_HS3		BIT(1)
+#define CS42L84_HS_SWITCH_CTL_GNDHS_HS4		BIT(0)
+
+#define CS42L84_HS_CLAMP_DISABLE		0x1813
+
+#define CS42L84_ADC_CTL1			0x2000
+#define CS42L84_ADC_CTL1_PREAMP_GAIN_SHIFT	6
+#define CS42L84_ADC_CTL1_PGA_GAIN_SHIFT		0
+#define CS42L84_ADC_CTL4			0x2003
+#define CS42L84_ADC_CTL4_WNF_CF_SHIFT		4
+#define CS42L84_ADC_CTL4_WNF_EN_SHIFT		3
+#define CS42L84_ADC_CTL4_HPF_CF_SHIFT		1
+#define CS42L84_ADC_CTL4_HPF_EN_SHIFT		0
+
+#define CS42L84_DAC_CTL1			0x3000
+#define CS42L84_DAC_CTL1_UNMUTE			BIT(0)
+//#define CS42L84_DAC_CTL1_DACB_INV_SHIFT 1
+//#define CS42L84_DAC_CTL1_DACA_INV_SHIFT 0
+#define CS42L84_DAC_CTL2			0x3001
+
+#define CS42L84_DAC_CHA_VOL_LSB			0x3004
+#define CS42L84_DAC_CHA_VOL_MSB			0x3005
+#define CS42L84_DAC_CHB_VOL_LSB			0x3006
+#define CS42L84_DAC_CHB_VOL_MSB			0x3007
+#define CS42L84_HP_VOL_CTL			0x3020
+#define CS42L84_HP_VOL_CTL_ZERO_CROSS		BIT(1)
+#define CS42L84_HP_VOL_CTL_SOFT			BIT(0)
+
+#define CS42L84_SRC_ASP_RX_CH1			0b1101
+#define CS42L84_SRC_ASP_RX_CH2			0b1110
+
+#define CS42L84_BUS_ASP_TX_SRC                  0x4000
+#define CS42L84_BUS_ASP_TX_SRC_CH1_SHIFT        0
+#define CS42L84_BUS_DAC_SRC			0x4001
+#define CS42L84_BUS_DAC_SRC_DACA_SHIFT		0
+#define CS42L84_BUS_DAC_SRC_DACB_SHIFT		4
+
+#define CS42L84_ASP_CTL				0x5000
+#define CS42L84_ASP_CTL_BCLK_EN_SHIFT		1
+#define CS42L84_ASP_CTL_TDM_MODE		BIT(2)
+#define CS42L84_ASP_FSYNC_CTL2			0x5010
+#define CS42L84_ASP_FSYNC_CTL2_BCLK_PERIOD_LO	GENMASK(7, 1)
+#define CS42L84_ASP_FSYNC_CTL3			0x5011
+#define CS42L84_ASP_FSYNC_CTL3_BCLK_PERIOD_HI	GENMASK(4, 0)
+#define CS42L84_ASP_DATA_CTL			0x5018
+
+#define CS42L84_ASP_RX_EN			0x5020
+#define CS42L84_ASP_RX_EN_CH1_SHIFT		0
+#define CS42L84_ASP_RX_EN_CH2_SHIFT		1
+#define CS42L84_ASP_TX_EN			0x5024
+#define CS42L84_ASP_TX_EN_CH1_SHIFT             0
+
+#define CS42L84_ASP_RX_CH1_CTL1			0x5028
+#define CS42L84_ASP_RX_CH1_CTL2			0x5029
+#define CS42L84_ASP_RX_CH1_WIDTH		0x502a
+#define CS42L84_ASP_RX_CH2_CTL1			0x502c
+#define CS42L84_ASP_RX_CH2_CTL2			0x502d
+#define CS42L84_ASP_RX_CH2_WIDTH		0x502e
+
+#define CS42L84_ASP_RX_CHx_CTL1_EDGE		BIT(0)
+#define CS42L84_ASP_RX_CHx_CTL1_SLOT_START_LSB	GENMASK(7, 1)
+#define CS42L84_ASP_RX_CHx_CTL2_SLOT_START_MSB	GENMASK(2, 0)
+
+#define CS42L84_ASP_TX_CH1_CTL1			0x5068
+#define CS42L84_ASP_TX_CH1_CTL2			0x5069
+#define CS42L84_ASP_TX_CH1_WIDTH		0x506a
+#define CS42L84_ASP_TX_CH2_CTL1			0x506c
+#define CS42L84_ASP_TX_CH2_CTL2			0x506d
+#define CS42L84_ASP_TX_CH2_WIDTH		0x506e
+
+#define CS42L84_DEBOUNCE_TIME_125MS		0b001
+#define CS42L84_DEBOUNCE_TIME_500MS		0b011
+
+#define CS42L84_BOOT_TIME_US			3000
+#define CS42L84_CLOCK_SWITCH_DELAY_US		150
+#define CS42L84_PLL_LOCK_POLL_US		250
+#define CS42L84_PLL_LOCK_TIMEOUT_US		1250
+
+#endif /* __CS42L84_H__ */

-- 
2.47.0



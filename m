Return-Path: <linux-kernel+bounces-515812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D84A3695A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD0616FA8E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD12A8D0;
	Sat, 15 Feb 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq58apOj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE843EAD7;
	Sat, 15 Feb 2025 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577816; cv=none; b=Hgrv3Cl2CwDcrQOa9jKeDdYCFa+wT/kOZ8LaPGwpnm5EkB8juz/ODmasEoEbT0mvf+FQxtruEN6/faaNmskpmOKDmK/ql0FnByinJaaBM6oTB24+QLNCLupVpoIe47LN9hkP/IXXOUF/IkYRnlNxiI1ULBMYa5VXJntGXxOKP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577816; c=relaxed/simple;
	bh=K5tVfDxVIZEsRyez0hm061s+077WRMgNNPD4C9/JBi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3qmudm8WhKiynBhb3aYOj1WJ43W+ZZdb2W604gyjGSgwiFdxrBsB/xqw+Nka5RqWhZWvP3CFsktMytRLs4/Axibfqw87gnBtxd9xdAofMJe7Qy8nk2WA8BsOvDMBZ2Yfv4jubiFs0gcvPrYvfBR8QWaA2Zf1psiZ4CEmsfoY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq58apOj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22104c4de96so3975465ad.3;
        Fri, 14 Feb 2025 16:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577813; x=1740182613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jv85ReZ7VjYl5+JfhrnCtl56IWTOSHkcPrZORl5Q+4=;
        b=dq58apOjls6oB6HyT5d6pJ4MbjjB5TqCPrDqrMqw76ahBFlleySWcQdCkOgNj0jTpg
         TKdb8iFLapZkwIcFbQZa2FTAsFSwI7hM9H8h9d5QVHYfL9sTj64cz/1rlszWpLJ5+QD1
         b+uNg9AiIFkFl+q6GvfsemmeSyLT70/K0As5TTyM/vdOZ7bhynmMVpXLBM50eYNVs3IP
         5l0zhfxbzeqGsoHOJbzmhbLf5ccJkwIsAY0wkbIZTgZYW0/LwgGKllFa2giAwNNXNiMf
         YCm4webWpBanXA5I28ORXm7MwMdoC2yI4hP/otxRg/+lcfu/hKukeLO2D/a1zM7JcMC3
         LLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577813; x=1740182613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jv85ReZ7VjYl5+JfhrnCtl56IWTOSHkcPrZORl5Q+4=;
        b=D+FI1SbD2CerChQJo/3ryRRaB/L09bde53bsqZQsZuAPdk2nDwm+AZwC9CgSeGgAhj
         OBqdeG9MW6DCQKZT/2a/wl/QLteJKb2q9//jUS52XZrKPTUdamdwxp/w4/ARSGjo9TOx
         7I+6R+PwPRno3ikW94Zq1aB8bnU9zHT489Sc4949tggAxSpOhZcPKqIIkEbtAQRmOV8V
         cwJBBhnFXlrKm+RJOP4AEVigcgNliPdJ65rpNHrwclke7RQYquHckEdlRJ53APashb1M
         kNxzTMqlXOQ8YdI/cyjSxXbIAYduarv7N2UL1t+mz4rEww2ZcrD1Lmbf6hy5V+OYd5rJ
         0aRw==
X-Forwarded-Encrypted: i=1; AJvYcCWQMh8UK4DXDqZT2Evk9q+HWK2sQhmrFjgyZiAa732VScaeRE2RoAv6/5M0oqiYL9yXP5f5FsyYgwXX7X4S@vger.kernel.org, AJvYcCWnboGv8GRXRZAjQHxoA0ep3PtQQYst7nFjxwJ9emvvYNaxGauIWIU+hWOy0/hB3YiqFPqBQ+M0nAGZ@vger.kernel.org, AJvYcCX5BnPFXfoclzMnBDq7OUfuYRC0NwkVg1W9yNIXFRfub6E7gLJETt+WXCFlqHlvuE1B4fFvbJq65jPaZK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+m7xs799RzSZ0+asHI4EmkQW6Jm5IDmXYEpxBVlVC7H/vnQHx
	/CoiUWoJ/jcIanUQ0oNAYNtKb0B5zDXsgRu4joZievnrJm7S9iMt
X-Gm-Gg: ASbGncsRGzb1deoKtnsVup/hgwyiS7GjP/lh42+2WPF7BHBU9lM1BC+0sxDRyjuqJj0
	9VNKwJKVAz1qAiK2AyLjwvR6ht7UBTSJqeicvIhhQLw/dgIaPTv7K6hBRQ3D4ErhyEbsarofoGU
	u+UfH1xfFcCSIoVVSevJQMaKgGPVJZYhqnKiZ2HeFp3OtLxrJWd+3ciLGUNJvfOMzSDpfLjwkiL
	Yy4q0/OVtaA40KaXdw6Ol8XDF1KWoH7fa+QPU50o5HjShi0Po8nSJHqpn6UYYe+/Nxohsl3kflA
	iIfV9uCU14q95KKE9lV6DMRdAr73mY5BZe+/oTcqkE3hD0y35s6EBREHBlDpQybMmRG9H0asBZg
	8ewXv0f+1Ew==
X-Google-Smtp-Source: AGHT+IFEDhAwa/6OACwmvv4+D+XKr4lDvPeWnQl1dQoZOOfH/ICfi2cO98uHa/GiWM7IDA2ZKpq2rg==
X-Received: by 2002:a17:903:2308:b0:215:b473:1dc9 with SMTP id d9443c01a7336-221040cf336mr15734255ad.46.1739577813127;
        Fri, 14 Feb 2025 16:03:33 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:32 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:36 +1000
Subject: [PATCH 03/27] ASoC: tas2764: Extend driver to SN012776
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-3-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=xd2PMfcuPk6XeGMGGgZ6wl2yZJIUxJkQH+xla5YAsnM=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb26N5m53SDm3cMacS6ssNts39gitijf9173E4+DK1
 e9SdGQ1O0pZGMS4GGTFFFk2NAl5zDZiu9kvUrkXZg4rE8gQBi5OAZjI0kuMDB9Cvt7fpbV819bu
 RSfCnH5KXskNqj21oIbp1ss3h9rcaqcy/GZh38vvcstMtv3JnW3fCva/PjRjTl/N/IKne/0sW2y
 blrICAA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

SN012776 is a speaker amp chip found in Apple's 2021 laptops. It appears
similar and more-or-less compatible to TAS2764. Extend the TAS2764
driver with some SN012776 specifics and configure the chip assuming
it's in one of the Apple machines.

This driver already partially depended on CONFIG_OF/Devicetree, so
drop the pretence that it doesn't, too.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/Kconfig   |  1 +
 sound/soc/codecs/tas2764.c | 46 ++++++++++++++++++++++---
 sound/soc/codecs/tas2764.h |  3 ++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ee35f3aa55216534037257b45f405a2af06c4872..0636b1f7a178a9ed8050e1567c18b94d446ac564 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1965,6 +1965,7 @@ config SND_SOC_TAS2562
 config SND_SOC_TAS2764
 	tristate "Texas Instruments TAS2764 Mono Audio amplifier"
 	depends on I2C
+	depends on OF
 
 config SND_SOC_TAS2770
 	tristate "Texas Instruments TAS2770 speaker amplifier"
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index d482cd194c08c5c443b82c665de7a6d96531ef2e..e04b8ecab819402b8c3d2b81a2a447730802e968 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
@@ -23,6 +24,11 @@
 
 #include "tas2764.h"
 
+enum tas2764_devid {
+	DEVID_TAS2764  = 0,
+	DEVID_SN012776 = 1
+};
+
 struct tas2764_priv {
 	struct snd_soc_component *component;
 	struct gpio_desc *reset_gpio;
@@ -30,7 +36,8 @@ struct tas2764_priv {
 	struct regmap *regmap;
 	struct device *dev;
 	int irq;
-	
+	enum tas2764_devid devid;
+
 	int v_sense_slot;
 	int i_sense_slot;
 
@@ -526,10 +533,16 @@ static struct snd_soc_dai_driver tas2764_dai_driver[] = {
 	},
 };
 
+static uint8_t sn012776_bop_presets[] = {
+	0x01, 0x32, 0x02, 0x22, 0x83, 0x2d, 0x80, 0x02, 0x06,
+	0x32, 0x46, 0x30, 0x02, 0x06, 0x38, 0x40, 0x30, 0x02,
+	0x06, 0x3e, 0x37, 0x30, 0xff, 0xe6
+};
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	int ret;
+	int ret, i;
 
 	tas2764->component = component;
 
@@ -578,6 +591,23 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	if (tas2764->devid == DEVID_SN012776) {
+		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
+					TAS2764_PWR_CTRL_BOP_SRC,
+					TAS2764_PWR_CTRL_BOP_SRC);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < ARRAY_SIZE(sn012776_bop_presets); i++) {
+			ret = snd_soc_component_write(component,
+						TAS2764_BOP_CFG0 + i,
+						sn012776_bop_presets[i]);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -697,6 +727,8 @@ static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)
 	return 0;
 }
 
+static const struct of_device_id tas2764_of_match[];
+
 static int tas2764_i2c_probe(struct i2c_client *client)
 {
 	struct tas2764_priv *tas2764;
@@ -707,6 +739,11 @@ static int tas2764_i2c_probe(struct i2c_client *client)
 	if (!tas2764)
 		return -ENOMEM;
 
+	if (device_is_compatible(&client->dev, "ti,sn012776"))
+		tas2764->devid = DEVID_SN012776;
+	else
+		tas2764->devid = DEVID_TAS2764;
+
 	tas2764->dev = &client->dev;
 	tas2764->irq = client->irq;
 	i2c_set_clientdata(client, tas2764);
@@ -741,13 +778,12 @@ static const struct i2c_device_id tas2764_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tas2764_i2c_id);
 
-#if defined(CONFIG_OF)
 static const struct of_device_id tas2764_of_match[] = {
-	{ .compatible = "ti,tas2764" },
+	{ .compatible = "ti,tas2764",  },
+	{ .compatible = "ti,sn012776", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tas2764_of_match);
-#endif
 
 static struct i2c_driver tas2764_i2c_driver = {
 	.driver = {
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 168af772a898ffd1c5e96c50df77ff6225f704cd..0a40166040e7e877ca5d23db6cb65531af12c40b 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -29,6 +29,7 @@
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
+#define TAS2764_PWR_CTRL_BOP_SRC	BIT(7)
 
 #define TAS2764_VSENSE_POWER_EN		3
 #define TAS2764_ISENSE_POWER_EN		4
@@ -110,4 +111,6 @@
 #define TAS2764_INT_CLK_CFG             TAS2764_REG(0x0, 0x5c)
 #define TAS2764_INT_CLK_CFG_IRQZ_CLR    BIT(2)
 
+#define TAS2764_BOP_CFG0                TAS2764_REG(0X0, 0x1d)
+
 #endif /* __TAS2764__ */

-- 
2.48.1



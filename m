Return-Path: <linux-kernel+bounces-536244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BBA47D22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1333A616E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5645235C0E;
	Thu, 27 Feb 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk18tsEP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEF22C35E;
	Thu, 27 Feb 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658228; cv=none; b=DyozKl/9IPRFnQPV/l3hs82xzvmR3aVNmcagyrJ6ONw4BdwjWVyt4bqEVmmqFcyakwV4xhlX9e47CHz89i03zEUk5NLztlHt1VcvkfcsJ9o6aZUy9G4gGhnGTAp2hCXxnS5tfueQKDKSMdCyewZpa517WtPgdTFkDIJSwjoymOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658228; c=relaxed/simple;
	bh=ls6nJr6c5xyRlqW0wE9UzbvVJV/9x1W6y7H0wIut1z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcQ0t+vMviCOFb4wfpag/EXr9q8kqRqg/WCJahheZ09PnuUjYJMxHMQX+xLJXFfxaWSYlVsJZ/unNOUHrVCD0TUsaYxpTayeXzbrDBOm0ueQrpqnrouiolCpnJobHbLauCKnB3EBC7iugub+5cVHyfKypMnSEvSK159f8RYWAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk18tsEP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212a930001so20774455ad.0;
        Thu, 27 Feb 2025 04:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658226; x=1741263026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2G8IntqVZ/p0yVip5R832K06lAhv6smk3QugjfMN1I=;
        b=jk18tsEPzbtX0DFkdSa5IUsi9zrXuRjbU12PT/aS/DoGm228ZC3BjAUjVQkzsu3gyg
         apkhYSlhf8AruHugnPLGCwkFLlWNWOKyG+33NE18/UMGuUvYwCd1+Hbkul3VS8RePr5I
         Gh70hCCChcpSVLDd4kNZzYA0OD7kiZp9R0wozPMHSQi0nVnc8BnfUkfbG+7F7ZuImfeR
         ufuPrY1VJLjjL3q1OR2OLOq/jRbtJk/KrqH3f8tpv/VbsGjb2EAnWVR8mSoYhx03ylna
         vOTn7wFbZnb+3BDk4Nf167hoMCwxdBHjGFQsXOewu3jZvfvYDudAxHzaD6m+SEuybd96
         jGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658226; x=1741263026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2G8IntqVZ/p0yVip5R832K06lAhv6smk3QugjfMN1I=;
        b=oKBWtU7dHOGnO7ok4yZwcBMGyR4dzJMI8CLW3l0wNwPnTaN/6exOknfgJ+6OUb6Cur
         vaGDao5Bpo7cWGn35nnVclGG0vWKF2hDavsyh9cK/2clMJNOYZ037ZfDNeGNavf8l67n
         SgZZMxIZUZ82dGf1oYSX0rNW2F1jjY8s+guB2t/8EJrwro7cV500eGbOGfqUiKQvv/ob
         xqzDApHqHqUEzp4csoIZZgdaBIAYg11asjv1SWcZQ/JJibPRv/yZbGZaaJWrjXnKEPtp
         TtVAtHlK0SXdEwXPt49naduqCd78gfX1F2pri/If7ufgotUmVZcCnim0oRrNjLvlxLm4
         77rg==
X-Forwarded-Encrypted: i=1; AJvYcCUvU5Uxw5u9jxD2Z9PFi10Q5+YRFhXGbJDL/9OUCali9g4uul3ivGL6hUsvgHmFBa9+nAVAOkWrwcuOipY=@vger.kernel.org, AJvYcCWkX4beJRbFD6uYas+pBmAD5BbHZQxIXhMZjTANyzUBFVebBMNYQiSAY6NLva1MgKDVOaIAObEcQUK7HS8=@vger.kernel.org, AJvYcCXZpi52OWfDb1Famn1uxjon3t1+BuHT+qwXhGpcjKxAzcZOzZjkjxw7T30NhPTh9fBW7ydRyVL1YJaJ@vger.kernel.org, AJvYcCXrTYw/ieBzoRh6tD0jhv+uRJRTn6xGEMMGD39B2l6Whz0kzQxxOFr8VF2HFXf0SEuXw8NABywIwXBu4re5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8t3CadJ819oeeIu0hI4LgMPVjAc95l5cB2MkbES5bQpeqG4u8
	bTbh/+WprcrxCoqCKG+mq8mQNvSIRbizJZ0hp5FU64CfBAXX/j+Q
X-Gm-Gg: ASbGncvoLiAtIGKWYf8BjqwfFsazl4zJGyNWbDHezvFj5W8MiiK1buq3yx5gq1aaJux
	NRq/2F2BTkQyyg5JN0Hm2irWgk7FvSjT4iN4kgWxTPdWS+zkozAV3Oz9sF+vcYwnl5UgdZC4woF
	SzT12aMa0kBXZ7Cv4EpbbM76y4YhdNesr0RR4JwF2J0JqlIkosEwePmPXpDnFMe77Met2Zk9jLr
	68SSTcQZcwxEMcAVUFZpuwelHna5/e3Iv8/o2g7tUkX0yxnp7wluoleDUX0CHi3JIEfB3G9CA+R
	oLTVMPyA64WFQ8eqSR6lR+rWQSZEnJ04d3aqdUYg8Wgc6Cw/zSu3FhiDfH6fAvt48yicFopKKqX
	Zc6miMVuaGuYZWZyzSmU3
X-Google-Smtp-Source: AGHT+IHSehyHYral5B9z7Uch5+OLoMeAHPJP+5CJ8NgoDW0Kj3SM8FYMoiHIT0RPXZr/7cRUWgoEeg==
X-Received: by 2002:a05:6a21:3d82:b0:1ee:ced0:f093 with SMTP id adf61e73a8af0-1eef55b57b0mr40384076637.36.1740658225781;
        Thu, 27 Feb 2025 04:10:25 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:10:25 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:39 +1000
Subject: [PATCH v3 12/20] ASoC: tas2770: expose die temp to hwmon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-12-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4581;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=ls6nJr6c5xyRlqW0wE9UzbvVJV/9x1W6y7H0wIut1z0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk+17PVqvTWXM3RNyNUaG7/jnrsye/94Pm/puZnU2
 X67d0twRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABPxWc/IsCBAyeaT1ZXDBmL5
 SbOMJy8JiO43SDn+Rts4unNLlHjeZ0aGT3f3z9h+9+HnJR6bL242fV10ZEdn0/XXE83f75/2x2r
 DezYA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

TAS2770 includes an ADC which reports the chip's die temperature.
As per the datasheet, the temperature in degrees Celsius is derived
ny taking the raw value stored in the ADC's registers, dividing by 16,
then subtracting 93.

Create and register a hwmon device to expose the chip's die temperature
to the hwmon interface.

The ADC is shut down during software shutdown mode, and its registers
are initialised to 0 on reset. This means that the die temperature will
read -93 *C until the chip has been fully powered up at least once (e.g.
the PCM its attached to is opened). Once the chip is put into software
shutdown again, the ADC will also shut down. The last value sampled
before this happens will persist in the ADC's registers.

Co-developed-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 102 +++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 7f219df8be7046912bf3ef452f75c17b5118bcf6..9cdd3470e9a04d5a5f801c3690d40f8fd131cd94 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/hwmon.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
@@ -491,6 +492,94 @@ static struct snd_soc_dai_driver tas2770_dai_driver[] = {
 	},
 };
 
+static int tas2770_read_die_temp(struct tas2770_priv *tas2770, long *result)
+{
+	int ret, reading;
+
+	/*
+	 * component could be uninitialised if the codec is not
+	 * attached to a machine driver
+	 */
+	if (!tas2770->component)
+		return -EINVAL;
+
+	ret = snd_soc_component_read(tas2770->component, TAS2770_TEMP_MSB);
+	if (ret < 0)
+		return ret;
+	reading = ret << 4;
+
+	ret = snd_soc_component_read(tas2770->component, TAS2770_TEMP_LSB);
+	if (ret < 0)
+		return ret;
+	reading |= ret >> 4;
+
+	/*
+	 * As per datasheet: divide register by 16 and subtract 93 to get
+	 * degrees Celsius. hwmon requires millidegrees. Let's avoid rounding
+	 * errors by subtracting 93 * 16 then multiplying by 1000 / 16.
+	 *
+	 * NOTE: The ADC registers are initialised to 0 on reset. This means
+	 * that the temperature will read -93 *C until the chip is brought out
+	 * of software shutdown (e.g. the PCM it's attached to is opened). The
+	 * ADC is also shut down in software shutdown/low-power mode, so the
+	 * value read back from its registers will be the last value sampled
+	 * before entering software shutdown.
+	 */
+	*result = (reading - (93 * 16)) * (1000 / 16);
+	return 0;
+}
+
+static umode_t tas2770_hwmon_is_visible(const void *data,
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
+static int tas2770_hwmon_read(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct tas2770_priv *tas2770 = dev_get_drvdata(dev);
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = tas2770_read_die_temp(tas2770, val);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct hwmon_channel_info *const tas2770_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops tas2770_hwmon_ops = {
+	.is_visible	= tas2770_hwmon_is_visible,
+	.read		= tas2770_hwmon_read,
+};
+
+static const struct hwmon_chip_info tas2770_hwmon_chip_info = {
+	.ops	= &tas2770_hwmon_ops,
+	.info	= tas2770_hwmon_info,
+};
+
 static const struct regmap_config tas2770_i2c_regmap;
 
 static int tas2770_codec_probe(struct snd_soc_component *component)
@@ -707,6 +796,19 @@ static int tas2770_i2c_probe(struct i2c_client *client)
 		}
 	}
 
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon;
+
+		hwmon = devm_hwmon_device_register_with_info(&client->dev, "tas2770",
+							tas2770,
+							&tas2770_hwmon_chip_info,
+							NULL);
+		if (IS_ERR(hwmon)) {
+			return dev_err_probe(&client->dev, PTR_ERR(hwmon),
+					     "Failed to register temp sensor\n");
+		}
+	}
+
 	result = tas2770_register_codec(tas2770);
 	if (result)
 		dev_err(tas2770->dev, "Register codec failed.\n");

-- 
2.48.1



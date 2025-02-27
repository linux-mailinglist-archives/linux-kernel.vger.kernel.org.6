Return-Path: <linux-kernel+bounces-536245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0EA47D25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F393C1883D08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FB236435;
	Thu, 27 Feb 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQOsJTd5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FC22C35E;
	Thu, 27 Feb 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658235; cv=none; b=KlZYwHIHtbTpEJe8OYhJv8WuWniBSRZHH96Cdr0SIVOuwDHzXOqlj2vaS+oCiWOQ6/F4nuzW9vP0TlLnvwlpgSGPNnGSWXAthkky3WiP38IuUB4OUNwiCmXXJJzto9X+lr20zyvDlBQUxaYTOUu0bRjBDkJ3aSRZhIVzncnTuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658235; c=relaxed/simple;
	bh=qHvfUmN1R+D3X/0kel7hIGI1UTjzGT/2lxJjDvieRlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsrBGSRL7zgwNYlOPNRB8xJzorTyhBMX+9QeI5Wc8ebpYR4dqYadAv2W8BFKe67QNr54ZG9LfWPD0mxRcixtZF1/li+VqYS4W65nZ8mObXkCf4AjGSQmNKbAkznvRem0OmsHtg6LlrsohheeDLeiw0bwwArxPwfswpoC998LXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQOsJTd5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22334203781so26125945ad.0;
        Thu, 27 Feb 2025 04:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658233; x=1741263033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XvdRl0ozFXSTGZyxyJz3ob8mwey7ewvJ2oCOTD5KBw=;
        b=gQOsJTd5khd/WzLikSSfhlX+oF3yK+yl0rUiES1n8fYTwytWCcEOZjeHmtXQCzGkji
         lbejXtJvQKFFE8gyqE7fGQ2SIJgvwnX9KJEz9gl4jzIjWbebZLAIr9k+zSjtLWsF0Htg
         /NjMvKeGp2DygqkRKFfutwtwubas4TiVZAl0z0SjSSeMmgj927ZsKS8x63o1S4RPgDGH
         pyTfqrePRgLAC6MUunDunENeJWg5MVmdEVvygtPuh69PIK1QJ/6SniCJKdTYLtCS5+E4
         ru7bbghYIqiFbxSc6w1y8rTRWorzMthzNK/Raxsofg5q6kAvwUWHM09yPnP8mlOXoUDF
         +SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658233; x=1741263033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XvdRl0ozFXSTGZyxyJz3ob8mwey7ewvJ2oCOTD5KBw=;
        b=qxdASI0qHF2Jrt40N1pmd58vEy/WPGl5TuSVFI/NrDrXI+qtC6b9y68XJKg3feWEXu
         Ojxf44x8S4X9pV7x2/Q8DSweM5+nGGCvgeKuPXGVkWhuPbAlPl7P81/qjkjoqMiEDzF4
         Jmi2Aaswvjs56/xtytgwebBqNWIpgnP5rsrk0QST1T2xjjzP/cpakqAR6/IpDJNnWLhx
         zxvEkeRuoPrgJGX1XEPULHaPAYLp9b+uQtwBQvBI7BrF55dHg6PF7vs7shKKrRqBsZC0
         /jlVQFaLyMHxWOx7a5b9u9KqHEHJ6u6P9OirtSozCNznhyNo98jHwBX/OCxQ9kEF8SGC
         Jt5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/UsmVNfKJr/9Cq/Nt91NUsMKzKfIPikP/6NNYLkIIiK1korXhfeHs25JcR5u5oeAoZQa1wCjJtLyDEU5D@vger.kernel.org, AJvYcCV79kKXcbx2JFkZW9PCJy0VY/bPJPIqw2WwdtL64ADijdtfFKz6e44e9auY5dE9NdCWNIoNVuBuBxLaDXg=@vger.kernel.org, AJvYcCW3RXrVtyQMh6SuRdqR9oBJL+rS+mZP+jBLXJ27Dz4x30N1Fp05nCODWCVx/NOkHZJMaUOzZDTlxSxt@vger.kernel.org, AJvYcCWCYbHaYUAxcUVaxMNxhSj4uckbKTQiBn8xcUWs/9lf3FFqwcj3IAOCZjhI1x7mQVrmV/Tj0gsWTF3jQdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59OR05ypTXQx8HUYC6YwmMLaZz3fDXYDk3epWxjD8E9BrS9LE
	Vcr9zQZZdRRbpwUo8j7M3WUQPF7wDxdVO7f+E2qYFNm//OGytzxp
X-Gm-Gg: ASbGncuS8f1qE4e9y0ClRV3puVkpKwe6zJ/CHKJ1S9LK22o/7CM9NRilhLawypSa0ig
	nZoFZV7oZUDZuMWoDqy1+DIKAGsy1dXddDFzW+QsEXr9F/cUZbg1mcksqVwhy0UL4cTKR9SXnM9
	BEQYNP9KJqQhRdciaR+kjhTS/0nuzrOCzGMdGjOXZaFFfVdoF9mFcm3X1dO+YTulrchv1JZe59R
	JircTeSL0S0DLMD5ELepX8bPQop+ewfU4sk/N0UShHSuZjOpSgUv48l2s6zILpL8zaAB0TjdnlV
	/8YoyqxRHnfJZ4o3W8eKcpYRkAa3dhl8SHJ51oj3FLCjumS3fc1DQBx5nKUq7ab8egyLUOQKvep
	eD6+2OTyJ52b6M4qiBKpU
X-Google-Smtp-Source: AGHT+IG1A7+2aRVuHKZ/d1JszoVfWOrdXpScsWQdnCG4oF1+hO3YTpEnAhE8uXpIffsTcWF0ln1teQ==
X-Received: by 2002:a05:6a20:8402:b0:1ee:b5f4:b1d7 with SMTP id adf61e73a8af0-1f2e387ef46mr4577116637.7.1740658233356;
        Thu, 27 Feb 2025 04:10:33 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:10:33 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:40 +1000
Subject: [PATCH v3 13/20] ASoC: tas2764: expose die temp to hwmon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-apple-codec-changes-v3-13-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4898;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=qHvfUmN1R+D3X/0kel7hIGI1UTjzGT/2lxJjDvieRlA=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk8t2cbyPE5qxrTuhu0bDHv+flROcNqiGCwtyXVX8
 vcpg6VOHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEzE2YWR4VPsljXee0+eOSMz
 7dC+hZt2O62QK9H/d5ZlTe6KmRLrONcx/OEQcu2cw3HA8UKfckT5vej5oT6TEyMZ7nlsXPXnasu
 yci4A
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

TAS2764 contains an ADC that reports the chip's die temperature.
The temperature in degrees Celsius is yielded by subtracting 93
from the raw value reported by the ADC.

Expose the codec die temperature to the hwmon interface.

The chip will initialise the temperature register to 2.6 *C
to avoid triggering over temp protection. As the ADC is powered
down during software shutdown, this value will persist until the
chip is fully powered up (e.g. when the PCM it's attached to is
opened). When the chip is powered back down, the last value sampled
will persist in the register.

Co-developed-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 96 +++++++++++++++++++++++++
 sound/soc/codecs/tas2764.h |  3 +
 2 files changed, 99 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 0234a41deecd62e860c9d54a7a3206abc0bdac54..b42bd5a50ee566ee83755d4ed7e2071b60951457 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/hwmon.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
@@ -578,6 +579,87 @@ static int tas2764_apply_init_quirks(struct tas2764_priv *tas2764)
 	return 0;
 }
 
+static int tas2764_read_die_temp(struct tas2764_priv *tas2764, long *result)
+{
+	int ret;
+
+	/*
+	 * component could be uninitialised if the codec is not
+	 * attached to a machine driver
+	 */
+	if (!tas2764->component)
+		return -EINVAL;
+
+	ret = snd_soc_component_read(tas2764->component, TAS2764_TEMP);
+	if (ret < 0)
+		return ret;
+	/*
+	 * As per datasheet, subtract 93 from raw value to get degrees
+	 * Celsius. hwmon wants millidegrees.
+	 *
+	 * NOTE: The chip will initialise the TAS2764_TEMP register to
+	 * 2.6 *C to avoid triggering temperature protection. Since the
+	 * ADC is powered down during software shutdown, this value will
+	 * persist until the chip is fully powered up (e.g. the PCM it's
+	 * attached to is opened). The ADC will power down again when
+	 * the chip is put back into software shutdown, with the last
+	 * value sampled persisting in the ADC's register.
+	 */
+	*result = (ret - 93) * 1000;
+	return 0;
+}
+
+static umode_t tas2764_hwmon_is_visible(const void *data,
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
+static int tas2764_hwmon_read(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct tas2764_priv *tas2764 = dev_get_drvdata(dev);
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = tas2764_read_die_temp(tas2764, val);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct hwmon_channel_info *const tas2764_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops tas2764_hwmon_ops = {
+	.is_visible	= tas2764_hwmon_is_visible,
+	.read		= tas2764_hwmon_read,
+};
+
+static const struct hwmon_chip_info tas2764_hwmon_chip_info = {
+	.ops	= &tas2764_hwmon_ops,
+	.info	= tas2764_hwmon_info,
+};
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
@@ -848,6 +930,20 @@ static int tas2764_i2c_probe(struct i2c_client *client)
 		}
 	}
 
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon;
+
+		hwmon = devm_hwmon_device_register_with_info(&client->dev, "tas2764",
+							tas2764,
+							&tas2764_hwmon_chip_info,
+							NULL);
+		if (IS_ERR(hwmon)) {
+			return dev_err_probe(&client->dev, PTR_ERR(hwmon),
+					     "Failed to register temp sensor\n");
+		}
+	}
+
+
 	return devm_snd_soc_register_component(tas2764->dev,
 					       &soc_component_driver_tas2764,
 					       tas2764_dai_driver,
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 4cf0f7f112d6c3002203fa32e900efd640ef3f22..4a419c11d4b08eebb915762db00af5c06ff3dd42 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -117,6 +117,9 @@
 #define TAS2764_INT_LTCH3               TAS2764_REG(0x0, 0x50)
 #define TAS2764_INT_LTCH4               TAS2764_REG(0x0, 0x51)
 
+/* Readout Registers */
+#define TAS2764_TEMP                    TAS2764_REG(0x0, 0x56)
+
 /* Clock/IRQ Settings */
 #define TAS2764_INT_CLK_CFG             TAS2764_REG(0x0, 0x5c)
 #define TAS2764_INT_CLK_CFG_IRQZ_CLR    BIT(2)

-- 
2.48.1



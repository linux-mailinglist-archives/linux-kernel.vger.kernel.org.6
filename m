Return-Path: <linux-kernel+bounces-518881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB58AA395C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A45C166C08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84A232377;
	Tue, 18 Feb 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gppSJDx4"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565C22CBC0;
	Tue, 18 Feb 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867858; cv=none; b=UK6d7N0Hzhs7ZbIyky2mGRy1Tu1yW27H/X4ca29f9bnWUMDll+mAZherBiL4m7RlNemkh0YmHaMtTcRXOLV6FAd1ni6wZ0O2KCHEchVLAa6X8i3ra4WObGIS9p1/l2UVBUE3m3dWos/FUIYKdualshCLzHIHLDePV3eftm/fGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867858; c=relaxed/simple;
	bh=R5CGUebK2zAj6O9/HHLGD450zIPtVaFw1f+T6NWzFVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fkw6/VWH4Y6rlgNX6GvcXpcIxieD/ytJs+3qx/sDDci2ub2RjpFN9knvPwV3ULqJNHQYPRxfK6ERs48snZ/yccwPzRNf/UvAggK7CIdjrqKJD6N4hVO4OIsauJ0A5+sw9aGbhkxybrNQdCQkl2ZXypw3T+Mon0T1kSNSLnbHeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gppSJDx4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220f048c038so63338595ad.2;
        Tue, 18 Feb 2025 00:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867856; x=1740472656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSGUP3m54FlOrzw+5tfDV1Rd46XpJOc9r57P1WtoieI=;
        b=gppSJDx4vyQtWa6Kxe3HwDdEl6jBdF5K5J8/xoya+a0muvM2XdYoIm6H2R+yJ2jnKZ
         ayohuTecRLcnRMYMCPBfjtYcslk0eoY1WfNBmqOn9mmNqTpWaeEOPdsaYtAPXCaLWsaU
         fNQYdtfdipE1cEkRSVYE6bRpKTdhQeWIrUY6nepL6q105qBJhYxWpP4GuG3A9VWnmSgQ
         wv8m90Yy4kVVQ8TU4saLFclK2+i/3PrFLV79fnX1bmIrpTWAkLDnJIp8G0iwKig7juIi
         NNs6DHaRIDCDYUkTX81mCoo/C6uUEvxvQP0N9CtFHboaNfJYHX9WzCxilUzUW2mXSTwH
         C8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867856; x=1740472656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSGUP3m54FlOrzw+5tfDV1Rd46XpJOc9r57P1WtoieI=;
        b=CfFEw9jUlunR64CKjLTzkoXs0rdacDMVxGEPQAQnOYsujbSs39/CmtmOUeN+X1MIUz
         29kSV7JrjTMY591yaFfY0eYDf3pKA69HZF8MZ3yZYinlpys8NkQj7X3bl4Lrv9kwKXof
         ZvdXoTFkfZYVcqAZ/CNTpamxYmE6QsCCWxh/VQF8hr5lW6E4Q1DxuVLcDZCpgy1JmR7I
         kSPmU5/q8vAmLaYKE67f3WtQMENqT6IUEj8+OKV49e+D8h/EKdtVy7xd4e3npDfs4qAz
         e73hAgpj4uGNNWCjhFhCWsDayHXPcNOmVY2oJuuJYf0kYs0rBtH+al1uMHYiDKtFSwAu
         oCUg==
X-Forwarded-Encrypted: i=1; AJvYcCUPbBmLIl8OEg0w6+twoIihnNWW1rYVGtwznFEHcwtPrE5MKxHO3H29UqUMKfACFa82seJNCstRCynKtoY=@vger.kernel.org, AJvYcCVAy2nDur4HZg7kRfyzeW8OEG5filTW7TXLb04G4d0mbPFtaxQCyZZlPkyU55rM+4TBSmCOTYIOtegTlAo=@vger.kernel.org, AJvYcCVk9U/3JqqLBoSCl3TkvKmMVJGrDRlP7GWBj70SZ/nosHh6BXUJO6AjOIssIypLURSi1EeaASsl1OncD/uw@vger.kernel.org, AJvYcCWuG2TRyVqZijTeEVzRwnD9g9O899BqJvAXRuPBEAnyUZkiihDlm4yY4NH9mvxXIdnF9cTCUJuUcJnx@vger.kernel.org
X-Gm-Message-State: AOJu0YxafVN91TNlYuVF6ZUouH4o/01KFqHdnAeYmONtEfH/cc1pnlt8
	SOyjFeqkTWdL5zboaKIr2VWWUXxP23etKOsQOgEGnATE9FgNzqFTfZLShc20
X-Gm-Gg: ASbGncs+ee/1seGb0Ot+uxqXHzhZY6xrsj378sR7yrfulF4yMmAcofj0lyM+mrh8hup
	JessTDRfsFH7Npm26VXBqvFX7sDPznSsQIT66T3hKYL6rSX10BU2epKFv+YFvPTk42Gmltg1ORE
	CdYHEI9mTfRMGzE+98rBRorEcwIxz7ga8hZvHJrwtZ6jEDj7fYmkrOXZnhdXASb0Hzgm4d1XAY2
	NID+bvMXo5HURBCJZNoh+SynBOPgBEiHT8Melx+M/ja6VIZTWNVgokY7DjrWHtTbrwaeq9HHnYG
	BuVX3uxuOxo7voIsB0M29IQfOvhPdNn0NP0f5fml7ECDz5Wr5SSgrlfwLzjWCuz7Dn82ZkhyKtL
	IlsrgpJRw2g==
X-Google-Smtp-Source: AGHT+IHinlUcJdepADETZgWdF6xVxTtPe3RJzl3iDPZR0TLKLeGYJs4/jm5yYrUcmNhdKp0WMMDrJQ==
X-Received: by 2002:a05:6a20:72a6:b0:1e1:9ba5:80d8 with SMTP id adf61e73a8af0-1ee8cc162e9mr20405530637.33.1739867856345;
        Tue, 18 Feb 2025 00:37:36 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:37:36 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:47 +1000
Subject: [PATCH v2 13/29] ASoC: tas2770: Export 'die_temp' to sysfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-13-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
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
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=lkuBo6XHksMD5HcdiK6pdh1/+6wNjBzUXd1OHHJ/WQM=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BLn7Z+4VtPB4N2MnK1OF0NPLuWc+UvU9ssedktF5
 9ZLWY49HaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAExk7g1Ghve2jpuUrMUa408u
 Dp+ns168O37VVnkxv4eaWQnte5M0bBkZHn3e3WO+V+gM59xMkZfJD1qr57+P287hljx36Zsrd9g
 beAE=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Export a file for the readout of die temperature measurements.
As per the datasheet, the temperature can be calculated by
dividing the register value by 16 and then subtracting 93.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 7f219df8be7046912bf3ef452f75c17b5118bcf6..84066884d36be8d41d83bca5680e9f683c420d78 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -20,6 +20,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -491,6 +492,51 @@ static struct snd_soc_dai_driver tas2770_dai_driver[] = {
 	},
 };
 
+static int tas2770_read_die_temp(struct tas2770_priv *tas2770, int *result)
+{
+	int ret, reading;
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
+	 * As per datasheet: divide register by 16 and subtract 93. We don't
+	 * want to divide just yet though.
+	 */
+	*result = reading - (93 * 16);
+	return 0;
+}
+
+static ssize_t die_temp_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct tas2770_priv *tas2770 = i2c_get_clientdata(to_i2c_client(dev));
+	int ret, temp;
+
+	ret = tas2770_read_die_temp(tas2770, &temp);
+
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%d.%03d C\n", temp / 16,
+			  (temp * 1000 / 16) % 1000);
+}
+
+static DEVICE_ATTR_RO(die_temp);
+
+static struct attribute *tas2770_sysfs_attrs[] = {
+	&dev_attr_die_temp.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(tas2770_sysfs);
+
 static const struct regmap_config tas2770_i2c_regmap;
 
 static int tas2770_codec_probe(struct snd_soc_component *component)
@@ -517,9 +563,19 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = sysfs_create_groups(&component->dev->kobj, tas2770_sysfs_groups);
+
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
+static void tas2770_codec_remove(struct snd_soc_component *component)
+{
+	sysfs_remove_groups(&component->dev->kobj, tas2770_sysfs_groups);
+}
+
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
 static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
@@ -532,6 +588,7 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 
 static const struct snd_soc_component_driver soc_component_driver_tas2770 = {
 	.probe			= tas2770_codec_probe,
+	.remove			= tas2770_codec_remove,
 	.suspend		= tas2770_codec_suspend,
 	.resume			= tas2770_codec_resume,
 	.controls		= tas2770_snd_controls,

-- 
2.48.1



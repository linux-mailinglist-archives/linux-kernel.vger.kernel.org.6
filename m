Return-Path: <linux-kernel+bounces-518884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AEEA395A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88E21897CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1322F15C;
	Tue, 18 Feb 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyz3rC1H"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C322D7BA;
	Tue, 18 Feb 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867881; cv=none; b=enK4T2tC493OqU2nE+F+9tiinE4YfEpPmdpTVbByOxDcMftZfaETop23ENECnTwbsCJzA6LAqgoBjk4XBnLjfC0IzYy/XkDmI/8rr+zRBmP2pgOjI/prKvHwihvSQK+DBGDBdXLIafN9YtD1iUzR7jMiwGAy8r+GOfObf1mQNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867881; c=relaxed/simple;
	bh=ELHe9Gx9zBA1ZoHYutyVq2BXEWZuUYmtVmXx2v/ql6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCGx3d/d8EoBcQaNRX2SftBhMJxDr7YmR5Ta4XVmPrIwkMSBDKQYyeySZ5NszOBURyEhUi4Qy4DrT1avDNglWgnQXOYZItfQveX23Cfg8rj7FnKt4+KY2+7h8qpqNsWcoy9sOZl5pkCcmWcuMyVXBGp3usQLOikHum7qitDC9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyz3rC1H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22113560c57so46601345ad.2;
        Tue, 18 Feb 2025 00:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867879; x=1740472679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsiNqfEcoONC0G46oo8Oc5GfM3qffuUL05c0mgTHX0Y=;
        b=iyz3rC1Hq10yFkNBtSxUJ3sO7DsaJj+5pTMDMZGvec6xEFODgXv5tsdZSsPxTDaoY+
         Si9tl8VKpE6E3xVxAvi/vG0IELxQwJgqtoxbVXlghjnyULlfT+V2FDX1Bsv5Ct/62BZ1
         7PnldJL2sXnZVZW5/RgfuYe+yD6VaBI3cTTOBpIFH9znH92J74THWKH7IDlsbrw2jk89
         TyetBhaboBw+XsKwytbFo2fwiriaQpDJVmXiXOrewHlWbt0q1Qh18pp/UXr+IcEYpBim
         2+BPlFDWNITBBcPbffuVBN4sUtebYtd4wH3qTh+lL7IC+/4cwlhwDaH9weUACD2vQ1AW
         3H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867879; x=1740472679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsiNqfEcoONC0G46oo8Oc5GfM3qffuUL05c0mgTHX0Y=;
        b=rK2VMZt5/ZkrJaNy0JDTIpU1/wycsCzKhmWw8tXZL6s9KqDVCXyUXT0GSm2MhafDSB
         8VLnItfX8oEyRRkYxXoO/vKX6sfySIQCcRi/9EhfiwXD5MVd6ZQnMolH4o1XmJEoPNVW
         lFZdByV07gGHMtP1OjfH5F0k8Jwvm/WRcIuVeFK6CH5nXIW8I9+b4bfJmy+H4qtK+qQW
         qoPO4mWnO3MYX7BSCkvu874BE/lIZasdwSF8pyh8wrEn53TjWLTIZEwUMYYtRg0Dg6on
         HxblTkczJFXY0SNtdPKqoO5V9eOF/sf2FiyoqdsArj+RqN5RZBetzxSvqJHCLdqq4y22
         aQyw==
X-Forwarded-Encrypted: i=1; AJvYcCUnexmbwT19ZheAmLb8yZPgqqE0acjF93uGeU+rRPmt4yVkCnxTOhv5rZ9dpQd4nv4ry1kNYZyGV0h9eDa3@vger.kernel.org, AJvYcCWm6Mu+TDYNTRQGTKzjx6DIJV3ncSD4ZT14xmWWEeB0NrnTk1pkg2RRBTiM3v/6WKKR/iWLGs6mtqxL9C4=@vger.kernel.org, AJvYcCXE0+d1SLXmAv+AWqh1wCXZ9dc4G4YWt05qZPTenWowQGLWCb0Khb8o/owfm8qEfTeqyKvJVKwiMqEx@vger.kernel.org, AJvYcCXRN7ei7s+DKvCIaZms6tVzlnrv2cFSFu34SErN/vb5h2nkD9PMtFgvlR6tBfH4tI9eBi8JntfnwRY4pMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbjocCJEQLvOdBdoq6i9YrzvdFxpY4LO7r3T/fqczLumoSUr3
	vdxwg4ZyX6Ysu6e7M8ZAxNoXciVJno27OEcfHdvcJ0MuvbCg2zCpvWCXd1Ky
X-Gm-Gg: ASbGncuRYroSoGLAG9LA/7R1Lrlib/E1LwLQLSeO2/56ipcyb7/sRtMv1qcnFXiOZzo
	Nltw1L073V7AaRqwsWIMNeIEyy7q5oCXyTTX9LzQEvkiXYC39vKoZVGSxRGASbeknjPiJ9kDTxV
	pCsVWDLmCaN8FO//SzHea3+iHNXsFZH1VGSYcHOV33O/NqohI3RD26fPyvFh9skMqBXOKMqV6ao
	B8ysomfaFi/erv/vHnhXbjlMn1wuqpBQp/iSPb/D5BFqknXtogC+Vmg8lppxSdVnF7d8WKsrwvt
	RUn2qLgNw77L5nJMEvx/crjEW1DVZzgTG5Uo4/jwfiMXzOT8BEp3i52elpMfK1jskZ3muvDI7++
	1Evvs4o4iiA==
X-Google-Smtp-Source: AGHT+IEF+IZYeppWpFRiGDvRqgopdewlzuMHucHDa0g++fwr8JSYoodOUVLlL3ed58cPAPVhWKpGaw==
X-Received: by 2002:a05:6300:6308:b0:1ee:c1b2:76d4 with SMTP id adf61e73a8af0-1eec1b2788fmr4186768637.40.1739867879084;
        Tue, 18 Feb 2025 00:37:59 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:37:58 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:50 +1000
Subject: [PATCH v2 16/29] ASoC: tas2764: expose die temp to hwmon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-16-932760fd7e07@gmail.com>
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
 James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=ELHe9Gx9zBA1ZoHYutyVq2BXEWZuUYmtVmXx2v/ql6o=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BKrOA7EVb++Oa3vr/Ob7pau2ovsCzZrb83jUZmp2
 +jx+OPijlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACYiEsfwP6Nj//dVDSttff9F
 CZptM6xg2TC5/P5VqQNJ1//8L/539TbDf9+WDutNBTeKe7JfHRaaztz/x1RvX93KwiX6u87ELBW
 cyg4A
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Expose the codec die temperature to the hwmon interface

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index b0d016f85f7fd57bec36b33db5e8c2bd242b5b94..670c59e57997a7988af837bd58da695ad773ae14 100644
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
@@ -605,6 +606,61 @@ static struct attribute *tas2764_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(tas2764_sysfs);
 
+#if defined(CONFIG_HWMON)
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
+	struct tas2764_priv *tas2764 = i2c_get_clientdata(to_i2c_client(dev));
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = tas2764_read_die_temp(tas2764, (int *)val);
+		if (!ret)
+			*val *= 1000;
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
+#endif
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
@@ -882,6 +938,20 @@ static int tas2764_i2c_probe(struct i2c_client *client)
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

-- 
2.48.1



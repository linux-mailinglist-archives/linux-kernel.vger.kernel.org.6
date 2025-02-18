Return-Path: <linux-kernel+bounces-518882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F835A395A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECAB188B064
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC4233D7B;
	Tue, 18 Feb 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlwoYqIy"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF82233136;
	Tue, 18 Feb 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867866; cv=none; b=hKcZ6+ELkT9mUYtZDkcydwX5/XDQO8TZSKzYtm64q++6pV/hI2rTT6i0TqaWgTcQu10TwGgOciVBn0hK7ljkEq3pnXHu8wM4k1qLrWU+5IeHJz9qv3/k5AzzGNlfw8XMeeOme9xk29/Agw8KaEGt3dJQQqq4lfHcBVeccP3b31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867866; c=relaxed/simple;
	bh=C+X0x7uIf65/mbXTMCE86W3v0h9GaMeMdchW1VENrnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/JXx7GF0MM5xKGmKs8WJd2VmRVhmz5DLL4WlrNNN1MnNBT0KNUDuCRWTDDqUIDlZN6btGPCmDJxfpHrY9EQQ+KvaTfZ3uoufflnF6aS2RRK91d3do5/1l/31DpW8rCHZrBMn+4API/mgEHEIPwGgsDlELjesXgMFuTe1kCl7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlwoYqIy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-221057b6ac4so43958115ad.2;
        Tue, 18 Feb 2025 00:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867864; x=1740472664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZkZf98xzuFsPo9rZYpEWNft19Sn7WJ32Cdi1OtVNJs=;
        b=LlwoYqIyjh1GCrnfz46vMI6s9+faY5PD2PKxakkJTJD90zsFtpzx6wqugkPRryaoTd
         cE9hcJNHVxaF5NFxYUTuAMyAckCixWnALOoXmdRPaW7kA0i/suqOu2NEHlTZpv8k+sdG
         eIeNESiLibfWaxGFNQDaaYlqt/xm1iaOFkKckd8TezEyT9kGVmNxjm8tvsuXOwQRjLXF
         w7U+GJ7oLlqcBofKI+YBQhZTDBcTvd2XJL/Ptx1c0dSJWBuqJ+77dJc3M5M3ql7ISjEb
         gz7k46r8mAb8xiFFXU0OlZnyHLSAkGmY9r+ZhP7JC4lzOHcia47LLtwE7WTJvmz6E78j
         5qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867864; x=1740472664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZkZf98xzuFsPo9rZYpEWNft19Sn7WJ32Cdi1OtVNJs=;
        b=RwpjjOh3oPVPnU7g6b7buyMSJaWAUKGwZgl4jAChAe6IMIJN9lmKf+s5+nj0d5VgzD
         pE/sRwEuOwkndgTdl8s2PBbU2rxK+foCqsFbcl9dzEaFjSLxXBhxiANW1K1TkiUfG3lP
         f71FhEM1m8Od7Hw8Vh2ZpRsyF5x/NTw3/wAKVJuOiN734ux0xMSUpRZsKEeK+CpCQ71Z
         uEy51GrmZiK5mIGl6kdFVUJcn1KaZV3VjLMlEBTUdTW2so8B1j1eUWxhqyFFdHQ7oVWz
         093iI4Qlb2f2oCONCvUYQTIgXIQGfqwX+DKeJH+bl0v8ClBFEJ0qo40UNpvdnquGHMwx
         mRlA==
X-Forwarded-Encrypted: i=1; AJvYcCUwuMfmwc5s16zqWl1kvQKaj64aJfkp+84ZHplXLp2ElWP7aNq6VI/MHTp5KUV3vyTRQP682a7WQtRw6iU=@vger.kernel.org, AJvYcCWfc1TLYLgC46MrHM8+aX0elFMLtevCKnFfd40YSgnnhBI7SsrA6jl3T2QN9Un+rxT2uqTkz2VUUQYXsiM=@vger.kernel.org, AJvYcCXC5AQiHfHBacnqXwfhd1sekz7B2rB/RSgyz8OSFqbmNtSItlgcSV01frisr49U8RNFvSTe8hb36vYL@vger.kernel.org, AJvYcCXPjnuTIxbFpn0GHtFd72O6EiqUNf8Tl5HlIBoHhiWfte+rLKZ1B45yh7gWA7GekZod5J6GZxm0wlkNS5/v@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqZau/F+QTz9h9Rbi75wV37mHHXvfNIC8xl/7JqAnTjxayXUY
	W0zJ5hrekZdbBr1T+6LWWayDXrB/WuqcMU6vazknHf7ZZyAjknY8fJCZvlAy
X-Gm-Gg: ASbGncvVb4X3HJhZ6bO7O/4MkHefu5uAWnejkT8bdTG2AfxqziEcaH0M2MWW2A3/vEE
	Tf61SuNEbZlvAjixFPzhvdmY+35hSRNqeBg3qCuK3ZHgX7uN2OA9qmB+QnEt7bmA+D1Ad6WVmCC
	clfAnCPqiB+Hg33es1EYVLg953rf3+Q5tcnChejVrK+FzoSYoHjmAamgjExGDp3R2KE39j0jGdW
	wBgCthp3/EzCa+RqV1jUzGb7jes0ZsXwyLwSxRHSVLPkP4eyXIZJJJBv1riWkrFKZjGudwNsIwT
	yuk3BDml2jNdB9Nxw5XXWt8Lf9Xv8AQGFh4uCzFh4tvPv/LNsjYhIB2KtQNrCMBS4WlhihCyO9D
	9YpevzL9sow==
X-Google-Smtp-Source: AGHT+IHnEmsdRs0QDQNqmFf6dAJT6iEkiGCVIADqflKn44jjikjLxu6ge9+xE6rbdfiUgc1uqiS8dg==
X-Received: by 2002:a05:6a21:3287:b0:1ee:66ce:16f4 with SMTP id adf61e73a8af0-1ee8cbfe3f6mr23976267637.36.1739867863817;
        Tue, 18 Feb 2025 00:37:43 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:37:43 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:48 +1000
Subject: [PATCH v2 14/29] ASoC: tas2770: expose die temp to hwmon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-14-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=C+X0x7uIf65/mbXTMCE86W3v0h9GaMeMdchW1VENrnc=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BLPuG0q9yy6/fZmd3+EAu+GtU/Dbj682L5v0QV31
 j+H4pfpdJSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjARYTOG/x7tj36wGtt9vjnr
 6e8XtYfTOY4EnTacpTwnrt7+wgn/w7oMf+Xc35/MLVDkbjiW6Bx9z3pt3LuKlozZ57b71rBZvRK
 7xAIA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Create and register a hwmon device to export the die temperature
to the hwmon interface

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 84066884d36be8d41d83bca5680e9f683c420d78..fee99db904a5885d740c1cfe8ce2645a963c6e1d 100644
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
@@ -537,6 +538,61 @@ static struct attribute *tas2770_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(tas2770_sysfs);
 
+#if defined(CONFIG_HWMON)
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
+	struct tas2770_priv *tas2770 = i2c_get_clientdata(to_i2c_client(dev));
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = tas2770_read_die_temp(tas2770, (int *)val);
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
+#endif
+
 static const struct regmap_config tas2770_i2c_regmap;
 
 static int tas2770_codec_probe(struct snd_soc_component *component)
@@ -768,6 +824,19 @@ static int tas2770_i2c_probe(struct i2c_client *client)
 	if (result)
 		dev_err(tas2770->dev, "Register codec failed.\n");
 
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
 	return result;
 }
 

-- 
2.48.1



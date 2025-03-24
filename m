Return-Path: <linux-kernel+bounces-573686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC3A6DAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313281896448
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9025F79D;
	Mon, 24 Mar 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXH4m8zD"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838A25F966
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821274; cv=none; b=p1CbVByBZc/IDiAHQD4zPua7k0UXE38IF8RchDiFH3t0n+danHwqB/f+a1CVpvsWcLjbQFgKKA7B9nM4wkuiOZiS3Vq68OWlXHxQ2RSnO9rj8G2FA0nj7nNNr9eYE/t2SK300onbc93ryzLa3d8GP91wWdppVGf9kQqAp1S+RrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821274; c=relaxed/simple;
	bh=EIis1g6PdS3f0AOhNeshL9YKCmmKkSkIVunOteFUnBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edjG73FlOdKgCKJk+iRfxqChY/MyKik+8eExBFo7qarinI3ZwhnPZMn1jiewd6Owx4BsrKpBqzUlK1p2EfJipZ5vek2+CYWIxEQ/D8Fv7QfOH7L8w580SsL+BZJcR3wEfkzzJMa/k+BFXnFeQN1lOe02+DPyyIz4JeEPe5Q8608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXH4m8zD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf848528aso36443125e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742821271; x=1743426071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIxdXc3XxbQbeeDfHw+WlqIL/H9ji4aLpTo3X7yPJCk=;
        b=LXH4m8zDFEMeHYO5xXSPRwIVafTHXP5UGcRE8RDlnLSkrXsWwZRz+EmoqOEIRVLFtr
         eNp4JDbFIiJdCMmkQi4xWqDwyg0Tp6800AjmUc/WWoOWsRMkUdyfADYfZkEbfwgwUwZ9
         xjDlMzqxMAxahQxsEy2Do369LIQn9Qpo48IFShEAvAwGeO+WwyuJ0OkZoc8HlCjm+Ag0
         dyQ+GureGoMzz+rdv6uWNEu9miex5E/rO+7cpVPLovTFsOEYhpcQCpxMDzz8s0BAhBpg
         +HVURpggVTDHZJMEM3hDb4f1pH/FvwYfwJfwM4iOdE7HEzLP+h+wLPgxWZ9b7EvYaJgd
         R2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821271; x=1743426071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIxdXc3XxbQbeeDfHw+WlqIL/H9ji4aLpTo3X7yPJCk=;
        b=Bkbxihzd1aNEqg/Oyz1RGwCjOvaN98M6g2zq2bqJ6CSGvrlzESQcvhwJ5qRMzZ5gO4
         CR9Jqt6FqbEo7tf2kXXjoGaIt67sGsr37tlzvaoqOSh2A2imtGA+ilVXQ6YznolynjrN
         9GPkg3Gk9SC/7PBzXPGard5iK//Gal8S+wdSQ4J0G7cQ8Ua+RlF5IEfL8V1WPmOFc8Wz
         EUX8yFkrmq9DXOpCLtFJmtYAnzGQXDllK7qzCQk7hVSO7okUdUPBCM1oJiC4gsEJehkq
         1K2erH/TfV2yRZvAUc1vDw04m/gJaoISTFDH+Y1EtypZfNfioUTWJJjlpN/vRUIhdRcG
         cAKg==
X-Forwarded-Encrypted: i=1; AJvYcCXVEVy6gbManpUw+o1YlYOObVaJhHPiee9yTgcQ1ogutmo7nSKkav9KE6RgfaMgHPt0SowAZPh3f6HD+LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZIRvLwuho4nHy3sGWn4EcxCsHapbIQ2hKRkID7Ik37wEiLg1
	GeIaV5GspOYX4haEsg5P39zJar0pASr/naf8bOdReFxcYNAaNIfhV+PIa+wxbHk=
X-Gm-Gg: ASbGnctTmqlIi63t87xF47OKDVPiudnn/UVeZ+OEztRm8zqf1ZOZZZX5Z+CBi+cVZGM
	gr8BnIGz7oysgZA7k3uoFpHenFk96UNtm3K9fzetvDrm/+of/QdtOkkk6YTGxDM/QkdFgTmJMxc
	wN+KLGoNHqkLV3cX9YMddrJ4k27QnMkCcOUO3T2NpldUmfLf/A08SkSxKsgG2SCCAO/ZAvv+GY3
	yoUangx7XK+M2FSVxU6MK3MBHR9P+4+U7ong4/A05aKyXd3cI6SeJHAGQiS/Dhg1//Qy2vGwQXw
	hA/M/DdAa5cNAXl1LYWUm88x9/jJbtzflKMmAWeuPfUCiuw3lmP4vu60oyCua87jVg9wPg==
X-Google-Smtp-Source: AGHT+IFs97yEJFrcQcGHdF61b11+D99EkuGXdOkKnHbn/qoC7JXgiu6gUj9xe/poo+JHd1PrEG2cvA==
X-Received: by 2002:a05:600c:331c:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43d52a8ff41mr52077115e9.21.1742821270695;
        Mon, 24 Mar 2025 06:01:10 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd1c7sm122275975e9.40.2025.03.24.06.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:01:10 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Christopher Obbard <christopher.obbard@linaro.org>
Subject: [PATCH v4 5/6] ASoC: codecs: wcd938x: add mux control support for hp audio mux
Date: Mon, 24 Mar 2025 13:00:56 +0000
Message-Id: <20250324130057.4855-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi mux is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable.

move to using mux control to enable both regulator and handle gpios,
deprecate the usage of gpio.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 sound/soc/codecs/Kconfig   |  1 +
 sound/soc/codecs/wcd938x.c | 50 +++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ee35f3aa5521..a2829d76e108 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
 	tristate
 	depends on SOUNDWIRE || !SOUNDWIRE
 	select SND_SOC_WCD_CLASSH
+	select MULTIPLEXER
 
 config SND_SOC_WCD938X_SDW
 	tristate "WCD9380/WCD9385 Codec - SDW"
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index dfaa3de31164..88c758efe40d 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <linux/mux/consumer.h>
 #include <linux/regulator/consumer.h>
 
 #include "wcd-clsh-v2.h"
@@ -178,6 +179,8 @@ struct wcd938x_priv {
 	int variant;
 	int reset_gpio;
 	struct gpio_desc *us_euro_gpio;
+	struct mux_control *us_euro_mux;
+	u32 mux_state;
 	u32 micb1_mv;
 	u32 micb2_mv;
 	u32 micb3_mv;
@@ -3235,17 +3238,31 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
 		dev_info(dev, "%s: Micbias4 DT property not found\n", __func__);
 }
 
-static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
+static int wcd938x_select_mux_state(struct device *dev, struct wcd938x_priv *wcd938x, int state)
 {
-	int value;
+	int ret = mux_control_try_select(wcd938x->us_euro_mux, state);
 
-	struct wcd938x_priv *wcd938x;
+	if (ret) {
+		dev_err(dev, "Error (%d) Unable to select us/euro mux state\n", ret);
+		return ret;
+	}
 
-	wcd938x = snd_soc_component_get_drvdata(component);
+	wcd938x->mux_state = state;
+	mux_control_deselect(wcd938x->us_euro_mux);
+
+	return 0;
+}
 
-	value = gpiod_get_value(wcd938x->us_euro_gpio);
+static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 
-	gpiod_set_value(wcd938x->us_euro_gpio, !value);
+	if (wcd938x->us_euro_mux) {
+		if (wcd938x_select_mux_state(component->dev, wcd938x, !wcd938x->mux_state))
+			return false;
+	} else {
+		gpiod_set_value(wcd938x->us_euro_gpio, !wcd938x->mux_state);
+	}
 
 	return true;
 }
@@ -3261,11 +3278,22 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 		return dev_err_probe(dev, wcd938x->reset_gpio,
 				     "Failed to get reset gpio\n");
 
-	wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
-						GPIOD_OUT_LOW);
-	if (IS_ERR(wcd938x->us_euro_gpio))
-		return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
-				     "us-euro swap Control GPIO not found\n");
+	wcd938x->us_euro_mux = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(wcd938x->us_euro_mux)) {
+		if (PTR_ERR(wcd938x->us_euro_mux) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		/* mux is optional and now fallback to using gpio */
+		wcd938x->us_euro_mux = NULL;
+		wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro", GPIOD_OUT_LOW);
+		if (IS_ERR(wcd938x->us_euro_gpio))
+			return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
+					     "us-euro swap Control GPIO not found\n");
+	} else {
+		ret = wcd938x_select_mux_state(dev, wcd938x, wcd938x->mux_state);
+		if (ret)
+			return ret;
+	}
 
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
 
-- 
2.39.5



Return-Path: <linux-kernel+bounces-573544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D577A6D8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854323A6609
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE925EF8B;
	Mon, 24 Mar 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVO7PYP7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA325E800
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814390; cv=none; b=V4MtJqbbam+IXh1lzZebOJZofPk9FhpxID9tXZPRxDSP6WBhN6LByNO+fZgjr53WTbD9A/XPEMWN1eZaK3NTvpaWDh4iH6+c+Fyns7o+kjVO/HcQLkIyFRodzexu4zZ8PazmpL/y5DaoLaXQnKsaIObgVVkENPaqqTtPwRei5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814390; c=relaxed/simple;
	bh=nktXVZZVK2sj5ks05K/PZQORVrDJifJshcJ6Gwx0Vgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fnqyl+squOOqSDa8kxbfqYeg24KWtnTb8Jqvi7UVVCLrCREpcNZ9GefFt3c2X5Ju8YYKg+pUgyqnEniKHvUuZniyAJ7EB4eJUe/lF/zW1ZWzuVz6TEmIQgnPNYwA0AQhRRGj8NwGtH5xwfewpCo64nnd7He4u0bK7BcABVpdK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kVO7PYP7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so32767525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742814385; x=1743419185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkYGp+yUUXL5KluJTZ2cEbi897SJOatbkfeU/8clakc=;
        b=kVO7PYP7gQWdll9HWyQZmf88wZZ9cyL++cWFdVQHihxQ3LmiBne2XhUXabuLXVQtcI
         DmcjUixu2Nw7GhYO/Izza2H1vS8FKKVjA60oR9mySoUCgSMrEl66elUQyaHJcYa0FDWf
         YRoqq0oiv2dsDHa/RYK71E7NMg8Wvo+DuO6VU40jv0axx6/RSf3e3M10UtCpBfstwamf
         rVo0Zdc219ALPeLvQULH9B+3Ph9uol6WsEclTDjG+r47EPvnubq6A8fOeCWBLcrckwpG
         xjVNVM4PiDBw0E7CpSxJo+xWrdIYLl8yJAAu4jntPhUwModnHODWuKqTd3OiDWy7n6aD
         dVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742814385; x=1743419185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkYGp+yUUXL5KluJTZ2cEbi897SJOatbkfeU/8clakc=;
        b=VQclDcKswHnXGpj9YnntHWwYs/ce6r1+1/nBGDCqXPXshYIoXQFKlna5igjT9pNUud
         xiYIM7gjRUZ6XRi/9TMBZDo9fBsmVoX1jYFBukQqaNKgbXurMI7xGKX/L93ogsHKM23r
         Ko6jDNsnkiuzkZ8C0W9iCD9rkvLeTG2d/ntGmx2pzG49/ye7gBVm8/L6skeh1U+SJ4uG
         Vz6ig+dh95tgRsFGfHUY3M1uGskOkD0XszYr5uXN7PvpSYUoOnKRL7tVOUXceAWDh+xV
         Ou0CFRVa9MyLjVENSq8RPn35klt835ShbneFwKV+k631RALzIXPxlc8Yc2+W976AADgR
         faJg==
X-Forwarded-Encrypted: i=1; AJvYcCXSzxxXGqDD8pNwx/z1DVk7noRyyPYSx4Vtgxn+z9FX24SwucrBGSWEUHtrRAoV82bD/9ElQAmjnH/FZ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vxHDwYpB/QkBLL4HDZXuXSUtukOFdzXD4CZc/cxc7k3RbjM/
	a4hfDBw4ZJmjyUlNDmACKS94T75FXthjcur649DSd4CODCZ1kMpgysCMri82QE4=
X-Gm-Gg: ASbGncvFXn9OUZg5MgfdKcc70S7wNo5BLLH6qNfD4uQMdZYspheRZQx890236GwM+bk
	wcpmy/5UNii9Cqz0JaJBx3LzVcY0x1wjTKz1qMtErx0p+Rsw90qjtkEQ7/OXu7KUZSV/TXn9sA0
	PKcnRsAoQoAQDtrnpYZEqZcEXXeTQDsSfyD3XSKdiSZLuy5Vr/5PZHX9kRMqX5s5vRSNE/w1t6f
	xm1Rn4j+olh+MnUcBF/98/Gp5iRWYb+8fRUcvtOJ1SytiCAJAq1kR79qsdNLUxRIrZcYFP7E9/0
	59O1dp9U3kuH6Mn46KHD9PI0YRVjgWol+DU22SS1U1e80zT4RS5PN+PtsYOuY2uAvUBA9A==
X-Google-Smtp-Source: AGHT+IFkqz3TkyW72Dlofx4AWfR6O0kT6HbA7qk3BC0dzeXLv2ZnZ2GDWRW4bucnsET8PXCbkEK32Q==
X-Received: by 2002:a5d:64ce:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-399795567f7mr13655493f8f.4.1742814385406;
        Mon, 24 Mar 2025 04:06:25 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm117236055e9.24.2025.03.24.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:06:24 -0700 (PDT)
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
Subject: [PATCH v3 5/6] ASoC: codecs: wcd938x: add mux control support for hp audio mux
Date: Mon, 24 Mar 2025 11:06:05 +0000
Message-Id: <20250324110606.32001-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
References: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

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
index dfaa3de31164..948b5f6cc45a 100644
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
@@ -3243,9 +3246,16 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
 
 	wcd938x = snd_soc_component_get_drvdata(component);
 
-	value = gpiod_get_value(wcd938x->us_euro_gpio);
+	if (!wcd938x->us_euro_mux) {
+		value = gpiod_get_value(wcd938x->us_euro_gpio);
 
-	gpiod_set_value(wcd938x->us_euro_gpio, !value);
+		gpiod_set_value(wcd938x->us_euro_gpio, !value);
+	} else {
+		mux_control_deselect(wcd938x->us_euro_mux);
+		wcd938x->mux_state = !wcd938x->mux_state;
+		if (mux_control_select(wcd938x->us_euro_mux, wcd938x->mux_state))
+			dev_err(component->dev, "Unable to select us/euro mux state\n");
+	}
 
 	return true;
 }
@@ -3261,14 +3271,23 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
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
+		if (mux_control_select(wcd938x->us_euro_mux, wcd938x->mux_state))
+			dev_err(dev, "Unable to select us/euro mux state\n");
+	}
 
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
-
 	wcd938x->supplies[0].supply = "vdd-rxtx";
 	wcd938x->supplies[1].supply = "vdd-io";
 	wcd938x->supplies[2].supply = "vdd-buck";
@@ -3581,6 +3600,9 @@ static void wcd938x_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 
+	if (wcd938x->us_euro_mux)
+		mux_control_deselect(wcd938x->us_euro_mux);
+
 	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 }
-- 
2.39.5



Return-Path: <linux-kernel+bounces-217664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D290B3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610F7B3ADEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F9D1D2153;
	Mon, 17 Jun 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gyya6KRr"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64720011A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632277; cv=none; b=hO4+8Aq/hILzqbnrWoAvgAMAMyWJ33LEOW4wMSjLFq/QMr5CqBPaB20hJsimXy2kZAIoKWrhQNIvSh2Umhyn5kYftwBnS0zWOS+MONio3XRt69hQaGIm52LZBSFjjbzUvNYaT+9Fb4i6g5y1VSud2O3L5DpqbfhbPW2t7N1VeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632277; c=relaxed/simple;
	bh=IMPpMteq51LRPDW2gSf+ThyrqorBSKEQdFy+CzbJC88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofS9pddtJDWp0+h7eLclIGXmbXR3IjIHPOyJSGJHwZie6ezupRSbcmMrouBBIoxYW4PcU7ILU0LI+vokCveRtZ59DA05QKxxuoddHW7YrurDFQXFCAPJyKAAKQDmKEUDC7rkXXBq/JGp+2DoWlqSYVnpMa9t6vSrcB7JFFpOb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gyya6KRr; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ee5662fde8so942853e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632273; x=1719237073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKnuVsDBtdHGm81QL99oZtdVbIW3JEVTOu6hlNZPjXg=;
        b=Gyya6KRrEo4aqr8ywMCcfchhoVHUekY7hRS+pnAXJN4eI4HCPKnQVpWaoO8P1XFi2v
         PvdtIHX5F6MGkoFo8L6Ut4hfBBh7cEejitHVeWDiWTZWR73DKLPz3CXWAaP9HcoBArBh
         YRVjKtwezkRAUQamXRqdc029Kn0H8VDDjLzM45CIvRowPedBbmFLdDoC9tBKZ+5akHY9
         Rcn2UZ9Dp0El5Zv1yFvC8NVPLhPMDhxkcyn/QzQ1xz8DVwA3C6rQF30dO22NatJw/6Z7
         JpXJPlIvVb7XYR6Hzk9hBcnhPWcsxFChOTEnkosxhHOZ+06Zj/lb8Mc9COFj4GuOsNCN
         04gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632273; x=1719237073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKnuVsDBtdHGm81QL99oZtdVbIW3JEVTOu6hlNZPjXg=;
        b=Eac61Bi8D+qa/Z1YVtilR8UHqX5hU8PaVUAzFKMP5eBVnp0cbif9K2PxLTqGxDV3+D
         71/63JPNpNR97hIpk+bpDvcr8r3E3PNwG+TyNX41LtsiwNEFT74pojnezrbgyAfS7kZi
         0iUhk1WsZVk6ceDtN08accaj6K19UWRqqDYIVl+Inou4iwzrcI6UFCJU+xGJsytYJrkd
         2cclmFag8eFJltRhvt41QHklqGEKOOxIVa+VgBpJS19iJ8lT69JVWEFlK+nEwcQHwAMw
         QAQvK4ltrKEV+s2UMi4xOkZWJxWiILnr1yR7GdB1E+/2SdfPXla0Bkh8bK4HfdKOKGvw
         EPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2J3qqzKc6q12NrokwTC+MoT5dtdzkOEM7Ump3xLnuBvmq7mLqv/J8bmGZh/vO74FRW+5yFI17tWgOttgX+D5iAO2kQ+bNmC0IgWLs
X-Gm-Message-State: AOJu0YwG+UwXNLnIqmpEgBLzMpImLqGPrLD2rQzLR735z8P92WXcIhYF
	lZ3gNOwEcICaJGQqcI1wMcYNHs7lIH3jePu5uYZ3TYfwx0+MvFs31oabDo/inVQ=
X-Google-Smtp-Source: AGHT+IHFy1tuFMwxa7P6sFsjYvAHUS1dIKxzAj2HLRYOAmnW2Gug4qjgVMG/WpGom5Qua5PdHz8vPQ==
X-Received: by 2002:a05:6122:915:b0:4ec:efca:d2b with SMTP id 71dfb90a1353d-4ee3e59c40amr7925275e0c.8.1718632272678;
        Mon, 17 Jun 2024 06:51:12 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:51:12 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:21 -0400
Subject: [PATCH v3 41/41] iio: trigger: stm32-timer-trigger: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-41-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 34 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index d76444030a28..0684329956d9 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -158,7 +158,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
 	regmap_write(priv->regmap, TIM_ARR, prd - 1);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 
 	/* Force master mode to update mode */
 	if (stm32_timer_is_trgo2_name(trig->name))
@@ -169,10 +169,10 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 				   0x2 << TIM_CR2_MMS_SHIFT);
 
 	/* Make sure that registers are updated */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
 
 	/* Enable controller */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -189,19 +189,19 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv,
 
 	mutex_lock(&priv->lock);
 	/* Stop timer */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 	regmap_write(priv->regmap, TIM_PSC, 0);
 	regmap_write(priv->regmap, TIM_ARR, 0);
 
 	/* Force disable master mode */
 	if (stm32_timer_is_trgo2_name(trig->name))
-		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2);
 	else
-		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS);
 
 	/* Make sure that registers are updated */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
 
 	if (priv->enabled) {
 		priv->enabled = false;
@@ -498,11 +498,9 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				priv->enabled = true;
 				clk_enable(priv->clk);
 			}
-			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
-					   TIM_CR1_CEN);
+			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		} else {
-			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
-					   0);
+			regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 			if (priv->enabled) {
 				priv->enabled = false;
 				clk_disable(priv->clk);
@@ -555,7 +553,7 @@ static int stm32_set_trigger_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 
-	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, TIM_SMCR_SMS);
+	regmap_set_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS);
 
 	return 0;
 }
@@ -683,7 +681,7 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
 		return ret;
 
 	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 	regmap_write(priv->regmap, TIM_ARR, preset);
 
 	return len;
@@ -757,9 +755,9 @@ static void stm32_timer_detect_trgo2(struct stm32_timer_trigger *priv)
 	 * Master mode selection 2 bits can only be written and read back when
 	 * timer supports it.
 	 */
-	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, TIM_CR2_MMS2);
+	regmap_set_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2);
 	regmap_read(priv->regmap, TIM_CR2, &val);
-	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
+	regmap_clear_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2);
 	priv->has_trgo2 = !!val;
 }
 
@@ -820,7 +818,7 @@ static void stm32_timer_trigger_remove(struct platform_device *pdev)
 	/* Check if nobody else use the timer, then disable it */
 	regmap_read(priv->regmap, TIM_CCER, &val);
 	if (!(val & TIM_CCER_CCXE))
-		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	if (priv->enabled)
 		clk_disable(priv->clk);
@@ -841,7 +839,7 @@ static int stm32_timer_trigger_suspend(struct device *dev)
 		regmap_read(priv->regmap, TIM_SMCR, &priv->bak.smcr);
 
 		/* Disable the timer */
-		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		clk_disable(priv->clk);
 	}
 

-- 
2.45.2



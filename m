Return-Path: <linux-kernel+bounces-225393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FAA91301E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD976B251FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA93817C7AE;
	Fri, 21 Jun 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n0oIgT4o"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868D16D310
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007925; cv=none; b=jfBtR+WiUd5c8VHt+c5UjpooM9x7hEsAcsaUoX88ZUtnUeAVZ7XAu/ruKQjMDbRpSKIUrg1IElOpN1Vy+632mf5DgiCSeNFuziO2AtFNkUylpSb9MudAASNVUfW7EBTzcyW/5jUQOjXInyK13rLD1NurS45R1ini/I32QcdX9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007925; c=relaxed/simple;
	bh=dFyOMn9zYwY5ETeFlyN+7rPTFpa4/nhO8WZn4HyNnY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiPIFVuR0TnarODk8wcvdbXh23I5PrBFobhveneNckQWMMhvlwPIZAKjh/QVMnVrtKemqEM5Uxo/k8psmW2XSrdJ6d4PpSva3aquWUgDtIkLNLK2yvooYiXE+nfpuPegRORU8cVAO9BqqnWg3ZUnpBbER89ngMObXNrc/rqqW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n0oIgT4o; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ba33b08550so1134562eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007923; x=1719612723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVRdFKhvRMw+/o8IRTEZqQPsLylWpccjPYBus1uBROU=;
        b=n0oIgT4onepIHLum6zyxgtewIffvpmTuZLFg352UnUsM0dXDMT3+B+z5VoMxd0adD7
         y+i42OOC/EKZHAarq+jEcFERgwLhhEWKxvut3872d8CTs55qPeYOMD+9O5g3eNtX4keE
         KeDimLy3ABGU+yatdpgmCExOiZUw3IUaP0joaO+uF5v9A+LoH2LKaZKBs0ByutKX5r3G
         o7/ddUiDK+4gOSfXxq1PeSaOoqubblFdGAtA+N5387jlPiTbFw0LcAtE5ujIuEGuvpig
         OOCTBq0iDdQS3UxSCJgQfj3Ponqw2T8A/DIAyooGFjiuCE4kLSOPrzsJpYJ6s1ZasrLh
         IVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007923; x=1719612723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVRdFKhvRMw+/o8IRTEZqQPsLylWpccjPYBus1uBROU=;
        b=e3BjaUkCSi5aPZePcxTUdG/4yPGLrfx81ermvDIfImmOqY/9IV2Hq4MNvbCj2OVDUT
         h8dX5hKbUM9niuLu+ZwNoNWZHSI6c17M4xv9tV46OWwgQr9DrZjT5UKvN9SdvyLC4zfq
         BKc1i7vA94sN8Ru4YLp/dJHIx/P+UHQcB+1N6Sj+0d4yIVssJP7MMC+HbL8i+fT+B6AQ
         wdh3gYQFYfS0pUnw6sIXVhAQ4YFfh+9ImFqTZKd9xVYKPmSMc8YPFGJFf1aC+h6G70I2
         jiq4SbqejI8K4ptZWA7qAp1719Th4EMmguVWC7yu/oZfKPYevQy8bL0vpZmNeG4uFAzj
         kfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA4FwhfScdZby8us+3J5v/6Ze1wKtgJJnYURYhxEc9qXAShkbWtMIGPGxw5V5eN8e0U0lJAkGWo43b8NlgJZrGjvFIVR3SRonaYuQg
X-Gm-Message-State: AOJu0Yw2rjFbbYdiJCvGmShrdE8YsJeDp1bH1Hqcfv4m0R+Uejb3q/Qz
	DNac2/x2ZhY+iQaYg0uuH0FBBJ7YGiTnCSsL0qvVxFSxnluLy842Gc1Q8rLNP9w=
X-Google-Smtp-Source: AGHT+IEAf590qHVXQF6WIVmoewi4OMSB/t6gCupkb1CE8LPyqCFfpCApy+8JHvS/R19jM823AhGK8A==
X-Received: by 2002:a4a:ea0a:0:b0:5c1:b998:a861 with SMTP id 006d021491bc7-5c1b998a905mr8204856eaf.5.1719007923356;
        Fri, 21 Jun 2024 15:12:03 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
Date: Fri, 21 Jun 2024 17:11:48 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-1-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the devm_regulator_get_enable_read_voltage() helper
function to simplify the code.

The error return is moved closer to the function call to make it easier
to follow the logic. And a few blank lines are added for readability.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/aspeed_adc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 998e8bcc06e1..090416c0d622 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -108,7 +108,6 @@ struct adc_gain {
 struct aspeed_adc_data {
 	struct device		*dev;
 	const struct aspeed_adc_model_data *model_data;
-	struct regulator	*regulator;
 	void __iomem		*base;
 	spinlock_t		clk_lock;
 	struct clk_hw		*fixed_div_clk;
@@ -404,13 +403,6 @@ static void aspeed_adc_power_down(void *data)
 	       priv_data->base + ASPEED_REG_ENGINE_CONTROL);
 }
 
-static void aspeed_adc_reg_disable(void *data)
-{
-	struct regulator *reg = data;
-
-	regulator_disable(reg);
-}
-
 static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
@@ -423,18 +415,14 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
-	data->regulator = devm_regulator_get_optional(data->dev, "vref");
-	if (!IS_ERR(data->regulator)) {
-		ret = regulator_enable(data->regulator);
-		if (ret)
-			return ret;
-		ret = devm_add_action_or_reset(
-			data->dev, aspeed_adc_reg_disable, data->regulator);
-		if (ret)
-			return ret;
-		data->vref_mv = regulator_get_voltage(data->regulator);
-		/* Conversion from uV to mV */
-		data->vref_mv /= 1000;
+
+	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	if (ret != -ENODEV) {
+		data->vref_mv = ret / 1000;
+
 		if ((data->vref_mv >= 1550) && (data->vref_mv <= 2700))
 			writel(adc_engine_control_reg_val |
 				FIELD_PREP(
@@ -453,8 +441,6 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 			return -EOPNOTSUPP;
 		}
 	} else {
-		if (PTR_ERR(data->regulator) != -ENODEV)
-			return PTR_ERR(data->regulator);
 		data->vref_mv = 2500000;
 		of_property_read_u32(data->dev->of_node,
 				     "aspeed,int-vref-microvolt",

-- 
2.45.2



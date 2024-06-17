Return-Path: <linux-kernel+bounces-217652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94090B2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361C71C22FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2981CF3EB;
	Mon, 17 Jun 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WpW6Rt08"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600591D0F4B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632269; cv=none; b=lTmKs39VI/PZnHCTq0Qb3HbemPNidzUfm9f0eqEfO6YOh2XpX8ndu8Sli0DI/l25j7DHVJbcHx/jZSuKHqCRNeG/1CpjmChkkxUxkmw1YYUtxzVOLj5MoB6Qr4dvG2emPjsz44Qp5+Qdmn8rKs46U+zIJbQQghhF9bdm27qZaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632269; c=relaxed/simple;
	bh=Sz6h2pKfKvBPze6AioYNagC/2euAAaKQFjYWGhnXEKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsLpJfe/whHqN6fG5AB3LCb7X2sLjoSUp3IbIUIk8WSRrEvFe81EpBeO36DBvQ6dFBnsCUQFEsy55VjKJ/OQlgNSQ7E9cGT+QovmUIsBdlFIcblROgszN2O19FrT5CEIbuAcjLCuTL/w5HAwi5YHIOn0Xci31QfSL3VVg1YOsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WpW6Rt08; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-795ca45c54cso246635585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632266; x=1719237066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79Hx9GfOVVYusy8xA5eoh/JX07K+FfT35u2XbTC3DMc=;
        b=WpW6Rt08gBZ1cv6fO1UfXJJIR/CkzG+/UhFtChA5QJKjry1TKBnZEs4SL0RvI96rqx
         WmhgHrHed906+tEQVCpa8hzRORssaVkql6mELNutrKQonhcKXxj315g/BhWpwTTz8/NX
         KGIH6lDntIdwTlabIIHp24evgGc0UAo5s1yua2b1iVGuJvCRf3qGZUeZ1dOqhZ2+dufC
         +EBPY6ZyHdGJ3f++LD+uhsYyHS/4EBqhLKfX6PiBEVMWL4LENqcDGPJG7F2bBfzoTXBY
         TqbvcE9pEimn8QiDmjOdPoztaCtgQoLMuZ/j+/D292b956H5RjfyG3hsbNoc8HSm4fwI
         +IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632266; x=1719237066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79Hx9GfOVVYusy8xA5eoh/JX07K+FfT35u2XbTC3DMc=;
        b=Kss9gZIGTsvErNn+LoOdqPYbgrpgq5d5dnzO55l9HLvKzqma43hoiGt5X6ry6hdAMy
         1/t2WlIpWydK1vw/nreQn6bLsnXezqGOWkKjVzR8Hsb0Mtgjug6vt+jpgMplANaUVeBG
         sJE0PIfERCCkA0iGPN/X5ymj+ood40a6bDNpy9tEa3OKdDX1GOfnuFhYGq++GfY3fOV7
         02jFVIrXl8gWXC1X4QlMPoPVaEwVdoFMIoVxd0Vdr3a3TwjrfsE/t4DcSkzdcpxU/AUA
         NHRmU1QgmqNBei0m6PrdULutNv8Wa2zguYwrlBYAtlawkV/rHW2oFvajQY1M6ViLP3QG
         EBgg==
X-Forwarded-Encrypted: i=1; AJvYcCXVUhZRdyccnhVBIztgeJk6Wzs0YP0eXhVDRP7thsXmK88/NimWbqQ2hdYp5gvQjiIqPC6sLJZ8rtzBufYxkOEydviVUo2UvyqJ6hlT
X-Gm-Message-State: AOJu0YyC4Q0fa3qTh6wydSZsKKR6ctSbhqgoqpHtYatWFRSDMKRWG0e7
	wW3rg/arqJ24sFJ8/FUtlh1Qpt7iRI9eGU/GBYPxTIUOqwM0t/ad/FfV7gCogQ0=
X-Google-Smtp-Source: AGHT+IEx2KbRAk7Gdof/baHhrw8Y3qRBi2Hyio6LTg74NUhbwR1HRET1Zcy3yDqPrTQiSKqEfswRkA==
X-Received: by 2002:a05:620a:1a86:b0:795:5d6f:8bbd with SMTP id af79cd13be357-798d26a4644mr1303274985a.73.1718632266285;
        Mon, 17 Jun 2024 06:51:06 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:51:06 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:18 -0400
Subject: [PATCH v3 38/41] iio: proximity: sx9500: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-38-88d1338c4cca@baylibre.com>
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
 drivers/iio/proximity/sx9500.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 550e7d3cd5ee..49f4ccd8a5c4 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -209,7 +209,7 @@ static int sx9500_inc_users(struct sx9500_data *data, int *counter,
 		/* Bit is already active, nothing to do. */
 		return 0;
 
-	return regmap_update_bits(data->regmap, reg, bitmask, bitmask);
+	return regmap_set_bits(data->regmap, reg, bitmask);
 }
 
 static int sx9500_dec_users(struct sx9500_data *data, int *counter,
@@ -220,7 +220,7 @@ static int sx9500_dec_users(struct sx9500_data *data, int *counter,
 		/* There are more users, do not deactivate. */
 		return 0;
 
-	return regmap_update_bits(data->regmap, reg, bitmask, 0);
+	return regmap_clear_bits(data->regmap, reg, bitmask);
 }
 
 static int sx9500_inc_chan_users(struct sx9500_data *data, int chan)
@@ -795,8 +795,8 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
 	int i, ret;
 	unsigned int val;
 
-	ret = regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
-				 SX9500_CHAN_MASK, SX9500_CHAN_MASK);
+	ret = regmap_set_bits(data->regmap, SX9500_REG_PROX_CTRL0,
+			      SX9500_CHAN_MASK);
 	if (ret < 0)
 		return ret;
 
@@ -815,8 +815,8 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
 	}
 
 out:
-	regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
-			   SX9500_CHAN_MASK, 0);
+	regmap_clear_bits(data->regmap, SX9500_REG_PROX_CTRL0,
+			  SX9500_CHAN_MASK);
 	return ret;
 }
 

-- 
2.45.2



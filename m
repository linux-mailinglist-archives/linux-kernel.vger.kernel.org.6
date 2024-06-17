Return-Path: <linux-kernel+bounces-217647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4C90B296
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AEA1C23834
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1C1CF3F7;
	Mon, 17 Jun 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t50Pv9IM"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9B1CF3C0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632261; cv=none; b=QknBlVhsKmeaqsdIxCHNMIYDR2ZKUMlFH9mfXaB6/rNnp6o2dSltX0qp4tP4hUXCWb3CVZ2WQEK3w8SFGkSpKVI8US3cI/7PZXvaHGCzil2/QWcYD/2W7dXJxC5z8IQbJuj67FCdw8P2iHPoDVuI7NscrLcHCZ/b4xC60NDI+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632261; c=relaxed/simple;
	bh=iu06Agy4gwP3mD/XsHj6uJ5NOzKIr+fvZxk9qZQspyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhahO4WB3Dd4kyh3I//0Bs+kTsabuR6TCooeabXQL8tUamchRC4qITZfSL3ycG32tCotOCLE/I5WYwZhaUwdPo/CIUidLE93aB596/OqJkAFMokpchv9Bfk+qPIARvQ8/iWQAhIJYhi93wMFgrzBviYvsJeuVehQIQqalsIELzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t50Pv9IM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-797a8cfc4ecso274090485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632258; x=1719237058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bd9TIH+WbKUd6xwGH770DEQhZI10Wa7zRAAyumCALaY=;
        b=t50Pv9IMa/aFlQrmOq7eBIfG0FMGJenpAycrBTNFT5mEH+XnA0k/tEo0pmmvt5OcPP
         7I5h/1IlUFEVU7hUWIZQRVqftajSDMgBrDoA8ZnhbkaaNPvyXw6Q2Ne3uOt/g4+VKSxU
         ACnLPu7RESrVGIC1wDchabs8AOr6QFmavHEgP8yw1830jwZ94yAGIi5LgB1zsEJo9Hnh
         k6Bd4PaaKxVvF5HDiD3XAZ3x661wzMSV0gpSTV7QjCSDtwCepJCPmK+eEM5xis8+WZO/
         cYx1c8ZmBNaiaGyN83y+LtKrfoNVLJdl2yTjJ6AZuEUnm+GW60AN9/R0PUS2di8qhxPl
         n2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632258; x=1719237058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bd9TIH+WbKUd6xwGH770DEQhZI10Wa7zRAAyumCALaY=;
        b=hPJ1hWuDMYH4gUL2SKybchKKu4nd4Q7NYf3lJGbkX9iNaFWBBYdpTN0FXiyfXISbzE
         OxR8TPzv8V3kl/lEzsc/N1BAocf98TtG+pLyoUer1NiIEcY09qYSobUgodsMWu3R+ep0
         GzqoL+3LKFyaTMnUM/pvJWXfFoo55gfoOfBwtd8xXHwHoD1K1ACOUarCQPMmGajFrGJO
         AUNkuaE7quZhoYLYi/WwuSCccv22J2OBX13yJH3G/mXte3h0FxeRgETxyDchNTv1vh9O
         vZIUQu46qdsqG0Ny0E75TgHyf9a5+y5b5XGbebGRfuNWaOCbs7kh+sHy0AsgZzcMU/Qb
         DV9w==
X-Forwarded-Encrypted: i=1; AJvYcCWomSfGeno+ls1I+asGGxJbqGSnR7up0rC7V6VsT+PGngnd9gxQDAOIvHx49hFByw9JbITNpHb1O9OM2B7r/QxeLCEPUB/H8C/4jEyv
X-Gm-Message-State: AOJu0YzT1lnYOPESbGao0Dc75lQtlmz2Nk/nJsbBw4JBvixeSamPlIEM
	rYj1FIde8CSOE4m8aMRIq4Ex53TPtQY7MTF4ZZNaNmSm1HEEW3NmWfOt9x9lGNk=
X-Google-Smtp-Source: AGHT+IHIgplKyy0pftg/5a2SG9pITo7fxr5SdNNjpCXiI/wTi4jbCSV+DPabl4pWpKgzNJgkUownfQ==
X-Received: by 2002:a05:620a:2684:b0:797:8ee3:9f01 with SMTP id af79cd13be357-798d2437ce1mr1017310785a.34.1718632257705;
        Mon, 17 Jun 2024 06:50:57 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:57 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:14 -0400
Subject: [PATCH v3 34/41] iio: magnetometer: mmc35240: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-34-88d1338c4cca@baylibre.com>
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

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/magnetometer/mmc35240.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 6b9f4b056191..ec35e9543a96 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -186,9 +186,8 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
 	 * Recharge the capacitor at VCAP pin, requested to be issued
 	 * before a SET/RESET command.
 	 */
-	ret = regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
-				 MMC35240_CTRL0_REFILL_BIT,
-				 MMC35240_CTRL0_REFILL_BIT);
+	ret = regmap_set_bits(data->regmap, MMC35240_REG_CTRL0,
+			      MMC35240_CTRL0_REFILL_BIT);
 	if (ret < 0)
 		return ret;
 	usleep_range(MMC35240_WAIT_CHARGE_PUMP, MMC35240_WAIT_CHARGE_PUMP + 1);
@@ -198,8 +197,7 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
 	else
 		coil_bit = MMC35240_CTRL0_RESET_BIT;
 
-	return regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
-				  coil_bit, coil_bit);
+	return regmap_set_bits(data->regmap, MMC35240_REG_CTRL0, coil_bit);
 
 }
 

-- 
2.45.2



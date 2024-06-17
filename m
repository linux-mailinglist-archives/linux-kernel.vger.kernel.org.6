Return-Path: <linux-kernel+bounces-217643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168F90B3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F89B31EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFE1CE0B0;
	Mon, 17 Jun 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sU4Zjmj9"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E71CE082
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632251; cv=none; b=DS8BpyZj0HeZPlXp0LXf2Q6W6eT5XqYW56SEnvZHxXHWmMZ9mw2YifpK48pRKEB4w/jfvMF4JvjMmc6ifXBVHJJwqY+v4SZP/feJ0xMgzojh7aiH6OJ7OwgB5PRcjk0OaFhhx5ZaU27jEnlzVh1Wv1M4XIwTr6Ni798eXB/ReNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632251; c=relaxed/simple;
	bh=smoODOKJzYbzSY7+vwmdsueBeuYxskf+h32ZLD9bbUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0tBSNZh1Jg5dULJY6DAU/KcQPo9crGUzRdorYQt922Q4pqLiBGwYGE+lZNm45Ic7BV8z3feJV+xSWkRQWF6qBexTOvKRIN+y/IDe1bACtyC/rMFMYGdQL2w87y+T7h37848kXYXXPV3AQbKf8m0puMlFcAYm3q+SEw/bcp6pJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sU4Zjmj9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79776e3e351so312739085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632249; x=1719237049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNtak+2SP0bqKcAwBmLBKZAak83BgIl2xc15imfy8nI=;
        b=sU4Zjmj9vjCxh9SOhS2GMNnOHbAwUV2UebpaJyHzLtvvNhcxQWtorpOPUgtx3yBn2x
         CTSUeAvZi8xCa8wJLQUN9QMLhE9svrEwjWqoNeSq8YDRId+Vuy6dHZ5nplJ3tb9eyPV9
         GZFXGd84gd0fpEbgyyTwk9o2Db8OsmLt7PK33Byd5O8SUAN6lc1D1sU1kzdZn+9gYHYV
         V0043GLJH+r0kf28SaI8pTBf2JPdeF3+6xhkmMMsaJZMyA8LutKARq2O7KSsCIxLrZwN
         Tln7PEI5RL7Kk39rt5Y05mLKeUU65nX2DRrzB9uNGw+uL1iFlxKtrdiXMTI0vC4AKrfL
         RTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632249; x=1719237049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNtak+2SP0bqKcAwBmLBKZAak83BgIl2xc15imfy8nI=;
        b=h3ikcSGCJxlXBttM9JyDeJiRf66g3iSuU/CEb3/oKRo7ky7KIiZGoaMKv1nZ5ku7LI
         0ooODXl/FtPqO7HIl+CSYP2y6ucwnRTsSgOFEoIKaFnIiQM4/aSCawxTxcTJXTNrR6gu
         r0+PULcQ4JRh3Dmv+5ibImMBgWZAyUH+vKFJiQ/AEIKD1GastwNLo5wLBhFrrFlMYws/
         GyFrPErKOsG1t/NszlONXEVgkzSfAL0JwnY+LdE5+1DdxDKrTM+4mrHmV+ChUhrPO2Dl
         DiDn8LGc/Bkw9C9H7r2PKIyY5APSJ22nxrw9eIeBqgywtXQ54QXLL/tiN8WxZRAJ4Yvo
         zwnA==
X-Forwarded-Encrypted: i=1; AJvYcCXDTou1Xbz/lZOVcmJtdfUmk/XRnKYvfTHUOf5gYGZuHUKfNNo+PJ8xag+25SSSX9OxLz4S7sI9tMOg3aLm5AwYR9Q7WYphGl7ZKXeB
X-Gm-Message-State: AOJu0YxzyxS0mUqNcvkiFPikWZMKTIUspNb8xfUBcPi9iMC68b5TxsFn
	j0ohVwccTgmqL1aaxDCFWdJTp0aVoW0RVtripDBpp/VkL6hCUtBgVzpwMAgdPkI=
X-Google-Smtp-Source: AGHT+IEff9Dln+tnuVCEmbJAGpzplXAkkgqJD6yK1MHCx8a+d/cYhrzz8V7ALZ8zTjCZj6a+ffKadQ==
X-Received: by 2002:a05:620a:4088:b0:797:d55a:5166 with SMTP id af79cd13be357-798d258dd41mr1141019385a.58.1718632249174;
        Mon, 17 Jun 2024 06:50:49 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:48 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:10 -0400
Subject: [PATCH v3 30/41] iio: light: isl29018: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-30-88d1338c4cca@baylibre.com>
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

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/light/isl29018.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 43484c18b101..8dfc750e68c0 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -550,9 +550,9 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 			return -ENODEV;
 
 		/* Clear brownout bit */
-		status = regmap_update_bits(chip->regmap,
-					    ISL29035_REG_DEVICE_ID,
-					    ISL29035_BOUT_MASK, 0);
+		status = regmap_clear_bits(chip->regmap,
+					   ISL29035_REG_DEVICE_ID,
+					   ISL29035_BOUT_MASK);
 		if (status < 0)
 			return status;
 	}

-- 
2.45.2



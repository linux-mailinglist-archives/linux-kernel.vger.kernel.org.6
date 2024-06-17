Return-Path: <linux-kernel+bounces-217637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF590B278
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906EB1C23890
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1224D1D47BC;
	Mon, 17 Jun 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EKnFeyad"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3391D3638
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632240; cv=none; b=bYhGJIPNZn5RANFQFirayitGEsDz8HAc4xYtEEYMQxFcGfHxAWft6zAhf7HC8PYye4v2sitTLAlRO4USn1LucZmsBnZCx4tYAqkTC6+LvgzXqRpiYp8qNbndX93C92AEmW6r2wcnpknfZI77QSsAVbEBzanCL8mXiHp1evZDH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632240; c=relaxed/simple;
	bh=sY6AVptqGy7qaDiPpO+WIwajsbuS/yJwZlwaJuIwYwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jhrq3XGKHbd/r5mvH3g994Hz4agaCNPhwNpmKY//eUw+P9ZdnUXs31G+NfWIchsYYMAxcVNO1Fl1mA0UOvjo3C+pcmpnv+BeAD/V8ViBy44RUPIlpi/p7qA2qBo31H9bJ+9Xy3r673M7lu7HGT5hygxONi53cMMPRYFFC3d6aTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EKnFeyad; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80d68861bf9so1534838241.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632236; x=1719237036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqMe4af98NHJiZdRmZKfGjAtSzwLMs3Usdpoxv76E0s=;
        b=EKnFeyadKuQW/Acs06imb7/gGql2ZAbn5KO3OATd0xmFwOjYkb+CouVkSwvxJJAHah
         7jJ/3nPzDgIx7nsEPa1o4xNhRV9DcILaI/ck3e2jf+RcKE8ou10qgq1n+vOHSsPl3HCn
         CarW0BtL7PnL8jUPgqTgSO9mzzMwcl75X/d9OPvnXXWa11qXb10YBvirTzN4x3lhIJli
         MIvkB3bw/AVFJce3UTrWfLEv3Ro+gnQ7GKM1b8aWPbIgTDcRGtS6+utYPqezUZqGtvYt
         aw9TmRh8dU1OH751SSQry5PYB51UPu7d5bDZu1PL/vmzwkYD7FdUmiuYuzvA5aKanGW7
         hHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632236; x=1719237036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqMe4af98NHJiZdRmZKfGjAtSzwLMs3Usdpoxv76E0s=;
        b=VoywvVMkeLw6WDkyTVznubufv+MkzbQQkL+By8Ci9MeMqvjEeMo+hhixXwlDjDeXvz
         PESjUX0Z4G4P+ZFFCRWAemLxxXxhCgBQY7BeEKzMkwP6y9aVDPSLBMyIH5eROgnGVw3S
         6k7Na8kTEfe8hTqzxAKmTwqJp9gE2e3DeGosqisgHYFE0jM6GAsrgaS8EVAgKwLYCztE
         Vw+NFP+PE/DeFHAHSEwRkK3uJcFtABzB9oeQmXzqGjmqTPuZtAx/xkSYTaGExG9XtszO
         w5qMxUYMM4C9xEGrmSwmW+thQcPIDL2f7dn0bbxEaiJLBVz6bwetH3vo7yVuPPcf9wUy
         R93A==
X-Forwarded-Encrypted: i=1; AJvYcCU6vsY5UgGuraxN63LsIaVsK7ZqD1UhCBQN3kkMre5/xW2l+M/sLSGiQdGnhrGYjjXLLefiHOppezhaj1xN2iVcpYVKAUJN2wJZhj4e
X-Gm-Message-State: AOJu0YwCH3bQEFjvCWByN3taHcgO+t/AiTp17sEhksterv8E91qWJ03v
	0Vyf4rpLz2P1uiq++gyBmL8wcbhxXlpHHdFq86ppnKCFwYrB73WCSV2FspGnSVM=
X-Google-Smtp-Source: AGHT+IFihHa6bMcNzaeLIOOLDw8PfmzIsl9aK4RVvUYriLx2jOAq5E+Axp1aames8cM1+wIsIKtc2A==
X-Received: by 2002:a05:6102:3b96:b0:48c:19d7:eb83 with SMTP id ada2fe7eead31-48dae3f30ebmr8867679137.34.1718632236471;
        Mon, 17 Jun 2024 06:50:36 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:36 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:04 -0400
Subject: [PATCH v3 24/41] iio: health: afe4404: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-24-88d1338c4cca@baylibre.com>
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
 drivers/iio/health/afe4404.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 7768b07ef7a6..51f4be39d20b 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -430,9 +430,8 @@ static int afe4404_suspend(struct device *dev)
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_update_bits(afe->regmap, AFE440X_CONTROL2,
-				 AFE440X_CONTROL2_PDN_AFE,
-				 AFE440X_CONTROL2_PDN_AFE);
+	ret = regmap_set_bits(afe->regmap, AFE440X_CONTROL2,
+			      AFE440X_CONTROL2_PDN_AFE);
 	if (ret)
 		return ret;
 
@@ -457,8 +456,8 @@ static int afe4404_resume(struct device *dev)
 		return ret;
 	}
 
-	ret = regmap_update_bits(afe->regmap, AFE440X_CONTROL2,
-				 AFE440X_CONTROL2_PDN_AFE, 0);
+	ret = regmap_clear_bits(afe->regmap, AFE440X_CONTROL2,
+				AFE440X_CONTROL2_PDN_AFE);
 	if (ret)
 		return ret;
 

-- 
2.45.2



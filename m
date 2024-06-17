Return-Path: <linux-kernel+bounces-217650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D55A90B2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33106280CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602001D0537;
	Mon, 17 Jun 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NzGz//51"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C171CF3EB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632264; cv=none; b=iRnVMaLZQotoCgzknQVCN4WtO6TtmVGeXslcgJ3gnoCrZpDbCGiIk4e+f9PYWxRX7zto4dCCI6anI6yb/7Ohf46PB7VNr+SHq7bvjnUGxbWvLkIpxpP0CTGTQfRStjT5JyZCzDiUIWEkcZcqVBHwUwAUllavT+wf9T6dCADCJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632264; c=relaxed/simple;
	bh=vM1JkJ0x/TYqTHqzgAuZC94s5MJ55op+dR9vjEILN4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lf9n/5t0wKv3rhHUKv49Ce53p+ub9L6h5uZleIhw58v6yGOeOk6UCH6TcZLDDExveyhZiCrT0yqFJFu9zouzHxk1mXkiBHntLLZLdNkYAVS/QlDhkkKFE0KEFRkITe0mlfVlZ7qtnYFSQfmyQ4URWHqwBQOexphQW4aAtU99v7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NzGz//51; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f628e71so2279957fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632262; x=1719237062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Tk27b9u+l0CzDHHIWu0wOizrcdk6I7Pf7l1UE2LHs0=;
        b=NzGz//513ml3WiJcUgwxZZ1zBQSCKot5xLpCZW3EcxPHX+Vgh8tM8K1boRvG7S5zMW
         iassgf1a8UeDo0F367yz89jb8tUdvddiZjbk/Acd0+mdwc+e3TUTlnrox7C7TqYiZ8ox
         4eDxUkj7mWznkezvHf8jSWMbZH9mKoZtUBuXgbwsQboOageunQ4E8ZcHLPi85lWs2FMp
         2cAzFQgGElFDB4NRoqhtv/m7AKaMmpYSAhREyCZCj9ujtxRsjIMDYY5u9VsHPbEoCkki
         W8sXTgvW1BaBoBqORtSBBvtqBrnxWlg4+31VySLw3sujIZiTymviv3tl2WsdDruHwtfS
         q8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632262; x=1719237062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Tk27b9u+l0CzDHHIWu0wOizrcdk6I7Pf7l1UE2LHs0=;
        b=km+VILCDkHd/CMpiU77FTHJygXUNq0A7ybGFVU+bdwBsl6DGF4HyKEnd2qw7RouwrO
         sa4ISZQGtRdQ02RdKnVCdo8I/K9MJypILU11eQVz+kP+U9y72S2C9kSnaibGFU5m8ZPg
         vEWYn7wH6rnNF77kADQQav0jzSeVVznSdcr27wTCiDzvPw325AThZm2an52P+HjizX0m
         svxF+xg566LmUcW3K5Gnd+Jb7s42fE5KrCSqYiABHXKGzUllQ4XE3MOfLqEKkTuyHB3y
         b1IyxZmOxGotNFX33dVkFAVjXiEpY8/uUNslcBbznSfGGR7QmB23JZLQGxJC5cvC/hRK
         qd9A==
X-Forwarded-Encrypted: i=1; AJvYcCW7SSdGxrywVnjQQ15zq6jTXYzJcUT+mpRRVncdVhaFLfMO1xuvYCBlaOHyn8n4GAyXEI2r9GcvSlpAUy/eXubM5DclvVFFE1t6rUr8
X-Gm-Message-State: AOJu0YwEg2QYumQcZdSNHZELwn2FEuX8BlszfKqAlx4foBy0qBnAF02y
	J2ApjAU21A4mwhwsYr+RNhrpl1pMDM9JtXVuPb6K1gaEUABO387HtZYHVdzrrk8=
X-Google-Smtp-Source: AGHT+IFPuCaLYR0OC2CKxxs6bVWzV0l0Y4GqKpcVsLYm2jLp2HnQirR7TaXtLxRY2U4vfGwAEVGQmA==
X-Received: by 2002:a05:6870:89a4:b0:254:7471:56b7 with SMTP id 586e51a60fabf-25842853b1bmr11345694fac.11.1718632262042;
        Mon, 17 Jun 2024 06:51:02 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:51:01 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:16 -0400
Subject: [PATCH v3 36/41] iio: proximity: sx9324: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-36-88d1338c4cca@baylibre.com>
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
 drivers/iio/proximity/sx9324.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index aa0d14a49d5e..629f83c37d59 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -835,9 +835,8 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 	int ret;
 
 	/* run the compensation phase on all channels */
-	ret = regmap_update_bits(data->regmap, SX9324_REG_STAT2,
-				 SX9324_REG_STAT2_COMPSTAT_MASK,
-				 SX9324_REG_STAT2_COMPSTAT_MASK);
+	ret = regmap_set_bits(data->regmap, SX9324_REG_STAT2,
+			      SX9324_REG_STAT2_COMPSTAT_MASK);
 	if (ret)
 		return ret;
 

-- 
2.45.2



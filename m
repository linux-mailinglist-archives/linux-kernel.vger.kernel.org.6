Return-Path: <linux-kernel+bounces-217612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC75A90B222
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1711C2317C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BEE1BB690;
	Mon, 17 Jun 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dFVpjkGZ"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CC1BA873
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632193; cv=none; b=pL9vVggl2nlkSv7+ke0TfCWbSr/eWqF43K1iQh2h0553YCkNlf5r5ZXlVbHzXmnTNlq9rSj8t/+tzExt473KU+zrwAb0nSpQcT6rLn7rpCoRggYZUASXB+J8vUN7ZYB8Tpsxo4CNHr6VRHmoD2XLrJBCjA8ysqFdcgkvCY4xqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632193; c=relaxed/simple;
	bh=yZg3W0CF/EzgkZiaio4uCiv0EYa6DTKX0nMHxwiSYDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtWquTibKAQg+Crd309bZROpFw5XVLMsDmXg8A0G7+TNHvswMSTMdptK1be6sKUBONKSolc3cHxvQKvJ7isAX92+JNibXob/OAWfBTOLRMdbfVkpqtjP9e5DDSvWx6freo340l73Gf7wZbeqcsg++tE45/vM02qJCOkPQXZzwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dFVpjkGZ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48c37941349so1596057137.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632189; x=1719236989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zs4CGtswXRcL4r5zLR2D5+LAoG+l8N82wbiM+7ownU=;
        b=dFVpjkGZ59QkMVvszQdpXP3L0dKycrfrtbgMEmZq2I5lCy9VC6M9lntD0iiOKlk/GY
         pf9WvnJ/YmKsjaxxJFoGyFhP5oAtaP4eiDMoV0MmMrx7S+Ebc2Fhiez75jlj7Bx6gMPB
         UV+j16pLmcq+oBQgTWVoX3XUi/VIJRn3SmsTxJkijN0Ad6pvtW1f1dQMBbcx5HZneZgy
         drvL7NjUG1lO3CTRRXHJ8pvxpsAYmvVgLgnmACoDsdIcgb0jp5sGz1bPAIY8aYvvxq7t
         ChqnOWqMJBsMpVz3oIXf2d3T00jwRsOX1dXIKuDnQUlZTwkjKD+mqrGhAiWn2S0Igv52
         SUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632189; x=1719236989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Zs4CGtswXRcL4r5zLR2D5+LAoG+l8N82wbiM+7ownU=;
        b=auhWsq2h1fELo9IUfCCRXE0ZjXFFNV9ntO7AFpqWJ4x1T5+B+2RpImMJuD6J0Nqhfc
         3iZlUYQns3Mffpj3uWPKnt4AIjVhNkMnuNPsgI7oa/dLEdVH3hCoiYsj02SZYX6SkWv8
         cGg+Bxknp2RvpY56165+XuQ6GcFPtrwJo0jXbUwzEwTwNPF3RhsImJe6QgJxddMLGhH7
         Ei4lTRrDB+Euibw7B/c2/3GzuV432XVCBzVAaeL4CSlKrF92FaRsKqoozTlJ/TCnSb83
         E4+i7jXhJ3ulz7K3QuttCz+IRSyyzTycNtPHDKptGSuYb9vd2wxtXY4sI72c8hEffW9W
         kmIg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/v6XTdHRAuoECUhKilsIfm710BPZolj+S7H2tj34lK0l+cEb6ioQs8w5t2+CXmH6ij/m/0X0dHrkYDFnzDNeSyaO21S3WYUKsmKq
X-Gm-Message-State: AOJu0YwI/kn1wbEIdGIXCnrtP8Cmm/UVZoSDkTVVTkln8xKicpHACtxr
	5RgqmI80r4XzTx3qxEcuuCrcFMXZzogspiKs5yO/ZX+vSH/RsdRkJJAFXGE/HHc=
X-Google-Smtp-Source: AGHT+IEFmgHtaGyOVxmPD/zpG+S8mAUnggR0FqGzztaCLAyq4bVNR5GtCNAnJm1CQv7c1xou1ffjIg==
X-Received: by 2002:a67:b902:0:b0:48d:7702:99e2 with SMTP id ada2fe7eead31-48dae3e00c7mr8793212137.31.1718632188950;
        Mon, 17 Jun 2024 06:49:48 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:48 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:42 -0400
Subject: [PATCH v3 02/41] iio: accel: kxsd9: Make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-2-88d1338c4cca@baylibre.com>
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
 drivers/iio/accel/kxsd9.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index ba99649fe195..03ce032e06ff 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -370,10 +370,8 @@ static int kxsd9_power_down(struct kxsd9_state *st)
 	 * make sure we conserve power even if there are others users on the
 	 * regulators.
 	 */
-	ret = regmap_update_bits(st->map,
-				 KXSD9_REG_CTRL_B,
-				 KXSD9_CTRL_B_ENABLE,
-				 0);
+	ret = regmap_clear_bits(st->map, KXSD9_REG_CTRL_B,
+				KXSD9_CTRL_B_ENABLE);
 	if (ret)
 		return ret;
 

-- 
2.45.2



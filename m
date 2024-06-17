Return-Path: <linux-kernel+bounces-217651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E390B4AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22967B36BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396D1D0F50;
	Mon, 17 Jun 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dy12cCfk"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFD1D0531
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632266; cv=none; b=k7YaKfXhox5MOjli1AKaCacvJO1cEr/pxgz8ftY2pwV6oszDdAQX5/yg+nEtCaFhNH5GpGXnsFto4rjDFAo+HAosWXTp0cglkUOncaRdv+2F30B90Vo4OYAnOF3waeUwhZQYSzk36wg7f1hNB+9U1s9MUGYX4/AS/wFL35hOreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632266; c=relaxed/simple;
	bh=z9RyjZU19LnLgrucgjYl1CZ1GaGyJEE70HiZ5+JD4QI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEy+EBLp4KTPFSSIGBXykRkqTlviF/RtNCdkKsE5t6iKAOLsLnB9xjX53V7yosZywCMSJDee+3D05MFdpUIKw78AhFDUMI1qElKXhnUtrb8rmXuEquOlbvi5k6Q5b/a6iJGV9zcjEAJGnKXdksiE0QHsdzsFs8RDaWQ+/FuVhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dy12cCfk; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-24c9f630e51so2184995fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632264; x=1719237064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWd9RIrs8wL0I/TcIsG/QAgGB9T5+fxOkhv6E/dAdZI=;
        b=Dy12cCfkpW3OL89p6eIQO5WH1yQEQIxtUbBpYOr0DMQTPPo2oXcQGurmwSGRjj7iko
         Qt8uKZNgcRkyqr/auHF/DgUXYo49cEyrkZj991EgIMWdQYkEIvdw2pBnTyh2TQdJDEC8
         DGKl5W/D9hUO67mvJQs/MI9R1r8m0p81LgeV331z10yvMT0/snQcTMzizP37itnr4egl
         VsZsgIJGopyWyJD1i1YVDAo+9VZzywCHDHqOpdymBoZv8OqQB1lRWz0eQ2g2lCFUWW7K
         Of9OC0bdaI4zv3KSiTwDdqXos9QlxGIxqhFP3ygpVP6ZK/cG7i3BammmgPAQGZsHVexq
         Wsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632264; x=1719237064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWd9RIrs8wL0I/TcIsG/QAgGB9T5+fxOkhv6E/dAdZI=;
        b=NuVzESXVB1oEiW+LYOo7ye4rwVS6a9b2qBS2MFmzLLS4mSKF4GT7mrusY7trds0uSL
         gspSzw6uXr/BLzhr+cSg/MqXdK1ltfUny2FgsazLtcDZItZzhn7Jmh6cd8aeOi8qsRpH
         ag1MFT/A171AMhzx0FDSHICD72BcIO0p06oLY20RksDqpr7gdR4eaueb14Pe92F7pnp0
         oNA/YzURkeptL6SCJhuBEiXQteV8h7R0rUtX4BUPgM3SPcl4HmV/s9GE+Onbg/IljePd
         PNZYuKl3jff6JiuRJH2MhyS4JEi9AHRKk9DWVYlK19w2fgpmUM26CugDmU/RF/qU1zmO
         LoKg==
X-Forwarded-Encrypted: i=1; AJvYcCUBGfUKdbh9ub/zLq5zFWnnIs0GHEWgHQ1KkIG2y4ta9h//A1ajr+V/+1/FhYLJIbhqZDzWT/4EE7hIJTw3wP9S3sa/itaKI4FK7N3P
X-Gm-Message-State: AOJu0Yx/Vsx8WcY7s5UeRziF3n+QNzB8yNpj75l2iY3iVKbukrLxrlms
	7LUJ0nBPrkcf7CGBUC9NTDu16W6wRyYX1zg2xWmI2JXNW9t2tNcQwB9xkWaWJks=
X-Google-Smtp-Source: AGHT+IH8uTWV+X4VQg+Hvv7+Ss0V04PvnK1VdmrqhUaV/+VFOL4UdwUlA2xHiJMwUxJKiw4xuPCudA==
X-Received: by 2002:a05:6870:15d5:b0:254:8bb9:d0bf with SMTP id 586e51a60fabf-2584298505cmr11157462fac.32.1718632264185;
        Mon, 17 Jun 2024 06:51:04 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:51:03 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:17 -0400
Subject: [PATCH v3 37/41] iio: proximity: sx9360: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-37-88d1338c4cca@baylibre.com>
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
 drivers/iio/proximity/sx9360.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 75a1c29f14eb..2b90bf45a201 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -672,9 +672,8 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
 	int ret;
 
 	/* run the compensation phase on all channels */
-	ret = regmap_update_bits(data->regmap, SX9360_REG_STAT,
-				 SX9360_REG_STAT_COMPSTAT_MASK,
-				 SX9360_REG_STAT_COMPSTAT_MASK);
+	ret = regmap_set_bits(data->regmap, SX9360_REG_STAT,
+			      SX9360_REG_STAT_COMPSTAT_MASK);
 	if (ret)
 		return ret;
 

-- 
2.45.2



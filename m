Return-Path: <linux-kernel+bounces-217644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E190B28A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB41C21D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04341CE9F1;
	Mon, 17 Jun 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FKZo7ofn"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DB1CE0AE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632254; cv=none; b=oWEVDqPtpQDz5178QMqrmTSCmOUFj9POQr511EhWqHLwiGitdZahww21ASxyCJbEyR+i/l2jjgV1qtCzPl3l9okFLieD/lgPqocFkrAEGS9pgXEvTxjYWOxnelgFOHftTWFzxctnUBE2Oj3kKp+3Zt9IzCggHKQwoYf9aY/kP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632254; c=relaxed/simple;
	bh=ckMo8AE5ydYAYNgqLQ5pfM8APLagaTP89WYb9paKWrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouogf+CCt4vPDlgdx7N7/jtn3cULAccPUW80DtHMmeffSD5rzEnfoA+J3St3LN96Ht7gpEHDUPDbdfgwtQqYgiASfPxuE39f/681dnGBkwoIGo1rDaONhklcafJHEvfbNfvt1YnNH14jOXXvaoN7UnyVePgifRJAk61kTAEOlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FKZo7ofn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-797e2834c4eso366754885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632251; x=1719237051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+ymucZ3m6lrJGr3WTAeCvzidHKg4xOe2grvPyQxJhA=;
        b=FKZo7ofnqZPmtP5B2Ngq0wBVjC1RVdrqQtZtMjghKmILB36EO0+2Y9Pl4NqL40FgMF
         YEQ84S/BrbcHEWHLQF2iyNHU35H4NxeS/xmXxMnyECYXlS8ONTEWcFVTsnz9AcmO7nIY
         lOiFBucF1d5amYlVh8ws1Gp8O3d2Il3sb4P6sTwvRZy5H+IZe9ARP4KKl9J8fKIdOxjc
         /X2B5tN4yOgx1gAwbZydGo1OOW5SCxKBnjOR3sz2j7e4L6dWcmwgwEJjKBSC9+g0bONA
         i/pinsqpdXoSykUO0UULDsmUg8Yeh1o6ONdTo8LRN4hF5bep8MAAkMaTHvE/HkxsOw/U
         SlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632251; x=1719237051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+ymucZ3m6lrJGr3WTAeCvzidHKg4xOe2grvPyQxJhA=;
        b=bljam3vc/hIoXLfbU64M8/4yxez4osK4ol1gUDRa0ntWWhPrz239togsc6wfIv0c0O
         NB5JmBaXORSR6zANxSDqULHwxe6vgfgKuprEi4yB0isrdSe/ILO7CFCK5FBeFl+FZlj1
         HCHlxmFqEVUX8DpGp1nVzLMMJn9whf2Q27g3IVmZTL+/CjZPLFW/FCN6LtE5KZIGVKY/
         KKyYAwroUoi+HgSEcQzoQ0wrm4SmNtpGJqEja1sc+VjV9AzEGBPPwWyEzIxxdOMPr7iu
         V89d6AxKKRC0cSaUb2IMR+HHS9BfrggCw0hm7T8A9WqPxMFarqkovJ4kfWXnIgtwumDN
         dWSA==
X-Forwarded-Encrypted: i=1; AJvYcCX3pCKodAa+lhZNv9Pcms8T5AffagXyEFcpmmXuQpOGWP9Kynh3Ocs8m5kmemRN/slfmfe0F/Yva0vrE2ungyOPtXDuP5OhYWj9x0vA
X-Gm-Message-State: AOJu0Yz+/F/3+rYoEmjOfAQ4MkNHSFNg+gLPlBHb307I+404Cw1+cKqe
	4UYud1QW+k99qqxfb62Ntk2NF6JmLvUYyWq6m0HAc+cwSIIGaETLXVLsQxvIqEE=
X-Google-Smtp-Source: AGHT+IFhD2JefGeiJgsg6Ae7QRIe/BDndSP0Z/WiCRPC91zIn6+wpqBzLsiQzn3/JIP4kN+hagVe4g==
X-Received: by 2002:a05:620a:4056:b0:795:56a1:6c0a with SMTP id af79cd13be357-798d03b78c4mr1852443685a.30.1718632251285;
        Mon, 17 Jun 2024 06:50:51 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:51 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:11 -0400
Subject: [PATCH v3 31/41] iio: light: st_uvis25_core: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-31-88d1338c4cca@baylibre.com>
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
 drivers/iio/light/st_uvis25_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index d4e17079b2f4..fba3997574bb 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -330,8 +330,8 @@ static int st_uvis25_suspend(struct device *dev)
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct st_uvis25_hw *hw = iio_priv(iio_dev);
 
-	return regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
-				  ST_UVIS25_REG_ODR_MASK, 0);
+	return regmap_clear_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
+				 ST_UVIS25_REG_ODR_MASK);
 }
 
 static int st_uvis25_resume(struct device *dev)

-- 
2.45.2



Return-Path: <linux-kernel+bounces-217613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075D90B223
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB171F24A43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1821BB69D;
	Mon, 17 Jun 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kKrpcsOM"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235271BA865
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632193; cv=none; b=Q/wXEgBNAUKMygs5LW7JQMF8AbGMC2NdK44D9p9tkzLXqV8FchckQsqqiR3FYzltxJdhigt3gCSROk2Hcdrei0F8bXMj3EG3Uk1dEDZltwvBtZMy0gYwf8dRDLJStbAAkJCnOeEIPQprS206BjMinvPvt1i2XKlPRx4F2RBwNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632193; c=relaxed/simple;
	bh=xkccHr6wwnlQsKCmzwFyuv2WRICeUsdifxKHZufCCP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enWMN4JRrXP8edObKOmrhkM56w36L2jYba2MnF1MvXeQVNY+yVgvsdr9NqfCSYiP2UYUQ9KYkKsfl+6aeU5vGnsBDE3GMm3+wSGImuDRNEA3aU65pAjIjGH3w9B+HF9os8C5VGlEm4fZGAIbepHb1KFoSPENLDNJ/bWI6p7HFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kKrpcsOM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-797fb0b4832so218398085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632191; x=1719236991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qpLBIScyQiW6pZURHAKIC6sw71J1lEFsgxMlm6mPzw=;
        b=kKrpcsOMe9j81oRPGb213ADgjzEfy+SMjiJA6imAMpLCsrawmr9zZWstDky/62HQYG
         BOoKjwzc8zFUeB69KusvojdW9Ko/nXTA1g3pLV7ZR/thaSuYC8yLKL0JYTfNsbeHiTix
         tFD9xgAqFzAXQT9pD52CvxEKhUY+7kcLzMzcBLuAIYtB1nUbIfOCDWfvDCSId5yFpAXQ
         +Jby3GCPuw1gJe7/InRK/GJSKnlyYENOMZCr6iua4uam1OhQysVjoMppXQLgGUmhoaaA
         OwkuE+rva8YxzJ0F+2ico2s5rBqCkIpki0oUq4mX4ZdJuNAAKj0mx7Acvw/zEtU7Hms7
         Htnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632191; x=1719236991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qpLBIScyQiW6pZURHAKIC6sw71J1lEFsgxMlm6mPzw=;
        b=ghzZ8D2H2DRgBTyjwfw0/HqCSQpzFSGhnoq/m4euafoHNOUdGTMxFuSETlPV9JvSap
         dETDEFp/FOk5t51gkn0rmPtudYXgVwI6n1tVeTbzXAmsv1ex/Q2+IOa4d4qRrHAT65Pq
         HwYgDNP71rhyyjnwkprEXWCQ/XKAq5ofoaDwV7gsY6fhlRs5klnl6ArEet31rupj1x3Z
         OwSDeCNCSiTLlWNY/usLMEDnclq1KvOwVVn1toH+tJQUtAUgx8garwrZQGQ08/fQAtSe
         S69MVMXfpvc8UlWXQZzdnUzeGq0GebCTSroDBqQJ3aFCFRxJR0aJEI7Qw8ckgegE0HcC
         ES8w==
X-Forwarded-Encrypted: i=1; AJvYcCVtidXt0N3OsyFTEk32OFxiXC3XqdkHwO2TRaTTr7aUUzPjs5aeoIMKhyGj+xI7poUYOU79q358FcL8/qoJb0xLnm7G3kGWGn6H6NQJ
X-Gm-Message-State: AOJu0YwFGaq+fG/GU5jW5DlE/ypqyGgA/Zz91qeHsbjii2Kq8n6QDaG8
	VvPaJYzpDK72215bzDBHChldyG+rjORGOocs9+te8BPFdN2xb6RSs7C5+LyByU8=
X-Google-Smtp-Source: AGHT+IECnYQvKUI7WwTgcSFed1zXdKR1H19TPysNu9rY9UY+uM67szMwUskr66DbaCdyM94wmFAuyQ==
X-Received: by 2002:a05:620a:372a:b0:797:b2a9:90a7 with SMTP id af79cd13be357-798d26b9321mr1211989385a.69.1718632191103;
        Mon, 17 Jun 2024 06:49:51 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:50 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:43 -0400
Subject: [PATCH v3 03/41] iio: accel: msa311: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-3-88d1338c4cca@baylibre.com>
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
 drivers/iio/accel/msa311.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index b8ddbfd98f11..4cdbf5424a53 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -1034,10 +1034,10 @@ static int msa311_chip_init(struct msa311_priv *msa311)
 				     "failed to unmap map0/map1 interrupts\n");
 
 	/* Disable all axes by default */
-	err = regmap_update_bits(msa311->regs, MSA311_ODR_REG,
-				 MSA311_GENMASK(F_X_AXIS_DIS) |
-				 MSA311_GENMASK(F_Y_AXIS_DIS) |
-				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
+	err = regmap_clear_bits(msa311->regs, MSA311_ODR_REG,
+				MSA311_GENMASK(F_X_AXIS_DIS) |
+				MSA311_GENMASK(F_Y_AXIS_DIS) |
+				MSA311_GENMASK(F_Z_AXIS_DIS));
 	if (err)
 		return dev_err_probe(dev, err, "can't enable all axes\n");
 

-- 
2.45.2



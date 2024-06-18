Return-Path: <linux-kernel+bounces-219578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29FA90D4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124B728EFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFFF1AC76F;
	Tue, 18 Jun 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MKexz67T"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAF1ABCB7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719364; cv=none; b=DslFlSazrIzhKiIR+hN+xRYDQQ+ybMX0NjoMfIOX2B5nQelyRguxrPgihwBljNhoypV8wupFWQKrxR3JSIwidrSOB2HOgUhvtNDd/uQ2r1FfKwjv537GrEOEEzdfJjByIj0wsR7g6wjzBpXacYa7EsuQR2xajUHLrj9Tn6kWUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719364; c=relaxed/simple;
	bh=PO21rWTwSri6pXqW0QAoF3rRYxBHPQXcTMLtVuYPAPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9Cm3oDiagtEyHZAO4ZG3M6i6TMaWIoi+noDJ4nCPJdjNMgfkFhgwaa6Q1awfYjIKMGt/NwmFb7gGD2+spuyDL2CCfG/9MbX6ZB81AfeJhSOCRqHwTolbrLBNqc83NbLCUdwTNFnAQAkz/xywHS+Eh5sSQ4uKs9a5EYrioqncCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MKexz67T; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-361785bfa71so272755f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719360; x=1719324160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmU+WlwI0In7K1/gMjhndg/uoX9jW0QNIwYtnLhPUbw=;
        b=MKexz67Ty2ztXziEExBdmHVk87zPY7S6ofk/iXtqhacvTTxSsQXt06vuuQGxj5e8oV
         7tsci5JrsG4hIBZPCI2asJwwf2ig6hdHZLHygUF6aMS0plVD4pRKrykHUXmaVYFTzSHA
         seeVsAMu1HeqzH2saOOgk9kof86rqUFFr7y0qPRH9UIw3D9LTciVu4yRxFrMFZhrDEwP
         RFiG3iuvSQCfu8l2VJ6ojXsqHjGQTV8pzXrS+q5FTp2RkXl5AKxDf4eAEklTRFVpfJUV
         IxkcGO/jnwHIjHEiNh3dIceMPIu5XtUKIgtzpmWHezR4a+mpGgy5JaE3FNufGgtdFLPQ
         KOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719360; x=1719324160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmU+WlwI0In7K1/gMjhndg/uoX9jW0QNIwYtnLhPUbw=;
        b=s2QErdt6TxNe+ACw4LEbTq+gcLXoEHsNsAB8GqT9Lc3+oNhErv2I1UndJnzt5wT4Tg
         3290zGgFX/KM1PreGz/oC5aKzO29meDpIex1FztAiw3dhnK7PHBlMvx7vjjg+/aC2lQ2
         J6oMjN4AWaGVZO4ccmTXze+ot33W1Cm2/niC12vgTcExh//WBnCErXrDkf/lZYHznyP9
         MbM0lU1iWJt7vtQunYFAA7EwpVWc4U0CeanZxRB6N2x9lGRLGgM34RQgWs94fumdYWa4
         NMZu/OBSea3UFzcI1RbkaSU8M4fPbGLArUfFbBS4INN5BssaPSaFc5qGnipjKvrpA5cX
         fZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVYiR+JFfsmWGYvTm7xu0Po/YFchNzSwOkWY1kYo5uEVUuwGvTm1MZtsue1krgRzxlvW0bvn/zj2ZTHoyjz9ELmMwP/tVTsGJPcUmja
X-Gm-Message-State: AOJu0Yxq5jAg/M98YxDHQUfYvHXOhn3O2xpr5Bu1C9THjizye0cOTOmG
	UqUfbwbwODusDb7ef7Nch2Wg7i+8D8qNOdZTRept8TdlZhf0FFleNvyNtrMoUyM=
X-Google-Smtp-Source: AGHT+IEtKN5tC6ABJu+hRBezT/QshYcfhWNrkTMUXMHmMGcpraUk52c+2mvByGaSZJu3f52D9bSM2A==
X-Received: by 2002:a5d:5412:0:b0:35f:259c:cca2 with SMTP id ffacd0b85a97d-3607a768b42mr8062269f8f.34.1718719359438;
        Tue, 18 Jun 2024 07:02:39 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:39 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:41 +0000
Subject: [PATCH 9/9] iio: adc: ad7606: fix standby gpio state to match the
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-9-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

The binding's documentation specifies that "As the line is active low, it
should be marked GPIO_ACTIVE_LOW". However, in the driver, it was handled
the opposite way. This commit sets the driver's behaviour in sync with the
documentation

Fixes: 722407a4e8c0 ("staging:iio:ad7606: Use GPIO descriptor API")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 502344e019e0..05addea105f0 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -438,7 +438,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return PTR_ERR(st->gpio_range);
 
 	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_standby))
 		return PTR_ERR(st->gpio_standby);
 
@@ -681,7 +681,7 @@ static int ad7606_suspend(struct device *dev)
 
 	if (st->gpio_standby) {
 		gpiod_set_value(st->gpio_range, 1);
-		gpiod_set_value(st->gpio_standby, 0);
+		gpiod_set_value(st->gpio_standby, 1);
 	}
 
 	return 0;

-- 
2.34.1



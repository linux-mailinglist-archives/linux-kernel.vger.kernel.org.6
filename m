Return-Path: <linux-kernel+bounces-217642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9190B285
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ECF1F23DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706481CE099;
	Mon, 17 Jun 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MgXMSCg2"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8E1CD5D8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632250; cv=none; b=tJeDab7rK7tRkFcjGqlsEbSppA5XIjN5fpzBzyIP48iLvMq40KrX/34Lz+mfmD9l5m5/pXHAXxlIjTcJgICVimjBrPEQT54Mjj7ZzJJmNRoiXIUgFWL5500rT2LwuV92jxuKQU8EaG9aTfbrK/6h81OGqsjk1+OaYg6Gp6DmiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632250; c=relaxed/simple;
	bh=kFbbephRGP7AE1Xa56t0vAiYHDMzoLghdVd3BAj9xjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrhGTlHT8Py60XoRSSe6C8SLVdy0fG4EJnSG9NdEJvEi662TdncXDYyJxWQ5tZKDX0LHSnux3Rqs/hQM85F3Y0XwU+eg7zaMTqT3dB/oWDWE/4wEtRQh0Epof/3vzrxfmlES7DRTFPv5XuKpTkMSrAklRdJ1hWNZlcI/Y0eNggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MgXMSCg2; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48e56ae9ac7so334732137.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632247; x=1719237047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DclUw90neJHmAEodckLVU1MrMAClwpCF1mlaeSjcN+U=;
        b=MgXMSCg2roORNLJCtNkC7jFx3opJX9fL8P2DylkI4jYWpBsEkEOBAReVyAQVR1uqJz
         I/rauZjQ7PgfmRCXQuNhjgWgRiLMwiwKKs+Yz69QpzJ9DTlG9cNJbzB8wSeejAwbocHI
         baPvjoivdUMF3sW/PlHM05hA6ZGxeqIyFRVcb0Se6cvYMOfqtbbkDGydinvSUqgwuLJr
         l4c2cgd2OaB20EE6sCw4jMuYw0fZZzNMmcweLhvsnvFvyaaVbCrV5q52LWWAxpJL8Rg7
         h6rTi092g/fyjnU/LKQ/Iw2NKex9oCgDpo5ThP8tWu8P4NYdEOu7JoZPOQ4wMcccpdPg
         WpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632247; x=1719237047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DclUw90neJHmAEodckLVU1MrMAClwpCF1mlaeSjcN+U=;
        b=n0VkSUi8LaU2dkiufADOaV9hv4EXdnCbCI4EvKXhxE/zan1JYNEkX5XuJ2/qHY8qF4
         zz9/dJec6M09gZ36DPQ6zY44W3u0qPPEBtvWbBuXGslZBtZA4Gp9OeHlyDQ3HW5urN0z
         g2c18fJQN4MyTcd/Id6BnDRoEXWn34/Vf/EAZGaeTLGeOnRcta6ccHHWGT6YgBIBMkAf
         QZAHn2M0ukWS4/xF8pDwz9YLvGUbwgCnxodFPCebMJhbaPn/Is2yuNA0D5Eao2+IISes
         T4pb87qaNn4YvVvT7/3u3qssjUKOyd/1Tnb7BI0x4tRXw64qW9mX12OXPM80b+B2Bieg
         wG1A==
X-Forwarded-Encrypted: i=1; AJvYcCUGiZV2YOpqoYaJB+OnPkRDhNBy7X7pAU45CNYJBkg/Y0oJt7v6pmQoXECtnmi+AXvu7YbMFi1Gxv12jlzACA7bDnNtuLqgkHAQwIgX
X-Gm-Message-State: AOJu0Yw3RjjpNZLK3p4t20FTNGINbG9yo1ORdrTEy8W+iVFx31l71ofX
	198pUsL+GlCw1nqNSRrmjNC5xqWyekmYOob2ypzJnRMQS43WFCEkQiNI4Lh25z0=
X-Google-Smtp-Source: AGHT+IEubRIeXP7Kagp49NVByjjGeveFz51rlB4BKjhqfHfpKBEa7G7VixyRzOvMhLylvoLMhbPrtQ==
X-Received: by 2002:a67:ec98:0:b0:48d:c0ab:ac20 with SMTP id ada2fe7eead31-48dc0abad12mr7057846137.7.1718632247057;
        Mon, 17 Jun 2024 06:50:47 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:46 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:09 -0400
Subject: [PATCH v3 29/41] iio: light: iqs621-als: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-29-88d1338c4cca@baylibre.com>
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
 drivers/iio/light/iqs621-als.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index 004ea890a4b2..6de33feada3a 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -86,8 +86,8 @@ static int iqs621_als_init(struct iqs621_als_private *iqs621_als)
 	if (iqs621_als->prox_en)
 		event_mask |= iqs62x->dev_desc->ir_mask;
 
-	return regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
-				  event_mask, 0);
+	return regmap_clear_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
+				 event_mask);
 }
 
 static int iqs621_als_notifier(struct notifier_block *notifier,

-- 
2.45.2



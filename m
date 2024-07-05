Return-Path: <linux-kernel+bounces-242346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A669286F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C6282740
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DE3148FF7;
	Fri,  5 Jul 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeiwXAGx"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC52148304
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176059; cv=none; b=U0Flp1410LrDtp2b5v0d5ckE/hwDV6RE3I0jhL0gmI6bf7P/9+Q6jP3eKgxB9wtjz9ofxmJgMjnbre7kQZm6gPuB4iruQPrHf4qE+9rHxRwhrSMBs/m47XW1BQjE1tw2ARJ94vjruo7WWg1I16Uw53LmzEBr7a9flDW5GoqA2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176059; c=relaxed/simple;
	bh=2JNEEDT0yqg0ZpezS+vJkAIFphubIucu2CrwWdLhExA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9Sq5jlPiSLgKfbRHgt0Zmqny77JuE8CHlRo4s0mU0vcWP7Y8xdWp3QLuIJCIpmUlwUM40KH4fnHI2bq2d709j8gGYCPpLcIH62iocUhY1RBdXrqHX8pWU65D17iwXVNU66Smjhj+07SFWVAdQQO6s4z2CINJTP470RAg48dae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IeiwXAGx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so1733275e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176055; x=1720780855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPUGB6WWLvSgcH0G9Q4p2N02Tp+SMaWAilQNUIzP9x8=;
        b=IeiwXAGxBTyEnIO9Us4XvDbvXCw7pmEzKczda6qvJEYejW5KjVRFGdOT9EEKU3j5SK
         6+yRVIJtNXmiBXlB3EzG5EXG7dVCnzMLzUIwYpsvJKQXHmKbKe36Tlvs2Bz0hldxGXHc
         vlZnEB5NvlLZJhC/uKKCq4pXmCNQudqRCBmfcwOZHzKCbsFzCgjpeZq5ZtbV78aRdsqa
         FwbsdDv+RohVAcYfk/9TY5nF6H0QoERWnJE0jArtfB6Sz4mAD4fQOeGtvAuhWH/jQgIS
         l7OZwpRr2kXL89X6ZTSFVz+CfOzgSvNa0a6OHZJN4uDwJDb/RtJw0etr+daHXKQhouTK
         YDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176055; x=1720780855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPUGB6WWLvSgcH0G9Q4p2N02Tp+SMaWAilQNUIzP9x8=;
        b=hAZCTx4yi4SzpryWn2p6sPQW2V2zkFMRVhYkPpilkLh+gEH107Wpo6nqlraJQ0firV
         bbq7CpEJHi/SLiRF8GGpWKz5CpT44dqUeM636CtV56JxSAcd9VNd6ARKKbIJT1dW53ip
         I0SYmWwoqGz2f6G1kEyjB6VuBJuHKPYuIt9Xv6GXWs6xdS+gxNQL63WbwFw6/nPTpe4w
         4Ds8BYaQFq16g7gsjiu3euFHOGY+wMlh7LbVcQEJNJFCbpIW1ExAwcBMkJur0F1pRTd2
         cmAGBjWsLUfYrzFtqRb/BRVjfLCQLw707oVUfvSe8PAEGb71lj9Mh5Qos1KsyUdufteR
         +YYA==
X-Forwarded-Encrypted: i=1; AJvYcCXaxt4uStREVll3rzCVfUMBPQ/R5fH0om/3qplArYrGCbWE/WSCQhE+rwduQw1TUgAZMs8RK6jeRPOwJkqOkJDD/4S55MEaQzloZ7fk
X-Gm-Message-State: AOJu0YwubEqB0UN1NG2BAoI8f/Ej2mYJIzJSZlzqb3eXIKbuB8g5IIpv
	goeR9fPHxo9hf3kPwCCHnFGxUPbcl2VKo5uabkmVDRhtCi2QzjOMtj7pZZ5GAuM=
X-Google-Smtp-Source: AGHT+IG91L1QiQgNWqSWoacLRT/4TO/Dx2hLrfRAQx3fZ6Bx/+xCR5Xz6K+GVEbHWRxKNEP2hp8MbA==
X-Received: by 2002:a05:600c:3b87:b0:425:6bea:8554 with SMTP id 5b1f17b1804b1-4264a44dd7emr27116585e9.27.1720176055057;
        Fri, 05 Jul 2024 03:40:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:40:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 12:40:44 +0200
Subject: [PATCH 1/6] iio: accel: bma400: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-cleanup-h-iio-v1-1-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
To: Dan Robertson <dan@dlrobertson.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2JNEEDT0yqg0ZpezS+vJkAIFphubIucu2CrwWdLhExA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82t2yoLgw7U/d/3WF1lw6Sbpe0R3WznQ7bXQ
 zvidEQNGzqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNrQAKCRDBN2bmhouD
 18eFD/99kCbJW7rMBIrokTGQp+teP0OMxk9HEiucDrZMQqy964A/H6w6db7bxlu/FqpIge6xQfZ
 pgShtD2t06mxtvYqI8U7yZJgNkkNoOY8Mzy1NJncQrBuEXHf66NEGrsoMYwpPl31WIGH7LN6EsI
 Ghx3oPDxEmtAAuHBGsEhdCdDzuartmIyR0WnmgMSBT43VYTwVglMAg0Ep48AuxCZnm4PDQD89zo
 bPvUgyFgchmkNQEFwAByBkrlygUVTQ+IPLRa2TlVN+gsau951q2k5VgHgWhtzwqk+5uEWLZHYf6
 wc6adZUHqX43cgbEfSaINs2Mszebw7ONrWbCMLyJLtJsYEAo/UyDrSk8AwM3CXeCzFjkKUE0gem
 N4LryYcpQ0eZ+PKKK/2HL50uDBF+MoMhmJQyOrb5MWFCTQ4Yo54ImehbKCayJSNQg6wx+0fE1OY
 I5KBjLZbj579jh2iLHlCdWNuDwDG6JugmcbLsnJt9D/ZxzDLrGWU3nphOqADk6rOpFUARMuc3ms
 ZLcIPlDzNFu0ntch5S3pAJ5mSW8zKSv65ZGz4qcHkVlVysAPcs4/pKU2ewf0L4x8LOano98sgKg
 /Wp5hbOhQDKwhrdvno18IAYmmFh+9K4rLxikmurZbqTx43Y1luTowQ57+5oh4A5yl4L8c6+DW6P
 7AiqGyaPLAdiiwA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/accel/bma400_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index e90e2f01550a..89db242f06e0 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -795,21 +796,19 @@ static int bma400_enable_steps(struct bma400_data *data, int val)
 
 static int bma400_get_steps_reg(struct bma400_data *data, int *val)
 {
-	u8 *steps_raw;
 	int ret;
 
-	steps_raw = kmalloc(BMA400_STEP_RAW_LEN, GFP_KERNEL);
+	u8 *steps_raw __free(kfree) = kmalloc(BMA400_STEP_RAW_LEN, GFP_KERNEL);
 	if (!steps_raw)
 		return -ENOMEM;
 
 	ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
 			       steps_raw, BMA400_STEP_RAW_LEN);
-	if (ret) {
-		kfree(steps_raw);
+	if (ret)
 		return ret;
-	}
+
 	*val = get_unaligned_le24(steps_raw);
-	kfree(steps_raw);
+
 	return IIO_VAL_INT;
 }
 

-- 
2.43.0



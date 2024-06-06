Return-Path: <linux-kernel+bounces-204467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41F8FEFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76CFB2107D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD21CBE8A;
	Thu,  6 Jun 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bb3TOCBw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15C1AB917
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684028; cv=none; b=GRedH8cD4qHdEQ0TlIiMdSt4uPem3iW7iw3LFjNuSa0wQzIvN3tm4dfHFgNl/6Nd2C9DxLwG4003rzcgBs98pBghxijDNjx79x7tW8A7LgN96QaLb9ihQ3/jHPH82gI5RtsQ7IBDAmjx8Mc8UbSnoeyFErvZ7UZsYUzQxZTr1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684028; c=relaxed/simple;
	bh=Hp0KsC5HwhKWjuU0rx+gepKEunDcg2mYhhVl5Vk2qUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CErm4m8U/X5etY/fJzSpsLVEFrzHTGPzcra4JnHFIxXnqRFxMAoauedz9yFnHzSqpWZQ03lc1BLWnFHdkIn7NY0fPbqFMeNZL4qtUdChYcxRGvt8qiJDex6QzSrn+S8HmyvYFuACkNmFbEzO3BPYWR1zqGsoxmhmDB0gerEAMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bb3TOCBw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4215b0c4b7dso11162935e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684025; x=1718288825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+ucwVrP9FqBPlEjc2qVzfZv7KjtrjoEsEhW3bQV3ZM=;
        b=Bb3TOCBwmnRZ0PvwFhQFn6Vi7s73PiAu6Tdl14MfQV4XceMvHorandXT4ohB8gF08v
         WooNocXD1YLZLmm8pD99ygqS5YM838wrIvlA/dETVPZXB8V7y4iPdD/iD59LIqqAdvMf
         1WqhA0DgPZeg2Mgd4Ea26yJS7xjKvqNjw3VQ1sQbUIKXVCzMiSCIlJADeylu/x/HJBfV
         ockSIUwIr7PgxjxrYwuDsNgf04r/K+LJMvcqsizRzEtCzukKHLWU82PovujRz/4a63ke
         kLwSmfxdGJICJc1xzuzUp4pJNgbkBQpqdrxIIBQqcf7qcFP4Rd6/UvxHiq8xe/2jEvhP
         y/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684025; x=1718288825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+ucwVrP9FqBPlEjc2qVzfZv7KjtrjoEsEhW3bQV3ZM=;
        b=OXU4ZPJY8yM+9DO6drn9ckHCOKssYBumZypK8g+rynD/zkviOIt7Le7FOp0QMe2xWf
         W6z+dLCkouHOGXFgub80YrYAKwjIdaXe6AgBiXrSFsoYncJxiLi999MxTL7f66pKXu+S
         JHfzzb8izh6pUdq73ZUKuQf1sseVtWddXBY0X+Ivmp0wr5UZYihyoiSj2bne9OJzKLwT
         d4/rWfzRCxY/jFSWo+EK5PL11PHRYkfM5W3nWnm8Asjbhh9AIuUVo1F152xvgeaxbLh2
         Tam7NHO+AMLTprBn7SIev9FOYLSv41c82Tlwjrb2cbl3fRjROIDgkfCBskZWx3rgBgEe
         O3jw==
X-Forwarded-Encrypted: i=1; AJvYcCXwaln3dK8tdiuI0t0SmVcJZYUBLum0uqigrSAr7/hHKhG4SBQEhkSQc+PxcgcRjlpglgpWFqGUd0Tr5mwkIpnMiqU1y0fzVNXBEGDB
X-Gm-Message-State: AOJu0YyMAaF4Boz6MbeF4HNkkvG8HP2tBrZe/YBDg30JmwKjZdnklYnr
	NexRHj4pOwLnqZTYq4U36ws7dROqgEqgOhTW2rPhv9tXDqUh9MR+/XXKigVW6qbQxJhVfkttkpU
	6ZtCsHA==
X-Google-Smtp-Source: AGHT+IHeRcRhmWeYcqfES9CowAT66RkX4rreoxVuN8gsEg8M2xfS1xjpanbOHWkrFb1iW4cWvwDxGg==
X-Received: by 2002:a05:600c:4ed2:b0:421:20aa:6048 with SMTP id 5b1f17b1804b1-4215632d043mr45173115e9.26.1717684025715;
        Thu, 06 Jun 2024 07:27:05 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm59158615e9.19.2024.06.06.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:27:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Jun 2024 16:26:48 +0200
Subject: [PATCH 6/8] iio: addac: ad74413r: simplify with
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-spi-match-data-v1-6-320b291ee1fe@linaro.org>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
In-Reply-To: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
To: Lucas Stankus <lucas.p.stankus@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Ramona Bolboaca <ramona.bolboaca@analog.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Hp0KsC5HwhKWjuU0rx+gepKEunDcg2mYhhVl5Vk2qUA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYcct9AkNfOhrdv0aXgz8WbT8ItA0nYChb1IkG
 tQJHicxlJKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmHHLQAKCRDBN2bmhouD
 1+8tD/9kGv0CRdyCorpxMDcIjlDugigaWQJF7veYJcxaXGNet5oxrENs39tNOSueTabB8gOVlFY
 EqPaSBiBGuUSxI57j4FJ6ZVgvhh4fa5t9sGsjO/vEGA31x58rnhlzJ5DkFjyVQSTnACQxjgHx7P
 zY52/H6bYjBQ6BmyJ2B93K51azN1RxkFbFf1/DRWYyeNL/dJqj2mgp4t1WD/OYcDCT9lqDPfEzE
 e8XDcxmIbC0zGwdOF/oRIhnebOz8U7sz5eJdqlkI8f8bg6qvcqRUs01Uz2YmuxmiCF2Ft+CrJ5Z
 AUZa6MdtvML2QwH5sCgnEgSzFxr/+GxJEcX6ajrdUfZ/7Ryo0F5ndepHJt3+LWHNvAev3Q28DGz
 dNd4GH1hJQGNAFzy+RhWixDNPGhFm/3MvIxtvmlguhrhMhnv7sSMm2Etr7mKTUGq4x74zGSc25R
 w6cX8cNdupXHTbyZe7UL0I2nuHhqVOFIW4w5ZoBmMd8y9LaJ9xsIq8RTD0PksazzEJua3ejSqsO
 PQPJnOk+dIjK9RTSCVlWnqydBPb7R0kog2XOiDVbAZeVSUNsBscuIqqYLI0X7CgVeltRDMgp1x1
 Z1ASWW+lqLAkgsy8NqqLJALd3hwCIsFLpxOZoBFhbXDEv8aHrAFdBGm9aBFXL7icaGco/deAuwL
 N4NNec7gwA477ew==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/addac/ad74413r.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index cd26a16dc0ff..2410d72da49b 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1365,16 +1365,9 @@ static int ad74413r_probe(struct spi_device *spi)
 
 	st->spi = spi;
 	st->dev = &spi->dev;
-	st->chip_info = device_get_match_data(&spi->dev);
-	if (!st->chip_info) {
-		const struct spi_device_id *id = spi_get_device_id(spi);
-
-		if (id)
-			st->chip_info =
-				(struct ad74413r_chip_info *)id->driver_data;
-		if (!st->chip_info)
-			return -EINVAL;
-	}
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -EINVAL;
 
 	mutex_init(&st->lock);
 	init_completion(&st->adc_data_completion);

-- 
2.43.0



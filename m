Return-Path: <linux-kernel+bounces-317147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0A96D9FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99952843DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88EF19D06E;
	Thu,  5 Sep 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbf53t1H"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEF189518
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542224; cv=none; b=pWELW9eNgLPkx0teo7R5dmhe9KXYnRmeenKuFdBKfiFNuuTdDuudT6bXPjnkmGrT77ffsHhihUGCrd94oxIPLOiZ/cUXTxQDfW1icwaqfUhGS8lCXhIznp4+DzNG4H1a7s51zTrChJ9TgbrD1hNjZtWkEpN91YBpYK8v8wV8fNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542224; c=relaxed/simple;
	bh=BMTo3carnvYp9GhWjQhnE96UE0W8/j+fbBiWuyJ/RUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O9Iw0Y9dv8vO5GCrhno1V9/W1xMMc+xbYM0hh8yXnUUlAmDXKQcei0LIoC338qOaD7I77mefpi9ft8ibIAc5Xwtte93Mx9295PFNwMHVXdeBJkzllhx3msHKMp2YFRNpFGuGKhaP6ghmUEf3DWFc+GA3amZnqAeDn6+oBHL92G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fbf53t1H; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c1120a32so439531f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725542220; x=1726147020; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVGZO5DUGSRAZiLVSjLJKdfhQDqbVUzzhoobR/BWTM0=;
        b=fbf53t1H2Z5RqfcjQ+SP6pkMw3AYFU3cecY8Ix8tlDv+mlyUS1HcqX2LYR3Acxy5ov
         f2DSATaC8W+7myNjIV16bIKUoPoLrkVdzO9RlJvHkqopvoPC7zWf8QQqjy34EhP06f+4
         0jVQ0IvehHxS4d6Bn99GqjixXdFE4LUKEC21mmLgYQUmTmQNASIQZRH8eiYOAebLGBGz
         yZh9wvl8CHoGYE5Cj/DmCsnivQ1oO1PEDw1W+TfuQsg6NdUlEc5yeybVRzwAs3Xynt46
         95lrW3N8XCvPaz2OFKqwDAYGa78YfCKTyi/ckeugHZdEdVqhFgpKMmRJGKtJFoEcWEfm
         ae6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542220; x=1726147020;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVGZO5DUGSRAZiLVSjLJKdfhQDqbVUzzhoobR/BWTM0=;
        b=geQZ/zXANoiRKtsiMDeRIOQGwBO9GErz3ICDV2cdOssasXJdpo6+GJiHUorgeHUq3p
         2i9swqWdvqwrxNMsUUz8E2kHVPxLRvr/6y50voN8YC91B2Uxngm+SPZ57NidZJ3QJxLs
         zB6oPKJdH7DS3mwkumZlZvtPDRaUPRZGsZWFALUrqFu2D9CdyMkXt2lynYX8FkFmH9MT
         p5JY61s906g6ywe7khIk7Kog/BtrKuAqcB0vQbZRTHYAx+D+3ckzKc5R7n5gTKeQWino
         HHzv021ZECBaEoEx5OcTcmJw8W62QN/I2sHrHfy3YEGT97c2UfxC83+7QVLBWF65Hdh3
         fLSA==
X-Forwarded-Encrypted: i=1; AJvYcCXrJmLk6ifg/xKEOep0Oh0ITBVQbhjZYZ1XxFzpEgCO1iEuy2lkXf3Qtbu5RLThk8sTDh/fXh7ZiIEg2u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJm6WJGL9RqCD2H1hFxc0QIw8dkjF9o2rxBJyCAJv3ozsW7eP0
	hKrrYyS7pMf++RdFqIbkL+Yq57R9o8ECx3bE4bT+xsZcyz7ise88fMCA5ftMtl8=
X-Google-Smtp-Source: AGHT+IHXGHeVl08sm0U4IEIbIKLtRMyu+iDC3lyWmyaA7RnL33Vci6SlP3CfCB7hLVvFD9z0PpmXjA==
X-Received: by 2002:a5d:590d:0:b0:367:8383:6305 with SMTP id ffacd0b85a97d-374bcff3aaamr11078324f8f.55.1725542219822;
        Thu, 05 Sep 2024 06:16:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4ac81sm19250718f8f.14.2024.09.05.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:16:59 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:16:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] platform: cznic: turris-omnia-mcu: Fix error check in
 omnia_mcu_register_trng()
Message-ID: <2b10f2e1-82d1-4f33-92c4-e0cb28b9edac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The gpiod_to_irq() function never returns zero.  It returns negative
error codes or a positive IRQ number.  Update the checking to check
for negatives.

Fixes: 41bb142a4028 ("platform: cznic: turris-omnia-mcu: Add support for MCU provided TRNG")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
For more information about the history of IRQ return values see my blog:
https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/
The gpiod_to_irq() function was modified to not return zero in 2016.

 drivers/platform/cznic/turris-omnia-mcu-trng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/cznic/turris-omnia-mcu-trng.c b/drivers/platform/cznic/turris-omnia-mcu-trng.c
index ad953fb3c37a..9a1d9292dc9a 100644
--- a/drivers/platform/cznic/turris-omnia-mcu-trng.c
+++ b/drivers/platform/cznic/turris-omnia-mcu-trng.c
@@ -70,8 +70,8 @@ int omnia_mcu_register_trng(struct omnia_mcu *mcu)
 
 	irq_idx = omnia_int_to_gpio_idx[__bf_shf(OMNIA_INT_TRNG)];
 	irq = gpiod_to_irq(gpio_device_get_desc(mcu->gc.gpiodev, irq_idx));
-	if (!irq)
-		return dev_err_probe(dev, -ENXIO, "Cannot get TRNG IRQ\n");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Cannot get TRNG IRQ\n");
 
 	/*
 	 * If someone else cleared the TRNG interrupt but did not read the
-- 
2.45.2



Return-Path: <linux-kernel+bounces-248953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6034692E45A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923E41C2074E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60461158DD4;
	Thu, 11 Jul 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeDeOfgq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1601158878
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693206; cv=none; b=fkT9Bdv60auqH6AOMilQW0edDMboGox+4Mh4PzuNohgioHUxQOlsC+WIFMcguSN1qtgsVZvzl00NO+3ny2pd/CPu/kIFXY92jjAAPag8Kiqkfls0/FrXKGPtRtehPnOYK+Yd6+SamOdOJUPbKzj8IyAP2UN47tlCkon49VjppFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693206; c=relaxed/simple;
	bh=bKIdUuVmWv5FJkFDtu2H6clQsAHCUTFbn8+qyaw6hHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIhadfy9u2zjCmWeNLoWlf8LeFHRu000RLOZrqhKwdAguHwxBWN68OoMwjPnDAMa83TfbuDyj+E25XptSp0NnsJsYMRnykLAp5kxv7P9E1Ksh/c0vqclpfYhI57fPb82B9vu7GAj3Fqn821GW4hZCNHF6ZzJOj2Sc+5d6y3ixzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AeDeOfgq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso1271055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720693203; x=1721298003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jw6bLyA4dVnYszcIqA96Q05ikE6tm67ysRPS44gZ2Bo=;
        b=AeDeOfgqmtP6YqYtgTpYNinb9oqMQl3i7j38vK4+io3o2BdQ00xqcjagYE4jzCULnB
         E4zK8QAZ7vgI18tg4Wl9bxBcVnzYW/fUdzoUskWQc+r5st4WQBPQ18QdyrnbNCK/CkK9
         9by3L7M9izvLBeYybfLp7EGrHzIkly9reeppj256TLUcJTas4KaaYGDeL6blF2Xj67po
         7JmFAm3A3hjbGCAd7Q45WmwhiU9R7cNAbVHuzPXOMnlorAPMeRcyY1KCUJmq8r2iA7vm
         Jmdj+/wNpcM5s0aaCWbWTgk2OVrKksnQfoAsrNXjLVa1Ng0pN2u+TS64yQ0ie+9HuytJ
         lUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693203; x=1721298003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw6bLyA4dVnYszcIqA96Q05ikE6tm67ysRPS44gZ2Bo=;
        b=Ycx5Un20uRaWf6wfFQuOHEMoSH3GendkQosjBwmqXQBa/Rvu6qklSj9joaM34fJZno
         /34NcLn07Usp57E4E7O6dgyuKKMYNj+l1U8pmlwBl6FDf8YBjNgjn00FJXO1x5zeCPCf
         ZByz5Wlw2JLpsP8hWUUT9Gp0Z12X/pywWFPuHoiieHffmTLdhu5DtW6pQpGjyJt9bZo4
         EtnbOWHLiSxVF1ACKC+YYgOtDJWOcERhU5EpkCdGfuQF+9/ovPsfJ6FBD/azwWEfVeLq
         IW83Uh1Nn5+Ai8Vti0cIvzzd7JyIv3iCUCbr3N8yFVF6DwT/x/RJQLTo7ze16Odf1QFM
         5Qsg==
X-Forwarded-Encrypted: i=1; AJvYcCWTpBxt3u8q1qY2yjjo+E1FTUX2VycMFHZchB2BYxcfijDrLDyhf8JIVZnUxYWQixJEc10qdxKV9VkOz7GC9mlZbIC02Dby4r2ss3Cf
X-Gm-Message-State: AOJu0Yw8BlOzImDesI/fzwaoVGZI5Oc6+KMmuRYRi44SH87n++d/1Q+2
	Jii7d1+TxB9/dbHCkmLB99kysuv7LiL7QZQ+jvG1nkKtwoeQT30Rqs9JvxkHSaA=
X-Google-Smtp-Source: AGHT+IEPG6ALVrKC0vxITNNnj0AxUU2b5IhohOK+zwxcy7Y2DoKsbVYQ4rwu1v3iMbA9+oXaQb0Gcw==
X-Received: by 2002:a05:600c:228f:b0:426:668f:5eca with SMTP id 5b1f17b1804b1-426706c6878mr52146665e9.7.1720693203327;
        Thu, 11 Jul 2024 03:20:03 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266e861339sm125270025e9.12.2024.07.11.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:20:02 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 11 Jul 2024 11:20:02 +0100
Subject: [PATCH 2/2] media: ov5675: Elongate reset to first transaction
 minimum gap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-linux-next-ov5675-v1-2-69e9b6c62c16@linaro.org>
References: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
In-Reply-To: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-13183

The ov5675 specification says that the gap between XSHUTDN deassert and the
first I2C transaction should be a minimum of 8192 XVCLK cycles.

Right now we use a usleep_rage() that gives a sleep time of between about
430 and 860 microseconds.

On the Lenovo X13s we have observed that in about 1/20 cases the current
timing is too tight and we start transacting before the ov5675's reset
cycle completes, leading to I2C bus transaction failures.

The reset racing is sometimes triggered at initial chip probe but, more
usually on a subsequent power-off/power-on cycle e.g.

[   71.451662] ov5675 24-0010: failed to write reg 0x0103. error = -5
[   71.451686] ov5675 24-0010: failed to set plls

The current quiescence period we have is too tight, doubling the minimum
appears to fix the issue observed on X13s.

Fixes: 49d9ad719e89 ("media: ov5675: add device-tree support and support runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov5675.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 92bd35133a5d..0498f8f3064d 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -1018,8 +1018,13 @@ static int ov5675_power_on(struct device *dev)
 
 	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
 
-	/* 8192 xvclk cycles prior to the first SCCB transation */
-	usleep_range(delay_us, delay_us * 2);
+	/* The spec calls for a minimum delay of 8192 XVCLK cycles prior to
+	 * transacting on the I2C bus, which translates to about 430
+	 * microseconds at 19.2 MHz.
+	 * Testing shows the range 8192 - 16384 cycles to be unreliable.
+	 * Grant a more liberal 2x -3x clock cycle grace time.
+	 */
+	usleep_range(delay_us * 2, delay_us * 3);
 
 	return 0;
 }

-- 
2.45.2



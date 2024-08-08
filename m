Return-Path: <linux-kernel+bounces-280062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF794C534
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A442D1C21ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005015B0F2;
	Thu,  8 Aug 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwACziWO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556415A4B5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145306; cv=none; b=e2Xqj40x3n9SjYaZcwHedkY19POsot1YPq/2mLBEdYCid/JgDAl9O0hxVAkDd46DqwkNraGQiBirKtD4O0zkB7keOKJKqpSWBfsMIzWgV+qD8y0R/liTY6lQ0Y3MPYAnQep+TIniv41b5qA8YkhdjBbwvwHGA3hZkcO87Ev9RwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145306; c=relaxed/simple;
	bh=NQU0Rv98JrX81/A1nEguAxQLbRP4/UsWjsfJGNGtA8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a2GTw+5XpdC1fds4NMvdueLSSLt6DTq49tWgHvnkGGdCK8mTvqPt7RE5BLKo9MWVB8zpiMTqUL/353Fx0Db0QW2gJ2TZ0SUxBgjIOkoVne2pZHiEFwZRXNX9PZ45PiS/lS1Gmyw9ecSIkstHA9vgu7n/+JwUn5IIBwmvewVp8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CwACziWO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efdf02d13so2578338e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723145302; x=1723750102; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmvNOlcZTqNimmDZ7x4m8PDONx3OgfdzukD/3f4hZ5w=;
        b=CwACziWOUTapdybnWrNogumsTX1V6OsrMKw78PQKu7KngUTQdcGc92gQio8YL67A1M
         /HJjnhRLN1MRe7e1ohM36s7AcMjIBI3ZqL07pQNJPnGGDRENikpY3Z4uJOAgYXvlAk6B
         LAFZMHdVCX3bAU6dOclgAQoaiK3LOGspzNDk5zcTHMAdomI/ZGBYlrHbMeCxcHqnAKbI
         vdLx6kqVCRc2teoLFnwg+89kOlgAbU8+MGSmlsljYAv+M/273NY0rbI2AcoYV2GFbaas
         RfDjumOQaUR+VfGrD6N9iQpEYq7tCn3N1M2MzTvAkOt5jEKzkzLUS74A8EstsOenSUcn
         2Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145302; x=1723750102;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmvNOlcZTqNimmDZ7x4m8PDONx3OgfdzukD/3f4hZ5w=;
        b=fUSlv6XbzbUUITW5eCA/B6yT+C+59z/r0lDyc4RGBZ1Bd7Ko/6/MqwOQfZ1lgvb6A+
         1y5K6fpaWmZgr1zKKYdf6uYx8X/oD2wb2Qtovp3sr9z10KxjXMCEsOBWVtdf3vcczuwD
         +jgW0JZrYvealVSSl2p0s8FFg9UcPUofKBzYdRgvQUG7FApD4rV4TUW08446RLvY8vj1
         qYz25jXWvz1zc2INa2XXpZCZNlv9NyYR2gjxIMlHaS6DQ/HrEs2X5D0+fHfmOGfObt9i
         +PhzoUkepK88MfJLYqoGwhnoFcV/dKqO30XZ/HH4lH3zpfuDCCFjhjVvtwioYIK4jqNa
         dliw==
X-Forwarded-Encrypted: i=1; AJvYcCX3NqArCA8xZeYUUn8Gd2EOiSKnLFamqoHCCyqCVZscuxqq9opQj1smu9hNDLxetjDWGdnpXf7sz8gbXqzhKQThuHpcjbwUaIholiu8
X-Gm-Message-State: AOJu0YxUEF+mH+i3Q5RCRy+v4a974QUS2C8/z2s5lg7JHg8Z/9SMOzoU
	4woR8MZE//1Z4lCeIM/CKcjXbApqBQ7tEFuFp9aFKznRFf6X+B3WpniAE2vrfLI=
X-Google-Smtp-Source: AGHT+IHtLnvvzJHxqOQEnHLayXZTmudxUv+Krktv9ZXkQDMBM8SbtIwTknWYYCVUWgTw7Owo1+ANLg==
X-Received: by 2002:a05:6512:280e:b0:52c:dd25:9ac6 with SMTP id 2adb3069b0e04-530e583df3dmr2798111e87.29.1723145301524;
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcaf7esm786912266b.12.2024.08.08.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
Date: Thu, 8 Aug 2024 22:28:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: pac1921: add missing error return in probe()
Message-ID: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error path was intended to return, and not just print an error.  The
current code will lead to an error pointer dereference.

Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/adc/pac1921.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index d04c6685d780..8200a47bdf21 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *client)
 
 	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
 	if (IS_ERR(priv->regmap))
-		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
-			      "Cannot initialize register map\n");
+		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
+				     "Cannot initialize register map\n");
 
 	devm_mutex_init(dev, &priv->lock);
 
-- 
2.43.0



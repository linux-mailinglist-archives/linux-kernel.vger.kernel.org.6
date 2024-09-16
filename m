Return-Path: <linux-kernel+bounces-330761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C393A97A3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2281C26E27
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344A15FA72;
	Mon, 16 Sep 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7QZmDpG"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2D15E5D4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495765; cv=none; b=F6CSuIsbKpM0SrLrCCmlBJOVWYbs7enPSAhNYrdE4/KvTaDdrrC3e6i2EKEQ0i9hluFNoAXv4y3iMH2PGyjbA+N0+hUhQg58yZ7kb6r0nWewo8qL2eUox0Tr1o8zNF27TAf08fajsqClsEhIQxXPh6y1kF2H/VLnVq+AL5xM8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495765; c=relaxed/simple;
	bh=NX5kItBI6qWChtIaNT2kylD3MQKq9w7BzjD6DZoxbDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwfP3MEIL3xhW4vfEULjXG3wWSv5eMm2v/d4vpT5taFBoVK5Kg/QV8p8Sak0FNSQxndPE3RbJxY+Z0CnOO69FefZwUjxudSMFDWLckEK0TKsJgRI6xGp0KTAX681OD3bCdiN95oi6grXwEcB/DsMS6rF9jNh8vEh5eiyEwjOQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7QZmDpG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d4979b843so627924266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495762; x=1727100562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhWdIDXVnRhjARMzfOhbCyFUIgcuuqCXLNl4MzBeIg0=;
        b=K7QZmDpGgmVdiqSOXak4dnBieT/pxEi2ZAZxwaCUDbXxeN9InFgXzap3gkmkbB5ghB
         MHrjg2v3nP52uBgUxBl8cgi3UGUM2w71AeCj/lwnVap0PtKRYEaEzlM+N2ATlesCEl05
         wpiRYCBErB8GXyRn4SNXWqlL8xXwztcYeqS9xWh6qDJZfSx4FJ07Ql+d6UrTWezHX+CX
         3T4CLevock6cufZ2yH37wTarUHaGsLmN04Y3FRzhZ4VSSBQbt6kCP83BUr9yNMYJPrBA
         xvnDHdvBRItD9nHD0NSA9F6qSu+VfyhccVxSLrD5tapBSyhvCDMng5jz6BywLik/Jxj4
         T1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495762; x=1727100562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhWdIDXVnRhjARMzfOhbCyFUIgcuuqCXLNl4MzBeIg0=;
        b=HKWWxO/GONt0DIOzKvngw2MR+yEfAIUjTzRvE7DgQQRUSQ29hiHppCTHdvV0ar7QMl
         Zf0j5Ub3FMPoPirfELctNKUl8Z7KQyO9oMpvSUhMXxzFYs/+pbeGf496cT/SiIz8osRY
         Tg9XTSRHtvG1Ss0T/7ga/qqFrBBAvMRzZmd3lVFxBOE17mIaFJlIzw0stn7oZAaqLWAZ
         c7Gz2U6r2eAD+AGyCmfzAThVHMUSMlvxGS1K/VbKac1RZvkeLI9Eg6F0NatgvecWN2tC
         FOfBAQrnbkYBTZl0d+TAfaMfJIfvyIjB2yo6v6jXPHCWsiWmxLh1OzBr5c/X+6SKrGIN
         q6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWnju+MzY50l2kLxUWJoXFO+qrapU2i49fPCQMYScDqeojyrEgOou1sQcLRTLux91hFDov1t4BKe29O+Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuMhV6EZm+cJdxQHsaV7ICA3ecj49OUlSVuJH94TSLuP/kx4P
	zE45WTEUM+PzBUczJ1BQf4uO+DydyWAvIXJBLs1CvAuScgLxU8D6Z0YRCRxMx/8=
X-Google-Smtp-Source: AGHT+IEZzIM9A+aqMP7t3V0EP26ZH1dlD/AwzLiHQs10yeXD8zAfdCjeoGV4RvP6VJWRp8ORItjbaA==
X-Received: by 2002:a17:907:72ca:b0:a8d:2d2e:90e6 with SMTP id a640c23a62f3a-a9029674fb4mr1717029766b.60.1726495762282;
        Mon, 16 Sep 2024 07:09:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096a29sm322687466b.41.2024.09.16.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:09:21 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:09:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: bmi323: fix reversed if statement in
 bmi323_core_runtime_resume()
Message-ID: <689a2122-6e2f-4b0c-9a1c-39a98621c6c1@stanley.mountain>
References: <cover.1726333044.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726333044.git.dan.carpenter@linaro.org>

This reversed if statement means that the function just returns success
without writing to the registers.

Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Added the dev_err() message

 drivers/iio/imu/bmi323/bmi323_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index f6ff07ba98cd..527d6c321ab3 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2226,8 +2226,10 @@ static int bmi323_core_runtime_resume(struct device *dev)
 	 * after being reset in the lower power state by runtime-pm.
 	 */
 	ret = bmi323_init(data);
-	if (!ret)
+	if (ret) {
+		dev_err(data->dev, "Device power-on and init failed: %d", ret);
 		return ret;
+	}
 
 	/* Register must be cleared before changing an active config */
 	ret = regmap_write(data->regmap, BMI323_FEAT_IO0_REG, 0);
-- 
2.45.2



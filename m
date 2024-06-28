Return-Path: <linux-kernel+bounces-234063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC291C1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD11C22A76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851A1CB32D;
	Fri, 28 Jun 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qf+bZVby"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432901C8FB8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586128; cv=none; b=s5129F0wWFMQUaNV81eFSeIaFNXGE5NxjiJE4wdPTLRBzLQ1OR7fdcPO5b8Xxzm97xzLxDjijIorlIzZtnbE3MVTX/FyeTnFl+tSTy9VP9o/zEQPg+tgITt2ZCc2vHZu0uvBIYaJ7t3gfBjwe4KIv6zO6MElQ3tV+MLyaOyNIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586128; c=relaxed/simple;
	bh=zkEo5EBrLX8I0YqEPhDKPXhiD1/9kd463rWFYg4+DxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BtaY9DrzJQ6jrrWZcCNrmDkwys9F4SrzKsZc8PhDOWA9+vtOXNyG+9POqyNYDmIql2nZbbuRY2FCUySIUY7EGWts1SuDtRyBS0AlAo09BgbWHRC2exmpU1H2dSR46NlKaye7RxnbDrStdmdUqvZhE35bE461ePdoneOXcakv7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qf+bZVby; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e7693c369so949684e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586124; x=1720190924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADGaCoJBg3lwoGbw2zYEMfaAobfkeTksU5BYqolmCQE=;
        b=qf+bZVbyNSes7tLSAV5EO9TfTI1V0eiLsWoiPJXYw0qdnqlG7RaRESG4Xf6goLLAju
         Qtd7F+58tOsTVtrhWRuTc9gdzHMH2ciYw83KSu88UA2HRrMzYIWQJWropLnzFPvJl7O5
         O7w7XgP3/9ErSpO6NMveRH+vteeOk4pt+CqmfDtmFU3xfAD3OigeJ5/mUzyUJ96MuxWc
         TOM+tfYw4fNHxfPkDEhW4qcFXYmPUL8WkeC5WmdW0FR/1qnucg5GSBmSXSdXjCMO5TOG
         i1lXmpKDramoz8bM9u5v2ctnWn8tBNGOC0LquRG65Zbg7jVDWCa1PpsDMbRmFLIYLqR4
         nc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586124; x=1720190924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADGaCoJBg3lwoGbw2zYEMfaAobfkeTksU5BYqolmCQE=;
        b=XQs6MVRL8HkwtyDIeK2JC+MvbSr09HUJw95lmCF08lGNv2ON008sa+nD6nKXBfVwt2
         dBudQVGf+tSvAnPLD5vPs2tCY33eGzyxz9RYWPsZ7y0zUMQvN5Hw7y+7s7Nz8grL2H91
         By91RPzLfhAevSAWoZv2BOy5mVjjIXeJSHm8pQ28c1+4HkJCrTjmjAJLz0/T008kgkaU
         ij/jzghJBcPbNvNb1CrrXKGf11swLF9Bwhym6UzfTolf9wyP65Esv/HvgrH4uGAvvmQ9
         1uBwrkQJnnuXGUB1pULr0MHUVWUykSFME190r8xOtmNmkk+in6/0jDvzgDCyhB/yZyIP
         yEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4sEe5xxA8YBrJUSc/G8ITO29Y9G9C1cRHqicQsLTLK38GJExV+v8IAwzvxxue2AQvGnFD/s0QX12cqcASstuXkiWKagvzhW6pwTL1
X-Gm-Message-State: AOJu0YzFOfYjz5vmycGFPMfa8npZsGJXS/VggNMWu73/Are3cA+yCYUP
	C8kwqvybP4MtXmt350j6H1Z3vkQiQM+Rf7lpZ8zWkuhk4VxsX2q+pQI6UDVQH0M=
X-Google-Smtp-Source: AGHT+IHG9i2w/w79YYyodKkBuJIFAclGDdSXPjq2661d7wRgXl44XIteS1jVb5nqsYRQfGoKVOYCzw==
X-Received: by 2002:a19:4310:0:b0:52c:b479:902d with SMTP id 2adb3069b0e04-52ce06105efmr12653810e87.4.1719586124217;
        Fri, 28 Jun 2024 07:48:44 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:43 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:28 +0000
Subject: [PATCH v2 10/10] iio: adc: ad7606: switch mutexes to scoped_guard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-10-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
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

Switching to scoped_guard simplifies the code and avoids to take care to
unlock the mutex in case of premature return.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 60 ++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 50ccc245e314..3c439787d130 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -69,19 +69,17 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	if (readval) {
 		ret = st->bops->reg_read(st, reg);
 		if (ret < 0)
-			goto err_unlock;
+			return ret;
 		*readval = ret;
-		ret = 0;
+		return 0;
 	} else {
-		ret = st->bops->reg_write(st, reg, writeval);
+		return st->bops->reg_write(st, reg, writeval);
 	}
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static int ad7606_read_samples(struct ad7606_state *st)
@@ -124,18 +122,18 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	scoped_guard(mutex, &st->lock) {
+		ret = ad7606_read_samples(st);
+		if (ret)
+			goto error_ret;
 
-	ret = ad7606_read_samples(st);
-	if (ret == 0)
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
 						   iio_get_time_ns(indio_dev));
-
-	iio_trigger_notify_done(indio_dev->trig);
-	/* The rising edge of the CONVST signal starts a new conversion. */
-	gpiod_set_value(st->gpio_convst, 1);
-
-	mutex_unlock(&st->lock);
+error_ret:
+		iio_trigger_notify_done(indio_dev->trig);
+		/* The rising edge of the CONVST signal starts a new conversion. */
+		gpiod_set_value(st->gpio_convst, 1);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -259,17 +257,15 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&st->lock);
-		i = find_closest(val2, st->scale_avail, st->num_scales);
-		if (st->sw_mode_en)
-			ch = chan->address;
-		ret = st->write_scale(indio_dev, ch, i);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
+		scoped_guard(mutex, &st->lock) {
+			i = find_closest(val2, st->scale_avail, st->num_scales);
+			if (st->sw_mode_en)
+				ch = chan->address;
+			ret = st->write_scale(indio_dev, ch, i);
+			if (ret < 0)
+				return ret;
+			st->range[ch] = i;
 		}
-		st->range[ch] = i;
-		mutex_unlock(&st->lock);
 
 		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -277,14 +273,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
-		mutex_lock(&st->lock);
-		ret = st->write_os(indio_dev, i);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
+		scoped_guard(mutex, &st->lock) {
+			ret = st->write_os(indio_dev, i);
+			if (ret < 0)
+				return ret;
+			st->oversampling = st->oversampling_avail[i];
 		}
-		st->oversampling = st->oversampling_avail[i];
-		mutex_unlock(&st->lock);
 
 		return 0;
 	default:

-- 
2.34.1



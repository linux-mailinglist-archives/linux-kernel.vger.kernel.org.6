Return-Path: <linux-kernel+bounces-234062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D8091C1A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925791F26DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7C1CB312;
	Fri, 28 Jun 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OmUH3gU2"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF01C68AB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586127; cv=none; b=RcqUt/JtXmeiWfUAV78BDQ0Md/1L0wPtoKmzJWxRD0BtTcF1befC6Pu5DTzdTxbi+NjyUIZ0dZMFAiPeS9wrxhujpMwNq9wWs/V68yFk8+Rknohje4H9hJUqj5r/26o++YXQj3CzEaOHIX/M5utjGF2Sz+kt3VpowH47Yv7kAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586127; c=relaxed/simple;
	bh=TIZIXKMsUIcBcBNX8jkDzeY8VA7Mhb/sJ7N5yvRpSuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilildtK0c6qifX0vTenlbRi0JjzQSl7z5Lqv1kp9bSFLY+F9o3HC+/QqIXdkdNu0DAuqwWZtNZTjqJ6EJ6/FQjmzkRcRpaS19g4J6lYZnosni8CiCbfi7sR2/ON8J+OGL8yCzOkLZdfYfptR0GKJpIo4zB1L44eHIaypi8PkxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OmUH3gU2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso8274621fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586123; x=1720190923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0syamWwYKEIgGFfBRP6mPS2Iu9QxWFGeekc+8eB0dRA=;
        b=OmUH3gU2HjJ08h9gcbgCvhKQ60f0zK7OETyEt+VYQlMd6YONKXyjpJtz+0tXymzTCj
         9WPDx731RI9Bhiysus0vUGiw4MxjAvNRqEcdLHYu1iiDaClmcDHMsoOsUMArpdOzVsPb
         jgCO7LKDPkJD136yVvewajpVgvxfvh6H/I3H7DtNY25J5HZeOnUGLLkMDAvZokVjtyyu
         Vd3xVDTLsQxSYwG286oGlWr4hFC6WGQxnVqiN1mdbkQKypNvFnZC2xESUgKD1vP9K5GN
         MihOjbiFQnI8UbkETcPJvny+UGWyycPXAHQhp8sSHZmtIvtGfN9e0629V7775o/L3ROV
         MORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586123; x=1720190923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0syamWwYKEIgGFfBRP6mPS2Iu9QxWFGeekc+8eB0dRA=;
        b=TpA/u9PCdW9nWuzp/8Mapd8ubPPkaas9Qz4LCdi2DNN3pAucv7qabafrra7DxuhM8j
         QLj7IgH25eCblP0yu14EoNh1JJzt25MQusK2evhe0eCeU8DPZkihLmjf+ggpdJZG+ctz
         BUUq+j27pxqkobtTZgbeWVoXWfRezd6H4myikirF6c2MRkBJzWSRvP4+FouZLqCQVy4X
         z/8UK2SMajek13iuEXqVKoA1zehEkkH+8LyLH1R3I7R6/4MXQWTmIkeW1xnZpxc+qM6A
         63biSgHrAGcZ3yVOZlYl1Oa7ldl2AbMwoRkGw3zktWYEBJlK63W9EvCP4Jh38cC3mXkS
         fm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBpNxzXgRDOsDs3bKLvDi94YscQUqAC6y9ibBhTIEdgCJsv1RfhmdDYBG9qJwALHxueSPu20k+QZFiYxturaOwPAUsJDbkyD9BWVhX
X-Gm-Message-State: AOJu0YzFTF33YDDwqGxw/lDkhIkScBkwo9ZXk0XkiUfhzWIbnKjWjWTc
	OpvzVEq0vhJeJGzjcoTT2oh2eCxNjq8zdImVcCV01ox8EwbwttzmqJnz+WDfHrw=
X-Google-Smtp-Source: AGHT+IGdYd+dELr8zIKWmQcy9X5n0z09TSJbmVdeFrFpZc6IVQh56XrFpIW3yj6V8h5TPsPZTCvydg==
X-Received: by 2002:a2e:8913:0:b0:2ec:6755:a0cf with SMTP id 38308e7fff4ca-2ec6755a196mr77843931fa.32.1719586123293;
        Fri, 28 Jun 2024 07:48:43 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:42 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:27 +0000
Subject: [PATCH v2 09/10] iio: adc: ad7606: fix standby gpio state to match
 the documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-9-96e02f90256d@baylibre.com>
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
index 8cce1fad9763..50ccc245e314 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -443,7 +443,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return PTR_ERR(st->gpio_range);
 
 	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_standby))
 		return PTR_ERR(st->gpio_standby);
 
@@ -686,7 +686,7 @@ static int ad7606_suspend(struct device *dev)
 
 	if (st->gpio_standby) {
 		gpiod_set_value(st->gpio_range, 1);
-		gpiod_set_value(st->gpio_standby, 0);
+		gpiod_set_value(st->gpio_standby, 1);
 	}
 
 	return 0;

-- 
2.34.1



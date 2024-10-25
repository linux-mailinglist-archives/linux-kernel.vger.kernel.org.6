Return-Path: <linux-kernel+bounces-381439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A779AFF43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A91F210CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3281D45FC;
	Fri, 25 Oct 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W+MefqaC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED01D5ADD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850393; cv=none; b=gHf/JiXnh7PwNcwvADCvaUGhTHSG+zgRShhxnPevY7hUNBIpaXUjxJhXLxNL75f7EJV6+FLkl3fLC06hUsteGLJ7+rs5dfmpMZDsX+yb5M+ywpU4BZoX5as/QB+hzD4ph4kGvygBj4fghMz6bHHjaI4VQ8HdZSejWfV126+yM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850393; c=relaxed/simple;
	bh=rGc3MWfnfDGr6DVhiTPyA4ENZmPwmhTHYX0jVVNz4Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPPVuE2VuE6DkLtMuZECLG6Yaj1jP5DigtVCO4UPMNKlDItpculyYkEf2abWkQ9fuzfMVyWLzBG8gjYe/zO3uyhw4Xr+DSMp9pD7zI9w84aKASIrGHwNqLA+JH0M3OY7w34hJUpUyMDBuqizj1jtah0jr52vR27k97AHutalzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W+MefqaC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so2287589a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729850390; x=1730455190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMGdrMcJaMIE/WsVeQifPxez2nYQfB71+FONgrmlyfk=;
        b=W+MefqaCmXKrfcbB+KWDoEWvL5VQOL5ZIm+dpBDcnsc39HcYuFa+336drolcn4LRn5
         45Cht9ul6SEngeKqkk6dHrqzZ+MXTqKXSGwiaibB5SDIuI3xGexBn7ZVeQ9QWXU5Y2Or
         eiMMIuVzm54PzqKVZ6GZk31yz+Dj0Jr60C9/Jckcm32HfA3JutzI21Qf0KOTQU/LNTUz
         UwyQnBrInWiJvFby1W0GezX9o8cV9EVEKwHqB1ei0ruScJiVyPbvAvu47fgAgyev2eF7
         P8PDuyehqXL3/7l0U7S2zNQunqaba15hNbuOZKxrV9knpfzFSNdKzpl8KTvrYtosAZMO
         aNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850390; x=1730455190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMGdrMcJaMIE/WsVeQifPxez2nYQfB71+FONgrmlyfk=;
        b=nDeBmveowVz5GQqiz71m2CvUjH9AwrtF9s0+vP6NINiMSle3YSL0clQbpN4ZkR+l/C
         0ZGOMzc3tqeSqT8wUpWXm7KDsiqljrPV3mQ1ZxIjxQQ4ppBnsbsvaHtHQJNyj32Pjfbp
         xo+Wi7xznxmehRdE1ojcbtaevN92LhUz7eexFfYdOytp6hOLP7Qqv4ieaqJ37s1I/9fC
         bma6wn3HMjPwgQw5Ps5ojT31zKkO34+i2LGJ/+ZHMGuDR8DaG5kmmYdadbpPIAPL57/6
         jo3IqfhhQbjiFayb+egzshH8RuMOofUcEJ7r9wGroN9Mnbm19K/i4pgkWh3cFxQ/rGtu
         6UGw==
X-Forwarded-Encrypted: i=1; AJvYcCWhjxnQy8dfnvH679iuBiN1ooENbfKCLQ2VIBJrFaJD2cB1MlOnjJHMQk5welt95lDWO+3qUPb9BYUut9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YztAlUoY2TZfQV9y00GW04ZDsbOcMn45bmjx5l4o/aK60Kklj8/
	ZEoxWhlONsBb+3wF68/phd05RIJcyasFU+s8+0bpnrBc69k5OUGKfZQD5woRyfQ=
X-Google-Smtp-Source: AGHT+IFHx4c5CALGB7W5EOFi/W4CgKWigUrzNoYjfJYsnyAu+NVG1D+ZwiEpouJlqZdc8Zwp0c9FeA==
X-Received: by 2002:a17:907:1c12:b0:a9a:4cf:5cea with SMTP id a640c23a62f3a-a9abf9a588amr851098666b.54.1729850389745;
        Fri, 25 Oct 2024 02:59:49 -0700 (PDT)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f02951esm51737266b.71.2024.10.25.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:49 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	conor.dooley@microchip.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 1/5] iio: adc: ad7606: fix/persist oversampling_ratio setting
Date: Fri, 25 Oct 2024 12:59:35 +0300
Message-ID: <20241025095939.271811-2-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241025095939.271811-1-aardelean@baylibre.com>
References: <20241025095939.271811-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mutexes were reworked to guards, the caching of the
oversampling_ratio values was removed by accident.

The main effect of this change is that, after setting the
oversampling_ratio value, reading it back would result in the initial value
(of 1).
The value would get sent to the device correctly though.

Fixes 2956979dbd0d: ("iio: adc: ad7606: switch mutexes to guard")
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 0e830a17fc19..ae49f4ba50d9 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -753,6 +753,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		ret = st->write_os(indio_dev, i);
 		if (ret < 0)
 			return ret;
+		st->oversampling = st->oversampling_avail[i];
 
 		return 0;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-- 
2.46.1



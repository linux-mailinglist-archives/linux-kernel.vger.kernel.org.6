Return-Path: <linux-kernel+bounces-316615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98BF96D1F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678F6286789
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DBB194ACF;
	Thu,  5 Sep 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JwPGn4g8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088B19341D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524655; cv=none; b=Tfqq/rNZahhUct7LADyNvaxRcGSVdHgmfq9AreUuUwJAI/LTNON95KRMV4FzaNxI0QdtJQavOe05+esDnXcoOnZVEaY107DjblqZSEr8VjEA8ausxxuHGCuX9Ju871DsHG81bRgWlBuxqA3HJl4Inkbra6baqswoLwK75cbz/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524655; c=relaxed/simple;
	bh=IXqmhsQDt/RO+GElC8x8ywqYUr/3SWcgPZP7XLJrRH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNE6PZVk+Ke3VCFCT8DLxN6p5L50vf7/PtDej2OPwMvs+21B6UlMlJTJyLbDQ14/QiKonotnNM3s1/qG6SsGH/2THrTYeK5Pqnfh1rBYfPqZ9KYRosmFnnoxVBVobPEadbTrlq8JuZIRIIplyRvpfqXKsxepFgRY8AfgYBIT1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JwPGn4g8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso40777466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725524652; x=1726129452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui2lv4x9FTPWujQRhFdVeT4msHXJUFxc93RUhnH6Vdg=;
        b=JwPGn4g8GeYDVKv4b9DldZ9DFTgVI+yaQ8IiL2Awq4e429XdqnSApH+1z+5Yl9yHBJ
         gNgSwD+tVZMvuwXgUePP55VFBuUyX8ZwpjWDGbh9+GKMjEVU5h9m45we+pQdMTtoVF6d
         YoJLlRq+fD1NslByFHgQ74eanGKPUeExnxrSX2o+i4KZX5Clh5ggKgnv6WB8U6jihynt
         dKzSGwf3pfcnUQpdEESR1WgUb1GwRI0H89yQH1/in3yiGPkbsov+6O9eSLmltuV7uqzj
         N6Ps3UuhSFyDcJe/6zQzwdbUyuUZcO8wA4amCJISJPcBj4QoVFuwc+YI4SiIb8aZG9K+
         wf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524652; x=1726129452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui2lv4x9FTPWujQRhFdVeT4msHXJUFxc93RUhnH6Vdg=;
        b=s5gEI8l8Fjb7OuSJtrTwcDK87kOunkUkdoi8nmOSEs67CJgXeZJBWU0mEs1LlunNBe
         vVCRmPgICJnR5ZVlCNDwrjYfZXnsBisBr2iUyiCY589cOmNELwQQMG1/N7TMrXZ7R5IA
         8TiTkj7A4WOvfWTGSZrPdqrN/QO0Wm8dIw8RfTzgjp1TF/ySJ5j9ZGiEuAJ8XraO+2z6
         W4fTIIHo5v6T0KkugU9oBGOLhaf6auv40g5xcj4sFCxl4KOCUnpCUoH0YkZfGrkxoQi1
         3Z91v5Lzxfr+iDw4TZ/gyp2S76Q4v2ojPuQKbLGU+tDkwmfUIKrTpIjrqtG5ppo1qBZ9
         u4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN1fAhwacO0ikLe6GqoZEaNCouvxXW1IBeKa6o06t9QEJp3Ad0e6J7LINPiK5HXPBfPPc9SymTMBAio8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OBE0lgJnZfnH/fES1JP5ORcQyNN5e7ptPP8WnXLG3PfbXzcs
	gLxy3AdWLVaQSk3EcfFOLS4P+UwbJjDclfpXB9uwbIAVeoDlBTcWmKYujOFjwxM=
X-Google-Smtp-Source: AGHT+IEg9smD3/79iAKydqGIqzyJ9DE03yBVXkcC3TkTHttLotdZFlY5siEzBv07VVQlDR9b14GcJg==
X-Received: by 2002:a17:907:c1e:b0:a86:a30f:4b00 with SMTP id a640c23a62f3a-a8a43209886mr500823866b.27.1725524652223;
        Thu, 05 Sep 2024 01:24:12 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c80sm102300366b.174.2024.09.05.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 01:24:11 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v4 2/8] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
Date: Thu,  5 Sep 2024 11:23:56 +0300
Message-ID: <20240905082404.119022-3-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905082404.119022-1-aardelean@baylibre.com>
References: <20240905082404.119022-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7606_scan_direct() function returns 'int', which is fine for 16-bit
samples.
But when going to 18-bit samples, these need to be implemented as 32-bit
(or int) type.

In that case when getting samples (which can be negative), we'd get random
error codes.
So, the easiest thing is to just move the 'val' pointer to
'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
preparation for 18-bit ADCs (of the AD7606 family).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dba1f28782e4..5049e37f8393 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -138,7 +138,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
+			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -153,7 +154,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
-		ret = st->data[ch];
+		*val = sign_extend32(st->data[ch], 15);
 
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
@@ -173,10 +174,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad7606_scan_direct(indio_dev, chan->address);
+			ret = ad7606_scan_direct(indio_dev, chan->address, val);
 			if (ret < 0)
 				return ret;
-			*val = (short) ret;
 			return IIO_VAL_INT;
 		}
 		unreachable();
-- 
2.46.0



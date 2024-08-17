Return-Path: <linux-kernel+bounces-290762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2F955852
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989641C21249
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AEE153808;
	Sat, 17 Aug 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ounaWgok"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571911E481
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904592; cv=none; b=sH8SBzvvqNCj8TxK1K9MLu/h4TntbJVPLM+81sbPpSporRFpdarIX3FOAoj23H49Ck0E5qlxyHzaEvuHEFMzxj+iWleg4GxXxqJ3gIDCh42DYgjCmkohC+DQoXlXvQa+vKmdXqRikvFnBOhoez/EnEpm/fLp1On3XFKy5ArEdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904592; c=relaxed/simple;
	bh=uk5i5KEhn3uYO96x/ZIsSJPtmoVsLanxeeIVAC3TqRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQ1obvBxWxZVrxLFeIFthTMADnkfvJJJF9SVbMAoWXC/5i1RbnWynQq1Z1Tgl1/dT2i7PkK3Nh3c8CMh8znq4hksXpbPZrzOm/b7UWcAxrcOlP21Wn7C6e4ffWqDcTcMF4D6Un/fACFZxp5KzUTrB4LScr4SUFJ8cd/oDLcTQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ounaWgok; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bebcdc75e9so505270a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723904587; x=1724509387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iMaGmzWFia+xTWrULyzkJ0JdQY6tg1+ik3EJL+2SsM=;
        b=ounaWgokWLTIDTyecXlnCOKga5FukWcN/gaUg0YO+LKv5CQwa1SRYmU7QhxtBJSHj4
         0ru7cYAGKmHe40RnqVqT/DLWSosidmiNz3gc4ar12c8YzsslXA4tizY0/eAbYFymB8fQ
         AOF7/1h07SiUQ76ZFPhHlFIpvqwvCXy6oVNELK1fyzQbdxRqZQ9187phzFGovtFfs0pc
         6Iu0ciceB7vbs9zWxraR+GGHK+L/u3WXi7OrtJt0QDjv8tORr7C7aaNIet3o4kdsTSX8
         gaWVQr2Tc/0YHRLsgDjoaZRw0RrSWOtYKPvA9iAspQabj+hEhPRZ4A6PVeuXoBNhuBG0
         KgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723904587; x=1724509387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iMaGmzWFia+xTWrULyzkJ0JdQY6tg1+ik3EJL+2SsM=;
        b=WR846rdzuj2824rcqF8jSe7n3BJrhwfhP1FFsmWSV24nHrf8MdhOo/jdLuYq5YAta/
         TXBAYe8aCdL5mPdGLEdxGnp7ydDDo5vDjW9g0GgoKRR+BZGnQUSbf8aBvOIBr520jbgw
         q0I7i5lPZrSr1Q7Wk+4TvgBeWKKPXU5fRp8s4juw8gawwdQcPm+XeVaQ4mA2p/BC3JUA
         Uk3UqzxFHNH8BoiavIcE1ztOJ/0v3tTZl7wL/TpNrvRcVje7AlRyGeKY0opLDbtrhprq
         w/S5cQpljjuI3jOd8/mRaGYaI/NjICzRn8LXVayM5onBFVbKk7aDOEXgRYHdGDwkz1JS
         QdPg==
X-Forwarded-Encrypted: i=1; AJvYcCW0P8YZFHbWFoQUkv0hLj8FsITnWxCqcFxouUj6BEzQGnYOXbcgUb49XU9lMfKmR8xIwjDbtYpV/UoWdPeMkBniPFI45H+0CyR7egz2
X-Gm-Message-State: AOJu0YzGU1jQhApbVB0BrPziQhJ3ROdKEOvCd3lSPKkBrqczTIkVA5/6
	LXp/gtKsH38MqfHdjmWDvKAqz1l4Qlkz8Da78jHcgdkx/9xeU8OpFDclwPoTZ78=
X-Google-Smtp-Source: AGHT+IGshDUPYYZZShBNA3L65qaD2NpTDM97a/D2l47/Pel9hRVfH+U4YCFgoVu5TCAqxCfpxBkR/A==
X-Received: by 2002:a17:907:6d29:b0:a79:a1b2:1a5e with SMTP id a640c23a62f3a-a8392f93cbemr199533766b.10.1723904587038;
        Sat, 17 Aug 2024 07:23:07 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935710sm403286466b.129.2024.08.17.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 07:23:06 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	gstols@baylibre.com,
	nuno.sa@analog.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
Date: Sat, 17 Aug 2024 17:22:57 +0300
Message-ID: <20240817142257.14470-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
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
So, the easiest thing is to, just move the 'val' pointer to
'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
preparation for 18-bit ADCs (of the AD7606 family).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dba1f28782e4..35b2862c3928 100644
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
+		ret = (short)st->data[ch];
 
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



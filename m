Return-Path: <linux-kernel+bounces-541625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD5A4BF59
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4531F3B01B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539320E03A;
	Mon,  3 Mar 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CCyBrL8e"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DF20DD63
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002474; cv=none; b=kS25eVMmaBMYKeGh1vW4XCfl4FBnhI0+tYD1r2nLkARjnFsqN5mkx529j3HO5/AyEIh/Ld0UeKGeimW5RSzDSHWnNfbRgaPsohwVHw+nTJTcnsEgHRoVyfKK6PC+7uI4DoFdRuLGFR2+OV4Jk1BTFS4+QeGaNAb0nCWA1EO3b1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002474; c=relaxed/simple;
	bh=+v+ir1+IglYL05L7kQ/+NcMJ+uc5Mh8VNYIDLO2zj4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=As3l1vOkEngnlTYeO49s9FtKFpZI9ZzsEjTso3ooGdGPyrvRh5VW6kCedTUVKMqGQsgew5M4apOeaqEnidfsCN0E5kvpareFXPQYMcMVcSXyM+RS3q4Cw610tvGSZ8ioaEvi2ekeR8ykVGYeJ8bfZiNFrGznAeOJOQbI+jM6Uvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CCyBrL8e; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390fdaf2897so1538939f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002471; x=1741607271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKR8mmc7je6VNvAt7e6XfCwJ0Xm9s9LiP8WsU315nXs=;
        b=CCyBrL8eeJVwtW/vo7tWcTm446qekFDbvRoK1W3Pmqxv3iA5H/UdB3hF6EQit9gGwh
         v9qV1HvcIGe8093vqFQZ7pe583JvPwx1uBhHLNigNoJdRAoZDVUoYG7aZ7u1Hs4HqGcL
         5KMOMD169w3jkX45AIUarv/Z/j4Lun0gybflb1G7OxCePmO48nc9dt7fLfp5XdYwTIJA
         MXtf5CM/XmKlwWEyjWaiRv6vNOh/HCsOXMJcLy2Alf1tj2mzV6icIEU+DOimXJLm9RD9
         yRn3lsSl39E6iPrwmGupqJ42Xe18sRgiK682EedLV/HOp1w2sZuVaCNbQbXUvTnXjOSc
         X0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002471; x=1741607271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKR8mmc7je6VNvAt7e6XfCwJ0Xm9s9LiP8WsU315nXs=;
        b=R25MZOSm+8kUEndqQmnlkq74wjBH0ELak0OWVn+VWqb7CBnOpx9PdG8Hx4JJ/ZrYFl
         plOAHPIJKiVm7G24WKWlVRD2zH+902ngspyz9bzgprrqosiu4624o0DhKYrdNLGBLfyu
         LCxtVGSbclEVnHaDUwKzJ1OvLEmiYTM/qrd3PER/Fc+fPRaFj6KsNIYz0j3C3zIPPzIG
         Lk0ahv6VPBdmF1EKj+HmJ+10gqAruyq8jONE9hjqdbuedWFYYruGLnWAqcbYIwBflfM3
         RjWRjWy/BX4X6nemjh0LJD1BkmEsE9WR6JwybQ01IbS4nyEoDINSTpeh1NcHNPa0DBOL
         GwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl2+60caxzH79b6FXCUKJfn9ClSAm5RY2JEZ8pmsZ/YTsazrWzBXuXlDTmOmp3ALKSFaHSN1mS983VBCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNsiqWUOezvqgclhoObNkA9nUPpsdey3yzg55at9IxLlWD10l
	sG+Y819kRl7Vv99irERwO7ETkABTYJsqP3uJ2/FdAs/vmqE7MkG56k5ti2oHag8=
X-Gm-Gg: ASbGncunt4sLw1WuaXrqF+flmLi2XjQYseX/uGvQgttau+YqgW2smmuHP0hK79czQOU
	9Zn+0LDxG0KuN7vsVhI1zz6evyD+ouctNCT3YPkM3iN83/v68hnoGVELzWeHmdEVdAlddxHBEUZ
	S0Igvh4oMRfWMRZqlx21a/WK4rfC6w5sU+DMbAGMPPgQRip2pDb72o08jPkNVXDYRLteGvBGNgB
	M/6vnSvHkEVyGcfAd25o5i9ptok/Pzun+PsDYXLNAtc3f5IRiYPzYCbIJEo8J9tMXKKpzkKWJtL
	M6ao8vxLuTEEVhXsPnE2T94/5s1ZrcXAvp7tFisYZWeVYlb+sJ3XankXVahT3XpdurWwZhSPSZ9
	BbP23HE4zRBRGknriHcUtEWZfaA==
X-Google-Smtp-Source: AGHT+IH5Z6btw41ZKAgQDipPHeM1p1kYa1+Z7ciGYHSk4HbVAIZ7A2f2vv2fwdCwPPHx3p4Q1j+Vww==
X-Received: by 2002:a5d:424b:0:b0:390:e46f:4454 with SMTP id ffacd0b85a97d-390ec9cbfbfmr10067180f8f.32.1741002471263;
        Mon, 03 Mar 2025 03:47:51 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a66adsm14110736f8f.25.2025.03.03.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:50 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] iio: adc: ad_sigma_delta: Add error checking for ad_sigma_delta_set_channel()
Date: Mon,  3 Mar 2025 12:47:04 +0100
Message-ID: <20250303114659.1672695-16-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=+v+ir1+IglYL05L7kQ/+NcMJ+uc5Mh8VNYIDLO2zj4c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbLpSyJJZQrMNOYSBT3O10ZES5srubfMKd/z Hdc8npRu1aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWywAKCRCPgPtYfRL+ TlsjB/wOYCnOMHsdZ0Q3jdrrQBdxHsZXk7f919eqxPaLXjMVofd/123J4vpuLOwaXwaC9W2fjs/ qEW9uVGxoJPU2pXSI/NOnW/tSiqvlVvvF0nKn8Vs8PGs4fACQy+R5WifPK8o/JDCKXnVex6BTOQ NOLo01eR/oiOROTYDKSkx1PKWUW1/efx/ARiHTLKT8bXBKRp0AGXj4nrn1ia98dXJj28h3t7D00 hkX1dnHsPcX5OjWBizSl7SxPa5dXzMQAe11k+Hsa8iu2l58v0J2FCYjmCuCXnxL75xv57fvrK1b 3mRa4JdY9akWMDP7YnNdyNbQyCL286ODl8Ga9ub/dpnFZRT8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

All other calls to ad_sigma_delta_set_channel() in ad_sigma_delta.c
check the return value afterwards. Do it for all calls.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d91a3ba127e3..6c37f8e21120 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -390,7 +390,9 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	ad_sigma_delta_set_channel(sigma_delta, chan->address);
+	ret = ad_sigma_delta_set_channel(sigma_delta, chan->address);
+	if (ret)
+		goto out_release;
 
 	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
@@ -431,6 +433,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = false;
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
+out_release:
 	iio_device_release_direct(indio_dev);
 
 	if (ret)
-- 
2.47.1



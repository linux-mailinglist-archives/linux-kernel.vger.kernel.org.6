Return-Path: <linux-kernel+bounces-212263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C057D905D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CECB2135B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53812F596;
	Wed, 12 Jun 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WMtQYTWP"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5E126F02
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226206; cv=none; b=FKoi1rlHFaVPJu4J08Cj2GblcDobFSJnXilNp0MDCrxtIZ3du9DNzjxjNm3WEnL8wSpWOMD1GYCltTUOQIgrZ5rgkv4VuteCrL9JgC4TBG638gQnOT9yIRS9SVmDih4lDe3THwOojMnhGXHr2tJPnmRZW4NelxxkCx7YRm8Yws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226206; c=relaxed/simple;
	bh=xZMj+Tp3hfugjb8DvqlKp+tQ02YG9Qbq10/c7lYjPNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru4IIJ2QaKQlyhqn9SXFky6ThyRG+14wAncg+CHBlNwwAZJHqTLGHpI33OnDGJCSSeW5/GW/50CXCYEXRTVqOfN1kV99X+ZW6XcgLo1Lj7GBB+pLtZul4p11KMJBHCRRq/mgxVEHoLxhtUaeZGyBN4DDYf+8gVjNhz5j0dH6/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WMtQYTWP; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d2220a11a8so133658b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226202; x=1718831002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hWOcNN+TXQI0vHdkxWXGyQx3IUvNG0BoVco9Tkt4lU=;
        b=WMtQYTWPPAPiKOeMyzal1EOjqkkz761SLE62WWRTdznahkKHVO7+FxLxGLxy1l3YAE
         C5IG36NAUu8hv2v6QT/ZsQaMoNOH2sOmwwgJMwAe98lokLT9xn+dYEhIzoTmEBaXIYps
         dDxueaP5Lp5fAkcSGg1tIOJYm4NFgNKyZN8da0f/OBHkg//z7WyumIhYwrJkOohKMjeZ
         hDL/NduMXdiDVqq8dxBEbUO3UdBoit0wPKGi4xHRnSknbaJ/e946VJXmuctqzm4hMFGP
         0sbpyjBeEipjIZvgQdTQaU8ZG3S9alER5Z9QVphXlzWAP57wpTQp4gIxl1k9HpMWcgh/
         Xrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226202; x=1718831002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hWOcNN+TXQI0vHdkxWXGyQx3IUvNG0BoVco9Tkt4lU=;
        b=OM9/GDXQxIfKfitXU8WxDZiHm+Lcta0CR+mhd8kMTPLGXpZ8bW8hoCq2yUdEGykmsR
         U0fCuXy2OInu9+U1m0Y9t5BfVhWyC08DrvvAKyi0oxaRuQj0NhDZKm1t3kV3zexmpd+M
         WsR2QVUEgWbXLmUjTKLOOhBokzL70qmtbOFFJHI5X31/r1sZ2Isaygplpg1ecUJgoDH0
         ys+SnL+VTCNmjCP5Uh328ZTMDh05k6R88VD9GMOSzu7v07HxwJY1HjSF4UyiE2PfSRVl
         K7QvtiDa85ffeJeRDsF3il+URIQmmH7yqXNddLMa6k+uyNs9Lj4UJtuOabHGDIE8IMzf
         mryA==
X-Forwarded-Encrypted: i=1; AJvYcCVzBpBT6zil6ADbp0UthHBayOFMtIpzs36lodWLMOCAoU27nDYUthyf3CTx07HLpSiYEXEZ63pkLiR68itLmmN9Rag+WNbd/+B2iIDb
X-Gm-Message-State: AOJu0YwIR88OJwc7wKgRpHEiEd+HLe/fes2tXxlX0x4A7uOX+3qFIIqC
	KwrCpG5iFegBrMnbAgJZzpK0X32F0nAxefnZmeMHiGdpVJ8PpfMAr2j1VN6Jw4s=
X-Google-Smtp-Source: AGHT+IEvviefEF6MK/t/Fpys2OCFvkv65Rxyl1H+DXe8N4+AZUg+8PjNV9RiCoXtmE2DqYHfirZ9Ug==
X-Received: by 2002:a05:6808:1456:b0:3d2:303f:ff3a with SMTP id 5614622812f47-3d23e11d1d5mr4109776b6e.51.1718226200831;
        Wed, 12 Jun 2024 14:03:20 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
Date: Wed, 12 Jun 2024 16:03:06 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-2-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
- avoid else in return value check
- use macro instead of comment to explain internal reference voltage
---
 drivers/iio/adc/ad7266.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 353a97f9c086..874d2dc34f92 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -23,9 +23,10 @@
 
 #include <linux/platform_data/ad7266.h>
 
+#define AD7266_INTERNAL_REF_MV	2500
+
 struct ad7266_state {
 	struct spi_device	*spi;
-	struct regulator	*reg;
 	unsigned long		vref_mv;
 
 	struct spi_transfer	single_xfer[3];
@@ -377,11 +378,6 @@ static const char * const ad7266_gpio_labels[] = {
 	"ad0", "ad1", "ad2",
 };
 
-static void ad7266_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7266_probe(struct spi_device *spi)
 {
 	struct ad7266_platform_data *pdata = spi->dev.platform_data;
@@ -396,28 +392,11 @@ static int ad7266_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			return ret;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
 
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Any other error indicates that the regulator does exist */
-		if (PTR_ERR(st->reg) != -ENODEV)
-			return PTR_ERR(st->reg);
-		/* Use internal reference */
-		st->vref_mv = 2500;
-	}
+	st->vref_mv = ret == -ENODEV ? AD7266_INTERNAL_REF_MV : ret / 1000;
 
 	if (pdata) {
 		st->fixed_addr = pdata->fixed_addr;

-- 
2.45.2



Return-Path: <linux-kernel+bounces-377750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3859AC3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F561F240AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D1199E94;
	Wed, 23 Oct 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CsMjOjtH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCF199E8D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675187; cv=none; b=FPjAkMKY3XGlnkGGkIBE9PG9kTmwpIOekBbzjfM2s4l5C21OGmvJQpAgoJvSqd5+Kqe45pWfO4NKS/BjHMNc7BaH/yZoZchnB1K4foItGdjeiNepmkFehk067xUhG9x5Bcd31p17mD555/NEk7YtmXVhX92DQ3O+iznYi0Lclds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675187; c=relaxed/simple;
	bh=5SRDC9p9MKxswYnd7y6LZi2xIt2zZS6yBwCYc+hydFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4COxjB2Usrjhp6sYM9TxXYfsXJAyYQUOS6H2yJSe3PxeucuQlbUjQFnQDgvzMoErR0+yZZFnZ3L3Kli/h0T6wKrK9uaEr0abdejcAczEzYmn+AoZ3rc87m8cIpGNb3KPcqkkr9gsfwfGoZmHX9Dm7Aq0zJpWuBHGSDnSxf4FnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CsMjOjtH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43159c9f617so63456405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729675184; x=1730279984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUAWPNA4323qWrX/2WYrVLftIYuIj6SGZHxAGWq4jNw=;
        b=CsMjOjtHvRXQRmEf5IvFY1TN/CQOSTPCIwET47Y9gQm3bkudfjMSmdEC9NnnlcflBy
         3Ok5H7nB/taNEeIEtDgsthVVGbFu1ptCy2IAAZWVz2ghMJ3n+VNR/mpxiwL9GVAJr8af
         vBUck34qnR/2T51eXzg+mjJkTw4t1YkGLNbgsKLijqB0kdQWqsple1vFcE6VtEDEThJo
         5Dqzy7gtSL8rlEbhu7dvC18a+QF6uGOPVPDlkyZAGxrypuBUiI119qj7eAWuWlBDoQuY
         kQ6TM0VD2Q2qYwoZHoUtzfiwHCjBp4AV2yZfM8S3CfccSHtPQQgdgeQslsWM/EXt+Jxx
         szxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675184; x=1730279984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUAWPNA4323qWrX/2WYrVLftIYuIj6SGZHxAGWq4jNw=;
        b=Npo7RDRuf+Xv3sWA6r6bYH0ppcnWlQzGScXGDChTxYBphk1X3YROZynr3LSckJmRzp
         HF19WYCC0M9859mwAkT5MmtQ8KDSFLDsfbxeujNUnVg6I6BmhNYR0rHmToU2Tiy/1+Wp
         5SaMBnRW+BszaTiJXM+jd/zR1AmpnIm2YF9K2sEjeHSr69Sv6TmH85XEVaZxkHjb/Qr/
         wXZe9lynmPSvuyStPZZ7QRZJhA198lHWOLFKR9lQ97AP5qKZZ2EnXg8s3010TFxtz4rX
         44cK/Gz+2+pZfGVqM5ktU1o6mN2a2h+5JmpqXpYtmUQF7OexBFaoAjkzq3i5M18EvqPY
         QsGA==
X-Forwarded-Encrypted: i=1; AJvYcCVU4K+Q7DGp5NXMSq7+9yGRFxHRauLDaIqGORIG2fu+jbet42oNuZCe8bIzyYDXFdO6a3L9heR65gxoTLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg40GpgKGGm3WKOHmeZjkuFNdqp5bN0ZSAoAUaxOBmCS01PKaK
	nzvO3L5GxAnXw5Mk7qqLXIdOiTt9HwdldXtWEhDWNEM7/yZ+2NDyfe3B/SYrRhU=
X-Google-Smtp-Source: AGHT+IG/VNM8c02tydtDKFpvCLc9ekaOX1xJn8EkpeM34xOF4e3DBVakwkBUmUTvjMsgb3ifjqeRGQ==
X-Received: by 2002:a05:600c:4f43:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-431841860eemr18352885e9.24.1729675184343;
        Wed, 23 Oct 2024 02:19:44 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8515796f8f.73.2024.10.23.02.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:19:43 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 23 Oct 2024 11:19:34 +0200
Subject: [PATCH v2 2/4] iio: adc: ad7380: fix oversampling formula
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-ad7380-add-adaq4380-4-support-v2-2-d55faea3bedf@baylibre.com>
References: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
In-Reply-To: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

The formula in the datasheet for oversampling time conversion seems to
be valid when device is at full speed using the maximum number of SDO
lines. The driver currently support only 1 SDO line. The formula will
produce larger delays than what is currently set, but some devices
actually require it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index fb728570debe6432d5f991595cb35e9e7af8b740..d57e17f38925da5fb7c8a0a2320a21474ba04b37 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -77,6 +77,12 @@
 #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
 #define T_POWERUP_US 5000		/* Power up */
 
+/*
+ * AD738x support several SDO lines to increase throughput, but driver currently
+ * supports only 1 SDO line (standard SPI transaction)
+ */
+#define AD7380_NUM_SDO_LINES		1
+
 struct ad7380_timing_specs {
 	const unsigned int t_csh_ns;	/* CS minimum high time */
 };
@@ -649,7 +655,8 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 
 	if (st->oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
-			T_CONVERT_X_NS * (st->oversampling_ratio - 1);
+			T_CONVERT_X_NS * (st->oversampling_ratio - 1) *
+			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
 }
@@ -667,12 +674,13 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 
 	/*
 	 * In the case of oversampling, conversion time is higher than in normal
-	 * mode. Technically T_CONVERT_X_NS is lower for some chips, but we use
-	 * the maximum value for simplicity for now.
+	 * mode: t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS*(x - 1)*num_channel/number_of_sdo_lines
+	 * where x is the oversampling ratio
 	 */
 	if (st->oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
-			(st->oversampling_ratio - 1);
+			(st->oversampling_ratio - 1) *
+			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	if (st->seq) {
 		xfer[0].delay.value = xfer[1].delay.value = t_convert;
@@ -1021,7 +1029,8 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
 				  AD7380_CONFIG2_SDO,
-				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
+				  FIELD_PREP(AD7380_CONFIG2_SDO,
+					     AD7380_NUM_SDO_LINES));
 }
 
 static int ad7380_probe(struct spi_device *spi)

-- 
2.47.0



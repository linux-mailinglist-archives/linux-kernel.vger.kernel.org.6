Return-Path: <linux-kernel+bounces-379462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687D39ADEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740F61F237CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643421C2334;
	Thu, 24 Oct 2024 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tcl5hjIH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D3189BB3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757849; cv=none; b=Z2fBMhNmpCyKEXgAgXiqqQoW6aUt+cssiWG9FAWfPrYvHQ0844iwBh0l0giIWlENO/zK6AW8VOHlde9l1irs/jPqKsXi6avC/JgjuPTqZzgfyftV77ahdXcOkEPQxrpVgErPtrjYb4GgsbT2zPsLJg3kMryCLQg3SOc8b9ibRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757849; c=relaxed/simple;
	bh=5SRDC9p9MKxswYnd7y6LZi2xIt2zZS6yBwCYc+hydFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4qMRDZhhE5KKacFUIcgWzxvdfy5gp6IyssVv9eQETYiUh6SJIqGA0t6+VntPjf8U8igQ6ZDxMqRck2Bc5VsTw67SZTD+EUDt6CwnI6wCtL28npIgDRgCZYkrd8s5eajAslcBm/5yZArE50ioC9E1YRtVE6ggfpq7D0txBboNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tcl5hjIH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so6559145e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729757845; x=1730362645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUAWPNA4323qWrX/2WYrVLftIYuIj6SGZHxAGWq4jNw=;
        b=tcl5hjIHsaAUigNqo51CTVG459HFTc1bbnc+SQqYr9YHlVSwUlVZsLTkh5/Fqdcfcw
         PV67ZKenBzeV2jO6YplsuxGUq1hY0hlI0SyCU7lRMb1sN//J9j9wKan10EuL4BY40GzV
         J3d1rngh+llp5a2n5lrEZ+RMTHNuiI1JM8QNgmrHaGGZgVQt6JB167Da5uhAVGb0n1CR
         mahBE732IF3LzApPVFhZGiPKNXsT337Qkv99mDWz0qxt7UMpQMXuNpdGVY89oZe+knc1
         53kZqTTzMHs3nI6YfNJrQHWrpwYA6+D27RivllvHsJB6H+yk65PBMwIrdLh1dkcjJ8Kg
         h0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729757845; x=1730362645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUAWPNA4323qWrX/2WYrVLftIYuIj6SGZHxAGWq4jNw=;
        b=XitghQ6kWpCBfpQUSsQdtMl2aFEjNGEWZh3N4QPf8/IjTe/KRjUnpYkaKwoWUtTjHy
         u6E9XVo9h9JUueA30MgjaGe5w+vsdxmWJxURJoJ/FKMPP3MWtg/suKXULrdFIm0MyjOm
         39TRMs3nG1GCT4JFWtaavytU9Lsxt6xMbn+0QNKHBNXDQkm2RqlZ5kDNPa5xMUPb9yji
         xgS9hDF73KUDO/8prZ5U7mbuZzqVnhutHJVfgXmKhdfIBQi+4ilg2CoNYBjvHfhc0qXO
         yAL3cwEk55CwrG8PEI9j/z8HN081keoUcALcTLb1/aJ2WpcfrioSb2cvQQRKIvC7dPEB
         vBsw==
X-Forwarded-Encrypted: i=1; AJvYcCVBdnipRD88IcRIDizej0ojQBJ04vd8UGrORderFsTu2e/OcUCGVDhTjJ89KH8J60naTeIVUWwfTLhz4fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySl+jd7hU5Vfe2PZDLuBeuPdcoC/aQQ2Ld6oKKmMKQAfaQOKlB
	rNWQiJPgeDwDNza6tqmOX3OiyXTFqYMWbrPX7QKrvEagLovkyobJej14Zj9oNpQ=
X-Google-Smtp-Source: AGHT+IHlbkjw8a7bvilTCBFaOO4QOtqabhsHfCRItFwBH0Lw5ptxMTSReldhXJVwYLzLi/jmMdBLXQ==
X-Received: by 2002:a05:600c:4e41:b0:430:54a4:5ad7 with SMTP id 5b1f17b1804b1-4318c6e895bmr9695095e9.1.1729757844786;
        Thu, 24 Oct 2024 01:17:24 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93d53sm10828922f8f.70.2024.10.24.01.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:17:23 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 10:16:57 +0200
Subject: [PATCH v3 2/4] iio: adc: ad7380: fix oversampling formula
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-ad7380-add-adaq4380-4-support-v3-2-6a29bd0f79da@baylibre.com>
References: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
In-Reply-To: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
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



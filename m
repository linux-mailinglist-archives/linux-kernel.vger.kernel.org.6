Return-Path: <linux-kernel+bounces-448088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7789F3AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942F47A4E32
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105B1D5141;
	Mon, 16 Dec 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IiMequnD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9091D4339
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381472; cv=none; b=F984SBNuGpF6vZwWvkvvwC+YN1dEyf3ooItrsWvL/Pqo83htZ1HAUFYPrT1Q4AxNNfc/iQgMOIUz5ly3ELzewOkuSp0nlUNyVhwQy8o+kqfifMVyuPLx0EMKPFDPQO25QIv1PNAsjdoM/2t2L1bbmVq6TJR8st5QQYF4E1VOTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381472; c=relaxed/simple;
	bh=fsCWVBl2aaJ7Rw7TFN9KYd/ZIN1YNZzpw8t5WXO3NGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3WYHnBh6KUcmfkrT1wv3AZXBsh4WuZJOh4Qq5panVoFdSYRoLNM3wMRjHOGau2AOEz0dWUBMZFnNkQA8nmNBFakKs8Z4h8bVqnQ6Hux1ySXnj0zlMLMxt4CLHcsXDHikGFn6cofutklZGfQOb+nJ0jkqjD4FVX6ytpYww1Fhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IiMequnD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso3963683f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381468; x=1734986268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Juh7h407eRDEHSWqSLRr8xowgcij3T6Bt7sPrV5Jtk=;
        b=IiMequnD7pl62k68OeT9RaoqU2XQvDhmO8vDZChxM5GZJfX9T6Ujkngx8KHgPr1bPG
         /ZVHSXytdhshsNnJH9HcT5p+4h75ahnA6OtRjD4c9TbOffVhZ9pC9xiSvBY2/BezwzAW
         5XBxjexeAnGXaljlrNERDsmsf+6Ba109Uy3DYsvvoZ5QTkCqdR6eeeiAb5ANIFUyl14U
         omeldgyBHiFtgn2kKWkl4dykdh49xveUj/8KsTIPBdKl5leMBUKWD9LRzA8hx3yTRiQk
         xHMpTUHzXE7cl32pPzMuyXjg27Zt67gWqLg4Xxnd8kz6abxNKgHBMKfflKTh+resylvq
         K6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381468; x=1734986268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Juh7h407eRDEHSWqSLRr8xowgcij3T6Bt7sPrV5Jtk=;
        b=GuPxCeh7JqqKEIjavSqXsUpC/aznUVR6ERL1hPSPL67OipgntqP896yi8OfT0YypUL
         cGM2Bpij8Y/hwpXB/6CK6H9cHSlvGK3kVR5ASDEbslGNZbFV1mGtz9+9JyHfVWWwds1B
         5F2WbHcqe667a8kNxVeq4Srxz3AWkfTHGRgICNRrY1ybDEKCpf1vWTNfe9dOGV9GyoGS
         R1f67LJKu8iRJO09F0hsYsnzzefK+4pY2NUJQ1mXnpAPmA3W0FjMtm6lmVkIpjAz2N4+
         vf/rhwkE3h1e8EV5JNivT11V0flBdhhCoe46CJ9JrBLmPZN/qLlUpc0jea6HBkWoa1MM
         tEkg==
X-Forwarded-Encrypted: i=1; AJvYcCV5wW0E+3bw/WAoGuUadkM73JRJ5ZgjHP8tzSDmCgTuHFz4uzcV0r+EaIW6qZ59urv1YNStkfCL7dG7y9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3e+EB4tPSuK76k/j1kJ9tOJVrNkQZIImDNgcBH3gOTFpaW6Ni
	0PGDZwjP5SW3H0cAYPly5fg+kfmF7+OX7IIj2ZXsXltx8aRrd9bTdu1grF5rcZg=
X-Gm-Gg: ASbGncvNdSCbF372dO9u5YnHKqJsR7X6xgHv7tvLdwrf/kJRKiuFOohQ6WChF7jURB6
	s43sYzR1JNgwPhrKSSOWNy21dIsVe0onCjWHyS4Rxfm7SxpFK/RqkbhCA8OSG4ntpiTzbIv5s+4
	1YG28cvM0smsWnsEBrNy353hR4U7/8aTvB6Io185meW+lx6GIzvog0vaLJ3JdlHb6ZdrmeILcrJ
	bV81Vc5OTQ0KKKw0bybDd5IU4m8/tgVOIuE8L+TjS/jXk4LKCPBMx91uip8MoIqDuA8eTVEzMdV
	Mo/BcGGvLlhO1kfEhBcV11fjQcLPOQwI6w==
X-Google-Smtp-Source: AGHT+IEkpFkOfoc5PKARgk1ZNgu9iMGY03qwc/Xhq8eCKvrej8r9r0RlEFs9qPq/7HEytl7RqDu/4w==
X-Received: by 2002:a5d:64e9:0:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-3888e0b8761mr11510312f8f.46.1734381468461;
        Mon, 16 Dec 2024 12:37:48 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:47 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:21 +0100
Subject: [PATCH 1/8] iio: dac: ad3552r-common: fix ad3541/2r ranges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
rev. C, table 38 (page 57).

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-common.c | 5 ++---
 drivers/iio/dac/ad3552r.h        | 8 +++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index 0f495df2e5ce..03e0864f5084 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -22,11 +22,10 @@ EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, "IIO_AD3552R");
 
 const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
 	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
-	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= { 0, 3000 },
 	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
 	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
-	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 },
-	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 }
+	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 }
 };
 EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, "IIO_AD3552R");
 
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index fd5a3dfd1d1c..4b5581039ae9 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -131,7 +131,7 @@
 #define AD3552R_CH1_ACTIVE				BIT(1)
 
 #define AD3552R_MAX_RANGES	5
-#define AD3542R_MAX_RANGES	6
+#define AD3542R_MAX_RANGES	5
 #define AD3552R_QUAD_SPI	2
 
 extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
@@ -189,16 +189,14 @@ enum ad3552r_ch_vref_select {
 enum ad3542r_ch_output_range {
 	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
 	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__3V,
 	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__5V,
 	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
+	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 };
 
 enum ad3552r_ch_output_range {

-- 
2.47.0



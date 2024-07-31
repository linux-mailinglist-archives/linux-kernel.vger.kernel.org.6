Return-Path: <linux-kernel+bounces-268659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632E942774
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19B128444D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDCD1A7215;
	Wed, 31 Jul 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uxrpKHHN"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AF1A4B39
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409556; cv=none; b=gy70gAXmHULhVm8j5JLZ9YJbwHWJcTpduffrzW64Fm1SAgP3+ZTWO+00u8Ua+KZDqH1aG/p01198VwUWhP4O82VccQ6daBXw2rOIcGgIMeMlz5KEvkTfEdip2Bhk7pEA6GbpVgpukkh+gP4rZVeUmNHEPaNl2QTgD+44epAOjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409556; c=relaxed/simple;
	bh=9dGPkiTFYDkEvhn/NqjG5/RctGzuW49L9Sh3Gg5iz5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=muCs6nOepaxKFPHywbcKGaegnOr7K61VKhfuWuLIkiTwkwT/MrZwt3fR8ekARGiIlE1ROgyXvr8egq2Yg2/cv1LqTDnyHo5h1tH50JNdpOd7LqNuW+ccwFtI8T+a9uIlcBSHe/gz0itWdiwtS6997lY3ZtuegOw03vwGf6hWh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uxrpKHHN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso35143405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722409553; x=1723014353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8DToPXnh1aWxX7ybAN+wh21IynsQgrWjhcqvmXDduw=;
        b=uxrpKHHNCklnT9o7EqJWH+cFAYMFeCqj5JPNdUqHn5BI5aDUg5rAXzPEykxPoBaQvd
         eyWghem1iyb37QTjjEOWwg90OSjoOfjkrMdZ42bP4gBUjic+T2FnmZC+KvoLVwhtL3gE
         q2o2x4AGjhBp5Js0umVUsXWDJvt7wLhwcgVkvJ6VmVJGSQH0rYpIWdPeollDRV3Fzagr
         wtI3fVHxvbwgSPClO7m6DyW9Zyul3cjMtgovuCevQ+vzSV4qhpfv9oYMzaS0ME9toHcB
         fz6Kj/LBX+in8sk8CbAdfGtoeYfLIDm6Tw9zH4tHhWjCXNcqK9kEp7wi45WwGgbOkw+W
         iR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409553; x=1723014353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8DToPXnh1aWxX7ybAN+wh21IynsQgrWjhcqvmXDduw=;
        b=QPMI2pUn1X0TpdQbFU3XGGmTVYKsn1QcGX13Kfkr1ec0RsuQOu1FvNn+sSmLcN5oRU
         +cPDNz4e+8BKySuVnlgzkc3md9OCvKlIiWqxNiLSYIhZNDv5yLusBIxo4JQwu0u/c02k
         QKLM7s/LiV8W5OoqHNOax/ZL09zKlVtSoaK/8FBhHEG1Sxp/yj/lDwsNkvtEHYg3vHLj
         bv1twsfBEUHfkd1VHLvGtG0Omd81R5Ww2eKAlUQzJqN7XArz6bosxMODLByD+TpFU/XZ
         el64cV5rfRLHUTea61HQBYhJxlc6YgB+Z42Cn3QnItJxotP77B6maI0AKcXkJLxD7tDX
         tdVA==
X-Forwarded-Encrypted: i=1; AJvYcCVnVhVK936biAiyADMlwLV2nzJC23ARFwCvxVeZpH60uaPu0g+wBnlsUJixIKoOc1aI2nFIPhKoUbeXgMFrzaPp7p2ziv7+4N439JNV
X-Gm-Message-State: AOJu0YyTTJgY36CXgR2Kw5e9N6Xk09l00lo+4wSI2YV7zGv4eLlj55vK
	7fLXNyugX3l4soTuIlJVaH4l8YaeuBCf1I1BzDE3osZB5JHqSWDrnA5qfdrBPb0=
X-Google-Smtp-Source: AGHT+IH1GAfFv5sNgUZ04+uyD4pq8HEHaz/JsKPmRVMY/Gl2o8hakRh/+nIMT5w9mIRlMBI4xcfXFg==
X-Received: by 2002:a05:600c:4ec9:b0:426:58cb:8ca3 with SMTP id 5b1f17b1804b1-42811d9eda7mr92210285e9.21.1722409553116;
        Wed, 31 Jul 2024 00:05:53 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2593sm9953215e9.4.2024.07.31.00.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:05:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 31 Jul 2024 09:05:45 +0200
Subject: [PATCH v2 4/7] iio: adc: ad7380: prepare driver for single-ended
 parts support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7380-add-single-ended-chips-v2-4-cd63bf05744c@baylibre.com>
References: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
In-Reply-To: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

ad738x family contains single-ended parts that have a 2:1 mux in front
of ADC, so the number of IIO channels is different from the number of
simultaneous channels that can be sampled.

To prepare the support for single-ended parts, introduce a new
num_simultaneous_channels variable. For currently supported parts,
num_simultaneous_channels is equal to num_channels minus 1 (the
timestamps channel)

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 72fece383f72..04cc1ef18131 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -80,6 +80,7 @@ struct ad7380_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	unsigned int num_simult_channels;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -208,6 +209,7 @@ static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
 	.num_channels = ARRAY_SIZE(ad7380_channels),
+	.num_simult_channels = 2,
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -216,6 +218,7 @@ static const struct ad7380_chip_info ad7381_chip_info = {
 	.name = "ad7381",
 	.channels = ad7381_channels,
 	.num_channels = ARRAY_SIZE(ad7381_channels),
+	.num_simult_channels = 2,
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -224,6 +227,7 @@ static const struct ad7380_chip_info ad7383_chip_info = {
 	.name = "ad7383",
 	.channels = ad7383_channels,
 	.num_channels = ARRAY_SIZE(ad7383_channels),
+	.num_simult_channels = 2,
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -234,6 +238,7 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.name = "ad7384",
 	.channels = ad7384_channels,
 	.num_channels = ARRAY_SIZE(ad7384_channels),
+	.num_simult_channels = 2,
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -244,6 +249,7 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.name = "ad7380-4",
 	.channels = ad7380_4_channels,
 	.num_channels = ARRAY_SIZE(ad7380_4_channels),
+	.num_simult_channels = 4,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -252,6 +258,7 @@ static const struct ad7380_chip_info ad7381_4_chip_info = {
 	.name = "ad7381-4",
 	.channels = ad7381_4_channels,
 	.num_channels = ARRAY_SIZE(ad7381_4_channels),
+	.num_simult_channels = 4,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -260,6 +267,7 @@ static const struct ad7380_chip_info ad7383_4_chip_info = {
 	.name = "ad7383-4",
 	.channels = ad7383_4_channels,
 	.num_channels = ARRAY_SIZE(ad7383_4_channels),
+	.num_simult_channels = 4,
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -270,6 +278,7 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
 	.name = "ad7384-4",
 	.channels = ad7384_4_channels,
 	.num_channels = ARRAY_SIZE(ad7384_4_channels),
+	.num_simult_channels = 4,
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -407,7 +416,7 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 	 */
 	st->xfer[1].bits_per_word = scan_type->realbits;
 	st->xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
-			  (st->chip_info->num_channels - 1);
+			  st->chip_info->num_simult_channels;
 }
 
 static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)

-- 
2.45.1



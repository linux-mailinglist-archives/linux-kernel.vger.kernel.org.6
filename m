Return-Path: <linux-kernel+bounces-439386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69EA9EAE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B75287B32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5649722E9F4;
	Tue, 10 Dec 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="andx9GKd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F847226523
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827615; cv=none; b=RYqtw6TjjcW3Q37mlKGGyJmHSCWqTYkVgvlhiRzel93Yfo+2RH23v2QcdobgEStMhUK2U2vWyvd4p+oaLyx9q4q3/hNK0qz5tqS+VURufCnLq8U/0Zu1CMr6RTrNe76hvYnjLLa9ZuRS9A5jazyJSIiV9MiV3Dabcg1xp51/a00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827615; c=relaxed/simple;
	bh=q8L+/X8mQMclZDxDMNMoohPiMsPmm9wiBCl25kpj+IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJyLluksPz0LUlWw5KrNr7RFtlyzC9g4sVeuUjTwLdI2xI6bkZN/MoNGXOaKlAbwMCk6LC8hWQS1x/5LlvobZR/40a0E6SvncjmZaEFprbbIBsvtUbPyaU13epTPwH2fTGEQvqFioOVpdw9L+haT86ISfWO/ko/mEck5vhympho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=andx9GKd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a736518eso59267525e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827611; x=1734432411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXPVN+H7vvYMLNQs3gMlC+noWJOkuHAbBtVwrLjbmHI=;
        b=andx9GKd0Ek48YVvpXcfJueL+UcPkEznFG9XVYgPDoFtP3FjEYd5uWK9ikKWMaiBzq
         PCQIqv5GC31ZmNuljWUqvtfGe6hfnTaExoktOpWyU5eCKc7j/Ny4oiAuHCHA0lsSbEHG
         38UzT6Lp9k5pyRKyC0/1prOzif5iYFYyIOGEoR6E1SqUaQvyWXT2Fb1ElFDBafivBnNe
         T8yVBuDbe3j/LZeFH13InrooaiRUpug/Rpxv0px3oN2GAiAXGoqy3mP0YTtbg8w+155k
         8kIKudIqYd2Nmxan1TU4cCoXi5gvhb4yKxbzgiGctbCjgY97tNgwU5nPFroIsriu8bJi
         56sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827611; x=1734432411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXPVN+H7vvYMLNQs3gMlC+noWJOkuHAbBtVwrLjbmHI=;
        b=T/YlJgBaV44QQfhnlutj/HbA7/smRjq/C6s37YPili2zQmMLlIk0Z26yUWxUMpwj5T
         3J6KN0zkWva+wwFfzDFuMBqBvzPjWlev0rq7I1ieqT+UjdF4A2I0b7iJbEcWEJwf7f8T
         fK5sJc3889tGj1A3QK3hhq+3raL2/N5JwUszcDMmKtjwG5cdZo5RZYESLmtUuN+pb7qG
         LbK03BSuNG+OdCyzluozqzUCyznN8Y6c/a4HDt6342VB2I9j6R8+OI/AAoNNBy/wqB2c
         l1hkefjSlJR/U64QBJUi0K5ivilSWKykGC2b5s+Z08PP1h0UMkQmifaZjEZLA2zdWHBj
         wvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRR/2SKnfaJxyTwCCGr+1X4dp8PIyeGC7wuGfwpyfMRX1A3Uer/QrGA850LvVcOjBc3o8KxOzc9L3edw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyaXlsZNllGkQMAyPsbCEMixK3tqrlkDSQApLW67tu5cU/IlO
	UdOL8VMKmEI4ejZr//hiIXDZ54IZbzDzPmtDlpNSf4wS8NxcJtWM/eO8Jv5dOmw=
X-Gm-Gg: ASbGnctLNRCm+fM2nDaSJEIEG8rWKE9oNxjxHXyrTrcAq2JPaa2nNolys5yf9lLTBXH
	Hu0KFUT7nBp+Xift3zko1XcKewl2daEWF6VZg5GCSmEJi8wUkMiAfK1SlxwXTXhV/F78aBo5Yq1
	LixAYmDI4CAEjY95PtIdBHU6cILDk9+XadzxRsp8k5nEd0UUP9IC9C8NjJStmXHqi+rPZfpk+BF
	Xd0E8jcPCA5lY8W6nubuxmjC0+Z72FsWl6gtT7Fhrr9RWoh07gP4zQFl5ru8twPod+ZNFjZEyhC
	jA==
X-Google-Smtp-Source: AGHT+IEjZNifROqSaH0tgV4tC6R+g7G5eQGgzNCQx1BZaVZ3snqitMBsuRIjjsXOy61Ogp6tgAddnA==
X-Received: by 2002:a05:600c:5114:b0:434:a802:e9a6 with SMTP id 5b1f17b1804b1-434fff30ed9mr39195745e9.7.1733827610857;
        Tue, 10 Dec 2024 02:46:50 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:50 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:48 +0000
Subject: [PATCH v2 8/9] iio: adc: ad7606: Change channel macros parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-8-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=3162;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=q8L+/X8mQMclZDxDMNMoohPiMsPmm9wiBCl25kpj+IE=;
 b=S0PrQp4CIcaxFv3AH+5EAQczxw7xbqwMk5SsilNV/T3/SOiEvKEaXgaZBKeehaiSvRB0PB77n
 B6xClCSvw8FBS84JkOGiRXfg6iHJ/KyRZVVE7mrwobh3jw1bjQdzQg0
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Add the possibility to pass the *_available parameters to the main
macro.
This is a preparation to add the new channels for software mode and
hardware mode in iio backend mode more easily.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.h | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index eca7ea99e24d..ada8065fba4e 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,37 +40,19 @@
 #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
 #define AD7606_OS_MODE			0x08
 
-#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
+#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all,	\
+		mask_sep_avail, mask_all_avail, bits) {		\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
 		.address = num,					\
 		.info_mask_separate = mask_sep,			\
+		.info_mask_separate_available =			\
+			mask_sep_avail,				\
 		.info_mask_shared_by_type = mask_type,		\
 		.info_mask_shared_by_all = mask_all,		\
-		.scan_index = num,				\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = (bits),			\
-			.storagebits = (bits) > 16 ? 32 : 16,	\
-			.endianness = IIO_CPU,			\
-		},						\
-}
-
-#define AD7606_SW_CHANNEL(num, bits) {				\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = num,					\
-		.address = num,					\
-		.info_mask_separate =				\
-			BIT(IIO_CHAN_INFO_RAW) |		\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_separate_available =			\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_shared_by_all =			\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.info_mask_shared_by_all_available =		\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+			mask_all_avail,				\
 		.scan_index = num,				\
 		.scan_type = {					\
 			.sign = 's',				\
@@ -80,14 +62,30 @@
 		},						\
 }
 
+#define AD7606_SW_CHANNEL(num, bits)			\
+	AD760X_CHANNEL(num,				\
+		/* mask separate */			\
+		BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask type */				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		/* mask all */				\
+		0,					\
+		/* mask separate available */		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask all available */		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		bits)
+
 #define AD7605_CHANNEL(num)				\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
-		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
+		BIT(IIO_CHAN_INFO_SCALE), 0, 0, 0, 16)
 
 #define AD7606_CHANNEL(num, bits)			\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
 		BIT(IIO_CHAN_INFO_SCALE),		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		0, 0, bits)
 
 #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
@@ -95,7 +93,8 @@
 	AD760X_CHANNEL(num, 0,				\
 		BIT(IIO_CHAN_INFO_SCALE),		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), 16)
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
+		0, 0, 16)
 
 struct ad7606_state;
 

-- 
2.34.1



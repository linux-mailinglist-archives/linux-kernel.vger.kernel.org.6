Return-Path: <linux-kernel+bounces-192523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E28D1E77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5761F237DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A82F17164A;
	Tue, 28 May 2024 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mmXpWCkw"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200ED170839
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906047; cv=none; b=dYoqkYG0iceo8XUzw/TFXjqbDR0vCMjLyIzHZH1IVmebL2Fi4ZUqXaHytLSXpUDDYs0mWvJJDGiLT0VF+7NOmefOkwkRnlpOJjjCU5HtA7pu3vcmSJZJUY0LYD4bdhAl1PGpXf2SQI0K9m+Svc74Y+0IDt62+i3e6NHKfWLDkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906047; c=relaxed/simple;
	bh=Zzso1sxK6Q/UMw8mWkOfuHFaXKWw5NzczerMMf94Meg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq5CCidlewSvLbWJD1aPA+ruyQ1UA35Lrvbfd9gLfYkfqNKZBskACs+zEvmZr7iuIETnUvn5M5/42Ws1NlJZaPbFeVaNNoFBAf6wE03l5/guOr5ySvyrGc6XmNz2cS+R8zCKbr0jAIgkfNMdwy4Po/NelphFS0FeO0vqVaMVfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mmXpWCkw; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-42108822e3cso23616565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716906043; x=1717510843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKaoQYw7yNqBcZbbeNBd7Up3BviKXiLpwv87L7N/DuE=;
        b=mmXpWCkwckaAuF5+yQbdbs9VoAn5xZt7feFWYTzCi+uUHjQ17EJ01ve7CXY1lpkqkF
         sp5cr+kgcXZ47D5z+HzOxY61d/1lHiiVOTuSvGkX4Wg94u/MY1haG+LP+hDP7EJIpsL6
         8YZqHNXV6GhyX0CQVFMMMNYGztLZgN0LCsVL8+HRQhuAuk5SxZwUjIjMaZLv+CUd0v02
         fDue385iIRMHbZFA0w5J5nhxsIhrmWYA4u1nLOjkw85e3CFfGvxTlOY0UF0k4OcvmHtn
         EInodbUwc9txIV7mam9hPvA/pSEUMB6Tq0927uC88p5K1cx/950rjHszn3IRhPLplCe/
         Dt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906043; x=1717510843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKaoQYw7yNqBcZbbeNBd7Up3BviKXiLpwv87L7N/DuE=;
        b=ISuahZ/NU372bMhw1jNkLVYXvAq9kSRIHxPKCABy7nZGYRHL0blpCIY76nHesRLtuA
         VI+1qQt+Hp0oryVi9dQYyJNcO5PRPZs70FVrJaguyAMfkt91IojaC9tCRmL8mQpzabZE
         wAxMvJCHqESfot3dVB8TOzJzKoAMeX7B+xSMnHXUYZR77WzatLfPso5WewogPzbBP5fL
         O8hLTMkt2vHZtDnziGlmucWYCcaCxh+ndk9RayXkIcXxGmU6qHKBG5a8YMMtAp1pJOpd
         0c/idQ8LQdnJeYuATEC9T/OuNOqbtUtDl321zZ4r/x8CQRbajLI4OwJWz/t4agybk97z
         kyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkAnytLKJVx4UwvdF/lBBfJ5/g90MyF345P2IGUKu3+9KApTdm1qKGgcTcrt7J1r6nECP0wb6D8aTiPOsc7JueEaOfHfSQ6Z42GhXG
X-Gm-Message-State: AOJu0YxY5FvideaSB2QQnv+ccDwCngWtsM3V521h9Ig+kl0fivTw5kJZ
	ef0U0PlQF23k14WKdjttWTVxu5yNuwG7cdLWS5UIwyq+teJ6fKlA5FCW/2JISDrjfA1yYXIjxlW
	ZRI0Wyq7q
X-Google-Smtp-Source: AGHT+IEQX+B45eG3mvmnIMj7QY5BU8cvy92fKruQUXncFnMv/tK/TI5wgfM30c4k5cgHa+jpjJTStg==
X-Received: by 2002:a05:6000:1942:b0:358:d9d4:1026 with SMTP id ffacd0b85a97d-358d9d411a5mr6053075f8f.17.1716906043624;
        Tue, 28 May 2024 07:20:43 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db5esm11999275f8f.15.2024.05.28.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:20:43 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 May 2024 16:20:34 +0200
Subject: [PATCH v7 7/7] iio: adc: ad7380: add support for ad738x-4 4
 channels variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-adding-new-ad738x-driver-v7-7-4cd70a4c12c8@baylibre.com>
References: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
In-Reply-To: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

Add support for ad7380/1/2/3-4 parts which are 4 channels
variants from ad7380/1/2/3

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 790d08c90ad0..6b0b1b0be363 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -8,6 +8,9 @@
  * Datasheets of supported parts:
  * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
  * ad7383/4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-7384.pdf
+ * ad7380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7380-4.pdf
+ * ad7381-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7381-4.pdf
+ * ad7383/4-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-4-ad7384-4.pdf
  */
 
 #include <linux/bitfield.h>
@@ -27,7 +30,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define MAX_NUM_CHANNELS		2
+#define MAX_NUM_CHANNELS		4
 /* 2.5V internal reference voltage */
 #define AD7380_INTERNAL_REF_MV		2500
 
@@ -104,27 +107,53 @@ static const struct iio_chan_spec name[] = {		\
 	IIO_CHAN_SOFT_TIMESTAMP(2),			\
 }
 
+#define DEFINE_AD7380_4_CHANNEL(name, bits, diff)	\
+static const struct iio_chan_spec name[] = {		\
+	AD7380_CHANNEL(0, bits, diff),			\
+	AD7380_CHANNEL(1, bits, diff),			\
+	AD7380_CHANNEL(2, bits, diff),			\
+	AD7380_CHANNEL(3, bits, diff),			\
+	IIO_CHAN_SOFT_TIMESTAMP(4),			\
+}
+
 /* fully differential */
 DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1);
 DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1);
+DEFINE_AD7380_4_CHANNEL(ad7380_4_channels, 16, 1);
+DEFINE_AD7380_4_CHANNEL(ad7381_4_channels, 14, 1);
 /* pseudo differential */
 DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0);
 DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0);
+DEFINE_AD7380_4_CHANNEL(ad7383_4_channels, 16, 0);
+DEFINE_AD7380_4_CHANNEL(ad7384_4_channels, 14, 0);
 
 static const char * const ad7380_2_channel_vcm_supplies[] = {
 	"aina", "ainb",
 };
 
+static const char * const ad7380_4_channel_vcm_supplies[] = {
+	"aina", "ainb", "ainc", "aind",
+};
+
 /* Since this is simultaneous sampling, we don't allow individual channels. */
 static const unsigned long ad7380_2_channel_scan_masks[] = {
 	GENMASK(1, 0),
 	0
 };
 
+static const unsigned long ad7380_4_channel_scan_masks[] = {
+	GENMASK(3, 0),
+	0
+};
+
 static const struct ad7380_timing_specs ad7380_timing = {
 	.t_csh_ns = 10,
 };
 
+static const struct ad7380_timing_specs ad7380_4_timing = {
+	.t_csh_ns = 20,
+};
+
 static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
@@ -161,6 +190,42 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.timing_specs = &ad7380_timing,
 };
 
+static const struct ad7380_chip_info ad7380_4_chip_info = {
+	.name = "ad7380-4",
+	.channels = ad7380_4_channels,
+	.num_channels = ARRAY_SIZE(ad7380_4_channels),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7381_4_chip_info = {
+	.name = "ad7381-4",
+	.channels = ad7381_4_channels,
+	.num_channels = ARRAY_SIZE(ad7381_4_channels),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7383_4_chip_info = {
+	.name = "ad7383-4",
+	.channels = ad7383_4_channels,
+	.num_channels = ARRAY_SIZE(ad7383_4_channels),
+	.vcm_supplies = ad7380_4_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7384_4_chip_info = {
+	.name = "ad7384-4",
+	.channels = ad7384_4_channels,
+	.num_channels = ARRAY_SIZE(ad7384_4_channels),
+	.vcm_supplies = ad7380_4_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
+	.available_scan_masks = ad7380_4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
@@ -172,7 +237,7 @@ struct ad7380_state {
 	 * transfer buffers to live in their own cache lines.
 	 * Make the buffer large enough for MAX_NUM_CHANNELS 16-bit samples and one 64-bit
 	 * aligned 64 bit timestamp.
-	 * As MAX_NUM_CHANNELS is 2 the layout of the structure is the same for all parts
+	 * As MAX_NUM_CHANNELS is 4 the layout of the structure is the same for all parts
 	 */
 	struct {
 		u16 raw[MAX_NUM_CHANNELS];
@@ -512,6 +577,10 @@ static const struct of_device_id ad7380_of_match_table[] = {
 	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
 	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
 	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
+	{ .compatible = "adi,ad7380-4", .data = &ad7380_4_chip_info },
+	{ .compatible = "adi,ad7381-4", .data = &ad7381_4_chip_info },
+	{ .compatible = "adi,ad7383-4", .data = &ad7383_4_chip_info },
+	{ .compatible = "adi,ad7384-4", .data = &ad7384_4_chip_info },
 	{ }
 };
 
@@ -520,6 +589,10 @@ static const struct spi_device_id ad7380_id_table[] = {
 	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
 	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
 	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
+	{ "ad7380-4", (kernel_ulong_t)&ad7380_4_chip_info },
+	{ "ad7381-4", (kernel_ulong_t)&ad7381_4_chip_info },
+	{ "ad7383-4", (kernel_ulong_t)&ad7383_4_chip_info },
+	{ "ad7384-4", (kernel_ulong_t)&ad7384_4_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7380_id_table);

-- 
2.44.0



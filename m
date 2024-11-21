Return-Path: <linux-kernel+bounces-416814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8339D4AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CEB1F227C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034601D359A;
	Thu, 21 Nov 2024 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WgKRltHE"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC11D0488
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184313; cv=none; b=YJvXKHLtIuHiYxQ2x3sWjwtU5ZuVG20rmJU6s6VGXkIPkTuRCUc3xng4yg+ePniww8tWTBVWGU36K5oYzZp0y9ZwI4/SPd53i8s1VNhl6y9UsDBtadgBJCAIeMjKQxRCEn9Ul3Eg9JY6WkF7ff5TEAQkAkf3i3gWNqZOw7pfwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184313; c=relaxed/simple;
	bh=I8peenOs3+A/hxXv5G48baZvl1ThPxqQ6j9EI+NJj2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIDPjU9385i1KbPxn0Y80Z0VkW1qrtCumw1PGF2HiYHRythgRZfOb0E2SUhibaEk5IFy2Azj6gPYPhEZ+OXFciaFWsEZMLn6q2kGWAJQXrECKT7LCeUSmQC5rqSmxLJf0J8IIsZP8tklFIP+bYaDEaEOOmQII8h8sj5lwYgRSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WgKRltHE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38241435528so445070f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732184309; x=1732789109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz/Jf9i+qzqUD9OC/Im10oe3TDhR8/H6yb+9VnZPKzE=;
        b=WgKRltHEWFZzL0bx0LJu1V0gXS30wZrWVlNtOeBqZMZLAGjrOb1IZgV0zJwcoXUVju
         dAZSqp+JEiPaqpv+8jfvUkObcoFHZENR3S/QuvG+zUNA+XiBgSprVrl9bJlwc2h5AExH
         OCmeO6C5tTY9OYJSUWukvsmIPAplzassvkw+potY4pejiBpy2JxZFAR8s9nrO6H3qY7H
         iw9zLkEhn2r2dsgLCBCuqKOmI9BH1uh73jS50HHr1N90IvmwXOgUGMFzeutZBTgdVXhl
         0ITMrj1846wCJkhItmeZeoOtnL1tY/ezlXCrU7VLOEDr7BBUDeCty+/Fg8YzT5mXpAx5
         jmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184309; x=1732789109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz/Jf9i+qzqUD9OC/Im10oe3TDhR8/H6yb+9VnZPKzE=;
        b=YBqhQ0JoG3JT6B0B11N9j2ZKMl0/JC9G1mWRrJzHMHaS2YE5R3ADcL3/mwpr0JyJ9S
         W8uQTExHsIp9kkqBYGXWJbv4fAM3auq+iY8GlEzVYU7XSJD/MA2Z65YjA9Iw4Rb/wiJU
         9mQxKG4fuL5aKNG70nIQ8FxSfglpBP5CMj18ErGm7rr6Wy9zCv0kQwzmotAsIkykYNZZ
         TtuAiSDW2a4365zvOwzSeb8KgSqrAg9JdTZhfEu19uMwAAZ7jfY3mQxa+JGIK5qR7sKQ
         CkFvb3hIOGQFTIKYcugdYMqNtL8TFRED38BesLCxLtyVejbczm9ZsSGxJYvmBfDRDCKV
         qQKg==
X-Forwarded-Encrypted: i=1; AJvYcCVHLJjTYOkW/8ilOB2zKR44h6rjl8v1o4pudoGjAkPh4z/sHO+crcjhP0k2ZqeuRQzdvictyprTLU3KySY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3IPLCiqI9nQxaUKZAjiZ6nZS57D3wYZ/DzOCPJVDdHXVbLcoZ
	Uk5l1Va+jZ1J5c2WRU10ep7BkdEsOYxZt/PWDHWAfbIUiAL7psyvpcYLX2jvjdVXwyo/rBeSAtU
	e
X-Google-Smtp-Source: AGHT+IHvbGiqlY44oV0CUFj3hcN2B71NTiYyCb/kFKisZV54NpUo924WC5nKdleVOIKzbj0eakjlaQ==
X-Received: by 2002:a5d:5887:0:b0:382:4fd6:405e with SMTP id ffacd0b85a97d-38254afa8ecmr4335021f8f.29.1732184308998;
        Thu, 21 Nov 2024 02:18:28 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm4598065f8f.47.2024.11.21.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:18:28 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 21 Nov 2024 10:18:26 +0000
Subject: [PATCH 4/9] iio: adc: ad7606: Move software functions into common
 file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ad7606_add_iio_backend_software_mode-v1-4-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732184304; l=16090;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=I8peenOs3+A/hxXv5G48baZvl1ThPxqQ6j9EI+NJj2E=;
 b=ZvRMuVy7dIP52Oc7B/thhWU1XD1WhIMjG9F84n7a2YWhrYH4zg7yH61P4yhKkm2Gbdhc9MKKW
 Nrt+W7yu2AEDjvV+8mlbMRKoX7vWfZtHIlfGRlLVjfj9ghCqsrCsX2P
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Since the register are always the same, whatever bus is used, moving the
software functions into the main file avoids the code to be duplicated
in both SPI and parallel version of the driver.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 128 ++++++++++++++++++++++++++++++++++++++++--
 drivers/iio/adc/ad7606.h     |  37 ++++++++++--
 drivers/iio/adc/ad7606_spi.c | 131 +------------------------------------------
 3 files changed, 156 insertions(+), 140 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 828603ed18f6..df0e49bc4bdb 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -85,6 +85,10 @@ static const unsigned int ad7606_oversampling_avail[7] = {
 	1, 2, 4, 8, 16, 32, 64,
 };
 
+static const unsigned int ad7606B_oversampling_avail[9] = {
+	1, 2, 4, 8, 16, 32, 64, 128, 256
+};
+
 static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
@@ -187,6 +191,8 @@ static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
+static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
+static int ad7606B_sw_mode_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.channels = ad7605_channels,
@@ -239,6 +245,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+	.sw_setup_cb = ad7606B_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, IIO_AD7606);
 
@@ -250,6 +257,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
+	.sw_setup_cb = ad7606B_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, IIO_AD7606);
 
@@ -294,6 +302,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
+	.sw_setup_cb = ad7606B_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, IIO_AD7606);
 
@@ -307,6 +316,7 @@ const struct ad7606_chip_info ad7616_info = {
 	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
 	.os_req_reset = true,
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+	.sw_setup_cb = ad7616_sw_mode_setup,
 };
 EXPORT_SYMBOL_NS_GPL(ad7616_info, IIO_AD7606);
 
@@ -1138,16 +1148,122 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
+static int ad7606_write_mask(struct ad7606_state *st,
+			     unsigned int addr,
+			     unsigned long mask,
+			     unsigned int val)
+{
+	int readval;
+
+	readval = st->bops->reg_read(st, addr);
+	if (readval < 0)
+		return readval;
+
+	readval &= ~mask;
+	readval |= val;
+
+	return st->bops->reg_write(st, addr, readval);
+}
+
+static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int ch_addr, mode, ch_index;
 
-	st->sw_mode_en = st->bops->sw_mode_config &&
-			 device_property_present(st->dev, "adi,sw-mode");
-	if (!st->sw_mode_en)
-		return 0;
+	/*
+	 * Ad7616 has 16 channels divided in group A and group B.
+	 * The range of channels from A are stored in registers with address 4
+	 * while channels from B are stored in register with address 6.
+	 * The last bit from channels determines if it is from group A or B
+	 * because the order of channels in iio is 0A, 0B, 1A, 1B...
+	 */
+	ch_index = ch >> 1;
+
+	ch_addr = AD7616_RANGE_CH_ADDR(ch_index);
+
+	if ((ch & 0x1) == 0) /* channel A */
+		ch_addr += AD7616_RANGE_CH_A_ADDR_OFF;
+	else	/* channel B */
+		ch_addr += AD7616_RANGE_CH_B_ADDR_OFF;
+
+	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
+	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
+
+	return ad7606_write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
+				     mode);
+}
+
+static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+				     AD7616_OS_MASK, val << 2);
+}
+
+static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_write_mask(st,
+				     AD7606_RANGE_CH_ADDR(ch),
+				     AD7606_RANGE_CH_MSK(ch),
+				     AD7606_RANGE_CH_MODE(ch, val));
+}
+
+static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return st->bops->reg_write(st, AD7606_OS_MODE, val);
+}
+
+static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * Scale can be configured individually for each channel
+	 * in software mode.
+	 */
+
+	st->write_scale = ad7616_write_scale_sw;
+	st->write_os = &ad7616_write_os_sw;
+
+	ret = st->bops->sw_mode_config(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Activate Burst mode and SEQEN MODE */
+	return ad7606_write_mask(st,
+			      AD7616_CONFIGURATION_REGISTER,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
+}
+
+static int ad7606B_sw_mode_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	DECLARE_BITMAP(os, 3);
+
+	bitmap_fill(os, 3);
+	/*
+	 * Software mode is enabled when all three oversampling
+	 * pins are set to high. If oversampling gpios are defined
+	 * in the device tree, then they need to be set to high,
+	 * otherwise, they must be hardwired to VDD
+	 */
+	if (st->gpio_os) {
+		gpiod_set_array_value(st->gpio_os->ndescs,
+				      st->gpio_os->desc, st->gpio_os->info, os);
+	}
+	/* OS of 128 and 256 are available only in software mode */
+	st->oversampling_avail = ad7606B_oversampling_avail;
+	st->num_os_ratios = ARRAY_SIZE(ad7606B_oversampling_avail);
 
-	indio_dev->info = &ad7606_info_sw_mode;
+	st->write_scale = ad7606_write_scale_sw;
+	st->write_os = &ad7606_write_os_sw;
 
 	return st->bops->sw_mode_config(indio_dev);
 }
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 8778ffe515b3..7a044b499cfe 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -10,6 +10,36 @@
 
 #define AD760X_MAX_CHANNELS	16
 
+#define AD7616_CONFIGURATION_REGISTER	0x02
+#define AD7616_OS_MASK			GENMASK(4, 2)
+#define AD7616_BURST_MODE		BIT(6)
+#define AD7616_SEQEN_MODE		BIT(5)
+#define AD7616_RANGE_CH_A_ADDR_OFF	0x04
+#define AD7616_RANGE_CH_B_ADDR_OFF	0x06
+/*
+ * Range of channels from a group are stored in 2 registers.
+ * 0, 1, 2, 3 in a register followed by 4, 5, 6, 7 in second register.
+ * For channels from second group(8-15) the order is the same, only with
+ * an offset of 2 for register address.
+ */
+#define AD7616_RANGE_CH_ADDR(ch)	((ch) >> 2)
+/* The range of the channel is stored in 2 bits */
+#define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
+#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
+
+#define AD7606_CONFIGURATION_REGISTER	0x02
+#define AD7606_SINGLE_DOUT		0x00
+
+/*
+ * Range for AD7606B channels are stored in registers starting with address 0x3.
+ * Each register stores range for 2 channels(4 bits per channel).
+ */
+#define AD7606_RANGE_CH_MSK(ch)		(GENMASK(3, 0) << (4 * ((ch) & 0x1)))
+#define AD7606_RANGE_CH_MODE(ch, mode)	\
+	((GENMASK(3, 0) & (mode)) << (4 * ((ch) & 0x1)))
+#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
+#define AD7606_OS_MODE			0x08
+
 #define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -71,6 +101,7 @@ struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan, int ch);
+typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**
  * struct ad7606_chip_info - chip specific information
@@ -80,6 +111,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
  * @num_channels:	number of channels
  * @num_adc_channels	the number of channels the ADC actually inputs.
  * @scale_setup_cb:	callback to setup the scales for each channel
+ * @sw_setup_cb:	callback to setup the software mode if available.
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
@@ -94,6 +126,7 @@ struct ad7606_chip_info {
 	unsigned int			num_adc_channels;
 	unsigned int			num_channels;
 	ad7606_scale_setup_cb_t		scale_setup_cb;
+	ad7606_sw_setup_cb_t		sw_setup_cb;
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
@@ -206,10 +239,6 @@ struct ad7606_bus_ops {
 	int (*reg_write)(struct ad7606_state *st,
 				unsigned int addr,
 				unsigned int val);
-	int (*write_mask)(struct ad7606_state *st,
-				 unsigned int addr,
-				 unsigned long mask,
-				 unsigned int val);
 	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 0662300cde8d..640e36092662 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -15,36 +15,6 @@
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
 
-#define AD7616_CONFIGURATION_REGISTER	0x02
-#define AD7616_OS_MASK			GENMASK(4, 2)
-#define AD7616_BURST_MODE		BIT(6)
-#define AD7616_SEQEN_MODE		BIT(5)
-#define AD7616_RANGE_CH_A_ADDR_OFF	0x04
-#define AD7616_RANGE_CH_B_ADDR_OFF	0x06
-/*
- * Range of channels from a group are stored in 2 registers.
- * 0, 1, 2, 3 in a register followed by 4, 5, 6, 7 in second register.
- * For channels from second group(8-15) the order is the same, only with
- * an offset of 2 for register address.
- */
-#define AD7616_RANGE_CH_ADDR(ch)	((ch) >> 2)
-/* The range of the channel is stored in 2 bits */
-#define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
-#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
-
-#define AD7606_CONFIGURATION_REGISTER	0x02
-#define AD7606_SINGLE_DOUT		0x00
-
-/*
- * Range for AD7606B channels are stored in registers starting with address 0x3.
- * Each register stores range for 2 channels(4 bits per channel).
- */
-#define AD7606_RANGE_CH_MSK(ch)		(GENMASK(3, 0) << (4 * ((ch) & 0x1)))
-#define AD7606_RANGE_CH_MODE(ch, mode)	\
-	((GENMASK(3, 0) & mode) << (4 * ((ch) & 0x1)))
-#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
-#define AD7606_OS_MODE			0x08
-
 static const struct iio_chan_spec ad7616_sw_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(16),
 	AD7616_CHANNEL(0),
@@ -194,76 +164,6 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
 }
 
-static int ad7606_spi_write_mask(struct ad7606_state *st,
-				 unsigned int addr,
-				 unsigned long mask,
-				 unsigned int val)
-{
-	int readval;
-
-	readval = st->bops->reg_read(st, addr);
-	if (readval < 0)
-		return readval;
-
-	readval &= ~mask;
-	readval |= val;
-
-	return st->bops->reg_write(st, addr, readval);
-}
-
-static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int ch_addr, mode, ch_index;
-
-
-	/*
-	 * Ad7616 has 16 channels divided in group A and group B.
-	 * The range of channels from A are stored in registers with address 4
-	 * while channels from B are stored in register with address 6.
-	 * The last bit from channels determines if it is from group A or B
-	 * because the order of channels in iio is 0A, 0B, 1A, 1B...
-	 */
-	ch_index = ch >> 1;
-
-	ch_addr = AD7616_RANGE_CH_ADDR(ch_index);
-
-	if ((ch & 0x1) == 0) /* channel A */
-		ch_addr += AD7616_RANGE_CH_A_ADDR_OFF;
-	else	/* channel B */
-		ch_addr += AD7616_RANGE_CH_B_ADDR_OFF;
-
-	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
-	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
-	return st->bops->write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
-				     mode);
-}
-
-static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return st->bops->write_mask(st, AD7616_CONFIGURATION_REGISTER,
-				     AD7616_OS_MASK, val << 2);
-}
-
-static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return ad7606_spi_write_mask(st,
-				     AD7606_RANGE_CH_ADDR(ch),
-				     AD7606_RANGE_CH_MSK(ch),
-				     AD7606_RANGE_CH_MODE(ch, val));
-}
-
-static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return ad7606_spi_reg_write(st, AD7606_OS_MODE, val);
-}
-
 static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -274,38 +174,12 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 	 */
 	indio_dev->channels = ad7616_sw_channels;
 
-	st->write_scale = ad7616_write_scale_sw;
-	st->write_os = &ad7616_write_os_sw;
-
-	/* Activate Burst mode and SEQEN MODE */
-	return st->bops->write_mask(st,
-			      AD7616_CONFIGURATION_REGISTER,
-			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
-			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
+	return 0;
 }
 
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	DECLARE_BITMAP(os, 3);
-
-	bitmap_fill(os, 3);
-	/*
-	 * Software mode is enabled when all three oversampling
-	 * pins are set to high. If oversampling gpios are defined
-	 * in the device tree, then they need to be set to high,
-	 * otherwise, they must be hardwired to VDD
-	 */
-	if (st->gpio_os) {
-		gpiod_set_array_value(st->gpio_os->ndescs,
-				      st->gpio_os->desc, st->gpio_os->info, os);
-	}
-	/* OS of 128 and 256 are available only in software mode */
-	st->oversampling_avail = ad7606B_oversampling_avail;
-	st->num_os_ratios = ARRAY_SIZE(ad7606B_oversampling_avail);
-
-	st->write_scale = ad7606_write_scale_sw;
-	st->write_os = &ad7606_write_os_sw;
 
 	/* Configure device spi to output on a single channel */
 	st->bops->reg_write(st,
@@ -350,7 +224,6 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
 	.sw_mode_config = ad7616_sw_mode_config,
 };
@@ -359,7 +232,6 @@ static const struct ad7606_bus_ops ad7606b_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606B_sw_mode_config,
 };
@@ -368,7 +240,6 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.read_block = ad7606_spi_read_block18to32,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
-	.write_mask = ad7606_spi_write_mask,
 	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
 	.sw_mode_config = ad7606c_18_sw_mode_config,
 };

-- 
2.34.1



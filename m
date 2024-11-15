Return-Path: <linux-kernel+bounces-410494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01369CDC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CAF2849CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA215192D61;
	Fri, 15 Nov 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QInaArz0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285F18C03B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665779; cv=none; b=jcMveidI51ydtvamnWH/qbCahXso4iB5aDZ04liZ7NVOU47awnWoz5mwKvm7F3pLj0qj1yv09NErOjRT5Oe6mVkr296CViDpMRWELgbA/GMDInxD9rfTqmErh0Om3LlMrmRPreBGBgwb3+CF9otXgQYumTGbIAqisDw82D4cD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665779; c=relaxed/simple;
	bh=yp8HclMjEgPnVolEt4GDET9NLM2QNAdMe6JwZ3Sr2zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SW9tOd2mOFiYIrNP/8DHYZLhEfqkVD6G2lEdZs8vR4wrYgBsnvuZ4LlROHqGIIAmcRMAZVE6a18VwHAuFPifjpqvQ/lG+Q6rMsGlayX/pqQJABfqePGV6GseeLsvvHOKdwprg2lWGPfSYFPemUGRulQonJJppdwLLINdqvQmIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QInaArz0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so13560695e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731665775; x=1732270575; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtD858HP6jaD/1nRunNRy5gRnEapf3vAfLlTnOGuNkU=;
        b=QInaArz0qtSfGhcUXjmiOsmbDh5h7moyhELXziWR4ZjsXMm11pMyzBbnk4p25U4q5/
         NNHaOPSAWOR9WelbD/M3KhT63PTL0MS7yatL295iDkW1C1e+cZhksYM61OkLq0nexcwl
         z2c1M9lc1Af4bSuJPLoJXjDopZAy6ymPJOSxsa9FJVMN23jrI37CdJtKOSB/ea1c8HAZ
         W5YR9dAARAOCT3PujrehKCC7ArATspjktfG3ZJt6LtVZKPY6drqeWJ1mWjAclD7rNpkw
         eZWnDSALwqNbPvXDKlUgpRzDg85VGEmoLWOxZC0eZ0nAYDoQ8xIJEu9hFhRIB8sJ2h7v
         y+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665775; x=1732270575;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtD858HP6jaD/1nRunNRy5gRnEapf3vAfLlTnOGuNkU=;
        b=fmZEXqThbB9+3HIJ7bazWZQw3E+C8abrL/D8Hf7pDMMxdy/lPlZkDCgZMLVtvHKNJJ
         x1Xe1a6hbKzIGErgDbrIITDEdEFwdj5rFHMqeFdgdZ6LupBKteWVORQ0fcot01QJunaC
         W+K1RTea+GLpBQ2o+MnEXHaTXnFGofmp8e0w9ZChLjiC4hATJGPHshJ+N0Pr6k7kB2ys
         RqvqYA3nOY+BMnN/8G+uK1dA7Mzfuh2iNTqDnDuyUwNGaNLEqBDjOXiXOsbqrtnUS/87
         MOkiDdPvg45s+1Ka+VVqqFqv0zvOzBp6LMlHrb1mxhPMB1w1cQ0+SnpctZ8jCvDtL0Cv
         20TA==
X-Forwarded-Encrypted: i=1; AJvYcCXV2Ypb1zKczxggQLPUg9HTT03B+YeAuZAiABmTcTZoD/56kuR39pnniOFeNySBFK0arZvt2TgL4XquPtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7N9kB2D8mCm0GrWdquMmddHPBb7+UtHTl1N7uY0qwsg6V+eM
	aQTdH5oFZVMqPDtKUpWCrn57r5gJ7iN4neBcZQUc5yerceZRzlP1hCfD8ECUb7rCaCjdZYmUHfU
	Z
X-Google-Smtp-Source: AGHT+IHO2TGu4SfoLBSgE8FWlgZhaCvlXvGpJUAiZbQIUqSGElGzT1pOPOWKIDw/HhHOfVWaQrgInw==
X-Received: by 2002:adf:e199:0:b0:382:24b1:e76f with SMTP id ffacd0b85a97d-3822590b591mr1515926f8f.2.1731665774748;
        Fri, 15 Nov 2024 02:16:14 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3822eb34170sm71116f8f.11.2024.11.15.02.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:16:14 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Fri, 15 Nov 2024 11:12:00 +0100
Subject: [PATCH] iio: adc: ad7173: add calibration support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAG8eN2cC/x2MSwqAMAwFryJZWzD171VEpLZRA6LSigjSuxtcD
 QPz3guBPFOALnnB082Bj10E0wTsavaFFDtx0JkuELFUxgmf0ZqNJ28uyZW2VZVjja5tGpDh6Wn
 m5z/thxg/XGh3amQAAAA=
X-Change-ID: 20241115-ad411x_calibration-2c663171d988
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

The ad7173 family of chips has up to four calibration modes.

Internal zero scale: removes ADC core offset errors.
Internal full scale: removes ADC core gain errors.
System zero scale: reduces offset error to the order of channel noise.
System full scale: reduces gain error to the order of channel noise.

All voltage channels will undergo an internal zero/full scale
calibration at bootup.

System zero/full scale can be done after bootup using the newly created
iio interface 'sys_calibration' and 'sys_calibration_mode'

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Calibration on the ad7173 family is the same as on the ad7192 family of
chips and mostly uses the ad_sigma_delta common code.
---
 drivers/iio/adc/ad7173.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a0fca16c3be07534547a5b914d525d05f7425340..11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -150,6 +150,11 @@
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
+#define AD7173_MODE_CAL_INT_ZERO		0x4 /* Internal Zero-Scale Calibration */
+#define AD7173_MODE_CAL_INT_FULL		0x5 /* Internal Full-Scale Calibration */
+#define AD7173_MODE_CAL_SYS_ZERO		0x6 /* System Zero-Scale Calibration */
+#define AD7173_MODE_CAL_SYS_FULL		0x7 /* System Full-Scale Calibration */
+
 struct ad7173_device_info {
 	const unsigned int *sinc5_data_rates;
 	unsigned int num_sinc5_data_rates;
@@ -175,6 +180,7 @@ struct ad7173_device_info {
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
+	bool has_internal_fs_calibration;
 	bool higher_gpio_bits;
 	u8 num_gpios;
 };
@@ -215,6 +221,7 @@ struct ad7173_state {
 	struct regmap *reg_gpiocon_regmap;
 	struct gpio_regmap *gpio_regmap;
 #endif
+	u8 *syscalib_mode;
 };
 
 static unsigned int ad4115_sinc5_data_rates[] = {
@@ -272,6 +279,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 	.has_input_buf = true,
 	.has_current_inputs = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -291,6 +299,7 @@ static const struct ad7173_device_info ad4112_device_info = {
 	.has_input_buf = true,
 	.has_current_inputs = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -326,6 +335,7 @@ static const struct ad7173_device_info ad4114_device_info = {
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -343,6 +353,7 @@ static const struct ad7173_device_info ad4115_device_info = {
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 8 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad4115_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
@@ -360,6 +371,7 @@ static const struct ad7173_device_info ad4116_device_info = {
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 4 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad4116_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
@@ -505,6 +517,105 @@ static const struct regmap_config ad7173_regmap_config = {
 	.read_flag_mask = BIT(6),
 };
 
+enum {
+	AD7173_SYSCALIB_ZERO_SCALE,
+	AD7173_SYSCALIB_FULL_SCALE,
+};
+
+static const char * const ad7173_syscalib_modes[] = {
+	[AD7173_SYSCALIB_ZERO_SCALE] = "zero_scale",
+	[AD7173_SYSCALIB_FULL_SCALE] = "full_scale",
+};
+
+static int ad7173_set_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int mode)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+
+	st->syscalib_mode[chan->channel] = mode;
+
+	return 0;
+}
+
+static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+
+	return st->syscalib_mode[chan->channel];
+}
+
+static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	bool sys_calib;
+	int ret, mode;
+
+	ret = kstrtobool(buf, &sys_calib);
+	if (ret)
+		return ret;
+
+	mode = st->syscalib_mode[chan->channel];
+	if (sys_calib) {
+		if (mode == AD7173_SYSCALIB_ZERO_SCALE)
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_ZERO,
+					      chan->address);
+		else
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_FULL,
+					      chan->address);
+	}
+
+	return ret ? : len;
+}
+
+static const struct iio_enum ad7173_syscalib_mode_enum = {
+	.items = ad7173_syscalib_modes,
+	.num_items = ARRAY_SIZE(ad7173_syscalib_modes),
+	.set = ad7173_set_syscalib_mode,
+	.get = ad7173_get_syscalib_mode
+};
+
+static const struct iio_chan_spec_ext_info ad7173_calibsys_ext_info[] = {
+	{
+		.name = "sys_calibration",
+		.write = ad7173_write_syscalib,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
+		 &ad7173_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
+			   &ad7173_syscalib_mode_enum),
+	{ }
+};
+
+static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < st->num_channels; i++) {
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
+		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, st->channels[i].ain);
+		if (ret < 0)
+			return ret;
+
+		if (st->info->has_internal_fs_calibration) {
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL,
+					      st->channels[i].ain);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 			     unsigned int offset, unsigned int *reg,
 			     unsigned int *mask)
@@ -801,6 +912,10 @@ static int ad7173_setup(struct iio_dev *indio_dev)
 	if (!st->config_cnts)
 		return -ENOMEM;
 
+	ret = ad7173_calibrate_all(st, indio_dev);
+	if (ret)
+		return ret;
+
 	/* All channels are enabled by default after a reset */
 	return ad7173_disable_all(&st->sd);
 }
@@ -1023,6 +1138,7 @@ static const struct iio_chan_spec ad7173_channel_template = {
 		.storagebits = 32,
 		.endianness = IIO_BE,
 	},
+	.ext_info = ad7173_calibsys_ext_info,
 };
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
@@ -1213,6 +1329,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
 	int ref_sel, ret, num_channels;
+	u8 *calib_mode;
 
 	num_channels = device_get_child_node_count(dev);
 
@@ -1240,8 +1357,14 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	if (!chans_st_arr)
 		return -ENOMEM;
 
+	calib_mode = devm_kcalloc(dev, st->num_channels, sizeof(*st->syscalib_mode),
+				  GFP_KERNEL);
+	if (!calib_mode)
+		return -ENOMEM;
+
 	indio_dev->channels = chan_arr;
 	st->channels = chans_st_arr;
+	st->syscalib_mode = calib_mode;
 
 	if (st->info->has_temp) {
 		chan_arr[chan_index] = ad7173_temp_iio_channel_template;

---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241115-ad411x_calibration-2c663171d988

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>



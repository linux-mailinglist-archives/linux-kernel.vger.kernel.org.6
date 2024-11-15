Return-Path: <linux-kernel+bounces-410521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932A9CDCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D266B252EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644411AC43E;
	Fri, 15 Nov 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fc3E8n+g"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886438DD8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667104; cv=none; b=CxlJ3dl+pTJ8ICb3xI627+h6RAn+FSL0XywSTEWrUVMSBC925AJOGq9Xnq9mmqOjNe1RXuM8+9/URkyzEASpSlw5SU32HdOwzpuOkEbsyTLEiL63ZUzaMplk/duTuDMc3PLR6rDhC9+Cyb4FNtsartX7KNspMSfy2fGBLrguKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667104; c=relaxed/simple;
	bh=a9Ci7wIoNIlUfqDLXVLFA0ucqR7miOS08awJuyxlED0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VTY6pSq4+pf7+iBV7dOJx2JZJkfqw9gJ10V6HrMfZGCZqs8Ikt2Ye1EZ8tivb2c8KfMCNT+c87DI7KSBMP7XSLimuXAq9pn1Efgt1dPTwrwDnuN9J+DUhB5xKgKyI99koNtK24SJ+yjjEodw6ukWvENI4ar0Wp8gVxAzoyty1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fc3E8n+g; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso1016933f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731667099; x=1732271899; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Db1U4jpEK2AiiwKsw/5x+Bw04+ZGyA1cxWkjFENXZLY=;
        b=fc3E8n+grWl2svRAzrpAUJNn/GNbUUI7nvU1qj3pUwKOpCDm1BAoNACM1IaUK5lOVN
         SRm13hbPeGLNp2JBEq8SSoEs8Qu4F3e89J7gzey8nNKgLSby+T1zGivhim+f7h9ubxZ+
         VFp54TkQGDyX6yLQny2/kFn3eGFOSubdochvsdw4MudrNS55FWTPyukv0e+E/WXlRCrX
         O8qrRfTwt95Ls+FsAxBywz5SAnkci0DPlCi+rcwSDrVeBuQ5RVRBRhzxa70e2Ev8AADu
         d6MAby1sRIMwk2FZIQ/+ejjnOMPCBGfWFxyqDzoPU6t77JUvE3uzJDxPkxkWna2/Ixs7
         P2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731667099; x=1732271899;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Db1U4jpEK2AiiwKsw/5x+Bw04+ZGyA1cxWkjFENXZLY=;
        b=gyvH5PaflAOztbY0W5Ro+LmRW5SIm0rzHvyJl07Kw6pf3lW19mJnVm7LVxZtPHjEvu
         TIRccNpBRbD+tEEEDrf6Q/0mybKECu587EfiJuUd0mBLg28wHttLCUJmJgQJAFRAy45c
         54BXaH+iyepaltSTT3cEcBjXvnI6hqZpa7MV9BqZDUv/5gixbWfZZqWfOgGVjfXWiOBd
         rlF1HSVMhaMyDjt1Sk+IlALZgGtrSS9EhHDmTwxzWeaQPnTHdy8vQzeAJRbWdvIH3u1D
         UjBQtzunay88kb9Q2Uw/snweuHv60vGsBQSmcoZ+IEmShxokZG6OsJIf9FGVHGGHEAD/
         ShTw==
X-Forwarded-Encrypted: i=1; AJvYcCV7NBkwbN1yM7KSWT6MGzN53gI8CValeu/J2qPc8PbXzVqbTqOzctn1yHupHgWVYW6/VNFBMS2MhkPn10M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKACngYu2+5TYPJLKTFJlHQsxSearEKExnr/AAEAh7CZxw15gB
	SblYSsqAEuqkETa9CVrUKDYOUwwQB1WzaUhjfaLMrMSzO8M370i6WKOf+1Au7RI=
X-Google-Smtp-Source: AGHT+IHs4KY4XzxNYlsXM+RtFDckmBr6pGD2/1eyNv2zRG7HjQp0QPampfN4h4i+u1UQn6If4vcBvg==
X-Received: by 2002:a05:6000:3c6:b0:374:af19:7992 with SMTP id ffacd0b85a97d-38225a42f6dmr1710307f8f.7.1731667099414;
        Fri, 15 Nov 2024 02:38:19 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae1617bsm4084163f8f.72.2024.11.15.02.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:38:18 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Fri, 15 Nov 2024 11:34:19 +0100
Subject: [PATCH RFC] iio: adc: ad7173: add openwire detection support for
 single conversions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-ad4111_openwire-v1-1-db97ac8bf250@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKojN2cC/1WOywrCMBBFfyXM2kgTDNYiIgh+gFspZdJONGAfJ
 rVWSv/dtOrC1XDmMmfuAJ6cJQ8JG8BRZ72tqwBiwSC/YnUhbovAICO5EkIojsU0s7qh6mkdcVK
 qII2x3KwNhKvGkbH9bDzD6XiA9LN0dH8Ee/tNSvIeZ3vCtv/yPsvxZrXDNnThneCCKxPLqDBa5
 XG01/iaYlrmdbmbXmr0xAOUtk1YRX3Lf0JIx/ENwwlFFOMAAAA=
X-Change-ID: 20241115-ad4111_openwire-e55deba8297f
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Some chips of the ad7173 family supports open wire detection.

Generate a threshold event whenever an external source is disconnected
from the system input on single conversions.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Hi.

This patch adds the openwire detection support for the ad4111 chip.

The openwire detection is done in software and relies on comparing the
results of two conversions on different channels.

As presented here, the code sends a THRESH Rising event tied to the
in_voltageX_raw channel on which it happened.

We think this is not correct but we can't seem to find an implementation
that would be elegant.

The main idea would be to add a specific channel for openwire detection
but we still would need to have the openwire enablement and threshold
tied to the voltage channel.

Any thought on this?

Thx,
Guillaume.
---
 drivers/iio/adc/ad7173.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa..f87f002cbd99cfabac2754559b3c6fc0a69f5b70 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -35,6 +35,7 @@
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -102,6 +103,7 @@
 
 #define AD7173_GPIO_PDSW	BIT(14)
 #define AD7173_GPIO_OP_EN2_3	BIT(13)
+#define AD4111_GPIO_GP_OW_EN	BIT(12)
 #define AD7173_GPIO_MUX_IO	BIT(12)
 #define AD7173_GPIO_SYNC_EN	BIT(11)
 #define AD7173_GPIO_ERR_EN	BIT(10)
@@ -149,6 +151,7 @@
 
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
+#define AD4111_OW_DET_THRSH_MV		300
 
 #define AD7173_MODE_CAL_INT_ZERO		0x4 /* Internal Zero-Scale Calibration */
 #define AD7173_MODE_CAL_INT_FULL		0x5 /* Internal Full-Scale Calibration */
@@ -181,11 +184,15 @@ struct ad7173_device_info {
 	bool has_int_ref;
 	bool has_ref2;
 	bool has_internal_fs_calibration;
+	bool has_openwire_det;
 	bool higher_gpio_bits;
 	u8 num_gpios;
 };
 
 struct ad7173_channel_config {
+	/* Openwire detection threshold */
+	unsigned int openwire_thrsh_raw;
+	int openwire_comp_chan;
 	u8 cfg_slot;
 	bool live;
 
@@ -202,6 +209,7 @@ struct ad7173_channel {
 	unsigned int chan_reg;
 	unsigned int ain;
 	struct ad7173_channel_config cfg;
+	bool openwire_det_en;
 };
 
 struct ad7173_state {
@@ -280,6 +288,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 	.has_current_inputs = true,
 	.has_int_ref = true,
 	.has_internal_fs_calibration = true,
+	.has_openwire_det = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -616,6 +625,59 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
 	return 0;
 }
 
+static int openwire_ain_to_channel_pair[][2][2] = {
+	[0] = { {0, 15},  {1, 2}   },
+	[1] = { {1, 2},   {2, 1}   },
+	[2] = { {3, 4},   {5, 6}   },
+	[3] = { {5, 6},   {6, 5}   },
+	[4] = { {7, 8},   {9, 10}  },
+	[5] = { {9, 10},  {10, 9}  },
+	[6] = { {11, 12}, {13, 14} },
+	[7] = { {13, 14}, {14, 13} },
+};
+
+static void ad4111_openwire_event(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+	struct ad7173_channel_config *cfg = &adchan->cfg;
+	int ret, val1, val2;
+
+	ret = regmap_set_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
+	if (ret)
+		return;
+
+	adchan->cfg.openwire_comp_chan =
+		openwire_ain_to_channel_pair[chan->channel][chan->differential][0];
+
+	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val1);
+	if (ret < 0)
+		goto out;
+
+	adchan->cfg.openwire_comp_chan =
+		openwire_ain_to_channel_pair[chan->channel][chan->differential][1];
+
+	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val2);
+	if (ret < 0)
+		goto out;
+
+	if (abs(val1 - val2) > cfg->openwire_thrsh_raw)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
+						    IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+	else
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
+						    IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+
+out:
+	adchan->cfg.openwire_comp_chan = -1;
+	regmap_clear_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
+}
+
 static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 			     unsigned int offset, unsigned int *reg,
 			     unsigned int *mask)
@@ -813,6 +875,9 @@ static int ad7173_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 	      FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, st->channels[channel].cfg.cfg_slot) |
 	      st->channels[channel].ain;
 
+	if (st->channels[channel].cfg.openwire_comp_chan >= 0)
+		channel = st->channels[channel].cfg.openwire_comp_chan;
+
 	return ad_sd_write_reg(&st->sd, AD7173_REG_CH(channel), 2, val);
 }
 
@@ -861,6 +926,11 @@ static int ad7173_disable_all(struct ad_sigma_delta *sd)
 
 static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 {
+	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
+
+	if (st->channels[chan].cfg.openwire_comp_chan >= 0)
+		chan = st->channels[chan].cfg.openwire_comp_chan;
+
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
@@ -968,6 +1038,9 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
+		if (ch->openwire_det_en)
+			ad4111_openwire_event(indio_dev, chan);
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 
@@ -1112,12 +1185,71 @@ static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
 }
 
+static int ad7173_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     int state)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+
+	adchan->openwire_det_en = state;
+
+	return 0;
+}
+
+static int ad7173_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				    enum iio_event_type type, enum iio_event_direction dir,
+				    enum iio_event_info info, int val, int val2)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		adchan->cfg.openwire_thrsh_raw = val;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7173_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				   enum iio_event_type type, enum iio_event_direction dir,
+				   enum iio_event_info info, int *val, int *val2)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val = adchan->cfg.openwire_thrsh_raw;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_event_spec ad4111_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_info ad7173_info = {
 	.read_raw = &ad7173_read_raw,
 	.write_raw = &ad7173_write_raw,
 	.debugfs_reg_access = &ad7173_debug_reg_access,
 	.validate_trigger = ad_sd_validate_trigger,
 	.update_scan_mode = ad7173_update_scan_mode,
+	.write_event_config = ad7173_write_event_config,
+	.write_event_value = ad7173_write_event_value,
+	.read_event_value = ad7173_read_event_value,
 };
 
 static const struct iio_scan_type ad4113_scan_type = {
@@ -1321,6 +1453,15 @@ static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
 	return 0;
 }
 
+static int ad7173_validate_openwire_ain_inputs(struct ad7173_state *st, bool differential,
+					       unsigned int ain0, unsigned int ain1)
+{
+	if (differential)
+		return (ain0 % 2) ?  (ain0 - 1) == ain1 : (ain0 + 1) == ain1;
+
+	return ain1 == AD4111_VINCOM_INPUT;
+}
+
 static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_channel *chans_st_arr, *chan_st_priv;
@@ -1375,6 +1516,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
@@ -1442,6 +1584,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->chan_reg = chan_index;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
+		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
 		if (chan_st_priv->cfg.bipolar)
@@ -1456,6 +1599,15 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 			chan->channel2 = ain[1];
 			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
+			if (st->info->has_openwire_det &&
+			    ad7173_validate_openwire_ain_inputs(st, chan->differential, ain[0], ain[1])) {
+				chan->event_spec = ad4111_events;
+				chan->num_event_specs = ARRAY_SIZE(ad4111_events);
+				chan_st_priv->cfg.openwire_thrsh_raw =
+					BIT(chan->scan_type.realbits - !!(chan_st_priv->cfg.bipolar))
+					* AD4111_OW_DET_THRSH_MV
+					/ ad7173_get_ref_voltage_milli(st, chan_st_priv->cfg.ref_sel);
+			}
 		}
 
 		if (st->info->data_reg_only_16bit)

---
base-commit: c849f534b9ea4688304f80f4571af75931dda7c1
change-id: 20241115-ad4111_openwire-e55deba8297f
prerequisite-message-id: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
prerequisite-patch-id: 26241903b8fee8c4243e73d11fb2872cd9f52a15

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>



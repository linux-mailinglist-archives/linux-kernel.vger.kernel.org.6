Return-Path: <linux-kernel+bounces-381422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BD9AFEFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B51C221BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D581C7B79;
	Fri, 25 Oct 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kylSqFJr"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4751DAC99
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849867; cv=none; b=YgZrKkjjIj+89SeZwQwBSTSkOkzHgIJ5xlS07T7S48biFXSg/YeaA5JaxCapaear1zYixThghiij7vMC//24IGd0sbn8WBDHV4n7EkA1YnYly+kpmBblmXsSeVgnaCsbim7ETJGZTxHsjR9WZNcPSW7N/QiLCj1u0tJm5OQ7MqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849867; c=relaxed/simple;
	bh=eFRAax/jOYknJj+mA1u9Mi7x/uS5Vdo459FAQVQK0bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B418sMBqgqxJNr9L+IQfPGB10iqWw9QAh7/p78K5WefRy0rhntCCsabtuc8K8HGFNHxklOjp3eWzQ8D1Hxelva1sCbz6UWGkggZ7y1agYSlk6QK7F1M+z2KYpuPTVaqb700gX6TvXfM/E5dlF7DehjCc79BXYpcScRFot/ShYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kylSqFJr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d41894a32so1397457f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729849863; x=1730454663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18Q0SNLrrGnD6lWyi8jFtTa7c779FJJMLTMpd23PZS4=;
        b=kylSqFJrekBxAXifacbWibBEj4CzCNwn8JUGRr0FEqr9MK1ZUT6Zbkmlm9uDlGjglI
         FyL/moV1+nFNg2PPh+RW7oIs0o2Z2IENoGd9D8pxdcow49Q9aJyoYj/w9FwutxUkxWS/
         bIf2aMk/1YE7iqDjRmiADRt8Np+nXwxRbui+A5hEHenVkLMPo8kVNv0GNo4zKvcsiigz
         UHrCv5lU6OXt9Pi7Lm0VoUA39F7OSIat/XfwxqRcHDVP1fWTETDxV5mTJpVKkJS/IFnz
         GVBqxMHk0HsWz1iCWtnocC5XKyJUnRYtRgZgCquerzCc5NigqcXPBXDsMfkwNN75J30z
         Q09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849863; x=1730454663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18Q0SNLrrGnD6lWyi8jFtTa7c779FJJMLTMpd23PZS4=;
        b=H7hJ7X8RfaPV2yuhuFEmt8hDArl41R2NVYCW6WkLTt75bRUe6qF9edxrhHZlXiUnF8
         G2SYbJYvzxrW0a3XW9TeYQsdKyjTLc9dFOGkSllBnuOEjjHTze2theCa8V7DwRmU2aGD
         KnAzP08fse1QC/rNw4kpuiRCdzY9FyXbDdPve5rSeuttlq5PRXe7FUDmTCrr3sB3WqjQ
         cjp1djyLJ2ahnuYpz63gcrWLNdhyc2vHZPO9WdGEGX1Y0nPeUFLluvGMs94kWDdQWz8z
         3tg0TbceTE5glUgvujMlG6kMUrOvKpnO8C8euh+EcgRZzdEcqDfm1mZVGmLKk+HRv2wJ
         yeSg==
X-Forwarded-Encrypted: i=1; AJvYcCVlgIp6yrFBRN35j2m6KGE+ApLH+QtjuPKNLIOz/Ce6sJbE0eQnvhl7P0DwLVNugfkVtxwQVIeVqtRJckc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNonQJVf+nwcgpfFsKHAGd1ls4bIkAv6E4Q/jayqYJu4F+mqU
	C6BfqG2c8xvQoSTZIYBB1RCmKfxteV+2500vW3iVrfAkStuJyuHam6zu7sh1Px8=
X-Google-Smtp-Source: AGHT+IEFJ+OD12S0zbYeS8PMN9ei3Zm9b7ttX/BfsVKj/cQwLbMevgytncV30ARV8VCaOS85DvHOlQ==
X-Received: by 2002:a05:6000:e04:b0:37d:46ad:127f with SMTP id ffacd0b85a97d-38045883804mr3726326f8f.26.1729849862955;
        Fri, 25 Oct 2024 02:51:02 -0700 (PDT)
Received: from [127.0.1.1] (host-79-41-194-153.retail.telecomitalia.it. [79.41.194.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6df1sm12895085e9.35.2024.10.25.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:51:02 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 25 Oct 2024 11:49:38 +0200
Subject: [PATCH v8 5/8] iio: dac: ad3552r: changes to use FIELD_PREP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-5-74ca7dd60567@baylibre.com>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 dlechner@baylibre.com, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
is removed. Variables (arrays) that was used to call ad3552r_field_prep
are removed too.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 166 ++++++++++++++--------------------------------
 1 file changed, 49 insertions(+), 117 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 7d61b2fe6624..75825d6a398b 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -210,46 +210,6 @@ static const s32 gains_scaling_table[] = {
 	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
 };
 
-enum ad3552r_dev_attributes {
-	/* - Direct register values */
-	/* From 0-3 */
-	AD3552R_SDO_DRIVE_STRENGTH,
-	/*
-	 * 0 -> Internal Vref, vref_io pin floating (default)
-	 * 1 -> Internal Vref, vref_io driven by internal vref
-	 * 2 or 3 -> External Vref
-	 */
-	AD3552R_VREF_SELECT,
-	/* Read registers in ascending order if set. Else descending */
-	AD3552R_ADDR_ASCENSION,
-};
-
-enum ad3552r_ch_attributes {
-	/* DAC powerdown */
-	AD3552R_CH_DAC_POWERDOWN,
-	/* DAC amplifier powerdown */
-	AD3552R_CH_AMPLIFIER_POWERDOWN,
-	/* Select the output range. Select from enum ad3552r_ch_output_range */
-	AD3552R_CH_OUTPUT_RANGE_SEL,
-	/*
-	 * Over-rider the range selector in order to manually set the output
-	 * voltage range
-	 */
-	AD3552R_CH_RANGE_OVERRIDE,
-	/* Manually set the offset voltage */
-	AD3552R_CH_GAIN_OFFSET,
-	/* Sets the polarity of the offset. */
-	AD3552R_CH_GAIN_OFFSET_POLARITY,
-	/* PDAC gain scaling */
-	AD3552R_CH_GAIN_SCALING_P,
-	/* NDAC gain scaling */
-	AD3552R_CH_GAIN_SCALING_N,
-	/* Rfb value */
-	AD3552R_CH_RFB,
-	/* Channel select. When set allow Input -> DAC and Mask -> DAC */
-	AD3552R_CH_SELECT,
-};
-
 struct ad3552r_ch_data {
 	s32	scale_int;
 	s32	scale_dec;
@@ -285,45 +245,6 @@ struct ad3552r_desc {
 	unsigned int		num_ch;
 };
 
-static const u16 addr_mask_map[][2] = {
-	[AD3552R_ADDR_ASCENSION] = {
-			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
-			AD3552R_MASK_ADDR_ASCENSION
-	},
-	[AD3552R_SDO_DRIVE_STRENGTH] = {
-			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-			AD3552R_MASK_SDO_DRIVE_STRENGTH
-	},
-	[AD3552R_VREF_SELECT] = {
-			AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
-			AD3552R_MASK_REFERENCE_VOLTAGE_SEL
-	},
-};
-
-/* 0 -> reg addr, 1->ch0 mask, 2->ch1 mask */
-static const u16 addr_mask_map_ch[][3] = {
-	[AD3552R_CH_DAC_POWERDOWN] = {
-			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
-			AD3552R_MASK_CH_DAC_POWERDOWN(0),
-			AD3552R_MASK_CH_DAC_POWERDOWN(1)
-	},
-	[AD3552R_CH_AMPLIFIER_POWERDOWN] = {
-			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
-			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0),
-			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1)
-	},
-	[AD3552R_CH_OUTPUT_RANGE_SEL] = {
-			AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
-			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0),
-			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1)
-	},
-	[AD3552R_CH_SELECT] = {
-			AD3552R_REG_ADDR_CH_SELECT_16B,
-			AD3552R_MASK_CH(0),
-			AD3552R_MASK_CH(1)
-	}
-};
-
 static u8 _ad3552r_reg_len(u8 addr)
 {
 	switch (addr) {
@@ -399,11 +320,6 @@ static int ad3552r_read_reg(struct ad3552r_desc *dac, u8 addr, u16 *val)
 	return 0;
 }
 
-static u16 ad3552r_field_prep(u16 val, u16 mask)
-{
-	return (val << __ffs(mask)) & mask;
-}
-
 /* Update field of a register, shift val if needed */
 static int ad3552r_update_reg_field(struct ad3552r_desc *dac, u8 addr, u16 mask,
 				    u16 val)
@@ -416,21 +332,11 @@ static int ad3552r_update_reg_field(struct ad3552r_desc *dac, u8 addr, u16 mask,
 		return ret;
 
 	reg &= ~mask;
-	reg |= ad3552r_field_prep(val, mask);
+	reg |= val;
 
 	return ad3552r_write_reg(dac, addr, reg);
 }
 
-static int ad3552r_set_ch_value(struct ad3552r_desc *dac,
-				enum ad3552r_ch_attributes attr,
-				u8 ch,
-				u16 val)
-{
-	/* Update register related to attributes in chip */
-	return ad3552r_update_reg_field(dac, addr_mask_map_ch[attr][0],
-				       addr_mask_map_ch[attr][ch + 1], val);
-}
-
 #define AD3552R_CH_DAC(_idx) ((struct iio_chan_spec) {		\
 	.type = IIO_VOLTAGE,					\
 	.output = true,						\
@@ -510,8 +416,14 @@ static int ad3552r_write_raw(struct iio_dev *indio_dev,
 					val);
 		break;
 	case IIO_CHAN_INFO_ENABLE:
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_DAC_POWERDOWN,
-					   chan->channel, !val);
+		if (chan->channel == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(0), !val);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(1), !val);
+
+		err = ad3552r_update_reg_field(dac, AD3552R_REG_ADDR_POWERDOWN_CONFIG,
+					       AD3552R_MASK_CH_DAC_POWERDOWN(chan->channel),
+					       val);
 		break;
 	default:
 		err = -EINVAL;
@@ -715,9 +627,9 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 	}
 
 	return ad3552r_update_reg_field(dac,
-					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
-					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
-					val);
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
+					AD3552R_MASK_ADDR_ASCENSION,
+					FIELD_PREP(AD3552R_MASK_ADDR_ASCENSION, val));
 }
 
 static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, s32 *v_min,
@@ -812,20 +724,20 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 				     "mandatory custom-output-range-config property missing\n");
 
 	dac->ch_data[ch].range_override = 1;
-	reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
 
 	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "mandatory adi,gain-scaling-p property missing\n");
-	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, val);
 	dac->ch_data[ch].p = val;
 
 	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "mandatory adi,gain-scaling-n property missing\n");
-	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, val);
 	dac->ch_data[ch].n = val;
 
 	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
@@ -841,9 +753,9 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 	dac->ch_data[ch].gain_offset = val;
 
 	offset = abs((s32)val);
-	reg |= ad3552r_field_prep((offset >> 8), AD3552R_MASK_CH_OFFSET_BIT_8);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, (offset >> 8));
 
-	reg |= ad3552r_field_prep((s32)val < 0, AD3552R_MASK_CH_OFFSET_POLARITY);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)val < 0);
 	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
 	err = ad3552r_write_reg(dac, addr,
 				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
@@ -886,9 +798,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	}
 
 	err = ad3552r_update_reg_field(dac,
-				       addr_mask_map[AD3552R_VREF_SELECT][0],
-				       addr_mask_map[AD3552R_VREF_SELECT][1],
-				       val);
+				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				       AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+				       FIELD_PREP(AD3552R_MASK_REFERENCE_VOLTAGE_SEL, val));
 	if (err)
 		return err;
 
@@ -900,9 +812,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 		}
 
 		err = ad3552r_update_reg_field(dac,
-					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][0],
-					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][1],
-					       val);
+					       AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					       AD3552R_MASK_SDO_DRIVE_STRENGTH,
+					       FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, val));
 		if (err)
 			return err;
 	}
@@ -938,9 +850,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 						     "Invalid adi,output-range-microvolt value\n");
 
 			val = err;
-			err = ad3552r_set_ch_value(dac,
-						   AD3552R_CH_OUTPUT_RANGE_SEL,
-						   ch, val);
+			if (ch == 0)
+				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), val);
+			else
+				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), val);
+
+			err = ad3552r_update_reg_field(dac,
+						       AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+						       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
+						       val);
 			if (err)
 				return err;
 
@@ -958,7 +876,14 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 		ad3552r_calc_gain_and_offset(dac, ch);
 		dac->enabled_ch |= BIT(ch);
 
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
+		if (ch == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH(0), 1);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH(1), 1);
+
+		err = ad3552r_update_reg_field(dac,
+					       AD3552R_REG_ADDR_CH_SELECT_16B,
+					       AD3552R_MASK_CH(ch), val);
 		if (err < 0)
 			return err;
 
@@ -970,8 +895,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	/* Disable unused channels */
 	for_each_clear_bit(ch, &dac->enabled_ch,
 			   dac->model_data->num_hw_channels) {
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_AMPLIFIER_POWERDOWN,
-					   ch, 1);
+		if (ch == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0), 1);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1), 1);
+
+		err = ad3552r_update_reg_field(dac,
+					       AD3552R_REG_ADDR_POWERDOWN_CONFIG,
+					       AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch),
+					       val);
 		if (err)
 			return err;
 	}

-- 
2.45.0.rc1



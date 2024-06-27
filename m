Return-Path: <linux-kernel+bounces-232266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C5891A5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6E71C2475C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9847A76;
	Thu, 27 Jun 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cjw9ury9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5715099C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489583; cv=none; b=pKSuqgoNrGqT2NTWvy3zIbn9ldx7ru01IESQkRLUil6abBB1G7xSZe0F8Z4EMuD6L8vcfE7cXyfWw5K+2sVBrsPjFUcwegfN53kPDwyuWJGM0g0AVeui2iOZZ1HDaCC+uZmk6DgIY0A1koMEtcGwfPP9i97n+0DA1if+qDqVQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489583; c=relaxed/simple;
	bh=qQ/7vkwC1C5cWmaoBBvMdVgy06+YTVptULeDy3n2Dds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQAiDWug5HhttLp5UzgFCcZ+13UaJi/349jw2o6unV5ASpEvHQiCBlJQxwABri6Wl+CK75ensF7auSkaJUsPn0iNuHXJZq1AOpwy9/a5ttyr/bZbUh57prf4U522BUsJRYQWUm38/Y6mKgyoi1WVKMWZkzBY6U+AAsvXn1eNHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cjw9ury9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424ad289949so16722995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719489580; x=1720094380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkwuueY8ob6w2zihWKIuCYMpPENMhr0LdjvttPAV8XY=;
        b=Cjw9ury9DoBSn2n1cjmFWBaMkfm6P+TV+rN2l2sdx0EMCBpFKdzeoRWexCIBgvCvlc
         Req51D4mVhptWTHb9y2NknDe6C/IrTHHxgD4UwSLqaE/4gL1sgndmZB+FvUUXCnGEVr+
         zc9vtm625QzFFC+opAadjwcBMCVKdiisNom3PhWmkBeQFq/IwXHg1r2BERlmaX7D+v3A
         Xl4EVtuaRfclzatltWChh93eL+wJNSve6XYMbzCwED8PzJptGzk7+8sdEXiPTSDhOcNY
         USgA4/2i93VDjYNtlis9E7yqjXdrr6MY2LFMwnNrOH5i/sIcGYwyh4quaEfDYrlJbHnW
         o9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489580; x=1720094380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkwuueY8ob6w2zihWKIuCYMpPENMhr0LdjvttPAV8XY=;
        b=XQrgOJkW022bozPND2eXsXQhrMXQWnS/mUInJPeeBeCf0nYCI08si0/mkdy3VxZfDf
         WuqLQlfQumYZNgxwiFcZ2JaVBtLzUpOtyFD2qeEATAuywY2A41005HbPXTitjsTVZffF
         MYBu0yQxdutr0Y18ceZ/l06v7CQz48cd6Wu+sAnBVAHSweArcAIXl8so+lDb+X+wrjxR
         uVw7lXofwTadaEV6nqutVUu67QYxwObGk1ySAN0Bkmeiy+gaqybbR6OdZQTTO1tD2+/F
         D/Z9Hoj5dOSCao0hMRokPnzyiTq2nfD6C/LvgcgL0m3cnozQXBETjRsDGtIa9MI9JRn4
         lEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3VLsE3iXo+Dv10G3rKyBEC4vYzmbgPaYssBLd1fwOA1FhDoY6ZgOGVHGG7nb2hZpaSLbRaPlYjyiCr7NLuofE5X6qvi8rYv0JLA8S
X-Gm-Message-State: AOJu0YzGZU8VmDJeaUhwO45PShyV2KjEwb8W+74265MA9b32AHGZTuj9
	1NbmSPrg1xaRgIbwnWO84aQjcrNQnHPIfP9f9PkqpTulHNYoCOegJIN92zslVImE+OOor7FvqVj
	Y
X-Google-Smtp-Source: AGHT+IEzdimMgZHeQNUIL+25K/WRKQ0nphqHceOaGkFix3mVJoIA7MTNUJiYVY6vS6uo6JdHvnkxFg==
X-Received: by 2002:a05:600c:3b14:b0:424:8c44:b639 with SMTP id 5b1f17b1804b1-4248c44b70fmr92812575e9.19.1719489579730;
        Thu, 27 Jun 2024 04:59:39 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:4435:7af:3956:8dba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82462a2sm63473585e9.2.2024.06.27.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:59:39 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 27 Jun 2024 13:59:15 +0200
Subject: [PATCH RFC 4/5] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-eblanc-ad4630_v1-v1-4-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
To: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1719489570; l=6851;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=qQ/7vkwC1C5cWmaoBBvMdVgy06+YTVptULeDy3n2Dds=;
 b=U1NIU0lHAAAAAQAAAhcAAAAHc3NoLXJzYQAAAAMBAAEAAAIBALJZcW6pLD4ksSdWnXd5r65Ze
 5Qc5pH7+DmmbKJasOXeVYRPFEmnORS7pwhURG11AMVFmnCVYWj+wPYrbCEeM7XKfO4oQzc66kYB
 7y0RrFwjoWKofytjI026zV5b2pn1JAItgu0Ijth+TSa6KVOTSXqqiVzOTDM1WL0hAIIzpkhE3Vt
 AVJrFDsh/nWed9OpeSS+S6e3ZxyJtlnhqbVIemcDmjwMihtFgTKeJWlxP7KGY/RQKPF/Ef7pS+O
 AckOrxuqGKvpOiNVCmuQEUQM0+r4uvwtja4zRSl+huqW+g1nLyReoZPzFwfJWREd+89dtTJTXN7
 xmmFNdX6KzRKBLVw1RY/R3mhAd+MkrdiNaRNKj+LO1QIxPoW90cPG9WpdVDUZf1VxhdciB6Hlxn
 lfEDFuCxU0n5H+kC4eiZvw+c9D4xX7iVdjPTMEaE6GBQNnMncdljBwA5NVN8WcaUhnAQnq7qhcz
 85L2Br7MPqe3q3J/PHIe0nHO56j7tTY6cFFs/ckqcQSTJigh2rA7InN1d7GqZFLzlewRTGaCY+M
 93d7DCIuxTxJWRpVm7NW1FBeX6d00+dAcQ/dS+jmA3kcdRoWtH160jmmYYvOgrsQTcMIQrPtK+B
 rULRmmIvEIJMF5UfNmxruWmWn6MM/xeejTNszoKqrORpbr7q3BnkKt2y/KdAAAABnBhdGF0dAAA
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAeHn8zj5DlxByhCxyZKhcHEQlNco
 qfURTTsVfmj+Obj5WjQl3fvYN5XIfrQgYmJdpQcqX+a7KpKAAc4Hg+LQjJiWRDIEksiCfz7p4PA
 myPwLTMSPeqZ+l0owGgV4VVr2O5bJp+9e16wyjT71bvPE3wJ5N5V1ICSD67sXb+sGXsn81IK75l
 0UbBPOn3OGyWx4RgHks5bzq4B/GBlGb81K4jTyeNxu03V+y5q7p0w7Bgsul2N2Q7KQRJwmxfbi3
 POoU4Vc4Zwy3fkefQwhkAsdhZpf+wfpi09eftjpqBznSNXKtr+FhzZUwbAj8Dmh6TzGOJAcrsOm
 LOBbg5ILZVqiXQxnIZXAZp1upAhMYFFjw7WbWL284aZ2wXP8UBEhEeV/6Z+wjdMM6YBnoQbEa9/
 3le1kPpkN4zLLWAjBpG0grBHrajkrXD1xa2lpO0OkQXUkppDFEX4gAnHwjRP2Ndx8C8kUJnVl/2
 2lGmhFvvHbZKPW8aPJ6tCKsRT0zVYTMI0VWSUXKv8cNrC8YzXmoD5M5Gml4Lm2Z8/0zif4yJZcF
 FYdUkyELZxMJdoeFJFrK/2FDHZfA8TtBBUCMnNI08fYc26wyxD2QpW2VIhayMJsbK4HktcTUiNy
 2DQs3uxZM0AQLQ0uv99pxOADKJHQZ/w8BQOc66Xebc96iztZHwoRX0ho=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

AD4630-24 and AD4630-16 are 2 channels ADCs. Both channels are
interleaved bit per bit on SDO line.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 130 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 1bcbcbd40a45..09d2f6d8cfe6 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -32,6 +32,8 @@
 #define AD4030_REG_PRODUCT_ID_H					0x05
 #define AD4030_REG_CHIP_GRADE					0x06
 #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE		0x10
+#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE		0x03
+#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE		0x00
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE		GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD					0x0A
 #define AD4030_REG_SPI_REVISION					0x0B
@@ -391,7 +393,10 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned int avg_len)
 static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
 					unsigned int mask)
 {
-	return mask & BIT(st->chip->num_channels);
+	if (st->chip->num_channels == 1)
+		return mask & BIT(st->chip->num_channels);
+
+	return mask & GENMASK(st->chip->num_channels + 1, st->chip->num_channels);
 }
 
 static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
@@ -412,6 +417,45 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 				st->mode);
 }
 
+/*
+ * @brief Descramble 2 32bits numbers out of a 64bits. The bits are interleaved: 1 bit for first
+ * number, 1 bit for the second, and so on...
+ */
+static void ad4030_extract_interleaved(u8 *src, u32 *out)
+{
+	u8 h0, h1, l0, l1;
+	u32 out0, out1;
+	u8 *out0_raw = (u8 *)&out0;
+	u8 *out1_raw = (u8 *)&out1;
+
+	for (int i = 0; i < 4; i++) {
+		h0 = src[i * 2];
+		l1 = src[i * 2 + 1];
+		h1 = h0 << 1;
+		l0 = l1 >> 1;
+
+		h0 &= 0xAA;
+		l0 &= 0x55;
+		h1 &= 0xAA;
+		l1 &= 0x55;
+
+		h0 = (h0 | h0 << 001) & 0xCC;
+		h1 = (h1 | h1 << 001) & 0xCC;
+		l0 = (l0 | l0 >> 001) & 0x33;
+		l1 = (l1 | l1 >> 001) & 0x33;
+		h0 = (h0 | h0 << 002) & 0xF0;
+		h1 = (h1 | h1 << 002) & 0xF0;
+		l0 = (l0 | l0 >> 002) & 0x0F;
+		l1 = (l1 | l1 >> 002) & 0x0F;
+
+		out0_raw[i] = h0 | l0;
+		out1_raw[i] = h1 | l1;
+	}
+
+	out[0] = out0;
+	out[1] = out1;
+}
+
 static int ad4030_conversion(struct ad4030_state *st, const struct iio_chan_spec *chan)
 {
 	unsigned int bytes_to_read = (BITS_TO_BYTES(chan->scan_type.realbits) +
@@ -437,10 +481,16 @@ static int ad4030_conversion(struct ad4030_state *st, const struct iio_chan_spec
 	ndelay(AD4030_TCONV_NS);
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
-	if (ret || (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
-		    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM))
+	if (ret)
 		return ret;
 
+	if (st->chip->num_channels == 2)
+		ad4030_extract_interleaved(st->rx_data.raw, st->rx_data.val);
+
+	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
+	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
+		return 0;
+
 	byte_index = st->chip->precision_bits == 16 ? 3 : 4;
 	for (i = 0; i < st->chip->num_channels; i++)
 		st->rx_data.common[i] = ((u8 *)&st->rx_data.val[i])[byte_index];
@@ -776,12 +826,25 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 
 static int ad4030_config(struct ad4030_state *st)
 {
+	int ret;
+	u8 reg_modes = 0;
+
 	st->min_offset = (int)BIT(st->chip->precision_bits) * -1;
 	st->max_offset = BIT(st->chip->precision_bits) - 1;
 	st->offset_avail[0] = st->min_offset;
 	st->offset_avail[1] = 1;
 	st->offset_avail[2] = st->max_offset;
 
+	if (st->chip->num_channels > 1)
+		reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
+					AD4030_LANE_MD_INTERLEAVED);
+	else
+		reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE, AD4030_LANE_MD_1_PER_CH);
+
+	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
+	if (ret)
+		return ret;
+
 	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
 		return regmap_write(st->regmap, AD4030_REG_IO,
 				AD4030_REG_IO_MASK_IO2X);
@@ -863,8 +926,14 @@ static const unsigned long ad4030_channel_masks[] = {
 	0,
 };
 
+static const unsigned long ad4630_channel_masks[] = {
+	GENMASK(1, 0),
+	GENMASK(3, 0),
+	0,
+};
+
 static const struct iio_scan_type ad4030_24_scan_types[] = {
-	[AD4030_SCAN_TYPE_NORMAL] = {
+	[AD4030_OUT_DATA_MD_24_DIFF] = {
 		.sign = 's',
 		.storagebits = 32,
 		.realbits = 24,
@@ -880,6 +949,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
 	},
 };
 
+static const struct iio_scan_type ad4030_16_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 16,
+		.shift = 16,
+		.endianness = IIO_BE,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_BE,
+	}
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
@@ -894,14 +980,50 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.num_channels = 1,
 };
 
+static const struct ad4030_chip_info ad4630_16_chip_info = {
+	.name = "ad4630-16",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_16_scan_types),
+		AD4030_CHAN_IN(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(2),
+		AD4030_CHAN_CMO(3),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
+	.precision_bits = 16,
+	.num_channels = 2,
+};
+
+static const struct ad4030_chip_info ad4630_24_chip_info = {
+	.name = "ad4630-24",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_24_scan_types),
+		AD4030_CHAN_IN(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(2),
+		AD4030_CHAN_CMO(3),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
+	.precision_bits = 24,
+	.num_channels = 2,
+};
+
 static const struct spi_device_id ad4030_id_table[] = {
 	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
+	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
+	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad4030_id_table);
 
 static const struct of_device_id ad4030_of_match[] = {
 	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
+	{ .compatible = "adi,ad4630-16", .data = &ad4630_16_chip_info },
+	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad4030_of_match);

-- 
2.44.1



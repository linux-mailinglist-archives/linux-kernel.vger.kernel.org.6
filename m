Return-Path: <linux-kernel+bounces-294296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3C958BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9FE1F23A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF71ABEB2;
	Tue, 20 Aug 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gDBZaDyx"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A11946A7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169537; cv=none; b=s0s3c3HFdknnLjW+J0oZbIfpDdWQEyZ9sTil1wGLi26yRF4K2RsfHY4Rq2FocrfGWW2IW86fUI1RK261CpIBaFuH4cSJgeeL7Snp4bgL/SF37H/5BnCWhJiaBCS/OPslQh7JY5Q/dfahV7muDkwRQQTRVIQLVcAp7mLrVQAN5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169537; c=relaxed/simple;
	bh=oaJmi/ZJxtUimFsdNU5rkHVdgv/yFGZx1cME/QQcQl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ttr21mHnBuFmq1hbIIww3ObP8dql0GXDrPKK2cnTwkCXM990DVtOXaWB9hqY35+GNN1UPF4VmQaDu38jZFN2XVKwXC7LI+UAXUNuPvGyoyhSWWAxXH/fshCaftK+QkGbyVQaVTxkDZX1fUY8f81x3q9fTN6b+uHBWrv3WyiZOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gDBZaDyx; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db1d0fca58so3403579b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724169534; x=1724774334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HECI8r7T3u0JJ5Sp0TIQJdhUl6oQitYnZhldhbcQNd4=;
        b=gDBZaDyx/B8rLKbArX27DDnjyZuPyQlWPxhjVduEZO8pVGLu8xEtkHiF1t6M/USsfA
         I41M3NoJewibYYsop7nCwS84z56g8DTlwrv04grKTibOorqXIZ/LqRIOJ/rSz3tg/QI2
         MfVHTcDn2++E5xHOtv172unTGk2eqgWA1UY1rDGTMQUtwN0OjmUnyd69GGlsvXCO9oZ0
         KpTySUBaxlyLq7YtN0k88Sz+i3jxTyF4mgylvG08w/o3RKeFudvHehXXn1SVNap/ywqt
         3Yu0HZzB4VkW80M8zdoAtowl6abRiTTttnLcawI1flzrh76lBuC/3Xi3WSHg6GOnJGMB
         Khig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169534; x=1724774334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HECI8r7T3u0JJ5Sp0TIQJdhUl6oQitYnZhldhbcQNd4=;
        b=W/aOd8H598cWarXR6DjetCRCoY7ttt+1qfXFUAtii5NPAlBg/aody7K8xKUj+nheVu
         7Cfw+FeB5JN6XUKqJW384HYAg6tHqo7+81OQv6kdsePH5BBzdC7cKF5I9LE3mN0VDuuz
         EMmByJDMuW5Rmi5wkdkvxufLy0ejJMf3rI5sH5YwKSrEWhudzbA3yy9CZDZREoKnCbnP
         6yUMSOSeLru8BYNUH5TZbx73Y/Kxy50kBnauLafvXda1xi9ZVlLxS1MkXctttbu+0p66
         giF+KRQ6FNOduDzm2APlSJfHaAzapDp7BpkwnafG+x4hzhq10JmsQ3rRGVIlXOt14da/
         jdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgav8jvYn0sDyOWKzE9pXKKVoR2mDjRXagmWUX2cGASx57tBND6jTMkshSx2NXxRz/7sBUCsbKWarpMzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmdN5gYpAfa0ph0hu2pPaYZifAJ4Ixikk8Rq8cSkmtPsEKTVR
	pxaWXMfbFyop97fcNc5trYS29Q+y6+lWCpjWxM2fLKDPACiCgAVUlIy7RKEjDwg=
X-Google-Smtp-Source: AGHT+IHIkAhI9bCg/czmhOwJ00jGYFHqeuQAh3GUl0mP8FSSaKUHPiSl0FgDu1UYYUa+B/YzS+e4WQ==
X-Received: by 2002:a05:6808:238f:b0:3dc:1b05:73fd with SMTP id 5614622812f47-3dd3acf921dmr18073312b6e.10.1724169534171;
        Tue, 20 Aug 2024 08:58:54 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d5a3efsm2872718b6e.17.2024.08.20.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:58:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 20 Aug 2024 10:58:36 -0500
Subject: [PATCH 2/4] iio: adc: ad4695: implement calibration support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
In-Reply-To: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

The AD4695 has a calibration feature that allows the user to compensate
for variations in the analog front end. This implements this feature in
the driver using the standard `calibgain` and `calibbias` attributes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 63d816ad2d1f..181c4146188c 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -23,6 +23,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/minmax.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -225,7 +226,11 @@ static const struct iio_chan_spec ad4695_channel_template = {
 	.indexed = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
-			      BIT(IIO_CHAN_INFO_OFFSET),
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					BIT(IIO_CHAN_INFO_CALIBBIAS),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 16,
@@ -619,7 +624,8 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 	struct ad4695_state *st = iio_priv(indio_dev);
 	struct ad4695_channel_config *cfg = &st->channels_cfg[chan->scan_index];
 	u8 realbits = chan->scan_type.realbits;
-	int ret;
+	unsigned int reg_val;
+	int ret, tmp;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -670,6 +676,153 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_CALIBSCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				ret = regmap_read(st->regmap16,
+					AD4695_REG_GAIN_IN(chan->scan_index),
+					&reg_val);
+				if (ret)
+					return ret;
+
+				*val = reg_val;
+				*val2 = 15;
+
+				return IIO_VAL_FRACTIONAL_LOG2;
+			}
+			unreachable();
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+				ret = regmap_read(st->regmap16,
+					AD4695_REG_OFFSET_IN(chan->scan_index),
+					&reg_val);
+				if (ret)
+					return ret;
+
+				tmp = sign_extend32(reg_val, 15);
+
+				*val = tmp / 4;
+				*val2 = abs(tmp) % 4 * MICRO / 4;
+
+				if (tmp < 0 && *val2) {
+					*val *= -1;
+					*val2 *= -1;
+				}
+
+				return IIO_VAL_INT_PLUS_MICRO;
+			}
+			unreachable();
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4695_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		switch (mask) {
+		case IIO_CHAN_INFO_CALIBSCALE:
+			switch (chan->type) {
+			case IIO_VOLTAGE:
+				if (val < 0 || val2 < 0)
+					reg_val = 0;
+				else if (val > 1)
+					reg_val = U16_MAX;
+				else
+					reg_val = (val * (1 << 16) +
+						   mul_u64_u32_div(val2, 1 << 16,
+								   MICRO)) / 2;
+
+				return regmap_write(st->regmap16,
+					AD4695_REG_GAIN_IN(chan->scan_index),
+					reg_val);
+			default:
+				return -EINVAL;
+			}
+		case IIO_CHAN_INFO_CALIBBIAS:
+			switch (chan->type) {
+			case IIO_VOLTAGE:
+				if (val2 >= 0 && val > S16_MAX / 4)
+					reg_val = S16_MAX;
+				else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
+					reg_val = S16_MIN;
+				else if (val2 < 0)
+					reg_val = clamp_t(int,
+						-(val * 4 + -val2 * 4 / MICRO),
+						S16_MIN, S16_MAX);
+				else if (val < 0)
+					reg_val = clamp_t(int,
+						val * 4 - val2 * 4 / MICRO,
+						S16_MIN, S16_MAX);
+				else
+					reg_val = clamp_t(int,
+						val * 4 + val2 * 4 / MICRO,
+						S16_MIN, S16_MAX);
+
+				return regmap_write(st->regmap16,
+					AD4695_REG_OFFSET_IN(chan->scan_index),
+					reg_val);
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	}
+	unreachable();
+}
+
+static int ad4695_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	static const int ad4695_calibscale_available[6] = {
+		/* Range of 0 (inclusive) to 2 (exclusive) */
+		0, 15, 1, 15, U16_MAX, 15
+	};
+	static const int ad4695_calibbias_available[6] = {
+		/*
+		 * Datasheet says FSR/8 which translates to signed/4. The step
+		 * depends on oversampling ratio which is always 1 for now.
+		 */
+		S16_MIN / 4, 0, 0, MICRO / 4, S16_MAX / 4, S16_MAX % 4 * MICRO / 4
+	};
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*vals = ad4695_calibscale_available;
+			*type = IIO_VAL_FRACTIONAL_LOG2;
+			return IIO_AVAIL_RANGE;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*vals = ad4695_calibbias_available;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_RANGE;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -705,6 +858,8 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad4695_info = {
 	.read_raw = &ad4695_read_raw,
+	.write_raw = &ad4695_write_raw,
+	.read_avail = &ad4695_read_avail,
 	.debugfs_reg_access = &ad4695_debugfs_reg_access,
 };
 

-- 
2.43.0



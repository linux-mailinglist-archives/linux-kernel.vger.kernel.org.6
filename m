Return-Path: <linux-kernel+bounces-520625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF561A3AC73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77E23AD2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BCB1DE2B9;
	Tue, 18 Feb 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dbuC56dg"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5311DC184
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920676; cv=none; b=n0+gOrkL1BuGmM4sZkOKPp38gIsarG659R8FiXsSMrEsW32m5HcCsFHjZsVWU9jXuoMRsC5DgtWU24Y6Ll5oG6iVaW4LN6ijuBKL/jGlmevf+brypWpDf8m+eWugDkXC57xviml+R7ACnmABXgFHWMyDmwcpEH6Clf2j2DZPxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920676; c=relaxed/simple;
	bh=9nCO7nZLKNdiDn/v0csoc01tAaw2I1Nd3kyqboFCUAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgDjg1P1NKNqiyPdtyfw8ZuDDFt8Exosujz/b6sxd7nulQAG/YClCoYkPiknnsUU2xdJfzgNv+7I2/bS8BQaEtFUN3ZK/r5z3qMfOHkjxQjQntGiokegi1A6a2ofqWTuR22zLJnbT678dr8h525YVFpSoGcbN2vsyBEaLWW3j/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dbuC56dg; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29fe83208a4so190390fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739920673; x=1740525473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nolGyY7FaUucKN7S8iQ8H4IDqpOVZJT/2gwczCi4r0I=;
        b=dbuC56dg55yyn16Rm73Olc050N/MqQzkw6zinFazALLNbMN373UzlvyljEKUcHlOgO
         CZvh4Er/wlFXZ7DkXhV/yKq10qQOM9Tk2FxzVtNj0Y+WgPGN9XUzS3i3KQORMW/ARYek
         WsSgA4YreltS6W/YI+1TzSlEfbZuAcPQLXO1iMq3piqGxu2FAc2SQwzx8Zjbsu1S/s/8
         I0A8sTf2pHVzpMLj8h99h+fqANbjqD9W/Am4tpXgokV9fUVPon+nPQM8QgY4LWiByol1
         rxeiRM6oEiSZoFbd3yw11WfRkrW1uEViRQK5TY/APiulC6fqQcKshsIAJMWaK4flLD2R
         Vsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920673; x=1740525473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nolGyY7FaUucKN7S8iQ8H4IDqpOVZJT/2gwczCi4r0I=;
        b=atv1RwZJaAoazXZ6TubthWk19uLr25x3S7Y8hwEDU6OoRyqjBYLEC1AC7KX+K3QDt+
         9UEj6H6VVPL7jgUSsNkHQLBn1amEIgGFI1phBWKGU5uxYeP+HDVF869Uie0m9zQYaNp9
         MDx37kFO3V5iP0EbovtuxQEMs7TImZ/ez7eA5vprK+bHz9NjvJJ64FKG2E6VusY1LWpM
         lsuBRzKuiAMFDraTxupZPI6XEQEHMnsj7hvCvTmweUf7YvNNoCldN9kVpsLhGEHNqd5Q
         8tmZQIxutMFf4lVBIfadBWy+jWZ131oDfFRugQ0m+WZ5b2V2BL1YQGlzGN5QdZT2jU6p
         4j0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyA7Pdo2IPUWe+DawUCPCdb5uklAVBjz11nF5fboBhtJ05rt5PKuH9Pyv3hRohPl/F1l0Q/e6x6/phtsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePA5FmYmIaQkwLyFtsKT/KIt3OEBnzxXgU3TowiOYTBHQOe5M
	5B86clSNG343d8PniYGiGicvfNAVkalEI81/vy99sW0d9fasqbSsr+lAv+l8DRI=
X-Gm-Gg: ASbGnctB/y4Qst9ofxO/425rZow0jb/pGXsMrebZcFCM8K8I2vPH5p5HPc+YY+PPi3O
	18V9fMke65wRWzp5h7XPmNrbz78HG2/P8QaTxrnkSH45Quce+mmBcNy7NwIufyoMcOyzZJBJ2w9
	ppvqUrUayidtXeC9DpoXhVH8LVF8lhQDijB+C1HV+pxAqBDs17IGUeaeEAATAMf8NP7cAAVmZlg
	rzn4IHNDMRey/28eDM3FksVdExMGKhwjbcDpQNSKDgP/X+liUn/JLo2wBmkNbBQ1/DFBEP7T6iw
	DNid3hSh/7f1FX3ybdHXwVBuMIrRDcPJubIpM3QU0VwpAIk=
X-Google-Smtp-Source: AGHT+IG2YgKjTkE825ZXpPLi2hzrtJ0Hq5GJ4kGNJKGqT9TWnzPIa1gRPXWVcRGRa4yjYFON4NsjQw==
X-Received: by 2002:a05:6870:2046:b0:2b1:db0e:e22d with SMTP id 586e51a60fabf-2bd0f32bbd2mr1428134fac.0.1739920672901;
        Tue, 18 Feb 2025 15:17:52 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7271f7c5ba8sm1803129a34.32.2025.02.18.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:17:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Feb 2025 17:17:45 -0600
Subject: [PATCH 1/2] iio: adc: ad4695: fix out of bounds array access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-1-57fef8c7a3fd@baylibre.com>
References: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
In-Reply-To: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Trevor Gamblin <tgamblin@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Fix some out of bounds array access of st->channels_cfg in the ad4695
driver. This array only has elements for voltage channels, but it was
also being accessed for the temperature channel in a few cases causing
reading past the end of the array.

In some cases, this was harmless because the value was read but not
used. However, the in_temp_sampling_frequency attribute shares code
with the in_voltageY_sampling_frequency attributes and was trying to
read the oversampling ratio from the st->channels_cfg array. This
resulted in a garbage value being used in the calculation and the
resulting in_temp_sampling_frequency value was incorrect.

To fix, make sure we always check that we are dealing with a voltage
channel before accessing the st->channels_cfg array and use an
oversampling ratio of 1 for the temperature channel (multiplicative
identity value) since that channel doesn't support oversampling.

Fixes: 67d63185db79 ("iio: adc: ad4695: add offload-based oversampling support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 3a1a6f96480fd383d32397f4d3c979069111c5c9..8721cbd2af34c53f0cea32e307b9ef2da46b0cfb 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -1035,12 +1035,14 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad4695_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	struct ad4695_channel_config *cfg = &st->channels_cfg[chan->scan_index];
-	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
+	struct ad4695_channel_config *cfg;
 	unsigned int reg_val;
 	int ret, tmp;
 	u8 realbits;
 
+	if (chan->type == IIO_VOLTAGE)
+		cfg = &st->channels_cfg[chan->scan_index];
+
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
@@ -1169,6 +1171,10 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		struct pwm_state state;
+		unsigned int osr = 1;
+
+		if (chan->type == IIO_VOLTAGE)
+			osr = cfg->oversampling_ratio;
 
 		ret = pwm_get_state_hw(st->cnv_pwm, &state);
 		if (ret)
@@ -1261,7 +1267,10 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad4695_state *st = iio_priv(indio_dev);
 	unsigned int reg_val;
-	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
+	unsigned int osr = 1;
+
+	if (chan->type == IIO_VOLTAGE)
+		osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
 
 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 		switch (mask) {
@@ -1361,7 +1370,10 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
 		},
 	};
 	struct ad4695_state *st = iio_priv(indio_dev);
-	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
+	unsigned int osr = 1;
+
+	if (chan->type == IIO_VOLTAGE)
+		osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -1713,7 +1725,7 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		struct iio_chan_spec *chan = &st->iio_chan[i];
-		struct ad4695_channel_config *cfg = &st->channels_cfg[i];
+		struct ad4695_channel_config *cfg;
 
 		/*
 		 * NB: When using offload support, all channels need to have the
@@ -1734,6 +1746,8 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 		if (chan->type != IIO_VOLTAGE)
 			continue;
 
+		cfg = &st->channels_cfg[i];
+
 		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
 		chan->info_mask_separate_available |=
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);

-- 
2.43.0



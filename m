Return-Path: <linux-kernel+bounces-567036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9372A6801E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1966B88591F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B30214A7D;
	Tue, 18 Mar 2025 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CeWog26X"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7B21480C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338351; cv=none; b=O7aeiSX/xviwMw7J5FKvEyPY2d/qcl5J/A+cg4VNYuo86pt0blB+H70F++tbOYwHOcZZ2yzAqTTm82TADjEptZ4ZlQ+b/BpDjJFQ0jgSp2gCWCwTXaDn9TYVgEY6qw1lPuPyM/7D0aLkbkbNrQcaog7sQMUixeZIZ4VLl0X5Dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338351; c=relaxed/simple;
	bh=n2XuLLxXTCJz5e0bPe5IE80EDLX+dhBN5Wga3hNAHPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcZGbJ5ZIkuyBxz8OY7vZtV2FxR6AHyQjIzz6WxvH9DYy0C45zeFPEvcCOsHJtquzwxBBdGwqaFLp/ieEwlyptCYd2rfDFvbmQlYbRkcA76EkUmhDhobh2W03Uma11GsX+ZpiBEp51oCvtrpuUoDDwkyoQTyn5P+F7BzQL5akDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CeWog26X; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7272a839f3dso1693271a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338348; x=1742943148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjwttRptCyX/KmMrSfvlA1VrtaMa/7/5WsmiZGKA3eU=;
        b=CeWog26XXzmblzCH4xDMAazAR4ljCHCTSuIwliJZCJwXwoa8yDsI/9S/+qomV65+ku
         FVhXiT9Qh3/Ypd9d+VIxKeRE/c4cdOpghLvRpj77GChSAIyYz/77x4s0t7HQ6GdrnNFF
         FkOeSHo4N90K/72q2zTIi1dNGYDj3y9jHjb+xGSX7bIvi2T8UfZMwDmfGT4j1MWr+GT1
         BXp+rsK7Vdk4T5dMlyTGzawC/eRWTxXaLqW1uCN+9lXd75V95zKi0zBDAKjzPkx/sZ44
         n8dxIOS/z/4/GQ5aJSbdWQFwtMZ/MOKWg1K8R9KF7djZ68+W/RRhVpdDthgsTbM8kpRC
         +ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338348; x=1742943148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjwttRptCyX/KmMrSfvlA1VrtaMa/7/5WsmiZGKA3eU=;
        b=bCuB8lRa4VGcm9X0++GES/WVz6v7p2tXZcXkwzpFG9PBS+vRyIFumo8qZnl+G2MOl8
         UURXfpOf1TnENeVTwGM2PdUR56CNdo/FDewWi1Gvbs556mMKGi/eXA6CPdZzvXlrXUyi
         f7n/LTo+Jfn2ogSJ6KEcRc2KAizF+E65DKVLzetCyqGS+jbtAYDC6iRQcyLDeBIkONOs
         H7Fd5zIxyl0KVLe5T4QCXzB1bl9bQKfQ2qvw9Hq11WdKjpbzbVE1MkVjEOLt3ZSBjDv1
         pHP0ETaLYOaXzn/c0109OMgxdZQLEcI2yKLdRivnVkQSBxtOHV+/Num3aBT7SziH8+x1
         FmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPICUNKmMZ/TxoAd0ANeAfZLNJFdxpuVNQTG5rWBLFxtpSEupeEN2SgCefwIHmP3l5iIv6P8APjuRDElU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3sEIvMoKnlITC5QWAVabo8Lmuvg6mJIHxMRIRwBaUjAQTB6z
	4MDwjs7hULXJqWA4sVtf5cxAhsAm++vhmVuGJSP60zfILbf4dpGEexBn1q1ZAPQ=
X-Gm-Gg: ASbGncvrLQjwek5BWJCIknRbkRygRQ/qOU5vIKznj0UdP8yLfxd/Pmbll6X1w//VdJq
	L4/KCT+M+EphdA5QEnUovi8rNmcImLv6qRYVfmc9uD8+XdrdxBkgK+5zcY6R2K5TxCTCrVTinQ/
	v0ZphPB/RUZhi0cSd1gdY/bSjiL/HJoN9K4qh/8mAx8gS22rd7/AlLh4vPxMdSpD3QGsrwEiIo9
	6r3G5UV/TQ7EWojwEpv6ozQ7slsbtDZ3PY/ThuvfsQojAOYV0wn60Sakp4HKp90M6ncsWOBrH7c
	KCc3APG1Gp4QBlZb66a0BPAVYEmAM+Nh/y8PUzvWvRZlZzg0/EzfcqGNduMg7Q/ZpitvBy+kf3a
	r
X-Google-Smtp-Source: AGHT+IFZeOB6UmAok88QtPjMZ4a7qssj21BeEdLRLwKLrzI8BBpWjmA+/MaBq6owK+oeIB5KrrWUKQ==
X-Received: by 2002:a05:6830:3903:b0:727:2f79:ce3a with SMTP id 46e09a7af769-72bfbdc582emr520823a34.12.1742338348657;
        Tue, 18 Mar 2025 15:52:28 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:16 -0500
Subject: [PATCH v2 08/10] iio: adc: ad7606: drop ch param from
 ad7606_scale_setup_cb_t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-8-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6289; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=n2XuLLxXTCJz5e0bPe5IE80EDLX+dhBN5Wga3hNAHPk=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkddg4E/ENxwGAXmv7gEi6SWv1qMVJ/43o2K
 8DKGGweFWuJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HRUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPZ2xAA13FHef7K1wo5lD2qvUjWMlT4vMtahvJ4RcAzXf6
 dWXiycvPGGTxGTzb0ngrsueqOxaxcYbUjiBVRxa9rmkcjZpFjyB6iS+LvuT1//rgTJze7j7ss+w
 4Z+pSrn0G78DRNdIsesOwfvQso27KKIty4Z3ufhzvtoo/DufJSvzAEkehGxQGbm7QtgWSAK77/A
 ZJsAbNVS4ImaSz6nfmeLbC54/6NHbji/44Esn+XSItPhdLcuqSnA7BHHbHMdgZeFaANfBWce9eU
 gW1sB/cA8NgesbVd6AYqTW5CuAKLuxnSYRDrSwXGjWe8WyI2ztfm13nqh2UZUBmAv19xwIqMtl4
 k9LwyzIMx1C1oz2BuWv8T3aVWUpTk4UJk2N9+i4/Uef7qfQu5IwxXn0c7/6FYJ48KTjRxN6m86C
 vCDojG30HyYQ6kncX4IBRYJFFzi5tmmj6dAYjqiJ2j9Pf01OfPqoPJzgK+erdzwmyhpjoJ+CBaY
 n0tqy3fn89weR+3gWhfIvUnceX9F3oejVYig8TOpQF3zHqntK92ujLJ635MNs57vM7NM2TBsOLQ
 hAkYdQxEXfiQwUf+vET7vK/roFBfvKXgrvMzP9R/A/FknGqSiD16uXBTzu24JqZsaPGZUbwS5RT
 7/w2dW80QK87zdOQwsvftnH+/hfHXFdo+oZrffCLJcGQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop the ch parameter from the ad7606_scale_setup_cb_t functions. The
same info is already available from the chan param via chan->scan_type
and chan->channel, so the parameter is redundant.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 44 +++++++++++++++++++++++---------------------
 drivers/iio/adc/ad7606.h |  2 +-
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3f03d4b7c2ceed5f7a134189c283ce392167b111..09c35161df365e531b8d254c7333359facf045c7 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -182,17 +182,17 @@ static const struct iio_chan_spec ad7616_channels[] = {
 };
 
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch);
+					  struct iio_chan_spec *chan);
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch);
+					  struct iio_chan_spec *chan);
 static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					 struct iio_chan_spec *chan, int ch);
+					 struct iio_chan_spec *chan);
 static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
@@ -346,10 +346,10 @@ int ad7606_reset(struct ad7606_state *st)
 EXPORT_SYMBOL_NS_GPL(ad7606_reset, "IIO_AD7606");
 
 static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					 struct iio_chan_spec *chan, int ch)
+					 struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	if (!st->sw_mode_en) {
 		/* tied to logic low, analog input range is +/- 5V */
@@ -425,10 +425,10 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 }
 
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch)
+					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
@@ -439,7 +439,8 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, chan->scan_index, &bipolar,
+				     &differential);
 	if (ret)
 		return ret;
 
@@ -482,10 +483,10 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch)
+					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
@@ -496,7 +497,8 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, chan->scan_index, &bipolar,
+				     &differential);
 	if (ret)
 		return ret;
 
@@ -540,10 +542,10 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7607_hw_scale_avail;
@@ -552,10 +554,10 @@ static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7606_18bit_hw_scale_avail;
@@ -564,10 +566,10 @@ static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7609_hw_scale_avail;
@@ -1305,7 +1307,7 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	indio_dev->channels = chans;
 
 	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
-		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset], ch);
+		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset]);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 16a230a7c00e3504744b97da339cdea6b8ecf40f..c57a193761c92add6f82cf0cc51ccfdb9d8d2ab4 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -113,7 +113,7 @@
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
-				       struct iio_chan_spec *chan, int ch);
+				       struct iio_chan_spec *chan);
 typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**

-- 
2.43.0



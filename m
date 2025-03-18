Return-Path: <linux-kernel+bounces-567035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD8A68017
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F388189BF19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59E2147F3;
	Tue, 18 Mar 2025 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3d8GoheL"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DA2147E9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338349; cv=none; b=jetC3koeCI3x7HS+rjMypsqhHgZImen9R9q4MAK1wT7UA94womK9ekUZQj8PPprMfJzMNeCAGEMDEYYD0lBPFxo75tdx+OIizLSnUw3/0rVDFg9m+5a4SrhTCuuyZoSJp/Yr09sxAN5pI7gMHVRJWZ3LxDjs5XCmeQndC0fvaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338349; c=relaxed/simple;
	bh=7ZeeN3jt0VgVmY+v13HjPQ019EhJlakTc9anieHggfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1poXdnca9xL0aZfSZ8fQJLZgzBRAe9tEwudaDESgZ0DAHScPPmFsdyHy8m8/FOvPkj69mC6eun7WuyEnU77fPIF8mCoi6ubccsE6eh9aM03+nhNth4DK+7HrsqGXLSYOsb0g7qWkuTSiQ3TfV0uwoJ+YNiQJSP8DdDYv925ZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3d8GoheL; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72726a65cbaso3950291a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338347; x=1742943147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9QbM8s9aJV+eD3jeL9fzQ9yUoqSg2ZDrUr+opJ83LM=;
        b=3d8GoheLTq5Nd7wRamFZs7+r2ZXzFASuq1fz1pxIu2aMaLUKVcJbX9xNGwFo8a7jim
         lwMIB4JycHa4NWiThnss6CXFqLDyYUg9ueyw5O/ywx3HgMq8ygIa4JeGvQ9UJ4MzOxCo
         FJRJQgDylwYI5ERkq7y1dyk/2HfI4GbBRAGAhuALyNKkw0ExYIkkf4lE+0+IQSUXg7PR
         3R7Hcr95i3mJMVvlEE8Xl78pqsZa2J4lntx/ntoR8Uf0kAl5DZV4Fjwb/PObD8KQpNKO
         ed3r1Pv1QPBx2BdNYcRaTaNYN+eKSsZLhJ6lu4JgsiUkSZSdHKa+/qlk285phOXLLESZ
         gTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338347; x=1742943147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9QbM8s9aJV+eD3jeL9fzQ9yUoqSg2ZDrUr+opJ83LM=;
        b=bVe++ihU/np3UwjOpfU+8ph+qybLHXCwOxJ+YEm5HRzYsaA19RyYOkMcqjMC7GRdja
         Tj6CS2p79Zak2aSoHDuBXlHQ8xtercAaQc0jrRmVFOhF1GG08laN/5R+NINl4o9wKDTn
         uhFFuobaVqCLFnqzH6k/ojpmm/waLD6wi82THEAsWiFDQTAirPOuHHR/47arQFifII2Z
         5F5oV41hztnkjPfoa5Jw6X0RGcuCrOM28Bi49/0eQPXhPzp3fRb1XsMBNtHgz9SLrP/Z
         /97F/cS8fsndI0dInYhxf5J7h1nI0rxsFOOWRCSVMDIFL0VFKJQ1a7nGCs71fo3QWdji
         qLCw==
X-Forwarded-Encrypted: i=1; AJvYcCX6IlFmZJBe/YeusaiOLQUJeWaoh3cv+7v+NPUPJVtehUUPecS+HlX4gzYc39YrQIon3YCSLJUnGMDjV8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsTBU9wHu5U6nv0ybP/z3bTd9jN0L6jp931ka7mzvQ0i0IHrl
	ishI7amsPIMDMmAkXCDai5itFUh4/Bfj57Dk5Hijgkz8pQWtyyFlRCrQlCA1KkE=
X-Gm-Gg: ASbGncsoI22ET/J+wd9O5zeGgeTIM234aPEdvnm+D2gLwE8rWuqg7kMBZFtiW77sywz
	CJBmez6yHmWko5gHd+iWSKdKSZ04ffZS0GGR74X9RStvjkpDGi2VUFw06WmXE7Hp4PqLJo1D0Qv
	fYE19E/zylxedGUrU60qwv7RMj0q+lATaWq5SUFlNMDGaqd+Mv6IEfTegaLQRPx4EWnWpnT/zQB
	v65XyGBuog1ZeQbkT/dSAUPlbSVHMOHJSmOcMExzREz2ZXH35S9Q9yYmljSphzlsUgZZk3Uib0R
	ZPGLTLjFu+T7vbm88TUhFzO94FGevdghTpC7Lyk+VclqYVivqrFssl0C2WyRtKijjnKLp5LOT5Y
	NYyWTwMellVY=
X-Google-Smtp-Source: AGHT+IEJuFOsfabuG6mv3sgyUGFg7qkWzItxKgu1NGpAAxoJYO5QrTRC0U+51ukoMzZQNMgPFjMN5w==
X-Received: by 2002:a05:6830:3811:b0:727:39d7:b0d5 with SMTP id 46e09a7af769-72bfbdd54fdmr472677a34.15.1742338346818;
        Tue, 18 Mar 2025 15:52:26 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:15 -0500
Subject: [PATCH v2 07/10] iio: adc: ad7606: don't use address field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-7-4b605427774c@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2364; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7ZeeN3jt0VgVmY+v13HjPQ019EhJlakTc9anieHggfw=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkdEZRZtf2XI302kdIOFOCRJHqREn8SCysjg
 K5UrJx5Z6CJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HRUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANoTxAAlfPZMqN41RHjBcTsnG/xzXm/343LGv7XV0ZTsXF
 w3wpPpVXGWp+IyCl3UI8Xa4lgHvHgIg29tVMLPM6uMytUqiPryJpojJ40iOqTKUs6Js8oVOCFjR
 wxIij43VoI0FfY1eUYo0M6tMnQz3H5Agx7/amIBdahZbG1uaEEQaoBIiMRJDjk1kC+VSgnBHcgg
 j/ynEAhHqnwrla6z5tKVOUoXgaQCA2J0ckEk/aa8KE7lOHwqvnJ2TFhRSm96M3SNgoFfgIhj0Wh
 xipbWaQP9a79lkMuagYmpim7+7fyJE6F2BqAQeGBcrQbKHaG6MDLS39tyVSMarkw/6TVIXQppaD
 rAYJyxUyCWrgl3FRXtgJcUyNUViT+nZ2wWaBjla9NOpIHBHoxMmJC4DAx6xu/J7wjeqxyR86Okn
 Q2DpC9G9eVHm7axj0D8lY7ACunASXQKimt4pryJJ43+T9PyZfVd5y1A2qgqfF9MfD4K0xLSShsv
 qmpK0G2KI6c2SJbnh/HmyBBVA8ZkwNaMvFkEt5YgZhsjuHdANzx8vBtu5UH8V1FLw3ScBIojpDf
 MNX03rxa8u+uq0E9spraRIhKyW2wlCeXsX4maSQFCDtBB1TgOwmAQgRpPAz28gkg+HAO0vaiLpR
 d2Jq1xUxbvVccBlvKxGv+OV65ht6MUSG0v0aJoZed3Ic=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop use of the address field in the ad7606 driver. This field was
duplicating the same info that was already in the channel and scan_index
fields. This is one less thing to have to hold in your mind when reading
the code.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 drivers/iio/adc/ad7606.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index b81591d8bc520c730e1632bd15eb1eddb5a59c90..3f03d4b7c2ceed5f7a134189c283ce392167b111 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -776,14 +776,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
-		ret = ad7606_scan_direct(indio_dev, chan->address, val);
+		ret = ad7606_scan_direct(indio_dev, chan->scan_index, val);
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
-			ch = chan->address;
+			ch = chan->scan_index;
 		cs = &st->chan_scales[ch];
 		*val = cs->scale_avail[cs->range][0];
 		*val2 = cs->scale_avail[cs->range][1];
@@ -865,7 +865,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
-			ch = chan->address;
+			ch = chan->scan_index;
 		cs = &st->chan_scales[ch];
 		for (i = 0; i < cs->num_scales; i++) {
 			scale_avail_uv[i] = cs->scale_avail[i][0] * MICRO +
@@ -1072,7 +1072,7 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
-			ch = chan->address;
+			ch = chan->scan_index;
 
 		cs = &st->chan_scales[ch];
 		*vals = (int *)cs->scale_avail;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 5ee04e8f4041c75d66b899a9371a75b5d0f31071..16a230a7c00e3504744b97da339cdea6b8ecf40f 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -45,7 +45,6 @@
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
-		.address = num,					\
 		.info_mask_separate = mask_sep,			\
 		.info_mask_separate_available =			\
 			mask_sep_avail,				\

-- 
2.43.0



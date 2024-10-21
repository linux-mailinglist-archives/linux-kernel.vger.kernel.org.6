Return-Path: <linux-kernel+bounces-374393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90379A6983
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80E3284496
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B11F893E;
	Mon, 21 Oct 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q9dbUDkt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18821F1311
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515763; cv=none; b=oPG7IzzuXmHR3BV+S4/crK2QZZLHZcyHwTS+lfkHGmpVkiHPgsS2c/sG2/7HPINt4rDC9EHXp2o2uktHiJ+0PFv5UlIF0ITWBfiG9oeRpvRiM3Hj/G5T/Vz7MuVu0sMKGwMXJbTZnBG0atuwkBpkiJ59GTetkFuS+tKaPEf0OvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515763; c=relaxed/simple;
	bh=/vHDMY5+soiiVfTJjsDcl+Tcn8eg5D/9fZbUdcL/foU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZDyLN+gflCTV7q0Vs/HEpypaIoEb6mI1Hgh12oe2Q6SVmyuDRjWYPvIfb0wnF+YU1ecpK1fn6E9PqpUnVNGwUvhtdl+t0N4q1BthKToiPnoQ+jfEbgLneZAwd8yvzuAV11ev4BFDNmGAFu17r8pD1g0klDkVHxGKFO5cWZkNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q9dbUDkt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso611331166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729515759; x=1730120559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsfTKhMEzsTUvMUHcKoet4fyDQT+vLa6vltcamFvJHs=;
        b=Q9dbUDktySgU9j5QJ7gXGiL003SRWdcLbxVNVIPmuUkuoRpC5oXLFGTbY1GNaCpT/V
         yjH1aTZ8qCjWDsQJxuxyk9dJzKtEzQxX6zaKS7sDJf16zXOFmKzt2eX7nZkZupeEK/S9
         FktvbDki6mCItCccsuuE4SBqFAv6s1/tJbukB49rv+U6BjttRtMmokoCRTLCs4bASvwf
         Tz3SZ16aiM9/Z4Q82Wn64kmk/qXIoN4mhKspfa6WoSHzJZfTwTWYaGuL3zmaDYgN3Yzz
         mudJA03ovz7L1/Q7aORCfWtuueMsaGXVydfUHM1NekWnfZXRfSEYtnvPvjvWBOcNgwZQ
         POCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515759; x=1730120559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsfTKhMEzsTUvMUHcKoet4fyDQT+vLa6vltcamFvJHs=;
        b=j7IaKolSCAAFRTsujTn9T4Ny0ZOIuWcNxeB/vrxMYKZDjr9coAJFBXy+gRvUALutq5
         hIZRtb0uoV+avDqLNWEiIrmdPioFIzkvDSjD0AfMnVteKFF2jKs1j7GLCt/JYNQkpq/C
         Xr/9aeZEmNxLVsITQgekBxwQNLPLVzQ0IxRJr+2OXu8m99yzyZsaAhmw9G05H8n3ENql
         +FrrzKTQOMrKgNhl+Z9r21NAD6UXz/9xD8yU1JPBFCznwon1WuAx+tjW9QlsUsqueXW4
         XEPdPFhQ5UXVJFU3DCBYJKgabBqeDDHucvQHq/MJvOp56khiBE5CwHmL2e6KdNpUZjYs
         6yKA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZpxywDSRvizpM4Cpxg3f/mgUUpLMwHInwOkZyIH6rjQN2Ks5aSWlwhj1fL4I5MxXrz8SdXnQLDA8VRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Q6kAX8k2yCc5foZHNUbD9FH+m2CCaAUDcCH82xSUsMhqh4EY
	o1g8qYXsgihMZ4tE0z5Hvi71KfGXMe3enR9YBtqlwddi4Q36IiYcytUhG0iT5SQ=
X-Google-Smtp-Source: AGHT+IEPUP36vChr4GiXp1vvE557inTV7I5+nNTM1UCGdCqVCiic3/5/zLwBJM3KSQWg0TPXeB1srg==
X-Received: by 2002:a17:907:7409:b0:a9a:80bd:2920 with SMTP id a640c23a62f3a-a9a80bd2eaamr637181266b.53.1729515759121;
        Mon, 21 Oct 2024 06:02:39 -0700 (PDT)
Received: from neptune.lan ([188.27.132.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e33sm202310366b.120.2024.10.21.06.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:38 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 2/6] iio: adc: ad7606: fix issue/quirk with find_closest() for oversampling
Date: Mon, 21 Oct 2024 16:02:17 +0300
Message-ID: <20241021130221.1469099-3-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021130221.1469099-1-aardelean@baylibre.com>
References: <20241021130221.1469099-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a small issue with setting oversampling-ratio that seems to have
been there since the driver was in staging.
Trying to set an oversampling value of '2' will set an oversampling value
of '1'. This is because find_closest() does an average + rounding of 1 + 2,
and we get '1'.

This is the only issue with find_closest(), at least in this setup. The
other values (above 2) work reasonably well. Setting 3, rounds to 2, so a
quick fix is to round 'val' to 3 (if userspace provides 2).

Fixes 41f71e5e7daf: ("staging: iio: adc: ad7606: Use find_closest() macro")
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ae49f4ba50d9..d0fe9fd65f3f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -748,6 +748,9 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if (val2)
 			return -EINVAL;
+		/* Minor trick, so that OS of 2, doesn't get rounded to 1 */
+		if (val == 2)
+			val++;
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
 		ret = st->write_os(indio_dev, i);
-- 
2.46.1



Return-Path: <linux-kernel+bounces-374396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318E9A69C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC862B23D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05431F9A8A;
	Mon, 21 Oct 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kIccRN1d"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79771F706A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515766; cv=none; b=E0Ipe9CQ3aOK2uMsgGgVRIHbFr8vuaZleudlfl3r9apkEa+hV6gaxtzO6TDO9a69q4t0j6XfN4aa+SPMWfH5RXkIN225tI7I9gHPoFzmobf4lUduJti0toesu4bYgep2jQ49lg7i3I9MZ2LFRjb0byfJcTC8eki6xgKF0+BgOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515766; c=relaxed/simple;
	bh=WKgeKu9BKiyFb382szdmwaGYbhsRt+mpw7oK76e+Juw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2LnTbmbbfAUgixOAHioFBfu048u77bRY9FTCpzZ7x3PLnezangFpfCVHJclzutRmVuVdMVoqZse43TKebbZg6d2ZO9ZwDdyBlr8lwPksUwOLqW269vlgD2ruwRZfqakji4sKhFSt4zeteS1p2zYQem/nlS2X96iHDanmsgbOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kIccRN1d; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so616860866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729515762; x=1730120562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exnou0jkm74QB50DFbZVtG627VNG9ugvQrtDOKEght8=;
        b=kIccRN1dXFGNOrUonzPxNsWrlUQsxVZXbDOPOQzCjVWZqzqU5oZg8TCNAH/ojV8aKr
         +8LlP5h7K8G6Ycjj6bTTiCD3P2agVnZHAWCzFpFGJNCB80E7irBACDLobRfBIxjVQtPD
         sQNzoDTzXjmWtNUm2X/QMPiTxo85hdCdUfnXg2ffta6yc3g3FCMjT3cNCta9CKALXi93
         4gfvS8JwZbl8eKVa6FWVZZolB2LEHW8ZrssylPxnsOXS/xw41EP6+/bCbpcpPtzRUQCm
         P8XjHBNF1WMlZG0t/qzCbbG62ivxWqEJPXajoN0YH+uaI4avWqqY3d8C/nl+eeEyyVbl
         d6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515762; x=1730120562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exnou0jkm74QB50DFbZVtG627VNG9ugvQrtDOKEght8=;
        b=Gro9feAhpbkOQEoRbw1TBFGQtPkFsjkn8Kwx4F83wlnWusDz79Prxmt7GRBPmpA4e8
         +z5TGE37rWxJRydsffW8w6HfpGONZNMKHYPby68cgpQzOZNToZHWTZbWzJKwruXmotuK
         FsPuRHbvl2TCofztNV1PmHCY72yRcBgkcLQLj0IENvXR32WkOMAdGB6qtjVE4SOvXZNg
         G4lvA6TSfT/c4GgxRot/cgeB9jH35aX+ummzigLgTxFudlR2mQ6HbXUWDUMubrfNkdA4
         059C84v1Bh61uIZbSqXr9n91H79AxmG6I4HO1fbnO5nTGrO4H9OTeeVayG12MKaAazlu
         +5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWOnbNVpkDfa5sNckr/0wueYow4jBzDvyca9L8fS7RYNIkRjrOlrCZ/EP6KpcCtmJYqe3UcJlsui1HbhMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKCczZyC13K185EPCjm3Xc6d6Tr415cu9wRzcyYK9Hn4PkwM4
	p4LNIctRuyXNd9JS2NghHQBYUjaOcVBQRra3VMIC1STU0iKzJbhOYnam/nSeYmg=
X-Google-Smtp-Source: AGHT+IHpgT9Fnvdd8Os6CvbTIWJb/pht/ROcNHvodcKIAP9VYk00V2IhRdT7gRJOIpwjFKL4MBk0Hg==
X-Received: by 2002:a17:907:6e89:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a9a69c687d8mr1274360966b.43.1729515761922;
        Mon, 21 Oct 2024 06:02:41 -0700 (PDT)
Received: from neptune.lan ([188.27.132.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e33sm202310366b.120.2024.10.21.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:41 -0700 (PDT)
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
Subject: [PATCH 3/6] iio: adc: ad7606: use realbits for sign-extending in scan_direct
Date: Mon, 21 Oct 2024 16:02:18 +0300
Message-ID: <20241021130221.1469099-4-aardelean@baylibre.com>
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

Currently the 'ad7606' driver supports parts with 18 and 16 bits
resolutions.
But when adding support for AD7607 (which has a 14-bit resolution) we
should check for the 'realbits' field, to be able to sign-extend correctly.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d0fe9fd65f3f..a1f0c2feb04a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -568,7 +568,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;
+	unsigned int realbits = st->chip_info->channels[1].scan_type.realbits;
 	const struct iio_chan_spec *chan;
 	int ret;
 
@@ -603,15 +603,29 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 
 	chan = &indio_dev->channels[ch + 1];
 	if (chan->scan_type.sign == 'u') {
-		if (storagebits > 16)
+		switch (realbits) {
+		case 18:
 			*val = st->data.buf32[ch];
-		else
+			break;
+		case 16:
 			*val = st->data.buf16[ch];
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 	} else {
-		if (storagebits > 16)
+		switch (realbits) {
+		case 18:
 			*val = sign_extend32(st->data.buf32[ch], 17);
-		else
+			break;
+		case 16:
 			*val = sign_extend32(st->data.buf16[ch], 15);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 	}
 
 error_ret:
-- 
2.46.1



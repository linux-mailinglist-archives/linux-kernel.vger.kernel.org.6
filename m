Return-Path: <linux-kernel+bounces-520626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44FA3AC74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD49163C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDF81DE3A5;
	Tue, 18 Feb 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JFQ/ASxS"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705491D86C7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920678; cv=none; b=MdxnlsxCI1q6WPncWEklqWLnpj5n9QxWBot/hEEjsysTLQf4nCkLUb2xLZIqMudnhSk1QvzmXjVddk0Y1F2HWytZ1uDEv1UZ0ZeZZbGRDMmU8esPngbGfckVaajj/3O1/MAzjVnc83C6k6oGbffiGF/55RhIPvNjQoWM1BvhsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920678; c=relaxed/simple;
	bh=Fc/KruNh8T4raL3lKWRskCYx+88ToxfZwIciprkAUJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5OO2TBkaCvsFIx7FPV6KqGRNCK99f26I1lafyD5fh0ND8cgrBOPjcb0N2S4/mh0yCwPJ/bfiPbr6QtDzlP30+2atd4EwvEqMrQRUqBSo4OJShMQkXThJzqckxyZxu4Nb4lOa+WjswcZFxO/ZxHQy8K1t+28VLBtsXBWRF6Br2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JFQ/ASxS; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7271cc3d73eso1581849a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739920674; x=1740525474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdXXbz+KViDcJGlSldaRjqAtEQyfETaLwe7gw52hDjk=;
        b=JFQ/ASxSJSaOxKw9oLjiE9J34OqDlWUILHBtCVof9kDq8sAfdtvuj03phg+YLKzlI3
         JRqQtoLQ0KxrI45wYFHHgN2b8esex6kDuD4qmeYqUhGGuS/TvTP//w5IqJGDtxHR+YZA
         FGii0c0mCP3wdPbPf4o26E3a3MRhi2tJW3vkaQah0E/1mISOH0z2OQWR0UFfK+EnkEEV
         mxr/1Ja9F2A2HdDBOULoU0YMb9G9kN9rucVzTqU7zHW7gaAM4BLu4NgsGSVbEqDXujWg
         4W9cANZyDAZXoI8WDt/nY/OMoQ8eM7+73CQbtoPPnybvH5t/awToH9OZZOXVu2QWqiMU
         vQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920674; x=1740525474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdXXbz+KViDcJGlSldaRjqAtEQyfETaLwe7gw52hDjk=;
        b=qrpijnl4J7t86oKYmDSS9+pnSx6I8qAxA9UvjuWif1VvaGcL8B7g6koD4HYADPwmWX
         7BchTZ5EW/okPibskUVJ64mLpMKHWvVeEmeVhtCcbuj3ATdOCWbHZG1Pz5xjgGHanRF2
         tNj2XppEBRoFtVSpdim6/BLmpoZW87afXHZAN5D5maJgAaWAw1a2J9n0BxLeoHG3bCVj
         YGq8pTUrG1htZH/qaRVZef+k7kGWKJIZUF9h3vDrbqC20kzCFKp5hL+YIvkE/1aJIfYy
         gDid+LuZvIRhv3RYxSkox+MwoCKlKYqyT0RIkVvqQWmPNA99XaBVGVjFYKYRN2mjQPlG
         BCQA==
X-Forwarded-Encrypted: i=1; AJvYcCUiMsaKM99WxUYvSD+OT3DCb5z9HYz0kKCoxGtP/0yMiOtA9e7hw3RZFpa2NjYSGAdcWBs2QhEYzIso2k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58pc/MZNnzvBZJdOo62uGbXwK1UWcxinpM8tcSENzdZTp49Fa
	lzW3xC2KOqBQ57+5KpZGmXkrNnkZgqU1/dKm+MFmSCeAdjsbEtfKbv4R1c8d6kk=
X-Gm-Gg: ASbGncuu276CqAojyAObggDrxpN2EUNRLWG9QLX680JY1+J6c9zKcaYrx+Kw2DdNwKr
	pXapex8eZrvuwANyAguVNXbvNE564jv3kXsqEj/DjufkI4YwSza/FjC9tP60WAk29FFplvCd/LX
	BvnkdkxeT0/OrU+RqnopZGnlcOEhCAGLWFpkxcV1RhKFRQQ6az00LLY4+RHxGChXZQ2q8TRHQpw
	l2L1eSDHuzII6QtO5Q5FymGwSPxBXTKvDISa4yGeHbQXRCxnZhyOAfZ/oBqguj8j35jHs147hwL
	8hR3ilFlk6aPqXNJPsOvCIjKHipWC7DkwgZ2k6TUOayh8eY=
X-Google-Smtp-Source: AGHT+IF7oRKpCGN6j69ZLc8G2JNQTQddNop9Dt1GJFV3FyCUOggPoz7eaolskYMdgMWyLlpjj5sgwg==
X-Received: by 2002:a05:6830:6684:b0:727:3303:7ea8 with SMTP id 46e09a7af769-72733038088mr2860011a34.25.1739920674577;
        Tue, 18 Feb 2025 15:17:54 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7271f7c5ba8sm1803129a34.32.2025.02.18.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:17:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Feb 2025 17:17:46 -0600
Subject: [PATCH 2/2] iio: adc: ad4695: simplify getting oversampling_ratio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-2-57fef8c7a3fd@baylibre.com>
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

We already have a local variable that holds a pointer to
st->channels_cfg[chan->scan_index]. Use that to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 8721cbd2af34c53f0cea32e307b9ef2da46b0cfb..b38d2b3ccbfca10dfe5b05c3a96ba00f8838b89c 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -1164,7 +1164,7 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			*val = st->channels_cfg[chan->scan_index].oversampling_ratio;
+			*val = cfg->oversampling_ratio;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;

-- 
2.43.0



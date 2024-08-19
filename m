Return-Path: <linux-kernel+bounces-291543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390929563E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE2CB21760
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A3158520;
	Mon, 19 Aug 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1jypdwtj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06315748F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050059; cv=none; b=qb4HT6xnCdOxa7SqHTm7vEicqCly4KjEEHlVd4k3/iSZYA58Zoqwxk90eu4vDPmYf0pDGr+ntTHaI8HbWrlnXYLe7mM8I+v380KrJ3brvb2XflFP4QAIfWQ9A4zpue5jFitmHH3ABrs+sC2T3tZJZ48PHAUTGkpreitIZGxAjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050059; c=relaxed/simple;
	bh=IXqmhsQDt/RO+GElC8x8ywqYUr/3SWcgPZP7XLJrRH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDZbszdm/sI4gGDEfCAanfrvkbbpg/RbVIHiQO99wTemYO/lfFmp3d+hsY1oWKInBw9JMUtNW+9o8TNy7XjT7dwVxvtF1StHHht/cOeNgFj13cDElLG5DAWHPUdZU9ZCQyqHjvWcYTco7iWBBPHvCbMFKam9hOriorZ8tb7qnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1jypdwtj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2c0f35f2so3349251fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724050056; x=1724654856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui2lv4x9FTPWujQRhFdVeT4msHXJUFxc93RUhnH6Vdg=;
        b=1jypdwtjdxhqrXu/8RUedTInpQxj1PitmoA0S58gHDADay5bHn90jP+x0Xba6etA2l
         R+asHeWEazPHWt0I3Pqzzw7FoZQdKeL2AiOQPvkM3UyAa83XuHtOQmYI6yQpC16Cq4J/
         rOWa/2D1EAaF4Q2g8y6aUalaSDyqdroeHcYNtK+3PlzhfV1LctlBsfLmwdCdfE3Rdahq
         BkeFf17pClzhxSBHb7KNY6jIb6sA6am8HUlPbhUURbepT7Gsp3E/8IP7b28Q57T2LWOr
         enPmXbacn302cg7IsCLBXywu1O7hoMMc5ofDjsL7WSJPLFH/zuxiCDmOSXd/DTpAb4Vz
         2S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724050056; x=1724654856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui2lv4x9FTPWujQRhFdVeT4msHXJUFxc93RUhnH6Vdg=;
        b=Cb24og4VdEg2K5vfixj98MzM/FcKPqaJshSlmb7YkDd/scfHoIErBBpMKTbciQESB/
         1qmP6OpLFaR+v8ypLA/VE9QlK4Y9Lr6hYh+++HBuAf1yT/AlB08Ejgma45xVrTLIwKrr
         rZaizTDS55FCht60JzzbH++AQ7fIm7BfGuzET/1LUMFc0wqDtHTvYdV3hIDgnST+EGUD
         Tlo12HkiVBfb/IDduJP8ZF3F7ELvMMbNmAjuGHLZeQKFYIEaJ0I3GV/F5yv27P8qWXT+
         GxvWEQuPpvihYIHc75gWQfL0G0XqUc/yBKP2Njkwq5J/p8A7mGIyDr23wUXKR/XZlAC5
         VP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHLCRPjYwkV1kzTZV2A02XL7FgcLC/rD8yVmQ58v9esEwbOrAb15mhy4TXil0bGRXEtYQLDyDqd8irfYNpWgLw1DB1VdSmgHj45Bsi
X-Gm-Message-State: AOJu0YyUZnOKTOltZqDyqV4ChdOUAXGYKJDCHmn0dtaq0ZNr8NWH4mko
	Zes4PJehrH88FQJhd3uA1in4whcgX9oC0g4jQRLkr5SJdyjQBFO0pyk5AdXiVgeSx7eYXRatuje
	g8QA=
X-Google-Smtp-Source: AGHT+IH4B1cciVB7OI8ow2IPgAdtaVxaiulvsVvuv81Mby5vIFPvQVAHDd0cmEg8ZBhdUoQ5hAgPsA==
X-Received: by 2002:a05:651c:b10:b0:2ee:d55c:255f with SMTP id 38308e7fff4ca-2f3be778bacmr40875561fa.7.1724050055727;
        Sun, 18 Aug 2024 23:47:35 -0700 (PDT)
Received: from neptune.lan ([188.27.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6bfcsm599069966b.28.2024.08.18.23.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 23:47:35 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 2/7] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
Date: Mon, 19 Aug 2024 09:47:12 +0300
Message-ID: <20240819064721.91494-3-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819064721.91494-1-aardelean@baylibre.com>
References: <20240819064721.91494-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7606_scan_direct() function returns 'int', which is fine for 16-bit
samples.
But when going to 18-bit samples, these need to be implemented as 32-bit
(or int) type.

In that case when getting samples (which can be negative), we'd get random
error codes.
So, the easiest thing is to just move the 'val' pointer to
'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
preparation for 18-bit ADCs (of the AD7606 family).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dba1f28782e4..5049e37f8393 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -138,7 +138,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
+			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -153,7 +154,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
-		ret = st->data[ch];
+		*val = sign_extend32(st->data[ch], 15);
 
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
@@ -173,10 +174,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad7606_scan_direct(indio_dev, chan->address);
+			ret = ad7606_scan_direct(indio_dev, chan->address, val);
 			if (ret < 0)
 				return ret;
-			*val = (short) ret;
 			return IIO_VAL_INT;
 		}
 		unreachable();
-- 
2.46.0



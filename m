Return-Path: <linux-kernel+bounces-353131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE895992937
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43A21F24017
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC151C0DE6;
	Mon,  7 Oct 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1LyWopO2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC01BFE1F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296946; cv=none; b=NYLq/TMDYqbef3JE0LAJXzk/PeUrz2Wn/dP/KgulV2pU00gpaRNdBNMMC1vdC0mCAvQ7rMmSDEKykQSTIq8GFmMJdw8dJZZWMWjHeSwZq7I3ksfTRswYIebIrqge9iqOsTK4fwZpMtK7wkDhQDQGTUJU9+fzr5qaeVwfAStqY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296946; c=relaxed/simple;
	bh=FxehuOAe3fC81LLxRKkzjr5CloSnOPsrRy8C4Juxy88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGk1Z8dMLGrwzf+ZHCy98bzn43TUhLl9Kb4UAQUVa3JKLYm6oKQ0t1RBkk2qMGkJFL+8SUPKZbOzhhifszAFwvqN2GO+yOz/DPGAZHq0MikY/J3+FdAo5cxLpDa0qsYGmDcKnJX6yphRIrhfTpnomvBL0aP3SlvCdlODNN4QTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1LyWopO2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso42691395e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728296943; x=1728901743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLGxBuGIMJzA7rhlX8B2E7xTcOSGZWicJwrfW/WvPLw=;
        b=1LyWopO2e7/a+M3iWBuyUhe1LVYD+rD6j5PDVP11dqXUENemaTHhKOsyzVUBc9rI8j
         Dz2gwLDJW8qpLIGtG7gRTHkZGsrSVpxTnfkwkB29+Td5WXdNvYiSzE+0PDV2hzyciifW
         oM22WBRTl2wzryvCuydlMuL8Xi4Wp/KhVLlWCoXOXcgSgdiWg9AwDgtk+UNTg9v9UPuZ
         sR+EyhA2jJNfQ8eBxFnfy6beYR7vuZc6QaVRFhwy2sOlu0v89k/EEHR8csvCmImg+vJZ
         042QTwfAEMyvK5WOrSaj4kKwf77j2siMt+lMEBn1DXCJqCAe6wI/VcmBt50hVBctXKtt
         m4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296943; x=1728901743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLGxBuGIMJzA7rhlX8B2E7xTcOSGZWicJwrfW/WvPLw=;
        b=Uc5POmoJKg29QAz8XvwwRqK4lKJIPmjhMcEGb6CdF92XFqKkl9mAKad49uTdIlvQ4/
         gnNhVjYTdMNjcp5pWsZQNybx9Vmj6AeZc/dTCon4Z0AxBtZrsKD1WDVzwUz5E+MKKrQU
         aI2qxnHlp+JKZpMu1Mka+16F0N4hvsRgN9oIIjhlAGsKgBHPHZbJm28KpMxCMlktsUZ9
         dv/TEgCiHY3hl/khlFa3LDwrJc6DbQbspB+/yi/t7DEubxJ4pId1lVmmyyW5uvFoWzYt
         Iwj+pdoJs6jxPuazaU277c3ohpHXdw6C0+Nuq8ZAfBQBzn0HkckAo/Dbw4437aOuvm+Y
         fzyw==
X-Forwarded-Encrypted: i=1; AJvYcCVXGykMXTFRkNyed8Zd+Zgera/8hJOP1EHUKBWU/1X83FI8cHArvMOZYz/F8uo1Rkb6UYO0HwR3W0XhfWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7P0Fr1WDkN4t5xK69mCjz5i7Gb2qc211HH7uDDU9a55ua7hg
	kLZVhcYqhhbV+Mgj2/knRuvwamC+PiUMxsuWPfM7MDFWD7ZsgeJCo9AAZizPncc=
X-Google-Smtp-Source: AGHT+IF41kZLC3dxLflXQrHt+uBj10nmL9Bu+3rLxK3L7MJwqig6tgyGiGBNauYCrEn5Aja9udoPTQ==
X-Received: by 2002:a05:600c:3ca6:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-42f85aae4bbmr75809445e9.12.1728296942807;
        Mon, 07 Oct 2024 03:29:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e89b42sm69850855e9.13.2024.10.07.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:29:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: eic-sprd: use generic device_get_match_data()
Date: Mon,  7 Oct 2024 12:28:59 +0200
Message-ID: <20241007102859.35602-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no need to use the OF-specific variant to get the match data.
Switch to using device_get_match_data() instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 2dd0e46c42ad..d4bf8d187e16 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -10,8 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
 
 /* EIC registers definition */
@@ -617,7 +617,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	u16 num_banks = 0;
 	int ret, i;
 
-	pdata = of_device_get_match_data(dev);
+	pdata = device_get_match_data(dev);
 	if (!pdata) {
 		dev_err(dev, "No matching driver data found.\n");
 		return -EINVAL;
-- 
2.43.0



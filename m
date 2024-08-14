Return-Path: <linux-kernel+bounces-286177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EBD951799
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694EF1C2107B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C01448FD;
	Wed, 14 Aug 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dnWNNPyk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F9143866
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627596; cv=none; b=Dhwj4lh7ce6wHyzwkU7bzGJH4uZ7kPgAZ5a25EK9UMDCuQWpTfdeBeYKANUlHdLSlLK/JeT4sI8o0CHOF7/tJf5a8TWhEULOYj849BI48eeIye1b1oxAw9YDELYIedeGpD33d1COMUJ9Bh1NxHE4ErPfa6j5D6GpRH0dLFKziaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627596; c=relaxed/simple;
	bh=XSd3GC/vD6GigFRdUJdwPYvqWhn/hvMNDJd+SrcI9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULjMtay+QpdmJ7jZBN7GZWsg83zIggE0SnYhCbFRDeOIXhC2MV+EkEkpByMGJ7i7A15fUocQw6czYAExAcFWWM/3bPaLtBc9z5sUaeyxzWZL37R0ECMIE86tkeyE5RyW4i46oJv0XiK88HhqCQRCB2KT2L/yYIBflGcLjtpgZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dnWNNPyk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428243f928cso44571235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723627593; x=1724232393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWFR1dplhqturIHla+8uDdf1jPTzY9s8gn8hBPScqFE=;
        b=dnWNNPykRvB1LtbEuToqFPdxu9fbVJ0iTH6/j/ziqNH2sZjyx/qY24KXweAZYnGyXR
         6SOkenf2Gw6xAYfHsZwnLMszPGL56U7+0cOcnWbyvx68koJkevwam3rYkp8P9SwLiqID
         LDNZM8l2yXmjb+1ZyqWGW2Ot8uwSLzpTSQcn3iubtrocWf/Ov00dO4uEyq2trQRl7zD8
         Hkgh6Ax4ymKxpHV+8KyW+dlmgZSDzxXkIEJ5RoXyQxfiR1s2+BXLQPtR6gjp2ZkhycU7
         MyamQVXrXJWWaAaMx/aSxeYutmnCf+KcbbiT2lQEUyNGTYyaQVf+dFjGwEYfrWEAiF+r
         XPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723627593; x=1724232393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWFR1dplhqturIHla+8uDdf1jPTzY9s8gn8hBPScqFE=;
        b=u6Z4SSgNP86xZ/0F6fK9MEzuolMj8uXSE9xrmSog+ZLV9p1Kf5TQ9yheYrRvWIxHED
         JVkRgaxXwa5o+K/I6so80QWbOm5jIySsTtYdFItgYC3Z1LLtJhZ+8l/P5lq3KULzKIYy
         bfBG0zjeG2+WTAEuCTnGqOzYiEet2+N53ZoJBkRLeqbyGXvMJzq7cg/UvkU4bljh0iL1
         Rtph+FTiP+UYmTG+ycOHau5XNVZGdMpl6UN5LTaQpwmKCyc9dhclatIMKjC7Tixr8hUH
         CT8XLqmAFsMmjw2RiH6dqwTcN8pB4h5vqLh0pclRBc6QQ7Y5Cs9rP1pCQToHuYcyTEW3
         ktew==
X-Gm-Message-State: AOJu0YwfnslxSsHDgByLpl2MTR/vP7HyG994Z1uIDwFPqtTLXHagcgzM
	+Dj8aM2+PD2679BezlZWiDZCs+wFjPMeYv9NDuTSsMsAiEcmi9+VZ1G2E/4R8BI=
X-Google-Smtp-Source: AGHT+IEAGyFBL2pBSyxaBNonkxJ5lI432QOs6vR7Pu05vSXCEXdHgmHgADCTB9ybYJXCbAOKll2+aQ==
X-Received: by 2002:a05:600c:4455:b0:426:6416:aa73 with SMTP id 5b1f17b1804b1-429dd2364f4mr14857245e9.12.1723627592824;
        Wed, 14 Aug 2024 02:26:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e78:fb96:21f1:335c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded80241sm13846895e9.48.2024.08.14.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:26:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] iio: dac: ad5449: drop support for platform data
Date: Wed, 14 Aug 2024 11:26:29 +0200
Message-ID: <20240814092629.9862-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no longer any users of the platform data struct. Remove
support for it from the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/iio/dac/ad5449.c             | 15 ++---------
 include/linux/platform_data/ad5449.h | 39 ----------------------------
 2 files changed, 2 insertions(+), 52 deletions(-)
 delete mode 100644 include/linux/platform_data/ad5449.h

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 4572d6f49275..953fcfa2110b 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -20,8 +20,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/platform_data/ad5449.h>
-
 #define AD5449_MAX_CHANNELS		2
 #define AD5449_MAX_VREFS		2
 
@@ -268,7 +266,6 @@ static const char *ad5449_vref_name(struct ad5449 *st, int n)
 
 static int ad5449_spi_probe(struct spi_device *spi)
 {
-	struct ad5449_platform_data *pdata = spi->dev.platform_data;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct iio_dev *indio_dev;
 	struct ad5449 *st;
@@ -306,16 +303,8 @@ static int ad5449_spi_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 
 	if (st->chip_info->has_ctrl) {
-		unsigned int ctrl = 0x00;
-		if (pdata) {
-			if (pdata->hardware_clear_to_midscale)
-				ctrl |= AD5449_CTRL_HCLR_TO_MIDSCALE;
-			ctrl |= pdata->sdo_mode << AD5449_CTRL_SDO_OFFSET;
-			st->has_sdo = pdata->sdo_mode != AD5449_SDO_DISABLED;
-		} else {
-			st->has_sdo = true;
-		}
-		ad5449_write(indio_dev, AD5449_CMD_CTRL, ctrl);
+		st->has_sdo = true;
+		ad5449_write(indio_dev, AD5449_CMD_CTRL, 0x0);
 	}
 
 	ret = iio_device_register(indio_dev);
diff --git a/include/linux/platform_data/ad5449.h b/include/linux/platform_data/ad5449.h
deleted file mode 100644
index d687ef5726c2..000000000000
--- a/include/linux/platform_data/ad5449.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AD5415, AD5426, AD5429, AD5432, AD5439, AD5443, AD5449 Digital to Analog
- * Converter driver.
- *
- * Copyright 2012 Analog Devices Inc.
- *  Author: Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __LINUX_PLATFORM_DATA_AD5449_H__
-#define __LINUX_PLATFORM_DATA_AD5449_H__
-
-/**
- * enum ad5449_sdo_mode - AD5449 SDO pin configuration
- * @AD5449_SDO_DRIVE_FULL: Drive the SDO pin with full strength.
- * @AD5449_SDO_DRIVE_WEAK: Drive the SDO pin with not full strength.
- * @AD5449_SDO_OPEN_DRAIN: Operate the SDO pin in open-drain mode.
- * @AD5449_SDO_DISABLED: Disable the SDO pin, in this mode it is not possible to
- *			read back from the device.
- */
-enum ad5449_sdo_mode {
-	AD5449_SDO_DRIVE_FULL = 0x0,
-	AD5449_SDO_DRIVE_WEAK = 0x1,
-	AD5449_SDO_OPEN_DRAIN = 0x2,
-	AD5449_SDO_DISABLED = 0x3,
-};
-
-/**
- * struct ad5449_platform_data - Platform data for the ad5449 DAC driver
- * @sdo_mode: SDO pin mode
- * @hardware_clear_to_midscale: Whether asserting the hardware CLR pin sets the
- *			outputs to midscale (true) or to zero scale(false).
- */
-struct ad5449_platform_data {
-	enum ad5449_sdo_mode sdo_mode;
-	bool hardware_clear_to_midscale;
-};
-
-#endif
-- 
2.43.0



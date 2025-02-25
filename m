Return-Path: <linux-kernel+bounces-530937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376AA43A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842B41885D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01172627F5;
	Tue, 25 Feb 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OrcFZeCH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7171519A5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477138; cv=none; b=EqjYknOXYGIfpc5l+6DFmHYkDwH0VH7ZT5/eiduIG0zMp4MXsaw9zjeh4z+Lz+c+j6Hn7KXnBI2NeorhOX8J+D2hStZ3IROc7fpW9AIsSyruPROzzeVoDpIVuCZqXjALO7KrJ0j1Et80Zec+fB54ELCALz+ftu0mMgON5BOn1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477138; c=relaxed/simple;
	bh=XARi+YZOioq2dSvOxXxvznWL5FQ8OEc1/3zPe3u8PFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXiOdZxZjijFOXnIIWuNRVtx5b1Uqy85aVM9MqKJ+Ok0ngr7//lHaoYyPiR0XD9O2xpWlijoiz/1+bmEwZTzQxCHS87aSypEszdpJ/OiFtSlIHy6x9mwwdiTdUws6hCBJtpFxGM/TqiBXgcA3g7ZB4zeZ8p3054pADEHla3MzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OrcFZeCH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so3896981f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740477133; x=1741081933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5GHjrvlBNm+Fuw+mlPf6/5PhsQQqF/yxmPzmUGmJOQ=;
        b=OrcFZeCHLhNiMi0Ap7Y2NJXa5TBrFHRWss8a9EAo/vi2Ev03jWWo4Ftg412YrzC8dm
         /r5WbvKciPUJdNGQ15IVEJL+Du7SdMYoqAwZuBNH+Izw3kaueSyspIyKfSkJayJQmwBU
         V8AKNUWAm7umSFgAE2woUCi84IpAsorwTJuQzNFhCgBsj0ATmXpzPI3tUCKSmLS7u+RU
         TBdDWVQrmRNf4gX5q4GseGXBEjp+WQgrYKB4N5ar48GNULTWOrftCg7XfrArDMkdSepv
         daxiZTxEmo4xVuHj6qUpTOKXRbLZ8ZiFxiULQEs1F0VIA7b/ep+W4CgAjEO/hVdmiRgQ
         RsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477133; x=1741081933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5GHjrvlBNm+Fuw+mlPf6/5PhsQQqF/yxmPzmUGmJOQ=;
        b=sd2aodmqp1aA//BStJ7VNy0R+Eh8JKrA6Ml7ZkpPMsFtK0GxlqkXfSA1cK1z0iNM2B
         W6i+9XVc3gBV8uErLb/pvRcVPWkZVfG3Zyhh5M7sRTPyqZBWduzv1MQKxj6EbLjlMlhg
         SyGUUdk7A1H6TuENGRyx9VQbiG3sB5mBCyjfRHgT09EzDDw6HwhKUo6EkWt+hvML15gM
         sEiObZ4vxV3FQ03Q049DuC+eJSY4+davZ8fM3GQSjcydtm5nSe1Qz1gwfbMBIZUDaB3v
         FeN+T9avlD2he+qYewihLr5uF6+Ur9TQxuqSrDk6E9NTz71NcPdVj989QUfayUwu5qyv
         yhSA==
X-Forwarded-Encrypted: i=1; AJvYcCX8NGK+22Iiic6tKCPCcfxQPel8NNrYo83vWFED92tq2mXLGw+wv0jydyORLHcKyvvBKW8yJG+88/47EWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISujvOHirzE92BAaFZMSFhLdI1PxQ/rtHLxMb83d1Od2XEAuA
	WmsOmNWG+Tt59+B6tu/YNZDKVATZ0PcgdsW5MDyv/ZIPQqlqjoCGusegc4qcbbK+dKhLb6Ie9zR
	9E7s=
X-Gm-Gg: ASbGncsneZ5/+EEiD1xrnXpzG9buj+mXTy/3KEHU9bp03wr8I+w220ATF1ZX7fgyp4Y
	2G2Sz2dHGsTc5OCM/ynWVXN02t1EkrotS6MxdRO8kgxc+Fmn1uzX9CoYtsgYmr6idR/FwXbnkPz
	LfXTBbsKCpoFkydQhWpPZjqyRXobhy/yUOtli0OtbNE5mt3w3eoLvfIVh88GFASgPimTfcuyHF0
	XRDdTl9pXlMYkNVb0egFDZgl9OPgk4YuX/YbGqQtIVNw/+l7t4jFln6laxGY7B+sJTdnFDIxVWE
	Q3fteNnFQKmP0se4nG3Zjw03yw==
X-Google-Smtp-Source: AGHT+IHI72au0X7G/eU3XJtp8XN4UP3wf3anxfHDJsGzVLMKwudw09vKCm6cjU/0t4YhXRSZTAfuLg==
X-Received: by 2002:a05:6000:186e:b0:38d:e572:4dc2 with SMTP id ffacd0b85a97d-38f70826839mr16248954f8f.40.1740477133387;
        Tue, 25 Feb 2025 01:52:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:15ae:2cfe:447a:4a32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fbef5sm1733781f8f.90.2025.02.25.01.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:52:12 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] gpiolib: use the required minimum set of headers
Date: Tue, 25 Feb 2025 10:52:10 +0100
Message-ID: <20250225095210.25910-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Andy suggested we should keep a fine-grained scheme for includes and
only pull in stuff required within individual ifdef sections. Let's
revert commit dea69f2d1cc8 ("gpiolib: move all includes to the top of
gpio/consumer.h") and make the headers situation even more fine-grained
by only including the first level headers containing requireded symbols
except for bug.h where checkpatch.pl warns against including asm/bug.h.

Fixes: dea69f2d1cc8 ("gpiolib: move all includes to the top of gpio/consumer.h")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: https://lore.kernel.org/all/Z7XPcYtaA4COHDYj@smile.fi.intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- don't include asm/errno.h: it's already provided by linux/err.h which
  must be included globally for this header due to
  gpiod_multi_set_value_cansleep() needing it

 include/linux/gpio/consumer.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0b2b56199c36..824a1717e6d2 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -3,10 +3,7 @@
 #define __LINUX_GPIO_CONSUMER_H
 
 #include <linux/bits.h>
-#include <linux/bug.h>
 #include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
 
 struct acpi_device;
@@ -185,6 +182,9 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 
 #else /* CONFIG_GPIOLIB */
 
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
 static inline int gpiod_count(struct device *dev, const char *con_id)
 {
 	return 0;
@@ -549,6 +549,9 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 #else
+
+#include <linux/bug.h>
+
 static inline int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc,
 					       unsigned long flags)
 {
-- 
2.45.2



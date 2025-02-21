Return-Path: <linux-kernel+bounces-525751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76653A3F44D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812C6189D44D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558D20AF8E;
	Fri, 21 Feb 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jbRH15hZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FD1EB1B9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141017; cv=none; b=lRhRb2/3ZpumWLVIEYWuABGDcR99m7TvmQEjU5rmlg2aOBRIwDOkJGoK9a9W3OQM9uHa2gQXF6cgUykqm0LW96b6CuP/7GkJwWjSdFun8lPOysbBHjedn7suYfWywNHv+W95EbddTrYl6lM2M9Z2thyIjIWpQGvw3NiDxfmUVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141017; c=relaxed/simple;
	bh=zwIa9LnPM0/7Lq5mdjdr/aLybJgHHvLha6qt1CTUVyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzB8nPOH5f/RenTt0wcAR+JPZJUr72e59EhXUefHVu4J97n+71tlofJoLl9n/YdOP+xLGRoKsXmb2ZznB6x3Mlf2W7QN2sSm8l3Zo0A6/qqMZzhbX/fqXqH2tcEYICBGByA/gqtaoAOHe/XZMi1dgy31qkfbj+D0rhyUHVTbLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jbRH15hZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399deda38cso12361295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740141012; x=1740745812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtqJEnmJyWeV1XPhylUERQv6caREg8pEVtLLf8kPmng=;
        b=jbRH15hZaZ+ZNRj4KGSAp9nu17Fh8EBLRTRgYa6oZe0esyeeKh0Fd9EWaiCvT6eKH+
         fmFVQzEtMOv4GHy9YggRQost4uIvDTDlrnKcUkJusLM7Qid01vAaqB5gZY4n1J5+afbs
         0uajak1HLAQXlwJcrN3jdmz0JunFcDaU9+jF1grBeiSS/9afSjfkbF7DVB++XyCZUG87
         c2NTNIV0mS5RBaYWFx1no8nsTLygliR2U0UWel3X2lsEbBUKgkr94C5Tu8s9pVabQNzG
         lMFQpsWtIl8Rf74Z02Xw0UkQWeKLh+zX++Rta3MHChy+SEgFrBbkq8sflJnBCUmsW2g+
         Zjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740141012; x=1740745812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtqJEnmJyWeV1XPhylUERQv6caREg8pEVtLLf8kPmng=;
        b=FRcfgLGJv/i2eUdQVzEIlXJ+5uQHHIF5kep08F2L90oT2gTlgOC4qiaLOu2kXGChsd
         BbLs+u+Qz2W0GlMswsnmZaJ1naWRyEPGNAZHeDkDks5krjbMWWJh0sEAIB7/t1D6bJjW
         /qd728z2rluAm32noms7B2lA9TcXu7v6NDAI3xealMwHevDyffBAYKqHkc33chP3ygK8
         F+R+9IHqsGAFrdtkqdBtk6wy2V/Ev4J7u4tQZOrGLjrtgx0XH8tkPUk6SCuw5kF1VXec
         XPHmLkJ4Ngc1m0zxOy6qdVxfSpNO4FJUvZb41hwUl/S1D5uQilb4sOACz4VKFlxfQQDr
         DZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUJlR9hcN+wEnbMExnRKGCKCHgY4X6AvM4pWE552mUEFP6gtWcblB9Jl2Od+l9Y2aiLj/Zl0MpDSrK2uuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSA61VFFgvm+1GjU2qDl1S1M03kpulTrSPWlsxad2Mc2wmS3S
	h1UYgrOCbE63YF8ZMhvRC+7tK/2gN3YzteaQns2+5lyOknXBOOEGm+yMEfROJPA=
X-Gm-Gg: ASbGncuQv6lqQbHlJI/MakYHqfB73k63yu2veDrvrUKMILVnein/nNXK6jVEGKIdxCS
	FmhsS/wskiHG8uZT2lc5snu55yaROOEAZiYimjCNaATShuZ2kZpZATD0LSdWS8qiACjIEXPQVTz
	3d4OXNWULyGQMAeDb7xHo7I/OJIL/zF7bimLQaMqqLofiEPV68B2UCo+rYvfXD3tZOUc5eEi3AZ
	6a6OHywKaLkFUG+VALkAPSb8ZJrdUqxEneuNVm+AvKvNWz+ptA7wbzJUD0XZFWzofgOeLRdj/eD
	OB2QRTOniseQGjA7iyi3oswGPQ==
X-Google-Smtp-Source: AGHT+IFXw8oXcA07bB6uKu3QA6RMhy0mON/qnca36kKS/4X4msS4PkMCYOZuWLLD1PSvJnv87kbkJw==
X-Received: by 2002:a5d:64a9:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-38f6e95af71mr3261259f8f.15.1740141011591;
        Fri, 21 Feb 2025 04:30:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6cbc:77f7:6f0e:5a7c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd51sm23276274f8f.29.2025.02.21.04.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 04:30:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] gpiolib: use the required minimum set of headers
Date: Fri, 21 Feb 2025 13:30:01 +0100
Message-ID: <20250221123001.95887-1-brgl@bgdev.pl>
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
 include/linux/gpio/consumer.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0b2b56199c36..f53cd8a1eb1e 100644
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
@@ -549,6 +549,10 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 #else
+
+#include <linux/bug.h>
+#include <asm/errno.h>
+
 static inline int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc,
 					       unsigned long flags)
 {
@@ -615,6 +619,8 @@ int devm_acpi_dev_add_driver_gpios(struct device *dev,
 
 #else  /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
+#include <asm/errno.h>
+
 static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 			      const struct acpi_gpio_mapping *gpios)
 {
@@ -640,6 +646,8 @@ void gpiod_unexport(struct gpio_desc *desc);
 
 #else  /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
 
+#include <asm/errno.h>
+
 static inline int gpiod_export(struct gpio_desc *desc,
 			       bool direction_may_change)
 {
-- 
2.45.2



Return-Path: <linux-kernel+bounces-517414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07110A3806A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7504A7A481F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF0217711;
	Mon, 17 Feb 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TfwCg1XQ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A41216E1B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788769; cv=none; b=mCPrtHAkEdgB7buAF06CiwPMiGn4zJx5SrVz1EJa/J9BVDRzAjKagy/bHTyHpToCpUw6atjxWH9R14gm0fDiNlZqsJ0zyo/idzffOaQ5KI88zEzIULSzjehGxZW5LEWYkH0I2nfsyfvY/urQmV2qFhNotVk5X4AOi2zOs4T1ZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788769; c=relaxed/simple;
	bh=vUF/NdChsuF8RX0PL62paJYNXihVr9EN9nW0GqUH6HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpcmtHRUVTvdWZwz1nVHA0+gXyOEJXDWJ+GL+2tttJBaLS6/Ovj42LL0wYSdDaNUEJZJFvkfMYMQo1HqTYbdHQNoXkwzeaAZ7ChIGjaTOxx/2lWnwDBHWHkOJvwJOF6Z2M3M+nOYp5CxJozJW6Y6womjh173wtgAvPvqjXxn1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TfwCg1XQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4396a82daf5so27132405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739788765; x=1740393565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq7tnHLSofTfA2piDpZZwNRhnA5jRBNdKKxEFfHW/ec=;
        b=TfwCg1XQP43BW6ofJ60nIlueVJdmsPmenMs08VlvdQE9C3JbYJEn4aIFC4oCP0fUtH
         YGl/D/ieSMfQEGk+nJrc6TzQU7Eot7FgmOjMMTOLIfAyIB4ZUrQYUBYdYkCF1DA2lbPn
         ysE/qSFXDFVzq/7rP85BVHEvB+jfNDyXeJeyPFJXOE+kxCpuheiF7EizCHq4UZkxC7en
         qdl4O22yVHnzMLIQqlqrsIBXhRw3VZVWWdS0UGJMgzn885GD6IpRHi+nZj7Pa7+j6L8s
         xS2oqHJmzJWJ9QP0TRQkgCFUIhTbTnnc4xD40K9wB7JJvxWwamshG1dmt/zeqR2eDrQ8
         kzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788765; x=1740393565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq7tnHLSofTfA2piDpZZwNRhnA5jRBNdKKxEFfHW/ec=;
        b=WEdSBf/39/MRBbbSjsWgNh1Lp/s2G875zAhLcFko6i3vcwHzs3X4Z6j4XkBCOVTUDP
         Q1zdPV/sR/bZ8ZrOiimM6LRyWOA7b/poeHFS2xaHlYtwd9CuRTIKtj5R+l8nlP+krecO
         GP6PvN943hwXL0qVwmLKCFl+u5wbbFvxY3Yj/pUm+ZNiyG+SYxEQgCFgmZWj44TDC/qB
         steRaKXlcZPKZWuD0Lg4mgbroUhFGZQnQCNT2XfaaD51d3a2X5Y+Dn3euh3xyOFvWM44
         9A6aVIKS7y0hLSKsP2c5adnlxwE9QpNlJXMnXf9O9QvAqxn/O4YzZjCdf2LkEsJEL1+v
         K3dw==
X-Forwarded-Encrypted: i=1; AJvYcCUz4d0ki++GmrbqI8NCh4PVaQ+gn43nWsHbu1mvH4Uzq0ahk1Y2p40FpcZyfxpY+zSiszoFhe+ktNxM2JI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6rFc5aSK0aiNG458w7cIOZYgDfU+jVJTzL9ZMTHcemFBQGWS
	RJMnfDxk+oNPhVkMfFUrAm+kZUu7CGz6c7OoDhlQ+eaBQpikxR7XH72rrxrjwpy1SUBQhaVSFh/
	IvpE=
X-Gm-Gg: ASbGncuzPnnQWF9i+/2JQ9mwWmOGqrV/bmzdDyi52fw6Xf8GAB/IXiaRmlhBD5n2ve8
	8fW0Jw4G4z6JO8Eorq2mtndlc7ygRCAUTwABdUGn6KVdaybEz4nVWtAL6QT9uLKKHhaprAoUmr+
	KYyZ+bsfWixPOedh+bBlbDldblvxYEJD1FOi2QlY5EMGreX+H3jqZgDdsU1+E9yu4K/4qW8WXaM
	eiU41NnAcV7zwnY17+ljv2lRRgw3n9+h5Ge+aDxq0fVbnRbpN2giSQrFzvrEYwIyvBO3pK3q+W4
	HxUwuYzFFoK8
X-Google-Smtp-Source: AGHT+IE4CNwnlKoha9ADPAeKHqx7QY4/pSOdlR/jtGXh8ZGwx2i49taknc0Hm9Pgs+7Gplgq0zx0mw==
X-Received: by 2002:a05:600c:3ca3:b0:439:60bc:71e5 with SMTP id 5b1f17b1804b1-4396e72aac4mr73128495e9.26.1739788765080;
        Mon, 17 Feb 2025 02:39:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8707:ccd:3679:187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d1f2sm147990095e9.18.2025.02.17.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:39:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dipen Patel <dipenp@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	timestamp@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 2/2] gpiolib: don't build HTE code with CONFIG_HTE disabled
Date: Mon, 17 Feb 2025 11:39:22 +0100
Message-ID: <20250217103922.151047-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217103922.151047-1-brgl@bgdev.pl>
References: <20250217103922.151047-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hardware timestamping is only used on tegra186 platforms but we include
the code and export the symbols everywhere. Shrink the binary a bit by
compiling the relevant functions conditionally.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v4:
- rebased after fixing conflicts

 drivers/gpio/gpiolib.c        |  2 ++
 include/linux/gpio/consumer.h | 36 +++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f261f7893f85..65ca749a1078 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2906,6 +2906,7 @@ int gpiod_direction_output_nonotify(struct gpio_desc *desc, int value)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_HTE)
 /**
  * gpiod_enable_hw_timestamp_ns - Enable hardware timestamp in nanoseconds.
  *
@@ -2971,6 +2972,7 @@ int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp_ns);
+#endif /* CONFIG_HTE */
 
 /**
  * gpiod_set_config - sets @config for a GPIO
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0dc49b5fca5c..0b2b56199c36 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -114,8 +114,6 @@ int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
-int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
-int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 
 /* Value get/set from non-sleeping context */
 int gpiod_get_value(const struct gpio_desc *desc);
@@ -347,18 +345,6 @@ static inline int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
 	WARN_ON(desc);
 	return -ENOSYS;
 }
-static inline int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc,
-					       unsigned long flags)
-{
-	WARN_ON(desc);
-	return -ENOSYS;
-}
-static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
-						unsigned long flags)
-{
-	WARN_ON(desc);
-	return -ENOSYS;
-}
 static inline int gpiod_get_value(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
@@ -559,6 +545,28 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 
 #endif /* CONFIG_GPIOLIB */
 
+#if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_HTE)
+int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
+int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
+#else
+static inline int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc,
+					       unsigned long flags)
+{
+	if (!IS_ENABLED(CONFIG_GPIOLIB))
+		WARN_ON(desc);
+
+	return -ENOSYS;
+}
+static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
+						unsigned long flags)
+{
+	if (!IS_ENABLED(CONFIG_GPIOLIB))
+		WARN_ON(desc);
+
+	return -ENOSYS;
+}
+#endif /* CONFIG_GPIOLIB && CONFIG_HTE */
+
 static inline
 struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
 					struct fwnode_handle *fwnode,
-- 
2.45.2



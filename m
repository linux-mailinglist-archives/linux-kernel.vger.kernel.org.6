Return-Path: <linux-kernel+bounces-383192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC89B1852
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C21A1F21EBC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DDC1D63EF;
	Sat, 26 Oct 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="znc1qCEv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034271D47DC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947521; cv=none; b=kIGs9m5zk+k6PF/4Z+QT8Z0KNSKfbtpFXYV77bJMGGRa8pfvkTaTraTNPapCA7aD2+ltLtDfGfoWr8VEOFQv9LNTgrFqwbGmD6JcHH2/qPTwoCZ9MINPWgYkrQWZN0ETEirGwJVIPa7hkEepCstDuyacQy3R/xiV/pCE8QQ5INY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947521; c=relaxed/simple;
	bh=3eGsWj3tldB6ErshJTowvNjw6P+DOV6RwonJQjhOJvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eool+65Pl/0Cxf0vlxeD+/haHyDjDozkgckYl2dpZAfPg0FWln0ihbaON4L9WlfY/nMGA0H0/iljeyLLVqpg2E7V4ZXXIbp338quCL3jfI8f571yP4V3vwByxWqsspSkreEYiGqYc+dTH92gM6Bz4OC1q6O03/RMDej5ujUyh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=znc1qCEv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431695fa98bso27740425e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729947517; x=1730552317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6mBZytrDKEzQaEmUgMpFJx27tSq4OYxz5Qwnw3leeA=;
        b=znc1qCEvoqvZ4X0OUcIqNH1SYNHH/QAzD1uOJn+qGTjUd1AVzqHsdWqhm+RkokxVup
         3gp1HoYs/MmlkIH1yPpFGDeLHRAYMytS69xtynz474SI8y5ZR+isjEnBZVnSLHJSYMjz
         oL8FLCecxHie26xL7YOWktne53FUiyXaulXXNms1YMJqNF/dqmCsjJXWf3Defg0LF6iI
         2m4m58dQLdQBha0WPk3oSulOuDkkWJ5RLsuQNpi5V2HRkK0H6w73rZTcawYwpAAhvTVo
         FkiSnQCJ+z/UaU7RJSq+tLgVx5wcmDiHFOMY+/IQQuWUPJNufzSE51vDMg25mwtV2+Ve
         ld1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729947517; x=1730552317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6mBZytrDKEzQaEmUgMpFJx27tSq4OYxz5Qwnw3leeA=;
        b=KmBHv8256RsGorjMTaVWBp9oR17PZIqP/m+O/QKyFsztadusQUIF9xPfXwwzGnEBPF
         Jgn+6wl6vIRDj/VhteDPaLr9330heC4UuEG9cUWSN9Z9bVxrABdpAUvzjbo/z76jSAUj
         KBkTvV5Qwa7kfbpPIz8CZFVWBk8uZGCKdWnLgXUNxZwqiMVt5gWppRC/tyTX7HhtE+Ym
         iMyuwcioBCd4iTBYiGF/PJSdUPgMMPhkxRXtAEhuZUZXg7EA4uFWBeg531V+5kFwViv2
         hLdbVKjL0NNQWum7PZmMbigMs3sSJnPboP5wc5d9bA2LupadNVjAFGsO3ruPCW/wl2E1
         QWng==
X-Forwarded-Encrypted: i=1; AJvYcCVGricigoLD6B0d/qfJnf5X0MRIBEl83NpLKKj4gyE84BUrUtLJbbR2R03SoSKZmWMASkQwqayj9DTe0WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJ3ZPDB4m/wO6Fjn8iiLbj2+94IvBIOXvfqW38a5oTmEhSNs+
	fx/LGwLPGt/sEzmoV3ntKEo47KY8ijtEYADDlyccNm4iNigfAWiwZEFjyFYlSgo=
X-Google-Smtp-Source: AGHT+IETMsEh1wTvqS8LLJnAJwH28gfAqDThFKMHmYJMNVRiZwJXW2BEj+wAiY4AGsS1xAu5l287OQ==
X-Received: by 2002:adf:b345:0:b0:37d:2d27:cd93 with SMTP id ffacd0b85a97d-380612008dbmr2013077f8f.43.1729947517114;
        Sat, 26 Oct 2024 05:58:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:617b:5770:df34:27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a3edasm47498535e9.22.2024.10.26.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:58:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 26 Oct 2024 14:58:29 +0200
Subject: [PATCH v3 1/5] gpio: sysfs: use cleanup guards for
 gpiod_data::mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-gpio-notify-sysfs-v3-1-ad8f127d12f5@linaro.org>
References: <20241026-gpio-notify-sysfs-v3-0-ad8f127d12f5@linaro.org>
In-Reply-To: <20241026-gpio-notify-sysfs-v3-0-ad8f127d12f5@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4303;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JtNYy2XqnFeY+eoUoR6vsJSZlTSzQbTj5jXZS6NTCW8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnHOd5bjJcj+GPd1FZ33MueHhu6xmJ7V4uOy77a
 sc4MtpPwFuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxzneQAKCRARpy6gFHHX
 csWnD/sGuWJUMMr8NI/gqHr4VJ7U32k6j6MffItGRvD1/2nQneCDDv/LUQcTUDVgFUOGSviWPj/
 /Ykk2Ow2uEbGUaT0tWTMCZctE3eyU96jtN+G+LBCYJBRPMkIn1cW5fnw0A9hKiHMAI7IeTkP/wH
 7mFCKUCJhmrnOQE7XeGXFA7a6iSSBu4jUq95YhNbBHt1vMjcntd0prHXF9VhWpZ7cehzWDvPSIw
 naC1Tj+So/1x9JMcS2S37IK+jZhTd1UHw1ticAjjaNUs8FRd5CexH1MZBXqzaQKBPRBPaXzEbmI
 8r6whB8QWwgkgG38ziXL/hqe8xgzbgfpqxueEnWtQaD56qFSy9BFY5dML/CdgIXA51rskgiDD8H
 kzJr3tyIJ1liXScGqaACA4B7JPWQ/UQ0K5SHJYqBI5MG+1nasQ7hrcV4vBgqpm/H4TM+2jpQFka
 4isjaCwFVqK4Mn9/fPCfzxpiQCVYNn8VWARDCmIxV6B8Og7ZTQ+dL7vtmfT6/8MlglSDslxdCxI
 iWR7DGAKUhIkDr7IaRE/HT75eE3hW+eIYfWQErgVK9z+8AbjrpEfr653wQY6KIbyQTBPh/qO9bH
 I52rPaA5owg4jOEFeaWnQdjDYEIUHbKa4iVn41+pah8y2uxi+CbFgijGERE8DGJW+qqnkaosVkf
 72HM+/n6Gc2K4Yg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink the code and drop some goto labels by using lock guards around
gpiod_data::mutex.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 82 ++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 0c713baa7784..a0926a1061ae 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -77,12 +77,10 @@ static ssize_t direction_show(struct device *dev,
 	struct gpio_desc *desc = data->desc;
 	int value;
 
-	mutex_lock(&data->mutex);
-
-	gpiod_get_direction(desc);
-	value = !!test_bit(FLAG_IS_OUT, &desc->flags);
-
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex) {
+		gpiod_get_direction(desc);
+		value = !!test_bit(FLAG_IS_OUT, &desc->flags);
+	}
 
 	return sysfs_emit(buf, "%s\n", value ? "out" : "in");
 }
@@ -94,7 +92,7 @@ static ssize_t direction_store(struct device *dev,
 	struct gpio_desc *desc = data->desc;
 	ssize_t			status;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (sysfs_streq(buf, "high"))
 		status = gpiod_direction_output_raw(desc, 1);
@@ -105,8 +103,6 @@ static ssize_t direction_store(struct device *dev,
 	else
 		status = -EINVAL;
 
-	mutex_unlock(&data->mutex);
-
 	return status ? : size;
 }
 static DEVICE_ATTR_RW(direction);
@@ -118,11 +114,8 @@ static ssize_t value_show(struct device *dev,
 	struct gpio_desc *desc = data->desc;
 	ssize_t			status;
 
-	mutex_lock(&data->mutex);
-
-	status = gpiod_get_value_cansleep(desc);
-
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		status = gpiod_get_value_cansleep(desc);
 
 	if (status < 0)
 		return status;
@@ -140,18 +133,17 @@ static ssize_t value_store(struct device *dev,
 
 	status = kstrtol(buf, 0, &value);
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	if (!test_bit(FLAG_IS_OUT, &desc->flags)) {
-		status = -EPERM;
-	} else if (status == 0) {
-		gpiod_set_value_cansleep(desc, value);
-		status = size;
-	}
+	if (!test_bit(FLAG_IS_OUT, &desc->flags))
+		return -EPERM;
 
-	mutex_unlock(&data->mutex);
+	if (status)
+		return status;
 
-	return status;
+	gpiod_set_value_cansleep(desc, value);
+
+	return size;
 }
 static DEVICE_ATTR_PREALLOC(value, S_IWUSR | S_IRUGO, value_show, value_store);
 
@@ -253,11 +245,8 @@ static ssize_t edge_show(struct device *dev,
 	struct gpiod_data *data = dev_get_drvdata(dev);
 	int flags;
 
-	mutex_lock(&data->mutex);
-
-	flags = data->irq_flags;
-
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		flags = data->irq_flags;
 
 	if (flags >= ARRAY_SIZE(trigger_names))
 		return 0;
@@ -276,26 +265,22 @@ static ssize_t edge_store(struct device *dev,
 	if (flags < 0)
 		return flags;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	if (flags == data->irq_flags) {
-		status = size;
-		goto out_unlock;
-	}
+	if (flags == data->irq_flags)
+		return size;
 
 	if (data->irq_flags)
 		gpio_sysfs_free_irq(dev);
 
-	if (flags) {
-		status = gpio_sysfs_request_irq(dev, flags);
-		if (!status)
-			status = size;
-	}
+	if (!flags)
+		return size;
 
-out_unlock:
-	mutex_unlock(&data->mutex);
+	status = gpio_sysfs_request_irq(dev, flags);
+	if (status)
+		return status;
 
-	return status;
+	return size;
 }
 static DEVICE_ATTR_RW(edge);
 
@@ -330,11 +315,8 @@ static ssize_t active_low_show(struct device *dev,
 	struct gpio_desc *desc = data->desc;
 	int value;
 
-	mutex_lock(&data->mutex);
-
-	value = !!test_bit(FLAG_ACTIVE_LOW, &desc->flags);
-
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		value = !!test_bit(FLAG_ACTIVE_LOW, &desc->flags);
 
 	return sysfs_emit(buf, "%d\n", value);
 }
@@ -350,13 +332,9 @@ static ssize_t active_low_store(struct device *dev,
 	if (status)
 		return status;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	status = gpio_sysfs_set_active_low(dev, value);
-
-	mutex_unlock(&data->mutex);
-
-	return status ? : size;
+	return gpio_sysfs_set_active_low(dev, value) ?: size;
 }
 static DEVICE_ATTR_RW(active_low);
 

-- 
2.45.2



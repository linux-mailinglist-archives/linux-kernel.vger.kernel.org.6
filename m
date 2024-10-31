Return-Path: <linux-kernel+bounces-391217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC259B83ED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E59B20D82
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD531CC151;
	Thu, 31 Oct 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="csgL3F1F"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9619ABB4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404926; cv=none; b=FuZHq+/OVuctYEjy2sttrxbQdcNMzF/KNDxuChV9fFl1ZHRa7j2dZ3shSwPM3Liq5uibuID6S1XDZ/cldbfCq2yboFdcOhIt16y2Qy5KYYWIwiCni9Wtf7FgYM6gai1woghu/zG243T13F5hXWIU+dA1NiIcaJJ3OB0jv3xS2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404926; c=relaxed/simple;
	bh=3eGsWj3tldB6ErshJTowvNjw6P+DOV6RwonJQjhOJvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dai0cVM3Bl/vUQ9JX0Jzu9/VoxcXXCPFk4uy0D5G59j9aCvgPIuI8miu2KJGLdiTJedUbjQZ6nLpf71e4jUpMHk5Gtdj/bGUzbrOTnBrBtcfRobyt2g4ovboh/AUfMuAjwyNOJvJkqYa94MnB16SOB+YFUWwEFnmutEuqiJG7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=csgL3F1F; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d47eff9acso867666f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730404922; x=1731009722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6mBZytrDKEzQaEmUgMpFJx27tSq4OYxz5Qwnw3leeA=;
        b=csgL3F1FFyjMSD/rfYDkQ0WNDyVi7kAkxOYqo6eTVx6+7PQT1oTjzsokHQcB4iEeX4
         Zo57jVqbBHGUDvqXKmkhcWXPiMdt536cKXUkiTOeXC1crR7kKTt/6dfX1ie3WzWm3vS+
         /YERwsx05YWnsQsr0JqBa4SWariRFsDioOdRID2C3nOlfyoPiwux1ec5BDnAOR4kR1ra
         dRSmyLXjAYBGuwORnMmSXuRJPb6CqxaRXO8oUZLcZ1aNHe6uLqBiNvr1mTFl6cgMM1Eh
         AI0TRFIK25iVtYrEixqR3WHms84CW/G/pjq4tCazBosR518A1lSIuYMbg5zbic7+qCuB
         1M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404922; x=1731009722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6mBZytrDKEzQaEmUgMpFJx27tSq4OYxz5Qwnw3leeA=;
        b=X6fTdy2TdSikTMAg7GAmmk/WeE6hGgjTX6LB59sTGHPytpYUYQrqW4TIBktn1Sr6FL
         9EMRohOJQAPSkpUSiQwTLoL1/9Ua3wpbCjQ61BMcOgOmTE/qAdXqNMI8hxVMOmYRJrKp
         wg4EKDSYaepevow0IDEEqUG/ukX/3RSG3pD6mzn8Fs8W2xdd21AKu3IXmPscPPXhhVJg
         WpjuF6Ls75bUUF6lRSHo+hUKmlAIGROIFjMVv4LFczoGx3c3ir/J+X2tCfbWG+nBwK10
         TFrS2EBN+T0k4yRz7g4khqTtizuJR3ZMfhkOVnYZeUsji910Yhqd0fTm5bUMVrx0VZIE
         11Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVYftAeFTyBKq6xYKvKHAPIpi0cR9oaBF6WFc9bwrYImnTRDOxusttqPlnNf36462z73mYRv/TIDiHBq1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlJHaRfgkpaaVl+Pt+nT4etBTiKrr410+tJhSISHqhESzIrBZ
	NLvHU8ykPUe2vZJKTIiRevoxFdWYiZpuOmr2PUsm4ENm+y4LxUjw+YgBwRqPMsI=
X-Google-Smtp-Source: AGHT+IGAZj09jlUVqaVWH2c9zCPhNV/xPpwAFq1+xmwxeDkiFGYkJBU61+Cwv42I1Tc9EE4zbt3vqA==
X-Received: by 2002:a5d:6c63:0:b0:37d:3973:cb8d with SMTP id ffacd0b85a97d-381c7a5e9d5mr977708f8f.24.1730404922353;
        Thu, 31 Oct 2024 13:02:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f39e:5519:d578:740])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1189123sm3003993f8f.115.2024.10.31.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:02:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 21:01:51 +0100
Subject: [PATCH v4 1/5] gpio: sysfs: use cleanup guards for
 gpiod_data::mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-gpio-notify-sysfs-v4-1-142021c2195c@linaro.org>
References: <20241031-gpio-notify-sysfs-v4-0-142021c2195c@linaro.org>
In-Reply-To: <20241031-gpio-notify-sysfs-v4-0-142021c2195c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4303;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JtNYy2XqnFeY+eoUoR6vsJSZlTSzQbTj5jXZS6NTCW8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnI+I2Pd20JG6ct2Q64CVWKREET3/J/otoQpcx9
 i8hzT2hHImJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZyPiNgAKCRARpy6gFHHX
 cvnQEADGPCnvjn8sKxmXZbnLjy/kg3253RNE4qwGiWrwgF4giPL4rsiGz8l9e5dTq9J8ZEoREp9
 r9XjOoVC6ZCx3Zc5mmnYLahVVYle8h2hDTtiy482PuU/nBDAxkDB96ihhAfaQiBtQEFUuc9No7k
 PJy5kVfs+n6x99lxIxpKEvXBwD3UX4rAF88N77rEOCOcK+OqDrLtlZT7FV1HDtHpswH9B0f8lhJ
 rUHGDCVXtGd9dWWcJeSw6EWDQtafbIAzeF33B4OCGzz6RKd822/uRaxaEjHKGMtbztQKpsjZreF
 QD3pUX5+cKoJFBgdBUPyGVwVnEdjQsGRk52FYSuzugcmSeCCbyi+S0Q8ILYxWR3R0DFOFrBEUsY
 BrSsqUhdQ8EmIz3MnO8gv4bpaOfanbHR+8HeLlNQB641fKgjh4GI2laBJbupSbOVmeMgwkaLbZg
 OM3/t+zVJVmKS3h58SqukHCpAIIMuYQgSdFV6bQVakJH4gsuHL9oWOn8550uEB2dxWqjqnYx392
 1UPHGZP/VUYUrIfbvmV0eHAQ5ffThHf2iVE/ZZTVLSD3O7u4KZqDf7JuzuZ2n271hUr3xNj99Sr
 BE4YgiHF50xyzlc+mTHDYQPgwxTRl9AQBFn4ZRU55riHsVYoIu+ik0OMhhl2ZWPVL5Mw6HIA9lE
 QXhFjVEMn6Cz5KA==
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



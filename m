Return-Path: <linux-kernel+bounces-391232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BF9B842D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9718A283FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1D1CB52E;
	Thu, 31 Oct 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3P8uQheH"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68444142E9F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405332; cv=none; b=HTDurfvD1jUCkVf3GqEbSbymmj3JQm6a0x58fUxjTQKhJ1Fa0LI+1X6A4m2MK9zd1VLOb4f9FKyztEfipxx7OAbb0cFtDEyfZIa5hGpGgnxrRXlCJ76WJr9c1NR6fmkJNHsXlp78/g6sTfmQO7KVxmf5B4zM0uaiXYvcpjMi8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405332; c=relaxed/simple;
	bh=wOQFi5MSy6tbhEpG3jKFVCRi1anD7nHYDvspYaJfXoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjsQNEHg713rhK9V1VJ8vD6NJcmlXi8tokIGusZZ7gN8ldoAqO84UP2IbD5JDfnnxPmSa0ZX/wnt8J1yndJcQcGStRqws+lGmOOyHtR/V4on3BVi0cHYN9NhOLH1e+dV5V06WTNLBKa3rkskbc8RqF+Q7Mvr79A8LeBMKd/Z2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3P8uQheH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315abed18aso10896805e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730405329; x=1731010129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfHagDh6usyc8u7POry/8zIyiGSSk5lsRPg0r7Le7jY=;
        b=3P8uQheHR1MJ7NKdGPEKFDNRALUtd9r/6J1IirUUdzjRExL926XotubBOTK4U3Iy0w
         xTwH4b9uiTAz+GJFH0uZYP4Hw+pJY2Uz69x1ptx6iBus4mRu2D6MhuEl6bh2QZWctE0L
         rHWrISR71Ns48JcZhw0DDGjnxpU0kRYGO/K0WMAgmNike78tX8rDx3Ov9fmNjIiIGZfh
         Tgu6OgB3+D79Gt6iNV/4DagBei4a/ct4xgHKX7ntYbWTMrkf1sPjex/9Hr2gxPHomOk2
         xjv7tVZB7NcN4Dg37ojQcEc80QJHS/p62p5cLrePiKUYxMI4MwrmCmJXcFFDCw3seClJ
         om0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405329; x=1731010129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfHagDh6usyc8u7POry/8zIyiGSSk5lsRPg0r7Le7jY=;
        b=YUWhWclVFszLUZMREVd9vWR/z4fdzl91RhA6qp7sJmgKUivHFH8+tO1C4MyRcZlGug
         l2rhtdiT3n58/S4iWtRosFqSB8xxn9qrcbkfBSgqcXDSp4Sv1pV1DXhp9EiE5rFKlmBl
         TjIrbbvN3sYib1ZR+GZEPzjpJxfJfQhoNwaSDOcMZq+PLe5/ETLQ4R76oYEDcvuJ0soR
         ma8m39nUreOlvg3n/ZnkhUMa/wh/NKiZiyBbMo/I4YTnyS6ywc6Sg9K5t8MGw+5olMqc
         pRSHo87fmsejTAzcrgnRiU4O8TOYGTjxqYIFJ9QJ2HsQumzD/ORVc4hH4v+q+cronR6T
         a2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVngs/iIT1mYaBDrW6izLp80Q1nxnzW+1a0dFKxK59Ni1YmOm03+EydU/7Zmh9/QJ9easyFjDAqrsBgxiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYI4T38IGEdSPecCXAP+ExLtT9BXo7TgOnOwKCNfHEFYrWL7B7
	9+VLMu94sjhQvPtClTXyOx6Cwl+7VJRqr19cC1tvwcPFQeG/ju+BSPW6BmqFcs8=
X-Google-Smtp-Source: AGHT+IHyxstUsfh00mPEKqx9SO8dh4Xe+8nJd5UICEep2LS8qUDyb+79q8iIkEcEmky/hZ/nNKREJg==
X-Received: by 2002:a05:600c:6046:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-43283297a21mr9014205e9.34.1730405328806;
        Thu, 31 Oct 2024 13:08:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f39e:5519:d578:740])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852efsm36984475e9.30.2024.10.31.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:08:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: cdev: don't report GPIOs requested as interrupts as used
Date: Thu, 31 Oct 2024 21:08:41 +0100
Message-ID: <20241031200842.22712-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIOs used as shared irqs can still be requested by user-space (or
kernel drivers for that matter) yet we report them as used over the
chardev ABI. Drop the test for FLAG_USED_AS_IRQ from
gpio_desc_to_lineinfo().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0ec162b0ea04..629e9372fd57 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2275,7 +2275,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	 */
 	if (test_bit(FLAG_REQUESTED, &dflags) ||
 	    test_bit(FLAG_IS_HOGGED, &dflags) ||
-	    test_bit(FLAG_USED_AS_IRQ, &dflags) ||
 	    test_bit(FLAG_EXPORT, &dflags) ||
 	    test_bit(FLAG_SYSFS, &dflags) ||
 	    !gpiochip_line_is_valid(guard.gc, info->offset)) {
-- 
2.45.2



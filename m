Return-Path: <linux-kernel+bounces-380563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B479AF285
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CED1F273CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D7C21730D;
	Thu, 24 Oct 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TnMqqb6+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6541EF958
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797340; cv=none; b=J57TZvrU46gzCq61f4yZCyD3rTHGJxpArobLW3+KI5B8QaSTJFexYTqnpaXGnzlUxm05NNHpCoGnRtISFeQKIYVfWxdUP27AgmXXx5RfYwiCGzE6rbkeRtiIGcRJFxOGJLorV8WH/iBnBqNcJJufrGj5wktG/v+4ot8LfYeqgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797340; c=relaxed/simple;
	bh=QjmaQqYm0iMEoRGtnJwIJdjBJ16XTZzTDvnDFsXlOLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXkBOX4fJz4s/snFMzFjyN3UOQuzpj2+ZO06jdnHuYwMuzHw3Gh5l6GJvSW+RpBXt6Gdr2qIq3a62Qc/Rjzzq5E4P8suLBuKzy0DR7c78sDkE8QWSW+YrvAE30Ru0Djw4KihvDCqNjgdbYGMjhOI675tOfTagi5tcLJmzysOSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TnMqqb6+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so13239045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729797337; x=1730402137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn2tQOtA8p3W0heFdAnV2X+VMQYhki4kVXiSMCqcSEw=;
        b=TnMqqb6+tlNolAKGh0ijVbvkuLPPk3Fyp8dtuOqXWUV3Y3iE9/3nF4P6gCRvzjN+Ry
         AHI9wFfRDHDnlJ8r6MAFdlNYfBHkYCNm1tiqM/4eK5W2OqoIIKQGcDUINPc5snGYUGyQ
         La4zChW4nKnr7Du1CxK4VexqZWE49eoe2Hjv0CQK7bemSM89L6y26+co8WP7dl/agwUI
         e74VagPPEAiFtyFe8/lXZjsCKNR9g7LpcD5VmBujV9fkyvDPcz44F/TPTQYhUuQm37/0
         Qf79EQr4RyYSCkicZkPSflbyTYEOH38mNLj+dfSEYs1Hq8IE8avWZMeRLtonkCLF2HpO
         8gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729797337; x=1730402137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tn2tQOtA8p3W0heFdAnV2X+VMQYhki4kVXiSMCqcSEw=;
        b=uJZbuEDF+7yIVLbbpvDeokScJfE9xVEK6TdMnS/Ia+6x1fTNsbGedwKhU3FARbfDmO
         zhhAsaF7h4GCkf9i/4S1mIPZBVzNJ21reC6ObFlKi0GFitu/GfepKnsNKOWBAMRTUJIp
         TjuMfclbqZNBZD3fZ46AhJMObA51BcuK74OBBttXVhco1cmp6uQ6cpumXB9xtWqd+7nR
         42uo/V7/BR4z+74XmPm7Sqvg+qKHUNmja/uodALWlA4rcKSuTT1vWyOMAnnOa9jPnJVc
         lqLoMDhbdZYeHHJnf+Uqb7sww2Dt21NdzSG5y95t42Q0J04zuakJ3PEwfX4eV7x4RjSE
         we9g==
X-Forwarded-Encrypted: i=1; AJvYcCWT34hk2VaGwB0PyZtVtPuvwFCaVkH16m7LYc9Da6qWlei6eLCdMQLCjiIxllLmZqwF1ENuqeaLdaU+FF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgNTFQjjcMa/VhZuKPkpXWSCoOxL0TaVMJw28RV67lK/JFnFx
	xEaWro9ssBbk/r6GsC7XgUedJa+vCnaLSBLvfcZNzWu6MQ+wN8jI5ipe/rqTnp8=
X-Google-Smtp-Source: AGHT+IFWQ7hqpzaveJch29gaXwDmWu2ew54XHbR43V4r8PC1suOitdi/yz2vao5Sla7dxMw5g18yrQ==
X-Received: by 2002:a05:600c:5249:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-4318c70f24fmr21096165e9.20.1729797337106;
        Thu, 24 Oct 2024 12:15:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:17a2:e679:56a4:a25a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37935sm11997657f8f.17.2024.10.24.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:15:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: remove leftover spinlock bits
Date: Thu, 24 Oct 2024 21:15:32 +0200
Message-ID: <20241024191532.78304-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We no longer use any spinlocks in gpiolib.c. Stop including
linux/spinlock.h and remove an outdated comment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ae758ba6dc3d..fa68ff574d10 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -24,7 +24,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/srcu.h>
 #include <linux/string.h>
 
@@ -1223,11 +1222,6 @@ struct gpio_device *gpio_device_find(const void *data,
 	struct gpio_device *gdev;
 	struct gpio_chip *gc;
 
-	/*
-	 * Not yet but in the future the spinlock below will become a mutex.
-	 * Annotate this function before anyone tries to use it in interrupt
-	 * context like it happened with gpiochip_find().
-	 */
 	might_sleep();
 
 	guard(srcu)(&gpio_devices_srcu);
-- 
2.45.2



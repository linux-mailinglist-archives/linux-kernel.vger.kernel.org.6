Return-Path: <linux-kernel+bounces-364015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B899C9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E241F21D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980191A01C3;
	Mon, 14 Oct 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mYhICIuL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721AC156F3F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908316; cv=none; b=O3pxmr0seRI2hP5xqlVp614iXBi+hgcQvst96kQD/k4PDBJZ8qYX8V+sCpTS+LcLeH5HG83n/jKC6NUyCIXGpjyA89eMi0OKDhLIKkyIzdW7s0ru2jCMzg3+r04mwIGXthuZshPgzjtOzhZ954kgLAnoTcZKgr0lg8N7GJq2D8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908316; c=relaxed/simple;
	bh=mFBoCNrUZG3cLzWf/DGnig1fihxe/09n1vjOwanoI1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DU7bSBzQsCuH+Sz/bogfyKRv2WgdR4mF990Ur+7IGea+dgI5mALZsXIECFLZNC5RukJlXpoow+CYIrCKRzXF/oCJqQ2iGUAgsc+23virXG+gWtBQUnewqhWxQ6LROqsN829Gk30xCAhggDTZkghKH7cBxdHYTNzl+DYNTuGClhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mYhICIuL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d462c91a9so2697684f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728908313; x=1729513113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PY41G9O9B41tlvbRmkxCPs2gsA50Z6WrgLw/irylVJo=;
        b=mYhICIuLUar8Wc1sgiAwLRnfsGp4IDICVeMH0mCdz4Rqh/RsMclRZKNtMj6aQfXrPO
         8pGyxToZCBB4a5TrhCOi9tvIcj4lE+x+t/Y9JL15Jg4JNZVXa1s57yjKdm4536iQBsfL
         +RtZuJV6lO6tv9p9/m9WC/p5ci9uJFAZHCdZ79YzZoZKWtOtD3fz67g2OdEU5J2jZUDo
         FjCf5/r5XyAaqrzZvOBwLERb6lNzeoB2kDNBsGEekUgYAAgLkKe5jweGS6tKpPBtUP68
         hYqNtU8NqpTReE65lUAL8chUclIcDEdaWRksP1vMAKIngR+pBKWW31109mnMUPMredlS
         753w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728908313; x=1729513113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY41G9O9B41tlvbRmkxCPs2gsA50Z6WrgLw/irylVJo=;
        b=xLiJtDpLniHoretG5MEVkNgBcBUZ8DJGmk9y7or1HKZcwrjd74WTV5RIPXArb/lX3t
         wngxMKSokWM72P3loPxyHSqLj8g6mRMJDE+UofoMHNnkvyWob9jEtb1vp+URzVIvgUo5
         F5s9OHWskvRI19UNEEPoVygFMgofoFh9gOHtYauGt2pLKuuSFQokVeQACAB/9o33CNJh
         EvC1QGgcOK0gHITvchN2FGNT9Gjm0dH9tT1SsfyqEY4k5sfdegqv7KcpJC7++r6u9CSh
         0nda1iK90+2yxiI0dcr5XlNXP1AMyHQqLDEdx4mciUQLmDQlbp7RyzTaQTvIAxDjpeTZ
         MYCw==
X-Forwarded-Encrypted: i=1; AJvYcCW3cfA6NwFQgFyMFasfAAZMUN8E5ZwO2aC1f24RGubMuCmnXXscuMbu1ajq1Jdhv0NHKb75F+QyUtolpn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUuH2VVaeltS9kE6dYqJ6l9T9ClpTzYHA4G55JvUWrGkmupaN
	lMsaG8FKvkoJVBjpUY12PPak4aLMbxryYqY4inWeeoeQeMm/AJic5BtRfL9txM9K56BJ8rBa7KW
	i
X-Google-Smtp-Source: AGHT+IGBtBgbb11CDhtxi74JajGba5TMb4OF5YCUYq7KkMcFJWXjOTg6hGJK3YS9i6dFXvblbTY3xQ==
X-Received: by 2002:adf:f3c9:0:b0:37d:3280:203a with SMTP id ffacd0b85a97d-37d55184cdbmr8709433f8f.10.1728908312531;
        Mon, 14 Oct 2024 05:18:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fdc2sm11234895f8f.88.2024.10.14.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:18:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sysfs: constify gpio class
Date: Mon, 14 Oct 2024 14:18:30 +0200
Message-ID: <20241014121831.106532-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All class functions used here take a const pointer to the class
structure. We can constify gpio_class.

While at it: remove a stray newline and use a tab in the struct
definition for consistency with the line above.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 20426d6e04d5..0c713baa7784 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -549,12 +549,11 @@ static struct attribute *gpio_class_attrs[] = {
 };
 ATTRIBUTE_GROUPS(gpio_class);
 
-static struct class gpio_class = {
+static const struct class gpio_class = {
 	.name =		"gpio",
-	.class_groups = gpio_class_groups,
+	.class_groups =	gpio_class_groups,
 };
 
-
 /**
  * gpiod_export - export a GPIO through sysfs
  * @desc: GPIO to make available, already requested
-- 
2.43.0



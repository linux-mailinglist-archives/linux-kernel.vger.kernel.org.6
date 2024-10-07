Return-Path: <linux-kernel+bounces-353138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224B99294A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D111C22C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE11CB514;
	Mon,  7 Oct 2024 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XEGeSGfG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C41C2324
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297287; cv=none; b=T0gzV83WKafMAOspHSW9MacR7tERV57y1xbjB2U2bRJ86be7kggi87LfdttTLcNm7w8PQy4jwFWoGpZ3CVyFydcgbZQoJdJUnFvUC40Q4BKikq3v4yIVdwbkLzD3MmWxlYLovg/qmj84rta7rhBq8/wYNOEEnbW8B+0RSRDM9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297287; c=relaxed/simple;
	bh=1qPlnzcMGjfYtKZcC+y8Ac/zKIwCECeIicdIk0nKk6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYEVSGKOh+48VARp5y6xeb3OJL6yTvrbq3RSqULahNwHrpR198yHgdk8hrI+t6VFJCUB/draqRHECj8R7SyNdbWF9nkbe6caozBQ+YRx1Ta+Ry7n5YaDksiQylyuGWlY7Xk1VamKX7s31YG7HUHoVz06UFGktQqa3P3te2zkYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XEGeSGfG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so43388325e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728297284; x=1728902084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRttM15lACyttOFmnb/OMbzHtGbNczmJy3XXf3scjPQ=;
        b=XEGeSGfGFy45yePMJxURX8fuFQvwbC7iiQmwT1n0WVmkyb+9t4i3fy4bEF48njHXba
         772s49sRzVJb64BFViZl7jBfVq79NNTI8GOpiaQuLkwlMDe/iR17mtZ1Ej2LFvIDGG2I
         kS6oT5AHfKCOyUiPdgGq0GqHIJxp840Pna3z2hn+pU2IfmOX7ntLlqfiZMgGFMAWe4BM
         9RHDXA0vrDV0lMShKesijtjI8FX5I5KLM+eTJc7thZThectK1Kl5oS53R1FmuLaLFq32
         w+hS+3E6jbcPqB7U0JAw8JoU6bzmSwKWbhfTni4v/GSBqyrzztQvwp/H7qovt4aVDVD/
         kf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728297284; x=1728902084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRttM15lACyttOFmnb/OMbzHtGbNczmJy3XXf3scjPQ=;
        b=hFWt8UB2leKcNdxKDUp+LfjPYYpyBobhjBNJKNMmzFrJFXkZ+86UhIkWpgHL+VVUOD
         BsePCMN16JriC0Z/O7GMGEPm4n0+q42t9wxs3ZilBMXrmVIuYAddR8DkQflJeaiZ4xVv
         8VZvBTlG2gIlxXD2Qb2YFZKDHNmJMXrYc2YvG2IQvrXGHETsCHJZAQJF2WAXt0NczrFk
         fpmnjfEUSGIW+/NwwvcyTieX0qOKo08wkVMw/qHx2jOZNzx+3TqmsKSKMidBCNi4uImi
         yp/yxWifFpARiR46Pdwkm8wrcRkYXhzgrwFWgmmqfq4b1Cb7XkIpsEcIB+wH8d054jR/
         6ltw==
X-Gm-Message-State: AOJu0YzOYZ/uuGtJq/+0OR2YkFHbEf8dVRsuAArErd7y6W+1vgWHt0gm
	UXQcI6mIy1+JHss1awqcXDCeYyxpb5+K3di+KDGDyqwh6TjUDJ25wjVLLqPEckg=
X-Google-Smtp-Source: AGHT+IFbZ4vVupz3Z0AyGdqcEjlQyrpqCoFOFGurA7FovfZmkUQIYEZk+qKenthhIBMvVS2W2Ec/1Q==
X-Received: by 2002:a5d:598f:0:b0:37c:cdcd:68ac with SMTP id ffacd0b85a97d-37d0e8f74e6mr8254107f8f.52.1728297284165;
        Mon, 07 Oct 2024 03:34:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16973c2asm5423555f8f.111.2024.10.07.03.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:34:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] gpio: davinci: allow building the module with COMPILE_TEST=y
Date: Mon,  7 Oct 2024 12:34:39 +0200
Message-ID: <20241007103440.38416-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make it possible to build the module when COMPILE_TEST is enabled for
better build coverage. Stop using of_match_ptr() to avoid build warnings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- stop using of_match_ptr()

 drivers/gpio/Kconfig        | 2 +-
 drivers/gpio/gpio-davinci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d93cd4f722b4..54770c917638 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -243,7 +243,7 @@ config GPIO_CLPS711X
 config GPIO_DAVINCI
 	tristate "TI Davinci/Keystone GPIO support"
 	default y if ARCH_DAVINCI
-	depends on (ARM || ARM64) && (ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_K3)
+	depends on ((ARM || ARM64) && (ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_K3)) || COMPILE_TEST
 	help
 	  Say yes here to enable GPIO support for TI Davinci/Keystone SoCs.
 
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 76b58c70b257..1da1d7c7ac2d 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -662,7 +662,7 @@ static struct platform_driver davinci_gpio_driver = {
 	.driver		= {
 		.name		= "davinci_gpio",
 		.pm = pm_sleep_ptr(&davinci_gpio_dev_pm_ops),
-		.of_match_table	= of_match_ptr(davinci_gpio_ids),
+		.of_match_table	= davinci_gpio_ids,
 	},
 };
 
-- 
2.43.0



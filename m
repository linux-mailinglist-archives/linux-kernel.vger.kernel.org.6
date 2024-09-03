Return-Path: <linux-kernel+bounces-313284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111BE96A31B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D89281935
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26841422A2;
	Tue,  3 Sep 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ILa+gD0F"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA702AD22
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378341; cv=none; b=P9eHv5dEKsbiEl20Tf4IK5NSAqh8Gz9k27+FjtGqF+CPFhZ5MlT3Q7GKrXnAsSx9XHqFpguuxA+MtzNOoJSjjD6cXs41+qRwAjfhyju3OHosUooexdHRHC/ztXJU6/f8xQ1kHvKuzb6Qu8/8lgJ97KA2ykx1f7ewBvSrNK5/NhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378341; c=relaxed/simple;
	bh=7TGt3UVPR5EKU3qIHcGrhDfIOHmcB3omprSj/24NcHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqVxNtd4w1S/K5xszjp1MF1bLyOXl3apO+7ho9FVee8k6eZUKjD7lC4KC0fYQ6AIsak0naggWk5Ad2p1q6c4BCAVoAPcSHzWzw4G2spRIQSlwjv+ZJL+faBbBONyt5QfQL26lc42Xfsw7iqhC6bLsefCxKzd5N+deiGmlWjgnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ILa+gD0F; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c962e5adso1303464f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725378338; x=1725983138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYFzd5wGbdUTzxf7kedk64DnlzYKL/ERNfiEExLtyL4=;
        b=ILa+gD0FcoLnXk7+D9bTvQHMH9oQ13Ekz3Zm8a6R4Zn+YzKoeJNx9kYNwKxwkhUAmT
         t+PrFsxq0LNe3KW7a1zmH+rR7oAgZB0sAn7yWzvFljv1YGmLF9WRzC07Gp2ZpmRL51RJ
         SjyLeL2fV1qreKbM8Fp/DTXYdgV1vInExkwXZaoWcr63rj8VOXAtCnlJrrD5KI/UMdVt
         tpadBjUYCR9bcrtJHt0TuiJoYJOOyl9ZUXUKaKuQneg1vdUD4PdkKAcmGLLGjXGPmtmB
         lSkEW+GKyrE/0B+/FTbpYtfSHPj12z2pEJzsvOKp7AeyyYiJoflOseYs+0jQFwXXe6oE
         +uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378338; x=1725983138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYFzd5wGbdUTzxf7kedk64DnlzYKL/ERNfiEExLtyL4=;
        b=b8cjMABV1lAqmSsx//8f/J2RN5Qe2bym/XlDglFBnB+dV54w43MZSvf4AqchDjSCDp
         JiwukDvq80gphSKvg2LzS+vzLtj3iCTlCA9FrVXhMW/g+0b+hHJT6sfVB68zcOErjCuG
         pcK9Kz9xIsR5yIUGuNhkst1hOGgNnfyySi9lkokYLVP+xuiEA4lQKKRJBiy7ihMhwt0i
         9QNeXZGuUcqjUlfZx+2pc4ZVuDyG28bNQirSAD/aNSX/YqpJmqMFfGfl/k8t0JObH65e
         W3dxjUXLMGklAK6eEjo1xrRiPAUjVwJg9TkxUnyBTBq92JfbBfTGCH8VNMgM8biCbdIW
         tZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXER8MKKjEMHRkLS+EbKlq9pvVPkficmGG4MCZHOz4rv3Bu3JqNJUCEW533vfCmHFYGBXEFJsg2sYJsIXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDKQXdvhYqYrRUPWhvhyOIm4UUv00hqZN64sgn4jt7Vd3eWeQ
	kAj3MpoCmwFWW0yeV8Zmg+vHAZy7cPsq4dbdi1v1KJPkVrZu/D5/GY9rfF5eGHE=
X-Google-Smtp-Source: AGHT+IEW0aC2qwad1ogmXE2GwNM6XKUxHfftr2VPi/LGhbsi0QB4I7TotNYbuNGJrqQfw3bYVMeTvw==
X-Received: by 2002:a05:6000:2811:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-374cd3cdf08mr4333632f8f.6.1725378337099;
        Tue, 03 Sep 2024 08:45:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6a50:a260:3846:9065])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a42sm172256465e9.11.2024.09.03.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:45:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Martyn Welch <martyn.welch@collabora.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: mpc8xxx: order headers alphabetically
Date: Tue,  3 Sep 2024 17:45:32 +0200
Message-ID: <20240903154533.101258-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Cleanup the includes by putting them in alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mpc8xxx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index ab30c911c9d50..e084e08f54387 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -7,19 +7,19 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/property.h>
-#include <linux/mod_devicetable.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <linux/gpio/driver.h>
 #include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #define MPC8XXX_GPIO_PINS	32
 
-- 
2.43.0



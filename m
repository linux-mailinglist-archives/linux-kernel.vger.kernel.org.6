Return-Path: <linux-kernel+bounces-191373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EAB8D0E60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E782814CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BB620DC5;
	Mon, 27 May 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ufyk4Ag1"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69A10A11
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839181; cv=none; b=S9S3eQQabQDlHZ7zasCcrkUIcWS/lczSLZKArQgp1y6bxuHvJEoeG2Pf8SSim7H8k2YC5s/EOUjmxGH64fPdF1ZRFmL+4mPmUS37F2wuCIpSBX14ykv1nmcpMFvSz4lxOyCDMh5+MFUhlSz/LGzbMrKm2rnG3aJEUb5ExMip7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839181; c=relaxed/simple;
	bh=rRqysAQWeM6jhpqHiLqjcOu4gGLwxsR8yzfqPRbmEyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPGSVUG6vYmWcQiPJLx4aQoA+vJQKsO4uIMCvo74w/P8TuAaVeY+G2saAGf0CPKuUvFy8ZJ19ZkGhUCUmWe8vZh2ebH5kBfYa+j/LkFkK7E0wPPx/OY6A1POYZQ4KHMaou1irp1V8MnA3XqWsIKnTUAkJhXFAsjHTrKlYPgcB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ufyk4Ag1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4211b3c0ef3so519435e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716839178; x=1717443978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rTl6IrIa+G4LMhRu5xAux6Zx02fHfcpRAhnP/gxP1yQ=;
        b=Ufyk4Ag1O63Z0Rpll458NoxMHL7PcmsdnMql7Uw1ystnyo5GP1cKKuyZD/UNbLV4ff
         YUnqDcu7jIhmmx7n/VVNCgSnwBUmylsHNm36kNuqR+rv634o2S4dTVKG72R9jcYJeVf3
         cAVXsqjY8/SgYLlqmeNZ/72RZmrKioDKy0Jw8CCQ66Oxg4TH8MVAlHrfgi4R8tRMEBYp
         cUKJua+AupRDKoDohzf7e0ovNGwC+YHKUkZTH23x2BhKtyXKr9xzMgjAx+Zs2E/nQmZg
         kT6aIB/UQwDJS6unOmn6AzPdwJ93hdoQmAgz/5MG9PZhH3EOGzzlGDmO/3GFoaVXcz2u
         /mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716839178; x=1717443978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTl6IrIa+G4LMhRu5xAux6Zx02fHfcpRAhnP/gxP1yQ=;
        b=Z1aegCep7IWjJ/ZC7eS4N2rqHrhwG0Dq487Tgl4KMCaSLtDxRuug0U2Q/Q9pLWHaHl
         ZQsrluW7L6jWVSGkMq2c40ha2wD9cnL1kn292LkGMO0TZiX1C0U+Y1cwHXNfn2bN3ZvC
         82zuf33+jULINXaKLxg+ml8MrxqOt6HwGo66rzmIPoowO3Hya0gccJbJGWDNMaGkDvcS
         BvbW1O4oYJEoJnZiwALB0OKhBHGfIc9RV0XEJx8h3vpbKJN+W85CNDJIyIWymUZRzYFt
         bON1cbnWZ8W6TWTQYeTHukU4+T7tY5cdPr8p6F5obPULZbg4Ne8e145TeYDJEtvC2+bO
         DTtw==
X-Forwarded-Encrypted: i=1; AJvYcCXCfZ4PSntc6nQP07A4lhpIG+RP9Ie3c241tH4PRHcVcg7QdCjfla51ij6z7BHhpqCk7Mkyu8IncE4NjicEffJMkwi+vOA30birZOI7
X-Gm-Message-State: AOJu0YxGV5RmAilYzctQPNjp/+XLYCRxJcaqtCK4ZzeCpbnljvsLmMwC
	c1AKvzJsge4fuTaex2TYOLTzKrKJOMkpgvIpSdaZR4POKICpT6VkiXqiUCOv0f4=
X-Google-Smtp-Source: AGHT+IGsC38qG7dqVJxXKZvWjhjWY02r40PAijRszttq6aSYh9bw3ao3UA8deJctkniQVJNnIzRl3A==
X-Received: by 2002:a1c:7717:0:b0:420:2df0:1a9b with SMTP id 5b1f17b1804b1-421089ffaf2mr79420285e9.18.1716839177236;
        Mon, 27 May 2024 12:46:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:c322:131e:ff9d:ef41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5299dsm146868935e9.20.2024.05.27.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:46:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: make gpiochip_set_desc_names() return void
Date: Mon, 27 May 2024 21:46:13 +0200
Message-ID: <20240527194613.197810-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

gpiochip_set_desc_names() cannot fail so drop its return value.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fa62367ee929..07e36e15f71f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -485,7 +485,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
  *   1. Non-unique names are still accepted,
  *   2. Name collisions within the same GPIO chip are not reported.
  */
-static int gpiochip_set_desc_names(struct gpio_chip *gc)
+static void gpiochip_set_desc_names(struct gpio_chip *gc)
 {
 	struct gpio_device *gdev = gc->gpiodev;
 	int i;
@@ -504,8 +504,6 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
 	/* Then add all names to the GPIO descriptors */
 	for (i = 0; i != gc->ngpio; ++i)
 		gdev->descs[i].name = gc->names[i];
-
-	return 0;
 }
 
 /*
@@ -999,11 +997,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
 
-	if (gc->names) {
-		ret = gpiochip_set_desc_names(gc);
-		if (ret)
-			goto err_cleanup_desc_srcu;
-	}
+	if (gc->names)
+		gpiochip_set_desc_names(gc);
+
 	ret = gpiochip_set_names(gc);
 	if (ret)
 		goto err_cleanup_desc_srcu;
-- 
2.43.0



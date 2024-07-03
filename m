Return-Path: <linux-kernel+bounces-239875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99377926652
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABFB1C2102A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE1183080;
	Wed,  3 Jul 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoLgkaAB"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C01EB56
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025203; cv=none; b=Nd03MF0bl0O7YGKeQjN9amJDde9mkptTQUhcIC64w5qZmWanwvEARNDIW4VyJnWKQSW820bESyFEFNlLpK8wkpLG2aZOYDXe4eyu54SHl5+FleQixltrRXSUbod1wD8ugtkuhXNFSpo+eEq4UpVpi39OJJ8zwpgjs0Igz4Hx38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025203; c=relaxed/simple;
	bh=HMpCFckabAc3rUFqu0pOABiEctF7GbrRYkZcXjBkkMo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VQFa+OYaN5ernC432L9COFrMSgdAmaKyIk2DjqfwQljtq66Pfh/m+0I2sWGjhP1aNKy5eMRwb9jbZdhgw3SbMpPDIEw2J/AYYvQCzmGqvcj3D7ULfZlqCO+MPQwyMggnmliP8j0Jstw4/xp8qXim1t5x6/ZgYxQcR1fwS7fkPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JoLgkaAB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6520c7bd15cso7212327b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720025201; x=1720630001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uGqHE0E7+SOnBS5UkqHAR0RRhXN6nF8kZmvFEId7fd0=;
        b=JoLgkaABg2ll7SEyxYSxTuhHsIEvMrxmtMfE5aYRH5ZxeER7GxF0+z/tLXZxXc+Xyf
         dukZWdQjIuoLbqESG3V44gH8kvuAJf82QwFDlscp158npRAf+XNFoXlVIyhil43FgNxY
         0VX9xLfVHFE6YsY72/W/sIBMQW4jplc3LQuPXZlVNIhGOKasDrGKUqZaKjaTCzReStwb
         0GH3RSyVcDborGWnXq8r7qQ9X+EPsYfxJHiwax6XnuywGVHZiB3gkJo28DiC/4W3F0si
         Kbf/Numcn8wGTB+aEALZ0iQaEw2pHmifNI++maam4eRIuWinq1ZXVlqSliJaH8SFKdzF
         7fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720025201; x=1720630001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGqHE0E7+SOnBS5UkqHAR0RRhXN6nF8kZmvFEId7fd0=;
        b=R08Ix/VWdCa4Ct63yJ1usNB3pVjvXpqjvnC0TbVonBGeAB5V1P0OOZodh7PXG/zXBZ
         350O1Sb/kG5GuKBD6pXgRejR1uwNSLAliuvaxNbVBzaMOaeDK8Fft6ctp8Fz/GWotVoQ
         sRpweJHZ2pMgcpEv0DbweT45n7vVGsc0O4BFa6IOpr82IZPpSffPicZfWfd3y2ZbzAoK
         inLqF/YhE9STcWM2CxSVM0iXF/IPm76RAhyT5U2wK19fz65c0brL4Q+3GMGZxpWyEhp5
         8Qhng6r/PHk3HPN+V9vg/e01eut54maYw/ndfi4B9r4rbRfMMyM42oc9eFAHqoSOAl30
         YS1A==
X-Forwarded-Encrypted: i=1; AJvYcCX/F2xkuFntbnCfm2GOUPq3+3QWqiJn0XUOS8ftnw/qQXTt9XvMY35xJhU+CnKNzT00doLU4HQS2YVoGpCutws4ER20SHIhJ+eWRrg2
X-Gm-Message-State: AOJu0YzZACJ2CitTkAuadgbudHJaXRa2JNqn0CnZ0gGfeuBTqZVlVcPI
	gbITS5use9dhBT9VeBmlohb1fNpKYMVSQWBTMWSQt5HRn5DRdwrDGYs5lxtABDZ9iTlXtPIYry4
	DLqSYXZBMRE//Xm/2RQ==
X-Google-Smtp-Source: AGHT+IF1wZf4hV0nZ/4PthS9COJLLib7w2IS942hsqZTgV6x0+Nk7H+nmONt5S8eWkJgGD+PledWdgHvG0scLO2q
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a0d:ea83:0:b0:64b:7f7e:910f with SMTP
 id 00721157ae682-64c77cb5cbbmr309867b3.7.1720025201195; Wed, 03 Jul 2024
 09:46:41 -0700 (PDT)
Date: Wed,  3 Jul 2024 12:46:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703164635.221203-1-zenghuchen@google.com>
Subject: [PATCH] leds:lm3601x:calculate max_brightness and brightness properly
From: Jack Chen <zenghuchen@google.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jack Chen <zenghuchen@google.com>, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

1) check the range of torch_current_max,
2) calcualtes max_brightness precisely,
3) lm3601x torch brightness register starts from 0 (2.4 mA).

Tested: tested with a lm36011 and it can set its brightness to lowest
value (2.4 mA)
Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/leds/flash/leds-lm3601x.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-lm3601x.c
index 7e93c447fec5..fc4df904ea90 100644
--- a/drivers/leds/flash/leds-lm3601x.c
+++ b/drivers/leds/flash/leds-lm3601x.c
@@ -190,7 +190,7 @@ static int lm3601x_brightness_set(struct led_classdev *cdev,
 		goto out;
 	}
 
-	ret = regmap_write(led->regmap, LM3601X_LED_TORCH_REG, brightness);
+	ret = regmap_write(led->regmap, LM3601X_LED_TORCH_REG, brightness - 1);
 	if (ret < 0)
 		goto out;
 
@@ -341,8 +341,9 @@ static int lm3601x_register_leds(struct lm3601x_led *led,
 
 	led_cdev = &led->fled_cdev.led_cdev;
 	led_cdev->brightness_set_blocking = lm3601x_brightness_set;
-	led_cdev->max_brightness = DIV_ROUND_UP(led->torch_current_max,
-						LM3601X_TORCH_REG_DIV);
+	led_cdev->max_brightness = DIV_ROUND_UP(
+			led->torch_current_max - LM3601X_MIN_TORCH_I_UA + 1,
+			LM3601X_TORCH_REG_DIV);
 	led_cdev->flags |= LED_DEV_CAP_FLASH;
 
 	init_data.fwnode = fwnode;
@@ -386,6 +387,14 @@ static int lm3601x_parse_node(struct lm3601x_led *led,
 		goto out_err;
 	}
 
+	if (led->torch_current_max > LM3601X_MAX_TORCH_I_UA) {
+		dev_warn(&led->client->dev,
+			 "led-max-microamp cannot be higher than %d\n",
+			 LM3601X_MAX_TORCH_I_UA);
+		led->torch_current_max = LM3601X_MAX_TORCH_I_UA;
+	}
+
+
 	ret = fwnode_property_read_u32(child, "flash-max-microamp",
 				&led->flash_current_max);
 	if (ret) {
-- 
2.45.2.803.g4e1b14247a-goog



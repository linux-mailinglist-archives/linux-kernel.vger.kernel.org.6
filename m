Return-Path: <linux-kernel+bounces-371312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563D9A398D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBF01F2576C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355E1922F8;
	Fri, 18 Oct 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QjnCu8F4"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5C191F89
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242633; cv=none; b=JeS2aZ5bWFg2DdPzzbp8HAmECquPE4Xp7T6oEpvZ3ApNW7DZi+wP2ttPBcrXWUwxmm4hKV/TWml8W34VIGSzvrb4NxXP99J1Uulz+0y9ElmU3tdv5P6q87e+9fGt1QY3Wysa6LnoX7qj2t22bFKGotAK31i1Kjy8tNHFZYjBeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242633; c=relaxed/simple;
	bh=Jc6C6BtaJP7y1Wa50WUZYA4CGv0mhlupt88QoaGx7vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rI5lQQOqQlR6R9vJQ6MtCf5Ot3rqRDcOFMoCQ8fCXJAX/tYpkSRri8ZMFcE6dwURIFPRcedqYDy4ku5Jb1w0sShfpoH0R1sCZDCVCRJb0MsShrm1K9TjceFl/Qnf786a6lUkDobwbFeOjJDwx4OaUjX4FYsFnOccuMlYt+aaUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QjnCu8F4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d8901cb98so1931096f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729242630; x=1729847430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REHoi0BzREleJqZ/Nl2V6XA6vWcoShbFDJgBvOZh4is=;
        b=QjnCu8F4EyUwiQRZeJdWDxCGEMqF3iRtckmg8lOh1THdh7kgkujkrlOlCt/xC5hkVh
         MapBnyAjQgF3aeUIDpthewlaI6Icqofs3z/kXP82xm+XcUKwm5LEjPkH9yyE7crVG7FY
         HHBIPdSUS2lleBPpXdViXiAIQ2wiboGZydAP5Y3V0FH8CheXAEMUvwr3LqUFIfiFcdqZ
         Vzt4IHSGWTSb9KPkxWQVtMK6UZs9/1AJwD5QtOM6lnGGKRmqxSRbwsWZ+ezeSKO8rMDc
         Kd1hlNirNqyljSfiRiCS2HlpCxCOj3Ym62Q+9y9rMKgXvlzFdRcC7N+DLHgSZ5Z7HSQi
         W47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242630; x=1729847430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REHoi0BzREleJqZ/Nl2V6XA6vWcoShbFDJgBvOZh4is=;
        b=b9E4sM+na/MJwKE8fgMWVJ7WFbVcQbkgUMmwYLMBafyq+1ixdExaIExmByJrfSdsrj
         v9G+7FXVTH9bxzpvManh5aEgtQVGXQXCoRmDnzAUVKkR9IqRdJZmIfCJ/7nYpcjpNccj
         1VjJjIiWlEZ1lBQ3UAl0h9hHTKtU/Op46r1NwxCnXHzL9LmSNLx/LtI7+duGuITz+ViL
         +HreiI0L9P/TPp/LOfWBOddUnd2FaTDbMPAqq6KZ+AW80BJ1IK5SzhTxjAfgPcokX6tW
         1zh+NwkIwwacrTm0lOQX92+XjpNcahmOx/XtXnQx1hntJPeGV9bERJ/W5VHdD+6T7rP6
         4F9w==
X-Forwarded-Encrypted: i=1; AJvYcCXu8W15cp2LM5ysNnUGAT49hnd8Kj8shZSWC+eJ/RbQ1wY+UEFB/Pb7dieQaaJU3KDxhJ8OPvSoUSx5oao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8yvrqC7RxpQDZyaK58EO3BUdjhMcA+4K5dXMov31TeylV5Z+n
	ya9DYzPE6HrXGaSCuyc66RXxgrw2hZZkeNe5g7VPr2cAiXZPG6ipzTNkil8J45s=
X-Google-Smtp-Source: AGHT+IF59FkLke48y/tED1sswyqQuEIFmITsdXrGTMYBeUWtpag4jSNeJzAy0fzaltXMN1VJAj4BfA==
X-Received: by 2002:adf:e807:0:b0:374:bd00:d1e with SMTP id ffacd0b85a97d-37d93d43e56mr4314930f8f.3.1729242629630;
        Fri, 18 Oct 2024 02:10:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dbe76bsm18700455e9.10.2024.10.18.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:10:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 11:10:15 +0200
Subject: [PATCH v5 7/8] gpiolib: switch the line state notifier to atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-gpio-notify-in-kernel-events-v5-7-c79135e58a1c@linaro.org>
References: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
In-Reply-To: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3446;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JremVAHUv8l5XF85K04PimL7Ca9vBLgcOvsxmUmBC6Y=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEiX7Uvg6llp/YErZf7m6l3e5mMsEISb0Scjju
 p9Al4Fq1MSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxIl+wAKCRARpy6gFHHX
 chfkD/92Mnj6ZOwvRlmap25XjTh1CT9VdZosExN3r+p/dApyORvmONGN903XoP4XnIiXPEPKZi+
 OBjf1Bxk06vJ+2xcTHh5yI0C/Oe70BOIQZ0qp7kNLOuAge0qL+ZQc3jiiYxIUtJ1vU5QXd8EqiP
 sJsJrW+lmTulSgKGy7fLDQ7NV/wyYgbfh+4NQPM+PISwj6Y8hjjIMyxNexDYu6v5d/lWJGV/hii
 i9vtJxEbo6wG130RIhBSuZpjjtSGkqhjmQNsujxY0/lQ26R031aWMp1JAFE4MZBpeoq7i1QVJcj
 c7KQkA7ajGhkOlG+8yEweWGtBROy5k/NKAsgVrOceoGanLmtivZosL8uA+GVA214/p41iaqqMeI
 HIn8AEOWE1RdLj5qtybCpbBpH/2/uCVgjBXeD8GeEEsxKvkgiTbKfqAtyKmo2+vfunRqHfK0Qt8
 wWBMNb+FEZc7/Uw1Lh27XVR/Xq1kNMjw5JcgzjAlGtRvhKFn0WvV4+XH2C+9pvl1UMyUJgK30cV
 W2vr6LpoYTrceULzWoQwmX7MkkumRM/GzStfdKdFtr+Fe2g6yVvXr+5zDSwuQL4IgJs/FdcpZnN
 GJaxeAizbs9tzC0qM7dt0iIvCv2QphNVbupcLjBpRmyff+Yn9t6TzN/cptQNpKKr6yk8f51ziMK
 kTBYLlfK4qJlteA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With everything else ready, we can now switch to using the atomic
notifier for line state events which will allow us to notify user-space
about direction changes from atomic context.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 12 ++++++------
 drivers/gpio/gpiolib.c      |  6 +++---
 drivers/gpio/gpiolib.h      |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 7759dca92f8b..cb4fb55e2696 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2729,8 +2729,8 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
-	ret = blocking_notifier_chain_register(&gdev->line_state_notifier,
-					       &cdev->lineinfo_changed_nb);
+	ret = atomic_notifier_chain_register(&gdev->line_state_notifier,
+					     &cdev->lineinfo_changed_nb);
 	if (ret)
 		goto out_free_bitmap;
 
@@ -2754,8 +2754,8 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	blocking_notifier_chain_unregister(&gdev->device_notifier,
 					   &cdev->device_unregistered_nb);
 out_unregister_line_notifier:
-	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
-					   &cdev->lineinfo_changed_nb);
+	atomic_notifier_chain_unregister(&gdev->line_state_notifier,
+					 &cdev->lineinfo_changed_nb);
 out_free_bitmap:
 	gpio_device_put(gdev);
 	bitmap_free(cdev->watched_lines);
@@ -2779,8 +2779,8 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 
 	blocking_notifier_chain_unregister(&gdev->device_notifier,
 					   &cdev->device_unregistered_nb);
-	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
-					   &cdev->lineinfo_changed_nb);
+	atomic_notifier_chain_unregister(&gdev->line_state_notifier,
+					 &cdev->lineinfo_changed_nb);
 	bitmap_free(cdev->watched_lines);
 	gpio_device_put(gdev);
 	kfree(cdev);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 807bee86afd5..83e85dbfdeed 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1026,7 +1026,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		}
 	}
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 
 	ret = init_srcu_struct(&gdev->srcu);
@@ -4098,8 +4098,8 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action)
 {
-	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-				     action, desc);
+	atomic_notifier_call_chain(&desc->gdev->line_state_notifier,
+				   action, desc);
 }
 
 /**
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 8737e1641278..a54be597d21a 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -72,7 +72,7 @@ struct gpio_device {
 	const char		*label;
 	void			*data;
 	struct list_head        list;
-	struct blocking_notifier_head line_state_notifier;
+	struct atomic_notifier_head line_state_notifier;
 	struct workqueue_struct	*line_state_wq;
 	struct blocking_notifier_head device_notifier;
 	struct srcu_struct	srcu;

-- 
2.43.0



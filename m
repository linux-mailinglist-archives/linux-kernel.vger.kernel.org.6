Return-Path: <linux-kernel+bounces-556305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8AAA5C3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB9F3A5810
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F06425BAAE;
	Tue, 11 Mar 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YNJ+NeZK"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE2158A13
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703508; cv=none; b=L5EaVekNqopuMmk9CDgAQ3fIXB52XoiPRKYhFzTFlEuQ+Dbq1NdZ9qpGHb2/iTPK32Ks8xXayYoCU8nY5hnR1QwiBP89lGKOmu+2qoWQj0yhz6EyqwMgjdY9neyRVdNcO2+f+zQiV2KVWiCiWpBV3L7lRd6XJJTbYlmQCKmPD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703508; c=relaxed/simple;
	bh=YXJNy14cVHUzFFk8z8wOVv+d2MzQCdgH6KsYK+IdEB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EP5/KQll90IOZPN0Kzmz7JLOEsKRivvnHEKK8co5/tHb+mmshEL57F6KRLkaYM9rPdAtaviGMW3VCkS9xPS+JdIjdJKc8sBQsPMfWiuWvrxWt1Ch9Re9gaZAJAsCa58A4HincKuegGQWgRyFvnL0ZAP/zQMI4CBPuIGYe2z0sbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YNJ+NeZK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso4320550f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741703505; x=1742308305; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SSH0YMdf+S5QjCHcC5ZZ6jS3iz9vBV0qYNcsmg4sNcQ=;
        b=YNJ+NeZKhcX7cLnMct8k5Am4BYZIW/JaIW/ujUlnuTpdLTAxVLqdfYGoTBxIgOiWsj
         z7wnQH4vYTFxsPRblewRWh6oU3MlN7412Oee6BVcI+eSK8CD05T1Hu8pgyiMbCcJYmbt
         Tk46bzYJ8UXCR6Z8ZbZPEqxb2zyjl/8a/40NYymEqtJqGmmUOv8gd8ZbeGw4673WCFw0
         ZayshuFl3lRKBvKZxUMXts9qlbzLhkiVTXc71CrgoVzdipO5nlicRNp71FXPed1S/rTu
         Q6jAlAmtTmePDWFxD/mjKH2wKXXVQT2MmEoTqATBSaQO7nxKr2ukqqSuugJLPCE4ieLg
         nmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703505; x=1742308305;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSH0YMdf+S5QjCHcC5ZZ6jS3iz9vBV0qYNcsmg4sNcQ=;
        b=pGG7FWrXUiSx0K9waS1qvCIiDgaPZ2vzLeGAwzffigXv6eW06FGfXkqgDz3/+Tobmt
         GEHBZ9L25xqgTn2BXykRnJt9f6BpmNQ9O/kvb+GKrhI5uNF6fEZvk92PJsAqzLZVoSlt
         iP/37XevON0kjwX3U6IgQtdM7O96UbQAdaUQmUmcF5tJAVFMKYnThbu73BNWEJSzCD+K
         kFlNwKEQsktMl0N2S39oI6+9gz95kAXIGnICPh6vbMAsg5YegkKuUhn2lwZEwKjMYxwA
         wlGjD1EdgtUgPl32obzzJaURDAo2bUzDCD+JhxGLprKA134Hj2+VIwtBPRTYnbHsguyE
         OLyA==
X-Forwarded-Encrypted: i=1; AJvYcCUq5nAJnSuoFoJqzzoDyAtRPtHRfHwqcbJ+lnucXp2yDI3/49Tf/nMOPd+x4svSS0IbIH7rChN0XbR6xh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHNjew2Y6F647TpuRlO2PxpbLNH4ArZELIEoHgMluDD60Nfd5
	OXq7YhnNEzmWsVVS6FbUPc50Vx1DN2J2fdoMgx1msviAnrkt2GYnQm8TVcIwDqk=
X-Gm-Gg: ASbGnctP1eG0jZZOgepJ5+xiqMPnigqKdHmuOJYeO6VcOoEsIIXfR7Hdsu4xBMvlWRA
	/XArD2ikWroD8LeKMRVBy/8zzFZYZUIhOwHSUViKfg+bAnczSz9kCDJRpwmq4YylvNNYIB9CV51
	W6/vJbleD8Um04GIFNFWBEkyOgYz7a+VpH1Eq6JbsBEOkTfXsYBRsXHY0GAIk5SU2LEBIdv1zR2
	NCstMTvb5N/+6WLLdtZZcIVMhy2WUjGYhhZoiczN4bUYS/gA23lZD6Md3zhZD73UsiDgbY8bjIW
	C6v86sx0cmsw/ojkT1Q4biVGN3o0Z2XqruOH
X-Google-Smtp-Source: AGHT+IEewd5vJWcLEPWmjko9Zz5+N5/mn4+GPzdtk7A1sEmca5MuhRsJixiaCVtsJrabR8Ta34E1bw==
X-Received: by 2002:a05:6000:1fac:b0:38f:3224:65e5 with SMTP id ffacd0b85a97d-3926c69a085mr4238352f8f.12.1741703505133;
        Tue, 11 Mar 2025 07:31:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5946:3143:114d:3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfe0004sm17835055f8f.40.2025.03.11.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:31:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 15:31:43 +0100
Subject: [PATCH RFT v2] gpio: cdev: use raw notifier for line state events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-gpiolib-line-state-raw-notifier-v2-1-138374581e1e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE5J0GcC/42NQQ6CMBBFr2Jm7ZgWUIIrVx7AuDMsSjvAJKQl0
 wY1hLvbcAKX7/+f/1aIJEwRrocVhBaOHHyG4ngAOxo/ELLLDIUqzqrUGoeZw8QdTuwJYzKJUMw
 bfUjcMwnWymrjSmoa6iC/zEI9f3bDCx73J7Q5HDmmIN/duui9+luwaNToVG+qqneX2tpbXhoJp
 yADtNu2/QD8xlSb1AAAAA==
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, David Jander <david@protonic.nl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5563;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=oIgxL81JZJSAphrl0iSZ6Y1kmJ/6uw9EQxoAW5GQxSQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn0ElQ9tBN2SdLWHuMmLSQZMKGdI9/MJJQoYW9D
 onhtjxeG0+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ9BJUAAKCRARpy6gFHHX
 cv1yD/9OLRcUeMT3V5LYGvlaObOQyRpiep5/CNTYeHyBbeWAV/iHDw/AtXcx+os3sXRTa5WOX5p
 6kfayzvCbKyxetvp+zvFBVwaziTa6JdZZUs+CAQyiWI8UoJt0JCcoqkUsP8LuSdX+d6B0yKmWfG
 xhW8uMQhWpdFXpMb9oXU5fbj0Zlh5ogDf1mFabtS8qPYSu5dkdpjSwCS8FG/tBv2foJ4NidAz0j
 pGZT5eY+HRqyNqN5q4cAQ4lR8I068fIAh3DuVKUb5glgfMwfofU92/gcOARGPwdag85hGc2Cz5a
 2/9mUc4pwPJ0VF+MsWu403aRVGkYF29IK0eOR6e2Ez6JVI3+hWxR//pg4YAcaL8T18cCnLh6kLp
 iTK8VZoRJucYyiM/ZN2j+YmFMt756K1mFUHvC7LjSMBqmXy84ZSzb+m6H4tRI0YZdLZjxiIq5x+
 HbKap1kgOa1vuVPXHOyrTAzB4Ozb0U9Qm7ddMsBAhaEk+dUHLzF3Pa3ryredH0NOz/LVwnsuK59
 ciNjhXl2O12nn2Gcrz5HvB0qDtCj2U7iZ6jd6/I+drK9vhwThOXpwgwZk4joJU3oF8D9g6uJVMA
 OJav9kojZcMK7QLKZnkzLubT29xbl+pQSLs/dwhyZIEF9wgwdKkdgXbIzjW3AivJC9LlRSwuOzR
 hFUTk6xsqZn17Jw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We use a notifier to implement the mechanism of informing the user-space
about changes in GPIO line status. We register with the notifier when
the GPIO character device file is opened and unregister when the last
reference to the associated file descriptor is dropped.

Since commit fcc8b637c542 ("gpiolib: switch the line state notifier to
atomic") we use the atomic notifier variant. Atomic notifiers call
rcu_synchronize in atomic_notifier_chain_unregister() which caused a
significant performance regression in some circumstances, observed by
user-space when calling close() on the GPIO device file descriptor.

Replace the atomic notifier with the raw variant and provide
synchronization with a read-write spinlock.

Fixes: fcc8b637c542 ("gpiolib: switch the line state notifier to atomic")
Reported-by: David Jander <david@protonic.nl>
Closes: https://lore.kernel.org/all/20250311110034.53959031@erd003.prtnl/
Tested-by: David Jander <david@protonic.nl>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- improve the commit message
- collect tags
- Link to v1: https://lore.kernel.org/r/20250311-gpiolib-line-state-raw-notifier-v1-1-d0fa44fd67cc@linaro.org
---
 drivers/gpio/gpiolib-cdev.c | 15 +++++++++------
 drivers/gpio/gpiolib.c      |  8 +++++---
 drivers/gpio/gpiolib.h      |  5 ++++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 40f76a90fd7d..107d75558b5a 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2729,8 +2729,9 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
-	ret = atomic_notifier_chain_register(&gdev->line_state_notifier,
-					     &cdev->lineinfo_changed_nb);
+	scoped_guard(write_lock_irqsave, &gdev->line_state_lock)
+		ret = raw_notifier_chain_register(&gdev->line_state_notifier,
+						  &cdev->lineinfo_changed_nb);
 	if (ret)
 		goto out_free_bitmap;
 
@@ -2754,8 +2755,9 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	blocking_notifier_chain_unregister(&gdev->device_notifier,
 					   &cdev->device_unregistered_nb);
 out_unregister_line_notifier:
-	atomic_notifier_chain_unregister(&gdev->line_state_notifier,
-					 &cdev->lineinfo_changed_nb);
+	scoped_guard(write_lock_irqsave, &gdev->line_state_lock)
+		raw_notifier_chain_unregister(&gdev->line_state_notifier,
+					      &cdev->lineinfo_changed_nb);
 out_free_bitmap:
 	gpio_device_put(gdev);
 	bitmap_free(cdev->watched_lines);
@@ -2779,8 +2781,9 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 
 	blocking_notifier_chain_unregister(&gdev->device_notifier,
 					   &cdev->device_unregistered_nb);
-	atomic_notifier_chain_unregister(&gdev->line_state_notifier,
-					 &cdev->lineinfo_changed_nb);
+	scoped_guard(write_lock_irqsave, &gdev->line_state_lock)
+		raw_notifier_chain_unregister(&gdev->line_state_notifier,
+					      &cdev->lineinfo_changed_nb);
 	bitmap_free(cdev->watched_lines);
 	gpio_device_put(gdev);
 	kfree(cdev);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5eb3f0ee071..b8197502a5ac 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1075,7 +1075,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		}
 	}
 
-	ATOMIC_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
+	rwlock_init(&gdev->line_state_lock);
+	RAW_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 
 	ret = init_srcu_struct(&gdev->srcu);
@@ -4361,8 +4362,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action)
 {
-	atomic_notifier_call_chain(&desc->gdev->line_state_notifier,
-				   action, desc);
+	guard(read_lock_irqsave)(&desc->gdev->line_state_lock);
+
+	raw_notifier_call_chain(&desc->gdev->line_state_notifier, action, desc);
 }
 
 /**
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a738e6c647d8..58f64056de77 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -16,6 +16,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/spinlock.h>
 #include <linux/srcu.h>
 #include <linux/workqueue.h>
 
@@ -47,6 +48,7 @@
  * @list: links gpio_device:s together for traversal
  * @line_state_notifier: used to notify subscribers about lines being
  *                       requested, released or reconfigured
+ * @line_state_lock: RW-spinlock protecting the line state notifier
  * @line_state_wq: used to emit line state events from a separate thread in
  *                 process context
  * @device_notifier: used to notify character device wait queues about the GPIO
@@ -75,7 +77,8 @@ struct gpio_device {
 	const char		*label;
 	void			*data;
 	struct list_head        list;
-	struct atomic_notifier_head line_state_notifier;
+	struct raw_notifier_head line_state_notifier;
+	rwlock_t		line_state_lock;
 	struct workqueue_struct	*line_state_wq;
 	struct blocking_notifier_head device_notifier;
 	struct srcu_struct	srcu;

---
base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
change-id: 20250311-gpiolib-line-state-raw-notifier-70c1ad3e99eb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>



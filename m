Return-Path: <linux-kernel+bounces-365598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29E999E4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AA51C23312
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636AA1EBFE6;
	Tue, 15 Oct 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="18lyViOJ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55A1E6DCD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989800; cv=none; b=WxCUZlVvEvhqj0SaNKmeSKyGJYKGL6D4shkWBzRA1D01nhBHr+iLeWEZABfnHcz2YPatoXwcpuAwjqXYRlpCcEqenqWR6COadNvfJgBp9IhNMX7fhMCbqO7Lr0yuPw+gXqY184QspGQrTo1Pp7M5FsRA1E14CRhYa6uCvX/4Lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989800; c=relaxed/simple;
	bh=mHGeTXkSLz/quqKh+bgl/pARcGM54n5NF3tAxUstCXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4ihlvzZPbGLeIe8WANRY9X1QV0zm9oXGNXe3XsTpAR9vEKw+3bptI1rnSa1mTrGJVvXuCwT5GxV+mxyKKVm9faJja6BAM8b+DJaedGooDmvA6IndtOTeL8M9tfNfea0M45pc3gPe8wGEIeCBI3UjFIaznqPSdIoPARfOxCi/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=18lyViOJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4612da0fso3757660f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728989796; x=1729594596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bElfYV+JapcJ+9k6206jn81atKKk59YkmAHm0D9qLSU=;
        b=18lyViOJD2ZTvMcOe/Q4BabEBV2O2Vu2QrPF/42BmvVW4nh2yxF5txFtxByCBfvcgX
         DreXSYZRmSjt61BpT643vN9l4uBv2YC1g/o+QGoC9lG2y+Z3YLeROCUmZU21pudhgXB2
         T//a0nwSLOCCdIVEUzQWJZAihOl5JzYORRAgCAtSI9nJyF1pUz+AB6VLMws0+cJ9GTZN
         75u20kMyBvWcKJSuioZo9JRVT6OwuPE/iHoHWsak8z0ctWkKsW/Uy+12r4rnX20m8IQb
         QVH4iBXXIPSvL3MAt3Q5TXsVOmonH3K6eBCXNPnPxWGqe0130LqgW/kIJeqyNN4dWQtx
         3UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989796; x=1729594596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bElfYV+JapcJ+9k6206jn81atKKk59YkmAHm0D9qLSU=;
        b=UyMYJKWSs7wqo43u+GRhQJHDcU52PCbkaHdzBWRN2Ey4h8l6KtHCuexe7GSFEh6D/7
         xaR3Pk1Bm+C6klkoSKb6hnms14osGO4x3/bgKd+JluXfa/rTihMNyYaC9qFta8NqpV16
         BRnfWId0N1ryQzlaocLLLmkZwHbS8EwR9oL966LBa3/IWLvozbANmEU6E2vS+Mx4qf0/
         MOsCLAMnPbnTVKTtrgzbzfU6yu9Baz3Iq7G+QiJyW4NpT4decTCAvXT3XyKeAOkw3dfT
         Hl2DqIWIGSFg0U++zWUi0AU0j+slQLcqjUoOOYhdYSAkG2m42yfS7UGyh5wQ6TzlB/YF
         GLBg==
X-Forwarded-Encrypted: i=1; AJvYcCXE0g99aZ39+ybC/WHd3o6LtH+E6XL2JuiRLwihGKvKyOO3fKL9KXMiw4NzFuiHnP8m7i/ME75demTyb1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Rz7VEwDY2yEYYdNrrABe6GiJwv2mrShHNF683X8r14f4l7/h
	GRtszSi5CBmAYlTDdVtn3UWHFM/9NAgNnNDFnDi9JgdgRBk6vRQBFy92Bg6HKiMAta36Ih3MnAO
	O
X-Google-Smtp-Source: AGHT+IEIJ1qi8uK3FnfhqXu3LOYo+YKUT2SgWKr6f7lGkitGelO5x8dSZ/qNh/f1JGg+EOlbMdjOcw==
X-Received: by 2002:adf:f5c6:0:b0:374:c157:a84a with SMTP id ffacd0b85a97d-37d551fc33amr9812385f8f.16.1728989796149;
        Tue, 15 Oct 2024 03:56:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc403d3sm1254115f8f.101.2024.10.15.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:56:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Oct 2024 12:56:16 +0200
Subject: [PATCH v3 4/6] gpio: cdev: put emitting the line state events on a
 workqueue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-gpio-notify-in-kernel-events-v3-4-9edf05802271@linaro.org>
References: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
In-Reply-To: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4901;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=f8lvTlR7jwkkQHTiOBQ0YBYlycUUnx2/1dVqc+JGfAw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnDkpe39urhIK2g2iZKIfiIdJYk0gGf71GbpYBz
 E/dfDumy3eJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZw5KXgAKCRARpy6gFHHX
 coaLEACZ+jXIKIcTgPJRx+YuzqYx+JNnJ1HTOu6bF/kUDBLmTOpkfmelTrIrY1gW5myTxvGtMdL
 0zHa/PaRyWZD/RHQA0+iwuJrwBGssbG324Y2fdguJmxyaTHwT39yojGSNGw0FgHGU8a21xIG22u
 YzXhfMSSgr+e/wm+Jfv5rL1SUPcYpSWc64n+1nOwgJnnGfuvudYuKlVvf3bjdUkjLVB41DscKnt
 tQ9Rctdg7PPvsJKTYpMnEFkDl2dX+Q9RnK0HSa8vPFmvnsA42iGz5Rn2LWe46lG0PsIxFSTkXnd
 Su8CcPARCmITnLUh+qeZ7SLxgE7GAGUNkAmHy3XhmMKErfQ+tVr4W5CxmNU6KG6g1REaPTd4q+P
 NUsN1KvmQ/0gDoWDxxwZmnjGLHj3A/gI97j6TQF2E82fxh/yuApgL9SY3RW7QNDa2ABGhqF98oZ
 OR8JUcVOK1Y1I1U99wyUEujKGUOGMFZJWMnafYGUofcStMt6qy6itPh59mtNhhMb0imKlAa8/C3
 Ls0oom4SoUtP4qsGL3ZUprZad/vFV6PUMXbaOWg949HWhLHgG+fMLxaWwLZIENTPFeOGrExGoCI
 k8I2hKBUu5KYY4u3QkSAZ62+I7URLv+PMBuWWUL7UJ/aHySM3+tcg2RRq4xtDQBjed6DOI4rF6Y
 H2fEX/OBPVvz1qg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to allow line state notifications to be emitted from atomic
context (for instance: from gpiod_direction_input/output()), we must
stop calling any sleeping functions in lineinfo_changed_notify(). To
that end let's use the new workqueue.

Let's atomically allocate small structures containing the required data
and fill it with information immediately upon being notified about the
change except for the pinctrl state which will be retrieved later from
process context. We can pretty reliably do this as pin functions are
typically set once per boot.

Let's make sure to bump the reference count of GPIO device and the GPIO
character device file descriptor to keep both alive until the event was
queued.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 84 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5b28a558c9d0..a10d6ea22415 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2450,6 +2450,7 @@ struct gpio_chardev_data {
 #ifdef CONFIG_GPIO_CDEV_V1
 	atomic_t watch_abi_version;
 #endif
+	struct file *fp;
 };
 
 static int chipinfo_get(struct gpio_chardev_data *cdev, void __user *ip)
@@ -2620,29 +2621,87 @@ static long gpio_ioctl_compat(struct file *file, unsigned int cmd,
 }
 #endif
 
+struct lineinfo_changed_ctx {
+	struct work_struct work;
+	struct gpio_v2_line_info_changed chg;
+	struct gpio_device *gdev;
+	struct gpio_chardev_data *cdev;
+};
+
+static void lineinfo_changed_func(struct work_struct *work)
+{
+	struct lineinfo_changed_ctx *ctx =
+			container_of(work, struct lineinfo_changed_ctx, work);
+	struct gpio_chip *gc;
+	int ret;
+
+	if (!(ctx->chg.info.flags & GPIO_V2_LINE_FLAG_USED)) {
+		/*
+		 * If nobody set the USED flag earlier, let's see with pinctrl
+		 * now. We're doing this late because it's a sleeping function.
+		 * Pin functions are in general much more static and while it's
+		 * not 100% bullet-proof, it's good enough for most cases.
+		 */
+		scoped_guard(srcu, &ctx->gdev->srcu) {
+			gc = srcu_dereference(ctx->gdev->chip, &ctx->gdev->srcu);
+			if (gc &&
+			    !pinctrl_gpio_can_use_line(gc, ctx->chg.info.offset))
+				ctx->chg.info.flags |= GPIO_V2_LINE_FLAG_USED;
+		}
+	}
+
+	ret = kfifo_in_spinlocked(&ctx->cdev->events, &ctx->chg, 1,
+				  &ctx->cdev->wait.lock);
+	if (ret)
+		wake_up_poll(&ctx->cdev->wait, EPOLLIN);
+	else
+		pr_debug_ratelimited("lineinfo event FIFO is full - event dropped\n");
+
+	gpio_device_put(ctx->gdev);
+	fput(ctx->cdev->fp);
+	kfree(ctx);
+}
+
 static int lineinfo_changed_notify(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
 	struct gpio_chardev_data *cdev =
 		container_of(nb, struct gpio_chardev_data, lineinfo_changed_nb);
-	struct gpio_v2_line_info_changed chg;
+	struct lineinfo_changed_ctx *ctx;
 	struct gpio_desc *desc = data;
-	int ret;
 
 	if (!test_bit(gpio_chip_hwgpio(desc), cdev->watched_lines))
 		return NOTIFY_DONE;
 
-	memset(&chg, 0, sizeof(chg));
-	chg.event_type = action;
-	chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &chg.info, false);
-	supinfo_to_lineinfo(desc, &chg.info);
+	/*
+	 * If this is called from atomic context (for instance: with a spinlock
+	 * taken by the atomic notifier chain), any sleeping calls must be done
+	 * outside of this function in process context of the dedicated
+	 * workqueue.
+	 *
+	 * Let's gather as much info as possible from the descriptor and
+	 * postpone just the call to pinctrl_gpio_can_use_line() until the work
+	 * is executed.
+	 */
 
-	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
-	if (ret)
-		wake_up_poll(&cdev->wait, EPOLLIN);
-	else
-		pr_debug_ratelimited("lineinfo event FIFO is full - event dropped\n");
+	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx) {
+		pr_err("Failed to allocate memory for line info notification\n");
+		return NOTIFY_DONE;
+	}
+
+	ctx->chg.event_type = action;
+	ctx->chg.timestamp_ns = ktime_get_ns();
+	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
+	supinfo_to_lineinfo(desc, &ctx->chg.info);
+	/* Keep the GPIO device alive until we emit the event. */
+	ctx->gdev = gpio_device_get(desc->gdev);
+	ctx->cdev = cdev;
+	/* Keep the file descriptor alive too. */
+	get_file(ctx->cdev->fp);
+
+	INIT_WORK(&ctx->work, lineinfo_changed_func);
+	queue_work(ctx->gdev->line_state_wq, &ctx->work);
 
 	return NOTIFY_OK;
 }
@@ -2802,6 +2861,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 		goto out_unregister_line_notifier;
 
 	file->private_data = cdev;
+	cdev->fp = file;
 
 	ret = nonseekable_open(inode, file);
 	if (ret)

-- 
2.43.0



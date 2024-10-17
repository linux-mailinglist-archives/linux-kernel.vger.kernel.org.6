Return-Path: <linux-kernel+bounces-369403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42EB9A1CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDF9B27200
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49E1D6DD8;
	Thu, 17 Oct 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Qo9Y/87l"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC91D2F73
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152876; cv=none; b=R4gzIg/uLquLF9PwmtdlgKwY1F/klktp3iSiO+wNNINI8wiqgJrBE3eo1pZLxB5kOKQEtQO8ZdjuAxklvZrvirmn31BWZMhH5J67ip5hZkxv7ufUc8S/52wqoX1Wf9kXemoxxd45cDPa/jrj1G41QRVGtEkdBO1ffdLu4lkKfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152876; c=relaxed/simple;
	bh=PrpJFSn1v8nec0wiPaBWRUGeCDKvtDkJixy1vIPLnV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=maWHtHAD2/jDhTiz36HnDGukiMsKln+L5uO+Vj+Z6cnt2js4BT2KtjPN6Wov+cAO6D2v0sP6ffnEF39AmAfsD51/KLD37MOeb6gYBqspRtzqNbhYLuVMnG7G53GcKHUfx7mWy02+r3g7OAxc9uLIefa2xo7lkN47LCW3AIqfXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Qo9Y/87l; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so527987f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729152871; x=1729757671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ9+jptp7Dks8GR7GteYZhyJSD9aHU2HeME8AuCmILE=;
        b=Qo9Y/87lO3P/nODRAVmqG/Xg3U+B0Vb6jfcD6zo5PFIdtLnsWzcS47FhPwFI/Tcixn
         f/oOqPZvehFR/Ej4rIgWgfA0g6psGOHIoGUBuH7P8uCoa6XZQE0hCllEpwZrf/OGHlFj
         bgMh2orUInAvXSktP25wQojYkLDwj3Vp8LezdtdPTTaM/hBSqsBKxT3xRO0OJOYMKyx0
         w9DZAodfl2EmS0yW796hEKBRB0HpzXCox3HrSxGnGo31abRBQzoLn1XQykIghw+jr5V5
         z+/Nnj4c3MIMWFA6cHaLGOe5hbRFx7pSfLfTLH3iSE5bdEnOIgzzWO3aNcJHlNp11uFE
         7nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152871; x=1729757671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ9+jptp7Dks8GR7GteYZhyJSD9aHU2HeME8AuCmILE=;
        b=O5kj7sWxU1AKBKG470CAjC1lxQJw+UkWC2aGI4sp1/fmWPVd1NPHi6WpMuByajgg43
         J4olaZ8l23NsufMoGhzbNkrFB4LhNf+sPVpTWggGg4L8o/qgyC7N3GjqJj/XzYgJvLFL
         uwV6Mnbuph1AB32PjNefxEJhTvDqHUgUrfzBTEjVHIzMSad8AdeArySQdNH2XYfv0nZZ
         5txXEMx4iYP1NpJ6wVILd/4m9jRZ2TQxMLs6wSU4HJuJ+0NO1uzDlbwymznKIyMk4Hgi
         mHgOU0xs6iwX35dn2BRTmRuEwUvYa5RhRriaP7acExRPHJ16Z7tmR37rTQ5zzqdWawrb
         vLNA==
X-Forwarded-Encrypted: i=1; AJvYcCX1qrNGvR95aqXHK63lwsFKGlw7k+vDVBqLSMg/JKrCkHMjB9G3AHleT4Qw9MLK82plf+ae8InS2EOmbJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNd/XJe7QNwDXJ1fdU1Yflw9Vhf31Tf+Cg5FaG5eIfeVR8Wtf
	5MTjhNkmav5Rj9qe59Z9pMHaAHrZG0cHza276OToTmoiiCm7MrKIwpUtZeX5BuE=
X-Google-Smtp-Source: AGHT+IFp91K7aB+pkhTWU5PY3/I1G7XdXkQZ/Im9BRoGn8XOuM5lVIYcdL35JpTmPY+jKUHhfHHsvw==
X-Received: by 2002:a5d:53cd:0:b0:37c:c4bc:181c with SMTP id ffacd0b85a97d-37d55184de1mr14688262f8f.11.1729152871206;
        Thu, 17 Oct 2024 01:14:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c61ae2sm17855695e9.46.2024.10.17.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:14:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 10:14:14 +0200
Subject: [PATCH v4 6/8] gpio: cdev: put emitting the line state events on a
 workqueue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-gpio-notify-in-kernel-events-v4-6-64bc05f3be0c@linaro.org>
References: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
In-Reply-To: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4814;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=8oH0OI5uVpWymK+8p6k+EMIaU2WzdTdaL9nSO2G6k4U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEMdeWUyYkvPl7I78riyiWYJVx4BYSRlNCtrtg
 LE7hAGq8XaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxDHXgAKCRARpy6gFHHX
 cihHEADF1jNbnrL74iwG7sGU7ba916dZuIrsffm24qBZWXgej8JqhlYO/O0rKDMnAppERCpjsL4
 mfLFjLN/u/RTLOBxRy6cgQpCoWeDKYkj7KKf/6T9dR63GiErCusSOCSYLzV3QbBpB6yI79AAxsV
 6skhRcLNNIEpE1VUPdAdByRNmb3ncm0mIofSuLOfElrvVsqSo9ArZEgqcNVs8acW7IuclxoGQPN
 wjaWvBJhWen03AkdLwoKQUQQ2w2UeKVpSlfSENK2+GHfy+VpmNv+OQWbLg6FRc6gv2WxIVinM2i
 c4PrGc8BcZAGhu24WZcqkcEZVziOQ6JjDeZA584FZYxRiv+wa/JKVO7ajppIRN5prkSY9mzGBSl
 eTBqufaeTaUvBqyg9gavvx2zmBEGvmC2sNNX53lFO+ZLA9BlxC5Kgnwle1awYMWp1cVtIyTqK5O
 RUP56s+Dia7t2C2BA+rC1PP2c/z9j9HGSPZiUqCbVzTc+waKu0j+86yVbDpl7BHIU41VVWXICs4
 XlZTgM3Jo2+DtnslQcNMsiS5D016n4IVQu6+zfikJP2v9i7BgWXmiZVkchJPKsf4eBtQqMH4H1L
 2r5laGqKrRp3JIwhJt5PoNHSSHwhCCMCkgWblDrruWFQ+T1y1k7aRggDdve39bJG5VfQve/h0Xn
 y4THTRKYjkR2pog==
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
 drivers/gpio/gpiolib-cdev.c | 82 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index b242fdb1ad28..7759dca92f8b 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2333,6 +2333,7 @@ struct gpio_chardev_data {
 #ifdef CONFIG_GPIO_CDEV_V1
 	atomic_t watch_abi_version;
 #endif
+	struct file *fp;
 };
 
 static int chipinfo_get(struct gpio_chardev_data *cdev, void __user *ip)
@@ -2502,28 +2503,86 @@ static long gpio_ioctl_compat(struct file *file, unsigned int cmd,
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
@@ -2683,6 +2742,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 		goto out_unregister_line_notifier;
 
 	file->private_data = cdev;
+	cdev->fp = file;
 
 	ret = nonseekable_open(inode, file);
 	if (ret)

-- 
2.43.0



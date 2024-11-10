Return-Path: <linux-kernel+bounces-403356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269529C348B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547B91C20BFF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01613BAD5;
	Sun, 10 Nov 2024 20:17:18 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371818E1F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731269837; cv=none; b=oT7kUIP0PWTbwAY56vbwSBBmbe58/hVQjPSmwvGMEDxqJc18tAYRDjoXlEAdIauCVBUFfhNslB+5g1o82jWcYATEIS1CTnXP+L6v4ZShSHel3+9Lh0HgCkgCGZxaaFPXc2AE1kqQIwjHbSNDWiMOAB4wdji8FRopdQjTjTUu/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731269837; c=relaxed/simple;
	bh=NGIScqIeeFRYfnwjF1bTumgir2LtoUL83VTSB/cTw5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUE001wkwckrOuPjhtZY9OwEpvLJW/grQ8YdQRiffHXyXKc0tnRp7EKo8HT1ROAWLED0RCs6IFTL9o3dtB48hlujHZcw5hO5LPtYeV+2MbjAZ78ogn3jucw6h4d3rsgr631i/okgXCdpfYcn5wqnlbUYdnt0wr9o2uXpeOdyUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id c33b8ed2-9fa0-11ef-a0b4-005056bdfda7;
	Sun, 10 Nov 2024 22:17:09 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [resend, PATCH v1 1/1] gpiolib: cdev: use !mem_is_zero() instead of memchr_inv(s, 0, n)
Date: Sun, 10 Nov 2024 22:16:15 +0200
Message-ID: <20241110201706.16614-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the mem_is_zero() helper where possible.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

resend: mem_is_zero() is now part of the official kernel

 drivers/gpio/gpiolib-cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 83ebcc8c83eb..40f76a90fd7d 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -16,7 +16,6 @@
 #include <linux/hte.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
-#include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -25,6 +24,7 @@
 #include <linux/poll.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
 #include <linux/timekeeping.h>
 #include <linux/uaccess.h>
 #include <linux/workqueue.h>
@@ -1215,7 +1215,7 @@ static int gpio_v2_line_config_validate(struct gpio_v2_line_config *lc,
 	if (lc->num_attrs > GPIO_V2_LINE_NUM_ATTRS_MAX)
 		return -EINVAL;
 
-	if (memchr_inv(lc->padding, 0, sizeof(lc->padding)))
+	if (!mem_is_zero(lc->padding, sizeof(lc->padding)))
 		return -EINVAL;
 
 	for (i = 0; i < num_lines; i++) {
@@ -1629,7 +1629,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if ((ulr.num_lines == 0) || (ulr.num_lines > GPIO_V2_LINES_MAX))
 		return -EINVAL;
 
-	if (memchr_inv(ulr.padding, 0, sizeof(ulr.padding)))
+	if (!mem_is_zero(ulr.padding, sizeof(ulr.padding)))
 		return -EINVAL;
 
 	lc = &ulr.config;
@@ -2411,7 +2411,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 	if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 		return -EFAULT;
 
-	if (memchr_inv(lineinfo.padding, 0, sizeof(lineinfo.padding)))
+	if (!mem_is_zero(lineinfo.padding, sizeof(lineinfo.padding)))
 		return -EINVAL;
 
 	desc = gpio_device_get_desc(cdev->gdev, lineinfo.offset);
-- 
2.47.0



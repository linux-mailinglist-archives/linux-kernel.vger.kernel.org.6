Return-Path: <linux-kernel+bounces-421567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683949D8CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F179916A53F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006F1BF7FC;
	Mon, 25 Nov 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LqM8uqFB"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C766161328
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564157; cv=none; b=SeoMWKn1l/KtxdnVg/EXVTcXaKrGTHPgTbA6FxjkdHp6Uil8uBtYEy36UfDvWOMo9822S/YPxyVQxfCm5vzsp94Zzvh35Gr/DCu1p/f7PkytuBtwE/BIsWd18xPf9Pl/Wd0mWie1KAabO0m/wzWo5IwAWmm8JqInOcSWpwmsHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564157; c=relaxed/simple;
	bh=rkxPaYdXHGqxfJOHO5r158lYWCRJX4SpWGFNVeI33Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDw/7xFLsYrt7zhDVMKE/OjUXmMRDLEDHqXcQ2Qclpl8yuuKbIlbYhsnfA/t/kb1f/L2GRAVgFj+dFVldjy/cO1QLeJrQDgY37GCavvoZXBfro4qclSIkaVU5XhJfCmm1bFwQpGzvQPb3lrgEu4L6s/VF78jvQN/ZNr8KfZaWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LqM8uqFB; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85706e5ecabso2365223241.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732564154; x=1733168954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNkRUI2D4ZTXw4CmB2STFErzqoquptPhm1N/NMRAw7I=;
        b=LqM8uqFB5XxRxfN4FGq2woeAp6o3k69GMA6DPW+KmgfeneHwcyoq15CsGlgQhazMx6
         vwlSGCfsgpMXa2DTACkbMpnyPj6cY/HKQub/X9oKF88Gk/dyEPAX01iDAFe3N/Z0M3RU
         u6p45nNya7q/pxQv4jfNaqoQ2pySMGAzxU3Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564154; x=1733168954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNkRUI2D4ZTXw4CmB2STFErzqoquptPhm1N/NMRAw7I=;
        b=jNy3ust/2MZ3WZc9is0Aiqu9L5XZAmTWALJcekn8Y+3zAu+S2Qwj05HFuc69ZtvOVF
         WXfcts71wpHikU5bzdx2RkkaoV0socJPGvqeSbF876C9CcFZvniEMPrwduC3zw6/AOvf
         +MNuhUFn6ZUhK+3zJIv4788yJtr92poWetEI8JpKJPzpMTDH+/HOFcIDno2OPAemLMNc
         wLOT/OEJ2+1HnXc2ltLby/2GlS9I1tE3AWJE38SNnJzieRAVHQu6egCv2dAuRyXPUu1V
         Xxt3zDj6YrL2kmEHN8/Zsl7YiT+h/WpMOCkceYuB8enoZp4MmFPYoNwPvSVlEXF9lCMp
         mO4A==
X-Gm-Message-State: AOJu0YwnT1z04t9DpePG4FR/3oI3I7VvZMT6FftpZKqG66Po7N+NpY2K
	4QRYqddtGZxwPh07JjMaf0gPVqwKw8fBAI6aUfH+VBQL++OFuR2rvHh5yt3mLg==
X-Gm-Gg: ASbGncs427M5L1jX2RF5izodTcbnaPNc0TZ3mXoh5bMKAIFp5pqKdaHVt+jdMGwrpta
	zQDvlDAscep0pUXmX4Y9ZwiQsrB2obH15gD8dwA1cFjo2wsU9I5nP/lYg+hnXPR050A/CKMlGqb
	OURlSKq13loG3gzeMhpBu6CgYjCcfn+z/6e9ANrVLUCvV4QKEC8DNa9Sal0OAVvo5su1r7pGx3Z
	9hLCc4ZnmbKyWTDRayFoQlcpHwJNvKm3FxSqD0HfGKmiCaXVoenRLi9nJt/UL8v/Ypo6wSzLB09
	wWwPWM3tX0UVuCjCjsLH+u9C
X-Google-Smtp-Source: AGHT+IFw4r0pJxPsi4HR2ZjtMg6jgNCS9ulAehVcqVJSXpmzBFsZUst3LdIDlS4ju0WKRKwzvh/1kg==
X-Received: by 2002:a67:f596:0:b0:4af:2d38:2232 with SMTP id ada2fe7eead31-4af35eb0df9mr847909137.6.1732564154195;
        Mon, 25 Nov 2024 11:49:14 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af358d2f9asm75324137.23.2024.11.25.11.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:49:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 19:49:07 +0000
Subject: [PATCH v4 2/7] media: uvcvideo: Factor out gpio functions to its
 own file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-uvc-subdev-v4-2-51e040599f1a@chromium.org>
References: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
In-Reply-To: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

This is just a refactor patch, no new functionality is added.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/Makefile     |   3 +-
 drivers/media/usb/uvc/uvc_driver.c | 119 +------------------------------------
 drivers/media/usb/uvc/uvc_gpio.c   | 118 ++++++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |   8 +++
 4 files changed, 131 insertions(+), 117 deletions(-)

diff --git a/drivers/media/usb/uvc/Makefile b/drivers/media/usb/uvc/Makefile
index 4f9eee4f81ab..85514b6e538f 100644
--- a/drivers/media/usb/uvc/Makefile
+++ b/drivers/media/usb/uvc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 uvcvideo-objs  := uvc_driver.o uvc_queue.o uvc_v4l2.o uvc_video.o uvc_ctrl.o \
-		  uvc_status.o uvc_isight.o uvc_debugfs.o uvc_metadata.o
+		  uvc_status.o uvc_isight.o uvc_debugfs.o uvc_metadata.o \
+		  uvc_gpio.o
 ifeq ($(CONFIG_MEDIA_CONTROLLER),y)
 uvcvideo-objs  += uvc_entity.o
 endif
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 6d34c910a659..914f342f4aa3 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -8,7 +8,6 @@
 
 #include <linux/atomic.h>
 #include <linux/bits.h>
-#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -775,9 +774,9 @@ static const u8 uvc_media_transport_input_guid[16] =
 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
 static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
 
-static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
-					       u16 id, unsigned int num_pads,
-					       unsigned int extra_size)
+struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
+					u16 id, unsigned int num_pads,
+					unsigned int extra_size)
 {
 	struct uvc_entity *entity;
 	unsigned int num_inputs;
@@ -1240,118 +1239,6 @@ static int uvc_parse_control(struct uvc_device *dev)
 	return 0;
 }
 
-/* -----------------------------------------------------------------------------
- * Privacy GPIO
- */
-
-static void uvc_gpio_event(struct uvc_device *dev)
-{
-	struct uvc_entity *unit = dev->gpio_unit;
-	struct uvc_video_chain *chain;
-	u8 new_val;
-
-	if (!unit)
-		return;
-
-	new_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
-
-	/* GPIO entities are always on the first chain. */
-	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
-	uvc_ctrl_status_event(chain, unit->controls, &new_val);
-}
-
-static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
-			    u8 cs, void *data, u16 size)
-{
-	if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
-		return -EINVAL;
-
-	*(u8 *)data = gpiod_get_value_cansleep(entity->gpio.gpio_privacy);
-
-	return 0;
-}
-
-static int uvc_gpio_get_info(struct uvc_device *dev, struct uvc_entity *entity,
-			     u8 cs, u8 *caps)
-{
-	if (cs != UVC_CT_PRIVACY_CONTROL)
-		return -EINVAL;
-
-	*caps = UVC_CONTROL_CAP_GET | UVC_CONTROL_CAP_AUTOUPDATE;
-	return 0;
-}
-
-static irqreturn_t uvc_gpio_irq(int irq, void *data)
-{
-	struct uvc_device *dev = data;
-
-	uvc_gpio_event(dev);
-	return IRQ_HANDLED;
-}
-
-static int uvc_gpio_parse(struct uvc_device *dev)
-{
-	struct uvc_entity *unit;
-	struct gpio_desc *gpio_privacy;
-	int irq;
-
-	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
-					       GPIOD_IN);
-	if (IS_ERR_OR_NULL(gpio_privacy))
-		return PTR_ERR_OR_ZERO(gpio_privacy);
-
-	irq = gpiod_to_irq(gpio_privacy);
-	if (irq < 0)
-		return dev_err_probe(&dev->intf->dev, irq,
-				     "No IRQ for privacy GPIO\n");
-
-	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
-				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
-	if (IS_ERR(unit))
-		return PTR_ERR(unit);
-
-	unit->gpio.gpio_privacy = gpio_privacy;
-	unit->gpio.irq = irq;
-	unit->gpio.bControlSize = 1;
-	unit->gpio.bmControls = (u8 *)unit + sizeof(*unit);
-	unit->gpio.bmControls[0] = 1;
-	unit->get_cur = uvc_gpio_get_cur;
-	unit->get_info = uvc_gpio_get_info;
-	strscpy(unit->name, "GPIO", sizeof(unit->name));
-
-	list_add_tail(&unit->list, &dev->entities);
-
-	dev->gpio_unit = unit;
-
-	return 0;
-}
-
-static int uvc_gpio_init_irq(struct uvc_device *dev)
-{
-	struct uvc_entity *unit = dev->gpio_unit;
-	int ret;
-
-	if (!unit || unit->gpio.irq < 0)
-		return 0;
-
-	ret = request_threaded_irq(unit->gpio.irq, NULL, uvc_gpio_irq,
-				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
-				   IRQF_TRIGGER_RISING,
-				   "uvc_privacy_gpio", dev);
-
-	unit->gpio.initialized = !ret;
-
-	return ret;
-}
-
-static void uvc_gpio_deinit(struct uvc_device *dev)
-{
-	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
-		return;
-
-	free_irq(dev->gpio_unit->gpio.irq, dev);
-}
-
 /* ------------------------------------------------------------------------
  * UVC device scan
  */
diff --git a/drivers/media/usb/uvc/uvc_gpio.c b/drivers/media/usb/uvc/uvc_gpio.c
new file mode 100644
index 000000000000..453739acbe8f
--- /dev/null
+++ b/drivers/media/usb/uvc/uvc_gpio.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *      uvc_gpio.c  --  USB Video Class driver
+ *
+ *      Copyright 2024 Google LLC
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio/consumer.h>
+#include "uvcvideo.h"
+
+static void uvc_gpio_event(struct uvc_device *dev)
+{
+	struct uvc_entity *unit = dev->gpio_unit;
+	struct uvc_video_chain *chain;
+	u8 new_val;
+
+	if (!unit)
+		return;
+
+	new_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
+
+	/* GPIO entities are always on the first chain. */
+	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
+	uvc_ctrl_status_event(chain, unit->controls, &new_val);
+}
+
+static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
+			    u8 cs, void *data, u16 size)
+{
+	if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
+		return -EINVAL;
+
+	*(u8 *)data = gpiod_get_value_cansleep(entity->gpio.gpio_privacy);
+
+	return 0;
+}
+
+static int uvc_gpio_get_info(struct uvc_device *dev, struct uvc_entity *entity,
+			     u8 cs, u8 *caps)
+{
+	if (cs != UVC_CT_PRIVACY_CONTROL)
+		return -EINVAL;
+
+	*caps = UVC_CONTROL_CAP_GET | UVC_CONTROL_CAP_AUTOUPDATE;
+	return 0;
+}
+
+static irqreturn_t uvc_gpio_irq(int irq, void *data)
+{
+	struct uvc_device *dev = data;
+
+	uvc_gpio_event(dev);
+	return IRQ_HANDLED;
+}
+
+int uvc_gpio_parse(struct uvc_device *dev)
+{
+	struct uvc_entity *unit;
+	struct gpio_desc *gpio_privacy;
+	int irq;
+
+	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
+					       GPIOD_IN);
+	if (IS_ERR_OR_NULL(gpio_privacy))
+		return PTR_ERR_OR_ZERO(gpio_privacy);
+
+	irq = gpiod_to_irq(gpio_privacy);
+	if (irq < 0)
+		return dev_err_probe(&dev->udev->dev, irq,
+				     "No IRQ for privacy GPIO\n");
+
+	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
+				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
+	if (IS_ERR(unit))
+		return PTR_ERR(unit);
+
+	unit->gpio.gpio_privacy = gpio_privacy;
+	unit->gpio.irq = irq;
+	unit->gpio.bControlSize = 1;
+	unit->gpio.bmControls = (u8 *)unit + sizeof(*unit);
+	unit->gpio.bmControls[0] = 1;
+	unit->get_cur = uvc_gpio_get_cur;
+	unit->get_info = uvc_gpio_get_info;
+	strscpy(unit->name, "GPIO", sizeof(unit->name));
+
+	list_add_tail(&unit->list, &dev->entities);
+
+	dev->gpio_unit = unit;
+
+	return 0;
+}
+
+int uvc_gpio_init_irq(struct uvc_device *dev)
+{
+	struct uvc_entity *unit = dev->gpio_unit;
+	int ret;
+
+	if (!unit || unit->gpio.irq < 0)
+		return 0;
+
+	ret = request_threaded_irq(unit->gpio.irq, NULL, uvc_gpio_irq,
+				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
+				   IRQF_TRIGGER_RISING,
+				   "uvc_privacy_gpio", dev);
+
+	unit->gpio.initialized = !ret;
+
+	return ret;
+}
+
+void uvc_gpio_deinit(struct uvc_device *dev)
+{
+	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
+		return;
+
+	free_irq(dev->gpio_unit->gpio.irq, dev);
+}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 965a789ed03e..91ed59b54d9a 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -673,6 +673,9 @@ do {									\
 extern struct uvc_driver uvc_driver;
 
 struct uvc_entity *uvc_entity_by_id(struct uvc_device *dev, int id);
+struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
+					u16 id, unsigned int num_pads,
+					unsigned int extra_size);
 
 /* Video buffers queue management. */
 int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type,
@@ -817,4 +820,9 @@ void uvc_debugfs_cleanup_stream(struct uvc_streaming *stream);
 size_t uvc_video_stats_dump(struct uvc_streaming *stream, char *buf,
 			    size_t size);
 
+/* gpio */
+int uvc_gpio_parse(struct uvc_device *dev);
+int uvc_gpio_init_irq(struct uvc_device *dev);
+void uvc_gpio_deinit(struct uvc_device *dev);
+
 #endif

-- 
2.47.0.338.g60cca15819-goog



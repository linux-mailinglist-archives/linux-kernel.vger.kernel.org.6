Return-Path: <linux-kernel+bounces-421570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9279D8CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AB016A64A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58A1CDFAE;
	Mon, 25 Nov 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qt9hhx9O"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7D1CDA13
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564163; cv=none; b=Zw8AHSkovciPip4PgOX9byUY+Oiw4YlR80eL74edcpq6uqU+Le1T1D5XDYXh3pFadGMzt91E/XptgoLkrpTEB9+60UCggoMiANkvLMh9CCADl2eeTiRSMIr/ox/JcCmzJJktDAsURDCOyR0tBB4ySVmUH7Kyt8La29XhyUEPG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564163; c=relaxed/simple;
	bh=fVuGaw1F+PMy4lVEqejt4Vp5RlNBADE5AOJUiE6ElSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdG5CJIf09KRXVg+tD4XvN0r/in9iY1PJI97MIS4OhVRxR6uDcXayLZg+lPQcqgwUaQucXwZFpapDniHeEjDIR3FUXIkYgtBzSRJNHMTG/buSi4ybt8XCEqgBrF1wON+YqgQO/44gOve/kCLu/XRoEeX1bxb7QbPIEfOJ/YEweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qt9hhx9O; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85714347e80so974210241.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732564161; x=1733168961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0D5Q+hYOq1ZPHGsr7NgS7GX1OqcPua9PPDDXDLVIPA=;
        b=Qt9hhx9OSwqE34yiwZ0qZZRjdWFlUCJx2C2jPjVbceI/lTHXfA8sZpnFs/fWDzCApD
         tD99sJL0N8t31zSNLg1UEpsfXmVUp7Du13xiZKcfsr9Riiwy5nB7rw9wIKFV6VhjvJiu
         OrsidDt+T7H+3SzyL8insVQdkFba97gk1DEMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564161; x=1733168961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0D5Q+hYOq1ZPHGsr7NgS7GX1OqcPua9PPDDXDLVIPA=;
        b=wUxlMQCqmnMA3R2eEYlYi4u5xO6zfLTjaPdKyFUAeUILA5UZjLIw511PcxGwd64xBj
         P42zED9MD2FkbxoBbb2FGoCv7v0otJJQAuia0nrTgu/Xtf+yOU1SSWWhtiMUoIC5rX2m
         9Pu5aVXvGjW2LwdZ7OuTBgZnksYSKQuglhVvLibyEkx/uZaPiYLtQIehmoERDWoX4pVs
         uI4TB09bQnPmUI5Fqv1c+pSi7f6IycPWzyt7geSyYaG/LqWd35LNF/3S9dg3X6iCSP4S
         Xrc9xQIeg2BYVm6JMbI/8LJT67DF/CwFhoxvzz5/OhQk7nG0Bbzqanbem0hjbXIyxwk2
         Dbyw==
X-Gm-Message-State: AOJu0YxlYszEZWe2q3e8mbQki8JhDibm0smfxNC9flJMIXuCMQ6E5zmM
	QIq0WhGBDjdSugdRXHp/NyafATkMYMnsAsz0D/35/+CLInbRXcjgjdS63r+EZ3ArTExzQJprHpg
	=
X-Gm-Gg: ASbGncusUQlg0SpbeB4yKknmzg2FLSGRAFE8jm9nNkvhMwUfNYoHImsIF3siFji2yBP
	KZZiDL6rxZMzemtL1PongTZ0BSx5wiQrFokoT0wYDpSivj6oSWpIxnSy3mWRVlXyT+hI8pzpmlJ
	A0PQbU+vYQ789YWCjJL1E4hs4PPMGeTL2edde0js73qvixoD1MAJVKD92C0PRxuStZz4qiaMpqi
	YZWrEzsQwQPT+pNsp90qG/6t4VZ8gYSuhfCr6tJpKyC0fv83p4On0KnN4AXCFCaJjIrW2L7LIci
	ALNA42IaC2P+EPrGpj3giS/f
X-Google-Smtp-Source: AGHT+IFORfKuNSMeS8hZDVAV1JGG165wthWbApvkGS4fYQL7dck4HfDnA98H1BoQ7EjhoTfR6/qswA==
X-Received: by 2002:a05:6102:e12:b0:4a5:b003:41bd with SMTP id ada2fe7eead31-4addcd1947amr13528500137.22.1732564160660;
        Mon, 25 Nov 2024 11:49:20 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af358d2f9asm75324137.23.2024.11.25.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:49:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 19:49:10 +0000
Subject: [PATCH v4 5/7] media: uvcvideo: Introduce
 UVC_QUIRK_PRIVACY_DURING_STREAM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-uvc-subdev-v4-5-51e040599f1a@chromium.org>
References: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
In-Reply-To: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Some devices power the GPIO pull-up with the same power-supply as the
camera. Avoid reading the GPIO if the device is not streaming.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_gpio.c  | 58 ++++++++++++++++++++++++++++++++++++---
 drivers/media/usb/uvc/uvc_video.c |  4 +++
 drivers/media/usb/uvc/uvcvideo.h  |  4 +++
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_gpio.c b/drivers/media/usb/uvc/uvc_gpio.c
index 80096022ad08..e6fe1845bd01 100644
--- a/drivers/media/usb/uvc/uvc_gpio.c
+++ b/drivers/media/usb/uvc/uvc_gpio.c
@@ -5,6 +5,7 @@
  *      Copyright 2024 Google LLC
  */
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/gpio/consumer.h>
 #include <linux/input.h>
@@ -16,6 +17,9 @@ static irqreturn_t uvc_gpio_irq(int irq, void *data)
 	struct uvc_gpio *uvc_gpio = &dev->gpio_unit->gpio;
 	int new_val;
 
+	if (!uvc_gpio->gpio_ready)
+		return IRQ_HANDLED;
+
 	new_val = gpiod_get_value_cansleep(uvc_gpio->gpio_privacy);
 	if (new_val < 0)
 		return IRQ_HANDLED;
@@ -26,6 +30,24 @@ static irqreturn_t uvc_gpio_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct dmi_system_id privacy_valid_during_streamon[] = {
+	{
+		.ident = "HP Elite c1030 Chromebook",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Jinlon"),
+		},
+	},
+	{
+		.ident = "HP Pro c640 Chromebook",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dratini"),
+		},
+	},
+	{ } /* terminate list */
+};
+
 int uvc_gpio_parse(struct uvc_device *dev)
 {
 	struct gpio_desc *gpio_privacy;
@@ -47,6 +69,15 @@ int uvc_gpio_parse(struct uvc_device *dev)
 	if (IS_ERR(unit))
 		return PTR_ERR(unit);
 
+	/*
+	 * Note: This quirk will not match external UVC cameras,
+	 * as they will not have the corresponding ACPI GPIO entity.
+	 */
+	if (dmi_check_system(privacy_valid_during_streamon))
+		dev->quirks |= UVC_QUIRK_PRIVACY_DURING_STREAM;
+	else
+		unit->gpio.gpio_ready = true;
+
 	unit->gpio.gpio_privacy = gpio_privacy;
 	unit->gpio.irq = irq;
 	strscpy(unit->name, "GPIO", sizeof(unit->name));
@@ -57,6 +88,16 @@ int uvc_gpio_parse(struct uvc_device *dev)
 	return 0;
 }
 
+void uvc_gpio_quirk(struct uvc_device *dev, bool stream_on)
+{
+	if (!dev->gpio_unit || !(dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM))
+		return;
+
+	dev->gpio_unit->gpio.gpio_ready = stream_on;
+	if (stream_on)
+		uvc_gpio_irq(0, dev);
+}
+
 int uvc_gpio_init(struct uvc_device *dev)
 {
 	struct uvc_entity *unit = dev->gpio_unit;
@@ -66,10 +107,6 @@ int uvc_gpio_init(struct uvc_device *dev)
 	if (!unit || unit->gpio.irq < 0)
 		return 0;
 
-	init_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
-	if (init_val < 0)
-		return init_val;
-
 	ret = request_threaded_irq(unit->gpio.irq, NULL, uvc_gpio_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
 				   IRQF_TRIGGER_RISING,
@@ -77,6 +114,19 @@ int uvc_gpio_init(struct uvc_device *dev)
 	if (ret)
 		return ret;
 
+	if ((dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM)) {
+		uvc_gpio_quirk(dev, false);
+		init_val = false;
+	} else {
+		unit->gpio.gpio_ready = true;
+
+		init_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
+		if (init_val < 0) {
+			free_irq(unit->gpio.irq, dev);
+			return init_val;
+		}
+	}
+
 	input_report_switch(dev->input, SW_CAMERA_LENS_COVER, init_val);
 	input_sync(dev->input);
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e00f38dd07d9..6efff8a7aca5 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -2296,6 +2296,8 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 	if (ret < 0)
 		goto error_video;
 
+	uvc_gpio_quirk(stream->dev, true);
+
 	return 0;
 
 error_video:
@@ -2308,6 +2310,8 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 
 void uvc_video_stop_streaming(struct uvc_streaming *stream)
 {
+	uvc_gpio_quirk(stream->dev, false);
+
 	uvc_video_stop_transfer(stream, 1);
 
 	if (stream->intf->num_altsetting > 1) {
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6002f1c43b69..1a784fb76ed7 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -77,6 +77,7 @@
 #define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 #define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
+#define UVC_QUIRK_PRIVACY_DURING_STREAM	0x00020000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
@@ -233,6 +234,7 @@ struct uvc_entity {
 		struct uvc_gpio {
 			int irq;
 			bool initialized;
+			bool gpio_ready;
 			struct gpio_desc *gpio_privacy;
 		} gpio;
 	};
@@ -819,10 +821,12 @@ size_t uvc_video_stats_dump(struct uvc_streaming *stream, char *buf,
 int uvc_gpio_parse(struct uvc_device *dev);
 int uvc_gpio_init(struct uvc_device *dev);
 void uvc_gpio_deinit(struct uvc_device *dev);
+void uvc_gpio_quirk(struct uvc_device *dev, bool stream_on);
 #else
 static inline int uvc_gpio_parse(struct uvc_device *dev) {return 0; }
 static inline int uvc_gpio_init(struct uvc_device *dev) {return 0; }
 static inline void uvc_gpio_deinit(struct uvc_device *dev) {};
+static inline void uvc_gpio_quirk(struct uvc_device *dev, bool stream_on) {};
 #endif
 
 #endif

-- 
2.47.0.338.g60cca15819-goog



Return-Path: <linux-kernel+bounces-406444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD39C60C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F84B35CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFD219C8C;
	Tue, 12 Nov 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TpsLUFlE"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134A217451
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432672; cv=none; b=KxCnNhecg1G/AVjRUuKjk7npSbUa0LWE7lCiEB3e5OjNB2nYM3suVRYv/aft/xZtuKRa6EtVJL9RZxxZ5sqnPSh/ifp3QmL+r5/otLQdLq9nzEkZFnjoF+5Ls7RyV4uMA/J2r2DQelLD/6Sa32T+SaJKDEamMkdrLqDG2O1VEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432672; c=relaxed/simple;
	bh=dKNSbt6Oq25hjXQq50l/hgHRO5f2QAmn2XqN3q2lQ5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe5sbwVM6D2DoYfBmZ2k70t1dI3i4cM6hnH12jUC0vw69NJD9r3qdOUUgY53sXK5bI0TuRH/hVJFuqgrWPltWVoyIUeeQyc8tOFkzBK5juhhtKE2xN4WBfH7F2nM/vSSDna1MjkZNLZ7H+3Q/wmtcSUp5o5FNQ6u3/kiGS7+KNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TpsLUFlE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b14df8f821so536489585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731432669; x=1732037469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jnHw1Y8c4yE4dBcUpY3EUHfdIRMlQ2qG4+v0lq76ss=;
        b=TpsLUFlEkbognWazm/8sudosVJ5j+C9UjtYE6cff6ETUxmtwk3W1D6B3idF4CSPMng
         R/03vwzMqM4vi0vIU4Qj81+9FxN9h8GOaACdpRINw3LLb1t24tMeewh87q1jxzjCwxmW
         uU4doHHaiqc4NhV4zC4A2BBo9UqyayM/q91xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432669; x=1732037469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jnHw1Y8c4yE4dBcUpY3EUHfdIRMlQ2qG4+v0lq76ss=;
        b=ElqDNAZ9WHTJmzG8Vl6sXofxr2zINc/z6czMSFCgLFPWqajmarpuRSsCk27fZbFuyi
         abNV2LeHevay4EH1YN6kzM+5Suyadl6TWLsj7AHdLb0+ivg2/Hw0UQrGFCUozLWlXVCP
         fanOVW01m1F9KcJbTZl1WK7DPc41JVCA7vtbCxAvhiMaTW1NTF3bO90oTYd5K1AJdtjZ
         rO9q3p8gmEujc3U8d9E7lFPxhSn2NnNFE5XhEdr3vDr4oY4O5snoo4HXMYQ2yC+aiu5f
         PYAQTBo+ucaFsNO3aaAhgo8lr/pQyGdMaiE9Cv6xUY9s3mtofSouw2n0OQ5yKYZa83IF
         R5bg==
X-Gm-Message-State: AOJu0YyH2X2Xpcg3+/Xxd7w7iv9cfLNY98UinjojNQepgd4OkJuTZQDU
	ak//E7NUfkTPJTwF9PS1bgJJ9Aguz2UTGbogCrnCBJEFCp5OvBbadfMjXMctQ2aRmPVYYrWt5b8
	=
X-Google-Smtp-Source: AGHT+IHGdaxihdxWgBKnNf5Sppk6z77xKHWY+whPXuVzDPdvi+N0u/EkrwaH8qJFQf/FzKb9kRKWzA==
X-Received: by 2002:a05:620a:31a0:b0:7b1:184f:caba with SMTP id af79cd13be357-7b331f20181mr2066510685a.40.1731432669650;
        Tue, 12 Nov 2024 09:31:09 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dcebsm608292285a.7.2024.11.12.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:31:08 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 Nov 2024 17:30:51 +0000
Subject: [PATCH v3 8/8] media: uvcvideo: Introduce
 UVC_QUIRK_PRIVACY_DURING_STREAM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-uvc-subdev-v3-8-0ea573d41a18@chromium.org>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
In-Reply-To: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
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
index 80096022ad08..8cab27c9d90d 100644
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
+			free_irq(dev->gpio_unit->gpio.irq, dev);
+			return init_val;
+		}
+	}
+
 	input_report_switch(dev->input, SW_CAMERA_LENS_COVER, init_val);
 	input_sync(dev->input);
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index cd9c29532fb0..0d542176ccde 100644
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
2.47.0.277.g8800431eea-goog



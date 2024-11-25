Return-Path: <linux-kernel+bounces-421572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A99D8D01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63B128B55F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420181CF2A5;
	Mon, 25 Nov 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LonaoS9m"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDEE1C1F13
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564168; cv=none; b=GNeOlG5UFwL+YclGJSlR5XJ5jUzf0aWINUqUadbVY9S3f99Ktb9LPdU0cbWYjx98UvHjkyAiAukfHZgUE7MqL4s1E5FSlsxIL+gY23thcNkbZ+Qgn9P1hcxaEnorc8KErFpcP9TUY+xqvNRsJ/q9EVAj9M998nevrlzAMfURULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564168; c=relaxed/simple;
	bh=cEG8q7JwIhfvSJZ4SLtfR3SIICXk8+dsAPReT7UVOHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1QvwDXtwi8rWo+91wTWWg4Qkm7BFUvHDUBxaBISlvSix1LHpaKOtWWpec5Mce9XETw1WoiIb1w6/J6EkHbVbN8loLtEig9slyaWvmDmWxcEybaMcPj0xoQDFWN4QAF8J+x2AuHiRcjAFZoLUnVkwuTEkTgQ8YEvQWvZxCv2C0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LonaoS9m; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5150f63db70so1001186e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732564165; x=1733168965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yziQfukfCQ8tCuWUmt6FHkDaKYe54QyufD5J4OTJbE=;
        b=LonaoS9mJNf9HZmb5t/xbnLohI8N62UTwKaPUyhrpk/dIkASY/3bFpS0E8ryTwv//k
         ctDppn/CXRQHs5OE2CABJrREwfS6h8KeDiqINB+0Z0QCRiFSSKniJInAUzGuZwvFTxfy
         YHO6Tv0wlUbT5Pdt7dIbJgQbQtWR4y3h1wBc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564165; x=1733168965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yziQfukfCQ8tCuWUmt6FHkDaKYe54QyufD5J4OTJbE=;
        b=wPBXcC1Q3tfYKdgNo84n/LlzTfjTcubRcNvGQBaoINKUP0O6lZnFwfPFu1VLIJXoWs
         24/i9ibZZPriHNxFV4xJOPnvCKzFe/H78+cM9mA3YLgG1dnCH/5HxJo3Jwwo9TQIcjQA
         9FfNl9fR2u1eCmReidOBlCQaxBcVLE+WhdrGhMPyJMHnGAk1sCWkgmYRWfYUPEJWXBIE
         n8Af7PFfR7HCXtyZRwW3jlgzVYqLLSueUNIuLxwTRwgPm6fcDSzifZ7y9tVvRUYEZAoh
         T3koSH7EzewBpcxI7q4mgPNdvpqY3OY0BE3YOP3hUjHU+E2N5kkB/tvwq9PiMuO53kzZ
         FeGQ==
X-Gm-Message-State: AOJu0Yw9aSTP1yTfmc4qR8+rRcEMNlLghaN1CGP3tOzKOG4sta5VHxI+
	LJo3J6CM5xSEgdkkbxCuaHcvG2A2cBfPrZNXj+hyDzY6U4hXi5xuXrhTsiMEgA==
X-Gm-Gg: ASbGncsur3s1BAC4X8sU8+6/gkyUc6gILs044VNM5AjtfyZk+Bc/pdXdIRai3fBJfwu
	58Yh9sVNSkDuCsWAUwEvkUG2ENAh1G/ASZYqqvp9wGuBcC8BYS5iQXkKAxLvyl5Hks33OYKFPJQ
	yNiwL6Hv1AGshSqxUfpAEg93/zCZAyi0a0dvuIv+jfRRESvwubrkfOamncTiMlQ25Mosg6MZDr7
	ZenOXjXxlsnO/47Xm6qlcB8g/Wj+E74jj+9XawXVn1Kp33XHVxSbQ5Tv3kLXFyVpoYFo1Muz4m5
	To8W6pBGOYXVnbSD2VlF+yJD
X-Google-Smtp-Source: AGHT+IEgALvAdijAkIcRetk4zuNBzVe1drnMtsw5mI5v64sMgDPBNw61u2gMURnGyFwCjHjpcK36EQ==
X-Received: by 2002:a05:6102:522:b0:4a4:97d1:aea0 with SMTP id ada2fe7eead31-4addcbefa12mr12046094137.11.1732564164881;
        Mon, 25 Nov 2024 11:49:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af358d2f9asm75324137.23.2024.11.25.11.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:49:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 19:49:12 +0000
Subject: [PATCH v4 7/7] media: uvcvideo: Remove UVC_EXT_GPIO entity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-uvc-subdev-v4-7-51e040599f1a@chromium.org>
References: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
In-Reply-To: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The only implementation of this entity was the external privacy gpio,
which now does not require to emulate an entity.
Remove all the dead code.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c |  4 ----
 drivers/media/usb/uvc/uvc_entity.c |  1 -
 drivers/media/usb/uvc/uvcvideo.h   | 20 +++++++-------------
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index ec07c74a5d26..936225c89182 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -769,7 +769,6 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 }
 
 static const u8 uvc_camera_guid[16] = UVC_GUID_UVC_CAMERA;
-static const u8 uvc_gpio_guid[16] = UVC_GUID_EXT_GPIO_CONTROLLER;
 static const u8 uvc_media_transport_input_guid[16] =
 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
 static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
@@ -814,9 +813,6 @@ struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
 	 * is initialized by the caller.
 	 */
 	switch (type) {
-	case UVC_EXT_GPIO_UNIT:
-		memcpy(entity->guid, uvc_gpio_guid, 16);
-		break;
 	case UVC_ITT_CAMERA:
 		memcpy(entity->guid, uvc_camera_guid, 16);
 		break;
diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index c1b69f9eaa56..36121b111ed5 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -111,7 +111,6 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_DISPLAY:
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
-		case UVC_EXT_GPIO_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 642449acce1c..5dd9ec1668e6 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -39,9 +39,6 @@
 	(UVC_ENTITY_IS_TERM(entity) && \
 	((entity)->type & 0x8000) == UVC_TERM_OUTPUT)
 
-#define UVC_EXT_GPIO_UNIT		0x7ffe
-#define UVC_EXT_GPIO_UNIT_ID		0x100
-
 /* ------------------------------------------------------------------------
  * Driver specific constants.
  */
@@ -180,8 +177,7 @@ struct uvc_entity {
 
 	/*
 	 * Entities exposed by the UVC device use IDs 0-255, extra entities
-	 * implemented by the driver (such as the GPIO entity) use IDs 256 and
-	 * up.
+	 * implemented by the driver use IDs 256 and up.
 	 */
 	u16 id;
 	u16 type;
@@ -230,13 +226,6 @@ struct uvc_entity {
 			u8  *bmControls;
 			u8  *bmControlsType;
 		} extension;
-
-		struct uvc_gpio {
-			int irq;
-			bool initialized;
-			bool gpio_ready;
-			struct gpio_desc *gpio_privacy;
-		} gpio;
 	};
 
 	u8 bNrInPins;
@@ -596,7 +585,12 @@ struct uvc_device {
 		const void *data;
 	} async_ctrl;
 
-	struct uvc_gpio gpio_unit;
+	struct uvc_gpio {
+		int irq;
+		bool initialized;
+		bool gpio_ready;
+		struct gpio_desc *gpio_privacy;
+	} gpio_unit;
 };
 
 enum uvc_handle_state {

-- 
2.47.0.338.g60cca15819-goog



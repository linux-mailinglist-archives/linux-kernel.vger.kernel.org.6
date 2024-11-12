Return-Path: <linux-kernel+bounces-406437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B6E9C5F04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEBB1F23C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5CF2144D8;
	Tue, 12 Nov 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TgP5/+xi"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDF21442C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432664; cv=none; b=bxgbr7jS3tG3o2h0z1FLaESgl09iDSHJYsqhH00cDYxH+TvX9ti2jO7DNXtZRYY18cjarcfiFL9yHByvnXATzsqjM6oqhxKyLfYrxnaTMDHTme6Y82Gg9I0ba4sRCdL1kcfJNMH7w9GpZ+IQV9nynMlVnLnbtp3mYrTbE6Gs1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432664; c=relaxed/simple;
	bh=SoqOVgZtfk6qflS1R+7nVDeCXG8YVZzmCjVvn+44Tbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxceZ8o0v5Waw03i5h6hsInQXUxa4RgVxS1zO326VTVenEhEZMWQ+roNaKvulOf6BEGsQdrYXCFoamkLH5QHbCMsxTe3GNNHYrChRwFrSe2vokLg1p0wPGAob1Xk7HGtzh38GP/3QOHuTuET5uf+VtEnDZq4Vgnivco30/0EPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TgP5/+xi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b14554468fso407769985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731432661; x=1732037461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CEQ1hc/dVUjfVi3Dxzg24dI3YBe1UVLQm5inRUtpP0=;
        b=TgP5/+xiiYAinb3EGlSscynjb+OIcZxjWaZyoxxoOSfvX0/589bq2tNEACH3/GjQJT
         wJyXXqfAGffCT+iqfX85PPfhYzRdxASFRshbCUX29ndfXTazF+qfTHegnV0i2TM7vrM9
         QhOdbmWG2CGrxzUS8HK7srTMTWDQ6cUoSYHy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432661; x=1732037461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CEQ1hc/dVUjfVi3Dxzg24dI3YBe1UVLQm5inRUtpP0=;
        b=oCgA7R91wELYcQD2iCDkgnpGVM1QUPhbNR3e/hxxHlyB+w/sHEzarTB1DG3ZPvUrNj
         d5tyxJTIEAWadHlqyPSGQthxVkkUyPXhj6VAOHr3qoE5IisV11gejwRo4Md9WlsMDU6q
         vkONV2/PXsOMbnpONrpK3kFcC5YN8+nNAu6ZZAWHNvNULTdPEcJ/FGnz2l9aa5RYLl4x
         h+wl4aUdgoxKi105e4TqE/++LeE+Sq0ZD0cXPLYK6pvwhyn2eMLACZ2Uas+AknhTg1RW
         M4doqgzvsDhTpDnjYocWx+sXKxkSd3gkpZcoFsgn0PiQa95dqmEmWcNKfAKbFDMIKngj
         Y4qQ==
X-Gm-Message-State: AOJu0Yw5u8DE4R5P9SqUajOMu3MHXZSHOcvzRi2TIJcGRIJopQYIypMn
	G+S/Wo0NEmWbMdHKOwFliNrV3RMaFnsu4/LLghxQVqeoIB5kHnxJ59179+2gPzSfgBORbyjycIU
	=
X-Google-Smtp-Source: AGHT+IHiWxBPVjEaTLN3awzQ+PvRvVnCssskW5MGI97Bk2RZNJBYbg7ngLO1E1nGrjTeCIqEqGnsIw==
X-Received: by 2002:a05:620a:1a02:b0:7b1:5311:468a with SMTP id af79cd13be357-7b331eb4186mr2371784685a.19.1731432661409;
        Tue, 12 Nov 2024 09:31:01 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dcebsm608292285a.7.2024.11.12.09.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:31:00 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 Nov 2024 17:30:44 +0000
Subject: [PATCH v3 1/8] media: uvcvideo: Fix crash during unbind if gpio
 unit is in use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-uvc-subdev-v3-1-0ea573d41a18@chromium.org>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
In-Reply-To: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

We used the wrong device for the device managed functions. We used the
usb device, when we should be using the interface device.

If we unbind the driver from the usb interface, the cleanup functions
are never called. In our case, the IRQ is never disabled.

If an IRQ is triggered, it will try to access memory sections that are
already free, causing an OOPS.

We cannot use the function devm_request_threaded_irq here. The devm_*
clean functions may be called after the main structure is released by
uvc_delete.

Luckily this bug has small impact, as it is only affected by devices
with gpio units and the user has to unbind the device, a disconnect will
not trigger this error.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 28 +++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a96f6ca0889f..cd13bf01265d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1295,14 +1295,14 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 	struct gpio_desc *gpio_privacy;
 	int irq;
 
-	gpio_privacy = devm_gpiod_get_optional(&dev->udev->dev, "privacy",
+	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
 					       GPIOD_IN);
 	if (IS_ERR_OR_NULL(gpio_privacy))
 		return PTR_ERR_OR_ZERO(gpio_privacy);
 
 	irq = gpiod_to_irq(gpio_privacy);
 	if (irq < 0)
-		return dev_err_probe(&dev->udev->dev, irq,
+		return dev_err_probe(&dev->intf->dev, irq,
 				     "No IRQ for privacy GPIO\n");
 
 	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
@@ -1329,15 +1329,27 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 static int uvc_gpio_init_irq(struct uvc_device *dev)
 {
 	struct uvc_entity *unit = dev->gpio_unit;
+	int ret;
 
 	if (!unit || unit->gpio.irq < 0)
 		return 0;
 
-	return devm_request_threaded_irq(&dev->udev->dev, unit->gpio.irq, NULL,
-					 uvc_gpio_irq,
-					 IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
-					 IRQF_TRIGGER_RISING,
-					 "uvc_privacy_gpio", dev);
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
+static void uvc_gpio_deinit(struct uvc_device *dev)
+{
+	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
+		return;
+
+	free_irq(dev->gpio_unit->gpio.irq, dev);
 }
 
 /* ------------------------------------------------------------------------
@@ -1934,6 +1946,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
+	uvc_gpio_deinit(dev);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		/* Nothing to do here, continue. */
 		if (!video_is_registered(&stream->vdev))
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07f9921d83f2..965a789ed03e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -234,6 +234,7 @@ struct uvc_entity {
 			u8  *bmControls;
 			struct gpio_desc *gpio_privacy;
 			int irq;
+			bool initialized;
 		} gpio;
 	};
 

-- 
2.47.0.277.g8800431eea-goog



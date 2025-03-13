Return-Path: <linux-kernel+bounces-559473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E193A5F429
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9D919C0308
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61F266F17;
	Thu, 13 Mar 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHTvzOkq"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A12673B5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868445; cv=none; b=CnVbNCmmV9y7I0neUhVYwwExMkvO944BbFvSAWEHNZnSuwzNdaPSEXvbZ7l03zSsJZBhh9asi8jpKf08O8LkfUKfbXhIJ20/91+wHpAWR9uvz9F2XNBxjEAl+t/5F8g62J+KChgW8R23q8OVdPcwJjmXOcPKa1LLzaP2sslIwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868445; c=relaxed/simple;
	bh=AY58SoD+ZhVTBIYdcNttMGVWKza2+aUpZJjjxBBwdDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnLh7lYAMEZALab7BiUxWyJic+YgcsK3C90Z1OuQz83lCpC/EpKg4SJARlD2GBrqoGLHcWphCZAofWvJWp2q5sVxJWK1M/I8VJCC0PKcd/D5/VEPICeiPcrKJvXVkM+z34GmMBgs9qG4ysk3U9xr4bCWzVO8IOa/8XBM+/Eh3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gHTvzOkq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e41e18137bso6468676d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741868441; x=1742473241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LaUbLtHwwn028SmzBwWRS6gnlRFgt6AH8li0LyjHLg=;
        b=gHTvzOkqtS5KplnkpiscnACQfhdZHXHOU96S4b8MdccUveMnf2VxZDoe/lTIi6/yEM
         XwoAUaMz4fVjPHOO5NHEQ7IYzIhj51E7xVrI+9NY6pnMOXF65NDxr7sTTkf0+FYQJ3yk
         1HO0vHJ6vsBX11ASHgqNI5g5Njj7WVLgHi3oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868441; x=1742473241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LaUbLtHwwn028SmzBwWRS6gnlRFgt6AH8li0LyjHLg=;
        b=ZGCwaSAetCyjRtll7H58VoDbE4xLr7gGb0ZUGgPr+Mx3UmxWHY0RzscKKZ463+lDmy
         5mUftZcmfOHBuy0P7V844d5PzpQj0fvDipRG9uIsh4AiolNliKvKW13TK1ZJ1NhnpHBA
         x3kWbgaFy8qSvfOoMqlA+j3mhOxE4l9ki+Ws5Y1mf2QSedZp6AYDDsNRZy/x717NQQ4a
         318UpZrstcWCNhF7vKSQ+gU4p/enz4iemM28lnXLyFpYdTeEMC4jFXN7PUc1pnxw706j
         He9/Cqq1TZVxp55jRAkKG1Hlr6x1EUuEeTo5mHfjRbpB4dYMXrXJMCgwpzs5s7VfbCaY
         +9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaPuYZONPgNhE157sBkevRNHNIkyQTf1kj2VqE1954AKU4m1xt0B4KhRvUnOxeBYE1/XMTXopC5w26ihk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54j+GyllMVtoxhsKbzCwtLeYBu+MZhaahMQMGRinTC1r15jtB
	i3Q8+3bNOpdxoS1RVGpKUbuaTLub2ta84EdDaBp3fpJkXTwpcbgnae33Qgf96w==
X-Gm-Gg: ASbGncusAvP1WmfTSOlDajjsqhVHGxI5bbOZYnQH8DZrVWQMlXIItCsw9eWR+Jx22xU
	1zLlTd5hyYJJjgFUIkwlfwVDLOdnOgjO6sMavudenuXnu3DkSr5Vk41xbRrGAOwaXOM3gcHctoy
	jTpDkLBI2XJjBY41U6uurU0TQxmncjYjTf+COQFHyBBY76BIv/fIF34WgXk4nqFwbeRsOaSHIEv
	wE5tgFyo4y0GBWcGgpAa8o3rwAuQwOGMKEu0bBaf6EduzV2DyY03hMBIPORkg2G+9x3H9YB4st4
	2j3UVFVGuhRA/oUjCFrLxFE3CAZm1H9M8kEJtqQbGMMF7BBKHYHzzEXXMlKxo1/6P5nKaIugS0d
	A23ycZRsBkWSgH2O4wQaS6A==
X-Google-Smtp-Source: AGHT+IEITUBocDzG1BLH4x0HoF9i4dp788zMihFPD7doCspz6hQIiTeuZXkgdafnavqpm9lCQfQD7w==
X-Received: by 2002:a05:6214:1c43:b0:6e6:6713:3ea8 with SMTP id 6a1803df08f44-6e90060cc3emr410041766d6.23.1741868441393;
        Thu, 13 Mar 2025 05:20:41 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade235f9bsm9038616d6.29.2025.03.13.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:20:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Mar 2025 12:20:39 +0000
Subject: [PATCH v3 1/2] media: uvcvideo: Fix deferred probing error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-uvc-eprobedefer-v3-1-a1d312708eef@chromium.org>
References: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
In-Reply-To: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.2

uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
have not yet been probed. This return code should be propagated to the
caller of uvc_probe() to ensure that probing is retried when the required
GPIOs become available.

Currently, this error code is incorrectly converted to -ENODEV,
causing some internal cameras to be ignored.

This commit fixes this issue by propagating the -EPROBE_DEFER error.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index deadbcea5e227c832976fd176c7cdbfd7809c608..e966bdb9239f345fd157588ebdad2b3ebe45168d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2231,13 +2231,16 @@ static int uvc_probe(struct usb_interface *intf,
 #endif
 
 	/* Parse the Video Class control descriptor. */
-	if (uvc_parse_control(dev) < 0) {
+	ret = uvc_parse_control(dev);
+	if (ret < 0) {
+		ret = -ENODEV;
 		uvc_dbg(dev, PROBE, "Unable to parse UVC descriptors\n");
 		goto error;
 	}
 
 	/* Parse the associated GPIOs. */
-	if (uvc_gpio_parse(dev) < 0) {
+	ret = uvc_gpio_parse(dev);
+	if (ret < 0) {
 		uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
 		goto error;
 	}
@@ -2263,24 +2266,32 @@ static int uvc_probe(struct usb_interface *intf,
 	}
 
 	/* Register the V4L2 device. */
-	if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
+	ret = v4l2_device_register(&intf->dev, &dev->vdev);
+	if (ret < 0)
 		goto error;
 
 	/* Scan the device for video chains. */
-	if (uvc_scan_device(dev) < 0)
+	if (uvc_scan_device(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	/* Initialize controls. */
-	if (uvc_ctrl_init_device(dev) < 0)
+	if (uvc_ctrl_init_device(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	/* Register video device nodes. */
-	if (uvc_register_chains(dev) < 0)
+	if (uvc_register_chains(dev) < 0) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 #ifdef CONFIG_MEDIA_CONTROLLER
 	/* Register the media device node */
-	if (media_device_register(&dev->mdev) < 0)
+	ret = media_device_register(&dev->mdev);
+	if (ret < 0)
 		goto error;
 #endif
 	/* Save our data pointer in the interface data. */
@@ -2314,7 +2325,7 @@ static int uvc_probe(struct usb_interface *intf,
 error:
 	uvc_unregister_video(dev);
 	kref_put(&dev->ref, uvc_delete);
-	return -ENODEV;
+	return ret;
 }
 
 static void uvc_disconnect(struct usb_interface *intf)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



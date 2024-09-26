Return-Path: <linux-kernel+bounces-339914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB14986C21
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E34FB24E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6A186E47;
	Thu, 26 Sep 2024 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SK1uKoUz"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5E1531E3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727329814; cv=none; b=n2pdveJ/w7usIafYQMX6fN5sPeNCqlpVbDSnc3+0g/rr2SUutzVBtEcUlg/LgtxIVNSiMUrDVXJmxq7Fxd0JIqoUPjiRd0c6aJeFdOmVgrKybqY2HpBoGuyZmi+XtW1ZSUQB8s5+lvfPBpiSemBvarmEnypPkLt3XcbnYD4DYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727329814; c=relaxed/simple;
	bh=gWqOpuNGrrOnjJXc15ru2E59HKMuTUnNVS2eBMpuErg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apyxI3trZuFdVyxmq1mYs74QGVmKXer9/fFHpSP94fJ/YCYgoUdSdVD5aQPWDmET8DMGojaOVfq6Xq7tBMgwXVldIWAAtFR2l4hX3tdpCqzHM5LkEtJ/uG5jVw2UzJjUjICJsli1Cq9sOxQ1UNXAHAkuabIWgursrw7zgxVUqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SK1uKoUz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4585e25f42bso4551641cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727329811; x=1727934611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R3jeoC+JoIkoCMlX58x+koThQrbjgmlcnr2nfF31vI=;
        b=SK1uKoUz6kcqkwZLy+ncgszmjEPDSTEWgsv5twozkodCawIB8iv1SmMLE1suSIJM8z
         C1zMHjyUUHeh/yZ409uvNuwTAf27Q97AMoMCpybbRX73SEZ74tb5y4jauZD/Df2vmbjh
         7q/q6NyPOiGnSD75ACOlctESVzKve56It04v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727329811; x=1727934611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R3jeoC+JoIkoCMlX58x+koThQrbjgmlcnr2nfF31vI=;
        b=nsVzPrzw+zOWuu1+6oyg1ExBmdp5euwdT9IGQwFUcSmo874r5gaQF9IcelBvNAiuT5
         dvy5cIKx4+QseACHrejfCa/fXxwmQXVBS8DyYbU/SXYaRWGKwdODxllHhTBBcdhEPY2N
         PWp3y+OH0hYbiZkshbfp872IBLTuUnxK+AlwbBR8DQab231zbGjAtZ8jR+nT+hrWzKq/
         Ugsg5uLL4/3Q03CNaIwTG29w2JtX4wZ2Gku40EZnmHuOywlER2sjKK8+jK0GTO9almRo
         zG4wnyA1HzLnnbx3fFWAmoqBepZzb6k3l7TtbxcTs/BSGHXG5P2gmiupjSTe7JQv29mp
         cGMw==
X-Forwarded-Encrypted: i=1; AJvYcCUQCqJ8Re9xgcyGicjCqBo1z/mlKoVqM+kYMu8QzMiWspPoWWpKGxEaL0N6msKZAgOP6SOpQCMnXSmhAvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2yUbO/IbkGGLtqB6YEvKdr25m1ft5cfK1zWD/ImGl07Vl6Ba
	5LzwniCf6i3vvi+b/Pqbnay0MELMaKKvQfEfH42veavVjdd5cZ6DF6DkrIpY3A==
X-Google-Smtp-Source: AGHT+IGgk05kC/TahyF9M/owtAg5RjgPRrJ8XBEO9Pn6N3lVjtrLE8EQvrkLA+fJYpM1tZpJ60/CWg==
X-Received: by 2002:ac8:58c2:0:b0:458:2756:fd8 with SMTP id d75a77b69052e-45b5e02b09fmr84774081cf.40.1727329810605;
        Wed, 25 Sep 2024 22:50:10 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5264b629sm22406781cf.64.2024.09.25.22.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 22:50:09 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Sep 2024 05:49:57 +0000
Subject: [PATCH v7 1/3] media: uvcvideo: Refactor the status irq API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-guenter-mini-v7-1-690441953d4a@chromium.org>
References: <20240926-guenter-mini-v7-0-690441953d4a@chromium.org>
In-Reply-To: <20240926-guenter-mini-v7-0-690441953d4a@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

There are two different use-cases of uvc_status():

- adding/removing a user when the camera is open/closed
- stopping/starting when the camera is suspended/resumed

Make the API reflect these two use-cases and move all the refcounting
and locking logic to the uvc_status.c file.

No functional change is expected from this patch.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 13 ++--------
 drivers/media/usb/uvc/uvc_status.c | 53 ++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c   | 22 +++++-----------
 drivers/media/usb/uvc/uvcvideo.h   | 10 ++++---
 4 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index f0febdc08c2d..31e8942f1ef8 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2116,7 +2116,6 @@ static int uvc_probe(struct usb_interface *intf,
 	INIT_LIST_HEAD(&dev->streams);
 	kref_init(&dev->ref);
 	atomic_set(&dev->nmappings, 0);
-	mutex_init(&dev->lock);
 
 	dev->udev = usb_get_dev(udev);
 	dev->intf = usb_get_intf(intf);
@@ -2288,10 +2287,7 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
 	/* Controls are cached on the fly so they don't need to be saved. */
 	if (intf->cur_altsetting->desc.bInterfaceSubClass ==
 	    UVC_SC_VIDEOCONTROL) {
-		mutex_lock(&dev->lock);
-		if (dev->users)
-			uvc_status_stop(dev);
-		mutex_unlock(&dev->lock);
+		uvc_status_suspend(dev);
 		return 0;
 	}
 
@@ -2322,12 +2318,7 @@ static int __uvc_resume(struct usb_interface *intf, int reset)
 				return ret;
 		}
 
-		mutex_lock(&dev->lock);
-		if (dev->users)
-			ret = uvc_status_start(dev, GFP_NOIO);
-		mutex_unlock(&dev->lock);
-
-		return ret;
+		return uvc_status_resume(dev);
 	}
 
 	list_for_each_entry(stream, &dev->streams, list) {
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index a78a88c710e2..e438ae5af2e8 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -257,6 +257,8 @@ int uvc_status_init(struct uvc_device *dev)
 	unsigned int pipe;
 	int interval;
 
+	mutex_init(&dev->status_lock);
+
 	if (ep == NULL)
 		return 0;
 
@@ -302,18 +304,22 @@ void uvc_status_cleanup(struct uvc_device *dev)
 	kfree(dev->status);
 }
 
-int uvc_status_start(struct uvc_device *dev, gfp_t flags)
+static int uvc_status_start(struct uvc_device *dev, gfp_t flags)
 {
+	lockdep_assert_held(&dev->status_lock);
+
 	if (dev->int_urb == NULL)
 		return 0;
 
 	return usb_submit_urb(dev->int_urb, flags);
 }
 
-void uvc_status_stop(struct uvc_device *dev)
+static void uvc_status_stop(struct uvc_device *dev)
 {
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
+	lockdep_assert_held(&dev->status_lock);
+
 	/*
 	 * Prevent the asynchronous control handler from requeing the URB. The
 	 * barrier is needed so the flush_status change is visible to other
@@ -350,3 +356,46 @@ void uvc_status_stop(struct uvc_device *dev)
 	 */
 	smp_store_release(&dev->flush_status, false);
 }
+
+int uvc_status_resume(struct uvc_device *dev)
+{
+	guard(mutex)(&dev->status_lock);
+
+	if (dev->status_users)
+		return  uvc_status_start(dev, GFP_NOIO);
+
+	return 0;
+}
+
+void uvc_status_suspend(struct uvc_device *dev)
+{
+	guard(mutex)(&dev->status_lock);
+
+	if (dev->status_users)
+		uvc_status_stop(dev);
+}
+
+int uvc_status_get(struct uvc_device *dev)
+{
+	int ret = 0;
+
+	guard(mutex)(&dev->status_lock);
+
+	if (!dev->status_users)
+		ret = uvc_status_start(dev, GFP_KERNEL);
+	if (!ret)
+		dev->status_users++;
+
+	return ret;
+}
+
+void uvc_status_put(struct uvc_device *dev)
+{
+	guard(mutex)(&dev->status_lock);
+
+	if (dev->status_users == 1)
+		uvc_status_stop(dev);
+	WARN_ON(!dev->status_users);
+	if (dev->status_users)
+		dev->status_users--;
+}
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f4988f03640a..97c5407f6603 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -628,20 +628,13 @@ static int uvc_v4l2_open(struct file *file)
 		return -ENOMEM;
 	}
 
-	mutex_lock(&stream->dev->lock);
-	if (stream->dev->users == 0) {
-		ret = uvc_status_start(stream->dev, GFP_KERNEL);
-		if (ret < 0) {
-			mutex_unlock(&stream->dev->lock);
-			usb_autopm_put_interface(stream->dev->intf);
-			kfree(handle);
-			return ret;
-		}
+	ret = uvc_status_get(stream->dev);
+	if (ret) {
+		usb_autopm_put_interface(stream->dev->intf);
+		kfree(handle);
+		return ret;
 	}
 
-	stream->dev->users++;
-	mutex_unlock(&stream->dev->lock);
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -670,10 +663,7 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	mutex_lock(&stream->dev->lock);
-	if (--stream->dev->users == 0)
-		uvc_status_stop(stream->dev);
-	mutex_unlock(&stream->dev->lock);
+	uvc_status_put(stream->dev);
 
 	usb_autopm_put_interface(stream->dev->intf);
 	return 0;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index b7d24a853ce4..07f9921d83f2 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -563,8 +563,6 @@ struct uvc_device {
 
 	const struct uvc_device_info *info;
 
-	struct mutex lock;		/* Protects users */
-	unsigned int users;
 	atomic_t nmappings;
 
 	/* Video control interface */
@@ -586,6 +584,8 @@ struct uvc_device {
 	struct usb_host_endpoint *int_ep;
 	struct urb *int_urb;
 	struct uvc_status *status;
+	struct mutex status_lock; /* Protects status_users */
+	unsigned int status_users;
 	bool flush_status;
 
 	struct input_dev *input;
@@ -752,8 +752,10 @@ int uvc_register_video_device(struct uvc_device *dev,
 int uvc_status_init(struct uvc_device *dev);
 void uvc_status_unregister(struct uvc_device *dev);
 void uvc_status_cleanup(struct uvc_device *dev);
-int uvc_status_start(struct uvc_device *dev, gfp_t flags);
-void uvc_status_stop(struct uvc_device *dev);
+int uvc_status_resume(struct uvc_device *dev);
+void uvc_status_suspend(struct uvc_device *dev);
+int uvc_status_get(struct uvc_device *dev);
+void uvc_status_put(struct uvc_device *dev);
 
 /* Controls */
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;

-- 
2.46.1.824.gd892dcdcdd-goog



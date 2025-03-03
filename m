Return-Path: <linux-kernel+bounces-542640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D16A4CBDA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02627AACEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632272356B3;
	Mon,  3 Mar 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="blSqxnsD"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE323534E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029228; cv=none; b=sx18hqJdfXgVUAAkb9N0nbCvy0XRgSpUbo+xtgcoTIqf0Xd+1I1rKsL4/eBj24IRIG5pko7wRniCtRRyoKgrh3QbhC4duSpeT2jrznSW3zOJ4ntuoh9vo+ET3lkdp0evYE8CZroSA3FUPR6Y9xsNx3Bq/rd+XBr3x4ucGHfb+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029228; c=relaxed/simple;
	bh=PPWla/2kebrucLkJRseQ3ggOogZO4AGyTq5pphOr1VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjR8owa9+mhoZKqFaFz3vZ4uGApKhrPIju7dvPGH2d9tnCMvfnRfO0Uw3d4na3Esr4oIr1eCVDQjUbWUW2sSBUWcPyO3vxpvBwdlpgrKjYj54XDHwY9eftJMWpXPUmqOaKndnVVKAIKKh9keGwXFZ1mv7hFkc0BdfnQu13O4aYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=blSqxnsD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f88518c8so25160571cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741029226; x=1741634026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7P1QXq27JNB3kApamJPl6/Zqox7TOiVvRdkffBjGTI=;
        b=blSqxnsDTBPoxPm+EF3xgFH/IMedaruRmlbUbKgvDT3VejAnIWA/FZ3cU0RQWBT7jf
         xHlQSvJGyOd1Os20s8/tnvSTidTConl0tqUGmtkXD8Fba/kU8Cp7pCxZGpxZ6KuGiD4F
         tuAjAo/c4AmDkCqMk3txQuDAWd9D+tPjboirA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029226; x=1741634026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7P1QXq27JNB3kApamJPl6/Zqox7TOiVvRdkffBjGTI=;
        b=tuHshZfYn9+pQr2BqBIQYW5l/6ogSW5klixdYeCCT0OPthRyRkuo6TOBoNnhoDs1V6
         6EZPcLe5Iy2aJQ38D1c7jM8J/dycmN2FBROWDsfBbgYZ+9uOcXaXiOx3Q7rrUQPWEf5E
         igDqNZ6nmhIeW2jsZ3XkiCjywCeell1dL4GPh0dhgPXFu+YlBsI2QOM1D99wXcVMAWiJ
         8//E3jwY1sA10rcXvKeotVDpXHMfn8x4cRR6bZUgxTgAWR9T3MO/ROl1zGswPmAM4Vgz
         IkNPvA4KAi9XL+PeLy/1AewUIt64X8HIXXcIIYWjete/nOc7+7dQYp7bLFBHw/JnlTiO
         GEiA==
X-Forwarded-Encrypted: i=1; AJvYcCVDEo37QJWQaz513Cov2ER/Lo1cjyMFf8lzzXye6wNHVevn7h85MesfNuQZojOwbU2SeNPTovWkXue5pt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4LrjT1yPr4qe/K6iQsn1pxSVQcmT5V618D2DTweny9+GDKIG
	5sMZ8xzQxPOkpOA5yxone0yqHHchPU0ljnh9++iEqGXeJhIsRtPTuErtj8A8ww==
X-Gm-Gg: ASbGnct3TNTRMHLxwFPq0Rr6ZAbEm3FLB+iV1r445kvnFoEnzY60grIDz4OOmZSapiZ
	a4eWE70ixxSNHuBO53f6I0iOv+jT+O3MV63VTFo6v3YSApcLzAUuCUvh61jKTgwxN+AMsdFHwbQ
	y071gy4U76OcP5JH4tCMhnFt5IwuEV3uUAqTFne0bUWM7FwIGzgqTDfrfMap/32/9I7lFDhHrkf
	rOQuWWdGa1KfJeXWd2xa6VNN80/pv784iX9LF1BGBYrhQqFDql1jY8D1ZRWVPfCdrEzSdkWCzea
	3yQR55Nk4PzK6VNMomzcSouIMloTyYxo879CB5JwGd+GnoAN7c/ryWrPcZ4EIq5sSRNwcaeyvZS
	p1qY7k5ghgwZ8I5c/YL60UA==
X-Google-Smtp-Source: AGHT+IEpNw4RsO+LZoW3IoxCforKe9aJtgSY48ThTpTugK/BWGpZU9TY/rkkvX28MUKTMjrfrVMrTw==
X-Received: by 2002:ac8:5852:0:b0:471:fee7:9610 with SMTP id d75a77b69052e-474bc080335mr164587941cf.12.1741029225763;
        Mon, 03 Mar 2025 11:13:45 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e0f1e0c1sm19745661cf.47.2025.03.03.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:13:45 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 03 Mar 2025 19:13:40 +0000
Subject: [PATCH v5 3/5] media: uvcvideo: Increase/decrease the PM counter
 per IOCTL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-uvc-granpower-ng-v5-3-a3dfbe29fe91@chromium.org>
References: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
In-Reply-To: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

Now we call uvc_pm_get/put from the device open/close. This low
level of granularity might leave the camera powered on in situations
where it is not needed.

Increase the granularity by increasing and decreasing the Power
Management counter per ioctl. There are two special cases where the
power management outlives the ioctl: async controls and streamon. Handle
those cases as well.

In a future patch, we will remove the uvc_pm_get/put from open/close.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 13 +++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c | 23 +++++++++++++++++++++--
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4e58476d305e..47188c7f96c7 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1594,12 +1594,15 @@ static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
 
 		if (ctrl->handle) {
 			WARN_ON(!ctrl->handle->pending_async_ctrls);
-			if (ctrl->handle->pending_async_ctrls)
+			if (ctrl->handle->pending_async_ctrls) {
 				ctrl->handle->pending_async_ctrls--;
+				uvc_pm_put(handle->chain->dev);
+			}
 		}
 
 		ctrl->handle = new_handle;
 		handle->pending_async_ctrls++;
+		uvc_pm_get(handle->chain->dev);
 		return;
 	}
 
@@ -1611,6 +1614,7 @@ static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
 	if (WARN_ON(!handle->pending_async_ctrls))
 		return;
 	handle->pending_async_ctrls--;
+	uvc_pm_put(handle->chain->dev);
 }
 
 void uvc_ctrl_status_event(struct uvc_video_chain *chain,
@@ -2815,6 +2819,7 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
 {
 	struct uvc_entity *entity;
+	int i;
 
 	guard(mutex)(&handle->chain->ctrl_mutex);
 
@@ -2829,7 +2834,11 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
 		}
 	}
 
-	WARN_ON(handle->pending_async_ctrls);
+	if (!WARN_ON(handle->pending_async_ctrls))
+		return;
+
+	for (i = 0; i < handle->pending_async_ctrls; i++)
+		uvc_pm_put(handle->stream->dev);
 }
 
 /*
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index de1e105f7263..1c9ac72be58a 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -691,6 +691,9 @@ static int uvc_v4l2_release(struct file *file)
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
 
+	if (handle->is_streaming)
+		uvc_pm_put(stream->dev);
+
 	/* Release the file handle. */
 	uvc_dismiss_privileges(handle);
 	v4l2_fh_del(&handle->vfh);
@@ -857,6 +860,7 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 		return ret;
 
 	handle->is_streaming = true;
+	uvc_pm_get(stream->dev);
 
 	return 0;
 }
@@ -873,7 +877,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 	guard(mutex)(&stream->mutex);
 
 	uvc_queue_streamoff(&stream->queue, type);
-	handle->is_streaming = false;
+	if (handle->is_streaming) {
+		handle->is_streaming = false;
+		uvc_pm_put(stream->dev);
+	}
 
 	return 0;
 }
@@ -1410,6 +1417,8 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
 	void __user *up = compat_ptr(arg);
 	long ret;
 
+	guard(uvc_pm)(handle->stream->dev);
+
 	switch (cmd) {
 	case UVCIOC_CTRL_MAP32:
 		ret = uvc_v4l2_get_xu_mapping(&karg.xmap, up);
@@ -1444,6 +1453,16 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
 }
 #endif
 
+static long uvc_v4l2_video_ioctl2(struct file *file,
+				  unsigned int cmd, unsigned long arg)
+{
+	struct uvc_fh *handle = file->private_data;
+
+	guard(uvc_pm)(handle->stream->dev);
+
+	return video_ioctl2(file, cmd, arg);
+}
+
 static ssize_t uvc_v4l2_read(struct file *file, char __user *data,
 		    size_t count, loff_t *ppos)
 {
@@ -1529,7 +1548,7 @@ const struct v4l2_file_operations uvc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uvc_v4l2_open,
 	.release	= uvc_v4l2_release,
-	.unlocked_ioctl	= video_ioctl2,
+	.unlocked_ioctl	= uvc_v4l2_video_ioctl2,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl32	= uvc_v4l2_compat_ioctl32,
 #endif
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index fbe3649c7cd6..eb8e374fa4c5 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -766,6 +766,7 @@ void uvc_status_put(struct uvc_device *dev);
 /* PM */
 int uvc_pm_get(struct uvc_device *dev);
 void uvc_pm_put(struct uvc_device *dev);
+DEFINE_GUARD(uvc_pm, struct uvc_device *, uvc_pm_get(_T), uvc_pm_put(_T))
 
 /* Controls */
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;

-- 
2.48.1.711.g2feabab25a-goog



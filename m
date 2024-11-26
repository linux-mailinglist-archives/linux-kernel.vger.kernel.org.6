Return-Path: <linux-kernel+bounces-422568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB29D9B45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7579F168A45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612C1DD0D6;
	Tue, 26 Nov 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oeuDtTxO"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBE1DACA1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638032; cv=none; b=DFMi4qZZUXo68Ib1FgX805eorofH1lCLuuhmsK61dzYsg+Ez3+wNZGAf47y9+Q7YADKpAlSR+58+csLNESTYKemH1/+10ixNlW1Q/w3muVUN6PG0bvVZcq1WYHnB3Ci3nAX0+6LJluddFyy0+J+C50SXvOsOTm8l9BbtTyeu/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638032; c=relaxed/simple;
	bh=IVh0R9nGIq7LQxrxeUzuHltM/Lda0LYF+qcuGJP4GWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/Gv0eLRxspbx9JnZsQTHVW0b08ZA8tblT6Qb/4GNSaO++Uvq1qcE6P7/UKi8cBNN4rq6oYAO2VkFd1oUd+2KepDtpiCSPvZ779Lf++j1v9mZNXyRvDljvUd6xcGRUTOrxtg19YFjy+UccIJ9/udyc90XxakTriFupGJkKosCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oeuDtTxO; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71d551855c2so942732a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638030; x=1733242830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85TfWs0jEmA8k141RAfWvOKiiPy4fhc+Ar2L/ksYixU=;
        b=oeuDtTxOIJIBx4K92ClrNlMWu7iquec/UZ3pJ8kc0qTwVYIkEUG0Cu1MHMh0acL9f3
         Ue1sL9C3EL33xadY//+cwJxeb2nV9K4sIGmKK9dV0t9E5Y83WnMcJEIQiyYWuVjccTgB
         853ZpEjLtXlyf9HSW3Cw0a0Zg3S1D4qE/tnyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638030; x=1733242830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85TfWs0jEmA8k141RAfWvOKiiPy4fhc+Ar2L/ksYixU=;
        b=vCYFb7hcEjV5TVs3QyYKeKkU0nQPwkkpimTDMs2ete77nPC6f8s6G6MA6DUtfUA7Jr
         4kFs99T8D8KS5yO3/fhtFcFS/nQ1P4VkmI8Mp9YHL1wv1WTX4ooirJPVbGP1epjayw5s
         7WtM9v0k0ZI3pIEbldXr766D8+RERkJM1RZVRUHJEiW/T3XpdppOaryvOP6qnUNjYFuT
         cW6jnI28m3FzzCGcbVAAptMWDb/vznL4CtOM9zDvzbMWBbvDwiraBH7h9dcaSmU19il9
         qNaOmLp11qU/xHj6nSWMZj2Cb0/35cfbJBnnTzcFGMFWMbdmJDC+Ndvxo4DU5IsGCJ4A
         YGfg==
X-Forwarded-Encrypted: i=1; AJvYcCUaFp3+XJACh+6XbogssyjtizXejmBfi/HHAkW+FUknx0yxpYi60KTR0NtZEUcncwITxPtPusZIkwGqOhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnJUBJQrqcmspUoKheAI1sCxcCgyufqz1a9VEihFBuZZlsPlU
	IKFja1eCDnJtkeBbFJ19uQRqMAF56/k0b/zRcdKt2VL/YD7OqXeFZfXSaH5yQA==
X-Gm-Gg: ASbGnctR4/+G/SVgZwvCQSgmIiil7FyBP/92uTDvr9oSqXMUYPZa4fBbJw5ME4Jmxc6
	oPfdbfK67T/WBDhQ6Yre6rII18OLwNab1CiG0ZiXBAh04+FK1hUKptC3oxpjJbGw22FnxVjD5bC
	0q2pwyyJjOy8va04eIEIv1LPnt2nVrGR+lnisHO681ADvU2alcA3gZvbPQzv4uaIj1dkMAAEAW7
	iG95PeEb9F2KKZCtm6N3hMNE1NJwO1ii4K1qZLWzARZAuKEeyf33ECbR4ip9qr0wBqZPNHSHxTk
	3qs4Cu1kphLEMM312si/hHD6
X-Google-Smtp-Source: AGHT+IGHcqzY+WUpuzKBkzRidLiPH4hUJ9H+BZBkHvQLlWb2ivbtOxMoXrTejhoPwoNuH+vicDxvPg==
X-Received: by 2002:a05:6358:988b:b0:1c6:204b:c5a7 with SMTP id e5c5f4694b2df-1ca7972f8aamr942012555d.10.1732638030198;
        Tue, 26 Nov 2024 08:20:30 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:29 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:56 +0000
Subject: [PATCH 6/9] media: uvcvideo: Increase/decrease the PM counter per
 IOCTL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-6-6312bf26549c@chromium.org>
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Now we call uvc_status_get/put from the device open/close. This low
level of granularity might leave the camera powered on in situations
where it is not needed.

Increase the granularity by increasing and decreasing the Power
Management counter per ioctl. There are two special cases where the
power management outlives the ioctl: async controls and streamon. Handle
those cases as well.

In a future patch, we will remove the uvc_status_get/put from open/close.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 18 +++++++++++++-----
 drivers/media/usb/uvc/uvc_v4l2.c | 26 +++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 11287e81d91c..2e2aa1b2f53d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1592,8 +1592,10 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	if (handle) {
 		ctrl->handle = NULL;
 		WARN_ON(!handle->pending_async_ctrls)
-		if (handle->pending_async_ctrls)
+		if (handle->pending_async_ctrls) {
 			handle->pending_async_ctrls--;
+			uvc_status_put(chain->dev);
+		}
 	}
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
@@ -2056,8 +2058,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
-		if (!ctrl->handle)
+		if (!ctrl->handle) {
 			handle->pending_async_ctrls++;
+			uvc_status_get(chain->dev);
+		}
 		ctrl->handle = handle;
 	}
 
@@ -2785,6 +2789,7 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
 {
 	struct uvc_entity *entity;
+	int i;
 
 	guard(mutex)(&handle->chain->ctrl_mutex);
 
@@ -2792,8 +2797,6 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
 		return;
 
 	list_for_each_entry(entity, &handle->chain->dev->entities, list) {
-		int i;
-
 		for (i = 0; i < entity->ncontrols; ++i) {
 			struct uvc_control *ctrl = &entity->controls[i];
 
@@ -2804,10 +2807,15 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
 			if (WARN_ON(!handle->pending_async_ctrls))
 				continue;
 			handle->pending_async_ctrls--;
+			uvc_status_put(handle->stream->dev);
 		}
 	}
 
-	WARN_ON(handle->pending_async_ctrls);
+	if (!WARN_ON(handle->pending_async_ctrls))
+		return;
+
+	for (i = 0; i < handle->pending_async_ctrls; i++)
+		uvc_status_put(handle->stream->dev);
 }
 
 /*
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 1d4db712137e..1972ede38c70 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -651,6 +651,9 @@ static int uvc_v4l2_release(struct file *file)
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
 
+	if (handle->is_streaming)
+		uvc_status_put(stream->dev);
+
 	/* Release the file handle. */
 	uvc_dismiss_privileges(handle);
 	v4l2_fh_del(&handle->vfh);
@@ -885,8 +888,10 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 		return 0;
 
 	ret = uvc_queue_streamon(&stream->queue, type);
-	if (!ret)
+	if (!ret) {
 		handle->is_streaming = true;
+		uvc_status_get(stream->dev);
+	}
 
 	return ret;
 
@@ -904,7 +909,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 	guard(mutex)(&stream->mutex);
 
 	uvc_queue_streamoff(&stream->queue, type);
-	handle->is_streaming = false;
+	if (handle->is_streaming) {
+		handle->is_streaming = false;
+		uvc_status_put(stream->dev);
+	}
 
 	return 0;
 }
@@ -1450,6 +1458,16 @@ static int uvc_v4l2_put_xu_query(const struct uvc_xu_control_query *kp,
 	return 0;
 }
 
+static long uvc_v4l2_video_ioctl2(struct file *file,
+				  unsigned int cmd, unsigned long arg)
+{
+	struct uvc_fh *handle = file->private_data;
+
+	guard(uvc_status)(handle->stream->dev);
+
+	return video_ioctl2(file, cmd, arg);
+}
+
 #define UVCIOC_CTRL_MAP32	_IOWR('u', 0x20, struct uvc_xu_control_mapping32)
 #define UVCIOC_CTRL_QUERY32	_IOWR('u', 0x21, struct uvc_xu_control_query32)
 
@@ -1464,6 +1482,8 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
 	void __user *up = compat_ptr(arg);
 	long ret;
 
+	guard(uvc_status)(handle->stream->dev);
+
 	switch (cmd) {
 	case UVCIOC_CTRL_MAP32:
 		ret = uvc_v4l2_get_xu_mapping(&karg.xmap, up);
@@ -1583,7 +1603,7 @@ const struct v4l2_file_operations uvc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uvc_v4l2_open,
 	.release	= uvc_v4l2_release,
-	.unlocked_ioctl	= video_ioctl2,
+	.unlocked_ioctl	= uvc_v4l2_video_ioctl2,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl32	= uvc_v4l2_compat_ioctl32,
 #endif

-- 
2.47.0.338.g60cca15819-goog



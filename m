Return-Path: <linux-kernel+bounces-427687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6B9E04C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D16283D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AE8204F9D;
	Mon,  2 Dec 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QQt+Cel/"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA27204F87
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149485; cv=none; b=lWLfnpU+3Qh7qrKj78Z8mDwffsXokTiUG4Oc0R4jD/DS/ifpM0Gx5o9vrYxP6Cxi4dJ5V4DJIJ8Y5aqCdzwYjx6QIHA/iOZylBVIw2T3YEdSLcZtpOtUrjc/1JtpTdkXx3JgalLq/VTHNneK35rHe3Hrwj+KdaThaU6cDT7FbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149485; c=relaxed/simple;
	bh=2CouL6TauW+OfYTjBFsOKvayyxDlTHWIFYpffgKYGh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d51CW776tfx1r89Dpa26ZyUggd3vFrIAO/c8X/yZuRcuXnCMFFnCEeSZZ8HNVfn0S/MR3MDuQnsGZ2qFr1x/3yMCCz3CAdE+8dLG+ANlhFLkZmpvPPZaKGOHgEh7fKCKFqoVkKDT/y189uCbv+Vvu0c7rbr/Xk7ruUi7oEhRnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QQt+Cel/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e61fcc3d2so914683fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149483; x=1733754283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLNHXjJlr/6qPBJLlmj7xWzEmuF7V3Sn4z0szK5h1CI=;
        b=QQt+Cel/9pcHXIo351Fm6cSzKXJJH94/WB2pyW+SWXCWffVvlENBc0OnhJU1p7dje8
         4xfu8pOaZKteALYVyIaBWsg9a4/DzzLrcf7sUI8p+cpjOuo/WLgurrnTWtb4yIdZ0V31
         2ok4xPPtxO9w/VfDXN0WFKwNyd0XL12YBtJjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149483; x=1733754283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLNHXjJlr/6qPBJLlmj7xWzEmuF7V3Sn4z0szK5h1CI=;
        b=K1vr6j7V3KxstUWyl5uGecXO57Bo1/olV2QzzZfqEfvmK7WcIJhM7LOI+NTCY0VzCC
         KxjHIa0alc/PFu027Sf/UxLBWshDaBJWv5O3MOxRBPQzYfzS9itHDtx5Ln6eM1ABCrNa
         5Cqk6PZXx8xBPVMhGVE7QzBiaVgbkxaPgIxMeeSkE8hU+zHewutyT79K6bO4+6qCFZtk
         PWcv8cCgrrmQHzYYAdX620ElVylye+akO4dahMEUvdF+py/LVSLKzOht2DzLmu5i1QxA
         9uapANBFC37MPE2geHYLkgsmoVHV6pAqOqmchLj5/X4t56oh1YRSYxzEaPmxroPjMERe
         58QA==
X-Forwarded-Encrypted: i=1; AJvYcCUfABTEqvEqmPo1kHGgNsamDIyJ6wV5u0EVyjUlbaszgJOfJbl/jElAS36KZKfBBJ4Zc9LEGgfD+uzVk3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwQto+td5xWb+4opn4QWIY/HkR5J+iqx7dHzRey7w/o80PLNF
	CvEunTUpQaW3Bx03ZCkasWwVzCI45UzON+n58dnW0gMgY3u1ZxD10f6KsPWVyw==
X-Gm-Gg: ASbGnctzU/IeQkfJQY7FbnJcVwXevw2xFNmlgwtx+xgxZ5qPHuLJ4dYyT3EBFmQNB8b
	IXpi2R6Ya4EQuLr43c1Ww7cK/kJYqwFh3R6PoNyQ9oBRIT/OiPOjEzyQ9iFAAaYJhhsEOylQiSH
	0/IkSG7KvQ/avV52jNxKNwLJC7Sw6eHbjU7E88WV6peEBkEzs5n1+QHL+DUNNoH7ZWM54epj7xp
	VL9Q7B061VObF2znY6hNZT5oK8qj9WATtxBQEC8Smu17GlbA7SZciFOeDszpcryjmA2i1ChDEzs
	COUfZGfE27gzMXzVGTBIGJbW
X-Google-Smtp-Source: AGHT+IHOmHK950Sz16eLfZ56imS30OV+bUBssh4g96SgnL/6rRx0a78AipUgKMzMa352e4qpARm5UA==
X-Received: by 2002:a05:6358:50ca:b0:1b8:3283:ec6e with SMTP id e5c5f4694b2df-1cab169cf8emr614679055d.24.1733149483059;
        Mon, 02 Dec 2024 06:24:43 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:41 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 14:24:36 +0000
Subject: [PATCH v5 2/5] media: uvcvideo: Remove dangling pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-uvc-fix-async-v5-2-6658c1fe312b@chromium.org>
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
In-Reply-To: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

When an async control is written, we copy a pointer to the file handle
that started the operation. That pointer will be used when the device is
done. Which could be anytime in the future.

If the user closes that file descriptor, its structure will be freed,
and there will be one dangling pointer per pending async control, that
the driver will try to use.

Clean all the dangling pointers during release().

To avoid adding a performance penalty in the most common case (no async
operation), a counter has been introduced with some logic to make sure
that it is properly handled.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 52 ++++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  9 ++++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9a80a7d8e73a..af1e38f5c6e9 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1579,6 +1579,37 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
 	uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
 }
 
+static void uvc_ctrl_get_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
+{
+	lockdep_assert_held(&handle->chain->ctrl_mutex);
+
+	if (ctrl->handle)
+		dev_warn_ratelimited(&handle->stream->dev->udev->dev,
+				     "UVC non compliance: Setting an async control with a pending operation.");
+
+	if (handle == ctrl->handle)
+		return;
+
+	if (ctrl->handle)
+		ctrl->handle->pending_async_ctrls--;
+
+	ctrl->handle = handle;
+	handle->pending_async_ctrls++;
+}
+
+static void uvc_ctrl_put_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
+{
+	lockdep_assert_held(&handle->chain->ctrl_mutex);
+
+	if (ctrl->handle != handle) /* Nothing to do here.*/
+		return;
+
+	ctrl->handle = NULL;
+	if (WARN_ON(!handle->pending_async_ctrls))
+		return;
+	handle->pending_async_ctrls--;
+}
+
 void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 			   struct uvc_control *ctrl, const u8 *data)
 {
@@ -1589,7 +1620,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle)
+		uvc_ctrl_put_handle(handle, ctrl);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -1865,7 +1897,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		if (!rollback && handle &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			ctrl->handle = handle;
+			uvc_ctrl_get_handle(handle, ctrl);
 	}
 
 	return 0;
@@ -2774,6 +2806,22 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 	return 0;
 }
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
+{
+	struct uvc_entity *entity;
+
+	guard(mutex)(&handle->chain->ctrl_mutex);
+
+	if (!handle->pending_async_ctrls)
+		return;
+
+	list_for_each_entry(entity, &handle->chain->dev->entities, list)
+		for (unsigned int i = 0; i < entity->ncontrols; ++i)
+			uvc_ctrl_put_handle(handle, &entity->controls[i]);
+
+	WARN_ON(handle->pending_async_ctrls);
+}
+
 /*
  * Cleanup device controls.
  */
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 97c5407f6603..b425306a3b8c 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07f9921d83f2..92ecdd188587 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -337,7 +337,11 @@ struct uvc_video_chain {
 	struct uvc_entity *processing;		/* Processing unit */
 	struct uvc_entity *selector;		/* Selector unit */
 
-	struct mutex ctrl_mutex;		/* Protects ctrl.info */
+	struct mutex ctrl_mutex;		/*
+						 * Protects ctrl.info,
+						 * ctrl.handle and
+						 * uvc_fh.pending_async_ctrls
+						 */
 
 	struct v4l2_prio_state prio;		/* V4L2 priority state */
 	u32 caps;				/* V4L2 chain-wide caps */
@@ -612,6 +616,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -797,6 +802,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);

-- 
2.47.0.338.g60cca15819-goog



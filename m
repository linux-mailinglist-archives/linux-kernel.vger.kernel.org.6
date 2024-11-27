Return-Path: <linux-kernel+bounces-423455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C19DA785
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D316220C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED921FBE93;
	Wed, 27 Nov 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+UqrPhQ"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF91FBCA8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709700; cv=none; b=ROKcSgA6auLpExHfxypgq6jD6ZpviWVXG6xdzOA7DUAJGtt3gl1HtHtJmJHtafVNmEt5d8fzrc2/dtxSxpr4yMWdpjOKCndM3ChJ5lNRer1TuLY2DxoSL9ApFWRDWN8+HTcmKiq/t2USP+7WMKpTuCyMVWpcL+8f5RRwzvjrNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709700; c=relaxed/simple;
	bh=WhdTkzcqR6Bf+l9KubUuR4/DJ8IIJcn0RVpx0dWpsR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkoEZU9DzlMizPZ9VF9kd/uTfpOrpIZY9keMMS5SrinA2RBklpO+7a45O4YFxb/CBy/1gJlxj5zy+bh6CDA72HtXZ0dOdjQ5brDqvjRjFP2Q2pFbd0HnNfK5xAGuFLgCVGLx4aSWf+9/5XdrQvhBDwQQfiyufBFJ/t+a73p2yak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y+UqrPhQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b65d1c707aso280605085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732709697; x=1733314497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0KHNn4es9DIQwBkLUHR0O3A+08DvzwFXH+1YhEGXA0=;
        b=Y+UqrPhQAPtBgpBCqlACR9fj87wmQeEX5Yd2Vuj6MGOrRL8wYIcQU6cKY56Kn4oIaF
         6Af93lMpqLk2qt2+C64L907THMur6bxxzVe9SBUvPn7Tcf0cykoOPpzjdbafFNYEIM2f
         ILPzsnQg1YsCoAMWW+WCGq3y8nyOCga2BlPao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709697; x=1733314497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0KHNn4es9DIQwBkLUHR0O3A+08DvzwFXH+1YhEGXA0=;
        b=Q+TSL878wWpOY1mJM1pa39pq7YRfjEppTa0JGN2zNjMQPuwhXdw+4eVjk0XXN8JN+0
         y9Vts7RDFgkxU95joOXNnSosHA/AZKWar3UuowQozdhexoaTKHKmtPGPyZ5tpZEAayME
         6OLrkyN6PEmnAzL8UIxOmPanlMNPNk/mR87iJ5k8bGTOZMIewb6jc4xzgz5D4XP8YHhQ
         a644QTAb/aQFvDk7d11Ja5ST9qU+1UQG4gY8/iWOXmvg9gaUDDLxPsT4zFfgf3kCrNBU
         tlVm5auT7zUUcbSnCaLSa5iqeWif2Oo0eTuNUg1p1pTAFLpcb/EeYa+6w0AnlHJ1fh3F
         Kd8A==
X-Forwarded-Encrypted: i=1; AJvYcCWO7ZEvzLJBry/dgvedrCVAA9fy4hXwGPICfUxS6B3h0az3ICUy+RieOChYey5gqT2uMC6aliZgAs6hVH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvwCQh5PE2Ef8JRbClf7wHATsw07wkBmY80JDMPDr72/1/WiX
	scDg3L1tMFFTUifdjicD1GrgMPZQH6TYdIZ15778285p9nkPKNguaIF6ymW3+A==
X-Gm-Gg: ASbGnctbO3heFMXk0E4MNT8AUbpTGsvAzwX0oNcKt11SUUgVwrXU8OxZPkyI0FTzryw
	1YQrThqQdGKSD0ZK1KD7zkZf62CLkeXSrCSw2uGW30Bo738g0B/KzBXiEah3a2SdNQov2gE0BkJ
	WR70eanBmtkzURb8TWfVclCwI35m0UjNhn7o9acfDELkT+p3E8rvddA86YFhlxpr4sG955//vQ9
	FL1nJDb9inbSCna2Wl0Ojsxtw099m/0XMSomU+P4qOeUvMceXXwgC6iUKjuc/Tkz/siECqH/Fht
	9rY4J142DtwsTtMv7fMxOjvi
X-Google-Smtp-Source: AGHT+IEdu8deXp9Whw6D3ODj6kf5vf4xXQ1BzDm2O19GNjsuQS6uwUGVVt/ypGSUyCnQ8eyQm4KPdA==
X-Received: by 2002:a05:620a:4095:b0:7b1:4b2e:3c0 with SMTP id af79cd13be357-7b67c263e59mr439636385a.14.1732709697396;
        Wed, 27 Nov 2024 04:14:57 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466be77cf7bsm371171cf.89.2024.11.27.04.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:14:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 12:14:49 +0000
Subject: [PATCH v2 1/4] media: uvcvideo: Remove dangling pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v2-1-510aab9570dd@chromium.org>
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
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
operation). A counter has been introduced with some logic to make sure
that it is properly handled.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 38 ++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  8 +++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..b6af4ff92cbd 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle) {
+		ctrl->handle = NULL;
+		WARN_ON(!handle->pending_async_ctrls);
+		if (handle->pending_async_ctrls)
+			handle->pending_async_ctrls--;
+	}
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -2046,8 +2051,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
+		if (!ctrl->handle)
+			handle->pending_async_ctrls++;
 		ctrl->handle = handle;
+	}
 
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
@@ -2770,6 +2778,32 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
+	list_for_each_entry(entity, &handle->chain->dev->entities, list) {
+		for (unsigned int i = 0; i < entity->ncontrols; ++i) {
+			struct uvc_control *ctrl = &entity->controls[i];
+
+			if (ctrl->handle != handle)
+				continue;
+
+			ctrl->handle = NULL;
+			if (WARN_ON(!handle->pending_async_ctrls))
+				continue;
+			handle->pending_async_ctrls--;
+		}
+	}
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
index 07f9921d83f2..c68659b70221 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -337,7 +337,10 @@ struct uvc_video_chain {
 	struct uvc_entity *processing;		/* Processing unit */
 	struct uvc_entity *selector;		/* Selector unit */
 
-	struct mutex ctrl_mutex;		/* Protects ctrl.info */
+	struct mutex ctrl_mutex;		/*
+						 * Protects ctrl.info and
+						 * uvc_fh.pending_async_ctrls
+						 */
 
 	struct v4l2_prio_state prio;		/* V4L2 priority state */
 	u32 caps;				/* V4L2 chain-wide caps */
@@ -612,6 +615,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -797,6 +801,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);

-- 
2.47.0.338.g60cca15819-goog



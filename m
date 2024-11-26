Return-Path: <linux-kernel+bounces-422565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6B9D9B42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89BB167BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED201D63FD;
	Tue, 26 Nov 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1pC5ZRk"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A81D90B1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638030; cv=none; b=oDPob+tPo0CFfORqfJWmkQxvHeRSa/PfeYoZZYORwjZ8yF4NgqUokiv5LjgPoigXYYuPT030vhIAtk2MVn26DOp6zWnVQZpPrVnpn/Pp5ZgfBYcTihOREucMfOuqhigmVPWgC8dX5FZBsD3qnXQ3ff8xW52+RXGGKg1VJZiqbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638030; c=relaxed/simple;
	bh=bePKgiLEtOHWWqdfEmU/XMv+SebhE/yNQeG1T0V3x24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+g9HQr/+hDutSLY27X6KxyC/kSfo3vurgoDlamWjeEUEgClc+ropKa1ApmRW4CO1eyrP636cgtfcqmwjfQXUyJJxH6qYc1JotrHXvRExa6a9ZaYhBniMFp73NMaAmHc7W5U4QUvMf/+Z6HUvyUCiLowDHFZCXOFz+2b6HVd1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n1pC5ZRk; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f205c4625dso266058eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638027; x=1733242827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWYCqdEsM1ywI2Gtcd8gKpH4aZIyvZJP5EwMGSKse/E=;
        b=n1pC5ZRkKg5+lJn6bXhLCgHK5vlrNXDky9eTBqNcXFgaLWiGc1qt/AJNdhX532ie8B
         J829HiOfuWSQwRcoI0sWJdPHYh4Cv3784OpX7uPAWuFguf4tGNvYrnz3Fb6AhtjefNlo
         iZCRXARmquTkCxhHk4Ff8nClZCF7S6MRVRf9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638027; x=1733242827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWYCqdEsM1ywI2Gtcd8gKpH4aZIyvZJP5EwMGSKse/E=;
        b=CHk2UtAydZFdbHK+xREtIvxy2cQKgnd+Trv5qO/eCY+bge8Adl2T8df4qZ8fNPEoc/
         sgYWpJ2uybkIzkB4FoT3EoQ+5ZwAHlIgSD3Mly4xhi/agOWdrKayyiQNjH7w9CwkHjza
         4uLBTQmPqn3Ncs3SJFoTLsjklFwvXiJC8AVbR0047qHj3qpGmS09aZGeaEARZqGoNwRG
         s7gRmZDFr2Y5dSGjhdDvvIiohz8FlpffbXQz6IXKLRZ0HnW05CZgDUShThXlSMJpNs4G
         eNRkYeawv94PYAzFpDbx501qH80sldAyIf5JWxKAWunKvBSDfbw93pcsuNz2YMkzRpl1
         KuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiG5vQoIwiXaljSP9DiuRxruPqVq9VIvxMz3/WKnpTrdzLxyFE9mBtSFm4HbyIrKBrA9S7V1Zilh2dQbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeh6ZstpZp9DzyT9vig97HmjiyqzKKiDMOJN9t49XFJkYRTH47
	7ahrNR4bLUz2KZork3GyjGg9V0U+QJ8bvtUBHt8pD3rqqJMjO2uV8fAmEnlENw==
X-Gm-Gg: ASbGncuNvEZGjDzoMmgRIGl0rBxNNwdS1SeM9N5cTIRUu6vwBrgqDRElzSFyDk9Ua7h
	vzt8y1J7v15fS0gGZylIsETrC3z18khd5mAbo3GppXZ9316+DtETk3lktky73p171KmPHgNbZoP
	4mMUCkjgUN0hCrJ0pPyujqVeQrQUX1d872qIUwpe24ywKT6hvYH2AC/n/KtQl6m6dC1MbSh5Vjj
	CSo9LpV+dL9DX9QU+6bq17/vKP1giEhihcLDdK7NRsboO0N7SX4V840AfxvXE3OEWprS70KLiuK
	+b7E6I1LPUV4N9XN/cyLX3Z0
X-Google-Smtp-Source: AGHT+IFP7tn9XGl7nTv1mz1ZVEhZf7iMYG/c3Vw4razkI9b6q1iBbwoYYcil2Tl02KVex3tVQ1+aRw==
X-Received: by 2002:a05:6358:949f:b0:1c6:1d18:7c44 with SMTP id e5c5f4694b2df-1ca79708784mr853391955d.6.1732638026153;
        Tue, 26 Nov 2024 08:20:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:52 +0000
Subject: [PATCH 2/9] media: uvcvideo: Remove dangling pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-2-6312bf26549c@chromium.org>
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

When an async control is written, we copy a pointer to the file handle
that started the operation. That pointer will be used when the device is
done. Which could be anytime in the future.

If the user closes that file descriptor, its structure will be freed,
and there will be one dangling pointer per pending async control, that
the driver will try to use.

Keep a counter of all the pending async controls and clean all the
dangling pointers during release().

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 40 ++++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  3 +++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5d3a28edf7f0..11287e81d91c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle) {
+		ctrl->handle = NULL;
+		WARN_ON(!handle->pending_async_ctrls)
+		if (handle->pending_async_ctrls)
+			handle->pending_async_ctrls--;
+	}
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -2050,8 +2055,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
@@ -2774,6 +2782,34 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
+		int i;
+
+		for (i = 0; i < entity->ncontrols; ++i) {
+			struct uvc_control *ctrl = &entity->controls[i];
+
+			if (!ctrl->handle || ctrl->handle != handle)
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
index 07f9921d83f2..2f8a9c48e32a 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -612,6 +612,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls; /* Protected by ctrl_mutex. */
 };
 
 struct uvc_driver {
@@ -797,6 +798,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);

-- 
2.47.0.338.g60cca15819-goog



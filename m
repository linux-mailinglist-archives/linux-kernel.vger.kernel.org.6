Return-Path: <linux-kernel+bounces-423137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9049DA354
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F742B262A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F381547FB;
	Wed, 27 Nov 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEepfIsQ"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A217B50F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693586; cv=none; b=JHY6CQ6HO5lPe5vO7/Vc1Wu11vjaWAohfr0fEhbNHCnvdgTkPDgzE/tce0XZpAwS3Zntg746MNhmE7i39zqMxWv6NGDtUxnCG7JQebyBL66a3zBG5OobTLSR1eKPKG+b/4Tt85EEpldAB9lHgZ+mqW36r/CjaDj4LGqxaOb7ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693586; c=relaxed/simple;
	bh=wsupc+qJZWfWzVfaFmE6CWRDyNHqRQr4iSu156pifPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7Ak4DBdhzBbRuLr8OdWJs7K9LKDUITlhRc7CjRoP1pwie8eks9B5oIkaPGtaoXLKaBQKwQnwEum/+vGjX3l851d9YdyV1bfbuBCw1wU0rFMnpVjeFnj0cMVcs56bwxsMH9TBzYD5i4ISel1tqvs3lnBcXhgELqJv0JKdVunbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FEepfIsQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b678da9310so95216685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732693584; x=1733298384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6+TDrLkgXM9/PtCs6e0qWgX2PpjlMIZQ4o/NRcpkPc=;
        b=FEepfIsQqghG5+AY7JdtOFU2R0W67wOJgJWPVC8LAvHY7YvxqFbtjDKGBlLel6BQtz
         WiPkoRBZK4IOHPo6MUDMkaFTkLk3QhDTFRYL5PJbKck0Zu8NFesG6rpzz1dvdSwGx5P+
         QGp6OehKOMZmMngVAiqAxtVQqG+QolX2mpvaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693584; x=1733298384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6+TDrLkgXM9/PtCs6e0qWgX2PpjlMIZQ4o/NRcpkPc=;
        b=e2+SYHxa01Sjxo3bb8FoIipL3FB3Ue+syPtFV0QRcdfGZsNovqmEFry6hopdPt221H
         prFka86UHk17cBGUsatBi0cK1L6Cc+gU8rK+iZnqxupvkQE0Ijs30af5F6CNbTNFav9M
         uXJtiyhRfUn9tk92oRRoILmBqMGFxrsKrPqr9pF6hFPm1gcMaMEMSTh2er9qpBMcaV8p
         7EI5jbYIPMVD//6oVcTykQllOdbQKLZo0JcHVyN5jNn+PNHYPX6Igo2AY3C3DRRL+ocz
         D1rKthF5TOVUGN7W2ihWpJTQnZp8E3r48pw1NfSKtlbXFi1XKcCQxEAMgnsuYIfcFVKB
         JIDw==
X-Forwarded-Encrypted: i=1; AJvYcCXRWm9WeEET+aBOHDlFbkKhYsPrDLy+GhoHc5aI1zM3dkB0iB3EEnd494t6mPO2kpgujyugoQ/1qOn63Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLezKekZsnCYKZrWVXmWyKXSM+7Ea4QE1IKgeKwIKV9FPVEnN
	q4iVV7eCWBLZrZ1ShJqNflwDpA/Y0Jq2iDvnQ6KZMTAFo2YA15kZsh3PHYCuHg==
X-Gm-Gg: ASbGncvbOvsQKjUX1M2BVIFevKE9hGJYvldw8AWD6ROwVO/S1FNj/ov+tMtEmMnKJc0
	JYbmtNsaJ3pU02imB9Ufy6R+W7Axiizm2Nj9ITKBMF7K+VTjOdbOElRybawAkZrehf1XWcHTfVy
	WPVsYb7fBd0uLj0nT/gI1R9NCTR1YlA0TjyrDGIRpDk/rMO2tGWoIbkiA6LNR11LURrhGevLvdh
	fGevJB1GqxORXkIMt55yx1DTfYvBLMyjP85l7hkPI8/CLa7Qnk6ytHxF4v02vmNC0ba0HubzC7c
	teKKwaqNj5vrHFz+B/3kJdPU
X-Google-Smtp-Source: AGHT+IHa7Pn2PDpYTelow+sIFnWl3x1JrObmzUG1+LV1s9m1wO2itR1j+AfGUfW2xoUFqinWiiyXvA==
X-Received: by 2002:a05:6214:2587:b0:6d4:1425:6d2b with SMTP id 6a1803df08f44-6d864dcb836mr30231026d6.36.1732693583896;
        Tue, 26 Nov 2024 23:46:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97b1asm63750386d6.40.2024.11.26.23.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:46:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 07:46:11 +0000
Subject: [PATCH 2/2] media: uvcvideo: Remove dangling pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v1-2-eb8722531b8c@chromium.org>
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
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
 drivers/media/usb/uvc/uvc_ctrl.c | 40 ++++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  3 +++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5d3a28edf7f0..51a53ad25e9c 100644
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



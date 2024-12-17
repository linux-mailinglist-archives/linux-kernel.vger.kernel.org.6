Return-Path: <linux-kernel+bounces-449940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360CE9F5865
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB3161FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556701FA24A;
	Tue, 17 Dec 2024 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MSDIlEc4"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1621FA159
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469628; cv=none; b=urybt591N5s9pxfkYGHwTkxmVKYAobECgsbWg1GAXwi8VVALXOfTayoYHfRQ44ntsiWP/95+5PVLsjT+X4HNGl4vUXEVLh/vMgLTd9Vt9ws1C+dJbJWKHTKIFsbZUMzMepk+ENVGZXkaNKNU9XS08yJAUrmxTVy+vHr7zOJjT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469628; c=relaxed/simple;
	bh=KWINgD5ata/eDZY7THpzR0BBEKdcMhTmgSkDYYCfiIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b18MK5pI2mtrod7bgyf3yMtL6aMwuALopg8+W362Cptwtzu+oXJ4tamwzz4YG/YKxTeZdqt5hbgOJD9sfUQUVC0+sJBURrn/hLRF9izEx6F7pKd2rAJuotknW9hWT0rZLZSCL1GoNqIQhyzxVv8JXSXynBgn7gqH0xfH21CKce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MSDIlEc4; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d89a727a19so1299466d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734469625; x=1735074425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzDVbtPPI6/PR4xHZ+uo8XhKlnVqNLbQOPgmtj8cDpY=;
        b=MSDIlEc4F3Md47Awgp+ZISXD6fmtw5DnG2qsq7B4Cv3CAJwjQhD12G5GxY1/UUo0O+
         1FsWGtiMDZn43RR/hDp/lyWQwIVwnr+YqIrXN1WEvuq7VwxMyL6R7yW8FQkIPKSI/X68
         u5utrH1iE8uyOuKgbYzBMCgM+MCxizgjaLH/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469625; x=1735074425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzDVbtPPI6/PR4xHZ+uo8XhKlnVqNLbQOPgmtj8cDpY=;
        b=c4xoGpwkXgMLHhc9y9jHxbnBxrk59mHn8YRCuT7Dj2QuNhq+ySW87gcMlc6Lpj+rwx
         Si8zngsWGzo4yQx+EFwMuJjb6lWt6YRxUXjh6DHbjaWFHyzphAVrm/rUqvhWHEy1rYBp
         IrZ2JJi5HQKYkYDePHjsBJqTNxF27weqy45bFohB5OmKLO+g8dzzP04YgeYdpJNN8pav
         FXztH5nxYLRRblDedeWmA42vgZXVTI0kv0RxGjb68FW3i96q0CtKevDZQd5uX2FQ+aj8
         2tADScf1bQLsVikDYVlJghc1RKKvaQ6Iu8ono97r5ylOQTSl5SW2oaMyZt4WsaRxEzgY
         jAYA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZnp8Xjw5GtRmysMuyijhXX/vrHtKqA5+bX7Pq9doz4P2A+h6xYI13k+R8kiRLbyFv725xJjKJdCx2BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tqRZsyygZgxyE8dMnQE4gY5mF1FuUFWmAdAVT3MwasMfp281
	1Gia7bP9r1BvtYOg2eeVTzTLSIgIHkhGNvzm9m7n8VXfARTybKsyAOqvbGiwNPubx0JAlgg4i3g
	=
X-Gm-Gg: ASbGncv3uCSf4nyFN2o2ul3LqJci1HdLDHY+WCg2h/iB8KlV0au6hshfDNGkgHcl0ui
	Gn8jjixr5YzXqNfJ5roVq7xqNdcdQcrI6QtvcOvlpZQvTp1ktM1o73WOzUthGxAB/ZtdJbRLucs
	N9Uj5OKq8hHRkqE5g5rRiZHPgdq9hgav/62k2UxiEgofovbCQ7oyLpBfOjE8+YA08EFaJfzhYk3
	dtOs+WAEpYYMs2Oo9hewBxAfHj9Fi/Ywp06x1sPfU9ljZAthlX0wQAAKjnRKIVrFjkZL25q0EZB
	+qQDbLjtmDLCgJvNxHdGl0/Xdo686Gg=
X-Google-Smtp-Source: AGHT+IGX8riHqAG53Ns1JT9wSuOCfFOlraoLCjYZFxLDwPTGDlF0oXz/RZNF/7QUyo7aQ+ZSfrGJPA==
X-Received: by 2002:a05:6214:501a:b0:6d9:fb5:d496 with SMTP id 6a1803df08f44-6dcf4c9e41cmr84982336d6.24.1734469624744;
        Tue, 17 Dec 2024 13:07:04 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f2a7sm42825276d6.27.2024.12.17.13.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:07:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Dec 2024 21:06:58 +0000
Subject: [PATCH 2/3] media: uvcvideo: Allow changing noparam on the fly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-uvc-deprecate-v1-2-57d353f68f8f@chromium.org>
References: <20241217-uvc-deprecate-v1-0-57d353f68f8f@chromium.org>
In-Reply-To: <20241217-uvc-deprecate-v1-0-57d353f68f8f@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Right now the parameter value is read during video_registration and
cannot be changed afterwards, despite its permissions 0644, that makes
the user believe that the value can be written.

The parameter only affects the beviour of uvc_queue_buffer_complete(),
with only one check per buffer.

We can read the value directly from uvc_queue_buffer_complete() and
therefore allowing changing it with sysfs on the fly.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 drivers/media/usb/uvc/uvc_queue.c  | 6 ++----
 drivers/media/usb/uvc/uvcvideo.h   | 4 +---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 091145743872..10812a841587 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1995,7 +1995,7 @@ int uvc_register_video_device(struct uvc_device *dev,
 	int ret;
 
 	/* Initialize the video buffers queue. */
-	ret = uvc_queue_init(queue, type, !uvc_no_drop_param);
+	ret = uvc_queue_init(queue, type);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 26ee85657fc8..ed246d8ff31a 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -208,8 +208,7 @@ static const struct vb2_ops uvc_meta_queue_qops = {
 	.stop_streaming = uvc_stop_streaming,
 };
 
-int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type,
-		    int drop_corrupted)
+int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type)
 {
 	int ret;
 
@@ -239,7 +238,6 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type,
 	mutex_init(&queue->mutex);
 	spin_lock_init(&queue->irqlock);
 	INIT_LIST_HEAD(&queue->irqqueue);
-	queue->flags = drop_corrupted ? UVC_QUEUE_DROP_CORRUPTED : 0;
 
 	return 0;
 }
@@ -472,7 +470,7 @@ static void uvc_queue_buffer_complete(struct kref *ref)
 	struct vb2_buffer *vb = &buf->buf.vb2_buf;
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
 
-	if ((queue->flags & UVC_QUEUE_DROP_CORRUPTED) && buf->error) {
+	if (buf->error && !uvc_no_drop_param) {
 		uvc_queue_buffer_requeue(queue, buf);
 		return;
 	}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07f9921d83f2..ebbd8afcf136 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -316,7 +316,6 @@ struct uvc_buffer {
 };
 
 #define UVC_QUEUE_DISCONNECTED		(1 << 0)
-#define UVC_QUEUE_DROP_CORRUPTED	(1 << 1)
 
 struct uvc_video_queue {
 	struct vb2_queue queue;
@@ -674,8 +673,7 @@ extern struct uvc_driver uvc_driver;
 struct uvc_entity *uvc_entity_by_id(struct uvc_device *dev, int id);
 
 /* Video buffers queue management. */
-int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type,
-		   int drop_corrupted);
+int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type);
 void uvc_queue_release(struct uvc_video_queue *queue);
 int uvc_request_buffers(struct uvc_video_queue *queue,
 			struct v4l2_requestbuffers *rb);

-- 
2.47.1.613.gc27f4b7a9f-goog



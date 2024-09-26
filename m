Return-Path: <linux-kernel+bounces-339922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2799986C30
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BD4B2520E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2918786D;
	Thu, 26 Sep 2024 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bx0IQXOO"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C3186E47
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330360; cv=none; b=IM3tV3A8qHMWQ+Hd15OFheQwLRhSmlP0KnGwBaEQ/cK0fE+98jkvpDZwdVSAQ4PDcHodOe3gFnAKaOTg7P6TdVNhOyqV+Dr6Nyq41ivKzIIDTyDY2LZLo4EnKxy069qATTkxDi407MzfU3nSy4KIs/59kAB3/wi830HYPPcWE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330360; c=relaxed/simple;
	bh=XYyn/uWSwGEwZ2izkIKhOmYIuCbBJ8CxIZasp0IY31A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mbubryq1HzK62zXO20mCA+Uu1O2+O3jbYmUJHaZs27kYX1KNUDd3ltNBXwJSbsBS7taQt+UBOirYUxWqjwOOOaGPCz/ejNlbuEr+/IX9Q6dZpHYHjugUVFcoaiCdZUR4cBFqq/TWCVSH6aD9umNkpk/3fXrsooTQ7YkKsFwE4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bx0IQXOO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4582760b79cso2847151cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727330357; x=1727935157; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/c8AisojHt8E8qq/bSCfOVPkpZhoMvB2alieW7bAk4=;
        b=bx0IQXOOJVzSvCeYKB1yNPRKrRMe4LGl0iKna1BizoObe62ouDS05M4Xt2C6w5ZPU1
         jRRmxJju8Wa4ks7XOMnnGybV6D1E4tFtEPIU3CbktPPob5kM43FXvy4WEA6dR3uwQv/v
         CplrSGwYP0t/c9Gik+XjCDUC7M5pfaIRDgi7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727330357; x=1727935157;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/c8AisojHt8E8qq/bSCfOVPkpZhoMvB2alieW7bAk4=;
        b=ErdbTPvOTanlAOygSokma5ZxD1rTQZau0iZ8rhXA15f5BoYwE/eeDUdSJF6iIT6ypg
         J8WbuVaFdGDagdKNKsmipyc6PO0L0qnDgH2tgO3b2AKYUkWufjLpO0XTaO6fOAP2wg8t
         zAg/ZJ5/Zc9x6WEJJRg6fy0pkhcfV9CLbbsxP6MJdEUQJpOJPHDe/Rgezw5LdzSk1Fmu
         CVzgOAUbCWxRQ9pezGqbJDq6DYZ+7+z8QIYS7NDeEtf52HvrT4yoeL0wDj+EmXtdCArc
         jLkemYRjqq92w9ds+B5LU8jZiOk1z9eGz+Duqs1q7Nk7paKP9HMAY3Ro4xas+0rAioGI
         eWGg==
X-Forwarded-Encrypted: i=1; AJvYcCWiQPHzDpmsCx7m+mL2wuBAVqrbZbPNjkBD+36/mScfLOJAZBrdNblpuq+mjw/dkRUbb9PDZd4qJUvGhRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoMoR1QPftTETDBvDgrr1BhE1tQPTaHRPBBTE/CYoPBNt47HC
	pblIJSX9QpoYO59ncQ7nW6nxk+MiBiI/CDcf7mW/KsU/8ltUYJMalox0lkGoiw==
X-Google-Smtp-Source: AGHT+IH8HqXesp42SaUkdV4xroJDzKJ0Wpb2M4gze5VjC9BE0JCCtVeG2eBFGZII9cPYa+Z2uyfzxQ==
X-Received: by 2002:ac8:5fd0:0:b0:458:2e48:b5ec with SMTP id d75a77b69052e-45b5e094b69mr64342101cf.45.1727330356886;
        Wed, 25 Sep 2024 22:59:16 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5253b05fsm22611271cf.10.2024.09.25.22.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 22:59:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Sep 2024 05:59:06 +0000
Subject: [PATCH] media: uvcvideo: Stop stream during unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-uvc_stop_streaming-v1-1-038180fafe5f@chromium.org>
X-B4-Tracking: v=1; b=H4sIACn49GYC/x2MQQqAIBAAvyJ7TjAJw74SEaZb7SELLQnEvyddB
 uYwkyFiIIwwsAwBE0U6fZW2YWB34zfk5KqDFLITWir+JDvH+7wqApqD/MYV6tVJgbpfLNTwCrj
 S+0/HqZQPntZ+N2QAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

uvc_unregister_video() can be called asynchronously from
uvc_disconnect(). If the device is still streaming when that happens, a
plethora of race conditions can occur.

Make sure that the device has stopped streaming before exiting this
function.

If the user still holds handles to the driver's file descriptors, any
ioctl will return -ENODEV from the v4l2 core.

This change makes uvc more consistent with the rest of the v4l2 drivers
using the vb2_fop_* and vb2_ioctl_* helpers.

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
This patch was part of the series:
https://patchwork.linuxtv.org/project/linux-media/list/?series=13064

Moved out from it to ease the review.
---
 drivers/media/usb/uvc/uvc_driver.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index f0febdc08c2d..bee150b852e4 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1919,11 +1919,41 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	struct uvc_streaming *stream;
 
 	list_for_each_entry(stream, &dev->streams, list) {
+		/* Nothing to do here, continue. */
 		if (!video_is_registered(&stream->vdev))
 			continue;
 
+		/*
+		 * For stream->vdev we follow the same logic as:
+		 * vb2_video_unregister_device().
+		 */
+
+		/* 1. Take a reference to vdev */
+		get_device(&stream->vdev.dev);
+
+		/* 2. Ensure that no new ioctls can be called. */
 		video_unregister_device(&stream->vdev);
-		video_unregister_device(&stream->meta.vdev);
+
+		/* 3. Wait for old ioctls to finish. */
+		mutex_lock(&stream->mutex);
+
+		/* 4. Stop streaming. */
+		uvc_queue_release(&stream->queue);
+
+		mutex_unlock(&stream->mutex);
+
+		put_device(&stream->vdev.dev);
+
+		/*
+		 * For stream->meta.vdev we can directly call:
+		 * vb2_video_unregister_device().
+		 */
+		vb2_video_unregister_device(&stream->meta.vdev);
+
+		/*
+		 * Now both vdevs are not streaming and all the ioctls will
+		 * return -ENODEV.
+		 */
 
 		uvc_debugfs_cleanup_stream(stream);
 	}

---
base-commit: 81ee62e8d09ee3c7107d11c8bbfd64073ab601ad
change-id: 20240926-uvc_stop_streaming-6e9fd20e97bc

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



Return-Path: <linux-kernel+bounces-214906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF105908BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57881F23D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA419752F;
	Fri, 14 Jun 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mo2NjXB5"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D4197A97
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368902; cv=none; b=DmurM+l1jzmITLd8BD62ExOWzwhy7woL2ko3ltISZxgH8T8IpxyGMesD6AXAC2JgrbLSRvrtAiQOD9PRx75hv01MUqcaRwNdUcLmMwV+uWqT29bTfs1AS06cDf36mw/ZKZG3u0ttGdpWx5oro0AVBHFaMu9hxveL+H4Z6o4CQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368902; c=relaxed/simple;
	bh=OPtShxcRovrc0ApwA+mGVi0pQIrUHwKT8NvIrhVwv18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=doIwt2eQuN/gz5Ra04hMl0OQtGvAaqkTkwa1idwSX93uI9fwEfy37oEy9Y2yZQelCcvTkKd74td+tl0mwTwqI8kts2ka0cOhghM3zLrQRkGPk+wDD7CegA0sfKNxZ49NcaTN6ydAJIG2DtynaLREK5pwvBG001unt4EOS2W8ulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mo2NjXB5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b065d12dc6so10710786d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718368900; x=1718973700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8kFpTSgweaR6Nec0z5zkoH1ecBgqoSDR5hh4JMWPJA=;
        b=mo2NjXB5Pmn2wU0CE1dlBIAE6C8pjy22iTck9biDkSpuKnv084ydrkGDr3joBQ9qEA
         A5FAa51WawwMrucDyOq/SGUMTFdYxOSLpLNlzUVcULEIxZXTsTQlFftbrCU6b+jmALJf
         VIQd4YxDLpqpoFaH4ck94IBvwB9UJejsfG4Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368900; x=1718973700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8kFpTSgweaR6Nec0z5zkoH1ecBgqoSDR5hh4JMWPJA=;
        b=pWP8NZ0bpc/CfJAPKRRVoT23cM/shASBR29lKcXvQIDFtAnEyXPUgTDXXc4KEhiQmS
         7gNzcA+TYQgvXqSM8RyEyiFhPaX1eK5Iz5uo0VYNZzhbvtmoJj10qYU1SR6nMEHPyhVN
         Df5oiHp6LSKuDHxXQi4W6uSejTZLb9dNe1Z66cri/noQ8cPZ+hohwDVFyikuVi6WH1pv
         7oWrig/SFgl//1C/wCsGR8gVLo/xcHC7udbNZcT5XJ6fNCYYB9go3/hT8sYEzsHIIWmr
         UjjXZc9L/f+siMURT+JMZVoA86XPE2Y3AYn/4fp/6vcGsoSLju8bMHK92qw9obvRVPlr
         kFMw==
X-Forwarded-Encrypted: i=1; AJvYcCXV04UqG6n22faQsiqgHzERX0lzl1aIL3ia0q8AX7Jl8kXIx0YI0xlOWB/yPq2Cg/kjtT2jCipwhxXdIQcfji79VKAliVRESJiZiQ9R
X-Gm-Message-State: AOJu0YwBv7SIuQnzhySaqDYV3lkhI9blppSJPJyAhIv3yu/RNn17CDL3
	tVCq6+HcyIriEkRayYVTON+p1iTjhQutTlVoL9xur5LGvGEBYj+8tCVC1cQpRg==
X-Google-Smtp-Source: AGHT+IGmXLlavEhpMV5CNUku5YzkH/cb63RUquisVvcQ5iK+GpLy1J22k3t9dposGLQFJm7TuVFW/w==
X-Received: by 2002:a05:6214:d89:b0:6b0:78b6:e5e9 with SMTP id 6a1803df08f44-6b2afcd23a8mr31288256d6.27.1718368899450;
        Fri, 14 Jun 2024 05:41:39 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c202e8sm17734056d6.50.2024.06.14.05.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:41:38 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Jun 2024 12:41:27 +0000
Subject: [PATCH v6 1/4] media: uvcvideo: Stop stream during unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-guenter-mini-v6-1-7b7fdc3b21b3@chromium.org>
References: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
In-Reply-To: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
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
 drivers/media/usb/uvc/uvc_driver.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bbd90123a4e7..55132688e363 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1908,11 +1908,41 @@ static void uvc_unregister_video(struct uvc_device *dev)
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

-- 
2.45.2.627.g7a2c4fd464-goog



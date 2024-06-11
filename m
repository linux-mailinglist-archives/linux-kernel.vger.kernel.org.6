Return-Path: <linux-kernel+bounces-209452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35BD903501
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCEA1C23408
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D08174EC3;
	Tue, 11 Jun 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dQ3GW1cG"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C805171099
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093532; cv=none; b=brGgz5vVZE4zGcXoUVnj0BKjlgx4oYlgTnhXNlXqi0RQRB3/fMqcDlJTA8i7q+v1J8M5GV07W7DsupHrKJE4jaoTq9R3bXtu9hPqv62K6vHpSD/8S/3rfHKh7NHVWS7897ZOEKk7Jxf6v1bAh9DbHL1MRsZFLBQHUbcIJGsc3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093532; c=relaxed/simple;
	bh=VBjl8MShjb4jhR/wD8VA+h2otUV+ZOfH5etejEqA764=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bi2ow0LtMtqUHnmr4zMP/vhSqMJooxTWxMcUSzkDS06KEIMqPzlZxJ6a/2MjHsEHELcbenF4z3truql5PZOJG999RZW6XLOOpLUrTwBKw1f3ku+LPgJCo+5oUVsAgvS/7m3Xvi+xzsf3ltrGD5QwbkGTKx9L1e8Dl1YSYkLrr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dQ3GW1cG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b06bdbf9fdso4822236d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718093530; x=1718698330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8v2HQzZnsAarKFZFIMw3d0cEESgGzGkmVZsX2rItjw=;
        b=dQ3GW1cGwHS6WY7hLP8xLKQ/QFBn0kB0bn+iMZlaGl6loEJnPjk1UT9x5PEmRw1zRP
         uN8LSed9YT4v2soVzdfBsZfEYLylW69olvevfUFEuB5EiQ5bsAVAobeB9f6I0Vh/mwT2
         4PdxyDRNz23oUwD/QsAJaniqMIpSARxGWRs0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718093530; x=1718698330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8v2HQzZnsAarKFZFIMw3d0cEESgGzGkmVZsX2rItjw=;
        b=IRjfuU+hggvtcNmPk8QuvRCRRSnboZX1lJCAzh2blLKPBhIa7EkeDJqyRp5vWNeUI2
         XbDHt3ShmrS7b1w9d7STuO3X9kFebX/8+znCi60dU87nNnpQ1hXtqxt0LcoVQ/NLANBC
         y7lSawJdDs9ff+Mm8oa/XC5eo+dJoiEZRTbgHRLLsq5nngoeMSar3fFoRmmQzeMY8Wsc
         M3daO+15dbiAEAIKe7VmxYwOx7tPjTUmVB5VBRsSYTQV/iBG3ToPlsc+NhaRS1bL/hX5
         F73jy9MKkRHRHhUGnGgyL76lVBhiHzZPdYhvI5+seArjkbfuLq0KwOotdbR4YlFPr9Kq
         YhaA==
X-Forwarded-Encrypted: i=1; AJvYcCXQXFaIL84elh/PpyxvDD+WA+LAL4dF2Nf1xy+k40fkwa7+Nb3wBO45K+ywXid6mbQUKbl78q7sGw13a4PjbnVqLC4bVnoQxxklMCA7
X-Gm-Message-State: AOJu0YzzSoFsgMmMhOSmfJ+QjlOf6bOX83wwDQ3n5T1arSN36E6oMKBh
	aKnaS7GGfQRKBVbMW1KmWSZOLyy1Mh90ld80N/O8TJy75Z/putqFI4sIkV4+JA==
X-Google-Smtp-Source: AGHT+IHJrD3aaT0KJbL4s5UWU+yxBKPow1+9VOCVV8mz/2gwC8+wamLfq6YRjGQFX/uJQr7Tf9Tp0g==
X-Received: by 2002:a05:6214:3186:b0:6b0:8b2d:b6e with SMTP id 6a1803df08f44-6b08b2d3a43mr14553876d6.63.1718093529989;
        Tue, 11 Jun 2024 01:12:09 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b09039c2b9sm1548886d6.28.2024.06.11.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:12:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 11 Jun 2024 08:12:06 +0000
Subject: [PATCH v5 1/4] media: uvcvideo: stop stream during unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-guenter-mini-v5-1-047b6fe5d08b@chromium.org>
References: <20240611-guenter-mini-v5-0-047b6fe5d08b@chromium.org>
In-Reply-To: <20240611-guenter-mini-v5-0-047b6fe5d08b@chromium.org>
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
plethora of race conditions can happen.

Make sure that the device has stopped streaming before exiting this
function.

If the user still holds handles to the driver's file descriptors, any
ioctl will return -ENODEV from the v4l2 core.

This change make uvc more consistent with the rest of the v4l2 drivers
using the vb2_fop_* and vb2_ioctl_* helpers.

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bbd90123a4e7..f1df6384e738 100644
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
+		/* 4. Stop streamming. */
+		uvc_queue_streamoff(&stream->queue, stream->type);
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
2.45.2.505.gda0bf45e8d-goog



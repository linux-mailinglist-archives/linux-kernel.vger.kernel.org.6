Return-Path: <linux-kernel+bounces-533895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB06A45FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544A41894071
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672BD19F41B;
	Wed, 26 Feb 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IRKXXwVN"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D243166
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574849; cv=none; b=rhV913zm0z0GC3RPl3DWCyQBiWtslx6We1wYCK7Zuj5gFResCQaBUkDwYr0jig0X3agOzCqOzkM43+qKjeZTWHTSQZ67iirPmK0WYIf+6avjVvIyRNngOCOhBS+m6rd+I4YO0CSwCfkmzCCuvI999WbGLmJ7yqy1Nks0ZLPLSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574849; c=relaxed/simple;
	bh=J4phSIV1IsjqS10A2sa1wgkOOB8DmVkKChjhEjWMup8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rGHuAmTq17OHcpkUXd5s5/nbvie0etlelnvDBromy9ZOHmwgB0wEziBiY5LN7NgxykO9ejRNlM3PrmqW+mFQftwQdxL9gYQivYCvjy72NHE3gpm7xB0uHVL0e3WWfkkQdXlSv+IJHmnVUzq7WZaQUWxC4sxkes4dYOa36rjpweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IRKXXwVN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd049b5428so63763526d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740574845; x=1741179645; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyjZzj7d18wJwwwvJyvuoYwwAkfDubW7UUdetywU8Bk=;
        b=IRKXXwVNU54sXzlm27W1xKiTvSFCjGoeHlL43XUCwBEFb7qrr+FTKXR8WsTAfyoNEg
         //zmegksQAkBTa6LwjeSzJb0FpyUtoeKi9U3FaeqNpg0fKKywMT9VmsjZZBCQDenR3+m
         2G2UgeSpu4Jdvz0IKmODG79lIx81hkR0XoNpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740574845; x=1741179645;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyjZzj7d18wJwwwvJyvuoYwwAkfDubW7UUdetywU8Bk=;
        b=tinq6O9aPXKX9JwKkHywpJC3pcoOWO//9Yl/fafRSI14+Qbw6pM165b0RNXSNYyWK0
         1BVSOa1Wrt4O8dYButFe9+G5q/a7WSnTM+ZXNWltMSUtxHoepozWYXg5y5IwUvXRvurf
         NikUI5/y11e9k0C5Zzrn2jr3h+8dmT0C2wvtwJZGVyPwwFbzg03I92CVcP7UIpJj6VsZ
         FePecaICPm3dv2jSRhbtOtz818cjUiWZNQ2YHVOAznrvlUlxKm5IaIbMYxkl1SvD7URt
         DWFqlj3AcN4vsNqxLBeTsJJgcCFSiytMFA6I3ZONY2r+u84qdA8cTz6h+ONPevPFbSr+
         MNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/LUHL5D4TXxK0vuPKibojaHDdbXMvrHk7fm/gKR1P6Yru1k1itz6gzxZV9tp7tr3eNy99vghx8vXVchk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdOB2N4E0Xg6eE1r0lGPxiCYWsDx074JUJcgrOO/o92FNa2pJ
	ogIrNC8fo5bBUOyV3ATiH3sfZlO0ZTiMdV+CuEXmlwN4AuVY8BjmGSl8ub1agA==
X-Gm-Gg: ASbGncvA61cnDIZfIghH/LbIb6RVI18EOnefCD7nuHeJiePaEFEiLzZ7d43mkYmcNH0
	VT7i784jzfyIoYIhQ/54oHfaiAUcHxAqMyffVKlOitgZtbhTfksx7+HotPsAH4cJPXouRDlv1On
	/7LP2Dx8yyseKRKSyrCp/ruRupiCrtS9AHAZbPuTsUspzBKL016E3muyLXyPqXofD9ShoNZTCWn
	abpWJkAKqASpac7muGOOM2jw2/ogxcy3QIwM4ViVN1p99gk5hP0J0YtENJMZ8WUzWYzJUwYvgm2
	UDE5FkRlJlHrz3qBjcF/k36akH+vf9rWcX02wKWWWesjUuOqqv8aYpDsh/NZ58t00AEXNJuaWvL
	58B0=
X-Google-Smtp-Source: AGHT+IGilKUCIddlifEHfV55Je9mp/wb6bVRPjoaxtBcDtdpEkbeF145mOvbHiuK5gNopTCnvtipWA==
X-Received: by 2002:a05:6214:3001:b0:6d4:215d:91b5 with SMTP id 6a1803df08f44-6e88688790amr48200446d6.11.1740574845021;
        Wed, 26 Feb 2025 05:00:45 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b19af0asm21698536d6.121.2025.02.26.05.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:00:44 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Feb 2025 13:00:41 +0000
Subject: [PATCH] media: uvcvideo: Enable full UVC metadata for all devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHgQv2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMz3dKyZN3c1JLElMSSRF2jVPNUExNTSzOzlFQloJaCotS0zAqwcdG
 xtbUAQVuZil4AAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
V4L2_META_FMT_D4XX. The only difference between the two of them is that
V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
V4L2_META_FMT_D4XX copies the whole metadata section.

Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
devices, but it is useful for any device where vendors include other
metadata, such as the one described by Microsoft:
- https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata

This patch removes the UVC_INFO_META macro and enables
V4L2_META_FMT_D4XX for every device. It also updates the documentation
to reflect the change.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 .../userspace-api/media/v4l/metafmt-d4xx.rst       | 19 +++--
 .../userspace-api/media/v4l/metafmt-uvc.rst        |  6 +-
 drivers/media/usb/uvc/uvc_driver.c                 | 83 ----------------------
 drivers/media/usb/uvc/uvc_metadata.c               | 15 ++--
 drivers/media/usb/uvc/uvcvideo.h                   |  1 -
 5 files changed, 23 insertions(+), 101 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst b/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst
index 0686413b16b2..1b18ef056934 100644
--- a/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst
+++ b/Documentation/userspace-api/media/v4l/metafmt-d4xx.rst
@@ -6,12 +6,23 @@
 V4L2_META_FMT_D4XX ('D4XX')
 *******************************
 
-Intel D4xx UVC Cameras Metadata
+UVC Full Payload Header Data (formerly known as Intel D4xx UVC Cameras
+Metadata).
 
 
 Description
 ===========
 
+V4L2_META_FMT_D4XX buffers follow the metadata buffer layout of
+V4L2_META_FMT_UVC with the only difference, that it also includes proprietary
+payload header data. It was originally implemented for Intel D4xx cameras, and
+thus the name, but now it can be used by any UVC device, when userspace wants
+full access to the UVC Metadata.
+
+
+Intel D4xx Metadata
+===================
+
 Intel D4xx (D435, D455 and others) cameras include per-frame metadata in their UVC
 payload headers, following the Microsoft(R) UVC extension proposal [1_]. That
 means, that the private D4XX metadata, following the standard UVC header, is
@@ -21,10 +32,8 @@ types are MetadataId_CaptureStats (ID 3), MetadataId_CameraExtrinsics (ID 4),
 and MetadataId_CameraIntrinsics (ID 5). For their description see [1_]. This
 document describes proprietary metadata types, used by D4xx cameras.
 
-V4L2_META_FMT_D4XX buffers follow the metadata buffer layout of
-V4L2_META_FMT_UVC with the only difference, that it also includes proprietary
-payload header data. D4xx cameras use bulk transfers and only send one payload
-per frame, therefore their headers cannot be larger than 255 bytes.
+D4xx cameras use bulk transfers and only send one payload per frame, therefore
+their headers cannot be larger than 255 bytes.
 
 This document implements Intel Configuration version 3 [9_].
 
diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
index 784346d14bbd..a3aae580e89e 100644
--- a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
+++ b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
@@ -6,7 +6,7 @@
 V4L2_META_FMT_UVC ('UVCH')
 *******************************
 
-UVC Payload Header Data
+UVC Partial Payload Header Data (formerly known as UVC Payload Header Data).
 
 
 Description
@@ -44,7 +44,9 @@ Each individual block contains the following fields:
         them
     * - :cspan:`1` *The rest is an exact copy of the UVC payload header:*
     * - __u8 length;
-      - length of the rest of the block, including this field
+      - length of the rest of the block, including this field (please note that
+        regardless of this value, the driver will never copy more than 12
+        bytes).
     * - __u8 flags;
       - Flags, indicating presence of other standard UVC fields
     * - __u8 buf[];
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index deadbcea5e22..f19dcd4a7ac6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2488,8 +2488,6 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
 };
 
 #define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
-#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
-	{.meta_format = m}
 
 /*
  * The Logitech cameras listed below have their interface class set to
@@ -3107,87 +3105,6 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
-	/* Intel D410/ASR depth camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0ad2,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel D415/ASRC depth camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0ad3,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel D430/AWG depth camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0ad4,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel RealSense D4M */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0b03,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel D435/AWGC depth camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0b07,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel D435i depth camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0b3a,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel D405 Depth Camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0b5b,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel D455 Depth Camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x0b5c,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
-	/* Intel D421 Depth Module */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x8086,
-	  .idProduct		= 0x1155,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= 0,
-	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
 	/* Generic USB Video Class */
 	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
 	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index 82de7781f5b6..5c44e6cdb83c 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -60,18 +60,16 @@ static int uvc_meta_v4l2_try_format(struct file *file, void *fh,
 				    struct v4l2_format *format)
 {
 	struct v4l2_fh *vfh = file->private_data;
-	struct uvc_streaming *stream = video_get_drvdata(vfh->vdev);
-	struct uvc_device *dev = stream->dev;
 	struct v4l2_meta_format *fmt = &format->fmt.meta;
-	u32 fmeta = fmt->dataformat;
+	u32 fmeta = fmt->dataformat == V4L2_META_FMT_D4XX ?
+		    V4L2_META_FMT_D4XX : V4L2_META_FMT_UVC;
 
 	if (format->type != vfh->vdev->queue->type)
 		return -EINVAL;
 
 	memset(fmt, 0, sizeof(*fmt));
 
-	fmt->dataformat = fmeta == dev->info->meta_format
-			? fmeta : V4L2_META_FMT_UVC;
+	fmt->dataformat = fmeta;
 	fmt->buffersize = UVC_METADATA_BUF_SIZE;
 
 	return 0;
@@ -110,19 +108,16 @@ static int uvc_meta_v4l2_enum_formats(struct file *file, void *fh,
 				      struct v4l2_fmtdesc *fdesc)
 {
 	struct v4l2_fh *vfh = file->private_data;
-	struct uvc_streaming *stream = video_get_drvdata(vfh->vdev);
-	struct uvc_device *dev = stream->dev;
 	u32 index = fdesc->index;
 
-	if (fdesc->type != vfh->vdev->queue->type ||
-	    index > 1U || (index && !dev->info->meta_format))
+	if (fdesc->type != vfh->vdev->queue->type || index > 1U)
 		return -EINVAL;
 
 	memset(fdesc, 0, sizeof(*fdesc));
 
 	fdesc->type = vfh->vdev->queue->type;
 	fdesc->index = index;
-	fdesc->pixelformat = index ? dev->info->meta_format : V4L2_META_FMT_UVC;
+	fdesc->pixelformat = index ? V4L2_META_FMT_D4XX : V4L2_META_FMT_UVC;
 
 	return 0;
 }
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 5e388f05f3fc..cc2092ae9987 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -534,7 +534,6 @@ static inline u32 uvc_urb_index(const struct uvc_urb *uvc_urb)
 
 struct uvc_device_info {
 	u32	quirks;
-	u32	meta_format;
 	u16	uvc_version;
 };
 

---
base-commit: d98e9213a768a3cc3a99f5e1abe09ad3baff2104
change-id: 20250226-uvc-metadata-2e7e445966de

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



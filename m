Return-Path: <linux-kernel+bounces-439265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB49EACE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1617818827F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E02397B0;
	Tue, 10 Dec 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jEQOMHTH"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90A237A34
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823790; cv=none; b=uzSriCaSdLZiOrHcdLd2NJYx2/QFo9sSBmWopaCOijISCLGWToLihF8bjbbIrZ8qrc1Sd8HGby6n92F8UNKX9hZIZsMn8NWm9TIICa26P+cLarWoRX/XVLzUtQLaqq6TvGHqupEB2ZjXS/BDvJuNGbu8G6ffklwRfiPWJsGrFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823790; c=relaxed/simple;
	bh=fKDUU4+a+tgFts82eq+chwHIWurrBXbxHGkI4O6ed0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJhmQgj9lfrp4xHlfBoch86Ju9wWa2Taa90F/ExdXFA+akYsQOf8FJpXwm/92sIZAY8QNDRknHVYlJGzLIkg6vOGu+zQE2FF9l7uV3xkX/nghAboYzuQW8ORYR1lG9MiQq1DxHRwEK1yE2fMzJJDT+5Forc9qQEfeQnKVGYEhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jEQOMHTH; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4676aad83d3so15088901cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823788; x=1734428588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcSM+HEV8BWvpd8XLVPPgYNPK82Sc3PIhfJhk9lYWic=;
        b=jEQOMHTHW1SSFfR671K5xpr4OpCloXT+RjDqJUcusgkoguVlj8sWmMNeXDbIOJYtnZ
         ahVbqTSGc2yhv6ZVxR5c5MCLt4RAlai6IiYHko1Fi06muXVGCevHsEWv/Qw9N53V5rUz
         81TpCVmiBwXwd2e1uujtZvRgJxhXADAx/36Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823788; x=1734428588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcSM+HEV8BWvpd8XLVPPgYNPK82Sc3PIhfJhk9lYWic=;
        b=WjRRDeE53U+R6vEPjYOlAhtqplS005nkXE/L1O0crd4Ffwx21LRda3WOEG7OtQKRR0
         5c74iuG67UQjPRxR2LBcKQXq46Cj/vJ7n09DFEDeLYlrmyZKqRcRgPi4wlNhxylyIUAb
         3tpR0EYSQYf3C/ke1QVYoGyL7xR0zQaQcO1Y3NE4KpqlPPd/YmbfHKwe+BB8nd0IgXM+
         F0QkYOZVWnbMwGDaxkb0ha+yJlPskXc6X9Trua92hcKedn3PWAEAFMTU3+uNggyEVkLv
         2U0v43AzSbIayRvHsq1mh4iOqeEBG3rmiQws94tzMQj/HnVzGMhEZtU6/rPdeK/u0nTk
         eCjg==
X-Forwarded-Encrypted: i=1; AJvYcCU6mh1uSyaxvSAlfdp5JGQiAcebunlsCJuM+5czIoIIQTYOLHJadgo3aKSYryYw/yUlMsUjj112wMNmn6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5O668jGDBCBDP+tIExQIdbOzUM+o+p07zZDEstAPMr2dvCVbD
	zTu3BLKZwMd14/2Qh9VKFymtEYqp8VBJiSOYKBSJ59r8PV8pz85FyIgUGZ588w==
X-Gm-Gg: ASbGncvdi3NBPym7odrRPiU1mG8TNbzxlVTTluJeKylhEJIIlgvPMq+qqYkdZjfKfCK
	1hkcTusDUo996JvGmKcD1wzdFS5x8q8dNoaSsjdrcJjhX5LGVBVpsLmnlz6QoCtp8gOhr9Sk715
	WabY1bStjf0dRFxSJfOxYptgZ2nuhdvYQWtEKV8wokZ+LWhaS3scl5++HftQuv71vrqnR07MnVK
	2I8vvXA41JTW5YiTsk5lpyZ9jz4mXt2vzl8P99xCE/39H72a77Gwauc1xP7xFD9PTRKYZMUfmdJ
	+Y6CJcffQC6T2n5qpmgLQa8yA3lg
X-Google-Smtp-Source: AGHT+IFtCAY1FI+TINr0gaxNPy0pUOg439RuOUTCEezTgC51c5iK/b9dchgVcUIE8AI0mMGMWG8sDg==
X-Received: by 2002:a05:6214:e6b:b0:6d4:1dc0:2620 with SMTP id 6a1803df08f44-6d91e4465a0mr64808496d6.40.1733823787859;
        Tue, 10 Dec 2024 01:43:07 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:43:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:54 +0000
Subject: [PATCH v16 18/18] media: uvcvideo: document UVC v1.5 ROI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-18-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Yunke Cao <yunkec@google.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

From: Yunke Cao <yunkec@google.com>

Added documentation of V4L2_CID_UVC_REGION_OF_INTEREST_RECT and
V4L2_CID_UVC_REGION_OF_INTEREST_AUTO.

An example of a userspace implementing this feature can be found at:
https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/release-R121-15699.B/camera/hal/usb/

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Yunke Cao <yunkec@google.com>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 .../userspace-api/media/drivers/uvcvideo.rst       | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/userspace-api/media/drivers/uvcvideo.rst b/Documentation/userspace-api/media/drivers/uvcvideo.rst
index a290f9fadae9..dbb30ad389ae 100644
--- a/Documentation/userspace-api/media/drivers/uvcvideo.rst
+++ b/Documentation/userspace-api/media/drivers/uvcvideo.rst
@@ -181,6 +181,7 @@ Argument: struct uvc_xu_control_mapping
 	UVC_CTRL_DATA_TYPE_BOOLEAN	Boolean
 	UVC_CTRL_DATA_TYPE_ENUM		Enumeration
 	UVC_CTRL_DATA_TYPE_BITMASK	Bitmask
+	UVC_CTRL_DATA_TYPE_RECT		Rectangular area
 
 
 UVCIOC_CTRL_QUERY - Query a UVC XU control
@@ -255,3 +256,66 @@ Argument: struct uvc_xu_control_query
 	__u8	query		Request code to send to the device
 	__u16	size		Control data size (in bytes)
 	__u8	*data		Control value
+
+
+Driver-specific V4L2 controls
+-----------------------------
+
+The uvcvideo driver implements the following UVC-specific controls:
+
+``V4L2_CID_UVC_REGION_OF_INTEREST_RECT (struct)``
+	This control determines the region of interest (ROI). ROI is a
+	rectangular area represented by a struct :c:type:`v4l2_rect`. The
+	rectangle is in global sensor coordinates using pixel units. It is
+	independent of the field of view, not impacted by any cropping or
+	scaling.
+
+	Use ``V4L2_CTRL_WHICH_MIN_VAL`` and ``V4L2_CTRL_WHICH_MAX_VAL`` to query
+	the range of rectangle sizes.
+
+	Setting a ROI allows the camera to optimize the capture for the region.
+	The value of ``V4L2_CID_REGION_OF_INTEREST_AUTO`` control determines
+	the detailed behavior.
+
+	An example of use of this control, can be found in the:
+	`Chrome OS USB camera HAL.
+	<https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/release-R121-15699.B/camera/hal/usb/>`
+
+
+``V4L2_CID_UVC_REGION_OF_INTEREST_AUTO (bitmask)``
+	This determines which, if any, on-board features should track to the
+	Region of Interest specified by the current value of
+	``V4L2_CID_UVD__REGION_OF_INTEREST_RECT``.
+
+	Max value is a mask indicating all supported Auto Controls.
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_EXPOSURE``
+      - Setting this bit causes automatic exposure to track the region of
+	interest instead of the whole image.
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_IRIS``
+      - Setting this bit causes automatic iris to track the region of interest
+        instead of the whole image.
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_WHITE_BALANCE``
+      - Setting this bit causes automatic white balance to track the region
+	of interest instead of the whole image.
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_FOCUS``
+      - Setting this bit causes automatic focus adjustment to track the region
+        of interest instead of the whole image.
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_FACE_DETECT``
+      - Setting this bit causes automatic face detection to track the region of
+        interest instead of the whole image.
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_DETECT_AND_TRACK``
+      - Setting this bit enables automatic face detection and tracking. The
+	current value of ``V4L2_CID_REGION_OF_INTEREST_RECT`` may be updated by
+	the driver.
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_IMAGE_STABILIZATION``
+      - Setting this bit enables automatic image stabilization. The
+	current value of ``V4L2_CID_REGION_OF_INTEREST_RECT`` may be updated by
+	the driver.
+    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_HIGHER_QUALITY``
+      - Setting this bit enables automatically capture the specified region
+        with higher quality if possible.

-- 
2.47.0.338.g60cca15819-goog



Return-Path: <linux-kernel+bounces-409822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D09C922F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6980AB24112
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30FD1A0AFB;
	Thu, 14 Nov 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aC7ulpuQ"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF471A9B3A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611453; cv=none; b=nNz8bUgNDPXoWnFVUhWu92UYuG5TuowJWk0gNdnNijnFDfJda0o2V8ScJMXa9Cfii2AHQIS9AI8kaki5DX1hztTxh5dPGyF/m9bdkW4DebDKsvXA+NXtqLZHY1eBmtyjeJyeXUy76TQSeHDxAieyvjj7DKTIR28y07cmJeEgHdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611453; c=relaxed/simple;
	bh=gIGmVdezcCcJeNLxtrKhKX+oRcR324CxjSWZAh2pVoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8/757bHnJGVP0yCg5Gr2dy+azLQhcshb6qyNpy8JcOV4yFLJsdHBgW6Z7v5J0I6btl9IqD+EYrZagMoo/2IAXOF9dN0KFdW8pS4ueIgZvisMjB7Kc4bX7jBB2WVAtF8w20TqUnqeP6pgpKkzbFbPH1FaIp0JO05NohFADhjCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aC7ulpuQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d382664fadso5469806d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611450; x=1732216250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoXFoTS1UHIpxTLyzT+33q7ydl+EE4ZnWBq8pnFccEU=;
        b=aC7ulpuQG0XZS4qz5WFOxUwUfF4c59+hF9Cjip0ZBecegc/Rk+yQxckchI6enBAgLV
         Kdq8gVBLvlBMQKdtqLKVsYZKCDiC+1Aks7oC5MEnpPrSS9putOClQ2VCOtmHjYXyjIeH
         0QejeX4Bt1Y/9MNPCCg5vth/BU0WfCM1t8pH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611450; x=1732216250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoXFoTS1UHIpxTLyzT+33q7ydl+EE4ZnWBq8pnFccEU=;
        b=JM7386FMBUPU39kJxi9wmZIB9ru8RnEKWLTjhIoTaKSme6TvcT/i5ogWJVozYuAQuE
         3V+t8lPFav+8CEE6aCNvrAm3x/Vmd+T8dhN0mmiEgT4xrddqwztQcPhI4ZJJRzoTMkmj
         YkRuveajakkq+TmVlGczvT2qNm4A+VcmBPUSfbq7R5yUFObh2mkaZGlHgYWigfLpWSPy
         +F2llsh1bpWGeA6G8veVikjfnfJYbfP7ckNWTRpaTxgfVx/vT/AoNLcfWcKiQQCiNOVW
         S5EexEzYkLyvGSW69dNc62CuU+VpHSs0T29bMJcV1AgwECZdvRf6en44fs0LLeo2R9Qe
         v+1A==
X-Forwarded-Encrypted: i=1; AJvYcCWvjusJrfa27T2yIVC4YSNxGt7XVTkjfbJEFtsrgZh+DrdTUqwQkTyBkSQI9uCF3WyzQO6EHkHBBpB+GiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiJrmTfIz0f7APurfZMZNq1o6eDDjHi0Hj3DmK5I5XXd2tjvk
	WX3MGXt6kshA5SB5lcxGOW7P2q+Jbi4oG+kz4AOLGmVj9WfozP9h/zbrM6fzow==
X-Google-Smtp-Source: AGHT+IH3AHUKa3QYBAA2tT0n3IAU/U0FsAiEeXPgr/F9Ta/r6uwiQZR+OH0yIoOUcs7eU1U6UG1g4A==
X-Received: by 2002:a05:6214:458c:b0:6cb:edd7:ac32 with SMTP id 6a1803df08f44-6d3d00be928mr154115866d6.12.1731611449903;
        Thu, 14 Nov 2024 11:10:49 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:10:49 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:34 +0000
Subject: [PATCH v15 05/19] media: uvcvideo: Handle uvc menu translation
 inside uvc_get_le_value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-5-64cfeb56b6f8@chromium.org>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

map->get() gets a value from an uvc_control in "UVC format" and converts
it to a value that can be consumed by v4l2.

Instead of using a special get function for V4L2_CTRL_TYPE_MENU, we
were converting from uvc_get_le_value in two different places.

Move the conversion to uvc_get_le_value().

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 77 +++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index bab9fdac98e6..77f7058ec966 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -862,6 +862,25 @@ static inline void uvc_clear_bit(u8 *data, int bit)
 	data[bit >> 3] &= ~(1 << (bit & 7));
 }
 
+static s32 uvc_menu_to_v4l2_menu(struct uvc_control_mapping *mapping, s32 val)
+{
+	unsigned int i;
+
+	for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
+		u32 menu_value;
+
+		if (!test_bit(i, &mapping->menu_mask))
+			continue;
+
+		menu_value = uvc_mapping_get_menu_value(mapping, i);
+
+		if (menu_value == val)
+			return i;
+	}
+
+	return val;
+}
+
 /*
  * Extract the bit string specified by mapping->offset and mapping->size
  * from the little-endian data stored at 'data' and return the result as
@@ -896,6 +915,16 @@ static s32 uvc_get_le_value(struct uvc_control_mapping *mapping,
 	if (mapping->data_type == UVC_CTRL_DATA_TYPE_SIGNED)
 		value |= -(value & (1 << (mapping->size - 1)));
 
+	/* If it is a menu, convert from uvc to v4l2. */
+	if (mapping->v4l2_type != V4L2_CTRL_TYPE_MENU)
+		return value;
+
+	switch (query) {
+	case UVC_GET_CUR:
+	case UVC_GET_DEF:
+		return uvc_menu_to_v4l2_menu(mapping, value);
+	}
+
 	return value;
 }
 
@@ -1060,32 +1089,6 @@ static int uvc_ctrl_populate_cache(struct uvc_video_chain *chain,
 	return 0;
 }
 
-static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
-				const u8 *data)
-{
-	s32 value = mapping->get(mapping, UVC_GET_CUR, data);
-
-	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
-		unsigned int i;
-
-		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
-			u32 menu_value;
-
-			if (!test_bit(i, &mapping->menu_mask))
-				continue;
-
-			menu_value = uvc_mapping_get_menu_value(mapping, i);
-
-			if (menu_value == value) {
-				value = i;
-				break;
-			}
-		}
-	}
-
-	return value;
-}
-
 static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
 			       struct uvc_control *ctrl)
 {
@@ -1136,8 +1139,8 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
 	if (ret < 0)
 		return ret;
 
-	*value = __uvc_ctrl_get_value(mapping,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
+	*value = mapping->get(mapping, UVC_GET_CUR,
+			      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
 	return 0;
 }
@@ -1287,7 +1290,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 {
 	struct uvc_control_mapping *master_map = NULL;
 	struct uvc_control *master_ctrl = NULL;
-	unsigned int i;
 
 	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
 	v4l2_ctrl->id = mapping->id;
@@ -1330,21 +1332,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
 		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
 		v4l2_ctrl->step = 1;
-
-		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
-			u32 menu_value;
-
-			if (!test_bit(i, &mapping->menu_mask))
-				continue;
-
-			menu_value = uvc_mapping_get_menu_value(mapping, i);
-
-			if (menu_value == v4l2_ctrl->default_value) {
-				v4l2_ctrl->default_value = i;
-				break;
-			}
-		}
-
 		return 0;
 
 	case V4L2_CTRL_TYPE_BOOLEAN:
@@ -1592,7 +1579,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	ctrl->handle = NULL;
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
-		s32 value = __uvc_ctrl_get_value(mapping, data);
+		s32 value = mapping->get(mapping, UVC_GET_CUR, data);
 
 		/*
 		 * handle may be NULL here if the device sends auto-update

-- 
2.47.0.338.g60cca15819-goog



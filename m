Return-Path: <linux-kernel+bounces-439252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CBF9EACBE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1864728B1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D6F2153E4;
	Tue, 10 Dec 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEX1WuAf"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A122153D3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823777; cv=none; b=jSrAl4MoW2m7F/WKKiaTqTDtb7ZbyjsZJyxFcvKsH43k+DmuztjXyCDxQs9uVZbRFUiLX9bwjC3cPVcsxOsiSv8zF0PX5T4oDSlNBcx/gVrpfxwv06jlh2pmTGHU/wCCeGXp5qIWRePUwF0Kh/QhTQAsJkEITkW8pXrK1e+QfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823777; c=relaxed/simple;
	bh=gv8rUdmSV4UR2dPzdenPsbmaBxNvhydo09k/zl6tPLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfhaQ0gWiAqwPE80cDsGIsEwN3w3DbRz1BDlzFQwfzG6Z6dJOxvGRNyO5tIJ12EGXv1Wx77IC14vHCMP2xu9UBQ36TSRmYmb81Z9hREPFyLwG+gR5VFzDrb8Nn+rgX5fU08on/IrTPf+pFdYIsBNYJSIS1yhLDTqDXHhwqc+cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FEX1WuAf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6da2d7884so111325585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823774; x=1734428574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aay2950jnBOP0EyAzMLsHhQ9XSwerGPpxxvrerX51do=;
        b=FEX1WuAfF3HIY3dJGLy7KNWvB6n58yuCwwEFIg6zmlg6mkcUJQAVL9611dzHZSETpr
         dEOr0dJnzNjDqtN4WxiUHCUbygE72h3pcNAdnh84vfsQtqbLg3DyDkgVgZE+UFBg45fv
         2gHI21Bl6sVnZc9YPiZAPB8PLWqrH3hfL797s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823774; x=1734428574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aay2950jnBOP0EyAzMLsHhQ9XSwerGPpxxvrerX51do=;
        b=hfypPBkARI/oZFly0PMzQDa9lTvfOey6O6E1Ojk705l7BFLlKjWk7NIe6bJQyBbGb+
         mfyfcUwXVnfvN410NSyOCy5YKIffHkdzPzW1Gvig3wWn4XcufDk1E+Bn2PBArcv+mmHV
         q/2y3oyywc177L+Ify/HnnUoA2CtOc1Ltp0NIhe5b66uoYEMtd2bsFJ8CG2Ynclay7tu
         OM7Z90XtaWKVnIaac1+Vtn00SFD1Lj29SyEVova/Y5lxCFGZ0P3FYEoX51K21iHNYQev
         VfPI9hJeFAhLOvMelfhnevTn+hF+7Cb0er8yP4DmFLALXMxD1lGNXQPch4pjj1WurGH9
         UIHg==
X-Forwarded-Encrypted: i=1; AJvYcCVaSY9qUJmdTGnWISm/v+oaHhSdwKI5u1AD9aP9GSqWXQG1c81lbtL7RRxC4vTG+/ZgZhOV4N0/ESnFins=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGeK0CHfvNIPUuIMJUOz7Bix2Bx/qlMqHQL0vWxr7nLQ1jgmx
	qnCNhOqjQIfXVSypLpOZNu2nvJsk2UrA1frhpgSG1R+M7UAMUi+TTBjcVd0Imw==
X-Gm-Gg: ASbGncsq4ziIvuDzyBZHTs0bMb8F7ebb3yXGWKbRktYzTHPQJC/MAzsbRuRTT7iOkDw
	hH3a1CFn+zo5Upq3Z7MUV2qRzZkxtxo59rjpQQcHiYCXm5sAqc38LT6Ut3p+FbfBOZvleztSBaJ
	zpWSZIpHa2huTRJubH/1AJoXCe6kA8Nq/9bLkQrztZEKVE+/MomDicind8q9jElV9arn64hP/uW
	H16/jYbimIkY1Ayk3ncZBLi4noO5Qsc+r7oJusDTSHr2jjqXjQyS5T8/w1XJHxDMMgszY5XFaDr
	5um5CuFNLLvvZQje5d2be6TagdrB
X-Google-Smtp-Source: AGHT+IHvsVSX4cF7Uq+tXoU3l7S6TpqvBBTt/QzYkHDT411ehQjvH1Xv2+t0pEkiDu6zBFsC1FpPbA==
X-Received: by 2002:a05:620a:2905:b0:7b6:d241:d4ae with SMTP id af79cd13be357-7b6dcebc84fmr718784185a.42.1733823767088;
        Tue, 10 Dec 2024 01:42:47 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:42:46 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:41 +0000
Subject: [PATCH v16 05/18] media: uvcvideo: Handle uvc menu translation
 inside uvc_get_le_value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-5-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Yunke Cao <yunkec@google.com>
X-Mailer: b4 0.13.0

map->get() gets a value from an uvc_control in "UVC format" and converts
it to a value that can be consumed by v4l2.

Instead of using a special get function for V4L2_CTRL_TYPE_MENU, we
were converting from uvc_get_le_value in two different places.

Move the conversion to uvc_get_le_value().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Yunke Cao <yunkec@google.com>
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



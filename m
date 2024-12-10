Return-Path: <linux-kernel+bounces-439259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C919EACD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02FA16BEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574A3DABEE;
	Tue, 10 Dec 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O72uzeY5"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5B234976
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823784; cv=none; b=cNx8PQicdXt5mPdfzNiNMLDJN8egl6Apq9JLDbKLRYwEMcRB+J8gBbDHybtxIu8yhll+lo7DkZRZ+gohEVSHMRLwesU9h6w5fPiayiWOGArxQpBkG1uIGEswrCkkhdM33dvuXn3UTnfwcnS2E8mJGOY8aKYwDtfzZKJqXGX3cGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823784; c=relaxed/simple;
	bh=mfhLeffdilkffQ88aag3azfnh854oo6y05hzwCztGkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9quHHm/xnbnZQJz/JIXMlfBss0zeCn7hx12IWlwIlH3dnP/jKsota8oyPb5KgKQonfQ9YnQlx6kyaYioI2DjWtOJY+QODXgt+Ohki5W8YdrfLh0XdAZSOpovo7LdXpXQiWXD+cgrEmQwL4NcaqN/Ey+2WDKUK3cSc+GIAGo3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O72uzeY5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6d109bca7so161210285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823781; x=1734428581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiwmj5eM7vigYSm+9Mmo6PKLcpfGimwewDBerK/2fr0=;
        b=O72uzeY53Yi6lleNdRtJidpfbwDOzxdynO0L/BsPrPv87OikiG42McrjVtYFJWzVcB
         77sIWPYueOeHX47wVAqTSwekCDTdnwdIYN0NwweRR6JrqtpZMprN3Em22rcewls/NlpK
         vpxJ6qI/vhv53qDDB1E1AjUzrN4hN1NU6el2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823781; x=1734428581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiwmj5eM7vigYSm+9Mmo6PKLcpfGimwewDBerK/2fr0=;
        b=npidrTrX1hbhtl8ykB6Ry/ao7nm5VAE9EWdIKWPBzX7D7vPzqZiYT0Zvnoli+DcjOD
         o4dw0sVuzgFZNjhIJslUaUhBEu7JhsDx5LPoNBIZhKDXMz367eGV2fbf95HsmNj+p8+t
         kavkNl9QVFHu/bejpbYjotH264jvv72ev27tXdmIIZl6d0aQ35PpzybOEo0GTxuRSiex
         Mq/WIipcvKuby/Kc+hPpHN2c5+P/z+eR/Cc15Bwm1lIhqS5xFCRBycx4X7JVKMhtqLGP
         thLcx+NUF9Rizds8y7HmOZLh3o8cKiqKPIPC69GYAkgaGa9J+3TuBcvnRDl0eYeWagDA
         HWNw==
X-Forwarded-Encrypted: i=1; AJvYcCXADYkZCb6+YNu4fSAXB8WyiDTsMkRtbhNVo/XTHYoL09E6YSkU9MwzTuuczBAsDeuPAgHRESxtZhCZ2gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFnjWr8H1X75/NT/7o2NS+JVVr3ZZydTIOmuY3U0UfGd20zMz
	cNmj0w4/sHXnZ0YYcq8Cdgp+1IeGVTojk8U+Zy3vbl1/OHWAezXoZHaNLremhA==
X-Gm-Gg: ASbGncsKteo4MXRFl0ZieRQ6CsHQ9zD32NEmZliAnZqTdGg+u9uDDg69actwF//+gMV
	Gzb09xDQ/U3g6znzBnOEuz6OGRl+8y2RS8MPkFN2/aEA5xG4IronAC63/mea6IyU9SmE41MyghZ
	bSunxKVHOrQDKP+8ZzBlcGDvmzcRHEgrGEFGj1hNrDSPK7LPnr3gXZyso66ld9/fhAO0aKICXKa
	SSacqfLvjQoHL9ff4tvaiV9cIUd7DmMYxVeuz+BkoGVWzlgRHkY8u8HVI6FbHPBqrNqh+GqVYWi
	0S7NWF9JhrXRZ+Uu4DZGD8oG67lD
X-Google-Smtp-Source: AGHT+IHpra8NicNX39bLjc8qG29QdCb3vJ/1EaZ3tqQYIlrU6vu2eVYCAwoAIvz2bnvNzvbnqJSOJg==
X-Received: by 2002:a05:6214:20aa:b0:6d8:7fe2:8b1e with SMTP id 6a1803df08f44-6d8e741e814mr204079766d6.48.1733823781235;
        Tue, 10 Dec 2024 01:43:01 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:43:00 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:48 +0000
Subject: [PATCH v16 12/18] media: uvcvideo: Factor out query_boundaries
 from query_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-12-e8201f7e8e57@chromium.org>
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

Split the function in two parts. queryctrl_boundaries will be used in
future patches.

No functional change expected from this patch.

Reviewed-by: Yunke Cao <yunkec@google.com>
Tested-by: Yunke Cao <yunkec@google.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 106 ++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 794d5c365352..785af382103b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1374,53 +1374,11 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
 	return ~0;
 }
 
-static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
-	struct uvc_control *ctrl,
-	struct uvc_control_mapping *mapping,
-	struct v4l2_queryctrl *v4l2_ctrl)
+static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
+				      struct uvc_control *ctrl,
+				      struct uvc_control_mapping *mapping,
+				      struct v4l2_queryctrl *v4l2_ctrl)
 {
-	struct uvc_control_mapping *master_map = NULL;
-	struct uvc_control *master_ctrl = NULL;
-
-	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
-	v4l2_ctrl->id = mapping->id;
-	v4l2_ctrl->type = mapping->v4l2_type;
-	strscpy(v4l2_ctrl->name, uvc_map_get_name(mapping),
-		sizeof(v4l2_ctrl->name));
-	v4l2_ctrl->flags = 0;
-
-	if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
-		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
-	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
-		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-
-	if (mapping->master_id)
-		__uvc_find_control(ctrl->entity, mapping->master_id,
-				   &master_map, &master_ctrl, 0, 0);
-	if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
-		s32 val;
-		int ret;
-
-		if (WARN_ON(uvc_ctrl_mapping_is_compound(master_map)))
-			return -EIO;
-
-		ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
-		if (ret < 0)
-			return ret;
-
-		if (val != mapping->master_manual)
-				v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
-	}
-
-	if (v4l2_ctrl->type >= V4L2_CTRL_COMPOUND_TYPES) {
-		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_HAS_PAYLOAD;
-		v4l2_ctrl->default_value = 0;
-		v4l2_ctrl->minimum = 0;
-		v4l2_ctrl->maximum = 0;
-		v4l2_ctrl->step = 0;
-		return 0;
-	}
-
 	if (!ctrl->cached) {
 		int ret = uvc_ctrl_populate_cache(chain, ctrl);
 		if (ret < 0)
@@ -1464,18 +1422,74 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
 		v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
+	else
+		v4l2_ctrl->minimum = 0;
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
 		v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+	else
+		v4l2_ctrl->maximum = 0;
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
 		v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
+	else
+		v4l2_ctrl->step = 0;
 
 	return 0;
 }
 
+static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
+				 struct uvc_control *ctrl,
+				 struct uvc_control_mapping *mapping,
+				 struct v4l2_queryctrl *v4l2_ctrl)
+{
+	struct uvc_control_mapping *master_map = NULL;
+	struct uvc_control *master_ctrl = NULL;
+
+	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
+	v4l2_ctrl->id = mapping->id;
+	v4l2_ctrl->type = mapping->v4l2_type;
+	strscpy(v4l2_ctrl->name, uvc_map_get_name(mapping),
+		sizeof(v4l2_ctrl->name));
+	v4l2_ctrl->flags = 0;
+
+	if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
+		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
+	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
+		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	if (mapping->master_id)
+		__uvc_find_control(ctrl->entity, mapping->master_id,
+				   &master_map, &master_ctrl, 0, 0);
+	if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
+		s32 val;
+		int ret;
+
+		if (WARN_ON(uvc_ctrl_mapping_is_compound(master_map)))
+			return -EIO;
+
+		ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
+		if (ret < 0)
+			return ret;
+
+		if (val != mapping->master_manual)
+			v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
+	}
+
+	if (v4l2_ctrl->type >= V4L2_CTRL_COMPOUND_TYPES) {
+		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_HAS_PAYLOAD;
+		v4l2_ctrl->default_value = 0;
+		v4l2_ctrl->minimum = 0;
+		v4l2_ctrl->maximum = 0;
+		v4l2_ctrl->step = 0;
+		return 0;
+	}
+
+	return __uvc_queryctrl_boundaries(chain, ctrl, mapping, v4l2_ctrl);
+}
+
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct v4l2_queryctrl *v4l2_ctrl)
 {

-- 
2.47.0.338.g60cca15819-goog



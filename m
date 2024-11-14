Return-Path: <linux-kernel+bounces-409829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24AC9C9257
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D22B2A77D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3F1B21AD;
	Thu, 14 Nov 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gqi+yGAh"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7419F42F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611460; cv=none; b=c5fPpj8U976eDkuQFrXIGP0XBCVZmmsEjtd2WbuN7XifUNK7MIcNu7hqrZ/J2poX7I9FTNvzWiTBvHy5JoF9lfHdo1ipN3cpQ6PtxUmZ1vqCSCaWIkFyK5jz0oFrUD/PvT8vLk03kANcTuQZMISTv4UX2mc/RMxwxm7G8YIXdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611460; c=relaxed/simple;
	bh=GTSzb2cA6iQFUD2LVLPdIY84kmKQY+ou4DnZ+2EhUOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4MXGeuS4Gd04CsMjL2gk/bw/Y9zwZSOXqErAAtmid6/lp96KR84GKpDftRjc1dMB9momjSHle+tqNkz44uulC54UmWlynWsHKQoWk8IdVd/kYIkSPJ8R9lSjHfVsRd2Yx05AamTJbp3VSm+Qn7XbPQGsUlWjnnzJAI+dykREII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gqi+yGAh; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d382664fadso5471226d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611457; x=1732216257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zASJkExVzt3mz1dGZGb6YpVtR37par5ZxSQfpFLGtY=;
        b=Gqi+yGAhM2LqdtHWH811XnV+hAqDqK5dwBNWbFA8SUVMz55DsV2uRyAX4qJ4VQ/Zk/
         OssuyR/KQhjnquiGC39u+FJF3jPNLWfaogRk6HyvB4cMzx60GuVwBx2YSjsACRbWuaSv
         mEUpapUskK6RkyHM4Xm1v0Mmlj6CSP8UletCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611457; x=1732216257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zASJkExVzt3mz1dGZGb6YpVtR37par5ZxSQfpFLGtY=;
        b=Cn0dimkbhqBvStVPCUAHbe24/9BXi6SN+XH/2PEgPs5gK8RsG7QExPTvhicFgbR22B
         9lL3dnSaMOUG1QTWsYOjRNsVVbsgWUZIxgDdwSTOMgtHun2A06sXUKFqKYp507i5YhDK
         EBMh2xfE8+fffLj1NPU3DPO+QpER82MZC0omnVBfj2CcvepWJVlvL2LExkMPgU0uUOLc
         AePbD41+i3PyTMMoQMNHjD+B0uspW6yKl/xejJJQHfuaHM8+a0+S0066JwV5/5GfzXrI
         tPESvfrTizIs1KpZ+6Ob9rp0ej4vFMksQkgGgXwY3yPQ29kE+iHxdlbeICdDtG8Dk+P1
         icvA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/fN/dVTjSd/j2On2jMafiaQ2AwPHFrPcKC/eJv4GGWUq/N8T/kV8SwgN57dKdiNKmkVDqQCCofXYypM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oW6HQSDsheJfq5gQ64hawyCuhTIUqDI3qgTJRpE2ODDH/jb1
	ymenfl8EOLdiXL8xhYp6IznvUzQng0MBob9qs8eULNbbQqeZibyk723R0av0Uw==
X-Google-Smtp-Source: AGHT+IFwQipG5MnSIrGPPQp4Ve+16Xv+jGuSrD7kyFyzdHnlGC/qJY1Unw7LCbkK+PWogHsT4KSLpQ==
X-Received: by 2002:a05:6214:118b:b0:6d3:dcce:a2d3 with SMTP id 6a1803df08f44-6d3dccea322mr96855556d6.47.1731611456783;
        Thu, 14 Nov 2024 11:10:56 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:10:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:41 +0000
Subject: [PATCH v15 12/19] media: uvcvideo: Factor out query_boundaries
 from query_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-12-64cfeb56b6f8@chromium.org>
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

Split the function in two parts. queryctrl_boundaries will be used in
future patches.

No functional change expected from this patch.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 106 ++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e51cd0a2228a..b591d7fddc37 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1367,53 +1367,11 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
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
@@ -1456,18 +1414,74 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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



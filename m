Return-Path: <linux-kernel+bounces-409830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341D9C923B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4445C282C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1281B392D;
	Thu, 14 Nov 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ALzoruBC"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D631B0F25
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611461; cv=none; b=C/vJzugRgHC9bAZQZ+1HqGeNWnpOG/4WnMuHBRaMBqzO78eNcs50VgxU17oatx4+ND19KSEBzGVIZa5vExmz4LUbg389E1hB7LxqaSfk+c4Qp7a+ut4/bhO6XyppG31SqGROdDe+3MLZd9/oDQLy00R40IqCAgZlck29UJdWQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611461; c=relaxed/simple;
	bh=4aYM1mbytyfhEDw5uHRi4COv7820Z421epIB62xgYEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiVMImGC8tJPcrkygiHFaqk/oFNE017fUd0kMgXpDN52N9znD8BWs1Cqt3GN61IYem49QSCBiizB7tRoTMp3SBAvxmhXPFf+Euaqrz3xM6xL+D3VW0KymAo3ppJ9CZ9cua5C1GlNHfH8Mdpz/3Iy+LJe7bDtGEY0z4x/INBbobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ALzoruBC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe3e99680so5371316d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611457; x=1732216257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8MY237UnOQ4N6VPhfi4yBpSwxWA8VpuxHQS0Imk3bI=;
        b=ALzoruBCqhIzyK0bOZD085jdLnGIFt9QThX8E1RJ6DGqnD/7dFuMeGmogBdf/TvY7K
         4JkX2v3nx8Dd1Y0flbjE8C4OS284bWzGQfh/5iNsHUcYF6NDrbF/vLAKiX3EhsuySFwl
         0wlldB1YmM6Mwa3PgA0sPDftEthJVMXuLVKic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611457; x=1732216257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8MY237UnOQ4N6VPhfi4yBpSwxWA8VpuxHQS0Imk3bI=;
        b=jvi4/eSpak4sAa2emmvPBO1pMukg8fYhKuG8CwO7wGRtA47acdpF0Z3BBTUQP6uPZx
         phzE0FHDNHFtNS/2uecEHoUPFh2cOGadHU2W/IMqe1Jjc6Rwlhi0WR0WF1VkyBCRcqHm
         F6DmS29D0rELj497JyIc3wQ/orOf3kCASzMENW4Bos6SQF8az9m5FLX6Dgh4TRDIZKFv
         XLQJf0noi241MJZTeS2uFKlK63lA/uPit4qyGw7EHoai1l1zM0H7TPNjJFnuQbaCoLKK
         c5dSYn8jLg4/uHoG1acGIO4tJ+Lyo99fGxObhAl1FiMHiGtt+o9pQ+sHrYkQ4EzO6PMd
         diDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7SjdhWSUJR/8f/QmI/2EVBZ4qjprsm9sx5OJYvN+bq4vdjNivrYYf+Ff0dZ83Hxo+UjOmD7dz9TQAEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcrspRQ21symNCq0ESIFQ4nKnuDeTY12dXN49h9vuiL5oXyW9
	S7OsQnv7kpp+H4L7P3Y8FqP135/gPtpdLiDyp85vmvZtL2P+EGr4egbfgOVZMg==
X-Google-Smtp-Source: AGHT+IHOpcHqAe4+KizmjW3hadP4zp2qAPzG6XrwFdFi5tBVwuyu9biAEH+KtWKsGqgG0uqhKgvgUA==
X-Received: by 2002:a05:6214:540e:b0:6cb:afe7:1403 with SMTP id 6a1803df08f44-6d39e2006bcmr322753126d6.48.1731611457638;
        Thu, 14 Nov 2024 11:10:57 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:10:57 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:42 +0000
Subject: [PATCH v15 13/19] media: uvcvideo: support
 V4L2_CTRL_WHICH_MIN/MAX_VAL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-13-64cfeb56b6f8@chromium.org>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Yunke Cao <yunkec@google.com>
X-Mailer: b4 0.13.0

From: Yunke Cao <yunkec@google.com>

Add support for V4L2_CTRL_WHICH_MIN/MAX_VAL in uvc driver.
It is needed for the V4L2_CID_UVC_REGION_OF_INTEREST_RECT control.

Signed-off-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 96 ++++++++++++++++++++++++++++++++--------
 drivers/media/usb/uvc/uvc_v4l2.c |  2 +
 2 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b591d7fddc37..0dae5e8c3ca0 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1270,6 +1270,37 @@ static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
 	return 0;
 }
 
+static bool uvc_ctrl_is_readable(u32 which, struct uvc_control *ctrl,
+				 struct uvc_control_mapping *mapping)
+{
+	if (which == V4L2_CTRL_WHICH_CUR_VAL)
+		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR);
+
+	if (which == V4L2_CTRL_WHICH_DEF_VAL)
+		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF);
+
+	/* Types with implicit boundaries. */
+	switch (mapping->v4l2_type) {
+	case V4L2_CTRL_TYPE_MENU:
+	case V4L2_CTRL_TYPE_BOOLEAN:
+	case V4L2_CTRL_TYPE_BUTTON:
+		return true;
+	case V4L2_CTRL_TYPE_BITMASK:
+		return (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) ||
+			(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX);
+	default:
+		break;
+	}
+
+	if (which == V4L2_CTRL_WHICH_MIN_VAL)
+		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN);
+
+	if (which == V4L2_CTRL_WHICH_MAX_VAL)
+		return !!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX);
+
+	return false;
+}
+
 /*
  * Check if control @v4l2_id can be accessed by the given control @ioctl
  * (VIDIOC_G_EXT_CTRLS, VIDIOC_TRY_EXT_CTRLS or VIDIOC_S_EXT_CTRLS).
@@ -1288,7 +1319,6 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 	struct uvc_control *master_ctrl = NULL;
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
-	bool read = ioctl == VIDIOC_G_EXT_CTRLS;
 	s32 val;
 	int ret;
 	int i;
@@ -1300,10 +1330,10 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 	if (!ctrl)
 		return -EINVAL;
 
-	if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) && read)
-		return -EACCES;
+	if (ioctl == VIDIOC_G_EXT_CTRLS)
+		return uvc_ctrl_is_readable(ctrls->which, ctrl, mapping);
 
-	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) && !read)
+	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		return -EACCES;
 
 	if (ioctl != VIDIOC_S_EXT_CTRLS || !mapping->master_id)
@@ -1451,6 +1481,9 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) &&
+	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN))
+		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX;
 
 	if (mapping->master_id)
 		__uvc_find_control(ctrl->entity, mapping->master_id,
@@ -2037,16 +2070,18 @@ static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
 
 	switch (which) {
 	case V4L2_CTRL_WHICH_CUR_VAL:
-		ret = __uvc_ctrl_load_cur(chain, ctrl);
-		if (ret < 0)
-			return ret;
 		id = UVC_CTRL_DATA_CURRENT;
 		query = UVC_GET_CUR;
 		break;
+	case V4L2_CTRL_WHICH_MIN_VAL:
+		id = UVC_CTRL_DATA_MIN;
+		query = UVC_GET_MIN;
+		break;
+	case V4L2_CTRL_WHICH_MAX_VAL:
+		id = UVC_CTRL_DATA_MAX;
+		query = UVC_GET_MAX;
+		break;
 	case V4L2_CTRL_WHICH_DEF_VAL:
-		ret = uvc_ctrl_populate_cache(chain, ctrl);
-		if (ret < 0)
-			return ret;
 		id = UVC_CTRL_DATA_DEF;
 		query = UVC_GET_DEF;
 		break;
@@ -2064,6 +2099,14 @@ static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
 	if (!data)
 		return -ENOMEM;
 
+	if (which == V4L2_CTRL_WHICH_CUR_VAL)
+		ret = __uvc_ctrl_load_cur(chain, ctrl);
+	else
+		ret = uvc_ctrl_populate_cache(chain, ctrl);
+
+	if (ret < 0)
+		return ret;
+
 	ret = mapping->get(mapping, query, uvc_ctrl_data(ctrl, id), size, data);
 	if (ret < 0)
 		return ret;
@@ -2076,22 +2119,37 @@ static int uvc_mapping_get_xctrl_std(struct uvc_video_chain *chain,
 				     struct uvc_control_mapping *mapping,
 				     u32 which, struct v4l2_ext_control *xctrl)
 {
+	struct v4l2_queryctrl qc;
+	int ret;
+
 	switch (which) {
 	case V4L2_CTRL_WHICH_CUR_VAL:
 		return __uvc_ctrl_get(chain, ctrl, mapping, &xctrl->value);
 	case V4L2_CTRL_WHICH_DEF_VAL:
-		if (!ctrl->cached) {
-			int ret = uvc_ctrl_populate_cache(chain, ctrl);
+	case V4L2_CTRL_WHICH_MIN_VAL:
+	case V4L2_CTRL_WHICH_MAX_VAL:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-			if (ret < 0)
-				return ret;
-		}
-		xctrl->value = uvc_mapping_get_s32(mapping, UVC_GET_DEF,
-						   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
-		return 0;
+	ret = __uvc_queryctrl_boundaries(chain, ctrl, mapping, &qc);
+	if (ret < 0)
+		return ret;
+
+	switch (which) {
+	case V4L2_CTRL_WHICH_DEF_VAL:
+		xctrl->value = qc.default_value;
+		break;
+	case V4L2_CTRL_WHICH_MIN_VAL:
+		xctrl->value = qc.minimum;
+		break;
+	case V4L2_CTRL_WHICH_MAX_VAL:
+		xctrl->value = qc.maximum;
+		break;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static int uvc_mapping_get_xctrl(struct uvc_video_chain *chain,
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 65dbb53b1e75..7e284770149d 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1087,6 +1087,8 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 	switch (ctrls->which) {
 	case V4L2_CTRL_WHICH_DEF_VAL:
 	case V4L2_CTRL_WHICH_CUR_VAL:
+	case V4L2_CTRL_WHICH_MAX_VAL:
+	case V4L2_CTRL_WHICH_MIN_VAL:
 		which = ctrls->which;
 		break;
 	default:

-- 
2.47.0.338.g60cca15819-goog



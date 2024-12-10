Return-Path: <linux-kernel+bounces-439261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC3F9EACD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF75161269
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9D225408;
	Tue, 10 Dec 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxXFqYYo"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866032500A8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823786; cv=none; b=OL0bwcZOdwvFDbNX1dS17pVroi5DK74P4y8FniejluHaYoz8fr6YTvIiLjMEuQC9sNAz4VOj1j3Jw1SpY9nILZN4K7dTM9Rsb40CDaLJZDuViUafrdOYUyX2PsqQ/EJgwQZapSDzze68mvwlJCPq9BvNPVPx2M51NlbSHEBRbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823786; c=relaxed/simple;
	bh=yqji/xzHYuOsoD1S6Hj7O2pucPqwN31k/pN+iJwwrO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJzDQ7xssgDBBfVhuja+fccF7Yb91LOOAspVWJyiDo2OvcLdJE8OKhvJr2Sf4s6kdko7WaUOo0yhiRCOPqgZBIZRbaIHuGClQzDL6elfnHuaXcmymB+TBMXF/w5dy3vFzRVEXLqoc6Mvg3owRjyvW0Ceid0YlLyJAoZwUHloihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxXFqYYo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so23145266d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823783; x=1734428583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4DLEGpbxISaKGwkcSnN6qP20jbOjfnGAGZ1UU5NuHw=;
        b=bxXFqYYoqvjs5zW7e4ZRCQ/k4PuhewxRGQKvY+oXka+LKcTijAqk4YXRg7VKky9gjb
         3iDRnTuzjl4716iI1vo+HJGFVb6phuQUsuLgbPSdivtp3be9Xd5KJP0bJz4HAWloMXfL
         J91+4uKvkFHvwJSYRC65t2nnQG5via4HM7RXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823783; x=1734428583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4DLEGpbxISaKGwkcSnN6qP20jbOjfnGAGZ1UU5NuHw=;
        b=ptH/3DITMS+4QiYewt292lvAA+bt4r2r92XOrHG0dZQZ4r3JH3VWg2ZjTZAGaadA2K
         HfqXFKTzbNwPEdc7BoI+5yZRQMWZPZ0bvb3UPs6bHu2Of8/3laqkP5C5rUH/QhKJn1c2
         BdE4+4/QzEhKdatoBGA+EnGWHnPj54+Z/r91OAUZNpEPUBvFjuRfaM5wWZQwczDcXjWg
         pVKKAaGJu0c/oThyxdF+b5VU2Seh/bJ4CXVdRsD945icoqBLsKndGpJ/YwACNAAX1ihy
         9/gbJ2swKpdFrBxBPjVFZ9WjMDWjr65lwP6r8tNvFgAGSegHcv8VifcHZTfSA4Bre4A/
         oo1g==
X-Forwarded-Encrypted: i=1; AJvYcCWVNmyF5296+Fgb88HO+tuIceRCZtWYzBPzWmRhjDDAd2AbnvF//30duUpLl27zirBJKGzsTUz5hdd3H70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpbbA6ys63RWSFtuFTHsv7P1VG7yKUXVOGupsm8gEpb11vfTx
	oFnfDuKLxdTGxuYhGVyYWM7UuR3HPEK6Jibe/Af1G0QsMdGhQMWEh38IIZVGcw==
X-Gm-Gg: ASbGncuAjbNdVPEl53AITjfIsYutwZr0+yWygNpXF/TX2+G4idAujzkVD0zXzY+4fvQ
	Rxzd1jXgQZ5zGhYdWYKWiVrsfXdl3AtmuqKK0D7GrxwG9gT8pX0Vu8/T+NYDV7xHmNLsVI5GIGP
	iLUQ6R2eZ1U0jAa0iDABANfVIyVWtTVqG86t5gxYlu91ZNRf4oP9yEwUxxgB+GX6NmuJsm4KOd6
	Csc66DfGx5TbIPODJ+6fXhxrkW/c5zYFiFM19ZFBzuiHBv/K3dtPfxV916V+yleZUMDpjEMPdjJ
	fGz9YueYXewoTEwRFYTQmd3XQLFZ
X-Google-Smtp-Source: AGHT+IGDLwVPsYRL6IYDVi5Q+ZWF5oyLjYiYvYAuxK4fkpF2rSBiWjqmp7rVZEHZCpZBZUq7IJEJPQ==
X-Received: by 2002:a05:6214:e6b:b0:6d8:848e:76c8 with SMTP id 6a1803df08f44-6d91e442686mr68091406d6.42.1733823783400;
        Tue, 10 Dec 2024 01:43:03 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:43:02 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:50 +0000
Subject: [PATCH v16 14/18] media: uvcvideo: let v4l2_query_v4l2_ctrl() work
 with v4l2_query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-14-e8201f7e8e57@chromium.org>
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

v4l2_query_ext_ctrl contains information that is missing in
v4l2_queryctrl, like elem_size and elems.

With this change we can handle all the element_size information inside
uvc_ctrl.c.

Now that we are at it, remove the memset of the reserved fields, the
v4l2 ioctl handler should do that for us.

There is no functional change expected from this change.

Reviewed-by: Yunke Cao <yunkec@google.com>
Tested-by: Yunke Cao <yunkec@google.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 24 ++++++++++++++----------
 drivers/media/usb/uvc/uvc_v4l2.c | 35 +++++++++++++++--------------------
 drivers/media/usb/uvc/uvcvideo.h |  2 +-
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 14aa9619fbf1..58bd42191f3e 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1259,7 +1259,8 @@ static int __uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
 }
 
 static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
-				u32 found_id, struct v4l2_queryctrl *v4l2_ctrl)
+				u32 found_id,
+				struct v4l2_query_ext_ctrl *v4l2_ctrl)
 {
 	int idx;
 
@@ -1407,7 +1408,7 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
 static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 				      struct uvc_control *ctrl,
 				      struct uvc_control_mapping *mapping,
-				      struct v4l2_queryctrl *v4l2_ctrl)
+				      struct v4l2_query_ext_ctrl *v4l2_ctrl)
 {
 	if (!ctrl->cached) {
 		int ret = uvc_ctrl_populate_cache(chain, ctrl);
@@ -1473,7 +1474,7 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 				 struct uvc_control *ctrl,
 				 struct uvc_control_mapping *mapping,
-				 struct v4l2_queryctrl *v4l2_ctrl)
+				 struct v4l2_query_ext_ctrl *v4l2_ctrl)
 {
 	struct uvc_control_mapping *master_map = NULL;
 	struct uvc_control *master_ctrl = NULL;
@@ -1511,6 +1512,9 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 			v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
 	}
 
+	v4l2_ctrl->elem_size = sizeof(s32);
+	v4l2_ctrl->elems = 1;
+
 	if (v4l2_ctrl->type >= V4L2_CTRL_COMPOUND_TYPES) {
 		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_HAS_PAYLOAD;
 		v4l2_ctrl->default_value = 0;
@@ -1524,7 +1528,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 }
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
-	struct v4l2_queryctrl *v4l2_ctrl)
+			struct v4l2_query_ext_ctrl *v4l2_ctrl)
 {
 	struct uvc_control *ctrl;
 	struct uvc_control_mapping *mapping;
@@ -1650,7 +1654,7 @@ static void uvc_ctrl_fill_event(struct uvc_video_chain *chain,
 	struct uvc_control_mapping *mapping,
 	s32 value, u32 changes)
 {
-	struct v4l2_queryctrl v4l2_ctrl;
+	struct v4l2_query_ext_ctrl v4l2_ctrl;
 
 	__uvc_query_v4l2_ctrl(chain, ctrl, mapping, &v4l2_ctrl);
 
@@ -2132,7 +2136,7 @@ static int uvc_mapping_get_xctrl_std(struct uvc_video_chain *chain,
 				     struct uvc_control_mapping *mapping,
 				     u32 which, struct v4l2_ext_control *xctrl)
 {
-	struct v4l2_queryctrl qc;
+	struct v4l2_query_ext_ctrl qec;
 	int ret;
 
 	switch (which) {
@@ -2146,19 +2150,19 @@ static int uvc_mapping_get_xctrl_std(struct uvc_video_chain *chain,
 		return -EINVAL;
 	}
 
-	ret = __uvc_queryctrl_boundaries(chain, ctrl, mapping, &qc);
+	ret = __uvc_queryctrl_boundaries(chain, ctrl, mapping, &qec);
 	if (ret < 0)
 		return ret;
 
 	switch (which) {
 	case V4L2_CTRL_WHICH_DEF_VAL:
-		xctrl->value = qc.default_value;
+		xctrl->value = qec.default_value;
 		break;
 	case V4L2_CTRL_WHICH_MIN_VAL:
-		xctrl->value = qc.minimum;
+		xctrl->value = qec.minimum;
 		break;
 	case V4L2_CTRL_WHICH_MAX_VAL:
-		xctrl->value = qc.maximum;
+		xctrl->value = qec.maximum;
 		break;
 	}
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 7e284770149d..5000c74271e0 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1014,40 +1014,35 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 	return ret;
 }
 
-static int uvc_ioctl_queryctrl(struct file *file, void *fh,
-			       struct v4l2_queryctrl *qc)
+static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
+				    struct v4l2_query_ext_ctrl *qec)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
 
-	return uvc_query_v4l2_ctrl(chain, qc);
+	return uvc_query_v4l2_ctrl(chain, qec);
 }
 
-static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
-				    struct v4l2_query_ext_ctrl *qec)
+static int uvc_ioctl_queryctrl(struct file *file, void *fh,
+			       struct v4l2_queryctrl *qc)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
-	struct v4l2_queryctrl qc = { qec->id };
+	struct v4l2_query_ext_ctrl qec = { qc->id };
 	int ret;
 
-	ret = uvc_query_v4l2_ctrl(chain, &qc);
+	ret = uvc_query_v4l2_ctrl(chain, &qec);
 	if (ret)
 		return ret;
 
-	qec->id = qc.id;
-	qec->type = qc.type;
-	strscpy(qec->name, qc.name, sizeof(qec->name));
-	qec->minimum = qc.minimum;
-	qec->maximum = qc.maximum;
-	qec->step = qc.step;
-	qec->default_value = qc.default_value;
-	qec->flags = qc.flags;
-	qec->elem_size = 4;
-	qec->elems = 1;
-	qec->nr_of_dims = 0;
-	memset(qec->dims, 0, sizeof(qec->dims));
-	memset(qec->reserved, 0, sizeof(qec->reserved));
+	qc->id = qec.id;
+	qc->type = qec.type;
+	strscpy(qc->name, qec.name, sizeof(qc->name));
+	qc->minimum = qec.minimum;
+	qc->maximum = qec.maximum;
+	qc->step = qec.step;
+	qc->default_value = qec.default_value;
+	qc->flags = qec.flags;
 
 	return 0;
 }
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index f429f325433b..8aca1a2fe587 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -766,7 +766,7 @@ void uvc_status_put(struct uvc_device *dev);
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
-			struct v4l2_queryctrl *v4l2_ctrl);
+			struct v4l2_query_ext_ctrl *v4l2_ctrl);
 int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 			struct v4l2_querymenu *query_menu);
 

-- 
2.47.0.338.g60cca15819-goog



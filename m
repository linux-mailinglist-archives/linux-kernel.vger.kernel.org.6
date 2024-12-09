Return-Path: <linux-kernel+bounces-438294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514369E9F76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048A418837F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188F1991BF;
	Mon,  9 Dec 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eDl8YVIC"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C0197A68
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772338; cv=none; b=hTbzBP8ioaOPx1M/K9xwguHI9/JsLa3JRY8iI+EbkcXS2BsuQ5uFeRe6sEkEeuIgiPXRnQXD9Vu7d7mSG05uJbTcMYARpT6rbFMgXKkjlA/+wpG5d6xrzYlWHEw2WHvW4soP8XsQjmXWVCGjx4LvjdLrbLCIRpXp6q76sszL+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772338; c=relaxed/simple;
	bh=EY8oqmKTiUV81iDV12LiEs5fxLsbZtTGDuxYmfLNCp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbmrdbOGzrlv2Gaf3uuLzrrte+ASlwVINOorX74PSGY+Z13iNkkHQjqIxPqWoRJivSbJuWIN9esWy0Dk2TaCHtPhdsYLajXyRl2tYJ7H314dZFn/IJYVyEw8nQpw3hioO7baAn2EX/AOFwyK8li82rn7AsowAQq4MeyOU9fSnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eDl8YVIC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d888c38841so37742336d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772335; x=1734377135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALuCNiC6NiBbAaZWJ7ZF+lCNq8dvy5S4QphoAjogwrE=;
        b=eDl8YVICjG0HdP+oStEBU76cEvD73LNGZQr4bUC3PDPQJmWs7MzS8TFDsg/zZuBS5j
         yYuDMdi5DgpjIQ/0YWuz6/Bl3DagroPNpJyjVOQ4E6Ip7/B1MMSGcCH+uuPFoxVarOGt
         Cb0J8FRa92vYKcg0Yi1HDY8Zf92Bpn/xFfOxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772335; x=1734377135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALuCNiC6NiBbAaZWJ7ZF+lCNq8dvy5S4QphoAjogwrE=;
        b=JR7E9Z1CFKjNv4iMVXa3Dt1quxvE1MyLxTWTTCD+JEILSnEu0RpRAqIGAEnfdU5UlD
         tkUeV43D7rW+67D9bEeZHP4inNGSVjNHOL7qNv45tmGHlwTq6rOrCB1OENhDIhWP7t54
         0+2WC9iHF7PqT4x6A/xjJiIffCQ1yuNpo9K5shAXlJ1sNWGeIEAcwRrf4OwvbxzzvULm
         e/fAgCnSNX7aszs4npenCzc9NABSq0gvAY9bquc4degDD0Gv+t5DNpTudmO6kOvOM1/A
         g+Xv9O5+LNpgb+1WSbTLKiaK9mqba0g07QWzpmabroiUiSGnRUXG0lNsBKJi3kAGJInu
         TeLw==
X-Forwarded-Encrypted: i=1; AJvYcCWvdLYGRB2fVtMXvXUgWYXNuWfwGiGlZ71tOU+a260fBmy/JjxodZCOMbhEjK+ojtkpYC0o+yJ6beNXn6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHVOFSXd6V7fD9rrf8ZpegPVWzpArvDq7xfO0ajngLIYfrmc53
	4zBu1Wqfd5196CRUoYvcYrddeO0rzCoGnl3Y2laVJ2m+1HybhJrvpDgFCI4cUw==
X-Gm-Gg: ASbGnctiIEOj9Mo2AHb+ofOsaf+wo7ZzMnOBIf34P22yfMy/WXGGjUaXEssQnBIyAFf
	jSrzEdU16a6abkWu0boEvP8bwqcWFRjUOdk1CcSbV1NhoFqh83fZSkRnls8Y8qp6P/5x2pWU+iz
	GOdazKt5bsBbMkrIqZmvVyGLjqJuw3FlmTHbjPfWccYNAg0Srs7Vf0cIDaUQEdJU4E8YALETYIn
	CRM3qsr/POfR6PMDsyoCwvbq4H5nUTWh2VioObfQmly2J8ybJh1eddw1wZMGUl1b75woerDbw6J
	0dUV9/w5Lla5OnRApRZtrqGS
X-Google-Smtp-Source: AGHT+IHsk+VHbWui+xY2odwllC141usB+LpKAHlP2mMq7yUmbaK9+La1b1tTbukiapbv37JDSVTxrw==
X-Received: by 2002:a05:6214:5086:b0:6d8:9002:bde2 with SMTP id 6a1803df08f44-6d8e71a8c8fmr234897486d6.28.1733772335566;
        Mon, 09 Dec 2024 11:25:35 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:35 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:32 +0000
Subject: [PATCH 01/10] media: ioctl: Simulate v4l2_queryctrl with
 v4l2_query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-1-deff7acfcdcb@chromium.org>
References: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
In-Reply-To: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

v4l2_queryctrl is a subset of v4l2_query_ext_ctrl. If the driver does
not implement v4l2_queryctrl we can implement it with
v4l2_query_ext_ctrl.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-dev.c   |  3 ++-
 drivers/media/v4l2-core/v4l2-ioctl.c | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 5bcaeeba4d09..252308a67fa8 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -572,7 +572,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
 	   and that can't be tested here. If the bit for these control ioctls
 	   is set, then the ioctl is valid. But if it is 0, then it can still
 	   be valid if the filehandle passed the control handler. */
-	if (vdev->ctrl_handler || ops->vidioc_queryctrl)
+	if (vdev->ctrl_handler || ops->vidioc_queryctrl ||
+	    ops->vidioc_query_ext_ctrl)
 		__set_bit(_IOC_NR(VIDIOC_QUERYCTRL), valid_ioctls);
 	if (vdev->ctrl_handler || ops->vidioc_query_ext_ctrl)
 		__set_bit(_IOC_NR(VIDIOC_QUERY_EXT_CTRL), valid_ioctls);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 0304daa8471d..a5562f2f1fc9 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2284,9 +2284,11 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
 	struct video_device *vfd = video_devdata(file);
+	struct v4l2_query_ext_ctrl qec;
 	struct v4l2_queryctrl *p = arg;
 	struct v4l2_fh *vfh =
 		test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
+	int ret;
 
 	if (vfh && vfh->ctrl_handler)
 		return v4l2_queryctrl(vfh->ctrl_handler, p);
@@ -2294,7 +2296,25 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
 		return v4l2_queryctrl(vfd->ctrl_handler, p);
 	if (ops->vidioc_queryctrl)
 		return ops->vidioc_queryctrl(file, fh, p);
-	return -ENOTTY;
+	if (!ops->vidioc_query_ext_ctrl)
+		return -ENOTTY;
+
+	/* Simulate query_ext_ctr using query_ctrl. */
+	qec.id = p->id;
+	ret = ops->vidioc_query_ext_ctrl(file, fh, &qec);
+	if (ret)
+		return ret;
+
+	p->id = qec.id;
+	p->type = qec.type;
+	strscpy(p->name, qec.name, sizeof(p->name));
+	p->minimum = qec.minimum;
+	p->maximum = qec.maximum;
+	p->step = qec.step;
+	p->default_value = qec.default_value;
+	p->flags = qec.flags;
+
+	return 0;
 }
 
 static int v4l_query_ext_ctrl(const struct v4l2_ioctl_ops *ops,

-- 
2.47.0.338.g60cca15819-goog



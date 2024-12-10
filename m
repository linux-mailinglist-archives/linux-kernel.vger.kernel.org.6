Return-Path: <linux-kernel+bounces-439186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F239EAC02
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B28163CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057983DAC07;
	Tue, 10 Dec 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iGAU9YjD"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9402500A9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822933; cv=none; b=ojgZRNKawyBkcOMVE638AEnQ1SNQ0K3pVL0q/E0p3yn+FOsLc6TwFRqEhSshqHax8Tt/fGXtFOWo7wpAPVo6p9zvJGVjK8RFnNQI1bWWDIjtTVaaGnZwSThCMVBR+JkWKVbTf8lu10N89f1x8F3d5U7mNOya+JAtqfweEBllUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822933; c=relaxed/simple;
	bh=5tAoo54TU4GQ4hW7pLNn7ok6ge350p6usP0YhXYzePE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVvaYWpZzYBc8TK41zfQG+antZP2kRNE2JFfgSUq8SWJcbU+hXahoe7Dw8wYm+sF+uxIN+BbL1OnTcxF1Umvpc90UjLLFQ5avSZntnbPEeUWIWSiUdc8CXc5+OktF5GpfLCmK/b5MjTVVmntrSg82kyNlSXIJurVlBKV/SuyQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iGAU9YjD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46769b34cbfso23528501cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822930; x=1734427730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjCxwHlk//pWYcvx6fmU+J931W36lgHNKb5tiH7Iy4s=;
        b=iGAU9YjDnIzXhrbyfzJLjzDnmsRh8lJ5huF7tkIVtqpjn0M7q7m98qPbyOHaHnT9M+
         cXaIIgVffgqFTcxqwaSXwNkntAzMM+Alr8zMW4MZBlWWT8zeIyAMOeSEWkFWLI6uG4Cr
         oO70sgvAUcTTItRfEHqtAJQLWq59K+uPVxOeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822930; x=1734427730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjCxwHlk//pWYcvx6fmU+J931W36lgHNKb5tiH7Iy4s=;
        b=lfrfCTm9OCRuJXzonb1D/LXqPkvJDmwC1AZVvALTqp/PRECdiNWV1SLZUeaBLxMRmr
         T4DmSdw3lEBBl2KiGgSJeu2KLlLI2+hcOu0JM0E85RG9fW6c4WUtdkFHMbmgKdvDQukn
         zMdnWhLMFJFm2sQiuHng23QWaiIZxFW8Uh2DB+4BwaY8VWXK7q6GFdS+Zl8EFX6Paafc
         uJw54C1zjmJk/rBiVSdxlXbyQ6aiBbi2Ptov0t8v4MBHrQ8CZ9MZtu+8Usl1C7zF2gHe
         fLQcMSrJ2xk7TElXsXQNhxDKW0UPqja22Xi/btNfex8wDnLsUhl5OqxQWdjF13WCCp81
         Tuxg==
X-Forwarded-Encrypted: i=1; AJvYcCWrrOtm7gG65X2rikkr7dbKBO/lFlTw2iVfWRUew7sYc7Ima16W3CW5ayrNawmJi1i2I7zg6NPfYeL2YMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+qBTQsNHd9BbmukYfvbJ04mh6Gp5wh3XqBPUDnT55cfdcJuU
	wWRfwUU7VGg9/l9GV2JiUK1RGnbaw1UOvi8RH6fIMG6ryolbLhfzz2JWQ31UiA==
X-Gm-Gg: ASbGncu4XgpBwsKncJk5C4ZqD2EKr9pIMNvps7/m4iU886WPXPZIV0sSjVQd2BsuxhN
	vd5slacsu8wl9GijXgASwTKp7S4tanv/IS+LUdaV/ztWvbl9/qCvvjFWzX+w4j8yoOFp/GGpAew
	KFj3vJgUozVdateUkYQ/uz4iqtKryA9AtF6Z0PlM0xLHnj2EN2zgMOGwe+K8LbT52abXTS3oz2k
	e9nzFqhCYLGZTFha3jV2ZediXfUItbGkQC88diN2OYHAJHinJsJQIuLEGZdnf6MNLwyJdHoLSKt
	lZJXUmTLxqJcPlPFSpQRs1/n6L24
X-Google-Smtp-Source: AGHT+IHlEaOPjN93sA8cjSBRqg2/WMxOoAfLZHozJqTzhAKHeUhuWeLsI2/xEgcPjttaJynBP3QLKg==
X-Received: by 2002:ac8:59c5:0:b0:466:a06f:ae0a with SMTP id d75a77b69052e-46771f5b0bamr69413111cf.32.1733822930286;
        Tue, 10 Dec 2024 01:28:50 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:28:49 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:45 +0000
Subject: [PATCH v2 01/11] media: ioctl: Simulate v4l2_queryctrl with
 v4l2_query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-1-c0a33d69f416@chromium.org>
References: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
In-Reply-To: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
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
 drivers/media/v4l2-core/v4l2-ioctl.c | 37 +++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

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
index 0304daa8471d..7d615ebc511e 100644
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
@@ -2294,7 +2296,40 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
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
+	p->flags = qec.flags;
+	strscpy(p->name, qec.name, sizeof(p->name));
+	switch (p->type) {
+	case V4L2_CTRL_TYPE_INTEGER:
+	case V4L2_CTRL_TYPE_BOOLEAN:
+	case V4L2_CTRL_TYPE_MENU:
+	case V4L2_CTRL_TYPE_INTEGER_MENU:
+	case V4L2_CTRL_TYPE_STRING:
+	case V4L2_CTRL_TYPE_BITMASK:
+		p->minimum = qec.minimum;
+		p->maximum = qec.maximum;
+		p->step = qec.step;
+		p->default_value = qec.default_value;
+		break;
+	default:
+		p->minimum = 0;
+		p->maximum = 0;
+		p->step = 0;
+		p->default_value = 0;
+		break;
+	}
+
+	return 0;
 }
 
 static int v4l_query_ext_ctrl(const struct v4l2_ioctl_ops *ops,

-- 
2.47.0.338.g60cca15819-goog



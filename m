Return-Path: <linux-kernel+bounces-225894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FD09136FB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528BC1F23861
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669912D775;
	Sat, 22 Jun 2024 23:48:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846412B148
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719100126; cv=none; b=m5aRZ+SwaEEdWxsU38afPuunuAcYSM1iyKsUIARMQj1V7rFOz9csDUUgJEDcB1jE/cUGExQMHZPAp2cDlHalSsl8YO+5aPUDPFEUV342FU7hWHAKBc8YwppU8r/On2eIMj5ZKYaM4bRp2Aq/7Snkt/XnMOmA1kIsTmvVLtgeQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719100126; c=relaxed/simple;
	bh=LBZuX0Ga+lPp0ZoDeMqKbgnd7nk7N/KSSAGb3NNcxPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEl6gZuWkXjla/FwDorgQDbJFnQIlS8etU61M/Mwz7fLkv+JftNKKD+wNe/a6c65AwuirhE56OYwEHs46tQ5zbo+J6nr45BAFMjkGbCm68HrQmozViCxjYlo3QwyxT/+08WBeKmtvJz5DXwCFFhlt5VGb+0WuBvWk44Cqk6loSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATD-0002ch-5F; Sun, 23 Jun 2024 01:48:35 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-004Hkd-Hh; Sun, 23 Jun 2024 01:48:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-000IWx-36;
	Sun, 23 Jun 2024 01:48:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 23 Jun 2024 01:48:30 +0200
Subject: [PATCH v2 2/3] usb: gadget: uvc: add g_parm and s_parm for frame
 interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v2-2-12690f7a2eff@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=LBZuX0Ga+lPp0ZoDeMqKbgnd7nk7N/KSSAGb3NNcxPs=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmd2LRwyaHGG9bQWJsOYA3ksoti8y/7qKzFpIme
 VuhGLRug6CJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZndi0QAKCRC/aVhE+XH0
 q+PaD/0c1flE0NngA6ghPiONXKDLdXKXZyYl9SfjUOsHfkmcQXG06sQHL6fx31YFTmqJ6N1Vi6j
 QGZuZMGwjn1I9/tG3aT68zkqr6tiD5R/S0Re5jiPS4vsNMmgnfrBe0HVss8r2AILDwr476u9mdu
 N1NjG6Bir5LEQmghWi5bM/LOatCaak4f8VsWmgGZqveBG5/kObwRMVg8NZ0w7lNt7uEP0HS1+pS
 xAKGMrZVXeBZLxLQL4heSqxUa9l8nKMBzY+ToVKDXL9uCnKmLnkswCuMFNemK+U2Cs0MvHQVB2a
 6jcwkGMyafDcXui+C+MpzPps5aottIX3ScpVzdjU5/zAmIIBN6cu2/7PNFRD4N3oFyeWDwaDDuv
 oIIjHFU1pZ66oOV+u2kft6+yFB+SREIrgfcfZzQUUWotqVqn6dqSRt3NlBwDmPOaZwXp2I4CmBX
 ipnNi8uvzG+zaihL0DKqdZ10SoDJ/lHAKmQVnJyBQSk+b28rndZqGqekPv2Qg/IgYRg7CvBYwBQ
 ie/oLzfMed6TpVVsfkf8w/8c8WA05MFM6pg9Q4T0UkhMMvKV9bgRonV/t7q2nzp1KXrQiZ+fnGD
 JR2/C+lr0MN4lz5tVBjmneE5sh4Sg7r6iO7NX4W9qA1GgDw0YmU8HXvzjwT7loCtJDWMiXaTEF3
 WJQ86Ah/q6O/eUA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The uvc gadget driver is lacking the information which frame interval
was set by the host. We add this information by implementing the g_parm
and s_parm callbacks.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v1 -> v2: -
---
 drivers/usb/gadget/function/uvc.h      |  1 +
 drivers/usb/gadget/function/uvc_v4l2.c | 52 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index cb35687b11e7e..d153bd9e35e31 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -97,6 +97,7 @@ struct uvc_video {
 	unsigned int width;
 	unsigned int height;
 	unsigned int imagesize;
+	unsigned int interval;
 	struct mutex mutex;	/* protects frame parameters */
 
 	unsigned int uvc_num_requests;
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a024aecb76dc3..5b579ec1f5040 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -307,6 +307,56 @@ uvc_v4l2_set_format(struct file *file, void *fh, struct v4l2_format *fmt)
 	return ret;
 }
 
+static int uvc_v4l2_g_parm(struct file *file, void *fh,
+			    struct v4l2_streamparm *parm)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct uvc_device *uvc = video_get_drvdata(vdev);
+	struct uvc_video *video = &uvc->video;
+	struct v4l2_fract timeperframe;
+
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	/* Return the actual frame period. */
+	timeperframe.numerator = video->interval;
+	timeperframe.denominator = 10000000;
+	v4l2_simplify_fraction(&timeperframe.numerator,
+		&timeperframe.denominator, 8, 333);
+
+	uvcg_dbg(&uvc->func, "Getting frame interval of %u/%u (%u)\n",
+		timeperframe.numerator, timeperframe.denominator,
+		video->interval);
+
+	parm->parm.output.timeperframe = timeperframe;
+	parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+
+	return 0;
+}
+
+static int uvc_v4l2_s_parm(struct file *file, void *fh,
+			    struct v4l2_streamparm *parm)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct uvc_device *uvc = video_get_drvdata(vdev);
+	struct uvc_video *video = &uvc->video;
+	struct v4l2_fract timeperframe;
+
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	timeperframe = parm->parm.output.timeperframe;
+
+	video->interval = v4l2_fraction_to_interval(timeperframe.numerator,
+		timeperframe.denominator);
+
+	uvcg_dbg(&uvc->func, "Setting frame interval to %u/%u (%u)\n",
+		timeperframe.numerator, timeperframe.denominator,
+		video->interval);
+
+	return 0;
+}
+
 static int
 uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
 		struct v4l2_frmivalenum *fival)
@@ -577,6 +627,8 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops = {
 	.vidioc_dqbuf = uvc_v4l2_dqbuf,
 	.vidioc_streamon = uvc_v4l2_streamon,
 	.vidioc_streamoff = uvc_v4l2_streamoff,
+	.vidioc_s_parm = uvc_v4l2_s_parm,
+	.vidioc_g_parm = uvc_v4l2_g_parm,
 	.vidioc_subscribe_event = uvc_v4l2_subscribe_event,
 	.vidioc_unsubscribe_event = uvc_v4l2_unsubscribe_event,
 	.vidioc_default = uvc_v4l2_ioctl_default,

-- 
2.39.2



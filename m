Return-Path: <linux-kernel+bounces-341166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54615987BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5E4283021
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EFB1B2ED7;
	Thu, 26 Sep 2024 23:37:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834111B07BD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393875; cv=none; b=tLY1rgGCh/IrVHtdX4Ct73UbUJ70CAQsSicLo0dbkY3qzfUOC2VRKfnOLI58ypMUcKjpAYICs0UWmfXkrcB6yWvYt4AVyRQfSw6enlYSGaagxAtrhSg61uSQvwNuhQVVcnlOf/tDSaflKtn0mBr1LwqJr58LfJ818lJAqbAqXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393875; c=relaxed/simple;
	bh=OotUQNt61dUhnjWyZkFcz575ktiMrhwQHmq4WSJYwik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J19iTgtzxFBlYN1uB012Fe7n+YXZrdK5IAAnpDEw9s5rGtlmrD4fe/QxPZ2K7g94o2+MtG5OKyPt9CbmMuuzVqBUQvu23ayYrhg5dFSY42xIhYxvOXMY2jABMZZWeFuL+Cq02XBAvoF42pPqDxMiPllxrnlC9g2Wxe3DYAe1wdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-0007WL-WB; Fri, 27 Sep 2024 01:37:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-001nOV-EF; Fri, 27 Sep 2024 01:37:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3L-005IAz-2v;
	Fri, 27 Sep 2024 01:37:44 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 27 Sep 2024 01:37:43 +0200
Subject: [PATCH v5 4/9] usb: gadget: uvc: add g_parm and s_parm for frame
 interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v5-4-2de78794365c@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4046;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=OotUQNt61dUhnjWyZkFcz575ktiMrhwQHmq4WSJYwik=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm9fBF5sLFiUig04zxmxDqsZpgmFxx3UaagU91L
 cMka02T8i6JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvXwRQAKCRC/aVhE+XH0
 qxpgEACFupnEpDtrjVG+Ks0+5kJPrTbpf68trEWWVS3PVmxQJ23fHUgUHq9mdnbXNqlI6IxRd48
 +J4p3Coh5Sv1cZazyw52RV+aeEHOu2PjR2OCWpdH0BJZwBvM8RhB2a3Ysubzquo+CJR8enQ5yt/
 LIZO3BlKJpvJ5yXUkQ7m2ORVQTCExHheTFbJ5J7/fsxo01RqkH9APrTlR18m4M/9fTGKo6ek7G+
 QLxXucSBD0k83dvedu94akU9FOcmCT2p4DjVTl5yRuDI77i2RhPueTfDcl1k0nsSOiOKqvu+cgJ
 SbKGIoqo7ePQDBMt7nMP5E0j1MvskZXbD/GjhsnfjL891QQmLvs+cr2lOIAYa14YSEffni5WChB
 dOP1kjaSxoFU1ENlnGUcXEOK+l1bHSWk8oa3EwrrK6m0qXjukhcurM/06RzaXM8/B/XHU/XHols
 Zp40BDGozg/mNriCDuHUhaywNPaoCrN2Zyw26spoa8yrtj2HjH0v6tVP1f0+HYTKPRDyYUgP+st
 iKCla3wtlZJbokfMx9ZwEvGatRcBLIbL5Jn5KMKqV/96WCP8dM5T0Uje+ixaHw3BayVBxLu8Oym
 24tK+TZf63VxpqksuzhztytIPCePqXYczBjmPimC2NC9/H4PunK+VU6+HBmYPsWDgLkcaepeOD4
 ayDQ9pa331yEmxw==
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
v4 -> v5:
 - using !V4L2_TYPE_IS_OUTPUT to check for type
 - initialzing interval to same default as in configfs
 - reordered this patch in the series
v1 -> v4: -
---
 drivers/usb/gadget/function/uvc.h       |  1 +
 drivers/usb/gadget/function/uvc_v4l2.c  | 52 +++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc_video.c |  1 +
 3 files changed, 54 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 4f44a607d9f5c..099038f1088ef 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -105,6 +105,7 @@ struct uvc_video {
 	unsigned int width;
 	unsigned int height;
 	unsigned int imagesize;
+	unsigned int interval;
 	struct mutex mutex;	/* protects frame parameters */
 
 	unsigned int uvc_num_requests;
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index de1736f834e6b..ab89f1630acb0 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -314,6 +314,56 @@ uvc_v4l2_set_format(struct file *file, void *fh, struct v4l2_format *fmt)
 	return ret;
 }
 
+static int uvc_v4l2_g_parm(struct file *file, void *fh,
+			   struct v4l2_streamparm *parm)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct uvc_device *uvc = video_get_drvdata(vdev);
+	struct uvc_video *video = &uvc->video;
+	struct v4l2_fract timeperframe;
+
+	if (!V4L2_TYPE_IS_OUTPUT(parm->type))
+		return -EINVAL;
+
+	/* Return the actual frame period. */
+	timeperframe.numerator = video->interval;
+	timeperframe.denominator = 10000000;
+	v4l2_simplify_fraction(&timeperframe.numerator,
+			       &timeperframe.denominator, 8, 333);
+
+	uvcg_dbg(&uvc->func, "Getting frame interval of %u/%u (%u)\n",
+		 timeperframe.numerator, timeperframe.denominator,
+		 video->interval);
+
+	parm->parm.output.timeperframe = timeperframe;
+	parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+
+	return 0;
+}
+
+static int uvc_v4l2_s_parm(struct file *file, void *fh,
+			   struct v4l2_streamparm *parm)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct uvc_device *uvc = video_get_drvdata(vdev);
+	struct uvc_video *video = &uvc->video;
+	struct v4l2_fract timeperframe;
+
+	if (!V4L2_TYPE_IS_OUTPUT(parm->type))
+		return -EINVAL;
+
+	timeperframe = parm->parm.output.timeperframe;
+
+	video->interval = v4l2_fraction_to_interval(timeperframe.numerator,
+						    timeperframe.denominator);
+
+	uvcg_dbg(&uvc->func, "Setting frame interval to %u/%u (%u)\n",
+		 timeperframe.numerator, timeperframe.denominator,
+		 video->interval);
+
+	return 0;
+}
+
 static int
 uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
 		struct v4l2_frmivalenum *fival)
@@ -587,6 +637,8 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops = {
 	.vidioc_dqbuf = uvc_v4l2_dqbuf,
 	.vidioc_streamon = uvc_v4l2_streamon,
 	.vidioc_streamoff = uvc_v4l2_streamoff,
+	.vidioc_s_parm = uvc_v4l2_s_parm,
+	.vidioc_g_parm = uvc_v4l2_g_parm,
 	.vidioc_subscribe_event = uvc_v4l2_subscribe_event,
 	.vidioc_unsubscribe_event = uvc_v4l2_unsubscribe_event,
 	.vidioc_default = uvc_v4l2_ioctl_default,
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index f43bf19218963..19ba18d5a42fb 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -784,6 +784,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	video->width = 320;
 	video->height = 240;
 	video->imagesize = 320 * 240 * 2;
+	video->interval = 666666;
 
 	/* Initialize the video buffers queue. */
 	uvcg_queue_init(&video->queue, uvc->v4l2_dev.dev->parent,

-- 
2.39.5



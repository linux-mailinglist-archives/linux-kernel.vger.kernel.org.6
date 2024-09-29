Return-Path: <linux-kernel+bounces-343122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDDF9896FA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4071F2136E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E72178CDE;
	Sun, 29 Sep 2024 18:59:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E785FDA7
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636380; cv=none; b=ljhSuB4icqNUmQNyORHLQkqdy2m+UeiGgaNkveTrmLUdQctNrDTTY94rJqn7NspE7R0NGYnURqjpt0ssldhP1kbv/y0v5ZwC9dEfe18Mrtt7bmpCuIxf3oo1hahidB9CRgyHiVCBci1ySEZwFsS9iyusxtYWDmoxkbSkFF4hDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636380; c=relaxed/simple;
	bh=/7WmY7rllTF+fLfM/l5bZ3Bth2MGsfy7tmnu6bPQpww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m84x446SewkzIhF1CHX+DskKEBfgI9Mx5RpoESJBpRnChL1CRQ2wRsR34VmpKkC4SA+rj4ow2oDpnAo3HIWM447N2F65uWwFHLp11yy5e1NbSfYXtkwPOmiD3JZqYHnQMRjKlAL8Ahpt2TUVzqMXjYL9d49Mh8lByVaBxyuqQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053s-KL; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-002Ro6-0y; Sun, 29 Sep 2024 20:59:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-2y;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 20:59:24 +0200
Subject: [PATCH v6 4/9] usb: gadget: uvc: add g_parm and s_parm for frame
 interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v6-4-08c05522e1f5@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4059;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=/7WmY7rllTF+fLfM/l5bZ3Bth2MGsfy7tmnu6bPQpww=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aOQ0YuuM54qT/7GoCqU62i2l7GqjRSEy5mV8
 CIS9kM1NQKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjkAAKCRC/aVhE+XH0
 qxWBD/wKvxyL2nCjQn/DtyGih2OGvFlg99bC9Y8Y8hS3H8erS1A8ujBiH3eRaN/d5wh1w+TEDKs
 o5jSi3vd8bAo1inK+faeJxSK3eKGZq/QATei1GDtB9hiImpSBr9VvpOAGUS9yptZ2UN8zKD9fmu
 MilDhr2NK32no/dSbHIRqvki3Ya2+l0oghM7Y1qA4oK/eTuhL7CoMYZThA0io2tHdD1oj01M0jO
 +HPh+e0SBI30+KKQQoo7SU5QpL9XzrzLI8C7GAPz91rsc56zi8+ih9G7Ck1expVHh0CrwZ8HhFx
 3vRBagSWt6zRZDADJkGwmTR1E+6nRp7Q0FZfVXO+cs4FYpfqHNZc5qAdfvXUkKWBSGk4S6cz4ko
 lpCMGQjdh69ZTerRQGmCIfh7wICLvcyrU5wQDHmkihl1SiquptG4OTVDxvohXw8nzl/CtbCbjcR
 LTo8K/JXVRRYFKksagQT8YNAO9slDw0wWGQZDai4dpp5mHKpVfnU+Ec9g/JLP7MGe3lcIFxy44v
 5XiqPVp4OqKBiS+4/OBqB5f40BbIMcKKvk3CHrA2l/WG/VqDb2n50nA06MlQEs3mpS7Ekp2vvWn
 vgH3Wl34WKyZV5qId3uQClzJyNtb/2ve/x+S3AgejI2UmzoZ8Q8KukxUV9rJRHEH3IV1NS4TaMo
 L8tnH5YsRlw3WjA==
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
v5 -> v6: -
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



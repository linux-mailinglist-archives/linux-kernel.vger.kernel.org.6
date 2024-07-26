Return-Path: <linux-kernel+bounces-263802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B29293DA98
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE479B25C48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32A14D6EB;
	Fri, 26 Jul 2024 22:03:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4714C5B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031404; cv=none; b=qMGD1e39VSjcjEDai3+AdtSbyWhu4moK1s34fUzK7mytMbxMDktrEfAikHfRo/D6/JXTr9KUAHjaSLOI6KNZ4lC6b69aTjP4tBg9ACtU6As13mWsQlzrauQSwo77hWK1Wd39IF7HMrokNMuPKFtvLjwe4Z7KtHR/NmsaEk+k86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031404; c=relaxed/simple;
	bh=JpVyBCvXbR+bijgysqnCR5c1wnLhUDG1b+V58uqS5S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OP97dQ+c74EIFNggws1EcVjVIinBaHwnfRxCN0yhmBrL1qYvEb2SJ5sthW+2zvQ4lMJPTTTED42yVd66atrRH/qSgiMAfBTRmnUqDugC8xAI6C09fx2cAcxjkSHAI+5zRDbYGdMGapuhYUCEuNZoaACc2Qxnf8tmsNHHOAbwY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1x-0005jI-Dz; Sat, 27 Jul 2024 00:03:17 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1w-002QjR-S1; Sat, 27 Jul 2024 00:03:16 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-00FdLn-2j;
	Sat, 27 Jul 2024 00:02:43 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sat, 27 Jul 2024 00:02:45 +0200
Subject: [PATCH v3 10/10] usb: gadget: uvc: add min g_ctrl vidioc and set
 min buffs to 4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v3-10-4da7033dd488@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=JpVyBCvXbR+bijgysqnCR5c1wnLhUDG1b+V58uqS5S8=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmpB0DaYLtFlQJJ8cqaOw5eL/8c9CeyZh/7Kspg
 WKpXQiuoX2JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZqQdAwAKCRC/aVhE+XH0
 qy3MEACSA3D57LqbAuWIHEmcOTPgi2X68CWbXTxMB/LgJtAhHKcu2x97lItkxAeW1tOEIAY+kfv
 RSQ1gaw0i6KIjpgEV+D7BEFzYYD9NHuzdiZD0/QYh6VVH/A86bjvZyultRv39siDNUu/4aXzZxa
 ZQha6G7cvn1HNgzjf4ff8CLcmMWq9LwFTwafeC3eKzrNHPVaf4fHsD6aK8xhOKLp/9YeVTkUXPY
 7siaaOtJ9DREc+W242Jccc8Z2JvTcxTjME2JmA5O16ECJw60bMEgXXLVXko5oOr+4S8vCL+29yl
 6Xf0KGxDkuJ/pmsvK4EdJfgKECD4Wzsb31KWKHJvvG7tc3Fpnf4igEe7YE4MrlapP84lRc6ytxT
 +ZINoyJtVwLoP2cPlCF3KUfy6LsPAAUxYWW/1YmcdnvS8K/KJV/XJttYXbPzIzm4VlEt+ZIQb3i
 yKf6LO5xD43gXW5tRgMlAZ8VPznJxhtXZ2OW2rKG+TpGONXxWVN8wRldqpafRtCrkTrkoR2e6Ce
 6dwirtt/EA4kkMSnpVHd+rgvhplwtYHl61A7IKLLZGR95d/dpHC6aoWhhm70zWOT59o0URl1D4F
 MUHoUnPoQO8qirLqzOixgraYRRHqztkB241z1GhbpNF+3oz5RSeC+IOXwUTWEaNmDaKBmjFEtux
 zlCPoFqpQCuS3Gw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

We increase the minimum amount of v4l2 buffers that will be possibly
enqueued into the hardware and allocate at least
UVCG_STREAMING_MIN_BUFFERS amount of requests. This way the driver has
also more requests available to prefill the isoc hardware with.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v1 -> v3: new patch
---
 drivers/usb/gadget/function/uvc.h       |  2 ++
 drivers/usb/gadget/function/uvc_queue.c |  3 ++-
 drivers/usb/gadget/function/uvc_v4l2.c  | 13 +++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index f6bc58fb02b84..e0b1f78fdbc65 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -71,6 +71,8 @@ extern unsigned int uvc_gadget_trace_param;
 
 #define UVCG_REQUEST_HEADER_LEN			12
 
+#define UVCG_STREAMING_MIN_BUFFERS		4
+
 /* ------------------------------------------------------------------------
  * Structures
  */
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index e33ce72325031..157e7f7d49c7a 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -21,6 +21,7 @@
 #include <media/videobuf2-vmalloc.h>
 
 #include "uvc.h"
+#include "uvc_video.h"
 
 /* ------------------------------------------------------------------------
  * Video buffers queue management.
@@ -86,7 +87,7 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 	}
 
 	video->req_size = req_size;
-	video->uvc_num_requests = nreq;
+	video->uvc_num_requests = nreq * UVCG_STREAMING_MIN_BUFFERS;
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 392fb400aad14..f96074f2c2824 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -357,6 +357,18 @@ static int uvc_v4l2_s_parm(struct file *file, void *fh,
 	return 0;
 }
 
+static int uvc_g_ctrl(struct file *file, void *priv, struct v4l2_control *vc)
+{
+	int ret = -EINVAL;
+
+	if (vc->id == V4L2_CID_MIN_BUFFERS_FOR_OUTPUT) {
+		vc->value = UVCG_STREAMING_MIN_BUFFERS;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int
 uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
 		struct v4l2_frmivalenum *fival)
@@ -629,6 +641,7 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops = {
 	.vidioc_streamoff = uvc_v4l2_streamoff,
 	.vidioc_s_parm = uvc_v4l2_s_parm,
 	.vidioc_g_parm = uvc_v4l2_g_parm,
+	.vidioc_g_ctrl = uvc_g_ctrl,
 	.vidioc_subscribe_event = uvc_v4l2_subscribe_event,
 	.vidioc_unsubscribe_event = uvc_v4l2_unsubscribe_event,
 	.vidioc_default = uvc_v4l2_ioctl_default,

-- 
2.39.2



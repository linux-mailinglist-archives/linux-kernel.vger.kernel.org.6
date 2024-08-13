Return-Path: <linux-kernel+bounces-284468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3A9950149
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182771F23822
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C017C7C2;
	Tue, 13 Aug 2024 09:34:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF313CA81
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541672; cv=none; b=bQtOCxTdn6pqrPIkN+6IJuFhz46rdZIbq/wj9d0M3nyPOyK51DojlcpOxTZrOJPGAffDHy+UdAQkS5lskflIP7F+OBq5ILz1WCKFfnGzu7dI/8CLBPrcmgjTZHmugrqBhcddUDB6OvdjpkCsW/K2wrjhwiOJAIrvnYl8arGerwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541672; c=relaxed/simple;
	bh=rj9b7K0Nbm9lGAMTKb9Y09pi8U+HR6hJCCBIdBSG5FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwVhCEOc5JG9C+Yh6XP+UjKeHpwAufxAuegMsY/RmSkqIvlmFQsMdt2YbAwPmWWr93dfQmwwGkKRvjVNVUd3TOrzuEs6/+amGK1+UQS9ufoielYpYuIZ5+hl/HcQZNW4uwKJlLFJDJiWZnbn9IS+Tl8TYBVPG0lH7b5//Afrt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnv9-0004A5-UD; Tue, 13 Aug 2024 11:34:27 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnv9-0005yY-FB; Tue, 13 Aug 2024 11:34:27 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0P;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:34 +0200
Subject: [PATCH v4 10/10] usb: gadget: uvc: add min g_ctrl vidioc and set
 min buffs to 4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-10-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=rj9b7K0Nbm9lGAMTKb9Y09pi8U+HR6hJCCBIdBSG5FA=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLNqZfMBw7L5B5aKx0UULdgxEbrn+BT9FeHo
 wBP/cH2TNaJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsizQAKCRC/aVhE+XH0
 qz7CD/9FEpRSh8VyQlqZG6f1NIn9XdkLGB2o/hBgZDugNSIMCWZJhIOEZMSqdxsTnZ5LlzmRuIE
 p/KhrHeVrt4OeRolSnxjTrlfDUfBnvKwyRO/5gnQ+QLnHrmu28Jtnn1CQTpT+uPR45ovjiXCJdA
 JhnqDZBkp1DyDJi3ZBWHvgxIgfYV5LB1TsYD2TCNIEZ0B1IPac4TgXLtqhYpeme3RRaw4XZ0vXl
 U//AvkY2mJh0Ncb6jA9ZWMlhs2W/+7kPfXBaDmlD8Be0kAFThNTh3R2311vdOLwQbNfvrK+iMie
 pRpFRc2RCrJP4swbxxLabEugCxY1CcALGgD7memCCXXCH1JH9d2Wdhe1ijzIM7xKt7+a1iN4fYS
 wWYX7cpVSC3O8TxwFjfTJ8wX2Rh2CYQLtmwxlEj/BSbZ3mRCD5HaXVeEkMroNPuD4cTWp9VKU7L
 Sj/d7JNSQI3JTXISiQ4nPWoQGrn6g2xxhzWA8VyeHl57RIQphzNebcTEm6YCkPXu23YuagvuVBr
 APCXKLlMqATZqIrKnXj9Cbr9nbQPzXyo+lzwa3dYQcxAscQ9orEidZWz+oQthFNRHHNSw53wl/I
 MgVhk+8sbXK2OojoCXoBQosU/ZqJnS3VzGfLbUCNI6Y1bLwR7OKTwcMErVVfcIdXZ+ZddB3X2ui
 IwmsKPnwgcLNevA==
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
v3 -> v4: -
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



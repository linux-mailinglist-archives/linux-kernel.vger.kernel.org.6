Return-Path: <linux-kernel+bounces-368166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803BD9A0C23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129351F24BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E760E21019A;
	Wed, 16 Oct 2024 13:58:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06920C039
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087108; cv=none; b=JtcTeuaOUo6HW3Jz72FLGEUpLOhnnF78yz0Ysxxw/FkfhTn4mg+a/DuNKI3CNj1gHCspoEUtXqJ88EUG6GEkE0L0sLJM18HOAMly+btpesDQHVsa5yldoTjl5jKjb+e4zqZN6qSZJIMaeucUb1FBawCjd61MLE3QJELI5UmifWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087108; c=relaxed/simple;
	bh=SCnB0IVoVu6QPaJhJtJ6/MNhWTj2P5Lgsxjj60AYCOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BShcnbVcnM6C9o8Wro3eVJXORya9ORlMZNgx5yleOpSUtcgs/noK1X1QDWGu4tqEBmHVJxZ8z47uh8gFE99cDGadpGUPi6FT8a0ur4XwDj5RVwtwarhMdUon614d6uq8YQxc7RMdv4y7znxZiEKUt9CuK4sYq/u2ej9GeGkqPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-0003H7-O8; Wed, 16 Oct 2024 15:58:21 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-002HjF-3Q; Wed, 16 Oct 2024 15:58:21 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xc-00BU5S-3C;
	Wed, 16 Oct 2024 15:58:20 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 16 Oct 2024 15:58:11 +0200
Subject: [PATCH v7 6/9] usb: gadget: uvc: set req_length based on payload
 by nreqs instead of req_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v7-6-e224bb1035f0@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v7-0-e224bb1035f0@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v7-0-e224bb1035f0@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5699;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=SCnB0IVoVu6QPaJhJtJ6/MNhWTj2P5Lgsxjj60AYCOE=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBnD8Z7MDvY04M2QbiBFOOaXdzGsMMTnhd8RJmsh
 qenuA+BN2eJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZw/GewAKCRC/aVhE+XH0
 q6t6EACKyNRQC6z87LfLnC259TWATLnFXQErAbbTEuexdWnS4BIjk6gHq0rweeXu6G6NHKJr/DW
 KJEgKCHGuOZnoMq12skmYYJ97Wut5OFn+sw2yCm+w3WtU6UVy+Wdw5n9RFi0Vkum786lZirVehS
 xpiT31mmjoEdX521TSVhQSO9koofBoKm37fAkfVH1aWRjlHdMJ1kLaVt4CsO8Vj4DopdkbBis66
 Vg0AL47O+5dQc4a5FAeV7h2ia5yoJNEmQO29a2dhVp6+dtCL/wL0EIy9RcvjoqLpKAHKHsBsP26
 ZghFoWwZ5vaO5OBMaE6t+eFijnULzCYXjUNrfsn0okFrY69aQ0NSlIowEbLq13Nr+ckjISOQnfl
 PVNOg4igB0CFEcKWlXyIWrHAmZsAy9njMmgkqgUoIAZyVBOOrZ0aNGo/REUk8DvI128nO0iCI4R
 faBa40YVp8ycWWRTkyMgOLn353tx1srrSiVMaveBi2/vN0nZmkOqHyyUN0UziSXMHtJDymhmdIQ
 aUNRFhF9otcxa9WKGPe8kkeany0JVOKOZdD3dpDHlqkAIYhwfVEI4bK2/JOJtr+nhE3sfrYFtbK
 emCM9OLESvxYpRBjel1zO5Cc01DOfwtpXXQ/aR8dj+yKAU/PEmbsn8ZRoOMMTBiQ0Icp1zd+N4T
 xTmOKOzz+0vV+IA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Compressed formats generate content depending amount of data that is set
in the vb2 buffer by the payload_size. When streaming those formats it
is better to scatter that smaller data over all requests. This patch is
doing that by introducing the calculated req_payload_size which is
updated by each frame. It the uses this amount of data to fill the
isoc requests instead of the video->req_size.

For uncompressed formats it will not make a difference since the payload
size will be equal to the imagesize. Therefore the code will have no
effecta as req_payload_size will be equal to req_size.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v5 -> v7: -
v4 -> v5:
 - keep using req_size instead of len in encode_isoc_sg to be more
   explicit
 - using new initialized variable reqs_per_frame instead of two
   calculations
 - reordered this patch in the series
v1 -> v4: -
---
 drivers/usb/gadget/function/uvc.h       |  2 ++
 drivers/usb/gadget/function/uvc_queue.c | 10 ++++++++--
 drivers/usb/gadget/function/uvc_queue.h |  2 ++
 drivers/usb/gadget/function/uvc_video.c | 15 ++++++++-------
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 099038f1088ef..bedb4ef42864f 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -110,6 +110,8 @@ struct uvc_video {
 
 	unsigned int uvc_num_requests;
 
+	unsigned int reqs_per_frame;
+
 	/* Requests */
 	bool is_enabled; /* tracks whether video stream is enabled */
 	unsigned int req_size;
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 731e3b9d21acc..6757a4e25a743 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -58,6 +58,7 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 static int uvc_buffer_prepare(struct vb2_buffer *vb)
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
+	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct uvc_buffer *buf = container_of(vbuf, struct uvc_buffer, buf);
 
@@ -78,10 +79,15 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
 		buf->mem = vb2_plane_vaddr(vb, 0);
 	}
 	buf->length = vb2_plane_size(vb, 0);
-	if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+	if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		buf->bytesused = 0;
-	else
+	} else {
 		buf->bytesused = vb2_get_plane_payload(vb, 0);
+		buf->req_payload_size =
+			  DIV_ROUND_UP(buf->bytesused +
+				       (video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
+				       video->reqs_per_frame);
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/uvc_queue.h b/drivers/usb/gadget/function/uvc_queue.h
index 41f87b917f6bc..b54becc570a38 100644
--- a/drivers/usb/gadget/function/uvc_queue.h
+++ b/drivers/usb/gadget/function/uvc_queue.h
@@ -39,6 +39,8 @@ struct uvc_buffer {
 	unsigned int offset;
 	unsigned int length;
 	unsigned int bytesused;
+	/* req_payload_size: only used with isoc */
+	unsigned int req_payload_size;
 };
 
 #define UVC_QUEUE_DISCONNECTED		(1 << 0)
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index ecb32a3e03760..677eaf5b7e4d0 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -136,7 +136,7 @@ uvc_video_encode_isoc_sg(struct usb_request *req, struct uvc_video *video,
 	unsigned int pending = buf->bytesused - video->queue.buf_used;
 	struct uvc_request *ureq = req->context;
 	struct scatterlist *sg, *iter;
-	unsigned int len = video->req_size;
+	unsigned int len = buf->req_payload_size;
 	unsigned int sg_left, part = 0;
 	unsigned int i;
 	int header_len;
@@ -146,15 +146,15 @@ uvc_video_encode_isoc_sg(struct usb_request *req, struct uvc_video *video,
 
 	/* Init the header. */
 	header_len = uvc_video_encode_header(video, buf, ureq->header,
-				      video->req_size);
+					     buf->req_payload_size);
 	sg_set_buf(sg, ureq->header, header_len);
 	len -= header_len;
 
 	if (pending <= len)
 		len = pending;
 
-	req->length = (len == pending) ?
-		len + header_len : video->req_size;
+	req->length = (len == pending) ? len + header_len :
+		buf->req_payload_size;
 
 	/* Init the pending sgs with payload */
 	sg = sg_next(sg);
@@ -202,7 +202,7 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
 {
 	void *mem = req->buf;
 	struct uvc_request *ureq = req->context;
-	int len = video->req_size;
+	int len = buf->req_payload_size;
 	int ret;
 
 	/* Add the header. */
@@ -214,7 +214,7 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
 	ret = uvc_video_encode_data(video, buf, mem, len);
 	len -= ret;
 
-	req->length = video->req_size - len;
+	req->length = buf->req_payload_size - len;
 
 	if (buf->bytesused == video->queue.buf_used ||
 			video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE) {
@@ -504,7 +504,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 
 	if (!usb_endpoint_xfer_isoc(video->ep->desc)) {
 		video->req_size = max_req_size;
-		video->uvc_num_requests =
+		video->reqs_per_frame = video->uvc_num_requests =
 			DIV_ROUND_UP(video->imagesize, max_req_size);
 
 		return;
@@ -535,6 +535,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 	 * able to fully encode one frame.
 	 */
 	video->uvc_num_requests = nreq + UVCG_REQ_MAX_ZERO_COUNT;
+	video->reqs_per_frame = nreq;
 }
 
 static int

-- 
2.39.5



Return-Path: <linux-kernel+bounces-343126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D7A989704
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761CA1C217FB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1B18595B;
	Sun, 29 Sep 2024 18:59:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02586A01E
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636382; cv=none; b=f2COSyGOMQsGt0eSxEPh4Ya0sWT0SyAYOgi4Ua1KNVjamwrWpvOVCOnAfh3dWVJwnrByw5Hxml0g6WGXu2+UVA+MvSI1a+Bo2NfVKSXbIktmEq25lynD3bXnlLVXxm/0tqf+kOUVkmmyz6HeBgyPsXSp9feBxYxHCLgyVFFx3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636382; c=relaxed/simple;
	bh=Hk7tbELgzh9caEJKk1jfev7yNN44yhrC8FT6TaKYFeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvkqMkKeKGRRYy9ek972zzSXnvwYIBQqAYjkm1PU7rMedinm0Od6HXDqPUdZSrWc/pm56v7zb6K7pbuZIN0fhCeLS1RuQRzqAn2Ne1rSVfEwPHhfC/ttb25A/DP2wb2IDJNhm3IlZFsnXfz5owIkA0OlSOAXDXurrMHyPUhuU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053v-KL; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-002Ro8-1m; Sun, 29 Sep 2024 20:59:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-30;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 20:59:26 +0200
Subject: [PATCH v6 6/9] usb: gadget: uvc: set req_length based on payload
 by nreqs instead of req_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v6-6-08c05522e1f5@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5699;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=Hk7tbELgzh9caEJKk1jfev7yNN44yhrC8FT6TaKYFeM=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aORAkNKtcBauirFrPlVipbScaYLRKdKm78F1
 9Lk/vP9PpqJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjkQAKCRC/aVhE+XH0
 q13BEACgLwGxeIHzggCVcaJyQjOC7hKf+24RxmNZpdNCMLNIHgLC5NRKbLG4H2pwTjUDx8nnsLT
 tyi+E8awD9Ma+XZn7wbDpGn/Nmuimo476VJjycM38u/0UMOwCGxtQvMAgOygGSp9rHIrCaH6h0M
 WAaFFNS22dUjqfZ9tRxCjd6xtlAAgAJFcTxXCOxm4b4aQUlvmHS+MDAlt3NqqOfdIgJVCfsDx1H
 v4ZGOosmFIOdm0FbyWk+AFWUg3BlfaHitkApnLPR9mMyJowTs9wOE/OXYUUf7V6VDOah449cs/W
 pFO0BjipqsFGV+kInWsLd/2dkflIc+Ln+un5P2UBk6YPLh66r+i7QARhdhb0Us/rLJ6b6lqX/xa
 t8VToIryuSaOxwQfFA9h1IsG+c3JcKAwNHQtlwSW+XWfdG48X5IIdkmnQB4KrMshg/XOildWpCU
 9rT/OBxmnQxbtKNoU7XmcjPAOj1//ZKRKsN5h/PL+FZ1GVxwVgB6BGzSKFS3j+Lyg6C9+kbBnaa
 fGQ7zoGYpHIIiKjBRSMqzbiCbA4OElandGTRQk/JNqduTxpapdTUTnL4LWlzOQUaMmCLb5RF/zb
 lkvfi6erAiA9bVAsiQeB/9NqQR6FtaEa+hsgz8gblHykTD6uoHg/psFBCBjnswtUTT2gOqfKgCZ
 cpJA7nq/cmiGRTw==
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
v5 -> v6: -
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
index 4efd7585d7541..0287a56fa50ad 100644
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



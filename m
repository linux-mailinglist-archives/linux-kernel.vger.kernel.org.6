Return-Path: <linux-kernel+bounces-284437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1279500FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5241F22D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B22174EEB;
	Tue, 13 Aug 2024 09:09:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2B175D3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540182; cv=none; b=QTyCXE3MGO58ojY/fjP9phv7OAwmHjs+p+m4r/MRWHMC9YlB5a/oCyMtDz/0ADNt/xrIjzKXJGAYs+ROHRo6fFLITvOzVsRdy+5NCHFE3KzOqxDb6S+j/iVfaFuGBcSDG8FoQYKVv8aeferBCwAUO/Je5SH6q/sJYnTCfsDiHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540182; c=relaxed/simple;
	bh=TlNFmUlB6A1ZL6sefujk/ACyJS6GxVDK0ModATmG4xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTOeNvIFU8Np29JDD5XPNWeiCkVb4c9Oghak2fjODxpsmYtwpOTHQpzNQMY8OGJzufXhmy1Bh+6wwH6PUeb6UAORDoFkuVG8kjUHDb543jDtsfabDs8VoN9eN89wAS/Tpd3ip6YNSSaD6TpWgrXso2K5fhqtmx578fy7SexiPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CO-SE; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005oh-7S; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0I;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:27 +0200
Subject: [PATCH v4 03/10] usb: gadget: uvc: remove pump worker and enqueue
 all buffers per frame in qbuf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-3-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8659;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=TlNFmUlB6A1ZL6sefujk/ACyJS6GxVDK0ModATmG4xw=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLL4YCrloiQa9JdeEqNWEKqiSExnx2Ad8RDt
 h2XJO6sCLSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsiywAKCRC/aVhE+XH0
 q5CWEAC4DGfBfHfTLGeAttOBlcufOMR/OjFvFxs7bTfrA7K9vGt9j8lyHmc6REzK8n1j5FkyOwv
 ij05nMypboPvJWDlTIi56qqTtLzyGDHqAmiU98p8U4xjc3G2he7b/N2j8AT6zVwHEvY/vueULwO
 F3gEIpyb3iakJItPb+uUw7LKlM3NvVjmMwi7UVEuBrpwRfH7Ef0fKJNPpYjAi0CAo+Puzww9rAe
 0fNSpuWB+mORFr/AVNc0pLSx87NbLbRO1Dyy9dXK7rjgv4YX7ClZkRDgok5Fv8gJh3o9Wai5jrT
 FNJWKpj6CBgpCPG7aaWT5AlvEnLgNMnJFfwfTpCk1dyV4UQP118aQdJBRKqexIyytcHBcjAC01V
 x0SkomC57e5JAGsMgfAFY9FsreR7MrqhE4A5SrPDxrnpmUinQrMu9mvFnh42ffOOswlXb57sbsX
 9l+yLNY4GRYMOCqYoITJTpPWHKysgRr639erA9xUkHjBSetbFuwkPVDpJku/qr5IXOfKlCg7iI4
 /tmFOs4NZ1mnHlgYKET44+Iv3E6FMpq5TxGIrIPg3qELILAWWCPox4aK7t7XO/GFp/Yp23iuUte
 GwLGFnfN3r5C5MpjC9sAS8UIFGllg87a+lxWnq0wEMv+4t/V8nTMNg2Kp4upBx9YyBGGBmwZltP
 M62DAM6zvniVczA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Since we now have at least the amount of requests to fill every frame
into the isoc queue that is requested with the REQBUFS ioctl, we can
directly encode all incoming frames into the available requests.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v3 -> v4: fixed exit path in uvc_enqueue_buffer by exceptionally call cleanup code on break
v1 -> v3: new patch
---
 drivers/usb/gadget/function/f_uvc.c     |  4 ---
 drivers/usb/gadget/function/uvc.h       |  5 +---
 drivers/usb/gadget/function/uvc_queue.c |  3 ++
 drivers/usb/gadget/function/uvc_v4l2.c  |  3 --
 drivers/usb/gadget/function/uvc_video.c | 53 ++++++++-------------------------
 drivers/usb/gadget/function/uvc_video.h |  1 +
 6 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 40187b7112e79..aeaf355a86eb3 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -986,14 +986,10 @@ static void uvc_function_unbind(struct usb_configuration *c,
 {
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
-	struct uvc_video *video = &uvc->video;
 	long wait_ret = 1;
 
 	uvcg_info(f, "%s()\n", __func__);
 
-	if (video->async_wq)
-		destroy_workqueue(video->async_wq);
-
 	/*
 	 * If we know we're connected via v4l2, then there should be a cleanup
 	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 646f1c01c5101..e252c3db73072 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -88,9 +88,6 @@ struct uvc_video {
 	struct uvc_device *uvc;
 	struct usb_ep *ep;
 
-	struct work_struct pump;
-	struct workqueue_struct *async_wq;
-
 	int enqueued;
 	int dequeued;
 
@@ -113,7 +110,7 @@ struct uvc_video {
 	struct list_head req_free;
 
 	/*
-	 * USB requests video pump thread has already encoded into. These are
+	 * USB requests video qbuf thread has already encoded into. These are
 	 * ready to be queued to the endpoint.
 	 */
 	struct list_head req_ready;
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 0aa3d7e1f3cc3..7995dd3fef184 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -102,6 +102,7 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
 static void uvc_buffer_queue(struct vb2_buffer *vb)
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
+	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct uvc_buffer *buf = container_of(vbuf, struct uvc_buffer, buf);
 	unsigned long flags;
@@ -120,6 +121,8 @@ static void uvc_buffer_queue(struct vb2_buffer *vb)
 	}
 
 	spin_unlock_irqrestore(&queue->irqlock, flags);
+
+	uvc_enqueue_buffer(video, buf);
 }
 
 static const struct vb2_ops uvc_queue_qops = {
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a024aecb76dc3..4085f459c3c70 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -429,9 +429,6 @@ uvc_v4l2_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
 	if (ret < 0)
 		return ret;
 
-	if (uvc->state == UVC_STATE_STREAMING)
-		queue_work(video->async_wq, &video->pump);
-
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index d47ddd674f457..5b0bf8069d48f 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -445,7 +445,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	/*
 	 * Here we check whether any request is available in the ready
 	 * list. If it is, queue it to the ep and add the current
-	 * usb_request to the req_free list - for video_pump to fill in.
+	 * usb_request to the req_free list - for qbuf to fill in.
 	 * Otherwise, just use the current usb_request to queue a 0
 	 * length request to the ep. Since we always add to the req_free
 	 * list if we dequeue from the ready list, there will never
@@ -469,7 +469,6 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		 * dequeue -> queue -> dequeue flow of uvc buffers will not
 		 * happen.
 		 */
-		queue_work(video->async_wq, &video->pump);
 	} else if ((video->enqueued - video->dequeued) > 32) {
 		spin_unlock_irqrestore(&video->req_lock, flags);
 
@@ -566,27 +565,15 @@ uvc_video_alloc_requests(struct uvc_video *video)
  * Video streaming
  */
 
-/*
- * uvcg_video_pump - Pump video data into the USB requests
- *
- * This function fills the available USB requests (listed in req_free) with
- * video data from the queued buffers.
- */
-static void uvcg_video_pump(struct work_struct *work)
+int uvc_enqueue_buffer(struct uvc_video *video, struct uvc_buffer *buf)
 {
-	struct uvc_video *video = container_of(work, struct uvc_video, pump);
 	struct uvc_video_queue *queue = &video->queue;
-	/* video->max_payload_size is only set when using bulk transfer */
-	bool is_bulk = video->max_payload_size;
 	struct usb_request *req = NULL;
-	struct uvc_buffer *buf;
+	bool is_bulk = video->max_payload_size;
 	unsigned long flags;
 	int ret = 0;
 
-	while (true) {
-		if (!video->ep->enabled)
-			return;
-
+	while (buf->state != UVC_BUF_STATE_DONE) {
 		/*
 		 * Check is_enabled and retrieve the first available USB
 		 * request, protected by the request lock.
@@ -594,7 +581,7 @@ static void uvcg_video_pump(struct work_struct *work)
 		spin_lock_irqsave(&video->req_lock, flags);
 		if (!video->is_enabled || list_empty(&video->req_free)) {
 			spin_unlock_irqrestore(&video->req_lock, flags);
-			return;
+			return -ENOENT;
 		}
 		req = list_first_entry(&video->req_free, struct usb_request,
 					list);
@@ -605,22 +592,8 @@ static void uvcg_video_pump(struct work_struct *work)
 		 * Retrieve the first available video buffer and fill the
 		 * request, protected by the video queue irqlock.
 		 */
-		spin_lock_irqsave(&queue->irqlock, flags);
-		buf = uvcg_queue_head(queue);
-		if (!buf) {
-			/*
-			 * Either the queue has been disconnected or no video buffer
-			 * available for bulk transfer. Either way, stop processing
-			 * further.
-			 */
-			spin_unlock_irqrestore(&queue->irqlock, flags);
-			break;
-		}
-
 		video->encode(req, video, buf);
 
-		spin_unlock_irqrestore(&queue->irqlock, flags);
-
 		spin_lock_irqsave(&video->req_lock, flags);
 		/* For bulk end points we queue from the worker thread
 		 * since we would preferably not want to wait on requests
@@ -633,15 +606,22 @@ static void uvcg_video_pump(struct work_struct *work)
 
 		if (ret < 0) {
 			uvcg_queue_cancel(queue, 0);
-			break;
+			goto cleanup;
 		}
 	}
+
+	return 0;
+
+cleanup:
+
 	spin_lock_irqsave(&video->req_lock, flags);
 	if (video->is_enabled)
 		list_add_tail(&req->list, &video->req_free);
 	else
 		uvc_video_free_request(req->context, video->ep);
 	spin_unlock_irqrestore(&video->req_lock, flags);
+
+	return 0;
 }
 
 /*
@@ -681,7 +661,6 @@ uvcg_video_disable(struct uvc_video *video)
 	}
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
-	cancel_work_sync(&video->pump);
 	uvcg_queue_cancel(&video->queue, 0);
 
 	spin_lock_irqsave(&video->req_lock, flags);
@@ -775,12 +754,6 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
 	spin_lock_init(&video->req_lock);
-	INIT_WORK(&video->pump, uvcg_video_pump);
-
-	/* Allocate a work queue for asynchronous video pump handler. */
-	video->async_wq = alloc_workqueue("uvcgadget", WQ_UNBOUND | WQ_HIGHPRI, 0);
-	if (!video->async_wq)
-		return -EINVAL;
 
 	video->uvc = uvc;
 	video->fcc = V4L2_PIX_FMT_YUYV;
diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
index 8ef6259741f13..2f30ebd05fefb 100644
--- a/drivers/usb/gadget/function/uvc_video.h
+++ b/drivers/usb/gadget/function/uvc_video.h
@@ -17,6 +17,7 @@ struct uvc_video;
 int uvcg_video_enable(struct uvc_video *video);
 int uvcg_video_disable(struct uvc_video *video);
 
+int uvc_enqueue_buffer(struct uvc_video *video, struct uvc_buffer *buf);
 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);
 
 #endif /* __UVC_VIDEO_H__ */

-- 
2.39.2



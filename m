Return-Path: <linux-kernel+bounces-368163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 579D69A0C22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E9B25DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4A21019B;
	Wed, 16 Oct 2024 13:58:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157C20C03D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087108; cv=none; b=KSMuV7RvKnya0Q9kfq4Ssw3V5VZmk5NdDLNrT+wwuml41RB0tBTGWnQmHIg6jg2rjKZ1PqUbrGGf3Q4Bl0kXID+GyeQg2Z8rLzmiZZdtEYH3VsqABraV9d3JcSI+7h68kIaQmI8JI1wZurzK4ctsrVK6ljuqP9Ns0AJaFZqwg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087108; c=relaxed/simple;
	bh=zXcv+GZp8owNqCV32UIHQkKuIzK350cvbZnPJj04JBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECxkkGdRThCiI4spgFK/BGnca1r01clCVwnMnjkg5j0qb0cqf/yku0E9V9NnBrWPj5J3K9Mxj18ulOC5DoU/yCthIO+wvfjQR0H+n6nDbWx5y28odZx3wC3zFmFgFC8Rotf0KSmq9mzpbVLzglz987Zo0y1EPXteWECW1hXVtGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-0003H2-Ov; Wed, 16 Oct 2024 15:58:21 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-002HjC-31; Wed, 16 Oct 2024 15:58:21 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xc-00BU5S-39;
	Wed, 16 Oct 2024 15:58:20 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 16 Oct 2024 15:58:08 +0200
Subject: [PATCH v7 3/9] usb: gadget: uvc: rework to enqueue in pump worker
 from encoded queue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v7-3-e224bb1035f0@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10792;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=zXcv+GZp8owNqCV32UIHQkKuIzK350cvbZnPJj04JBM=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBnD8Z6/pD6SvMbEaBupeoUQ84CNdPv1HyNNjwta
 EUpDs7tv0iJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZw/GegAKCRC/aVhE+XH0
 q0xZD/9XTDNT8YNXu5UdbZ4eJtq3VCmCn77LZQWMR048JL2HtlyaclRpsZ9AmTYNbwjjNz97hXX
 y4gw5nXbtAk3aWEnVhruw6UNrd2ySBdEBQ2yDKItlWdpPubV2YcAuKM7wFbwCkjpTc2oviO8c9D
 h0Ln/lLWrfomXVq4eu3xx7szl/9WIh1MlCLCWqyzJ0KggGMAjLQAizX6Z4LQ1vOUKdk4vFbebD3
 HoZCAqbizu7/nh7qSJB3eFHDg25BE57N8d8VYrhuEHMDBU4iuF3rNa93T8z58BZnJZKOgICtzP8
 6n67nkwlpjkHbSk4SvoaoMOFQIzBdRL9hSaX/7nYG9iXue116XrGuUxAWdIg+sUD2OVeX6ME1Cx
 LCM8BhN7W0MMehHyFU8MEK73ZeLr0IWry2cECdcGbWi5x0ynWcfQNumLXb22wgazbp3UoCMHvCl
 CTL5SPasdvUzOPuisMejJ5rT25xzh9GVH4A9GGCdZKRC0+pONJq72Q84CIcNO3ud/iN+LBK00If
 G8vFroXmaK7B+v5QT3ww+oP8EsKH/DfNelXh+V3ONYdG65r36QAzsExW/XJ51CHB7Z7jWJDe+xR
 GaDCWg748D3VeZXZdJgGx4dMPZvpursOnxkFMlHKkPmlog6aj68HzJPzCgMm5WHIWbpB4tOgkO1
 HqHhlEvMCOeza8g==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

We install an kthread with pfifo priority that is iterating over all
prepared requests and keeps the isoc queue busy. This way it will be
scheduled with the same priority as the interrupt handler.

As the kthread is triggered with video_enable it will immediately
queue some zero length requests into the hw if there is no buffer data
available. It also watches the level of needed zero length requests in
the hardware not to fall under the UVCG_REQ_MAX_ZERO_COUNT threshold.
This way we can drop the function uvc_video_ep_queue_initial_requests
entirely.

By using the kthread to do the actual request handling the interrupt
handler will not be running into the time consuming and eventually
locking work of actually enqueueing the requests back into its own
pipeline. This work can now even be scheduled on another cpu.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v5 -> v7: -
v4 -> v5:
 - merging patch '(drivers/usb/gadget/function/uvc_queue.h') into this
   one
 - added initial kthread_queue_work(video->kworker, &video->hw_submit);
   to uvcg_video_enable
 - fixed error message in uvcg_video_init
 - reordered this patch in the series
 - renamed the kworker to hw_submit since the pump thread is used again
   with the work_queue
v1 -> v4: -
---
 drivers/usb/gadget/function/f_uvc.c     |   2 +
 drivers/usb/gadget/function/uvc.h       |   3 +
 drivers/usb/gadget/function/uvc_video.c | 180 +++++++++++++++-----------------
 3 files changed, 87 insertions(+), 98 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 40187b7112e79..f04376768bc10 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -991,6 +991,8 @@ static void uvc_function_unbind(struct usb_configuration *c,
 
 	uvcg_info(f, "%s()\n", __func__);
 
+	kthread_cancel_work_sync(&video->hw_submit);
+
 	if (video->async_wq)
 		destroy_workqueue(video->async_wq);
 
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 55d796f5f5e8d..4f44a607d9f5c 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -94,6 +94,9 @@ struct uvc_video {
 	struct work_struct pump;
 	struct workqueue_struct *async_wq;
 
+	struct kthread_worker   *kworker;
+	struct kthread_work     hw_submit;
+
 	atomic_t queued;
 
 	/* Frame parameters */
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index c041873cf8560..06055959f7165 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -324,50 +324,6 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
 	return 0;
 }
 
-/*
- * Must only be called from uvcg_video_enable - since after that we only want to
- * queue requests to the endpoint from the uvc_video_complete complete handler.
- * This function is needed in order to 'kick start' the flow of requests from
- * gadget driver to the usb controller.
- */
-static void uvc_video_ep_queue_initial_requests(struct uvc_video *video)
-{
-	struct usb_request *req = NULL;
-	unsigned long flags = 0;
-	unsigned int count = 0;
-	int ret = 0;
-
-	/*
-	 * We only queue half of the free list since we still want to have
-	 * some free usb_requests in the free list for the video_pump async_wq
-	 * thread to encode uvc buffers into. Otherwise we could get into a
-	 * situation where the free list does not have any usb requests to
-	 * encode into - we always end up queueing 0 length requests to the
-	 * end point.
-	 */
-	unsigned int half_list_size = video->uvc_num_requests / 2;
-
-	spin_lock_irqsave(&video->req_lock, flags);
-	/*
-	 * Take these requests off the free list and queue them all to the
-	 * endpoint. Since we queue 0 length requests with the req_lock held,
-	 * there isn't any 'data' race involved here with the complete handler.
-	 */
-	while (count < half_list_size) {
-		req = list_first_entry(&video->req_free, struct usb_request,
-					list);
-		list_del(&req->list);
-		req->length = 0;
-		ret = uvcg_video_ep_queue(video, req);
-		if (ret < 0) {
-			uvcg_queue_cancel(&video->queue, 0);
-			break;
-		}
-		count++;
-	}
-	spin_unlock_irqrestore(&video->req_lock, flags);
-}
-
 static void
 uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 {
@@ -375,10 +331,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_video *video = ureq->video;
 	struct uvc_video_queue *queue = &video->queue;
 	struct uvc_buffer *last_buf;
-	struct usb_request *to_queue = req;
 	unsigned long flags;
-	bool is_bulk = video->max_payload_size;
-	int ret = 0;
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	atomic_dec(&video->queued);
@@ -441,65 +394,85 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
+	list_add_tail(&req->list, &video->req_free);
 	/*
-	 * Here we check whether any request is available in the ready
-	 * list. If it is, queue it to the ep and add the current
-	 * usb_request to the req_free list - for video_pump to fill in.
-	 * Otherwise, just use the current usb_request to queue a 0
-	 * length request to the ep. Since we always add to the req_free
-	 * list if we dequeue from the ready list, there will never
-	 * be a situation where the req_free list is completely out of
-	 * requests and cannot recover.
+	 * Queue work to the wq as well since it is possible that a
+	 * buffer may not have been completely encoded with the set of
+	 * in-flight usb requests for whih the complete callbacks are
+	 * firing.
+	 * In that case, if we do not queue work to the worker thread,
+	 * the buffer will never be marked as complete - and therefore
+	 * not be returned to userpsace. As a result,
+	 * dequeue -> queue -> dequeue flow of uvc buffers will not
+	 * happen. Since there are is a new free request wake up the pump.
 	 */
-	to_queue->length = 0;
-	if (!list_empty(&video->req_ready)) {
-		to_queue = list_first_entry(&video->req_ready,
-			struct usb_request, list);
-		list_del(&to_queue->list);
-		list_add_tail(&req->list, &video->req_free);
-		/*
-		 * Queue work to the wq as well since it is possible that a
-		 * buffer may not have been completely encoded with the set of
-		 * in-flight usb requests for whih the complete callbacks are
-		 * firing.
-		 * In that case, if we do not queue work to the worker thread,
-		 * the buffer will never be marked as complete - and therefore
-		 * not be returned to userpsace. As a result,
-		 * dequeue -> queue -> dequeue flow of uvc buffers will not
-		 * happen.
-		 */
-		queue_work(video->async_wq, &video->pump);
-	} else if (atomic_read(&video->queued) > UVCG_REQ_MAX_ZERO_COUNT) {
-		list_add_tail(&to_queue->list, &video->req_free);
-		/*
-		 * There is a new free request - wake up the pump.
-		 */
-		queue_work(video->async_wq, &video->pump);
+	queue_work(video->async_wq, &video->pump);
 
-		spin_unlock_irqrestore(&video->req_lock, flags);
+	spin_unlock_irqrestore(&video->req_lock, flags);
 
-		return;
-	}
-	/*
-	 * Queue to the endpoint. The actual queueing to ep will
-	 * only happen on one thread - the async_wq for bulk endpoints
-	 * and this thread for isoc endpoints.
-	 */
-	ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
-	if (ret < 0) {
+	kthread_queue_work(video->kworker, &video->hw_submit);
+}
+
+static void uvcg_video_hw_submit(struct kthread_work *work)
+{
+	struct uvc_video *video = container_of(work, struct uvc_video, hw_submit);
+	bool is_bulk = video->max_payload_size;
+	unsigned long flags;
+	struct usb_request *req;
+	int ret = 0;
+
+	while (true) {
+		if (!video->ep->enabled)
+			return;
+		spin_lock_irqsave(&video->req_lock, flags);
 		/*
-		 * Endpoint error, but the stream is still enabled.
-		 * Put request back in req_free for it to be cleaned
-		 * up later.
+		 * Here we check whether any request is available in the ready
+		 * list. If it is, queue it to the ep and add the current
+		 * usb_request to the req_free list - for video_pump to fill in.
+		 * Otherwise, just use the current usb_request to queue a 0
+		 * length request to the ep. Since we always add to the req_free
+		 * list if we dequeue from the ready list, there will never
+		 * be a situation where the req_free list is completely out of
+		 * requests and cannot recover.
 		 */
-		list_add_tail(&to_queue->list, &video->req_free);
+		if (!list_empty(&video->req_ready)) {
+			req = list_first_entry(&video->req_ready,
+					       struct usb_request, list);
+		} else {
+			if (list_empty(&video->req_free) ||
+			    (atomic_read(&video->queued) > UVCG_REQ_MAX_ZERO_COUNT)) {
+				spin_unlock_irqrestore(&video->req_lock, flags);
+
+				return;
+			}
+			req = list_first_entry(&video->req_free, struct usb_request,
+					       list);
+			req->length = 0;
+		}
+		list_del(&req->list);
+
 		/*
-		 * There is a new free request - wake up the pump.
+		 * Queue to the endpoint. The actual queueing to ep will
+		 * only happen on one thread - the async_wq for bulk endpoints
+		 * and this thread for isoc endpoints.
 		 */
-		queue_work(video->async_wq, &video->pump);
-	}
+		ret = uvcg_video_usb_req_queue(video, req, !is_bulk);
+		if (ret < 0) {
+			/*
+			 * Endpoint error, but the stream is still enabled.
+			 * Put request back in req_free for it to be cleaned
+			 * up later.
+			 */
+			list_add_tail(&req->list, &video->req_free);
+			/*
+			 * There is a new free request - wake up the pump.
+			 */
+			queue_work(video->async_wq, &video->pump);
 
-	spin_unlock_irqrestore(&video->req_lock, flags);
+		}
+
+		spin_unlock_irqrestore(&video->req_lock, flags);
+	}
 }
 
 static int
@@ -771,7 +744,7 @@ int uvcg_video_enable(struct uvc_video *video)
 
 	atomic_set(&video->queued, 0);
 
-	uvc_video_ep_queue_initial_requests(video);
+	kthread_queue_work(video->kworker, &video->hw_submit);
 	queue_work(video->async_wq, &video->pump);
 
 	return ret;
@@ -794,6 +767,17 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	if (!video->async_wq)
 		return -EINVAL;
 
+	/* Allocate a kthread for asynchronous hw submit handler. */
+	video->kworker = kthread_create_worker(0, "UVCG");
+	if (IS_ERR(video->kworker)) {
+		uvcg_err(&video->uvc->func, "failed to create UVCG kworker\n");
+		return PTR_ERR(video->kworker);
+	}
+
+	kthread_init_work(&video->hw_submit, uvcg_video_hw_submit);
+
+	sched_set_fifo(video->kworker->task);
+
 	video->uvc = uvc;
 	video->fcc = V4L2_PIX_FMT_YUYV;
 	video->bpp = 16;

-- 
2.39.5



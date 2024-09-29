Return-Path: <linux-kernel+bounces-343128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D1989705
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C6F1C21AAB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F777185B71;
	Sun, 29 Sep 2024 18:59:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4955E48
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636382; cv=none; b=VyE3jYCqmHed2WTrPZ6erdQi7dawfguHPMdFAll2QSssdI55bnWLJxKlQ1v3+Bv0bVSkUDxsviTFiBEIHjtwYtS9txd6NsjV+hhem6Axpl8krLhr419YzmeeR4HyVRAaR3/MkQ6r2wQfmi3Usb1GZ1O17UxZihupzXlTzeJuNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636382; c=relaxed/simple;
	bh=tqEAc4G4g5DANBIiYnngjMwLHhsQQN7FAdkIiAeqdto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGZiYJyQSYXC3D4Rev978rfAHX2pUXetuG5Pm/UzCDzH6NrYR40meyAlu7PRejunx9ZdwVv3L7iU2yXsGKdFtikKE2F6mKuiqYQz/VN+Q8lwNsGU6cSnknxdi/+mP6+O7f1YJNzWyVA8832ihkDmhkEIwsVZ/GaQjzFpYEeUNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053u-KM; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-002Ro5-0m; Sun, 29 Sep 2024 20:59:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-2x;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 20:59:23 +0200
Subject: [PATCH v6 3/9] usb: gadget: uvc: rework to enqueue in pump worker
 from encoded queue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v6-3-08c05522e1f5@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10792;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=tqEAc4G4g5DANBIiYnngjMwLHhsQQN7FAdkIiAeqdto=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aOQN/n0sMwL6+6ej/Bdp2EhaSyh8Kmbxterp
 AgboMcxWoSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjkAAKCRC/aVhE+XH0
 q4S1D/9/GTbNFgXjvAaRMd31R03/Xj1KhLIFy6T4XlPlKldjD1oTEbbldNgQv0RXEHTwaEGibHh
 HtflYw3OPbjt/E8axdXhRbv0pDg8k0Hriw/odtnHRBgjM0alKhuUmLWkyQ58pFMvOinMwDzH4YJ
 2IqfUWF+YwSkS+OogtCCzEiB5m/nJnBzGtQzCSD+MiyhVOkNGvKQ5KCxcbMn2ocj5LRqsyLMtlg
 xxFFMhnRbvNX/jLaNsA4zf+VJnLKy4CkMW58Vz2+ze01Rdb84kHg06Gbup59APHgC/bqKEySaNw
 s6yUQzsscDj3EZoSD8pX/TEUZplrUYwVB7TjlGqr2TNCvS7G0laXPoAjtctq2UkBck2Lxy0RTGG
 HpTRH6bbKyxcK/EHYgUMqTHtnPxyk/F7EztzzD1VMDxbtY4hOO0vwGMw98LxJ0RAfcDqm1qEhX2
 xi5rtz1KbES/byWUpNBdPsUgmYaFwD5/oN2bVLX8q50/sHoBWDYMZ14iGgmGCjQMXzNi2u158zH
 TJ6eLHBg+RkcnICE1sefWYhgqV7qWCDu3WPdSPxtlRYAbXh3FAcQuw1TG6S+RMqME6FgZuzJhMY
 3Vx46L2AEXw9bz4jMoSoHCRE1GKcnAjEKDHa6ZDG2qkxzp5swi1HyM/P49qlvmWdF2kDcDJjARq
 eQMUnXyZwkaMGvQ==
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
v5 -> v6: -
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
index eb82aaed6ba13..f43bf19218963 100644
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



Return-Path: <linux-kernel+bounces-284431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D635C9500E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575651F217CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CBD18453A;
	Tue, 13 Aug 2024 09:09:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3039174EEB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540181; cv=none; b=Z3b8kOoqzEyEbqftlfpTmeP0acXaUgkqTfc3YoWO21POfKAvy4ElshPZEvEH5hTEXS4tvCw70XdUKfNWi77cCte12AVvTACAkqbpyrUuovnSNjXHs8hqRnGFHN4bM97jChep/3ZuxenqWUC3O/D8t7A2/FmJRto6BtXDsejMQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540181; c=relaxed/simple;
	bh=SkZsPxCbDN43LHxyvk94Y4g+KqeuNu68KsIeoOP6vGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BarFNoZZ/Pg93OrWOAnlj5dnUhzhdgz8d4PDyfnuF5JroV/7EktxruUvpPgGl7xNd3j8AFalcdRAAazRuTxXJswsyn+d36U7CyKQ35c6FZKS2b9RdKZikNSJmV5H2sap42zK/Vv0jF3TpuwOu0BzrLgcX+nQNVskp4rZ5+NEnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CN-SE; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005oi-7a; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0J;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:28 +0200
Subject: [PATCH v4 04/10] usb: gadget: uvc: rework to enqueue in pump
 worker from encoded queue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-4-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8172;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=SkZsPxCbDN43LHxyvk94Y4g+KqeuNu68KsIeoOP6vGM=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLLLQ+WRpi7mVeN6VsERbrrfYXqlJ37Ck25d
 d3p6cd9Cw6JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsiywAKCRC/aVhE+XH0
 qw9oEACynR6NT41ltfX2ipnDFkcOH0Ik4WVCrEvYvnziPQOaJhQhODs45BiG0iOtXvV7y23WeNI
 bPIesIXgXbipv1Lv7qEUzI+jLAHlk+xx03B4WUOETfSt8an9sNNmhryo16Jn7DCBU6A6+k4eKgw
 ZvBfCiqvhyXSClZPQp1cRle5ODZoQkFDGpViGtRJksOkWbpL4oqZtgNVQCi6JIdexgydQGygOn0
 UiXGs2ha3yQGYtu2ypmkHxXwzBsUxSUQemLVEvV/k+Q22N0zDdXkYE+yjzUjDgCETV/haAfNlnJ
 ypMEgN9GpM+VvOiGZE4PEnjxXumyhnZmHNGLhnREJNx0odm2w74/oYFTs6BEfB6kxqEma6yWhK+
 lAW/430MogLawfyKeJlU1pmUCqkSR73OdkejfKspA1vMLpY/0+tYznWgm736GeVffpqlexAncQn
 CvQaNkdhfqrDWvZZy/BlvD965yrMi2mNhRUv4GVFy5sxIExE7XGRKJWDn/FtrseWEjurFmzYSGU
 0J/AC+sG7q2DbQC/Tp1DSEQuEKUxUfxocvCpyjTRkvGZPiTn3/eb7gz9xaasNAuPmr3ilDrc5df
 8n/s+zs/QEOylrk4OXVwtnbDMSFa6BK7Rvb76KO+L4Z9iHiI0x1QDTscIrXUd/MfcA5chitRHdf
 5+7A3sTAkVFWrQw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

We install an kthread with pfifo prioroity that is iterating over all
prepared requests and keeps the isoc queue busy. It also watches the
theshold to enqueue zero length requests if needed. This way it will be
scheduled with the same priority as the interrupt handler.

But the interrupt handler will not be running into the time consuming
and eventually locking work of actually enqueueing the requests back
into its own pipeline. This work can now even can be scheduled on
another cpu.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v3 -> v4: -
v1 -> v3: new patch
---
 drivers/usb/gadget/function/f_uvc.c     |   3 +
 drivers/usb/gadget/function/uvc.h       |   3 +
 drivers/usb/gadget/function/uvc_v4l2.c  |   3 +
 drivers/usb/gadget/function/uvc_video.c | 118 ++++++++++++++++++++------------
 4 files changed, 84 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index aeaf355a86eb3..1609daf85a258 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -986,10 +986,13 @@ static void uvc_function_unbind(struct usb_configuration *c,
 {
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
+	struct uvc_video *video = &uvc->video;
 	long wait_ret = 1;
 
 	uvcg_info(f, "%s()\n", __func__);
 
+	kthread_cancel_work_sync(&video->pump);
+
 	/*
 	 * If we know we're connected via v4l2, then there should be a cleanup
 	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index e252c3db73072..b3a5165ac70ec 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -88,6 +88,9 @@ struct uvc_video {
 	struct uvc_device *uvc;
 	struct usb_ep *ep;
 
+	struct kthread_worker	*kworker;
+	struct kthread_work	pump;
+
 	int enqueued;
 	int dequeued;
 
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 4085f459c3c70..de41519ce9aa0 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -429,6 +429,9 @@ uvc_v4l2_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
 	if (ret < 0)
 		return ret;
 
+	if (uvc->state == UVC_STATE_STREAMING)
+		kthread_queue_work(video->kworker, &video->pump);
+
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 5b0bf8069d48f..a51e95e3b717c 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -376,10 +376,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_video *video = ureq->video;
 	struct uvc_video_queue *queue = &video->queue;
 	struct uvc_buffer *last_buf;
-	struct usb_request *to_queue = req;
 	unsigned long flags;
-	bool is_bulk = video->max_payload_size;
-	int ret = 0;
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	video->dequeued++;
@@ -442,54 +439,78 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
+	list_add_tail(&req->list, &video->req_free);
+
+	spin_unlock_irqrestore(&video->req_lock, flags);
+
 	/*
-	 * Here we check whether any request is available in the ready
-	 * list. If it is, queue it to the ep and add the current
-	 * usb_request to the req_free list - for qbuf to fill in.
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
+	 * happen.
 	 */
-	to_queue->length = 0;
-	if (!list_empty(&video->req_ready)) {
-		to_queue = list_first_entry(&video->req_ready,
-			struct usb_request, list);
-		list_del(&to_queue->list);
-		list_add_tail(&req->list, &video->req_free);
+	kthread_queue_work(video->kworker, &video->pump);
+}
+
+static void uvcg_video_pump(struct kthread_work *work)
+{
+	struct uvc_video *video = container_of(work, struct uvc_video, pump);
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
-		 * Queue work to the wq as well since it is possible that a
-		 * buffer may not have been completely encoded with the set of
-		 * in-flight usb requests for whih the complete callbacks are
-		 * firing.
-		 * In that case, if we do not queue work to the worker thread,
-		 * the buffer will never be marked as complete - and therefore
-		 * not be returned to userpsace. As a result,
-		 * dequeue -> queue -> dequeue flow of uvc buffers will not
-		 * happen.
+		 * Here we check whether any request is available in the ready
+		 * list. If it is, queue it to the ep and add the current
+		 * usb_request to the req_free list - for video_pump to fill in.
+		 * Otherwise, just use the current usb_request to queue a 0
+		 * length request to the ep. Since we always add to the req_free
+		 * list if we dequeue from the ready list, there will never
+		 * be a situation where the req_free list is completely out of
+		 * requests and cannot recover.
 		 */
-	} else if ((video->enqueued - video->dequeued) > 32) {
-		spin_unlock_irqrestore(&video->req_lock, flags);
+		if (!list_empty(&video->req_ready)) {
+			req = list_first_entry(&video->req_ready,
+					       struct usb_request, list);
+		} else {
+			if (list_empty(&video->req_free) || (video->enqueued - video->dequeued) > 32) {
+				spin_unlock_irqrestore(&video->req_lock, flags);
+
+				return;
+			}
+			req = list_first_entry(&video->req_free, struct usb_request,
+					       list);
+			req->length = 0;
+		}
+		list_del(&req->list);
 
-		return;
-	}
-	/*
-	 * Queue to the endpoint. The actual queueing to ep will
-	 * only happen on one thread - the async_wq for bulk endpoints
-	 * and this thread for isoc endpoints.
-	 */
-	ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
-	if (ret < 0) {
 		/*
-		 * Endpoint error, but the stream is still enabled.
-		 * Put request back in req_free for it to be cleaned
-		 * up later.
+		 * Queue to the endpoint. The actual queueing to ep will
+		 * only happen on one thread - the async_wq for bulk endpoints
+		 * and this thread for isoc endpoints.
 		 */
-		list_add_tail(&to_queue->list, &video->req_free);
-	}
+		ret = uvcg_video_usb_req_queue(video, req, !is_bulk);
+		if (ret < 0) {
+			/*
+			 * Endpoint error, but the stream is still enabled.
+			 * Put request back in req_free for it to be cleaned
+			 * up later.
+			 */
+			list_add_tail(&req->list, &video->req_free);
+		}
 
-	spin_unlock_irqrestore(&video->req_lock, flags);
+		spin_unlock_irqrestore(&video->req_lock, flags);
+	}
 }
 
 static int
@@ -755,6 +776,17 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	INIT_LIST_HEAD(&video->req_ready);
 	spin_lock_init(&video->req_lock);
 
+	/* Allocate a work queue for asynchronous video pump handler. */
+	video->kworker = kthread_create_worker(0, "UVCG");
+	if (IS_ERR(video->kworker)) {
+		uvcg_err(&video->uvc->func, "failed to create message pump kworker\n");
+		return PTR_ERR(video->kworker);
+	}
+
+	kthread_init_work(&video->pump, uvcg_video_pump);
+
+	sched_set_fifo(video->kworker->task);
+
 	video->uvc = uvc;
 	video->fcc = V4L2_PIX_FMT_YUYV;
 	video->bpp = 16;

-- 
2.39.2



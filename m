Return-Path: <linux-kernel+bounces-341164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B0987BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8876A280D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646231B2ED4;
	Thu, 26 Sep 2024 23:37:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAA1B07C3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393874; cv=none; b=WI2VkL3ZRTFaQ69GFGHUaiIdAUaSguJ6oNx/2zJbTpnerdg3rVbO2u3Ctp0q1uykRqtQ23FoueQAmaCWAbwdJlJ99QmXZjcv5c7ydcFz/Zv5EzgvXfWllSRmFNjcWYLtvc+2USfWzrtYitXaPelMrUU1kQ2lu/rdaWkEvzYn8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393874; c=relaxed/simple;
	bh=TQh5etl5nIijawyn7zhFuQ1u9gYq3NJFYxbxyXSOgDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyFBL1p9yDLGwo2IhpdTorgBdavMCQp1Dj5RUZjmMMcBvH/3IRpRvBA+5vL9M5DUU4vckl0L8srQ2gk4Au8HaEVoMZj31uWkkD9njVVfRG5KRsjzb2v+Sot9+wTvW9wTM4VnzrrVZdYlf72VTQKd5je3+2R6l1bLBsGaAqmSWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3N-0007WK-0F; Fri, 27 Sep 2024 01:37:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-001nOT-Dx; Fri, 27 Sep 2024 01:37:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3L-005IAz-2t;
	Fri, 27 Sep 2024 01:37:44 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 27 Sep 2024 01:37:41 +0200
Subject: [PATCH v5 2/9] usb: gadget: uvc: only enqueue zero length requests
 in potential underrun
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v5-2-2de78794365c@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=TQh5etl5nIijawyn7zhFuQ1u9gYq3NJFYxbxyXSOgDQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm9fBF//QA6EV7T8iUSotsdn91e8fIxWUibO7lj
 1soIvjgwDKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvXwRQAKCRC/aVhE+XH0
 qxkZD/wLxyxVSrFO3Wslyn000Cra4ZoFDxksNZVrd3l0Tr72bg4FWjk49o9vhnADGcJZs1nqv5Y
 L8iZi6dXHh2c7u2FPvRmYgpNAHGePxwYGYueIBgDHgGHxz0kdTHAdCmGfTVm+eKzfLLsaZfvwrE
 OieSB4lFNFjTWTE8YZDn+VviS7w6M20tEpSbmKfS47WkHB5+QUJPu5K7Py7YNiP23SiOVbUTqwL
 1QXBKAoCohv0PDAk3TMafiN3Avz+4Vh87Y5vcgNxQjTLRh7fFPNOLyj5apkf4bcMXBUR6yHkjIO
 RqQMCv7eCQZ6//65GtMwAYCJp160vp0wR1DAuGVpmIJBhPeQ4hktEKOVWmgbsVgA68ZXWoHy+7l
 YS0MmZ+6W/Y48OlAROWgKCYItVWzLH5hsyOJCF+fgBnrfRol4h46L7DINSttN0Olito6jCiYcEm
 FuIWwyHg6fm1W+qqn2lUgoNoH32RfBnMNYGkRDSCjurCQdgvUUf6EERfBi7mvbFDWB/NqYMvq7U
 /Ns3oDSlHxUITddAVWIUqwMVjOlL07fuUIbNEhwRV5f1MUM69QBHBBzLPZrp4/sX3V4jjQDTPVk
 vH8X2Mu2H46hT+3r8PJVPHEUS6N4YurbUWvTATpFsYrnk/j2a95SNQzAF9a0WFjhPqMXESYUd5B
 vbG1f94I2o+Ka2w==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The complete handler will at least be called after 16 requests have
completed, but will still handle all finisher requests. Since we have
to maintain a costant filling in the isoc queue we ensure this by
adding zero length requests.

By counting the amount enqueued requests we can ensure that the queue is
never underrun and only need to get active if the queue is running
critical. This patch is setting 32 as the critical level, which
is twice the request amount that is needed to create interrupts.

To properly solve the amount of zero length requests that needs to
be held in the hardware after one interrupt needs to be measured
and depends on the runtime of the first enqueue run after the interrupt
triggered. For now we just use twice the amount of requests between an
interrupt.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v4 -> v5: -
 - using min to limit for UVCG_REQ_MAX_INT_COUNT as the interrupt boundary
 - using atomic_inc, atomic_dec on one variable to avoid rollover
 - reordered this patch in the series
 - added UVCG_REQ_MAX_ZERO_COUNT to set the threshold of zero length
   requests in the hw
 - added UVCG_REQ_MAX_INT_COUNT as quantifier for the
   highest amount of request between an interrupt
v1 -> v4: -
---
 drivers/usb/gadget/function/uvc.h       |  5 +++++
 drivers/usb/gadget/function/uvc_video.c | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index cb35687b11e7e..55d796f5f5e8d 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -71,6 +71,9 @@ extern unsigned int uvc_gadget_trace_param;
 
 #define UVCG_REQUEST_HEADER_LEN			12
 
+#define UVCG_REQ_MAX_INT_COUNT			16
+#define UVCG_REQ_MAX_ZERO_COUNT			(2 * UVCG_REQ_MAX_INT_COUNT)
+
 /* ------------------------------------------------------------------------
  * Structures
  */
@@ -91,6 +94,8 @@ struct uvc_video {
 	struct work_struct pump;
 	struct workqueue_struct *async_wq;
 
+	atomic_t queued;
+
 	/* Frame parameters */
 	u8 bpp;
 	u32 fcc;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 48fd8d3c50b0c..eb82aaed6ba13 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -269,6 +269,8 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 		}
 	}
 
+	atomic_inc(&video->queued);
+
 	return ret;
 }
 
@@ -304,7 +306,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
 		 */
 		if (list_empty(&video->req_free) || ureq->last_buf ||
 			!(video->req_int_count %
-			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
+			min(DIV_ROUND_UP(video->uvc_num_requests, 4), UVCG_REQ_MAX_INT_COUNT))) {
 			video->req_int_count = 0;
 			req->no_interrupt = 0;
 		} else {
@@ -379,6 +381,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	int ret = 0;
 
 	spin_lock_irqsave(&video->req_lock, flags);
+	atomic_dec(&video->queued);
 	if (!video->is_enabled) {
 		/*
 		 * When is_enabled is false, uvcg_video_disable() ensures
@@ -466,6 +469,16 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		 * happen.
 		 */
 		queue_work(video->async_wq, &video->pump);
+	} else if (atomic_read(&video->queued) > UVCG_REQ_MAX_ZERO_COUNT) {
+		list_add_tail(&to_queue->list, &video->req_free);
+		/*
+		 * There is a new free request - wake up the pump.
+		 */
+		queue_work(video->async_wq, &video->pump);
+
+		spin_unlock_irqrestore(&video->req_lock, flags);
+
+		return;
 	}
 	/*
 	 * Queue to the endpoint. The actual queueing to ep will
@@ -756,6 +769,8 @@ int uvcg_video_enable(struct uvc_video *video)
 
 	video->req_int_count = 0;
 
+	atomic_set(&video->queued, 0);
+
 	uvc_video_ep_queue_initial_requests(video);
 	queue_work(video->async_wq, &video->pump);
 

-- 
2.39.5



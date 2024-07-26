Return-Path: <linux-kernel+bounces-263792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D893DA8A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4612B1C233C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE31153BC1;
	Fri, 26 Jul 2024 22:02:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A114A09F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031379; cv=none; b=PCBQraeXZyV4xOhVWgllUsHM+vIZ58s7C5vd/whFG+89ow8GvIpmFneTHLqTSxzRtVE2qQUtiBpaDZKaF1Ck2HK7MHLMId7qdLuCylitTzdcdzUH8XkHNxb1d8KwvaPXj2l0XXt2C1Hj2A6BFvL4R2I/ZH2TehOMKdVCibkS6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031379; c=relaxed/simple;
	bh=toGTO7Y0GTVk2fkauRz++GP/r0GYyNqYRHF8xHVsB1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hM3iGI+lpuvP8Dz5dtDAgM1X0wmnp5Gegvh74W/XVn7XFfEzUr8BXzc8gkw66rO+nWlFYGSK4KPSqhy9TsB9V+aFEkluJEVH002NqrhUCinfGLe3rbTA8Bx2T08s25OqzxzTgFyd7Njs9FyI58DMdCYrLCdT9WOhmvqJBPYsyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1Q-0005Mm-RE; Sat, 27 Jul 2024 00:02:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-002Qhx-UX; Sat, 27 Jul 2024 00:02:43 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-00FdLn-2e;
	Sat, 27 Jul 2024 00:02:43 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sat, 27 Jul 2024 00:02:40 +0200
Subject: [PATCH v3 05/10] usb: gadget: uvc: remove
 uvc_video_ep_queue_initial_requests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v3-5-4da7033dd488@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=toGTO7Y0GTVk2fkauRz++GP/r0GYyNqYRHF8xHVsB1w=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmpB0BGyY/DsH7t65QxxYphVc5f6oKZh6k2fft9
 EDfB52lj0qJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZqQdAQAKCRC/aVhE+XH0
 q+JJEACsTAyocFRKtYeFZuT2bmOzFbKFgChfP/9HI/JoYwxz20Mx2wzkYal1LE3BqIZzS0WJPRc
 0MnSLyfpzkbwczgc1rLSa0whr1W3VrjipQc0tbghnTlJrLeqkljxWMo3x1TytywzJNCdHVHHYBz
 ZtabZcpZ9/yn0unqbs/7QPsOfOuQEi+I/fG9QSFRrS8gg+/mPUrZRCrDAuZJw5rJYfDDCcu9dLd
 5cgrSNzinvol+2FNaPi+cHD/fxk0d2nUvZPBPPa4y+HG5YxGyiDgW41Xak1FJLbXsNqBWPl2bDt
 v3U6V5tOvPEvblMD7EmhhibIFYYnKXAygJ3RacKT3SygGewWmFiHJysG4z2JWBAfDWUuRT9vepi
 oAqbopdyy4bQSH8fzfL1wCZ6Y3lApS2FjCHDFiXUQYgcE+zpWrPmSO0Vc+yMXeQSas11X1E8gqI
 MAIgT6GRIi6q7EtXtE0Sivq9Pi39Yi5ixCm5oEesgezSO+ePqew6MqpKFkM8Ddi2KUYHTN4QDXq
 w/glWl7Gdnd1lU+hG9fgD+rbKWuixt6qidSIb0zX2LuynrlemZ/m/4o6T00MIiJV3/6zBojZ1Vg
 cPJk2oCl95LJuiZsVnOwnmELJzlwBBHskP5Z5fdoWZGmvYHw+UoozHxUkIeIlUQyJqLQtf5VlE8
 lCxCX8RzP5wsIAA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

By moving the buffer enqueing to an extra worker and not
enqueueing the each request by its corresponding complete
interrupt, we can remove the initial amount of zero length requests.

As soon as real data is available the isoc queue will be filled
as much as possible.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v1 -> v3: new patch
---
 drivers/usb/gadget/function/uvc_video.c | 46 ---------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index a0448f8e8f334..463777b5db6ff 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -325,50 +325,6 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
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
@@ -755,8 +711,6 @@ int uvcg_video_enable(struct uvc_video *video)
 
 	video->req_int_count = 0;
 
-	uvc_video_ep_queue_initial_requests(video);
-
 	return ret;
 }
 

-- 
2.39.2



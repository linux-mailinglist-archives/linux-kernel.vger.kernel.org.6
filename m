Return-Path: <linux-kernel+bounces-284438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B19500F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051411F23677
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9419B3F9;
	Tue, 13 Aug 2024 09:09:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AC175D26
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540182; cv=none; b=FNlqAddr/hdZ2MAG3M3NgBGF5BOfRYN5Kzq/psSh4YMAwe9cVyaxJzbEPC181e6JAQ7R0m9z+BQ2UvaguyInZk1MMYpG8lDZ3de5q4nvAqKYXp8yQR+hjt83FMjOAMQdFO6NCrS4W+EK2gFQnTOVUSRDdm3hGQNP4bzkac+dHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540182; c=relaxed/simple;
	bh=bU0k/xA07ACWz48gmJ42M7Hs1NAUBpxOmkkbzuZRjN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLOCXS1MW2a2t1BjizHhGgfbgWablKxOt/0Cc9KqxEAvvMACnn6HP88t2a39uelWQ07rt3xTcIZwspBhpJmrrrtJOMmfa8KHjLSlrryjenCi1IB85NG6VYeF3JswTn2CcGiFb6XNRzMYOxvW9K3bijhg2lH2qYDtEy9S3NuAmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CM-SF; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005oj-6p; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0K;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:29 +0200
Subject: [PATCH v4 05/10] usb: gadget: uvc: remove
 uvc_video_ep_queue_initial_requests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-5-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=bU0k/xA07ACWz48gmJ42M7Hs1NAUBpxOmkkbzuZRjN8=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLMTSl44hvf3GoKX7pI+zynBN69r+UQKm880
 jmhC+CVow+JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsizAAKCRC/aVhE+XH0
 qxLQEACbMBbolqOo1GGLT8rKUlXOH//bO16YaFaMvajC94L6p2zk5LaJiglZ+qNrYK+psyLbdbY
 sGtmJJ6iQjwqLrFU86G4Xyem2aU2YGI9kP55wd+JauWzcs3GK/IJjz23JUBamEi42aXM4f8GPB/
 tf4edTnRtoaX4ISK5vJaa0th0ObUH+/ibk0d7imFk+bcBgnsSeL/TKhS3G3F0ZmSm5B8qIihFZN
 amGcVEEPKwo9sl66BBUXBIFAEenLGY86+LfnskxyT3U1y0o5KM3eVmLNS70zqsDtTJAirz2qfyE
 15Bh3I/8RNOlE/tk1x3AZP/v/XnVLmcVColp5kqLSQlhaitYe+9VmxDcBmmozvY72nezBdtDJZa
 YTpruc2vK1D9FCPO+Hl6yWYakhu60dD/LRBYqqz54d6bicVbN6/RO4DVJLZ5C4kC9/6WcN/REeL
 2qsQP1NJLSd/odIzGLwhA0AHXFnH8i/fsU1zFly1psl/164xE61BgQ8GxJ+qpHfOUjWLYu1qwQR
 eNsXzS6K2axUtLb68WktjvT7iaFJz0H98VWUoRwb2kbJdOjeZ5Kw3emtnPmJg/1KYTtV/bxODo5
 P7T6Vy2h17/IV0YZHt/0b/PbgLKcxYRRcSqpUq/ofXTcEkqkXMR0adGwbfV5h94e+JtpjNnNZ+v
 6JUMNoaTp69lERg==
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
v3 -> v4: -
v1 -> v3: new patch
---
 drivers/usb/gadget/function/uvc_video.c | 46 ---------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index a51e95e3b717c..259920ae36843 100644
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
@@ -760,8 +716,6 @@ int uvcg_video_enable(struct uvc_video *video)
 
 	video->req_int_count = 0;
 
-	uvc_video_ep_queue_initial_requests(video);
-
 	return ret;
 }
 

-- 
2.39.2



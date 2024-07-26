Return-Path: <linux-kernel+bounces-263794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DA93DA8D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848B41F2127E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153F154454;
	Fri, 26 Jul 2024 22:02:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE01214A4FB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031379; cv=none; b=QKePmq/nN7M74Of69jow8Baa44ZG0eqQle9/ZtidkGB7RQUKYNpDU+GjeC7bDDd76i1KIN/ZMu69F/cSDDzW3ichmvo262PWRMWfUMLHAiB3P9AyTaAVhbcAS3Y1OPPoir2jzbYuuaisNK4xzyD6HHUrceRL50pXDUK3fXY+kTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031379; c=relaxed/simple;
	bh=2cdHVqHAzmPhViiTiJfqBs6awqwnWOp3F22KKYxab9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khagnyu/8Uvzw7dwYeRXmfvDyjxvJIK4kRxDb36SBKOnUZb+tEv+1imAAUv27FukFX8a7+xZWDq6HXSODENyuMAyxYVAnoy0EjFtW4l6HY7adY3oghO6c01OQO2kJmNz4FcotnOOD5T5jeSH/ZorL0O63ZioBNgxfsaPUd1rsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1Q-0005Mu-RD; Sat, 27 Jul 2024 00:02:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-002Qhy-W7; Sat, 27 Jul 2024 00:02:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-00FdLn-2f;
	Sat, 27 Jul 2024 00:02:43 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sat, 27 Jul 2024 00:02:41 +0200
Subject: [PATCH v3 06/10] usb: gadget: uvc: set req_size once when the vb2
 queue is calculated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v3-6-4da7033dd488@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=2cdHVqHAzmPhViiTiJfqBs6awqwnWOp3F22KKYxab9c=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmpB0CigTP7a6ATBe0DOlEpSLqxJ9bWgeYmgTKv
 EJmPpi3+7uJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZqQdAgAKCRC/aVhE+XH0
 q7QHD/4tayZzs7J42eKo0bexh43q6jOSkDfIuS6Oj7Bu3jg2J6CcpnjRFPIiDYQw9taEX/gqTMs
 nR+8ECMQpYrqH58IcZdXMwzlDvvhP/jVe97rCEoXJAqg7F51JjTkZUzHLIKRkkSyBVasr/fUnMX
 x48VdGSHOelz7bka12DbpnRG9/ACF7LKQHD3o32CS0XvFy3grRjsYUyjpwHL9mFRCRTdomYaw+J
 9gz1kW0nerQFBL8uLjx3OiFWonlUbas2lZ6bAbqUHXvq5aHKFujYmkSidccLIaLR2TErXd9v722
 JrFIbN7paHpcoKr6XEL2gJRfP0maqKoofAR96SiIEk1qaM6+s4k/v0cbiTxUXF3fSdvDyOtyuGJ
 OdxxD67Ixb+iSdXfuroA973oNwUHQ7t7sC2dRsXYqpaRE9spv28vrONipUv4D3gFD9+HFbchgu4
 2unklUU3psEIE/O4bqT1NqbzACHFwauXSqWsM+ACe/DBXj0PSQC3VTIistIRKjFeCCtIBXPmMGY
 6L9wCLcjYTtR9WOPk/PxEPax3tD261rVBVRxopGGk9fJ/Trl+lx9Yte9HygEVVG7mlT7fjG2An3
 To5sXo9vyCozZVGB4mLtBqPcC6PNp76f0dsXq2PYLUxCKuqoAqKd1UVoLIBHTCHQv8ytSvLYdB3
 dDLXJ+6Fg2Oj4zA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The uvc gadget driver is calculating the req_size on every
video_enable/alloc_request and is based on the fixed configfs parameters
maxpacket, maxburst and mult.

As those parameters can not be changed once the gadget is started and
the same calculation is done already early on the
vb2_streamon/queue_setup path its save to remove one extra calculation
and reuse the calculation from uvc_queue_setup for the allocation step.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v2 -> v3: -
v1 -> v2: -
---
 drivers/usb/gadget/function/uvc_queue.c |  2 ++
 drivers/usb/gadget/function/uvc_video.c | 15 ++-------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 7995dd3fef184..2414d78b031f4 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -63,6 +63,8 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 	 */
 	nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
 	nreq = clamp(nreq, 4U, 64U);
+
+	video->req_size = req_size;
 	video->uvc_num_requests = nreq;
 
 	return 0;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 463777b5db6ff..9d3cfa96b1350 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -480,7 +480,6 @@ uvc_video_free_requests(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	return 0;
 }
 
@@ -488,16 +487,9 @@ static int
 uvc_video_alloc_requests(struct uvc_video *video)
 {
 	struct uvc_request *ureq;
-	unsigned int req_size;
 	unsigned int i;
 	int ret = -ENOMEM;
 
-	BUG_ON(video->req_size);
-
-	req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
-
 	for (i = 0; i < video->uvc_num_requests; i++) {
 		ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
 		if (ureq == NULL)
@@ -507,7 +499,7 @@ uvc_video_alloc_requests(struct uvc_video *video)
 
 		list_add_tail(&ureq->list, &video->ureqs);
 
-		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
+		ureq->req_buffer = kmalloc(video->req_size, GFP_KERNEL);
 		if (ureq->req_buffer == NULL)
 			goto error;
 
@@ -525,12 +517,10 @@ uvc_video_alloc_requests(struct uvc_video *video)
 		list_add_tail(&ureq->req->list, &video->req_free);
 		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
 		sg_alloc_table(&ureq->sgt,
-			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
+			       DIV_ROUND_UP(video->req_size - UVCG_REQUEST_HEADER_LEN,
 					    PAGE_SIZE) + 2, GFP_KERNEL);
 	}
 
-	video->req_size = req_size;
-
 	return 0;
 
 error:
@@ -658,7 +648,6 @@ uvcg_video_disable(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
 	/*

-- 
2.39.2



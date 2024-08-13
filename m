Return-Path: <linux-kernel+bounces-284434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026FA9500EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0CDB24547
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8D51898F8;
	Tue, 13 Aug 2024 09:09:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A76176FCF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540182; cv=none; b=qP07al4CAL5YveT3Gv/mO4Jw/vI16/wmvMejqVEHkdp6rCfK0yLW6MkBfAYygRl/zpNFsk6o2OhD9mmLh95yGEKAulHhIGtRmwvTYQv4gt6ZbT0GyidjfyIOWAjd66pL5k6j+nzaRJa1r3vg6IFpxf7NL1x9RyRt9h8mk5P8zCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540182; c=relaxed/simple;
	bh=K7t59qAyTIATX7DJedngWZpU2GfYXp1lk2+YQczMvcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwuvCzk53fjob8DBekcIPYav1VEAmoJjM4MI3j8mqFMwbcQ7tNlJkkiuhDjEO0lnTxjl3rrzK7hpMr1zrKkKLqJJYlSIqW7vUFmHMRpd/9WRIQA9+guo7gHFnKRB6ni/iV4lMIhXjIhSXc1FlZs2wQbsx+jMWiRkYlmwLGx+SbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CJ-SF; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005ok-6t; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0L;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:30 +0200
Subject: [PATCH v4 06/10] usb: gadget: uvc: set req_size once when the vb2
 queue is calculated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-6-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=K7t59qAyTIATX7DJedngWZpU2GfYXp1lk2+YQczMvcs=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLMSrlkkD3TmD3KVN4id4mXSqJ0ko85jWmpD
 ju3uRie1kmJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsizAAKCRC/aVhE+XH0
 qxKgD/95caa3oirK+foxJ4+2ywouWBfIcoI+7MQISTVMuAQg2k4FzEnnqOWMlqiJMn64dykoFQ3
 +oDEqvCuLjNQ/2jcTyIHv1miQi6DnP/nWsuSm07AUiGENCVHjzmAH0fviSTANE7UTrfUFNif5Er
 yMGvi5gJGTPdDcpolhQfW741WB0j7sOG6M2JWgg9k6BuVtNlo7v4bgEaYm+MmeMnyrdtyJTrCgE
 X2fthPr1hBKjQfyTzs7tLzIu3LrViehMG/3fGipDfPac3Rr5tsN82X6b4hrR85EQNsveXfSH4KR
 irzb/LgzJw9ILX5vF7Gim2d0MeXcvSE0t6sAXLGcbh5lutbVxujSemm0TbTE1mL8buWwUzeUJ0b
 EdJ4VF/NoZuI6EOq25R06r//qDzldZ7P932Knz9Co2AAJeHV57JlWnErDGjrQoWRlUBoHumSbrP
 skrCPu485WTXPwpuIcx0h2dEaI4GkXn6STuPFd2/npj6kMhux+Wo/vIvaoqAVAlbp4Xh3vMDsjs
 z6kWgV1Kd7XYRr1p3Dar5QTz2jlru15BtXsICaEUnEDlcFNDpNB21qF+rga6/K1Ef4txoh9h8AV
 Oon9+7lVvIVj0eTHxtQyzivR+kUlFqhIZhAcT8g70PBt0/hRAp1S0+ftpj+PxNy6pIGx9k7OCAd
 QXq4qNbe38jwrUA==
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
v3 -> v4: -
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
index 259920ae36843..a6786beef91ad 100644
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
@@ -663,7 +653,6 @@ uvcg_video_disable(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
 	/*

-- 
2.39.2



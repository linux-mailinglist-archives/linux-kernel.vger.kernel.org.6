Return-Path: <linux-kernel+bounces-225892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C48F9136F7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2071F231DA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408A12B14B;
	Sat, 22 Jun 2024 23:48:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53812AAE4
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719100126; cv=none; b=dpwSSVIsBqwdFt2/DatmmW/dXS78njmRpqAtD4xdL/fj3ePszE6TbPcUFp7viTi1oZ4i+RhZ7srJacmo3i2huN0A2Q1CtJAoGXUNSgB23yxNYobaIrUs6Tuue8KQh9bplptMpjJzlpi5nw/J3G1bmgQKnDmkCuKqqp68C3szJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719100126; c=relaxed/simple;
	bh=zvzna6niCULIOsf1krFO6xX5xTvSU+BBkHM8O4pKRro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsPnlRNfVyK5B5O+eVPCC9efNPkB/Tt1pgOGNluef+xT9QxR1vgdmrnGybG/nJQDco5Xzxdej+RxZOL8pw8lVok2NipxOhRN5rAVIeGoMcanG9pie3AG/4w67bOeivhA9n5DrR0N9G6qe5wk8MFfZxYt47uQmFkTXeASACEePQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATD-0002cf-5F; Sun, 23 Jun 2024 01:48:35 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-004Hkc-Gv; Sun, 23 Jun 2024 01:48:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-000IWx-35;
	Sun, 23 Jun 2024 01:48:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 23 Jun 2024 01:48:29 +0200
Subject: [PATCH v2 1/3] usb: gadget: function: uvc: set req_size once when
 the vb2 queue is calculated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v2-1-12690f7a2eff@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=zvzna6niCULIOsf1krFO6xX5xTvSU+BBkHM8O4pKRro=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmd2LRzov2p04A9MUzQour0vyAA+sYkI5LzSBaW
 2zEThFiKvqJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZndi0QAKCRC/aVhE+XH0
 q3AID/4oWCCa5ep7GqbbfBiSNExY4njozZKlHwyji4J+P1MtmqLp1B/KNR7HefOKF+0yvVhggqs
 bfcKpDH9NpTldVJAMAXS4T4a47JgNjhHYUHgBwQ1jhdw0qsMsuEta/SWaLwE5TxOCCGTintLIz+
 PxJ60SBNej+m3oxgfQbwX6czlKv75aLk2UQ572IezV2XnubTLhcBwphgkKrG2GSj6BdOfGo5Pzi
 TC6qYAIHEgMtS5CV2A+cw1Ht+q3W1YNC+xkRKZMPbcc3zQ0yZkmfYG14Zh6P0Dl64X6Y9TPHmhl
 dDe0f/X+4FLbRht0BNapul1+RfIB/ZsiLNYrblZqPUewvQsMCR6+YoAU0sQgrpckcPeLS4+s0ca
 KMsd9UvTzRU84bvUE8611PN885B/FCBbrHhA6lgiPDZgTNgvpp2/kEb0e7J2ICk2gRjJDGQHMZQ
 T0Y2TUNXi1YaECQMbNDA3rfX7HvnDwh3vOGX8hLnmGIv4vaHXEDP2NKXSQ8cq3uW01/PdoWp5uy
 bYIhLLTiikGqMZl/RKkVwtQJQnaHSAjdZ5mJAEcOpkPZDbvarPPALZ0uamfW5E+G+jwS7+NCS0J
 vp7jC0kDgt1pWW2dXSBIIP80oTlXUD6C3omCibURyAD9F/YVhCRKLhfEQugOQu2HysVTiXGVfRY
 +OgLsrgx4yv+8TA==
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
Link to v1: https://lore.kernel.org/r/20240404-uvc_request_calc_once-v1-1-fea7fd8f0496@pengutronix.de

v1 -> v2: -
---
 drivers/usb/gadget/function/uvc_queue.c |  2 ++
 drivers/usb/gadget/function/uvc_video.c | 15 ++-------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 0aa3d7e1f3cc3..ce51643fc4639 100644
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
index d41f5f31dadd5..95bb64e16f3da 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -496,7 +496,6 @@ uvc_video_free_requests(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	return 0;
 }
 
@@ -504,16 +503,9 @@ static int
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
@@ -523,7 +515,7 @@ uvc_video_alloc_requests(struct uvc_video *video)
 
 		list_add_tail(&ureq->list, &video->ureqs);
 
-		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
+		ureq->req_buffer = kmalloc(video->req_size, GFP_KERNEL);
 		if (ureq->req_buffer == NULL)
 			goto error;
 
@@ -541,12 +533,10 @@ uvc_video_alloc_requests(struct uvc_video *video)
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
@@ -699,7 +689,6 @@ uvcg_video_disable(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
 	/*

-- 
2.39.2



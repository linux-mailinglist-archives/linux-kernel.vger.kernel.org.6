Return-Path: <linux-kernel+bounces-341158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C1987BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85C91C2178A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB31B14E7;
	Thu, 26 Sep 2024 23:37:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21421B07B1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393873; cv=none; b=DPc9+5MveEIniqjeDKhuXjFEt2GHqAMCz4TYbKfzqXxvV2khXQ9tRf9p392pOtuzN57bYmyQVu2IMs0O0EP45msS6qnMVtUnazvTAS9X8WI9PJOQHD2rgL9NjMi5M7uGbyfsRjJTp4wU9ct8AS9vNfsHeXPfyXrgv3z7WKCD69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393873; c=relaxed/simple;
	bh=KCJzkVrbX4p9KesPyrZo5pncQyB+kG1CpQ7sBxu5iMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZGG++aGbEwz8P8upnpLM8aBz8FdUgReOkt/jeMVkePKZpqJKMfUZgOKSHg5Mj3ez2J/G335Fzb2TClV1S0t6otc0zAdxohwP7xGI6MnTrIKGKIEJh3fwPJbD/IaE8onj/p4ZTg73UOEYqWvx4VitvZu2Hsla2kzQYJLzP3tlnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3N-0007WO-4J; Fri, 27 Sep 2024 01:37:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-001nOW-EF; Fri, 27 Sep 2024 01:37:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3L-005IAz-2w;
	Fri, 27 Sep 2024 01:37:44 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 27 Sep 2024 01:37:44 +0200
Subject: [PATCH v5 5/9] usb: gadget: uvc: set req_size and n_requests based
 on the frame interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v5-5-2de78794365c@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6408;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=KCJzkVrbX4p9KesPyrZo5pncQyB+kG1CpQ7sBxu5iMs=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm9fBGFy4t+EJHFvImBrY+QlhgY+LhIhazRHzIz
 Npc8Dk9vVCJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvXwRgAKCRC/aVhE+XH0
 q7dOD/9yOmHDiZh+OFpzfvBlSwcjTvaeisRmpyMbTIkFJ9SYLzs7FRXNpO4g5ipcXxQKTtpZuui
 AeaUVptm8ckzAu11iZabQ8eTS0i6mpaX5yF38rmqoTJFpKtK8D03I/p0AYBs2cmyrUuZbGIORy3
 lic4g4PWT0Q/xuvvd4URIcQ62tA95oQui7PLgN5M8q76oqC022z2JgMUaHtZLiFHqsVMZNSrg6o
 Jzprc5uVAf00FGCg1X5jplTqyrlUSDK4AOVDh3DUU5YERjoqPT3NECp66sncgC98SdoR1qbUAaT
 6LHsJDahxRrEXUIE+gRtsBs3Kuihh8LwHnNd2QRAVCvdBBTOvWd4rE5UvTfoSzWINT45Tb5R58V
 E1RbNgQxqDvRcMqnCs6suz5FySjcbiRQj8B2XCdekHiKH8/OquY48EKn/4pTBfPMX5hceZBalsz
 2UMwgudML9Q+SSxSzhu6VvHEgxjZoX0XWijF40pFdr4daRtmUHnC7zAE6v5DOs4znbA068UmkFV
 wjTuP+sE2eJ8OrbaB4ShzGXhFz8ui8KMloVSGQiBtemzSJaT/Jnf7oUT0CLZJa1ntRi5PRiKOME
 znNUmi4OkJv8PLiYsBmCCcAen+uAOl1b1Jp6XCw6D7xMSh8NvtB/N+AS06F9a9lo1aRxiC2WYQG
 U/Zm6uV/VTfD09Q==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch is removing the initial imprecise and limited calculation of
requests needed to be used from the queue_setup callback. It instead
introduces the uvc_video_prep_requests function which is called
immediately before the request allocation.

With the information of the usb frame interval length it is possible to
calculate the number of requests needed during one frame duration.

Based on the calculated number of requests and the imagesize we
calculate the actual size per request. This calculation has the benefit
that the frame data is equally distributed over all allocated requests.

When the req_size is not in the range for the actually configured
max_req_size configured for the overall bandwidth we fallback
to use the max_req_size instead.

Since this calculations are only important for isoc transfers we just
use max_request_size for bulk and skip it.

As video->req_size will be recalculated on every video_enable resetting
it to 0 is not necessary anymore.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v4 -> v5:
 - reordered this patch in the series
 - merging previous extra patch: ('usb: gadget: uvc: set req_size once when the vb2 queue is calculated')
 - moved the overall request size calculation to one seperate function
 - only calculating once before enabling the video ep
v3 -> v4: -
v2 -> v3:
 - added the frame duration for full-speed devices into calculation
v1 -> v2:
 - add headersize per request into calculation
---
 drivers/usb/gadget/function/uvc_queue.c | 13 -------
 drivers/usb/gadget/function/uvc_video.c | 68 +++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 0aa3d7e1f3cc3..731e3b9d21acc 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -44,8 +44,6 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
 	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
-	unsigned int req_size;
-	unsigned int nreq;
 
 	if (*nbuffers > UVC_MAX_VIDEO_BUFFERS)
 		*nbuffers = UVC_MAX_VIDEO_BUFFERS;
@@ -54,17 +52,6 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 
 	sizes[0] = video->imagesize;
 
-	req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
-
-	/* We divide by two, to increase the chance to run
-	 * into fewer requests for smaller framesizes.
-	 */
-	nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
-	nreq = clamp(nreq, 4U, 64U);
-	video->uvc_num_requests = nreq;
-
 	return 0;
 }
 
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 19ba18d5a42fb..4efd7585d7541 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -486,23 +486,70 @@ uvc_video_free_requests(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	return 0;
 }
 
+static void
+uvc_video_prep_requests(struct uvc_video *video)
+{
+	struct uvc_device *uvc = container_of(video, struct uvc_device, video);
+	struct usb_composite_dev *cdev = uvc->func.config->cdev;
+	unsigned int interval_duration = video->ep->desc->bInterval * 1250;
+	unsigned int max_req_size, req_size, header_size;
+	unsigned int nreq;
+
+	max_req_size = video->ep->maxpacket
+		 * max_t(unsigned int, video->ep->maxburst, 1)
+		 * (video->ep->mult);
+
+	if (!usb_endpoint_xfer_isoc(video->ep->desc)) {
+		video->req_size = max_req_size;
+		video->uvc_num_requests =
+			DIV_ROUND_UP(video->imagesize, max_req_size);
+
+		return;
+	}
+
+	if (cdev->gadget->speed < USB_SPEED_HIGH)
+		interval_duration = video->ep->desc->bInterval * 10000;
+
+	nreq = DIV_ROUND_UP(video->interval, interval_duration);
+
+	header_size = nreq * UVCG_REQUEST_HEADER_LEN;
+
+	req_size = DIV_ROUND_UP(video->imagesize + header_size, nreq);
+
+	if (req_size > max_req_size) {
+		/* The prepared interval length and expected buffer size
+		 * is not possible to stream with the currently configured
+		 * isoc bandwidth. Fallback to the maximum.
+		 */
+		req_size = max_req_size;
+	}
+	video->req_size = req_size;
+
+	/* We need to compensate the amount of requests to be
+	 * allocated with the maximum amount of zero length requests.
+	 * Since it is possible that hw_submit will initially
+	 * enqueue some zero length requests and we then will not be
+	 * able to fully encode one frame.
+	 */
+	video->uvc_num_requests = nreq + UVCG_REQ_MAX_ZERO_COUNT;
+}
+
 static int
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
+	/*
+	 * calculate in uvc_video_prep_requests
+	 * - video->uvc_num_requests
+	 * - video->req_size
+	 */
+	uvc_video_prep_requests(video);
 
 	for (i = 0; i < video->uvc_num_requests; i++) {
 		ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
@@ -513,7 +560,7 @@ uvc_video_alloc_requests(struct uvc_video *video)
 
 		list_add_tail(&ureq->list, &video->ureqs);
 
-		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
+		ureq->req_buffer = kmalloc(video->req_size, GFP_KERNEL);
 		if (ureq->req_buffer == NULL)
 			goto error;
 
@@ -531,12 +578,10 @@ uvc_video_alloc_requests(struct uvc_video *video)
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
@@ -689,7 +734,6 @@ uvcg_video_disable(struct uvc_video *video)
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	INIT_LIST_HEAD(&video->req_ready);
-	video->req_size = 0;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
 	/*

-- 
2.39.5



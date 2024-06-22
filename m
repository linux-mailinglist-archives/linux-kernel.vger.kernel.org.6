Return-Path: <linux-kernel+bounces-225891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F4F9136F4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7672A281209
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390BD12BF18;
	Sat, 22 Jun 2024 23:48:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECC12AAE0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719100125; cv=none; b=NJchMdG4XzbLurqnhCoboUz0b6HFXAzWX5xwm6otzv8EXRz8mImxS9lmFQbDGv13rM9TEUKNJfjDUpcCUpEoqjuVimlUztrXkHvdH+aPxFT0zZw+6z2nyayb35Up2X5HFQF6UQ9/za2xXFL+2lVzKZzmeNPnEOwOqay1Xh19wRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719100125; c=relaxed/simple;
	bh=G7Bdwm2LgSzcu8hKez+YkvaF4kB0cS8V8sK1sTJqTBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jn8g6b90hGZTcpjWio0kLMtjfDNC1VPU6/PoEr2dPKKAbqShNb1t9+EEDnc+vKI2Tt7AZZ8DgSSZDrE3CQs5qUhOEI33jEfHsRCvI5MRFONnpu2aEHe1ZYxpN1yA4prnpURr9bt5APHz2bfkKnwqW1j4t5ua2FZZh+JgEBcl0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATD-0002cg-5F; Sun, 23 Jun 2024 01:48:35 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-004Hke-HQ; Sun, 23 Jun 2024 01:48:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-000IWx-37;
	Sun, 23 Jun 2024 01:48:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 23 Jun 2024 01:48:31 +0200
Subject: [PATCH v2 3/3] usb: gadget: uvc: set req_size and n_requests based
 on the frame interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v2-3-12690f7a2eff@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3182;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=G7Bdwm2LgSzcu8hKez+YkvaF4kB0cS8V8sK1sTJqTBo=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmd2LSvQDIFbhZh1nGSdlJ6iKp1YiKTCaR4Flr/
 XaLR/EK/lKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZndi0gAKCRC/aVhE+XH0
 q9YFEADCdz7a9ExUObvtVWFP8ta1exn5yyW8RaWwyUPA0FbvgczUKbvDUSTkzLnSBXi1Sx/Vqgu
 WLmzqGVZCEzJfrbYKNSduz9Rz0MyM1Pp5hE2zVqdp/4H3mxbHXSmfmfweHymsY8jdj7zSdrNSJr
 y+j0/8Y7HU1bFyBlDzPtMDCSotGQ42VowD5JyFyxn/xvvTy2nXeJCBsaD0Ykyy5GqcLMfXIxbOR
 dcrcWVaow/cOumdeQ3orgODjhQd5kE1nCUlrOsE46HfK+TyCBdsiTYUvH7vlg+gthsjFrgNruJZ
 Z3WE53ZsZNkHy3oQTuiv5FzIaLqZs8bh91hX5Rhm9NIZ3vtbJGDjIgnmbSH8uavFDV1uucnZyzu
 GziduKL0c37gx7CY0h6uVOh2XGUoyosqtP0M2VbtEyAj7BOeuWjfTDduDsoDYEB4pn0h4zABvLv
 BNbh0kMg963Kazdl7eqQONd0fdHq/K7/N6mqFjtaPCA5M3FhZPXiNN/DScerhpFaTRchkbUqbdN
 utQd3mcf8d7SJqNmMi8vF3OS9yKIxuPjcFvbEefwf62dAKKJB23nMNQRD8Q18kLr1yOTajAhYDp
 FhIkw90X3Eb0JGL+Orgauu9xJeqwdbRtbcJjfxi6LMlWvWe5ZFFa9QN8zw3ZtAOfxBKjDDQmdF0
 VqDx5VgtNsypwxg==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With the information of the interval frame length it is now possible to
calculate the number of usb requests by the frame duration. Based on the
request size and the imagesize we calculate the actual size per request.
This has calculation has the benefit that the frame data is equally
distributed over all allocated requests.

We keep the current req_size calculation as a fallback, if the interval
callbacks did not set the interval property.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v1 -> v2: - add headersize per request into calculation
---
 drivers/usb/gadget/function/uvc_queue.c | 30 +++++++++++++++++++++++-------
 drivers/usb/gadget/function/uvc_video.c |  2 +-
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index ce51643fc4639..141e52e34c610 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -44,7 +44,7 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
 	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
-	unsigned int req_size;
+	unsigned int req_size, max_req_size, header_size;
 	unsigned int nreq;
 
 	if (*nbuffers > UVC_MAX_VIDEO_BUFFERS)
@@ -54,15 +54,31 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 
 	sizes[0] = video->imagesize;
 
-	req_size = video->ep->maxpacket
+	nreq = DIV_ROUND_UP(video->interval, video->ep->desc->bInterval * 1250);
+
+	header_size = nreq * UVCG_REQUEST_HEADER_LEN;
+
+	req_size = DIV_ROUND_UP(video->imagesize + header_size, nreq);
+
+	max_req_size = video->ep->maxpacket
 		 * max_t(unsigned int, video->ep->maxburst, 1)
 		 * (video->ep->mult);
 
-	/* We divide by two, to increase the chance to run
-	 * into fewer requests for smaller framesizes.
-	 */
-	nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
-	nreq = clamp(nreq, 4U, 64U);
+	if (!req_size) {
+		req_size = max_req_size;
+
+		/* We divide by two, to increase the chance to run
+		 * into fewer requests for smaller framesizes.
+		 */
+		nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
+		nreq = clamp(nreq, 4U, 64U);
+	} else if (req_size > max_req_size) {
+		/* The prepared interval length and expected buffer size
+		 * is not possible to stream with the currently configured
+		 * isoc bandwidth
+		 */
+		return -EINVAL;
+	}
 
 	video->req_size = req_size;
 	video->uvc_num_requests = nreq;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 95bb64e16f3da..d197c46e93fb4 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -304,7 +304,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
 		 */
 		if (list_empty(&video->req_free) || ureq->last_buf ||
 			!(video->req_int_count %
-			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
+			clamp(DIV_ROUND_UP(video->uvc_num_requests, 4), 4U, 16U))) {
 			video->req_int_count = 0;
 			req->no_interrupt = 0;
 		} else {

-- 
2.39.2



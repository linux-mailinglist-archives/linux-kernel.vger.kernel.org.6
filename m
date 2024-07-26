Return-Path: <linux-kernel+bounces-263793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E493DA8E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97142B252D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E115444D;
	Fri, 26 Jul 2024 22:02:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E614A09C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031379; cv=none; b=CyfTL68TiskC3JrBxyA2xPMpMzpH0SI7B03E+O1fM7PqPvqxNs9Nu3t+YA2Ul+dQZX1LXBWuQDS1ODlfmuORpcjzTPNp8nGq4ncWUPy2Oo2xOeDtrL2NneVBkyB58JCorEnfuBs4tDhC+1nVBvpKpApQrR49FK7f4OiAmbpO3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031379; c=relaxed/simple;
	bh=f4ZiiU8LD4siPkXxdwBYmCvsM069yp/y9JCG/a+mOK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5j6Os9mqmb8jbsri8UAIz6ulD7D2OdeEcUeoZS2M1XtY7TFgD5PDrzetXp7xq+JoQCyiB1pmmNo58gA5us1qMQ5nEwkRW0fRKODEMxGGuBtHhJi37TM/xDVxVD9n/2uUWAf3gdZeA6IPpKo4KUQHPf1+5vl/zfXg1guJXzYbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1Q-0005Mv-RG; Sat, 27 Jul 2024 00:02:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-002Qi0-WF; Sat, 27 Jul 2024 00:02:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-00FdLn-2h;
	Sat, 27 Jul 2024 00:02:43 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sat, 27 Jul 2024 00:02:43 +0200
Subject: [PATCH v3 08/10] usb: gadget: uvc: set req_size and n_requests
 based on the frame interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v3-8-4da7033dd488@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=f4ZiiU8LD4siPkXxdwBYmCvsM069yp/y9JCG/a+mOK0=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmpB0CTURNsHotBImTaWZbqX3vROnpkkN5brw9G
 aE9l0bSkSyJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZqQdAgAKCRC/aVhE+XH0
 q7v1D/9DA7cD6PPpq9MzFhR5WXx6PdEWMiUA87TqOQ8ySUn7q5PCEAwzq4X+t2V/sj9I8GpfhIJ
 EVnvNDMiY5Ilfqec+LSZB77sxLQzV6cq9bDhrfpg3hVWILh1VqzzjIl0bCoyFWNxWjiXr5aqtJV
 2m86ytSaroPleqeocDqFpDz+rf9wbyiLedXxHr3/m7pdQ2+0z2P8QiM520sRjJkI2b8cl8wD1fw
 twaMc37W3Nc8AoK2uk9usGWc8ayvGhvJWgvyxeHlHgQQMJU9+a3ZtiidAYG1evu3cPduP1ySjpA
 yHu2lraeRGS59wg7QSZA62Zdcp6cjzl+ZOOG4Ms+FYOTNKKxZm1BiZHkKuQ/FK7OtQ1nSQfODzF
 bRF33UuNgtbXi1AwVubX4i82h/IDg35CrBLxYXGxdJFph/lvBZHtNIg/4GYPCVnqXaCaOIXubjW
 H+oBPDyPr/No2Yn7mCb4zbpDVYVQoRCYSMb9r07FGJO5cPipkPBxn74oJ4HdlhywSnbTllurHtT
 qO+LerXZOrC/gVm6Vpsngs3ClZK/nl0AMH/mgIHCWjJoAgCYE2a03BL4EsodeXKuBq7RKOb1TWg
 rQi2zdstkYQtarjeFlvqU8c5z/X3kIqPEErK/sGPfL6KEEaINBJwxkU2BpawJw954KDCX//fvGj
 YFKtYLdkpFViO5w==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With the information of the interval frame length it is now possible to
calculate the number of usb requests by the frame duration. Based on the
request size and the imagesize we calculate the actual size per request.
This calculation has the benefit that the frame data is equally
distributed over all allocated requests.

We keep the current req_size calculation as a fallback, if the interval
callbacks did not set the interval property.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v2 -> v3:
 - added the frame duration for full-speed devices into calculation
v1 -> v2:
 - add headersize per request into calculation
---
 drivers/usb/gadget/function/uvc_queue.c | 35 ++++++++++++++++++++++++++-------
 drivers/usb/gadget/function/uvc_video.c |  2 +-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 2414d78b031f4..ab04df0e4f360 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -44,7 +44,9 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
 	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
-	unsigned int req_size;
+	struct usb_composite_dev *cdev = video->uvc->func.config->cdev;
+	unsigned int interval_duration = video->ep->desc->bInterval * 1250;
+	unsigned int req_size, max_req_size, header_size;
 	unsigned int nreq;
 
 	if (*nbuffers > UVC_MAX_VIDEO_BUFFERS)
@@ -54,15 +56,34 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 
 	sizes[0] = video->imagesize;
 
-	req_size = video->ep->maxpacket
+	if (cdev->gadget->speed < USB_SPEED_HIGH)
+		interval_duration = video->ep->desc->bInterval * 10000;
+
+	nreq = DIV_ROUND_UP(video->interval, interval_duration);
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
index 9d3cfa96b1350..fd2195f7153d9 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -307,7 +307,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
 		if (list_empty(&video->req_free) || ureq->last_buf ||
 				!req->length ||
 			!(video->req_int_count %
-			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
+			clamp(DIV_ROUND_UP(video->uvc_num_requests, 4), 4U, 16U))) {
 			video->req_int_count = 0;
 			req->no_interrupt = 0;
 		} else {

-- 
2.39.2



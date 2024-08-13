Return-Path: <linux-kernel+bounces-284433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9929500EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DEF2810C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83B187349;
	Tue, 13 Aug 2024 09:09:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9F16DEA9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540182; cv=none; b=uR0g21MC52CZ+RQT0IcXy9mwZX3pbmcm08sG5o81ZR8kj8LkpKzipeevY6sK3PAaq5s7oNHAw5V1wdKVbaGy/rLksGJX3TelEofv/dQIiM8jmKnSdj8e4QJMyLwV4n1UNftBj6P3KG0Y4vJwfa7ZhPIHO1igtl/VqsUd5zcDXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540182; c=relaxed/simple;
	bh=8l1+q6211Afpcbv3xFB7a1zxAwc7hRSt2YKTP95MoOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEc3P0to7WSs15lzh8XWV5QtCKN48b9mFfZPOquhXFVBCGHihUu2S0SqATVnpryX4hhx3nr0waLUAa5Xa2YG+y0YbPUpwDpapkJUCKjUBl9ZNft9PL6IdlTGs+SMt25NMsIvcP0Oi79aGC8CZm0VlK/sV70Q36vpTkjNhIsBeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CQ-SE; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005om-82; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0N;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:32 +0200
Subject: [PATCH v4 08/10] usb: gadget: uvc: set req_size and n_requests
 based on the frame interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-8-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=8l1+q6211Afpcbv3xFB7a1zxAwc7hRSt2YKTP95MoOc=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLNps9UYKxnwlGUb4uOd2KKGzvXbUavYapaF
 ancs9Mso2mJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsizQAKCRC/aVhE+XH0
 q/MhD/sFGRhkhzYW059mkerJVbDVmNjG6/zlmugvLr7mUsBjKJFdESs8s/NLOlhtB6HvelkPHt5
 NOMD27mQzDqMtsINsyGtYDNnPxuF28JF16Ti/btd3bXWSngZNrQ0c4PbYNohc4iw06eZa8kCv+r
 ohdf+tBZYcLzJgaW+IfIPqlGYDTTP+u3//r8F0/6y9Qrwc2OvVrO/f/Z8ctx3GoXadUcNFZIBKq
 ke+1bsUxdH2vb/Jb57bWGuJW6XLZlEuP3dTZVZPy3TFERBCl7koKT8VmYupS2hfVDmBbvwV3sez
 duu4V/46rlcM3VsPEmkn3SgvXiiVcfpcXjRYsRvu/iWdnrqhGrFzPVSndMbStm6go/6IDUJT6/3
 Vt1TAevdb5QIJq/8MROzSFdMKDhv6wKT0A4bpzYHiXcaD3u/Yp5vVM4HoM8wQ4RyqdtjwFws1KF
 tq9RmvRPcXhxurst6M5qtqTdFZec8Ku9cp7E40YuZZuvFiTDe5QF96GV3rRU7gUe2+9g+R6Msoa
 3+N8bPiOAcMbgiwNUwg6LmXO7P3nGmx7cJZqZJWjNDc6+pqMWYcwTmET6TR+0gSfdbx0si3Dw0j
 UloLhaitXoSQTMzvNKI45mCTWPO1YrsryiIW/ILKl5Zq4lg9ecaagJc3LCrTeQN9QM91boUw8YA
 nx1z1M0DgK6CnKw==
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
v3 -> v4: -
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
index a6786beef91ad..fe19608b57720 100644
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



Return-Path: <linux-kernel+bounces-284439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC5A9500FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6196C1C22D23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DF19B5A6;
	Tue, 13 Aug 2024 09:09:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891917B433
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540183; cv=none; b=hC47SoWBpEbJjKQukNYvjwJfvcvAMHdmB6teo6WnFWYJK88AWzGBGIebK0v0NAwQZyTpI1eu507dMbUYF4TcNnuLP+UcURkj3Bppf12Y3NsZ/INS0y9f6L/rKVzEkVI/H6hR+ZcvXME8FK8UjhdsrFW6UHlEHgRjp22WufAv/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540183; c=relaxed/simple;
	bh=pR9Q1xJIQp6r4a68/d9PCSwj+85Vq81NrZV56hszM7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbR7IS5nV+xMxTbf9mwbY5lcAHcJz2jSVWF0g0BnNtJqf66PfYJARpcyheKrsIJHs+CkCX/hqgE7ZRHf2+pTiwK2rUmlF6vLJgUqCiDou0aK42hmbnen9Q1WsAdnyUuXLNCtBoAHpYxvwMU6vhZQFmhQDgJMaVvKpt0apWc9JJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CP-SF; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005on-83; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0O;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:33 +0200
Subject: [PATCH v4 09/10] usb: gadget: uvc: set req_length based on payload
 by nreqs instead of req_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-9-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4214;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=pR9Q1xJIQp6r4a68/d9PCSwj+85Vq81NrZV56hszM7Q=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLN797r8Eswpj0toyqDidEtNCqQT+lBsIcH7
 eNMTNImexmJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsizQAKCRC/aVhE+XH0
 q57yEACSN4eXjVOdmtSeMKQSkLpt2z6CiLpauhPyFSwisNfdzhM2T0M+wjNlfEKuzI5Ju7F+7br
 FYAhiSI1OfO1jK5+D4GvgzIQOhktKjBjHGB1NtDDpFslBHTCRToI4hnCvBxfEG5aSHucgGXs73s
 0RyqLfFFe9r4EyW8SKtGyE5DrzLyqgyXGY4tHr8teRKvUZkglzVY0PcMvwQA+bxRTiwN8R3p9Jc
 PAjH2bBYFNAgwQwxTSZZXHJwETn5TxmyE6EwRthkEYXQ4eDmEGuvZJ16UsjUABEX6zhZYLvBo9i
 Dn2Vg9pfhMJkMRN2m/c/LPtkKZ4skAHEyOi+usIhohP+m8F1i9W+kH638Lf/21hxeJqHkrvvs73
 r9bzSMH1eY1Nyxg6tNPa/WKUdmKgFisLHrKxO/usFJyadtfStTXeM06gPJAQKtxef5QhJAQe5lo
 r+GqRgKgxoTKbFjZAKUFiA6EtHq9dRBJoybu21cUVDiscaeKz4zGyHFLc9nN5p0Wc50EXYH4gaC
 LJpr/xDNRvril3F9I843muw/QBvSQKZRePKCM+a9fgufz/BJLgXitjvV7NleKkMak0hNIfr7jSE
 jO2+py3l37K+hl2Uv2fsgEY2CDK99mQqoPlw7e+WJTVvjnYNYEvjj25xZ3jhu1B/nHmNsbouhjB
 q1RTjlSfRPKb+lQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

For uncompressed formats it makes sense to fill the requests with its
maximum since the amount of requests and its size is calculated for
this exact amount. Compressed formats generate content depending amount
of data that is set in the vb2 buffer by the payload_size. When
streaming those formats it is even better to scatter that smaller
data over all requests.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v3 -> v4: -
v1 -> v3: new patch
---
 drivers/usb/gadget/function/uvc_queue.c |  9 ++++++++-
 drivers/usb/gadget/function/uvc_queue.h |  1 +
 drivers/usb/gadget/function/uvc_video.c | 13 ++++++-------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index ab04df0e4f360..e33ce72325031 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -94,6 +94,7 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 static int uvc_buffer_prepare(struct vb2_buffer *vb)
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
+	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct uvc_buffer *buf = container_of(vbuf, struct uvc_buffer, buf);
 
@@ -116,8 +117,14 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
 	buf->length = vb2_plane_size(vb, 0);
 	if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		buf->bytesused = 0;
-	else
+	else {
+		unsigned int nreq;
+		nreq = DIV_ROUND_UP(video->interval, video->ep->desc->bInterval * 1250);
 		buf->bytesused = vb2_get_plane_payload(vb, 0);
+		buf->req_payload_size =
+			  DIV_ROUND_UP(buf->bytesused +
+					(nreq * UVCG_REQUEST_HEADER_LEN), nreq);
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/uvc_queue.h b/drivers/usb/gadget/function/uvc_queue.h
index 41f87b917f6bc..a7355442dd6cd 100644
--- a/drivers/usb/gadget/function/uvc_queue.h
+++ b/drivers/usb/gadget/function/uvc_queue.h
@@ -39,6 +39,7 @@ struct uvc_buffer {
 	unsigned int offset;
 	unsigned int length;
 	unsigned int bytesused;
+	unsigned int req_payload_size;
 };
 
 #define UVC_QUEUE_DISCONNECTED		(1 << 0)
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index fe19608b57720..a5cf4dbdc5d59 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -136,7 +136,7 @@ uvc_video_encode_isoc_sg(struct usb_request *req, struct uvc_video *video,
 	unsigned int pending = buf->bytesused - video->queue.buf_used;
 	struct uvc_request *ureq = req->context;
 	struct scatterlist *sg, *iter;
-	unsigned int len = video->req_size;
+	unsigned int len = buf->req_payload_size;
 	unsigned int sg_left, part = 0;
 	unsigned int i;
 	int header_len;
@@ -145,16 +145,15 @@ uvc_video_encode_isoc_sg(struct usb_request *req, struct uvc_video *video,
 	sg_init_table(sg, ureq->sgt.nents);
 
 	/* Init the header. */
-	header_len = uvc_video_encode_header(video, buf, ureq->header,
-				      video->req_size);
+	header_len = uvc_video_encode_header(video, buf, ureq->header, len);
 	sg_set_buf(sg, ureq->header, header_len);
 	len -= header_len;
 
 	if (pending <= len)
 		len = pending;
 
-	req->length = (len == pending) ?
-		len + header_len : video->req_size;
+	req->length = (len == pending) ? len + header_len :
+		buf->req_payload_size;
 
 	/* Init the pending sgs with payload */
 	sg = sg_next(sg);
@@ -202,7 +201,7 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
 {
 	void *mem = req->buf;
 	struct uvc_request *ureq = req->context;
-	int len = video->req_size;
+	int len = buf->req_payload_size;
 	int ret;
 
 	/* Add the header. */
@@ -214,7 +213,7 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
 	ret = uvc_video_encode_data(video, buf, mem, len);
 	len -= ret;
 
-	req->length = video->req_size - len;
+	req->length = buf->req_payload_size - len;
 
 	if (buf->bytesused == video->queue.buf_used ||
 			video->queue.flags & UVC_QUEUE_DROP_INCOMPLETE) {

-- 
2.39.2



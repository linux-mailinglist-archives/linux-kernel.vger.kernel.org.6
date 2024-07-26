Return-Path: <linux-kernel+bounces-263796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A393DA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4078281B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0C1552E4;
	Fri, 26 Jul 2024 22:03:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45614A0BD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031379; cv=none; b=hHk/KpYtTkxr7J2xBRbvu85WQ+gyn5Fz6aEKluNZQ0fhwT28Fkqml+ylOpYlspBUC0mFxpPyS42Kg5uHgBXuHzMHqmLsE7tqh8k2a4R18lRI1kHP4Fy7Jxp8eo/wv9vyIj/PPhbIW9qpI1xfvpq2ibvnxaRfcXGgIt0Gn+1FYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031379; c=relaxed/simple;
	bh=Xp1Vap8cEke4S3pNDtwJUBr4HLRTDgdAQ6d4cgu7+Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kj7gxplufK2/oDu3QZG6Ona03hpL+47OS8B9ndQE2n541KhtTZuaQd8RrZK+hN6z02iUqlqxbFRkN3WUjIzY/UsFnV+SgnhANneqs5+4q88QstOPnPGM2GXwzGqyevC6sVgWnVNCR1nrU/c3NMgstX2GllMSYDa2FiqtITNQ/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1Q-0005Ms-SQ; Sat, 27 Jul 2024 00:02:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-002Qi1-Vy; Sat, 27 Jul 2024 00:02:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-00FdLn-2i;
	Sat, 27 Jul 2024 00:02:43 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sat, 27 Jul 2024 00:02:44 +0200
Subject: [PATCH v3 09/10] usb: gadget: uvc: set req_length based on payload
 by nreqs instead of req_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v3-9-4da7033dd488@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4201;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=Xp1Vap8cEke4S3pNDtwJUBr4HLRTDgdAQ6d4cgu7+Hk=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmpB0DDvtXCJOa/eaeLIwfNldVJSFpSlADqcnQj
 qEmm1r7QXSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZqQdAwAKCRC/aVhE+XH0
 qzSkD/44HnMgCN7nvly6PyJO3tI4p9vACyybRJ7JxKnKKMDMgLwF9T9qhJ3ZJgm0VSBLZ2HRDtw
 w4myv3G73FlPwRImO4oysKQkPFDeDHx/F/y2+uhS5BcELvN9iF3ZsaZYM8xHEIGqZWGKbQvjCAo
 /PLK18/wnJpq9UaNgfKUiB3ZmbvT4UL2uh3NAtKMP4JKH3gyoNiqdJLSG0hg4hecp8MczjrfUX6
 Lnin0aGyhlT5iXV9ciAc9NMgF8YwsDlAsjlqtu14rDYfVosOdL9R0svMyTzqQRzc7xr2vDlMuvy
 BcX0qUC2kHM21z0EqPJUHbHnm5Xc7/AVfFd4Ey1L+YS2Ag0o5cOdn664+CtlcScFyWCWoXgx2ye
 +wystngiwKndo4aQ4dvWqYWC5Z+RkNDWBzjeZisLpD9SHVmTP1llC+7w0CrZzZ9u1EQI4azuwPk
 POlxaAMdEXuTEiNjt40xKzOZK+HfFcMeMo7JyV6RwBxp46fWcTPV8RAcm6DTScoS5v6WsIccXWV
 Bcur/a4q6c/DT9tvzyOH3kCbYfbhulos7BoE5sk34ZzeWNLaa48NB/MunGNqIE9MZhgcqqYbizR
 a1HcACpH099S6WouvM2gb+Lc5TMSEflDl14ydFb1PwRo6kPSLH+ajXMFjXd+eEOSpCOHJPKZKMW
 5X62/TJnYQJ5HsA==
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
index fd2195f7153d9..f6911f124be4b 100644
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



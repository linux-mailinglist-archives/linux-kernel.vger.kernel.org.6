Return-Path: <linux-kernel+bounces-284436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B39500F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAEC1F228D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3919AA58;
	Tue, 13 Aug 2024 09:09:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF017B421
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540182; cv=none; b=HR9u3K3ZtRCdVE0S+zggscLbA8bqKjP7Ij5/EsRKxdVaEyShfIzrVnWMVznOe0LXzK3/IrwrNrT3+w75AYq4OpscgBsN6KdjLJ1h+5f+0el9BfK7EEUFGKd7EvD6gxdn0ObWBN5tnv8HbDN+jnyNg7WKayCWyCS3ucVvvnKydnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540182; c=relaxed/simple;
	bh=t4rn2tx6pz+7/aMEqxto9Mmqdr+OuwOa+HF2o3tdYeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0Q0vZeIH83/epbCtnSNnkEhj7A2ea8t/zBUP5YLK2t1YT5bKWqRa1ZaGzGBxsvgxX0V1LGjBSsA6ZxUnoG/vTAGHaSikrR2tHUoXBgz1TqbcXiRTu+FQT4HYNAAVKrHwneaNvlSO5AF/rVjn1MR6OTUvoK2VThBCty3c/2PLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CL-SD; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005og-7M; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0H;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 13 Aug 2024 11:09:26 +0200
Subject: [PATCH v4 02/10] usb: gadget: uvc: only enqueue zero length
 requests in potential underrun
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v4-2-ca22f334226e@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=t4rn2tx6pz+7/aMEqxto9Mmqdr+OuwOa+HF2o3tdYeQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLK3bg6sQ0kq9/4e3OENc6X8vS+Ap0IOUHj9
 KX81K3fMG2JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsiygAKCRC/aVhE+XH0
 q5KID/9Bb8sfCucOUhL2eCTK0eY7W2lJbYRpq8SdeviwI1j5Jn6i6d6TUEr3tMi+/kKaTwNid1h
 zf9R2UJ20q3WJG4ksCa1pxcrWkF5jjEIalaDGX2xi6Xax5x3nhwIsc8YVRlf7Wd8lLuarQkLwEI
 YRF4nD68bFyULWccd/SPPd8sR4FTZFnj0X64aNwTexKz22RMxFqrStOI4RIOQFpvVhnTCVHJGyg
 2Q6r1db5++VEWmDndCM295+qwTNTTNtDU2W/FUSMErPtNDQ4Sv39TGNtvbEGEw5YpBAy5z/+qDz
 1zFA7g2ekeSQ7TY7w0nu1p9KdEFBNLVW1/lrfMugvOqnNWG2T5k7M9jBbbSkW5l8Hvj+/PEKcvq
 bZeYC9bQ5U09r6jmksmH+5z/hDt5vc20Jcm6vGALjrHXI7eHDUxjbwkyV4362sQ8Tymw/I2Uj4+
 Rf2yZ03qAxb2d5sDPVFvK/K32MP80haumCRZG3cFnO3NtF9rcEiaioHi98rou06wLey/kH1q2G0
 dGEgEbyiH+TwqlzI3aXkKxGYBFhYLspB72LkBlDIAvleH6wmpSKG5IvEHSqQfMRDycTQLk2E8qx
 VQPhLs7U61+uHv7yCCWXjHj717sLIok5FmVWZoc2jWE3pe1lytI4sWFv0NNAYamLzhvnBiFqWwI
 j/D86Ol7e54IQig==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The complete handler will at least be called after 16 requests have
completed, but will still handle all finisher requests. Since we have
to maintain a costant filling in the isoc queue we ensure this by
adding zero length requests.

By counting the amount enqueued requests we can ensure that the queue is
never underrun and only need to get active if the queue is running
critical. This patch is setting 32 as the critical level, which
is twice the request amount that is needed to create interrupts.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v3 -> v4: -
v1 -> v3: new patch
---
 drivers/usb/gadget/function/uvc.h       | 5 ++++-
 drivers/usb/gadget/function/uvc_video.c | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index cb35687b11e7e..646f1c01c5101 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -91,6 +91,9 @@ struct uvc_video {
 	struct work_struct pump;
 	struct workqueue_struct *async_wq;
 
+	int enqueued;
+	int dequeued;
+
 	/* Frame parameters */
 	u8 bpp;
 	u32 fcc;
@@ -106,7 +109,7 @@ struct uvc_video {
 	unsigned int req_size;
 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 
-	/* USB requests that the video pump thread can encode into */
+	/* USB requests that the video qbuf thread can encode into */
 	struct list_head req_free;
 
 	/*
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 03bff39cd4902..d47ddd674f457 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -269,6 +269,8 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 		}
 	}
 
+	video->enqueued++;
+
 	return ret;
 }
 
@@ -380,6 +382,7 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	int ret = 0;
 
 	spin_lock_irqsave(&video->req_lock, flags);
+	video->dequeued++;
 	if (!video->is_enabled) {
 		/*
 		 * When is_enabled is false, uvcg_video_disable() ensures
@@ -467,6 +470,10 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		 * happen.
 		 */
 		queue_work(video->async_wq, &video->pump);
+	} else if ((video->enqueued - video->dequeued) > 32) {
+		spin_unlock_irqrestore(&video->req_lock, flags);
+
+		return;
 	}
 	/*
 	 * Queue to the endpoint. The actual queueing to ep will

-- 
2.39.2



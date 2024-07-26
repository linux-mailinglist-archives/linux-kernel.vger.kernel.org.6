Return-Path: <linux-kernel+bounces-263800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18E693DA93
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FDB2331A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DFC156243;
	Fri, 26 Jul 2024 22:03:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4F14B064
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031379; cv=none; b=HswaXdwz2jQN/KSeT8YzSjom/RbeOh4JhH5u2NRqSGPdGsNNkPZ7XK4TzXLWKE/aoVnnZEkhKUukZP9aU9IZeCiKIWdmdIvBdD8TXsO85iKsIpvv6LYgEBrvkGH0DH1iPnuCe6aT5K4Qz0CRC4uEqwSmdctNpsFGd7IcCS/ZxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031379; c=relaxed/simple;
	bh=d4N276jXUhvGBMnQmpZPQHqjqQDtlScV/gbDx0G4ZNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThLpSxQXhZqTgxSXpWN2zM82qoGEIBfhfVX31LybvO8ba6RWI1QalAFBd0+gcxuAe12FguiZlhMV0UwHCi6CpeD9CO62Nwn+VJ07fBuhJv1+ds5+dS3b1H+HwyskFWzXJgmnUZksFfru2ztlW8ZXSbDJ39ChD++5a92Nnyaiscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1Q-0005Mr-RF; Sat, 27 Jul 2024 00:02:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-002Qhu-VC; Sat, 27 Jul 2024 00:02:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sXT1P-00FdLn-2b;
	Sat, 27 Jul 2024 00:02:43 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sat, 27 Jul 2024 00:02:37 +0200
Subject: [PATCH v3 02/10] usb: gadget: uvc: only enqueue zero length
 requests in potential underrun
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v3-2-4da7033dd488@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=d4N276jXUhvGBMnQmpZPQHqjqQDtlScV/gbDx0G4ZNQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmpB0AED6RR3mV9lMOYlW6C4+MWnuKt9uIgaT+i
 5J8wuJ+baGJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZqQdAAAKCRC/aVhE+XH0
 q2hsEAC5HHNw5d1IVUmCvkr40fyMJrnXSiEj+u9YwfbargZr+qXTJ2GqNU0WvXTeNS7ALV39sk2
 oNw+aszjsEjO4RwOGvPWWRURFuckOGXHXsjptN3kVTS+Zx1SSsMAhLjZHAzPSInG7/PzOpJQ2iz
 1/TdJUGUJASohlkpCeO44z3H2mx8owAFmXgDaWlOcg04vQAy/rKiG5ZHoQgkzjnL7/cVbIk9huZ
 Ue0L4O1/UCADhXnyMlpgeZryRmNhu49o6HslC0semBWiMCIMpVMW2rwCUkEJ7Nff+xH3PT6QZdC
 37QA4lN7qVT0o7m6lfIpnQQQg+DfF/XtFFF5uuPiTJI/fvbF119D0cztc162zbzTtCsXrJ57OZE
 rhnBLKLyeF4C8RXEq4YFAEwAz4000TWhMxK0Tdab6UkhZpMk/IzmNppo1z4jiZmtdHGIzN/zWEl
 7op3mm9tjdeEAqXmU59KyEPDzPSEqaadgJTXQWam33KEQCa1oq4M/CiWnbGqp7MGm1mE1HkaLL0
 Yu37iXQ9G+l7Pg4SBSck0VJIeHlQMjQv7wodAH+qY8Nk6JoqqluusXld1BZ/4CqLaWxSrDtCe04
 Cm77ZrR6uw4If4mQ49eAjA1qBu5W2NR+PZJ+Wpt9q1POR8OxOAMx0g7sCC7s9nbwrbQ2W1BVMzL
 NCO8au3gOjjgd3g==
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



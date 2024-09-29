Return-Path: <linux-kernel+bounces-343127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C805A989702
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CCA1F226BB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A7185949;
	Sun, 29 Sep 2024 18:59:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F075103F
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636382; cv=none; b=eJ1DWKkmuXYYPH59Liw9NjEzlAey0TIlFhwJ1hFWudf9cZmX0E8+TajtSjne8vLh/h7UHJrSrhnsKPUY0Hxmc8NDUiM9kewDwpsEDtwc0aqknWInarBdbpmnoAkdrDzQhu80nedC0ttjm0q52SU3aGqkXQBk6QzLBAZFgMi3D/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636382; c=relaxed/simple;
	bh=kngrIUdohYDweYjrpeEtFY0IvoCnJzGSSuzWmk8HDPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdwvQuAaCW2Dbr4ODj5SILStObNMerK66KSdG+5Q3qOB6Aa+e6VfHxRHQ37XZgIAmF02G5xfNkjDnNMXUlApHpz56J4yWgf8/I9YDthbjeQtdzSlKcBheeiLSZU8DKQwrs/7EJ9AYtM0SqiPvXRZ69uUlc6nF2eEb1pQse/Cysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053o-KL; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-002Ro2-0H; Sun, 29 Sep 2024 20:59:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-2v;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 20:59:21 +0200
Subject: [PATCH v6 1/9] usb: gadget: uvc: wake pump everytime we update the
 free list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v6-1-08c05522e1f5@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=kngrIUdohYDweYjrpeEtFY0IvoCnJzGSSuzWmk8HDPA=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aOPn/vQOXvdVMsUJ4otY8xzduWcjdZ0nf18G
 09B+JXftPmJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjjwAKCRC/aVhE+XH0
 q64BD/98VAGE2/ELmPGAWkPbbsyPSY+nOyMVz9dZlQJ/qjoGLrQy8h9DwIZKsJacOyMnvstH4EK
 ijINEOd8ppAwZUF+fdIqcyS+zrT3yGhQ8ryD0GfTTrMEqa0PR2jJVjLzW8QE9PgEWwIXuRE+Tee
 /eFfVk6IgeKW+WCbCAFTFtTdokcNGvS+Uh+zU6HwglqY9zKAer/7N93xj8GF9TXjsEdX9h8yB/j
 aoi2hefgj+O2gUZvCTaemHfjnPaHJ4HYLOgT4oLShfL4X9pGzgRkIoU0DJ+p4VTtGI1V9Phu4Fk
 4pjO3/N9h7xs/zwz8/4Kb7mE+CH4VkTxTUQjWE2Qy1854OKMPHkDYIAgrAcsjk0q+BL9VyEjKMa
 cW6jJArRS2q1wQnwBC7zjsZATaR7npdbAxlVSR59FsuKO7UXKiP+wR1YK5htWDqhdagDR+wfvoo
 /CvVoTwGcH8RG/QGjg1PWLBa1clKW+Bm4TO8fC5njPW5CEOhiStmoGoEFUnFh8W1W1YZJwrWpxv
 dGkokA0meiJJK4ww3aiq08aN60pF2qgIn/uzRTJ3G6ZO4JLlIjEpjEWitQPTSLUYKzQ0SyvFywI
 pZrjRFjzBMvb5gY92YRE5nSA7ZcQ3tleOctaKkuezV9ncez5klEdEOJc5cQIIInLr5JPY+9Xvp/
 dpqqj/t5G4Jq3Cg==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Since the req_free list will updated if enqueuing one request was not
possible it will be added back to the free list. With every available
free request in the queue it is a valid case for the pump worker to use
it and continue the pending bufferdata into requests for the req_ready
list.

Fixes: 6acba0345b68 ("usb:gadget:uvc Do not use worker thread to pump isoc usb requests")
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v5 -> v6: -
v1 -> v5: - new patch
---
 drivers/usb/gadget/function/uvc_video.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index a9edd60fbbf77..48fd8d3c50b0c 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -480,6 +480,10 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		 * up later.
 		 */
 		list_add_tail(&to_queue->list, &video->req_free);
+		/*
+		 * There is a new free request - wake up the pump.
+		 */
+		queue_work(video->async_wq, &video->pump);
 	}
 
 	spin_unlock_irqrestore(&video->req_lock, flags);

-- 
2.39.5



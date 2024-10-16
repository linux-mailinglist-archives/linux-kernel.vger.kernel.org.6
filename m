Return-Path: <linux-kernel+bounces-368164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1899A0C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F1D1F25E14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E2920FAA1;
	Wed, 16 Oct 2024 13:58:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5920C03E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087108; cv=none; b=UmUCucQmiWn6kCxMZq+WwQMzc9dWrZ1STwdfUZhQOqFCU5raO3CXOgvjjXYPj+xXqQ34zysBjt7Kyh5zHcErpzTOwjBDyfY4XyTkOmZxN8L2sb8MhQCOFW/ydVtepIgfzVgCVQ5VGTT5uuGZDE4/K+1YD7vgkcx4NrEmag8Fhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087108; c=relaxed/simple;
	bh=KOYB94vey15IcIEifhD0pxE/3ywuoSg72econbiOevY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVjMvCY22KACoVUg6lHzd3Lh9tzC3A3TrzOkNlQBRxVBF/eOzwRHIMXZ1jxAfwgRJI8rbn9d/5eUKGd1buVVlaGJYoJOiWbiDJjlPVrQ6aqJ92U2JCu1ytXRCL/SylpCaoF4KgD3Un2R2hBH2kaW/vv3ltUscuB88PAE18k2l74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-0003Gy-L5; Wed, 16 Oct 2024 15:58:21 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-002Hj9-14; Wed, 16 Oct 2024 15:58:21 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xc-00BU5S-37;
	Wed, 16 Oct 2024 15:58:20 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 16 Oct 2024 15:58:06 +0200
Subject: [PATCH v7 1/9] usb: gadget: uvc: wake pump everytime we update the
 free list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v7-1-e224bb1035f0@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v7-0-e224bb1035f0@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v7-0-e224bb1035f0@pengutronix.de>
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
 bh=KOYB94vey15IcIEifhD0pxE/3ywuoSg72econbiOevY=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBnD8Z5OwzTS3YtusaUNYvdnd8da0k7vpqucVTOV
 mEniLmQiOeJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZw/GeQAKCRC/aVhE+XH0
 q4LYD/9PPaYo5AxM/QjZCKDxQB/DiJSeQ6koO1itB166LtcsAw7ukVLcIfTLoJl8wKRxj8B3Kbe
 MixNISTNr4aaBooYk/dJHqiP2Pin6Ya9mTNUnydxIQeo9tAuPud687TtM8WbKzYoCRX4gzmeT6K
 xrx+EeHeuPBTov2n0a6jqatYipsI0BAW6KPm3svMgZsJWE5hAEUMplCyZK5yD3SXyo56rwKYXP+
 fhGJnbuv34snmCXS3t27BlKBlThLDMHD4XNDAZS5d6R0/s8p+bZeI3H0oHqf5yzj77Yo1nDDBjT
 QxiHC04jfc83rPnbX0s3wTC1SGoCiE8syS0wSTd9Mtl7o6wR/aCLfd91Cu3UQIuqUTB3ups3D8C
 BoTLGK34dksil8vdqrq9S1J+HM0XZzuEexWC/wsDVf1fWSQUyxu7TTTo1hqXj/p/Z99a1ja/3X8
 keM7hWqg6BX4+rZAnP6/npgbvEZk5pGnrp622OuFa7St6Vv+u1b04SthK58RKyEUJbXC6Eqx0H6
 FxLTEAeBoR7MGQpDwXgcZqFUOT1FK1A7vMvKAj6fEHIAVh3sF0BtNVbWDLDtR3J1jU2ZIeRNtCt
 LDPc1BK1E/SLc5xf76pN4sTEK5dxpv7nnVUOoA6F8X9L6NPP2lhzOknqRnSww2hh9z1v42qHSTd
 Or9hYr0xC68I8kg==
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
v5 -> v7: -
v1 -> v5: - new patch
---
 drivers/usb/gadget/function/uvc_video.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 57a851151225d..002bf724d8025 100644
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



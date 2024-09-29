Return-Path: <linux-kernel+bounces-343121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45F9896F5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC13B1F21209
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ABB7D3F4;
	Sun, 29 Sep 2024 18:59:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381B5A117
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636380; cv=none; b=uhtt9jlXlEzwFbkulCSUVmPRuHTd9Xeomt/IqzseESc7xvoXT84Gm94vKSCh4FIY9IZDh3Y1pB/YuLiUyH31byRONzRNqO9953L36h2iZ7dh8rDhfEgWUZlUK4Hi1vDCXuydb3AHFjoUD6JY+02lZ6F2GQJc4O3XBOwHTRaAkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636380; c=relaxed/simple;
	bh=7S+aPuRPGUbYnkcvuKpuMWRYvF73uV3ggRsPg/mMG5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkTs1hHKo3rnDYGEZI0ZgHRtci2zO2z4U67gQ3EdpWA7fjV2YpSZBTylNwczcYTmrbH9lVSKBJ7Tk04REp3gYJMBeXRa4xe2Di5xbcYsSSXrJVa9ez95tzkpM2KvGvUBN3mZr2Bn4m7HgPY6fSusg8osA4/t1BPnAhMtlFI1Gd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053t-KL; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-002RoB-1D; Sun, 29 Sep 2024 20:59:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-33;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 20:59:29 +0200
Subject: [PATCH v6 9/9] usb: gadget: uvc: dont call
 usb_composite_setup_continue when not streaming
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v6-9-08c05522e1f5@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=7S+aPuRPGUbYnkcvuKpuMWRYvF73uV3ggRsPg/mMG5o=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aOSKRNJf2gHyr9LAFLASPoX8Ve4fvtg2MTYI
 kxp29wUvUyJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjkgAKCRC/aVhE+XH0
 q1hyEAC9Ir5VllmE3JkSMXYslr0pvNe7lSHQR4q6gEsFYaviIKdKz/ufdT9Cqnv16+GgzpVRT0F
 TL3M17aKRLreii0Jnc3CvpcBd+YD4htM2s+m5muwx6PrQH1Hi7HsfzEgJcpruWVFsRxxGEobNWg
 l8huJfX7l4aQeg3gq7vcwiGoFfSSN9HxbFAfRAX08TQem77kavX4wzzT72BRvb7UtoiAckRb3TM
 q4jFllw9FJtkfytNOF7W7Y7B9y+q3ZSo5YdHvJ2k2KQ9MsJsQtyqMazrCdY9Wl+Pj2hJkKRTvV6
 v22uXItUzb3GiL0PEX/8XvLO/JA+xYXsoyXUW+2MeVigBRdTQdat2p7+uIDvKIHuprNZv8HX/er
 8EkJKkGJgFghvVXdAhHH54mefZ7+GD+16A0gSsIQVjnSwZFPFwMqb1x7yaSkcZV34RSXkSn9ErU
 55svaoCTXsu2nVXTtMNyKUdJAzGeG7j+8d4Jt3WVcELDkgBkLW1Jo2kZaq2dYNo3N5ZYT0tT7LE
 h5D3P4W03/vv8onzx/9Nb0NYktsb06VpEl13JjBY8oFBK/FRTnKbFtv5XSLruEviufe4XXhlsnP
 v3U32J8eqhl0neIRJKkLPIp+Hj58gxoUuMSHfZJB/lzgXzmlVV6sFXq2gc8oV6OzveYqmvDsngn
 7puAuykchMJ/Exw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

If the streamoff call was triggered by some previous disconnect
or userspace application shutdown the uvc_function_setup_continue
should not be called and the state should not be overwritten.

For this situation the set_alt(0) was never called and the streaming ep
has no USB_GADGET_DELAYED_STATUS pending.

Since the state then was already updated before we also omit the state
update.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v5 -> v6: -
v1 -> v5: - new patch
---
 drivers/usb/gadget/function/uvc_v4l2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index ab89f1630acb0..3492855f0fb29 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -546,6 +546,9 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	if (ret < 0)
 		return ret;
 
+	if (uvc->state != UVC_STATE_STREAMING)
+		return 0;
+
 	uvc->state = UVC_STATE_CONNECTED;
 	uvc_function_setup_continue(uvc, 1);
 	return 0;

-- 
2.39.5



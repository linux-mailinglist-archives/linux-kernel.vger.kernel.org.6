Return-Path: <linux-kernel+bounces-341157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D66987BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6CB2853B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58A1B143A;
	Thu, 26 Sep 2024 23:37:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE51AD402
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393873; cv=none; b=Rbd5nNiCh6gH3DmCX2Dj/hktmLvRccH31FMj4t3Knw+gBAnzydBqcdOTc2MAMfvWCVWmQJdrO1TGJcEbD0bKZOs/kgq2Zj+0tUD5LzgfiUJtD2mVLi5RMkjOI2ZMBUzhtwBWpbSn1I5tcw3JaScqPmV0IDOxC4hJkqTLU/Uom5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393873; c=relaxed/simple;
	bh=ZC7vhKknmIv2ZJpX7IaaS5kqxmYqf1oRBfTMnf5v6m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWB9u2zTmkqhhq0mHzfDe2oa3nC+TqUV9kErp7Z6q83Oj56l15aOSLaxtlPBoSB61L9ayyAhPtde0CcHlc+11oqUxy1GAEg3u4nnCZ1/3G99FO9jq1JoxQGB+KnoK6DiDRcqAcYgQkhkckqiFvc//aDO6LAvOfsWZlFlXA58kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3N-0007WN-5q; Fri, 27 Sep 2024 01:37:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-001nOa-Ec; Fri, 27 Sep 2024 01:37:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3L-005IAz-30;
	Fri, 27 Sep 2024 01:37:44 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 27 Sep 2024 01:37:48 +0200
Subject: [PATCH v5 9/9] usb: gadget: uvc: dont call
 usb_composite_setup_continue when not streaming
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v5-9-2de78794365c@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=ZC7vhKknmIv2ZJpX7IaaS5kqxmYqf1oRBfTMnf5v6m0=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm9fBHaxZ6s0DMLzvJkk19xjWII0MPbZ0SlIxKq
 vNDrRVcwLuJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvXwRwAKCRC/aVhE+XH0
 q5FaD/9ghIhrqeWPp637SzW/2Q4M+yfgvTtyuejRgbG4WJBtRw8e+KtBTtUu4v7ZI0oRuNIYsLE
 OoxjXeAwfRaEkhhMAkU3rS+dRb1NunFeekzU69ghb32iRdpvrEOiu8TrIeDROoEVf7cK7jCMVHE
 wUamCzEc7syyz/rutIrnANuAhNdYX7a2AZ+yVW9e57Yor4voD4W+YNrEYLMYkwcgRsH6alcJPLo
 TO2L7tJySox+UcIhyDwHSEnBq+SPvjX22xUalUFBD7ZRCB1QGbh9y9Dbd26tVMzfKbzG6drvHHQ
 +vPLyAbV2uhi9c2dnjHRClXj6rs+/BgWu1x/EsZ6RhHp4bsZq836nHUuklDJQnHxyMdDXeJDjgv
 VZyL04aL6a00j4F7BmpywSNG/t1fcfSWCYSoqaqsyr/ojGwi89SEyiirr3eiODd8bljH1m54E2l
 piKbHAs+iisJXFKHkBEOGZltxT0TeJfYCdlnwrMRPz2xj2Dju3Yh6y4yIXzZ85aqfFzjFXg5LLH
 Px4t1aNTm/sV7qZ0450wqJpx82xJxG67V5qy3VyGGupjpXQVlYZY1x089TajMfRVNuqY0LPUqu0
 OUUoMZbYpaf+oP51VKR91D+cSekDUJLxBrzEVIhU30vrX4VPYr04D2irsjW9ePLs9aZwRDCmqne
 BYk2kCQItpTG6BQ==
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



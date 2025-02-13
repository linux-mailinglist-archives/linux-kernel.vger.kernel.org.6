Return-Path: <linux-kernel+bounces-512838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED00AA33E48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917741889358
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AACE20CCC8;
	Thu, 13 Feb 2025 11:41:59 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72560202C31
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446919; cv=none; b=XWao0C3ZtKk99wvtlKdlmd+UrDaxJNxKN4sBXVC0a2X4o4sQRggfqpMAds4z+ez02cPLUOpAY91ieinq3exHiQ/eupR8LOHGbGo66SXCmJTsiAhpxa4Y7E7/33nbS7iIMkCUa13tvVmvV2HT8SU9AiLW4I9Ge2t6wLiM3N8DNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446919; c=relaxed/simple;
	bh=2PxVLBVlMXAS6DEQITAK06rc6Z4iCHt8dtigQKJD31Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlT3i20jRFP06PEHjMAw/ZMk9Ep7mIzrNv9vwvtpBh678qp2uN8YzVBxhzBe/W1zdsP7prIDcoJ4MweqmkoMWkP54NSnAF67gHWcx1W3JtwSUIZks0eIbB/9daFh0afSL2TMK/UgppTuJPiRa5dp76LZIwF7GvKlYkHnUBLO/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 13 Feb
 2025 14:41:45 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 13 Feb
 2025 14:41:45 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+ccbbc229a024fa3e13b5@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [usb?] WARNING in cxacru_cm/usb_submit_urb (2)
Date: Thu, 13 Feb 2025 14:41:43 +0300
Message-ID: <20250213114144.727875-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67a49862.050a0220.264083.0000.GAE@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Test if a better endpoint check is more appropriate here.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
---
 drivers/usb/atm/cxacru.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 0dd85d2635b9..d72cd30a299e 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,7 +1131,10 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
-	struct usb_endpoint_descriptor *in, *out;
+	static u8 ep_addrs[] = {
+		CXACRU_EP_CMD + USB_DIR_IN,
+		CXACRU_EP_CMD + USB_DIR_OUT,
+		0};
 	int ret;
 
 	/* instance init */
@@ -1179,13 +1182,11 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	}
 
 	if (usb_endpoint_xfer_int(&cmd_ep->desc))
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						NULL, NULL, &in, &out);
+		ret = usb_check_int_endpoints(intf, ep_addrs);
 	else
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						&in, &out, NULL, NULL);
+		ret = usb_check_bulk_endpoints(intf, ep_addrs);
 
-	if (ret) {
+	if (!ret) {
 		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
 		ret = -ENODEV;
 		goto fail;


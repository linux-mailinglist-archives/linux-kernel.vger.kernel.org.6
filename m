Return-Path: <linux-kernel+bounces-207342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A59015ED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A38DB21224
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080242E63B;
	Sun,  9 Jun 2024 11:19:35 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12611865C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931974; cv=none; b=iyJbCKx/g/uzKvjD77BtP3rWuAL4Hd+OQF1eNJ9wdOSPGniJERpXAG/AUyFl6uDlMJtNwG+u/FPdMchCm7ksdZqzw/kQd8z1Zz5i4cZfmgJ7NIiu0hHddULutcDyeN89hZ13VlMAdaHxunjaZlouOLQZUPDty1M3nbDV94QdCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931974; c=relaxed/simple;
	bh=+V8Zax0iRwxHQ0eU9iOFL0Cw7Djo8PAj80uDzHJ0ARE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzmrCyhs23KKQYsxi919SX0YMQxSiPoKqBZCHBxQCx7Hq1UYPYZOPaEVqh8MhpDmMOAfZPctlsbjmGhVsDA+YjedSoSOgi4p5y/ZTwxaB4T1uDuk+Mpx0xxO9ta4w8DHNX355OikODJfGQUlmeN4hI4s65O6vKxPRQDaMUP7bVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 9 Jun
 2024 14:19:20 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 9 Jun 2024
 14:19:20 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: WARNING in cxacru_cm/usb_submit_urb
Date: Sun, 9 Jun 2024 04:19:14 -0700
Message-ID: <20240609111914.3620-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000d2c99705a01ead04@google.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
---
 drivers/usb/atm/cxacru.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 4ce7cba2b48a..8f3b9a0a38e1 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,6 +1131,7 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
+	struct usb_endpoint_descriptor *in, *out;
 	int ret;
 
 	/* instance init */
@@ -1177,6 +1178,19 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 		goto fail;
 	}
 
+	if (usb_endpoint_xfer_int(&cmd_ep->desc))
+		ret = usb_find_common_endpoints(intf->cur_altsetting,
+						NULL, NULL, &in, &out);
+	else
+		ret = usb_find_common_endpoints(intf->cur_altsetting,
+						&in, &out, NULL, NULL);
+
+	if (ret) {
+		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
 	if ((cmd_ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 			== USB_ENDPOINT_XFER_INT) {
 		usb_fill_int_urb(instance->rcv_urb,


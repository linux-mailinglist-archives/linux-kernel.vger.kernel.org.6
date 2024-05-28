Return-Path: <linux-kernel+bounces-192833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15098D22DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB3128507E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E945BEC;
	Tue, 28 May 2024 17:59:25 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8EC446A1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919164; cv=none; b=larcaTNG0IJfX34bDWA4p/wJSMU9iodIJSeQHzjUPozhl4u1hEtNXBjPyR8vjRRm66RafifQpd3bUjAWQpqSX6HlmfWNB/CPUUgMtTKvJQVR7W0lH34gCoOXNdWTiMNNBOvrxXJUVmhHaPqaLEXNGJU+QxRlQ2bUdcqWRFbsg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919164; c=relaxed/simple;
	bh=xdleK44FgukP8bWDJjnH5QvLaMzO588N0cV67F9/bd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO14fwBovdaok40Zc7FTWCXa8Elwz+QFf1LELajiEjFDgPCq0cXYd3TD63bjWdz7BW9qpTuG0kei8L/IhiZNL4hXnOzoFhveOLAuLxF1NXRz8EvAvnXMMjGmumTr+3gbwGUhpiAYy78cNArXBFif8bjBc1IaP9NyL2RpH0oKiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 28 May
 2024 20:59:16 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 28 May
 2024 20:59:16 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: WARNING in cxacru_cm/usb_submit_urb
Date: Tue, 28 May 2024 10:59:07 -0700
Message-ID: <20240528175907.3525-1-n.zhandarovich@fintech.ru>
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
 drivers/usb/atm/cxacru.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 4ce7cba2b48a..8a8e94a601c6 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,7 +1131,8 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
-	int ret;
+	struct usb_endpoint_descriptor *in, *out;
+	int ret = -1;
 
 	/* instance init */
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
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
+		usb_dbg(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
 	if ((cmd_ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 			== USB_ENDPOINT_XFER_INT) {
 		usb_fill_int_urb(instance->rcv_urb,


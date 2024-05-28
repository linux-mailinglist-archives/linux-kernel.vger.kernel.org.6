Return-Path: <linux-kernel+bounces-192871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE698D2356
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A301C225CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FA16D4FC;
	Tue, 28 May 2024 18:38:18 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805371C6A5;
	Tue, 28 May 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716921498; cv=none; b=RE4/YFsMj6KDHdLnNaIiT88vWFbecUceHdYwGy+usAxMeJzfdVRp8zMFIJgPFcJDtsjuzUp1Vv5qheWvefFVPsUp5kl96eJQDJPhVCQWQUta6zvQZcwck9XM4ZAchd8JggJ97gAO/ax8jLwFhsG+uPnByXOrJ+h40YqrmrVv04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716921498; c=relaxed/simple;
	bh=dWDoz0X/mYRcpwkIRGqglgh6THVbSl0vAvvqDr5ihkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vmfw5k2KVAqLeRvIhqSmmhriVAJJDVVouyhd9drWntKzOFfJHqdRhxw0Wz06UnXG1vyOY+j7/xIJopqxizRvDz0/NPrRbC97UuPAs5P+WvmEifqlaZoQjbujzc/6zh19UJadu9efzI8WJQK+toQhKWDfcG4Xbu5+tV4x+SyqqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 28 May
 2024 21:38:11 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 28 May
 2024 21:38:11 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<accessrunner-general@lists.sourceforge.net>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com>
Subject: [PATCH] usb: atm: cxacru: fix endpoint checking in cxacru_bind()
Date: Tue, 28 May 2024 11:38:07 -0700
Message-ID: <20240528183807.3832-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
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

Syzbot is still reporting quite an old issue [1] that occurs due to
incomplete checking of present usb endpoints. As such, wrong
endpoints types may be used at urb sumbitting stage which in turn
triggers a warning in usb_submit_urb().

Fix the issue by verifying that required endpoint types are present
for both in and out endpoints, taking into account cmd endpoint type.

Unfortunately, this patch has not been tested on real hardware.

[1] Syzbot report:
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 8667 at drivers/usb/core/urb.c:502 usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
Modules linked in:
CPU: 0 PID: 8667 Comm: kworker/0:4 Not tainted 5.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
..
Call Trace:
 cxacru_cm+0x3c0/0x8e0 drivers/usb/atm/cxacru.c:649
 cxacru_card_status+0x22/0xd0 drivers/usb/atm/cxacru.c:760
 cxacru_bind+0x7ac/0x11a0 drivers/usb/atm/cxacru.c:1209
 usbatm_usb_probe+0x321/0x1ae0 drivers/usb/atm/usbatm.c:1055
 cxacru_usb_probe+0xdf/0x1e0 drivers/usb/atm/cxacru.c:1363
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3354
 usb_set_configuration+0x113a/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293

Reported-and-tested-by: syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com
Fixes: 902ffc3c707c ("USB: cxacru: Use a bulk/int URB to access the command endpoint")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. While the driver is orphaned, it might still make sense to
suppress the syzbot report, seeing how ancient it is.
P.P.S. checkpatch complains about outdated format of debug printing
but I decided to keep it in tune with the rest of the driver. 

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


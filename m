Return-Path: <linux-kernel+bounces-512902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18DA33F03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E2F3A57AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12D22155B;
	Thu, 13 Feb 2025 12:23:08 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAD207E01;
	Thu, 13 Feb 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449388; cv=none; b=EEenRD3m/9mLUfLRJqngqGa8oxefzIOgvtLryL2uUtIjT0uknh5INjx75EALrErByGZHAk0PWy69A0G1QtZD+hfjvC+Y4pCMGmT69kyn05VneTRpvGlbfTUvMMG/56xalf0FDIR2Zn2qpspHxeTjefZUtPo/QS6OG4s82BZB9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449388; c=relaxed/simple;
	bh=XrCZbI1KCwa0EfL5BDXDVd6ZESCjvqyob9kFh9a5CVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txuam7u/07suHx4qxvUq7Q5bPLZLiAcMNhtNX3k08LvvpH9IMnhAsA9gNfBIp+hwtDxQ0Z0K3PZk/vA9cgmyW3ZljNGM026wLetGIWdd8YVQKscxZoq7enjb56rIwgnWKbKtqQhR7avJRAZ27hpUEsrn2TG5HBZVDYRqR+F7HWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 13 Feb
 2025 15:23:00 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 13 Feb
 2025 15:23:00 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<accessrunner-general@lists.sourceforge.net>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<syzbot+ccbbc229a024fa3e13b5@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: [PATCH] usb: atm: cxacru: fix a flaw in existing endpoint checks
Date: Thu, 13 Feb 2025 15:22:57 +0300
Message-ID: <20250213122259.730772-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
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

Syzbot once again identified a flaw in usb endpoint checking, see [1].
This time the issue stems from a commit authored by me (2eabb655a968
("usb: atm: cxacru: fix endpoint checking in cxacru_bind()")).

While using usb_find_common_endpoints() may usually be enough to
discard devices with wrong endpoints, in this case one needs more
than just finding and identifying the sufficient number of endpoints
of correct types - one needs to check the endpoint's address as well.

Since cxacru_bind() fills URBs with CXACRU_EP_CMD address in mind,
switch the endpoint verification approach to usb_check_XXX_endpoints()
instead to fix incomplete ep testing.

[1] Syzbot report:
usb 5-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 1378 at drivers/usb/core/urb.c:504 usb_submit_urb+0xc4e/0x18c0 drivers/usb/core/urb.c:503
...
RIP: 0010:usb_submit_urb+0xc4e/0x18c0 drivers/usb/core/urb.c:503
...
Call Trace:
 <TASK>
 cxacru_cm+0x3c8/0xe50 drivers/usb/atm/cxacru.c:649
 cxacru_card_status drivers/usb/atm/cxacru.c:760 [inline]
 cxacru_bind+0xcf9/0x1150 drivers/usb/atm/cxacru.c:1223
 usbatm_usb_probe+0x314/0x1d30 drivers/usb/atm/usbatm.c:1058
 cxacru_usb_probe+0x184/0x220 drivers/usb/atm/cxacru.c:1377
 usb_probe_interface+0x641/0xbb0 drivers/usb/core/driver.c:396
 really_probe+0x2b9/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
...

Reported-and-tested-by: syzbot+ccbbc229a024fa3e13b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ccbbc229a024fa3e13b5
Fixes: 2eabb655a968 ("usb: atm: cxacru: fix endpoint checking in cxacru_bind()")
Cc: stable@kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. another option would be to try to use endpoints found by
usb_find_common_endpoints() and use them to fill and send URBs.
But this may interfere with real devices and I have no way of
testing them myself.

 drivers/usb/atm/cxacru.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 0dd85d2635b9..47d06af33747 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,7 +1131,10 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
-	struct usb_endpoint_descriptor *in, *out;
+	static const u8 ep_addrs[] = {
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


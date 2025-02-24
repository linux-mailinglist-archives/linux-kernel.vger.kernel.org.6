Return-Path: <linux-kernel+bounces-529455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705FFA42690
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BB53BB9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F18C2561B2;
	Mon, 24 Feb 2025 15:30:49 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C914A627
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411048; cv=none; b=V+c7P+CKKKoNRSEtvs4cWe0vJPr5fGU7eHmFhwDxWVIUS7Jp9NUDCECw8nLCp02/zpuv+WKTXi8VyH/jlLnLGuN2dq9+X5Gbh1EcaXSbLhbbAs893G2RAkpMb03a8QAG1u7779Q/zY1u/yYze0QW25WEVKp2q0IHwi3tpigZb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411048; c=relaxed/simple;
	bh=i9Ox3gddLFBtFR4LN+v5YyKu6OcMpPDuA1FEgwSvwFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oxu7LnSvZaGW3g0e8sZrUbz2tfvfLwyXDXB3IHzpDmGH1O3l97inW5museCJ8psmqrCWTyE1IBONKja55hGyXO+CjYa+v8Pj7jMSW9+sgoWjlsIl3jFcUV4zwHVD+AF7uk3TA+i0bp4yS9bkKbIeZtbOFYC3GngGWPARMjOsmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 24 Feb
 2025 18:30:42 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 Feb
 2025 18:30:41 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb (2)
Date: Mon, 24 Feb 2025 18:30:34 +0300
Message-ID: <20250224153035.1219984-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000346bbd0613dc4396@google.com>
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

Test if fix is working.

Also, enable a fix to KASAN issue in android to get past build/boot
error.

#syz test
---
 drivers/android/binderfs.c | 1 +
 drivers/net/usb/gl620a.c   | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index bc6bae76ccaf..94c6446604fc 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,6 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
+		hlist_del_init(&device->hlist);
 		kfree(device->context.name);
 		kfree(device);
 	}
diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
index 46af78caf457..0bfa37c14059 100644
--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -179,9 +179,7 @@ static int genelink_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	dev->hard_mtu = GL_RCV_BUF_SIZE;
 	dev->net->hard_header_len += 4;
-	dev->in = usb_rcvbulkpipe(dev->udev, dev->driver_info->in);
-	dev->out = usb_sndbulkpipe(dev->udev, dev->driver_info->out);
-	return 0;
+	return usbnet_get_endpoints(dev, intf);
 }
 
 static const struct driver_info	genelink_info = {


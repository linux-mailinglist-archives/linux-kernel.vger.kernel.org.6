Return-Path: <linux-kernel+bounces-519857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D801A3A2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AD53A2829
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CE026E15A;
	Tue, 18 Feb 2025 16:29:45 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD051C3054
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896185; cv=none; b=XuL+K7Hcah0DPTmts6XMhm6k810HV5oiJmuax1Si+RmS9DOHRzVdKov4wmFl24SVPMsqOYcEUhVUbR4lJ/Pdmb3GfWTx026lIfqH1U5h+W0lzTgfYfc47lerdiFD1CvwFrXa7G1Ugea35kjhLJO4M7WcoWtwR4AfrISFAT/ydxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896185; c=relaxed/simple;
	bh=gCXNynCSULMV7N/Nw/nTy3wXntG/bQKHaxFV9fBm1rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNqgDNbbghL7pn+GqZjTPjsNXSFmArE5RP7bWyjDYrWl4NxJcBJOnj2NuSOwjBriQzXCWL0g0dzPw4qzlvFLQjujYIeLtnfl+BLVl/QsM/ADKxWg/xAkDGGvUASaoRk6nLDOghYrisjKiCUJxk25SY31izuNBJsa33fuWCa+CUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 18 Feb
 2025 19:29:31 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 Feb
 2025 19:29:31 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb (2)
Date: Tue, 18 Feb 2025 19:29:29 +0300
Message-ID: <20250218162931.958387-1-n.zhandarovich@fintech.ru>
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

Do basic endpoint verification via usbnet utilities in gl620a driver.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
---
 drivers/net/usb/gl620a.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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


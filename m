Return-Path: <linux-kernel+bounces-218854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32C90C70E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49B41F2481F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78AB1AAE0B;
	Tue, 18 Jun 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CDYIvS5Z"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14BA1AAE07
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698928; cv=none; b=a89uM+8PXOjLvdS3aUVowr6MuyW9DT1t4BZqGXg04seKZU6m/O+U8LFeX+dC0AjTQSd9BLTElB3l/jc+meuLQbphINkptp39kHofHRaGWQ//AAzMtRXaKvxBuQ8gviwmvfeNN5gOtV5Y5xM+niibsri/K/EtDyGkNr1MFqnELAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698928; c=relaxed/simple;
	bh=m5Q9Ccwh0sDs/QkQ9CGmXJGRyQhdTtsLcjO7xUlW1lo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RJQHexmppZ/qvx9La00kuDlaskABPyKM5zokiKdBCywHgffUtrCDNFboiywWzouZyu4Rt4KlgQIVqGfi75pPlS+UU4H6nhNRb4a9Rf7NeG5dGrC0dGVPnLVMC7ZY3esVPo+HyJ2kgzJfy2Mh7z88ZZSjDcxk6Mq+IPIJQUdzM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CDYIvS5Z; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718698917; bh=EMkwW3BuRrcyRf+r4YOMWvOLhiIjfGv1mcpyT1IpxOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDYIvS5ZWn4dj2pqNjLw6PNW4G/NrfwhaGuDSQz9qfHJCg5xk6S5hMfDcqPYBk2AN
	 46DhQklgFEZnRpzlBoMBKsoYuFpeREiGJnG484t2Z8pDR9Py1aAqH2lAEWbZMri+Hm
	 Sdo8OXdynPQFhlfxJnhy/XYI1u0m2ShQ6pf2MOOs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 577864FD; Tue, 18 Jun 2024 16:21:55 +0800
X-QQ-mid: xmsmtpt1718698915tn1svsqbe
Message-ID: <tencent_000DE025D70D8E120A5DA8DDBD19064FAD07@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wHYXFAfj21zA8f0XlGBw0WT+Eh54qoJgjKDVVg59tOatxfgi9Sr
	 BJjYR4b7emyVdWboBK6oigixH/50gggZoxkTCCDK3GqeWQ48Dx7PnvxUgg68mvQcsvT+FVM7jvc0
	 dian1wUvFgZ97ZdWALRq+r7fqHXGKRTb4t5ubexJ0bvkD6Aw5rShK7ivk6Jryx8QlxszB00fI8Oh
	 pISue2FqyBBWOHLIImJ0gZMaen5tUrp7UbDloie8CeiTF4Kq/DeKFYToliRhVN9CkXs5dySGLH7J
	 rbmF24JYDH6j7QQ41fgbkzE27BJAT8Qh3InhZ8oeriiIBZFgnPrF2wHCx4nX5Idu43QkE5GITVlp
	 QpMewl+FoFI+DV/GQ+y1RJSM07WVK8akYNwPFUKjW71+So5BFXyVLTo4W8ty9egUJL8i5IBSVWDK
	 CHRkRMG7OjZuW+QOLpmPhA2wz5Jlb6DfSdPTaRC4kYJer1Zlj1TZRNXiICDBYfjtfKeehceg2IyT
	 WV2oOIRx2WnsBSLEQ/YwoIDWE4VJ9Y3Pf+bwquzfbZoBHVGYFils2u3Qr4AhI1MmF2VlDolG1H4k
	 dtJLei7rH+b6g/7AbPYppAPoekauZCuev8f8+A4/ZtMXgh7eI3YkbJBGrqmY+Jvsy769+2EpGJ1i
	 V4lE0suX9EO93UeC2zoPasJYv0znu6InLUV0lhC02UR1U2n+bPRDedkLEBLClm/PWbKzhMDVbvxt
	 tXoh0R1A8teS7xdkJkEKJJmZvURunGV7Jo78BASzWuUSPcK2kWFzBaB2dnsoCKIOcjKFOez+KT2Y
	 cyR2jUShGG329f1rzZBws/KehWP9a3xJPpXu0c//bjO9zqU+/JbDxsdtJKzOIxUNDMEvV/ezfaHG
	 /ANav+IABds2D+OQE/8J9kpM6485xemmPbcIo7RpT33WDZAaEv078=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7e51ea277ea81fe6935d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] BUG: soft lockup in mac80211_hwsim_beacon (2)
Date: Tue, 18 Jun 2024 16:21:56 +0800
X-OQ-MSGID: <20240618082155.1269194-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000d388cf061af92595@google.com>
References: <000000000000d388cf061af92595@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test sl

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2ccbdf43d5e7

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 6830be4419e2..a6e761638078 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -273,7 +273,7 @@ static void wdm_int_callback(struct urb *urb)
 	}
 
 	if (urb->actual_length < sizeof(struct usb_cdc_notification)) {
-		dev_err(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
+		dev_dbg(&desc->intf->dev, "wdm_int_callback - %d bytes\n",
 			urb->actual_length);
 		goto exit;
 	}



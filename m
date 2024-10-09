Return-Path: <linux-kernel+bounces-356574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E8996387
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501251C23D16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EA9187561;
	Wed,  9 Oct 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Tp+AsM+t"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472018A6A3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463163; cv=none; b=GQy5ZN//F8DcXNsJRSWqNOT3TwzgniLrgchcxapcYHY312fFGc6kT7o2CTPP7P2ZKx6hSQ+cu07ekcHlIN2HjjABKRrc7HBztQ8aSGe+ZQzDFbRRn9UMThOYu54q/+MNR5fXu2sN0KhR5u7xYdwyyxeX/0QBMROT3hXQcj/a3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463163; c=relaxed/simple;
	bh=dUqjSUjqB/n/llU6r5QMLiTG16V3Hd20G8RiK2oLizo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fMMu/D4yDoBhFVpPYFANwviG+DDi3/qO7cZ+g9Dsmev1bdZe7ssIXMteI5NntjUFGmvr/9U/ciNoW6XkHuucnbILnamUKxSudF2ArzswsnyvYGNJe3uDpgVhWYjBEGX2921SmkXoxnu++2WeH6dElkENUblWzLZf+SwKy1S3nvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Tp+AsM+t; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728463153; bh=zsGbU4egY3J7HI4TYM66msMk7fjnGTq9IHTedECqG+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tp+AsM+t4N8y0qWK49tiNqZabkpz1pHS5G5lzvDmliamjgej5T+iv0eF2IxqDxvCJ
	 6s7LL08LvnjvBw0+gXnsnyDSiKndlaI2xK8cqfVFQ7nPd9TLO2kLppwQf7ArrcdvRW
	 VnLiQu6Gnt3CZ6a4yd6+0ZfgWEfJSIczZeamtsWc=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9CC0D84B; Wed, 09 Oct 2024 16:39:12 +0800
X-QQ-mid: xmsmtpt1728463152tssl4ueqh
Message-ID: <tencent_50D0A5FA0DA39222DD8A5DDF192D4FC80D07@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtTO02SnXfjtQVAzvmN5IuQ5Ul+NbVMk/cj0Og5e2QKb05hQlk9r
	 Oq8+VgfQIescXr6czlm5MkYfIChLMK67lNfEIYnQgPRXBxjrZI4ST8ER9dz51JnMbml4Ffm04967
	 DAVKxF+E9rsZRCsjxc7g5GjLmoIL+NICtJwhlK4lkRJsBGAXjsw6FOKRyfFT1Sxg/dBpiVHQc1IX
	 QzaaV2uMxK23CfcNv9fpSJGeFMMMJBSIJItiJMYTu/Xp3TZQx+hGqssuXC6B5daLqvLm7vHOO4iw
	 GQWUonksw1Qqvj/eYoLX6S7VM9h50pTmlLxVS9wk07WqVlz6WCMtenlIxdRJpZ651dwTgLvoPpyh
	 Wlj0AonyRiKQGfPFWsQCiL2lAVzJsqbvZwDHSyaJ6FI9hbK1bBSNX/kB4pJtI2937uR1nJzUWnWB
	 rIOvy3rJ5d9FzCZbDdgArlOhHg7FnZ34i+A0+XyLiDQHevbbSmtUq2eJaatR+RA8PU34fcN4h7xr
	 +HAIEQ0FyVdp3/XamjAzyWOmYG3BkUIjblnmR7XjKY9M8W50pBRF+VH8Z7LNJI1RPor3x2H8D1zm
	 eUGT6IYYPZ287RaHWXFikt0CXrn52f3dIjDTa2Z1tMie/e/wLYaEnlP/pdkChcjkWl7RvPq93ijU
	 fz0VCrU/Kwn/+vnH2zlcFuUapBG5GxbPMBuyNz3I4kOmTGb85gj7r4NfMDM/llGb0EVA+fRqw3BW
	 Z+xinV6rvDSGhIrpySSRst9aoumHv0s3Z51/tXhk9Oihzbe8ZzPECCFuc0OtPCV7+sajp7bLaM2Y
	 ehjHBACADTkOKY+6rvbcSggQvKth5eMRFy2wJ3vekQDEfc7dzPN73jTOH+R0AnFR0TgcoZj9FgMZ
	 7txG583uMQVr/klvG7Laoa7qnKrg7a87XV8mGnzLOegoqUHI7Mkwc0kLb65rjxAG7HCr6cygfatz
	 sDSx14wT0KG0z4TQ7VuEM5q96bl+ubp5NdcqqkCuHp32rD7g9/8R0BEw7uQlWk
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [usb?] possible deadlock in chaoskey_open
Date: Wed,  9 Oct 2024 16:39:07 +0800
X-OQ-MSGID: <20241009083906.1212717-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6705f457.050a0220.3f80e.0021.GAE@google.com>
References: <6705f457.050a0220.3f80e.0021.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

delay get the chaoskey_list_lock, avoid to circular locking dependency

#syz test

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index e8b63df5f975..17e29c6e878b 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -232,10 +232,10 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	if (dev->hwrng_registered)
 		hwrng_unregister(&dev->hwrng);
 
-	mutex_lock(&chaoskey_list_lock);
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	dev->present = false;



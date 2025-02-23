Return-Path: <linux-kernel+bounces-527756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0CFA40F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0241898239
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216792063EA;
	Sun, 23 Feb 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mD/OxH+n"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE801C84B7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740317649; cv=none; b=a0T5h5DTZeOw+U1sqxKgiwDI3K8UzQdy1HSQh34mF0HMB2MPN+4P1U7A9xiWYwmIyR8j5QLuVh76hC1LD5AVXcvAEN32Eg66QLlnzMn161wFaESZc5WuqXTbsd8LBI2mnEaQ6LmloojtH1f1pMk3NkrZxqTiVPZaEeK/yEB7KsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740317649; c=relaxed/simple;
	bh=3AyCXbix7cFfnULsuth7dztzkVojT+Q+ULsnH4Tgays=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pkyjvl6JaNVV7yaT8lceayKOcVeahJAczFVdr0iMicwS3CzH19atbNxV+sCgSt+fwoLbgyY5bccQfLQIb1+SJXQ7hla2ObdqIjG6fQiVcNVuGKm/zoeFPGTKFvH32IhK4glGYpQ4dBAToVZ3tR7277qpOPNbdUK99drROnz76vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mD/OxH+n; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740317639; bh=9Wvb//uSWMtmDkp50Pb9+KyvOfYQEXCKsUwS6Q1Z6Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mD/OxH+nfVm+ncFcgEPJxth1z8NHh1WOFVNLjupmKp9gdFAkDU2L5aNbttWFqCKGU
	 rLwJ7ZibhMBZGU9ZJ0M1xrU5ZAgXmCR/Fc6JWJbVbTwv92sNTxSqqB+/aocIeIRfVp
	 2Fa6gZmK/Xo9f4OYgPKGUNA9dR3U9PWkdzW4Oj+Q=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 66809E98; Sun, 23 Feb 2025 21:25:40 +0800
X-QQ-mid: xmsmtpt1740317140tebzyohxq
Message-ID: <tencent_08165DBC5DF09954CF920D98A5F78D9C9207@qq.com>
X-QQ-XMAILINFO: MgRVKi3YcRBINQoDVxj9REFmWboZSgC5w8vXh8xmuqDJ2Ll6sAmMiP5pd+ddCt
	 dkyTJpEV+L0UbnGcsNWNKKFopZq8m9U/9nvmHPgq7l/zZxo65yzzXedPHak4FMmG5yx5wLydXMlm
	 4eSQuTbd8BV8zTL/MPAtpse6i1MJcxUkjiLo2dBoW8bVfgqqeV2i6m4RiU67vZT7IxGmPqIbusb6
	 bd1UdwdgNhrCHVGBC3ONctCFX6PQPmCAFpvYh8x+/2Ts3oN/0ZyJwmqwuc1cTepTRSFjKiZcepFE
	 nbPIZUGEKhAiiwh3j1k/1q34h48zGyUB5osKrM2KyBE/pY1kYQXT9SdKYHcJaSia9AbLkxM2mFCy
	 0oCCK8XQCWkj1Hp6HqAYBFjZehZpt/5UmwC5uQXZEviwH/G1qg+boH7/yTrgyaq8+MR0/unrQyYb
	 iGWkdclgKrnDTMQBDjVSoevOfDa0a5sItys3Qe4UHfmwOBVck1BOhO0//u0QuJHvoCjkH0RqXMaU
	 VeBjuj76h/zPMd6laBNJxg13lrGtc94ou8QFTQmjNDE+eBOLYMTUiNSp51mXoY5G8kr9LVTM6YNu
	 iWCR+MqDQWyy3Wt5eBdYbYHdpc/b3ZuvKVVUs6mrrQP4TKStISDNUmBMO2G/tlhqjmyTQluzC8ud
	 0yxX5DnGWfCbysVTW273NDPlnk1U46upYNFEo1JnX9PmLAoFp2Xx2bYHXeuUJzp7NUwc7ehigYuD
	 dY90Na7fF56sLv+DUyMclL5Hx5ET9Sx6HWivLTtS9l8CXSf+YbP2nAqAtu6baFhNr6pU4z2G8R9Y
	 /7boaE+Y0+g2p0v5TGIK+zv0dQQ48Poo/uGRvArhDfh+HHrBOJnHjM9UL0ZrjUahT2fK0YpA980Y
	 7KJX69ildsGq3W4/KqKHjxihYYdow/ZEeXL7/Bk+kgr5M9SlX3YGY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 21:25:40 +0800
X-OQ-MSGID: <20250223132539.496057-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
References: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index c9e65e9088b3..4a70ca5eeb1a 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1086,6 +1086,7 @@ static void steam_work_unregister_cb(struct work_struct *work)
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
+	printk("steam: %p, opened: %d, connected: %d, %s\n", steam, opened, connected, __func__);
 	if (connected) {
 		if (opened) {
 			steam_sensors_unregister(steam);
@@ -1153,11 +1154,10 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	struct steam_device *steam = hdev->driver_data;
 
 	unsigned long flags;
-	bool connected;
 
 	spin_lock_irqsave(&steam->lock, flags);
-	steam->client_opened--;
-	connected = steam->connected && !steam->client_opened;
+	if (steam->client_opened > 0)
+		steam->client_opened--;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
 	schedule_work(&steam->unregister_work);
@@ -1322,6 +1322,7 @@ static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
 
+	printk("steam: %p, hid device is group steam %d, %s\n", steam, hdev->group == HID_GROUP_STEAM, __func__);
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
 		return;



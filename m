Return-Path: <linux-kernel+bounces-527767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B6A40F3F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F543B8F92
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584B2045B9;
	Sun, 23 Feb 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZC2WyTk/"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97726AF3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320473; cv=none; b=OB6h5gQOvMkk63vhgBq0t5/n6d4m+JQTBgIxUShsivzBlEjW9FJ2Pxm/U0BeNBq9FnMOzZvd3BrGR3QcAm1xgVq5n620MCQkWS77TsbXouwcDnv2iCEa7W1+ceuomdCNntxXRiG5+OP+UrMobWfDk4gVLlbDU2L5k3OFaSe6Nlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320473; c=relaxed/simple;
	bh=88rGPDOYETCZr3cM9rSejwP7ruvdEdp6vXBjlVqp/J0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CA99Z+Ww/vB6fUl/YPU3BL/VQIKnfCNA33ZjP41ueT2cnVM1WwEJtJjVxD3I7uAMxEuUaHAil1JxoZZZGH7Ixh8vOK11lKv1dqRdZqE1tV15w11GodbyTujz0JJXHohtNEv0p4YHFY/+Schu9hHuMI9Ax8i5Es4wSSSE6QcBCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZC2WyTk/; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740320157; bh=sAg2oEgvzK7mupe9CXHSz2+v3Jf3u9gkrgsJJNA0ifw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZC2WyTk/q1YA64rex1mRwRGwkqeFv6o4WZ9kFfZgMYcROA3xUiQ8hXZIwJ6Q7NUwN
	 OnrLanlNCbiogxTJ++SCT8RxL97pLQiREvJV/AV8v7bGbzRxt3VoUp+IMLGv2T4FnG
	 dFS8WAd1xBZ/hr9tEKr11adjW1IBg2iYL+xDegT8=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 3F7B2E45; Sun, 23 Feb 2025 22:15:55 +0800
X-QQ-mid: xmsmtpt1740320155tvbmbsxaw
Message-ID: <tencent_610D8DA5A60DA31253DD9D5DA59909CFA807@qq.com>
X-QQ-XMAILINFO: MPEorwW6cFo9o5XvcMcA7QnFSVmQjvVG5n6ZssIANp4vHMpQiE2zrGeVT2YcYZ
	 XkR8uwttIzvLrH5QcWIHapEusfCTjqPugnoTxwpwj/7pqj5BRaZfmrn1WUv+3sZjUKZpX2NYb3MG
	 qvbOnSXmXVm0BA6YOcN4pDnW2/OTbNFYB23axKj2flVvOEYPkb713c23xxquAv9hXmB5g7z9yrg8
	 4jNyUw6yAiBBvx54YapnQlzKoyb7zQbvfoUG3BINYXkWaI94+4gKI/b0Ez3WuU/ECtwXarLQz7bY
	 bmv8x1Cil2d4fAf4h6eRD4q6BbU8p9MtLDgT3InjiD8p/JzNTbD7bnBjOyjWVBfJn8tDo3lR+MhK
	 v/CDYCZvwDBLpCBXv470xGNRHv1tSx3Wot8e3GHdqds/x44NRkW8MQOyAMqmIPBrsqvtWbWBEUvr
	 VE039TfRL7OHd7RP43gtWMT3U1EBOfPyNRZVjhetPhWaoJUDsY3WQkso2UkcB1JdkwsptA5zil9k
	 5vfglFo+3v/MnaULbcbXR6tnPbv3T2DcktxwWKt9Hn86Fq3bqT+gpiMBVdeqd0F2HxsZjTUPpR61
	 /II+W3ikgEogNkMf8Q9ZkWG/lXSh7YXgO/yRmPweMA/PiSpsrLuFyFkSGY0ULrzogEBXvn3Dd6d9
	 VykQTmK8lym5L3D5mRmY8we/dDXkVNTpdamwNBUVR+DVMo3yVDaBU07BlwOXaucyWvjIkoJAu06l
	 G03DUuosQTLGI91zJOtl3xbZxPHpF/RDnTlN3fV+Lm4ZysZLU/ZixM5p2uU7D8+3PAFPUn5h88tn
	 IRbitaBoOETrn0YfEjdAC6jNbUyLEyx8071Harw8JJCbijp4YQIcRzv/F+ESH3jWBxFltY8wxJiV
	 xNHe+MYqZEpT/0KpFVd8FegA0yNJZOied6SYBuOn1m7lKUEzVLkWOGNfg1YneC6A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 22:15:56 +0800
X-OQ-MSGID: <20250223141555.542448-2-eadavis@qq.com>
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
index c9e65e9088b3..2317c3f7e037 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -596,6 +596,7 @@ static int steam_input_open(struct input_dev *dev)
 	unsigned long flags;
 	bool set_lizard_mode;
 
+	printk("steam: %p, %s\n", steam, __func__);
 	/*
 	 * Disabling lizard mode automatically is only done on the Steam
 	 * Controller. On the Steam Deck, this is toggled manually by holding
@@ -1086,6 +1087,10 @@ static void steam_work_unregister_cb(struct work_struct *work)
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
+	printk("steam: %p, client_hdev: %p, opened: %d, connected: %d, input: %p, %s\n", steam, steam->client_hdev, opened, connected, input, __func__);
+	if (!steam->client_hdev)
+		return;
+
 	if (connected) {
 		if (opened) {
 			steam_sensors_unregister(steam);
@@ -1153,11 +1158,10 @@ static void steam_client_ll_close(struct hid_device *hdev)
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
@@ -1322,6 +1326,7 @@ static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
 
+	printk("steam: %p, hid device is group steam %d, %s\n", steam, hdev->group == HID_GROUP_STEAM, __func__);
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
 		return;



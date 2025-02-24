Return-Path: <linux-kernel+bounces-528176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D0A4148E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC64D188D35E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E621AAA1D;
	Mon, 24 Feb 2025 04:54:35 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495A2F3B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372875; cv=none; b=BskMHRvjWUkx86+lmHnDRQm4iGOj/1jAMg1VwyxSmYD9IOiMtCzs1DfrKH65K9Q/qRgt9AGTeMrprIekNPIrF+eMYLCTIBGfevOk8oHq/FMuxoTUumYGIf5X6N8ddkrDoXz1FvZqsAfydPly7WBeMsnst/cs1vg/aadAZILZ1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372875; c=relaxed/simple;
	bh=Y1th7TCKRnc1Igzghx/0oQZwI6Axf5FJPd6T4hOut2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7vP94fjWOWOkNkvpTQ1gbRNX1miiFh0gW9ddjd8tu8xz9eCz4wI6sKtK8ZAEju+YrVrHOIdYq9Xh3cw2Wa5JBDvqY6KB+G6BIcpDoPljLyusz+blD3dh/YbmRT5UYCP0wR0yRhmrE6Lc/NW8A+xqm1HXrggQKT2uWd82cdwpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.129])
	by sina.com (10.185.250.24) with ESMTP
	id 67BBFB7B000069A1; Mon, 24 Feb 2025 12:54:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 37983610748523
X-SMAIL-UIID: 4E3D1F39833C4AD7B6425EC5C0A07305-20250224-125422-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Mon, 24 Feb 2025 12:54:09 +0800
Message-ID: <20250224045410.2756-1-hdanton@sina.com>
In-Reply-To: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 22 Feb 2025 09:01:23 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    0a86e49acfbb dt-bindings: usb: samsung,exynos-dwc3 Add exy..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c02ba4580000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/hid/hid-steam.c
+++ y/drivers/hid/hid-steam.c
@@ -314,6 +314,7 @@ struct steam_device {
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
 	struct work_struct unregister_work;
+	struct work_struct unregister_work2;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -618,6 +619,8 @@ static void steam_input_close(struct inp
 	unsigned long flags;
 	bool set_lizard_mode;
 
+	if (dev->going_away)
+		return;
 	if (!(steam->quirks & STEAM_QUIRK_DECK)) {
 		spin_lock_irqsave(&steam->lock, flags);
 		set_lizard_mode = !steam->client_opened && lizard_mode;
@@ -1077,25 +1080,17 @@ static void steam_work_unregister_cb(str
 {
 	struct steam_device *steam = container_of(work, struct steam_device,
 							unregister_work);
-	unsigned long flags;
-	bool connected;
-	bool opened;
-
-	spin_lock_irqsave(&steam->lock, flags);
-	opened = steam->client_opened;
-	connected = steam->connected;
-	spin_unlock_irqrestore(&steam->lock, flags);
+	steam_sensors_unregister(steam);
+	steam_input_unregister(steam);
+}
 
-	if (connected) {
-		if (opened) {
-			steam_sensors_unregister(steam);
-			steam_input_unregister(steam);
-		} else {
-			steam_set_lizard_mode(steam, lizard_mode);
-			steam_input_register(steam);
-			steam_sensors_register(steam);
-		}
-	}
+static void steam_work_unregister_cb2(struct work_struct *work)
+{
+	struct steam_device *steam = container_of(work, struct steam_device,
+							unregister_work2);
+	steam_set_lizard_mode(steam, lizard_mode);
+	steam_input_register(steam);
+	steam_sensors_register(steam);
 }
 
 static bool steam_is_valve_interface(struct hid_device *hdev)
@@ -1160,7 +1155,7 @@ static void steam_client_ll_close(struct
 	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->unregister_work2);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -1253,6 +1248,7 @@ static int steam_probe(struct hid_device
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
 	steam->sensor_timestamp_us = 0;
 	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
+	INIT_WORK(&steam->unregister_work2, steam_work_unregister_cb2);
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
@@ -1314,6 +1310,7 @@ err_cancel_work:
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_work_sync(&steam->unregister_work);
+	cancel_work_sync(&steam->unregister_work2);
 
 	return ret;
 }
@@ -1330,7 +1327,6 @@ static void steam_remove(struct hid_devi
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 	hid_destroy_device(steam->client_hdev);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
@@ -1340,6 +1336,8 @@ static void steam_remove(struct hid_devi
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	flush_work(&steam->unregister_work);
+	flush_work(&steam->unregister_work2);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
--


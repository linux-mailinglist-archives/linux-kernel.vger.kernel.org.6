Return-Path: <linux-kernel+bounces-528724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B77A41B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794C13B482D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBEE2566D8;
	Mon, 24 Feb 2025 10:41:41 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46194189912
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393700; cv=none; b=W3CO7ZcVRzcy7F9KZyRziZejsA1FdOJTmxtjhYoId24f+XDx3FE+xD3iWC7AJChasXzubHBANErNDfs0BQFuDwF0hLCmDcoG4hHPd8QJIoX+sQQqkSsf+6LF6p8eJv2NUxpZQmiXfTvjfcPn7f72aGdohyiwWsCMrNXC5OE5ozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393700; c=relaxed/simple;
	bh=CTinIevPsAsfwXHtuqoFEXRNM7OiV3OQGBsw1VQSnRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njV94W5/IIiXrubQdm0T0TIZjxwnmMfPNI6fC0i31KKWUJmC9+s8jbS6GvLQ9apTgM4eiD8hD77fnZ1u+sNVgzw0ccURKl7HFGd5xPu43Rtkqhd5Bw72XIyjPImNIsFeUwf+/I96esr5cGlZODnbGgc5+OOtls9mDW8ft/9KIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.129])
	by sina.com (10.185.250.24) with ESMTP
	id 67BC4CD3000019F1; Mon, 24 Feb 2025 18:41:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 86109510748425
X-SMAIL-UIID: 2CD96E9E2D834D4F8555EE832F7BCCC8-20250224-184127-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Mon, 24 Feb 2025 18:41:13 +0800
Message-ID: <20250224104114.2781-1-hdanton@sina.com>
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
@@ -313,6 +313,7 @@ struct steam_device {
 	u16 rumble_left;
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
+	unsigned int dead;
 	struct work_struct unregister_work;
 };
 
@@ -618,6 +619,8 @@ static void steam_input_close(struct inp
 	unsigned long flags;
 	bool set_lizard_mode;
 
+	if (dev->going_away)
+		return;
 	if (!(steam->quirks & STEAM_QUIRK_DECK)) {
 		spin_lock_irqsave(&steam->lock, flags);
 		set_lizard_mode = !steam->client_opened && lizard_mode;
@@ -1140,6 +1143,10 @@ static int steam_client_ll_open(struct h
 	unsigned long flags;
 
 	spin_lock_irqsave(&steam->lock, flags);
+	if (steam->dead) {
+		spin_unlock_irqrestore(&steam->lock, flags);
+		return -ENODEV;
+	}
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
@@ -1156,6 +1163,10 @@ static void steam_client_ll_close(struct
 	bool connected;
 
 	spin_lock_irqsave(&steam->lock, flags);
+	if (steam->dead) {
+		spin_unlock_irqrestore(&steam->lock, flags);
+		return;
+	}
 	steam->client_opened--;
 	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
@@ -1321,11 +1332,15 @@ err_cancel_work:
 static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
 		return;
 	}
+	spin_lock_irqsave(&steam->lock, flags);
+	steam->dead++;
+	spin_unlock_irqrestore(&steam->lock, flags);
 
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
@@ -1350,6 +1365,8 @@ static void steam_do_connect_event(struc
 	spin_lock_irqsave(&steam->lock, flags);
 	changed = steam->connected != connected;
 	steam->connected = connected;
+	if (steam->dead)
+		changed = false;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
 	if (changed && schedule_work(&steam->work_connect) == 0)
--


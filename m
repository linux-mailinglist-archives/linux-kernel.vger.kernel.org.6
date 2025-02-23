Return-Path: <linux-kernel+bounces-527638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9DA40D90
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B034D179BFA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B851FDE15;
	Sun, 23 Feb 2025 09:06:45 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51042868B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740301605; cv=none; b=sKad16xu7T+KKIFe1ioaZ8m0J8TuZVIP1WM2a3Z9bu9PWSiJuaQXHOuV9nJ+6LippxIXNPCG6HGhukSbLteOmvjsjCpsGsmJ06qtXijZIVLnJ2tvfhause+xF00nKjsokXvUIBbyJpbEm7KgUNMo9uuQXWJ4TzyYIAnEJQJCPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740301605; c=relaxed/simple;
	bh=midBqKvE5BR/GgmwE1mXEQMqgCvLwyQHB0vRxcA+brs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mExi9xy9MUq+1feGJYpnT3pxWf3uqFuYseIddcfvl4rDhebVHhjRRk707NH5/dR+/Dnx+swLSwD5V6DqxaeDU+8d+N9Sl1ESpxyF0ou+oQzHXRhKuC8TdTtxpD+RSdFdtsj3hLSGMnepWii+zurIvCvW3rdRCpacNXvZnil0SWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.168])
	by sina.com (10.185.250.24) with ESMTP
	id 67BAE48800001817; Sun, 23 Feb 2025 17:04:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 26210310748389
X-SMAIL-UIID: E66A617CB0D242ADBA69091F6EF8F0A3-20250223-170411-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 17:03:57 +0800
Message-ID: <20250223090358.2692-1-hdanton@sina.com>
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
@@ -618,6 +618,8 @@ static void steam_input_close(struct inp
 	unsigned long flags;
 	bool set_lizard_mode;
 
+	if (dev->going_away)
+		return;
 	if (!(steam->quirks & STEAM_QUIRK_DECK)) {
 		spin_lock_irqsave(&steam->lock, flags);
 		set_lizard_mode = !steam->client_opened && lizard_mode;
@@ -1086,6 +1088,11 @@ static void steam_work_unregister_cb(str
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
+	if (opened) {
+		steam_sensors_unregister(steam);
+		steam_input_unregister(steam);
+		opened = false;
+	}
 	if (connected) {
 		if (opened) {
 			steam_sensors_unregister(steam);
@@ -1340,6 +1347,7 @@ static void steam_remove(struct hid_devi
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	disable_work_sync(&steam->unregister_work);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
--


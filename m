Return-Path: <linux-kernel+bounces-527560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657AAA40C9C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 04:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8019B171079
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9542AE8C;
	Sun, 23 Feb 2025 03:04:16 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E03211
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740279856; cv=none; b=e7Zt/CUe9NTA0m/NFAQo8cDlaGyV8mRjQQY+BbPc+lCb5SLCI3RLm00VR67BPhgBmMkJzyLsNOCTcYDzyjibfw4gShqts2mDqig9KGhIxxcw3Mfm45Ek2VeoBqezL7HOskmeJ82/KY+dCL1GK2BtYteqWoAE9oReMq5PzPmxYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740279856; c=relaxed/simple;
	bh=nFJOgHjZ/C15HHyUUvUbqP3vs9RuYGp0BbHxqJds6So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxSE8IEBUpc29QpMjD0mXA9cLFPnx9zdOXkC6kLa3CbMMZw26ZwtrbAiOPdzSOHAf0lTP0Ta9k7ZNIMixlkdieZKtNMKZOQ132D3PfTexEzxVQq/+mmyTtgIqtPh9jLXI7P6MEmY22B79FoS6Zfk2/6S9gWecAV9sWUR/ssi1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.60])
	by sina.com (10.185.250.23) with ESMTP
	id 67BA8DE300001EB3; Sun, 23 Feb 2025 10:54:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2321688913523
X-SMAIL-UIID: 49433830E50740C28B5D7CCAD58D1252-20250223-105430-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 10:54:16 +0800
Message-ID: <20250223025417.2617-1-hdanton@sina.com>
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
@@ -1086,15 +1086,14 @@ static void steam_work_unregister_cb(str
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
+	if (opened) {
+		steam_sensors_unregister(steam);
+		steam_input_unregister(steam);
+	}
 	if (connected) {
-		if (opened) {
-			steam_sensors_unregister(steam);
-			steam_input_unregister(steam);
-		} else {
-			steam_set_lizard_mode(steam, lizard_mode);
-			steam_input_register(steam);
-			steam_sensors_register(steam);
-		}
+		steam_set_lizard_mode(steam, lizard_mode);
+		steam_input_register(steam);
+		steam_sensors_register(steam);
 	}
 }
 
@@ -1340,6 +1339,7 @@ static void steam_remove(struct hid_devi
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	disable_work_sync(&steam->unregister_work);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
--


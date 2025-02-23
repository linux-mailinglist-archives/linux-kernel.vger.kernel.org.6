Return-Path: <linux-kernel+bounces-527534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB60BA40C64
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D56189B4DC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61F6AAD;
	Sun, 23 Feb 2025 00:28:12 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A305383
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740270492; cv=none; b=j5Y4YVSIiOONtFKD1aXLFB0jr4ckzqZfszGd7jGq0J/nqwu97Vocfb0EZ6rzkn4M8jfZMp4TLap75nwj6nYrk5K5Q0f6kvBr4VxICuCJdWA6aSMqiGbl0XCu/QHFwuXD+zxcSW18v/oq/LqMjtPpQugWAEXJQWyVjqqdEo1svuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740270492; c=relaxed/simple;
	bh=ym+z2pQwcM7Agfds4ni0YflO5URxRMTg4Polq3Ulxmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XorVDEh/4NSEmgaH5RxGtZrxAdyWyf8vZbr1n0EsG/RNxerRRPH6tuZYdwk7AuJmUPHuTP6ezFxJ9JwC2lDGjo4GApdsA5PdYvARCpuT864psNjT/gM95FLRawHVGNcn1uYFE/yL+l28iZH+dnOys261SaAD5byScaB2vdBUdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.60])
	by sina.com (10.185.250.24) with ESMTP
	id 67BA6B8A00005948; Sun, 23 Feb 2025 08:27:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 76096110748399
X-SMAIL-UIID: 6DFE8143692F4CED97CAD350A03ED4A8-20250223-082756-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 08:27:42 +0800
Message-ID: <20250223002744.2585-1-hdanton@sina.com>
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
 
--


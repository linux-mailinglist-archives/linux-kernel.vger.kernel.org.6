Return-Path: <linux-kernel+bounces-527710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE9DA40E66
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D6177860
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC819205500;
	Sun, 23 Feb 2025 11:40:02 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB273D984
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310802; cv=none; b=rHG45lWECqbe8dAxQDMTF5dUAjS7GMVqmbsoArBLdrX6ns5sK4px7Jsk+ArEerS2UL4hrRaLA4SI3wDIDDcSPf/HqOUgeQHYIPRJ7QqwnUyqNkKizm/+mySLa3ExBJhn3NTW9qW4GArUI0RELuM798aoLf6I9BN1yfR5b4xRRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310802; c=relaxed/simple;
	bh=OLIy4modDSwY3TLo69aA3bPaHuOWulX6JyVnqWabyew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTveudbPvqlT+fhkeon4BsJt1tVS0FXpT59ru3+77zfLq/MXYME8YjiO7MrKWtNVNuMCjZCvWvzX7mAqFYhn8sgZapwgcatgmXwXvXRQ9EhQbto3rlGJHFZMpFymPdj/1x0M23abSV3FwXkrRU+oxySmZlfI1zo7hw5gWIG7Ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.60])
	by sina.com (10.185.250.23) with ESMTP
	id 67BB090600002354; Sun, 23 Feb 2025 19:39:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7799558913409
X-SMAIL-UIID: 540D98BAF7024E3789ED395CA9A91436-20250223-193953-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 19:39:40 +0800
Message-ID: <20250223113941.2735-1-hdanton@sina.com>
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
@@ -1330,7 +1337,6 @@ static void steam_remove(struct hid_devi
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 	hid_destroy_device(steam->client_hdev);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
@@ -1340,6 +1346,7 @@ static void steam_remove(struct hid_devi
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	steam_unregister(steam);
+	flush_work(&steam->unregister_work);
 }
 
 static void steam_do_connect_event(struct steam_device *steam, bool connected)
--


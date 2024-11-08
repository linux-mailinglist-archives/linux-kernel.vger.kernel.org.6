Return-Path: <linux-kernel+bounces-401547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A089C1C23
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC83B218B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138E1E3DF4;
	Fri,  8 Nov 2024 11:24:48 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F91E3DE4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065088; cv=none; b=uO9WxSwa+taH0uTFk/eMBLdJSPgn6CR/EvnqborDy5aRxUOavnrVYKLhOVIsMLZ2A+OOR7+eOB57gdEDk1Bs23PUqJPTDnODwqLQj66/oWao5VwRzaY4UUQg7OsLgRPoX7mhGHKxLvTbpYRCxkIQ50DO8h2pQXi0LgIGv7dzCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065088; c=relaxed/simple;
	bh=8SoAMftcXLVFiamnDMQ3USZsK+wTOGhXwFEauq75swk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FcjWUxcMMKfWxA7644AnWcF6udJp8eb0apF7pqi7xiXbpdh+EKfBbwPPZU9Hsyu/Bp+UlygYW9rzjQLQj7wtaAmUGPjqIf9X7UesHBGbC4H3H7kM5ej7QkowcxE65WDiJB/BIxQjwl8bIAKBzrfbQhXO/IrOGDA+hgSZG68lVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so22599845ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065086; x=1731669886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXMTjcFXyKcZCBZQZj0WEVberb9k2EXzi12jjMhX470=;
        b=nsX+tjB4xvI30S0HKAiHB+e0X+9PHnvXXaUp9P4p9Krk2WtQZTuvYOfrv8ZoM/TOUc
         ZAwBXIKi5/0pxZGBMUGVb5gsmyV2ILzqPVmFqDFuVGyFzySFX27Hm8Zrk7yBOEAgWiVw
         SMQxiY3m/ecmNyxXcnJadCJsDcaLWsYXE8r3VF2/NpEFg77vP42a6zWUNqeNw276Bhmj
         pncXdSgjx6Vmvq6bQlCRatG6a8C7NrbUAx7ctM01zSrf3uCvXa7y35O8cA95Djurr+oz
         OFdsjSNVHJEESOYVWr37f3vVGCMpojWzKkk/7wa1Ucb0MXzWBJYhzSlCn+U8F41C4dPX
         qF7Q==
X-Gm-Message-State: AOJu0YzrGhgfpzfpZjlSDAbkir+2LpW6wtJDlc7BfViL9i0CAFW+NiNn
	NLn966kWC8HgHs9f+wf6FOt9bKPytqq9j6wlCLocc32kS8RKxDR6AYtx7gmgu+HTTIW00JBoLab
	m54zuJI000jesuYMF4TDN6RxGcHrY7zx+5dnHiZB31llsM8hGzJxE+RY=
X-Google-Smtp-Source: AGHT+IHiAJfVjiB0rFyGqX/kmn3Y/RFiaf6d/t2eoGtQ/Hsxsg5hbClMJCYi+cIhpQNySoSDE+yPInaRXyLSXoJik6XBWELWRqON
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c6:b0:3a0:a80a:997c with SMTP id
 e9e14a558f8ab-3a6f1a25691mr26224665ab.19.1731065086121; Fri, 08 Nov 2024
 03:24:46 -0800 (PST)
Date: Fri, 08 Nov 2024 03:24:46 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672df4fe.050a0220.69fce.0011.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
Author: lizhi.xu@windriver.com

net device has been unregistered ?

#syz test

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 08dd521a51a5..6771c0569516 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -101,6 +101,7 @@ enum {
 
 enum ieee802154_sdata_state_bits {
 	SDATA_STATE_RUNNING,
+	SDATA_STATE_LISTDONE,
 };
 
 /* Slave interface definition.
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..95f11d377fd3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -683,6 +683,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
+	printk("sd: %p, sdl: %p, dev: %p, l: %p, if remove\n", sdata, sdata->list, sdata->dev, sdata->local);
+	if (test_bit(SDATA_STATE_LISTDONE, &sdata->state))
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
@@ -697,7 +701,9 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
+		printk("sd: %p, sdl: %p, dev: %p, l: %p, rmv interfaces\n", sdata, sdata->list, sdata->dev, sdata->local);
 		list_del(&sdata->list);
+		set_bit(SDATA_STATE_LISTDONE, &sdata->state);
 
 		unregister_netdevice(sdata->dev);
 	}
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21b7c3b280b4..81289719584e 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -279,6 +279,7 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
+	printk("l: %p unreg hw\n", local);
 	ieee802154_remove_interfaces(local);
 
 	rtnl_unlock();


Return-Path: <linux-kernel+bounces-401996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E39C2212
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273B92847C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F042192B79;
	Fri,  8 Nov 2024 16:29:17 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C4187FE4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083357; cv=none; b=jvhor9jLzGo9UQ8DaDkt6G/MmZruTtGaebthIiSIakrRvdNIhfBRH3jJKTdr4fmcugpGoxNhJkkDDdRDtlyYnz+DL1ZOZfgs0F/H79KUgPTmGvWxcOH37EayBIW+yPCrdhfu1PVv5Yu5LK7coOWHXZiQ+B90At9PVevw1ZefCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083357; c=relaxed/simple;
	bh=RQdH1YP9LKrMMxYdWUboGc8L5z6+QiLydp5qwK4dYXk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bCDSda0N96EkgvcsL0kr99n96jPlI8cI/47TPN6qyaTKfzJMzqXb2r1ZH2ZBHgiBSTf5rMtjvilNL1xLobME2RsfNbGjzqigCmdSMTH/a60Y/Hl8pp3FAtH1dQltGxI9ACFWfEJdRbofa0C9VUORksPR41ofBU1/ps+cJXljgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abb2b6d42so231662639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 08:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083354; x=1731688154;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCC7WlKCorDD/dItGKgeNxckskLXAK+4LGeEaSO50Ec=;
        b=bnJA8cXD2xIOcEEwgXaJoXyyavNw7FAhqS+G8QVWDTCYbgAIeMLACrr3yz714G8lFm
         oHZ/uciMipdWBqqhRF2OD3BOzyA8+ya0B3fFbyEbQ8zq1AEjLHGxAqOGItWDVcu3EUhY
         3UJ509Ebww8N4UHr7BAilliFJJsrW4CdYH8mivXJk6D2SGkqsheklb6PVLxpsWLXLkB1
         738aNb0hE29ujzqxz9wOX55uw+Jf+KdHt9ZfosXrQFjXzmzK0Lp0huGlul9LmWLts/y0
         e8mc3dRPHLJ8V2jjd1id3TcUM4ix0hDQEGyPkZxSOYlTew/A+AtpVXVzina6o/cT6yrz
         Ln0w==
X-Gm-Message-State: AOJu0YzPUHFN8Lj6uPijff8vtfiYSpTfB9Obx3Snh6YbZp9a/UmF1LsG
	dAkoE7Sdtru83dZ2xv1BPUVoKhI115i5/j6VQheot0GQ2744t1ZOjqDBjyDnrdur2SsgYfiVkpv
	BQOkAGY8CkH/l59UXwJrcUvVc/9Luwz+VibYw98QZGWJCYFjOdMcj3hA=
X-Google-Smtp-Source: AGHT+IHA+bIOKy+cpRVCIwF6qygoW/noaahCQPYjqqIQVo22U2OPNC6vBa3mTJnh9ub7ZNFKcdzHY6i6o4Q5fUxCyFVZL+2USbeo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a6f1993119mr41868255ab.3.1731083354698; Fri, 08 Nov 2024
 08:29:14 -0800 (PST)
Date: Fri, 08 Nov 2024 08:29:14 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e3c5a.050a0220.320e73.030a.GAE@google.com>
Subject: Re: [syzbot] Re: BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: BUG: corrupted list in ieee802154_if_remove
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 906bd684e4b1e517dd424a354744c5b0aebef8af

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 08dd521a51a5..52c8ea7f1da0 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -41,13 +41,11 @@ struct ieee802154_local {
 
 	/* As in mac80211 slaves list is modified:
 	 * 1) under the RTNL
-	 * 2) protected by slaves_mtx;
 	 * 3) in an RCU manner
 	 *
 	 * So atomic readers can use any of this protection methods.
 	 */
 	struct list_head	interfaces;
-	struct mutex		iflist_mtx;
 
 	/* Data related workqueue */
 	struct workqueue_struct	*workqueue;
@@ -101,6 +99,7 @@ enum {
 
 enum ieee802154_sdata_state_bits {
 	SDATA_STATE_RUNNING,
+	SDATA_STATE_REMOVING,
 };
 
 /* Slave interface definition.
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..f108c46122e3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -668,9 +668,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (ret < 0)
 		goto err;
 
-	mutex_lock(&local->iflist_mtx);
 	list_add_tail_rcu(&sdata->list, &local->interfaces);
-	mutex_unlock(&local->iflist_mtx);
 
 	return ndev;
 
@@ -683,25 +681,32 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
-	mutex_lock(&sdata->local->iflist_mtx);
-	list_del_rcu(&sdata->list);
-	mutex_unlock(&sdata->local->iflist_mtx);
-
-	synchronize_rcu();
-	unregister_netdevice(sdata->dev);
+	if (!test_and_set_bit(SDATA_STATE_REMOVING, &sdata->state)) {
+		list_del_rcu(&sdata->list);
+		synchronize_rcu();
+		unregister_netdevice(sdata->dev);
+	}
 }
 
+#define list_for_each_rcu_safe(pos, n, head) \
+	for (pos = rcu_dereference((head)->next), n = pos->next; \
+	     !list_is_head(pos, (head)); \
+	     pos = n, n = rcu_dereference(pos->next))
+
 void ieee802154_remove_interfaces(struct ieee802154_local *local)
 {
-	struct ieee802154_sub_if_data *sdata, *tmp;
+	struct list_head *entry, *tmp;
 
-	mutex_lock(&local->iflist_mtx);
-	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
+	list_for_each_rcu_safe(entry, tmp, &local->interfaces) {
+		struct ieee802154_sub_if_data *sdata =
+			container_of(entry, struct ieee802154_sub_if_data, list);
 
-		unregister_netdevice(sdata->dev);
+		if (!test_and_set_bit(SDATA_STATE_REMOVING, &sdata->state)) {
+			list_del_rcu(&sdata->list);
+			synchronize_rcu();
+			unregister_netdevice(sdata->dev);
+		}
 	}
-	mutex_unlock(&local->iflist_mtx);
 }
 
 static int netdev_notify(struct notifier_block *nb,
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21b7c3b280b4..61b6c5e06177 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -91,7 +91,6 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_LIST_HEAD(&local->interfaces);
 	INIT_LIST_HEAD(&local->rx_beacon_list);
 	INIT_LIST_HEAD(&local->rx_mac_cmd_list);
-	mutex_init(&local->iflist_mtx);
 
 	tasklet_setup(&local->tasklet, ieee802154_tasklet_handler);
 
@@ -174,8 +173,6 @@ void ieee802154_free_hw(struct ieee802154_hw *hw)
 
 	BUG_ON(!list_empty(&local->interfaces));
 
-	mutex_destroy(&local->iflist_mtx);
-
 	wpan_phy_free(local->phy);
 }
 EXPORT_SYMBOL(ieee802154_free_hw);


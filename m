Return-Path: <linux-kernel+bounces-405238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DBB9C4EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A3B25E72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93220B1F7;
	Tue, 12 Nov 2024 06:46:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A224C91
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393986; cv=none; b=MYDGignteSmL9tbFqFMI1pAIljKT3AVhA3sD+HOmEAJGvss5IX+Fo2LZbj7Vc281/Pcz2QuLSg9zBROsielLVyykAEibXMqDsvC5KLckBvF5seJzZB63jUrnVMImv4dFNnRBTmhre9FVVXpQJb8KeMmASN4KQ4ACr1JOZIr9cWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393986; c=relaxed/simple;
	bh=F2RoJfP2Ch+7Fvd/WBXIv38Wz4bfyET6P8XqZLU8FNE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EgOHx+6EOdpYWUL7zbsnHVFvRebOj0hXlkM9GgQ5KeGUjiIKpM5bFGzPArbpE9zLM5aKrrvC+OkYq6O5304pmRr0XW4m3chx/npdYlO6TUsds42N2nxlG1FJ4IizrRMQYhopigiPgyR6KmxPu9zLDNKFVPpIsOaLscPzkB9rdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b3808522so59995265ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731393983; x=1731998783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmKxBXSRgScwMCBDxrUG34UvWUMtRPWYZEH7xO+2HsE=;
        b=OJXyDr0mIfeccsAYvX/9hwgPmGgYwDq1t/pGO9dMi3JEYzmVrQmv/Hy4Axay/bySBq
         jOlSFsbZ6Mikn/X6ahqArtYDPIiCgcdLAemhMGs7cQRI7n2AsOoatE6oRL6Aby3XSAUg
         OzYMu7oSMR50ZSxlMaT5hQiEsOudO1qIUtzBN6tUfV4/BYuXDP7cKGtZ39jcxsqrUwmu
         HDbiaMdcUeUVBqinFEFAqw7xvquWgSPSBO65SUPEUOKjwc1CwWN/hDq3EfSf1GhAR7z1
         VKbgsoUZjmMOZsMuq3l+ccAfaxwQkQU3d/SjBhrumwfN+xaz3QYWqiUWuOhprhHUmRKp
         olpg==
X-Gm-Message-State: AOJu0YzJAxHAKvjZUNez/FwbES5xqOSBI9TEDd2lq1bm9AP2rHE9IOji
	KuFyOue8/dsoSlP4Iu3SdEll4EGxDmvm4kzfh9zVy1Vl6EC5pSSqg7todg9yQNb5Ge07u6nospT
	WeAoZigYr+y4tB+dOrng0O1nmA1gWYqP275+UJoYegEqWJ4uvA8gFplY=
X-Google-Smtp-Source: AGHT+IE/rwaR0UV4HDzq7fLkeNaYrhyNSyQOArpHcKmgEk+L+fDDWYNyTRsxzAJ14XjycMFFvqnzVdvdQrvwlwhmzAC63m33R3Vu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c244:0:b0:3a6:ab32:7417 with SMTP id
 e9e14a558f8ab-3a6f1994673mr133070255ab.1.1731393983641; Mon, 11 Nov 2024
 22:46:23 -0800 (PST)
Date: Mon, 11 Nov 2024 22:46:23 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732f9bf.050a0220.138bd5.00d7.GAE@google.com>
Subject: Re: [syzbot] Re: BUG: corrupted list in ieee802154_if_remove()
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: BUG: corrupted list in ieee802154_if_remove()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2d5404caa8c7bb5c4e0435f94b28834ae5456623

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
index c0e2da5072be..619f06bf9931 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -668,9 +668,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (ret < 0)
 		goto err;
 
-	mutex_lock(&local->iflist_mtx);
 	list_add_tail_rcu(&sdata->list, &local->interfaces);
-	mutex_unlock(&local->iflist_mtx);
 
 	return ndev;
 
@@ -683,25 +681,21 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
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
+		unregister_netdevice(sdata->dev);
+	}
 }
 
 void ieee802154_remove_interfaces(struct ieee802154_local *local)
 {
 	struct ieee802154_sub_if_data *sdata, *tmp;
 
-	mutex_lock(&local->iflist_mtx);
-	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
-
-		unregister_netdevice(sdata->dev);
-	}
-	mutex_unlock(&local->iflist_mtx);
+	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list)
+		if (!test_and_set_bit(SDATA_STATE_REMOVING, &sdata->state)) {
+			list_del_rcu(&sdata->list);
+			unregister_netdevice(sdata->dev);
+		}
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


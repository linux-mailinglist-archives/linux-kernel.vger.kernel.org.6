Return-Path: <linux-kernel+bounces-402605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0359C298F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC1E1F22883
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B7884A32;
	Sat,  9 Nov 2024 02:51:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D581AD7
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731120685; cv=none; b=JFeCS1GwPb+PmC9+XAf7LEEmshBTFVULOzryfxn0MZlekQung/xjkV0X510ML5n5/nWzoUOI/2FPQwN23MzQg9OrxQVi66quzaSQXKupVoZYk/mI6oo9bNhbHnHuwJPIwmYdczddOsVAkBxRs5aKBNghbYUj7pgEWtaG2v3DuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731120685; c=relaxed/simple;
	bh=kmfgNFxFLKbOMb9PAPl1Scb/ewh6dcwdLQMeKYR14/k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TGtStOPDXD2NhxvMTIvzuTD73Fi6c4unKqecew2oz4gyH0dm/blMZEjw6shU5mJceJ0oi8ZA6JSkuIPhspcmCJb9osFgd+AATGshYCldg5Rrk+LVVXIJmAA4BhbVknqtbl56Ub6wU7cyJYf3N3PFs+1BBgxHSShIW/m73Lx02u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6bb827478so28287745ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 18:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731120683; x=1731725483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCOQDIkfjVEGiHxmKmd1MfYQ3xkC+jKJF+qlDjClcyI=;
        b=hu8dbuQti8n00zojrD7mgHBzezQwgHvp8gQ2tyW88a6MfpJ/TKWqrizssfh9A7usNg
         2w9+TFPRvs2mQg61fUMyCn7jAgqy7H4SpIrU1jPgaau2RCIVBOYU8yDsK3BV0EMuZmT1
         FuwqA0LHEKroOCFwdvt3O3M1p/HEytSeChExYvfEkEoy4IThzpJNv+8USZqIGBvhSJMB
         ew8EEn2oF2pDtQ0Cdw7dz9JuF7BK5g5dn5VkAI3rgY5aZLm5XlCZcr1XztHfiJk6Ikvo
         UAPbL3Sb0Bhnt/aSfJmNbWsBOsn3YItOOUDLMCEZwrOJyTAECV+im9gUv1y9AQjebxnJ
         cHkQ==
X-Gm-Message-State: AOJu0YxkLusMci/wjMziDwYrFwLjiKwdiZh+rDnuNZsH3KIshK2Mi0gL
	mtE4aI2SRxVweBhjWS/5dIzTWG7yDevBO2Jwk6RUwdHpyXqnr35mrtr9I6TsgB7f+qRWNgyZ4OH
	fgjngSy4SrLj23rXMoF2M2b8cFQV8I5LxRaUT4NrSpzbUUt0A3GOh1MU=
X-Google-Smtp-Source: AGHT+IGvOyl5fWUVGJAK6RZmSZ2a2VuRU+zcr+NBTj4d+A7yXeeivN9LOC5gILsl6/xmKiG6FnXjaZKZb/oJkyrhuv0ko6IifjEz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1485:b0:3a3:a307:6851 with SMTP id
 e9e14a558f8ab-3a6f1a504fcmr64266895ab.22.1731120683176; Fri, 08 Nov 2024
 18:51:23 -0800 (PST)
Date: Fri, 08 Nov 2024 18:51:23 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ece2b.050a0220.320e73.030d.GAE@google.com>
Subject: Re: [syzbot] Re: BUG: corrupted list in ieee802154_if_remove()
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: BUG: corrupted list in ieee802154_if_remove()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git da4373fbcf006deda90e5e6a87c499e0ff747572

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
index c0e2da5072be..f4cbd5a8bb4e 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -668,9 +668,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (ret < 0)
 		goto err;
 
-	mutex_lock(&local->iflist_mtx);
 	list_add_tail_rcu(&sdata->list, &local->interfaces);
-	mutex_unlock(&local->iflist_mtx);
 
 	return ndev;
 
@@ -683,25 +681,37 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
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
 
+#define list_for_each_rcu_safe(pos, n, head) \
+	for (pos = rcu_dereference((head)->next), n = pos->next; \
+	     !list_is_head(pos, (head)); \
+	     pos = n, n = rcu_dereference(pos->next))
+
 void ieee802154_remove_interfaces(struct ieee802154_local *local)
 {
-	struct ieee802154_sub_if_data *sdata, *tmp;
+	struct ieee802154_sub_if_data *sdata;
+	struct list_head *entry, *tmp;
+	LIST_HEAD(head);
+
+	rcu_read_lock();
+
+	list_for_each_rcu_safe(entry, tmp, &local->interfaces) {
+		sdata = container_of(entry, struct ieee802154_sub_if_data, list);
+		if (!test_and_set_bit(SDATA_STATE_REMOVING, &sdata->state))
+			list_move(&sdata->list, &head);
+	}
 
-	mutex_lock(&local->iflist_mtx);
-	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
+	rcu_read_unlock();
 
+	list_for_each_safe(entry, tmp, &head) {
+		sdata = container_of(entry, struct ieee802154_sub_if_data, list);
 		unregister_netdevice(sdata->dev);
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


Return-Path: <linux-kernel+bounces-256273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE0934BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199F01F23F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA012D1FA;
	Thu, 18 Jul 2024 10:40:24 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4616F303
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299223; cv=none; b=J1HIbvx9PxkgBqbK2RKnFf4UNPoZTwz40j6xsZlkW1s3uiKekbA0uOEp8XIa6qnIphbqFOGEvZe/ZX/4tRmWx/iBsSd9aU1X+AozFyLZXgjS0JIoy1CQ97sO7FCAsWZWH8KJSv+O4qO6fqr1WHdXyM+FO3ERMru8ckyRJJBV0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299223; c=relaxed/simple;
	bh=uTSgg4eqLi0XKAUmEfDsrZRgYhTO42o9OZC6ZKw3TTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTqijCWR9jms8sb97ZRPTUO1tZpBwmxWhOrQx+GhBL/zADKsCXUFlKZOvtbGMIXYfvgFRp2T6F40hwxcmuWY05bVEJZbu/XLlyK0Vw6HCZg2MvMBoyUrGYo2V37nWj/L1Wilyev2lyNkFMntRj9HxTWulm1063ZvmsJDhQHuvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.47])
	by sina.com (10.185.250.22) with ESMTP
	id 6698F10300004E46; Thu, 18 Jul 2024 18:40:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5178747602673
X-SMAIL-UIID: DC0561E9A6494821AF741D9197DF53F7-20240718-184005-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Date: Thu, 18 Jul 2024 18:39:53 +0800
Message-Id: <20240718103953.1323-1-hdanton@sina.com>
In-Reply-To: <0000000000005c6453061d53bc0f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jul 2024 19:02:19 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    58f9416d413a Merge branch 'ice-support-to-dump-phy-config-..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed24b5980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  58f9416d413a

--- x/net/mac80211/iface.c
+++ y/net/mac80211/iface.c
@@ -1091,6 +1091,7 @@ static void ieee80211_set_default_queues
 static void ieee80211_sdata_init(struct ieee80211_local *local,
 				 struct ieee80211_sub_if_data *sdata)
 {
+	mutex_init(&sdata->debug_mutex);
 	sdata->local = local;
 
 	/*
--- x/net/mac80211/ieee80211_i.h
+++ y/net/mac80211/ieee80211_i.h
@@ -1172,6 +1172,8 @@ struct ieee80211_sub_if_data {
 	u16 desired_active_links;
 
 	u16 restart_active_links;
+	struct mutex  debug_mutex;
+	u32 dev_seq, sta_seq;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
--- x/net/mac80211/debugfs_netdev.c
+++ y/net/mac80211/debugfs_netdev.c
@@ -1016,12 +1016,16 @@ static void ieee80211_debugfs_add_netdev
 
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 {
+	mutex_lock(&sdata->debug_mutex);
 	if (!sdata->vif.debugfs_dir)
-		return;
+		goto out;
 
 	debugfs_remove_recursive(sdata->vif.debugfs_dir);
 	sdata->vif.debugfs_dir = NULL;
 	sdata->debugfs.subdir_stations = NULL;
+	sdata->dev_seq++;
+out:
+	mutex_unlock(&sdata->debug_mutex);
 }
 
 void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata)
--- x/net/mac80211/debugfs_sta.c
+++ y/net/mac80211/debugfs_sta.c
@@ -1280,12 +1280,18 @@ void ieee80211_sta_debugfs_add(struct st
 			   &sta->driver_buffered_tids);
 
 	drv_sta_add_debugfs(local, sdata, &sta->sta, sta->debugfs_dir);
+	sdata->sta_seq = sdata->dev_seq;
 }
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
-	debugfs_remove_recursive(sta->debugfs_dir);
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+
+	mutex_lock(&sdata->debug_mutex);
+	if (sdata->sta_seq == sdata->dev_seq)
+		debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
+	mutex_unlock(&sdata->debug_mutex);
 }
 
 #undef DEBUGFS_ADD
--


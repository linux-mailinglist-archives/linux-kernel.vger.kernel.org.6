Return-Path: <linux-kernel+bounces-255087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8074933B98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD80B228EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7EE17F386;
	Wed, 17 Jul 2024 10:59:14 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474D17F369
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213954; cv=none; b=MR+gCHxP4lkVGLUUwiAFCrtJhzaBVHBd2P3WJyydpOLlEj0jwThONrStlVepjGI+hhlSM/djT6bvLXDODZ7Ero+MVHIcyrx2LI7+J/oCHJYJlQf8FjH8yuurcR6EOfMYFklxd2uIeV6cU1/QxQp4dtDKHPgcGHI1bVWJV7/V5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213954; c=relaxed/simple;
	bh=YLV42JxVl4OkrsIl7TsUMtOr/riYdYNJC26pn76O0Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afyXxKoferAgZdqqanp849cX4n8cQuOCqaab2HoCJak9w513S66O3IjHXvhjJaLlrv9wM471DQPWL+fxqos3EhEHBfuZebReDt7/Y/pRm15VAEnhxxYVBGylAIPX+7fTMKOxtJIoauT4I5lPOsRbbcj+LnH8x0F3uNTxiNvN0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.143])
	by sina.com (10.185.250.24) with ESMTP
	id 6697A3ED0000213B; Wed, 17 Jul 2024 18:58:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3748610748568
X-SMAIL-UIID: 68F980AA0B354273AB3946FF0D58B2FA-20240717-185856-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Date: Wed, 17 Jul 2024 18:58:49 +0800
Message-Id: <20240717105849.1208-1-hdanton@sina.com>
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

--- x/net/mac80211/debugfs_netdev.c
+++ y/net/mac80211/debugfs_netdev.c
@@ -1016,12 +1016,15 @@ static void ieee80211_debugfs_add_netdev
 
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 {
+	mutex_lock(&sdata->debug_mutex);
 	if (!sdata->vif.debugfs_dir)
-		return;
+		goto out;
 
 	debugfs_remove_recursive(sdata->vif.debugfs_dir);
 	sdata->vif.debugfs_dir = NULL;
 	sdata->debugfs.subdir_stations = NULL;
+out:
+	mutex_unlock(&sdata->debug_mutex);
 }
 
 void ieee80211_debugfs_rename_netdev(struct ieee80211_sub_if_data *sdata)
--- x/net/mac80211/debugfs_sta.c
+++ y/net/mac80211/debugfs_sta.c
@@ -1284,8 +1284,13 @@ void ieee80211_sta_debugfs_add(struct st
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
-	debugfs_remove_recursive(sta->debugfs_dir);
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+
+	mutex_lock(&sdata->debug_mutex);
+	if (sdata->debugfs.subdir_stations != NULL)
+		debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
+	mutex_unlock(&sdata->debug_mutex);
 }
 
 #undef DEBUGFS_ADD
--- x/net/mac80211/ieee80211_i.h
+++ y/net/mac80211/ieee80211_i.h
@@ -1172,6 +1172,7 @@ struct ieee80211_sub_if_data {
 	u16 desired_active_links;
 
 	u16 restart_active_links;
+	struct mutex  debug_mutex;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct {
--- x/net/mac80211/iface.c
+++ y/net/mac80211/iface.c
@@ -1091,6 +1091,7 @@ static void ieee80211_set_default_queues
 static void ieee80211_sdata_init(struct ieee80211_local *local,
 				 struct ieee80211_sub_if_data *sdata)
 {
+	mutex_init(&sdata->debug_mutex);
 	sdata->local = local;
 
 	/*
--


Return-Path: <linux-kernel+bounces-253703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9293258E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5A81F23827
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E831990CE;
	Tue, 16 Jul 2024 11:26:15 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AB7CF16
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129175; cv=none; b=jN/c5JuTsA9anEf+P5x/2nTEVk2G9a1Dw3nnoCVYUy1tz7tvRn95N081MLyioxwUR7moGm20snDdU2ob/jQHgB7qtnRT1hnypPDiQROjl7zmqwSWGYZf6376HUfmdcJagSBZMmh7K3ZoijmcR23Hln0ftfr2tc4ROWKf9FMgbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129175; c=relaxed/simple;
	bh=Mniu9gA6b2EhKO+fpC6eoSHwsVpdY6vrZZ8IXcjtu64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbfnGaJGgWNO5Wp6fXuKJXkokbWJjdhfQPAIDWjY/zWNjfIRLhrZkYQgJwyYpRcId9KOuKYWlBI8re6tpLFCLdeO4s/sSodAqxE/y5CzCfw68RcTT99xUhRAZJpnYbXp50uKh4bWfUv3jM6h1/HYx97UnJip64Qafi3Kv5+npV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.121])
	by sina.com (10.185.250.23) with ESMTP
	id 6696578700007F0B; Tue, 16 Jul 2024 19:20:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6427918913742
X-SMAIL-UIID: C1D7265DBBD647969A15E1A7E2015AF9-20240716-192041-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Date: Tue, 16 Jul 2024 19:20:34 +0800
Message-Id: <20240716112034.1076-1-hdanton@sina.com>
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

--- x/net/mac80211/debugfs_sta.c
+++ y/net/mac80211/debugfs_sta.c
@@ -1284,6 +1284,12 @@ void ieee80211_sta_debugfs_add(struct st
 
 void ieee80211_sta_debugfs_remove(struct sta_info *sta)
 {
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+
+	if (!sdata->debugfs.subdir_stations)
+		return;
+	if (!sdata->vif.debugfs_dir)
+		return;
 	debugfs_remove_recursive(sta->debugfs_dir);
 	sta->debugfs_dir = NULL;
 }
--


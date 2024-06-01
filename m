Return-Path: <linux-kernel+bounces-197745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC08D6E97
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68FAB216DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAB14A82;
	Sat,  1 Jun 2024 07:02:17 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9318111AA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717225337; cv=none; b=n/kmjciD53t3dUd2HHNDuoGsf/fEPRAa91TIcAWE6NmK+qAALZvyEMqyOm5hchPPQ7/391wxH6aD6N5o56KbsHBFkzbCGMgfy0ydcVvDrdxaV+zsh765TM9D1Rw8hhnEbTH8UzZ+0M0to0qJ7OW8A3WXyvlihe3+WNSMac+O3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717225337; c=relaxed/simple;
	bh=zv8eMW1Eelq4laV38IJKliGY//RaAnyGOig+D03M6C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOdSuW8aKnbM4VzD3fOSwiKgVTzxiwbsuvEbE8dI7I+FIR4ULNLlg9/HppL2P/sBtLj2+NYQ7qsUhsNK5+dmXtpoimT0XKTKEG0wHdJHRiv0tMWPzCnha4JlGFN7BN+qSFeBRr4RGF6B6uwVsDl7ad7FX192NOIxhqKVAzgxX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.165])
	by sina.com (10.185.250.21) with ESMTP
	id 665AC74700002F9A; Sat, 1 Jun 2024 15:01:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8688393408439
X-SMAIL-UIID: 6BA0A628B0B844B49317363F6B6842EB-20240601-150129-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+54594368fbd5a4f1754a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in kcompactd (2)
Date: Sat,  1 Jun 2024 15:01:17 +0800
Message-Id: <20240601070117.3481-1-hdanton@sina.com>
In-Reply-To: <0000000000002304860619cb8aa1@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 31 May 2024 20:17:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    2bfcfd584ff5 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17314572980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/mac80211/ieee80211_i.h
+++ y/net/mac80211/ieee80211_i.h
@@ -1437,6 +1437,7 @@ struct ieee80211_local {
 	 * queues increases over the limit. */
 #define IEEE80211_IRQSAFE_QUEUE_LIMIT 128
 	struct tasklet_struct tasklet;
+	struct work_struct tlw;
 	struct sk_buff_head skb_queue;
 	struct sk_buff_head skb_queue_unreliable;
 
--- x/net/mac80211/main.c
+++ y/net/mac80211/main.c
@@ -423,9 +423,9 @@ u64 ieee80211_reset_erp_info(struct ieee
 	       BSS_CHANGED_ERP_SLOT;
 }
 
-static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+static void ieee80211_tlw_fn(struct work_struct *w)
 {
-	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
+	struct ieee80211_local *local = container_of(w, struct ieee80211_local, tlw);
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&local->skb_queue)) ||
@@ -450,6 +450,13 @@ static void ieee80211_tasklet_handler(st
 	}
 }
 
+static void ieee80211_tasklet_handler(struct tasklet_struct *t)
+{
+	struct ieee80211_local *local = from_tasklet(local, t, tasklet);
+
+	schedule_work(&local->tlw);
+}
+
 static void ieee80211_restart_work(struct work_struct *work)
 {
 	struct ieee80211_local *local =
@@ -989,6 +996,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_
 	tasklet_setup(&local->tx_pending_tasklet, ieee80211_tx_pending);
 	tasklet_setup(&local->wake_txqs_tasklet, ieee80211_wake_txqs);
 	tasklet_setup(&local->tasklet, ieee80211_tasklet_handler);
+	INIT_WORK(&local->tlw, ieee80211_tlw_fn);
 
 	skb_queue_head_init(&local->skb_queue);
 	skb_queue_head_init(&local->skb_queue_unreliable);
@@ -1634,6 +1642,7 @@ void ieee80211_unregister_hw(struct ieee
 
 	tasklet_kill(&local->tx_pending_tasklet);
 	tasklet_kill(&local->tasklet);
+	flush_work(&local->tlw);
 
 #ifdef CONFIG_INET
 	unregister_inetaddr_notifier(&local->ifa_notifier);
--


Return-Path: <linux-kernel+bounces-541476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A88A4BD64
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138F33B55F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F71F3FC2;
	Mon,  3 Mar 2025 11:00:02 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230B1F4C9D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999601; cv=none; b=NpjMOLt19FanGTuDa4wAeis2287SzsbchFPp7VbgGNVJfY1gwIw9MwXAmreLfpYfPYrEbYjVdexTFA+LioEJpELpL7fmOl2GHEYhI09gTnMqRfk4m6WOeZNgCEwDC4PWf9RRUDzQ51RHqv5/83b8QM7L6Ov8xQEkIMCugxINYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999601; c=relaxed/simple;
	bh=Dtq3yE+UNHEsj6x2wPixGnasokmKm3LElA9fktZdOWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bouwoEV6gJbb0zyZxCuTAMz3e8v+dNfFDKHf1pI15p8wdOEopAza/K9fkzX5oIAqCVHLqy7v6uFP4kV+uePBYLw0F5ULG8S57xT23IzyfS6AqfSD/HI8hBF5dF7jyuVioHsW60lZvUbyLtdVsnV9Z+haUNQnTKdKMhc0zFC2lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.87])
	by sina.com (10.185.250.23) with ESMTP
	id 67C58A5F0000477C; Mon, 3 Mar 2025 18:54:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3596408913434
X-SMAIL-UIID: 4DE9BD4B872042298C567D4F95590111-20250303-185425-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work (2)
Date: Mon,  3 Mar 2025 18:54:12 +0800
Message-ID: <20250303105413.2938-1-hdanton@sina.com>
In-Reply-To: <67c447a7.050a0220.55417.04d3.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 02 Mar 2025 03:57:27 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    03d38806a902 Merge tag 'thermal-6.14-rc5' of git://git.ker..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155128b7980000

#syz test

--- x/net/netfilter/nf_tables_api.c
+++ y/net/netfilter/nf_tables_api.c
@@ -10654,6 +10654,10 @@ static int nf_tables_commit(struct net *
 		mutex_unlock(&nft_net->commit_mutex);
 		return 0;
 	}
+	if (nft_net->flushed) {
+		mutex_unlock(&nft_net->commit_mutex);
+		return -EAGAIN;
+	}
 
 	nft_ctx_init(&ctx, net, skb, nlh, NFPROTO_UNSPEC, NULL, NULL, NULL);
 
@@ -11251,6 +11255,7 @@ static int nf_tables_abort(struct net *n
 	else
 		nf_tables_module_autoload_cleanup(net);
 
+	nft_net->flushed = 0;
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
@@ -11854,6 +11859,7 @@ static int nft_rcv_nl_event(struct notif
 	gc_seq = nft_gc_seq_begin(nft_net);
 
 	nf_tables_trans_destroy_flush_work();
+	nft_net->flushed = 1;
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
@@ -11903,6 +11909,7 @@ static int __net_init nf_tables_init_net
 	nft_net->base_seq = 1;
 	nft_net->gc_seq = 0;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
+	nft_net->flushed = 0;
 
 	return 0;
 }
--- x/include/net/netfilter/nf_tables.h
+++ y/include/net/netfilter/nf_tables.h
@@ -1915,6 +1915,7 @@ struct nftables_pernet {
 	unsigned int		base_seq;
 	unsigned int		gc_seq;
 	u8			validate_state;
+	u8			flushed;
 };
 
 extern unsigned int nf_tables_net_id;
--


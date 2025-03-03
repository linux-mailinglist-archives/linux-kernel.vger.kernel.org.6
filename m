Return-Path: <linux-kernel+bounces-541582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F4A4BE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFD8168211
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9731FBE8B;
	Mon,  3 Mar 2025 11:30:39 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676EC1F8735
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001439; cv=none; b=DFJSTetI0LHtmIKw7v2jlWsDI/P6fCmpjn668+Jw86Vbu/HJTXeXUEWkgS8VyERNvKdubbvyk+2PN3vf3UbNEIWu9s6PR72IvkHDLExRhNP2HmgvW/Hbo73rUcY4mjcaniwDErRVycFzzBEj53BQ38pzKNuimusjxSMj1WN5Ayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001439; c=relaxed/simple;
	bh=sA+lmEtH/+EuWqwB7D4qANkpF6ObT710gao9EBuWnDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gm6H54RRCBs3ok8u44x1ed/qjI7WM5Jn6kCB0uurbtFbv4X+SjIWlfAv2rLXMVOpCUNV5PkKVUnfWbA66Ba/DHUW47GzNH/0mZ9CC5S2kD1V+W1wHj18J7KSWBkoVm5/luy59D46axym//awhdB0D5mgTCNRpZnppdOTYEfuo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.87])
	by sina.com (10.185.250.22) with ESMTP
	id 67C592CF0000283E; Mon, 3 Mar 2025 19:30:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5362867602641
X-SMAIL-UIID: D71E763B7CE44A88B8D6FE27267AD13D-20250303-193025-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work (2)
Date: Mon,  3 Mar 2025 19:30:12 +0800
Message-ID: <20250303113013.2959-1-hdanton@sina.com>
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

--- x/include/net/netfilter/nf_tables.h
+++ y/include/net/netfilter/nf_tables.h
@@ -1915,6 +1915,7 @@ struct nftables_pernet {
 	unsigned int		base_seq;
 	unsigned int		gc_seq;
 	u8			validate_state;
+	u8			flushed;
 };
 
 extern unsigned int nf_tables_net_id;
--- x/net/netfilter/nf_tables_api.c
+++ y/net/netfilter/nf_tables_api.c
@@ -10654,6 +10654,9 @@ static int nf_tables_commit(struct net *
 		mutex_unlock(&nft_net->commit_mutex);
 		return 0;
 	}
+	if (nft_net->flushed) {
+		return -EAGAIN;
+	}
 
 	nft_ctx_init(&ctx, net, skb, nlh, NFPROTO_UNSPEC, NULL, NULL, NULL);
 
@@ -11251,6 +11254,7 @@ static int nf_tables_abort(struct net *n
 	else
 		nf_tables_module_autoload_cleanup(net);
 
+	nft_net->flushed = 0;
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
@@ -11854,6 +11858,7 @@ static int nft_rcv_nl_event(struct notif
 	gc_seq = nft_gc_seq_begin(nft_net);
 
 	nf_tables_trans_destroy_flush_work();
+	nft_net->flushed = 1;
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
@@ -11903,6 +11908,7 @@ static int __net_init nf_tables_init_net
 	nft_net->base_seq = 1;
 	nft_net->gc_seq = 0;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
+	nft_net->flushed = 0;
 
 	return 0;
 }
--


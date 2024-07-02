Return-Path: <linux-kernel+bounces-237662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD8923C61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546FFB22A15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DDA15B11E;
	Tue,  2 Jul 2024 11:28:46 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595915218A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919726; cv=none; b=L+sP7+H0pr8UYCLxbV7vQCgaUBvNm2cWTc0juKb0uX/SYFJVt2I33hKbm0b3GM8vzrqPTLoFBu4vB9bGmIRLDdsAyjunUTKpbQs5d1Auasw2Ff9bbgx5bKdl5MHDGdth+fFWSJ/G+UreRTeQjf8Q9ANpgm8MzedW2gvwIZpHbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919726; c=relaxed/simple;
	bh=oVsqQcM+R6Z1/qrxt7MIzTyuo8UzND5cjzA7GyjdBGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEUAHlfDgt0DcCDdXwBSgFJJ/7EnXBzChwMKvvT+r6H0MQ9r0T7LzlOx+f9iO5bVw5xtlCZH1VkyZBzGkMtnLlVHj+37XMTmazmJS88LuDrW5EwRoJ1Y4RnlY+Z1TIg+Y9F9jrjF/zxNC9VklVcTCtgfnRq3kbnHgL8ly70MBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.52])
	by sina.com (10.185.250.21) with ESMTP
	id 6683E458000043A8; Tue, 2 Jul 2024 19:28:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7997793408658
X-SMAIL-UIID: B87B1765489C41E3B80B876BE2DD2EC0-20240702-192826-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
Date: Tue,  2 Jul 2024 19:28:14 +0800
Message-Id: <20240702112814.2760-1-hdanton@sina.com>
In-Reply-To: <000000000000aa1dbb061c354fe6@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Jul 2024 13:19:15 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    1c5fc27bc48a Merge tag 'nf-next-24-06-28' of git://git.ker..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cecb1e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  1c5fc27bc48a

--- x/include/net/netfilter/nf_tables.h
+++ y/include/net/netfilter/nf_tables.h
@@ -1281,6 +1281,7 @@ struct nft_table {
 	u64				hgenerator;
 	u64				handle;
 	u32				use;
+	atomic_t			cnt;
 	u16				family:6,
 					flags:8,
 					genmask:2;
--- x/net/netfilter/nf_tables_api.c
+++ y/net/netfilter/nf_tables_api.c
@@ -162,6 +162,8 @@ static struct nft_trans *nft_trans_alloc
 
 	trans->net = ctx->net;
 	trans->table = ctx->table;
+	if (trans->table)
+		atomic_inc(&trans->table->cnt);
 	trans->seq = ctx->seq;
 	trans->flags = ctx->flags;
 	trans->report = ctx->report;
@@ -1498,6 +1500,7 @@ static int nf_tables_newtable(struct sk_
 	if (err < 0)
 		goto err_trans;
 
+	atomic_inc(&table->cnt);
 	list_add_tail_rcu(&table->list, &nft_net->tables);
 	return 0;
 err_trans:
@@ -1663,6 +1666,8 @@ static int nf_tables_deltable(struct sk_
 
 static void nf_tables_table_destroy(struct nft_table *table)
 {
+	if (!atomic_dec_and_test(&table->cnt))
+		return;
 	if (WARN_ON(table->use > 0))
 		return;
 
@@ -9532,7 +9537,6 @@ static void nft_commit_release(struct nf
 	switch (trans->msg_type) {
 	case NFT_MSG_DELTABLE:
 	case NFT_MSG_DESTROYTABLE:
-		nf_tables_table_destroy(trans->table);
 		break;
 	case NFT_MSG_NEWCHAIN:
 		free_percpu(nft_trans_chain_stats(trans));
@@ -9572,6 +9576,9 @@ static void nft_commit_release(struct nf
 		break;
 	}
 
+	if (trans->table)
+		nf_tables_table_destroy(trans->table);
+
 	if (trans->put_net)
 		put_net(trans->net);
 
--


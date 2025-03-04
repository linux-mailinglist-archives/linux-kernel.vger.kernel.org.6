Return-Path: <linux-kernel+bounces-543153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4090A4D22E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB55016F2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ABA1EB9FA;
	Tue,  4 Mar 2025 03:53:56 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7B13790B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741060435; cv=none; b=OFDCvVUVMjA9r8IAk2+ICbj04N+qMkVz5ulUEe2c4P7Q8Xy6tR8B8ZyyLDvwZcdDw1ZDkirwkBpIlFlCaSgS3HxwrxzDCIcWe8V75sAG74uUdab64yOKxN4jfqgLEfMy+kv8i4WbkccSrVI6hFCW3p7dy5PslQ+J85Nc8kCLPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741060435; c=relaxed/simple;
	bh=skMWMsxYVsQqKW+OJYBbo3qr92LYhwutArtIZBY5NBw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GSVkX7RozKHIaRMhW0kbKYDNe4S/xsSv7zMdyAYeh93vV4yGeYkb3xdsaW4aY5hGG0gZzNVqhOLk30rAnnGKsdKMKBH/dDoLYm4ICwznR9MuQdYLoq5WgWemOlcxNCb1UK4wmSASfcD1Fdz5Ku1Q+ckIl8LYFU8TtcdUCXlbXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so57243555ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 19:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741060432; x=1741665232;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rf8uFOMgZvaTKVgIBpWP7ebTiTIpNFVSxodQqR3/XdI=;
        b=UUhagellFK+Kgk+qbCVlLtgWAYF+wpuQbkDcQenYSyGNuxh/QL4HiwzYxnv9bkg19t
         zqlfrUyGTgcd4Ut15CiEi5sbHKdjNQXp7DBOXHHyZdtUAXobS8n4sG+3hF6CTWZsTHka
         OUq5fql1p17jgxWWPAePqhDmoWpIvqvlsZtJHXSmeKq5SQd9s1VXrVHlkjIq7gs+a4XZ
         N5hOmt5xVSyGQ/WXxbBfmalUo01oVTpUCcti2IMHD6c3Eylya9vC8Yzlzx6+US5LJ2bV
         DatK39Nx32EF/Z5FbVxQlotirgrIUIzaWFQXI8esTxBKlKOym55ghAzTzU8oyyC2eIR7
         jL0w==
X-Gm-Message-State: AOJu0YyPrZgVAxVb7HrgKHJ23AH2MSdxpSGpnRO85ZEE7f4dWH2KOveG
	tS9FHVjV6cCOg1ujkKTT1MUlTDgTpEk0lfZvt95pFngjLzp8il8kheTZbuVpAFvKhv8zsX7Uw3m
	jx/BgovjQ6ACwR6gRr7kCjAe1o2HNnWmnnRiQ48ELkZ1dCesevM5X+6M=
X-Google-Smtp-Source: AGHT+IH0iqFH7Oq6O1ZQkJYKeoCoIKrMyPjmne9I89fZuPEUVTx/rF0d5XEzziMvNH9Cwo3+juL1AEnVWyZGPN4+IdqJtJb0wV9o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d01:b0:3d3:f2cc:fb0 with SMTP id
 e9e14a558f8ab-3d3f2cc11d0mr122864015ab.19.1741060432734; Mon, 03 Mar 2025
 19:53:52 -0800 (PST)
Date: Mon, 03 Mar 2025 19:53:52 -0800
In-Reply-To: <67c447a7.050a0220.55417.04d3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c67950.050a0220.15b4b9.0000.GAE@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
Author: fw@strlen.de

#syz test

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 60d5dcdb289c..c428a152d907 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1891,7 +1891,7 @@ void nft_chain_filter_fini(void);
 void __init nft_chain_route_init(void);
 void nft_chain_route_fini(void);
 
-void nf_tables_trans_destroy_flush_work(void);
+void nf_tables_trans_destroy_flush_work(struct net *net);
 
 int nf_msecs_to_jiffies64(const struct nlattr *nla, u64 *result);
 __be64 nf_jiffies64_to_msecs(u64 input);
@@ -1905,6 +1905,8 @@ static inline int nft_request_module(struct net *net, const char *fmt, ...) { re
 struct nftables_pernet {
 	struct list_head	tables;
 	struct list_head	commit_list;
+	struct list_head	destroy_list;
+	struct list_head	gc_list;
 	struct list_head	commit_set_list;
 	struct list_head	binding_list;
 	struct list_head	module_list;
@@ -1915,6 +1917,7 @@ struct nftables_pernet {
 	unsigned int		base_seq;
 	unsigned int		gc_seq;
 	u8			validate_state;
+	struct work_struct	destroy_work;
 };
 
 extern unsigned int nf_tables_net_id;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a34de9c17cf1..e9c46fd77498 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -34,10 +34,7 @@ unsigned int nf_tables_net_id __read_mostly;
 static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
-static LIST_HEAD(nf_tables_destroy_list);
-static LIST_HEAD(nf_tables_gc_list);
 static DEFINE_SPINLOCK(nf_tables_destroy_list_lock);
-static DEFINE_SPINLOCK(nf_tables_gc_list_lock);
 
 enum {
 	NFT_VALIDATE_SKIP	= 0,
@@ -109,6 +106,8 @@ static const u8 nft2audit_op[NFT_MSG_MAX] = { // enum nf_tables_msg_types
 	[NFT_MSG_GETSETELEM_RESET] = AUDIT_NFT_OP_SETELEM_RESET,
 };
 
+static void nf_tables_trans_gc_work(struct list_head *gc_list);
+
 static void nft_validate_state_update(struct nft_table *table, u8 new_validate_state)
 {
 	switch (table->validate_state) {
@@ -125,10 +124,6 @@ static void nft_validate_state_update(struct nft_table *table, u8 new_validate_s
 	table->validate_state = new_validate_state;
 }
 static void nf_tables_trans_destroy_work(struct work_struct *w);
-static DECLARE_WORK(trans_destroy_work, nf_tables_trans_destroy_work);
-
-static void nft_trans_gc_work(struct work_struct *work);
-static DECLARE_WORK(trans_gc_work, nft_trans_gc_work);
 
 static void nft_ctx_init(struct nft_ctx *ctx,
 			 struct net *net,
@@ -10006,13 +10001,18 @@ static void nft_commit_release(struct nft_trans *trans)
 
 static void nf_tables_trans_destroy_work(struct work_struct *w)
 {
+	struct nftables_pernet *nft_net = container_of(w, struct nftables_pernet, destroy_work);
 	struct nft_trans *trans, *next;
+	LIST_HEAD(gc_head);
 	LIST_HEAD(head);
 
 	spin_lock(&nf_tables_destroy_list_lock);
-	list_splice_init(&nf_tables_destroy_list, &head);
+	list_splice_init(&nft_net->gc_list, &gc_head);
+	list_splice_init(&nft_net->destroy_list, &head);
 	spin_unlock(&nf_tables_destroy_list_lock);
 
+	nf_tables_trans_gc_work(&gc_head);
+
 	if (list_empty(&head))
 		return;
 
@@ -10024,9 +10024,11 @@ static void nf_tables_trans_destroy_work(struct work_struct *w)
 	}
 }
 
-void nf_tables_trans_destroy_flush_work(void)
+void nf_tables_trans_destroy_flush_work(struct net *net)
 {
-	flush_work(&trans_destroy_work);
+	struct nftables_pernet *nft_net = nft_pernet(net);
+
+	flush_work(&nft_net->destroy_work);
 }
 EXPORT_SYMBOL_GPL(nf_tables_trans_destroy_flush_work);
 
@@ -10277,16 +10279,11 @@ static bool nft_trans_gc_work_done(struct nft_trans_gc *trans)
 	return true;
 }
 
-static void nft_trans_gc_work(struct work_struct *work)
+static void nf_tables_trans_gc_work(struct list_head *gc_list)
 {
 	struct nft_trans_gc *trans, *next;
-	LIST_HEAD(trans_gc_list);
-
-	spin_lock(&nf_tables_gc_list_lock);
-	list_splice_init(&nf_tables_gc_list, &trans_gc_list);
-	spin_unlock(&nf_tables_gc_list_lock);
 
-	list_for_each_entry_safe(trans, next, &trans_gc_list, list) {
+	list_for_each_entry_safe(trans, next, gc_list, list) {
 		list_del(&trans->list);
 		if (!nft_trans_gc_work_done(trans)) {
 			nft_trans_gc_destroy(trans);
@@ -10326,11 +10323,13 @@ void nft_trans_gc_elem_add(struct nft_trans_gc *trans, void *priv)
 
 static void nft_trans_gc_queue_work(struct nft_trans_gc *trans)
 {
-	spin_lock(&nf_tables_gc_list_lock);
-	list_add_tail(&trans->list, &nf_tables_gc_list);
-	spin_unlock(&nf_tables_gc_list_lock);
+	struct nftables_pernet *nft_net = nft_pernet(trans->net);
+
+	spin_lock(&nf_tables_destroy_list_lock);
+	list_add_tail(&trans->list, &nft_net->gc_list);
+	spin_unlock(&nf_tables_destroy_list_lock);
 
-	schedule_work(&trans_gc_work);
+	schedule_work(&nft_net->destroy_work);
 }
 
 static int nft_trans_gc_space(struct nft_trans_gc *trans)
@@ -10484,11 +10483,11 @@ static void nf_tables_commit_release(struct net *net)
 
 	trans->put_net = true;
 	spin_lock(&nf_tables_destroy_list_lock);
-	list_splice_tail_init(&nft_net->commit_list, &nf_tables_destroy_list);
+	list_splice_tail_init(&nft_net->commit_list, &nft_net->destroy_list);
 	spin_unlock(&nf_tables_destroy_list_lock);
 
 	nf_tables_module_autoload_cleanup(net);
-	schedule_work(&trans_destroy_work);
+	schedule_work(&nft_net->destroy_work);
 
 	mutex_unlock(&nft_net->commit_mutex);
 }
@@ -11853,7 +11852,7 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
-	nf_tables_trans_destroy_flush_work();
+	nf_tables_trans_destroy_flush_work(net);
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
@@ -11895,6 +11894,8 @@ static int __net_init nf_tables_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&nft_net->tables);
 	INIT_LIST_HEAD(&nft_net->commit_list);
+	INIT_LIST_HEAD(&nft_net->destroy_list);
+	INIT_LIST_HEAD(&nft_net->gc_list);
 	INIT_LIST_HEAD(&nft_net->commit_set_list);
 	INIT_LIST_HEAD(&nft_net->binding_list);
 	INIT_LIST_HEAD(&nft_net->module_list);
@@ -11903,6 +11904,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	nft_net->base_seq = 1;
 	nft_net->gc_seq = 0;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
+	INIT_WORK(&nft_net->destroy_work, nf_tables_trans_destroy_work);
 
 	return 0;
 }
@@ -11936,21 +11938,20 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 	nft_gc_seq_end(nft_net, gc_seq);
 
 	mutex_unlock(&nft_net->commit_mutex);
+
+	cancel_work_sync(&nft_net->destroy_work);
+
 	WARN_ON_ONCE(!list_empty(&nft_net->tables));
 	WARN_ON_ONCE(!list_empty(&nft_net->module_list));
 	WARN_ON_ONCE(!list_empty(&nft_net->notify_list));
-}
-
-static void nf_tables_exit_batch(struct list_head *net_exit_list)
-{
-	flush_work(&trans_gc_work);
+	WARN_ON_ONCE(!list_empty(&nft_net->destroy_list));
+	WARN_ON_ONCE(!list_empty(&nft_net->gc_list));
 }
 
 static struct pernet_operations nf_tables_net_ops = {
 	.init		= nf_tables_init_net,
 	.pre_exit	= nf_tables_pre_exit_net,
 	.exit		= nf_tables_exit_net,
-	.exit_batch	= nf_tables_exit_batch,
 	.id		= &nf_tables_net_id,
 	.size		= sizeof(struct nftables_pernet),
 };
@@ -12029,10 +12030,7 @@ static void __exit nf_tables_module_exit(void)
 	unregister_netdevice_notifier(&nf_tables_flowtable_notifier);
 	nft_chain_filter_fini();
 	nft_chain_route_fini();
-	nf_tables_trans_destroy_flush_work();
 	unregister_pernet_subsys(&nf_tables_net_ops);
-	cancel_work_sync(&trans_gc_work);
-	cancel_work_sync(&trans_destroy_work);
 	rcu_barrier();
 	rhltable_destroy(&nft_objname_ht);
 	nf_tables_core_module_exit();
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 7ca4f0d21fe2..72711d62fddf 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -228,7 +228,7 @@ static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 	return 0;
 }
 
-static void nft_compat_wait_for_destructors(void)
+static void nft_compat_wait_for_destructors(struct net *net)
 {
 	/* xtables matches or targets can have side effects, e.g.
 	 * creation/destruction of /proc files.
@@ -236,7 +236,7 @@ static void nft_compat_wait_for_destructors(void)
 	 * work queue.  If we have pending invocations we thus
 	 * need to wait for those to finish.
 	 */
-	nf_tables_trans_destroy_flush_work();
+	nf_tables_trans_destroy_flush_work(net);
 }
 
 static int
@@ -262,7 +262,7 @@ nft_target_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 
 	nft_target_set_tgchk_param(&par, ctx, target, info, &e, proto, inv);
 
-	nft_compat_wait_for_destructors();
+	nft_compat_wait_for_destructors(ctx->net);
 
 	ret = xt_check_target(&par, size, proto, inv);
 	if (ret < 0) {
@@ -515,7 +515,7 @@ __nft_match_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 
 	nft_match_set_mtchk_param(&par, ctx, match, info, &e, proto, inv);
 
-	nft_compat_wait_for_destructors();
+	nft_compat_wait_for_destructors(ctx->net);
 
 	return xt_check_match(&par, size, proto, inv);
 }


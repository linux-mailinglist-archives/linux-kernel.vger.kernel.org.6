Return-Path: <linux-kernel+bounces-244096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB261929F11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EAE285F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C57B79945;
	Mon,  8 Jul 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mmpXG2zb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C075579F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430969; cv=none; b=ZPhjbKA3mQNH9RuOcWtH0KQP4ab5KWNC0HttfXSer/R1vbntuUekoYcb0u5cD3d1/+daAWr3ULhhSfZ4r38S230bLUs/b3HUxUq9ZPIMNKL5bz9rzTS/K1NG3BS29yw6c+RuwXE8bBfN+xlKJEPZBKlqUt3x4Gk6ckG6d+MZmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430969; c=relaxed/simple;
	bh=aTGIb0+D9Sv/jOsQ3tTClvWRoDWhCH/sWnarT4el9/Q=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OHYMYLb7VqqTRJ5f/LhSALJD+R6Sk1HFEk6XYxPxayAecGTHLfGh5qXhY0zYpxls79mPmQyvt0VOeF1bs7Zh19SCL0D/2oabzAJArqwXT2gQMf1E20+h1kpcsJYo0Y+MkQZqXfWJaNlK7lG4Nz42ZZHBcJ8OpuXZSaiLzpfV5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mmpXG2zb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=zdZYKFLVQz7+kKvF6YVvGcJqDTuHqI+KXzq8RKGs9qc=; b=mmpXG2zbMpxwAJZJMpb71M4RpE
	jjqNfmIKbELEopjL5cr2kPfQrKs6PNFoXYLUv4qPIAOM8sfD7PsDwlZSZeco0s7WVquN1I+Lw8xo+
	c8Qv5e8hOUNywoT4bo5c4WAQ8HyRQWnOD/YCsYdr+th+xuptAKTSGtyVFTNnJsVy0g0Ptz1prfho9
	LtZM0NI+tvvUVEpbUPWHO2xXxzZdiGJSeZGruMKYcGNBiy6/gERqUjhago0vwViukNIRBRyRBEorC
	Q6tVhmXb3nrnMV6gd0rxGDnYPte1ImmUa26jHmxt4BBimqZWaLmdB8kabtJIP3NPLeV1EfeWMrEHx
	K0Ae4C7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgO-00000000ZsO-044y;
	Mon, 08 Jul 2024 09:29:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 133B1301173; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092415.579623285@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 oleg@redhat.com,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH 04/10] perf/uprobe: RCU-ify find_uprobe()
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With handle_swbp() triggering concurrently on (all) CPUs, tree_lock
becomes a bottleneck. Avoid treelock by doing RCU lookups of the
uprobe.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -40,6 +40,7 @@ static struct rb_root uprobes_tree = RB_
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -54,6 +55,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem)
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	refcount_t		ref;
+	struct rcu_head		rcu;
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
@@ -593,6 +595,12 @@ static struct uprobe *get_uprobe(struct
 	return uprobe;
 }
 
+static void uprobe_free_rcu(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+	kfree(uprobe);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (refcount_dec_and_test(&uprobe->ref)) {
@@ -604,7 +612,7 @@ static void put_uprobe(struct uprobe *up
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		kfree(uprobe);
+		call_rcu(&uprobe->rcu, uprobe_free_rcu);
 	}
 }
 
@@ -653,7 +661,7 @@ static struct uprobe *__find_uprobe(stru
 		.inode = inode,
 		.offset = offset,
 	};
-	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
+	struct rb_node *node = rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
 		return get_uprobe(__node_2_uprobe(node));
@@ -667,20 +675,32 @@ static struct uprobe *__find_uprobe(stru
  */
 static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
-	struct uprobe *uprobe;
+	unsigned int seq;
 
-	read_lock(&uprobes_treelock);
-	uprobe = __find_uprobe(inode, offset);
-	read_unlock(&uprobes_treelock);
+	guard(rcu)();
 
-	return uprobe;
+	do {
+		seq = read_seqcount_begin(&uprobes_seqcount);
+		struct uprobe *uprobe = __find_uprobe(inode, offset);
+		if (uprobe) {
+			/*
+			 * Lockless RB-tree lookups are prone to false-negatives.
+			 * If they find something, it's good. If they do not find,
+			 * it needs to be validated.
+			 */
+			return uprobe;
+		}
+	} while (read_seqcount_retry(&uprobes_seqcount, seq));
+
+	/* Really didn't find anything. */
+	return NULL;
 }
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
 	struct rb_node *node;
 
-	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
+	node = rb_find_add_rcu(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
 	if (node)
 		return get_uprobe(__node_2_uprobe(node));
 
@@ -702,7 +722,9 @@ static struct uprobe *insert_uprobe(stru
 	struct uprobe *u;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	u = __insert_uprobe(uprobe);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 
 	return u;
@@ -936,7 +958,9 @@ static void delete_uprobe(struct uprobe
 		return;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);




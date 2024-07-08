Return-Path: <linux-kernel+bounces-244093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B0F929F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CB12853DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3C7580D;
	Mon,  8 Jul 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQw2biEJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F125579F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430962; cv=none; b=IfatNtWns59Pp5IqRWTuPnD4fwULiG0lSK1zYr70yNpwgxHx9SovzrNT8WjrDle5hy7ds9XI/eokbdi80Xqc6V591LlUrkkdBCvYJRPYzF3e3jvGoz1TEMbY9ibl5ZYkjjYCR+o0plmzZq6PTaXVL9JvKi0tFZQr85yIeqJ8HvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430962; c=relaxed/simple;
	bh=XBXEJ+AdSFCenTIAnaHRXYDU1xC6HpLBXNVHMY67qMI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b5N/BUuXZ5O/kfKoXVWjYR2AJfmzN/j9ByGNDd+BJbfOGdqspS7fPhXjb+sISHcUkpFIMM+Q6bYUYiUR/XpALp1o9+CNfjCXgHGNbPdGxXekKEj3wooG0y8PxT67C52h3spRr0Xll1arS1rBWGLLJ6L0AlIVQ7bArAtVFajcf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YQw2biEJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=M7BG3on9gtFS2ZVkFa0TmKGBd6u6NcFvOKrWMeHPY+E=; b=YQw2biEJNBqZ+OhVgoggX6sTzn
	HBide21arRRMLXEx8qv5HGRZIPhFJx6WWkgKq/yjr7M8P1FHHCKIoaMct6F+2a7BkB3SuaUBMe3U7
	DXn4Smw47cY3pkaCCgl7QwWDTF7ax7e79ZNIRZcwjqzBA0kaws27B6jq8nf+UXU7fhvA8MkCu7rUM
	tATAC5WCh6YZlq/tQCqb1nLU7yffguZ0WvNVrc2dkCgQUfzW3YDAj4FKTJ4IziQpA+zmTozUUcVC8
	DrLJytwk9V+lDlVcenCwR0dpp2z9dPr4U2XJ3v/cGtBRuKNKWd4rV3/++OutEALg8VBH8+EwoZugT
	zFbGl3Zw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgN-00000006hOd-37AX;
	Mon, 08 Jul 2024 09:29:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 214F8302D54; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092415.906217175@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:48 +0200
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
Subject: [PATCH 07/10] perf/uprobe: Convert (some) uprobe->refcount to SRCU
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With handle_swbp() hitting concurrently on (all) CPUs, potentially on
the same uprobe, the uprobe->refcount can get *very* hot. Move the
struct uprobe lifetime into uprobes_srcu such that it covers both the
uprobe and the uprobe->consumers list.

With this, handle_swbp() can use a single large SRCU critical section
to avoid taking a refcount on the uprobe for it's duration.

Notably, the single-step and uretprobe paths need a reference that
leaves handle_swbp() and will, for now, still use ->refcount.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -615,7 +615,7 @@ static void put_uprobe(struct uprobe *up
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		call_rcu(&uprobe->rcu, uprobe_free_rcu);
+		call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
 	}
 }
 
@@ -667,7 +667,7 @@ static struct uprobe *__find_uprobe(stru
 	struct rb_node *node = rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
-		return get_uprobe(__node_2_uprobe(node));
+		return __node_2_uprobe(node);
 
 	return NULL;
 }
@@ -680,7 +680,7 @@ static struct uprobe *find_uprobe(struct
 {
 	unsigned int seq;
 
-	guard(rcu)();
+	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
 
 	do {
 		seq = read_seqcount_begin(&uprobes_seqcount);
@@ -1130,6 +1130,8 @@ void uprobe_unregister_nosync(struct ino
 {
 	struct uprobe *uprobe;
 
+	guard(srcu)(&uprobes_srcu);
+
 	uprobe = find_uprobe(inode, offset);
 	if (WARN_ON(!uprobe))
 		return;
@@ -1137,7 +1139,6 @@ void uprobe_unregister_nosync(struct ino
 	mutex_lock(&uprobe->register_mutex);
 	__uprobe_unregister(uprobe, uc);
 	mutex_unlock(&uprobe->register_mutex);
-	put_uprobe(uprobe);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
@@ -1247,6 +1248,8 @@ int uprobe_apply(struct inode *inode, lo
 	struct uprobe_consumer *con;
 	int ret = -ENOENT;
 
+	guard(srcu)(&uprobes_srcu);
+
 	uprobe = find_uprobe(inode, offset);
 	if (WARN_ON(!uprobe))
 		return ret;
@@ -1257,7 +1260,6 @@ int uprobe_apply(struct inode *inode, lo
 	if (con)
 		ret = register_for_each_vma(uprobe, add ? uc : NULL);
 	mutex_unlock(&uprobe->register_mutex);
-	put_uprobe(uprobe);
 
 	return ret;
 }
@@ -1977,7 +1979,7 @@ pre_ssout(struct uprobe *uprobe, struct
 		return err;
 	}
 
-	utask->active_uprobe = uprobe;
+	utask->active_uprobe = get_uprobe(uprobe);
 	utask->state = UTASK_SSTEP;
 	return 0;
 }
@@ -2108,7 +2110,7 @@ static void handler_chain(struct uprobe
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
-	guard(srcu)(&uprobes_srcu);
+	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
 
 	for_each_consumer_rcu(uc, uprobe->consumers) {
 		int rc = 0;
@@ -2227,6 +2229,8 @@ static void handle_swbp(struct pt_regs *
 	if (bp_vaddr == get_trampoline_vaddr())
 		return handle_trampoline(regs);
 
+	guard(srcu)(&uprobes_srcu);
+
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
 	if (!uprobe) {
 		if (is_swbp > 0) {
@@ -2255,7 +2259,7 @@ static void handle_swbp(struct pt_regs *
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
-		goto out;
+		return;
 
 	/*
 	 * Pairs with the smp_wmb() in prepare_uprobe().
@@ -2268,22 +2272,17 @@ static void handle_swbp(struct pt_regs *
 
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
-		goto out;
+		return;
 
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
-		goto out;
+		return;
 
 	handler_chain(uprobe, regs);
 
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
-		goto out;
-
-	if (!pre_ssout(uprobe, regs, bp_vaddr))
 		return;
 
-	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
-out:
-	put_uprobe(uprobe);
+	pre_ssout(uprobe, regs, bp_vaddr);
 }
 
 /*




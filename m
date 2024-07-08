Return-Path: <linux-kernel+bounces-244098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83191929F13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044461F230D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340E7C6C0;
	Mon,  8 Jul 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGCoToo9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A85558B7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430970; cv=none; b=KerTtnfFOc8AGQuQWRgviUBtYMWtVplfxzDlz4cJLRu16GT67y3EG9VugF2vk+l5ZZ7BipnsXJ1nCDF+qH0MkEqtw54kbb4Z96X938DOXSIHvpOXkwIex30q+P9EMRuUgVO34H8Q47gN0PKTVV71iFx3hCiq89Xh4oR19WlIXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430970; c=relaxed/simple;
	bh=19oikYIhlf6k4p96gB5CwVw/zCLin1gB3y02oDAksuA=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fXNalCO/rqF+g9vCGeckuwLK407Spa1QLZ6lY3MvILMAm9Jmg4/HVFfrZoCNdO3Z9abj0mx+W6Xqr92WT9NNaMW8r3SAxSyODHyIr1lRv2WfNjtzrHqO5PKJOG6pB/xpT+3OQ0O3JmXKt0v8LpsbsEC+joJ4RQ7jMAYDOMgDUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GGCoToo9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=INjGkbUShkrtBrjMmEIfWNm46FJQN+XQG6PJX5gCW08=; b=GGCoToo9n3ejpYpeNouOt/pl7T
	3hJ4OqSPkjNJ7qTMi9gs8/gCZYZ8GVSiSTQzT5s82aKpuHnN/hrFcLbXhqtFU24yaSW7Ht8Zb/nGm
	xwHMBcnDsKi50clCamGgVflHDohEnFOe7/V4V/mrQh29BnDRkAH5g+06990r0fSgAArab99f7kGkS
	40hI4eNn4OiDOA1/rRXIpByLQkWrWlyEm6bKGo4IWwYGa/AoIUh61X7N2RUyuPQt2Ja+o3jLEURrF
	2MSbxqiHVp/KnNn3aLY6hbKu7Jp5lVIpCR4oovaHwsSXn+hLREP+7WkyCIeCjNQkpLi7m0wKu4k09
	qW8RL6ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgO-00000000ZsR-15RL;
	Mon, 08 Jul 2024 09:29:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 292F9303DD8; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092416.127360526@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:50 +0200
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
Subject: [PATCH 09/10] perf/uprobe: Convert single-step and uretprobe to SRCU
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Both single-step and uretprobes take a refcount on struct uprobe in
handle_swbp() in order to ensure struct uprobe stays extant until a
next trap.

Since uprobe_unregister() only cares about the uprobe_consumer
life-time, and these intra-trap sections can be arbitrarily large,
create a second SRCU domain to cover these.

Notably, a uretprobe with a registered return_instance that never
triggers -- because userspace -- will currently pin the
return_instance and related uprobe until the task dies. With this
convertion to SRCU this behaviour will inhibit freeing of all uprobes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/uprobes.h |    2 ++
 kernel/events/uprobes.c |   23 ++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -78,6 +78,7 @@ struct uprobe_task {
 
 	struct return_instance		*return_instances;
 	unsigned int			depth;
+	unsigned int			active_srcu_idx;
 };
 
 struct return_instance {
@@ -86,6 +87,7 @@ struct return_instance {
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
+	int			srcu_idx;
 
 	struct return_instance	*next;		/* keep as stack */
 };
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -51,6 +51,7 @@ static struct mutex uprobes_mmap_mutex[U
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
 DEFINE_STATIC_SRCU(uprobes_srcu);
+DEFINE_STATIC_SRCU(uretprobes_srcu);
 
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
@@ -598,12 +599,18 @@ static struct uprobe *get_uprobe(struct
 	return uprobe;
 }
 
-static void uprobe_free_rcu(struct rcu_head *rcu)
+static void uprobe_free_stage2(struct rcu_head *rcu)
 {
 	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
 	kfree(uprobe);
 }
 
+static void uprobe_free_stage1(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+	call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_stage2);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (refcount_dec_and_test(&uprobe->ref)) {
@@ -615,7 +622,7 @@ static void put_uprobe(struct uprobe *up
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
+		call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_stage1);
 	}
 }
 
@@ -1735,7 +1742,7 @@ unsigned long uprobe_get_trap_addr(struc
 static struct return_instance *free_ret_instance(struct return_instance *ri)
 {
 	struct return_instance *next = ri->next;
-	put_uprobe(ri->uprobe);
+	srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
 	kfree(ri);
 	return next;
 }
@@ -1753,7 +1760,7 @@ void uprobe_free_utask(struct task_struc
 		return;
 
 	if (utask->active_uprobe)
-		put_uprobe(utask->active_uprobe);
+		srcu_read_unlock(&uretprobes_srcu, utask->active_srcu_idx);
 
 	ri = utask->return_instances;
 	while (ri)
@@ -1796,7 +1803,7 @@ static int dup_utask(struct task_struct
 			return -ENOMEM;
 
 		*n = *o;
-		get_uprobe(n->uprobe);
+		__srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
 		n->next = NULL;
 
 		*p = n;
@@ -1939,7 +1946,8 @@ static void prepare_uretprobe(struct upr
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
 
-	ri->uprobe = get_uprobe(uprobe);
+	ri->srcu_idx = srcu_read_lock(&uretprobes_srcu);
+	ri->uprobe = uprobe;
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
@@ -1979,7 +1987,8 @@ pre_ssout(struct uprobe *uprobe, struct
 		return err;
 	}
 
-	utask->active_uprobe = get_uprobe(uprobe);
+	utask->active_srcu_idx = srcu_read_lock(&uretprobes_srcu);
+	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
 	return 0;
 }




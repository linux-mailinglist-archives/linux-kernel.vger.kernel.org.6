Return-Path: <linux-kernel+bounces-244100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F152929F15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0F1B22EEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FFB80023;
	Mon,  8 Jul 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BzQoAiQL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AA56452
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430970; cv=none; b=mllTubQ2l/lQcPywL8TqJ+rUVlWrCmd7W+AcOcpvG2ojtSiBAvNR9va0Z8UYQ1w42hPib4hZz23jF9VPcQ/IyHoV1R0FUBokjfRjpwlb/+Bob7o6Vg09j+dH9ST34+R+C+I5LUeSYQVnb6sFOvvDsIV7fIWdsrGMU8E/j3u2Lvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430970; c=relaxed/simple;
	bh=NIznFFC+YqfstGk8XO7oJGHArYFE63Hknj2SoWt6TsY=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HP60VQaTGm0c/JdRf3Es0XwZuokdneuikbqLWrrZ2Kfk+5Y+iOH98XDn8+3UWVrjAB3CiTrRLFFe2oL0uSBcybeATkyq+0RvW7fadf71rMwGH/UQ6LurunU9M08MK2SMspU8i0fJToSoLNoWJfpgyoHBTMVoZSfN7LkoOsfV1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BzQoAiQL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=AYprHqdZvozegjyHQBgBMRoiJh+6953VLAW68QuttTQ=; b=BzQoAiQL9I7o+H+8dxZD+BCApE
	tp6gHlJGlDKtfvwVz+Jtx/n5jLZ+ZSw+IVZu0vbs56KOSaIHQnAA2E1JtZijVXITclURJ9Q1RTjzW
	VebEQcJSojL26exBrIpxB2ZwUJBDlHPYCgEcwJ9DWlobpZmpHApk4Hj9u1IoXGwAskJFhTCyT3fG0
	JAj9j3vgXWaFG2f/x4pYu7fX1N9mgig+JFS1P5w+zmsxn31puXqeJAG19mOHHDCkxV447BF1v2tq7
	RcJfudZU9fqcVQGvfzPJPmyObjSJKmIJd7JWC9vqQcfUDPK/3MXD/ztPhUbgR4aNjQbPEPv8xoupI
	0PnWmiXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgO-00000000ZsS-1FMa;
	Mon, 08 Jul 2024 09:29:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2DCE9304BE6; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092416.235666453@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:51 +0200
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
Subject: [PATCH 10/10] perf/uprobe: Add uretprobe timer
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to put a bound on the uretprobe_srcu critical section, add a
timer to uprobe_task. Upon every RI added or removed the timer is
pushed forward to now + 1s. If the timer were ever to fire, it would
convert the SRCU 'reference' to a refcount reference if possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/uprobes.h |    8 +++++
 kernel/events/uprobes.c |   66 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 6 deletions(-)

--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -15,6 +15,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/timer.h>
 
 struct vm_area_struct;
 struct mm_struct;
@@ -79,6 +80,10 @@ struct uprobe_task {
 	struct return_instance		*return_instances;
 	unsigned int			depth;
 	unsigned int			active_srcu_idx;
+
+	struct timer_list		ri_timer;
+	struct callback_head		ri_task_work;
+	struct task_struct		*task;
 };
 
 struct return_instance {
@@ -86,7 +91,8 @@ struct return_instance {
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
-	bool			chained;	/* true, if instance is nested */
+	u8			chained;	/* true, if instance is nested */
+	u8			has_ref;
 	int			srcu_idx;
 
 	struct return_instance	*next;		/* keep as stack */
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1742,7 +1742,12 @@ unsigned long uprobe_get_trap_addr(struc
 static struct return_instance *free_ret_instance(struct return_instance *ri)
 {
 	struct return_instance *next = ri->next;
-	srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
+	if (ri->uprobe) {
+		if (ri->has_ref)
+			put_uprobe(ri->uprobe);
+		else
+			srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
+	}
 	kfree(ri);
 	return next;
 }
@@ -1766,11 +1771,48 @@ void uprobe_free_utask(struct task_struc
 	while (ri)
 		ri = free_ret_instance(ri);
 
+	timer_delete_sync(&utask->ri_timer);
+	task_work_cancel(utask->task, &utask->ri_task_work);
 	xol_free_insn_slot(t);
 	kfree(utask);
 	t->utask = NULL;
 }
 
+static void return_instance_task_work(struct callback_head *head)
+{
+	struct uprobe_task *utask = container_of(head, struct uprobe_task, ri_task_work);
+	struct return_instance *ri;
+
+	for (ri = utask->return_instances; ri; ri = ri->next) {
+		if (!ri->uprobe)
+			continue;
+		if (ri->has_ref)
+			continue;
+		if (refcount_inc_not_zero(&ri->uprobe->ref))
+			ri->has_ref = true;
+		else
+			ri->uprobe = NULL;
+		srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
+	}
+}
+
+static void return_instance_timer(struct timer_list *timer)
+{
+	struct uprobe_task *utask = container_of(timer, struct uprobe_task, ri_timer);
+	task_work_add(utask->task, &utask->ri_task_work, TWA_SIGNAL);
+}
+
+static struct uprobe_task *alloc_utask(struct task_struct *task)
+{
+	struct uprobe_task *utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+	if (!utask)
+		return NULL;
+	timer_setup(&utask->ri_timer, return_instance_timer, 0);
+	init_task_work(&utask->ri_task_work, return_instance_task_work);
+	utask->task = task;
+	return utask;
+}
+
 /*
  * Allocate a uprobe_task object for the task if necessary.
  * Called when the thread hits a breakpoint.
@@ -1782,7 +1824,7 @@ void uprobe_free_utask(struct task_struc
 static struct uprobe_task *get_utask(void)
 {
 	if (!current->utask)
-		current->utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+		current->utask = alloc_utask(current);
 	return current->utask;
 }
 
@@ -1791,7 +1833,7 @@ static int dup_utask(struct task_struct
 	struct uprobe_task *n_utask;
 	struct return_instance **p, *o, *n;
 
-	n_utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+	n_utask = alloc_utask(t);
 	if (!n_utask)
 		return -ENOMEM;
 	t->utask = n_utask;
@@ -1803,13 +1845,20 @@ static int dup_utask(struct task_struct
 			return -ENOMEM;
 
 		*n = *o;
-		__srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
+		if (n->uprobe) {
+			if (n->has_ref)
+				get_uprobe(n->uprobe);
+			else
+				__srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
+		}
 		n->next = NULL;
 
 		*p = n;
 		p = &n->next;
 		n_utask->depth++;
 	}
+	if (n_utask->return_instances)
+		mod_timer(&n_utask->ri_timer, jiffies + HZ);
 
 	return 0;
 }
@@ -1957,6 +2006,8 @@ static void prepare_uretprobe(struct upr
 	ri->next = utask->return_instances;
 	utask->return_instances = ri;
 
+	mod_timer(&utask->ri_timer, jiffies + HZ);
+
 	return;
 fail:
 	kfree(ri);
@@ -2151,6 +2202,9 @@ handle_uretprobe_chain(struct return_ins
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
 
+	if (!uprobe)
+		return;
+
 	guard(srcu)(&uprobes_srcu);
 
 	for_each_consumer_rcu(uc, uprobe->consumers) {
@@ -2197,8 +2251,10 @@ static void handle_trampoline(struct pt_
 
 		instruction_pointer_set(regs, ri->orig_ret_vaddr);
 		do {
-			if (valid)
+			if (valid) {
 				handle_uretprobe_chain(ri, regs);
+				mod_timer(&utask->ri_timer, jiffies + HZ);
+			}
 			ri = free_ret_instance(ri);
 			utask->depth--;
 		} while (ri != next);




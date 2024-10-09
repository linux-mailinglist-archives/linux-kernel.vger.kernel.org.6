Return-Path: <linux-kernel+bounces-357116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C42996BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1031C24AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D925E199FB8;
	Wed,  9 Oct 2024 13:21:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D578198E69
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480075; cv=none; b=E6JuL8iJaPhyxa8CgZgIRs2j+Ft1jSgTNRXpD0KMid5ao0RDeyO8on1EGpRI2b+7obA2ftPbp4iJkwDChDOeMbTKevEXQwV9Qs9H8/LfZwNTKACjKGUbwxaqGca5FxOOnGZv59Nt42MEfr2iVnQ+ffq+9i++oPLGFT0zLk1LXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480075; c=relaxed/simple;
	bh=PT2XMQAV2hkgZP1Zs73E2VXp46ND+daiBSO83zepyFU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PXfhLfuUP2h+RayTvrPv3ShUYkVBoaAnUcz8bMZG6/3KXNzVlgLMXwq1Fg/wOmNWqmPjEEi23nrj+h7rK6RXXZPx/TAbQG3f3vSP4m/iAUNWaIvIm5DUOF4Ba9L283BAQ+aSe42VX+wUWkGfaoBy0UH9/zld9ipwJJ7BIjvu/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD83C4CEDA;
	Wed,  9 Oct 2024 13:21:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syWcy-0000000178H-2UZz;
	Wed, 09 Oct 2024 09:21:20 -0400
Message-ID: <20241009132120.456794859@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Oct 2024 09:21:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [for-next][PATCH 6/6] tracepoint: Remove SRCU protection
References: <20241009132104.470687911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

With the removal of the trace_*_rcuidle() tracepoints, there is no reason
to protect tracepoints with SRCU. The reason the SRCU protection was
added, was because it can protect tracepoints when RCU is not "watching".
Now that tracepoints are only used when RCU is watching, remove the SRCU
protection. It just made things more complex and confusing anyway.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Link: https://lore.kernel.org/20241003184220.0dc21d35@gandalf.local.home
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h |  4 ---
 kernel/tracepoint.c        | 51 +-------------------------------------
 2 files changed, 1 insertion(+), 54 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 7e4af7b3633c..3d33b9872cec 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -32,8 +32,6 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
-extern struct srcu_struct tracepoint_srcu;
-
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -109,7 +107,6 @@ void for_each_tracepoint_in_module(struct module *mod,
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
-	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
 #else
@@ -207,7 +204,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (!(cond))						\
 			return;						\
 									\
-		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
 									\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1e3de77ea6b3..6474e2cf22c9 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -25,9 +25,6 @@ enum tp_func_state {
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
-DEFINE_SRCU(tracepoint_srcu);
-EXPORT_SYMBOL_GPL(tracepoint_srcu);
-
 enum tp_transition_sync {
 	TP_TRANSITION_SYNC_1_0_1,
 	TP_TRANSITION_SYNC_N_2_1,
@@ -37,7 +34,6 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
-	unsigned long srcu;
 	bool ongoing;
 };
 
@@ -50,7 +46,6 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
-	snapshot->srcu = start_poll_synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = true;
 }
 
@@ -61,8 +56,6 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
-	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu))
-		synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = false;
 }
 
@@ -85,9 +78,6 @@ static LIST_HEAD(tracepoint_module_list);
  */
 static DEFINE_MUTEX(tracepoints_mutex);
 
-static struct rcu_head *early_probes;
-static bool ok_to_free_tracepoints;
-
 /*
  * Note about RCU :
  * It is used to delay the free of multiple probes array until a quiescent
@@ -111,56 +101,17 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void srcu_free_old_probes(struct rcu_head *head)
-{
-	kfree(container_of(head, struct tp_probes, rcu));
-}
-
 static void rcu_free_old_probes(struct rcu_head *head)
 {
-	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
-}
-
-static __init int release_early_probes(void)
-{
-	struct rcu_head *tmp;
-
-	ok_to_free_tracepoints = true;
-
-	while (early_probes) {
-		tmp = early_probes;
-		early_probes = tmp->next;
-		call_rcu(tmp, rcu_free_old_probes);
-	}
-
-	return 0;
+	kfree(container_of(head, struct tp_probes, rcu));
 }
 
-/* SRCU is initialized at core_initcall */
-postcore_initcall(release_early_probes);
-
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
-		/*
-		 * We can't free probes if SRCU is not initialized yet.
-		 * Postpone the freeing till after SRCU is initialized.
-		 */
-		if (unlikely(!ok_to_free_tracepoints)) {
-			tp_probes->rcu.next = early_probes;
-			early_probes = &tp_probes->rcu;
-			return;
-		}
-
-		/*
-		 * Tracepoint probes are protected by both sched RCU and SRCU,
-		 * by calling the SRCU callback in the sched RCU callback we
-		 * cover both cases. So let us chain the SRCU and sched RCU
-		 * callbacks to wait for both grace periods.
-		 */
 		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
 	}
 }
-- 
2.45.2




Return-Path: <linux-kernel+bounces-388143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C39B5B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F21F2187E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1161CF5F5;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33371CF289
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266571; cv=none; b=Tj1zMjm0BLm/427S7GCironuexLtGAG7LI3VaY0BVCw7MNSjt8iOMrsi0BBJvLJmqXY/HguUIS+mYYRYFTWRe/NZXPG02B3mU9228vw7M2YadUktx+RWCKPZTNHE9ib3+Shz9VwArwInniANlxdG04FFMOp9MtExH1EvP5Jn2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266571; c=relaxed/simple;
	bh=XNUK0TECBAjRZzXRzwjfDmT9lMeI7Lr7DwwAmU30QsM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hE+lTc7OFzcI0VwvDWYbecuOIiUHkOOMijG2vCFTDoPt4OplX+Tsl9j+hB0ua+Oo1s9pjQGh3ZNa2pRt53vo0xY21+KPZ0/F4xnJRBPviB2iyG22lBl1Cd9GrDzo/7FW0NpjOO2mAHkGTKnr+7s7kSfD90VBYgJ89Kt60BRlZvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8AAC4CEE4;
	Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OC-00000005BD8-3qGF;
	Wed, 30 Oct 2024 01:37:04 -0400
Message-ID: <20241030053704.781457290@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: [for-next][PATCH 2/7] fgraph: Give ret_stack its own kmem cache
References: <20241030053650.956861738@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ret_stack (shadow stack used by function graph infrastructure) is
created for every task on the system when function graph is enabled. Give
it its own kmem_cache. This will make it easier to see how much memory is
being used specifically for function graph shadow stacks.

In the future, this size may change and may not be a power of two. Having
its own cache can also keep it from fragmenting memory.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/20241026063210.7d4910a7@rorschach.local.home
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4ce87982966a..001abf376c0c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -172,6 +172,8 @@ enum {
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
+static struct kmem_cache *fgraph_stack_cachep;
+
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 static unsigned long fgraph_array_bitmask;
 
@@ -1022,8 +1024,11 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
 	struct task_struct *g, *t;
 
+	if (WARN_ON_ONCE(!fgraph_stack_cachep))
+		return -ENOMEM;
+
 	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
-		ret_stack_list[i] = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+		ret_stack_list[i] = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
 		if (!ret_stack_list[i]) {
 			start = 0;
 			end = i;
@@ -1054,7 +1059,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
-		kfree(ret_stack_list[i]);
+		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
 	return ret;
 }
 
@@ -1117,9 +1122,12 @@ void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 	if (ftrace_graph_active) {
 		unsigned long *ret_stack;
 
+		if (WARN_ON_ONCE(!fgraph_stack_cachep))
+			return;
+
 		ret_stack = per_cpu(idle_ret_stack, cpu);
 		if (!ret_stack) {
-			ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+			ret_stack = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
 			if (!ret_stack)
 				return;
 			per_cpu(idle_ret_stack, cpu) = ret_stack;
@@ -1139,7 +1147,10 @@ void ftrace_graph_init_task(struct task_struct *t)
 	if (ftrace_graph_active) {
 		unsigned long *ret_stack;
 
-		ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+		if (WARN_ON_ONCE(!fgraph_stack_cachep))
+			return;
+
+		ret_stack = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
 		if (!ret_stack)
 			return;
 		graph_init_task(t, ret_stack);
@@ -1154,7 +1165,11 @@ void ftrace_graph_exit_task(struct task_struct *t)
 	/* NULL must become visible to IRQs before we free it: */
 	barrier();
 
-	kfree(ret_stack);
+	if (ret_stack) {
+		if (WARN_ON_ONCE(!fgraph_stack_cachep))
+			return;
+		kmem_cache_free(fgraph_stack_cachep, ret_stack);
+	}
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1294,6 +1309,14 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	guard(mutex)(&ftrace_lock);
 
+	if (!fgraph_stack_cachep) {
+		fgraph_stack_cachep = kmem_cache_create("fgraph_stack",
+							SHADOW_STACK_SIZE,
+							SHADOW_STACK_SIZE, 0, NULL);
+		if (!fgraph_stack_cachep)
+			return -ENOMEM;
+	}
+
 	if (!fgraph_initialized) {
 		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
 					fgraph_cpu_init, NULL);
-- 
2.45.2




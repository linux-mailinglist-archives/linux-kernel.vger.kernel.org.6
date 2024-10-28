Return-Path: <linux-kernel+bounces-384167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236F9B252A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274B61C20FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112C18E04F;
	Mon, 28 Oct 2024 06:18:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6718990E;
	Mon, 28 Oct 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096334; cv=none; b=d88kQoWH4fwleL0CC8BMDKa+Yy1XoCdf47+BUOs835VFLC7yClC8ZLgEtxt42nggeGLviUeD9IVpBEd+1iX2u6jzus1V+XFN8w9wurNXpFOkOE+EbQ3P+okOwxP1fBA9VrQbFv8daGuxog6Hkly4wXEyjYee/yfEWfyxpufAa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096334; c=relaxed/simple;
	bh=dzDk9/xFKvznY+UTyW1qA2jZIwt55uoI3mWeTswf4Kw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=e103VHtYF6fsc1+wPBbxyQSdZdN+TZozE+SwpfYkV04+3q2rTrfy5Xc4vPP2dlgU88PasyKhX5LIw7G76kSf5df+fabd4+Ca7fIdXvMYjioBLGIQY+DkoOEstCzLfVL93nwcyC+3RmNF+85vKDh6/3a47weh4ru38yta2yie154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61896C4CEE3;
	Mon, 28 Oct 2024 06:18:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5J6N-000000052wy-01NP;
	Mon, 28 Oct 2024 02:19:43 -0400
Message-ID: <20241028061942.865941501@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 02:18:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 1/2] fgraph: Free ret_stacks when graph tracing is done
References: <20241028061821.009891807@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Since function graph tracing was added to the kernel, it needed shadow
stacks for every process in order to be able to hijack the return address
and replace it with its own trampoline to trace when the function exits.
The first time function graph was used, it allocated PAGE_SIZE for each
task on the system (including idle tasks). But because these stacks may
still be in use long after tracing is done, they were never freed (except
when a task exits). That means any task that never exits (including kernel
tasks), would always have these shadow stacks allocated even when they
were no longer needed.

The race that needed to be avoided was tracing functions that sleep for
long periods of time (i.e. poll()). If it gets traced, its original return
address is saved on the shadow stack. That means the shadow stack can not
be freed until the task is no longer using it.

Luckily, it is easy to know if the task is done with its shadow stack.
After function graph is disabled, the shadow stack will never grow, and
once the last element is removed off of it, nothing will use it again.

When function graph is done and the last user unregisters, all the tasks
in the system can be examined and if the shadow stack pointer
(curr_ret_depth), is zero, then it can be freed. But since there's no
memory barriers on the CPUs doing the tracing, it has to be moved to a
link list first and then after a call to synchronize_rcu_tasks_trace() the
shadow stacks can be freed.

As the shadow stack is not going to grow anymore, the end of the shadow
stack can be used to store a structure that holds the list_head for the
link list as well as a pointer to the task. This can be used to delay the
freeing until all the shadow stacks to be freed are added to the link list
and the synchronize_rcu_tasks_trace() has finished.

Note, tasks that are still using their shadow stack will not have them
freed. They will stay until the task exits or if another instance of
function graph is registered and unregistered and the shadow stack is no
longer being used.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20241028060118.796879197@goodmis.org

- Use guard(mutex) for ftrace_lock in ftrace_graph_init_task()
  The added mutex ignored the error paths that returned early.

 kernel/trace/fgraph.c | 114 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 001abf376c0c..f7df6c14d5f9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1144,6 +1144,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
 
+	guard(mutex)(&ftrace_lock);
 	if (ftrace_graph_active) {
 		unsigned long *ret_stack;
 
@@ -1292,19 +1293,106 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 	fgraph_direct_gops = &fgraph_stub;
 }
 
-/* The cpu_boot init_task->ret_stack will never be freed */
-static int fgraph_cpu_init(unsigned int cpu)
+static void __fgraph_cpu_init(unsigned int cpu)
 {
 	if (!idle_task(cpu)->ret_stack)
 		ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+}
+
+static int fgraph_cpu_init(unsigned int cpu)
+{
+	if (ftrace_graph_active)
+		__fgraph_cpu_init(cpu);
+	return 0;
+}
+
+struct ret_stack_free_data {
+	struct list_head		list;
+	struct task_struct		*task;
+};
+
+static void remove_ret_stack(struct task_struct *t, struct list_head *head, int list_index)
+{
+	struct ret_stack_free_data *free_data;
+
+	/* If the ret_stack is still in use, skip this */
+	if (t->curr_ret_depth >= 0)
+		return;
+
+	free_data = (struct ret_stack_free_data*)(t->ret_stack + list_index);
+	list_add(&free_data->list, head);
+	free_data->task = t;
+}
+
+static void free_ret_stacks(void)
+{
+	struct ret_stack_free_data *free_data, *n;
+	struct task_struct *g, *t;
+	LIST_HEAD(stacks);
+	int list_index;
+	int list_sz;
+	int cpu;
+
+	/* Calculate the size in longs to hold ret_stack_free_data */
+	list_sz = DIV_ROUND_UP(sizeof(struct ret_stack_free_data), sizeof(long));
+
+	/*
+	 * We do not want to race with __ftrace_return_to_handler() where this
+	 * CPU can see the update to curr_ret_depth going to zero before it
+	 * actually does. As tracing is disabled, the ret_stack is not going
+	 * to be used anymore and there will be no more callbacks. Use
+	 * the top of the stack as the link list pointer to attach this
+	 * ret_stack to @head. Then at the end, run an RCU trace synthronization
+	 * which will guarantee that there are no more uses of the ret_stacks
+	 * and they can all be freed.
+	 */
+	list_index = SHADOW_STACK_MAX_OFFSET - list_sz;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, t) {
+		if (t->ret_stack)
+			remove_ret_stack(t, &stacks, list_index);
+	}
+	read_unlock(&tasklist_lock);
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		t = idle_task(cpu);
+		if (t->ret_stack)
+			remove_ret_stack(t, &stacks, list_index);
+	}
+	cpus_read_unlock();
+
+	/* Make sure nothing is using the ret_stacks anymore */
+	synchronize_rcu_tasks_trace();
+
+	list_for_each_entry_safe(free_data, n, &stacks, list) {
+		unsigned long *stack = free_data->task->ret_stack;
+
+		free_data->task->ret_stack = NULL;
+		kmem_cache_free(fgraph_stack_cachep, stack);
+	}
+}
+
+static __init int fgraph_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
+				fgraph_cpu_init, NULL);
+	if (ret < 0) {
+		pr_warn("fgraph: Error to init cpu hotplug support\n");
+		return ret;
+	}
 	return 0;
 }
+core_initcall(fgraph_init)
 
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
-	static bool fgraph_initialized;
 	int command = 0;
-	int ret = 0;
+	int cpu;
+	int ret;
 	int i = -1;
 
 	guard(mutex)(&ftrace_lock);
@@ -1317,17 +1405,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 			return -ENOMEM;
 	}
 
-	if (!fgraph_initialized) {
-		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
-					fgraph_cpu_init, NULL);
-		if (ret < 0) {
-			pr_warn("fgraph: Error to init cpu hotplug support\n");
-			return ret;
-		}
-		fgraph_initialized = true;
-		ret = 0;
-	}
-
 	if (!fgraph_array[0]) {
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
@@ -1342,6 +1419,12 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	ftrace_graph_active++;
 
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		__fgraph_cpu_init(cpu);
+	}
+	cpus_read_unlock();
+
 	if (ftrace_graph_active == 2)
 		ftrace_graph_disable_direct(true);
 
@@ -1412,6 +1495,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_entry = ftrace_graph_entry_stub;
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+		free_ret_stacks();
 	}
  out:
 	gops->saved_func = NULL;
-- 
2.45.2




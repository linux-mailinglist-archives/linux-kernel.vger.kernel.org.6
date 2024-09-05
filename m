Return-Path: <linux-kernel+bounces-317885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1D96E50C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B571E1F24505
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69F1B12DB;
	Thu,  5 Sep 2024 21:27:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7376E56E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571645; cv=none; b=dDgjGNSOR+KZ3XkFSM2ozgvCoCdqVAerebA5CSZvFf33bdjxyhaDA3Lfg/aJ/G8gTmDBP49edEbaQUHw72PuIGa6IY5MHX1lOlnh/09NDKH3k2gJqgvh25Jah8KJvXw4qbFLfTuow2sUso4tlpXg3X54LIXkh0r9W6cBsRgE90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571645; c=relaxed/simple;
	bh=OWp6k/q9xvcxxieQZJlCD2WY9PHmwB9mKtVRSBASCvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MSw2jPuhKMOR6Uj7OZzgPSlDdIKs3CoWlZpd+37A6yaJ1i1KPoqwf/VJnHVh+z3X2pMlSLSWR1VkCOedGpD1W8Gqr76DdHWPIi615Xmd8XGlfZfa9x4w/dht/F958t6PlTPJsoB1owesfRitROvoiDzvmrXVziIBzArEKJxviL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB84C4CEC4;
	Thu,  5 Sep 2024 21:27:24 +0000 (UTC)
Date: Thu, 5 Sep 2024 17:28:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Tomas Glozar <tglozar@redhat.com>, "Luis
 Claudio R. Goncalves" <lgoncalv@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: [GIT PULL] tracing: Fixes for 6.11
Message-ID: <20240905172827.6a64cf97@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Tracing fixes for 6.11:

- Fix adding a new fgraph callback after function graph tracing has
  already started.

  If the new caller does not initialize its hash before registering the
  fgraph_ops, it can cause a NULL pointer dereference. Fix this by adding
  a new parameter to ftrace_graph_enable_direct() passing in the newly
  added gops directly and not rely on using the fgraph_array[], as entries
  in the fgraph_array[] must be initialized. Assign the new gops to the
  fgraph_array[] after it goes through ftrace_startup_subops() as that
  will properly initialize the gops->ops and initialize its hashes.

- Fix a memory leak in fgraph storage memory test.

  If the "multiple fgraph storage on a function" boot up selftest
  fails in the registering of the function graph tracer, it will
  not free the memory it allocated for the filter. Break the loop
  up into two where it allocates the filters first and then registers
  the functions where any errors will do the appropriate clean ups.

- Only clear the timerlat timers if it has an associated kthread.

  In the rtla tool that uses timerlat, if it was killed just as it
  was shutting down, the signals can free the kthread and the timer.
  But the closing of the timerlat files could cause the hrtimer_cancel()
  to be called on the already freed timer. As the kthread variable is
  is set to NULL when the kthreads are stopped and the timers are freed
  it can be used to know not to call hrtimer_cancel() on the timer if
  the kthread variable is NULL.

- Use a cpumask to keep track of osnoise/timerlat kthreads

  The timerlat tracer can use user space threads for its analysis.
  With the killing of the rtla tool, the kernel can get confused
  between if it is using a user space thread to analyze or one of its
  own kernel threads. When this confusion happens, kthread_stop()
  can be called on a user space thread and bad things happen.
  As the kernel threads are per-cpu, a bitmask can be used to know
  when a kernel thread is used or when a user space thread is used.

- Add missing interface_lock to osnoise/timerlat stop_kthread()

  The stop_kthread() function in osnoise/timerlat clears the
  osnoise kthread variable, and if it was a user space thread does
  a put_task on it. But this can race with the closing of the timerlat
  files that also does a put_task on the kthread, and if the race happens
  the task will have put_task called on it twice and oops.

- Add cond_resched() to the tracing_iter_reset() loop.

  The latency tracers keep writing to the ring buffer without resetting
  when it issues a new "start" event (like interrupts being disabled).
  When reading the buffer with an iterator, the tracing_iter_reset()
  sets its pointer to that start event by walking through all the events
  in the buffer until it gets to the time stamp of the start event.
  In the case of a very large buffer, the loop that looks for the start
  event has been reported taking a very long time with a non preempt kernel
  that it can trigger a soft lock up warning. Add a cond_resched() into
  that loop to make sure that doesn't happen.

- Use list_del_rcu() for eventfs ei->list variable

  It was reported that running loops of creating and deleting  kprobe events
  could cause a crash due to the eventfs list iteration hitting a LIST_POISON
  variable. This is because the list is protected by SRCU but when an item is
  deleted from the list, it was using list_del() which poisons the "next"
  pointer. This is what list_del_rcu() was to prevent.


Please pull the latest trace-v6.11-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.11-rc4

Tag SHA1: 7f09aa3e1fa8ddf070ef0812322e2dce810cc964
Head SHA1: 5bfbcd1ee57b607fd29e4645c7f350dd385dd9ad


Masami Hiramatsu (Google) (2):
      tracing: fgraph: Fix to add new fgraph_ops to array after ftrace_startup_subops()
      tracing: Fix memory leak in fgraph storage selftest

Steven Rostedt (4):
      eventfs: Use list_del_rcu() for SRCU protected list variable
      tracing/osnoise: Use a cpumask to know what threads are kthreads
      tracing/timerlat: Only clear timer if a kthread exists
      tracing/timerlat: Add interface_lock around clearing of kthread in stop_kthread()

Zheng Yejian (1):
      tracing: Avoid possible softlockup in tracing_iter_reset()

----
 fs/tracefs/event_inode.c      |  2 +-
 kernel/trace/fgraph.c         | 31 ++++++++++++++++-----------
 kernel/trace/trace.c          |  2 ++
 kernel/trace/trace_osnoise.c  | 50 +++++++++++++++++++++++++++++--------------
 kernel/trace/trace_selftest.c | 23 +++++++++++++++-----
 5 files changed, 73 insertions(+), 35 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 01e99e98457d..8705c77a9e75 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -862,7 +862,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 	list_for_each_entry(ei_child, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
-	list_del(&ei->list);
+	list_del_rcu(&ei->list);
 	free_ei(ei);
 }
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d1d5ea2d0a1b..d7d4fb403f6f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1206,18 +1206,24 @@ static void init_task_vars(int idx)
 	read_unlock(&tasklist_lock);
 }
 
-static void ftrace_graph_enable_direct(bool enable_branch)
+static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *gops)
 {
 	trace_func_graph_ent_t func = NULL;
 	trace_func_graph_ret_t retfunc = NULL;
 	int i;
 
-	for_each_set_bit(i, &fgraph_array_bitmask,
-			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
-		func = fgraph_array[i]->entryfunc;
-		retfunc = fgraph_array[i]->retfunc;
-		fgraph_direct_gops = fgraph_array[i];
-	 }
+	if (gops) {
+		func = gops->entryfunc;
+		retfunc = gops->retfunc;
+		fgraph_direct_gops = gops;
+	} else {
+		for_each_set_bit(i, &fgraph_array_bitmask,
+				 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
+			func = fgraph_array[i]->entryfunc;
+			retfunc = fgraph_array[i]->retfunc;
+			fgraph_direct_gops = fgraph_array[i];
+		}
+	}
 	if (WARN_ON_ONCE(!func))
 		return;
 
@@ -1256,8 +1262,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ret = -ENOSPC;
 		goto out;
 	}
-
-	fgraph_array[i] = gops;
 	gops->idx = i;
 
 	ftrace_graph_active++;
@@ -1266,7 +1270,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_disable_direct(true);
 
 	if (ftrace_graph_active == 1) {
-		ftrace_graph_enable_direct(false);
+		ftrace_graph_enable_direct(false, gops);
 		register_pm_notifier(&ftrace_suspend_notifier);
 		ret = start_graph_tracing();
 		if (ret)
@@ -1281,14 +1285,15 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	} else {
 		init_task_vars(gops->idx);
 	}
-
 	/* Always save the function, and reset at unregistering */
 	gops->saved_func = gops->entryfunc;
 
 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
+	if (!ret)
+		fgraph_array[i] = gops;
+
 error:
 	if (ret) {
-		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
@@ -1324,7 +1329,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
 
 	if (ftrace_graph_active == 1)
-		ftrace_graph_enable_direct(true);
+		ftrace_graph_enable_direct(true, NULL);
 	else if (!ftrace_graph_active)
 		ftrace_graph_disable_direct(false);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebe7ce2f5f4a..edf6bc817aa1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3958,6 +3958,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..bbe47781617e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -252,6 +252,11 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
+/*
+ * Protect the interface.
+ */
+static struct mutex interface_lock;
+
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */
@@ -259,14 +264,20 @@ static inline void tlat_var_reset(void)
 {
 	struct timerlat_variables *tlat_var;
 	int cpu;
+
+	/* Synchronize with the timerlat interfaces */
+	mutex_lock(&interface_lock);
 	/*
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
 	for_each_cpu(cpu, cpu_online_mask) {
 		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+		if (tlat_var->kthread)
+			hrtimer_cancel(&tlat_var->timer);
 		memset(tlat_var, 0, sizeof(*tlat_var));
 	}
+	mutex_unlock(&interface_lock);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
 #define tlat_var_reset()	do {} while (0)
@@ -331,11 +342,6 @@ struct timerlat_sample {
 };
 #endif
 
-/*
- * Protect the interface.
- */
-static struct mutex interface_lock;
-
 /*
  * Tracer data.
  */
@@ -1612,6 +1618,7 @@ static int run_osnoise(void)
 
 static struct cpumask osnoise_cpumask;
 static struct cpumask save_cpumask;
+static struct cpumask kthread_cpumask;
 
 /*
  * osnoise_sleep - sleep until the next period
@@ -1675,6 +1682,7 @@ static inline int osnoise_migration_pending(void)
 	 */
 	mutex_lock(&interface_lock);
 	this_cpu_osn_var()->kthread = NULL;
+	cpumask_clear_cpu(smp_processor_id(), &kthread_cpumask);
 	mutex_unlock(&interface_lock);
 
 	return 1;
@@ -1945,11 +1953,16 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
+	mutex_lock(&interface_lock);
 	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
 	if (kthread) {
-		if (test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+		mutex_unlock(&interface_lock);
+
+		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
+		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
-		} else {
+		} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			/*
 			 * This is a user thread waiting on the timerlat_fd. We need
 			 * to close all users, and the best way to guarantee this is
@@ -1958,8 +1971,8 @@ static void stop_kthread(unsigned int cpu)
 			kill_pid(kthread->thread_pid, SIGKILL, 1);
 			put_task_struct(kthread);
 		}
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	} else {
+		mutex_unlock(&interface_lock);
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			/*
@@ -1967,7 +1980,6 @@ static void stop_kthread(unsigned int cpu)
 			 */
 			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
 			barrier();
-			return;
 		}
 	}
 }
@@ -1982,12 +1994,8 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	cpus_read_lock();
-
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		stop_kthread(cpu);
-
-	cpus_read_unlock();
 }
 
 /*
@@ -2021,6 +2029,7 @@ static int start_kthread(unsigned int cpu)
 	}
 
 	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+	cpumask_set_cpu(cpu, &kthread_cpumask);
 
 	return 0;
 }
@@ -2048,8 +2057,16 @@ static int start_per_cpu_kthreads(void)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, &osnoise_cpumask);
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
+		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
+			struct task_struct *kthread;
+
+			kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+			if (!WARN_ON(!kthread))
+				kthread_stop(kthread);
+		}
 		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+	}
 
 	for_each_cpu(cpu, current_mask) {
 		retval = start_kthread(cpu);
@@ -2579,7 +2596,8 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 
-	hrtimer_cancel(&tlat_var->timer);
+	if (tlat_var->kthread)
+		hrtimer_cancel(&tlat_var->timer);
 	memset(tlat_var, 0, sizeof(*tlat_var));
 
 	osn_var->sampling = 0;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 97f1e4bc47dc..c4ad7cd7e778 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -942,7 +942,7 @@ static __init int test_graph_storage_multi(void)
 {
 	struct fgraph_fixture *fixture;
 	bool printed = false;
-	int i, ret;
+	int i, j, ret;
 
 	pr_cont("PASSED\n");
 	pr_info("Testing multiple fgraph storage on a function: ");
@@ -953,22 +953,35 @@ static __init int test_graph_storage_multi(void)
 		if (ret && ret != -ENODEV) {
 			pr_cont("*Could not set filter* ");
 			printed = true;
-			goto out;
+			goto out2;
 		}
+	}
 
+	for (j = 0; j < ARRAY_SIZE(store_bytes); j++) {
+		fixture = &store_bytes[j];
 		ret = register_ftrace_graph(&fixture->gops);
 		if (ret) {
 			pr_warn("Failed to init store_bytes fgraph tracing\n");
 			printed = true;
-			goto out;
+			goto out1;
 		}
 	}
 
 	DYN_FTRACE_TEST_NAME();
-out:
+out1:
+	while (--j >= 0) {
+		fixture = &store_bytes[j];
+		unregister_ftrace_graph(&fixture->gops);
+
+		if (fixture->error_str && !printed) {
+			pr_cont("*** %s ***", fixture->error_str);
+			printed = true;
+		}
+	}
+out2:
 	while (--i >= 0) {
 		fixture = &store_bytes[i];
-		unregister_ftrace_graph(&fixture->gops);
+		ftrace_free_filter(&fixture->gops.ops);
 
 		if (fixture->error_str && !printed) {
 			pr_cont("*** %s ***", fixture->error_str);


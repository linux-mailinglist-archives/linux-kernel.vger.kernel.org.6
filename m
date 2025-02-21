Return-Path: <linux-kernel+bounces-526767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34BDA402F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410033B7884
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E192512DB;
	Fri, 21 Feb 2025 22:42:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D752397BF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177742; cv=none; b=gF5YbEyK0/gSjC6cOnwtx8CWSo2iGQOorMwjoBx96GZrQPYg20giKeCa82AOAGK8kyW2/bU1fNec6WamHaM8aLsaKuNxCk3UwF2Hvx4MbQlkPnYIoqix4Ou5hKWQD+a0BuDDvS7aePXQq9kEnqXGX42Z/2DHej0UbyaGZ7akKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177742; c=relaxed/simple;
	bh=K+8ZvBtI8/hb7LWXpDO3LCl8qLMhq/YGHqsWZzQtWIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t7/2LZdD//aOUyUXC1jHPFf/HBa7p8+SIdpfnBSIkVMZPvZDptOjVwutZjYuAqkbdPbNXkMX4F1PYqfxqA6X6YwxrnWoP4JFG3IZyirBVJZknOU6WEdfKEbl4LgtlT52kV1YZCm8yKVg1BUAbiW/F0KLhoc+Vf7PF4uNIBmgrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC29C4CED6;
	Fri, 21 Feb 2025 22:42:20 +0000 (UTC)
Date: Fri, 21 Feb 2025 17:42:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Adrian Huang
 <ahuang12@lenovo.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Heiko Carstens <hca@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: [GIT PULL] ftrace: Fixes for v6.14
Message-ID: <20250221174250.31f75672@gandalf.local.home>
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

tracing fixes for v6.14:

Function graph accounting fixes:

- Fix the manage ops hashes

  The function graph registers a "manager ops" and "sub-ops" to ftrace.
  The manager ops does not have any callback but calls the sub-ops
  callbacks. The manage ops hashes (what is used to tell ftrace what
  functions to attach to) is built on the sub-ops it manages.

  There was an error in the way it built the hash. An empty hash means to
  attach to all functions. When the manager ops had one sub-ops it properly
  copied its hash. But when the manager ops had more than one sub-ops, it
  went into a loop to make a set of all functions it needed to add to the
  hash. If any of the subops hashes was empty, that would mean to attach
  to all functions. The error was that the first iteration of the loop
  passed in an empty hash to start with in order to add the other hashes.
  That starting hash was mistaken as to attach to all functions. This made
  the manage ops attach to all functions whenever it had two or more
  sub-ops, even if each sub-op was attached to only a single function.

- Do not add duplicate entries to the manager ops hash

  If two or more subops hashes trace the same function, an entry for that
  function will be added to the manager ops for each subops. This causes
  waste and extra overhead.

Fprobe accounting fixes:

- Remove last function from fprobe hash

  Fprobes has a ftrace hash to manage which functions an fprobe is attached
  to. It also has a counter of how many fprobes are attached. When the last
  fprobe is removed, it unregisters the fprobe from ftrace but does not
  remove the functions the last fprobe was attached to from the hash. This
  leaves the old functions attached. When a new fprobe is added, the fprobe
  infrastructure attaches to not only the functions of the new fprobe, but
  also to the functions of the last fprobe.

- Fix accounting of the fprobe counter

  When a fprobe is added, it updates a counter. If the counter goes from
  zero to one, it attaches its ops to ftrace. When an fprobe is removed, the
  counter is decremented. If the counter goes from 1 to zero, it removes the
  fprobes ops from ftrace. There was an issue where if two fprobes trace the
  same function, the addition of each fprobe would increment the counter.
  But when removing the first of the fprobes, it would notice that another
  fprobe is still attached to one of its functions no it does not remove
  the functions from the ftrace ops. But it also did not decrement the
  counter. When the last fprobe is removed, the counter is still one. This
  leaves the fprobes callback still registered with ftrace and it being
  called by the functions defined by the fprobes ops hash.  Worse yet,
  because all the functions from the fprobe ops hash have been removed, that
  tells ftrace that it wants to trace all functions. Thus, this puts the
  state of the system where every function is calling the fprobe callback
  handler (which does nothing as there are no registered fprobes), but this
  causes a good 13% slow down of the entire system.

Other updates:

- Add a selftest to test the above issues to prevent regressions.

- Fix preempt count accounting in function tracing

  Better recursion protection was added to function tracing which added
  another layer of preempt disable. As the preempt_count gets traced in the
  event, it needs to subtract the amount of preempt disabling the tracer
  does to record what the preempt_count was when the trace was triggered.

- Fix memory leak in output of set_event

  A variable is passed by the seq_file functions in the location that is
  set by the return of the next() function. The start() function allocates
  it and the stop() function frees it. But when the last item is found, the
  next() returns NULL which leaks the data that was allocated in start().
  The m->private is used for something else, so have next() free the data
  when it returns NULL, as stop() will then just receive NULL in that case.


Please pull the latest ftrace-v6.14-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.14-rc3

Tag SHA1: 328c196f09179d2b010a8d4ef93dedca84f2783f
Head SHA1: 2fa6a01345b538faa7b0fae8f723bb6977312428


Adrian Huang (1):
      tracing: Fix memory leak when reading set_event file

Sebastian Andrzej Siewior (1):
      ftrace: Correct preemption accounting for function tracing.

Steven Rostedt (5):
      ftrace: Fix accounting of adding subops to a manager ops
      ftrace: Do not add duplicate entries in subops manager ops
      fprobe: Always unregister fgraph function from ops
      fprobe: Fix accounting of when to unregister from function graph
      selftests/ftrace: Update fprobe test to check enabled_functions file

----
 kernel/trace/fprobe.c                              | 12 ++---
 kernel/trace/ftrace.c                              | 36 ++++++++++-----
 kernel/trace/trace_events.c                        | 11 ++++-
 kernel/trace/trace_functions.c                     |  6 +--
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    | 54 ++++++++++++++++++++++
 5 files changed, 95 insertions(+), 24 deletions(-)
---------------------------
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 2560b312ad57..33082c4e8154 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -403,13 +403,12 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 	lockdep_assert_held(&fprobe_mutex);
 
 	fprobe_graph_active--;
-	if (!fprobe_graph_active) {
-		/* Q: should we unregister it ? */
+	/* Q: should we unregister it ? */
+	if (!fprobe_graph_active)
 		unregister_ftrace_graph(&fprobe_graph_ops);
-		return;
-	}
 
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
+	if (num)
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
 
 static int symbols_cmp(const void *a, const void *b)
@@ -679,8 +678,7 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	if (count)
-		fprobe_graph_remove_ips(addrs, count);
+	fprobe_graph_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 728ecda6e8d4..6b0c25761ccb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3220,15 +3220,22 @@ static struct ftrace_hash *copy_hash(struct ftrace_hash *src)
  *  The filter_hash updates uses just the append_hash() function
  *  and the notrace_hash does not.
  */
-static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
+static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash,
+		       int size_bits)
 {
 	struct ftrace_func_entry *entry;
 	int size;
 	int i;
 
-	/* An empty hash does everything */
-	if (ftrace_hash_empty(*hash))
-		return 0;
+	if (*hash) {
+		/* An empty hash does everything */
+		if (ftrace_hash_empty(*hash))
+			return 0;
+	} else {
+		*hash = alloc_ftrace_hash(size_bits);
+		if (!*hash)
+			return -ENOMEM;
+	}
 
 	/* If new_hash has everything make hash have everything */
 	if (ftrace_hash_empty(new_hash)) {
@@ -3292,16 +3299,18 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
 /* Return a new hash that has a union of all @ops->filter_hash entries */
 static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
 {
-	struct ftrace_hash *new_hash;
+	struct ftrace_hash *new_hash = NULL;
 	struct ftrace_ops *subops;
+	int size_bits;
 	int ret;
 
-	new_hash = alloc_ftrace_hash(ops->func_hash->filter_hash->size_bits);
-	if (!new_hash)
-		return NULL;
+	if (ops->func_hash->filter_hash)
+		size_bits = ops->func_hash->filter_hash->size_bits;
+	else
+		size_bits = FTRACE_HASH_DEFAULT_BITS;
 
 	list_for_each_entry(subops, &ops->subop_list, list) {
-		ret = append_hash(&new_hash, subops->func_hash->filter_hash);
+		ret = append_hash(&new_hash, subops->func_hash->filter_hash, size_bits);
 		if (ret < 0) {
 			free_ftrace_hash(new_hash);
 			return NULL;
@@ -3310,7 +3319,8 @@ static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
 		if (ftrace_hash_empty(new_hash))
 			break;
 	}
-	return new_hash;
+	/* Can't return NULL as that means this failed */
+	return new_hash ? : EMPTY_HASH;
 }
 
 /* Make @ops trace evenything except what all its subops do not trace */
@@ -3505,7 +3515,8 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 		filter_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->filter_hash);
 		if (!filter_hash)
 			return -ENOMEM;
-		ret = append_hash(&filter_hash, subops->func_hash->filter_hash);
+		ret = append_hash(&filter_hash, subops->func_hash->filter_hash,
+				  size_bits);
 		if (ret < 0) {
 			free_ftrace_hash(filter_hash);
 			return ret;
@@ -5707,6 +5718,9 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 			return -ENOENT;
 		free_hash_entry(hash, entry);
 		return 0;
+	} else if (__ftrace_lookup_ip(hash, ip) != NULL) {
+		/* Already exists */
+		return 0;
 	}
 
 	entry = add_hash_entry(hash, ip);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4cb275316e51..513de9ceb80e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1591,6 +1591,13 @@ s_next(struct seq_file *m, void *v, loff_t *pos)
 		return iter;
 #endif
 
+	/*
+	 * The iter is allocated in s_start() and passed via the 'v'
+	 * parameter. To stop the iterator, NULL must be returned. But
+	 * the return value is what the 'v' parameter in s_stop() receives
+	 * and frees. Free iter here as it will no longer be used.
+	 */
+	kfree(iter);
 	return NULL;
 }
 
@@ -1667,9 +1674,9 @@ static int s_show(struct seq_file *m, void *v)
 }
 #endif
 
-static void s_stop(struct seq_file *m, void *p)
+static void s_stop(struct seq_file *m, void *v)
 {
-	kfree(p);
+	kfree(v);
 	t_stop(m, NULL);
 }
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index d358c9935164..df56f9b76010 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -216,7 +216,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	parent_ip = function_get_true_parent_ip(parent_ip, fregs);
 
-	trace_ctx = tracing_gen_ctx();
+	trace_ctx = tracing_gen_ctx_dec();
 
 	data = this_cpu_ptr(tr->array_buffer.data);
 	if (!atomic_read(&data->disabled))
@@ -321,7 +321,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
-	unsigned long flags;
 	int bit;
 
 	if (unlikely(!tr->function_enabled))
@@ -347,8 +346,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (is_repeat_check(tr, last_info, ip, parent_ip))
 		goto out;
 
-	local_save_flags(flags);
-	trace_ctx = tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_dec();
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
 	trace_function(tr, ip, parent_ip, trace_ctx);
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index dc25bcf4f9e2..449f9d8be746 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -7,12 +7,38 @@ echo 0 > events/enable
 echo > dynamic_events
 
 PLACE=$FUNCTION_FORK
+PLACE2="kmem_cache_free"
+PLACE3="schedule_timeout"
 
 echo "f:myevent1 $PLACE" >> dynamic_events
+
+# Make sure the event is attached and is the only one
+grep -q $PLACE enabled_functions
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
 echo "f:myevent2 $PLACE%return" >> dynamic_events
 
+# It should till be the only attached function
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
+# add another event
+echo "f:myevent3 $PLACE2" >> dynamic_events
+
+grep -q $PLACE2 enabled_functions
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 2 ]; then
+	exit_fail
+fi
+
 grep -q myevent1 dynamic_events
 grep -q myevent2 dynamic_events
+grep -q myevent3 dynamic_events
 test -d events/fprobes/myevent1
 test -d events/fprobes/myevent2
 
@@ -21,6 +47,34 @@ echo "-:myevent2" >> dynamic_events
 grep -q myevent1 dynamic_events
 ! grep -q myevent2 dynamic_events
 
+# should still have 2 left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 2 ]; then
+	exit_fail
+fi
+
 echo > dynamic_events
 
+# Should have none left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 0 ]; then
+	exit_fail
+fi
+
+echo "f:myevent4 $PLACE" >> dynamic_events
+
+# Should only have one enabled
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
+echo > dynamic_events
+
+# Should have none left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 0 ]; then
+	exit_fail
+fi
+
 clear_trace


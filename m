Return-Path: <linux-kernel+bounces-181279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4B8C79D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECB4B22005
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5614D446;
	Thu, 16 May 2024 15:54:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2A14D431
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874891; cv=none; b=MZ+HqMvob33WD0XS87hA5O+MAfJddjAcQc4urXSgMAv8TmQ/jTFmd72HyMw7M7msHoOyLxlPQe2jbNKDsQmIZ8H+RNYVtXzPSJ6vlEZjcSPkZGfn5YFitiYxrH74HjeWTLpOMEPPZZTewrkq62Yx+RK/jsbfqfo/IZyIkYlEx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874891; c=relaxed/simple;
	bh=FOSXC2Q65VEvriAMezp3gL0yOoXg0gtxq3K2dr9Ma/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=F8kcs0JLvhnAheC4jVfPCetzUA/IMizWdKMw0/OYvUSloahm6U2uyia8HYQRh8HJ1MePYrYhDTGRgVEMjdnUst/fSKdiErYat3/Ptaczv2Ub8bGMYXry/DMHB+N8jBph3K8RLqZO6NPgBfhSpAKTnzV1K92u12SvIAwgLxu1OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9CDC113CC;
	Thu, 16 May 2024 15:54:50 +0000 (UTC)
Date: Thu, 16 May 2024 11:54:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Hao Ge <gehao@kylinos.cn>, "Paul E. McKenney"
 <paulmck@kernel.org>, Thorsten Blum <thorsten.blum@toblux.com>, Yuran
 Pereira <yuran.pereira@hotmail.com>, Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Cleanups for v6.10
Message-ID: <20240516115449.32d6f2b0@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

tracing cleanups for v6.10:

- Removed unused ftrace_direct_funcs variables

- Fix a possible NULL pointer dereference race in eventfs

- Update do_div() usage in trace event benchmark test

- Speedup direct function registration with asynchronous RCU callback.
  The synchronization was done in the registration code and this
  caused delays when registering direct callbacks. Move the freeing
  to a call_rcu() that will prevent delaying of the registering.

- Replace simple_strtoul() usage with kstrtoul()


Please pull the latest trace-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.10

Tag SHA1: 7cb6620f9a48fbdda06bc070c3e6270a39edc76a
Head SHA1: d4e9a968738bf66d3bb852dd5588d4c7afd6d7f4


Dr. David Alan Gilbert (2):
      ftrace: Remove unused list 'ftrace_direct_funcs'
      ftrace: Remove unused global 'ftrace_direct_func_count'

Hao Ge (1):
      eventfs: Fix a possible null pointer dereference in eventfs_find_events()

Paul E. McKenney (1):
      ftrace: Use asynchronous grace period for register_ftrace_direct()

Thorsten Blum (1):
      tracing: Improve benchmark test performance by using do_div()

Yuran Pereira (1):
      ftrace: Replaces simple_strtoul in ftrace

Zheng Yejian (1):
      ftrace: Fix possible use-after-free issue in ftrace_location()

----
 fs/tracefs/event_inode.c       |  7 ++---
 include/linux/ftrace.h         |  3 --
 kernel/trace/fgraph.c          | 11 -------
 kernel/trace/ftrace.c          | 68 ++++++++++++++++++++++--------------------
 kernel/trace/trace_benchmark.c |  2 +-
 5 files changed, 39 insertions(+), 52 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a878cea70f4c..0256afdd4acf 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -345,10 +345,9 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		 * If the ei is being freed, the ownership of the children
 		 * doesn't matter.
 		 */
-		if (ei->is_freed) {
-			ei = NULL;
-			break;
-		}
+		if (ei->is_freed)
+			return NULL;
+
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..e3a83ebd1b33 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -83,7 +83,6 @@ static inline void early_trace_init(void) { }
 
 struct module;
 struct ftrace_hash;
-struct ftrace_direct_func;
 
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
 	defined(CONFIG_DYNAMIC_FTRACE)
@@ -414,7 +413,6 @@ struct ftrace_func_entry {
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-extern int ftrace_direct_func_count;
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
@@ -426,7 +424,6 @@ void ftrace_stub_direct_tramp(void);
 
 #else
 struct ftrace_ops;
-# define ftrace_direct_func_count 0
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c83c005e654e..a130b2d898f7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -125,17 +125,6 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 {
 	struct ftrace_graph_ent trace;
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-	/*
-	 * Skip graph tracing if the return location is served by direct trampoline,
-	 * since call sequence and return addresses are unpredictable anyway.
-	 * Ex: BPF trampoline may call original function and may skip frame
-	 * depending on type of BPF programs attached.
-	 */
-	if (ftrace_direct_func_count &&
-	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
-		return -EBUSY;
-#endif
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..2308c0a2fd29 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1595,12 +1595,15 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct dyn_ftrace *rec;
+	unsigned long ip = 0;
 
+	rcu_read_lock();
 	rec = lookup_rec(start, end);
 	if (rec)
-		return rec->ip;
+		ip = rec->ip;
+	rcu_read_unlock();
 
-	return 0;
+	return ip;
 }
 
 /**
@@ -1614,25 +1617,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	struct dyn_ftrace *rec;
+	unsigned long loc;
 	unsigned long offset;
 	unsigned long size;
 
-	rec = lookup_rec(ip, ip);
-	if (!rec) {
+	loc = ftrace_location_range(ip, ip);
+	if (!loc) {
 		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
 			goto out;
 
 		/* map sym+0 to __fentry__ */
 		if (!offset)
-			rec = lookup_rec(ip, ip + size - 1);
+			loc = ftrace_location_range(ip, ip + size - 1);
 	}
 
-	if (rec)
-		return rec->ip;
-
 out:
-	return 0;
+	return loc;
 }
 
 /**
@@ -2538,7 +2538,6 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
 static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
-int ftrace_direct_func_count;
 
 /*
  * Search the direct_functions hash to see if the given instruction pointer
@@ -4202,12 +4201,12 @@ static int
 add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 		 int clear_filter)
 {
-	long index = simple_strtoul(func_g->search, NULL, 0);
+	long index;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 
 	/* The index starts at 1 */
-	if (--index < 0)
+	if (kstrtoul(func_g->search, 0, &index) || --index < 0)
 		return 0;
 
 	do_for_each_ftrace_rec(pg, rec) {
@@ -5318,14 +5317,6 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long *ips, unsigned int cnt,
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
-struct ftrace_direct_func {
-	struct list_head	next;
-	unsigned long		addr;
-	int			count;
-};
-
-static LIST_HEAD(ftrace_direct_funcs);
-
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
 /*
@@ -5366,6 +5357,13 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 	}
 }
 
+static void register_ftrace_direct_cb(struct rcu_head *rhp)
+{
+	struct ftrace_hash *fhp = container_of(rhp, struct ftrace_hash, rcu);
+
+	free_ftrace_hash(fhp);
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
@@ -5464,10 +5462,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-	if (free_hash && free_hash != EMPTY_HASH) {
-		synchronize_rcu_tasks();
-		free_ftrace_hash(free_hash);
-	}
+	if (free_hash && free_hash != EMPTY_HASH)
+		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
 
 	if (new_hash)
 		free_ftrace_hash(new_hash);
@@ -5817,9 +5813,8 @@ __setup("ftrace_graph_notrace=", set_graph_notrace_function);
 
 static int __init set_graph_max_depth_function(char *str)
 {
-	if (!str)
+	if (!str || kstrtouint(str, 0, &fgraph_max_depth))
 		return 0;
-	fgraph_max_depth = simple_strtoul(str, NULL, 0);
 	return 1;
 }
 __setup("ftrace_graph_max_depth=", set_graph_max_depth_function);
@@ -6596,6 +6591,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6809,6 +6806,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -7142,6 +7142,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -7183,12 +7184,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			if (pg->records) {
-				free_pages((unsigned long)pg->records, pg->order);
-				ftrace_number_of_pages -= 1 << pg->order;
-			}
-			ftrace_number_of_groups--;
-			kfree(pg);
+			pg->next = tmp_page;
+			tmp_page = pg;
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
 				ftrace_pages = pg;
@@ -7205,6 +7202,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 811b08439406..e19c32f2a938 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -104,7 +104,7 @@ static void trace_do_benchmark(void)
 		stddev = 0;
 
 	delta = bm_total;
-	delta = div64_u64(delta, bm_cnt);
+	do_div(delta, (u32)bm_cnt);
 	avg = delta;
 
 	if (stddev > 0) {


Return-Path: <linux-kernel+bounces-293361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1698957E43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AAB2033D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E418C03D;
	Tue, 20 Aug 2024 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/1TiSY1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eMNvutIs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581A1E212E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135422; cv=none; b=l64Ttp20/ataHhFN53EvMGa4afnYzOmcgHkG9++QgaHQ6uq8xQi8hxLgRvBnOt0VzFCqo8V2Tj9o3nM2Fc0Q6eNBD4dHnv7nXjEV+39Ta3py7gLn7ZowzEuzg0ZrbGEVXIWN8VamHrpxj4Cm3Ahg8OKdcztqUA4khp84N8ZZl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135422; c=relaxed/simple;
	bh=4OdqDdNHwI+MpNe3A4JuCxp3X0/uGKJmw+4fmyl14ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoCAOZnwnBTYcNZvTc/9xkmA95Nf06H37IPVHly4g6HoFBKkK8zUSdWVQz/qReQFnSpI16hGUmY8bTEUaA0ITO1PJUec+nGytgJen1RmC6g/L9Qs+DB+5Y69h2L+7svb13euiJD/E8T8h5XKYUk7lnGmQ/IZ58MQsfsWWUKn4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/1TiSY1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eMNvutIs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbnnfoXadhhBBS7uyzhVWkZWyR3EDchUa4vB6qOLFEY=;
	b=2/1TiSY1ohK5a9UBg2EJev/tO4qdrmRYHyXTFHypYCM/MffBGLC3Pr0vSOfx5N25oJgf5K
	oadcaO6bD6iMw1q6O3UqJnF1eyfIPk1mcYJ34EUa2qdBzmfmTkkfjXqvJynpFaE2KbqEPA
	qSP2JpnTQMNfZouQdcEjhX2tqTThZrkOrNvWm/c/yBjlgbuI0NfWOTA83+7xXXC5TwCCEl
	acjiLCHCW4FALArQMmiAOSTv+pkE/vPMnCvz4dw/yZK9YBEY5JpPEfuDY1J83XWgng6sps
	s4Otu/8H+VEKE9QpFybyv7LIx+HOn6dEktDJEZIfrTr/C1wPHi5WqZi+Kz2jWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbnnfoXadhhBBS7uyzhVWkZWyR3EDchUa4vB6qOLFEY=;
	b=eMNvutIs0MAoouyJ2D5Q9wZVh4+2YFq69pgkBGpgjblSar2Mk/ra8nXWvkIzczKNisMG8Y
	1qGboxPg942cE0Dg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH printk v8 35/35] lockdep: Mark emergency sections in lockdep splats
Date: Tue, 20 Aug 2024 08:36:01 +0206
Message-Id: <20240820063001.36405-36-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark emergency sections wherever multiple lines of
lock debugging output are generated. In an emergency
section, every printk() call will attempt to directly
flush to the consoles using the EMERGENCY priority.

Note that debug_show_all_locks() and
lockdep_print_held_locks() rely on their callers to
enter the emergency section. This is because these
functions can also be called in non-emergency
situations (such as sysrq).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/locking/lockdep.c | 83 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 58c88220a478..fea538f7d131 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -56,6 +56,7 @@
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
+#include <linux/console.h>
 
 #include <asm/sections.h>
 
@@ -573,8 +574,10 @@ static struct lock_trace *save_trace(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return NULL;
 	}
@@ -887,11 +890,13 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
 		instrumentation_begin();
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		printk(KERN_ERR
 			"BUG: looking up invalid subclass: %u\n", subclass);
 		printk(KERN_ERR
 			"turning off the locking correctness validator.\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		instrumentation_end();
 		return NULL;
 	}
@@ -968,11 +973,13 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	else {
 		/* Debug-check: all keys must be persistent! */
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		pr_err("INFO: trying to register non-static key.\n");
 		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
 		pr_err("you didn't initialize this object before use?\n");
 		pr_err("turning off the locking correctness validator.\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return false;
 	}
 
@@ -1316,8 +1323,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			return NULL;
 		}
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_lock_classes++;
@@ -1349,11 +1358,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (verbose(class)) {
 		graph_unlock();
 
+		nbcon_cpu_emergency_enter();
 		printk("\nnew class %px: %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		if (!graph_lock()) {
 			return NULL;
@@ -1392,8 +1403,10 @@ static struct lock_list *alloc_list_entry(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_list_entries++;
@@ -2039,6 +2052,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	depth = get_lock_depth(target);
 
+	nbcon_cpu_emergency_enter();
+
 	print_circular_bug_header(target, depth, check_src, check_tgt);
 
 	parent = get_lock_parent(target);
@@ -2057,6 +2072,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinline void print_bfs_bug(int ret)
@@ -2569,6 +2586,8 @@ print_bad_irq_dependency(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
 	pr_warn("WARNING: %s-safe -> %s-unsafe lock order detected\n",
@@ -2618,11 +2637,13 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
 	next_root->trace = save_trace();
 	if (!next_root->trace)
-		return;
+		goto out;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+out:
+	nbcon_cpu_emergency_exit();
 }
 
 static const char *state_names[] = {
@@ -2987,6 +3008,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================================\n");
 	pr_warn("WARNING: possible recursive locking detected\n");
@@ -3009,6 +3032,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -3606,6 +3631,8 @@ static void print_collision(struct task_struct *curr,
 			struct held_lock *hlock_next,
 			struct lock_chain *chain)
 {
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================\n");
 	pr_warn("WARNING: chain_key collision\n");
@@ -3622,6 +3649,8 @@ static void print_collision(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 #endif
 
@@ -3712,8 +3741,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 	chain->chain_key = chain_key;
@@ -3730,8 +3761,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 
@@ -3970,6 +4003,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	if (!debug_locks_off() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("================================\n");
 	pr_warn("WARNING: inconsistent lock state\n");
@@ -3998,6 +4033,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -4032,6 +4069,8 @@ print_irq_inversion_bug(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("========================================================\n");
 	pr_warn("WARNING: possible irq lock inversion dependency detected\n");
@@ -4072,11 +4111,13 @@ print_irq_inversion_bug(struct task_struct *curr,
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
 	root->trace = save_trace();
 	if (!root->trace)
-		return;
+		goto out;
 	print_shortest_lock_dependencies(other, root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+out:
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -4153,6 +4194,8 @@ void print_irqtrace_events(struct task_struct *curr)
 {
 	const struct irqtrace_events *trace = &curr->irqtrace;
 
+	nbcon_cpu_emergency_enter();
+
 	printk("irq event stamp: %u\n", trace->irq_events);
 	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
 		trace->hardirq_enable_event, (void *)trace->hardirq_enable_ip,
@@ -4166,6 +4209,8 @@ void print_irqtrace_events(struct task_struct *curr)
 	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
 		trace->softirq_disable_event, (void *)trace->softirq_disable_ip,
 		(void *)trace->softirq_disable_ip);
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int HARDIRQ_verbose(struct lock_class *class)
@@ -4686,10 +4731,12 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
+		nbcon_cpu_emergency_enter();
 		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 	}
 
 	return ret;
@@ -4730,6 +4777,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	if (debug_locks_silent)
 		return 0;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("[ BUG: Invalid wait context ]\n");
@@ -4749,6 +4798,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	pr_warn("stack backtrace:\n");
 	dump_stack();
 
+	nbcon_cpu_emergency_exit();
+
 	return 0;
 }
 
@@ -4956,6 +5007,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("==================================\n");
 	pr_warn("WARNING: Nested lock was not taken\n");
@@ -4976,6 +5029,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -5024,11 +5079,13 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	debug_class_ops_inc(class);
 
 	if (very_verbose(class)) {
+		nbcon_cpu_emergency_enter();
 		printk("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk(KERN_CONT "#%d", class->name_version);
 		printk(KERN_CONT "\n");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 	}
 
 	/*
@@ -5155,6 +5212,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCK_DEPTH too low!");
 		printk(KERN_DEBUG "depth: %i  max: %lu!\n",
 		       curr->lockdep_depth, MAX_LOCK_DEPTH);
@@ -5162,6 +5220,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		lockdep_print_held_locks(current);
 		debug_show_all_locks();
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return 0;
 	}
@@ -5181,6 +5240,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================\n");
 	pr_warn("WARNING: bad unlock balance detected!\n");
@@ -5197,6 +5258,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinstr int match_held_lock(const struct held_lock *hlock,
@@ -5901,6 +5964,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=================================\n");
 	pr_warn("WARNING: bad contention detected!\n");
@@ -5917,6 +5982,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static void
@@ -6530,6 +6597,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=========================\n");
 	pr_warn("WARNING: held lock freed!\n");
@@ -6542,6 +6611,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static inline int not_in_range(const void* mem_from, unsigned long mem_len,
@@ -6588,6 +6659,8 @@ static void print_held_locks_bug(void)
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("====================================\n");
 	pr_warn("WARNING: %s/%d still has locks held!\n",
@@ -6597,6 +6670,8 @@ static void print_held_locks_bug(void)
 	lockdep_print_held_locks(current);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 void debug_check_no_locks_held(void)
@@ -6654,6 +6729,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 	if (unlikely(curr->lockdep_depth)) {
 		if (!debug_locks_off())
 			return;
+		nbcon_cpu_emergency_enter();
 		pr_warn("\n");
 		pr_warn("================================================\n");
 		pr_warn("WARNING: lock held when returning to user space!\n");
@@ -6662,6 +6738,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 		pr_warn("%s/%d is leaving the kernel with locks still held!\n",
 				curr->comm, curr->pid);
 		lockdep_print_held_locks(curr);
+		nbcon_cpu_emergency_exit();
 	}
 
 	/*
@@ -6678,6 +6755,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	bool rcu = warn_rcu_enter();
 
 	/* Note: the following can be executed concurrently, so be careful. */
+	nbcon_cpu_emergency_enter();
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("WARNING: suspicious RCU usage\n");
@@ -6716,6 +6794,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	lockdep_print_held_locks(curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	nbcon_cpu_emergency_exit();
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
-- 
2.39.2



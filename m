Return-Path: <linux-kernel+bounces-190104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60D8CF970
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331AE1C20C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3913DB9C;
	Mon, 27 May 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQmCRvk4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ANQSGG5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F56413AD38
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791912; cv=none; b=G5KBE5HsKXrfm4dQSsOSdPRrFq2jhxuLAAcDUAsQjA3UevIcx14NAXX/madzgzU8/epJ0DzxSPVgCKRkSftTih9lZkko8yHr2wlDuYaQtI7lWjtDow17dKttF/82ccFY/m2OutVwp/uFBYGaTuM9xQk9oZvdryRGu47y1+RBpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791912; c=relaxed/simple;
	bh=1wETrd3QxZa6JEiWlFQIO6yl4IUpd7BYzrr49ZMy5YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sj8s6FROcGWcx7EPML661MAvqo9ZS+sJ6//L5SEPFAl98O/tQQxzytFkjJBmsMUS2sV9ejF3ZDFucwflP70kK+fjguCRJfXc4gqZlys9HoCMfgu78ZMkx18ZShrno3nd5hDsdhS8RezufF0JuKE6U84EHMpvKFUoL2ARg+RLKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQmCRvk4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ANQSGG5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+B1JLU7pRhvX/0oEMOhFW5PTzAmUDHfmWDy1oIGKPw=;
	b=cQmCRvk4KeDK0w3+Ymyc6U5m2VHtvUCVCVmuYNU4nsbZH8Qc14kfEq4A2i7pkxBF/LJd02
	ZnYI7OB64yzK3pWm0B2K4WTfrJ/+gqgvIGCUxvpwvoQ+gicQR/5ikL9I4p/aLeJZP3qJtW
	R8OUNAjIb5stoa5ic0zj2JU/OXv+gyGO8yyr6FR69PC7S0OUKATH1CZLo7K7XT8/TY1tAB
	0NhRcQ2g+B5FMkF+44ql3drQzGM8HYGTS6Y7GlLYUJiXj7QZbeLaBq4Q+JP+psmp1t0fMg
	lPD1CNsDdvVKBCH38ZVB0LcQ+1kDoMOcYBl/TMJEl/8ErzVF+aiHrpYgiSME1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+B1JLU7pRhvX/0oEMOhFW5PTzAmUDHfmWDy1oIGKPw=;
	b=4ANQSGG5OHfl40p35WBdEPDpZBa1BbQpxePPpMV1fi6uEXQF5v2lU4v9KCjtBBE+4zvuQx
	5oyZ4ZHR2dobNHDA==
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
Subject: [PATCH printk v6 30/30] lockdep: Mark emergency sections in lockdep splats
Date: Mon, 27 May 2024 08:43:49 +0206
Message-Id: <20240527063749.391035-31-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark emergency sections wherever multiple lines of
lock debugging output are generated. In an emergency
section the CPU will not perform console output for the
printk() calls. Instead, a flushing of the console
output is triggered when exiting the emergency section.
This allows the full message block to be stored as
quickly as possible in the ringbuffer.

Note that debug_show_all_locks() and
lockdep_print_held_locks() rely on their callers to
enter the emergency section. This is because these
functions can also be called in non-emergency
situations (such as sysrq).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/locking/lockdep.c | 84 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..c06842e037d8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -56,6 +56,7 @@
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
+#include <linux/console.h>
 
 #include <asm/sections.h>
 
@@ -574,8 +575,10 @@ static struct lock_trace *save_trace(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return NULL;
 	}
@@ -888,11 +891,13 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
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
@@ -969,11 +974,13 @@ static bool assign_lock_key(struct lockdep_map *lock)
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
 
@@ -1317,8 +1324,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			return NULL;
 		}
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_lock_classes++;
@@ -1350,11 +1359,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
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
@@ -1393,8 +1404,10 @@ static struct lock_list *alloc_list_entry(void)
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return NULL;
 	}
 	nr_list_entries++;
@@ -2040,6 +2053,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	depth = get_lock_depth(target);
 
+	nbcon_cpu_emergency_enter();
+
 	print_circular_bug_header(target, depth, check_src, check_tgt);
 
 	parent = get_lock_parent(target);
@@ -2058,6 +2073,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinline void print_bfs_bug(int ret)
@@ -2570,6 +2587,8 @@ print_bad_irq_dependency(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
 	pr_warn("WARNING: %s-safe -> %s-unsafe lock order detected\n",
@@ -2619,11 +2638,13 @@ print_bad_irq_dependency(struct task_struct *curr,
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
@@ -2988,6 +3009,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================================\n");
 	pr_warn("WARNING: possible recursive locking detected\n");
@@ -3010,6 +3033,8 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -3607,6 +3632,8 @@ static void print_collision(struct task_struct *curr,
 			struct held_lock *hlock_next,
 			struct lock_chain *chain)
 {
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("============================\n");
 	pr_warn("WARNING: chain_key collision\n");
@@ -3623,6 +3650,8 @@ static void print_collision(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 #endif
 
@@ -3713,8 +3742,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 	chain->chain_key = chain_key;
@@ -3731,8 +3762,10 @@ static inline int add_chain_cache(struct task_struct *curr,
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 		return 0;
 	}
 
@@ -3971,6 +4004,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	if (!debug_locks_off() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("================================\n");
 	pr_warn("WARNING: inconsistent lock state\n");
@@ -3999,6 +4034,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
@@ -4033,6 +4070,8 @@ print_irq_inversion_bug(struct task_struct *curr,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("========================================================\n");
 	pr_warn("WARNING: possible irq lock inversion dependency detected\n");
@@ -4073,11 +4112,13 @@ print_irq_inversion_bug(struct task_struct *curr,
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
@@ -4154,6 +4195,8 @@ void print_irqtrace_events(struct task_struct *curr)
 {
 	const struct irqtrace_events *trace = &curr->irqtrace;
 
+	nbcon_cpu_emergency_enter();
+
 	printk("irq event stamp: %u\n", trace->irq_events);
 	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
 		trace->hardirq_enable_event, (void *)trace->hardirq_enable_ip,
@@ -4167,6 +4210,8 @@ void print_irqtrace_events(struct task_struct *curr)
 	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
 		trace->softirq_disable_event, (void *)trace->softirq_disable_ip,
 		(void *)trace->softirq_disable_ip);
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int HARDIRQ_verbose(struct lock_class *class)
@@ -4687,10 +4732,12 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
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
@@ -4731,6 +4778,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	if (debug_locks_silent)
 		return 0;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("[ BUG: Invalid wait context ]\n");
@@ -4750,6 +4799,8 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	pr_warn("stack backtrace:\n");
 	dump_stack();
 
+	nbcon_cpu_emergency_exit();
+
 	return 0;
 }
 
@@ -4954,6 +5005,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("==================================\n");
 	pr_warn("WARNING: Nested lock was not taken\n");
@@ -4974,6 +5027,8 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
@@ -5019,11 +5074,13 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -5150,6 +5207,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
 		debug_locks_off();
+		nbcon_cpu_emergency_enter();
 		print_lockdep_off("BUG: MAX_LOCK_DEPTH too low!");
 		printk(KERN_DEBUG "depth: %i  max: %lu!\n",
 		       curr->lockdep_depth, MAX_LOCK_DEPTH);
@@ -5157,6 +5215,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		lockdep_print_held_locks(current);
 		debug_show_all_locks();
 		dump_stack();
+		nbcon_cpu_emergency_exit();
 
 		return 0;
 	}
@@ -5176,6 +5235,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=====================================\n");
 	pr_warn("WARNING: bad unlock balance detected!\n");
@@ -5192,6 +5253,8 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static noinstr int match_held_lock(const struct held_lock *hlock,
@@ -5895,6 +5958,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=================================\n");
 	pr_warn("WARNING: bad contention detected!\n");
@@ -5911,6 +5976,8 @@ static void print_lock_contention_bug(struct task_struct *curr,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static void
@@ -6524,6 +6591,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("=========================\n");
 	pr_warn("WARNING: held lock freed!\n");
@@ -6536,6 +6605,8 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 static inline int not_in_range(const void* mem_from, unsigned long mem_len,
@@ -6582,6 +6653,8 @@ static void print_held_locks_bug(void)
 	if (debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("====================================\n");
 	pr_warn("WARNING: %s/%d still has locks held!\n",
@@ -6591,6 +6664,8 @@ static void print_held_locks_bug(void)
 	lockdep_print_held_locks(current);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 void debug_check_no_locks_held(void)
@@ -6616,6 +6691,7 @@ void debug_show_all_locks(void)
 		if (!p->lockdep_depth)
 			continue;
 		lockdep_print_held_locks(p);
+		nbcon_cpu_emergency_flush();
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
 	}
@@ -6648,6 +6724,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 	if (unlikely(curr->lockdep_depth)) {
 		if (!debug_locks_off())
 			return;
+		nbcon_cpu_emergency_enter();
 		pr_warn("\n");
 		pr_warn("================================================\n");
 		pr_warn("WARNING: lock held when returning to user space!\n");
@@ -6656,6 +6733,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 		pr_warn("%s/%d is leaving the kernel with locks still held!\n",
 				curr->comm, curr->pid);
 		lockdep_print_held_locks(curr);
+		nbcon_cpu_emergency_exit();
 	}
 
 	/*
@@ -6672,6 +6750,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	bool rcu = warn_rcu_enter();
 
 	/* Note: the following can be executed concurrently, so be careful. */
+	nbcon_cpu_emergency_enter();
 	pr_warn("\n");
 	pr_warn("=============================\n");
 	pr_warn("WARNING: suspicious RCU usage\n");
@@ -6710,6 +6789,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	lockdep_print_held_locks(curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	nbcon_cpu_emergency_exit();
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
-- 
2.39.2



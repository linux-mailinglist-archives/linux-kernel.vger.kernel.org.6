Return-Path: <linux-kernel+bounces-341096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C0987B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5DD1C20CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697D1AFB2E;
	Thu, 26 Sep 2024 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyeZP9PW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093011B0113;
	Thu, 26 Sep 2024 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390989; cv=none; b=S+Vcpu57A9yGer8aF7DEyZjy7wfi9t/NtFEr21uUoPy48h9nSf/+ESRgem1zyHsFQI/u0WPZ794YHBKwSkzLwA0AMJRkFVhM6EMvlXE5PKUEdtDHZ0INSLfGmKjw0L9oSecJaXO/BDt8RM5KKUjsCPbu5S0xrIKJtCnldOtULLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390989; c=relaxed/simple;
	bh=bE1OM/op4+e/YyAtntgPKGkBQ7JAfe3Vd2i3n+7WjN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L19qrHtoty7OX88/amCd4jPK0EAZNxgWyxR0exHE8o/yNRVrMZx2cKZWZxa0znZe3A6H7RABMBNOtMJiSeNFi0gcOe5IXshECp+YHBVT8BPxD0jwGCvcNdPMh5lR8zM1xfscYC4jj74tbE/b/3OIdzYkfbpKKBolq7kG1Ht0o3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyeZP9PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97D7C4CECF;
	Thu, 26 Sep 2024 22:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390988;
	bh=bE1OM/op4+e/YyAtntgPKGkBQ7JAfe3Vd2i3n+7WjN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lyeZP9PWK4kodAkIS7yTyNhlbSAraYXy5xoRG+4jGTQgHQpPMG/SpnI8qwYvYWXHN
	 2n5SVdMmIQKyc28FIyY6jAWXZSFbIDk6s3gnVQeBr0LRLKKQlX9IM9vojf/i73iQqD
	 CfCm3C+5NVgQBGW+P/HXiSTEfAolKpVXHCSG1YKaW1j4jcoJQOX3jab5KUWQOAmqUA
	 CDsPW6j8jql2Dz6xVR+fFUfQx3zOCu0yD4gRCsNFASNmCFinYbw3AUOYceXe10QK0l
	 fA7mxZEWvX0uj8fKH8Sz+UHIWEgZI1Vlifl6t85IucnruBVsouNjrOEnm0aK52cFE0
	 lwZINyZQN4z5w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH 13/20] kthread: Default affine kthread to its preferred NUMA node
Date: Fri, 27 Sep 2024 00:49:01 +0200
Message-ID: <20240926224910.11106-14-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kthreads attached to a preferred NUMA node for their task structure
allocation can also be assumed to run preferrably within that same node.

A more precise affinity is usually notified by calling
kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.

For the others, a default affinity to the node is desired and sometimes
implemented with more or less success when it comes to deal with hotplug
events and nohz_full / CPU Isolation interactions:

- kcompactd is affine to its node and handles hotplug but not CPU Isolation
- kswapd is affine to its node and ignores hotplug and CPU Isolation
- A bunch of drivers create their kthreads on a specific node and
  don't take care about affining further.

Handle that default node affinity preference at the generic level
instead, provided a kthread is created on an actual node and doesn't
apply any specific affinity such as a given CPU or a custom cpumask to
bind to before its first wake-up.

This generic handling is aware of CPU hotplug events and CPU isolation
such that:

* When a housekeeping CPU goes up that is part of the node of a given
  kthread, the related task is re-affined to that own node if it was
  previously running on the default last resort online housekeeping set
  from other nodes.

* When a housekeeping CPU goes down while it was part of the node of a
  kthread, the running task is migrated (or the sleeping task is woken
  up) automatically by the scheduler to other housekeepers within the
  same node or, as a last resort, to all housekeepers from other nodes.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuhotplug.h |   1 +
 kernel/kthread.c           | 106 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 2361ed4d2b15..228f27150a93 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -239,6 +239,7 @@ enum cpuhp_state {
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RANDOM_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
+	CPUHP_AP_KTHREADS_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 40,
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1527a522cdd3..736276d313c2 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -35,6 +35,9 @@ static DEFINE_SPINLOCK(kthread_create_lock);
 static LIST_HEAD(kthread_create_list);
 struct task_struct *kthreadd_task;
 
+static LIST_HEAD(kthreads_hotplug);
+static DEFINE_MUTEX(kthreads_hotplug_lock);
+
 struct kthread_create_info
 {
 	/* Information passed to kthread() from kthreadd. */
@@ -53,6 +56,7 @@ struct kthread_create_info
 struct kthread {
 	unsigned long flags;
 	unsigned int cpu;
+	unsigned int node;
 	int started;
 	int result;
 	int (*threadfn)(void *);
@@ -64,6 +68,8 @@ struct kthread {
 #endif
 	/* To store the full name if task comm is truncated. */
 	char *full_name;
+	struct task_struct *task;
+	struct list_head hotplug_node;
 };
 
 enum KTHREAD_BITS {
@@ -122,8 +128,11 @@ bool set_kthread_struct(struct task_struct *p)
 
 	init_completion(&kthread->exited);
 	init_completion(&kthread->parked);
+	INIT_LIST_HEAD(&kthread->hotplug_node);
 	p->vfork_done = &kthread->exited;
 
+	kthread->task = p;
+	kthread->node = tsk_fork_get_node(current);
 	p->worker_private = kthread;
 	return true;
 }
@@ -314,6 +323,11 @@ void __noreturn kthread_exit(long result)
 {
 	struct kthread *kthread = to_kthread(current);
 	kthread->result = result;
+	if (!list_empty(&kthread->hotplug_node)) {
+		mutex_lock(&kthreads_hotplug_lock);
+		list_del(&kthread->hotplug_node);
+		mutex_unlock(&kthreads_hotplug_lock);
+	}
 	do_exit(0);
 }
 EXPORT_SYMBOL(kthread_exit);
@@ -339,6 +353,48 @@ void __noreturn kthread_complete_and_exit(struct completion *comp, long code)
 }
 EXPORT_SYMBOL(kthread_complete_and_exit);
 
+static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpumask)
+{
+	cpumask_and(cpumask, cpumask_of_node(kthread->node),
+		    housekeeping_cpumask(HK_TYPE_KTHREAD));
+
+	if (cpumask_empty(cpumask))
+		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_KTHREAD));
+}
+
+static void kthread_affine_node(void)
+{
+	struct kthread *kthread = to_kthread(current);
+	cpumask_var_t affinity;
+
+	WARN_ON_ONCE(kthread_is_per_cpu(current));
+
+	if (kthread->node == NUMA_NO_NODE) {
+		housekeeping_affine(current, HK_TYPE_RCU);
+	} else {
+		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
+			WARN_ON_ONCE(1);
+			return;
+		}
+
+		mutex_lock(&kthreads_hotplug_lock);
+		WARN_ON_ONCE(!list_empty(&kthread->hotplug_node));
+		list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
+		/*
+		 * The node cpumask is racy when read from kthread() but:
+		 * - a racing CPU going down will either fail on the subsequent
+		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
+		 *   afterwards by the scheduler.
+		 * - a racing CPU going up will be handled by kthreads_online_cpu()
+		 */
+		kthread_fetch_affinity(kthread, affinity);
+		set_cpus_allowed_ptr(current, affinity);
+		mutex_unlock(&kthreads_hotplug_lock);
+
+		free_cpumask_var(affinity);
+	}
+}
+
 static int kthread(void *_create)
 {
 	static const struct sched_param param = { .sched_priority = 0 };
@@ -369,7 +425,6 @@ static int kthread(void *_create)
 	 * back to default in case they have been changed.
 	 */
 	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
-	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
@@ -385,6 +440,9 @@ static int kthread(void *_create)
 
 	self->started = 1;
 
+	if (!(current->flags & PF_NO_SETAFFINITY))
+		kthread_affine_node();
+
 	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
 		cgroup_kthread_ready();
@@ -779,6 +837,52 @@ int kthreadd(void *unused)
 	return 0;
 }
 
+/*
+ * Re-affine kthreads according to their preferences
+ * and the newly online CPU. The CPU down part is handled
+ * by select_fallback_rq() which default re-affines to
+ * housekeepers in case the preferred affinity doesn't
+ * apply anymore.
+ */
+static int kthreads_online_cpu(unsigned int cpu)
+{
+	cpumask_var_t affinity;
+	struct kthread *k;
+	int ret;
+
+	guard(mutex)(&kthreads_hotplug_lock);
+
+	if (list_empty(&kthreads_hotplug))
+		return 0;
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = 0;
+
+	list_for_each_entry(k, &kthreads_hotplug, hotplug_node) {
+		if (WARN_ON_ONCE((k->task->flags & PF_NO_SETAFFINITY) ||
+				 kthread_is_per_cpu(k->task) ||
+				 k->node == NUMA_NO_NODE)) {
+			ret = -EINVAL;
+			continue;
+		}
+		kthread_fetch_affinity(k, affinity);
+		set_cpus_allowed_ptr(k->task, affinity);
+	}
+
+	free_cpumask_var(affinity);
+
+	return ret;
+}
+
+static int kthreads_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_KTHREADS_ONLINE, "kthreads:online",
+				kthreads_online_cpu, NULL);
+}
+early_initcall(kthreads_init);
+
 void __kthread_init_worker(struct kthread_worker *worker,
 				const char *name,
 				struct lock_class_key *key)
-- 
2.46.0



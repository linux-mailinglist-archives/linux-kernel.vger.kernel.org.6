Return-Path: <linux-kernel+bounces-432750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D909E4FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5746C1881BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8D1D0DEC;
	Thu,  5 Dec 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNWmeBWq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119F1B219B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387520; cv=none; b=J2WSD38Vj+DopNRC6oVQKYl1Bqyw3bZs/Y83/VYaQ5kSzsh+oB49OwjubGIVngWJuf74vFxG8JL5CGfV5yNiwMlZEp9YY2ZExNR7uv7SYYLr6hVO16ZRjKQfAscJWbQpsr5c0h0O9Dvlf/W5vIxLOrLv45iJR0qZdL6pwkoDP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387520; c=relaxed/simple;
	bh=KBvk2jNTghOafdSPBD8B16h6E5ILhhotf3ATl9qqizk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMeUTpnjShQgBSP1H9vCJ2P5Ehsq44q/rjYQuaFKT0a0dNkdx1dbSDeIj+LISaDMA9ub4qllHRxcJlBHWGcVzuiNhiroeN2AQwXq6FYawIJ98VBQXpkAj9x0IW9JDTW+ctFeJ4snCUkFF+xRTHa98vbCXlJdqGxHgqkyL1dHYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNWmeBWq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733387517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2vM6qUuCJYzyfHeB88GfpKyQAf0dwch2f0TqJnEPdAU=;
	b=dNWmeBWqs6/1qiX0fydCArU1A/3UwhsctlKdTwSPaaTe7QeMagdfWcsa6c97UvkRhkZwhU
	B4uOsFNHPdKEnN/zqLKcWwZ4u5Iy5gg1JxB1inF8NPBSFlu4EEP1sOBMUW9uKp3cD+/h7V
	l65WA8VSL20wkfGXhv6PONcto/XNezM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-gvnJkFQXN86hWtSsyN7wzQ-1; Thu,
 05 Dec 2024 03:31:53 -0500
X-MC-Unique: gvnJkFQXN86hWtSsyN7wzQ-1
X-Mimecast-MFC-AGG-ID: gvnJkFQXN86hWtSsyN7wzQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 499F31955DA8;
	Thu,  5 Dec 2024 08:31:52 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBCB81955E87;
	Thu,  5 Dec 2024 08:31:42 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] sched: Move task_mm_cid_work to mm delayed work
Date: Thu,  5 Dec 2024 09:31:11 +0100
Message-ID: <20241205083110.180134-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, the task_mm_cid_work function is called in a task work
triggered by a scheduler tick. This can delay the execution of the task
for the entire duration of the function, negatively affecting the
response of real time tasks.

This patch runs the task_mm_cid_work in a new delayed work connected to
the mm_struct rather than in the task context before returning to
userspace.

This delayed work is initialised while allocating the mm and disabled
before freeing it, its execution is no longer triggered by scheduler
ticks but running periodically based on the defined MM_CID_SCAN_DELAY.

The main advantage of this change is that the function can be offloaded
to a different CPU and even preempted by RT tasks.

On a busy system, this may mean the function gets called less often, but
the current behaviour already doesn't provide guarantees. Moreover, this
new behaviour could be more predictable in some situations since the
delayed work is always scheduled with the same periodicity for each mm.

This deprecate the "sched: improve task_mm_cid_work impact on isolated
systems" patches by dropping the first patch and using a workqueue
instead of RCU callbacks.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/lkml/20241202140735.56368-1-gmonaco@redhat.com/
---
 include/linux/mm_types.h |  5 +++++
 kernel/sched/core.c      | 37 +++++++------------------------------
 2 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..38c567f06dce 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -856,6 +856,7 @@ struct mm_struct {
 		 * mm nr_cpus_allowed updates.
 		 */
 		raw_spinlock_t cpus_allowed_lock;
+		struct delayed_work mm_cid_work;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1149,6 +1150,8 @@ enum mm_cid_state {
 	MM_CID_LAZY_PUT = (1U << 31),
 };
 
+extern void task_mm_cid_work(struct work_struct *work);
+
 static inline bool mm_cid_is_unset(int cid)
 {
 	return cid == MM_CID_UNSET;
@@ -1221,12 +1224,14 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
+	INIT_DELAYED_WORK(&mm->mm_cid_work, task_mm_cid_work);
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
+	disable_delayed_work(&mm->mm_cid_work);
 	free_percpu(mm->pcpu_cid);
 	mm->pcpu_cid = NULL;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..0c3a778c9cb5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5654,7 +5654,6 @@ void sched_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, donor);
 	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
@@ -10520,22 +10519,14 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
 }
 
-static void task_mm_cid_work(struct callback_head *work)
+void task_mm_cid_work(struct work_struct *work)
 {
 	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
 	struct cpumask *cidmask;
-	struct mm_struct *mm;
+	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
+	struct mm_struct *mm = container_of(delayed_work, struct mm_struct, mm_cid_work);
 	int weight, cpu;
 
-	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
-
-	work->next = work;	/* Prevent double-add */
-	if (t->flags & PF_EXITING)
-		return;
-	mm = t->mm;
-	if (!mm)
-		return;
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	if (!old_scan) {
@@ -10571,26 +10562,12 @@ void init_sched_mm_cid(struct task_struct *t)
 
 	if (mm) {
 		mm_users = atomic_read(&mm->mm_users);
-		if (mm_users == 1)
+		if (mm_users == 1) {
 			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
+			schedule_delayed_work(&mm->mm_cid_work,
+					      msecs_to_jiffies(MM_CID_SCAN_DELAY));
+		}
 	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
-}
-
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
-{
-	struct callback_head *work = &curr->cid_work;
-	unsigned long now = jiffies;
-
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
-		return;
-	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
-		return;
-
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)

base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
-- 
2.47.1



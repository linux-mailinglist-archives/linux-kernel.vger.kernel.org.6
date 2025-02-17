Return-Path: <linux-kernel+bounces-517496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC5A38199
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0119116FBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AE21859B;
	Mon, 17 Feb 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vqw5pc5w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A48217F27
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791416; cv=none; b=OjTeRuCNO+C/GgQ8OlCGm3q3oJVDnrjdtijdZfn7GiwR6Ra3TANeOR9kAxseGrS+qGcQACGoqmxaiyn1+jj2Hr87CXxZi6Mi9RiuuGPHH69mTcQM+ZslDeqKcnzRtEt8FRKTJOLREPDmA5FJS6YT1GTJpKlxcNZ12ZmLud09l4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791416; c=relaxed/simple;
	bh=tCn+zXx+bMTWTjCLwfEQuYUE8qVtI5OAQHT0vM17Igs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp3tAh1JDp3o5rwiYoO5WfQp/zLWQoPSFxTPpCo6d3aFI0rQRElNd7Ld5l7gEs6oVdBvBr4WWuqm3b6arUoKxLr269pCX18dslzlzW+HktGHrIdf6eVe5ZPGffZhGIkU43yHV4MBUXrzAudhpKGSXdvUyooUdtxtMKhuvoByMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vqw5pc5w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739791413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmVVq3HHzqRlZLdZZrTZki/75/BrjuDDaU0LBdE44wk=;
	b=Vqw5pc5wqh9PTT71XgHdCLkRp6B1QzT/K80MetV49uL7A2lL1xDuoWboqvXQ5L6Lx5PNuo
	qeF3Sr8D5fsSUsHZ4XNge/y/WVW3v9yuFKXHBneRabSM7Ms2Q5zjlrjM1xql/6XLrblSxS
	ZL9ia0RRJIOL2u7zd1+fMFds/AvWIsE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-yVEZmuJVO1SYSDLbzU-3CA-1; Mon,
 17 Feb 2025 06:23:30 -0500
X-MC-Unique: yVEZmuJVO1SYSDLbzU-3CA-1
X-Mimecast-MFC-AGG-ID: yVEZmuJVO1SYSDLbzU-3CA_1739791409
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F3D51800874;
	Mon, 17 Feb 2025 11:23:29 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.190])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAE811955BD4;
	Mon, 17 Feb 2025 11:23:25 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/2] sched: Compact RSEQ concurrency IDs in batches
Date: Mon, 17 Feb 2025 12:23:16 +0100
Message-ID: <20250217112317.258716-2-gmonaco@redhat.com>
In-Reply-To: <20250217112317.258716-1-gmonaco@redhat.com>
References: <20250217112317.258716-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, the task_mm_cid_work function is called in a task work
triggered by a scheduler tick to frequently compact the mm_cids of each
process for each core. This can delay the execution of the corresponding
thread for the entire duration of the function, negatively affecting the
response in case of real time tasks. In practice, we observe
task_mm_cid_work increasing the latency of 30-35us on a 128 cores
system, this order of magnitude is meaningful under PREEMPT_RT.

Run the task_mm_cid_work in batches of up to CONFIG_RSEQ_CID_SCAN_BATCH
cpus, this contains the duration of the delay for each scan.
Also improve the duration by iterating for all present cpus and not for
all possible.

The task_mm_cid_work already contains a mechanism to avoid running more
frequently than every 100ms, considering the function runs at every
tick, assuming ticks every 1ms (HZ=1000 is common on distros) and
assuming an unfavorable scenario of 1/10 ticks during task T runtime, we
can compact the CIDs for task T in about 130ms by setting
CONFIG_RSEQ_CID_SCAN_BATCH to 10 on a 128 cores machine.
This value also drastically reduces the task work duration and is a more
acceptable latency for the aforementioned machine.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h |  8 ++++++++
 init/Kconfig             | 12 ++++++++++++
 kernel/sched/core.c      | 27 ++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6b..1e0e491d2c5c2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -867,6 +867,13 @@ struct mm_struct {
 		 * When the next mm_cid scan is due (in jiffies).
 		 */
 		unsigned long mm_cid_next_scan;
+		/*
+		 * @mm_cid_scan_cpu: Which cpu to start from in the next scan
+		 *
+		 * Scan in batches of CONFIG_RSEQ_CID_SCAN_BATCH after each scan
+		 * save the next cpu index here (or 0 if we are done)
+		 */
+		unsigned int mm_cid_scan_cpu;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
@@ -1249,6 +1256,7 @@ static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 	raw_spin_lock_init(&mm->cpus_allowed_lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
+	mm->mm_cid_scan_cpu = 0;
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b3..39f1d4c7980c0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1813,6 +1813,18 @@ config DEBUG_RSEQ
 
 	  If unsure, say N.
 
+config RSEQ_CID_SCAN_BATCH
+	int "Number of CPUs to scan every time we attempt mm_cid compaction"
+	range 1 NR_CPUS
+	default 10
+	depends on SCHED_MM_CID
+	help
+	  CPUs are scanned pseudo-periodically to compact the CID of each task,
+	  this operation can take a longer amount of time on systems with many
+	  CPUs, resulting in higher scheduling latency for the current task.
+	  A higher value means the CID is compacted faster, but results in
+	  higher scheduling latency.
+
 config CACHESTAT_SYSCALL
 	bool "Enable cachestat() system call" if EXPERT
 	default y
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac691..8d1cce4ed62c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10536,7 +10536,7 @@ static void task_mm_cid_work(struct callback_head *work)
 	struct task_struct *t = current;
 	struct cpumask *cidmask;
 	struct mm_struct *mm;
-	int weight, cpu;
+	int weight, cpu, from_cpu, to_cpu;
 
 	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
 
@@ -10546,6 +10546,15 @@ static void task_mm_cid_work(struct callback_head *work)
 	mm = t->mm;
 	if (!mm)
 		return;
+	cpu = from_cpu = READ_ONCE(mm->mm_cid_scan_cpu);
+	to_cpu = from_cpu + CONFIG_RSEQ_CID_SCAN_BATCH;
+	if (from_cpu > cpumask_last(cpu_present_mask)) {
+		from_cpu = 0;
+		to_cpu = CONFIG_RSEQ_CID_SCAN_BATCH;
+	}
+	if (from_cpu != 0)
+		/* Delay scan only if we are done with all cpus. */
+		goto cid_compact;
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	if (!old_scan) {
@@ -10561,17 +10570,29 @@ static void task_mm_cid_work(struct callback_head *work)
 		return;
 	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
 		return;
+
+cid_compact:
+	if (!try_cmpxchg(&mm->mm_cid_scan_cpu, &cpu, to_cpu))
+		return;
 	cidmask = mm_cidmask(mm);
 	/* Clear cids that were not recently used. */
-	for_each_possible_cpu(cpu)
+	cpu = from_cpu;
+	for_each_cpu_from(cpu, cpu_present_mask) {
+		if (cpu == to_cpu)
+			break;
 		sched_mm_cid_remote_clear_old(mm, cpu);
+	}
 	weight = cpumask_weight(cidmask);
 	/*
 	 * Clear cids that are greater or equal to the cidmask weight to
 	 * recompact it.
 	 */
-	for_each_possible_cpu(cpu)
+	cpu = from_cpu;
+	for_each_cpu_from(cpu, cpu_present_mask) {
+		if (cpu == to_cpu)
+			break;
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
+	}
 }
 
 void init_sched_mm_cid(struct task_struct *t)
-- 
2.48.1



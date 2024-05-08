Return-Path: <linux-kernel+bounces-173900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CB8C075F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917BB1C213A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2324B33;
	Wed,  8 May 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpIOLi39"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CD15E88
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207709; cv=none; b=revtCASKWqZ6RRyOHNq5bTEwFtgJC6phgtofUTdJPVGExPPAI8eNePFhZkti5IeFE8eD/WtrV96tvdFGK4b/N1buJ7S27jD79McNB1xkWsaclVFexmSvCGqaN0sF7rCgvjenPP53D93KHll5ZL6SCzpj2JfHzbEY1MxaVynPkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207709; c=relaxed/simple;
	bh=JgBkmeklItskJFuBEF/kSnIO0m86SH5Nn0hsMuxfUsw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c2IZ19v9cyGetpeVEuTLQ+Jd9aBbUofiatH1xMeh8qIaR4jGLtsgNqvjGFeP8naV3CwsAK8k66zfHH3M6N/0BZagBj16r+pdao+AmdF7ts4DVoOH8amH8qHJCjpl8U6zpxUahV6a9vUdd4Ydqf4Ls04Lcy7hvDXL7vsgzCmcv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpIOLi39; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61c9675ae5aso4692477b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715207706; x=1715812506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ynuosejSQPbV61aVJAjbPQ9xlSnDu2H5xFDho/Baft4=;
        b=rpIOLi39C83rGQUWFfb2qrXcGofLl/cIbYHrESHZU7bRWo99U96whs+ywzNo/Ok7hj
         vcL8TIS8fcnSaUhPMAqqmhm0hIad80g84dogbgcYF0IqoOBfFONR5tduxX+BNnt3jm8U
         rwLmrWZI3A44XdSZCRDQKbXW4HJSdQSFkBfdD+TfA1ijLkqhFBCjBg3mVPNclX/UTqdV
         AcA5X5nhcGIiloStRlii7ciz9RpDz7NHA7GkZZPUlQNWrTUIv2akSMAGZCO1fylYHDRO
         C5Ag+IDsZl2HSjPQaXe2cqrC/sIQuszFECBe2sctr7BmfwBB4us11HxNrAKmX5jz6Sq7
         YMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715207706; x=1715812506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynuosejSQPbV61aVJAjbPQ9xlSnDu2H5xFDho/Baft4=;
        b=hauLSNsWUGoWGq2xEIiqm0JrE2PPIPXYZMxq4axTVpYd8Z4lXe6qiGfFeSlyt5XwPD
         IZPh9+ai3B7MjY+sYKB1D2QYlAUgmZnkzYhTIbFOgWD0nbMbeZXl4bAPfmL5nS1xj2t0
         DfVNc4xIG39qpAQL9b+0L6oCmJ85AdaZBZYdL6MlB0lgWDp+cw6uDEcN71nQHzYI3wbk
         B5O9PeNWwknyuzrwp7OqjMkPUHVbGx5syQkGtO/snIL9uKYLOfOnYEWNIvmm0clAIzM7
         lbYi3v1bdvzZI7AFUkHqHDifL4Cz9brTPR6FHmmbdrySdUq9Q96tmc+Rm1LwRnRsr5tJ
         zxiA==
X-Forwarded-Encrypted: i=1; AJvYcCXQoPqv5g2axbRNIaQKy1si3whxrs6t/+KL2kHSZGDR99gqjfcqxMnoZp4mmiDg/d7AwyTNhud2dLAlxqhyOFMJVvAG5LX9NBCoVxO+
X-Gm-Message-State: AOJu0YyOEQscg3LVa5tTlRv8/5qPcw14JmHa6xb7WCXZf1rSXYmRQ7fN
	4KeOPVgoycdW8l3LFYxmbSvLaTz26GoHPBerMShxPCxLS+weQtsczT6Gzl0Z3jaRDkK/xhi0yYF
	6mu+Fdg==
X-Google-Smtp-Source: AGHT+IG6vQm5mCS8oLQPgE/Q7cXJHlRrCiNtMHDGgfyeZVb4oBpkDU+tnTN3M2wYYWxE6LdnY2YcGOlUXumS
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:9e77:7b75:fb4f:e043])
 (user=joshdon job=sendgmr) by 2002:a05:690c:6d10:b0:61b:e6a8:a8a with SMTP id
 00721157ae682-62085d37db0mr9708407b3.6.1715207706627; Wed, 08 May 2024
 15:35:06 -0700 (PDT)
Date: Wed,  8 May 2024 15:34:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240508223456.4189689-1-joshdon@google.com>
Subject: [PATCH] sched/fair: prevent unbounded task iteration in load balance
From: Josh Don <joshdon@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

b0defa7ae03ec changed the load balancing logic to ignore env.max_loop if
all tasks examined to that point were pinned. The goal of the patch was
to make it more likely to be able to detach a task buried in a long list
of pinned tasks. However, this has the unfortunate side effect of
creating an O(n) iteration in detach_tasks(), as we now must fully
iterate every task on a cpu if all or most are pinned. Since this load
balance code is done with rq lock held, and often in softirq context, it
is very easy to trigger hard lockups. We observed such hard lockups with
a user who affined O(10k) threads to a single cpu.

My initial suggestion to Vincent was to revert the original patch and
instead bump sched_nr_migrate. However, he pointed out that we do still
want to have a limit on the number of tasks we actually detach (which is
an expensive operation), but still allow a deeper search.

As a result of the above, this patch now separates the number of tasks
we migrate from the number of tasks we can search. Now, the search limit
can be raised while keeping the nr_migrate fixed.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/core.c  |  3 ++-
 kernel/sched/debug.c |  1 +
 kernel/sched/fair.c  | 19 ++++++++++++++-----
 kernel/sched/sched.h |  1 +
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..820ffa9bbcfe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -144,10 +144,11 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
 #endif /* CONFIG_SCHED_DEBUG */
 
 /*
- * Number of tasks to iterate in a single balance run.
+ * Max number of tasks we can move/iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
 const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
+const_debug unsigned int sysctl_sched_migrate_search_depth = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 168eecc209b4..d1701c98f996 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -356,6 +356,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
+	debugfs_create_u32("migrate_search_depth", 0644, debugfs_sched, &sysctl_sched_migrate_search_depth);
 
 	mutex_lock(&sched_domains_mutex);
 	update_sched_domain_debugfs();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 34fe6e9490c2..b4b26f39dd45 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8764,6 +8764,9 @@ struct lb_env {
 	unsigned int		loop_break;
 	unsigned int		loop_max;
 
+	unsigned int		num_detached;
+	unsigned int		detach_max;
+
 	enum fbq_type		fbq_type;
 	enum migration_type	migration_type;
 	struct list_head	tasks;
@@ -9044,11 +9047,11 @@ static int detach_tasks(struct lb_env *env)
 
 		env->loop++;
 		/*
-		 * We've more or less seen every task there is, call it quits
-		 * unless we haven't found any movable task yet.
+		 * Call it quits if we're going to exceed our search limit;
+		 * we can't search indefinitely even if we've not found a
+		 * migratable task yet.
 		 */
-		if (env->loop > env->loop_max &&
-		    !(env->flags & LBF_ALL_PINNED))
+		if (env->loop > env->loop_max)
 			break;
 
 		/* take a breather every nr_migrate tasks */
@@ -9116,6 +9119,9 @@ static int detach_tasks(struct lb_env *env)
 		list_add(&p->se.group_node, &env->tasks);
 
 		detached++;
+		env->num_detached++;
+		if (env->num_detached >= env->detach_max)
+			break;
 
 #ifdef CONFIG_PREEMPTION
 		/*
@@ -11287,6 +11293,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_cpu = busiest->cpu;
 	env.src_rq = busiest;
 
+	env.num_detached = 0;
+	env.detach_max = sysctl_sched_nr_migrate;
+
 	ld_moved = 0;
 	/* Clear this flag as soon as we find a pullable task */
 	env.flags |= LBF_ALL_PINNED;
@@ -11297,7 +11306,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
+		env.loop_max  = min(sysctl_sched_migrate_search_depth, busiest->nr_running);
 
 more_balance:
 		rq_lock_irqsave(busiest, &rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..1597175d5f0b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2539,6 +2539,7 @@ extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
 
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
+extern const_debug unsigned int sysctl_sched_migrate_search_depth;
 
 extern unsigned int sysctl_sched_base_slice;
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog



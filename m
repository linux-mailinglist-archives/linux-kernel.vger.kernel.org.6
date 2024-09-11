Return-Path: <linux-kernel+bounces-325531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2438975AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84510B23B19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0B1BA291;
	Wed, 11 Sep 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/QA5vOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB471BA274
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083405; cv=none; b=T39gqAVA7dONcjypc77PH5T3Nx+LHqDmMG1rh+G3v/FQxTnk33HMoGrT2i9550jTdc6gTEc7mYuq9sKEWDX32B51mb2fwg6JJ3w/JGRm7MSGEE44YMHlZnmc71x2Dzin1biAG9EDOzKAqubyEjLLAHl20l8Ty+gz7yAsgMUtxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083405; c=relaxed/simple;
	bh=FFOrwJnlAB30RedVfJe0YzEixx8hN3faDDKEzHSb4lc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fcfAeZRbjWU12dL7dN80CffaSeqwD8VHDmonA6hvyfvYHaZbJCvdqZ2FFJVIFlWEdt6evqBV+7opR6zOwul3Bz4VWB6ckOK8le/w3rXxlLmH0To+RRUSc62uTh6E8aP47zgyPQ61HA3trmCeEZLK4sNQpv19q96XgfcDqRpe2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/QA5vOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE76CC4CEC0;
	Wed, 11 Sep 2024 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726083404;
	bh=FFOrwJnlAB30RedVfJe0YzEixx8hN3faDDKEzHSb4lc=;
	h=Date:From:To:Cc:Subject:From;
	b=O/QA5vOnU6eak+ZxGE4GtKLLk1A2hLpVXW1f8001f5GJHIumpKqJ510GqrAyp/PGL
	 vvVGTfPNxD2Q+k+PucJCJmvu4mMHu2jcFqxE7vRGPXnbMbjFogZOawcHhAG7uxmA6u
	 VLMIcdMuMTJG5AMfMYFpX+Pg1cePDG1XqEkvIrOly5ihUbsdvq0+olvHX/qavzlXeV
	 RciTsHbasVFRp3W3IYz6JZ2UIDY0ROxMlWmbqyi1MdNL4ySHc6inojEcZ0LBA+HkYL
	 G4SB4csyHXdAbdgYSF8Orl9z5xgUEmZCdSJA4SN72hOCB3KSWQ8kY5Zk8gezNQi3f7
	 C5ov7mxOI9nBQ==
Date: Wed, 11 Sep 2024 09:36:43 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12] sched: Move update_other_load_avgs() to
 kernel/sched/pelt.c
Message-ID: <ZuHxS2LfTBg0TZK1@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

96fd6c65efc6 ("sched: Factor out update_other_load_avgs() from
__update_blocked_others()") added update_other_load_avgs() in
kernel/sched/syscalls.c right above effective_cpu_util(). This location
didn't fit that well in the first place, and with 5d871a63997f ("sched/fair:
Move effective_cpu_util() and effective_cpu_util() in fair.c") moving
effective_cpu_util() to kernel/sched/fair.c, it looks even more out of
place.

Relocate the function to kernel/sched/pelt.c where all its callees are.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/pelt.c     |   20 ++++++++++++++++++++
 kernel/sched/pelt.h     |    1 +
 kernel/sched/sched.h    |    2 --
 kernel/sched/syscalls.c |   22 ----------------------
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fa52906a4478..a9c65d97b3ca 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -467,3 +467,23 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	return ret;
 }
 #endif
+
+/*
+ * Load avg and utiliztion metrics need to be updated periodically and before
+ * consumption. This function updates the metrics for all subsystems except for
+ * the fair class. @rq must be locked and have its clock updated.
+ */
+bool update_other_load_avgs(struct rq *rq)
+{
+	u64 now = rq_clock_pelt(rq);
+	const struct sched_class *curr_class = rq->curr->sched_class;
+	unsigned long hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
+
+	lockdep_assert_rq_held(rq);
+
+	/* hw_pressure doesn't care about invariance */
+	return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
+		update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
+		update_irq_load_avg(rq, 0);
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 2150062949d4..f4f6a0875c66 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+bool update_other_load_avgs(struct rq *rq);
 
 #ifdef CONFIG_SCHED_HW_PRESSURE
 int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 07a2f523e2eb..8063db62b027 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3245,8 +3245,6 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) { }
 
 #ifdef CONFIG_SMP
 
-bool update_other_load_avgs(struct rq *rq);
-
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
 				 unsigned long *max);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b621e0050e42..ddf6e6c82f02 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -258,28 +258,6 @@ int sched_core_idle_cpu(int cpu)
 
 #endif
 
-#ifdef CONFIG_SMP
-/*
- * Load avg and utiliztion metrics need to be updated periodically and before
- * consumption. This function updates the metrics for all subsystems except for
- * the fair class. @rq must be locked and have its clock updated.
- */
-bool update_other_load_avgs(struct rq *rq)
-{
-	u64 now = rq_clock_pelt(rq);
-	const struct sched_class *curr_class = rq->curr->sched_class;
-	unsigned long hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-
-	lockdep_assert_rq_held(rq);
-
-	/* hw_pressure doesn't care about invariance */
-	return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
-		update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
-		update_irq_load_avg(rq, 0);
-}
-#endif /* CONFIG_SMP */
-
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.


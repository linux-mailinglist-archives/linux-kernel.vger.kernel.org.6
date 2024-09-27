Return-Path: <linux-kernel+bounces-342278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE8988D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D783A1F22056
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F301B791A;
	Fri, 27 Sep 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuYOp6BP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2D1B5303
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727480922; cv=none; b=mbiIaOgPf08KqAa2S11nxlkIf+R3/Ahm76KrUpoPvL9a+81KIkgDMcO8yG+frBB4T4GbXmy0Q1sjeZXf/96NUe7ja8lw+m0AL4PfMJdFebmtDKjMmWK4zo7xt/5IZr31k0nLiAuqwe8erR5jckFyjr0se5X0VKJ+ZH/W5zTRFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727480922; c=relaxed/simple;
	bh=VPzEDa+hI6Mo+5GtFXkJEDMaE6W2SpGN9jZ4wetptoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgLJS5JPpIGnp1ZG47YGWo6pKWGjAoGTLDC9Ypm7TSB6YOJN9i4FtozH7+aErH01LN0AnbEkj/wrHisBvMPbo5gSousrx/JfClf5QdWMebIpRG81BOQQKcsK566rGnvL/5a5iopmCjLNkspLgJ8s9gMUsqejsYuuSIXy/2KNotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuYOp6BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C005EC4CEC4;
	Fri, 27 Sep 2024 23:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727480921;
	bh=VPzEDa+hI6Mo+5GtFXkJEDMaE6W2SpGN9jZ4wetptoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CuYOp6BPGtI96vV/VG2gu5QQWDxbcffo2TraG374aiVhqc2rggt5OLwLAZHXgTLca
	 MezPtRzmROXGdrw3jP7g82b9vSM3ZgOdRT6mtxR6kM0sTRIjwARvZqJqLeeuxzt80T
	 AseWChueKBW1rE2JmmjRGJs6jT7X+nwNm1Dk3ixqWngaACi0Q4KhsKybaegZGpky2V
	 EAPTAxc9ncLiRKYyQdvu4b3+BKDCW+L6+/1o6CsQ6CR905hB5Sz1kuUjIk55cpQhQ+
	 hGQ18IyX68CgcEBMH8DuEKPGzt/cNZejWRzMX/NBoItc4A2UAl9A7pBSBa7h+RK4yx
	 qUaBJwNMXFgFQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched/core: Make select_task_rq() take the pointer to wake_flags instead of value
Date: Fri, 27 Sep 2024 13:46:11 -1000
Message-ID: <20240927234838.152112-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927234838.152112-1-tj@kernel.org>
References: <20240927234838.152112-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used to allow select_task_rq() to indicate whether
->select_task_rq() was called by modifying *wake_flags.

This makes try_to_wake_up() call all functions that take wake_flags with
WF_TTWU set. Previously, only select_task_rq() was. Using the same flags is
more consistent, and, as the flag is only tested by ->select_task_rq()
implementations, it doesn't cause any behavior differences.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..e70b57a5693e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3518,12 +3518,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
  * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
-int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
+int select_task_rq(struct task_struct *p, int cpu, int *wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
 	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
-		cpu = p->sched_class->select_task_rq(p, cpu, wake_flags);
+		cpu = p->sched_class->select_task_rq(p, cpu, *wake_flags);
 	else
 		cpu = cpumask_any(p->cpus_ptr);
 
@@ -4120,6 +4120,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	guard(preempt)();
 	int cpu, success = 0;
 
+	wake_flags |= WF_TTWU;
+
 	if (p == current) {
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
@@ -4252,7 +4254,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 */
 		smp_cond_load_acquire(&p->on_cpu, !VAL);
 
-		cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
+		cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
 		if (task_cpu(p) != cpu) {
 			if (p->in_iowait) {
 				delayacct_blkio_end(p);
@@ -4793,6 +4795,7 @@ void wake_up_new_task(struct task_struct *p)
 {
 	struct rq_flags rf;
 	struct rq *rq;
+	int wake_flags = WF_FORK;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
@@ -4807,7 +4810,7 @@ void wake_up_new_task(struct task_struct *p)
 	 */
 	p->recent_used_cpu = task_cpu(p);
 	rseq_migrate(p);
-	__set_task_cpu(p, select_task_rq(p, task_cpu(p), WF_FORK));
+	__set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
@@ -4815,7 +4818,7 @@ void wake_up_new_task(struct task_struct *p)
 
 	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
 	trace_sched_wakeup_new(p);
-	wakeup_preempt(rq, p, WF_FORK);
+	wakeup_preempt(rq, p, wake_flags);
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-- 
2.46.2



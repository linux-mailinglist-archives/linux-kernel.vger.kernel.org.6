Return-Path: <linux-kernel+bounces-348936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7858198EE21
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E541F2187C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA01547CD;
	Thu,  3 Oct 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mU2AWwR1"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8F1422C7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954957; cv=none; b=rm33VuBtbhCJTg135brbWGXOxN69CC1Pg/UoP2OjT/6GRwHi1likhsZVPfk3A7sJi/7LRi0QaUGbzMHrbqqVLNFOwvstqzpNBzuEC7LZ7Bmpkzojld7g2ChUeDXR0eQFLIw5wq3usr5IaGe2zn6BtBNAs/BHJMttl4Ozu6a3L5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954957; c=relaxed/simple;
	bh=nVjOl7FI7A+n6tLkR5VVKYp4Rl4H/IYpRVFdm6TrJgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpMoEBHM2+hDvxllhtIbQ5ZD6qC2fJPX05xXc2/JyJvX7oB8eQEp8usc/NmObhS0XcoykPUJGB5DbrdL9A7QJT5R5Ub2kPKFmeqrbdkGr260pUdgLV5uzbcZiaVkoDM0KLcmGb7S2lcE6pI/xEhWGeNL5hdlPpoIEXk7DkSyab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mU2AWwR1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c5acb785f2so4858736d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727954952; x=1728559752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDA9NUNx9gSo2kRmc35eR3BkbtLwu7lBmRWMEDqyb+0=;
        b=mU2AWwR1UDJQtdwPB9DSE4kyOnvtN01w5WPy6SU78AH16VRnn9LV2VmtAatoWDzuo0
         sUtuKZZH8pUkSle68iPhu2WMJ/Z9R3ji9ppOPBCgUaMuEv3G+jt5IVmEa6I050ic4SsQ
         neYjbVR2XiG4hwYZDoyOi1aGj/qlZ/LEgUnZqyhT0MFOhT2c2toeNu591cTOmFmTjkzm
         ykPT8rqMBm1KQktTvqA4nkjlTWWpGxwLwQ5fng2gVneUY366Ya1PYJ2TyWNQw8oDwM9H
         HmwvKfhraO8F10c+hLWnZH7ETt0yrmhzy5CeZUi/eyWVOrZI5x6d5Hzb7hYSHMTPozYf
         ipcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727954952; x=1728559752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDA9NUNx9gSo2kRmc35eR3BkbtLwu7lBmRWMEDqyb+0=;
        b=fujiqeZsLpeUqmuDNBpX9yTQv9VFaqSVPUZ+CiCszWXKwqIa9dfY/IWmykoZvAjklk
         5gOn1OlkqVkDLsXdFxvZoAKbjHx0XqgDHz3wi/W+0z21tZCPVwxqywsCTfQlGDJAqf1a
         mS3cKtbdd99ZGVbf5QBVVCk7MxcbYRCM6ArnyN9K2HeAULNYxt8fEAmmgU86mYxyAnwF
         tyrpMo7dkWzANixOWWSPS0Bvx0R+QLKE18Wxh08x7bUr2T32po1/i5E2oMA/1JoAXZFj
         b2PyH7VJzbXTN7xaVvRiFXPonuvrLDs1yhBksF8V9H5LKi76H3Ih8ERGUQv9oF1LwYzI
         hU6g==
X-Forwarded-Encrypted: i=1; AJvYcCX0tbOs2LmvB1RLwsWcwa5A6oBT5pqWMnZFISjkUS94bbaXRKYATwckRImT2KfW71kgBYVQg/jJLJ3kGTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSzoJIeyJalgqFSLiKmwaxECe97iMuSzbONfarsINfXT1mngW
	/4rs3ozluDr6UHG+k2gxtdeHhN9zEYhWBD3uh3sdDwn+LaGPkSk9QDzLHWes2Yw=
X-Google-Smtp-Source: AGHT+IGKBdcVDcUfhjcWU4LPho1BuvRf7cARd5UtflWnLAlYg+l9fMr57836UwiyVyTmk44DF5CG8g==
X-Received: by 2002:a05:6214:2b8d:b0:6cb:2cfa:3b9d with SMTP id 6a1803df08f44-6cb819d6288mr66848376d6.14.1727954952255;
        Thu, 03 Oct 2024 04:29:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb935cce42sm5674286d6.37.2024.10.03.04.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:29:10 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Brandon Duffany <brandon@buildbuddy.io>,
	stable@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH] sched: psi: fix bogus pressure spikes from aggregation race
Date: Thu,  3 Oct 2024 07:29:05 -0400
Message-ID: <20241003112905.1617308-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Brandon reports sporadic, non-sensical spikes in cumulative pressure
time (total=) when reading cpu.pressure at a high rate. This is due to
a race condition between reader aggregation and tasks changing states.

While it affects all states and all resources captured by PSI, in
practice it most likely triggers with CPU pressure, since scheduling
events are so frequent compared to other resource events.

The race context is the live snooping of ongoing stalls during a
pressure read. The read aggregates per-cpu records for stalls that
have concluded, but will also incorporate ad-hoc the duration of any
active state that hasn't been recorded yet. This is important to get
timely measurements of ongoing stalls. Those ad-hoc samples are
calculated on-the-fly up to the current time on that CPU; since the
stall hasn't concluded, it's expected that this is the minimum amount
of stall time that will enter the per-cpu records once it does.

The problem is that the path that concludes the state uses a CPU clock
read that is not synchronized against aggregators; the clock is read
outside of the seqlock protection. This allows aggregators to race and
snoop a stall with a longer duration than will actually be recorded.

With the recorded stall time being less than the last snapshot
remembered by the aggregator, a subsequent sample will underflow and
observe a bogus delta value, resulting in an erratic jump in pressure.

Fix this by moving the clock read of the state change into the seqlock
protection. This ensures no aggregation can snoop live stalls past the
time that's recorded when the state concludes.

Reported-by: Brandon Duffany <brandon@buildbuddy.io>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219194
Link: https://lore.kernel.org/lkml/20240827121851.GB438928@cmpxchg.org/
Fixes: df77430639c9 ("psi: Reduce calls to sched_clock() in psi")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 kernel/sched/psi.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..84dad1511d1e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -769,12 +769,13 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 }
 
 static void psi_group_change(struct psi_group *group, int cpu,
-			     unsigned int clear, unsigned int set, u64 now,
+			     unsigned int clear, unsigned int set,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
 	u32 state_mask;
+	u64 now;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
@@ -789,6 +790,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * SOME and FULL time these may have resulted in.
 	 */
 	write_seqcount_begin(&groupc->seq);
+	now = cpu_clock(cpu);
 
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
@@ -899,18 +901,15 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
-	now = cpu_clock(cpu);
-
 	group = task_psi_group(task);
 	do {
-		psi_group_change(group, cpu, clear, set, now, true);
+		psi_group_change(group, cpu, clear, set, true);
 	} while ((group = group->parent));
 }
 
@@ -919,7 +918,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 {
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
-	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
 		psi_flags_change(next, 0, TSK_ONCPU);
@@ -936,7 +934,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				break;
 			}
 
-			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
 		} while ((group = group->parent));
 	}
 
@@ -974,7 +972,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		do {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, now, wake_clock);
+			psi_group_change(group, cpu, clear, set, wake_clock);
 		} while ((group = group->parent));
 
 		/*
@@ -986,7 +984,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = group->parent)
-				psi_group_change(group, cpu, clear, set, now, wake_clock);
+				psi_group_change(group, cpu, clear, set, wake_clock);
 		}
 	}
 }
@@ -997,8 +995,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now, irq;
 	s64 delta;
+	u64 irq;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -1011,7 +1009,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	if (prev && task_psi_group(prev) == group)
 		return;
 
-	now = cpu_clock(cpu);
 	irq = irq_time_read(cpu);
 	delta = (s64)(irq - rq->psi_irq_time);
 	if (delta < 0)
@@ -1019,12 +1016,15 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	rq->psi_irq_time = irq;
 
 	do {
+		u64 now;
+
 		if (!group->enabled)
 			continue;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
 		write_seqcount_begin(&groupc->seq);
+		now = cpu_clock(cpu);
 
 		record_times(groupc, now);
 		groupc->times[PSI_IRQ_FULL] += delta;
@@ -1223,11 +1223,9 @@ void psi_cgroup_restart(struct psi_group *group)
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 		struct rq_flags rf;
-		u64 now;
 
 		rq_lock_irq(rq, &rf);
-		now = cpu_clock(cpu);
-		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_group_change(group, cpu, 0, 0, true);
 		rq_unlock_irq(rq, &rf);
 	}
 }
-- 
2.46.2



Return-Path: <linux-kernel+bounces-303262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390839609DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4811C22C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466141A0AEA;
	Tue, 27 Aug 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="et/z9bKm"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D741A01BC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761142; cv=none; b=sOSXKuy4BQa34ysPoBZzvVGXmGg8L07pK5wXOwk0mKjCBo+XkQFAErd5zMM5PpMGuhk3rADTLozXrWbFg6J8fAjQ0WQl9l4fEdg18NpfWPOSl9D10fRGUG4ltn7WWrU6sEjt+j8JjzQ714r8whzXVDaed/pWujaC5SMBQd1hMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761142; c=relaxed/simple;
	bh=L+w3VuaEDrwzK0tX5us3sHk7M+lej+aiGmyh8rPf5Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad27cyveFUIxOLLxy9+SnA44B9ru4+TuxX57ss4dDrqE/3bl9Y8ri/2NUKG9gZowdhXmi3wHuUUK2hy6VRU2R3jFBgsLhCxh/snTMWM/jr1boLxV3DKEKc5RN36qJ1Gx7pn+HCB7HC0RhZqmAn1mNw+Lr41MUdPe8LVDuIXbS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=et/z9bKm; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c09fd20eddso2501609a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1724761137; x=1725365937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8xjJWmPLQlupiBp2HbQ1GsjuXsvaJ4qBaIANBbAMQU=;
        b=et/z9bKmZW1wnZ8Cu520x0mM2DPRZlhgvn1nSe6mW94uyS/7EbsMsxa5jiRpKvwaUF
         adZBfrskdRDjqhi81hvvHEEs7NURtzTblQdX+yik23j+Hgzyaweppi+J6ybrQWBLo16Y
         n92G032gW1sxa6o6XBA0thqbrfeeZocfw3VOpLw8Uc7eqQCtKWu/SayZCvMjER0+gK/8
         GkV0gkIUpd01Q/NSV46R69sI34W5JGQxuhqTVlqryd9ucegNDKFhYcW8cf4u8koyTM6H
         nU5ccwWxdZTMtOCntXuWNm7rXef72ifTfIxNd+9jEtXPllJykNXNeQtaC4+jbZgvxzMF
         ZRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761137; x=1725365937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8xjJWmPLQlupiBp2HbQ1GsjuXsvaJ4qBaIANBbAMQU=;
        b=nYnE+sU3fyQnUX9Zng7rlV1dzFZChB8z8k1DMujqwSkt7VHoblsF7FzbuhG8lzbsqN
         xHxLflu8gd1yU54ZKNJPd+mPPiTlmGPoyoPb47Tw4W6KzMCgVMpuFvbg9dVjOZ24zJB2
         1EfL9WHyGhEI2I8BjfxvDdWiVAhLzWXslBYgDA1WuseXKGTldlRe4pTNQE64pld0qdIz
         5zF3k2j1fdZ7U+fWdVX7lSymdpt0MjI+WHI+aijNIFphiKj9vEoO+EAIpHBbYhO6ThWP
         n99C8vE+YwAe4Bkmjv0mbrMFmCL7L0NOdh5o2Bsg/VxZbmudXweJTnS9pE88LiLlng/b
         rZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfhZMmpL3TPcMLynpoCABfIL4b43OzY+26x28OpwvJfFahUpsz7escvJBZRK+7/C58EMq9mUqLzII00AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnlshLlfqXi2lyl4EaVjUNLEEEH6wDP+SlCIefX7977vQOg5E
	rLPNkNLfxpzR8crdOJhWFo9V368ahnN1sfQKblzLLDg2MH+4TBHbtng833jBxDY=
X-Google-Smtp-Source: AGHT+IHXSxAdj9Xg1S9r/KjqKKlSBB3gSkKBbNgZ4MdagTFWjJgJ2k/rPRxU7CG0jpJkG3I78cgWbw==
X-Received: by 2002:a17:907:7d8d:b0:a7a:ab1a:2d71 with SMTP id a640c23a62f3a-a86e3d43261mr210945666b.59.1724761137128;
        Tue, 27 Aug 2024 05:18:57 -0700 (PDT)
Received: from localhost (ip-046-005-139-073.um12.pools.vodafone-ip.de. [46.5.139.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e548781csm103288266b.28.2024.08.27.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:18:56 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:18:51 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: bugzilla-daemon@kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shakeel Butt <shakeelb@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched: psi: fix bogus pressure spikes from aggregation race
Message-ID: <20240827121851.GB438928@cmpxchg.org>
References: <bug-219194-14699@https.bugzilla.kernel.org/>
 <20240826181900.GA3214@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826181900.GA3214@cmpxchg.org>

Sending a proper patch. Peter, can you please take this?

---

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
Fixes: df77430639c9 ("psi: Reduce calls to sched_clock() in psi")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
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
2.46.0


Return-Path: <linux-kernel+bounces-302025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214C795F8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59DC1F238E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C645D8002A;
	Mon, 26 Aug 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HKbZZKQz"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D12B677
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696351; cv=none; b=PzPNpONZQBLUVG3OpSpXPEewd5B3j2M7SVudm7Vs47/yxfHQRKzXb5JrEmZ3F522ylMORTTrP3uri1OjeMaLoIifjoZOApO/Kkl9pq5IyjE0thoyWbvQA/k1rubW9kzL+wq96bD4YJqI3HShgOASj+25IF3lpxh6FmrVCrF+jtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696351; c=relaxed/simple;
	bh=fr3n87uqzXFl9khU9HwXuoTtd2j4MJWxmMhb+L6QkYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv48zG29DRxQWxlPPSXUoior20TxKCax2pYrOufhTSudjCCAEdEJUIjkTdGrGjjUB8hb7vp1WQ0ha9vDiNwq/OQAt7ic9UeZSG1GCsX8yxBAQgtx3J8O4YFDwoDleP1Yfk3tA3+yA7jImNXKLzNyMRh+5pT9xUi52v1Fm+eIpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HKbZZKQz; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so5658758a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1724696346; x=1725301146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcZd+LHSZruXN3ccbiyxEH9/4HmykqRuLA/zHtu0Ok0=;
        b=HKbZZKQzJdQteyPfFHwxjkEqYdoQcB/Insk7WPIXvyyUdxVPuhbSItZy2T0YvN6vTy
         m5biyzJm3Wwh9SWnTMcoYkVShygtBcW1Y/twTaXKFnA+JJM6+wr0HfKxHthr7Oay4dDb
         ePI7Pq/JMXllCxSvvHc55kWJVyGgLjx0fR+/8LxxxRrSGPr70a13PPr14YD2vTycmtoz
         tspg499zQvLjaSJ8yeZ20Cs3WbY/HpIikPzwHB2x6B7akKj2uZvyr/33bQyYBzAFadhO
         PCdJn6VPQCtC6crAveLCT0knvLq6sXkQnCwToE2Yf4GpkM7O4CMBl5E0GljJOPyFdzEU
         h2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724696346; x=1725301146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcZd+LHSZruXN3ccbiyxEH9/4HmykqRuLA/zHtu0Ok0=;
        b=Q1kKaGm0XJsiDkpOJbkK8YtnWdG5e7FVhg1Z20rVufmOuGr6E9ekPN7IJLC/AjL+k5
         OUll7r4iYM2UkFbSY2WighwL8u005zhKP56AN30LgbGQSDM01aCq2btX30/Q05fwGd/9
         RgehcWhHQywCam5bx5zwco88GTZtnW59DtxAQKHyfmtIR2mUH6OlO0GfaiX95pzi3e3q
         i2mGo4e0q91/FJB/ZDTqzflhSkKuCwKfJFTuqA+MA+c+qMTfzDbuTwdDXSan0C3OfDk+
         3FM0HsZTKQLTyQi68iDpHdbaG5hwMxfeTU9Bw8NpSqt17jwNyPaUtnfBLmPArlqlpLEJ
         F0zg==
X-Forwarded-Encrypted: i=1; AJvYcCX45PXA2faIZAwU+5CojJo8eUFk/qaj8o+z62r0g6Gt/hUitsBeC1PC9qWyRPtMoKkqkL5lUs3P0rxj/mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSQGtlQHgyDgGjKUDQ4IifKkpabyxz/jkOlAldGvzNZnzGy7G
	Zz94WLNHTd+axGXXNnP/zeVK7eKiws4o8J/GsevbpnbgwCjoBuAisKrJqVlKU4JsGK2zf2jJyq4
	9peBv2vhA
X-Google-Smtp-Source: AGHT+IFp7FZgPDAMMd5QMww8EplS7CaF0MtqqIYU71Cs/i5eyOGppC8jFuCuntrQq+pSdgHPwnG7PQ==
X-Received: by 2002:a05:6402:34d6:b0:5a3:283d:b05a with SMTP id 4fb4d7f45d1cf-5c089171c7emr8353035a12.17.1724696346206;
        Mon, 26 Aug 2024 11:19:06 -0700 (PDT)
Received: from localhost (ip-046-005-139-073.um12.pools.vodafone-ip.de. [46.5.139.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb471f07sm34794a12.61.2024.08.26.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 11:19:05 -0700 (PDT)
Date: Mon, 26 Aug 2024 20:19:00 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: bugzilla-daemon@kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 219194] New: PSI full-stall duration reports nonsensically
 large value when reading pressure file too frequently
Message-ID: <20240826181900.GA3214@cmpxchg.org>
References: <bug-219194-14699@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-219194-14699@https.bugzilla.kernel.org/>

Hi Brandon,

On Mon, Aug 26, 2024 at 12:49:34AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219194
> 
>             Bug ID: 219194
>            Summary: PSI full-stall duration reports nonsensically large
>                     value when reading pressure file too frequently
>            Product: Other
>            Version: 2.5
>           Hardware: AMD
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: other_other@kernel-bugs.osdl.org
>           Reporter: brandon@buildbuddy.io
>                 CC: hannes@cmpxchg.org
>         Regression: No
> 
> Created attachment 306775
>   --> https://bugzilla.kernel.org/attachment.cgi?id=306775&action=edit
> Minimal reproducible example
> 
> The cumulative full-stall duration ("total" field) reported in
> /sys/fs/cgroup/.../cpu.pressure is occasionally nonsensically large - a value
> much longer than the total execution duration of the only process that was run
> in the cgroup.
> 
> Interestingly, the nonsensical value that it reports is often exactly 4.294967
> seconds. This value looks suspiciously like UINT32_MAX (4294967295) which made
> me think that this is a bug with PSI code rather than something I was doing
> wrong.

Thanks for reporting this. Your reproducer was immensely helpful in
tracking this down, much appreciated. With the below patch, I can no
longer trigger it. If at all possible, could you try it on your end?

It's a race condition between aggregator (reader) and a task changing
state. Specifically, it's an issue with the live state snooping: the
aggregator will add cpu_clock() - state_start to the sample of any
currently active states that have not been recorded yet. This makes
the aggregator get ahead of recorded task state, but we assume this is
okay because, as the state concludes, that delta we snooped ahead will
be incorporated back into the recorded times.

But there is a bug. When the state change concludes it reads
cpu_clock() before acquiring the seq write lock. This means an
aggregator can race and snoop ahead to a later clock value than the
one at which the state will conclude. The next aggregation will see a
negative delta and record a UINT_MAX - <race time> sample:

psi_group_change()               get_recent_times()
  now = cpu_clock() (X)

  <a few cycles pass>

                                 read_seqcount_begin()
                                 now = cpu_clock() (X+42)
                                 memcpy(times, groupc->times)
                                 !read_seqcount_retry()

                                 /* Snoops live state up to X+42 */
                                 if (state_mask & (1 << s))
                                   times[s] += now - state_start

				 delta = times[s] - groupc->times_prev[s]
                                 groupc->times_prev[s] = times[s]

                                 /* times_prev up to X+42 */

  write_seqcount_begin()
  /* concludes state ending at X */
  groupc->times[s] += now - state_start
  groupc->state_mask &= 1 << s
  write_seqcount_end()

                                 read_seqcount_begin()
                                 memcpy(times, groupc->times)
                                 !read_seqcount_retry()

                                 if (state_mask & (1 << s))
                                   ; /* nope, state concluded */

				 delta = times[s] - groupc->times_prev[s]
                                 /* times_prev ahead, sample is UINT_MAX-42 */

The solution is to move the clock read of the state change into the
locked section. This way, live snooping cannot get ahead of the time
at which the state will conclude:

---

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


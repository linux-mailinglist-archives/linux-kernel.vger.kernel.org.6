Return-Path: <linux-kernel+bounces-364239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9999CE79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C701F23CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5871ABEA2;
	Mon, 14 Oct 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NqPDnwSe"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D319E802
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917048; cv=none; b=LPMgP8ZXh5OmbDHOARi9+goUJfGDvcp1w7ono4O/Bxtzx4AycBln3WouNV4TJNQMfWrFLwfVyYYrCJawGxMcoNljWymrf3qZTq1OajzsdG/hrfrYzkHP9pVbqWdQAnG6QDbgAJekqdritVyVfKzCGmYndapfme/0p69gYKRvmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917048; c=relaxed/simple;
	bh=rNSLofclVVlDLziVzmKGEyFarWS274DEUsUY33rg0rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEulflDCDipXw55xrY8fVrIXxPKmC7EhfoT7nkhoQVyKtX6wSQ9/qeQRzTRaWFQVJySqzQAWoAbD82P5CcxIrmSIfPVdmuiA2Np0kX3b//00IXWsXsNCtjPc++RBAq1bSg5owBz9WprIE37Tn62WTgn1ZCBpCznhyD3s6XOK5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NqPDnwSe; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b10f2c24f0so506227585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728917044; x=1729521844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8+Eaka4yodQw63ewN28IGOimAmsphprlynPxP29NWY=;
        b=NqPDnwSeybCk7apRwDf44XMTZWHFa4ZaYddO/EwL8GnCqAv7wAMix38DuO+z/yQgym
         Vn90yqYZVCN7qZPpHoefFQX36lXjYSQD1dbHgWBOeZvTBcnxuImWNG92qf06pnbxfVUD
         MYKp+5slzWT0NhmWpBPst+tXdd2daGb+Th/3rCDAUx+dIZVBestTCU/eXyizVCwJ+fQr
         xU60C4O1VB3lEFi2d4Dx07s6wx3wil093ehwEWlei1q7R7WlLZ3crTydrjUSP/RNVO0b
         OgBF0oG1SJ872QIvJqu+Y6CXOHhLeCvwbiSeBjQondMO16lBMRhFYNFxT073fVJHVP6q
         MtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917044; x=1729521844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8+Eaka4yodQw63ewN28IGOimAmsphprlynPxP29NWY=;
        b=XnynbGHdkLlm1TKbtnIhSqRCdG2r/IOa+5oeVbMXOBzVVvO9RCCZ67q3fLnZ2bgUIO
         /id3PynXps+Ssw9B/tMEwcBr0GcPY6t8LE7G+tHggV8ph46eVg7VyH8CYc/fVCDWw/im
         Q7JT86+OPi2ORJ3d662HKUJx+Iag/c07WEfRRqZ+ZaXZffndZMs8RwPcG6z6ki+IETZx
         VoJXNFNpUiwEzmlm9DNBNDx68GhkgLiBYlGebRE3rf/frRLpmVfN+7bqWW1DWmdzKSPm
         Yw1gJVXs7EuF0jr3yWe2I2xPSqG7p+ZK46oM/qUc64z7ljI0xpIJ620qQttRBVvqfIdL
         7Aew==
X-Forwarded-Encrypted: i=1; AJvYcCX2wngVTZD63uaGNcSx3h9SHP8L3VVS82TyirI5gAC1lHbWlbo5v9533pL3PqwZy/DccFxP8xjAx4h6o34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+0wkZ3/usLxgsX4O+G+HxcTVWc7ndGn1IoICXfgVnDcVnJQvC
	lnnU5iYqc6gT/HrLm23QgM032kIRIkFvMVulsSAKcGPRBKY43JeoGJ0DhP6Igzo=
X-Google-Smtp-Source: AGHT+IG4z09y/IVx11c7WF6iK+anW7AiOx1+YCGeKGYvBPx9DjLa18/G88jda//QeiNpJPf29EABdw==
X-Received: by 2002:a05:620a:45a1:b0:7b1:1916:b77 with SMTP id af79cd13be357-7b121005d8fmr1282738085a.51.1728917043951;
        Mon, 14 Oct 2024 07:44:03 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148f07f4sm426250785a.65.2024.10.14.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:44:03 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:43:58 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bert Karwatzki <spasswolf@web.de>, regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Message-ID: <20241014144358.GB1021@cmpxchg.org>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
 <20241010130621.GH17263@noisy.programming.kicks-ass.net>
 <20241010193712.GC181795@cmpxchg.org>
 <20241011083323.GL17263@noisy.programming.kicks-ass.net>
 <20241011100803.GA331616@cmpxchg.org>
 <20241011103958.GO17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011103958.GO17263@noisy.programming.kicks-ass.net>

On Fri, Oct 11, 2024 at 12:39:58PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 11, 2024 at 06:08:03AM -0400, Johannes Weiner wrote:
> > Completely untested. But if it looks good, I'll send a proper patch.
> 
> Sure. Thanks for doing this.

Ok here goes. Built, booted and runtime-tested.

---

From 91f230caa0119877cb861047e1af1371bf00d908 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 11 Oct 2024 06:18:07 -0400
Subject: [PATCH] sched: psi: pass enqueue/dequeue flags to psi callbacks
 directly

What psi needs to do on each enqueue and dequeue has gotten more
subtle, and the generic sched code trying to distill this into a bool
for the callbacks is awkward.

Pass the flags directly and let psi parse them. For that to work, the
#include "stats.h" (which has the psi callback implementations) needs
to be below the flag definitions in "sched.h". Move that section
further down, next to some of the other accounting stuff.

This also puts the ENQUEUE_SAVE/RESTORE branch behind the psi jump
label, slightly reducing overhead when PSI=y but runtime disabled.

Link: https://lore.kernel.org/lkml/20241011083323.GL17263@noisy.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/core.c  | 12 +++++-----
 kernel/sched/sched.h | 56 ++++++++++++++++++++++----------------------
 kernel/sched/stats.h | 29 +++++++++++++++--------
 3 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 527502a86ff9..42cf181bf3ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2019,10 +2019,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	uclamp_rq_inc(rq, p);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
+	psi_enqueue(p, flags);
+
+	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_enqueue(rq, p);
-		psi_enqueue(p, flags & ENQUEUE_MIGRATED);
-	}
 
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
@@ -2039,10 +2039,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & DEQUEUE_SAVE)) {
+	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeue(rq, p);
-		psi_dequeue(p, !(flags & DEQUEUE_SLEEP));
-	}
+
+	psi_dequeue(p, flags);
 
 	/*
 	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588a8f00..bbda03f17126 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2085,34 +2085,6 @@ static inline const struct cpumask *task_user_cpus(struct task_struct *p)
 
 #endif /* CONFIG_SMP */
 
-#include "stats.h"
-
-#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
-
-extern void __sched_core_account_forceidle(struct rq *rq);
-
-static inline void sched_core_account_forceidle(struct rq *rq)
-{
-	if (schedstat_enabled())
-		__sched_core_account_forceidle(rq);
-}
-
-extern void __sched_core_tick(struct rq *rq);
-
-static inline void sched_core_tick(struct rq *rq)
-{
-	if (sched_core_enabled(rq) && schedstat_enabled())
-		__sched_core_tick(rq);
-}
-
-#else /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS): */
-
-static inline void sched_core_account_forceidle(struct rq *rq) { }
-
-static inline void sched_core_tick(struct rq *rq) { }
-
-#endif /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS) */
-
 #ifdef CONFIG_CGROUP_SCHED
 
 /*
@@ -3166,6 +3138,34 @@ extern void nohz_run_idle_balance(int cpu);
 static inline void nohz_run_idle_balance(int cpu) { }
 #endif
 
+#include "stats.h"
+
+#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
+
+extern void __sched_core_account_forceidle(struct rq *rq);
+
+static inline void sched_core_account_forceidle(struct rq *rq)
+{
+	if (schedstat_enabled())
+		__sched_core_account_forceidle(rq);
+}
+
+extern void __sched_core_tick(struct rq *rq);
+
+static inline void sched_core_tick(struct rq *rq)
+{
+	if (sched_core_enabled(rq) && schedstat_enabled())
+		__sched_core_tick(rq);
+}
+
+#else /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS): */
+
+static inline void sched_core_account_forceidle(struct rq *rq) { }
+
+static inline void sched_core_tick(struct rq *rq) { }
+
+#endif /* !(CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS) */
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 struct irqtime {
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 767e098a3bd1..8ee0add5a48a 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -127,21 +127,25 @@ static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
  * go through migration requeues. In this case, *sleeping* states need
  * to be transferred.
  */
-static inline void psi_enqueue(struct task_struct *p, bool migrate)
+static inline void psi_enqueue(struct task_struct *p, int flags)
 {
 	int clear = 0, set = 0;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	/* Same runqueue, nothing changed for psi */
+	if (flags & ENQUEUE_RESTORE)
+		return;
+
 	if (p->se.sched_delayed) {
 		/* CPU migration of "sleeping" task */
-		SCHED_WARN_ON(!migrate);
+		SCHED_WARN_ON(!(flags & ENQUEUE_MIGRATED));
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
 		if (p->in_iowait)
 			set |= TSK_IOWAIT;
-	} else if (migrate) {
+	} else if (flags & ENQUEUE_MIGRATED) {
 		/* CPU migration of runnable task */
 		set = TSK_RUNNING;
 		if (p->in_memstall)
@@ -158,17 +162,14 @@ static inline void psi_enqueue(struct task_struct *p, bool migrate)
 	psi_task_change(p, clear, set);
 }
 
-static inline void psi_dequeue(struct task_struct *p, bool migrate)
+static inline void psi_dequeue(struct task_struct *p, int flags)
 {
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	/*
-	 * When migrating a task to another CPU, clear all psi
-	 * state. The enqueue callback above will work it out.
-	 */
-	if (migrate)
-		psi_task_change(p, p->psi_flags, 0);
+	/* Same runqueue, nothing changed for psi */
+	if (flags & DEQUEUE_SAVE)
+		return;
 
 	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
@@ -176,6 +177,14 @@ static inline void psi_dequeue(struct task_struct *p, bool migrate)
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
 	 */
+	if (flags & DEQUEUE_SLEEP)
+		return;
+
+	/*
+	 * When migrating a task to another CPU, clear all psi
+	 * state. The enqueue callback above will work it out.
+	 */
+	psi_task_change(p, p->psi_flags, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
-- 
2.47.0



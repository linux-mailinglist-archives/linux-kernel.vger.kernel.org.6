Return-Path: <linux-kernel+bounces-278360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186DE94AF34
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716D3281C21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C713DBBE;
	Wed,  7 Aug 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ukQO2Jk1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE572F3E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053298; cv=none; b=MFAU34bGapc5Oq80/aTdJ4dTPrhVnridzDSjmRUxp+0dV1d27sIsGAKzC3ZS48ZxUNY6Aj8jc+yt7UbstgBTsOFAfmCCGigE8REfFTz+l124qMg0BzlBJtXKqXqOHV+oQQCyAy8TIsmQUUvcc6IUgZsSQ1a8+WrdYgtqN/U6buk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053298; c=relaxed/simple;
	bh=kCIyLOOFbn4F5/3I5A4FRrbL/WqjP0kPQlaMKgNpMlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBecbMWARBsUOVO0rn3HGLnOkz9KRxs41Fou9BK6zvMhMBWYaiTKTV+IfJnVURR+ZFvfj7oA2G6f1tnR/B4WyrgpVGSvmpdpxntQogJ1JdD3WYmMeZ6JSuJG0abCw/LfgjpKQFMRRVoUA2Tywhh3NpTEy1y6qtSKuPnacvmSFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ukQO2Jk1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LSmLnZAYSG6nJtNjA8UgvfkCVavDv7ujxtGDAW7Y4VE=; b=ukQO2Jk1trfFPs8cNV69iR/oHP
	KBb3ETBFF5OXmWBIbZyDRhIlDVW887DKGqWC4Pwl8Pv/rIOX4NyuFAGyg+D+XAS/jJDY9uIG0k9JJ
	oPWrmzt2F/+AEbLRSjpqWQIf1OhjFIzj65RWgNQ5g/Ki8keahtbj3KGarfvpMQhPMP1vHmADBbfzt
	UVx4z/oQP7J5cRBOXiB/BQprck3hM3/4qnQtLaB6Erk6lhE8Btp5+R+GpgoHm/noFfnOlNgEPeG8S
	0XvEpTFwk3l/k9cuFO1cQ9sHzWZYYoftiQEOX0DacjPJnwrb9t3ND9PMsZfyOiEoOfDVULn0ip0jx
	PiRUYQrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbkro-00000007if9-2Dcf;
	Wed, 07 Aug 2024 17:54:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 491A130033D; Wed,  7 Aug 2024 19:54:31 +0200 (CEST)
Date: Wed, 7 Aug 2024 19:54:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de,
	Mike Galbraith <efault@gmx.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Chunxin Zang <zangchunxin@lixiang.com>
Subject: Re: [PATCH 21/24] sched/eevdf: Allow shorter slices to wakeup-preempt
Message-ID: <20240807175431.GD31338@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.735459544@infradead.org>
 <1955C728-8266-41B6-92CA-CD0A13A0B79C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1955C728-8266-41B6-92CA-CD0A13A0B79C@gmail.com>

On Mon, Aug 05, 2024 at 08:24:24PM +0800, Chunxin Zang wrote:
> > On Jul 27, 2024, at 18:27, Peter Zijlstra <peterz@infradead.org> wrote:

> > +static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > +{
> > + if (!sched_feat(PREEMPT_SHORT))
> > + return false;
> > +
> > + if (curr->vlag == curr->deadline)
> > + return false;
> > +
> > + return !entity_eligible(cfs_rq, curr);
> > +}

> Can this be made more aggressive here? Something like , in the PREEMPT_SHORT
> + NO_RUN_TO_PARITY combination, it could break the first deadline of the current
> task. This can achieve better latency benefits in certain embedded scenarios, such as
> high-priority periodic tasks.

You are aware we have SCHED_DEADLINE for those, right?

Why can't you use that? and what can we do to fix that.

> +static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> +{
> + if (!sched_feat(PREEMPT_SHORT))
> + return false;
> +
> + if (sched_feat(RUN_TO_PARITY) && curr->vlag == curr->deadline)
> + return false;
> +
> + return !entity_eligible(cfs_rq, curr);
> +}

No, this will destroy the steady state schedule (where no tasks
join/leave) and make it so that all tasks hug the lag=0 state
arbitrarily close -- as allowed by the scheduling quanta.

Yes, it will get you better latency, because nobody gets to actually run
it's requested slice.

The goal really is for tasks to get their request -- and yes that means
you get to wait. PREEMPT_SHORT is already an exception to this rule, and
it is very specifically limited to wake-ups so as to retain as much of
the intended behaviour as possible.

> Additionally, if possible, could you please include my name in this patch? I spent over a
> month finding this solution and conducting the tests, and I hope to leave some trace of
> my efforts during that time. This is also one of the reasons why I love Linux and am eager
> to contribute to open source. I would be extremely grateful.

I've made it the below. Does that work for you?

---
Subject: sched/eevdf: Allow shorter slices to wakeup-preempt
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Sep 26 14:32:32 CEST 2023

Part of the reason to have shorter slices is to improve
responsiveness. Allow shorter slices to preempt longer slices on
wakeup.

    Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |

  100ms massive_intr 500us cyclictest NO_PREEMPT_SHORT

  1 massive_intr:(5)      | 846018.956 ms |   779188 | avg:   0.273 ms | max:  58.337 ms | sum:212545.245 ms |
  2 massive_intr:(5)      | 853450.693 ms |   792269 | avg:   0.275 ms | max:  71.193 ms | sum:218263.588 ms |
  3 massive_intr:(5)      | 843888.920 ms |   771456 | avg:   0.277 ms | max:  92.405 ms | sum:213353.221 ms |
  1 chromium-browse:(8)   |  53015.889 ms |   131766 | avg:   0.463 ms | max:  36.341 ms | sum:60959.230  ms |
  2 chromium-browse:(8)   |  53864.088 ms |   136962 | avg:   0.480 ms | max:  27.091 ms | sum:65687.681  ms |
  3 chromium-browse:(9)   |  53637.904 ms |   132637 | avg:   0.481 ms | max:  24.756 ms | sum:63781.673  ms |
  1 cyclictest:(5)        |  12615.604 ms |   639689 | avg:   0.471 ms | max:  32.272 ms | sum:301351.094 ms |
  2 cyclictest:(5)        |  12511.583 ms |   642578 | avg:   0.448 ms | max:  44.243 ms | sum:287632.830 ms |
  3 cyclictest:(5)        |  12545.867 ms |   635953 | avg:   0.475 ms | max:  25.530 ms | sum:302374.658 ms |

  100ms massive_intr 500us cyclictest PREEMPT_SHORT

  1 massive_intr:(5)      | 839843.919 ms |   837384 | avg:   0.264 ms | max:  74.366 ms | sum:221476.885 ms |
  2 massive_intr:(5)      | 852449.913 ms |   845086 | avg:   0.252 ms | max:  68.162 ms | sum:212595.968 ms |
  3 massive_intr:(5)      | 839180.725 ms |   836883 | avg:   0.266 ms | max:  69.742 ms | sum:222812.038 ms |
  1 chromium-browse:(11)  |  54591.481 ms |   138388 | avg:   0.458 ms | max:  35.427 ms | sum:63401.508  ms |
  2 chromium-browse:(8)   |  52034.541 ms |   132276 | avg:   0.436 ms | max:  31.826 ms | sum:57732.958  ms |
  3 chromium-browse:(8)   |  55231.771 ms |   141892 | avg:   0.469 ms | max:  27.607 ms | sum:66538.697  ms |
  1 cyclictest:(5)        |  13156.391 ms |   667412 | avg:   0.373 ms | max:  38.247 ms | sum:249174.502 ms |
  2 cyclictest:(5)        |  12688.939 ms |   665144 | avg:   0.374 ms | max:  33.548 ms | sum:248509.392 ms |
  3 cyclictest:(5)        |  13475.623 ms |   669110 | avg:   0.370 ms | max:  37.819 ms | sum:247673.390 ms |

As per the numbers the, this makes cyclictest (short slice) it's
max-delay more consistent and consistency drops the sum-delay. The
trade-off is that the massive_intr (long slice) gets more context
switches and a slight increase in sum-delay.

Chunxin contributed did_preempt_short() where a task that lost slice
protection from PREEMPT_SHORT gets rescheduled once it becomes
in-eligible.

[mike: numbers]
Co-Developed-by: Chunxin Zang <zangchunxin@lixiang.com>
Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Link: https://lkml.kernel.org/r/20240727105030.735459544@infradead.org
---
 kernel/sched/fair.c     |   64 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |    5 +++
 2 files changed, 61 insertions(+), 8 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -973,10 +973,10 @@ static void clear_buddies(struct cfs_rq
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if ((s64)(se->vruntime - se->deadline) < 0)
-		return;
+		return false;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -993,10 +993,7 @@ static void update_deadline(struct cfs_r
 	/*
 	 * The task has consumed its request, reschedule.
 	 */
-	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
-		clear_buddies(cfs_rq, se);
-	}
+	return true;
 }
 
 #include "pelt.h"
@@ -1134,6 +1131,38 @@ static inline void update_curr_task(stru
 		dl_server_update(p->dl_server, delta_exec);
 }
 
+static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+{
+	if (!sched_feat(PREEMPT_SHORT))
+		return false;
+
+	if (curr->vlag == curr->deadline)
+		return false;
+
+	return !entity_eligible(cfs_rq, curr);
+}
+
+static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
+				    struct sched_entity *pse, struct sched_entity *se)
+{
+	if (!sched_feat(PREEMPT_SHORT))
+		return false;
+
+	if (pse->slice >= se->slice)
+		return false;
+
+	if (!entity_eligible(cfs_rq, pse))
+		return false;
+
+	if (entity_before(pse, se))
+		return true;
+
+	if (!entity_eligible(cfs_rq, se))
+		return true;
+
+	return false;
+}
+
 /*
  * Used by other classes to account runtime.
  */
@@ -1157,6 +1186,7 @@ static void update_curr(struct cfs_rq *c
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
+	bool resched;
 
 	if (unlikely(!curr))
 		return;
@@ -1166,7 +1196,7 @@ static void update_curr(struct cfs_rq *c
 		return;
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	resched = update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -1184,6 +1214,14 @@ static void update_curr(struct cfs_rq *c
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
+
+	if (rq->nr_running == 1)
+		return;
+
+	if (resched || did_preempt_short(cfs_rq, curr)) {
+		resched_curr(rq);
+		clear_buddies(cfs_rq, curr);
+	}
 }
 
 static void update_curr_fair(struct rq *rq)
@@ -8611,7 +8649,17 @@ static void check_preempt_wakeup_fair(st
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 	/*
-	 * XXX pick_eevdf(cfs_rq) != se ?
+	 * If @p has a shorter slice than current and @p is eligible, override
+	 * current's slice protection in order to allow preemption.
+	 *
+	 * Note that even if @p does not turn out to be the most eligible
+	 * task at this moment, current's slice protection will be lost.
+	 */
+	if (do_preempt_short(cfs_rq, pse, se) && se->vlag == se->deadline)
+		se->vlag = se->deadline + 1;
+
+	/*
+	 * If @p has become the most eligible task, force preemption.
 	 */
 	if (pick_eevdf(cfs_rq) == pse)
 		goto preempt;
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -18,6 +18,11 @@ SCHED_FEAT(PLACE_REL_DEADLINE, true)
  * 0-lag point or until is has exhausted it's slice.
  */
 SCHED_FEAT(RUN_TO_PARITY, true)
+/*
+ * Allow wakeup of tasks with a shorter slice to cancel RESPECT_SLICE for
+ * current.
+ */
+SCHED_FEAT(PREEMPT_SHORT, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed


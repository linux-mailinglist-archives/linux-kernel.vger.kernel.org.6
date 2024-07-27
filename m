Return-Path: <linux-kernel+bounces-264105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760D93DF02
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717B61C216D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53880BF7;
	Sat, 27 Jul 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fgsHNGWw"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAE53362
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078148; cv=none; b=h/PZenOvodM2aQOu3tPXQNe+ozqc5cx7vkwgOiHuCWkq888EtAlYYURdkpc8o7G4DFfIR/NkBHUEN33NCOMKMwBglWy79tV4O6RxkRyZc0XCRAnZgCkkwQzByf8HxJ2ryYg2N1jCFF/jQvozIMs2Po6TwHU6+HWh/pCnQvgc2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078148; c=relaxed/simple;
	bh=Or4+uACR+jQL3H4G5GA++OAJ9Aj6g9B8faMTAV3niIc=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sgXdQ0E13mPZi9juZkd+UZQNILZDXXION2Fdbtd4oLjzZVQg1pnIUMoo8TEAvS1B0hT5a5fJLhNG2l/Ln6wty1kJfSox7NJvMDKmBb9v/mS84W1sedCbDoDRP2Ml0SeqEb691b+5QitN76DSfg0klKUyoKCLUS6tfO+GdBJTlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fgsHNGWw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=BxHbmBvcrkqr1ZyDmvxI/RrR7sTlnrHIdKc8vA7hhaE=; b=fgsHNGWwlfVWyS3sLj0i8Y9d11
	6bdonR1gkw4iYya1fz1uQVlcOdThRqpAXqJeAzNgz7LzhyVDyy/CEDhcXZDawklyIblTZ5uKcq4Yl
	pA8yBY9uOvOi47rG5BwLRUfKhSHYhXTdr14SDwyo02vKORVa9ORfJyXcIE8z38u5dmfxSCt0Da7JI
	9EaiXr7To1waMtqmwbGgCHefY3arcW0KiiCKcSfc796zMQSSe9nOF+qUof3vOkTY7lH/4TPrKG8hV
	v/8voreNVY+JV55YP1AAD1OfVqV1gl/gk8OXtuHpVgyczNdk30YHnWQj0ptBWckGMljaagA/vE18o
	aH/V8Z6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBh-00000004QN1-3hcV;
	Sat, 27 Jul 2024 11:02:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EEFEA307F59; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105030.735459544@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de,
 Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [PATCH 21/24] sched/eevdf: Allow shorter slices to wakeup-preempt
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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

[mike: numbers]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
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




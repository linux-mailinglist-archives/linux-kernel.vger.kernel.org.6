Return-Path: <linux-kernel+bounces-222616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03965910495
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B853282665
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C31AC79E;
	Thu, 20 Jun 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cWcASoEe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649246BF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887935; cv=none; b=Jgcyo/ZmXFvPQqMN1eB0N6H/bfDG+rsqBOFpz+c9/acQoAIzzOmnIvzvD0F2TP/svdK85LRa5wFKUsPOS/t05nAesWrUNoXWMQQ6l69/0VuWHtwls2kCP7eLQa+YJ0E4F9PBJILZZpTXtcsJISkGWsCF8CMSiXWx3oXsnfKBIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887935; c=relaxed/simple;
	bh=Nkr2TbOco4Tj5ehCCvFSa/gdpZxr4QI/95nA34o59GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6MiFhf0IH3F5SGLXDTXmi5lw/NOeC3EWiUFgBFa1ng52GGjfaDkCbyXAi39F5TYsWH/nojZL8lgGHFRjO3z5s1t6eLjmLxsJCAbZvtgxJdp7sBKiQr1aVvKteyu/L6he8Xf0XTYec+awhwMsyWJXLV7zzbEHYPLMl1uDQJf+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cWcASoEe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5RHPdovA/z7Hq2P/42bo3jHwkzpD5YMvXbXNmsoIgIU=; b=cWcASoEeTmK+MvCS6aKcmrwzSw
	xyQHnfnMPGyn8HSO3eWKSSkpLCAGqjcmnkUx+5VRVXoT4cuxg8Ax5RH3qE9jc9/rVfOrqJOmkBSrH
	ow5kcKv/1t1OFKRrvOHREJEM2qJZ3EhpG4mBFXrxEkCgSb+j50b8Bm3jXcFEAXY1svPL868T5eOqR
	DYrHwtc/V23QENqZS1QvcsV6HJNQZSCm78LqwMIGR3kONNYW84PFOGUU7bw6cRI7CKQMLSRZdAi2a
	UXcqzVsvhHK/s/AT/STjazhVXV/ccFsE0AWn8Ho28Xnn0GjWp+oUTzBwEDlo89HHMo77yxQJ3grOx
	af6Qk5Mw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKHGd-000000064cv-3ifT;
	Thu, 20 Jun 2024 12:51:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84FCF300CB9; Thu, 20 Jun 2024 14:51:55 +0200 (CEST)
Date: Thu, 20 Jun 2024 14:51:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yu.c.chen@intel.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, linux-kernel@vger.kernel.org, efault@gmx.de,
	kprateek.nayak@amd.com, jameshongleiwang@126.com,
	yangchen11@lixiang.com, zangchunxin@lixiang.com
Subject: Re: [PATCH v3] sched/fair: Preempt if the current process is
 ineligible
Message-ID: <20240620125155.GY31592@noisy.programming.kicks-ass.net>
References: <20240613131437.9555-1-spring.cxz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613131437.9555-1-spring.cxz@gmail.com>

On Thu, Jun 13, 2024 at 09:14:37PM +0800, Chunxin Zang wrote:
> ---
>  kernel/sched/fair.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..21ef610ddb14 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -745,6 +745,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	return vruntime_eligible(cfs_rq, se->vruntime);
>  }
>  
> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
> +	if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
> +	    entity_eligible(cfs_rq, se))
> +		return false;
> +
> +	return true;
> +}
> +
>  static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
>  {
>  	u64 min_vruntime = cfs_rq->min_vruntime;
> @@ -974,11 +983,13 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
>  /*
>   * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>   * this is probably good enough.
> + *
> + * return true if se need preempt
>   */
> -static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	if ((s64)(se->vruntime - se->deadline) < 0)
> -		return;
> +		return false;
>  
>  	/*
>  	 * For EEVDF the virtual time slope is determined by w_i (iow.
> @@ -995,10 +1006,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	/*
>  	 * The task has consumed its request, reschedule.
>  	 */
> -	if (cfs_rq->nr_running > 1) {
> -		resched_curr(rq_of(cfs_rq));
> -		clear_buddies(cfs_rq, se);
> -	}
> +	return true;
>  }
>  
>  #include "pelt.h"
> @@ -1157,6 +1165,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  {
>  	struct sched_entity *curr = cfs_rq->curr;
>  	s64 delta_exec;
> +	bool need_preempt;
>  
>  	if (unlikely(!curr))
>  		return;
> @@ -1166,12 +1175,17 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  		return;
>  
>  	curr->vruntime += calc_delta_fair(delta_exec, curr);
> -	update_deadline(cfs_rq, curr);
> +	need_preempt = update_deadline(cfs_rq, curr);
>  	update_min_vruntime(cfs_rq);
>  
>  	if (entity_is_task(curr))
>  		update_curr_task(task_of(curr), delta_exec);
>  
> +	if (need_preempt || check_entity_need_preempt(cfs_rq, curr)) {
> +		resched_curr(rq_of(cfs_rq));
> +		clear_buddies(cfs_rq, curr);
> +	}
> +
>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
>  }

Yeah sorry no. This will mess up the steady state schedule. At best we
can do something like the below which will make PREEMPT_SHORT a little
more effective I suppose.


--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -985,10 +985,10 @@ static void clear_buddies(struct cfs_rq
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
@@ -1005,10 +1005,7 @@ static void update_deadline(struct cfs_r
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
@@ -1168,6 +1165,8 @@ static void update_curr(struct cfs_rq *c
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	s64 delta_exec;
+	struct rq *rq;
+	bool resched;
 
 	if (unlikely(!curr))
 		return;
@@ -1177,13 +1176,23 @@ static void update_curr(struct cfs_rq *c
 		return;
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	resched = update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr))
 		update_curr_task(task_of(curr), delta_exec);
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
+
+	rq = rq_of(cfs_rq);
+	if (rq->nr_running == 1)
+		return;
+
+	if (resched ||
+	    (curr->vlag != curr->deadline && !entity_eligible(cfs_rq, curr))) {
+		resched_curr(rq);
+		clear_buddies(cfs_rq, curr);
+	}
 }
 
 static void update_curr_fair(struct rq *rq)


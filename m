Return-Path: <linux-kernel+bounces-317260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2096DBA0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7395F1F27D11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488319D06B;
	Thu,  5 Sep 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QY+VpAQp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AE194A52
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545955; cv=none; b=YXEh89yPzaxf6uo2uxo+0BeB7ljvgT7JU+PhDDPP+1Vo+BxknL0AwI7NXSldaxPNvWY6RuIsmTcTjxie4qKL9JkuN2tzDLk0nhMeoKD1sSnACt3YKMRwmqKlYyY2PxIvNwguMGRJ8v+pEVcfdaDxuTFUcuDxcyVJEuaJBE8Gnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545955; c=relaxed/simple;
	bh=m96oV0PjbrLqUAsLFkwBXLTKtlCyTVGdlbZazAHj+6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaZxSKrLWZ/xI7oLeHtm8zLPUl+WsPsibtE6RVAbbrXpuPdjYOPinvQGIGX1A4gKlSPEJiO6Ma09a6zc0SkMwd6BM0eoCJCJdPG05xkO2vwAw1NYo9PXcTaR2si1OqTB5IsrfyNUSAl1APuns6gyUatW8AhePlph7EkPv24K1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QY+VpAQp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fpkJiLFV7VL+qeUmcjpCuWP62nVh8aORiWjPUQz5x4g=; b=QY+VpAQptr28s/BvaCRbuRJsxZ
	AcxiWMQACBle3zSOIrBzbB24Xqr7P9pDkxOGt6NzseAGElRAB/xDXjP4+jT1WcFvkkNkkiDgrAvPw
	OYmCDe8gAM30i2VC1/q56wRh9GkkNf+VSwfea6A5iy5iAu+h6TJfPoq2UsS3NQN+OCfbKK7Lg1bju
	JDLisWKrJk796KOHVbW9243Z/jWJ9wzNlhkwXaVv7x/MbOQyM2AuKBbmYhzeQ5FYiA+S6tVbBCMwK
	6pfWKDbMFLs14jA4uNxUryqFvSc+B4bEZoNfTaPG5GBzm23HNaNvoLeJjHBZgL1jjDFzL6vvfNyb2
	y6M0J4bA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smDK6-00000000Uxw-1gkK;
	Thu, 05 Sep 2024 14:18:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D6AC300599; Thu,  5 Sep 2024 16:18:57 +0200 (CEST)
Date: Thu, 5 Sep 2024 16:18:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Luis Machado <luis.machado@arm.com>, mingo@redhat.com,
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Message-ID: <20240905141857.GO4723@noisy.programming.kicks-ass.net>
References: <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
 <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>

On Thu, Sep 05, 2024 at 03:02:44PM +0200, Dietmar Eggemann wrote:

> From 0d7e8d057f49a47e0f3f484ac7d41e047dccec38 Mon Sep 17 00:00:00 2001
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Thu, 5 Sep 2024 00:05:23 +0200
> Subject: [PATCH] kernel/sched: Fix util_est accounting for DELAY_DEQUEUE
> 
> Remove delayed tasks from util_est even they are runnable.
> 
> Exclude delayed task which are (a) migrating between rq's or (b) in a
> SAVE/RESTORE dequeue/enqueue.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1e693ca8ebd6..5c32cc26d6c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6948,18 +6948,19 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	int rq_h_nr_running = rq->cfs.h_nr_running;
>  	u64 slice = 0;
>  
> -	if (flags & ENQUEUE_DELAYED) {
> -		requeue_delayed_entity(se);
> -		return;
> -	}
> -
>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at
>  	 * the cfs_rq utilization to select a frequency.
>  	 * Let's add the task's estimated utilization to the cfs_rq's
>  	 * estimated utilization, before we update schedutil.
>  	 */
> -	util_est_enqueue(&rq->cfs, p);
> +	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
> +		util_est_enqueue(&rq->cfs, p);
> +
> +	if (flags & ENQUEUE_DELAYED) {
> +		requeue_delayed_entity(se);
> +		return;
> +	}
>  
>  	/*
>  	 * If in_iowait is set, the code below may not trigger any cpufreq
> @@ -7177,7 +7178,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>   */
>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	util_est_dequeue(&rq->cfs, p);
> +	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
> +		util_est_dequeue(&rq->cfs, p);
>  
>  	if (dequeue_entities(rq, &p->se, flags) < 0) {
>  		if (!rq->cfs.h_nr_running)

Thanks!


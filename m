Return-Path: <linux-kernel+bounces-206820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265CD900E33
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF122285FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C461552E4;
	Fri,  7 Jun 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN1sNR/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB51CAB5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800384; cv=none; b=R57KQK8GEBR6nruNsED4NRL3QQgOoIDKwYS6e2hO5s6qG5Wb1CTfvqudfY4/mA0dyTmoPCmPZ/VXg7UEgoWFQdUEq7p6toZFiTADk5INq/Eh4pa7H5umDb5/jvX79Fwfh5S+hduB9jiiVjN1ypesMZzr/RjZ5PCqaMAjcwTCvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800384; c=relaxed/simple;
	bh=GjJb35OraHi0SzFdMQYu8ta0vOZOofLfX73CdwH1hRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHpl89pPzAjBOZIZMqNp1fiDeM9ltdUCHLmX5Gh5157PGBPPLn4pzG5CEEa8Y0EcRFdFyN0s6dIYNlcS6uLVenpe6LFhamIKWX2T2CzzR3wyKQEGwAyjSRwv1OORm6CPhUiKuJKtAVkbh3/EYygCOE/L+vgvmc8KOTJhqDb42I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN1sNR/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39B2C2BBFC;
	Fri,  7 Jun 2024 22:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717800384;
	bh=GjJb35OraHi0SzFdMQYu8ta0vOZOofLfX73CdwH1hRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CN1sNR/hK2tkp1kTtzSZFm4lO60PkEXYuV/Z+2Fn3XGcJXpeznutuCCoR/8K+1hm3
	 0aZo0qUVG1FvY6xwNSfLA19KtLc4ZbBC0lD4c6E4bTWfxj4D6S4ynwYm3GRqALQUXS
	 zXpRLx0HvAcA75f0OtYeDBGPCPBNtqxyqMB8Bg8mz9HahqyLPWQGq7KtsZUedTYtsY
	 0wVQrrwjH2qCZFWluTe+r1MTVq5g0wT8W2FQ7FJH8gZtGo5wP/Ymh863GLI18Q9uwR
	 gFQlhbsPRkc9xxjvW6t7sSH4JmpLbWLth4Hd94PnziORQurGfFQV4mvyK1uJZIx9gH
	 ESqnBBLa3Na3w==
Date: Sat, 8 Jun 2024 00:46:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Cruz Zhao <CruzZhao@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH 1/2] timer: Use is_idle_task() check instead of
 idle_cpu() on irq exit
Message-ID: <ZmONvY8q_lVOdjvu@pavilion.home>
References: <20240530122401.3826022-1-zegao@tencent.com>
 <20240530122401.3826022-2-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240530122401.3826022-2-zegao@tencent.com>

Le Thu, May 30, 2024 at 08:24:00AM -0400, Ze Gao a écrit :
> idle_cpu() was initially introduced in irq_enter()/exit() to check
> whether an irq interrupts an idle cpu or not since commit
> 79bf2bb335b8 ("[PATCH] tick-management: dyntick / highres functionality")
> and at that time, it's implemented via a simple check if the curr
> of task of that rq is idle or not. And then commit 6378ddb59215 ("time:
> track accurate idle time with tick_sched.idle_sleeptime") uses the same
> check to do accurate idle time accounting.
> 
> But since commit 908a3283728d ("sched: Fix idle_cpu()"), idle_cpu()
> takes scheduler stats into consideration and becomes more constrained,
> and therefore it tells more than if we have interrupted an idle
> process but also whether a cpu is going to be idle or not since it
> takes queued tasks and queued to be woken tasks into account.
> 
> However for tick user, it is too much as now we only rely on this check
> to do nohz idle time accounting in tick_nohz_start_idle() just in case
> that tick_nohz_stop_idle() is called upon irq_enter() if we actually
> rupture an idle cpu(process). The use of idle_cpu() simply complicates
> things here, and the introduction of sched_core_idle_cpu() in
> commit 548796e2e70b ("sched/core: introduce sched_core_idle_cpu()")
> proves this.
> 
> The use of is_idle_task() just like in commit 0a8a2e78b7ee ("timer: Fix
> bad idle check on irq entry") helps to save one unnecessary fix for idle
> time accounting for the newly force idle state. Note this also preps for
> the remove of sched_core_idle_cpu() in the following patch.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  kernel/softirq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 02582017759a..24c7bf3c3f6c 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -617,7 +617,7 @@ static inline void tick_irq_exit(void)
>  	int cpu = smp_processor_id();
>  
>  	/* Make sure that timer wheel updates are propagated */
> -	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> +	if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_cpu(cpu)) {

The reason why there is a check here for idle_cpu() (or sched_core_idle_cpu())
is to avoid calling again tick_nohz_start_idle() and then again
tick_nohz_stop_idle() later from tick_nohz_idle_exit(). This can save two costly
calls to ktime_get() when a real task is waiting for the CPU. So any quick clue to
know if a task is going to be scheduled is good to get. And idle_cpu() gives
them all:

int idle_cpu(int cpu)
{
	struct rq *rq = cpu_rq(cpu);

	if (rq->curr != rq->idle)
		return 0;

// This is the necessary is_idle_task() check

	if (rq->nr_running)
		return 0;

// This tells if there is a real task pending. Ok that check
// is perhaps a bit redundant with need_resched()...

#ifdef CONFIG_SMP
	if (rq->ttwu_pending)
		return 0;
#endif

// This one tells if there is a remote wakeup pending for this CPU.
// And need_resched() doesn't tell about that yet...

	return 1;
}

So it looks to me that idle_cpu() is still a good fit at this place.
And sched_core_idle_cpu() doesn't bring more overhead since the static
key in sched_core_enabled() is rarely active (I guess...). And if it is,
then the check is even more simple.

Thanks.

>  		if (!in_hardirq())
>  			tick_nohz_irq_exit();
>  	}
> -- 
> 2.41.0
> 


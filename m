Return-Path: <linux-kernel+bounces-200697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12B8FB37F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E08281F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984741465A7;
	Tue,  4 Jun 2024 13:22:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5714658A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507330; cv=none; b=KKUmBe/SJuAoi1B9mjTq05ItjF+t2NbUTCRfiolD6Dcs+nejA/1hqEZDTsQkySdG+LIOcCgkFHg2hNgPfOwtFnpFWOFYtJixIVg6DrCHERtXmdSjsRBzlQOblm+wz/RFH84F/f5I36iTi0Rh06chKPW33V56Ahag+RwbW0vYp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507330; c=relaxed/simple;
	bh=8F/EhiLs2so7RVQUHfEcWAz1308jhOqznNqQJ8dKJgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ir0yYTQoW7Zupsbp/CYbP119h/8HiPdRdzDxC6sYlVpPdJMklgzZV1N3uFW+w8iWw1iaoHkGw2tw1QdjfnZWijEaf5EvY5DHzxP74sXtM9PtPcPnMR+QWKbsWwn5KE47G06UhHu2GuJYsRayA8KnheMIgZYgHuSZjI0M0s8L44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8D1C2BBFC;
	Tue,  4 Jun 2024 13:22:06 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:22:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/rt: Use 'back' only if CONFIG_RT_GROUP_SCHED
 is enabled
Message-ID: <20240604092203.7c31b7b5@gandalf.local.home>
In-Reply-To: <20240603125002.3086-2-yajun.deng@linux.dev>
References: <20240603125002.3086-1-yajun.deng@linux.dev>
	<20240603125002.3086-2-yajun.deng@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Jun 2024 20:50:01 +0800
Yajun Deng <yajun.deng@linux.dev> wrote:

> The 'back' member in struct sched_rt_entity only related to
> CONFIG_RT_GROUP_SCHED, so there is no need to init it in dequeue_rt_stack.
> 
> Init the 'back' member in init_tg_rt_entry and use it only if
> CONFIG_RT_GROUP_SCHED is enabled.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  kernel/sched/rt.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 63e49c8ffc4d..44bb9087cfe5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -232,8 +232,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
>  
>  	if (!parent)
>  		rt_se->rt_rq = &rq->rt;
> -	else
> +	else {
>  		rt_se->rt_rq = parent->my_q;
> +		parent->back = rt_se;
> +	}

If one block of an if/else requires brackets, then both do.


>  
>  	rt_se->my_q = rt_rq;
>  	rt_se->parent = parent;
> @@ -1428,16 +1430,19 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>  	struct sched_rt_entity *back = NULL;
>  	unsigned int rt_nr_running;
>  
> -	for_each_sched_rt_entity(rt_se) {
> -		rt_se->back = back;
> +	for_each_sched_rt_entity(rt_se)
>  		back = rt_se;
> -	}
>  
>  	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
>  
> -	for (rt_se = back; rt_se; rt_se = rt_se->back) {
> +	for (rt_se = back; rt_se; ) {
>  		if (on_rt_rq(rt_se))
>  			__dequeue_rt_entity(rt_se, flags);
> +#ifdef CONFIG_RT_GROUP_SCHED
> +		rt_se = rt_se->back;
> +#else
> +		rt_se = NULL;
> +#endif

Perhaps make a helper function to get rid of the #ifdef in the code here.

	for (rt_se = back, rt_se; rt_se = rt_se_back(rt_se)) {

Where rt_se_back() above can be defined in the #ifdef blocks for
CONFIG_RT_GROUP_SCHED as either:

static struct sched_rt_entity *rt_se_back(struct sched_rt_entity *se)
{
	return se->back;
}

Or

static inline struct sched_rt_entity *rt_se_back(struct sched_rt_entity *se)
{
	return NULL;
}

-- Steve


>  	}
>  
>  	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);



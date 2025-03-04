Return-Path: <linux-kernel+bounces-545512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC79A4EE0B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397AC188E554
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B325F99E;
	Tue,  4 Mar 2025 20:05:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED531F37C3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118739; cv=none; b=AxKAW3QaYvk6F5XEOJUN6ReHl8HoClc4a1JJ20/qRPQ03W5xWYLG+ryDO4IAoQ4QBq4fASt5v81o3T98SEepEF4lMZfRvMgZJlCRBhH3VukfRN+kQB4XDqWG/DT1/xyCGAqeVjzDxIPM/DCYzX8DR2Dp9A9VJcPd6tkl3GlHYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118739; c=relaxed/simple;
	bh=HD8ypumj05SI70iNWRl3GpfKyQzpVZHWTo/7ssUWRAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppTl3eG992s7QeRlBO8L/tcaDpd9sNsEDWlozbI78Zt1WL6IOnuiF8OARtP1/bS95f/sHNjeZmFgnjTmUbjIc7Xctc9bQ/JAGRtvxbI+GUhiNDN4ky93fTVvRbKnWkeTOAzbocC7zAko94pSPhtRv2/fJaas442zU0qeAeho8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C78C4CEE8;
	Tue,  4 Mar 2025 20:05:38 +0000 (UTC)
Date: Tue, 4 Mar 2025 15:06:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched: Disable DL server if sysctl_sched_rt_runtime
 is -1
Message-ID: <20250304150632.3fde716c@gandalf.local.home>
In-Reply-To: <20250304200116.2210119-1-joelagnelf@nvidia.com>
References: <20250304200116.2210119-1-joelagnelf@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 15:01:16 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> Currently, RCU boost testing in rcutorture is broken because it relies on
> having RT throttling disabled. This means the test will always pass (or
> rarely fail). This occurs because recently, RT throttling was replaced
> by DL server which boosts CFS tasks even when rcutorture tried to
> disable throttling (see rcu_torture_disable_rt_throttle()).
> 
> Therefore this patch prevents DL server from starting when RC torture
> sets the sysctl_sched_rt_runtime to -1.
> 
> With this patch, boosting in TREE09 fails more than 50% of boost attempts
> making the test more useful.
> 
> Also add a check of this to task_non_contending() because otherwise it
> throws a warning (in the case when DL server was already started before
> rcutorture started).
> 

Hmm, I wonder if dl_server caused a regression. That is, disabling rt
throttling should allow RT tasks to starve anything it wants. And some RT
applications rely on this.

Should this include a Fixes and Cc stable?

-- Steve


> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/deadline.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 38e4537790af..09c5139a3183 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -448,7 +448,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
>  	if (dl_entity_is_special(dl_se))
>  		return;
>  
> -	WARN_ON(dl_se->dl_non_contending);
> +	WARN_ON(dl_se->dl_non_contending && rt_bandwidth_enabled());
>  
>  	zerolag_time = dl_se->deadline -
>  		 div64_long((dl_se->runtime * dl_se->dl_period),
> @@ -1648,6 +1648,13 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>  {
>  	struct rq *rq = dl_se->rq;
>  
> +	/*
> +	 * Prevent dl_server from starting if RT bandwidth is not enabled.
> +	 * This is used by test code to test RCU boosting.
> +	 */
> +	if (!rt_bandwidth_enabled())
> +		return;
> +
>  	/*
>  	 * XXX: the apply do not work fine at the init phase for the
>  	 * fair server because things are not yet set. We need to improve



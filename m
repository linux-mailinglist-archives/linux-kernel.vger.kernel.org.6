Return-Path: <linux-kernel+bounces-525947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36DA3F7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07E08617D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36951209671;
	Fri, 21 Feb 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCDEjzNH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807553AC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149361; cv=none; b=DDvff9ZA2SspbrzLFL8HzBdc7e/YhSykZe0z+tZRfNShrhsrhpTMw+pv7SxxO6ld/ZR0U6R8zPn3oIbTWNuLRchZAMeLpH50upjed0N7J0Wd/s8BUoeioy35o63rlgG2REZlSgm7oPVNyThdnDTQKEOL5ANctsilnQxCg7l03pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149361; c=relaxed/simple;
	bh=jNIwMrKuas8S5bhOgu1FnGuVIiAseKlTQwoMMcQYYHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP6udHluIDvdJl4glLrT1rufNt1VieQfc6ncO7PA2ChIIEOfY/kWCymTV4M2ZavfASAxIRCX5PAp7DZs8326JJCqyIqke8V+g5lih8vakmFdOTjEAu7nzADpkZfT6CxKl6nS4iNe8YS+mzn9UOy8KogCUqjlVtbzRRPuPgdsy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCDEjzNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA5AC4CED6;
	Fri, 21 Feb 2025 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740149361;
	bh=jNIwMrKuas8S5bhOgu1FnGuVIiAseKlTQwoMMcQYYHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCDEjzNHHa5lsZd7drnFO7Gc3rFS8WG830+zZSl0TKMtK5+39bEb8FHHanlsAgA5U
	 YPWwnV67WTHJpBAx3H0DXKnhLKsfHgmtW8xnEasNOh6bc9SjlQF24VhFdYExaPOW6G
	 XemqVrPmz6UK6prsbeaYJQKY5cdeCHqni/opJ2MYB+2Gnib9y3flsEGWiPyPkUG05A
	 5Ybn1UYboaipNKQDF/8TdNDqKNCCC/PZNWVdYbXdKYqgsl9rTB1GQJZXcYvXSpr3ea
	 u/aRr0+i2aQ1TilAZPGhLuFAWzmwXOW3auBepEquO0q1jLspJHPQrt+gBbUSI0Rtff
	 5A2pkdTWXQuNg==
Date: Fri, 21 Feb 2025 15:49:18 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: open list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] workqueue: Always use wq_select_unbound_cpu() for
 WORK_CPU_UNBOUND.
Message-ID: <Z7iSboU-05uMJ7-e@localhost.localdomain>
References: <20250221112003.1dSuoGyc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221112003.1dSuoGyc@linutronix.de>

Le Fri, Feb 21, 2025 at 12:20:03PM +0100, Sebastian Andrzej Siewior a écrit :
> If the user did not specify a CPU while enqueuing a work item then
> WORK_CPU_UNBOUND is passed. In this case, for WQ_UNBOUND a CPU is
> selected based on wq_unbound_cpumask while the local CPU is preferred.
> For !WQ_UNBOUND the local CPU is selected.
> For NOHZ_FULL system with isolated CPU wq_unbound_cpumask is set to the
> not isolated (housekeeping) CPUs. This leads to different behaviour if a
> work item is scheduled on an isolated CPU where
> 	schedule_delayed_work(, 1);
> 
> will move the timer to the housekeeping CPU and then schedule the work
> there (on the housekeeping CPU) while
> 	schedule_delayed_work(, 0);
> 
> will schedule the work item on the isolated CPU.
> 
> The documentation says WQ_UNBOUND prefers the local CPU. It can
> preferer the local CPU if it is part of wq_unbound_cpumask.
> 
> Restrict WORK_CPU_UNBOUND to wq_unbound_cpumask via
> wq_select_unbound_cpu().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I really would like to have this patch in. I have considered
doing that a few month ago but got sort-of discouraged by the
lack of properly defined semantics for schedule_work(). And that
function has too many users to check their locality assumptions.

Its headers advertize to queue in global workqueue but the target
is system_wq and not system_unbound_wq. But then it's using
WORK_CPU_UNBOUND through queue_work().

I'm tempted to just assume that none of its users depend on the
work locality?

Thanks.

> ---
>  kernel/workqueue.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bfe030b443e27..134d9550538aa 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2261,12 +2261,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>  	rcu_read_lock();
>  retry:
>  	/* pwq which will be used unless @work is executing elsewhere */
> -	if (req_cpu == WORK_CPU_UNBOUND) {
> -		if (wq->flags & WQ_UNBOUND)
> -			cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> -		else
> -			cpu = raw_smp_processor_id();
> -	}
> +	if (req_cpu == WORK_CPU_UNBOUND)
> +		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
>  
>  	pwq = rcu_dereference(*per_cpu_ptr(wq->cpu_pwq, cpu));
>  	pool = pwq->pool;
> -- 
> 2.47.2
> 


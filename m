Return-Path: <linux-kernel+bounces-424745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093559DB8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D87B164DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B81B0F2C;
	Thu, 28 Nov 2024 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQMHnUY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294261AA1D9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800995; cv=none; b=T7eevJs3hgH/0/Q9AoQjVAj7ovLsTg6cxRQ5p7x1aC1BpJT9SzFJlkUf/nvCBlkrWNwMQdYeBQwY2i84HRaM2cjrThbd0vJ1b7ADw4HaLBdFmCoq0hV/KZ7+asmz3r7vjw4C1gsWVxcEYKAjCM1ClHs94MtUmw/rkIk0AmQT6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800995; c=relaxed/simple;
	bh=SmMxN2iy/s8LehxiSAuj2uj0HwcRFK1rE/t+bwJiiYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUn2IYx9QNwjIuQ42lB59RnAFKW1Fq4xaQg9e5lEc/yvOzMRx2EpJqUCnsKGWYmRmQh3yNXO3QsWhYmmJA0yCz30K4iZfM2WiQxCDBlw0CVvH6gdBUWcxb6rvU2oI5ez1aio02bQLmK5CgZ6thQWYmFQ7WrcGnDIm0LTJ/zq2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQMHnUY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF7C4CECE;
	Thu, 28 Nov 2024 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732800994;
	bh=SmMxN2iy/s8LehxiSAuj2uj0HwcRFK1rE/t+bwJiiYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQMHnUY4LgpaSDlF+nksaE3f4khylQInfcTfDl+zuvs8r+FZx1RvF3bsgSfHgJedM
	 ZrD317ENyPwV8qOlFQLZifJPC1Nt9B9uJroabUEZC6T0BBJqZy6k3Z+dg6HOACAOyB
	 gAlR1HSp3i6JmU9DSthLINdzgyI/Zb7YwAv9z8oamrn1bgF++/AwGftg2YJ6Yh+eN3
	 GM1X1jR6jk9asFtby+AtTia5ejNrQDdaJ2TR3ixP0POOE6OEl4bQSybHGR5yggzgxq
	 Won/34ajHhXhp6nXXgkK+2uXnnzp1fr3EEbE13UsYRBHJJYsjTaKOA7WVR8tHzq9R4
	 j5VbE/VHksFZw==
Date: Thu, 28 Nov 2024 14:36:31 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 4/6] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <Z0hx34Cjw1X0r1lo@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106201758.428310-5-ankur.a.arora@oracle.com>

Le Wed, Nov 06, 2024 at 12:17:56PM -0800, Ankur Arora a écrit :
> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> states for read-side critical sections via rcu_all_qs().
> One reason why this was needed, was lacking preempt-count, the tick
> handler has no way of knowing whether it is executing in a read-side
> critical section or not.
> 
> With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
> PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
> quiescent states via rcu_all_qs().
> 
> So, use the availability of preempt_count() to report quiescent states
> in rcu_flavor_sched_clock_irq().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/rcu/tree_plugin.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1c7cbd145d5e..da324d66034b 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -974,13 +974,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>   */
>  static void rcu_flavor_sched_clock_irq(int user)
>  {
> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> +	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> +	      !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {

I'm never sure if nested hardirqs are still possible but just in case,

    preempt_count() == HARDIRQ_OFFSET

might be a more robust check. And that also applies to the PREEMPT_RCU
implementation.

Thanks.

>  
>  		/*
>  		 * Get here if this CPU took its interrupt from user
> -		 * mode or from the idle loop, and if this is not a
> -		 * nested interrupt.  In this case, the CPU is in
> -		 * a quiescent state, so note it.
> +		 * mode, from the idle loop without this being a nested
> +		 * interrupt, or while not holding a preempt count (but
> +		 * with PREEMPT_COUNT=y. In this case, the CPU is in a
> +		 * quiescent state, so note it.
>  		 *
>  		 * No memory barrier is required here because rcu_qs()
>  		 * references only CPU-local variables that other CPUs
> -- 
> 2.43.5
> 


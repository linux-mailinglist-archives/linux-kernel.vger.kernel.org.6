Return-Path: <linux-kernel+bounces-422459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F7E9D99EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20394B24CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551621D47DC;
	Tue, 26 Nov 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmu2lsvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3A28F5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632546; cv=none; b=uEd4ARS46GNrnAh0PUobqiEedVeHnBzJgbxBaqyuy9t12V0IsVAW2A1OgD4twW93L/zUSXDB+ipjFH7gkM9HZ9obomVh2rmtpla9aIryISqkm7QgjR21g25LkTfrUiESdmA/YC+f36Z37SL7v/xzAZaVFPGrrgrqU8mSX8cx0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632546; c=relaxed/simple;
	bh=V2Prx3tc7mzdHx38TeBwxLsWpp9WJ4nCQc4P7aZB7RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jut3Q2gUHs7xgKCTAIW0+bR4nTTHcGTafe+CWvQJV8GI9vqFwUK9GDsCNEd6qkbjdOy1J2LE3/MECOpopLaY+IFU6V9dE083BFy1CcWmOJW9tE9hiGkQ6r/fBVZOR8T9EYMbErMCIUpxONO/A30RhqOhHDT+nzfb6hlla26lMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmu2lsvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F87C4CECF;
	Tue, 26 Nov 2024 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732632546;
	bh=V2Prx3tc7mzdHx38TeBwxLsWpp9WJ4nCQc4P7aZB7RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmu2lsvzgrcqY3HSdI5/5JamL2ESYunnaSGj1bAbiBh+p49YmtpfRk1OvGzFNYrH/
	 4WrNPgr0P5dKRQt2CQi/8O+1PlmFBMSdllIHB/qH7RCHyXOAXIKgIteckvUQ2DWE6V
	 VRlWfXbohPfEbb0DWPB3dacvR7YTmSxnWBvof9036CUmz0ZaPaQOBO9zhh3n9k9zqb
	 veFlZ+exCh4rfetV1NI7amJtdoVjETGHoiVVTBP8adD8CMOAZOADQDglgvsVa/g6is
	 OqxUpM53dtAs8d4k12+iXT8kXBzbxPm7GCNjJLwcAqLc8zsAmbmkIHRZ/d9RsWKMr1
	 V2RVjI3kNvgRQ==
Date: Tue, 26 Nov 2024 15:49:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
Message-ID: <Z0Xf37hJiyA7O0Ye@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
 <87serfgffs.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87serfgffs.fsf@oracle.com>

Le Mon, Nov 25, 2024 at 01:40:39PM -0800, Ankur Arora a écrit :
> 
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a écrit :
> >> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
> >> which allows for dynamic switching of preemption models.
> >>
> >> The choice of PREEMPT_RCU or not, however, is fixed at compile time.
> >>
> >> Given that PREEMPT_RCU makes some trade-offs to optimize for latency
> >> as opposed to throughput, configurations with limited preemption
> >> might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.
> >>
> >> Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
> >> preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
> >> model PREEMPT_DYNAMIC.
> >>
> >> This means the throughput oriented models, PREEMPT_NONE,
> >> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=n.
> >>
> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  kernel/rcu/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> >> index 5a7ff5e1cdcb..9d52f87fac27 100644
> >> --- a/kernel/rcu/Kconfig
> >> +++ b/kernel/rcu/Kconfig
> >> @@ -18,7 +18,7 @@ config TREE_RCU
> >>
> >>  config PREEMPT_RCU
> >>  	bool
> >> -	default y if PREEMPTION
> >> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> >>  	select TREE_RCU
> >>  	help
> >>  	  This option selects the RCU implementation that is
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >
> > But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
> > some issues now that the code can be preemptible. Well I think
> > it has always been preemptible but PREEMPTION && !PREEMPT_RCU
> > has seldom been exerciced (or was it even possible?).
> >
> > For example rcu_read_unlock_strict() can be called with preemption
> > enabled so we need the following otherwise the rdp is unstable, the
> > norm value becomes racy (though automagically fixed in rcu_report_qs_rdp())
> > and rcu_report_qs_rdp() might warn.
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 58d84c59f3dd..368f00267d4e 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
> >
> >  static inline void __rcu_read_unlock(void)
> >  {
> > -	preempt_enable();
> >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> >  		rcu_read_unlock_strict();
> > +	preempt_enable();
> >  }
> >
> >  static inline int rcu_preempt_depth(void)
> 
> Based on the discussion on the thread, how about keeping this and
> changing the preempt_count check in rcu_read_unlock_strict() instead?
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1c7cbd145d5e..8fc67639d3a7 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -831,8 +831,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>  void rcu_read_unlock_strict(void)
>  {
>         struct rcu_data *rdp;
> +       int pc = ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHIFT);

This should be in_atomic_preempt_off(), otherwise softirqs and IRQs are
spuriously accounted as quiescent states.

Thanks.

> 
> -       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> +       /*
> +        * rcu_report_qs_rdp() can only be invoked with a stable rdp and
> +        * and from the local CPU.
> +        * With CONFIG_PREEMPTION=y, do this while holding the last
> +        * preempt_count which gets dropped after __rcu_read_unlock().
> +        */
> +       if (irqs_disabled() || pc > 1 || !rcu_state.gp_kthread)
>                 return;
>         rdp = this_cpu_ptr(&rcu_data);
>         rdp->cpu_no_qs.b.norm = false;
> 
> 
> Thanks
> 
> --
> ankur


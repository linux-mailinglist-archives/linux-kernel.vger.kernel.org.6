Return-Path: <linux-kernel+bounces-425646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCB49DE85A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23292B213FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB74208CA;
	Fri, 29 Nov 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTIjrVgX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEE4C9D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890136; cv=none; b=q13uqIq3CRXq6bxMSTjvVCSOTdy3uNMRXuZ27gECEXqkF8/DN57EYtQL0p3TZWsUmS+L/GOeq1T3sG9lmktxIYtiScXzzGL/uEvl2HhAKNpsGDyw+igVhlxcD1AAoHosBTVkIS9hy10m7t/DJieweBF+MmyN1ml5tdVsBzeNHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890136; c=relaxed/simple;
	bh=L+79NtBaXOkU3W8AJSCPup/ZJ4h5o0GoneQ42SV9ZnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWR1dQ6Y5cH1RC7K5IWsW+P/REc1copMqpzIoeyw7wB9qlZomDxKk1/QLShHQomIW27rFBYaDEbszbHn960e9hQRoUYb4MA4zsvnH9+gsSl+kbqSM1ZoLUAAIPtrM3I0SJH07zh8QVEx89WJqVxSUZZi7/mJtLf1+Wvzrn1x8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTIjrVgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6871FC4CECF;
	Fri, 29 Nov 2024 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732890135;
	bh=L+79NtBaXOkU3W8AJSCPup/ZJ4h5o0GoneQ42SV9ZnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTIjrVgXPH+ioB3hV89R2WiJSRueJBerz9ov+AJbCx4sQ1umWPpptsWHrz37u4bld
	 eLxMlWwIw5cmetKqXSt5MI687SmZVsfxMSdr4aKtFqZvL1lUNvZn9yknrNMUbGynXb
	 rKF016P2FJG0zZZgHKGAOnzk5X51KhDPspo/iYQc/oZJyiHgoZ1TpY0PdLQjoyY6X4
	 HC1Egd5Ckq1N060Y0GcviWfx3Q5uKxbwkRoCfi6dJ8cNhJgWu5BH+9U5ZHxmMlHOPX
	 621koB91P8EL1yBpodLU9T/5kuvopOe6aYtvZM40VfbPeaapgNs5mTpVfY1aGKUTIm
	 OTsu+MUzpDTTw==
Date: Fri, 29 Nov 2024 15:22:12 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 5/6] osnoise: handle quiescent states for
 PREEMPT_RCU=n, PREEMPTION=y
Message-ID: <Z0nOFDt_Y370pyew@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-6-ankur.a.arora@oracle.com>
 <Z0h_KMzCCx2umo6h@localhost.localdomain>
 <87seraeimb.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87seraeimb.fsf@oracle.com>

Le Thu, Nov 28, 2024 at 09:03:56PM -0800, Ankur Arora a écrit :
> 
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Wed, Nov 06, 2024 at 12:17:57PM -0800, Ankur Arora a écrit :
> >> To reduce RCU noise for nohz_full configurations, osnoise depends
> >> on cond_resched() providing quiescent states for PREEMPT_RCU=n
> >> configurations. And, for PREEMPT_RCU=y configurations does this
> >> by directly calling rcu_momentary_eqs().
> >>
> >> With PREEMPT_LAZY=y, however, we can have configurations with
> >> (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
> >> can help.
> >>
> >> Handle that by fallback to the explicit quiescent states via
> >> rcu_momentary_eqs().
> >>
> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
> >>  1 file changed, 12 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> >> index a50ed23bee77..15e9600d231d 100644
> >> --- a/kernel/trace/trace_osnoise.c
> >> +++ b/kernel/trace/trace_osnoise.c
> >> @@ -1538,18 +1538,20 @@ static int run_osnoise(void)
> >>  		/*
> >>  		 * In some cases, notably when running on a nohz_full CPU with
> >>  		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
> >> -		 * This will eventually cause unwarranted noise as PREEMPT_RCU
> >> -		 * will force preemption as the means of ending the current
> >> -		 * grace period. We avoid this problem by calling
> >> -		 * rcu_momentary_eqs(), which performs a zero duration
> >> -		 * EQS allowing PREEMPT_RCU to end the current grace period.
> >> -		 * This call shouldn't be wrapped inside an RCU critical
> >> -		 * section.
> >> +		 * This will eventually cause unwarranted noise as RCU forces
> >> +		 * preemption as the means of ending the current grace period.
> >> +		 * We avoid this by calling rcu_momentary_eqs(), which performs
> >> +		 * a zero duration EQS allowing RCU to end the current grace
> >> +		 * period. This call shouldn't be wrapped inside an RCU
> >> +		 * critical section.
> >>  		 *
> >> -		 * Note that in non PREEMPT_RCU kernels QSs are handled through
> >> -		 * cond_resched()
> >> +		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
> >> +		 * PREEMPT_LAZY configurations), QSs are handled through
> >> +		 * cond_resched(). For PREEMPT_LAZY kernels, we fallback to
> >> +		 * the zero duration QS via rcu_momentary_eqs().
> >>  		 */
> >> -		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
> >> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
> >> +		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTION))) {
> >>  			if (!disable_irq)
> >>  				local_irq_disable();
> >
> > How about making this unconditional so it works everywhere and doesn't
> > rely on cond_resched() Kconfig/preempt-dynamic mood?
> 
> I think it's a minor matter given that this isn't a hot path, but
> we don't really need it for the !PREEMPT_RCU configuration.

Well if you make it unconditional, cond_resched() / rcu_all_qs() won't do its
own rcu_momentary_qs(), because rcu_data.rcu_urgent_qs should
be false. So that essentially unify the behaviours for all configurations.

Thanks.

> 
> Still, given that both of those clauses imply CONFIG_PREEMPTION, we
> can just simplify this to (with an appropriately adjusted comment):
> 
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1543,7 +1543,7 @@ static int run_osnoise(void)
>                  * Note that in non PREEMPT_RCU kernels QSs are handled through
>                  * cond_resched()
>                  */
> -               if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
> +               if (IS_ENABLED(CONFIG_PREEMPTION)) {
>                         if (!disable_irq)
>                                 local_irq_disable();
> 
> --
> ankur


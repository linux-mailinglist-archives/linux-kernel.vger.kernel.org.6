Return-Path: <linux-kernel+bounces-424664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FEE9DB7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6970A163220
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90E19DF5F;
	Thu, 28 Nov 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgR5gv3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519C1993B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797239; cv=none; b=CNFGuuGP9vHBELSbKntB7RWKIhckfab3A/RnAtIjA5AzFXM+FIv7L97MeEkpCkIE5DPaJEW32YphS+iWcl500Vh821DtXbR0vqmUSOlGxwhLGeRIiF8XQbUgv3eh4Y4b/OKECjjmGyE7d4slBppdeHhvcBvPTVHwf0ECFX/S6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797239; c=relaxed/simple;
	bh=nA2viIAr08TTYpnPRNKlMblhcVcBLc4/CEX4cs4njlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYyKMvVV4IuM19Wyt+XTK85Pr9EHJMqvL+8ZLIWWlYv/sgWu8+kwe0n01A4xcRWTr3cZ/xL1YAsIx3X7Xo3d0Y0kV3U6vtlukeBzlWBgDRHyuJAoQsiJ6af6Ska8F5HoSDG4salbyoa/ykdF9A0ZRLuvyKfEgxzyTbAGz3KoCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgR5gv3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8649DC4CED3;
	Thu, 28 Nov 2024 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797239;
	bh=nA2viIAr08TTYpnPRNKlMblhcVcBLc4/CEX4cs4njlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgR5gv3zcmx0FremblOF5p2cFrmMuPnkmyhpuivREfHMPyc8+hJ7XFK/ajKviOdNK
	 Z2s+7U49BwhUI44MYQRYhhhOroR6g/sbDttz2se8Lr6jornDsxZTlDr3AESpbW+TGO
	 Ppj/GsWBRKUQYSIkwekF32uR+RZLBZPIMo7/hsf42eiORrZniWClvzyaP1cOL7K1qt
	 sH6uVZd9u1FAqxhlueb6bJBhHkBBlWfjad5yZ1z1ebcPtgJfPpMFlXzT1sv7l8qWYI
	 iGiykkJgixcPxWeKFNTUiGiylTOiqZXEp5lyU5L9Apej0IgY+z0V4XiI6Td46GwXJf
	 yAfKM5yly4+9w==
Date: Thu, 28 Nov 2024 13:33:56 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
Message-ID: <Z0hjNED_t_lqNFbG@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
 <87serfgffs.fsf@oracle.com>
 <Z0Xf37hJiyA7O0Ye@localhost.localdomain>
 <87zfllfddj.fsf@oracle.com>
 <87jzcpfbc6.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzcpfbc6.fsf@oracle.com>

Le Tue, Nov 26, 2024 at 10:19:05PM -0800, Ankur Arora a écrit :
> 
> Ankur Arora <ankur.a.arora@oracle.com> writes:
> 
> > Frederic Weisbecker <frederic@kernel.org> writes:
> >
> >> Le Mon, Nov 25, 2024 at 01:40:39PM -0800, Ankur Arora a écrit :
> >>>
> >>> Frederic Weisbecker <frederic@kernel.org> writes:
> >>>
> >>> > Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a écrit :
> >>> >> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
> >>> >> which allows for dynamic switching of preemption models.
> >>> >>
> >>> >> The choice of PREEMPT_RCU or not, however, is fixed at compile time.
> >>> >>
> >>> >> Given that PREEMPT_RCU makes some trade-offs to optimize for latency
> >>> >> as opposed to throughput, configurations with limited preemption
> >>> >> might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.
> >>> >>
> >>> >> Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
> >>> >> preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
> >>> >> model PREEMPT_DYNAMIC.
> >>> >>
> >>> >> This means the throughput oriented models, PREEMPT_NONE,
> >>> >> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=n.
> >>> >>
> >>> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >>> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >>> >> ---
> >>> >>  kernel/rcu/Kconfig | 2 +-
> >>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>> >>
> >>> >> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> >>> >> index 5a7ff5e1cdcb..9d52f87fac27 100644
> >>> >> --- a/kernel/rcu/Kconfig
> >>> >> +++ b/kernel/rcu/Kconfig
> >>> >> @@ -18,7 +18,7 @@ config TREE_RCU
> >>> >>
> >>> >>  config PREEMPT_RCU
> >>> >>  	bool
> >>> >> -	default y if PREEMPTION
> >>> >> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> >>> >>  	select TREE_RCU
> >>> >>  	help
> >>> >>  	  This option selects the RCU implementation that is
> >>> >
> >>> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >>> >
> >>> > But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
> >>> > some issues now that the code can be preemptible. Well I think
> >>> > it has always been preemptible but PREEMPTION && !PREEMPT_RCU
> >>> > has seldom been exerciced (or was it even possible?).
> >>> >
> >>> > For example rcu_read_unlock_strict() can be called with preemption
> >>> > enabled so we need the following otherwise the rdp is unstable, the
> >>> > norm value becomes racy (though automagically fixed in rcu_report_qs_rdp())
> >>> > and rcu_report_qs_rdp() might warn.
> >>> >
> >>> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >>> > index 58d84c59f3dd..368f00267d4e 100644
> >>> > --- a/include/linux/rcupdate.h
> >>> > +++ b/include/linux/rcupdate.h
> >>> > @@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
> >>> >
> >>> >  static inline void __rcu_read_unlock(void)
> >>> >  {
> >>> > -	preempt_enable();
> >>> >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> >>> >  		rcu_read_unlock_strict();
> >>> > +	preempt_enable();
> >>> >  }
> >>> >
> >>> >  static inline int rcu_preempt_depth(void)
> >>>
> >>> Based on the discussion on the thread, how about keeping this and
> >>> changing the preempt_count check in rcu_read_unlock_strict() instead?
> >>>
> >>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >>> index 1c7cbd145d5e..8fc67639d3a7 100644
> >>> --- a/kernel/rcu/tree_plugin.h
> >>> +++ b/kernel/rcu/tree_plugin.h
> >>> @@ -831,8 +831,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
> >>>  void rcu_read_unlock_strict(void)
> >>>  {
> >>>         struct rcu_data *rdp;
> >>> +       int pc = ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHIFT);
> >>
> >> This should be in_atomic_preempt_off(), otherwise softirqs and IRQs are
> >> spuriously accounted as quiescent states.
> >
> > Not sure I got that. Won't ((preempt_count() & PREEMPT_MASK) >> PREEMPT_SHIFT)
> > give us task only preempt count?
> 
> Oh wait. I see your point now. My check is too narrow.
> 
> Great. This'll work:
> 
> -       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> +       if (irqs_disabled() || in_atomic_preempt_off()|| !rcu_state.gp_kthread)
> 
> Thanks

Do you plan to integrate this in a further version of your set? Or should I send
a patch?

Thanks.


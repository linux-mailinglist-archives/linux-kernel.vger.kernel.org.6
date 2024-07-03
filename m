Return-Path: <linux-kernel+bounces-239487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB79260CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67918286E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC1F1741D2;
	Wed,  3 Jul 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EytTrnzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC461E4A9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010874; cv=none; b=LdTA2XzcGnqjgmKuFeNP8iP237aYNPfGJ392Mb28+f+Ooq/lsCTvoUIqhLVcmgRMNsmAfMWCNKtR8uYuJKW8cn3BoL6VuFjsu1S5uoDD2uCpTjvNkZ/4z653EZvHeFP0LLj16/t8JptS/H+5TcNZJJv2908R74FU5vPS11/9OX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010874; c=relaxed/simple;
	bh=4yoV+dToAsxCdjlO3YqpVgavlJUdbhyk7NPR3cgjbVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyWI5lBxi+DPnsjr7zgToZ/DakB9UwxEQLggMG7mpy5ZeJa/Ax5/zncIY8DasqPfHOxAL2ZKYtjzY6iOSnZITmNfaJDeixiTgC6C8r2xPJFyyuYhVCFD289lsNZgKjAmQnQewxO6Oracil/8d2Koul/vOb3zXZdQlUn9n/0qdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EytTrnzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDACC2BD10;
	Wed,  3 Jul 2024 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720010873;
	bh=4yoV+dToAsxCdjlO3YqpVgavlJUdbhyk7NPR3cgjbVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EytTrnzSg8koLpqsCL/xmwFSA4sQsEPldBI8FhS9397dd8bKMJovSNlJMC2LHweP4
	 ntlvb27PobkoS2BOyMmCJWT0Y4pi2PiYHKbn1g2nWCEh8Et//y4s3dw+GHI1oP38/r
	 kj4kmkMK1ZRfQw4xUAFCigNDw+Q7poEI9Up0kjTVTteIR7dSC3bukOU8jKx20L9+/E
	 SjZwLTwi1SzYpr+FAECi+GSzdpZS58d2HqaMQbhZOa9DrrUCGAUCLR6iOvBdAU4Omf
	 rF+4es4AfQz1xMQTEPeOBqBjvHu7NdHg2Y47R5lKq6kplYMq+t7CD3WU7q91Gyag3K
	 4C0hp/8HKr3RA==
Date: Wed, 3 Jul 2024 14:47:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 5/6] sched/isolation: Introduce isolated task work
Message-ID: <ZoVId-DDDVvdmUZX@localhost.localdomain>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-6-frederic@kernel.org>
 <672db961-6056-426d-bf62-5688344be304@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672db961-6056-426d-bf62-5688344be304@suse.cz>

Le Wed, Jun 26, 2024 at 03:27:59PM +0200, Vlastimil Babka a écrit :
> On 6/25/24 3:52 PM, Frederic Weisbecker wrote:
> > Some asynchronous kernel work may be pending upon resume to userspace
> > and execute later on. On isolated workload this becomes problematic once
> > the process is done with preparatory work involving syscalls and wants
> > to run in userspace without being interrupted.
> > 
> > Provide an infrastructure to queue a work to be executed from the current
> > isolated task context right before resuming to userspace. This goes with
> > the assumption that isolated tasks are pinned to a single nohz_full CPU.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  include/linux/sched.h           |  1 +
> >  include/linux/sched/isolation.h | 17 +++++++++++++++++
> >  kernel/sched/core.c             |  1 +
> >  kernel/sched/isolation.c        | 31 +++++++++++++++++++++++++++++++
> >  kernel/sched/sched.h            |  1 +
> >  5 files changed, 51 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d531b610c410..f6df21866055 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1349,6 +1349,7 @@ struct task_struct {
> >  #endif
> >  
> >  #ifdef CONFIG_NO_HZ_FULL
> > +	struct callback_head		nohz_full_work;
> >  	atomic_t			tick_dep_mask;
> >  #endif
> >  
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index 2b461129d1fa..e69ec5ed1d70 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -72,4 +72,21 @@ static inline bool cpu_is_isolated(int cpu)
> >  	       cpuset_cpu_is_isolated(cpu);
> >  }
> >  
> > +#if defined(CONFIG_NO_HZ_FULL)
> > +extern int __isolated_task_work_queue(void);
> > +
> > +static inline int isolated_task_work_queue(void)
> > +{
> > +	if (!housekeeping_test_cpu(raw_smp_processor_id(), HK_TYPE_TICK))
> 
> This is an unconditional call to a function defined in
> kernel/sched/isolation.c, and only there a static_branch_unlikely() test
> happens, but the call overhead is always paid, and the next patch adds that
> to folio_add_lru().
> 
> I notice a housekeeping_cpu() function above that does the static branch
> inline, which is great, except it defaults to return true so not directly
> applicable, but this function could be done the same way to keep the static
> branch inline.

Right, there definetly needs some inlining.

Thanks.


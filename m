Return-Path: <linux-kernel+bounces-242076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49500928344
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CD5283FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4489144D10;
	Fri,  5 Jul 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rNrRpLIM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75433C7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166183; cv=none; b=uaUe9/lOfyr73KepAUmoxBj79GJrM3Ldr6hVgtTCfcv3xW/MMUKi9hmBCWxG1IhhsX2q4ps5+hK+94PXsUAUyeSM2uzA0XqoV1PpfXaxbieeUYVi5GJtdvX30JLzG7AIE2XxqU5gxNdOnnryiHNi1c0hVTpynggmdArLypcnuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166183; c=relaxed/simple;
	bh=7lRXsIyIXcHTo0/TNvYLnCx1bIDYVxLC5xFG9KcMnMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3EIBxrGu7dxr9VTxdyAPF2wNEtOga9FQLXAjQnZkJup+p0M0FVBXQXWHsAfpVc0CYIOzBs5BPqxAjnRFowCL7ZIAbG/PsVX3eRTq+FTW4a1OwMOuarS2AHuFhCPnLP/tlmbSZSI6E7CzvGkkVue9yrCDDKbxI0mi5U7jLzDYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rNrRpLIM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qGPlD6IQD5QtgR5+WUAULcxbPSIE/REWmS+bu1+0rxo=; b=rNrRpLIMwjGFUuUniGPE+1MeTs
	fKOdQBX85xuI07LHXVeK4PK2KtYmdVE18vIO6AsTeF3sgW2uwKbJY5QcNjyKVlO/isJts2eFQ0NG9
	9dJxdEHGTHByiSgvUVlkDzu2dZJ6Lr8+mQ54aXqJfJt0hRg8NMmC9dfUYaTM76O0cxcnzI2LPGA52
	G8+IqfrCVzZ/mslF6cEGsUOmGts/98aWn3+UMCbRSZ468XUDES+3RBU+eQ198ENDtbnI1/WdY4ovM
	PZBj8WeZXV8oOA4wfjuEb5gryzOD21k8Ndd1i7WcmyNph6l8MQc/704ILk2NhSLteYM6CtMcZWI78
	/TXy0HDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPdnd-00000003jtW-3gCp;
	Fri, 05 Jul 2024 07:56:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8826E3005AF; Fri,  5 Jul 2024 09:56:09 +0200 (CEST)
Date: Fri, 5 Jul 2024 09:56:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Peilin He <peilinhe2020@163.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn, jiang.kun2@zte.com.cn, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, liu.chun2@zte.com.cn, mgorman@suse.de,
	mingo@redhat.com, rostedt@goodmis.org, tu.qiang35@zte.com.cn,
	vincent.guittot@linaro.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re: Re: [PATCH linux-next v2] sched/core: Add WARN() to check
 overflow in migrate_disable()
Message-ID: <20240705075609.GY11386@noisy.programming.kicks-ass.net>
References: <20240704134716.GU11386@noisy.programming.kicks-ass.net>
 <20240705054132.108523-1-peilinhe2020@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705054132.108523-1-peilinhe2020@163.com>

On Fri, Jul 05, 2024 at 05:41:32AM +0000, Peilin He wrote:
> > How about we do something like this?
> >
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7a5ea8fc8abb..06a559532ed6 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2237,6 +2237,12 @@ void migrate_disable(void)
> >  
> >      if (p->migration_disabled) {
> >          p->migration_disabled++;
> > +#ifdef CONFIG_DEBUG_PREEMPT
> > +        /*
> > +         * Warn about overflow half-way through the range.
> > +         */
> > +        WARN_ON_ONCE((s16)p->migration_disabled < 0);
> > +#endif
> >          return;
> >      }
> 
> Agreed, converting p->migration_disabled to a signed number 
> will detect overflow occurrences earlier than our current method.
> 
> > @@ -2254,14 +2260,20 @@ void migrate_enable(void)
> >          .flags     = SCA_MIGRATE_ENABLE,
> >      };
> >  
> > +#ifdef CONFIG_DEBUG_PREEMPT
> > +    /*
> > +     * Check both overflow from migrate_disable() and superfluous
> > +     * migrate_enable().
> > +     */
> > +    if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
> > +        return;
> > +#endif
> > +
> >      if (p->migration_disabled > 1) {
> >          p->migration_disabled--;
> >          return;
> >      }
> >  
> > -    if (WARN_ON_ONCE(!p->migration_disabled))
> > -        return;
> > -
> >      /*
> >       * Ensure stop_task runs either before or after this, and that
> >       * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
> 
> Agreed, similarly checking for overflow in p->migration_disabled 
> within migrate_enable is fine, but placing WARN_ON_ONCE inside 
> the CONFIG_DEBUG_PREEMPT macro may cause return logic deviations. 
> It is recommended to support WARN_ON_ONCE as a standard feature.

It is debug stuff, it should only be needed for debug builds. Same as
the preemption things, they also only check for overflow on debug
builds.


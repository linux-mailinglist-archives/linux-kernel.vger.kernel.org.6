Return-Path: <linux-kernel+bounces-357082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08524996B48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE07A28A21C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF419DF60;
	Wed,  9 Oct 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dYft/JbY"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51C19DF66
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478896; cv=none; b=s6EiC2TDEt46er4FvXMJ3/AdxWUa0E2dntdeYF1+NgNI73ECWeBcc7863VTAbaQDSrPGUeF7HVsYCJYWdUUitkC2TmkvoE43I3Pxg9AKmbZHtJ7kthV/5VS7CV0HNVxLvbwgQyYPMWzXNbBSfZG5dMkS8ZLZqYWbVkbnIvPwdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478896; c=relaxed/simple;
	bh=VIU7o6QWrxGnLySbd4uFlJ3Fr14tYeCg77JvcTh3nqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MILg/aGfpmcgA3HvSQssmfiiNgJcjM2DOl9U75Ep4DQYIyeGiCth3sKK7GsjBgw5QC5jLA8G9xaV2ndVdgVO5FV2DELicUAfV6LvMRJFjiwijdxrX4oBxg6F7BeTFHXh5+Xn4EeVnggNAfh2Z51c3V4aqTBNt+qYNYDGhFj29WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dYft/JbY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iHbuL04KUf/8LRDU+96Q8dOD+R4BjSDA4RgBziZCiWE=; b=dYft/JbYv+H84XdbMktESxMwQb
	PsvH0WM+f3Ul6ViES8TwL4q8rSH+k2QyiL+pea8jzgn3o5HXtVS+HnxcTDyU3qS2uAzP1QC+XxQt4
	CeyfcqA2kp37HUSWIBT2XIULCoE40D9i1WXPj7LuBoAw9vjw8SLRoSv0odtrTQHkN0kNnYSkB8d2+
	6ohU75/0Mxd7nPF3saqSY730jx4OzzQQbYT5mhg1LPSQurKlbW+9aGQgPbM/3Nn+ctNQzG3cjhLJ6
	tl9Np9WI5Vsykb93cUS0mMH0hPswDgbAwLlPaVMMKcX2q4FeSyHlYVUgK1tTaw4DMHMg0VECvE0h+
	/iJm0XdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syWJg-00000004xQI-2Egt;
	Wed, 09 Oct 2024 13:01:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D275C3004AF; Wed,  9 Oct 2024 15:01:23 +0200 (CEST)
Date: Wed, 9 Oct 2024 15:01:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 1/5] sched: Add TIF_NEED_RESCHED_LAZY infrastructure
Message-ID: <20241009130123.GM17263@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.219540785@infradead.org>
 <20241009121859.C2-B8P4L@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009121859.C2-B8P4L@linutronix.de>

On Wed, Oct 09, 2024 at 02:18:59PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-07 09:46:10 [+0200], Peter Zijlstra wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -964,9 +963,9 @@ static bool set_nr_if_polling(struct tas
> >  }
> >  
> >  #else
> > -static inline bool set_nr_and_not_polling(struct task_struct *p)
> > +static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
> >  {
> > -	set_tsk_need_resched(p);
> > +	atomic_long_or(1 << tif, (atomic_long_t *)&ti->flags);
> 
> 	set_ti_thread_flag(ti, tif);
> ?
> Not sure if there is a benefit over atomic_long_or() but you could avoid
> the left shift. I know. Performance critical.

:-)

Yeah, I suppose set_ti_thread_flag() works just fine here.


Return-Path: <linux-kernel+bounces-389563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF769B6E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30840B21385
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79312144DB;
	Wed, 30 Oct 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJyigJCS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8D213EE0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322674; cv=none; b=T6OMPrdx8P9sIf4yYoPtrVjSoLbIXLHwU7N9eXMPJaNvZhrRaoH79UV6NqJ+C/OJcmIpjeamMswDyUSVobs6XUDNxyBPbtWjt7PcTZTb63cDP2FwpK/lumg8lIBXYsTl8oexoR3TzXH6rU9cGysTqnRmQv5AOCoU37V4dsyy+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322674; c=relaxed/simple;
	bh=rKN07IFiyLry56HMrH/Crz2lDow4R3mFSDZSAlhGTng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbCR6sI4UOK5GaFMm0qHXf+51b+pAEjDuF7Y//fyNM7+ruFjWjuLbigbx2jJj0udZOAEeMW2etG3ode6LiJH/EC9vuZI2JdDJCPLYpmE7yvjHCotSYJs6UIptseDi17TDfCNX6v8wec058zid6Mt5jqsFeAPgSTJ3gQjzorfsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OJyigJCS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YQlalOXmPT8K4J17vnmLbA6DUJN7XQlGBTi1tPTDRAo=; b=OJyigJCSumQ1BClocCdHDydMxj
	FlzvZnuF41xZst6nNmAZ6TuvRjoAe6oJXGfbGaLWcL5XszkuO3Gc5ndw6QEqGPb59K6BVltTm54gm
	+fyKn+ax0OiJDM0c2WhJ0PuwnAafmT8/op6zpGh7GaOzl8MDpmo0NCJ1XkWaPdEmIqH46J+DUmWa3
	nK3ZQnwGLPLJqSkE83u7jym4eUD+mBktkz46HmjdoqjwLKT03kl3ad7Vf6KJ/eUK3b5FRerR1A/pG
	koFxTlD8jFTyBlk9YQcDluwCshATMvXQHSVM9HuhumdHMpCtB498WCU1U5aZyP2fO06G8nqzl5UwE
	tFhCLKVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Fy4-0000000Duvi-0lYg;
	Wed, 30 Oct 2024 21:11:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68F37300ABE; Wed, 30 Oct 2024 22:11:04 +0100 (CET)
Date: Wed, 30 Oct 2024 22:11:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/6] sched: Employ sched_change guards
Message-ID: <20241030211104.GT9767@noisy.programming.kicks-ass.net>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.488737132@infradead.org>
 <ZyKeAGgnuZiz3a4A@slm.duckdns.org>
 <ZyKgpI3YMTfzhgFK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyKgpI3YMTfzhgFK@slm.duckdns.org>

On Wed, Oct 30, 2024 at 11:09:56AM -1000, Tejun Heo wrote:
> On Wed, Oct 30, 2024 at 10:58:40AM -1000, Tejun Heo wrote:
> > On Wed, Oct 30, 2024 at 04:12:57PM +0100, Peter Zijlstra wrote:
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -4496,6 +4496,8 @@ static void scx_ops_disable_workfn(struc
> >  		const struct sched_class *new_class =
> >  			__setscheduler_class(p->policy, p->prio);
> >  
> > +		update_rq_clock(task_rq(p));
> > +
> 
> Oh, this probably should be paired with DEQUEUE_NOCLOCK.

Yeah, it is like that at the end of the series. I'll shuffle things
around and make it so earlier.

Thanks!


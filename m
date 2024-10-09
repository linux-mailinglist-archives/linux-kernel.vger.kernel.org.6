Return-Path: <linux-kernel+bounces-356651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F299649A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CB41F26CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA718A6DD;
	Wed,  9 Oct 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hj+gnQw7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C943188929
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465251; cv=none; b=FmrrWVG0j9bvNsawgoGu29jt9p5tV505q0D4D5z+m7dgMS3KR6jWmJtY/iLBmqjHe1rvYcQ949YtIbTABP/nbiTJvdMRBkAJQ69Y/ClxaadOrjPUB8aQRuWDUNpQsmrnnstBB4jbHvsCjjTqhTAcxRCXNRx85uMml8vK2CvjCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465251; c=relaxed/simple;
	bh=Utrc1u4+Hstv/BRbvWGNZNWv9JXQyrvy/2xczg7ce7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKzrCgQ70MotIU30bbo7U/bze+uC82FXe+9xdTlgw4ovnpjrl2oyMZWY79SsF6O+lOWovmzO0DlQH6bGeWs4L0MX2iBZ27eURZvDQsioLINC3L5rHNDcLT3Kzpkr6I6BGpU/vM8JILgGIqAtwfuXiJVJV94TAAqAMSde/Ug9v10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hj+gnQw7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=S/cXN9Ak8mURwNRejAvhXtxdhwNkFx0AQ6RWxn11/Xc=; b=Hj+gnQw7THyvMux9+vMr1msExi
	D2Prug8M51f4/roIftMGWJVn0WO3TcVuvneQo3k9XVIse5D+T59DWKb+RnWAdHcc9Jtr6JhKjCGuS
	g0Xgumxj45cuO4eNiN83gr3UMbPSwDYDmnhu5oCnx0EsyhqWqUmaLMaqi1PQKWlWSREOg/RYpYq8I
	uYusjivfhnbw1aARCjXIIfyfmSDA1QVSb6ehmAE+uQQUS1pi5rpAZvZ8cp+E5L442RD1jU9cZqwDy
	mo6UCzvE8O15AHtZj0+hwMremMKYxfEZB0SQ3IsGpC9xeIhxqRDx47LzgKkI5RbxJLgLFPCI5rR6N
	eVuoczhw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sySld-00000004sV2-3My1;
	Wed, 09 Oct 2024 09:14:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2651A300297; Wed,  9 Oct 2024 11:14:01 +0200 (CEST)
Date: Wed, 9 Oct 2024 11:14:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
Message-ID: <20241009091401.GL17263@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
 <20241009085021.cw9147B8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009085021.cw9147B8@linutronix.de>

On Wed, Oct 09, 2024 at 10:50:21AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-07 09:46:11 [+0200], Peter Zijlstra wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1103,6 +1106,32 @@ void resched_curr(struct rq *rq)
> …
> > +static __always_inline int tif_need_resched_lazy(void)
> 
> The naming is a bit confusing here because tif_need_resched() checks if
> the TIF_NEED_RESCHED is set while this returns the proper TIF bit
> instead.

Right you are; naming things be hard. How about: get_lazy_tif_bit() ?
There's only the single user anyway.

> > +{
> > +	if (dynamic_preempt_lazy())
> > +		return TIF_NEED_RESCHED_LAZY;
> > +
> > +	return TIF_NEED_RESCHED;
> > +}
> 
> Sebastian


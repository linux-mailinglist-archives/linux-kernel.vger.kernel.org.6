Return-Path: <linux-kernel+bounces-285557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5EA950F93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F0CB249BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B421AB507;
	Tue, 13 Aug 2024 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C1ivD9mi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616D1AAE06
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587507; cv=none; b=TK5IKFVsEbfpnFRQN1TOb7E5Nqi/cuwT72RODDBe/+BWlkg26J8c+3e8XBvt14NhnF6rx35QFcR5Z+8EENBXuIuFpLYl+KbkD39g21nwD0/cdDQeRFmxlD0hzkhJdxulhgLXSkTryHR05Wp84wjaK0TKvbs2JKT/9d6X/QTvaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587507; c=relaxed/simple;
	bh=t56MRumctEXbx6FmmaUnp96COXmxLmPDJ8TFps9e8Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBH/QXZFCvt5hjlGS030sy3okMyy7UXZspN2MMfMNcHkfKVsxn0J/Y+tsy/OG39ldrQqCGSjPKy2y02GQT0nZG0wmGQHl/ku74ccygP78QJXIZkh87vdjKCGExUvzQbF2MkTYSLWq25pRPPDa5CyKaKrmmPP+XFbfc6GY1ocH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C1ivD9mi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uoiLbBV1P/kZcpQtke8gf//MV/a3BtQIb+J6uvUf5PE=; b=C1ivD9milRouJPBR1cQtQy5uQt
	fTnYwNrVzt/B6LMXaUNAqTR+Up0U/FOqM7+4W9QawweImtaiTnqaXE4oe5r02uNQ5UeBN+jk0gTRL
	PnXfL7qxVgxpdNg22F/HXclWk5T/TwtZevHy3e0GIKDU34Zaw6hPGi7+rViR1P0SS+muTy0f4Y9ep
	NeYC6WFDVjlPNOLNiYVq2q9ltBqVyVeu5py+RAMxM9F/boGBCPE2q0v3Zde2T+OeELhfZRqmuSi8J
	7mpnP2PsTw4AggR/GobnL3O/t9pBmcPB1KLyfzxYVa94urKXjV3EqMJ28sqbuv/KpAfBYiezpirzo
	iRm04Ukw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdzqC-00000007rp5-16Sz;
	Tue, 13 Aug 2024 22:18:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B1C030074E; Wed, 14 Aug 2024 00:18:07 +0200 (CEST)
Date: Wed, 14 Aug 2024 00:18:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
Message-ID: <20240813221806.GB10328@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.514088302@infradead.org>
 <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Tue, Aug 13, 2024 at 02:43:56PM +0200, Valentin Schneider wrote:
> On 27/07/24 12:27, Peter Zijlstra wrote:
> > Note that tasks that are kept on the runqueue to burn off negative
> > lag, are not in fact runnable anymore, they'll get dequeued the moment
> > they get picked.
> >
> > As such, don't count this time towards runnable.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/fair.c  |    2 ++
> >  kernel/sched/sched.h |    6 ++++++
> >  2 files changed, 8 insertions(+)
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5388,6 +5388,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> >                       if (cfs_rq->next == se)
> >                               cfs_rq->next = NULL;
> >                       se->sched_delayed = 1;
> > +			update_load_avg(cfs_rq, se, 0);
> 
> Shouldn't this be before setting ->sched_delayed? accumulate_sum() should
> see the time delta as spent being runnable.
> 
> >                       return false;
> >               }
> >       }
> > @@ -6814,6 +6815,7 @@ requeue_delayed_entity(struct sched_enti
> >       }
> >
> >       se->sched_delayed = 0;
> > +	update_load_avg(cfs_rq, se, 0);
> 
> Ditto on the ordering

Bah, so I remember thinking about it and then I obviously go and do it
the exact wrong way around eh? Let me double check this tomorrow morning
with the brain slightly more awake :/

> >  }
> >
> >  /*
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -816,6 +816,9 @@ static inline void se_update_runnable(st
> >
> >  static inline long se_runnable(struct sched_entity *se)
> >  {
> > +	if (se->sched_delayed)
> > +		return false;
> > +
> 
> Per __update_load_avg_se(), delayed-dequeue entities are still ->on_rq, so
> their load signal will increase. Do we want a similar helper for the @load
> input of ___update_load_sum()?

So the whole reason to keep then enqueued is so that they can continue
to compete for vruntime, and vruntime is load based. So it would be very
weird to remove them from load.



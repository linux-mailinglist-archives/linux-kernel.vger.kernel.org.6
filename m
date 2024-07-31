Return-Path: <linux-kernel+bounces-269084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB4942D60
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FF32876AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715501AD9EB;
	Wed, 31 Jul 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VWTe3OEn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E971A8BEF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425853; cv=none; b=VliUZDSQLankZ6i9Riz7frF6FoOvl3kL10WKwH73QAi5/mnNQIpB/KW1jXPDJ3YHLvTDyDhG36kHCormLqwBgedW9hbkkuHmVJWN/XR7db4Lw/R6fyBvS5cEn+cVg344HjlI4bAhSJ6PNZMX9aRixyrBQyS/0hjd1w25bKMyE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425853; c=relaxed/simple;
	bh=WL7o+LQp50b2Ysi/c9o4IuBeN86VjMkt7yedq/mOGWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnuQw9hrAxEKshoX1tmM/PNexObTdcFLhDt7ngUvKQFhOt/wBFwH1V8PVpL6loDSKCGAt/aZOETTf6gZg1DC98re1HK5LL10Fecby65sBHoF0QOhc878b++buga9MDzZweoXOZw8Ji+g4dMDwLVD2h2igsMZBwmfcNJp4X0Z5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VWTe3OEn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GNrQrBGqT+jtpN2J6tsUnVWMiDGRAp89UzHUy8jR/H8=; b=VWTe3OEnFWI1VSlHbw0wnRctOG
	RKBRLAdYDjCqcgK1WmAIOuA4kZEG4lbsyDRQviF86v1Lk8C4OpLQAh3TEV1eitxyM3HVbCM7a2Pw8
	joqPVjMBFwsjD+M1EMCLbE53f44DjsdeB35BPr9Q2tAXlxIRkmBMa4Blmk2nSSAY8fEE2AeiMst26
	1xw6ilSaKfNl0/0Na4opuY9vJRbPF0h/Uj/AgXWzQEvASjphK5LVp8lSZ0LqBYYIiLkP+WKjQHuAV
	XS0UDe5NF2esbSbcdX0Id7cC2AEV4p/Rw+HUVt75tLHcauMHElohOyrsYTpLvcWZp89k8oA6EN1u0
	UtnloxGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ7dx-00000005CxD-1Kjq;
	Wed, 31 Jul 2024 11:37:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57581300820; Wed, 31 Jul 2024 13:37:20 +0200 (CEST)
Date: Wed, 31 Jul 2024 13:37:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
Message-ID: <20240731113720.GB33588@noisy.programming.kicks-ass.net>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net>
 <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
 <Zqn_0XIcxTpHxswZ@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqn_0XIcxTpHxswZ@jlelli-thinkpadt14gen4.remote.csb>


Sorry for the delay, I need the earth to stop spinning so goddamn fast
:-) 36 hours days ftw or so... Oh wait, that'd mean other people also
increase the amount of crap they send my way, don't it?

Damn..

On Wed, Jul 31, 2024 at 11:11:45AM +0200, Juri Lelli wrote:
> Hi John,
> 
> On 12/07/24 12:10, John Stultz wrote:
> > On Fri, Jul 12, 2024 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 01:31:50PM -0700, John Stultz wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > Let's define the scheduling context as all the scheduler state
> > > > in task_struct for the task selected to run, and the execution
> > > > context as all state required to actually run the task.
> > > >
> > > > Currently both are intertwined in task_struct. We want to
> > > > logically split these such that we can use the scheduling
> > > > context of the task selected to be scheduled, but use the
> > > > execution context of a different task to actually be run.
> > > >
> > > > To this purpose, introduce rq_selected() macro to point to the
> > > > task_struct selected from the runqueue by the scheduler, and
> > > > will be used for scheduler state, and preserve rq->curr to
> > > > indicate the execution context of the task that will actually be
> > > > run.
> > >
> > > > * Swapped proxy for selected for clarity
> > >
> > > I'm not loving this naming...  what does selected even mean? What was
> > > wrong with proxy? -- (did we have this conversation before?)
> > 
> > So yeah, this came up earlier:
> > https://lore.kernel.org/lkml/CANDhNCr3acrEpBYd2LVkY3At=HCDZxGWqbMMwzVJ-Mn--dv3DA@mail.gmail.com/
> > 
> > My big concern is that the way proxy was used early in the series
> > seemed to be inverted from how the term is commonly used.
> > 
> > A proxy is one who takes an action on behalf of someone else.

Ah, I see your confusion.

> > In this case we have a blocked task that was picked to run, but then
> > we run another task in its place. Intuitively, this makes the proxy
> > the one that actually runs, not the one that was picked. But the
> > earliest versions of the patch had this flipped, and caused lots of
> > conceptual confusion in the discussions I had with folks about what
> > the patch was doing (as well as my own confusion initially working on
> > the patch).
> 
> I don't think I have strong preferences either way, but I actually
> considered the proxy to be the blocked donor (the one picked by the
> scheduler to run), as it makes the owner use its properties, acting as a
> proxy for the owner.

This. But I suspect we both suffer from not being native English
speakers.

Would 'donor' work in this case?

Then the donor gets all the accounting done on it, while we execute
curr.


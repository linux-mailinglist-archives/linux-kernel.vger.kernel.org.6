Return-Path: <linux-kernel+bounces-269369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD6943217
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96166280EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BC1BBBC5;
	Wed, 31 Jul 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9++bOVO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8A1B29C5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436614; cv=none; b=GPJoOM3gXQGWgoWjAzAtagBAda9VKok656AVMcE95Jfq6Jkcu3Z1bYOFAJd7dzOaFFEWreWt96m/FRyZk1fPpLeXa2kQi+dlUewUrx5pD289Q4BOq3XS233Qvz/pGn1DDaL79DaN3SobbCTEnQNY7QWooBONe8xJXlniQyzwScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436614; c=relaxed/simple;
	bh=b+zJh0LfeAwcriCDN0IFPXgYnuWSc8EdOTJ24IqmUxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcdzLn77lL1pvQD7p2M+JjGrtHuTcHzFhAO9ohfabylNdAHKY5fW4Hlh0U1n7u26A+VAHdzka6+Gv66QfCUCg3zyh9zb7s9bu6ESZTrFdfVQXRHiYUHmPqp7mCPUXLmYDDKSCOTdag/q3lPGBS2YheuWSBfJPA6ku4GO3BT0iIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9++bOVO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722436611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqbXQIxHbpb1hqzKRna/+RFAtjmaMliX6p7yM3qg7No=;
	b=E9++bOVOerkdCht7de1hhopL1zxR+O9nNlvaihH+qlPPBO5uzWmqUwHAFbCEeLMNw8HzZA
	1zM+L3YsCPlZNCLEj/xR77dpJGP7nLBtTZSATVYG8B4ZvMvEOxa0sZZTe/2g6cfUUNYa0J
	F4/xmqGnMxSnBxHm+BiuKa0ceJEbNAw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-81ebYxS0OCenb6rpI3Aieg-1; Wed,
 31 Jul 2024 10:36:46 -0400
X-MC-Unique: 81ebYxS0OCenb6rpI3Aieg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B36A1954128;
	Wed, 31 Jul 2024 14:36:43 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.9.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49AF619560AE;
	Wed, 31 Jul 2024 14:36:38 +0000 (UTC)
Date: Wed, 31 Jul 2024 10:36:35 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, John Stultz <jstultz@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20240731143635.GB188529@pauld.westford.csb>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net>
 <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
 <Zqn_0XIcxTpHxswZ@jlelli-thinkpadt14gen4.remote.csb>
 <20240731113720.GB33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731113720.GB33588@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jul 31, 2024 at 01:37:20PM +0200 Peter Zijlstra wrote:
> 
> Sorry for the delay, I need the earth to stop spinning so goddamn fast
> :-) 36 hours days ftw or so... Oh wait, that'd mean other people also
> increase the amount of crap they send my way, don't it?
> 
> Damn..
> 
> On Wed, Jul 31, 2024 at 11:11:45AM +0200, Juri Lelli wrote:
> > Hi John,
> > 
> > On 12/07/24 12:10, John Stultz wrote:
> > > On Fri, Jul 12, 2024 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Jul 09, 2024 at 01:31:50PM -0700, John Stultz wrote:
> > > > > From: Peter Zijlstra <peterz@infradead.org>
> > > > >
> > > > > Let's define the scheduling context as all the scheduler state
> > > > > in task_struct for the task selected to run, and the execution
> > > > > context as all state required to actually run the task.
> > > > >
> > > > > Currently both are intertwined in task_struct. We want to
> > > > > logically split these such that we can use the scheduling
> > > > > context of the task selected to be scheduled, but use the
> > > > > execution context of a different task to actually be run.
> > > > >
> > > > > To this purpose, introduce rq_selected() macro to point to the
> > > > > task_struct selected from the runqueue by the scheduler, and
> > > > > will be used for scheduler state, and preserve rq->curr to
> > > > > indicate the execution context of the task that will actually be
> > > > > run.
> > > >
> > > > > * Swapped proxy for selected for clarity
> > > >
> > > > I'm not loving this naming...  what does selected even mean? What was
> > > > wrong with proxy? -- (did we have this conversation before?)
> > > 
> > > So yeah, this came up earlier:
> > > https://lore.kernel.org/lkml/CANDhNCr3acrEpBYd2LVkY3At=HCDZxGWqbMMwzVJ-Mn--dv3DA@mail.gmail.com/
> > > 
> > > My big concern is that the way proxy was used early in the series
> > > seemed to be inverted from how the term is commonly used.
> > > 
> > > A proxy is one who takes an action on behalf of someone else.
> 
> Ah, I see your confusion.
> 
> > > In this case we have a blocked task that was picked to run, but then
> > > we run another task in its place. Intuitively, this makes the proxy
> > > the one that actually runs, not the one that was picked. But the
> > > earliest versions of the patch had this flipped, and caused lots of
> > > conceptual confusion in the discussions I had with folks about what
> > > the patch was doing (as well as my own confusion initially working on
> > > the patch).
> > 
> > I don't think I have strong preferences either way, but I actually
> > considered the proxy to be the blocked donor (the one picked by the
> > scheduler to run), as it makes the owner use its properties, acting as a
> > proxy for the owner.
> 
> This. But I suspect we both suffer from not being native English
> speakers.
> 
> Would 'donor' work in this case?
>
> Then the donor gets all the accounting done on it, while we execute
> curr.
> 

"donor" works for me and is more expressive (and shorter) than
"selected". Fwiw.



Cheers,
Phil

-- 



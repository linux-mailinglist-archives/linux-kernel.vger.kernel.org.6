Return-Path: <linux-kernel+bounces-565521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C4DA66A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26123B559B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DED1A5B98;
	Tue, 18 Mar 2025 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H3fj/n9Q"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87F1537CB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278172; cv=none; b=H6li3BCvpZOCcq/kP7On/0h7NSvXJ23h5C97JioNOCI1NjJ998YWx9dirZ72RlGA2NNv4zE/XsDYt7Jvdlr6dLEsrvW0WDcq02nspPXVo+41Dbncz0ajhGxinhZzSEwKuiiWs5qQa2F7/1nzlpqGnhK3p2WB1Lbuaxh3hgpsBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278172; c=relaxed/simple;
	bh=0SP/1UR1OLGXTHLqbdnG5+getHel7cf03NJzFAQbZY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvKy2sJb6vPhXMXE9QblHzW36KsL0CSW+1w6ULHLOX6uCBVCldYRcmjwPHD62NG4qIXI1rH+vOjLfEgucLsBPComvu+gHdKPzDZTUdOmewrwKGgY5oUk84OdFC1TRMUFLdGnX4KnW5oFSKM+sQ9tRer4ypjsBxrdM1j5taexfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H3fj/n9Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XmbEEBxv7wnOPtRU35Rv0DzfteZxdf43CTkM19jBhKI=; b=H3fj/n9Qt2Df+2D0un8D5rQ6xY
	8IpuTNsVu3xw9eL6tlujUBZcdz7AuqU8qhVJTpljFocXTEFwYmKIcveTRzB99vfev8C4BH12o3FnU
	dgtK3rfbdjaFSot4IFgBloWQysemTa4X1mwTJTmJsE7yF3N/tyIyb9vAeJh3gkXc/B84lsfRs+hlM
	Air+Oc8dmECYk7w30vT6B2SGbTJ7+g14GK7EgDyO05Ytsy2RZQeoXXHDFvJp0wSPWoESmgL/dqVMl
	W4Pdr2CYs20+GEefpIBHH1yMQgz9esRr6jq/LS4bZdr2o8UOsN/is7BpeY+vrv2q09vRY9EbjgE4Z
	b6TooDPA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuQ8c-00000003gam-2Qo4;
	Tue, 18 Mar 2025 06:09:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E86E5300783; Tue, 18 Mar 2025 07:09:17 +0100 (CET)
Date: Tue, 18 Mar 2025 07:09:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com,
	Valentin Schneider <valentin.schneider@arm.com>,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC PATCH v15 7/7] sched: Start blocked_on chain processing in
 find_proxy_task()
Message-ID: <20250318060917.GA26027@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-8-jstultz@google.com>
 <20250317164356.GB6888@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317164356.GB6888@noisy.programming.kicks-ass.net>

On Mon, Mar 17, 2025 at 05:43:56PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 12, 2025 at 03:11:37PM -0700, John Stultz wrote:
> > @@ -6668,47 +6676,138 @@ static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
> >  }
> >  
> >  /*
> > + * Find runnable lock owner to proxy for mutex blocked donor
> > + *
> > + * Follow the blocked-on relation:
> > + *   task->blocked_on -> mutex->owner -> task...
> > + *
> > + * Lock order:
> > + *
> > + *   p->pi_lock
> > + *     rq->lock
> > + *       mutex->wait_lock
> > + *
> > + * Returns the task that is going to be used as execution context (the one
> > + * that is actually going to be run on cpu_of(rq)).
> >   */
> >  static struct task_struct *
> >  find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> >  {
> > +	struct task_struct *owner = NULL;
> > +	struct task_struct *ret = NULL;
> > +	int this_cpu = cpu_of(rq);
> > +	struct task_struct *p;
> >  	struct mutex *mutex;
> >  
> > +	/* Follow blocked_on chain. */
> > +	for (p = donor; task_is_blocked(p); p = owner) {
> > +		mutex = p->blocked_on;
> > +		/* Something changed in the chain, so pick again */
> > +		if (!mutex)
> > +			return NULL;
> >  		/*
> > +		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> > +		 * and ensure @owner sticks around.
> >  		 */
> > +		raw_spin_lock(&mutex->wait_lock);
> 
> This comment -- that is only true if you kill __mutex_unlock_fast(),
> which I don't think you did in the previous patches.

Ignore this; I got myself confused again. :-)


Return-Path: <linux-kernel+bounces-448833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91F9F4631
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4679167481
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85481DCB24;
	Tue, 17 Dec 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RFbqfDqz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A718035
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424801; cv=none; b=Nretr7Vr4iZBuoLjrsZXYG/LpiBNlcYw0LI2YnSNMEHrysDqoQ8L1GM3LUU1X1LgVzAYKEngGg2ZqTYNcMmUD/nySnoAsvtzXROReuyPITfeycNwB0jkCeSGMcFmiGEX7fbetdm4t35L1RTrQihXY71GZNLO7iNgSVraK/c+myI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424801; c=relaxed/simple;
	bh=ls/AmNG93LU9ayn/71FsfGrw4+Ni4nHAglsLHh2S6aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSxC7ZZjEjG/C/UJqRT2MFLj6r4tAoUTBrrZ6Ac2cnKidJAx5i7HQbH7JX0TvRvCehfawVnxVk3STgZmpG5MGWbsouYJZ0Z8ExoMFfCaGKZi0IlhgcmmPKNPWpKlGfrXLcRbpIr781nW5eumLwG9MD/HexI5Ag6HjZ7SxjmVNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RFbqfDqz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zHKSQ9Na+RcR019nXxbqF8cNu/t1XZ8eXhmHmP+Ovf0=; b=RFbqfDqz7m7V3l3Trt00C8orAY
	C7XQPDYBkR8DcF1sWU6/Wv3RK1cG/70XUP5jwJwTfxjMeJrEs//69GCUwmdO1UxFchyhXzd1qlS2h
	F4UoelRJrag+4OFNLkxdhRQxeShWKBPg3WDCEnCyFtyUqn3WHS+0/3yeOiaxQaPFLiz3+Yk5JVQVV
	CRAJELFss3fNk7eMXQA2KcGpecbecOO2jSQ/9g+R4pi2keWiaGnVl8gxGwUZOeTrdsa4r2Hb7tiQh
	wksqB0CnLpTSUgjxXCOdgF2eK3sYhO95X0g949AMg01U6+m9OX3SDrCGtG+zrBHKfrtF6KCQDZPPL
	xTXjt21A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNT7L-00000005q8b-3AUz;
	Tue, 17 Dec 2024 08:39:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7AE9300192; Tue, 17 Dec 2024 09:39:46 +0100 (CET)
Date: Tue, 17 Dec 2024 09:39:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
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
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC][PATCH v14 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20241217083946.GF35539@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-3-jstultz@google.com>
 <20241213232214.GA17501@noisy.programming.kicks-ass.net>
 <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>
 <20241216165419.GE35539@noisy.programming.kicks-ass.net>
 <CANDhNCpTfZFOkUkB4f4iQwXA3wnsDuUA_1ZLuseGYunnpgO9Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpTfZFOkUkB4f4iQwXA3wnsDuUA_1ZLuseGYunnpgO9Rw@mail.gmail.com>

On Mon, Dec 16, 2024 at 09:01:24PM -0800, John Stultz wrote:
> On Mon, Dec 16, 2024 at 8:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Dec 13, 2024 at 07:39:57PM -0800, John Stultz wrote:
> > > On Fri, Dec 13, 2024 at 3:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Mon, Nov 25, 2024 at 11:51:56AM -0800, John Stultz wrote:
> > > So yes, the description can use improvement here. I at one time had
> > > 3-4 separate very fine grained patches (see the top 4 patches here:
> > > https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc6-fine-grained/?after=c4cad6e353c00254a2dfbb227ef81d8c3827427d+35)
> > > that I rolled into one when sending out(mostly to avoid overwhelming
> > > folks), but the squished commit description isn't as clear.
> > > So if it's helpful I can split this back out?
> > >
> > > I'll also add some better comments as well.
> >
> > Not sure yet about splitting back out -- let me try and figure out what
> > all is actually done / needed.
> >
> > So blocked_lock started out as another lock around ttwu(), in order to
> > serialize the task wakeup vs reading a remote ->blocked_on relation.
> 
> I think of it primarily to serialize the task->blocked* state (there
> gets to be quite a bit by the end of the proxy series).
> 
> > Since we do this with rq->lock held, it can't be ->pi_lock, and hence
> > ->blocked_lock was born.
> 
> Yeah, we needed to use something other than the task->pi_lock to
> serialize it as it has to nest under the mutex->wait_lock.

No, the critical bit is nesting under rq->lock -- we need to be able to
walk the blocked relation in the middle of schedule(). You can equally
wrap blocked_lock outside of wait_lock, that doesn't really matter much.

> > Later patches appear to have moved it into mutex, mirroring the
> > ->wait_lock -- this is probably better.
> >
> > /me goes chase that state thing for a bit..
> 
> ? I'm not sure I followed this.  The blocked_lock continues to
> serialize the task->blocked* state through the patch series.

Well, there was only ->blocked_on, and on UP you don't need
serialization beyond disabling preemption.

The tricky bit is SMP, then you need something to stabilize the blocked
relation.


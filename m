Return-Path: <linux-kernel+bounces-448852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4D9F4672
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E57A3DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F51714BE;
	Tue, 17 Dec 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RgRSLzpH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37019B5B4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425318; cv=none; b=lBNd/5sRCbCOjimOG04YBaIweAjkxXrgLbfGQHpGsgSfljCBM2M8a62QvFzV+baOqXMvz8/v/9lMrdeTpar28TWlNem3Lw6G7ZD15z23sd5mBibD76stBTECa7RfwfauUsE49xBMQdedhHDnHSIiq37MTtPUMI5XqTTRAPu4HP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425318; c=relaxed/simple;
	bh=v7K3LTf7evJOgrKhRDWImRtt3LO0+IhgNWsGfnmegHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyW34bLDvAGtva2oS0BDOvCzLP/skAeyrbptm01wtKRbxybrKQG7cNNBXo/Weh+r7CWvkFrEHAUMUDdNKYcQe///ulj9yK1749fkNCCRqXCbwPBN144xr2LWWG3gM8WTBMfY9CWov3WZ8ns4Ep62+hfQsznaDI8QGzIW5NE5YsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RgRSLzpH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=V2vSXprZooYw8v3cMOSRLXATROv2oqgwW+OHCJ4mSm0=; b=RgRSLzpH95EK9zBV4m0wC1Kvo/
	fvFxxCS/VWKvQS8B6OPe/wvtPcn14MJd2pZ6l6NzRTJEFqsBFDU6uUA2xSRDJAMl7Xv8kL3I4vrwC
	y+PNu74lUGsONIbsHukPL356+XLG/Mz9Qv9CTqD0Yc4BzO7hMnoOpOFCgO8WiB/sUtPcpdxXCIeoK
	+NH6XAqB7CnFcsLog3RRXsyRmsunU0lNTpwGJXM2K3OZhCb1X9adwGLUAuWskwjbbNwVH3G18vq8B
	GaA6S+pS07Sg+dl8ag5gRKFQ+WhCeRxwd8DH8lIOf+4EI/L9RQy4+LY8RUsQciDduBP16bGEU01th
	YdKup7yg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTFl-00000005sDK-3xWK;
	Tue, 17 Dec 2024 08:48:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6E28C300192; Tue, 17 Dec 2024 09:48:29 +0100 (CET)
Date: Tue, 17 Dec 2024 09:48:29 +0100
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
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Subject: Re: [RFC][PATCH v14 3/7] sched: Fix runtime accounting w/ split exec
 & sched contexts
Message-ID: <20241217084829.GH35539@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-4-jstultz@google.com>
 <20241213233740.GB17501@noisy.programming.kicks-ass.net>
 <20241214000951.GA16123@noisy.programming.kicks-ass.net>
 <CANDhNCoMz9m_U_86utexFp8+QgVr8rEdGwOygBbNEpwtsByxeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoMz9m_U_86utexFp8+QgVr8rEdGwOygBbNEpwtsByxeA@mail.gmail.com>

On Mon, Dec 16, 2024 at 10:09:16PM -0800, John Stultz wrote:
> On Fri, Dec 13, 2024 at 4:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sat, Dec 14, 2024 at 12:37:40AM +0100, Peter Zijlstra wrote:
> > > Would it not be *much* clearer if we do it like:
> > >
> > > static s64 update_curr_se(struct rq *rq, struct sched_entity *donor,
> > >                         struct sched_entity *curr)
> > > {
> > >       ...
> > >       donor->exec_start = now;
> > >       curr->exec_start = now;
> > >       curr->sum_exec_runtime += delta_exec;
> > >       ...
> > > }
> > >
> > > and update the callsites like so:
> > >
> > > update_curr_common()
> > >       update_curr_se(rq, &donor->se, &rq->curr.se)
> > >
> > > update_curr()
> > >       update_curr_se(rq, &curr->se, &curr->se);
> > >
> > >
> > > except, now I'm confused about the update_curr() case. That seems to
> > > always update the execution context, rather than the donor ?
> >
> > Ah no, cfs_rq->curr is the donor.
> 
> Yeah. That is one detail in the current series where the naming can be
> particularly confusing.
> 
> I can go through and rename cfs_rq->curr to cfs_rq->donor (or some
> other name) to make it more clear, but it seems like a ton of churn,
> so I've been hesitant to do so until there was stronger consensus to
> taking the patch series, but maybe we're at that point now?

Nah, it was just me being confused, lets keep down the curn for now.

> But maybe a simpler and more isolated fix is I could just rework
> update_curr_se to just take the rq* and we can derive the donor.se and
> curr.se from that.

You can't; rq only has tasks, while cfs_rq is a hierarchy with many se's
backing a single task :/


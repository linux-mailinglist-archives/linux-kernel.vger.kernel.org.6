Return-Path: <linux-kernel+bounces-564408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9664A65451
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670057A53BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C22459C2;
	Mon, 17 Mar 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DtzeYyDX"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871424397A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223028; cv=none; b=ioEP7aZX64kvD7wk4RC6z/0u92j8Ico+bnWQcCAgevOVi8vegeZTDaFgY2rFnsa0/OzqFHgCNdJubVuZ/A88DjUw0JTKjPIEcZ9VWqOyxfgS5VkfvNjz0i4FSo09sbcH7l4/FG+W/3AJe/mGKRSWYs+vHpyapOcmgOyySmXHCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223028; c=relaxed/simple;
	bh=o8PVkLkttFxiDUx9o+jcZ/GKuzRUyLmhESRH0zszrKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIgtciqubtiN1+Lywofq+IC1H6yFsT6ayXkAAbIndI70QczPcvcBDb5TylqQglF8v8PaKI6wwUu0GZjV+CMwB+NmKa/WQFIdR/e3Vz4fZQzeEhU0s/h1lld7/gR4HdO77B0ZbQBBHmwfcml7cOgpgWZk+d2eTBuji8U25YQYfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DtzeYyDX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9Hl0Ua6zEXnX2ZwDutSTzWCK5K2P76jP5Q2VCSF84Ns=; b=DtzeYyDXvRAUpfHk5Hk65VTFzh
	dtHc2vtT9kC/Ir/Ocn0Lc1wDUaKXkXaQAbwKS7GGac2jYGKgeIW3X9YGeyKDNAXYSfEpl+4hNdFTh
	awfgf9LqZCBnryu/uF4BilOHWIM1vrgIcpHPuhBHZwSS7IQMkGILHMxaRftQR+xursjl/sEYStDzg
	EWDStakdPB5nbAevGP/AGq7BEj3qMZoOrgJGH77ZdpSb68GNypQ6xgTdsZ1WocNwlyFu3Cqsyr6hG
	3owY8gjmkHe7HGAmAKu+wztzn6VGZyAiCYpc0w4CQLIod4muFSKzwi2bkwxFkS23e0oQckv0vCEsi
	8PDahgiA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuBnD-00000003T4N-47UM;
	Mon, 17 Mar 2025 14:50:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BC25300783; Mon, 17 Mar 2025 15:50:15 +0100 (CET)
Date: Mon, 17 Mar 2025 15:50:15 +0100
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
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH v15 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
Message-ID: <20250317145015.GA31506@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-2-jstultz@google.com>
 <20250317143347.GE36386@noisy.programming.kicks-ass.net>
 <CANDhNCrCmNVQjAy2pHY_K3VYR=f_44fqPRnAP-mr16yUhk8rPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrCmNVQjAy2pHY_K3VYR=f_44fqPRnAP-mr16yUhk8rPw@mail.gmail.com>

On Mon, Mar 17, 2025 at 03:44:11PM +0100, John Stultz wrote:
> On Mon, Mar 17, 2025 at 3:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Mar 12, 2025 at 03:11:31PM -0700, John Stultz wrote:
> >
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index d0d021b3fa3b3..b989ddc27444e 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -875,6 +875,16 @@ config UCLAMP_BUCKETS_COUNT
> > >
> > >         If in doubt, use the default value.
> > >
> > > +config SCHED_PROXY_EXEC
> > > +     bool "Proxy Execution"
> > > +     default n
> > > +     # Avoid some build failures w/ PREEMPT_RT until it can be fixed
> > > +     depends on !PREEMPT_RT
> >         depends on !SPM && !SCHED_CLASS_EXT
> >
> > for now, right?
> 
> Did you mean SMP there?  SMP is supported. Even with same rq proxying,
> it just blocks the task and lets it sleep if the owner is on another
> rq.

Ah, yes, typing hard. And yes, I missed it would work rq local. Still
trying to untangle the proxy_deactivate() failure case :-)


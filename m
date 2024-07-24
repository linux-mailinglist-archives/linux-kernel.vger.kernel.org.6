Return-Path: <linux-kernel+bounces-260780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839D93AE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F83D28291C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782E14C59A;
	Wed, 24 Jul 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AC2afsFL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA91B285
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811151; cv=none; b=EgNkOJk6ruf1srvyJQwKVwm61+9/rHmCDmPt4FB9Qzol9+NTqTG9juv3pojSVnElzdctwI7cbbfodQXhmpF7jaSLGyC+ULaGgbWbRz/vjXW6c0sNOsqMJfJyj4JowQMtDa/4KHenwOKEoMBkjbjsaxiLHHj2h+9XFIf0DFblyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811151; c=relaxed/simple;
	bh=5lgCsyS1C/hoVQ2x7EY+Yn5ZjEGmeOgopVY4+iKBx3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuZtcRj2kXKib5SuM2fjeCPrlaWQfFWg5zT8RMSzWA6AJ24L9AWHWtIhcQWExFAKT2ejY2eaTAkhaITVpfNpPizNkTtkpIcWayyYBmsije/Eks3y5MSoJB1KeGnot9hL4ZfvJ+Z28PO+Dxd2bq3MfS2Q0rRP/JSEQHRn2DX0ACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AC2afsFL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MIn5LMU5wq5hXf7/THqhoMmq+3JsfKQJaUvx1cwvb5Y=; b=AC2afsFLmdal8snF9jaLHE5eN6
	Ins10jbxjsJKSbO6yaCQz0bATS0Cp2Y8EwiFM9YvkhzDPtNfBqzmW2dTaXJGdTvLKNAzjE/k+jdy1
	Q22cQQZUUIUIHiQ45PlpFyBUUv1MqknNj6ZbJrrNxRPN94u8pz98/T+ATN0823GFWecXgIo8suj5r
	wu8MmUuFqDFjmABjOa+Ia8OKP95llQgBu6EkOb1Zhcd4VrU2askJ3t3W9iVNvVylKsFdfnsHroPKl
	+se+gw2NHUaYFUjDlfOGaWWi9uyBNYjPxnYpwaDVWlXHIfRitqF0fUN40bKytg0X0Hew2v3okL5Mh
	gT4/tXKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWXjS-00000007frI-14PG;
	Wed, 24 Jul 2024 08:52:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DDE633003EA; Wed, 24 Jul 2024 10:52:21 +0200 (CEST)
Date: Wed, 24 Jul 2024 10:52:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240724085221.GO26750@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqAFtfSijJ-KMVHo@slm.duckdns.org>

On Tue, Jul 23, 2024 at 09:34:13AM -1000, Tejun Heo wrote:

> > > +	for_each_active_class(class) {
> > >  		p = class->pick_next_task(rq);
> > > -		if (p)
> > > +		if (p) {
> > > +			const struct sched_class *prev_class = prev->sched_class;
> > > +
> > > +			if (class != prev_class && prev_class->switch_class)
> > > +				prev_class->switch_class(rq, p);
> > >  			return p;
> > > +		}
> > >  	}
> > 
> > So I really don't like this one.. at the very least it would need a comment
> > explaining why it only needs calling here and not every time a put_prev_task()
> > and set_next_task() pair cross a class boundary -- which would be the
> > consistent thing to do.
> > 
> > Now, IIRC, you need a class call that indicates you're about to loose the CPU
> > so that you can kick the task to another CPU or somesuch. And last time I got
> > it backwards and suggested adding an argument to pick_next_task(), but what
> > about put_prev_task()?
> >
> > Can't we universally push put_prev_task() after the pick loop? Then we get
> > something like:
> 
> Yeah, the problem with put_prev_task() was that it was before the next task
> was picked, so we couldn't know what the next class should be.

Right. But I don't think it needs to stay that way.

> > 	next = pick_task();
> > 	if (next != prev) {
> > 		put_prev_task(rq, prev, next->class != prev->class);
> > 		set_next_task(rq, next);
> > 	}
> > 
> > I have patches for most of this for fair (in my eevdf queue), and I
> > think the others are doable, after all, this is more or less what we do
> > for SCHED_CORE already.
> > 
> >   /me went off hacking for a bit
> > 
> > I've done this; find the results at: queue.git sched/prep
> > 
> > I've also rebased the sched_ext tree on top of that with the below delta, which
> > you can find at: queue.git sched/scx
> 
> Hmm... took a brief look, but I think I'm missing something. Doesn't
> put_prev_task() need to take place before pick_task() so that the previously
> running task can be considered when pick_task() is picking the next task to
> run?

So pick_task() came from the SCHED_CORE crud, which does a remote pick
and as such isn't able to do a put -- remote is still running its
current etc.

So pick_task() *SHOULD* already be considering its current and pick
that if it is a better candidate than whatever is on the queue.

If we have a pick_task() that doesn't do that, it's a pre-existing bug
and needs fixing anyhow.

> > This led me to discover that you're passing the task of the other class into
> > the bpf stuff -- I don't think that is a sane thing to do. You get preempted,
> > it doesn't matter from which higher class or by which specific task, a policy
> > must not care about that. So I kinda bodged it, but I really think this should
> > be taken out.
> 
> At least for visibility, I think it makes sense. One can attach extra BPF
> progs to track the preemption events but it can be useful for the scheduler
> itself to be able to colllect when and why it's getting preempted. Also, in
> a more controlled environments, which RT task is preempting the task can be
> a, while not always reliable, useful hint in whether it'd be better to
> bounce to another CPU right away or not. That said, we can drop it e.g. if
> it makes implementation unnecessarily complicated.

It shouldn't be too hard to 'fix', it just feel wrong to hand the next
task into the prev class for something like this.

> > I also found you have some terrible !SMP hack in there, which I've
> > broken, I've disabled it for now. This needs a proper fix, and not
> > something ugly like you did.
> 
> Yeah, this came up before. On UP, SCX either needs to call the balance
> callback as that's where the whole dispatch logic is called from (which
> makes sense for it as dispatching often involves balancing operations), or
> SCX itself needs to call it directly in a matching sequence. Just enabling
> balance callback on UP && SCX would be the cleanest.

Or make scx hard depend on SMP? Are there really still people using !SMP
-- and I suppose more importantly, do we care?

I mean, they could always run an SMP kernel on their UP potato if they
*really* feel they need this.

> > Anyway, it seems to build, boot and pass the sched_ext selftest:
> > 
> > PASSED:  21
> > SKIPPED: 0
> > FAILED:  0
> > 
> > (albeit with a fair amount of console noise -- is that expected?)
> 
> Yeah, the selftests trigger a lot of error conditions so that's expected.
> 
> > Also, why does that thing hard depend on DEBUG_BTF? (at least having
> > that option enabled no longer explodes build times like it used to)
> 
> That's necessary for building the schedulers, at least, I think. We didn't
> have that earlier and people were getting confused.

It's what made it difficult for me to even build this stuff, simple
things like:

  cd foo-build; ../scipts/config --enable CONFIG_SCHED_CLASS_EXT; cd -

don't work (nor error out on the lack of dependencies), and my build
scripts were force disabling the BTF crud -- and thus silently also the
scx thing.

It looks like I can change my builds scripts, because the reason I did
that was that BTF made the build times explode and that is no longer the
case.

> > Also should we /CONFIG_SCHED_CLASS_EXT/CONFIG_SCHED_BPF/ ? Then
> > something like: grep BPF foo-build/.config
> > more easily shows what's what.
> 
> I don't know. isn't that too inconsistent with other classes, and down the
> line, maybe there may be BPF related additions to scheduler?

We can always rename crap later if needed. Maybe I'm the weird one doing
grep on .config, dunno. I also edit raw diff files and people think
that's weird too.



Return-Path: <linux-kernel+bounces-387048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF19B4B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B31F23985
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E5205E1A;
	Tue, 29 Oct 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N0q/XtCe"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF722EAF1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209608; cv=none; b=mI0hyhmajzFw9cpf/aokdaK+s4Uaodv9W9OWScWXC5h0YO+giS+s3eoO8BgtQ0NhwGsGWJ4cenKVhiEVMiJA8LiZdemT9882faoGYRWYCrQILla+SY25abqBLvudpMB2HCqGi1E0PFIsXAOm7fFKDMYk3GqRkE286j1Z8HlxBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209608; c=relaxed/simple;
	bh=HcGjzj4qJ2ffwJc62k4bla6sh80QDI5qmkr6CzeH7g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak3YZ1ff8+fYGyal8c9J2YiyFN2Hk2CcoITtnHOHKFRIH45PEmzykk2cCl0f964ZUjjDaSF6F4ezFCvx7MG1FjsbDYPcdYsLJ2qXcs7JYLxBtb95wIwxvNQJO7SxS3EK8IO1cgNNTipDU3CUYz3IuacB+N3ie9CYMbu1oJ5Pqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N0q/XtCe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z8SicmJPe91V7nwH+BPJtaqFkv7A2APH/euLs/x+oZI=; b=N0q/XtCeDkGehuNO47KTiTC3AT
	vkkLLByfy7txiUw/RL/wQdtHM7XZmT+g2sJFm4rKkS+P6ZcTZlaawdsQxhCqZKX/bSC8P219FFPTy
	AQZrV1GQKT0OJbb9ejHf82tW8wEOqmxLGqyg5L2KshU4JdDwVEAwLEr9ePNHaXAE7uEYyxc8rZGxn
	T8QzFj1p4NXuwUDc2P+ah4MAmjKe36mwfjw0k5UmXjsCRL/U50AoJ0KcCmu2Rmy3AsneX07jcB+cM
	TcPytq123vd6drDfj4uaQ2/HEBSy4mdniquNwprFi4rztP6xMtiRHEsVwwW6c/PdzqWwBGiJfX3II
	xSSJAW5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mYU-00000009uRU-1Tym;
	Tue, 29 Oct 2024 13:46:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 01DB830073F; Tue, 29 Oct 2024 14:46:42 +0100 (CET)
Date: Tue, 29 Oct 2024 14:46:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] kcsan, seqlock: Support seqcount_latch_t
Message-ID: <20241029134641.GR9767@noisy.programming.kicks-ass.net>
References: <20241029083658.1096492-1-elver@google.com>
 <20241029114937.GT14555@noisy.programming.kicks-ass.net>
 <CANpmjNPyXGRTWHhycVuEXdDfe7MoN19MeztdQaSOJkzqhCD69Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPyXGRTWHhycVuEXdDfe7MoN19MeztdQaSOJkzqhCD69Q@mail.gmail.com>

On Tue, Oct 29, 2024 at 02:05:38PM +0100, Marco Elver wrote:
> On Tue, 29 Oct 2024 at 12:49, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 29, 2024 at 09:36:29AM +0100, Marco Elver wrote:
> > > Reviewing current raw_write_seqcount_latch() callers, the most common
> > > patterns involve only few memory accesses, either a single plain C
> > > assignment, or memcpy;
> >
> > Then I assume you've encountered latch_tree_{insert,erase}() in your
> > travels, right?
> 
> Oops. That once certainly exceeds the "8 memory accesses".
> 
> > Also, I note that update_clock_read_data() seems to do things
> > 'backwards' and will completely elide your proposed annotation.
> 
> Hmm, for the first access, yes. This particular oddity could be
> "fixed" by surrounding the accesses by
> kcsan_nestable_atomic_begin/end(). I don't know if it warrants adding
> a raw_write_seqcount_latch_begin().
> 
> Preferences?

I *think* it is doable to flip it around to the 'normal' order, but
given I've been near cross-eyed with a head-ache these past two days,
I'm not going to attempt a patch for you, since I'm bound to get it
wrong :/

> > > therefore, the value of 8 memory accesses after
> > > raw_write_seqcount_latch() is chosen to (a) avoid most false positives,
> > > and (b) avoid excessive number of false negatives (due to inadvertently
> > > declaring most accesses in the proximity of update_fast_timekeeper() as
> > > "atomic").
> >
> > The above latch'ed RB-trees can certainly exceed this magical number 8.
> >
> > > Reported-by: Alexander Potapenko <glider@google.com>
> > > Tested-by: Alexander Potapenko <glider@google.com>
> > > Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/linux/seqlock.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > > index fffeb754880f..e24cf144276e 100644
> > > --- a/include/linux/seqlock.h
> > > +++ b/include/linux/seqlock.h
> > > @@ -614,6 +614,7 @@ typedef struct {
> > >   */
> > >  static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
> > >  {
> > > +     kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> > >       /*
> > >        * Pairs with the first smp_wmb() in raw_write_seqcount_latch().
> > >        * Due to the dependent load, a full smp_rmb() is not needed.
> > > @@ -631,6 +632,7 @@ static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *
> > >  static __always_inline int
> > >  raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
> > >  {
> > > +     kcsan_atomic_next(0);
> > >       smp_rmb();
> > >       return unlikely(READ_ONCE(s->seqcount.sequence) != start);
> > >  }
> > > @@ -721,6 +723,13 @@ static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
> > >       smp_wmb();      /* prior stores before incrementing "sequence" */
> > >       s->seqcount.sequence++;
> > >       smp_wmb();      /* increment "sequence" before following stores */
> > > +
> > > +     /*
> > > +      * Latch writers do not have a well-defined critical section, but to
> > > +      * avoid most false positives, at the cost of false negatives, assume
> > > +      * the next few memory accesses belong to the latch writer.
> > > +      */
> > > +     kcsan_atomic_next(8);
> > >  }
> >
> > Given there are so very few latch users, would it make sense to
> > introduce a raw_write_seqcount_latch_end() callback that does
> > kcsan_atomic_next(0) ? -- or something along those lines? Then you won't
> > have to assume such a small number.
> 
> That's something I considered, but thought I'd try the unintrusive
> version first. But since you proposed it here, I'd much prefer that,
> too. ;-)
> Let me try that.
> 
> Thanks,
> -- Marco


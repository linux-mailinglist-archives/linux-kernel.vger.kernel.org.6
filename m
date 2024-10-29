Return-Path: <linux-kernel+bounces-386998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28659B4A98
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33BD28335F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB8205E17;
	Tue, 29 Oct 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="or+EwbV7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77170C2ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207183; cv=none; b=eQsXBSnD5kZ18T7jF0HBDNpwH0L4Jq+3p41UXIaZZ1PUcLZ40sZklUnxk/v/v5qx/pLgk1R36+5jSxPIzafVbi6etcYr7et5wjUkFyXUXJuDSwzy9a6CSJC3P+tn5FXeXveX0Pbwp1xa2EH55Cc93TryymVzPeWTZvHKFm+b9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207183; c=relaxed/simple;
	bh=48vTuMVxOY3Vh3K7QBbivurdZXR3WfKhrPNH8x35x0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AocRMjSz8zccyOvq3yBEXbyi6SIMT63rNKb0mwEJNNrCpf86ykPNqfe3nC4SsCuDnZEjBW9jfy4lx5gU6FKl9o0q0x/UWiibWqO4yENEGM67gu3RP76itzrnEgZpQG28kvfu1EzJ+ZDUl7MQstdT36Y7Lff3nDjRXIauAzUvNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=or+EwbV7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso3943940b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730207181; x=1730811981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NHj8IGmGIs1egtb7syFkJuryY4pVczFLIPpjJP1F+TM=;
        b=or+EwbV70niuvyt0qIDv1tj0Dv/NOliiwJV4PdZ5CN+hPD9r74pTCpeDQTA3iebRw2
         XB5xgfUrgiwyhIeXJSJcKScg4/7/ulav9ZPHrDqr0b24uw/c6MDA5M3OinsAbXTFxvPC
         1uNAvKZXxGiTLLGPsL1ivDPb1B5iNeTDhxdXr2qyr8l+wgohieaRgFTuiDsOAsjFo79b
         VcP/90X42bC1M+HGl7LiN5EqzaPv3eia/a8br4HpraizKQRE2kWOfSPiiB1izUjceQTS
         JsX7LzPu2xRVy2iPCi9wIoePnI8BWW/LKg93kU0typRh64oMlrBMfrh+hVF+7heW5uy7
         uhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207181; x=1730811981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHj8IGmGIs1egtb7syFkJuryY4pVczFLIPpjJP1F+TM=;
        b=bKmjA5nN4khHnuZ8awF6YbwhmUW/BjHg1qYBv1Xg5FBcrtK3jKxl+4a71wLqAY4QHN
         +ukUNkRIfGNzJAzVbT1z7xLcdwsOoPYG9o/N6Av8ZbRG0P/J/tL/Lht7BaAvi1xyr2rt
         zDjX8/v9cfQjzV/x+UU8pu6HFHtugHGILI79AwjFxGAa1EY5McMLiQliLNCaue+/ATz/
         1+MgRdoFMXn76f+gq0SZRo2DWQmJvXIttnWCy+g8QeUDj4D90/DOlCL+PMDkG9zPtWFq
         cmls2AbBNB+S+95lUzvlxgovuAqbV/8xYKlVw4AtkX+8Cjk2tTpL9T9/TXxxmBR3gYMM
         92+w==
X-Forwarded-Encrypted: i=1; AJvYcCXhgyOX5ebDLrMkkXE127vm8qg86I9+hU1TU6ohEkJBItl0bd23a8V4XEcLdpH5yMvWV3Dc3deUQ6EpZwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8TuFEsaFfbBHRIdmPTPeb/gspUc2SplBXKSIH3KdHFA1jFKL
	uI38sEl47Oi5/7pPeBkNm2luK5dMZfVJAkCdk0X51URr9aeLd1N8wPu/dTDSM7CU6VGHWzU21zD
	URjCSjmTj0j3JgVS0GRbBIxWVdQ6X8jW23NDQ
X-Google-Smtp-Source: AGHT+IFqgq9XP2OlsftQqekOzP9p6HoWIcNFPPYFQP/nwtgiEeSO9cYr1iWcK3DznxduaspwjF0ybkZey+m6cNaweGs=
X-Received: by 2002:a05:6a00:3cc8:b0:71e:e3:608 with SMTP id
 d2e1a72fcca58-7206306ebb4mr15810841b3a.26.1730207180368; Tue, 29 Oct 2024
 06:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029083658.1096492-1-elver@google.com> <20241029114937.GT14555@noisy.programming.kicks-ass.net>
In-Reply-To: <20241029114937.GT14555@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 29 Oct 2024 14:05:38 +0100
Message-ID: <CANpmjNPyXGRTWHhycVuEXdDfe7MoN19MeztdQaSOJkzqhCD69Q@mail.gmail.com>
Subject: Re: [PATCH] kcsan, seqlock: Support seqcount_latch_t
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 12:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 29, 2024 at 09:36:29AM +0100, Marco Elver wrote:
> > Reviewing current raw_write_seqcount_latch() callers, the most common
> > patterns involve only few memory accesses, either a single plain C
> > assignment, or memcpy;
>
> Then I assume you've encountered latch_tree_{insert,erase}() in your
> travels, right?

Oops. That once certainly exceeds the "8 memory accesses".

> Also, I note that update_clock_read_data() seems to do things
> 'backwards' and will completely elide your proposed annotation.

Hmm, for the first access, yes. This particular oddity could be
"fixed" by surrounding the accesses by
kcsan_nestable_atomic_begin/end(). I don't know if it warrants adding
a raw_write_seqcount_latch_begin().

Preferences?

> > therefore, the value of 8 memory accesses after
> > raw_write_seqcount_latch() is chosen to (a) avoid most false positives,
> > and (b) avoid excessive number of false negatives (due to inadvertently
> > declaring most accesses in the proximity of update_fast_timekeeper() as
> > "atomic").
>
> The above latch'ed RB-trees can certainly exceed this magical number 8.
>
> > Reported-by: Alexander Potapenko <glider@google.com>
> > Tested-by: Alexander Potapenko <glider@google.com>
> > Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/seqlock.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index fffeb754880f..e24cf144276e 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -614,6 +614,7 @@ typedef struct {
> >   */
> >  static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
> >  {
> > +     kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> >       /*
> >        * Pairs with the first smp_wmb() in raw_write_seqcount_latch().
> >        * Due to the dependent load, a full smp_rmb() is not needed.
> > @@ -631,6 +632,7 @@ static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *
> >  static __always_inline int
> >  raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
> >  {
> > +     kcsan_atomic_next(0);
> >       smp_rmb();
> >       return unlikely(READ_ONCE(s->seqcount.sequence) != start);
> >  }
> > @@ -721,6 +723,13 @@ static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
> >       smp_wmb();      /* prior stores before incrementing "sequence" */
> >       s->seqcount.sequence++;
> >       smp_wmb();      /* increment "sequence" before following stores */
> > +
> > +     /*
> > +      * Latch writers do not have a well-defined critical section, but to
> > +      * avoid most false positives, at the cost of false negatives, assume
> > +      * the next few memory accesses belong to the latch writer.
> > +      */
> > +     kcsan_atomic_next(8);
> >  }
>
> Given there are so very few latch users, would it make sense to
> introduce a raw_write_seqcount_latch_end() callback that does
> kcsan_atomic_next(0) ? -- or something along those lines? Then you won't
> have to assume such a small number.

That's something I considered, but thought I'd try the unintrusive
version first. But since you proposed it here, I'd much prefer that,
too. ;-)
Let me try that.

Thanks,
-- Marco


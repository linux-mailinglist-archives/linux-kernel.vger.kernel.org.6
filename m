Return-Path: <linux-kernel+bounces-378934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C649AD76A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98DB1C20E17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8801FEFB6;
	Wed, 23 Oct 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSx1W2cA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7E1FDFBD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721840; cv=none; b=a4JvRIe+nUgItPbWGfrRIrW13Re7naGKFExiGYSRTuGs9jNZlhTZyLtiWPhFpsC/FWcoO/c3v5Cs1ibblLNPCVp1wz8qafTv61uOtfi6q96lq0l3TRaRPK8nsLEZKYgpvJmwIdZrO4FsUiQiecrIo/CS7RWO1IOJHyiKD5yETKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721840; c=relaxed/simple;
	bh=dJMRml3b5d6K+LJ03f35i2p2yGOCULNdRud36RK6mag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpXfgFbiEOVqeyD8UwH3aANqx0wm5fx72w6h55PFHfuTTgG8YOFB5hpH+Yuc2kUeu0jbWW6xviOJFT7lcWeytdBysRZDJz22ULH5kJD7kxUAqwo+6hoiiTeOZy+e+D9q5momYlx9NqPFM1MO7HcrNH3kDww7RXGr4+Nn0vRLl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSx1W2cA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so32285e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729721836; x=1730326636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYnah6UupQZI0qWCXiKPjf/9J0hvWERnQJhCh6/oVVA=;
        b=RSx1W2cAe6tA7n2eTAMJ5VtIlll50Pkat3Q4XQWf/z+xGnn9v6iwIwcUNe2Q6oE1VU
         uwiHht3r1VBMDqu4Z+1yEmHAqdq6K6QWuqR5VIYcYsZKb0DVIQxEamUB/X7WP9bP2TFL
         /24ydacUlgD7cELCJaacFpmVyWXUiq9TCyp6p3afYvH+HwGLtITQYI2q4t6IhXFdk/hI
         F9tqnGucLKZ7OTOf4aeO84JDLlWDriXDPSazRJ2BVX53enf+JSsQ7Aoik80mJu56P1Ek
         FHg5cHygjHRbycWyUm/VuqUHj5K5Ltbmp1Ta/ETe8S8Allo4BZ8my+5bgNgnWAdq1m9g
         c6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729721836; x=1730326636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYnah6UupQZI0qWCXiKPjf/9J0hvWERnQJhCh6/oVVA=;
        b=REOQLWWh+QW5lgHz+2Xkk2kvyP5chQ6VmIS27ncOPUANIQUhFa3dgBOZK2vLJvnXO6
         Cq6UfUPqLeBPdcLmCe4jGvqUTgzpxzJbC3JiUtiwVlvJg1RvMKG50Nl4tnt7B1iXbLn6
         LjldFHmbeZSORjbcED2eCueT8CpP4vs4dqdUrrXj12sEgZDPlFDNiQcB6uaIW01lsLfp
         dsSyOLRQqScAkVoAuIyCIsO3VNuN26HfnrtojMBrq4C/SOqzUfbXcnT18cR8Wdb+NxP+
         H6Nw8l+8MbqNqt1HKHQWu3ETjcd7bwbX0Bj3K6ElNvDegPwgtW3kXxZR2OUlOjldW/ST
         FOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVam3YoMtTjT1Zv1ouID6v6IvgeI34sNJbYSQ+Bek6Kf44RCOgnstcbYOc06o2P96hbGiSwmCRSFV2mUj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fZFh67T64kfoqfzFBqEIalDRSCiQpJjvtXaFfWWzi6x3XCEh
	9MlQ9Rrc1VxACxplaSQELSubIatC50soNFcYrL1/vYLj63/eabNdiw7GU0kpthQJnumrn27c9kb
	yZ75qdRZeKSVteVqKqDnDw+3Xuw28s0gdt8H2
X-Google-Smtp-Source: AGHT+IG5NEdVkdVtPRBWmJxwh6d5994BuIu+YOC4gDRr/xGcvo3Gj3xpwSvpVaHjGoNST0roRaIqGgsj1KgLmsaWduk=
X-Received: by 2002:a05:600c:5023:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-4318a50525emr1664815e9.2.1729721836377; Wed, 23 Oct 2024
 15:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net>
In-Reply-To: <20241023201031.GF11151@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Oct 2024 15:17:01 -0700
Message-ID: <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:10=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Oct 10, 2024 at 01:56:41PM -0700, Andrii Nakryiko wrote:
> > From: Suren Baghdasaryan <surenb@google.com>
> >
> > Add helper functions to speculatively perform operations without
> > read-locking mmap_lock, expecting that mmap_lock will not be
> > write-locked and mm is not modified from under us.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@google=
.com
> > ---
> >  include/linux/mm_types.h  |  3 ++
> >  include/linux/mmap_lock.h | 72 ++++++++++++++++++++++++++++++++-------
> >  kernel/fork.c             |  3 --
> >  3 files changed, 63 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 6e3bdf8e38bc..5d8cdebd42bc 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -887,6 +887,9 @@ struct mm_struct {
> >                * Roughly speaking, incrementing the sequence number is
> >                * equivalent to releasing locks on VMAs; reading the seq=
uence
> >                * number can be part of taking a read lock on a VMA.
> > +              * Incremented every time mmap_lock is write-locked/unloc=
ked.
> > +              * Initialized to 0, therefore odd values indicate mmap_l=
ock
> > +              * is write-locked and even values that it's released.
> >                *
> >                * Can be modified under write mmap_lock using RELEASE
> >                * semantics.
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index de9dc20b01ba..9d23635bc701 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -71,39 +71,84 @@ static inline void mmap_assert_write_locked(const s=
truct mm_struct *mm)
> >  }
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> > +static inline void init_mm_lock_seq(struct mm_struct *mm)
> > +{
> > +     mm->mm_lock_seq =3D 0;
> > +}
> > +
> >  /*
> > - * Drop all currently-held per-VMA locks.
> > - * This is called from the mmap_lock implementation directly before re=
leasing
> > - * a write-locked mmap_lock (or downgrading it to read-locked).
> > - * This should normally NOT be called manually from other places.
> > - * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > - * *all* VMA write locks, including ones from further up the stack.
> > + * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE s=
emantics)
> > + * or write-unlocked (RELEASE semantics).
> >   */
> > -static inline void vma_end_write_all(struct mm_struct *mm)
> > +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
> >  {
> >       mmap_assert_write_locked(mm);
> >       /*
> >        * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
> >        * mmap_lock being held.
> > -      * We need RELEASE semantics here to ensure that preceding stores=
 into
> > -      * the VMA take effect before we unlock it with this store.
> > -      * Pairs with ACQUIRE semantics in vma_start_read().
> >        */
> > -     smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +
> > +     if (acquire) {
> > +             WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +             /*
> > +              * For ACQUIRE semantics we should ensure no following st=
ores are
> > +              * reordered to appear before the mm->mm_lock_seq modific=
ation.
> > +              */
> > +             smp_wmb();
>
> Strictly speaking this isn't ACQUIRE, nor do we care about ACQUIRE here.
> This really is about subsequent stores, loads are irrelevant.
>
> > +     } else {
> > +             /*
> > +              * We need RELEASE semantics here to ensure that precedin=
g stores
> > +              * into the VMA take effect before we unlock it with this=
 store.
> > +              * Pairs with ACQUIRE semantics in vma_start_read().
> > +              */
>
> Again, not strictly true. We don't care about loads. Using RELEASE here
> is fine and probably cheaper on a few platforms, but we don't strictly
> need/care about RELEASE.
>
> > +             smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +     }
> > +}
>
> Also, it might be saner to stick closer to the seqcount naming of
> things and use two different functions for these two different things.
>
> /* straight up copy of do_raw_write_seqcount_begin() */
> static inline void mm_write_seqlock_begin(struct mm_struct *mm)
> {
>         kcsan_nestable_atomic_begin();
>         mm->mm_lock_seq++;
>         smp_wmb();
> }
>
> /* straigjt up copy of do_raw_write_seqcount_end() */
> static inline void mm_write_seqcount_end(struct mm_struct *mm)
> {
>         smp_wmb();
>         mm->mm_lock_seq++;
>         kcsan_nestable_atomic_end();
> }
>
> Or better yet, just use seqcount...

Yeah, with these changes it does look a lot like seqcount now...
I can take another stab at rewriting this using seqcount_t but one
issue that Jann was concerned about is the counter being int vs long.
seqcount_t uses unsigned, so I'm not sure how to address that if I
were to use seqcount_t. Any suggestions how to address that before I
move forward with a rewrite?

>
> > +
> > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, i=
nt *seq)
> > +{
> > +     /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > +     *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> > +     /* Allow speculation if mmap_lock is not write-locked */
> > +     return (*seq & 1) =3D=3D 0;
> > +}
> > +
> > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int=
 seq)
> > +{
> > +     /* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
> > +     smp_rmb();
> > +     return seq =3D=3D READ_ONCE(mm->mm_lock_seq);
> >  }
>
> Because there's nothing better than well known functions with a randomly
> different name and interface I suppose...
>
>
> Anyway, all the actual code proposed is not wrong. I'm just a bit
> annoyed its a random NIH of seqcount.

Ack. Let's decide what we do about u32 vs u64 issue and I'll rewrite this.


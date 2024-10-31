Return-Path: <linux-kernel+bounces-390043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047839B74DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224D61C249A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD60145B1D;
	Thu, 31 Oct 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZEJ5cTG"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD704437C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358019; cv=none; b=DjXrPPkIjRL6b042OOYjzSoRZzvNbOpLDwsvD0IFTI2vMZ9as4nJLMycg022bwFEXvRf2zGYWiux/4O2gfF2ssaUpo9MZ5AT9nOLGOO0tpatfn0k949FW+4ML8gZNTVGzKwYaA9SHTSeO+Eo3JDc2wvNu2GoDZwwdalAEz8j5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358019; c=relaxed/simple;
	bh=B6An2IvJucez0AEBnS3I6G6IIM6TOkIcRf0Wf7gKEDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHx2kZ6qtglP6eTV4yOrkxu9T7AlX45bQX58uUVeN3OYErMsgHe9UKvWiXZDzntA0hNVhvAeelMRRXQQQCDQqeeIHFHLRzSd72tKtVcgnrtEqa3ieGS+2sqk3AAQM/QvotU99jbPWmJbFTPfE1nWfxlwvKZin2tKINygZ7KE8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZEJ5cTG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-718065d6364so298028a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730358015; x=1730962815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sppGUZRH/VIPn+CbB520cu48wmx8heQ3RHF4CC/cpsk=;
        b=AZEJ5cTGPA3E9SJO7BhvxWu6Ps0Xw2SoD/ZCBopq9kqFqJCMTnD+OezFr1JvdFDokW
         MXqNERPZV2YNaSe9zxSMvhWagT6rQ/ZUtgyCouNjvkQVqdEHQ+yGhnu9BzwnULcLUtaR
         UFksL70aNzN6qZemZeP2PIYK42TdW1qDdwZ4bscd/q0kfcbFiO1tOE+g4l0lzlmO/FIF
         3vg+veZkpwqNZxHnwXOd4ydCBcvaqpEoZkpQUlVlS3DgjGvC8dcud6YhOJvCvLsaSVgk
         oVJqOkWY7Po1YjjD70Sqh/+iWaO62F9sT63sgZH0eEzRcJXF0TWqa7cgovDktEOtizqr
         Hgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730358015; x=1730962815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sppGUZRH/VIPn+CbB520cu48wmx8heQ3RHF4CC/cpsk=;
        b=tGh5Yhn9YSAKvK4Ku2lMFTfV7Et62SnCO8uBqS6AttoPY5Wu7urgDDAoqi4AyXVM1/
         b2+vYmAUiCMPIo/Oc8NXqMGeAc3Vx0bRb4+SnXYdh7dRaN/OKAkiiANkpZ42omKGmZHB
         t0DWuVIjs3ni/6WUltozHvIYTenudMzMwqJQwIRrCSsUGXUnUJJMWe6OxsuFMc1mL7A4
         cSAKfT4YZ8pmtrLFwsgrZYg/dFxd0az10+iS7mQ1fccijGitCWnNerqBknbekqldy0P4
         /ov0qh6vDkq1bVsBIFkqY/E7D7ws+pE2Ac+lQtwO/nv3wOF0sDpJp7/f996Tktim8BHX
         DuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkhMw8WZqHc5zIyA7m0F8COvj2aSs3IYR1sSqb+gFHCrGXzecdCsF55WFjrVzDDXS5Rgpc6qckGypwCyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wdTnMOlSezXCXj614eyvGD/4MDa2H5tnxBA+Zdt/at4VackG
	521JiihpMPnCkRqhyH6ScrAnnFVdwgMNDerEZ5Q/ZskSu2ug0T5qmA9WNpyfpeJfxPXefIa4l7+
	sD75+yqv7KGlHT8izfDKFUEZReRwHsC1pk74VyESFeIuICkvpUQ==
X-Google-Smtp-Source: AGHT+IGXpJ7JzPXzVM3yw0TjbfW3oLL9r2NiggwI70oZi2p9irwBFs8PewJUHIct8ZSw4i9kjbBDZHj7+5fXFVNoDyo=
X-Received: by 2002:a05:6870:b522:b0:261:86d:89e2 with SMTP id
 586e51a60fabf-29051d49278mr15266657fac.36.1730358015264; Thu, 31 Oct 2024
 00:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029083658.1096492-1-elver@google.com> <20241029114937.GT14555@noisy.programming.kicks-ass.net>
 <CANpmjNPyXGRTWHhycVuEXdDfe7MoN19MeztdQaSOJkzqhCD69Q@mail.gmail.com>
 <20241029134641.GR9767@noisy.programming.kicks-ass.net> <ZyFKUU1LpFfLrVXb@elver.google.com>
 <20241030204815.GQ14555@noisy.programming.kicks-ass.net>
In-Reply-To: <20241030204815.GQ14555@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 31 Oct 2024 08:00:00 +0100
Message-ID: <CANpmjNNsDG7J=ZsuA40opV1b3xKMF0P8P3yCsufowJCRegGa7w@mail.gmail.com>
Subject: Re: [PATCH] kcsan, seqlock: Support seqcount_latch_t
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 21:48, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 29, 2024 at 09:49:21PM +0100, Marco Elver wrote:
>
> > Something like this?
> >
> > ------ >8 ------
> >
> > Author: Marco Elver <elver@google.com>
> > Date:   Tue Oct 29 21:16:21 2024 +0100
> >
> >     time/sched_clock: Swap update_clock_read_data() latch writes
> >
> >     Swap the writes to the odd and even copies to make the writer critical
> >     section look like all other seqcount_latch writers.
> >
> >     With that, we can also add the raw_write_seqcount_latch_end() to clearly
> >     denote the end of the writer section.
> >
> >     Signed-off-by: Marco Elver <elver@google.com>
> >
> > diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> > index 68d6c1190ac7..311c90a0e86e 100644
> > --- a/kernel/time/sched_clock.c
> > +++ b/kernel/time/sched_clock.c
> > @@ -119,9 +119,6 @@ unsigned long long notrace sched_clock(void)
> >   */
> >  static void update_clock_read_data(struct clock_read_data *rd)
> >  {
> > -     /* update the backup (odd) copy with the new data */
> > -     cd.read_data[1] = *rd;
> > -
> >       /* steer readers towards the odd copy */
> >       raw_write_seqcount_latch(&cd.seq);
> >
> > @@ -130,6 +127,11 @@ static void update_clock_read_data(struct clock_read_data *rd)
> >
> >       /* switch readers back to the even copy */
> >       raw_write_seqcount_latch(&cd.seq);
> > +
> > +     /* update the backup (odd) copy with the new data */
> > +     cd.read_data[1] = *rd;
> > +
> > +     raw_write_seqcount_latch_end(&cd.seq);
> >  }
> >
> >  /*
>
> That looks about right :-)
>
> > ------ >8 ------
> >
> > I also noticed your d16317de9b41 ("seqlock/latch: Provide
> > raw_read_seqcount_latch_retry()") to get rid of explicit instrumentation
> > in noinstr.
> >
> > Not sure how to resolve that. We have that objtool support to erase
> > calls in noinstr code (is_profiling_func), but that's x86 only.
> >
> > I could also make kcsan_atomic_next(0) noinstr compatible by checking if
> > the ret IP is in noinstr, and immediately return if it is.
> >
> > Preferences?
>
> Something like this perhaps?

Looks good.

Let me try to assemble the pieces into a patch. (Your SOB will be
needed - either now or later.)

Thanks,
-- Marco

> ---
>  arch/x86/kernel/tsc.c        |  5 +++--
>  include/linux/rbtree_latch.h | 14 ++++++++------
>  include/linux/seqlock.h      | 31 ++++++++++++++++++++++++++++++-
>  kernel/printk/printk.c       |  9 +++++----
>  kernel/time/sched_clock.c    | 20 ++++++++++++--------
>  kernel/time/timekeeping.c    | 10 ++++++----
>  6 files changed, 64 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index dfe6847fd99e..67aeaba4ba9c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -174,10 +174,11 @@ static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long ts
>
>         c2n = per_cpu_ptr(&cyc2ns, cpu);
>
> -       raw_write_seqcount_latch(&c2n->seq);
> +       write_seqcount_latch_begin(&c2n->seq);
>         c2n->data[0] = data;
> -       raw_write_seqcount_latch(&c2n->seq);
> +       write_seqcount_latch(&c2n->seq);
>         c2n->data[1] = data;
> +       write_seqcount_latch_end(&c2n->seq);
>  }
>
>  static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
> index 6a0999c26c7c..bc992c61b7ce 100644
> --- a/include/linux/rbtree_latch.h
> +++ b/include/linux/rbtree_latch.h
> @@ -145,10 +145,11 @@ latch_tree_insert(struct latch_tree_node *node,
>                   struct latch_tree_root *root,
>                   const struct latch_tree_ops *ops)
>  {
> -       raw_write_seqcount_latch(&root->seq);
> +       write_seqcount_latch_begin(&root->seq);
>         __lt_insert(node, root, 0, ops->less);
> -       raw_write_seqcount_latch(&root->seq);
> +       write_seqcount_latch(&root->seq);
>         __lt_insert(node, root, 1, ops->less);
> +       write_seqcount_latch_end(&root->seq);
>  }
>
>  /**
> @@ -172,10 +173,11 @@ latch_tree_erase(struct latch_tree_node *node,
>                  struct latch_tree_root *root,
>                  const struct latch_tree_ops *ops)
>  {
> -       raw_write_seqcount_latch(&root->seq);
> +       write_seqcount_latch_begin(&root->seq);
>         __lt_erase(node, root, 0);
> -       raw_write_seqcount_latch(&root->seq);
> +       write_seqcount_latch(&root->seq);
>         __lt_erase(node, root, 1);
> +       write_seqcount_latch_end(&root->seq);
>  }
>
>  /**
> @@ -204,9 +206,9 @@ latch_tree_find(void *key, struct latch_tree_root *root,
>         unsigned int seq;
>
>         do {
> -               seq = raw_read_seqcount_latch(&root->seq);
> +               seq = read_seqcount_latch(&root->seq);
>                 node = __lt_find(key, root, seq & 1, ops->comp);
> -       } while (raw_read_seqcount_latch_retry(&root->seq, seq));
> +       } while (read_seqcount_latch_retry(&root->seq, seq));
>
>         return node;
>  }
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index fffeb754880f..9c2751087185 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -621,6 +621,12 @@ static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *
>         return READ_ONCE(s->seqcount.sequence);
>  }
>
> +static __always_inline unsigned read_seqcount_latch(const seqcount_latch_t *s)
> +{
> +       kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> +       return raw_read_seqcount_latch(s);
> +}
> +
>  /**
>   * raw_read_seqcount_latch_retry() - end a seqcount_latch_t read section
>   * @s:         Pointer to seqcount_latch_t
> @@ -635,6 +641,13 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
>         return unlikely(READ_ONCE(s->seqcount.sequence) != start);
>  }
>
> +static __always_inline int
> +read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
> +{
> +       kcsan_atomic_next(0);
> +       return raw_read_seqcount_latch_retry(s, start);
> +}
> +
>  /**
>   * raw_write_seqcount_latch() - redirect latch readers to even/odd copy
>   * @s: Pointer to seqcount_latch_t
> @@ -716,13 +729,29 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
>   *     When data is a dynamic data structure; one should use regular RCU
>   *     patterns to manage the lifetimes of the objects within.
>   */
> -static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
> +static __always_inline void raw_write_seqcount_latch(seqcount_latch_t *s)
>  {
>         smp_wmb();      /* prior stores before incrementing "sequence" */
>         s->seqcount.sequence++;
>         smp_wmb();      /* increment "sequence" before following stores */
>  }
>
> +static __always_inline void write_seqcount_latch_begin(seqcount_latch_t *s)
> +{
> +       kcsan_nestable_atomic_begin();
> +       raw_write_seqcount_latch(s);
> +}
> +
> +static __always_inline void write_seqcount_latch(seqcount_latch_t *s)
> +{
> +       raw_write_seqcount_latch(s);
> +}
> +
> +static __always_inline void write_seqcount_latch_end(seqcount_latch_t *s)
> +{
> +       kcsan_nestable_atomic_end();
> +}
> +
>  #define __SEQLOCK_UNLOCKED(lockname)                                   \
>         {                                                               \
>                 .seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index beb808f4c367..19911c8fa7b6 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -560,10 +560,11 @@ bool printk_percpu_data_ready(void)
>  /* Must be called under syslog_lock. */
>  static void latched_seq_write(struct latched_seq *ls, u64 val)
>  {
> -       raw_write_seqcount_latch(&ls->latch);
> +       write_seqcount_latch_begin(&ls->latch);
>         ls->val[0] = val;
> -       raw_write_seqcount_latch(&ls->latch);
> +       write_seqcount_latch(&ls->latch);
>         ls->val[1] = val;
> +       write_seqcount_latch_end(&ls->latch);
>  }
>
>  /* Can be called from any context. */
> @@ -574,10 +575,10 @@ static u64 latched_seq_read_nolock(struct latched_seq *ls)
>         u64 val;
>
>         do {
> -               seq = raw_read_seqcount_latch(&ls->latch);
> +               seq = read_seqcount_latch(&ls->latch);
>                 idx = seq & 0x1;
>                 val = ls->val[idx];
> -       } while (raw_read_seqcount_latch_retry(&ls->latch, seq));
> +       } while (read_seqcount_latch_retry(&ls->latch, seq));
>
>         return val;
>  }
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index 68d6c1190ac7..4958b40ba6c9 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -71,13 +71,13 @@ static __always_inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>
>  notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
>  {
> -       *seq = raw_read_seqcount_latch(&cd.seq);
> +       *seq = read_seqcount_latch(&cd.seq);
>         return cd.read_data + (*seq & 1);
>  }
>
>  notrace int sched_clock_read_retry(unsigned int seq)
>  {
> -       return raw_read_seqcount_latch_retry(&cd.seq, seq);
> +       return read_seqcount_latch_retry(&cd.seq, seq);
>  }
>
>  unsigned long long noinstr sched_clock_noinstr(void)
> @@ -102,7 +102,9 @@ unsigned long long notrace sched_clock(void)
>  {
>         unsigned long long ns;
>         preempt_disable_notrace();
> +       kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
>         ns = sched_clock_noinstr();
> +       kcsan_atomic_next(0);
>         preempt_enable_notrace();
>         return ns;
>  }
> @@ -119,17 +121,19 @@ unsigned long long notrace sched_clock(void)
>   */
>  static void update_clock_read_data(struct clock_read_data *rd)
>  {
> -       /* update the backup (odd) copy with the new data */
> -       cd.read_data[1] = *rd;
> -
>         /* steer readers towards the odd copy */
> -       raw_write_seqcount_latch(&cd.seq);
> +       write_seqcount_latch_begin(&cd.seq);
>
>         /* now its safe for us to update the normal (even) copy */
>         cd.read_data[0] = *rd;
>
>         /* switch readers back to the even copy */
> -       raw_write_seqcount_latch(&cd.seq);
> +       write_seqcount_latch(&cd.seq);
> +
> +       /* update the backup (odd) copy with the new data */
> +       cd.read_data[1] = *rd;
> +
> +       write_seqcount_latch_end(&cd.seq);
>  }
>
>  /*
> @@ -267,7 +271,7 @@ void __init generic_sched_clock_init(void)
>   */
>  static u64 notrace suspended_sched_clock_read(void)
>  {
> -       unsigned int seq = raw_read_seqcount_latch(&cd.seq);
> +       unsigned int seq = read_seqcount_latch(&cd.seq);
>
>         return cd.read_data[seq & 1].epoch_cyc;
>  }
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 7e6f409bf311..2ca26bfeb8f3 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -424,16 +424,18 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
>         struct tk_read_base *base = tkf->base;
>
>         /* Force readers off to base[1] */
> -       raw_write_seqcount_latch(&tkf->seq);
> +       write_seqcount_latch_begin(&tkf->seq);
>
>         /* Update base[0] */
>         memcpy(base, tkr, sizeof(*base));
>
>         /* Force readers back to base[0] */
> -       raw_write_seqcount_latch(&tkf->seq);
> +       write_seqcount_latch(&tkf->seq);
>
>         /* Update base[1] */
>         memcpy(base + 1, base, sizeof(*base));
> +
> +       write_seqcount_latch_end(&tkf->seq);
>  }
>
>  static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
> @@ -443,11 +445,11 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
>         u64 now;
>
>         do {
> -               seq = raw_read_seqcount_latch(&tkf->seq);
> +               seq = read_seqcount_latch(&tkf->seq);
>                 tkr = tkf->base + (seq & 0x01);
>                 now = ktime_to_ns(tkr->base);
>                 now += __timekeeping_get_ns(tkr);
> -       } while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
> +       } while (read_seqcount_latch_retry(&tkf->seq, seq));
>
>         return now;
>  }


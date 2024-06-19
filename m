Return-Path: <linux-kernel+bounces-221089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677690EC52
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920E51F21840
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F51442F1;
	Wed, 19 Jun 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOnfi6qJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E76143C4E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802369; cv=none; b=FkbAyAe4B7J7S5mjffl2tMm8Jl0fDeu+96O8daocR1TUq7kG13znGt/gX+8B01YNSN3hkBeAOFUPV/+Ol1hqG0mDUDcXvcp2DYd+O3p1Hw+PQJmUcuU2C9Rr4rW4cI6907mMmlF3VkXe609+/QSRlFEN+x040vdMouT6x5jZszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802369; c=relaxed/simple;
	bh=WhH3f61w5OHFaWLqMa8WqQQXaDmVxPuC3yDAvEuOZAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDqdqomaVeX3xc91cC++aCpPMZZQRUQR+SNypo4jGttbXpv7SVXFPJgrf2WQZ1B+v8XzgmHCGOyVmvg5JRyZG2/RrJAhflv0uy6+dI0BLxRVkH8+Q+BhtJjwFNbXdDt6MPiTun8Lk/Vv1ZMqsVT/7j0asI2MO6p+B9NUErT06L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOnfi6qJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so13471a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718802366; x=1719407166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z4EPWm/7sFf0qvlXjeo/vkQgrKJ+6F4iyvSDNSvdwE=;
        b=jOnfi6qJEqRisWd8+hM9TQ/BMg/EPV6MIRKhTzE+2CnefOWBuf78xqyEOAFNKa8fyn
         7LTlWdMs9CBWMQcz8o1d7iRLQ3TvLlc+5TxscMRZYBHE+ZPlDq9FhI6Y3B+uxGljEta/
         afyWB/zvJ6jlrxavPfD/fCEgf+4WH9aAO70nR2B1Z7goO21wPrGb0gKG4Ymh+LfUgtLT
         P8i6EK+Qbg+j6JyVaw5ku/zllQYZZPeywE9c3pD6BkdsCh61nFx03QTssQH+5JEYu30/
         eqwP3pNcfegQL/IIK7grG0jZaAhuAVKD8JbwCqMZ3zu+gcbchjXKvxE7dYS5uZ43nAy3
         6lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802366; x=1719407166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z4EPWm/7sFf0qvlXjeo/vkQgrKJ+6F4iyvSDNSvdwE=;
        b=tOCGs3RBDr5zqKJlMNGQJ2QNJF+2LGma9nWn9KSV91Haqw9D4seuz+RLmD1Nzjgop9
         QEc/Jlqyr2KBVp3L3gTE3QS53zth5Q3UwFqUKXiz4GjFED9v6HTKcu87fUMA3UC6fm5r
         T5qs5FEBJCYHOcEvqLqMl7CRMv83faX+qS9yDz3wHV3ukUzmPA7KOCa2xzyGtoVESQMa
         OR21luEwZVX/VToXujclXGhUVKo4xpWDhJhorHAuNzS2OHHQIzvaXECGpF2ioZhA+rEl
         iqmmtcnL9bT1pm8Il3fj0lyxWDCblGnsXK1pTwSsqgqqDlUwmFC3RemEOZO6q5Dv+Vo8
         SzZg==
X-Forwarded-Encrypted: i=1; AJvYcCXXnMMXe3AO5EE88FNMN1Dup6pTrKHceZRd+bUYScew50rbN4bOp94cYk2W8cc5737q9hlAA8np3GUvPV8Gf0uALwCxGFYEIq4bmO2J
X-Gm-Message-State: AOJu0Yyy6X0qhGCiI8iYLWtYrkdK9OpwjUmyPK4XNbIfDg4AOR+d4LCY
	VCZBQKAGaabw9qn2wJ4Z05Dt1Au5pHS7Gi61PDv4U3x9E1MGERhdoF2xbIJn8OI9FI7faTvXYwK
	c01hfz/CVxKItk0lsOHieVEE/wJT6oRbb4xbw
X-Google-Smtp-Source: AGHT+IEZzH/p5LRG1PiKwZYtagQA/Ag9UpMKZbcHRgmTer+Ur/62u+Q1A2Rb5x89mApmidQ4hfxKGI9Li1jbVA3Kmqw=
X-Received: by 2002:a05:6402:35d5:b0:57c:b3c3:32bb with SMTP id
 4fb4d7f45d1cf-57d0ec44f62mr146344a12.1.1718802365895; Wed, 19 Jun 2024
 06:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <3f9a1de9e415fcb53d07dc9e19fa8481bb021b1b.1718092070.git.dvyukov@google.com>
 <20240619111936.GK31592@noisy.programming.kicks-ass.net>
In-Reply-To: <20240619111936.GK31592@noisy.programming.kicks-ass.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 19 Jun 2024 15:05:54 +0200
Message-ID: <CACT4Y+b=c0zy6TLANM67KoudUXaX5frY+mD4Co-K1BVF6fqEBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/entry: Remove unwanted instrumentation in common_interrupt()
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 11, 2024 at 09:50:30AM +0200, Dmitry Vyukov wrote:
> > common_interrupt() and friends call kvm_set_cpu_l1tf_flush_l1d(),
> > which is not marked as noinstr nor __always_inline.
> > So compiler outlines it and adds instrumentation to it.
> > Since the call is inside of instrumentation_begin/end(),
> > objtool does not warn about it.
> >
> > The manifestation is that KCOV produces spurious coverage
> > in kvm_set_cpu_l1tf_flush_l1d() in random places because
> > the call happens when preempt count is not yet updated
> > to say that we are in an interrupt.
>
> So I'm reading spurious here, but the next patch trips BUG, them very
> much not the same thing. Which is it?

I am not sure I understand the question.
Currently kvm_set_cpu_l1tf_flush_l1d() is traced, so the added test
produces a BUG without this fix (and does not produce with this fix).
By "spurious" I meant that tracing of kvm_set_cpu_l1tf_flush_l1d() and
interrupts in general is parasitic/unwanted.

> > Mark kvm_set_cpu_l1tf_flush_l1d() as __always_inline and move
> > out of instrumentation_begin/end() section.
> > It only calls __this_cpu_write() which is already safe to call
> > in noinstr contexts.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> > Fixes: 6368558c3710 ("x86/entry: Provide IDTENTRY_SYSVEC")
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: syzkaller@googlegroups.com
>
> Anyway, the patch is fine,
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> > ---
> >  arch/x86/include/asm/hardirq.h  | 8 ++++++--
> >  arch/x86/include/asm/idtentry.h | 6 +++---
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
> > index c67fa6ad098a..6ffa8b75f4cd 100644
> > --- a/arch/x86/include/asm/hardirq.h
> > +++ b/arch/x86/include/asm/hardirq.h
> > @@ -69,7 +69,11 @@ extern u64 arch_irq_stat(void);
> >  #define local_softirq_pending_ref       pcpu_hot.softirq_pending
> >
> >  #if IS_ENABLED(CONFIG_KVM_INTEL)
> > -static inline void kvm_set_cpu_l1tf_flush_l1d(void)
> > +/*
> > + * This function is called from noinstr interrupt contexts
> > + * and must be inlined to not get instrumentation.
> > + */
> > +static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void)
> >  {
> >       __this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
> >  }
> > @@ -84,7 +88,7 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
> >       return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
> >  }
> >  #else /* !IS_ENABLED(CONFIG_KVM_INTEL) */
> > -static inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
> > +static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
> >  #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
> >
> >  #endif /* _ASM_X86_HARDIRQ_H */
> > diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> > index d4f24499b256..ad5c68f0509d 100644
> > --- a/arch/x86/include/asm/idtentry.h
> > +++ b/arch/x86/include/asm/idtentry.h
> > @@ -212,8 +212,8 @@ __visible noinstr void func(struct pt_regs *regs,                 \
> >       irqentry_state_t state = irqentry_enter(regs);                  \
> >       u32 vector = (u32)(u8)error_code;                               \
> >                                                                       \
> > +     kvm_set_cpu_l1tf_flush_l1d();                                   \
> >       instrumentation_begin();                                        \
> > -     kvm_set_cpu_l1tf_flush_l1d();                                   \
> >       run_irq_on_irqstack_cond(__##func, regs, vector);               \
> >       instrumentation_end();                                          \
> >       irqentry_exit(regs, state);                                     \
> > @@ -250,7 +250,6 @@ static void __##func(struct pt_regs *regs);                               \
> >                                                                       \
> >  static __always_inline void instr_##func(struct pt_regs *regs)               \
> >  {                                                                    \
> > -     kvm_set_cpu_l1tf_flush_l1d();                                   \
> >       run_sysvec_on_irqstack_cond(__##func, regs);                    \
> >  }                                                                    \
> >                                                                       \
> > @@ -258,6 +257,7 @@ __visible noinstr void func(struct pt_regs *regs)                 \
> >  {                                                                    \
> >       irqentry_state_t state = irqentry_enter(regs);                  \
> >                                                                       \
> > +     kvm_set_cpu_l1tf_flush_l1d();                                   \
> >       instrumentation_begin();                                        \
> >       instr_##func (regs);                                            \
> >       instrumentation_end();                                          \
> > @@ -288,7 +288,6 @@ static __always_inline void __##func(struct pt_regs *regs);               \
> >  static __always_inline void instr_##func(struct pt_regs *regs)               \
> >  {                                                                    \
> >       __irq_enter_raw();                                              \
> > -     kvm_set_cpu_l1tf_flush_l1d();                                   \
> >       __##func (regs);                                                \
> >       __irq_exit_raw();                                               \
> >  }                                                                    \
> > @@ -297,6 +296,7 @@ __visible noinstr void func(struct pt_regs *regs)                 \
> >  {                                                                    \
> >       irqentry_state_t state = irqentry_enter(regs);                  \
> >                                                                       \
> > +     kvm_set_cpu_l1tf_flush_l1d();                                   \
> >       instrumentation_begin();                                        \
> >       instr_##func (regs);                                            \
> >       instrumentation_end();                                          \
> > --
> > 2.45.2.505.gda0bf45e8d-goog
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20240619111936.GK31592%40noisy.programming.kicks-ass.net.


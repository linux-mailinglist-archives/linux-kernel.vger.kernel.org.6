Return-Path: <linux-kernel+bounces-535183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B72A46FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CAF16E101
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA49139E;
	Thu, 27 Feb 2025 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEimcYk8"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C1A47
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615053; cv=none; b=SSJIKlElnTRrtauy6kw5lXKLNQ4h5+cEYM7ruQS8tZv+/yvF8Gx+W6NSird6tHpXJCiQ3SzThGrPnCpHU4wcmaBa5CwHtSL+coDRzx9eXYytY3H4f2BYjSnB9qhPalxF75ksn8MDIMkLLbJwNYYJGBoFwbED5eh9r0j8q0YrCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615053; c=relaxed/simple;
	bh=SDW4dQCiHFkOQF2Qnqaf1OGL32Mm21aQYnLkjVoKZug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBo36umErzRyHbHHsnQEr5kJ0KyxZn3q4AJPHBE54+inu9Hv+Hu/kZWGlQnIKEc93cDt9KI6YdS3CiIMH6emxzeic3Z4aGEtky3q2R48ms2fATlNxv2kltcX30LywO27Wl6pih672qVRL9e4rHiQ28f1kl1D7tjZ2NO3kAk9XiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEimcYk8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-545fed4642aso334693e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740615050; x=1741219850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb0gE+NKVO1C8U7TOom7WVUwbPJXgxqIoAIUKNz44LY=;
        b=MEimcYk8XsDo7RA5nEhR8W0HoOfjmfEbf4Q/wvBS4EgTEOWBYrXFJM+VWex5lRtPoC
         uMnGW8fnmJ+lkV82oJ2fqWWtoHK4R5pjipLWDfhyfrIMskqTW+RnrSdtM+kf2lRx6Vsg
         l0elewhYxDm2pCc1PaHPEpsql5cXFyMin+MuY1CCmsIvJ6z+FTVeVXVXKcupgBXchHXJ
         l1Ub/0k38bWQbHJjE+fGyh2oR+lWNv74o8Xm2pr95TF/P717cwacuvo4HBiwo1W4qMgg
         3pWitOab713Eslj0OCPEuykXiAll9Iw0Ny+M7F7CmMFgGYV+yylnQRgkEXCn9CaJtj+L
         lmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615050; x=1741219850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb0gE+NKVO1C8U7TOom7WVUwbPJXgxqIoAIUKNz44LY=;
        b=gycvTVhfAdCBOLmEJ5KjL50RvXvUT6oXMXontpwoslmttmT9P+zsiNhScZyU5XDcBq
         agvTw6ZagSV5ibm8jBKj+3RoE3bCB+0pQ8zXnKoGzMri1S6fWA85PJ/FykQl+X/wZudm
         pxKfdwlnQoqni9hNoJMEUuc1boOTTiF/rH6ZmlIcN6wZUcI3ZMvMT2FdJtZd2IEq7biM
         OMoq9/LrXtN36wyamPw7+QJl5DTXaqsxqK8+l4Mk4k6hki4/S5M0yufRzMZBxD9gjbpY
         xI3gPvigB/pwiPFEsTdi4N78YbEuB80aNHVlrCZavCldtJLMfl+OmCBU8ZafcIrkffrw
         OyuQ==
X-Gm-Message-State: AOJu0YyiWzKyFtLrziUXH3tkTPOah83Cx8tBr3ai+hNlq8HN7YrdBoZK
	GU3sbz4M/Wg4HzkD9ETBQNJiLU7adUcXYcZ0T2cF0/cqAfx/K5e1QvQF2Sxo2ddSuotngeHEicc
	SMUiGnQOR6rB7baCVZ4IQpOOcMg==
X-Gm-Gg: ASbGncvMp+S1OGXUrxdoJEh3W5ar6kEbI0ee+WAk9NtLUq2dRBJ0qhw7SQsXYUPviex
	NrWdWl3ppdqCH1x1WrhtMa45yrz3jCAojvVZLmKUktbgsdwTZ3YKCqws0d0yRlDo1FFoMindOan
	4v1XAz9w4nk1tylmdhwRiYSA==
X-Google-Smtp-Source: AGHT+IGzUw2Dtxdz1LrisDKrJXmLKNQWPPk2kYELnhAeBJ55tPyKVWtvLBHhv1kvzDsXSoPQOCJlG3Lhyz1xsH7IaGE=
X-Received: by 2002:a05:6512:2242:b0:544:c36:3333 with SMTP id
 2adb3069b0e04-54838ef5b9cmr11868538e87.30.1740615049738; Wed, 26 Feb 2025
 16:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226180531.1242429-1-brgerst@gmail.com> <20250226180531.1242429-8-brgerst@gmail.com>
 <20250226202554.GC29387@noisy.programming.kicks-ass.net>
In-Reply-To: <20250226202554.GC29387@noisy.programming.kicks-ass.net>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 26 Feb 2025 19:10:38 -0500
X-Gm-Features: AQ5f1JpjxTUheMYv8k5TxkYgRlF2MFXeSZNkZWupqUGpjZ_jricfe6umst02l34
Message-ID: <CAMzpN2iM_GdoPgQVu41k7dFGt4yy50K2pdzaRDQ=3STxyzp_Jg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] x86/irq: Move irq stacks to percpu hot section
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:25=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Feb 26, 2025 at 01:05:26PM -0500, Brian Gerst wrote:
>
> > diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> > index 474af15ae017..2cd2064457b1 100644
> > --- a/arch/x86/kernel/irq.c
> > +++ b/arch/x86/kernel/irq.c
> > @@ -34,6 +34,11 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
> >  DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
> >  EXPORT_PER_CPU_SYMBOL(__softirq_pending);
> >
> > +DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, hardirq_stack_ptr);
> > +#ifdef CONFIG_X86_64
> > +DEFINE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
> > +#endif
> > +
> >  atomic_t irq_err_count;
> >
> >  /*
>
> Perhaps instead of the above #ifdef,...
>
> > diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
> > index dc1049c01f9b..48a27cde9635 100644
> > --- a/arch/x86/kernel/irq_32.c
> > +++ b/arch/x86/kernel/irq_32.c
> > @@ -52,6 +52,8 @@ static inline int check_stack_overflow(void) { return=
 0; }
> >  static inline void print_stack_overflow(void) { }
> >  #endif
> >
> > +DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
> > +
> >  static void call_on_stack(void *func, void *stack)
> >  {
> >       asm volatile("xchgl     %%ebx,%%esp     \n"
>
> > diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> > index 56bdeecd8ee0..4834e317e568 100644
> > --- a/arch/x86/kernel/irq_64.c
> > +++ b/arch/x86/kernel/irq_64.c
>
> stick it in this file, like you already did for the 32bit case?

I had it that way originally, but it wasn't packing efficiently before
I added SORT_BY_ALIGNMENT() to the linker script.  I'll change it
back.


Brian Gerst


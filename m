Return-Path: <linux-kernel+bounces-202118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234E98FC7FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF58281EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785818FC86;
	Wed,  5 Jun 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZYftunl"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4C18FDBF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580033; cv=none; b=sT6C6vrKqrTDqex9Fi3z8IFvMAQEb4OCTlPhZAHA4dvwDxFQGYoPpxzmYvHvD6j/doUzRVQU09WEj1ljA/CK3H4dJ0QeHLth13pddJq0s4rGuLWSqLoXN2c2PalIyVL5XzhfD038D4k0B2oPgk/GF/lAuMcN+L9FeTp8erJGqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580033; c=relaxed/simple;
	bh=0yenf1GqW2sxQ2LAAzM9s07WPp6jrULYlI3dwmd29Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IA15H0UiBrG6gITRQEGAh7T8AmTmmeQ69O4FUrdr0PSnl1suFeJKjCES2N1hl4tCI3QqvCFmITfxEO2uom2JJXhsX7Md24HnS8gQ5qJSaMmxwlFJ1xkPjsVP8JrQWB1ek4BxYuvMqzEjUXihBMrdZljAPmv9Rts+4C4PyqMqfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZYftunl; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4eb25f3c203so874840e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717580031; x=1718184831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIIkd0qfqF3cd1xqtDRqCrMiooCb5pj7Hihyirw1UUA=;
        b=kZYftunlnNTOtXepJF2L6Jb229NunzrAWCF1YndqluolfSuvWyKz7VhXcOA+zifhTa
         KTY2QhoRHIjbovUOavXA+h8rUmU5dgWCHjyQ2V3XgDlpuhXMDF8a9xCxj+bS859sylnp
         a+Lcqh1fV1jJ7Y/9s5pVCiflTVfkle55/0ZZ13kl6g0gF7EWNPPlD1gTsO5h9FbpTjVG
         5m68ZqfB5+GsNWauUcb4U976DelY1o0eYgg62IWyLZaJeCuopN5lm9qzlPIFy8+XAdeW
         PY+ctxGD52Ctxu4WvtRJJlxC/r8PBqqFSVzFwvG31yZ90h0/A3T1ikB8DFyx/NKRDS79
         8CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580031; x=1718184831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIIkd0qfqF3cd1xqtDRqCrMiooCb5pj7Hihyirw1UUA=;
        b=LIjBhyhzklDQNp7THJNd7F+uFx+SDnXwrc/zL2MDJ6/64sBM7EiNv4KMVrTsvc5TB/
         zZ/xl6lI1iUuS0KVtJTinsgnYNeCOz3dRGdfV4m9vcGXqoBMw63FflQKr6j8YUWqSFgV
         N9qZtacFZySRsQHmQtKaw3N22i3PClyENFS45jWW4EmsiIhCvXIbCQ3pv4cTOyR2fdeq
         Rt08JT24CrAmlm4QtWdCr18M8aoPL67OEOh9rtxd4ff4H4Wm6cMcJlG4IJG344nU/ZEw
         TZjsO223MqA42uwwnzv0bsDRsJ+5p6Mu6rONe3tXfMbxBkF56R1mk85AlSrUER/3+A5z
         uYOA==
X-Forwarded-Encrypted: i=1; AJvYcCUGZ09wwW1Ym4kXFHRewa7THT0xPTBwEj1JU48lFTHj6e4esKHZ6D5XU/slPh0l8sHMq/NWvg/8C7mArVfGSDoaa4D55MjL1Zfd1VDu
X-Gm-Message-State: AOJu0YxZIRhSNoZtsVHThYtLXlc0nMFtpjLAXMTsfLt5h58TJR4uviIW
	RmB442YWolyLdsK/HOIJEsAv0auQEYGaSzaGvOq+LVJke1HYAZMoQ8qIPR3JlLas99TmiMXXQAc
	D8TkdAsTmw6ecOSqLQel5J4P4J9gjv7Y6vQ/j
X-Google-Smtp-Source: AGHT+IG2cm3mRRAXRdIV3Xu6Y5MFu5l5fry6BzrLubfh0duqgP2b+HmqLBvkYafdDFCuKwChfkJsrZsDQ5OhtyNPZLg=
X-Received: by 2002:a05:6122:155:b0:4e4:ef42:633a with SMTP id
 71dfb90a1353d-4eb3a40681dmr1944417e0c.8.1717580030639; Wed, 05 Jun 2024
 02:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
 <CANpmjNO4PX94DSVn_ndjsNqzr3Dw5Lc_nVUEu4oc6RK-iny16g@mail.gmail.com> <CACT4Y+bT+D41NopXN4rFbxqgC--mqYL=xCQOje0jDssjncKY+A@mail.gmail.com>
In-Reply-To: <CACT4Y+bT+D41NopXN4rFbxqgC--mqYL=xCQOje0jDssjncKY+A@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Jun 2024 11:33:13 +0200
Message-ID: <CANpmjNNPbS4V7Pf3SgUCAKX8xKwbMqWdz+h2cirAAd7XdNmJqA@mail.gmail.com>
Subject: Re: [PATCH 2/4] kcov: add interrupt handling self test
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, glider@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 11:18, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 5 Jun 2024 at 11:10, Marco Elver <elver@google.com> wrote:
> >
> > > Add a boot self test that can catch sprious coverage from interrupts.
> > > The coverage callback filters out interrupt code, but only after the
> > > handler updates preempt count. Some code periodically leaks out
> > > of that section and leads to spurious coverage.
> > > Add a best-effort (but simple) test that is likely to catch such bugs.
> > > If the test is enabled on CI systems that use KCOV, they should catch
> > > any issues fast.
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: syzkaller@googlegroups.com
> > >
> > > ---
> > >
> > > In my local testing w/o the previous fix,
> > > it immidiatly produced the following splat:
> > >
> > > kcov: running selftest
> > > BUG: TASK stack guard page was hit at ffffc90000147ff8
> > > Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
> > > ...
> > >  kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
> > >  sysvec_call_function+0x15/0xb0
> > >  asm_sysvec_call_function+0x1a/0x20
> > >  kcov_init+0xe4/0x130
> > >  do_one_initcall+0xbc/0x470
> > >  kernel_init_freeable+0x4fc/0x930
> > >  kernel_init+0x1c/0x2b0
> > > ---
> > >  kernel/kcov.c     | 28 ++++++++++++++++++++++++++++
> > >  lib/Kconfig.debug |  9 +++++++++
> > >  2 files changed, 37 insertions(+)
> > >
> > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > index c3124f6d5536..04136f80042f 100644
> > > --- a/kernel/kcov.c
> > > +++ b/kernel/kcov.c
> > > @@ -1057,6 +1057,30 @@ u64 kcov_common_handle(void)
> > >  }
> > >  EXPORT_SYMBOL(kcov_common_handle);
> > >
> > > +#ifdef CONFIG_KCOV_TEST
> > > +static void __init selftest(void)
> > > +{
> > > +       volatile int i;
> > > +
> > > +       pr_err("running self test\n");
> > > +       /*
> > > +        * Test that interrupts don't produce spurious coverage.
> > > +        * The coverage callback filters out interrupt code, but only
> > > +        * after the handler updates preempt count. Some code periodically
> > > +        * leaks out of that section and leads to spurious coverage.
> > > +        * It's hard to call the actual interrupt handler directly,
> > > +        * so we just loop here for ~400 ms waiting for a timer interrupt.
> >
> > Where do the 400 ms come from? I only see that it loops a long time,
> > but that the timing is entirely dependent on how fast the CPU executes
> > the loop.
> >
> > > +        * We set kcov_mode to enable tracing, but don't setup the area,
> > > +        * so any attempt to trace will crash.
> > > +        */
> > > +       current->kcov_mode = KCOV_MODE_TRACE_PC;
> > > +       for (i = 0; i < (1 << 28); i++)
> > > +               ;
> >
> > Can't you check jiffies, and e.g. check that actual ~100-500ms have elapsed?
> >
> > timeout = jiffies + msecs_to_jiffies(300);
> > while (!time_after(jiffies, timeout)) {
> >   cpu_relax();
> > }
>
> We can't call any functions. If anything is instrumented, the kernel crashes.
>
> But just reading jiffies should be fine, so we can do:
>
> unsigned long start = jiffies;
> while ((jiffies - start) * MSEC_PER_SEC / HZ < 500)
> ;

I'm quite sure that those helpers are macros, but who knows if that
will ever change.

The above open-coded version looks reasonable.


Return-Path: <linux-kernel+bounces-220919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B890E927
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88733285A96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B3139578;
	Wed, 19 Jun 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvmGuc9t"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCC13B792
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795948; cv=none; b=Z60FOpGWbhRPGqO2xGPbkRHD/MdNV0YSCsFHa1D+HbUNAtkTg2nYzA0J3CIWucoNAMMj43QjUstS3kjm62nJWuoGDHTiE7d4u+JdQ47bO+mardRiEcY5Idzk8V1Xq3C+bGDeUCn8nWB8TUcYIT7LCWOuIXOOEc5esqNP9R0TU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795948; c=relaxed/simple;
	bh=EloWIQf6dsqdaAoGn6lfvkWCMflKXQhym3w1lX/hTNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=padZ+FUR85BINUuHT41ST3ddVuB9V7pJqc6PxLJk5ZsSiWkFxGRMulYtB1OUQL/rGquGtJ+0i6UuST1hm7uoy03F0ypK6ri73jzy3MQjEjmeygOBcT2/xoZi0kZxh2FoOUSDL+jcFyx/DTwVt+xZ1/2sn78h8j2X2t80YZ8BI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvmGuc9t; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51ab3715d46so1525e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718795945; x=1719400745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0KsCob1Jjevk7WioTiQHC+BTJK/hWvQtKsaUJ/oMu24=;
        b=BvmGuc9t7E1XlVBTcLxJnuLljUBuqVX/OgX3egaNFN5QdUbvRL/l1YnkITdutvpUKS
         b6l4C88Yfr2A6TeiAPg6WRPUaJLEZgdPsTEoN5ISG4EJOb8CIhVAfshCW8coOZ53Or3r
         pP8mgNV0eLk6Yg73P3qMiIkNLa7M+iBN0D6DGtuiC30uklOdJLL2/uLa41fY/ieq2hKt
         suluBklKD3CZA04SolYV5Lep5pWHU+oiCJ5gmb0y3nJRXW1pKEZLKgkVKN+xn6Du6WlX
         ff0meymzSYGq85XySh7elHhhcg6h3GsdPmxi+COF5JIAehCMGqc0CQizOIlmuEnAKBX/
         RTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795945; x=1719400745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KsCob1Jjevk7WioTiQHC+BTJK/hWvQtKsaUJ/oMu24=;
        b=xHNohSwc3fuoWDeUefrjgVy+y8Br2vk532FuzKC74Vwbd9TfUqEYbJgOq5/aLonucL
         EFTLOCufrgZVpc9fGBJiU5t5G8y2LvmE/NYTgHsHFo5YeG4aAHvajJ4Bu/LtaJygidra
         V1nbxaNFfVW235MI9vG9ADUdJc43xoExLLivYTUapwPBNbSLlQswFGCPk2yBEkYXq/jl
         yKmK0C5gRfQCUHlfNlf4bbfmt80xpvx50oEk4h+L5VZbPPDM1/n/FMhmsMyovj3KY5IX
         DE9XkjpR4/mijk5cVaZ1gUCARBk9QkTK2+EjOpMEvUGY631e4+4L1tTsnO7mOTv908cM
         M+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRLnrU7d4Q6KXBAYmGsf5cLtaVbJqFHlbPQDGzARoL+yrTFUEhQOI7JtdKxnXtZ8p8USSEgNNQLHKOrXushviJJcaKdMUcp2ZSKl/Y
X-Gm-Message-State: AOJu0Yx8bHwQY3Lbxw/fq+8t8qNzdAQP5NRP5Q7ySS5D4y7Fx/oBSb+r
	BtIycLwAucfbW6SjB1R3qUgca2QY+QuoLaaYcKDuL48ZxQeaTOaJEOO/TEXbusRpsLF+WXv3ThQ
	aq/S1CQZdQIrCGOoOoGF5H5R4Q/akiSMjn27G
X-Google-Smtp-Source: AGHT+IEceXNYZHUVD0L8ZSfmc18qzPW1qEDYNcDszpsud3RHsk1j48eofGmLsGZJV4fL+7KNbb035FJ7WLGkNTzXmwk=
X-Received: by 2002:a05:6512:32a5:b0:52c:c9eb:dece with SMTP id
 2adb3069b0e04-52ccbc121a8mr61423e87.5.1718795944732; Wed, 19 Jun 2024
 04:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
 <20240619111309.GJ31592@noisy.programming.kicks-ass.net>
In-Reply-To: <20240619111309.GJ31592@noisy.programming.kicks-ass.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 19 Jun 2024 13:18:52 +0200
Message-ID: <CACT4Y+bUPsrGpbakLE-yJN8aKE3ODgB7oWHu+cHW2XSoFvJd_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kcov: add interrupt handling self test
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 11, 2024 at 09:50:31AM +0200, Dmitry Vyukov wrote:
> > Add a boot self test that can catch sprious coverage from interrupts.
> > The coverage callback filters out interrupt code, but only after the
> > handler updates preempt count. Some code periodically leaks out
> > of that section and leads to spurious coverage.
> > Add a best-effort (but simple) test that is likely to catch such bugs.
> > If the test is enabled on CI systems that use KCOV, they should catch
> > any issues fast.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: syzkaller@googlegroups.com
> >
> > ---
> >
> > Changed since v1:
> >  - renamed KCOV_TEST to KCOV_SELFTEST
> >  - improved the config description
> >  - loop for exactly 300ms in the test
> >
> > In my local testing w/o the previous fix,
> > it immidiatly produced the following splat:
> >
> > kcov: running selftest
> > BUG: TASK stack guard page was hit at ffffc90000147ff8
> > Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
> > ...
> >  kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
> >  sysvec_call_function+0x15/0xb0
> >  asm_sysvec_call_function+0x1a/0x20
> >  kcov_init+0xe4/0x130
> >  do_one_initcall+0xbc/0x470
> >  kernel_init_freeable+0x4fc/0x930
> >  kernel_init+0x1c/0x2b0
>
> So I'm not entirely sure how the above BUG comes about, nor how this
> selftest tickles it. Could you elaborate?
>
> I've found check_kcov_mode() which has this !in_task() clause, but I'm
> not entirely sure how failing that leads to the above mentioned failure.

I've tried to explain it in the test comment, maybe I need to improve it:

+        * We set kcov_mode to enable tracing, but don't setup the area,
+        * so any attempt to trace will crash. Note: we must not call any
+        * potentially traced functions in this region.

Basically, we setup current task kcov in a way that any attempt to
trace in __sanitizer_cov_trace_pc() will crash, and then just loop
waiting for interrupts.

A more legit way to achieve the same would be to properly setup kcov
for tracing from within the kernel, then call outermost interrupt
entry function, then check we traced nothing. But that would require a
non-trivial amount of new complex code, and e.g. the top-most
interrupt entry function is not exported and is arch-specific.



> > ---
> >  kernel/kcov.c     | 31 +++++++++++++++++++++++++++++++
> >  lib/Kconfig.debug |  8 ++++++++
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index c3124f6d5536..72a5bf55107f 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/hashtable.h>
> >  #include <linux/init.h>
> > +#include <linux/jiffies.h>
> >  #include <linux/kmsan-checks.h>
> >  #include <linux/mm.h>
> >  #include <linux/preempt.h>
> > @@ -1057,6 +1058,32 @@ u64 kcov_common_handle(void)
> >  }
> >  EXPORT_SYMBOL(kcov_common_handle);
> >
> > +#ifdef CONFIG_KCOV_SELFTEST
> > +static void __init selftest(void)
> > +{
> > +     unsigned long start;
> > +
> > +     pr_err("running self test\n");
> > +     /*
> > +      * Test that interrupts don't produce spurious coverage.
> > +      * The coverage callback filters out interrupt code, but only
> > +      * after the handler updates preempt count. Some code periodically
> > +      * leaks out of that section and leads to spurious coverage.
> > +      * It's hard to call the actual interrupt handler directly,
> > +      * so we just loop here for a bit waiting for a timer interrupt.
> > +      * We set kcov_mode to enable tracing, but don't setup the area,
> > +      * so any attempt to trace will crash. Note: we must not call any
> > +      * potentially traced functions in this region.
> > +      */
> > +     start = jiffies;
> > +     current->kcov_mode = KCOV_MODE_TRACE_PC;
>
>         barrier();
>
> > +     while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
> > +             ;
>
>         barrier();
>
> > +     current->kcov_mode = 0;
> > +     pr_err("done running self test\n");
> > +}
> > +#endif
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20240619111309.GJ31592%40noisy.programming.kicks-ass.net.


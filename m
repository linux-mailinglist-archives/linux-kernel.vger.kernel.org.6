Return-Path: <linux-kernel+bounces-202076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C658E8FC785
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C060286322
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB118FC9D;
	Wed,  5 Jun 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+e4HM8G"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B149657
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579116; cv=none; b=M/lG0EhkAij7DYCxyqxZPBB1fvLz2OdW6wq8SlnZTR7bdBhmHnCkLh36TB083AjYyLSUj8RFb+Se9CHPX/SUwoiAOr3JyzQ92Y/BxeHDv5skKzY465Sy8XYHTv84EPmjNJJ0x+LlL1pBc1ZIIwvt8E+4hih8Z8TUCYwoTHLdqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579116; c=relaxed/simple;
	bh=+ZyZfYPSqykjuJmAPcRUo3gbuZR/cyNv2PcZl2Fy5p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1OYUKuxwnliWjTTsdQV3TW9PK8GUem2u28pwfyG2N5/jLGLny+22glfgtipmbOc7FCZ4OI3C00ES0A4SKqdys9+C/i9W3i+/xIsheG4JbjAu9z8CG6dKk5TIaY3YCOmjAI0kBeZq6A0ytG20Dgp6PyEQWJ8P4Dcd07b8i2m/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+e4HM8G; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso6530a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717579113; x=1718183913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJM9znrwzJI8mOc/XR2FV7hSs0RlBnN4dap9JmYQDlM=;
        b=k+e4HM8GsmJYsU6xjQA4keY+1k+7Tgwryr4O0M6j/G5B8/yLvF8+/W+/j0cPZg9iM1
         F0uotQ9+NijGKlLbtnaWIJMn+k5MMsuZQSYSkrk/rJkDPyBje3eWhsqu11iARAx3hbI3
         mUKfsnPl6I+xGiJ0ztpWIj+/UZsnY1ySxpcC0zYtqTeptbd9nw+L/BXGNk/iAkPrNuje
         VmlQHGGt16bMDfjsbtP9ne8EUR4ZCK4RcPZ+rlPV4Dx7QBH3TYtstgO6oL7gQlaTbn8P
         yZMrB0Nl9c9BmTBP2lppRG2SRe1jN1W7ZhZB5ZPCANQwaHntvSYd1Y8z9j4SXWSo/4HS
         MzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579113; x=1718183913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJM9znrwzJI8mOc/XR2FV7hSs0RlBnN4dap9JmYQDlM=;
        b=aqkf6w0GoboZJ3Y9LxMD/O7Na8spabLPrRU3AraO/iEuPHa7F4nuhHydKfXlYZ9jjL
         kKpjFi3YWv+cRNvgX0g82Iz87aBX4lyy/uaqe7gWXdYKbFUsjmh7o1fBKo1eZXcXEnB+
         33JXHifBsNZwpPww8TnupRKXkONb9OwekeKajFlHxwFj2cAzCWAIInYnOgna4p6h2J5u
         A4Q7RbGesEUcgbBkPVWocc2gDKbRnatpi/2or8YhquH+Az0zb4zyrhKdJG/HgaE3b6+s
         DeAJ+nLUh5BGhX3p8+jeB+Pdyo9dgkSxrqiU23eI/rO7+VYS+JEQZAEMWSMvv4SaH+/m
         kpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYSaWIJA3vuQsLzIdRlu6VE0gRJpI4bUjHhLmtZE3daH5ACO9ERGsUo1ERnlhthkla5ZWXFvGp2iUvVXPzU/43YpV3q8X7eNgxjkM+
X-Gm-Message-State: AOJu0Yyeoy4tWnM/Eal0wb5mxSXGEuCoxQcabthAzi41MoA4gupALOV/
	FpRj3W5gn7HPOJ6Pz9xzIpHv5EGUSUN8Zv/Rudx43+2eB4F+bYlWM4G/cb9nFK7ip3RmiSFfagT
	+YuBwS6wadBc6RHTVbKL9934p6RJ5XUYr/Gtp
X-Google-Smtp-Source: AGHT+IGKtcMWPd7oPQBHvSKdJEMhkIpnoLyBStiiaFenBwkfjQk/tT17Bl4gXUM60xv/TStdZ8pNwfMU57LOutITnCc=
X-Received: by 2002:aa7:de10:0:b0:57a:3103:9372 with SMTP id
 4fb4d7f45d1cf-57a95009854mr94513a12.7.1717579112709; Wed, 05 Jun 2024
 02:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
 <CANpmjNO4PX94DSVn_ndjsNqzr3Dw5Lc_nVUEu4oc6RK-iny16g@mail.gmail.com>
In-Reply-To: <CANpmjNO4PX94DSVn_ndjsNqzr3Dw5Lc_nVUEu4oc6RK-iny16g@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 5 Jun 2024 11:18:21 +0200
Message-ID: <CACT4Y+bT+D41NopXN4rFbxqgC--mqYL=xCQOje0jDssjncKY+A@mail.gmail.com>
Subject: Re: [PATCH 2/4] kcov: add interrupt handling self test
To: Marco Elver <elver@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, glider@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 11:10, Marco Elver <elver@google.com> wrote:
>
> > Add a boot self test that can catch sprious coverage from interrupts.
> > The coverage callback filters out interrupt code, but only after the
> > handler updates preempt count. Some code periodically leaks out
> > of that section and leads to spurious coverage.
> > Add a best-effort (but simple) test that is likely to catch such bugs.
> > If the test is enabled on CI systems that use KCOV, they should catch
> > any issues fast.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: syzkaller@googlegroups.com
> >
> > ---
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
> > ---
> >  kernel/kcov.c     | 28 ++++++++++++++++++++++++++++
> >  lib/Kconfig.debug |  9 +++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index c3124f6d5536..04136f80042f 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -1057,6 +1057,30 @@ u64 kcov_common_handle(void)
> >  }
> >  EXPORT_SYMBOL(kcov_common_handle);
> >
> > +#ifdef CONFIG_KCOV_TEST
> > +static void __init selftest(void)
> > +{
> > +       volatile int i;
> > +
> > +       pr_err("running self test\n");
> > +       /*
> > +        * Test that interrupts don't produce spurious coverage.
> > +        * The coverage callback filters out interrupt code, but only
> > +        * after the handler updates preempt count. Some code periodically
> > +        * leaks out of that section and leads to spurious coverage.
> > +        * It's hard to call the actual interrupt handler directly,
> > +        * so we just loop here for ~400 ms waiting for a timer interrupt.
>
> Where do the 400 ms come from? I only see that it loops a long time,
> but that the timing is entirely dependent on how fast the CPU executes
> the loop.
>
> > +        * We set kcov_mode to enable tracing, but don't setup the area,
> > +        * so any attempt to trace will crash.
> > +        */
> > +       current->kcov_mode = KCOV_MODE_TRACE_PC;
> > +       for (i = 0; i < (1 << 28); i++)
> > +               ;
>
> Can't you check jiffies, and e.g. check that actual ~100-500ms have elapsed?
>
> timeout = jiffies + msecs_to_jiffies(300);
> while (!time_after(jiffies, timeout)) {
>   cpu_relax();
> }

We can't call any functions. If anything is instrumented, the kernel crashes.

But just reading jiffies should be fine, so we can do:

unsigned long start = jiffies;
while ((jiffies - start) * MSEC_PER_SEC / HZ < 500)
;

> > +       current->kcov_mode = 0;
> > +       pr_err("done running self test\n");
> > +}
> > +#endif
> > +
> >  static int __init kcov_init(void)
> >  {
> >         int cpu;
> > @@ -1076,6 +1100,10 @@ static int __init kcov_init(void)
> >          */
> >         debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
> >
> > +#ifdef CONFIG_KCOV_TEST
> > +       selftest();
> > +#endif
> > +
> >         return 0;
> >  }
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 59b6765d86b8..79836a15b6cb 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2171,6 +2171,15 @@ config KCOV_IRQ_AREA_SIZE
> >           soft interrupts. This specifies the size of those areas in the
> >           number of unsigned long words.
> >
> > +config KCOV_TEST
>
> s/TEST/SELFTEST/
>
> It may be confused with a longer standalone test.
>
> > +       bool "Test CONFIG_KCOV feature"
>
> Maybe "Perform short selftests on boot" (similar to CONFIG_KCSAN_SELFTEST).
>
> > +       depends on KCOV
> > +       help
> > +         Sanity check for KCOV coverage collection.
> > +         Runs built-in self test on boot to detect some common issues.
> > +
> > +         If unsure, say N.
> > +
> >  menuconfig RUNTIME_TESTING_MENU
> >         bool "Runtime Testing"
> >         default y
> > --
> > 2.45.1.467.gbab1589fc0-goog
> >


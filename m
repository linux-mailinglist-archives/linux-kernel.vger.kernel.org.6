Return-Path: <linux-kernel+bounces-209425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86290345C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F041C20D04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA6172BCA;
	Tue, 11 Jun 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzrnMumW"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F116F8E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092362; cv=none; b=gDyl4O1tNfiNrDtusjporTwrLHM8P3bc3D1EUBt4qBEUr4KpMTzXpal17jy9Is9Zg5HRZTQcjBj2at2QLL1ghfce+TdwflVCwGQinvgSsIp2cTdnHwubRyiH6ZVsNnfYa2EcZaiq5hpPfYsL42dTZsb6n9OyXSVCPhLGWXviXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092362; c=relaxed/simple;
	bh=R9689AWK2VT1E2GNaFBcGwbJD3MjPbJkPIxVo4rmoWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2L8+NfpxgORlU+kg4xrowfOvzuRBH5E3PDFjJvkQA+VcV8R+mHC4THn+DsJLQVO+hDK+lDe+VqhEbQILMPY/S3lGR5itECTgK/pk+L1aBIsUtq+5Ecb1T16L3qqIJ0qfZ3RZpO+tTJJfgadTkHileqX/HFK3qhpKDNxLmUNlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzrnMumW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso11449a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718092359; x=1718697159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KXsEPPKIKyv8GnY5/uiOiRnN/zPjlFd4WtDRbKwFxcA=;
        b=LzrnMumWUgTFUey8o4ouf81q8rLv/ur0hAgTrJCZx51lA/+Jlq83Veo1rg9szMmrtv
         tqnZjtXj1TD9GuDMniLdp9XVMbGjfNPJ/PeVQ4/doJ7TvmIciZe8Y79qSMgJW8f39BzJ
         Jgq+FoCdPFjz+vrM7QgDscKrZOvSv+mtI3UrdYgi/+wLIIcxx6sZXtQLTZuOvYZjyv+D
         6KJNq9D/sBIfxaZwCavvwRCy2mIEYSp4D0df8WQB3j5zPFbXt2ysX+kEZWW+Sw/GrU25
         jeLKnPnnbYDWhEphfoKzddZmnxfJZ9823ARJhnZM7PmG71qtAFC1Gf514jqPm3qrFUOf
         Od/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092359; x=1718697159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXsEPPKIKyv8GnY5/uiOiRnN/zPjlFd4WtDRbKwFxcA=;
        b=q4WTBpHhLmUZJmdsnQ01J4wupQcaR481R//Ysh27ILb82ekT/PEvJWkCChR81zD1BU
         x3kVLfYTTrwNQ65OtUqlfAzc3ZQItmwHnkCbS3XUH5T35lX5gymLuEwXuicjvhCAX0My
         jlgBOENdNv+4tQXGTG+ZgAErxL1PBAqGHvqs217KsBa0CGMI1FyPaBR3ekropIYn8bW4
         rBuSXJmzo2PgA6bG3NV/5pNuRj1qS220KK1myNpIWP+xPJmS9dlbyMDjt6QBTLEKO3Kx
         UfsmHQ4XZa6K3FRSIGlVQ1kYAPX1cKvYZqw+pdn4kXcw7tSSrivXNIPDqIMBrUobtn9T
         udfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0n6useOBD3wIhmRbKhLtCJmvXYJb7B4JJxqClq6iI/x8CSz4xSbxkMF/M/cihfbWZI0FtNM03xcRp1RX/L/86WwFrT5058s+fVaeH
X-Gm-Message-State: AOJu0YyYWd3keIn++lu4V9Epk9TODIe8C7Z2xkp5STJlQA9QCn2cH3Jp
	tlcPSImJMBjTZwP7KSWwpbeQiHkHJr0IjhZczQzc8GRtI1r5+d41F3yo6wUtzTnYby1F+2ttqp4
	+ozxRElGnxXL+lNJfhUn4owIVh2oqiIjhADgH
X-Google-Smtp-Source: AGHT+IFI/T2q/eK35WjX/VFdJhBJ6J1CfgnQuT5+uijnGKKbi+2QyueptTikovm8q0UzXz96tTdiFyJ04Dp1KrFBM/o=
X-Received: by 2002:aa7:cb44:0:b0:57c:9d50:d129 with SMTP id
 4fb4d7f45d1cf-57c9d50df62mr7465a12.0.1718092358782; Tue, 11 Jun 2024 00:52:38
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
 <CANpmjNO4PX94DSVn_ndjsNqzr3Dw5Lc_nVUEu4oc6RK-iny16g@mail.gmail.com>
 <CACT4Y+bT+D41NopXN4rFbxqgC--mqYL=xCQOje0jDssjncKY+A@mail.gmail.com> <CANpmjNNPbS4V7Pf3SgUCAKX8xKwbMqWdz+h2cirAAd7XdNmJqA@mail.gmail.com>
In-Reply-To: <CANpmjNNPbS4V7Pf3SgUCAKX8xKwbMqWdz+h2cirAAd7XdNmJqA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Jun 2024 09:52:26 +0200
Message-ID: <CACT4Y+bWa_hPhU4RcVhqkH+-S+-R=FFDS3WV2Fa-RK5besUCFg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kcov: add interrupt handling self test
To: Marco Elver <elver@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, glider@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 11:33, Marco Elver <elver@google.com> wrote:
>
> On Wed, 5 Jun 2024 at 11:18, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, 5 Jun 2024 at 11:10, Marco Elver <elver@google.com> wrote:
> > >
> > > > Add a boot self test that can catch sprious coverage from interrupts.
> > > > The coverage callback filters out interrupt code, but only after the
> > > > handler updates preempt count. Some code periodically leaks out
> > > > of that section and leads to spurious coverage.
> > > > Add a best-effort (but simple) test that is likely to catch such bugs.
> > > > If the test is enabled on CI systems that use KCOV, they should catch
> > > > any issues fast.
> > > >
> > > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: x86@kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: syzkaller@googlegroups.com
> > > >
> > > > ---
> > > >
> > > > In my local testing w/o the previous fix,
> > > > it immidiatly produced the following splat:
> > > >
> > > > kcov: running selftest
> > > > BUG: TASK stack guard page was hit at ffffc90000147ff8
> > > > Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
> > > > ...
> > > >  kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
> > > >  sysvec_call_function+0x15/0xb0
> > > >  asm_sysvec_call_function+0x1a/0x20
> > > >  kcov_init+0xe4/0x130
> > > >  do_one_initcall+0xbc/0x470
> > > >  kernel_init_freeable+0x4fc/0x930
> > > >  kernel_init+0x1c/0x2b0
> > > > ---
> > > >  kernel/kcov.c     | 28 ++++++++++++++++++++++++++++
> > > >  lib/Kconfig.debug |  9 +++++++++
> > > >  2 files changed, 37 insertions(+)
> > > >
> > > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > > index c3124f6d5536..04136f80042f 100644
> > > > --- a/kernel/kcov.c
> > > > +++ b/kernel/kcov.c
> > > > @@ -1057,6 +1057,30 @@ u64 kcov_common_handle(void)
> > > >  }
> > > >  EXPORT_SYMBOL(kcov_common_handle);
> > > >
> > > > +#ifdef CONFIG_KCOV_TEST
> > > > +static void __init selftest(void)
> > > > +{
> > > > +       volatile int i;
> > > > +
> > > > +       pr_err("running self test\n");
> > > > +       /*
> > > > +        * Test that interrupts don't produce spurious coverage.
> > > > +        * The coverage callback filters out interrupt code, but only
> > > > +        * after the handler updates preempt count. Some code periodically
> > > > +        * leaks out of that section and leads to spurious coverage.
> > > > +        * It's hard to call the actual interrupt handler directly,
> > > > +        * so we just loop here for ~400 ms waiting for a timer interrupt.
> > >
> > > Where do the 400 ms come from? I only see that it loops a long time,
> > > but that the timing is entirely dependent on how fast the CPU executes
> > > the loop.
> > >
> > > > +        * We set kcov_mode to enable tracing, but don't setup the area,
> > > > +        * so any attempt to trace will crash.
> > > > +        */
> > > > +       current->kcov_mode = KCOV_MODE_TRACE_PC;
> > > > +       for (i = 0; i < (1 << 28); i++)
> > > > +               ;
> > >
> > > Can't you check jiffies, and e.g. check that actual ~100-500ms have elapsed?
> > >
> > > timeout = jiffies + msecs_to_jiffies(300);
> > > while (!time_after(jiffies, timeout)) {
> > >   cpu_relax();
> > > }
> >
> > We can't call any functions. If anything is instrumented, the kernel crashes.
> >
> > But just reading jiffies should be fine, so we can do:
> >
> > unsigned long start = jiffies;
> > while ((jiffies - start) * MSEC_PER_SEC / HZ < 500)
> > ;
>
> I'm quite sure that those helpers are macros, but who knows if that
> will ever change.
>
> The above open-coded version looks reasonable.

Sent v2 with fixes, PTAL.
https://lore.kernel.org/all/cover.1718092070.git.dvyukov@google.com/T/#t


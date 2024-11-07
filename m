Return-Path: <linux-kernel+bounces-399852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B459C0541
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CC2819BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987FB20F5AA;
	Thu,  7 Nov 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmwv6d4z"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BD20EA37
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981139; cv=none; b=WiXGFRH7odMHrHY/CJwnIv6NooEjZK5v6HVCV5XTM+yiSGLFbkxhMbZp1GF1MCMPRwFjK9bfvawRagNv5J65K9w2M6wzp84cqyJOuzep3rzZXoX1s4LbWs+5rR8+FyB8FlMfNYTzOusnXd/c+pnR1HRvqEVqcS+pW7tSYnXnaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981139; c=relaxed/simple;
	bh=LKcABXxZhf1uCxFOm1eAd2Y0wKm3z9TVOD9Hmseyucs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HM/mvtjDX+tVKjjhKaYCbiJoKH2iPujZZ0py4vrSkVvCDeM6ZnX7LbI9S4dbICPIVh2RF4cs60VgbB3S01Y56tmA7hXuX1pfMpAK6GFjHt+MVZyGEXTYTqI5NmXr7MuXhbXGkbKOJn8Axo5mV8uceCrpT3tSxd9nqfaQyZidNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qmwv6d4z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53a0c160b94so858810e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730981135; x=1731585935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izxMAyki5TknHkkLQO6tF8DHWeE5uS10/tSIZ01KAfA=;
        b=Qmwv6d4zinmg4oi5wJkCRxgjW0hOCtabaEYgbHuv/jGvIS2Q7HlOybg61Mfou7La5l
         FgSbYbqhUeET2VRJqL0VqhvzAb3a9ii70zmnHhx3u0qNjagA8tpJiIXFQgLTQmNHSmfI
         6cal+WnJMMBTZzt52dWVriFfU4UN/UrATg+bHWvTIw4nYAKnKx0iPvJNB6EBQckIYWDg
         o1AX1c01TjtRxWTkjTSYlAVOe2+Yc6q33Xhc27HWMmN8A/PVY8XnGtDGcBU0/aU4GFMY
         g6xoz9/XGXrq+qyIjNgVCDn+3kojLy/PUP0zcjCMlEB4etia8ka39d9gH4IbOuHmOHD3
         EfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981135; x=1731585935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izxMAyki5TknHkkLQO6tF8DHWeE5uS10/tSIZ01KAfA=;
        b=OqXl2M5QEMigXO2+UJWUTaV0b2ptcwqsrUw06lzcdKSBO/lKPRAfzBVKeXFeVvVeQJ
         aC1Iq0bXzYf92DyorCt1pQv8/SmXZuRKiP5Vpiv/O7RetUtZw7W0wnu4ywk7PJ2tGnuh
         SZQEyJNKA8MDrzZR3wWITdRbr+KJJ8p935zeVXMVaaq3MMncXjwxtWYvvfPyvDUwzjbA
         lCzffSfVBR4iswReXX/b/JHjdPv2Lajq3Bbg0+PN2rBGNU6eMbOShH8cTyU8iNtrWU4p
         p1krqzpKTBsvjBvNa2Us5br8kB2qbWfkXbHoJUigrxfM8URSji8mGh9Db0SzCNcHqou7
         7VAw==
X-Gm-Message-State: AOJu0YwefVULfOUdJE3o7wnL2I3U375Beyo5/GlPLENyARhoZojAT4yy
	bD/pB98ropMYQ3Lqp5nEkGPUHXsd6wdTus1IUVRiClHL9qy1GDEWUSVgUEa/YuY1tJFLb9cjguc
	NstRIXONUZ6+M2jf7RXBrsu/E4g==
X-Google-Smtp-Source: AGHT+IGkSOiJ5yvFXSMLmfFAB/jAlLizULRJG8cb8peqdhOFdMZT9VRiV+Vku1503ZJ3/Inm7cydmwiuVIAsWMuPHWo=
X-Received: by 2002:a05:6512:b8a:b0:539:ccfd:8f36 with SMTP id
 2adb3069b0e04-53d65df7cd1mr10635143e87.28.1730981134976; Thu, 07 Nov 2024
 04:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-10-brgerst@gmail.com>
 <CAFULd4YA0g0Mx0AKBfM-nK_OuTf0pY_fAnR5CCiJeh0cKPLMnQ@mail.gmail.com>
In-Reply-To: <CAFULd4YA0g0Mx0AKBfM-nK_OuTf0pY_fAnR5CCiJeh0cKPLMnQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 7 Nov 2024 07:05:23 -0500
Message-ID: <CAMzpN2g0iSXsm9jbgL3YJP9YGwtyG732g3aNnBjJWHgFkm_oJA@mail.gmail.com>
Subject: Re: [PATCH v5 09/16] x86/percpu/64: Use relative percpu offsets
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:28=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wr=
ote:
> >
> > The percpu section is currently linked at absolute address 0, because
> > older compilers hardcoded the stack protector canary value at a fixed
> > offset from the start of the GS segment.  Now that the canary is a
> > normal percpu variable, the percpu section does not need to be linked
> > at a specific address.
> >
> > x86-64 will now calculate the percpu offsets as the delta between the
> > initial percpu address and the dynamically allocated memory, like other
> > architectures.  Note that GSBASE is limited to the canonical address
> > width (48 or 57 bits, sign-extended).  As long as the kernel text,
> > modules, and the dynamically allocated percpu memmory are all in the
> > negative address space, the delta will not overflow this limit.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/include/asm/processor.h |  6 +++++-
> >  arch/x86/kernel/head_64.S        | 19 +++++++++----------
> >  arch/x86/kernel/setup_percpu.c   | 12 ++----------
> >  arch/x86/kernel/vmlinux.lds.S    | 29 +----------------------------
> >  arch/x86/platform/pvh/head.S     |  5 ++---
> >  arch/x86/tools/relocs.c          | 10 +++-------
> >  arch/x86/xen/xen-head.S          |  9 ++++-----
> >  init/Kconfig                     |  2 +-
> >  8 files changed, 27 insertions(+), 65 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pr=
ocessor.h
> > index a113c3f4f558..ae50d5d4fa26 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -428,7 +428,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
> >
> >  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
> >  {
> > -       return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
> > +#ifdef CONFIG_SMP
> > +       return per_cpu_offset(cpu);
> > +#else
> > +       return 0;
> > +#endif
> >  }
> >
> >  extern asmlinkage void entry_SYSCALL32_ignore(void);
> > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > index c3028b4df85f..ffbcb0aea450 100644
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -61,11 +61,14 @@ SYM_CODE_START_NOALIGN(startup_64)
> >         /* Set up the stack for verify_cpu() */
> >         leaq    __top_init_kernel_stack(%rip), %rsp
> >
> > -       /* Setup GSBASE to allow stack canary access for C code */
> > +       /*
> > +        * Set up GSBASE.
> > +        * Note that, on SMP, the boot cpu uses init data section until
> > +        * the per cpu areas are set up.
> > +        */
> >         movl    $MSR_GS_BASE, %ecx
> > -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> > -       movl    %edx, %eax
> > -       shrq    $32,  %rdx
> > +       xorl    %eax, %eax
> > +       xorl    %edx, %edx
>
> You can use cltd after "xor %eax, %eax", it is one byte shorter with
> the same effect ...

I suppose that would work, but I'm not sure it's worth it to
hyper-optimize boot code like this.  It's also confusing since the SDM
calls this instruction CDQ instead of CLTD.

Brian Gerst


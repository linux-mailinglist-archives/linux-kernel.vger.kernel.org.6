Return-Path: <linux-kernel+bounces-400001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8219C079F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC61283CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C520B1E2;
	Thu,  7 Nov 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+xi+rgd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E221EE019
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986490; cv=none; b=lum3XSafnxf+NaHOen09DHHbpSCUb+4OvWQIbE/in+GYclNQknIacCYjwYiRiRAwprNcnHZdBz4XZyex4EPPG+W/DPFhItznOcerRvWJj5B4ElbqO/n1uvZ1op/rgqOaXToESo9z6h6Pn3NfIDkZ4Iv2wwp4v+W7N7N42fofhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986490; c=relaxed/simple;
	bh=CBZ7aqFf6W6HwFKDmCRhz51raexfBR0Ll3SqqO7VngU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ+HiyFljua+wEMs9h9MtLCEtTZci2/diCevwqVbP9wnBi/JZhyLC464SbHHhc3YRdWYTsczXvonLq6SthSieYtBqm0yVfZTLSADAVRxqztghNNnagpS0bpJziJIZ4OtLO+mPiNZDzMRchJrsj16eRkzmBOe8dKMfDdNh43m/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+xi+rgd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e7e73740so789175e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986486; x=1731591286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhsFgA/EIJBwpraIAT9oEKriXviptqi7CjRLDOmpXc0=;
        b=A+xi+rgdng/NIn4tVi6KgMICjk+Efvd8lC9K/B9PbjNmZ7hucxHw4tZK5eVu2eVDT1
         ZM7xAzjIZ+kl+UsREC8W+IjjkuzdLZuUvJNVqvBPe+wjsSD3g4odT/VizamgcSRZILKH
         DfEvqytuRkORrbSHmr2wmRJ7a5AhPAGcMkXjSRJTHCemjoEekqPrOZWkFEoUvSNUS9p4
         B5CfHByjDY20LfGa1kChESVl8BdjCH+NBHiZ6lXorS9ifO83y1JdBvkrqUAv1NC1fv9Z
         N3WtqQ8zEHyW+5YOTAO1JTXSv5duc8YJ9SciDxfG4/cTDT0Zp6svAP0X/4TO3Aw85mxd
         PexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986486; x=1731591286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhsFgA/EIJBwpraIAT9oEKriXviptqi7CjRLDOmpXc0=;
        b=vrBd1BsWEglYU7Eqv7WHyIxqz7b2RZ5EUS5sAflS3bMMEYGWLj4T/TZGmdqcx7y67W
         CMg9ETaUk8LFlQjAHgICyW4LpSAQbYrrgOVmiwI7aUngzg2TJYBzLBsNtGxUC699thnR
         1AefXnRQdlkYfK+1CFY60ynEqVxJAQJ5IGi/+UOqFNJ53OQHz0K5bD0ZYx0R1dTE+Ylt
         hvcksE8A0KcwLElUR/vhBMJH+mnGoSQEBD0802v4s/qiXkSusVxUr/IOmQmfgHWriIDi
         MUA/HDvCrYsO4553B6knLPHyyaK3oKImzzLIwYkqIfaXTg6c/0LD0CfXguA/qVl49CH3
         7+XA==
X-Gm-Message-State: AOJu0YwzAm2okEapbTzP7Kf4rMrWPAx87NaPgJnIO8MY3d0sOC2spWRG
	GlFIfZBoq9SLiCoX0G+5UDgzq6unTFdE6OZpanXHvNZ6YaA9VNkUJK+RUwiHKo8v6Xy7DQW9a8S
	kjpepJG+A7NKPXeudf4PYCbb93NE=
X-Google-Smtp-Source: AGHT+IFlLxgdVSNcIsplxlKO8vUhJQmPTOA2QwHraaW+6lHcRI+uaJyxCfpPV0iln35+z/HIiQZnlUKMiOwZXxv84wM=
X-Received: by 2002:a05:651c:b06:b0:2fb:5f9d:c296 with SMTP id
 38308e7fff4ca-2ff1a8c4c67mr9195581fa.4.1730986486193; Thu, 07 Nov 2024
 05:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-10-brgerst@gmail.com>
 <CAFULd4YA0g0Mx0AKBfM-nK_OuTf0pY_fAnR5CCiJeh0cKPLMnQ@mail.gmail.com> <CAMzpN2g0iSXsm9jbgL3YJP9YGwtyG732g3aNnBjJWHgFkm_oJA@mail.gmail.com>
In-Reply-To: <CAMzpN2g0iSXsm9jbgL3YJP9YGwtyG732g3aNnBjJWHgFkm_oJA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 14:34:34 +0100
Message-ID: <CAFULd4ZgJt3ZifEQFPFuT-YRN0-p6w-=rFRKuwoEhBS84JSmiw@mail.gmail.com>
Subject: Re: [PATCH v5 09/16] x86/percpu/64: Use relative percpu offsets
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:05=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> On Thu, Nov 7, 2024 at 6:28=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> =
wrote:
> > >
> > > The percpu section is currently linked at absolute address 0, because
> > > older compilers hardcoded the stack protector canary value at a fixed
> > > offset from the start of the GS segment.  Now that the canary is a
> > > normal percpu variable, the percpu section does not need to be linked
> > > at a specific address.
> > >
> > > x86-64 will now calculate the percpu offsets as the delta between the
> > > initial percpu address and the dynamically allocated memory, like oth=
er
> > > architectures.  Note that GSBASE is limited to the canonical address
> > > width (48 or 57 bits, sign-extended).  As long as the kernel text,
> > > modules, and the dynamically allocated percpu memmory are all in the
> > > negative address space, the delta will not overflow this limit.
> > >
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > ---
> > >  arch/x86/include/asm/processor.h |  6 +++++-
> > >  arch/x86/kernel/head_64.S        | 19 +++++++++----------
> > >  arch/x86/kernel/setup_percpu.c   | 12 ++----------
> > >  arch/x86/kernel/vmlinux.lds.S    | 29 +----------------------------
> > >  arch/x86/platform/pvh/head.S     |  5 ++---
> > >  arch/x86/tools/relocs.c          | 10 +++-------
> > >  arch/x86/xen/xen-head.S          |  9 ++++-----
> > >  init/Kconfig                     |  2 +-
> > >  8 files changed, 27 insertions(+), 65 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/=
processor.h
> > > index a113c3f4f558..ae50d5d4fa26 100644
> > > --- a/arch/x86/include/asm/processor.h
> > > +++ b/arch/x86/include/asm/processor.h
> > > @@ -428,7 +428,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
> > >
> > >  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
> > >  {
> > > -       return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu)=
;
> > > +#ifdef CONFIG_SMP
> > > +       return per_cpu_offset(cpu);
> > > +#else
> > > +       return 0;
> > > +#endif
> > >  }
> > >
> > >  extern asmlinkage void entry_SYSCALL32_ignore(void);
> > > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > > index c3028b4df85f..ffbcb0aea450 100644
> > > --- a/arch/x86/kernel/head_64.S
> > > +++ b/arch/x86/kernel/head_64.S
> > > @@ -61,11 +61,14 @@ SYM_CODE_START_NOALIGN(startup_64)
> > >         /* Set up the stack for verify_cpu() */
> > >         leaq    __top_init_kernel_stack(%rip), %rsp
> > >
> > > -       /* Setup GSBASE to allow stack canary access for C code */
> > > +       /*
> > > +        * Set up GSBASE.
> > > +        * Note that, on SMP, the boot cpu uses init data section unt=
il
> > > +        * the per cpu areas are set up.
> > > +        */
> > >         movl    $MSR_GS_BASE, %ecx
> > > -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> > > -       movl    %edx, %eax
> > > -       shrq    $32,  %rdx
> > > +       xorl    %eax, %eax
> > > +       xorl    %edx, %edx
> >
> > You can use cltd after "xor %eax, %eax", it is one byte shorter with
> > the same effect ...
>
> I suppose that would work, but I'm not sure it's worth it to
> hyper-optimize boot code like this.  It's also confusing since the SDM
> calls this instruction CDQ instead of CLTD.

No big deal, indeed.

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>


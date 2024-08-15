Return-Path: <linux-kernel+bounces-287544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703889528FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972531F23F15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC4166F3D;
	Thu, 15 Aug 2024 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O6cDqCpH"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EF166F37
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723700246; cv=none; b=lHJ47m2eQbY5bgD0KjHiItkBVYXVbpv4ZLBWhp1PJtliZwbWsWEl3/rKPek0Flk1cc/RQC9dHRkjIK3P7NKdNKkAiNnTH6DSEWQYEmQL3ZIZBno/qeBpnXq8VeCLAeh4cU5X6BzrJX/hD+nuVfaxhxmvpQC02ApI70Q/GIsa+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723700246; c=relaxed/simple;
	bh=qpM7t0jk2VpfeFjDLKmFXFjRR/jJ2cdh6VCEojgVlg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws+mm0J71NMMlhkR6AqVSJvWEkwPntXxcpiRtC/+BJf8p9DFue6w+WO2eCL6rgt2Vb+eJPEKpIwawfZFy6CsiqpP57yQvTXaIoi1e4hCNXZ5v7d3XsBfGtOimXeqVAWyAki1KfFcEXpeVLb6S6ho8ognOEvNVnAV8/Dec2sOSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O6cDqCpH; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5320d8155b4so787635e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723700242; x=1724305042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjDe8SKONaZURgHZA5c05VUPeOQmcnfH8fj79hTPUW0=;
        b=O6cDqCpHiD8GMvFx8VwZV3RdedAM+qg3Y4s5rRIzVA1Ivi6qfcPx0293dfmZ/050d4
         JgHCl/fc6a0PKFl5g63A4+js1ydFaYfQvjIXed3tPJ8XJUkb1NoclS9x0j5f6hmb/A6h
         7Kefb2mk8HHDSqAw+v5/BqcUC7qW7vWvYH4XwgcTPg2WuWL/QOIH95WMauTSCF1z6ALM
         nwPzNgXFoVAh8bkwEQ6JpovJ1T2hALlomEInAMtRo564edDjJ8P+o/+tKLPkq5fJygzE
         9Zm9itnGmpw1d35f+spF94PI+k/FQF2WkjkTehZT2/+TC5OLGcZrEN8EgmR+sOptKhec
         p/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723700242; x=1724305042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjDe8SKONaZURgHZA5c05VUPeOQmcnfH8fj79hTPUW0=;
        b=WXi835kH/+RzH6aX0F/Wjbh3Ei952ekPZdzNLUckhrCPVi+ACMU/OAJ9lQWAeFkWeo
         BDXfo6O0y5St2ZRaO2t75ne/luzepbNuex5r6PwtYyxoMCUws+qKF+hqU/tLX6FWhIdc
         CwvcOD4G2mnpSN0jtDQHKHyik1bSiJ3+VMj2tdj/S85UVmmK6S3yI+6nYugUhLQcthFM
         Dnfj6XiNL98bNtUvP+awkQdLy9N/HJqpWcvDlFUbyaHAs3q++ne0j1FBQdf8R6V7sZdp
         nLsaHPJVjieN/1ndqU0NA+EweM3tiZdhE8UBlFt7XV5arEfquoEkejK5gW2J0UQjfPH4
         xiuA==
X-Forwarded-Encrypted: i=1; AJvYcCV3gGWXlIwEZFawtPjwtoAb41K+yYfVM1frIZwdDj90mcULd2Gl0PshoZL5y0rtMld9l6PxRqIvEy3EtiKO8Hvn+pm1EmFMd2S7Qszg
X-Gm-Message-State: AOJu0Yz+PnKJtyDlFkw5HqcGKfiMnenhVNzwCP6WDjW2FD/sRN44qlBX
	zsskPkL5UdOsW8shy5lAbY0KjCVM06LlzJ/MTGhrBI9vvJvhlbcDKEi1hgUAZvyWhVjhuynupdR
	mU7BWZ+fRWYkstEgNbpSWsfg/GprQcRVlGE3HGuhGjYy63nf1
X-Google-Smtp-Source: AGHT+IF9jSmbdeVwCB79GtR9SDoJ+2bWHoYxzLqNWum1tI3hIQtH6XZiiN6rGlSnsekomXl3LrE9gKaymssMicPa+1U=
X-Received: by 2002:a05:6512:3b0d:b0:530:ac6e:ea2f with SMTP id
 2adb3069b0e04-532edbacfb7mr2890845e87.37.1723700241540; Wed, 14 Aug 2024
 22:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625030502.68988-1-cuiyunhui@bytedance.com>
 <CAEEQ3wnrdRcBdevQDGQ-5dr3aO1ura13_VskMYm8ySTZJTiYhw@mail.gmail.com> <CAEEQ3wkFk1bxEPH38yBH8wzAGhMB296B8knjx8nFKQYgrACSDg@mail.gmail.com>
In-Reply-To: <CAEEQ3wkFk1bxEPH38yBH8wzAGhMB296B8knjx8nFKQYgrACSDg@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 15 Aug 2024 07:37:09 +0200
Message-ID: <CAHVXubhWck7WS4CHByw1Y6zpN_+K41TmQ=xa7c_3+xo_se+HaA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Randomize lower bits of stack address
To: yunhui cui <cuiyunhui@bytedance.com>, Kees Cook <keescook@chromium.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, conor.dooley@microchip.com, bjorn@rivosinc.com, 
	sorear@fastmail.com, cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, punit.agrawal@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunhui,

On Thu, Aug 15, 2024 at 4:08=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> A gentle ping, Any more comments on this patch?

I'm adding @Kees Cook  in cc in case he has any.

Thanks,

Alex

>
> On Thu, Jul 11, 2024 at 2:09=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Add punit in the loop.
> >
> >
> > On Tue, Jun 25, 2024 at 11:05=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedanc=
e.com> wrote:
> > >
> > > Implement arch_align_stack() to randomize the lower bits
> > > of the stack address.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  arch/riscv/include/asm/exec.h | 8 ++++++++
> > >  arch/riscv/kernel/process.c   | 9 +++++++++
> > >  2 files changed, 17 insertions(+)
> > >  create mode 100644 arch/riscv/include/asm/exec.h
> > >
> > > diff --git a/arch/riscv/include/asm/exec.h b/arch/riscv/include/asm/e=
xec.h
> > > new file mode 100644
> > > index 000000000000..07d9942682e0
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/exec.h
> > > @@ -0,0 +1,8 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +#ifndef __ASM_EXEC_H
> > > +#define __ASM_EXEC_H
> > > +
> > > +extern unsigned long arch_align_stack(unsigned long sp);
> > > +
> > > +#endif /* __ASM_EXEC_H */
> > > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.=
c
> > > index e4bc61c4e58a..e3142d8a6e28 100644
> > > --- a/arch/riscv/kernel/process.c
> > > +++ b/arch/riscv/kernel/process.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/tick.h>
> > >  #include <linux/ptrace.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/personality.h>
> > >
> > >  #include <asm/unistd.h>
> > >  #include <asm/processor.h>
> > > @@ -26,6 +27,7 @@
> > >  #include <asm/cpuidle.h>
> > >  #include <asm/vector.h>
> > >  #include <asm/cpufeature.h>
> > > +#include <asm/exec.h>
> > >
> > >  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR=
_PER_TASK)
> > >  #include <linux/stackprotector.h>
> > > @@ -99,6 +101,13 @@ void show_regs(struct pt_regs *regs)
> > >                 dump_backtrace(regs, NULL, KERN_DEFAULT);
> > >  }
> > >
> > > +unsigned long arch_align_stack(unsigned long sp)
> > > +{
> > > +       if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_=
va_space)
> > > +               sp -=3D get_random_u32_below(PAGE_SIZE);
> > > +       return sp & ~0xf;
> > > +}
> > > +
> > >  #ifdef CONFIG_COMPAT
> > >  static bool compat_mode_supported __read_mostly;
> > >
> > > --
> > > 2.20.1
> > >
> >
> > Thanks,
> > Yunhui
>
> Thanks,
> Yunhui


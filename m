Return-Path: <linux-kernel+bounces-258412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F0F9387A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3042280F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5CC12B93;
	Mon, 22 Jul 2024 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PMEo5fl4"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66128F54
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721617949; cv=none; b=TwxXEPKq5RFnvSppSzPanh4bdWuqIjDxiznS3tFMAP814QPv5E8hHcDWwI02kUFl1IWUOk2rQOJbO6kXA0riYvYKgwu39PHzRCI2xE5v1o0bHLSziP2ONy4551YElVMcG9UHzgHy/N0BhVkSm2kkD6cAgoK3M8Bv+tQt4Lgx2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721617949; c=relaxed/simple;
	bh=oqhtMKeTyj66DNZE/v7RD2ZgLNvLTWGxxbsOoNKi1WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE+ydcCFmui7c6kcWAYnJhEOk6do11DoWelk2BvSoI+z9U3x7SaKEuLx9fdo+KlVUs4JVAOE31nSHTDQHspdkphYVX6cr+ombpYNrwuSOmE4XCLbuvQ8+EASTK/EJw3PuDsBZYSGeJjjtCReZ7O3dm7mVbg3z1fGuXqpgaKnVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PMEo5fl4; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2611da054fbso1255916fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721617947; x=1722222747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VlY9vQIqtUAagLIYX96hyqfTP17OmaFXQAiweqEIno=;
        b=PMEo5fl4z87evKLxXH6AIkDlmMl7zZqDb9IL4oLHC2Fn1nN2Rq50w87pOdqWvYkCsQ
         YhO7eOObh7Y6jF+f+/aW74I/18XvBzj3tYgWDZXOyl+hMBdszTtNiirQ8I5Ud0r90LIT
         3aHX8pTmWIsCpB09IenTlvH/K5jRO7KsxUfbvb51WPXrWojFjUMpLFHBbqTMH1AXYequ
         6UL50SyPZjllYatbuxXnZY9zKxsbaZmqUg8q/90oAurRIFZ2YB+Z1Un8Qmd+Az8+eM5F
         Qte3yR0K5N28vXCpD9ApVH+Mg+MH21cjrzgsdpmKStXuR8DsZFQeGSEXMwaxQqeSMZNQ
         QODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721617947; x=1722222747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VlY9vQIqtUAagLIYX96hyqfTP17OmaFXQAiweqEIno=;
        b=oyDLjlH+4Z10m7eXibqozumoNlTpBOtL3mFVuqU8DSYZ7xom3oAPzCOKxwvzaiMLGF
         NMPb+/LckMDgBPPNTa5zBcdAbIVoaqsc91p0C3vwraCInAVZ1BbCc8MxpchR5kVsI35O
         Y9rfY4Mw9Rk0CE7EWShBcZSGbhwsUn1te/Ghul1mZ14ru3EamGzxd3xwEnZ7NziGQNV0
         dQezlrqOpXfRgJMfTKpBBUc3725gYelPB3RGXys4hLu4X0KiG1sXgUkjhQm7KiyJ9jaC
         u2cdI+k6j99q5y9FMwNTtGbTAdOoNLZz2PpmhodI9B0rAIAW7Mu45htcEVjS8sVrRhc5
         hNBA==
X-Forwarded-Encrypted: i=1; AJvYcCWEObWFyZlHL2gtTcLRyWAwwE8vuotJ5y0IgAGLriR3L3G5Ts8bMBhi2qeUbtWlmOLiUnLuM5+HmTDa2KBeSbQ8ymtFmDjPcn1Xdcgc
X-Gm-Message-State: AOJu0YwEDs5ZemUHhUEmu3lHBj2OOm7mQC9cSCBuf9wjUqRQcoKF47Pv
	cxeTSWj0/DvQPIhYLOPnLYYX/oS8rqLWQvyuwbu2WwWHYXcW0n70enaLvvRly3zx/UubmiZXQma
	aW2YsIrvQ1vUHju2FIniRq/738ov+khCxg6Xoqw==
X-Google-Smtp-Source: AGHT+IEmKL8qSE6nD4oaItm05/DMOLtviaNKjqxaDNvzE1H6a0xYKUtsnk11YNWmPChOacgnhT/rbuXKZJXBxgJfnCY=
X-Received: by 2002:a05:6870:a450:b0:260:fd4c:6506 with SMTP id
 586e51a60fabf-2638df29e12mr5587831fac.19.1721617946842; Sun, 21 Jul 2024
 20:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718020935.12803-1-cuiyunhui@bytedance.com> <20240719-92015016b960e7153e97b39d@orel>
In-Reply-To: <20240719-92015016b960e7153e97b39d@orel>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Jul 2024 11:12:16 +0800
Message-ID: <CAEEQ3wnbJSOhXkvfBPMJ0+CvDJ_o1Fa_uFCd3dReMPXDgZG+JQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv/mm/fault: add show_pte() before die()
To: Andrew Jones <ajones@ventanamicro.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, akpm@linux-foundation.org, surenb@google.com, 
	peterx@redhat.com, alexghiti@rivosinc.com, willy@infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew,

On Fri, Jul 19, 2024 at 10:33=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Thu, Jul 18, 2024 at 10:09:35AM GMT, Yunhui Cui wrote:
> > When the kernel displays "Unable to handle kernel paging request at
> > virtual address", we would like to confirm the status of the virtual
> > address in the page table. So add show_pte() before die().
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/mm/fault.c | 47 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index 90d4ba36d1d0..dfe3ce38e16b 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -22,6 +22,52 @@
> >
> >  #include "../kernel/head.h"
> >
> > +static void show_pte(unsigned long addr)
> > +{
> > +     pgd_t *pgdp, pgd;
> > +     p4d_t *p4dp, p4d;
> > +     pud_t *pudp, pud;
> > +     pmd_t *pmdp, pmd;
> > +     pte_t *ptep, pte;
> > +     struct mm_struct *mm =3D current->mm;
> > +
> > +     if (!mm)
> > +             mm =3D &init_mm;
>
> arm64 show_pte starts with a summary line where the pgtable type (swapper
> vs. user), number of VA bits, and physical address of the pgd are
> displayed. Should we add that too?
Oaky=EF=BC=8C I will add it in v2.

>
> Thanks,
> drew
>
> > +     pgdp =3D pgd_offset(mm, addr);
> > +     pgd =3D READ_ONCE(*pgdp);
> > +     pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
> > +     if (pgd_none(pgd) || pgd_bad(pgd))
> > +             goto out;
> > +
> > +     p4dp =3D p4d_offset(pgdp, addr);
> > +     p4d =3D READ_ONCE(*p4dp);
> > +     pr_cont(", p4d=3D%016lx", p4d_val(p4d));
> > +     if (p4d_none(p4d) || p4d_bad(p4d))
> > +             goto out;
> > +
> > +     pudp =3D pud_offset(p4dp, addr);
> > +     pud =3D READ_ONCE(*pudp);
> > +     pr_cont(", pud=3D%016lx", pud_val(pud));
> > +     if (pud_none(pud) || pud_bad(pud))
> > +             goto out;
> > +
> > +     pmdp =3D pmd_offset(pudp, addr);
> > +     pmd =3D READ_ONCE(*pmdp);
> > +     pr_cont(", pmd=3D%016lx", pmd_val(pmd));
> > +     if (pmd_none(pmd) || pmd_bad(pmd))
> > +             goto out;
> > +
> > +     ptep =3D pte_offset_map(pmdp, addr);
> > +     if (!ptep)
> > +             goto out;
> > +
> > +     pte =3D READ_ONCE(*ptep);
> > +     pr_cont(", pte=3D%016lx", pte_val(pte));
> > +     pte_unmap(ptep);
> > +out:
> > +     pr_cont("\n");
> > +}
> > +
> >  static void die_kernel_fault(const char *msg, unsigned long addr,
> >               struct pt_regs *regs)
> >  {
> > @@ -31,6 +77,7 @@ static void die_kernel_fault(const char *msg, unsigne=
d long addr,
> >               addr);
> >
> >       bust_spinlocks(0);
> > +     show_pte(addr);
> >       die(regs, "Oops");
> >       make_task_dead(SIGKILL);
> >  }
> > --
> > 2.39.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks=EF=BC=8C
Yunhui


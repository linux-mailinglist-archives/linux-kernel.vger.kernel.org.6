Return-Path: <linux-kernel+bounces-258436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09659387E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C089280E69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6913FFC;
	Mon, 22 Jul 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M5Pvv6ec"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C12F26
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620844; cv=none; b=umo4pN8Li1YZi1an86tQ4UFdtRuZH87ZhCeMSKRdS8G/GPmhX87fUQbRAEaDHA8x8+GcViq0rmQr54igYEpn88brROea44061X8oU2dOpcZwHCWI+q8MlYP/X1e7vLXdqoJPnRmRXxs1RKgAAEutbdJRX6DvzMmkq2m+R0zHX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620844; c=relaxed/simple;
	bh=oGNhP8ovZPDl5i3vKYLo7FGZ8hwMNjaWwE53L7e3vVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFJZokcFwF9gMqpeD2zEgAR18Cx6IriU6BlrRefHt+tusCormGKC3YwCqUGA5Nr8QCMH2wpKHbLx+AdzNN3duaSoGLIbiaSQrHP221FWWgRrdt8dETTBXxg/grYaqVN8jeX7NLO9JZhzFSCVpPszfX2IVlAeuLar8ov04PGqGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M5Pvv6ec; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d9e13ef9aaso2427728b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721620842; x=1722225642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU/U9aT/yCpp05DYRB+Jlkcig4GcoVKKEP6zUCdSbio=;
        b=M5Pvv6ecZAqvShAVWkv3hrXHYmBWB2TlDTE6V5SOmWvMd7TPZ/AhRNJBRS1fYp9XMx
         Zr6702qIMiH63fUFLjVTJ/pxgUzJ0KJOfAaY6hvyMxs1Gy9v/5PAUhneYEmT/5rjGQib
         lJ6/FhfL11jLTo4ZCnqNPKAejP7oFzWGzb9gP3jH3KhiH4vA4QRZvQ9V4NENmD/z42+4
         f3zmuW2RHlZ2B9mgy7p2qe6VjqtGhrkQOgnx8iisEwy2q84laICbuadb3cqb0pN6GHBr
         XkxqFdgrJqdPkGqaMduSamOGbi6sD720inXZRM31+Z3/GZ1rstFukJlXGse8eXYVJ235
         EQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721620842; x=1722225642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU/U9aT/yCpp05DYRB+Jlkcig4GcoVKKEP6zUCdSbio=;
        b=I11SQFBWWZ50081EMvFNh6WRnuBzKVrR06bGj7R5eUHDKmA5vVDTodjMmRNwDU6SPC
         QdtjR7PAS7RAxsJbun9dzFdrVbWhfo1Mk4+R+FvHjYjJlRSJ/RkiA2Pr7PmeZAkYwp5g
         /5krm0Q4mbBleKjA24y8CTwLHky6FUqIA186ivFlrCj9pBQt84l3GHQ11T54mbK4m5Jj
         3WTfkEqk+FNqu85T8YHjKgk2cNn9GV+bmrJTf2SUIn/nAASxl7NEgL6s2xl6l1Z6iwhh
         JHypY75LyoADH5PV+pNPzklANvK1MD8RLIbr5NslWH5JKvuxKOkYEHoZhi43xIxY4t5g
         KWeg==
X-Forwarded-Encrypted: i=1; AJvYcCV06jup+oenMzfCua2cMP/O7OyTSr/d6nXmmUOxFi/O3E6G5927G4kN2RVboqkVZXSfJzH1nGeFFc6BbwnWz9pNOOTGATvm0fgv5yzg
X-Gm-Message-State: AOJu0Yxq9UxPMKeXbzYbfBBKuFzZi2BnOWhWTETu/xLRx9EkTLcS+8aF
	wR4jzst8HlV+hW0clkziJd2d5VZHGXezM3wati8HaAdc01pcnMSpyILVh3baRbNt8wGUVq5y1Jo
	/pCcaKTZ9JQw/oTIZco084nF7DLkwfnlMTHpLgw==
X-Google-Smtp-Source: AGHT+IFufRHIYdTg2myge8uAn3TBHPQBEg7AxWUisYIUvVxbwCM8e7mtmaptcuhhHHsopWJlBCy1ww8Pnv0TCceAK6E=
X-Received: by 2002:a05:6870:55ca:b0:260:e713:ae8b with SMTP id
 586e51a60fabf-263ab42d509mr5067699fac.20.1721620841722; Sun, 21 Jul 2024
 21:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718020935.12803-1-cuiyunhui@bytedance.com> <CAHVXubiYbLs9j=boM7yVg0nRBg3kY9EQiv2R+edLs+B7qJTZug@mail.gmail.com>
In-Reply-To: <CAHVXubiYbLs9j=boM7yVg0nRBg3kY9EQiv2R+edLs+B7qJTZug@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Jul 2024 12:00:30 +0800
Message-ID: <CAEEQ3wm3vk4Yyix+507SH=Qyi4b1dwiGu0-Ep2ikweDTTLLfOg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv/mm/fault: add show_pte() before die()
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, akpm@linux-foundation.org, surenb@google.com, 
	peterx@redhat.com, willy@infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex=EF=BC=8C

On Sat, Jul 20, 2024 at 12:26=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> Hi Yunhui,
>
> On Thu, Jul 18, 2024 at 4:20=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
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
> > +       pgd_t *pgdp, pgd;
> > +       p4d_t *p4dp, p4d;
> > +       pud_t *pudp, pud;
> > +       pmd_t *pmdp, pmd;
> > +       pte_t *ptep, pte;
> > +       struct mm_struct *mm =3D current->mm;
> > +
> > +       if (!mm)
> > +               mm =3D &init_mm;
> > +       pgdp =3D pgd_offset(mm, addr);
> > +       pgd =3D READ_ONCE(*pgdp);
> > +       pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
> > +       if (pgd_none(pgd) || pgd_bad(pgd))
> > +               goto out;
> > +
> > +       p4dp =3D p4d_offset(pgdp, addr);
> > +       p4d =3D READ_ONCE(*p4dp);
> > +       pr_cont(", p4d=3D%016lx", p4d_val(p4d));
> > +       if (p4d_none(p4d) || p4d_bad(p4d))
> > +               goto out;
> > +
> > +       pudp =3D pud_offset(p4dp, addr);
> > +       pud =3D READ_ONCE(*pudp);
> > +       pr_cont(", pud=3D%016lx", pud_val(pud));
> > +       if (pud_none(pud) || pud_bad(pud))
> > +               goto out;
> > +
> > +       pmdp =3D pmd_offset(pudp, addr);
> > +       pmd =3D READ_ONCE(*pmdp);
> > +       pr_cont(", pmd=3D%016lx", pmd_val(pmd));
> > +       if (pmd_none(pmd) || pmd_bad(pmd))
> > +               goto out;
> > +
> > +       ptep =3D pte_offset_map(pmdp, addr);
> > +       if (!ptep)
> > +               goto out;
> > +
> > +       pte =3D READ_ONCE(*ptep);
>
> All the READ_ONCE() can be replaced by pXXp_get() macros defined here:
> https://elixir.bootlin.com/linux/v6.10/source/include/linux/pgtable.h#L31=
5
>
> And we should stop as soon as we encounter a leaf entry using pXd_leaf().
>
Okay, I'll update it in v2.

> Thanks,
>
> Alex
>
> > +       pr_cont(", pte=3D%016lx", pte_val(pte));
> > +       pte_unmap(ptep);
> > +out:
> > +       pr_cont("\n");
> > +}
> > +
> >  static void die_kernel_fault(const char *msg, unsigned long addr,
> >                 struct pt_regs *regs)
> >  {
> > @@ -31,6 +77,7 @@ static void die_kernel_fault(const char *msg, unsigne=
d long addr,
> >                 addr);
> >
> >         bust_spinlocks(0);
> > +       show_pte(addr);
> >         die(regs, "Oops");
> >         make_task_dead(SIGKILL);
> >  }
> > --
> > 2.39.2
> >
>
> Otherwise, that's a good idea to print the page table content on fault so=
:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex

Thanks,
Yunhui


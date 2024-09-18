Return-Path: <linux-kernel+bounces-332240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0CD97B71C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4F41C216BF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6E52F74;
	Wed, 18 Sep 2024 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dMNuWXG5"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2E9443
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726631060; cv=none; b=Shl/VqQuWNFEWUssi4w0gkwiBn1eHRBMT2A4ZvbXkR/IFfNIykGxSlHwEiejBI6mCMKotHevz2ROd7Jt5q68SrZPhnzQPqmVRRaXWhuXbXl89kSB0LxumnMWA2ou0mn9ZlsuKxdDQseKiFFJ6ko1OxgL2VNSf6O7Zg9KCFNkrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726631060; c=relaxed/simple;
	bh=rED2rHRydyg/1KhBvcYFXp3zFT9SkLb2tvU1x0V1B8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGtmJV6Gm6/y/JM6y3oem42YXZBBsRRcAbGG9oC5gdIbC2OaLlrCeRPibYD1aOi+mYxDO771xprqefrHCi0Jr+tu+tZqkYFJrawPwWalizr5utZoHbCa7GojTY3Agfbko3JQwiNfwgP71teBrXebNfO4ImJqOLdR4JinmyZn/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dMNuWXG5; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e03f8ecef8so3435628b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726631057; x=1727235857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DobwYhNLX7T7HDxembho0c7pkvfHZaGZKAqaliF5l+8=;
        b=dMNuWXG5gplX79jbfJOpcpgg2P1EW5IDTs08obqwtaZ33A/bdche34a+FzrWoRyz5W
         AQ9UepZvkFmdIqnIiRPfd+4JQxn0HOM2843Rw8v5lfrmX4n1CntWzNGg0/A61zJtBeUH
         hsIuew44O55CdmvMRQ9jjFTHIV9myltNfIm874tFrpfV6S//35HtKHGzcDIrFJiboene
         U963oSSBjBQ6TglV8eAjITFHfj19p6Ttlfp2UfxVZsFThihzXCwrIvKtwopT9pwMGmKd
         j/rhD0kGAP5kkuDx5WqItsUZqfuW4+QUqFBh5S25jBvPVSxd91LpI2FZhQDLWtC9P8n6
         H6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726631057; x=1727235857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DobwYhNLX7T7HDxembho0c7pkvfHZaGZKAqaliF5l+8=;
        b=u4rn3jiDqYNZBZyf08ScqRlu4Sa03nbK6LvKtH5QbrkSw7NLSmca92bsj9IVU4B+V4
         OoADvSOD2iNva8AjTue3pCH9dqIyJG7GRETOw3xPZuo6YsMDtK1y3RkgzjpAuz0ewKBP
         wOn8T6nIocbsuRVk5WPXPuqif4Wl7eR0duxSwGHD2dwYRotjb3tWy8ns5coDbEKadK33
         rbEZwg1o3HpRfqRZSmSmN5kWeyx+4fzANe7PT1L9JluMfvEDnhe5WAmIy+MQgMqcMkon
         W/QysdYwoDT5dsT93qsuqt7aEztpGC6T7E/iRT3xNDhZkK0JDElm8CyPth6G9GoeZBEm
         Xlbw==
X-Forwarded-Encrypted: i=1; AJvYcCWPP8GmJ3zZhkrevxXo0VzQKnXQrvOr295o+Et0cP88zRSCel3psehhyOjyigvaI+adxkCj+K3cbJi2RCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe39lodhiHr414IQygdd0UOxff3rskIt6+kwCZvh1BBeO6uW4G
	04KKdPrsFiILmTWboU+sooU1GflI9KtPJasmU/jqJxGoizvJKocrkPX3OhiLAaG8OLW616GzDsn
	YDBtFSdlvJQMcSryTFrWu3cuR5yiak8tzv70Xdg==
X-Google-Smtp-Source: AGHT+IF6de8Ljl0ByArbrMkxhZs+4LwqOYs7ZOBCk6m5TQb5f1t5owv4UvkHCcuojdyGYfR5plBv4DlUn7J0rn9ve1s=
X-Received: by 2002:a05:6808:219c:b0:3e0:4076:183b with SMTP id
 5614622812f47-3e071ae397dmr18229228b6e.32.1726631057195; Tue, 17 Sep 2024
 20:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723021820.87718-1-cuiyunhui@bytedance.com> <CAEEQ3w=hsAEp8t+eH1GQW4M9ZY2TPXGUuhyNLB5DFEo88vwDZA@mail.gmail.com>
In-Reply-To: <CAEEQ3w=hsAEp8t+eH1GQW4M9ZY2TPXGUuhyNLB5DFEo88vwDZA@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 18 Sep 2024 11:44:05 +0800
Message-ID: <CAEEQ3wmOKtfMyRYnmEcHcczuRhPjMC8g_rxQc9y3X9gOuaqS0Q@mail.gmail.com>
Subject: Re: [PATCH v3] riscv/mm/fault: add show_pte() before die()
To: conor@kernel.org, punit.agrawal@bytedance.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org, 
	surenb@google.com, peterx@redhat.com, alexghiti@rivosinc.com, 
	willy@infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

A gentle ping for this patch.

On Thu, Aug 15, 2024 at 10:05=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
>
> Hi All,
>
> A gentle ping, Any more comments on this patch?
>
> On Tue, Jul 23, 2024 at 10:18=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.=
com> wrote:
> >
> > When the kernel displays "Unable to handle kernel paging request at
> > virtual address", we would like to confirm the status of the virtual
> > address in the page table. So add show_pte() before die().
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/mm/fault.c | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index 5224f3733802..c72e6c7c09ef 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -22,6 +22,57 @@
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
> > +
> > +       pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=
=3D0x%016llx\n",
> > +                current->comm, PAGE_SIZE / SZ_1K, VA_BITS,
> > +                mm =3D=3D &init_mm ? (u64)__pa_symbol(mm->pgd) : virt_=
to_phys(mm->pgd));
> > +
> > +       pgdp =3D pgd_offset(mm, addr);
> > +       pgd =3D pgdp_get(pgdp);
> > +       pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
> > +       if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
> > +               goto out;
> > +
> > +       p4dp =3D p4d_offset(pgdp, addr);
> > +       p4d =3D p4dp_get(p4dp);
> > +       pr_cont(", p4d=3D%016lx", p4d_val(p4d));
> > +       if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
> > +               goto out;
> > +
> > +       pudp =3D pud_offset(p4dp, addr);
> > +       pud =3D pudp_get(pudp);
> > +       pr_cont(", pud=3D%016lx", pud_val(pud));
> > +       if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
> > +               goto out;
> > +
> > +       pmdp =3D pmd_offset(pudp, addr);
> > +       pmd =3D pmdp_get(pmdp);
> > +       pr_cont(", pmd=3D%016lx", pmd_val(pmd));
> > +       if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
> > +               goto out;
> > +
> > +       ptep =3D pte_offset_map(pmdp, addr);
> > +       if (!ptep)
> > +               goto out;
> > +
> > +       pte =3D ptep_get(ptep);
> > +       pr_cont(", pte=3D%016lx", pte_val(pte));
> > +       pte_unmap(ptep);
> > +out:
> > +       pr_cont("\n");
> > +}
> > +
> >  static void die_kernel_fault(const char *msg, unsigned long addr,
> >                 struct pt_regs *regs)
> >  {
> > @@ -31,6 +82,7 @@ static void die_kernel_fault(const char *msg, unsigne=
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
> Thanks,
> Yunhui


Thanks,
Yunhui


Return-Path: <linux-kernel+bounces-259547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A9939828
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438981F221E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26E13665A;
	Tue, 23 Jul 2024 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NlJe/Zti"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE17322A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721700940; cv=none; b=hZaHVfOALpDPADkBFsEHf8Fz9q+C+1JVRkmOdkm7EmzkKqgPEBqc6UNSESBpNon86rQFkHw7ddkarPBFRHpaoFbU0CbBaK/v6MCj7acZpouJgihWJFXkP2hrSgnyIDxkhzwBYRPDIB+J3dKOIiUIy56k+ObYaDdvabAYBlOz2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721700940; c=relaxed/simple;
	bh=sGxTY1WMtNuarTpoJdqoGk9m8qFbGRF4t0gWSNU4mao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf/6kpgcNBnpL1234KjdkG/qf2V5SJ9DAKx6Js0HaTTPfD1HbB0oxYU/4tBsO61oe/bkPjt4V6/DF01EZWLhvwr9R1iH+td3nwrtLjSr0xmJEr6BwWFBTgPGTe18zASfruejXZ9VXhwNINtt8Td/yjb4qo7DZ9SSPuAtAgzbnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NlJe/Zti; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso1541049fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721700938; x=1722305738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJdZfAkdVNg0Q3730C/uHig6sfe5OttmDP7Ke1DUOwU=;
        b=NlJe/ZtizbAB+ml9VAHXOXyip6iD9R2V+KrUo01uWQ3/rmLvGz81XZIFKi1q7enMN6
         hUoaFAAeU1+LCkc94YcDJ2I7tRLpN+qE9Oegz6QsQP5zSehOuF+tV+brlWd0m0Mem0gj
         0WgrrZ+OCzg9bLDjcAwIVDa6whONNpUisN4J6oV14WqR3ip9MC0AN5X+q54srl+N130O
         jZQ9kiOUvZJyRBGLGQlgkWKVIMC7tzIpA3+9ygOsgUN/cmU5TwGPsv9PyKmGjxS0Nt2n
         rUTTzk3qsnHcvJTj2Vjang6GTSYvWIUxHTX95WrvqURvFYEH7EDPiBRaEChda2Jo3f5D
         WjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721700938; x=1722305738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJdZfAkdVNg0Q3730C/uHig6sfe5OttmDP7Ke1DUOwU=;
        b=uxeoMCc6FMTpjHh1+5XomyiTGDY/GDN0qSOBPKnHDglkb4Zr5TuFPXixkK2mBVk93I
         feSrVu40nLhB2amEsCIlZ8piyAayDXO5XClv6Yt5GAXGG5NhAmvASL3HaahaTRHumZTD
         RAGKvbwXIx8om5epBCRYXqVy/XX3/ws/JsNzIjBA0DVyHOvW4bx+UrNcH3kDGVmqxlDv
         zbGqFe5uftman62qWRilWix9S1I7MPwZFmrlMLAdbFdPamGUj5mnU6hEkgXBrXbTmm1J
         A7aCM3H9lqXmL+QYBrKvJ1HumPYi11LBUNZoivfnRvrUF7z760kFx0mBqdml2yFzfNJ9
         Q0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVw02QKf7q6eQAnI1/FhtCevub4NpEwbyI1K1NUSchfGlqvSm16Sh0EVfSHSTS463WLMD/vyO6a9dsPP8Eb2rTwQLNtlmISjFkZqpUB
X-Gm-Message-State: AOJu0YyeDVok4W6JuSjbMJZWkiQ8AzCM6BYspGsZ3WWjOCkJsKZqW6m5
	qAOHOZ4lXlta8OP4OAeR+QYNbMnNRAYLZmkqDOKXVcfoCw6pEesl3wSlKKuE4aRJOeSUEGWlLrr
	29IpVnkfmAarOGIZEyWLvnfIB2wK2G+rh60WPkg==
X-Google-Smtp-Source: AGHT+IFgpbVGn9CsI8xN/1EVf0wd3TbR54+Ws9lZ6TW/kxWDhj3Zfq1y+37Tr2mCsWlBgNY3lZVyku/q5trpn/3/hAI=
X-Received: by 2002:a05:6870:8196:b0:25e:24d5:4d54 with SMTP id
 586e51a60fabf-2612164d7admr8380917fac.35.1721700937722; Mon, 22 Jul 2024
 19:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722042037.27934-1-cuiyunhui@bytedance.com> <20240722-pantyhose-salvaging-96faac4b4661@spud>
In-Reply-To: <20240722-pantyhose-salvaging-96faac4b4661@spud>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 23 Jul 2024 10:15:26 +0800
Message-ID: <CAEEQ3wn1NbZJXyr3KaRNisjtMjs8cPPa6hrZ80Zp4NMg46C_MQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] riscv/mm/fault: add show_pte() before die()
To: Conor Dooley <conor@kernel.org>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, akpm@linux-foundation.org, surenb@google.com, 
	peterx@redhat.com, alexghiti@rivosinc.com, willy@infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Tue, Jul 23, 2024 at 1:28=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jul 22, 2024 at 12:20:37PM +0800, Yunhui Cui wrote:
> > When the kernel displays "Unable to handle kernel paging request at
> > virtual address", we would like to confirm the status of the virtual
> > address in the page table. So add show_pte() before die().
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> The patchwork automation reports:
> +      1 ../arch/riscv/mm/fault.c:39:4: warning: format specifies type 'u=
nsigned long' but the argument has type 'phys_addr_t' (aka 'unsigned long l=
ong') [-Wformat]
Okay, I'll update it in v3.

>
> Cheers,
> Conor.
>
> > ---
> >  arch/riscv/mm/fault.c | 53 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index 5224f3733802..666d282a8bf4 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -22,6 +22,58 @@
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
> > +
> > +     pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=3D0=
x%016lx\n",
> > +              current->comm, PAGE_SIZE/SZ_1K, VA_BITS,
> > +              (mm =3D=3D &init_mm ? __pa_symbol(mm->pgd) :
> > +              (unsigned long)virt_to_phys(mm->pgd)));
> > +
> > +     pgdp =3D pgd_offset(mm, addr);
> > +     pgd =3D pgdp_get(pgdp);
> > +     pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
> > +     if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
> > +             goto out;
> > +
> > +     p4dp =3D p4d_offset(pgdp, addr);
> > +     p4d =3D p4dp_get(p4dp);
> > +     pr_cont(", p4d=3D%016lx", p4d_val(p4d));
> > +     if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
> > +             goto out;
> > +
> > +     pudp =3D pud_offset(p4dp, addr);
> > +     pud =3D pudp_get(pudp);
> > +     pr_cont(", pud=3D%016lx", pud_val(pud));
> > +     if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
> > +             goto out;
> > +
> > +     pmdp =3D pmd_offset(pudp, addr);
> > +     pmd =3D pmdp_get(pmdp);
> > +     pr_cont(", pmd=3D%016lx", pmd_val(pmd));
> > +     if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
> > +             goto out;
> > +
> > +     ptep =3D pte_offset_map(pmdp, addr);
> > +     if (!ptep)
> > +             goto out;
> > +
> > +     pte =3D ptep_get(ptep);
> > +     pr_cont(", pte=3D%016lx", pte_val(pte));
> > +     pte_unmap(ptep);
> > +out:
> > +     pr_cont("\n");
> > +}
> > +
> >  static void die_kernel_fault(const char *msg, unsigned long addr,
> >               struct pt_regs *regs)
> >  {
> > @@ -31,6 +83,7 @@ static void die_kernel_fault(const char *msg, unsigne=
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

Thanks,
Yunhui


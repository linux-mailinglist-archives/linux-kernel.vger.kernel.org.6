Return-Path: <linux-kernel+bounces-259546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CA939824
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9F1F2228F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152313A253;
	Tue, 23 Jul 2024 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ayCgwdxb"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781AEC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721700877; cv=none; b=fPGHX4LVm+SSqTMthz8SlRajc4CduRVHKKIkwaTF9ZZFJXR2COzqCu8X6zJybvYxz4mP26V7uX4zWgKezi89m8uiFmEXYVNlB60SHxRtM/om6T+QnHVKr/sYkd3C+spvC55f1rWtQgSK5ps3N7NSxyyt2LGUqQoLwgDq25xOcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721700877; c=relaxed/simple;
	bh=0nkLKnxaI52Fn1qCNnoAipaXKdTjzPaq6EOYaXEBWOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnYl4OM2iB7UMp5ersVOlXtZ/jwf/FTRu4SnItDjDNhk0vv7E/XPXYMVbd+Xhz1Uh7MWW7vi/TgiLJjGiv8qs/g5gB+gQILkLrkK69eeD6HJloc75DPApt0gjWZkaU1b4ocf7XLE/jmbEXvmze92vg7RWKieLfrl9CflltNTVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ayCgwdxb; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d569bee00aso1411280eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721700874; x=1722305674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+KyexOp1+64hGftnhl06UQTDhjl9bHisKnpbZEpIZA=;
        b=ayCgwdxbGZMSSnu23ZGRTF+R1chys2+zaTj8iG2l1uoZzosii85yHFhO+Psid31mix
         evFFBfo2wn7MjE0Gq2MoKwkBU8mmOtuB2br8J1F7CJWXu63xLdPn8/h8wYfMSEPYM0ft
         coDo1UaW2NBeeGG5YKN/lZtLXE1yr3fRzejNZsxflOtrXTxBF1GKkBxpmcTSmz1MXybp
         svB33zwItFCgyyMz9JqZb36sNmxv07K87CZD9VUmXLf8N5qajbbpFg0SZupcPc8ELvoA
         T1gR8AKYXHURNJSl+sxKqlxZAfRhI/VBODpbwU9oBk+/ucS7iiJEtvfv18BDpuLzxilp
         NM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721700874; x=1722305674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+KyexOp1+64hGftnhl06UQTDhjl9bHisKnpbZEpIZA=;
        b=Pk4//g/2Sq2mujF0ucNuHmLd/t/8PxSDmSQeUbAu3RwY0mJYyGw1AKq63hOQ78Mxys
         Lk9o0QZYH579FwKXYHoyEtazZsUr0z8XabHcmLFy+SA/5hXiuOo1ZDSziWB6fCMfMKFR
         Ea2NvmERB7Zwju9aPaQ5rpheuCUxAQ3DTiJf0db4wi3V7lxRFlW1dHtlWIz5CkuzAZNp
         9iCTvbPaxBzPCTAVY/SS8Wt9+hpfvb2Gt5fjOdDLG48uJyAe1zsCrwGaGjfPJ1VxKAOF
         6akd6tRB/wlrdgRhFyttrLV51wD0mxkIiHcnTfkoMu2B6MsEmwwRzPF3Kd4YCBHmCv43
         HnZg==
X-Forwarded-Encrypted: i=1; AJvYcCVBDSwKsHrM2VXX4nx2l1qUi6VzRrIlEMN3pCk5JxlHACftgn5qwQeqtewU2IwGpFZmRlJU4TrsQux3h+tB+GGlSx2ULZKnj1YEYM0P
X-Gm-Message-State: AOJu0Yx/Sperrmln4w/UmFxVEligW6psYzPFb6R78SPPOUNKIF2epzzw
	dqHZq6T/M1B5BW0tvq1qO1om6QONXgZyY1+dEPgWtbtViDj4q4u+55CCa4gAGaR4iTMfTJGuwLr
	1LCExwhXrDQUdhF9Rs6cgIGv/BDDHvIwCAI0yxHeyfL62fuS8sGU=
X-Google-Smtp-Source: AGHT+IHGNfghFlazmtyi1nY8PPgmCCsF4cSeVA7XgfiEz9kdMSs+VkGfU2H1jEQHXggLI8KHs3OppCPujh4mvoyloDs=
X-Received: by 2002:a05:6871:824:b0:25e:14e9:10c9 with SMTP id
 586e51a60fabf-261213255e1mr9052557fac.6.1721700874476; Mon, 22 Jul 2024
 19:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722042037.27934-1-cuiyunhui@bytedance.com> <20240722-a0d01590ba9ec0e0cc18ac74@orel>
In-Reply-To: <20240722-a0d01590ba9ec0e0cc18ac74@orel>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 23 Jul 2024 10:14:23 +0800
Message-ID: <CAEEQ3wkuR_fjrv6a78gKBTRCPujj1vnSdHHst4_Z4fjd3Dt+OA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] riscv/mm/fault: add show_pte() before die()
To: Andrew Jones <ajones@ventanamicro.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, akpm@linux-foundation.org, surenb@google.com, 
	peterx@redhat.com, alexghiti@rivosinc.com, willy@infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew,

On Tue, Jul 23, 2024 at 12:56=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Mon, Jul 22, 2024 at 12:20:37PM GMT, Yunhui Cui wrote:
> > When the kernel displays "Unable to handle kernel paging request at
> > virtual address", we would like to confirm the status of the virtual
> > address in the page table. So add show_pte() before die().
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
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
>
> nit: unnecessary () around the ternary.
Okay, I'll update it in v3.

>
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
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew

Thanks,
Yunhui


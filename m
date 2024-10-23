Return-Path: <linux-kernel+bounces-378165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0499ACC39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B661F22FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B61BDA8F;
	Wed, 23 Oct 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TM9t2QRG"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8841B4F1F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693541; cv=none; b=fJqNC9d2kXXTVwkUf4YaRzlRGMdKybZ7mf+om2/dkzJvRhr+HANbN8GLu35pTdru6JfuZxYzYur+GdRyTzcwrohcm3rWUG24GagL7gZ4Vb1T5kefGTs+YYhCMpHZHKBRhDm8oMIHJnxyybNICNjGFvvPvQhYco4Ra4MFrv9rKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693541; c=relaxed/simple;
	bh=ojRLudR+eC6nbIbKDapRw9fMM/C07i87ksgX323eRY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JLCqAf7vut+f+gmF4kHY00Jj4Isw6oWJi26V0mO1qdoTtBxuFXEnmVlO5qYP9lHjhLli3meL+tg05+T0BUn28fbYEVX0ZFyYX/2czlz0r2+LFV7HHQtmr0utva7GAPD0RMzSOpCfaqNMDMghHKFMPkHWq780Law8oXPzEoOBrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TM9t2QRG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d47b38336so4692576f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729693538; x=1730298338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAAn5kPuNQNsFVWUY6sfnOq+1F6tSClgu6q4tnZMMF8=;
        b=TM9t2QRGynKo5rf6ENGVGqhIFhGWvBKBYfY1axBfCwZ/PDAhTTDIlKI2+x2TZF5mJB
         56+7wFfS86f+Lk7xqnDYIADGTvXWjGWeUwzDUOQzyCQUa819BKkEQki2B54P8TmXGSpc
         spIIqEJAIAMbuf1cSgF14sw0AoeX9E+YbkVPBf+OGQzSSMpucjO5qb4FDTu8G9rDv/yP
         S94s1WlkfexS5IgLhR5vFmUIEIi4dwHb15TLv/FIpbbVmy6US/1oIGl51uszDcX56H/b
         Zi8XicrYaGJKm6p3yPF35Bn+cWMBr5kwtQ8u5CK+UZplVTy4X9TFuSQdxHQqncE5qfiy
         O6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693538; x=1730298338;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAAn5kPuNQNsFVWUY6sfnOq+1F6tSClgu6q4tnZMMF8=;
        b=KPKx4KjdoEcFBZZrhw5BNd7Dkfltm6/Cv98AuHKGmGyyt61Ys4I4275SjT1nEYeLuw
         RlTB9+mk5gjUFy7+LhJ1B3qgzefvuCAbDrkgWuOSGjYVGZjEuyBkDr4ABo8wP5nC11l/
         q4nQz+67cvWOxGjE3/RKWvNp3jAOKd1soDIouXqpN34zLlN51En6d0E7R9L/+GNyL/0F
         zTZKuVvm3bPvSopY88/hHSp3UZNTKf3KO7gNrHz2o0FIdlFLipDhD6/ZyJ1TD1xdSTjr
         DbIGvsHvYgpugj6E60YR096fniEjQME5Erjwq6lHv8rNs2tuyKGTYxH1Mr7jdgCyWN/F
         GyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMJm21xl1ANfsYc1wfNveNAF0OtPjLsk86W1JIe4l6c+PRBhPLF/chk/m7+AaILEMzz4yS28vBk53slW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvIyjKkY3B6CDN1dBzgkbEJME2ZFxfdDDe3fBxPIN9TP6xwwB
	9uiDTD2If/pgMNZ4ZIwLISfqV9F3OTNpQHTXATMn6XTn0vvprmwByEXOgJt0wCo=
X-Google-Smtp-Source: AGHT+IH6jVXQh4hL/d9WafdER0ekPEytRlJ6cLK7k+UAKu5Om/+ImrICrtNuDGQ6EVFGukI2hOoWag==
X-Received: by 2002:a05:6000:1e50:b0:37d:485b:b68d with SMTP id ffacd0b85a97d-37efceede09mr2011658f8f.2.1729693537734;
        Wed, 23 Oct 2024 07:25:37 -0700 (PDT)
Received: from localhost ([149.57.114.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186beffd5sm17612115e9.24.2024.10.23.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:25:37 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: palmer@dabbelt.com
Cc: conor@kernel.org,  punit.agrawal@bytedance.com,
  paul.walmsley@sifive.com,  aou@eecs.berkeley.edu,
  akpm@linux-foundation.org,  surenb@google.com,  peterx@redhat.com,
  alexghiti@rivosinc.com,  willy@infradead.org,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,  Andrew
 Jones <ajones@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH v3] riscv/mm/fault: add show_pte() before die()
In-Reply-To: <CAEEQ3wmOKtfMyRYnmEcHcczuRhPjMC8g_rxQc9y3X9gOuaqS0Q@mail.gmail.com>
	(yunhui cui's message of "Wed, 18 Sep 2024 11:44:05 +0800")
References: <20240723021820.87718-1-cuiyunhui@bytedance.com>
	<CAEEQ3w=hsAEp8t+eH1GQW4M9ZY2TPXGUuhyNLB5DFEo88vwDZA@mail.gmail.com>
	<CAEEQ3wmOKtfMyRYnmEcHcczuRhPjMC8g_rxQc9y3X9gOuaqS0Q@mail.gmail.com>
Date: Wed, 23 Oct 2024 15:25:36 +0100
Message-ID: <87ed46galb.fsf@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

yunhui cui <cuiyunhui@bytedance.com> writes:

> Hi Palmer,
>
> A gentle ping for this patch.
>
> On Thu, Aug 15, 2024 at 10:05=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.=
com> wrote:
>>
>> Hi All,
>>
>> A gentle ping, Any more comments on this patch?
>>
>> On Tue, Jul 23, 2024 at 10:18=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
>> >
>> > When the kernel displays "Unable to handle kernel paging request at
>> > virtual address", we would like to confirm the status of the virtual
>> > address in the page table. So add show_pte() before die().
>> >
>> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> > ---
>> >  arch/riscv/mm/fault.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 52 insertions(+)

Another one that seems to have slipped through the cracks. If there are
no further comments, please merge the patch.

Thanks,
Punit

>> >
>> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>> > index 5224f3733802..c72e6c7c09ef 100644
>> > --- a/arch/riscv/mm/fault.c
>> > +++ b/arch/riscv/mm/fault.c
>> > @@ -22,6 +22,57 @@
>> >
>> >  #include "../kernel/head.h"
>> >
>> > +static void show_pte(unsigned long addr)
>> > +{
>> > +       pgd_t *pgdp, pgd;
>> > +       p4d_t *p4dp, p4d;
>> > +       pud_t *pudp, pud;
>> > +       pmd_t *pmdp, pmd;
>> > +       pte_t *ptep, pte;
>> > +       struct mm_struct *mm =3D current->mm;
>> > +
>> > +       if (!mm)
>> > +               mm =3D &init_mm;
>> > +
>> > +       pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=
=3D0x%016llx\n",
>> > +                current->comm, PAGE_SIZE / SZ_1K, VA_BITS,
>> > +                mm =3D=3D &init_mm ? (u64)__pa_symbol(mm->pgd) : virt=
_to_phys(mm->pgd));
>> > +
>> > +       pgdp =3D pgd_offset(mm, addr);
>> > +       pgd =3D pgdp_get(pgdp);
>> > +       pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
>> > +       if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
>> > +               goto out;
>> > +
>> > +       p4dp =3D p4d_offset(pgdp, addr);
>> > +       p4d =3D p4dp_get(p4dp);
>> > +       pr_cont(", p4d=3D%016lx", p4d_val(p4d));
>> > +       if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
>> > +               goto out;
>> > +
>> > +       pudp =3D pud_offset(p4dp, addr);
>> > +       pud =3D pudp_get(pudp);
>> > +       pr_cont(", pud=3D%016lx", pud_val(pud));
>> > +       if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
>> > +               goto out;
>> > +
>> > +       pmdp =3D pmd_offset(pudp, addr);
>> > +       pmd =3D pmdp_get(pmdp);
>> > +       pr_cont(", pmd=3D%016lx", pmd_val(pmd));
>> > +       if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
>> > +               goto out;
>> > +
>> > +       ptep =3D pte_offset_map(pmdp, addr);
>> > +       if (!ptep)
>> > +               goto out;
>> > +
>> > +       pte =3D ptep_get(ptep);
>> > +       pr_cont(", pte=3D%016lx", pte_val(pte));
>> > +       pte_unmap(ptep);
>> > +out:
>> > +       pr_cont("\n");
>> > +}
>> > +
>> >  static void die_kernel_fault(const char *msg, unsigned long addr,
>> >                 struct pt_regs *regs)
>> >  {
>> > @@ -31,6 +82,7 @@ static void die_kernel_fault(const char *msg, unsign=
ed long addr,
>> >                 addr);
>> >
>> >         bust_spinlocks(0);
>> > +       show_pte(addr);
>> >         die(regs, "Oops");
>> >         make_task_dead(SIGKILL);
>> >  }
>> > --
>> > 2.39.2
>> >
>>
>> Thanks,
>> Yunhui
>
>
> Thanks,
> Yunhui


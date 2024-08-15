Return-Path: <linux-kernel+bounces-287442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDA9527CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21A41F23663
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F29476;
	Thu, 15 Aug 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VdiG7gRo"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA544C69
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723687562; cv=none; b=GyNB5LkXWcagmDc7vYWTR/vby6c35NGJCQ6Bc2TAldYJGu/I7I+psp6gX5AbhYMCzx8QD42MYunMhPNyQv/f3M1diWYzGT4wUImgxX4NK6pVrucsaj3wSS6oxgNbrwE8GuZ84PMKGOvVENI7vSAPun9BU7bzhR1tttsAHFNzWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723687562; c=relaxed/simple;
	bh=BDnTCpWWmur+11JCuk92Wt9LbD6AC/vh667vww7L9B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny/MotScavgLPrSLwg1wTrR7puNbi3P6iTFN9MT/HOXOki8UVZ2hzZ6cEiGIbw1FnNrKuCTKiTJNYIft+mTOZ0X0D6HtLPlLKMkRo/7HY7oFLl3IFOwQNH5q+eiqgmqn+yVIXMB01IsMTgdll1nrbTTfUekvzTTgAQX4SOB3NKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VdiG7gRo; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5c7f23f22so331104eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723687559; x=1724292359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gztf11sxNJHPAiXVpalG2T6xg+DahVfwn29zmjNMpnI=;
        b=VdiG7gRor1JZ5mG+xS7CEo0SQ+l1jl5wt6z0pQPj0U3EsZxqDqAMk83YPhir9lD1nB
         kdoWsMUPsgX7CEhjL4EEYthqFXENwAFQjbbmEtRBPh8RGdfqRCgaMz0FTjuQCIYgbw6X
         0n+pq57xPMhLngqHV3v45YG+TCB9ujDRuER2LdTV+n3dLS0Zy3lk3uLW5dBsHvvsKCC4
         cNh9ql3m3gXy2XVUwfCZ9nF7+jrnepzfErM4jsdP1Yt7Wk0l0Z5W7mOYeQG2/H7aGbkR
         nUUBL1iAiZp5MasP/fI49Nlnl2kJA/oQlQ0ihWmpB3El3WAo7j/k5VacxpTex4NH7x0I
         jfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723687559; x=1724292359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gztf11sxNJHPAiXVpalG2T6xg+DahVfwn29zmjNMpnI=;
        b=nsbBPqptnhJTF4TgfHf9kSWhSfFz98dFerL21LX82FzUBfZ0Hh+tndthVGMWcgTMjh
         OYN9IlbvnYHsBrsxwGaRCh1CFLb1Gz1Z2YFL07fFsyPeaqSfnBvUnjpifLdHF2x84p60
         1neyF2tiVZ/NPfSeeudQh+xZ99rgKnICYe1bBM2fCGL8W8JAXB2yMFMJBjT3JVzD4ve4
         0nK4TKOl22L89HWsw5oaTBw61tyPFjH1RtGq2duMUDdv4G3TXH8m1kgqI028xEQeX2Mm
         yOO7ZvEyZy/r8UbjAtIDCb/HlTrdIxQ8wmIhMyhZ86ma3mpTM9GR/D0t8YW6NC/aNHA4
         K0vw==
X-Forwarded-Encrypted: i=1; AJvYcCUcUq5Pn9h1GfeBbtk2hPxhgVYGR3tA6x88hLdzFWTUKvyMxG2tesVK40cNojVPgO5+RV1W78dI3JPnVPLG+RMm+wvjXjVqY+dXCMK7
X-Gm-Message-State: AOJu0Yx+ofhEEeL7+SaIuGyWNS5n959GrrjfYoVem+OgWKYxwwkow1gY
	duw8i848Ow0ZrrBIy13f8f4P0zz5JwY0bSNCgtWEGG7oVzpzZMAuUdPIAHtp8jRttP42yuqDlEe
	VrvA7riUd15e2KpdIZvmj4j7MJrZghykd2ITLPQ==
X-Google-Smtp-Source: AGHT+IHUGhcjxAU7b6t0hrvQi020b2arIFzB1nNlSVxcVIo/1yVCawLhV+YuT9lQoGaEmkbYJtbHnnDmtVVbUoulU8M=
X-Received: by 2002:a4a:ee97:0:b0:5ce:d2e3:b18 with SMTP id
 006d021491bc7-5da7c7214b8mr4159683eaf.8.1723687558915; Wed, 14 Aug 2024
 19:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723021820.87718-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240723021820.87718-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 15 Aug 2024 10:05:47 +0800
Message-ID: <CAEEQ3w=hsAEp8t+eH1GQW4M9ZY2TPXGUuhyNLB5DFEo88vwDZA@mail.gmail.com>
Subject: Re: [PATCH v3] riscv/mm/fault: add show_pte() before die()
To: conor@kernel.org, punit.agrawal@bytedance.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org, 
	surenb@google.com, peterx@redhat.com, alexghiti@rivosinc.com, 
	willy@infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

A gentle ping, Any more comments on this patch?

On Tue, Jul 23, 2024 at 10:18=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
>
> When the kernel displays "Unable to handle kernel paging request at
> virtual address", we would like to confirm the status of the virtual
> address in the page table. So add show_pte() before die().
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/mm/fault.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 5224f3733802..c72e6c7c09ef 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -22,6 +22,57 @@
>
>  #include "../kernel/head.h"
>
> +static void show_pte(unsigned long addr)
> +{
> +       pgd_t *pgdp, pgd;
> +       p4d_t *p4dp, p4d;
> +       pud_t *pudp, pud;
> +       pmd_t *pmdp, pmd;
> +       pte_t *ptep, pte;
> +       struct mm_struct *mm =3D current->mm;
> +
> +       if (!mm)
> +               mm =3D &init_mm;
> +
> +       pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=3D0=
x%016llx\n",
> +                current->comm, PAGE_SIZE / SZ_1K, VA_BITS,
> +                mm =3D=3D &init_mm ? (u64)__pa_symbol(mm->pgd) : virt_to=
_phys(mm->pgd));
> +
> +       pgdp =3D pgd_offset(mm, addr);
> +       pgd =3D pgdp_get(pgdp);
> +       pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
> +       if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
> +               goto out;
> +
> +       p4dp =3D p4d_offset(pgdp, addr);
> +       p4d =3D p4dp_get(p4dp);
> +       pr_cont(", p4d=3D%016lx", p4d_val(p4d));
> +       if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
> +               goto out;
> +
> +       pudp =3D pud_offset(p4dp, addr);
> +       pud =3D pudp_get(pudp);
> +       pr_cont(", pud=3D%016lx", pud_val(pud));
> +       if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
> +               goto out;
> +
> +       pmdp =3D pmd_offset(pudp, addr);
> +       pmd =3D pmdp_get(pmdp);
> +       pr_cont(", pmd=3D%016lx", pmd_val(pmd));
> +       if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
> +               goto out;
> +
> +       ptep =3D pte_offset_map(pmdp, addr);
> +       if (!ptep)
> +               goto out;
> +
> +       pte =3D ptep_get(ptep);
> +       pr_cont(", pte=3D%016lx", pte_val(pte));
> +       pte_unmap(ptep);
> +out:
> +       pr_cont("\n");
> +}
> +
>  static void die_kernel_fault(const char *msg, unsigned long addr,
>                 struct pt_regs *regs)
>  {
> @@ -31,6 +82,7 @@ static void die_kernel_fault(const char *msg, unsigned =
long addr,
>                 addr);
>
>         bust_spinlocks(0);
> +       show_pte(addr);
>         die(regs, "Oops");
>         make_task_dead(SIGKILL);
>  }
> --
> 2.39.2
>

Thanks,
Yunhui


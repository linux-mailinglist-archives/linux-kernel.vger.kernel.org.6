Return-Path: <linux-kernel+bounces-362023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B899B00B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B021B23110
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F214263;
	Sat, 12 Oct 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMIcQXZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C611BC3F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728699382; cv=none; b=cCbmKL9wssczx+6DzN2Ak4HGUj8eqpaC267bwKPiIT+9QZZxteBC/TVNRSwkxaKc1co28j6p1fifnYQBFDcs/CA2c+HJiO52Xt/4MOrql4huSUhVtGUS4Xa5fkOd714Ia8w5h6841DRtsUHWYtB2y6W40yMsmc3ie7Y+ZfzvC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728699382; c=relaxed/simple;
	bh=JUodbJ31pdXwG1oR2V7v0TetHTfgjIOpHojdVIma3iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibTbVrTcE8D+aFMJMiSiMV7kJLasz4hcb3cNVkO4QJhMyB9m9YlKdl0yUc2Pe+d8fnG5ibZKt5ZNKxQgqmKpi9CZBVIw4bZx8bM8yQoD1EqpiyVTdXydxG9faaIlPKZAoVKCQnfa1heFvYa+YYjgGMx6DVivG+CJw/ViOS2OaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMIcQXZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F0C4CECD
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728699381;
	bh=JUodbJ31pdXwG1oR2V7v0TetHTfgjIOpHojdVIma3iI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PMIcQXZXeQj5qtw0siETa1YY9ZgelydhQU6wpPqNjQ0Gt1Ivy9GYk+dv2G9F8o+TF
	 ybSrG9j44z2r8gNPBy+f50kZIcUU5Le1nf1aFDUb8zXCfvAMI6EawCY1YdtkZo4sq9
	 3KKPhgPlPzZju7MgGJQhawcYIz9wOlQ5zed6W+QTIEyJfB1hHBmGXpgC4p09JR1VtL
	 dX4F7RMaxyLmP/EC7n4LJXPEIWdhteYhIglD7UBkOrHGqQHFkwRCEawc88g6bAbCcY
	 5wf9fpgCd4mI3pL2M0nGntQSsGUnDKQ7gUaTe2/sJhk4xmm76AOON6Hyq6Bvt+Ftxp
	 GRtR5x+dWRmOA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso3366984a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:16:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqqnFkCH/VDDq+JJ0BAOsYfZbfL7ONP+vzjjPx3z8RJB9JobOzp5KwGEULzicXSgAFAo4/8uQmuHElh94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGyNp87G6YwO3GY70c1g4cS2aFaTDQbHv/8ZDqoxpfRH0tOXg
	6E7vReGwSgrHYnbiCdsU2Hb0yxZ8XNe4lMwGw4Dg+cgMZuU4E0HrzHxzWdsc4cOTcwiETA9geNC
	pmdaxrOHPbdAs19+AVEbkOhc0lL4=
X-Google-Smtp-Source: AGHT+IHuFRnnHrrgkM7pYwKUrgWiOtG7kV+p2T7XJp2djiBQ20CmZvBlI9kbC33qte/eEVLx+BBS1FsMPLaHGiB9gJA=
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a99b930e9d1mr358486566b.13.1728699380354; Fri, 11 Oct 2024
 19:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010035048.3422527-1-maobibo@loongson.cn> <20241010035048.3422527-5-maobibo@loongson.cn>
In-Reply-To: <20241010035048.3422527-5-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 12 Oct 2024 10:16:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5DvHcS+apFthMWNNqvvq+VMu--6bcuyGzdMz66K8Bd=g@mail.gmail.com>
Message-ID: <CAAhV-H5DvHcS+apFthMWNNqvvq+VMu--6bcuyGzdMz66K8Bd=g@mail.gmail.com>
Subject: Re: [PATCH 4/4] LoongArch: Use atomic operation with set_pte and
 pte_clear function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Oct 10, 2024 at 11:50=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> For kernel space area on LoongArch system, both two consecutive page
> table entries should be enabled with PAGE_GLOBAL bit. So with function
> set_pte() and pte_clear(), pte buddy entry is checked and set besides
> its own pte entry. However it is not atomic operation to set both two
> pte entries, there is problem with test_vmalloc test case.
>
> With previous patch, all page table entries are set with PAGE_GLOBAL
> bit at beginning. Only its own pte entry need update with function
> set_pte() and pte_clear(), nothing to do with buddy pte entry.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgtable.h | 44 ++++++++++------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 22e3a8f96213..4be3f0dbecda 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -325,40 +325,26 @@ extern void paging_init(void);
>  static inline void set_pte(pte_t *ptep, pte_t pteval)
>  {
>         WRITE_ONCE(*ptep, pteval);
> +}
>
> -       if (pte_val(pteval) & _PAGE_GLOBAL) {
> -               pte_t *buddy =3D ptep_buddy(ptep);
> -               /*
> -                * Make sure the buddy is global too (if it's !none,
> -                * it better already be global)
> -                */
> -               if (pte_none(ptep_get(buddy))) {
> -#ifdef CONFIG_SMP
> -                       /*
> -                        * For SMP, multiple CPUs can race, so we need
> -                        * to do this atomically.
> -                        */
> -                       __asm__ __volatile__(
> -                       __AMOR "$zero, %[global], %[buddy] \n"
> -                       : [buddy] "+ZB" (buddy->pte)
> -                       : [global] "r" (_PAGE_GLOBAL)
> -                       : "memory");
> -
> -                       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> -#else /* !CONFIG_SMP */
> -                       WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(buddy))=
 | _PAGE_GLOBAL));
> -#endif /* CONFIG_SMP */
> -               }
> -       }
> +static inline unsigned long __ptep_get_and_clear(pte_t *ptep)
> +{
> +       return atomic64_fetch_and(_PAGE_GLOBAL, (atomic64_t *)&pte_val(*p=
tep));
>  }
>
>  static inline void pte_clear(struct mm_struct *mm, unsigned long addr, p=
te_t *ptep)
>  {
> -       /* Preserve global status for the pair */
> -       if (pte_val(ptep_get(ptep_buddy(ptep))) & _PAGE_GLOBAL)
> -               set_pte(ptep, __pte(_PAGE_GLOBAL));
> -       else
> -               set_pte(ptep, __pte(0));
> +       __ptep_get_and_clear(ptep);
With the first patch, a kernel pte always take _PAGE_GLOBAL, so we
don't need an expensive atomic operation, just
"set_pte(pte_val(ptep_get(ptep)) & _PAGE_GLOBAL)" is OK here. And then
we don't need a custom ptep_get_and_clear().


Huacai

> +}
> +
> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
> +static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> +                                       unsigned long addr, pte_t *ptep)
> +{
> +       unsigned long val;
> +
> +       val =3D __ptep_get_and_clear(ptep);
> +       return __pte(val);
>  }
>
>  #define PGD_T_LOG2     (__builtin_ffs(sizeof(pgd_t)) - 1)
> --
> 2.39.3
>


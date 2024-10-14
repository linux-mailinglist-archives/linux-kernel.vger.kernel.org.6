Return-Path: <linux-kernel+bounces-363289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C9499C00F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F321C21955
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E124A145B1B;
	Mon, 14 Oct 2024 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inT2a268"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A65588E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887617; cv=none; b=RKKJATadIi+3RxNrpUHJEYr3LncLDso9ug7YRyZldrvU2IpQ7N5ip47MdS0dtSUIUUxIcc+Nb6+Ln5a1mzWrE55Q6zQSQVNtjfLKEt4sMQ7fQB89Ae9W06c2syj0PtNUEetithpA10DKKJbRzdPcyhHX5pXf85tJaDSWoHJvvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887617; c=relaxed/simple;
	bh=1vFIJKT9gpEeD+/OKW1YiSfLCdrShPFpH5UoS6vW8VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSypeYE4xjfNYiMH1B1G+F6vPizydVG01e0wTIFyJ1UgB6L9CXITsrnQsGjHS8UeTt3tB/+NjF7/n1OuaFxB0XqMAa7G38s37qQe0wV/oaKFAkUPKZpdJCgfNxChyHVNy7tTL3OatmhD1DfPXrbbACSYTKfkFLStjbhc3ePsAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inT2a268; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD17C4CEC3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728887616;
	bh=1vFIJKT9gpEeD+/OKW1YiSfLCdrShPFpH5UoS6vW8VU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=inT2a2682JG1bWQrfgQodr9TTrAksApY4Za0ZtA4CXwtkC7P0SBrQz3pmvzxddajk
	 BeSLzkg07RJZDkityEtwBVB369EBv7oDHCRc2+DTglCgAV4UZdDf5yY8YIsRiZQfog
	 6IfbXxcQUktY/ju2EMMMTDZOkHej5w1GlE/uHeI2iR2rAQM1I7w7xqJ0odqewJ+FIV
	 CwmxZ3IEe6802+DYvWbCyP72Pv5Qp62Pq/NErkm4mTvG0+5wKSDDRFVbdV/owc7h/2
	 +k4m/4iwrO978JJTii5qLSBma7AjE52mDlxzbrSDFqGmxXsMYEtu2uXn91282jrWn2
	 NDH7z7sN8X4dw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9952ea05c5so605413166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:33:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIzzcuA4BbHK9VfqcDSegb/nuzBa3yo9avsb8OKyj9YHYmwrRK64UquWs5ewni5OUJQ1ajiJzgXrXBoUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrkyChO8+qGDZxF9CBZEiRLBGzMieE0oc0mfNxmQpSzhco+gU
	l0bnfUTBrwM3N7TxOjM0aed1lZ3WIN9Q9DBYICIbkzQk9W+wSgBK80IjDh1mBkWxYRTm9FUfMkM
	t7Od2gKdeKHoqhTUp+3deLZ1/9Mc=
X-Google-Smtp-Source: AGHT+IGZ/pvSEGOj2aDr3UCuPoEvLIEwFDanfdCCKGheVeO9c+rk7OR+rdL3ExZXprAgiHJej2PQMPfVqYcxsuOXJPo=
X-Received: by 2002:a17:907:368d:b0:a99:5466:2556 with SMTP id
 a640c23a62f3a-a99b966b636mr1020625266b.61.1728887615477; Sun, 13 Oct 2024
 23:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014035855.1119220-1-maobibo@loongson.cn> <20241014035855.1119220-4-maobibo@loongson.cn>
In-Reply-To: <20241014035855.1119220-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 14 Oct 2024 14:33:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4-OQ4rmyztsRVsOuPra7xbzy9vcckerP8NG-7ti8jKwg@mail.gmail.com>
Message-ID: <CAAhV-H4-OQ4rmyztsRVsOuPra7xbzy9vcckerP8NG-7ti8jKwg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] LoongArch: Remove pte buddy set with set_pte and
 pte_clear function
To: Bibo Mao <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

The old code tries to fix the same problem in the first patch, so this
patch can also be squashed to the first one (and it is small enough
now).

Others look good to me.

Huacai

On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> For kernel address space area on LoongArch system, both two consecutive
> page table entries should be enabled with PAGE_GLOBAL bit. So with
> function set_pte() and pte_clear(), pte buddy entry is checked and set
> besides its own pte entry. However it is not atomic operation to set both
> two pte entries, there is problem with test_vmalloc test case.
>
> With previous patch, all page table entries are set with PAGE_GLOBAL
> bit at beginning. Only its own pte entry need update with function
> set_pte() and pte_clear(), nothing to do with pte buddy entry.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgtable.h | 35 ++++------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 22e3a8f96213..bc29c95b1710 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -325,40 +325,15 @@ extern void paging_init(void);
>  static inline void set_pte(pte_t *ptep, pte_t pteval)
>  {
>         WRITE_ONCE(*ptep, pteval);
> -
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
> +       pte_t pte;
> +
> +       pte =3D ptep_get(ptep);
> +       pte_val(pte) &=3D _PAGE_GLOBAL;
> +       set_pte(ptep, pte);
>  }
>
>  #define PGD_T_LOG2     (__builtin_ffs(sizeof(pgd_t)) - 1)
> --
> 2.39.3
>
>


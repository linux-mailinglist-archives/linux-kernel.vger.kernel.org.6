Return-Path: <linux-kernel+bounces-362022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D099B00A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904822836FE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82568101DE;
	Sat, 12 Oct 2024 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4N5svc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAE17BA3
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728699375; cv=none; b=mOVEcQFs3nK92KAg5AQkmw8I4oAxRKRhR34SUujBND4o2MBkU8Es74+mZxvCpPcGUW5PtxAOVTSCTpGfMvpbAKtozxoI3oN7EfGaC2OuJzg4/Gsg93LzUWtHBU9Bu5OhFQ2ecGjdGllVo9OMSlLvU5OaIpZ/oMYdrHqBYcy+toE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728699375; c=relaxed/simple;
	bh=fs2ex6Myrxn/BuLSkwmMzK6WA09iYO2UwtMXj00+gJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYt3MxFErx5njjej8mAaQLEAoeK2/zwLjrTJTIf19+IodMve7zHeg3MxpanWG75nRJp1NNGpUbdysojkoQPykqsb1u3HiOBqFLbroBnGsfShajEwqGPZJUV8hK3xVE1wS2ZVVs/HvKsU/YMfW5AlgO1NpCgLGeaKAJ9Tj+ypV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4N5svc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECD9C4CECF
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728699374;
	bh=fs2ex6Myrxn/BuLSkwmMzK6WA09iYO2UwtMXj00+gJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p4N5svc+7DSQ0ui/6lqj5oaOmjFVcC+Jla40/uz5HNxGxk3rFMKScieFbB0A3JOHH
	 LWJem7qP3V0T6+1EvegejI4FnngIM/O/CAApD552ycafQGXJKVdlcxUUKFJwNRDfo3
	 kE8250XTJabddZVLaecNaK2F5gk5DdB6G97AznwRkGTSzUNX6HvKoTGmp93TzCiedF
	 BTiaDqtykdRLNsinAHKaIvH1do9+EIad5tQBrzAgaCfHB6uw/VlqTCHPkYtbEHl4cg
	 hlNwUgZSxzCclTJXBP/gmKPC1Tg3SIxIfxQE3JJVrzWi6OzRRw4rYMUSxVetksjZSj
	 07Y7wTWY0c8yA==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso25375495e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:16:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDLTrWaYgdd23zRN5gjG5FMhgVwboDA2lKgDlXOFE9mK3UGu4wSmKRNOVj1pnrCNomnzuYcShhRcZ6R0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9s3DnCY0SteUxcTRCoFBbxj3zFd4JSKDXWeejTmoNX7t0kMgY
	7mCez0AFiJdv57/5NbMzLYrUKKXuLdQ6K1kPrnAcUg7HTtZww/n8RNbTOAT2wQkSzT1nSMZ+kFe
	KagMKGdEpFD9mw6Q4ORNemzC6AjY=
X-Google-Smtp-Source: AGHT+IEc1OUAjleT+os4xzcRNciedjusj82RHLgnziGR9iE7/CnrYGfrNpINEnlEOpvTmH4FpI8KZyHmfCDrMrUFysE=
X-Received: by 2002:adf:9bd2:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-37d5ff5a4cemr1208845f8f.18.1728699373163; Fri, 11 Oct 2024
 19:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010035048.3422527-1-maobibo@loongson.cn> <20241010035048.3422527-4-maobibo@loongson.cn>
In-Reply-To: <20241010035048.3422527-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 12 Oct 2024 10:16:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6OR_HYSF451vSk_qSt1a6froSPZKY-=YSRBQgww5a+0A@mail.gmail.com>
Message-ID: <CAAhV-H6OR_HYSF451vSk_qSt1a6froSPZKY-=YSRBQgww5a+0A@mail.gmail.com>
Subject: Re: [PATCH 3/4] LoongArch: Add barrier between set_pte and memory access
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
> It is possible to return a spurious fault if memory is accessed
> right after the pte is set. For user address space, pte is set
> in kernel space and memory is accessed in user space, there is
> long time for synchronization, no barrier needed. However for
> kernel address space, it is possible that memory is accessed
> right after the pte is set.
>
> Here flush_cache_vmap/flush_cache_vmap_early is used for
> synchronization.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/cacheflush.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/inc=
lude/asm/cacheflush.h
> index f8754d08a31a..53be231319ef 100644
> --- a/arch/loongarch/include/asm/cacheflush.h
> +++ b/arch/loongarch/include/asm/cacheflush.h
> @@ -42,12 +42,24 @@ void local_flush_icache_range(unsigned long start, un=
signed long end);
>  #define flush_cache_dup_mm(mm)                         do { } while (0)
>  #define flush_cache_range(vma, start, end)             do { } while (0)
>  #define flush_cache_page(vma, vmaddr, pfn)             do { } while (0)
> -#define flush_cache_vmap(start, end)                   do { } while (0)
>  #define flush_cache_vunmap(start, end)                 do { } while (0)
>  #define flush_icache_user_page(vma, page, addr, len)   do { } while (0)
>  #define flush_dcache_mmap_lock(mapping)                        do { } wh=
ile (0)
>  #define flush_dcache_mmap_unlock(mapping)              do { } while (0)
>
> +/*
> + * It is possible for a kernel virtual mapping access to return a spurio=
us
> + * fault if it's accessed right after the pte is set. The page fault han=
dler
> + * does not expect this type of fault. flush_cache_vmap is not exactly t=
he
> + * right place to put this, but it seems to work well enough.
> + */
> +static inline void flush_cache_vmap(unsigned long start, unsigned long e=
nd)
> +{
> +       smp_mb();
> +}
I don't know whether this is the best API to do this, and I think
flush_cache_vunmap() also should be a smp_mb().


Huacai

> +#define flush_cache_vmap flush_cache_vmap
> +#define flush_cache_vmap_early flush_cache_vmap
> +
>  #define cache_op(op, addr)                                             \
>         __asm__ __volatile__(                                           \
>         "       cacop   %0, %1                                  \n"     \
> --
> 2.39.3
>


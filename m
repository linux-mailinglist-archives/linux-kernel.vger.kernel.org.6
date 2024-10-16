Return-Path: <linux-kernel+bounces-367455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E09A029B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE391F23B27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A71C3038;
	Wed, 16 Oct 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwGflVpJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109091B85EC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063848; cv=none; b=UL7jDPEsU7vOqmRddpQEsrSserEMMQ1wGZyWMm9P00uP7bkXCZVAX0d4LisxF0a5H5VpYWJIkEq7w/QCKZ032XV6SXEVL58ivogLuzyEYcqlYp+MJgP8Q7vAxrbnnvPsLs4I4PruJpfxsI7jSoRD6R5b1PaGhf76grBmEmsYaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063848; c=relaxed/simple;
	bh=BiGEJtQfZvYa4sIn+ELPpiWdnPMj6XIZ6gDNFCL2g7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nyt65lb85o8NEPDG803XCEG+rkaHD/Hpa+jahrNVcNgDA9abM3jZvqNRezeNvcvnFR3PK/idRDX66jfBnecT0s8ixaDe/HbhCx2RhPO8B5VDX6Bj62pZNPqzCAGnURChrgG6x+xlxV5RS1HUVF7WpqONbXuJtAFsDPIaYpkjajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwGflVpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B757C4CED2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729063847;
	bh=BiGEJtQfZvYa4sIn+ELPpiWdnPMj6XIZ6gDNFCL2g7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CwGflVpJh7LdN4I9Xl1gO9GtAJ5sp/Pj1wWtRWj7AZTJYOMBiJ7hI7Gfs0OezN/s+
	 5eVdehTpV2kEIcdASKxhe0En5amuWbF33nVlKx1OPj2hAjHSH5fgOxdtaPmJaZKcHx
	 QKLhexut+hS98/UIPBKZNOWnlrHCkgbQFKeUb/wJhfYsqV2kGJmLHli9F/G1UTxok1
	 cpRHSwO1u5hAizGJeoTjVdXj2C+gBjT7Skz+qXqBoApopamoYqPu7/CqLq1SI+VAaS
	 uBAEpM77Ft7SeUElZMfTdtCNfFXeDxiTw7wZtC7QVa4yrCkvoMckE2v/miyicXQ9oq
	 ZMYpA5mmsg3QA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so4269136a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:30:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4ubz3AZkw2WBQxffiv9l2Faf5LQQqzVkbDz7n/FNq9UdXw9esTTzgkEcASmtuHImnoGCAXRHEsmm+hyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1sUdNuxHfc5Xw1a33WCJlktz8TPz/fc0HAfKYyu+eueHq97w
	Kwe12ioj1wANjeITMZI7V7zO1dPcWDvimz9IMqJ+P/lEX0mUP0m2yMjglITihUaLahQBCOXVzXk
	3zfVFoX4x+V42ggEXnvULdiurxGk=
X-Google-Smtp-Source: AGHT+IGGgI/RALmibbLHEgiBVUT9M21MDnSkFq4Au5DeP01Xn6lKa0uHZWLkvAovFIylEUT/MwPrEjLDn03ZvFDfMUs=
X-Received: by 2002:a17:907:848:b0:a99:3318:e7c3 with SMTP id
 a640c23a62f3a-a99e3e4c294mr1543126666b.43.1729063846118; Wed, 16 Oct 2024
 00:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014035855.1119220-1-maobibo@loongson.cn> <20241014035855.1119220-3-maobibo@loongson.cn>
 <CAAhV-H6nkiw_eOS3jFdojJsCJOA2yiprQmaT5c=SnPhJTOyKkQ@mail.gmail.com>
 <e7c06bf4-897a-7060-61f9-97435d2af16e@loongson.cn> <CAAhV-H6H=Q=1KN5q8kR3j55Ky--FRNifCT93axhqE=vNMArDaQ@mail.gmail.com>
 <1b4070c9-921e-65e3-c2a7-dab486d4f17f@loongson.cn>
In-Reply-To: <1b4070c9-921e-65e3-c2a7-dab486d4f17f@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 16 Oct 2024 15:30:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5fx14iUM_5e36sO-kd8VWpFLG_Qmi5JUHKiPRqrPQsoA@mail.gmail.com>
Message-ID: <CAAhV-H5fx14iUM_5e36sO-kd8VWpFLG_Qmi5JUHKiPRqrPQsoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] LoongArch: Add barrier between set_pte and memory access
To: maobibo <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:09=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2024/10/15 =E4=B8=8B=E5=8D=888:27, Huacai Chen wrote:
> > On Tue, Oct 15, 2024 at 10:54=E2=80=AFAM maobibo <maobibo@loongson.cn> =
wrote:
> >>
> >>
> >>
> >> On 2024/10/14 =E4=B8=8B=E5=8D=882:31, Huacai Chen wrote:
> >>> Hi, Bibo,
> >>>
> >>> On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loongson.c=
n> wrote:
> >>>>
> >>>> It is possible to return a spurious fault if memory is accessed
> >>>> right after the pte is set. For user address space, pte is set
> >>>> in kernel space and memory is accessed in user space, there is
> >>>> long time for synchronization, no barrier needed. However for
> >>>> kernel address space, it is possible that memory is accessed
> >>>> right after the pte is set.
> >>>>
> >>>> Here flush_cache_vmap/flush_cache_vmap_early is used for
> >>>> synchronization.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>    arch/loongarch/include/asm/cacheflush.h | 14 +++++++++++++-
> >>>>    1 file changed, 13 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarc=
h/include/asm/cacheflush.h
> >>>> index f8754d08a31a..53be231319ef 100644
> >>>> --- a/arch/loongarch/include/asm/cacheflush.h
> >>>> +++ b/arch/loongarch/include/asm/cacheflush.h
> >>>> @@ -42,12 +42,24 @@ void local_flush_icache_range(unsigned long star=
t, unsigned long end);
> >>>>    #define flush_cache_dup_mm(mm)                         do { } whi=
le (0)
> >>>>    #define flush_cache_range(vma, start, end)             do { } whi=
le (0)
> >>>>    #define flush_cache_page(vma, vmaddr, pfn)             do { } whi=
le (0)
> >>>> -#define flush_cache_vmap(start, end)                   do { } while=
 (0)
> >>>>    #define flush_cache_vunmap(start, end)                 do { } whi=
le (0)
> >>>>    #define flush_icache_user_page(vma, page, addr, len)   do { } whi=
le (0)
> >>>>    #define flush_dcache_mmap_lock(mapping)                        do=
 { } while (0)
> >>>>    #define flush_dcache_mmap_unlock(mapping)              do { } whi=
le (0)
> >>>>
> >>>> +/*
> >>>> + * It is possible for a kernel virtual mapping access to return a s=
purious
> >>>> + * fault if it's accessed right after the pte is set. The page faul=
t handler
> >>>> + * does not expect this type of fault. flush_cache_vmap is not exac=
tly the
> >>>> + * right place to put this, but it seems to work well enough.
> >>>> + */
> >>>> +static inline void flush_cache_vmap(unsigned long start, unsigned l=
ong end)
> >>>> +{
> >>>> +       smp_mb();
> >>>> +}
> >>>> +#define flush_cache_vmap flush_cache_vmap
> >>>> +#define flush_cache_vmap_early flush_cache_vmap
> >>>   From the history of flush_cache_vmap_early(), It seems only archs w=
ith
> >>> "virtual cache" (VIVT or VIPT) need this API, so LoongArch can be a
> >>> no-op here.
> > OK,  flush_cache_vmap_early() also needs smp_mb().
> >
> >>
> >> Here is usage about flush_cache_vmap_early in file linux/mm/percpu.c,
> >> map the page and access it immediately. Do you think it should be noop
> >> on LoongArch.
> >>
> >> rc =3D __pcpu_map_pages(unit_addr, &pages[unit * unit_pages],
> >>                                        unit_pages);
> >> if (rc < 0)
> >>       panic("failed to map percpu area, err=3D%d\n", rc);
> >>       flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
> >>       /* copy static data */
> >>       memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
> >> }
> >>
> >>
> >>>
> >>> And I still think flush_cache_vunmap() should be a smp_mb(). A
> >>> smp_mb() in flush_cache_vmap() prevents subsequent accesses be
> >>> reordered before pte_set(), and a smp_mb() in flush_cache_vunmap()
> >> smp_mb() in flush_cache_vmap() does not prevent reorder. It is to flus=
h
> >> pipeline and let page table walker HW sync with data cache.
> >>
> >> For the following example.
> >>     rb =3D vmap(pages, nr_meta_pages + 2 * nr_data_pages,
> >>                     VM_MAP | VM_USERMAP, PAGE_KERNEL);
> >>     if (rb) {
> >> <<<<<<<<<<< * the sentence if (rb) can prevent reorder. Otherwise with
> >> any API kmalloc/vmap/vmalloc and subsequent memory access, there will =
be
> >> reorder issu. *
> >>         kmemleak_not_leak(pages);
> >>         rb->pages =3D pages;
> >>         rb->nr_pages =3D nr_pages;
> >>         return rb;
> >>     }
> >>
> >>> prevents preceding accesses be reordered after pte_clear(). This
> >> Can you give an example about such usage about flush_cache_vunmap()? a=
nd
> >> we can continue to talk about it, else it is just guessing.
> > Since we cannot reach a consensus, and the flush_cache_* API look very
> > strange for this purpose (Yes, I know PowerPC does it like this, but
> > ARM64 doesn't). I prefer to still use the ARM64 method which means add
> > a dbar in set_pte(). Of course the performance will be a little worse,
> > but still better than the old version, and it is more robust.
> >
> > I know you are very busy, so if you have no time you don't need to
> > send V3, I can just do a small modification on the 3rd patch.
> No, I will send V3 by myself. And I will drop the this patch in this
> patchset since by actual test vmalloc_test works well even without this
> patch on 3C5000 Dual-way, also weak function kernel_pte_init will be
> replaced with inline function rebased on
>
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patc=
hes/mm-define-general-function-pxd_init.patch
This patch is in Andrew's mm-unstable branch. As far I know,
mm-unstable is for next (6.13) and mm-stable is for current (6.12).

But this series is bugfix, so it is for current (6.12).

>
> I dislike the copy-paste method without further understanding :(,
> although I also copy and paste code, but as least I try best to
> understand it.

I dislike too. But in order to make this series be in 6.12, it is
better to keep copy-paste, and then update the refactoring patch to V2
for Andrew (rebase and drop is normal for mm-unstable).


Huacai

>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>> potential problem may not be seen from experiment, but it is needed i=
n
> >>> theory.
> >>>
> >>> Huacai
> >>>
> >>>> +
> >>>>    #define cache_op(op, addr)                                       =
      \
> >>>>           __asm__ __volatile__(                                     =
      \
> >>>>           "       cacop   %0, %1                                  \n=
"     \
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>>
> >>
> >>
>


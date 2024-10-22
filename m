Return-Path: <linux-kernel+bounces-375424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FAF9A95C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3943C284566
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6512E1CA;
	Tue, 22 Oct 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7oXHInr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B012C549
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562218; cv=none; b=gAtQpt8c41G6Mwz7aa5vLkXqUVlhdo22kjjF9vV9+9OCAdaUL9cTMevUiJe+L/Rqz8EaOcYL4HSeXjOtTNn98AHIjMf05QeBL82TVLdXWf0g9FGP3IrqBUu1WtNZQi+O2E/nXhsfh2sfmz9Y+K9MKn/cey52BybNyeZnUYBSKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562218; c=relaxed/simple;
	bh=pAyOeLUxoK7wVi2gugpZLA4wR3HLIaNJyLzayk2c9aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow8p6wsOI7sACmIwytAsEaYmYxxdVXQ7BfdpIjCIo1kopcQsgUEtbiLLl5cSmRJ7j36xY9o73eO3w2d+VR+tcPdYvzmWLctZWNbP5luFsv0p3Y8W0gB3JLI2FTHwS+PMaOf5SZWyLS3jOTQR/k44VYkIuYgIzzwlDiPFQ0qTqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7oXHInr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B58C4CEEB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729562218;
	bh=pAyOeLUxoK7wVi2gugpZLA4wR3HLIaNJyLzayk2c9aU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q7oXHInrW2VW/3LLq+OeXc2OJnY18OJc/LppuuBrnzNE+xF/8aNffYYWznJLsvVh4
	 iitYgy8hTcJe7VbuFILs+lSEHle5mEqC3Kylrwq8UXzHlkh2NCrwApX0GipxJsDOTJ
	 +v/NRIPP341JCA/ycShHBdeGQa23Th8gAbqwrV5RYq+yL7wbbOw2r4+t+BflLoaz9T
	 uvU5+Xccxf25/JxSn4CqwYFn4sbwUYbqB3NPoDfuBrMvDDk939nt1bDI+FiccWsI5y
	 1Kz1ljWx/AqasqRpV4rF1lp2UqWgnYvAOlDe0opnTmROfPErFTaq9+RPp6qdfX+vEW
	 fS8bPHSIldznA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa086b077so595933366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:56:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJwZ9VA88PHYHmPv6YOy++SHfMmQT6Ji8QGrhVzG3xgII4uQTRyQTJCZVt9CZS8ZUhJ14RneZdL3+yVPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEvsYW4zXDfG7iuMLOaEv1R+8yw6lfpT8B1y97goRd0j4NI0u
	IAnv97iLihUT+o1vtL6Re4POnDx7/DHJoA4eW2iizGrnW3KFmT/SbaA9ZvYD4LDF+Anvcf7n4/g
	pnLsUKN6y1ITwhaxSvbp5dtmndxs=
X-Google-Smtp-Source: AGHT+IFOD80K2Ho/zsnScckqxvtq+Ni45RwySW5JX7WS3Su5ejurpJyL8TJXakEnJgakOpzjVXeWsxe50rvnwOPlRnk=
X-Received: by 2002:a17:907:a4a:b0:a9a:5a14:b8d8 with SMTP id
 a640c23a62f3a-a9aa8a05ebcmr185074666b.43.1729562216407; Mon, 21 Oct 2024
 18:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014035855.1119220-1-maobibo@loongson.cn> <20241014035855.1119220-2-maobibo@loongson.cn>
 <CAAhV-H5QkULWp6fciR1Lnds0r00fUdrmj86K_wBuxd0D=RkaXQ@mail.gmail.com>
 <f3089991-fd49-8d55-9ede-62ab1555c9fa@loongson.cn> <CAAhV-H7yX6qinPL5E5tmNVpJk_xdKqFaSicUYy2k8NGM1owucw@mail.gmail.com>
 <a4c6b89e-4ffe-4486-4ccd-7ebc28734f6f@loongson.cn> <CAAhV-H6FkJZwa-pALUhucrU5OXxsHg+ByM+4NN0wPQgOJTqOXA@mail.gmail.com>
 <5f76ede6-e8be-c7a9-f957-479afa2fb828@loongson.cn> <CAAhV-H51W3ZRNxUjeAx52j6Tq18CEhB3_YeSH=psjAbEJUdwgg@mail.gmail.com>
 <f727e384-6989-0942-1cc8-7188f558ee39@loongson.cn> <CAAhV-H5CADad2EGv0zMQrgrvpNRtBTWDoXFj=j+zXEJdy7HkAQ@mail.gmail.com>
 <33d6cb6b-834b-f9b8-df28-b15243994f9b@loongson.cn>
In-Reply-To: <33d6cb6b-834b-f9b8-df28-b15243994f9b@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 22 Oct 2024 09:56:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6gis1oSYUQJ3BzQL1qafPBj_nbBNq8arAxEJvJG7S6aQ@mail.gmail.com>
Message-ID: <CAAhV-H6gis1oSYUQJ3BzQL1qafPBj_nbBNq8arAxEJvJG7S6aQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LoongArch: Set initial pte entry with PAGE_GLOBAL
 for kernel space
To: maobibo <maobibo@loongson.cn>
Cc: wuruiyang@loongson.cn, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:40=E2=80=AFAM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2024/10/21 =E4=B8=8B=E5=8D=886:13, Huacai Chen wrote:
> > On Mon, Oct 21, 2024 at 9:23=E2=80=AFAM maobibo <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2024/10/18 =E4=B8=8B=E5=8D=882:32, Huacai Chen wrote:
> >>> On Fri, Oct 18, 2024 at 2:23=E2=80=AFPM maobibo <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/10/18 =E4=B8=8B=E5=8D=8812:23, Huacai Chen wrote:
> >>>>> On Fri, Oct 18, 2024 at 12:16=E2=80=AFPM maobibo <maobibo@loongson.=
cn> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2024/10/18 =E4=B8=8B=E5=8D=8812:11, Huacai Chen wrote:
> >>>>>>> On Fri, Oct 18, 2024 at 11:44=E2=80=AFAM maobibo <maobibo@loongso=
n.cn> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 2024/10/18 =E4=B8=8A=E5=8D=8811:14, Huacai Chen wrote:
> >>>>>>>>> Hi, Bibo,
> >>>>>>>>>
> >>>>>>>>> I applied this patch but drop the part of arch/loongarch/mm/kas=
an_init.c:
> >>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linu=
x-loongson.git/commit/?h=3Dloongarch-next&id=3D15832255e84494853f543b4c70ce=
d50afc403067
> >>>>>>>>>
> >>>>>>>>> Because kernel_pte_init() should operate on page-table pages, n=
ot on
> >>>>>>>>> data pages. You have already handle page-table page in
> >>>>>>>>> mm/kasan/init.c, and if we don't drop the modification on data =
pages
> >>>>>>>>> in arch/loongarch/mm/kasan_init.c, the kernel fail to boot if K=
ASAN is
> >>>>>>>>> enabled.
> >>>>>>>>>
> >>>>>>>> static inline void set_pte(pte_t *ptep, pte_t pteval)
> >>>>>>>>       {
> >>>>>>>>             WRITE_ONCE(*ptep, pteval);
> >>>>>>>> -
> >>>>>>>> -       if (pte_val(pteval) & _PAGE_GLOBAL) {
> >>>>>>>> -               pte_t *buddy =3D ptep_buddy(ptep);
> >>>>>>>> -               /*
> >>>>>>>> -                * Make sure the buddy is global too (if it's !n=
one,
> >>>>>>>> -                * it better already be global)
> >>>>>>>> -                */
> >>>>>>>> -               if (pte_none(ptep_get(buddy))) {
> >>>>>>>> -#ifdef CONFIG_SMP
> >>>>>>>> -                       /*
> >>>>>>>> -                        * For SMP, multiple CPUs can race, so w=
e need
> >>>>>>>> -                        * to do this atomically.
> >>>>>>>> -                        */
> >>>>>>>> -                       __asm__ __volatile__(
> >>>>>>>> -                       __AMOR "$zero, %[global], %[buddy] \n"
> >>>>>>>> -                       : [buddy] "+ZB" (buddy->pte)
> >>>>>>>> -                       : [global] "r" (_PAGE_GLOBAL)
> >>>>>>>> -                       : "memory");
> >>>>>>>> -
> >>>>>>>> -                       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> >>>>>>>> -#else /* !CONFIG_SMP */
> >>>>>>>> -                       WRITE_ONCE(*buddy, __pte(pte_val(ptep_ge=
t(buddy)) | _PAGE_GLOBAL));
> >>>>>>>> -#endif /* CONFIG_SMP */
> >>>>>>>> -               }
> >>>>>>>> -       }
> >>>>>>>> +       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> >>>>>>>>       }
> >>>>>>>>
> >>>>>>>> No, please hold on. This issue exists about twenty years, Do we =
need be
> >>>>>>>> in such a hurry now?
> >>>>>>>>
> >>>>>>>> why is DBAR(0b11000) added in set_pte()?
> >>>>>>> It exists before, not added by this patch. The reason is explaine=
d in
> >>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?h=3Dv6.12-rc3&id=3Df93f67d06b1023313ef1662eac490e29c025c030
> >>>>>> why speculative accesses may cause spurious page fault in kernel s=
pace
> >>>>>> with PTE enabled?  speculative accesses exists anywhere, it does n=
ot
> >>>>>> cause spurious page fault.
> >>>>> Confirmed by Ruiyang Wu, and even if DBAR(0b11000) is wrong, that
> >>>>> means another patch's mistake, not this one. This one just keeps th=
e
> >>>>> old behavior.
> >>>>> +CC Ruiyang Wu here.
> >>>> Also from Ruiyang Wu, the information is that speculative accesses m=
ay
> >>>> insert stale TLB, however no page fault exception.
> >>>>
> >>>> So adding barrier in set_pte() does not prevent speculative accesses=
.
> >>>> And you write patch here, however do not know the actual reason?
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?h=3Dv6.12-rc3&id=3Df93f67d06b1023313ef1662eac490e29c025c030
> >>> I have CCed Ruiyang, whether the description is correct can be judged=
 by him.
> >>
> >> There are some problems to add barrier() in set_pte():
> >>
> >> 1. There is such issue only for HW ptw enabled and kernel address spac=
e,
> >> is that? Also it may be two heavy to add barrier in set_pte(), compari=
ng
> >> to do this in flush_cache_vmap().
> > So adding a barrier in set_pte() may not be the best solution for
> > performance, but you cannot say it is a wrong solution. And yes, we
> > can only care the kernel space, which is also the old behavior before
> > this patch, so set_pte() should be:
> >
> > static inline void set_pte(pte_t *ptep, pte_t pteval)
> > {
> >          WRITE_ONCE(*ptep, pteval);
> > #ifdef CONFIG_SMP
> >          if (pte_val(pteval) & _PAGE_GLOBAL)
> cpu_has_ptw seems also need here, if it is only for hw page walk.
> >                  DBAR(0b11000); /* o_wrw =3D 0b11000 */
> > #endif
> > }
> >
> > Putting a dbar unconditionally in set_pte() is my mistake, I'm sorry fo=
r  that.
> >
> >>
> >> 2. LoongArch is different with other other architectures, two pages ar=
e
> >> included in one TLB entry. If there is two consecutive page mapped and
> >> memory access, there will page fault for the second memory access. Suc=
h
> >> as:
> >>      addr1 =3Dpercpu_alloc(pagesize);
> >>      val1 =3D *(int *)addr1;
> >>        // With page table walk, addr1 is present and addr2 is pte_none
> >>        // TLB entry includes valid pte for addr1, invalid pte for addr=
2
> >>      addr2 =3Dpercpu_alloc(pagesize); // will not flush tlb in first t=
ime
> >>      val2 =3D *(int *)addr2;
> >>        // With page table walk, addr1 is present and addr2 is present =
also
> >>        // TLB entry includes valid pte for addr1, invalid pte for addr=
2
> >>      So there will be page fault when accessing address addr2
> >>
> >> There there is the same problem with user address space. By the way,
> >> there is HW prefetching technology, negative effective of HW prefetchi=
ng
> >> technology will be tlb added. So there is potential page fault if memo=
ry
> >> is allocated and accessed in the first time.
> > As discussed internally, there may be three problems related to
> > speculative access in detail: 1) a load/store after set_pte() is
> > prioritized before, which can be prevented by dbar, 2) a instruction
> > fetch after set_pte() is prioritized before, which can be prevented by
> > ibar, 3) the buddy tlb problem you described here, if I understand
> > Ruiyang's explanation correctly this can only be prevented by the
> > filter in do_page_fault().
> >
> >  From experiments, without the patch "LoongArch: Improve hardware page
> > table walker", there are about 80 times of spurious page faults during
> > boot, and increases continually during stress tests. And after that
> > patch which adds a dbar to set_pte(), we cannot observe spurious page
> > faults anymore. Of course this doesn't mean 2) and 3) don't exist, but
> Good experiment result. Could you share me code about page fault
> counting and test cases?
Counting method:
1, Add a simple printk at the beginning of spurious_fault(), and count
the number of printk from dmesg.
2, Test case: boot Fedora to desktop, and then run kernel building
work with "make -j8" in the system.

Huacai

>
> > we can at least say 1) is the main case. On this basis, in "LoongArch:
> > Improve hardware page table walker" we use a relatively cheap dbar
> > (compared to ibar) to prevent the main case, and add a filter to
> > handle 2) and 3). Such a solution is reasonable.
> >
> >
> >>
> >> 3. For speculative execution, if it is user address, there is eret fro=
m
> >> syscall. eret will rollback all speculative execution instruction. So =
it
> >> is only problem for speculative execution. And how to verify whether i=
t
> >> is the problem of speculative execution or it is the problem of clause=
 2?
> > As described above, if spurious page faults still exist after adding
> > dbar to set_pte(), it may be a problem of clause 2 (case 3 in my
> > description), otherwise it is not a problem of clause 2.
> >
> > At last, this patch itself is attempting to solve the concurrent
> > problem about _PAGE_GLOBAL, so adding pte_alloc_one_kernel() and
> > removing the buddy stuff in set_pte() are what it needs. However it
> > shouldn't touch the logic of dbar in set_pte(), whether "LoongArch:
> > Improve hardware page table walker" is right or wrong.
> yes, I agree. We can discuss set_pte() issue in later. Simple for this
> patch to solve concurrent problem, it is ok
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git/diff/mm/kasan/init.c?h=3Dloongarch-next&id=3D15832255e84494853f543b4c7=
0ced50afc403067
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
> >>
> >>
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Bibo Mao
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>>
> >>>>>> Obvious you do not it and you write wrong patch.
> >>>>>>
> >>>>>>>
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Regards
> >>>>>>>> Bibo Mao
> >>>>>>>>> Huacai
> >>>>>>>>>
> >>>>>>>>> On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loon=
gson.cn> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Unlike general architectures, there are two pages in one TLB e=
ntry
> >>>>>>>>>> on LoongArch system. For kernel space, it requires both two pt=
e
> >>>>>>>>>> entries with PAGE_GLOBAL bit set, else HW treats it as non-glo=
bal
> >>>>>>>>>> tlb, there will be potential problems if tlb entry for kernel =
space
> >>>>>>>>>> is not global. Such as fail to flush kernel tlb with function
> >>>>>>>>>> local_flush_tlb_kernel_range() which only flush tlb with globa=
l bit.
> >>>>>>>>>>
> >>>>>>>>>> With function kernel_pte_init() added, it can be used to init =
pte
> >>>>>>>>>> table when it is created for kernel address space, and the def=
ault
> >>>>>>>>>> initial pte value is PAGE_GLOBAL rather than zero at beginning=
.
> >>>>>>>>>>
> >>>>>>>>>> Kernel address space areas includes fixmap, percpu, vmalloc, k=
asan
> >>>>>>>>>> and vmemmap areas set default pte entry with PAGE_GLOBAL set.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>>>>> ---
> >>>>>>>>>>       arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
> >>>>>>>>>>       arch/loongarch/include/asm/pgtable.h |  1 +
> >>>>>>>>>>       arch/loongarch/mm/init.c             |  4 +++-
> >>>>>>>>>>       arch/loongarch/mm/kasan_init.c       |  4 +++-
> >>>>>>>>>>       arch/loongarch/mm/pgtable.c          | 22 ++++++++++++++=
++++++++
> >>>>>>>>>>       include/linux/mm.h                   |  1 +
> >>>>>>>>>>       mm/kasan/init.c                      |  8 +++++++-
> >>>>>>>>>>       mm/sparse-vmemmap.c                  |  5 +++++
> >>>>>>>>>>       8 files changed, 55 insertions(+), 3 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loong=
arch/include/asm/pgalloc.h
> >>>>>>>>>> index 4e2d6b7ca2ee..b2698c03dc2c 100644
> >>>>>>>>>> --- a/arch/loongarch/include/asm/pgalloc.h
> >>>>>>>>>> +++ b/arch/loongarch/include/asm/pgalloc.h
> >>>>>>>>>> @@ -10,8 +10,21 @@
> >>>>>>>>>>
> >>>>>>>>>>       #define __HAVE_ARCH_PMD_ALLOC_ONE
> >>>>>>>>>>       #define __HAVE_ARCH_PUD_ALLOC_ONE
> >>>>>>>>>> +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> >>>>>>>>>>       #include <asm-generic/pgalloc.h>
> >>>>>>>>>>
> >>>>>>>>>> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *m=
m)
> >>>>>>>>>> +{
> >>>>>>>>>> +       pte_t *pte;
> >>>>>>>>>> +
> >>>>>>>>>> +       pte =3D (pte_t *) __get_free_page(GFP_KERNEL);
> >>>>>>>>>> +       if (!pte)
> >>>>>>>>>> +               return NULL;
> >>>>>>>>>> +
> >>>>>>>>>> +       kernel_pte_init(pte);
> >>>>>>>>>> +       return pte;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>       static inline void pmd_populate_kernel(struct mm_struct =
*mm,
> >>>>>>>>>>                                             pmd_t *pmd, pte_t =
*pte)
> >>>>>>>>>>       {
> >>>>>>>>>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loong=
arch/include/asm/pgtable.h
> >>>>>>>>>> index 9965f52ef65b..22e3a8f96213 100644
> >>>>>>>>>> --- a/arch/loongarch/include/asm/pgtable.h
> >>>>>>>>>> +++ b/arch/loongarch/include/asm/pgtable.h
> >>>>>>>>>> @@ -269,6 +269,7 @@ extern void set_pmd_at(struct mm_struct *m=
m, unsigned long addr, pmd_t *pmdp, pm
> >>>>>>>>>>       extern void pgd_init(void *addr);
> >>>>>>>>>>       extern void pud_init(void *addr);
> >>>>>>>>>>       extern void pmd_init(void *addr);
> >>>>>>>>>> +extern void kernel_pte_init(void *addr);
> >>>>>>>>>>
> >>>>>>>>>>       /*
> >>>>>>>>>>        * Encode/decode swap entries and swap PTEs. Swap PTEs a=
re all PTEs that
> >>>>>>>>>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init=
.c
> >>>>>>>>>> index 8a87a482c8f4..9f26e933a8a3 100644
> >>>>>>>>>> --- a/arch/loongarch/mm/init.c
> >>>>>>>>>> +++ b/arch/loongarch/mm/init.c
> >>>>>>>>>> @@ -198,9 +198,11 @@ pte_t * __init populate_kernel_pte(unsign=
ed long addr)
> >>>>>>>>>>              if (!pmd_present(pmdp_get(pmd))) {
> >>>>>>>>>>                      pte_t *pte;
> >>>>>>>>>>
> >>>>>>>>>> -               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> >>>>>>>>>> +               pte =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZ=
E);
> >>>>>>>>>>                      if (!pte)
> >>>>>>>>>>                              panic("%s: Failed to allocate mem=
ory\n", __func__);
> >>>>>>>>>> +
> >>>>>>>>>> +               kernel_pte_init(pte);
> >>>>>>>>>>                      pmd_populate_kernel(&init_mm, pmd, pte);
> >>>>>>>>>>              }
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/m=
m/kasan_init.c
> >>>>>>>>>> index 427d6b1aec09..34988573b0d5 100644
> >>>>>>>>>> --- a/arch/loongarch/mm/kasan_init.c
> >>>>>>>>>> +++ b/arch/loongarch/mm/kasan_init.c
> >>>>>>>>>> @@ -152,6 +152,8 @@ static void __init kasan_pte_populate(pmd_=
t *pmdp, unsigned long addr,
> >>>>>>>>>>                      phys_addr_t page_phys =3D early ?
> >>>>>>>>>>                                              __pa_symbol(kasan=
_early_shadow_page)
> >>>>>>>>>>                                                    : kasan_all=
oc_zeroed_page(node);
> >>>>>>>>>> +               if (!early)
> >>>>>>>>>> +                       kernel_pte_init(__va(page_phys));
> >>>>>>>>>>                      next =3D addr + PAGE_SIZE;
> >>>>>>>>>>                      set_pte(ptep, pfn_pte(__phys_to_pfn(page_=
phys), PAGE_KERNEL));
> >>>>>>>>>>              } while (ptep++, addr =3D next, addr !=3D end && =
__pte_none(early, ptep_get(ptep)));
> >>>>>>>>>> @@ -287,7 +289,7 @@ void __init kasan_init(void)
> >>>>>>>>>>                      set_pte(&kasan_early_shadow_pte[i],
> >>>>>>>>>>                              pfn_pte(__phys_to_pfn(__pa_symbol=
(kasan_early_shadow_page)), PAGE_KERNEL_RO));
> >>>>>>>>>>
> >>>>>>>>>> -       memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> >>>>>>>>>> +       kernel_pte_init(kasan_early_shadow_page);
> >>>>>>>>>>              csr_write64(__pa_symbol(swapper_pg_dir), LOONGARC=
H_CSR_PGDH);
> >>>>>>>>>>              local_flush_tlb_all();
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/p=
gtable.c
> >>>>>>>>>> index eb6a29b491a7..228ffc1db0a3 100644
> >>>>>>>>>> --- a/arch/loongarch/mm/pgtable.c
> >>>>>>>>>> +++ b/arch/loongarch/mm/pgtable.c
> >>>>>>>>>> @@ -38,6 +38,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> >>>>>>>>>>       }
> >>>>>>>>>>       EXPORT_SYMBOL_GPL(pgd_alloc);
> >>>>>>>>>>
> >>>>>>>>>> +void kernel_pte_init(void *addr)
> >>>>>>>>>> +{
> >>>>>>>>>> +       unsigned long *p, *end;
> >>>>>>>>>> +       unsigned long entry;
> >>>>>>>>>> +
> >>>>>>>>>> +       entry =3D (unsigned long)_PAGE_GLOBAL;
> >>>>>>>>>> +       p =3D (unsigned long *)addr;
> >>>>>>>>>> +       end =3D p + PTRS_PER_PTE;
> >>>>>>>>>> +
> >>>>>>>>>> +       do {
> >>>>>>>>>> +               p[0] =3D entry;
> >>>>>>>>>> +               p[1] =3D entry;
> >>>>>>>>>> +               p[2] =3D entry;
> >>>>>>>>>> +               p[3] =3D entry;
> >>>>>>>>>> +               p[4] =3D entry;
> >>>>>>>>>> +               p +=3D 8;
> >>>>>>>>>> +               p[-3] =3D entry;
> >>>>>>>>>> +               p[-2] =3D entry;
> >>>>>>>>>> +               p[-1] =3D entry;
> >>>>>>>>>> +       } while (p !=3D end);
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>       void pgd_init(void *addr)
> >>>>>>>>>>       {
> >>>>>>>>>>              unsigned long *p, *end;
> >>>>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>>>>>>>>> index ecf63d2b0582..6909fe059a2c 100644
> >>>>>>>>>> --- a/include/linux/mm.h
> >>>>>>>>>> +++ b/include/linux/mm.h
> >>>>>>>>>> @@ -3818,6 +3818,7 @@ void *sparse_buffer_alloc(unsigned long =
size);
> >>>>>>>>>>       struct page * __populate_section_memmap(unsigned long pf=
n,
> >>>>>>>>>>                      unsigned long nr_pages, int nid, struct v=
mem_altmap *altmap,
> >>>>>>>>>>                      struct dev_pagemap *pgmap);
> >>>>>>>>>> +void kernel_pte_init(void *addr);
> >>>>>>>>>>       void pmd_init(void *addr);
> >>>>>>>>>>       void pud_init(void *addr);
> >>>>>>>>>>       pgd_t *vmemmap_pgd_populate(unsigned long addr, int node=
);
> >>>>>>>>>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> >>>>>>>>>> index 89895f38f722..ac607c306292 100644
> >>>>>>>>>> --- a/mm/kasan/init.c
> >>>>>>>>>> +++ b/mm/kasan/init.c
> >>>>>>>>>> @@ -106,6 +106,10 @@ static void __ref zero_pte_populate(pmd_t=
 *pmd, unsigned long addr,
> >>>>>>>>>>              }
> >>>>>>>>>>       }
> >>>>>>>>>>
> >>>>>>>>>> +void __weak __meminit kernel_pte_init(void *addr)
> >>>>>>>>>> +{
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>       static int __ref zero_pmd_populate(pud_t *pud, unsigned =
long addr,
> >>>>>>>>>>                                      unsigned long end)
> >>>>>>>>>>       {
> >>>>>>>>>> @@ -126,8 +130,10 @@ static int __ref zero_pmd_populate(pud_t =
*pud, unsigned long addr,
> >>>>>>>>>>
> >>>>>>>>>>                              if (slab_is_available())
> >>>>>>>>>>                                      p =3D pte_alloc_one_kerne=
l(&init_mm);
> >>>>>>>>>> -                       else
> >>>>>>>>>> +                       else {
> >>>>>>>>>>                                      p =3D early_alloc(PAGE_SI=
ZE, NUMA_NO_NODE);
> >>>>>>>>>> +                               kernel_pte_init(p);
> >>>>>>>>>> +                       }
> >>>>>>>>>>                              if (!p)
> >>>>>>>>>>                                      return -ENOMEM;
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >>>>>>>>>> index edcc7a6b0f6f..c0388b2e959d 100644
> >>>>>>>>>> --- a/mm/sparse-vmemmap.c
> >>>>>>>>>> +++ b/mm/sparse-vmemmap.c
> >>>>>>>>>> @@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_blo=
ck_zero(unsigned long size, int node)
> >>>>>>>>>>              return p;
> >>>>>>>>>>       }
> >>>>>>>>>>
> >>>>>>>>>> +void __weak __meminit kernel_pte_init(void *addr)
> >>>>>>>>>> +{
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>       pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsig=
ned long addr, int node)
> >>>>>>>>>>       {
> >>>>>>>>>>              pmd_t *pmd =3D pmd_offset(pud, addr);
> >>>>>>>>>> @@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud=
_t *pud, unsigned long addr, int node)
> >>>>>>>>>>                      void *p =3D vmemmap_alloc_block_zero(PAGE=
_SIZE, node);
> >>>>>>>>>>                      if (!p)
> >>>>>>>>>>                              return NULL;
> >>>>>>>>>> +               kernel_pte_init(p);
> >>>>>>>>>>                      pmd_populate_kernel(&init_mm, pmd, p);
> >>>>>>>>>>              }
> >>>>>>>>>>              return pmd;
> >>>>>>>>>> --
> >>>>>>>>>> 2.39.3
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>>>
> >>
>


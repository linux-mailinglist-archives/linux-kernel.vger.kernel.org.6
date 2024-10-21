Return-Path: <linux-kernel+bounces-374073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA4F9A6238
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2154F1C2180F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC41E3DD8;
	Mon, 21 Oct 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8CVaWgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0B192D69
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505618; cv=none; b=tg5dW7h4qQ7pcY7PHMkopivAkPY0Gcw4q/WKfVv1YJ92V3bRKorQKknkwkeLdf6jvfbAxTDclcgYXTfwjQnkNMgx00lEdWKZgtK6lZtauVfUVcDMwRHk7r6poKQCAuC+nqfnWqqIG5de1GEXJASRPnULBgHv788IFYlsjTW7OiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505618; c=relaxed/simple;
	bh=jgibUuUlmzffYqsQkg5W+yVcI04OIHEGmRwn6NuO/wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axLLeVhHbspfLM6Nmy8yLItWODgyUuN9yhu8UNNggeuzC1B2jEeGWexfRN6iPK9j2INfJ2WR+aElHdQtvbazAsXT4N7jdoBxJExCyH7v5c5PlEBkzXZUfauWl29NFv9AH5DdOxn0fT/scq2gtg9DG9AwsyCht0WR7/NQOQOETXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8CVaWgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F9DC4CEE6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729505617;
	bh=jgibUuUlmzffYqsQkg5W+yVcI04OIHEGmRwn6NuO/wU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O8CVaWgKGMhB0cBPkApEVVEUDRMYrD7xqVCOt0yoZtyt6QGgwVQ3ptHt0jB7djrkB
	 /mlbBfaR2RXCgCKzS25NVvzir/j4HKgSlEoKlHOzDW+xePTLFusb6wI0Cv80FyMkFI
	 8OTUo0f4qHR3syPBXiYCDPCToRNIQP0iwdsz/TFvZCpnfLEfrsnKbFzrMnCIHlUr8j
	 8gqpGl3AoPfp3a2+ejLi4UKG1bh0GpFt1mCu9/TfA7f2E4CLXNK4q5UfREhRAE08Ur
	 LQXANATocN1JCmkfbwpA3a5SgUBtqbtChK+nOY9tIF6e+GsoD6rmvYXgP4H9Lq33fq
	 X3UGYlLa4/2ZQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so5389751a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:13:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAHmU/B9+GixUc36wi+dO6ltJ5891n34GGyeWqVYfAbb/wU36X8oDU03qIxPljwN9H+Lid+1PkHblRpnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFsWpCvv4CI7j6txh2e59gumEIkQOEqojRJ/vQLklldBAJqMoN
	54UcbnmtGBjOeVZLJVyYgOKt40FisEl+Dc3vVBacbiVDmc7L+Gk11K27oYDHJ047iXAH9DthJl9
	jete8csBn2Et5+0tlL3g7YUvMkEA=
X-Google-Smtp-Source: AGHT+IGkScV1UZ4+JsX1t5mnmGxuvMdzS/NJr4OXeJMsMFge9N+OTDfUV2GMn59vK/I6+b7B/D8r6K8TkoU1q96HgQc=
X-Received: by 2002:a17:906:478b:b0:a99:4025:82e1 with SMTP id
 a640c23a62f3a-a9a69c55c81mr1013062566b.41.1729505615843; Mon, 21 Oct 2024
 03:13:35 -0700 (PDT)
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
 <f727e384-6989-0942-1cc8-7188f558ee39@loongson.cn>
In-Reply-To: <f727e384-6989-0942-1cc8-7188f558ee39@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 21 Oct 2024 18:13:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5CADad2EGv0zMQrgrvpNRtBTWDoXFj=j+zXEJdy7HkAQ@mail.gmail.com>
Message-ID: <CAAhV-H5CADad2EGv0zMQrgrvpNRtBTWDoXFj=j+zXEJdy7HkAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LoongArch: Set initial pte entry with PAGE_GLOBAL
 for kernel space
To: maobibo <maobibo@loongson.cn>
Cc: wuruiyang@loongson.cn, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:23=E2=80=AFAM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2024/10/18 =E4=B8=8B=E5=8D=882:32, Huacai Chen wrote:
> > On Fri, Oct 18, 2024 at 2:23=E2=80=AFPM maobibo <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2024/10/18 =E4=B8=8B=E5=8D=8812:23, Huacai Chen wrote:
> >>> On Fri, Oct 18, 2024 at 12:16=E2=80=AFPM maobibo <maobibo@loongson.cn=
> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/10/18 =E4=B8=8B=E5=8D=8812:11, Huacai Chen wrote:
> >>>>> On Fri, Oct 18, 2024 at 11:44=E2=80=AFAM maobibo <maobibo@loongson.=
cn> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2024/10/18 =E4=B8=8A=E5=8D=8811:14, Huacai Chen wrote:
> >>>>>>> Hi, Bibo,
> >>>>>>>
> >>>>>>> I applied this patch but drop the part of arch/loongarch/mm/kasan=
_init.c:
> >>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-=
loongson.git/commit/?h=3Dloongarch-next&id=3D15832255e84494853f543b4c70ced5=
0afc403067
> >>>>>>>
> >>>>>>> Because kernel_pte_init() should operate on page-table pages, not=
 on
> >>>>>>> data pages. You have already handle page-table page in
> >>>>>>> mm/kasan/init.c, and if we don't drop the modification on data pa=
ges
> >>>>>>> in arch/loongarch/mm/kasan_init.c, the kernel fail to boot if KAS=
AN is
> >>>>>>> enabled.
> >>>>>>>
> >>>>>> static inline void set_pte(pte_t *ptep, pte_t pteval)
> >>>>>>      {
> >>>>>>            WRITE_ONCE(*ptep, pteval);
> >>>>>> -
> >>>>>> -       if (pte_val(pteval) & _PAGE_GLOBAL) {
> >>>>>> -               pte_t *buddy =3D ptep_buddy(ptep);
> >>>>>> -               /*
> >>>>>> -                * Make sure the buddy is global too (if it's !non=
e,
> >>>>>> -                * it better already be global)
> >>>>>> -                */
> >>>>>> -               if (pte_none(ptep_get(buddy))) {
> >>>>>> -#ifdef CONFIG_SMP
> >>>>>> -                       /*
> >>>>>> -                        * For SMP, multiple CPUs can race, so we =
need
> >>>>>> -                        * to do this atomically.
> >>>>>> -                        */
> >>>>>> -                       __asm__ __volatile__(
> >>>>>> -                       __AMOR "$zero, %[global], %[buddy] \n"
> >>>>>> -                       : [buddy] "+ZB" (buddy->pte)
> >>>>>> -                       : [global] "r" (_PAGE_GLOBAL)
> >>>>>> -                       : "memory");
> >>>>>> -
> >>>>>> -                       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> >>>>>> -#else /* !CONFIG_SMP */
> >>>>>> -                       WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(=
buddy)) | _PAGE_GLOBAL));
> >>>>>> -#endif /* CONFIG_SMP */
> >>>>>> -               }
> >>>>>> -       }
> >>>>>> +       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> >>>>>>      }
> >>>>>>
> >>>>>> No, please hold on. This issue exists about twenty years, Do we ne=
ed be
> >>>>>> in such a hurry now?
> >>>>>>
> >>>>>> why is DBAR(0b11000) added in set_pte()?
> >>>>> It exists before, not added by this patch. The reason is explained =
in
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?h=3Dv6.12-rc3&id=3Df93f67d06b1023313ef1662eac490e29c025c030
> >>>> why speculative accesses may cause spurious page fault in kernel spa=
ce
> >>>> with PTE enabled?  speculative accesses exists anywhere, it does not
> >>>> cause spurious page fault.
> >>> Confirmed by Ruiyang Wu, and even if DBAR(0b11000) is wrong, that
> >>> means another patch's mistake, not this one. This one just keeps the
> >>> old behavior.
> >>> +CC Ruiyang Wu here.
> >> Also from Ruiyang Wu, the information is that speculative accesses may
> >> insert stale TLB, however no page fault exception.
> >>
> >> So adding barrier in set_pte() does not prevent speculative accesses.
> >> And you write patch here, however do not know the actual reason?
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?h=3Dv6.12-rc3&id=3Df93f67d06b1023313ef1662eac490e29c025c030
> > I have CCed Ruiyang, whether the description is correct can be judged b=
y him.
>
> There are some problems to add barrier() in set_pte():
>
> 1. There is such issue only for HW ptw enabled and kernel address space,
> is that? Also it may be two heavy to add barrier in set_pte(), comparing
> to do this in flush_cache_vmap().
So adding a barrier in set_pte() may not be the best solution for
performance, but you cannot say it is a wrong solution. And yes, we
can only care the kernel space, which is also the old behavior before
this patch, so set_pte() should be:

static inline void set_pte(pte_t *ptep, pte_t pteval)
{
        WRITE_ONCE(*ptep, pteval);
#ifdef CONFIG_SMP
        if (pte_val(pteval) & _PAGE_GLOBAL)
                DBAR(0b11000); /* o_wrw =3D 0b11000 */
#endif
}

Putting a dbar unconditionally in set_pte() is my mistake, I'm sorry for  t=
hat.

>
> 2. LoongArch is different with other other architectures, two pages are
> included in one TLB entry. If there is two consecutive page mapped and
> memory access, there will page fault for the second memory access. Such
> as:
>     addr1 =3Dpercpu_alloc(pagesize);
>     val1 =3D *(int *)addr1;
>       // With page table walk, addr1 is present and addr2 is pte_none
>       // TLB entry includes valid pte for addr1, invalid pte for addr2
>     addr2 =3Dpercpu_alloc(pagesize); // will not flush tlb in first time
>     val2 =3D *(int *)addr2;
>       // With page table walk, addr1 is present and addr2 is present also
>       // TLB entry includes valid pte for addr1, invalid pte for addr2
>     So there will be page fault when accessing address addr2
>
> There there is the same problem with user address space. By the way,
> there is HW prefetching technology, negative effective of HW prefetching
> technology will be tlb added. So there is potential page fault if memory
> is allocated and accessed in the first time.
As discussed internally, there may be three problems related to
speculative access in detail: 1) a load/store after set_pte() is
prioritized before, which can be prevented by dbar, 2) a instruction
fetch after set_pte() is prioritized before, which can be prevented by
ibar, 3) the buddy tlb problem you described here, if I understand
Ruiyang's explanation correctly this can only be prevented by the
filter in do_page_fault().

From experiments, without the patch "LoongArch: Improve hardware page
table walker", there are about 80 times of spurious page faults during
boot, and increases continually during stress tests. And after that
patch which adds a dbar to set_pte(), we cannot observe spurious page
faults anymore. Of course this doesn't mean 2) and 3) don't exist, but
we can at least say 1) is the main case. On this basis, in "LoongArch:
Improve hardware page table walker" we use a relatively cheap dbar
(compared to ibar) to prevent the main case, and add a filter to
handle 2) and 3). Such a solution is reasonable.


>
> 3. For speculative execution, if it is user address, there is eret from
> syscall. eret will rollback all speculative execution instruction. So it
> is only problem for speculative execution. And how to verify whether it
> is the problem of speculative execution or it is the problem of clause 2?
As described above, if spurious page faults still exist after adding
dbar to set_pte(), it may be a problem of clause 2 (case 3 in my
description), otherwise it is not a problem of clause 2.

At last, this patch itself is attempting to solve the concurrent
problem about _PAGE_GLOBAL, so adding pte_alloc_one_kernel() and
removing the buddy stuff in set_pte() are what it needs. However it
shouldn't touch the logic of dbar in set_pte(), whether "LoongArch:
Improve hardware page table walker" is right or wrong.


Huacai

>
> Regards
> Bibo Mao
>
>
> >
> > Huacai
> >
> >>
> >> Bibo Mao
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Obvious you do not it and you write wrong patch.
> >>>>
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>>
> >>>>>> Regards
> >>>>>> Bibo Mao
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>> On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loongs=
on.cn> wrote:
> >>>>>>>>
> >>>>>>>> Unlike general architectures, there are two pages in one TLB ent=
ry
> >>>>>>>> on LoongArch system. For kernel space, it requires both two pte
> >>>>>>>> entries with PAGE_GLOBAL bit set, else HW treats it as non-globa=
l
> >>>>>>>> tlb, there will be potential problems if tlb entry for kernel sp=
ace
> >>>>>>>> is not global. Such as fail to flush kernel tlb with function
> >>>>>>>> local_flush_tlb_kernel_range() which only flush tlb with global =
bit.
> >>>>>>>>
> >>>>>>>> With function kernel_pte_init() added, it can be used to init pt=
e
> >>>>>>>> table when it is created for kernel address space, and the defau=
lt
> >>>>>>>> initial pte value is PAGE_GLOBAL rather than zero at beginning.
> >>>>>>>>
> >>>>>>>> Kernel address space areas includes fixmap, percpu, vmalloc, kas=
an
> >>>>>>>> and vmemmap areas set default pte entry with PAGE_GLOBAL set.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>>> ---
> >>>>>>>>      arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
> >>>>>>>>      arch/loongarch/include/asm/pgtable.h |  1 +
> >>>>>>>>      arch/loongarch/mm/init.c             |  4 +++-
> >>>>>>>>      arch/loongarch/mm/kasan_init.c       |  4 +++-
> >>>>>>>>      arch/loongarch/mm/pgtable.c          | 22 +++++++++++++++++=
+++++
> >>>>>>>>      include/linux/mm.h                   |  1 +
> >>>>>>>>      mm/kasan/init.c                      |  8 +++++++-
> >>>>>>>>      mm/sparse-vmemmap.c                  |  5 +++++
> >>>>>>>>      8 files changed, 55 insertions(+), 3 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongar=
ch/include/asm/pgalloc.h
> >>>>>>>> index 4e2d6b7ca2ee..b2698c03dc2c 100644
> >>>>>>>> --- a/arch/loongarch/include/asm/pgalloc.h
> >>>>>>>> +++ b/arch/loongarch/include/asm/pgalloc.h
> >>>>>>>> @@ -10,8 +10,21 @@
> >>>>>>>>
> >>>>>>>>      #define __HAVE_ARCH_PMD_ALLOC_ONE
> >>>>>>>>      #define __HAVE_ARCH_PUD_ALLOC_ONE
> >>>>>>>> +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> >>>>>>>>      #include <asm-generic/pgalloc.h>
> >>>>>>>>
> >>>>>>>> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >>>>>>>> +{
> >>>>>>>> +       pte_t *pte;
> >>>>>>>> +
> >>>>>>>> +       pte =3D (pte_t *) __get_free_page(GFP_KERNEL);
> >>>>>>>> +       if (!pte)
> >>>>>>>> +               return NULL;
> >>>>>>>> +
> >>>>>>>> +       kernel_pte_init(pte);
> >>>>>>>> +       return pte;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      static inline void pmd_populate_kernel(struct mm_struct *mm=
,
> >>>>>>>>                                            pmd_t *pmd, pte_t *pt=
e)
> >>>>>>>>      {
> >>>>>>>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongar=
ch/include/asm/pgtable.h
> >>>>>>>> index 9965f52ef65b..22e3a8f96213 100644
> >>>>>>>> --- a/arch/loongarch/include/asm/pgtable.h
> >>>>>>>> +++ b/arch/loongarch/include/asm/pgtable.h
> >>>>>>>> @@ -269,6 +269,7 @@ extern void set_pmd_at(struct mm_struct *mm,=
 unsigned long addr, pmd_t *pmdp, pm
> >>>>>>>>      extern void pgd_init(void *addr);
> >>>>>>>>      extern void pud_init(void *addr);
> >>>>>>>>      extern void pmd_init(void *addr);
> >>>>>>>> +extern void kernel_pte_init(void *addr);
> >>>>>>>>
> >>>>>>>>      /*
> >>>>>>>>       * Encode/decode swap entries and swap PTEs. Swap PTEs are =
all PTEs that
> >>>>>>>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> >>>>>>>> index 8a87a482c8f4..9f26e933a8a3 100644
> >>>>>>>> --- a/arch/loongarch/mm/init.c
> >>>>>>>> +++ b/arch/loongarch/mm/init.c
> >>>>>>>> @@ -198,9 +198,11 @@ pte_t * __init populate_kernel_pte(unsigned=
 long addr)
> >>>>>>>>             if (!pmd_present(pmdp_get(pmd))) {
> >>>>>>>>                     pte_t *pte;
> >>>>>>>>
> >>>>>>>> -               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> >>>>>>>> +               pte =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE)=
;
> >>>>>>>>                     if (!pte)
> >>>>>>>>                             panic("%s: Failed to allocate memory=
\n", __func__);
> >>>>>>>> +
> >>>>>>>> +               kernel_pte_init(pte);
> >>>>>>>>                     pmd_populate_kernel(&init_mm, pmd, pte);
> >>>>>>>>             }
> >>>>>>>>
> >>>>>>>> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/=
kasan_init.c
> >>>>>>>> index 427d6b1aec09..34988573b0d5 100644
> >>>>>>>> --- a/arch/loongarch/mm/kasan_init.c
> >>>>>>>> +++ b/arch/loongarch/mm/kasan_init.c
> >>>>>>>> @@ -152,6 +152,8 @@ static void __init kasan_pte_populate(pmd_t =
*pmdp, unsigned long addr,
> >>>>>>>>                     phys_addr_t page_phys =3D early ?
> >>>>>>>>                                             __pa_symbol(kasan_ea=
rly_shadow_page)
> >>>>>>>>                                                   : kasan_alloc_=
zeroed_page(node);
> >>>>>>>> +               if (!early)
> >>>>>>>> +                       kernel_pte_init(__va(page_phys));
> >>>>>>>>                     next =3D addr + PAGE_SIZE;
> >>>>>>>>                     set_pte(ptep, pfn_pte(__phys_to_pfn(page_phy=
s), PAGE_KERNEL));
> >>>>>>>>             } while (ptep++, addr =3D next, addr !=3D end && __p=
te_none(early, ptep_get(ptep)));
> >>>>>>>> @@ -287,7 +289,7 @@ void __init kasan_init(void)
> >>>>>>>>                     set_pte(&kasan_early_shadow_pte[i],
> >>>>>>>>                             pfn_pte(__phys_to_pfn(__pa_symbol(ka=
san_early_shadow_page)), PAGE_KERNEL_RO));
> >>>>>>>>
> >>>>>>>> -       memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> >>>>>>>> +       kernel_pte_init(kasan_early_shadow_page);
> >>>>>>>>             csr_write64(__pa_symbol(swapper_pg_dir), LOONGARCH_C=
SR_PGDH);
> >>>>>>>>             local_flush_tlb_all();
> >>>>>>>>
> >>>>>>>> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgt=
able.c
> >>>>>>>> index eb6a29b491a7..228ffc1db0a3 100644
> >>>>>>>> --- a/arch/loongarch/mm/pgtable.c
> >>>>>>>> +++ b/arch/loongarch/mm/pgtable.c
> >>>>>>>> @@ -38,6 +38,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> >>>>>>>>      }
> >>>>>>>>      EXPORT_SYMBOL_GPL(pgd_alloc);
> >>>>>>>>
> >>>>>>>> +void kernel_pte_init(void *addr)
> >>>>>>>> +{
> >>>>>>>> +       unsigned long *p, *end;
> >>>>>>>> +       unsigned long entry;
> >>>>>>>> +
> >>>>>>>> +       entry =3D (unsigned long)_PAGE_GLOBAL;
> >>>>>>>> +       p =3D (unsigned long *)addr;
> >>>>>>>> +       end =3D p + PTRS_PER_PTE;
> >>>>>>>> +
> >>>>>>>> +       do {
> >>>>>>>> +               p[0] =3D entry;
> >>>>>>>> +               p[1] =3D entry;
> >>>>>>>> +               p[2] =3D entry;
> >>>>>>>> +               p[3] =3D entry;
> >>>>>>>> +               p[4] =3D entry;
> >>>>>>>> +               p +=3D 8;
> >>>>>>>> +               p[-3] =3D entry;
> >>>>>>>> +               p[-2] =3D entry;
> >>>>>>>> +               p[-1] =3D entry;
> >>>>>>>> +       } while (p !=3D end);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      void pgd_init(void *addr)
> >>>>>>>>      {
> >>>>>>>>             unsigned long *p, *end;
> >>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>>>>>>> index ecf63d2b0582..6909fe059a2c 100644
> >>>>>>>> --- a/include/linux/mm.h
> >>>>>>>> +++ b/include/linux/mm.h
> >>>>>>>> @@ -3818,6 +3818,7 @@ void *sparse_buffer_alloc(unsigned long si=
ze);
> >>>>>>>>      struct page * __populate_section_memmap(unsigned long pfn,
> >>>>>>>>                     unsigned long nr_pages, int nid, struct vmem=
_altmap *altmap,
> >>>>>>>>                     struct dev_pagemap *pgmap);
> >>>>>>>> +void kernel_pte_init(void *addr);
> >>>>>>>>      void pmd_init(void *addr);
> >>>>>>>>      void pud_init(void *addr);
> >>>>>>>>      pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
> >>>>>>>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> >>>>>>>> index 89895f38f722..ac607c306292 100644
> >>>>>>>> --- a/mm/kasan/init.c
> >>>>>>>> +++ b/mm/kasan/init.c
> >>>>>>>> @@ -106,6 +106,10 @@ static void __ref zero_pte_populate(pmd_t *=
pmd, unsigned long addr,
> >>>>>>>>             }
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +void __weak __meminit kernel_pte_init(void *addr)
> >>>>>>>> +{
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      static int __ref zero_pmd_populate(pud_t *pud, unsigned lon=
g addr,
> >>>>>>>>                                     unsigned long end)
> >>>>>>>>      {
> >>>>>>>> @@ -126,8 +130,10 @@ static int __ref zero_pmd_populate(pud_t *p=
ud, unsigned long addr,
> >>>>>>>>
> >>>>>>>>                             if (slab_is_available())
> >>>>>>>>                                     p =3D pte_alloc_one_kernel(&=
init_mm);
> >>>>>>>> -                       else
> >>>>>>>> +                       else {
> >>>>>>>>                                     p =3D early_alloc(PAGE_SIZE,=
 NUMA_NO_NODE);
> >>>>>>>> +                               kernel_pte_init(p);
> >>>>>>>> +                       }
> >>>>>>>>                             if (!p)
> >>>>>>>>                                     return -ENOMEM;
> >>>>>>>>
> >>>>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >>>>>>>> index edcc7a6b0f6f..c0388b2e959d 100644
> >>>>>>>> --- a/mm/sparse-vmemmap.c
> >>>>>>>> +++ b/mm/sparse-vmemmap.c
> >>>>>>>> @@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_block=
_zero(unsigned long size, int node)
> >>>>>>>>             return p;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +void __weak __meminit kernel_pte_init(void *addr)
> >>>>>>>> +{
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned=
 long addr, int node)
> >>>>>>>>      {
> >>>>>>>>             pmd_t *pmd =3D pmd_offset(pud, addr);
> >>>>>>>> @@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t=
 *pud, unsigned long addr, int node)
> >>>>>>>>                     void *p =3D vmemmap_alloc_block_zero(PAGE_SI=
ZE, node);
> >>>>>>>>                     if (!p)
> >>>>>>>>                             return NULL;
> >>>>>>>> +               kernel_pte_init(p);
> >>>>>>>>                     pmd_populate_kernel(&init_mm, pmd, p);
> >>>>>>>>             }
> >>>>>>>>             return pmd;
> >>>>>>>> --
> >>>>>>>> 2.39.3
> >>>>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>>>
> >>
> >>
>


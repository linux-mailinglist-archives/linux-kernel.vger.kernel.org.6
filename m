Return-Path: <linux-kernel+bounces-270934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637C94473B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA70B1C225C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482816F29A;
	Thu,  1 Aug 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b3aiAQFD"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347316EBE9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502661; cv=none; b=P5x0a5+59DZNTMUZNxHoUPANH8b7jYS8GPM1kuKDzBTnSA23WjjwuUKTrJNrr3KNQuwNg0XcKGxY7hLPnKDVIfi6ssYm36gfrcmfGdjLxsJ++zeufMX6BD2iETmWj10zcuz/ZlsJkzUS2WMrlWMxFIVCK51Vqh3oqRVy55LNbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502661; c=relaxed/simple;
	bh=5B5LJZTd/kr0j8WYnODbxaKdrpwpg4p8IBZO04NfU0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+Wg3i/8zD7qt+j5dcriwVkMt8BvAXAVuse5eDZmJ/O9r1DmaCkrdd6xfvj7+pUnfP9Fm+Ph41VV8/o6Yghvwiphnf6yZGBXRO9yJPy64yLOA6lO/YzyQx7WVK8DYSXTDnH4Z2wHogke6Mw9YkT4kOWE221LPq8m1gSj4UgJCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b3aiAQFD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso10617845a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722502657; x=1723107457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiBjZz2sS9TizBRH8f9iV0d8caGxH3UUrgmC+RocEis=;
        b=b3aiAQFD0KvcnQK35CX1w0XT35iM3tRQaQ9Szd0HUAy1T7YpWwVCak9aD7ezEYHPQ9
         wT9tZhjFQZulTctJglmz3wWn+B8EzWJvTYgMfVf6Psd9rvDznWm/1N04TjMBreO71bfn
         NDK+UfC7gAR7k5DObTr5zFOCtKnBJFhplP0K9c6xOqpccWC5XuuZWFCmeBhMikQyxbZ1
         2ugGiX+Uw9NVuSuZguKzBy2EiPwP2G0wV+imIrPUKgAtcpyJ4NODre0UEPvdmxYh7aAD
         Noh46prjsGn47V8+8a6cdN9GxRSHHeQmdTPprhngQnswQxLdSKr3MFR2CobBtUeWVvIv
         BL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502657; x=1723107457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiBjZz2sS9TizBRH8f9iV0d8caGxH3UUrgmC+RocEis=;
        b=gjUwVTjLYI1jf34bGbkdVmBl1NRhcQBCiKYwchq+6TOBnmo8AS+oydeDuYAzAhmxvq
         VkewCRGCSO9PFVVK2vVa2w5o+MGt7yool1Kw2tWLjPrTRkSeN8wzEdkkjvEWpDN8veLo
         yD4IbaKXf7t8UksM4LZZEUPrcku7U2AxwtW3zc+d0j/QMkm2ZUE6ZsAPr1OUiHpuL0MS
         CAKi2EMQ9/wsf4PP509OJzHQxsoi2h/RQZ6sCL3uttvaasFmO40jcel8S1dQp4tauEqy
         vic3wVNjPQj3Hj30V4zs97Jz2KGbk9CW76OpZ49BXOBSCXrYd6oqEChewRj4TBsnPPr3
         n3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+YkIQPcAK910DoQpJdqesirurZPBn2a/S+Hwj5+qtmV3s8WiU9ZKo9yHJlSYTk6IGIsRJ3u4bvzn9WPxe+u6VysKQtnvG1U299Nk8
X-Gm-Message-State: AOJu0YyjB92jZJjOWXVhTSC3fT7McMQiZy8MWs3Cv9jwMU1s7CY/MEI7
	DKCNxO8YtaFAczWG949MHSndqfZ3ESXmKZaArdea1dROD5uJvD5yteRqPGcM4MLI2+k7n19Wi9l
	5/L1pJs6hH18hFVFryLgNr3LKmeqYQlTbFRu/Tw==
X-Google-Smtp-Source: AGHT+IGHVkR2BRvl49TJI3JrSuAxzI8Lthgs9tcAqeCPttIMH1GkGiQ8WDDrEEGp6qilew8worZtHpTQmNw1pcJobzQ=
X-Received: by 2002:a17:907:6ea4:b0:a7a:9e11:e87c with SMTP id
 a640c23a62f3a-a7daf79482dmr167428066b.9.1722502657195; Thu, 01 Aug 2024
 01:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508113419.18620-1-alexghiti@rivosinc.com>
 <6d37f914-d139-48ea-be63-c428ac767cc1@arm.com> <CAHVXubhmihZA50pdaek4=fx83ycdOyuYkRmVLPtZk59uKBoWPw@mail.gmail.com>
 <863092ed-2b04-46bb-8d99-5796346cef3a@ghiti.fr> <b7ae4c41-5de8-4097-9f66-b98bb9885395@arm.com>
 <a21f990c-fc74-4a5e-ad03-10c83a051e65@ghiti.fr>
In-Reply-To: <a21f990c-fc74-4a5e-ad03-10c83a051e65@ghiti.fr>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 1 Aug 2024 10:57:26 +0200
Message-ID: <CAHVXubg83eaGx_P8g-=9V9zmxxWRJxM8OuWcsJonPFwfqM3d9g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/9] Merge arm64/riscv hugetlbfs contpte support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Tue, Jul 2, 2024 at 9:51=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> Hi Ryan,
>
> On 24/06/2024 10:00, Ryan Roberts wrote:
> > On 28/05/2024 09:07, Alexandre Ghiti wrote:
> >> Hi Ryan,
> >>
> >> On 12/05/2024 19:25, Alexandre Ghiti wrote:
> >>> Hi Ryan,
> >>>
> >>> On Fri, May 10, 2024 at 3:49=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>> On 08/05/2024 12:34, Alexandre Ghiti wrote:
> >>>>> This patchset intends to merge the contiguous ptes hugetlbfs implem=
entation
> >>>>> of arm64 and riscv.
> >>>>>
> >>>>> Both arm64 and riscv support the use of contiguous ptes to map page=
s that
> >>>>> are larger than the default page table size, respectively called co=
ntpte
> >>>>> and svnapot.
> >>>>>
> >>>>> The riscv implementation differs from the arm64's in that the LSBs =
of the
> >>>>> pfn of a svnapot pte are used to store the size of the mapping, all=
owing
> >>>>> for future sizes to be added (for now only 64KB is supported). That=
's an
> >>>>> issue for the core mm code which expects to find the *real* pfn a p=
te points
> >>>>> to. Patch 1 fixes that by always returning svnapot ptes with the re=
al pfn
> >>>>> and restores the size of the mapping when it is written to a page t=
able.
> >>>>>
> >>>>> The following patches are just merges of the 2 different implementa=
tions
> >>>>> that currently exist in arm64 and riscv which are very similar. It =
paves
> >>>>> the way to the reuse of the recent contpte THP work by Ryan [1] to =
avoid
> >>>>> reimplementing the same in riscv.
> >>>> Hi Alexandre,
> >>>>
> >>>> I've skimmed through this series and the one that moves contpte. I c=
an see there
> >>>> is definitely value in sharing the implementation, and the rough sha=
pe of things
> >>>> seems appropriate. I had some minor concerns about making it harder =
to implement
> >>>> potential future arm64 errata workarounds but on reflection, most of=
 the
> >>>> now-shared code is really just wrapping the primitives that are stil=
l
> >>>> arch-specific.
> >>>>
> >>>> I'm going to need to spend proper time reviewing it to give detailed=
 feedback,
> >>>> but I'll be out on paternity leave for 3 weeks from end of Monday at=
 the latest.
> >>> Too bad, I expected to discuss that with you at LSF/MM...But congrats=
!
> >>> Hope your wife is fine :)
> >>>
> >>>> So realistically I won't be able to do the detailed review until at =
least the
> >>>> first week of June.
> > Hi Alexandre,
> >
> > Sorry for the radio silence. I'm back at work now and have some cycles =
to review
> > this. Did you ever post a new version based on the suggestions below?
>
>
> Unfortunately no, other things happened that took all my attention, sorry=
.
>
>
> >>>> Some high level thoughts:
> >>>>
> >>>>    - huge_ptep_* functions could be working on different sized huge =
ptes - arm64
> >>>> supports contpte, pmd, contpmd and pud. Is keeping them in contpte.c
> >>>> appropriate?
> >>> Hmm indeed, I'll see what I can do.
> >>
> >> So I took a look at that. It amounts to doing the same as what we do f=
or THP
> >> contptes, ie having both contpte-aware and "normal" APIs. Let's take f=
or example
> >> huge_ptep_get(), below is what I get. To me it's not that bad, so I'll=
 implement
> >> this unless there is strong opposition.
> > I'm not sure I've understood what you are going here... see below.
> >
> >>
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm=
/pgtable.h
> >> index f8efbc128446..869a9aae6c68 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -1715,6 +1715,16 @@ static inline void clear_young_dirty_ptes(struc=
t
> >> vm_area_struct *vma,
> >>                  contpte_clear_young_dirty_ptes(vma, addr, ptep, nr, f=
lags);
> >>   }
> >>
> >> +static inline pte_t huge_ptep_get(pte_t *ptep)
> >> +{
> >> +        pte_t orig_pte =3D __ptep_get(ptep);
> >> +
> >> +        if (!pte_present(orig_pte) || !pte_cont(orig_pte))
> >> +                return orig_pte;
> >> +
> >> +        return contpte_huge_ptep_get(ptep);
> > A "huge pte" is not the same as a "cont pte". A huge pte is an abstract=
 thing,
> > which maybe of a number of different sizes; on arm64 with 4K base pages=
, 64K,
> > 2M, 32M, 1G are supported. The 64K size is implemented using the PTE_CO=
NT bit at
> > PTE level. 2M is a single PMD level block, 32M uses PMD_CONT at PMD lev=
el and 1G
> > is 1 PUD block. So I'm not sure it makes sense to tie this up with "con=
tpte_"
> > functions?
> >
> >> +}
> >> +
> >>   #else /* CONFIG_ARM64_CONTPTE */
> >>
> >>   #define ptep_get                               __ptep_get
> >> @@ -1736,6 +1746,8 @@ static inline void clear_young_dirty_ptes(struct
> >> vm_area_struct *vma,
> >>   #define ptep_set_access_flags __ptep_set_access_flags
> >>   #define clear_young_dirty_ptes __clear_young_dirty_ptes
> >>
> >> +#define huge_ptep_get                          __ptep_get
> > I don't quite understand the logic here. huge ptes are needed for huget=
lb so
> > their definition needs to be tied to that, not to ARM64_CONTPTE, which =
is an
> > independent feature.
> >
> >> +
> >>   #endif /* CONFIG_ARM64_CONTPTE */
> >>
> >>   #endif /* !__ASSEMBLY__ */
> >> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> >> index 3f09ac73cce3..aa0ee3f02226 100644
> >> --- a/arch/arm64/mm/hugetlbpage.c
> >> +++ b/arch/arm64/mm/hugetlbpage.c
> >> @@ -127,28 +127,6 @@ static inline int num_contig_ptes(unsigned long s=
ize,
> >> size_t *pgsize)
> >>          return contig_ptes;
> >>   }
> >>
> >> -pte_t huge_ptep_get(pte_t *ptep)
> >> -{
> >> -       int ncontig, i;
> >> -       size_t pgsize;
> >> -       pte_t orig_pte =3D __ptep_get(ptep);
> >> -
> >> -       if (!pte_present(orig_pte) || !pte_cont(orig_pte))
> >> -               return orig_pte;
> >> -
> >> -       ncontig =3D num_contig_ptes(page_size(pte_page(orig_pte)), &pg=
size);
> >> -       for (i =3D 0; i < ncontig; i++, ptep++) {
> >> -               pte_t pte =3D __ptep_get(ptep);
> >> -
> >> -               if (pte_dirty(pte))
> >> -                       orig_pte =3D pte_mkdirty(orig_pte);
> >> -
> >> -               if (pte_young(pte))
> >> -                       orig_pte =3D pte_mkyoung(orig_pte);
> >> -       }
> >> -       return orig_pte;
> >> -}
> >> -
> >>   /*
> >>    * Changing some bits of contiguous entries requires us to follow a
> >>    * Break-Before-Make approach, breaking the whole contiguous set
> >> diff --git a/mm/contpte.c b/mm/contpte.c
> >> new file mode 100644
> >> index 000000000000..4e742cf00b6f
> >> --- /dev/null
> >> +++ b/mm/contpte.c
> >> @@ -0,0 +1,17 @@
> >> +pte_t contpte_huge_ptep_get(pte_t *ptep)
> >> +{
> >> +        int ncontig, i;
> >> +        size_t pgsize;
> >> +
> >> +        ncontig =3D num_contig_ptes(page_size(pte_page(orig_pte)), &p=
gsize);
> >> +        for (i =3D 0; i < ncontig; i++, ptep++) {
> >> +                pte_t pte =3D __ptep_get(ptep);
> >> +
> >> +                if (pte_dirty(pte))
> >> +                        orig_pte =3D pte_mkdirty(orig_pte);
> >> +
> >> +                if (pte_young(pte))
> >> +                        orig_pte =3D pte_mkyoung(orig_pte);
> >> +        }
> >> +        return orig_pte;
> >> +}
> > I guess your observation is that contpte_ and hugepte_ code looks simil=
ar so it
> > shold be grouped? I think if we can get some actual reuse that might ma=
ke sense,
> > but as implemented, this function is completely separate from
> > contpte_ptep_get(). I wonder if its simpler just to have contpte.c for =
contpte_
> > and hugepte_.c for hugepte_ then they can be included in the build inde=
pendently
> > based on arch/core Kconfigs (e.g. CONFIG_HUGETLB_PAGE vs CONFIG_ARM64_C=
ONTPTE).
>
>
> Yes, you're right, this was just rambling :)
>
>
> >
> >>>> Perhaps it's better to keep huge_pte and contpte separate? Also, it
> >>>> only works on arm64 because we can get away with calling the lower-l=
evel pte
> >>>> functions even when the huge_pte is actually a contpmd/pmd/pud, beca=
use the
> >>>> format is the same. That might present challenges to other arches if=
 the format
> >>>> is different?
> >>> Yes, but I think that if that happens, we could get away with it by
> >>> choosing the right function depending on the size of the mapping?
> >>>
> >>>>    - It might be easier to review if the arm64 stuff is first moved =
(without
> >>>> changes) then modified to make it suitable for riscv, then for riscv=
 to be
> >>>> hooked up. At the moment I'm trying to follow all 3 parts per-functi=
on.
> >>> Ok, let me give it a try during your paternity leave!
> > Review would certainly be easier with this approach!
>
>
> I'll do my best to do that soon.

So I finally have time to rework this and I tested moving all the
arm64 functions first and then adapting them to riscv. But I can't
modify a function at a time as it fails to build for riscv, since the
not-yet-adapted functions are arm64 specific. So I'd have to come with
a big monolithic patch that changes everything at once, which I think
will not help the review process.

So I'll keep the same format and should be back soon with the new version.

Thanks,

Alex

>
> Hope everything went well for you.
>
> Thanks,
>
> Alex
>
>
> >
> > Thanks,
> > Ryan
> >
> >>>> Thanks,
> >>>> Ryan
> >>> Thanks,
> >>>
> >>> Alex
> >>>
> >>>>> This patchset was tested by running the libhugetlbfs testsuite with=
 64KB
> >>>>> and 2MB pages on both architectures (on a 4KB base page size arm64 =
kernel).
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-r=
yan.roberts@arm.com/
> >>>>>
> >>>>> Changes in v2:
> >>>>>     - Rebase on top of 6.9-rc3
> >>>>>
> >>>>> Alexandre Ghiti (9):
> >>>>>     riscv: Restore the pfn in a NAPOT pte when manipulated by core =
mm code
> >>>>>     riscv: Safely remove huge_pte_offset() when manipulating NAPOT =
ptes
> >>>>>     mm: Use common huge_ptep_get() function for riscv/arm64
> >>>>>     mm: Use common set_huge_pte_at() function for riscv/arm64
> >>>>>     mm: Use common huge_pte_clear() function for riscv/arm64
> >>>>>     mm: Use common huge_ptep_get_and_clear() function for riscv/arm=
64
> >>>>>     mm: Use common huge_ptep_set_access_flags() function for riscv/=
arm64
> >>>>>     mm: Use common huge_ptep_set_wrprotect() function for riscv/arm=
64
> >>>>>     mm: Use common huge_ptep_clear_flush() function for riscv/arm64
> >>>>>
> >>>>>    arch/arm64/Kconfig                  |   1 +
> >>>>>    arch/arm64/include/asm/pgtable.h    |  56 +++++-
> >>>>>    arch/arm64/mm/hugetlbpage.c         | 291 +---------------------=
------
> >>>>>    arch/riscv/Kconfig                  |   1 +
> >>>>>    arch/riscv/include/asm/hugetlb.h    |   2 +-
> >>>>>    arch/riscv/include/asm/pgtable-64.h |  11 ++
> >>>>>    arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
> >>>>>    arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
> >>>>>    arch/riscv/mm/pgtable.c             |   6 +-
> >>>>>    mm/Kconfig                          |   3 +
> >>>>>    mm/Makefile                         |   1 +
> >>>>>    mm/contpte.c                        | 272 ++++++++++++++++++++++=
++++
> >>>>>    12 files changed, 480 insertions(+), 544 deletions(-)
> >>>>>    create mode 100644 mm/contpte.c
> >>>>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv


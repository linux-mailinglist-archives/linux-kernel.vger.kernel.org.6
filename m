Return-Path: <linux-kernel+bounces-304089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2968961A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA391C22750
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F961D4171;
	Tue, 27 Aug 2024 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cePrcmgI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B21D0DE4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798186; cv=none; b=HzZ0E+tjg5zalVal+24lOa2OC2wZY32xee1WTSmPExpXEiss7HpWAwI+iTaO4PsrpF6JWl36NYzDA17aTgF9thLhgJK6skDxsmq0dlTIlxjIXxJ291A1koNsuldxyLTi3isuHig5P3JJ3OYqjVsHYPF38C2BkJrVLn3DHh6U4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798186; c=relaxed/simple;
	bh=X9PYKJLgK0Anu/T+r7Cmv4P5xnYLXYtrA6NmjBpmoHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuoUrX6qFWLGfPVamPSBfQF+7fNwgpCUXeJFxfM3+Rci58cP6vWeAq97/qVindar2lP9HC25I9MZi98dtLUEhImYf0SIpIm8Dbq1Ikwa2Q4a/9WI4iAcyDmNKHB2TjYRvCmM1KsDIQecUQZR4/hYU9IdQnqWPUyWajcVQIYnWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cePrcmgI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso10835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724798183; x=1725402983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7Z8bHC9lXhnYf47HvMGTMfGY056hXU2IGQLlFcO8fg=;
        b=cePrcmgInHKguhPNF7wx48Y7bYWxjaJIjgPtqDM97GaeyCf7tSGx7u69M3gXT4vhGi
         OG0SBL+T1UgB6lHXnXK3QNAEKXxGwl5DbAZh5GRMs6enInKYswijENUJCP6z3s32+Tla
         wL1BfL9jvqHWbsrZ/N8ZbR9L5uiEzv84l+k0fAPbCrFKSiuayRwJzwlpMmfaqnWCqY4w
         s8lkweCRmrtitI36q9rubDPq7ze2roZzBxyDCQry2rAiLOBQH3YsP2wp1+i9waP7p8QE
         e7pbXnl5PwpjLsK0h/WkARmdbVpikSA8kKZH/ZmRu3jmyOYYVndHUi5WOBp1tnDURPp+
         ASJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798183; x=1725402983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7Z8bHC9lXhnYf47HvMGTMfGY056hXU2IGQLlFcO8fg=;
        b=coTm5N2V8Tto9fIg0gwp33pgt326QjoUeqc9nC/XZS0YvxTEkVDCGSB0AGW1jPteRf
         UEmJ6JkH1f3kOyNdHp7Qh2l8VdjXVdBp+TvNe7ypznxPJL9RLR6VlwoePPLNE3kPXplP
         QIRYi9b1BxYJuFaUS33MDGpawT6KkIYjnz6ldRStBtZ8JNE6xj1pBqa6LRfdenqV+S2v
         UjC2yU+xNwtFATp+RhJg88OY4VQNsyRTeDBkMUhvYuY4CltGhSX5jPA9yCXlIPD01Syz
         aYu5ED9FX6Aw4e2VJ6npsEE3KmtnOn9Zl+3mb+sGuEX+csj0YNuKTfJjQ/zWkddjadJ/
         Ms0g==
X-Gm-Message-State: AOJu0YwW+fT7l3wFR3VXYh3WT27+lfftGClrKc3aylpmJ1y7/tAqW4UI
	yi/pJtLKa1lZ2fs83HPqXwrJmWMvBKrC5vNpjzDVvHxdfQMTLePPMadkpaFCKmTxSfwpC3BrlCL
	SqEocdeXS+b8CUsAxuiFLfTkePTV36UEVcuZA
X-Google-Smtp-Source: AGHT+IERarZz0t8KpbIzW+ZARbyqwfuN177nAbHR5HvRaocRDTIom/7x2jD8I5SxtyZhmQnBn5njFCAOBfVRulF8IDU=
X-Received: by 2002:a05:600c:1e20:b0:426:68ce:c97a with SMTP id
 5b1f17b1804b1-42ba50d0ba9mr209745e9.7.1724798181619; Tue, 27 Aug 2024
 15:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826204353.2228736-1-peterx@redhat.com>
In-Reply-To: <20240826204353.2228736-1-peterx@redhat.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 27 Aug 2024 15:36:07 -0700
Message-ID: <CACw3F50Zi7CQsSOcCutRUy1h5p=7UBw7ZRGm4WayvsnuuEnKow@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] mm: Support huge pfnmaps
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Gavin Shan <gshan@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Alistair Popple <apopple@nvidia.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Sean Christopherson <seanjc@google.com>, 
	Oscar Salvador <osalvador@suse.de>, Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>, 
	Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Hildenbrand <david@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 1:44=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> v2:
> - Added tags
> - Let folio_walk_start() scan special pmd/pud bits [DavidH]
> - Switch copy_huge_pmd() COW+writable check into a VM_WARN_ON_ONCE()
> - Update commit message to drop mentioning of gup-fast, in patch "mm: Mar=
k
>   special bits for huge pfn mappings when inject" [JasonG]
> - In gup-fast, reorder _special check v.s. _devmap check, so as to make
>   pmd/pud path look the same as pte path [DavidH, JasonG]
> - Enrich comments for follow_pfnmap*() API, emphasize the risk when PFN i=
s
>   used after the end() is invoked, s/-ve/negative/ [JasonG, Sean]
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> This series is based on mm-unstable, commit b659edec079c of Aug 26th
> latest, with patch "vma remove the unneeded avc bound with non-CoWed foli=
o"
> reverted, as reported broken [0].
>
> This series implements huge pfnmaps support for mm in general.  Huge pfnm=
ap
> allows e.g. VM_PFNMAP vmas to map in either PMD or PUD levels, similar to
> what we do with dax / thp / hugetlb so far to benefit from TLB hits.  Now
> we extend that idea to PFN mappings, e.g. PCI MMIO bars where it can grow
> as large as 8GB or even bigger.
>
> Currently, only x86_64 (1G+2M) and arm64 (2M) are supported.  The last
> patch (from Alex Williamson) will be the first user of huge pfnmap, so as
> to enable vfio-pci driver to fault in huge pfn mappings.
>
> Implementation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In reality, it's relatively simple to add such support comparing to many
> other types of mappings, because of PFNMAP's specialties when there's no
> vmemmap backing it, so that most of the kernel routines on huge mappings
> should simply already fail for them, like GUPs or old-school follow_page(=
)
> (which is recently rewritten to be folio_walk* APIs by David).
>
> One trick here is that we're still unmature on PUDs in generic paths here
> and there, as DAX is so far the only user.  This patchset will add the 2n=
d
> user of it.  Hugetlb can be a 3rd user if the hugetlb unification work ca=
n
> go on smoothly, but to be discussed later.
>
> The other trick is how to allow gup-fast working for such huge mappings
> even if there's no direct sign of knowing whether it's a normal page or
> MMIO mapping.  This series chose to keep the pte_special solution, so tha=
t
> it reuses similar idea on setting a special bit to pfnmap PMDs/PUDs so th=
at
> gup-fast will be able to identify them and fail properly.
>
> Along the way, we'll also notice that the major pgtable pfn walker, aka,
> follow_pte(), will need to retire soon due to the fact that it only works
> with ptes.  A new set of simple API is introduced (follow_pfnmap* API) to
> be able to do whatever follow_pte() can already do, plus that it can also
> process huge pfnmaps now.  Half of this series is about that and converti=
ng
> all existing pfnmap walkers to use the new API properly.  Hopefully the n=
ew
> API also looks better to avoid exposing e.g. pgtable lock details into th=
e
> callers, so that it can be used in an even more straightforward way.
>
> Here, three more options will be introduced and involved in huge pfnmap:
>
>   - ARCH_SUPPORTS_HUGE_PFNMAP
>
>     Arch developers will need to select this option when huge pfnmap is
>     supported in arch's Kconfig.  After this patchset applied, both x86_6=
4
>     and arm64 will start to enable it by default.
>
>   - ARCH_SUPPORTS_PMD_PFNMAP / ARCH_SUPPORTS_PUD_PFNMAP
>
>     These options are for driver developers to identify whether current
>     arch / config supports huge pfnmaps, making decision on whether it ca=
n
>     use the huge pfnmap APIs to inject them.  One can refer to the last
>     vfio-pci patch from Alex on the use of them properly in a device
>     driver.
>
> So after the whole set applied, and if one would enable some dynamic debu=
g
> lines in vfio-pci core files, we should observe things like:
>
>   vfio-pci 0000:00:06.0: vfio_pci_mmap_huge_fault(,order =3D 9) BAR 0 pag=
e offset 0x0: 0x100
>   vfio-pci 0000:00:06.0: vfio_pci_mmap_huge_fault(,order =3D 9) BAR 0 pag=
e offset 0x200: 0x100
>   vfio-pci 0000:00:06.0: vfio_pci_mmap_huge_fault(,order =3D 9) BAR 0 pag=
e offset 0x400: 0x100
>
> In this specific case, it says that vfio-pci faults in PMDs properly for =
a
> few BAR0 offsets.
>
> Patch Layout
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Patch 1:         Introduce the new options mentioned above for huge PFNMA=
Ps
> Patch 2:         A tiny cleanup
> Patch 3-8:       Preparation patches for huge pfnmap (include introduce
>                  special bit for pmd/pud)
> Patch 9-16:      Introduce follow_pfnmap*() API, use it everywhere, and
>                  then drop follow_pte() API
> Patch 17:        Add huge pfnmap support for x86_64
> Patch 18:        Add huge pfnmap support for arm64
> Patch 19:        Add vfio-pci support for all kinds of huge pfnmaps (Alex=
)
>
> TODO
> =3D=3D=3D=3D
>
> More architectures / More page sizes
> ------------------------------------
>
> Currently only x86_64 (2M+1G) and arm64 (2M) are supported.  There seems =
to
> have plan to support arm64 1G later on top of this series [2].
>
> Any arch will need to first support THP / THP_1G, then provide a special
> bit in pmds/puds to support huge pfnmaps.
>
> remap_pfn_range() support
> -------------------------
>
> Currently, remap_pfn_range() still only maps PTEs.  With the new option,
> remap_pfn_range() can logically start to inject either PMDs or PUDs when
> the alignment requirements match on the VAs.
>
> When the support is there, it should be able to silently benefit all
> drivers that is using remap_pfn_range() in its mmap() handler on better T=
LB
> hit rate and overall faster MMIO accesses similar to processor on hugepag=
es.
>

Hi Peter,

I am curious if there is any work needed for unmap_mapping_range? If a
driver hugely remap_pfn_range()ed at 1G granularity, can the driver
unmap at PAGE_SIZE granularity? For example, when handling a PFN is
poisoned in the 1G mapping, it would be great if the mapping can be
splitted to 2M mappings + 4k mappings, so only the single poisoned PFN
is lost. (Pretty much like the past proposal* to use HGM** to improve
hugetlb's memory failure handling).

Probably these questions can be answered after reading your code,
which I plan to do, but just want to ask in case you have an easy
answer for me.

* https://patchwork.plctlab.org/project/linux-kernel/cover/20230428004139.2=
899856-1-jiaqiyan@google.com/
** https://lwn.net/Articles/912017

> More driver support
> -------------------
>
> VFIO is so far the only consumer for the huge pfnmaps after this series
> applied.  Besides above remap_pfn_range() generic optimization, device
> driver can also try to optimize its mmap() on a better VA alignment for
> either PMD/PUD sizes.  This may, iiuc, normally require userspace changes=
,
> as the driver doesn't normally decide the VA to map a bar.  But I don't
> think I know all the drivers to know the full picture.
>
> Tests Done
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Cross-build tests
>
> - run_vmtests.sh
>
> - Hacked e1000e QEMU with 128MB BAR 0, with some prefault test, mprotect(=
)
>   and fork() tests on the bar mapped
>
> - x86_64 + AMD GPU
>   - Needs Alex's modified QEMU to guarantee proper VA alignment to make
>     sure all pages to be mapped with PUDs
>   - Main BAR (8GB) start to use PUD mappings
>   - Sub BAR (??MBs?) start to use PMD mappings
>   - Performance wise, slight improvement comparing to the old PTE mapping=
s
>
> - aarch64 + NIC
>   - Detached NIC test to make sure driver loads fine with PMD mappings
>
> Credits all go to Alex on help testing the GPU/NIC use cases above.
>
> Comments welcomed, thanks.
>
> [0] https://lore.kernel.org/r/73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucife=
r.local
> [1] https://lore.kernel.org/r/20240807194812.819412-1-peterx@redhat.com
> [2] https://lore.kernel.org/r/498e0731-81a4-4f75-95b4-a8ad0bcc7665@huawei=
.com
>
> Alex Williamson (1):
>   vfio/pci: Implement huge_fault support
>
> Peter Xu (18):
>   mm: Introduce ARCH_SUPPORTS_HUGE_PFNMAP and special bits to pmd/pud
>   mm: Drop is_huge_zero_pud()
>   mm: Mark special bits for huge pfn mappings when inject
>   mm: Allow THP orders for PFNMAPs
>   mm/gup: Detect huge pfnmap entries in gup-fast
>   mm/pagewalk: Check pfnmap for folio_walk_start()
>   mm/fork: Accept huge pfnmap entries
>   mm: Always define pxx_pgprot()
>   mm: New follow_pfnmap API
>   KVM: Use follow_pfnmap API
>   s390/pci_mmio: Use follow_pfnmap API
>   mm/x86/pat: Use the new follow_pfnmap API
>   vfio: Use the new follow_pfnmap API
>   acrn: Use the new follow_pfnmap API
>   mm/access_process_vm: Use the new follow_pfnmap API
>   mm: Remove follow_pte()
>   mm/x86: Support large pfn mappings
>   mm/arm64: Support large pfn mappings
>
>  arch/arm64/Kconfig                  |   1 +
>  arch/arm64/include/asm/pgtable.h    |  30 +++++
>  arch/powerpc/include/asm/pgtable.h  |   1 +
>  arch/s390/include/asm/pgtable.h     |   1 +
>  arch/s390/pci/pci_mmio.c            |  22 ++--
>  arch/sparc/include/asm/pgtable_64.h |   1 +
>  arch/x86/Kconfig                    |   1 +
>  arch/x86/include/asm/pgtable.h      |  80 +++++++-----
>  arch/x86/mm/pat/memtype.c           |  17 ++-
>  drivers/vfio/pci/vfio_pci_core.c    |  60 ++++++---
>  drivers/vfio/vfio_iommu_type1.c     |  16 +--
>  drivers/virt/acrn/mm.c              |  16 +--
>  include/linux/huge_mm.h             |  16 +--
>  include/linux/mm.h                  |  57 ++++++++-
>  include/linux/pgtable.h             |  12 ++
>  mm/Kconfig                          |  13 ++
>  mm/gup.c                            |   6 +
>  mm/huge_memory.c                    |  50 +++++---
>  mm/memory.c                         | 183 ++++++++++++++++++++--------
>  mm/pagewalk.c                       |   4 +-
>  virt/kvm/kvm_main.c                 |  19 ++-
>  21 files changed, 425 insertions(+), 181 deletions(-)
>
> --
> 2.45.0
>
>


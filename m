Return-Path: <linux-kernel+bounces-434280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED81B9E6452
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A001B284818
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F06170A26;
	Fri,  6 Dec 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UhQ3GVaO"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE7364A9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452903; cv=none; b=iAZDLS66fdVVfFT8RHKkZKnKjOqPwxY7nNTMGCCnhwUg4SBu79rRxni65DhIvacbhW3hfbUs8jgLOT6FwGsZqYsPAwAOZIvhT7FneyLDxrz1cdiebSEvtK1FA84TsKy78Xks29N0zrZnuhkcZmBqVdlnZkpAU3TJgGmfiJPOndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452903; c=relaxed/simple;
	bh=sMpaNd5ke1oeV8iepSyG4ZGV5tFg6kNXx55oc5niHac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVXvUeKj+RhUu2R8RNtgPlVGWOgat5eR4D/ukG+8tmk5X7vGVIwseK6egU8FcWthaXlyjUqN52dXF56YkAAUMuzHCFnQvP09MOVsakUcg7k+zEC7QpRmYUYC6wRBzi95kack0Fe6PxY/VNq+7AVN9scdzskmofVkoyWSm4Ybjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UhQ3GVaO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso1152215a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 18:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733452899; x=1734057699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyI1vpJbF1lA2GSyRq3p1fE6a3Gj94zXoVwVDWf3HLY=;
        b=UhQ3GVaOZUetr2/P5QHyc9DQ+JmtnK6inPrlNH3VFjsDGSleEkwdAS9hL1Qr+hXkze
         jDyUeXqnxCqmf4osoL4qWkb4/p/DArZPnf0nUklHgzLijLfZ+qBRbL5WH31UpZQe2D6H
         k9i8rKU6PcHraCLmcSBm/05e9gfnhigY8o7KMwQ8fIDvoVmjrfHH29JuxpY4wF2NFr9f
         xcsjudGQzp9rEMyRxCFM0z6EJcCOFHocDPEBy1NpIuAWW+9odAEV7+T0pJtISBl8yprT
         Q3zrngCitIYWN9JuDopVmQefIR2V/j3Ao4uWsPqMZQd//PScF6d5914JFBTehMDGlARC
         74Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733452899; x=1734057699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyI1vpJbF1lA2GSyRq3p1fE6a3Gj94zXoVwVDWf3HLY=;
        b=at9INw3wS85X4TJVBAr1otQyaPPHkeeVNZO7L2vNZgHmZ0cB1XmRK2vxQhKbbRlgOI
         CkUCcU2E1qyGaMTX9UCvqvA9owN/dBvHlBVjU+tJfYlijmOz3+XlRqPF60p+VYRtCbAX
         zGNWx3jTvw1V66pY2jpLSGQ/j41KbwpPlIY+Yc0OFHy9yGP60lVPWsvNizB1EXpm7CWd
         lKxsCD10zTyD08gNjtx6v0911sXK34N/H6/BPyxEstPcCnqI7+EY7rHohvM9WNcTNP7k
         wLLOIXr2qOPp5LwkYIZfgm80MMCb5bSUr5rq5mbCKc0EvhLnOw/ni+uU8VDXHJybH9uP
         JFpg==
X-Forwarded-Encrypted: i=1; AJvYcCUCd2+crkbvNC6hjs4QbqapC1nz/Eeu/dbosCxoRgEXWMm5eyxzamtE5X+qHYH8j6hAcHVQEHKPuQQRXZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LW+kjKb8TUQXRjfuLUGtG2W2O0JCJcnaDgKYx8ot8VCbtfFr
	Y28DsEzYpUzbLqftJxmoLb7IHv5AIUg3jJeWxULk5mcS8dUioePVGABweotke8/WWHtqMUf+9mu
	plDE+Hd9poHTI2nwzvhBh8Og+x619/Z93V1Adaw==
X-Gm-Gg: ASbGncshdjULU26XzjgxuQWE0A21WX0t2jEtdcaLhQoLqisdW8SIB/+Cvf8ojnhgKmF
	NNbh54s+rboPdx5psb9dRKwNCZuLRYJYDDTs5F4u0opgWwkSX
X-Google-Smtp-Source: AGHT+IEUYjjxoNVonXftGirFN2eYx0YoHUjkucusrRhp2lBZDnBg/ur7q7d/l8gQ0l23mUaXrY71JWBrqUptthTQgSA=
X-Received: by 2002:a17:90b:2ccd:b0:2ee:45fd:34ee with SMTP id
 98e67ed59e1d1-2ef6ab29c3emr2272187a91.37.1733452899670; Thu, 05 Dec 2024
 18:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205103729.14798-1-luxu.kernel@bytedance.com> <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com>
In-Reply-To: <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 6 Dec 2024 10:41:28 +0800
Message-ID: <CAPYmKFsODeUg69r+bjeH4tZuB4DyXNUjjduAPMbtAzVBhFgpEw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
To: Zi Yan <ziy@nvidia.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ardb@kernel.org, anup@brainfault.org, atishp@atishpatra.org, 
	xieyongji@bytedance.com, lihangjing@bytedance.com, 
	punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zi Yan,

On Fri, Dec 6, 2024 at 10:00=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 5 Dec 2024, at 5:37, Xu Lu wrote:
>
> > This patch series attempts to break through the limitation of MMU and
> > supports larger base page on RISC-V, which only supports 4K page size
> > now. The key idea is to always manage and allocate memory at a
> > granularity of 64K and use SVNAPOT to accelerate address translation.
> > This is the second version and the detailed introduction can be found
> > in [1].
> >
> > Changes from v1:
> > - Rebase on v6.12.
> >
> > - Adjust the page table entry shift to reduce page table memory usage.
> >     For example, in SV39, the traditional va behaves as:
> >
> >     ----------------------------------------------
> >     | pgd index | pmd index | pte index | offset |
> >     ----------------------------------------------
> >     | 38     30 | 29     21 | 20     12 | 11   0 |
> >     ----------------------------------------------
> >
> >     When we choose 64K as basic software page, va now behaves as:
> >
> >     ----------------------------------------------
> >     | pgd index | pmd index | pte index | offset |
> >     ----------------------------------------------
> >     | 38     34 | 33     25 | 24     16 | 15   0 |
> >     ----------------------------------------------
> >
> > - Fix some bugs in v1.
> >
> > Thanks in advance for comments.
> >
> > [1] https://lwn.net/Articles/952722/
>
> This looks very interesting. Can you cc me and linux-mm@kvack.org
> in the future? Thanks.

Of course. Hope this patch can be of any help.

>
> Have you thought about doing it for ARM64 4KB as well? ARM64=E2=80=99s co=
ntig PTE
> should have similar effect of RISC-V=E2=80=99s SVNAPOT, right?

I have not thought about it yet. ARM64 has native 64K MMU. The kernel
can directly configure the page size as 64K and MMU will do
translation at corresponding granularity. So I doubt if there is a
need to implement 64K Page Size based on CONT PTE. If you want to use
CONT PTE for acceleration instead of 64K MMU, maybe you can have a try
on THP_CONTPTE[1] which has been merged~

[1] https://lwn.net/Articles/935887/

Best regards,

Xu Lu

>
> >
> > Xu Lu (21):
> >   riscv: mm: Distinguish hardware base page and software base page
> >   riscv: mm: Configure satp with hw page pfn
> >   riscv: mm: Reimplement page table entry structures
> >   riscv: mm: Reimplement page table entry constructor function
> >   riscv: mm: Reimplement conversion functions between page table entry
> >   riscv: mm: Avoid pte constructor during pte conversion
> >   riscv: mm: Reimplement page table entry get function
> >   riscv: mm: Reimplement page table entry atomic get function
> >   riscv: mm: Replace READ_ONCE with atomic pte get function
> >   riscv: mm: Reimplement PTE A/D bit check function
> >   riscv: mm: Reimplement mk_huge_pte function
> >   riscv: mm: Reimplement tlb flush function
> >   riscv: mm: Adjust PGDIR/P4D/PUD/PMD_SHIFT
> >   riscv: mm: Only apply svnapot region bigger than software page
> >   riscv: mm: Adjust FIX_BTMAPS_SLOTS for variable PAGE_SIZE
> >   riscv: mm: Adjust FIX_FDT_SIZE for variable PMD_SIZE
> >   riscv: mm: Apply Svnapot for base page mapping if possible
> >   riscv: Kconfig: Introduce 64K page size
> >   riscv: Kconfig: Adjust mmap rnd bits for 64K Page
> >   riscv: mm: Adjust address space layout and init page table for 64K
> >     Page
> >   riscv: mm: Update EXEC_PAGESIZE for 64K Page
> >
> >  arch/riscv/Kconfig                    |  34 +-
> >  arch/riscv/include/asm/fixmap.h       |   3 +-
> >  arch/riscv/include/asm/hugetlb.h      |   5 +
> >  arch/riscv/include/asm/page.h         |  56 ++-
> >  arch/riscv/include/asm/pgtable-32.h   |  12 +-
> >  arch/riscv/include/asm/pgtable-64.h   | 128 ++++--
> >  arch/riscv/include/asm/pgtable-bits.h |   3 +-
> >  arch/riscv/include/asm/pgtable.h      | 564 +++++++++++++++++++++++---
> >  arch/riscv/include/asm/tlbflush.h     |  26 +-
> >  arch/riscv/include/uapi/asm/param.h   |  24 ++
> >  arch/riscv/kernel/head.S              |   4 +-
> >  arch/riscv/kernel/hibernate.c         |  21 +-
> >  arch/riscv/mm/context.c               |   7 +-
> >  arch/riscv/mm/fault.c                 |  15 +-
> >  arch/riscv/mm/hugetlbpage.c           |  30 +-
> >  arch/riscv/mm/init.c                  |  45 +-
> >  arch/riscv/mm/kasan_init.c            |   7 +-
> >  arch/riscv/mm/pgtable.c               | 111 ++++-
> >  arch/riscv/mm/tlbflush.c              |  31 +-
> >  arch/s390/include/asm/hugetlb.h       |   2 +-
> >  include/asm-generic/hugetlb.h         |   5 +-
> >  include/linux/pgtable.h               |  21 +
> >  kernel/events/core.c                  |   6 +-
> >  mm/debug_vm_pgtable.c                 |   6 +-
> >  mm/gup.c                              |  10 +-
> >  mm/hmm.c                              |   2 +-
> >  mm/hugetlb.c                          |   4 +-
> >  mm/mapping_dirty_helpers.c            |   2 +-
> >  mm/memory.c                           |   4 +-
> >  mm/mprotect.c                         |   2 +-
> >  mm/ptdump.c                           |   8 +-
> >  mm/sparse-vmemmap.c                   |   2 +-
> >  mm/vmscan.c                           |   2 +-
> >  33 files changed, 1029 insertions(+), 173 deletions(-)
> >  create mode 100644 arch/riscv/include/uapi/asm/param.h
> >
> > --
> > 2.20.1
>
>
> Best Regards,
> Yan, Zi


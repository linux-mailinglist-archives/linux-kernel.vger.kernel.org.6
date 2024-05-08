Return-Path: <linux-kernel+bounces-173482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F157A8C00E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79CB289297
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566554FA3;
	Wed,  8 May 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHQXO6lQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109C127B68
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181941; cv=none; b=e4J0/eQ2DTmJSRmzcPGMjz4wmL2QsEuEI3okZU1kAo+KFRkHv/EO0mVKWRrq24b9F7fRPrOc/Y/MYg/DyBg6nxuYIEwLiFzIuxmHoQ+Oh157pySml4/pAXX5K8HFIXzU+dBLv5cWdKHR6hZxZTjnS4u8eNVUFcmwdlBN80GuIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181941; c=relaxed/simple;
	bh=UL93JwU4TQ8z1MmbqB26f35BXls3RFBS4jo/9zycyO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AG6D3FRObAIMYpKIc8S507jbzf2nJreKcxJI37rLuNUi7CHOl4TMdULEuPBIeBfoIJmCw3ZhM0PFL2lJoeNsBbn944Cii3VpeGApKXmrIFkLJC9noZYAlTkyhGbtsXjhdHhrTlmoR92wAHM1hZJBHLICwe/BBoAKg0noC714Nmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHQXO6lQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so5343936e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715181937; x=1715786737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6NPiKyKurDlabmpC6QSly3h2VfCRzqtNRBYDTEGWtQ=;
        b=PHQXO6lQIWa6E6Q12sqS4XRr+YsO9apkONb6asFQC8bVSRmBg++KfZtExV7IXPpUvo
         psBHKi13N3vlKDNDGf4Pdf1tQAmBVPp+S5nXMxyMhQsQq9x4yP0nBxXwQorlBby3eTAq
         KVST7p4dWfXmLku154HDC//zkwFno2IjdAikz7qy+9xFaV+mL6Z6dUfHqqsR+IxArzPR
         F5Ar/ufKA4TFl71nGrr0M8zIMElEstIKDkRRSFlX8UXFoRCGBKW6cnw0JTOD1ebPIATn
         XQmiqQxlLCW7emcZBRsFZPaT4zPRY/9Ek4uis1j4gV6P4fZ21VHOBWf+BzixiUkMS/rO
         WdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181937; x=1715786737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6NPiKyKurDlabmpC6QSly3h2VfCRzqtNRBYDTEGWtQ=;
        b=h2BbebsuM9FIeQ4gbd5xZca7vb5xkVZqeSCb1gkJym8+eXzbeco4cuAE3t0OMnZNFT
         VH6d9Py5I1Gjjj1mk5sS30CvaaoaR5t5RGLoZ7pggQW7++B5xjB2ageqWhGTo7CzBcrt
         oRIGkSX/+Yb9EzoV0O9Lr+cG2fZ4RXg6ihUsvme6LVwD58pQ3a2uM5zh4cwkG19xZOLF
         Oi6YEzQkkm5hRxdiMzfM0AMzAEd2t+RXHMW1TWeIIZPj6j25qZaeUEeYUaMmH6wKy5cl
         U52oY7dLiwfo8Zg59Cp9bL65MF9cBLF7qaZHZHdyadnvwVRze5ysCDWP+dmDSGKxCwwz
         zURw==
X-Forwarded-Encrypted: i=1; AJvYcCXSw7ryENes2ZxJJsnYfmJrQxBYuS323FOYGYt7KvBMW/2eL6aOd77YQVeVlVX7c0Y2H9qm41jUI7r2DJu/hp6f3KKN+5nEt3fT7Pzd
X-Gm-Message-State: AOJu0YwM0GiThRYyJ4UcwJszcTEGdaqfZuUX+qI8yi04i3266KE06KN9
	xPnbToioxqqOllUEDpQxt+5n/8olOWkZTCBZ3h+dglFoj0XfSGYCcMNjS2PqangHvdf2cI5kvly
	D0yPBnGZgww1S0D3aGb5Dxna6m6M=
X-Google-Smtp-Source: AGHT+IEbBjMMfSQ1BZQCIZeVVo1+efpRaTdZ06EBYRC7uNqEeLb2x1Xc3ztkKK6L9S5kwVybN+ytYEjiVtk+jlUF1pU=
X-Received: by 2002:ac2:42cd:0:b0:51c:d876:710c with SMTP id
 2adb3069b0e04-5217c667197mr1740215e87.37.1715181937073; Wed, 08 May 2024
 08:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com> <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com> <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com> <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com> <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com> <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
 <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com> <da24d8bb-3723-48fa-86f4-8b24457d3556@huawei.com>
 <2b403705-a03c-4cfe-8d95-b38dd83fca52@arm.com> <CAHbLzkq9BQFfpjxG_ozrgzWOO3XJmtre-mgY03McY6guVn7U9g@mail.gmail.com>
 <281aebf1-0bff-4858-b479-866eb05b9e94@huawei.com> <219cb8e3-a77b-468b-9d69-0b3e386f93f6@arm.com>
 <7d8c43b6-b1ef-428e-9d6a-1c26284feb26@huawei.com>
In-Reply-To: <7d8c43b6-b1ef-428e-9d6a-1c26284feb26@huawei.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 8 May 2024 08:25:25 -0700
Message-ID: <CAHbLzkpYWusx85nPD_Ywxvg5cLuxVLMhu91NO8-zidgBjKN7yg@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, 
	cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Ze Zuo <zuoze1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 6:37=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei.=
com> wrote:
>
>
>
> On 2024/5/8 16:36, Ryan Roberts wrote:
> > On 08/05/2024 08:48, Kefeng Wang wrote:
> >>
> >>
> >> On 2024/5/8 1:17, Yang Shi wrote:
> >>> On Tue, May 7, 2024 at 8:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>>>
> >>>> On 07/05/2024 14:53, Kefeng Wang wrote:
> >>>>>
> >>>>>
> >>>>> On 2024/5/7 19:13, David Hildenbrand wrote:
> >>>>>>
> >>>>>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
> >>>>>>>
> >>>>>>>> suggest. If you want to try something semi-randomly; it might be=
 useful
> >>>>>>>> to rule
> >>>>>>>> out the arm64 contpte feature. I don't see how that would be int=
eracting
> >>>>>>>> here if
> >>>>>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. D=
isable with
> >>>>>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
> >>>>>>> I don't enabled mTHP, so it should be not related about ARM64_CON=
TPTE,
> >>>>>>> but will have a try.
> >>>>>
> >>>>> After ARM64_CONTPTE disabled, memory read latency is similar with A=
RM64_CONTPTE
> >>>>> enabled(default 6.9-rc7), still larger than align anon reverted.
> >>>>
> >>>> OK thanks for trying.
> >>>>
> >>>> Looking at the source for lmbench, its malloc'ing (512M + 8K) up fro=
nt and using
> >>>> that for all sizes. That will presumably be considered "large" by ma=
lloc and
> >>>> will be allocated using mmap. So with the patch, it will be 2M align=
ed. Without
> >>>> it, it probably won't. I'm still struggling to understand why not al=
igning it in
> >>>> virtual space would make it more performant though...
> >>>
> >>> Yeah, I'm confused too.
> >> Me too, I get a smaps[_rollup] for 0.09375M size, the biggest differen=
ce
> >> for anon shows below, and all attached.
> >
> > OK, a bit more insight; during initialization, the test makes 2 big mal=
loc
> > calls; the first is 1M and the second is 512M+8K. I think those 2 are t=
he 2 vmas
> > below (malloc is adding an extra page to the allocation, presumably for
> > management structures).
> >
> > With efa7df3e3bb5 applied, the 1M allocation is allocated at a non-THP-=
aligned
> > address. All of its pages are populated (see permutation() which alloca=
tes and
> > writes it) but none of them are THP (obviously - its only 1M and THP is=
 only
> > enabled for 2M). But the 512M region is allocated at a THP-aligned addr=
ess. And
> > the first page is populated with a THP (presumably faulted when malloc =
writes to
> > its control structure page before the application even sees the allocat=
ed buffer.
> >
> > In contrast, when efa7df3e3bb5 is reverted, neither of the vmas are THP=
-aligned,
> > and therefore the 512M region abutts the 1M region and the vmas are mer=
ged in
> > the kernel. So we end up with the single 525328 kB region. There are no=
 THPs
> > allocated here (due to alignment constraiints) so we end up with the 1M=
 region
> > fully populated with 4K pages as before, and only the malloc control pa=
ge plus
> > the parts of the buffer that the application actually touches being pop=
ulated in
> > the 512M region.
> >
> > As far as I can tell, the application never touches the 1M region durin=
g the
> > test so it should be cache-cold. It only touches the first part of the =
512M
> > buffer it needs for the size of the test (96K here?). The latency of al=
locating
> > the THP will have been consumed during test setup so I doubt we are see=
ing that
> > in the test results and I don't see why having a single TLB entry vs 96=
K/4K=3D24
> > entries would make it slower.
>
> It is strange, and even more stranger, I got another machine(old machine
> 128 core and the new machine 96 core, but with same L1/L2 cache size
> per-core), the new machine without this issue, will contact with our
> hardware team, maybe some different configurations(prefetch or some
> other similar hardware configurations) , thank for all the suggestion
> and analysis!

Yes, the benchmark result strongly relies on cache and memory
subsystem. See the below analysis.

>
>
> >
> > It would be interesting to know the address that gets returned from mal=
loc for
> > the 512M region if that's possible to get (in both cases)? I guess it i=
s offset
> > into the first page. Perhaps it is offset such that with the THP alignm=
ent case
> > the 96K of interest ends up straddling 3 cache lines (cache line is 64K=
 I
> > assume?), but for the unaligned case, it ends up nicely packed in 2?
>
> CC zuoze, please help to check this.
>
> Thank again.
> >
> > Thanks,
> > Ryan
> >
> >>
> >> 1) with efa7df3e3bb5 smaps
> >>
> >> ffff68e00000-ffff88e03000 rw-p 00000000 00:00 0
> >> Size:             524300 kB
> >> KernelPageSize:        4 kB
> >> MMUPageSize:           4 kB
> >> Rss:                2048 kB
> >> Pss:                2048 kB
> >> Pss_Dirty:          2048 kB
> >> Shared_Clean:          0 kB
> >> Shared_Dirty:          0 kB
> >> Private_Clean:         0 kB
> >> Private_Dirty:      2048 kB
> >> Referenced:         2048 kB
> >> Anonymous:          2048 kB // we have 1 anon thp
> >> KSM:                   0 kB
> >> LazyFree:              0 kB
> >> AnonHugePages:      2048 kB
> >
> > Yes one 2M THP shown here.

You have THP allocated. W/o commit efa7df3e3bb5 the address may be not
PMD aligned (it still could be, but just not that likely), the base
pages were allocated. To get an apple to apple comparison, you need to
disable THP by setting /sys/kernel/mm/transparent_hugepage/enabled to
madvise or never, then you will get base pages too (IIRC lmbench
doesn't call MADV_HUGEPAGE).

The address alignment or page size may have a negative impact to your
CPU's cache and memory subsystem, for example, hw prefetcher. But I
saw a slight improvement with THP on my machine. So the behavior
strongly depends on the hardware.

> >
> >> ShmemPmdMapped:        0 kB
> >> FilePmdMapped:         0 kB
> >> Shared_Hugetlb:        0 kB
> >> Private_Hugetlb:       0 kB
> >> Swap:                  0 kB
> >> SwapPss:               0 kB
> >> Locked:                0 kB
> >> THPeligible:           1
> >> VmFlags: rd wr mr mw me ac
> >> ffff88eff000-ffff89000000 rw-p 00000000 00:00 0
> >> Size:               1028 kB
> >> KernelPageSize:        4 kB
> >> MMUPageSize:           4 kB
> >> Rss:                1028 kB
> >> Pss:                1028 kB
> >> Pss_Dirty:          1028 kB
> >> Shared_Clean:          0 kB
> >> Shared_Dirty:          0 kB
> >> Private_Clean:         0 kB
> >> Private_Dirty:      1028 kB
> >> Referenced:         1028 kB
> >> Anonymous:          1028 kB // another large anon
> >
> > This is not THP, since you only have 2M THP enabled. This will be 1M of=
 4K page
> > allocations + 1 4K page malloc control structure, allocated and accesse=
d by
> > permutation() during test setup.
> >
> >> KSM:                   0 kB
> >> LazyFree:              0 kB
> >> AnonHugePages:         0 kB
> >> ShmemPmdMapped:        0 kB
> >> FilePmdMapped:         0 kB
> >> Shared_Hugetlb:        0 kB
> >> Private_Hugetlb:       0 kB
> >> Swap:                  0 kB
> >> SwapPss:               0 kB
> >> Locked:                0 kB
> >> THPeligible:           0
> >> VmFlags: rd wr mr mw me ac
> >>
> >> and the smap_rollup
> >>
> >> 00400000-fffff56bd000 ---p 00000000 00:00 0 [rollup]
> >> Rss:                4724 kB
> >> Pss:                3408 kB
> >> Pss_Dirty:          3338 kB
> >> Pss_Anon:           3338 kB
> >> Pss_File:             70 kB
> >> Pss_Shmem:             0 kB
> >> Shared_Clean:       1176 kB
> >> Shared_Dirty:        420 kB
> >> Private_Clean:         0 kB
> >> Private_Dirty:      3128 kB
> >> Referenced:         4344 kB
> >> Anonymous:          3548 kB
> >> KSM:                   0 kB
> >> LazyFree:              0 kB
> >> AnonHugePages:      2048 kB
> >> ShmemPmdMapped:        0 kB
> >> FilePmdMapped:         0 kB
> >> Shared_Hugetlb:        0 kB
> >> Private_Hugetlb:       0 kB
> >> Swap:                  0 kB
> >> SwapPss:               0 kB
> >> Locked:                0 kB
> >>
> >> 2) without efa7df3e3bb5 smaps
> >>
> >> ffff9845b000-ffffb855f000 rw-p 00000000 00:00 0
> >> Size:             525328 kB
> >
> > This is a merged-vma version of the above 2 regions.
> >
> >> KernelPageSize:        4 kB
> >> MMUPageSize:           4 kB
> >> Rss:                1128 kB
> >> Pss:                1128 kB
> >> Pss_Dirty:          1128 kB
> >> Shared_Clean:          0 kB
> >> Shared_Dirty:          0 kB
> >> Private_Clean:         0 kB
> >> Private_Dirty:      1128 kB
> >> Referenced:         1128 kB
> >> Anonymous:          1128 kB // only large anon
> >> KSM:                   0 kB
> >> LazyFree:              0 kB
> >> AnonHugePages:         0 kB
> >> ShmemPmdMapped:        0 kB
> >> FilePmdMapped:         0 kB
> >> Shared_Hugetlb:        0 kB
> >> Private_Hugetlb:       0 kB
> >> Swap:                  0 kB
> >> SwapPss:               0 kB
> >> Locked:                0 kB
> >> THPeligible:           1
> >> VmFlags: rd wr mr mw me ac
> >>
> >> and the smap_rollup,
> >>
> >> 00400000-ffffca5dc000 ---p 00000000 00:00 0 [rollup]
> >> Rss:                2600 kB
> >> Pss:                1472 kB
> >> Pss_Dirty:          1388 kB
> >> Pss_Anon:           1388 kB
> >> Pss_File:             84 kB
> >> Pss_Shmem:             0 kB
> >> Shared_Clean:       1000 kB
> >> Shared_Dirty:        424 kB
> >> Private_Clean:         0 kB
> >> Private_Dirty:      1176 kB
> >> Referenced:         2220 kB
> >> Anonymous:          1600 kB
> >> KSM:                   0 kB
> >> LazyFree:              0 kB
> >> AnonHugePages:         0 kB
> >> ShmemPmdMapped:        0 kB
> >> FilePmdMapped:         0 kB
> >> Shared_Hugetlb:        0 kB
> >> Private_Hugetlb:       0 kB
> >> Swap:                  0 kB
> >> SwapPss:               0 kB
> >> Locked:                0 kB
> >>


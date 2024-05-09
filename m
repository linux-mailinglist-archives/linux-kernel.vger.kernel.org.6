Return-Path: <linux-kernel+bounces-174311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECCA8C0CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396DCB21F94
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA2C14A09D;
	Thu,  9 May 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcm3ARhZ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF813D289
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244998; cv=none; b=lUipcaR0KCmwrQFLORAV2Zn/KkWOcdHqFpF7buuADPeCynbO68D7lrscB1KESaDYVU96xTJjofFeklfAmOgIUh+AyL53+tIXpa4YH+Vi43rgg41wANI42wz6M1xkp+RMEb8YvaIuYOR686DHA3Wm9jXtdz9UjBTThT1Iy76N8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244998; c=relaxed/simple;
	bh=hKQYUBLwlyNCoeOE+Q2Xm1KRZvxccgpo7Pa182uqSBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNifvlOzkSfiLx3D7mhkk3RS9GRSwC24PA2k/IlY7ds2Ayrc1FlOV3HSMYcfGHph3LRiVdzvZfjfz/X6godEwoi5C8/cyc2SnsvqAWfpRJIrHvIafwaU2TxSm819QkmY/ESW/XcTlgwUzLCUqP6HU8LDQ/G3TU2WPULO2RIA+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rcm3ARhZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so144317166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715244995; x=1715849795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq74kVZCKggMGSqhPRfk3K/aawyZk/HKiHXpQRgHcaE=;
        b=Rcm3ARhZw80y71GuBED6PQ8uqyNo+X+UtTHgxXMdGhWig/5WbjKRoUXV7FLdxyM2lI
         T4EC/dP+O1b+HcsBgP3fErrfnHm34zuOkDvRcipWzg3a/Ks9MVEy1WeflvOt1YWcGZkl
         QEWZaoQ1V6UPSDNoVcLH1J8HlNEnpbUNSbewjPq50/DJPv8C8v88ZZsxfOGHfd9zhbFX
         461NYaivmcgiZTpV09VwRH2TTtXZwjMxslsME/yh+/cM3vcGcUmkuRHm/blcISWUEkAU
         dBxGWCNkTkudMU8233T57ByKpwae39irEvpIxRFAR8RMt97rz3zaT5MBmnMFCJSrZsXe
         vYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715244995; x=1715849795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq74kVZCKggMGSqhPRfk3K/aawyZk/HKiHXpQRgHcaE=;
        b=X1f3KmPTJPvb9j7Z3p0K07Sn2+LTgt84kIYVfI9to3V39zx0JUMQ4G5+gHucjgy+/Z
         aQXPGsuupMqIqOf0FZs+jzoNzcl+YDL1dpD72gYDBgNlaKcMqqw4UmFN7ZdDp1Drd0Fo
         478unpWRxJSSWShLVxyef6UToHn8YN8rhT9PbN6j3p+Lt4nFMxay6Te95SAjw+MtCEs+
         s76Es0SlnMpXNP/IW1qJ1VKlDHtbbyjRuw+Fg38l3q0gkA2zQM8UypocBHkGgP1POIkF
         +87I6cqQDBB3z6+9tZhG0preaZ7nZlbY0Bv1INL0zuAxAjl4lvj9ce63DL8MJOgogG+o
         VfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4wDw166Gvl7nPuLcUDlpOf3v9H5gHg+/Vp1co1W+Y/ETA+1f+HRzgtVhjgZWk5gSuyeHMWLLwTI+IJpJw/HiqozgVsOnnR7wLxd/q
X-Gm-Message-State: AOJu0Yz+oHD0kGP07t7HR4RX7OoyCy08IFV7lc4jK92EU6Z3mR/W/Ty7
	OcxXrbJlRBIHtR9ne97gsZxrVCiiwyyoeF6dp5bd90LfusCK2sAtpAkgqcSEHk3yaSHUTjWV8tB
	Cu9sih6iUpwAg1kKEUpfdFa9l7Uc=
X-Google-Smtp-Source: AGHT+IFf3DIUwmiY+4i/GSvSJb9oJjCKLSIZdz2EWw0j3fhcOrCw1FZQVqPnPxpkqZHcM/2OVrJ96OfTUKuCkyh5E5M=
X-Received: by 2002:a50:bb48:0:b0:56f:e7b9:e67d with SMTP id
 4fb4d7f45d1cf-5731d9d17damr4410968a12.12.1715244994728; Thu, 09 May 2024
 01:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com> <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com> <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
 <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com> <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
 <20240508155253.GK4650@nvidia.com> <30469615-2DDC-467E-A810-5EE8E1CFCB43@nvidia.com>
 <20240508163526.GM4650@nvidia.com>
In-Reply-To: <20240508163526.GM4650@nvidia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 9 May 2024 16:56:23 +0800
Message-ID: <CAK1f24knjnKkHDp+bRkpfWqe6v5-GPJF=sSWPo6zQUydT9aMaw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>, Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org, 
	willy@infradead.org, sj@kernel.org, maskray@google.com, ryan.roberts@arm.com, 
	david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Jason,

Thanks a lot for clarifying!

On Thu, May 9, 2024 at 12:35=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, May 08, 2024 at 12:22:08PM -0400, Zi Yan wrote:
> > On 8 May 2024, at 11:52, Jason Gunthorpe wrote:
> >
> > > On Wed, May 08, 2024 at 10:56:34AM -0400, Zi Yan wrote:
> > >
> > >> Lance is improving try_to_unmap_one() to support unmapping PMD THP a=
s a whole,
> > >> so he moves split_huge_pmd_address() inside while (page_vma_mapped_w=
alk(&pvmw))
> > >> and after mmu_notifier_invalidate_range_start() as split_huge_pmd_lo=
cked()
> > >> and does not include the mmu notifier ops inside split_huge_pmd_addr=
ess().
> > >> I wonder if that could cause issues, since the mmu_notifier_invalida=
te_range_start()
> > >> before the while loop only has range of the original address and
> > >> split huge pmd can affect the entire PMD address range and these two=
 ranges
> > >> might not be the same.
> > >
> > > That does not sound entirely good..
> > >
> > > I suppose it depends on what split does, if the MM page table has the
> > > same translation before and after split then perhaps no invalidation
> > > is even necessary.
> >
> > Before split, it is a PMD mapping to a PMD THP (order-9). After split,
> > they are 512 PTEs mapping to the same THP. Unless the secondary TLB
> > does not support PMD mapping and use 512 PTEs instead, it seems to
> > be an issue from my understanding.
>
> I may not recall fully, but I don't think any secondaries are
> so sensitive to the PMD/PTE distinction.. At least the ones using
> hmm_range_fault() are not.
>
> When the PTE eventually comes up for invalidation then the secondary
> should wipe out any granual they may have captured.
>
> Though, perhaps KVM should be checked carefully.

Agreed. IIUC,  the secondary mappings are teardown in
mmu_notifier_invalidate_range_start() and allowed to be established again
only mmu_notifier_invalidate_range_end(), then all modifications will be
picked up by the secondary MMU. I just image that the secondary MMU
like a TLB, where you only invalidate, and then it will be refilled later (=
after
mmu_notifier_invalidate_range_end()).

Thanks again for the lesson!
Lance

>
> > In terms of two mmu_notifier ranges, first is in the split_huge_pmd_add=
ress()[1]
> > and second is in try_to_unmap_one()[2]. When try_to_unmap_one() is unma=
pping
> > a subpage in the middle of a PMD THP, the former notifies about the PMD=
 range
> > change due to one PMD split into 512 PTEs and the latter only needs to =
notify
> > about the invalidation of the unmapped PTE. I do not think the latter c=
an
> > replace the former, although a potential optimization can be that the l=
atter
> > can be removed as it is included in the range of the former.
>
> I think we probably don't need both, either size might be fine, but
> the larger size is definately fine..
>
> > Regarding Lance's current code change, is it OK to change mmu_notifier =
range
> > after mmu_notifier_invalidate_range_start()?
>
> No, it cannot be changed during a start/stop transaction.
>
> Jason
>
>


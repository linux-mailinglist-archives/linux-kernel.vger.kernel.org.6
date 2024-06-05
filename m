Return-Path: <linux-kernel+bounces-202797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A128FD147
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512F01C21DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7983398E;
	Wed,  5 Jun 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR24vllK"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4A2E40D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599438; cv=none; b=HuvoVsBbC9YzykZ9u6V34scDO/7OE/BlJLSniO2TSwHJw/PvmyTOHdsCmvPWSwD9vln6MwQii9xlASfZzEVXrskTO/r95RIYiII5NPCXdMWDclXJ6CYOvXCoKH/3vcTh+Qj0mnk65vFYAxeZOVUuoK1fVDq7sPFSFNFIHCVOQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599438; c=relaxed/simple;
	bh=wYaCdVWF5xj+9+4OFEs7eBSNrdDQGkxKfQ29AioRhno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuY1fwd01zholkzP14ijpPuctlGr3UzTKe47aoo+LbF23q5qHpFENSCzqrABha/EoKt9Qd1lwLcAT43rEzQe/FusTYyFtEwcujOsK/Q+ym55qqWDaguL6fgf0j1ej0c7P5WmXQjo7NNmCnCPK8WEOG8s6ErxBdZrbZTrN+NzS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR24vllK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso3256152a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717599435; x=1718204235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew0ehDFYMnSFybPsJ2azRb8JDVlCAGuoP78U60v29ZY=;
        b=HR24vllKdbK7vC3vebwxu8eFGpdg1xyshXP5Xzn9uGugB1hvmiCNU2LVg5I1csaSmq
         M7yiTQtxc4md0YnmoVIpRvcUtOM7xV9agKPK5ZIvvKsmyrI9ZzGpek5P9sSdXLby6rS/
         U1NktKtiL3EAi8HuUi/KpMLJXyBEQdDerqhSDV1+NbdRxqR9xiEJyv3H24Ms7epMRVNK
         2bPJx/pimIhMnvYbl1pCGGDVvGM7zjH5ng0G20DUEaJ9pVCMB9qIx2/j54pP+Y4+/xyS
         gkWawm+yRXbuW8TY82BLHvGRh2MRqnBIGBvxTVw49IKrDABEAg4MlGyhwXtdp1uM+hBv
         5ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717599435; x=1718204235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew0ehDFYMnSFybPsJ2azRb8JDVlCAGuoP78U60v29ZY=;
        b=jSQlUzH/KReWHPQLTE36SfGNwUGJu8M+bKZx24/EcfxRZwRkE6crl7/+pQhwfgOzNr
         dimBa7LX8x1o2eVHPw2su+9yFWHjwA8qs1deXXIabcLoSUyLAAYYsrn/INdsHefaM/NZ
         2KZKfhSVMU10JC9MPo3p27t+mDo5NCpbT/Uv7gwm5YayHHl1ru5L8UogjEDis72bqQsg
         msZhBWDAiQE7ocaQ4jO2QctPAvVIlZ9B9yezePCowFKYs6+UhM71b4yg7NZ1C07wZa8e
         g3EnKpa0SNYZ37P1aWhIyFPjEML2G0NXoOERXDohUdmEnXACM895BzTv0CbjiW+++GWo
         R74g==
X-Forwarded-Encrypted: i=1; AJvYcCX4Y0Yck4JZyM5ySRzvBpI+i0Bnl/jMLcd+IsuIorAvDCuwivvSW8DZ1jx7ec5aJNBr5pd76YnQgcSWUffc7W4qZs5DGKIsEA5cYZ+H
X-Gm-Message-State: AOJu0YzTdQguvGXBSl0TwyKxNT/AS1xe5L7YHncv+WN+9dIVJOez7q/G
	kjrvbo4bq0xw73a6Jr/SErxNtzk0qiTprs9OSTOpy/4sT2xZ9OwRVcdvU2VOfGZlbK/HKPt1Jcq
	c01PBcWgTOUQB0bfIyQltzCebGXeyGPsa
X-Google-Smtp-Source: AGHT+IEghxABuzt8hc7dbwM1mrOj97xuKqWBK5xJM+Ug+8gPFvaD/YI18EGQtid1Qg2cFuruJUiY7sFjhiOAHMaUkiM=
X-Received: by 2002:a50:998e:0:b0:57a:215a:5cb9 with SMTP id
 4fb4d7f45d1cf-57a8b6f8f2bmr1996745a12.19.1717599434705; Wed, 05 Jun 2024
 07:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com> <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
 <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com> <8580a462-eadc-4fa5-b01a-c0b8c3ae644d@redhat.com>
In-Reply-To: <8580a462-eadc-4fa5-b01a-c0b8c3ae644d@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 5 Jun 2024 22:57:01 +0800
Message-ID: <CAK1f24=7=QqDFoh=joC+o1eZfyJ8onyc9ELBZBzn1CFr4uPSwQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>, akpm@linux-foundation.org, willy@infradead.org, 
	sj@kernel.org, baolin.wang@linux.alibaba.com, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:39=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 05.06.24 16:28, David Hildenbrand wrote:
> > On 05.06.24 16:20, Lance Yang wrote:
> >> Hi David,
> >>
> >> On Wed, Jun 5, 2024 at 8:46=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>>
> >>> On 21.05.24 06:02, Lance Yang wrote:
> >>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> >>>> folios, start the pagewalk first, then call split_huge_pmd_address()=
 to
> >>>> split the folio.
> >>>>
> >>>> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we migh=
t
> >>>> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range =
during
> >>>> the page walk. It=E2=80=99s probably necessary to mlock this THP to =
prevent it from
> >>>> being picked up during page reclaim.
> >>>>
> >>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>> ---
> >>>
> >>> [...] again, sorry for the late review.
> >>
> >> No worries at all, thanks for taking time to review!
> >>
> >>>
> >>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>> index ddffa30c79fb..08a93347f283 100644
> >>>> --- a/mm/rmap.c
> >>>> +++ b/mm/rmap.c
> >>>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *fol=
io, struct vm_area_struct *vma,
> >>>>         if (flags & TTU_SYNC)
> >>>>                 pvmw.flags =3D PVMW_SYNC;
> >>>>
> >>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
> >>>> -             split_huge_pmd_address(vma, address, false, folio);
> >>>> -
> >>>>         /*
> >>>>          * For THP, we have to assume the worse case ie pmd for inva=
lidation.
> >>>>          * For hugetlb, it could be much worse if we need to do pud
> >>>> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *f=
olio, struct vm_area_struct *vma,
> >>>>         mmu_notifier_invalidate_range_start(&range);
> >>>>
> >>>>         while (page_vma_mapped_walk(&pvmw)) {
> >>>> -             /* Unexpected PMD-mapped THP? */
> >>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> >>>> -
> >>>>                 /*
> >>>>                  * If the folio is in an mlock()d vma, we must not s=
wap it out.
> >>>>                  */
> >>>>                 if (!(flags & TTU_IGNORE_MLOCK) &&
> >>>>                     (vma->vm_flags & VM_LOCKED)) {
> >>>>                         /* Restore the mlock which got missed */
> >>>> -                     if (!folio_test_large(folio))
> >>>> +                     if (!folio_test_large(folio) ||
> >>>> +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)=
))
> >>>>                                 mlock_vma_folio(folio, vma);
> >>>
> >>> Can you elaborate why you think this would be required? If we would h=
ave
> >>> performed the  split_huge_pmd_address() beforehand, we would still be
> >>> left with a large folio, no?
> >>
> >> Yep, there would still be a large folio, but it wouldn't be PMD-mapped=
.
> >>
> >> After Weifeng's series[1], the kernel supports mlock for PTE-mapped la=
rge
> >> folio, but there are a few scenarios where we don't mlock a large foli=
o, such
> >> as when it crosses a VM_LOCKed VMA boundary.
> >>
> >>    -                     if (!folio_test_large(folio))
> >>    +                     if (!folio_test_large(folio) ||
> >>    +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD=
)))
> >>
> >> And this check is just future-proofing and likely unnecessary. If enco=
untering a
> >> PMD-mapped THP missing the mlock for some reason, we can mlock this
> >> THP to prevent it from being picked up during page reclaim, since it i=
s fully
> >> mapped and doesn't cross the VMA boundary, IIUC.
> >>
> >> What do you think?
> >> I would appreciate any suggestions regarding this check ;)
> >
> > Reading this patch only, I wonder if this change makes sense in the
> > context here.
> >
> > Before this patch, we would have PTE-mapped the PMD-mapped THP before
> > reaching this call and skipped it due to "!folio_test_large(folio)".
> >
> > After this patch, we either
> >
> > a) PTE-remap the THP after this check, but retry and end-up here again,
> > whereby we would skip it due to "!folio_test_large(folio)".
> >
> > b) Discard the PMD-mapped THP due to lazyfree directly. Can that
> > co-exist with mlock and what would be the problem here with mlock?
> >
> >

Thanks a lot for clarifying!

> > So if the check is required in this patch, we really have to understand
> > why. If not, we should better drop it from this patch.
> >
> > At least my opinion, still struggling to understand why it would be
> > required (I have 0 knowledge about mlock interaction with large folios =
:) ).
> >
>
> Looking at that series, in folio_references_one(), we do
>
>                         if (!folio_test_large(folio) || !pvmw.pte) {
>                                 /* Restore the mlock which got missed */
>                                 mlock_vma_folio(folio, vma);
>                                 page_vma_mapped_walk_done(&pvmw);
>                                 pra->vm_flags |=3D VM_LOCKED;
>                                 return false; /* To break the loop */
>                         }
>
> I wonder if we want that here as well now: in case of lazyfree we
> would not back off, right?
>
> But I'm not sure if lazyfree in mlocked areas are even possible.
>
> Adding the "!pvmw.pte" would be much clearer to me than the flag check.

Hmm... How about we drop it from this patch for now, and add it back if nee=
ded
in the future?

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>


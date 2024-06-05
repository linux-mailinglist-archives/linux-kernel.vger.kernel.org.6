Return-Path: <linux-kernel+bounces-202769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23358FD0B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D23E1F213C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F071A291;
	Wed,  5 Jun 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd3MNYXs"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878D19D88A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597255; cv=none; b=nILH3VmiMuIsrqlHcmwWcKqgNE++U+6caKyQxXD71aZvfzmKCCX8sCuVDgel3eilzRx9pepv3DMuthbaVp66DDqQH5BpcMJh2CDqYh1EjjquVQ81KzAyI5r/428/9kr0cbYX/F4/5fcsr0AWb+pF7sj3vk24sqx2eN3uqDZ+sY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597255; c=relaxed/simple;
	bh=rwzRMqBnuvWkjZ3Mx6xR3M/0Dew3Q2Uw/R41CRqfrw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5+eHNDpYp3eCpj2CCvTPgSGAztO4C9yxb6h9UQ7Z/JcPgN3CPws52WnPZeoo9vEE0+o/BobhT1bZlGaSm27sBeNckxWgg4yJ5DxDo+PLz/qWnYG19oJdAlCbkky36O/ijhWHHYG8jemWuQZPr62O3L8CnANDPbjytz4mwSH/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd3MNYXs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b83225088so6769445e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717597252; x=1718202052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6/nFcvo4Plib4eYfTDh6OIq6sf+MB/iDA/4kpOYR+k=;
        b=Dd3MNYXscgN49lUo+2+UCsdOMpyEyaLMFcWoz9Giz4ROJDEzoSDdfR+tEMggqtcfbq
         SKQXj6cAnunJS6Huo3IQylSW/9TzQ/YNyyErV+p1YUvdmFjuNsoQP2hEyM0tBg6lIH5C
         LwMq3Bp8zx4K1ycbBsWdcvbgISErhz7U4WgjxG3q0OpEnAxBhgTw2JvcTYdVYcN5rIYD
         SAGMyQvO4QnvQhLfbaDw1FRpgABKGiFJ6uOOPTMtiBKvQsk6sZQruQ9I2PkaytkJdr7Y
         QWRjg5vsjOu9FjZzk0/aPWl9gnjt1UiojWl7AeWUQRUNSQBSdJQSyjmkrwUIjWMsRH5g
         F2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717597252; x=1718202052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6/nFcvo4Plib4eYfTDh6OIq6sf+MB/iDA/4kpOYR+k=;
        b=LCe1XFE3nGuqfgVwPcCwcFo0d9u/sYGtNS9xA4JShuaZ/v+zbYX33zAn9aBCVeN47b
         uw3SUquNdBo1p1f12DbW8DG+RUUxhMzU06ecl8OY2EnWzmEd+APsyWnRmnTU91jNIxkL
         lALsPMGYekgyLRMcy6ucaqlsohs4nXKSmG4URoVAWAPybzkqmLvSwLj2UDuODW8r3zlq
         17DKspfMYq8baTCFx+It0Fv5f8QDyOwTjo8qZh+LB6PK8C/xgS/z3OhuHm9xgT7RjUTy
         +7PZLT+BK50PrKuGHz4aLaR7+Qlc44H3DZJ8MQr8gNDJnWZMGn0RkUulPATDZ9Dpov+Q
         4Peg==
X-Forwarded-Encrypted: i=1; AJvYcCVc5ckc6aaC5/jsanRV6rJ3/d5cAV+ZR4tD1LP/txd7pG/qtPROligN5JrNfV5DV5KeeyEjl0Byy1/zl1PGjwPdyQNo0ooGsqgxD4db
X-Gm-Message-State: AOJu0Yye43cwg5hjsXDqmjAxFDl/xFUiUu8h00ZxJvZnAwFB3SFmnAWp
	NsJ3izXpXUfKupw9NLK8KemhRKI1Phe7LYNoqouRVGZs8mEPmEpNyamWDgkYOhMyUoAZnJ+ew70
	icEn88Y2l9UPZ+ZaGmffRnS9kaOY=
X-Google-Smtp-Source: AGHT+IEclwAhv2Gs76M218qecK/f9MCwW8rrRU378XIhtJLYeZe+NoqxXepfOxLbW0F6m2D9FYleT8L7sWbciSpknMc=
X-Received: by 2002:a05:6512:4891:b0:52b:af6b:7b4c with SMTP id
 2adb3069b0e04-52baf6b7bffmr1031490e87.30.1717597251361; Wed, 05 Jun 2024
 07:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com>
In-Reply-To: <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 5 Jun 2024 22:20:39 +0800
Message-ID: <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, Jun 5, 2024 at 8:46=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 21.05.24 06:02, Lance Yang wrote:
> > In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> > folios, start the pagewalk first, then call split_huge_pmd_address() to
> > split the folio.
> >
> > Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we might
> > encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range dur=
ing
> > the page walk. It=E2=80=99s probably necessary to mlock this THP to pre=
vent it from
> > being picked up during page reclaim.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
>
> [...] again, sorry for the late review.

No worries at all, thanks for taking time to review!

>
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index ddffa30c79fb..08a93347f283 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >       if (flags & TTU_SYNC)
> >               pvmw.flags =3D PVMW_SYNC;
> >
> > -     if (flags & TTU_SPLIT_HUGE_PMD)
> > -             split_huge_pmd_address(vma, address, false, folio);
> > -
> >       /*
> >        * For THP, we have to assume the worse case ie pmd for invalidat=
ion.
> >        * For hugetlb, it could be much worse if we need to do pud
> > @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >       mmu_notifier_invalidate_range_start(&range);
> >
> >       while (page_vma_mapped_walk(&pvmw)) {
> > -             /* Unexpected PMD-mapped THP? */
> > -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> > -
> >               /*
> >                * If the folio is in an mlock()d vma, we must not swap i=
t out.
> >                */
> >               if (!(flags & TTU_IGNORE_MLOCK) &&
> >                   (vma->vm_flags & VM_LOCKED)) {
> >                       /* Restore the mlock which got missed */
> > -                     if (!folio_test_large(folio))
> > +                     if (!folio_test_large(folio) ||
> > +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
> >                               mlock_vma_folio(folio, vma);
>
> Can you elaborate why you think this would be required? If we would have
> performed the  split_huge_pmd_address() beforehand, we would still be
> left with a large folio, no?

Yep, there would still be a large folio, but it wouldn't be PMD-mapped.

After Weifeng's series[1], the kernel supports mlock for PTE-mapped large
folio, but there are a few scenarios where we don't mlock a large folio, su=
ch
as when it crosses a VM_LOCKed VMA boundary.

 -                     if (!folio_test_large(folio))
 +                     if (!folio_test_large(folio) ||
 +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))

And this check is just future-proofing and likely unnecessary. If encounter=
ing a
PMD-mapped THP missing the mlock for some reason, we can mlock this
THP to prevent it from being picked up during page reclaim, since it is ful=
ly
mapped and doesn't cross the VMA boundary, IIUC.

What do you think?
I would appreciate any suggestions regarding this check ;)

[1] https://lore.kernel.org/all/20230918073318.1181104-3-fengwei.yin@intel.=
com/T/#mdab40248cf3705581d8bfb64e1ebf2d9cd81c095

>
> >                       goto walk_done_err;
> >               }
> >
> > +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > +                     /*
> > +                      * We temporarily have to drop the PTL and start =
once
> > +                      * again from that now-PTE-mapped page table.
> > +                      */
> > +                     split_huge_pmd_locked(vma, range.start, pvmw.pmd,=
 false,
> > +                                           folio);
>
> Using range.start here is a bit weird. Wouldn't this be pvmw.address?
> [did not check]

Hmm... we may adjust range.start before the page walk, but pvmw.address
does not.

At least for now, pvmw.address seems better. Will adjust as you suggested.

>
> > +                     pvmw.pmd =3D NULL;
> > +                     spin_unlock(pvmw.ptl);
> > +                     pvmw.ptl =3D NULL;
>
>
> Would we want a
>
> page_vma_mapped_walk_restart() that is exactly for that purpose?

Nice, let's add page_vma_mapped_walk_restart() for that purpose :)

Thanks again for your time!

Lance

>
> > +                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > +                     continue;
> > +             }
> > +
> > +             /* Unexpected PMD-mapped THP? */
> > +             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>
> --
> Cheers,
>
> David / dhildenb
>


Return-Path: <linux-kernel+bounces-205235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBC8FF9BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D61F2429B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06D611CBD;
	Fri,  7 Jun 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKeP1E21"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880334C76
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725064; cv=none; b=hmjHezhobntzCmoJnwX583sWqqFsJTycevQQFfS08Ht5a9NyhdAvJRt2FIRaCmlLfmLkV0lXBQpncNnK6/tFpMo9IcZS28gDvyH0R/FGkHDcfa91u1dX3r8JTBXHbj/EXmSaVdPouApQYHNqDdzc5SJ7CY6RkPcLVwjl72Y2HE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725064; c=relaxed/simple;
	bh=Dr3s28YKkK4NkE1XnCpVsZ9voy/Ar7EnjhVk8e4B8is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHiZTDLx/Xm1+Kx7TJWLktTj55OfBsocgN3OlZHbuSX4af4mSn6yN+8CCGAjtAV5dk7HBHoaLyeawxhuMOdcoBeIiAbPuGydSR3hSoUR8XsKGwIWEKfBCune3NJgNBw8BS8SQrAEAOPAUTLgU2vxPCMnUrSJC/L758jGWmIwcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKeP1E21; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so1698480a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717725061; x=1718329861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jgyEjE44lnwVIp+Vzkq3Lwb3VBd6jriok/nTPf4IRI=;
        b=HKeP1E21LYLFBGAQv8cVJIIcNPRl0hkDL/O6qCcPoDJLvJwSDFjYUeUpMl2FQU4oO3
         wXQ9KxdEHL3bE2zHzrEwXXVyxr4PoGTlfeYZSBYdNEFoI8TLQohB+l0JuymJ1fEaEcJ0
         bmV0vSy4VDveu2aleQ5H5dY3NP7tnDSzp+zXyLf/xfJK1XtWRNXtv4+2V8Hb3hXpprLr
         B4GvhZeDHmtQdtv4Cc4WL6lX/6FTGFIiDIMGpN0zUnCtFhWaAaXcxr9n5iH7iJq1XSPQ
         iZOiXzSIy0lBrTNl7W3/F9YS+50anfOOXyKo2Hhnb+GiuY4viKg0yj+XoMzuw9npKLpb
         XXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717725061; x=1718329861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jgyEjE44lnwVIp+Vzkq3Lwb3VBd6jriok/nTPf4IRI=;
        b=cGYi+UHwKDUdGq1Zo8oUHHcu1Zapr04KVSsGaRDmjHSg8LT5A/hPsgStuaO7L4AC8A
         2xjnwNbGE60x5BjIszsFfDo5+SUzoz8JCL+yAxDcPCqqdWFZgBW0axybZtKIWpwGgIN7
         8H1/hMzhdREEuaZ5nlWFPoHAkQTGG/cVehHdqG0/OQ1Gm8SSZbxV+SRN7pmzH4LOjmYm
         S+VwSk+ShG78jFgSBuVB6ppFkkfBF53phMI6CMVZIAl2lLAOJ/qAvFtvrJOICuWieaeg
         boCTxaz3kmfiC2iRs3pXLtq0yF/tQrKD0x+ZTsuM6AUMej/YISGRQwMv1F/2VdjxNZW6
         pX2g==
X-Forwarded-Encrypted: i=1; AJvYcCU2Z7Wze2tR4gdgWHa8z4dzaFGxGpuoB6irF2V13lrRCGS/0e1NrD6XxS5hB+50LEgsgpSIK9WJVZoIh01dpiHAKWfPH7JMYALcjLYt
X-Gm-Message-State: AOJu0YxGPUZpDeiSC4EmNGWpr8DXim7pHT1/5fNTwtrPNNNTZCDyE7XI
	rWs7AGq0IYacdGbGni+aREQzsrg66jpE469fwruze34HsP90mnIDJy+/qQailPNbI45JJaTldEp
	ed4Gl8XeSUv7gQqu6y88B7nPkwTY=
X-Google-Smtp-Source: AGHT+IHI75h04SIf4Rmmtl46mN7kSxQnN/OGrsFpteG6StVtG1VO6ZHry9J2NeT6hJcXAn65twmP+sjd9qdh36qj3Hc=
X-Received: by 2002:a50:99c9:0:b0:578:6901:7454 with SMTP id
 4fb4d7f45d1cf-57c5089a10amr487540a12.15.1717725060550; Thu, 06 Jun 2024
 18:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com> <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
 <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com> <CAK1f24kKra71RSQdFOpQecU6+yMELC748irKUt54Kg64-P=4-A@mail.gmail.com>
 <758f7be7-c17e-46d1-879f-83340ec85749@redhat.com> <5a728148-ed93-4d68-a86f-9be3612dedbb@redhat.com>
 <CAK1f24nMbW_UvCTq=K0aFu9=7psYZ9wmHq47J=AK7VYmpCpC4Q@mail.gmail.com> <2a6a1b50-e711-42c2-91f4-42881a6057e9@redhat.com>
In-Reply-To: <2a6a1b50-e711-42c2-91f4-42881a6057e9@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 7 Jun 2024 09:50:49 +0800
Message-ID: <CAK1f24nT429ZdEcFUv0r0Sbihjum-Z8ghoYxML=tzaDpVWZk-w@mail.gmail.com>
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

On Thu, Jun 6, 2024 at 5:41=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.06.24 11:38, Lance Yang wrote:
> > On Thu, Jun 6, 2024 at 4:06=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 06.06.24 10:01, David Hildenbrand wrote:
> >>> On 06.06.24 05:55, Lance Yang wrote:
> >>>> On Wed, Jun 5, 2024 at 10:28=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 05.06.24 16:20, Lance Yang wrote:
> >>>>>> Hi David,
> >>>>>>
> >>>>>> On Wed, Jun 5, 2024 at 8:46=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>>>
> >>>>>>> On 21.05.24 06:02, Lance Yang wrote:
> >>>>>>>> In preparation for supporting try_to_unmap_one() to unmap PMD-ma=
pped
> >>>>>>>> folios, start the pagewalk first, then call split_huge_pmd_addre=
ss() to
> >>>>>>>> split the folio.
> >>>>>>>>
> >>>>>>>> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we =
might
> >>>>>>>> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED ra=
nge during
> >>>>>>>> the page walk. It=E2=80=99s probably necessary to mlock this THP=
 to prevent it from
> >>>>>>>> being picked up during page reclaim.
> >>>>>>>>
> >>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>>>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>>>>>> ---
> >>>>>>>
> >>>>>>> [...] again, sorry for the late review.
> >>>>>>
> >>>>>> No worries at all, thanks for taking time to review!
> >>>>>>
> >>>>>>>
> >>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>>>> index ddffa30c79fb..08a93347f283 100644
> >>>>>>>> --- a/mm/rmap.c
> >>>>>>>> +++ b/mm/rmap.c
> >>>>>>>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio =
*folio, struct vm_area_struct *vma,
> >>>>>>>>           if (flags & TTU_SYNC)
> >>>>>>>>                   pvmw.flags =3D PVMW_SYNC;
> >>>>>>>>
> >>>>>>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
> >>>>>>>> -             split_huge_pmd_address(vma, address, false, folio)=
;
> >>>>>>>> -
> >>>>>>>>           /*
> >>>>>>>>            * For THP, we have to assume the worse case ie pmd fo=
r invalidation.
> >>>>>>>>            * For hugetlb, it could be much worse if we need to d=
o pud
> >>>>>>>> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct foli=
o *folio, struct vm_area_struct *vma,
> >>>>>>>>           mmu_notifier_invalidate_range_start(&range);
> >>>>>>>>
> >>>>>>>>           while (page_vma_mapped_walk(&pvmw)) {
> >>>>>>>> -             /* Unexpected PMD-mapped THP? */
> >>>>>>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> >>>>>>>> -
> >>>>>>>>                   /*
> >>>>>>>>                    * If the folio is in an mlock()d vma, we must=
 not swap it out.
> >>>>>>>>                    */
> >>>>>>>>                   if (!(flags & TTU_IGNORE_MLOCK) &&
> >>>>>>>>                       (vma->vm_flags & VM_LOCKED)) {
> >>>>>>>>                           /* Restore the mlock which got missed =
*/
> >>>>>>>> -                     if (!folio_test_large(folio))
> >>>>>>>> +                     if (!folio_test_large(folio) ||
> >>>>>>>> +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_=
PMD)))
> >>>>>>>>                                   mlock_vma_folio(folio, vma);
> >
> > Should we still keep the '!pvmw.pte' here? Something like:
> >
> > if (!folio_test_large(folio) || !pvmw.pte)
> >      mlock_vma_folio(folio, vma);
>
> I was wondering the same the whole time ...
>
> >
> > We can mlock the THP to prevent it from being picked up during page rec=
laim.
> >
> > David, I=E2=80=99d like to hear your thoughts on this ;)
>
> but I think there is no need to for now, in the context of your patchset.=
 :)

Agreed. Let's drop it for now :)

Thanks a lot for your thoughts!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>


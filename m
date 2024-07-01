Return-Path: <linux-kernel+bounces-236811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C973191E759
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6831C2151E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD42BB04;
	Mon,  1 Jul 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQCMKhWo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2416EBF6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858042; cv=none; b=t9vVeYNTigqii1DFdb1QTxUwZQkZBvb67163Yz2NBc7o8mZdNcwHCCxc6PZrS3UQZVpqO+kHzTHEIsgic4PXMGQyH+Rr5SBTpvmJF06wWBWOgnvZkLWFTBSLCcEO29DLDh5irLCBFGBw0Msib4hcQUqwv3XJlTzScoX4d5Vm0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858042; c=relaxed/simple;
	bh=T+5SnGMB/v6IIb7sPMndMvsr2WLzYbg8uXETj7t7Uyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRBTol9NPSmn05e9Z+IZopVfFGLEU0MOgvBD3GiEkyapxQU1pfcVyjyWjnnjff2v8gurvVb2PDsz1leiZ772ab6W42gwBR4aZtcND3PPifnwaCbXOUBpCRG32s2wiiUD316V7aGLVc32jkm4rLdD5cKKkHFRNMXN5EIVLIwOdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQCMKhWo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so840878a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858039; x=1720462839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWE6SkHai2dr4PJhwkPcdxBi9e64Tm0a2kZhQnrC0lU=;
        b=kQCMKhWoIJbX6s9ZseUt1hybq5zX/lQrVYjBVlrB4RCgfnnkc0kBw9A4X4zw9ldFvd
         s8IoyXi7NXD/693TvPXb/5ZYNuO6eXqhFXx21PZ7W6LyIsS+/L/mQVMDhXFfxoYBll2O
         P5/GuUnRvfJ+T5Guw7d91LEYfKwOYvDXCWLTrrVIjaJCIndb6hk2WUzn1JPrKs/XJh6A
         TMzIRk/KKHasnchYJPnlJJB9cxuBTi9PNVXrZ6nNGIOFL7dT2Y6D+8SOgM5oIwPPK7o3
         Eo+gV63wpGqLyv/f0OilDWq9WCnlctqbWECAiZ9aWjoB/Dyvmj8hWQQq64PkOobBfiXo
         D2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858039; x=1720462839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWE6SkHai2dr4PJhwkPcdxBi9e64Tm0a2kZhQnrC0lU=;
        b=kW99eLhcB1Dl5+kWpFWe0UpTBsdQM+kkGutK5SFZIBkfk52AU580YtB5mvS8kg2lKK
         vOSqrUimpIFAgseaWPd2ywbcUwm+JHUEXoQvgihjCsTk+F+by7wj6AtCTMslHBbXQ27g
         9E6Wm+c28UteGau7MV0G088O9nb5CoMdKShCW0q98amUDAKVBVm7aCFDhUWgK+MJO44s
         CO9zPyR03TGArSqpF+9Ilnexj6HSVK8r5rrEK3gjXlDF06EaH4INA0Ic+gcuZsOMAHjY
         w/5cGof2OH46+Oyfzm3TK86PdcQWh3PSSzSrD8UVkqJmwP4jEbaIhNCJJZRa/B6mGI0U
         IOcg==
X-Forwarded-Encrypted: i=1; AJvYcCVdoReQXWZOLXhmb0zsTiWoYpUR7CF0DGOQG9wMsVZMIkU0f1wQ5PrdFywo5CbNuOElTVz/SiPST/ddPFndyyvcNw9L2u4DQfq3368q
X-Gm-Message-State: AOJu0Yxbr9mNcZyECbNAve9Fu+tCzeeiJ2cBRQ1chhRY+tpWY5QhWbbq
	TONvqhbHqVmflr+Z0xJrVkOSOv0AIRpaA5wOS0ZsW+3m75sMevNuBIt3a3vwiCz1ehfIa0R5LYx
	C13lfmgTaGqHAXn6l2Ns/q6E+BcA=
X-Google-Smtp-Source: AGHT+IETj650C+A8QNY2L/tY1xZJGI/lrVKRxHZXvH83tdlSO0bvAHBQp9F1MmdOCq9YhRYFUgrqTDgjD0mP1hk32zY=
X-Received: by 2002:a05:6402:2712:b0:57c:a422:677b with SMTP id
 4fb4d7f45d1cf-5879ede2763mr4921647a12.8.1719858038669; Mon, 01 Jul 2024
 11:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com> <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
 <516aa6b3-617c-4642-b12b-0c5f5b33d1c9@arm.com> <597ac51e-3f27-4606-8647-395bb4e60df4@redhat.com>
 <6f68fb9d-3039-4e38-bc08-44948a1dae4d@arm.com> <992cdbf9-80df-4a91-aea6-f16789c5afd7@redhat.com>
 <2e0a1554-d24f-4d0d-860b-0c2cf05eb8da@arm.com> <06c74db8-4d10-4a41-9a05-776f8dca7189@redhat.com>
 <429f2873-8532-4cc8-b0e1-1c3de9f224d9@arm.com> <7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com>
In-Reply-To: <7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 1 Jul 2024 11:20:27 -0700
Message-ID: <CAHbLzkrv2U39oOFuuHpmcfvDOuMayjwdgXLshxtDSSPGPzOkJQ@mail.gmail.com>
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous shmem
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Bang Li <libang.li@antgroup.com>, hughd@google.com, akpm@linux-foundation.org, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:23=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.07.24 12:16, Ryan Roberts wrote:
> > On 01/07/2024 10:17, David Hildenbrand wrote:
> >> On 01.07.24 11:14, Ryan Roberts wrote:
> >>> On 01/07/2024 09:57, David Hildenbrand wrote:
> >>>> On 01.07.24 10:50, Ryan Roberts wrote:
> >>>>> On 01/07/2024 09:48, David Hildenbrand wrote:
> >>>>>> On 01.07.24 10:40, Ryan Roberts wrote:
> >>>>>>> On 01/07/2024 09:33, Baolin Wang wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 2024/7/1 15:55, Ryan Roberts wrote:
> >>>>>>>>> On 28/06/2024 11:49, Bang Li wrote:
> >>>>>>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support fo=
r
> >>>>>>>>>> anonymous shmem"), we can configure different policies through
> >>>>>>>>>> the multi-size THP sysfs interface for anonymous shmem. But
> >>>>>>>>>> currently "THPeligible" indicates only whether the mapping is
> >>>>>>>>>> eligible for allocating THP-pages as well as the THP is PMD
> >>>>>>>>>> mappable or not for anonymous shmem, we need to support semant=
ics
> >>>>>>>>>> for mTHP with anonymous shmem similar to those for mTHP with
> >>>>>>>>>> anonymous memory.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
> >>>>>>>>>> ---
> >>>>>>>>>>       fs/proc/task_mmu.c      | 10 +++++++---
> >>>>>>>>>>       include/linux/huge_mm.h | 11 +++++++++++
> >>>>>>>>>>       mm/shmem.c              |  9 +--------
> >>>>>>>>>>       3 files changed, 19 insertions(+), 11 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>>>>>>>>> index 93fb2c61b154..09b5db356886 100644
> >>>>>>>>>> --- a/fs/proc/task_mmu.c
> >>>>>>>>>> +++ b/fs/proc/task_mmu.c
> >>>>>>>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, v=
oid *v)
> >>>>>>>>>>       {
> >>>>>>>>>>           struct vm_area_struct *vma =3D v;
> >>>>>>>>>>           struct mem_size_stats mss =3D {};
> >>>>>>>>>> +    bool thp_eligible;
> >>>>>>>>>>             smap_gather_stats(vma, &mss, 0);
> >>>>>>>>>>       @@ -882,9 +883,12 @@ static int show_smap(struct seq_fil=
e *m, void
> >>>>>>>>>> *v)
> >>>>>>>>>>             __show_smap(m, &mss, false);
> >>>>>>>>>>       -    seq_printf(m, "THPeligible:    %8u\n",
> >>>>>>>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
> >>>>>>>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL)=
);
> >>>>>>>>>> +    thp_eligible =3D !!thp_vma_allowable_orders(vma, vma->vm_=
flags,
> >>>>>>>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_OR=
DERS_ALL);
> >>>>>>>>>> +    if (vma_is_anon_shmem(vma))
> >>>>>>>>>> +        thp_eligible =3D
> >>>>>>>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
> >>>>>>>>>> +                            vma, vma->vm_pgoff, thp_eligible)=
;
> >>>>>>>>>
> >>>>>>>>> Afraid I haven't been following the shmem mTHP support work as =
much as I
> >>>>>>>>> would
> >>>>>>>>> have liked, but is there a reason why we need a separate functi=
on for
> >>>>>>>>> shmem?
> >>>>>>>>
> >>>>>>>> Since shmem_allowable_huge_orders() only uses shmem specific log=
ic to
> >>>>>>>> determine
> >>>>>>>> if huge orders are allowable, there is no need to complicate the
> >>>>>>>> thp_vma_allowable_orders() function by adding more shmem related=
 logic,
> >>>>>>>> making
> >>>>>>>> it more bloated. In my view, providing a dedicated helper
> >>>>>>>> shmem_allowable_huge_orders(), specifically for shmem, simplifie=
s the logic.
> >>>>>>>
> >>>>>>> My point was really that a single interface (thp_vma_allowable_or=
ders)
> >>>>>>> should be
> >>>>>>> used to get this information. I have no strong opinon on how the
> >>>>>>> implementation
> >>>>>>> of that interface looks. What you suggest below seems perfectly r=
easonable
> >>>>>>> to me.
> >>>>>>
> >>>>>> Right. thp_vma_allowable_orders() might require some care as discu=
ssed in
> >>>>>> other
> >>>>>> context (cleanly separate dax and shmem handling/orders). But that=
 would be
> >>>>>> follow-up cleanups.
> >>>>>
> >>>>> Are you planning to do that, or do you want me to send a patch?
> >>>>
> >>>> I'm planning on looking into some details, especially the interactio=
n with large
> >>>> folios in the pagecache. I'll let you know once I have a better idea=
 what
> >>>> actually should be done :)
> >>>
> >>> OK great - I'll scrub it from my todo list... really getting things d=
one today :)
> >>
> >> Resolved the khugepaged thiny already? :P
> >>
> >> [khugepaged not active when only enabling the sub-size via the 2M fold=
er IIRC]
> >
> > Hmm... baby brain?
>
> :)
>
> I think I only mentioned it in a private mail at some point.
>
> >
> > Sorry about that. I've been a bit useless lately. For some reason it wa=
sn't on
> > my list, but its there now. Will prioritise it, because I agree it's no=
t good.
>
>
> IIRC, if you do
>
> echo never > /sys/kernel/mm/transparent_hugepage/enabled
> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enable=
d
>
> khugepaged will not get activated.

khugepaged is controlled by the top level knob. But the above setting
sounds confusing, can we disable the top level knob, but enable it on
a per-order basis? TBH, it sounds weird and doesn't make too much
sense to me.

>
> --
> Cheers,
>
> David / dhildenb
>
>


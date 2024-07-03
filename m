Return-Path: <linux-kernel+bounces-239809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B98926594
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F55E1F22161
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593A18306F;
	Wed,  3 Jul 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMkudysf"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82798181B90
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022898; cv=none; b=TqIVM2/JE4njgZ40dlAAHZ4448WQ6GRPV4n8OwKZ04jOTqUs6nNlNs4j2TQyfmmUB3cMhaHiw0Daaw87ldU3IIOOQcSwlAqeE5FpJOljJuGc+MvD2eKxm6WW/vvQ9TSLOpNoRpH3FhKb+RKZnSuJ8RG9MzjTC21EjBf6r/o4lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022898; c=relaxed/simple;
	bh=fHaG0KS+blzEttrnz11qtCcQu+PPMX0SMJVA6VT34o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvevrz0Lylagw9LAmXvKwLnAZffbF/EQZg2LE+PmHOFOocuA/e2jjsSVK9hF3qpKplg9WH7h0A61b+/DQrqqWupEtuslIr49GZV08ANPAfSKxSktbAb10Lyks/KTfQKNU6JWkKqVO1LKD0DsagrixTG4ySfPieDwrrsPqccMzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMkudysf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7252bfe773so588227566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720022895; x=1720627695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2pdxtnt1FgHWWmn6kO+dZg+GShFc0xP2wGWgU3fL8M=;
        b=RMkudysfLlxdJ+z3adfoQWeHYIT01bXLqQnN3oKHkMdqw1GMNW9mgcIdHg0ATSke8n
         wQ6V6i17uvX9JZ4Ow6K+B98zrISsbPN3+mz7mPifE8BlDwABSjxFutXEsyiDgntSEMvJ
         Og0Lg/C9ukf+faeuOMEZtwGBaseGE19FcDYWfEQmkwFD3EjhaaVPQjmLvugLVnlwMMOy
         3YzfeDu8AqzSyuveGNDvdG2cnwcbORfajUkQAMadT07oryLZnBV9oZBKdV8PJmDLJFIc
         UP7KCa3UBcVdrsdvhiwUQWeYgH1ajdQlp3vwdFOeDwbgh+werG1f4cQkvnc51bTA8Mu7
         Pnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720022895; x=1720627695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2pdxtnt1FgHWWmn6kO+dZg+GShFc0xP2wGWgU3fL8M=;
        b=ebvHZg/77kWah+DcJs2SBSAPuW9/kXANofAVY9ElhC4O0Pqg00l04T1pHBaiUNgTOR
         dCSpBipKfpG2ofjeuiIRGpy4b6vgzr/amK6cIWti7aXQ/D3d9r53MFmhdNJomX4B+zBU
         z5FZkQ/pD3JlYMoRK+XhrZRXBmuJofb2uQDyJbp9zyBlSDwB/WfHkNlblZS6/RN12FCk
         x47VxDT+uTUmsdpNi+Ii8D2v1FT7PBVq8Q7pxdkYj2hCuihKG/qK31x8m0RRU1tOElOc
         8XoHt29bh6smr2Rg/xM0pf1Xl/dA3JTrQiKFOfzZ8vq9iDjOiUbt5yBs5FPjFEIWLUMX
         v5bA==
X-Forwarded-Encrypted: i=1; AJvYcCW367OommWI/gTqK/vN6sGarFYqlag0K8RRlvXHIOCrm8N4PJPmiUJuZeZkFYsvAgS1Te3rbZBlxIWzD0RtSMELwTYxwDcIHwJZIUa2
X-Gm-Message-State: AOJu0Yxtb/BHOXsL+jw7Z9yqXmI32AOk1POY37sc2jXtBcOFN5ILHUAZ
	MSlgu+xdQ/swWAPjovLi6c9q35/2k3JAbIFRnyeOupsLNhLADPwsnZJKpTS2oBwGa9dhEMT3z64
	sMtKJ45iMnBC+JoLM4erciEtWqpA=
X-Google-Smtp-Source: AGHT+IFhUYFRhbui+Csdt7xE9fVsW4u4K1V66lh8/QMfBbE5wBLTgGo+YtsbsKo4CbCgHrVoXI0iXOKehgKEPUsuL/M=
X-Received: by 2002:a17:906:1749:b0:a72:5226:331d with SMTP id
 a640c23a62f3a-a751445fa4amr765061966b.70.1720022894556; Wed, 03 Jul 2024
 09:08:14 -0700 (PDT)
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
 <CAHbLzkrv2U39oOFuuHpmcfvDOuMayjwdgXLshxtDSSPGPzOkJQ@mail.gmail.com> <2450e4f8-236f-49ce-8bd3-b30a6d8c5e57@arm.com>
In-Reply-To: <2450e4f8-236f-49ce-8bd3-b30a6d8c5e57@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 3 Jul 2024 09:08:01 -0700
Message-ID: <CAHbLzkponjBbtYo6F0+QJ_tmoUFa8i2VPCX7MGX758sAmyLtpQ@mail.gmail.com>
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Bang Li <libang.li@antgroup.com>, hughd@google.com, akpm@linux-foundation.org, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:24=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 01/07/2024 19:20, Yang Shi wrote:
> > On Mon, Jul 1, 2024 at 3:23=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 01.07.24 12:16, Ryan Roberts wrote:
> >>> On 01/07/2024 10:17, David Hildenbrand wrote:
> >>>> On 01.07.24 11:14, Ryan Roberts wrote:
> >>>>> On 01/07/2024 09:57, David Hildenbrand wrote:
> >>>>>> On 01.07.24 10:50, Ryan Roberts wrote:
> >>>>>>> On 01/07/2024 09:48, David Hildenbrand wrote:
> >>>>>>>> On 01.07.24 10:40, Ryan Roberts wrote:
> >>>>>>>>> On 01/07/2024 09:33, Baolin Wang wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 2024/7/1 15:55, Ryan Roberts wrote:
> >>>>>>>>>>> On 28/06/2024 11:49, Bang Li wrote:
> >>>>>>>>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support =
for
> >>>>>>>>>>>> anonymous shmem"), we can configure different policies throu=
gh
> >>>>>>>>>>>> the multi-size THP sysfs interface for anonymous shmem. But
> >>>>>>>>>>>> currently "THPeligible" indicates only whether the mapping i=
s
> >>>>>>>>>>>> eligible for allocating THP-pages as well as the THP is PMD
> >>>>>>>>>>>> mappable or not for anonymous shmem, we need to support sema=
ntics
> >>>>>>>>>>>> for mTHP with anonymous shmem similar to those for mTHP with
> >>>>>>>>>>>> anonymous memory.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>       fs/proc/task_mmu.c      | 10 +++++++---
> >>>>>>>>>>>>       include/linux/huge_mm.h | 11 +++++++++++
> >>>>>>>>>>>>       mm/shmem.c              |  9 +--------
> >>>>>>>>>>>>       3 files changed, 19 insertions(+), 11 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>>>>>>>>>>> index 93fb2c61b154..09b5db356886 100644
> >>>>>>>>>>>> --- a/fs/proc/task_mmu.c
> >>>>>>>>>>>> +++ b/fs/proc/task_mmu.c
> >>>>>>>>>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m,=
 void *v)
> >>>>>>>>>>>>       {
> >>>>>>>>>>>>           struct vm_area_struct *vma =3D v;
> >>>>>>>>>>>>           struct mem_size_stats mss =3D {};
> >>>>>>>>>>>> +    bool thp_eligible;
> >>>>>>>>>>>>             smap_gather_stats(vma, &mss, 0);
> >>>>>>>>>>>>       @@ -882,9 +883,12 @@ static int show_smap(struct seq_f=
ile *m, void
> >>>>>>>>>>>> *v)
> >>>>>>>>>>>>             __show_smap(m, &mss, false);
> >>>>>>>>>>>>       -    seq_printf(m, "THPeligible:    %8u\n",
> >>>>>>>>>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
> >>>>>>>>>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_AL=
L));
> >>>>>>>>>>>> +    thp_eligible =3D !!thp_vma_allowable_orders(vma, vma->v=
m_flags,
> >>>>>>>>>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_=
ORDERS_ALL);
> >>>>>>>>>>>> +    if (vma_is_anon_shmem(vma))
> >>>>>>>>>>>> +        thp_eligible =3D
> >>>>>>>>>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
> >>>>>>>>>>>> +                            vma, vma->vm_pgoff, thp_eligibl=
e);
> >>>>>>>>>>>
> >>>>>>>>>>> Afraid I haven't been following the shmem mTHP support work a=
s much as I
> >>>>>>>>>>> would
> >>>>>>>>>>> have liked, but is there a reason why we need a separate func=
tion for
> >>>>>>>>>>> shmem?
> >>>>>>>>>>
> >>>>>>>>>> Since shmem_allowable_huge_orders() only uses shmem specific l=
ogic to
> >>>>>>>>>> determine
> >>>>>>>>>> if huge orders are allowable, there is no need to complicate t=
he
> >>>>>>>>>> thp_vma_allowable_orders() function by adding more shmem relat=
ed logic,
> >>>>>>>>>> making
> >>>>>>>>>> it more bloated. In my view, providing a dedicated helper
> >>>>>>>>>> shmem_allowable_huge_orders(), specifically for shmem, simplif=
ies the logic.
> >>>>>>>>>
> >>>>>>>>> My point was really that a single interface (thp_vma_allowable_=
orders)
> >>>>>>>>> should be
> >>>>>>>>> used to get this information. I have no strong opinon on how th=
e
> >>>>>>>>> implementation
> >>>>>>>>> of that interface looks. What you suggest below seems perfectly=
 reasonable
> >>>>>>>>> to me.
> >>>>>>>>
> >>>>>>>> Right. thp_vma_allowable_orders() might require some care as dis=
cussed in
> >>>>>>>> other
> >>>>>>>> context (cleanly separate dax and shmem handling/orders). But th=
at would be
> >>>>>>>> follow-up cleanups.
> >>>>>>>
> >>>>>>> Are you planning to do that, or do you want me to send a patch?
> >>>>>>
> >>>>>> I'm planning on looking into some details, especially the interact=
ion with large
> >>>>>> folios in the pagecache. I'll let you know once I have a better id=
ea what
> >>>>>> actually should be done :)
> >>>>>
> >>>>> OK great - I'll scrub it from my todo list... really getting things=
 done today :)
> >>>>
> >>>> Resolved the khugepaged thiny already? :P
> >>>>
> >>>> [khugepaged not active when only enabling the sub-size via the 2M fo=
lder IIRC]
> >>>
> >>> Hmm... baby brain?
> >>
> >> :)
> >>
> >> I think I only mentioned it in a private mail at some point.
> >>
> >>>
> >>> Sorry about that. I've been a bit useless lately. For some reason it =
wasn't on
> >>> my list, but its there now. Will prioritise it, because I agree it's =
not good.
> >>
> >>
> >> IIRC, if you do
> >>
> >> echo never > /sys/kernel/mm/transparent_hugepage/enabled
> >> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/ena=
bled
> >>
> >> khugepaged will not get activated.
> >
> > khugepaged is controlled by the top level knob.
>
> What do you mean by "top level knob"? I assume
> /sys/kernel/mm/transparent_hugepage/enabled ?

Yes.

>
> If so, that's not really a thing in its own right; its just the legacy PM=
D-size
> THP control, and we only take any notice of it if a per-size control is s=
et to
> "inherit". So if we have:
>
> # echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enab=
led
>
> Then by design, /sys/kernel/mm/transparent_hugepage/enabled should be ign=
ored.
>
> > But the above setting
> > sounds confusing, can we disable the top level knob, but enable it on
> > a per-order basis? TBH, it sounds weird and doesn't make too much
> > sense to me.
>
> Well that's the design and that's how its documented. It's done this way =
for
> back-compat. All controls are now per-size. But at boot, we default all p=
er-size
> controls to "never" except for the PMD-sized control, which is defaulted =
to
> "inherit". That way, an unenlightened user-space can still control PMD-si=
zed THP
> via the legacy (top-level) control. But enlightened apps can directly con=
trol
> per-size.

OK, good to know.

>
> I'm not sure how your way would work, because you would have 2 controls
> competing to do the same thing?

I don't see how they compete if they are 2-level knobs. And I failed
to see how it achieved back-compat. For example, memcached reads
/sys/kernel/mm/transparent_hugepage/enabled to determine whether it
should manage memory in huge page (2M) granularity. If the setting is
set to :

# echo never > /sys/kernel/mm/transparent_hugepage/enabled
# echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enable=
d

memcached will manage memory in 4K granularity, but 2M THP is actually
enabled unless memcached checks the per-order knobs.

If we use 2-level mode, memcached doesn't need check per-order setting
at all in order to know whether THP is enabled or not. And it actually
doesn't care about what orders are enabled, it assumes THP size is 2M
(or PMD size). Even though 2M is not enabled but lower orders are
enabled, memcached still can fully utilize the mTHP since the memory
chunk managed by memcached is still 2M aligned in this setting. So
unenlightened applications still can work well. Jemalloc should do the
similar thing if I remember correctly.

>
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
> >>
>


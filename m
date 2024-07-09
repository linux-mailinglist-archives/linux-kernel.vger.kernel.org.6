Return-Path: <linux-kernel+bounces-246566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C167C92C39A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BF1F23687
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5567918561B;
	Tue,  9 Jul 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FagUBUVj"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37903182A40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551724; cv=none; b=lwblfUwf6wGSpkYj6JeuBFvgjB1A5vjZg8s3w64ppyvpjbvpl9wzAPqf6keS3T8CNLoQYQahmCYWep65ORKexmm11LfndzqzYdeCniBIHsGRlXX1UzUWgs2n4R/WcmBO898ZjGRdZjaswIiB+KwHaj4TBMtGHRmuxscyfvsv5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551724; c=relaxed/simple;
	bh=MkD2+Ry7waYISDSrVQe3JW61+5se+5J4M7f91/nZ1z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn/7zXpy/wJoFNrZaRqy1q1C13sQyumsHYiJqCO5gT7LQpHjCjgzgLH+MydNhhEPHwiX6FVDRC9+t8Lv282p3S/mhr1oj5jDe5Ao+Ywm3pbJq+pyKKqvZAG1yVKAaUg5tH3sfKeHKV9p5b4l6x9VJfQFgOp73T1kkOxaSh+dUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FagUBUVj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77e85cb9b4so345614266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720551721; x=1721156521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh4Nx3pgMgKbKwDw84/HlJyWLA/Ba2ctRGqEg5L1e1Q=;
        b=FagUBUVjZEGx0iWDGDxoXOy/kdBR+TaXxUnoGe6Ypqn1hNtQcoOGKESCT0xOjq1e/G
         SfCUBomEUJ8zD4EjS7W1FUJIQ7+RbEKj9aVX5BuXnbtoGkdXNhnGQ1YjgZCuwv4bbiNR
         kLQOY6GA8x8NUXaDdF7GdGGsSiChTNMChgaHD8VbFAi5ZpkY0o/LGrSBCmUi7xkunrNt
         A/30r4pxkXhO+Sn/Blz3XUiHbeZ2q+7XMcdHlKjR5rg9r+U3cMmf9J6Hjsf5zPlto5XQ
         YORI8nAfT3/cGq5Oy0zWz8BrA8nKwdvfmcNzLTSnvZr9JbHWJN08quIk69dUnlomppyl
         TAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551721; x=1721156521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh4Nx3pgMgKbKwDw84/HlJyWLA/Ba2ctRGqEg5L1e1Q=;
        b=hHWczweI9ih57qvZtRPZ4Ucb0h3efITMKFOXzRyZTbDply98ADBrT0Z/RdYDSYsdPn
         fKMJRtkWwa1E1+onKwdukrNjUOVzB0lAvWpyvjS+jwfSrpIFWJ5BfR07ek8J8BQGLy1d
         ntiXm8oqbxRNPKPPcETa7pNKBKefvZEPBJZcrV7Yn/CRLuNZP5cVuSPQxF84gbISkcxn
         SWD52zMuk4oD3autrlKZydWGGPClcBinjIv/Zn/rppKMpirb2LpQkZxj+LY1FG6l8+Ia
         +toCJ0QUNPAD08lv0yLKFkXBhfjIqY/611luTU6pmEwladrxQ3dpY3QIwqHYqUvmEUrP
         9B6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKW3nyOYpSdTP7iaOXDRBq/xRYkbv+0fR24vHY2fU9i0q4o1alzygeLDBcrv8j4aEZBH0PyD8R6Ki/eKyieGoyft2jCRjfVWVqptI5
X-Gm-Message-State: AOJu0YzrwDXE+TfSosktKbqWRZLNTEibFnAbLVBByDHq2pm46cUJqvjj
	p3NHxspT4uHktG90+C/hdVAj8deQehSpFdodX3qLk86a+ivE0RGsejN5EM0cj7nTWHSlM+vvyVZ
	J2iT8morT31ft0lQ/6cUlryBRZ5w=
X-Google-Smtp-Source: AGHT+IHiMEWKaCzY3i6yd3Ry71b2GNBonESSLQAHh9ascdlMyzgNoUqeLMOkK2qTMu0zyCsUADKHAa3M+d3hVhY7MZ8=
X-Received: by 2002:a17:906:6a06:b0:a6f:173d:36b9 with SMTP id
 a640c23a62f3a-a780b68a4dcmr266684666b.16.1720551720306; Tue, 09 Jul 2024
 12:02:00 -0700 (PDT)
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
 <CAHbLzkrv2U39oOFuuHpmcfvDOuMayjwdgXLshxtDSSPGPzOkJQ@mail.gmail.com>
 <2450e4f8-236f-49ce-8bd3-b30a6d8c5e57@arm.com> <CAHbLzkponjBbtYo6F0+QJ_tmoUFa8i2VPCX7MGX758sAmyLtpQ@mail.gmail.com>
 <4de05ed8-6ec7-4b90-942c-a170a26be384@arm.com>
In-Reply-To: <4de05ed8-6ec7-4b90-942c-a170a26be384@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 9 Jul 2024 12:01:47 -0700
Message-ID: <CAHbLzkoQ+dZK4Zm2=mFWT-vE1BR10Q43+DMDNzm5jxEiCqwDbg@mail.gmail.com>
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Bang Li <libang.li@antgroup.com>, hughd@google.com, akpm@linux-foundation.org, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:43=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 03/07/2024 17:08, Yang Shi wrote:
> > On Tue, Jul 2, 2024 at 1:24=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 01/07/2024 19:20, Yang Shi wrote:
> >>> On Mon, Jul 1, 2024 at 3:23=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>> On 01.07.24 12:16, Ryan Roberts wrote:
> >>>>> On 01/07/2024 10:17, David Hildenbrand wrote:
> >>>>>> On 01.07.24 11:14, Ryan Roberts wrote:
> >>>>>>> On 01/07/2024 09:57, David Hildenbrand wrote:
> >>>>>>>> On 01.07.24 10:50, Ryan Roberts wrote:
> >>>>>>>>> On 01/07/2024 09:48, David Hildenbrand wrote:
> >>>>>>>>>> On 01.07.24 10:40, Ryan Roberts wrote:
> >>>>>>>>>>> On 01/07/2024 09:33, Baolin Wang wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2024/7/1 15:55, Ryan Roberts wrote:
> >>>>>>>>>>>>> On 28/06/2024 11:49, Bang Li wrote:
> >>>>>>>>>>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP suppor=
t for
> >>>>>>>>>>>>>> anonymous shmem"), we can configure different policies thr=
ough
> >>>>>>>>>>>>>> the multi-size THP sysfs interface for anonymous shmem. Bu=
t
> >>>>>>>>>>>>>> currently "THPeligible" indicates only whether the mapping=
 is
> >>>>>>>>>>>>>> eligible for allocating THP-pages as well as the THP is PM=
D
> >>>>>>>>>>>>>> mappable or not for anonymous shmem, we need to support se=
mantics
> >>>>>>>>>>>>>> for mTHP with anonymous shmem similar to those for mTHP wi=
th
> >>>>>>>>>>>>>> anonymous memory.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>       fs/proc/task_mmu.c      | 10 +++++++---
> >>>>>>>>>>>>>>       include/linux/huge_mm.h | 11 +++++++++++
> >>>>>>>>>>>>>>       mm/shmem.c              |  9 +--------
> >>>>>>>>>>>>>>       3 files changed, 19 insertions(+), 11 deletions(-)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>>>>>>>>>>>>> index 93fb2c61b154..09b5db356886 100644
> >>>>>>>>>>>>>> --- a/fs/proc/task_mmu.c
> >>>>>>>>>>>>>> +++ b/fs/proc/task_mmu.c
> >>>>>>>>>>>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *=
m, void *v)
> >>>>>>>>>>>>>>       {
> >>>>>>>>>>>>>>           struct vm_area_struct *vma =3D v;
> >>>>>>>>>>>>>>           struct mem_size_stats mss =3D {};
> >>>>>>>>>>>>>> +    bool thp_eligible;
> >>>>>>>>>>>>>>             smap_gather_stats(vma, &mss, 0);
> >>>>>>>>>>>>>>       @@ -882,9 +883,12 @@ static int show_smap(struct seq=
_file *m, void
> >>>>>>>>>>>>>> *v)
> >>>>>>>>>>>>>>             __show_smap(m, &mss, false);
> >>>>>>>>>>>>>>       -    seq_printf(m, "THPeligible:    %8u\n",
> >>>>>>>>>>>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
> >>>>>>>>>>>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_=
ALL));
> >>>>>>>>>>>>>> +    thp_eligible =3D !!thp_vma_allowable_orders(vma, vma-=
>vm_flags,
> >>>>>>>>>>>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, TH=
P_ORDERS_ALL);
> >>>>>>>>>>>>>> +    if (vma_is_anon_shmem(vma))
> >>>>>>>>>>>>>> +        thp_eligible =3D
> >>>>>>>>>>>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
> >>>>>>>>>>>>>> +                            vma, vma->vm_pgoff, thp_eligi=
ble);
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Afraid I haven't been following the shmem mTHP support work=
 as much as I
> >>>>>>>>>>>>> would
> >>>>>>>>>>>>> have liked, but is there a reason why we need a separate fu=
nction for
> >>>>>>>>>>>>> shmem?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Since shmem_allowable_huge_orders() only uses shmem specific=
 logic to
> >>>>>>>>>>>> determine
> >>>>>>>>>>>> if huge orders are allowable, there is no need to complicate=
 the
> >>>>>>>>>>>> thp_vma_allowable_orders() function by adding more shmem rel=
ated logic,
> >>>>>>>>>>>> making
> >>>>>>>>>>>> it more bloated. In my view, providing a dedicated helper
> >>>>>>>>>>>> shmem_allowable_huge_orders(), specifically for shmem, simpl=
ifies the logic.
> >>>>>>>>>>>
> >>>>>>>>>>> My point was really that a single interface (thp_vma_allowabl=
e_orders)
> >>>>>>>>>>> should be
> >>>>>>>>>>> used to get this information. I have no strong opinon on how =
the
> >>>>>>>>>>> implementation
> >>>>>>>>>>> of that interface looks. What you suggest below seems perfect=
ly reasonable
> >>>>>>>>>>> to me.
> >>>>>>>>>>
> >>>>>>>>>> Right. thp_vma_allowable_orders() might require some care as d=
iscussed in
> >>>>>>>>>> other
> >>>>>>>>>> context (cleanly separate dax and shmem handling/orders). But =
that would be
> >>>>>>>>>> follow-up cleanups.
> >>>>>>>>>
> >>>>>>>>> Are you planning to do that, or do you want me to send a patch?
> >>>>>>>>
> >>>>>>>> I'm planning on looking into some details, especially the intera=
ction with large
> >>>>>>>> folios in the pagecache. I'll let you know once I have a better =
idea what
> >>>>>>>> actually should be done :)
> >>>>>>>
> >>>>>>> OK great - I'll scrub it from my todo list... really getting thin=
gs done today :)
> >>>>>>
> >>>>>> Resolved the khugepaged thiny already? :P
> >>>>>>
> >>>>>> [khugepaged not active when only enabling the sub-size via the 2M =
folder IIRC]
> >>>>>
> >>>>> Hmm... baby brain?
> >>>>
> >>>> :)
> >>>>
> >>>> I think I only mentioned it in a private mail at some point.
> >>>>
> >>>>>
> >>>>> Sorry about that. I've been a bit useless lately. For some reason i=
t wasn't on
> >>>>> my list, but its there now. Will prioritise it, because I agree it'=
s not good.
> >>>>
> >>>>
> >>>> IIRC, if you do
> >>>>
> >>>> echo never > /sys/kernel/mm/transparent_hugepage/enabled
> >>>> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/e=
nabled
> >>>>
> >>>> khugepaged will not get activated.
> >>>
> >>> khugepaged is controlled by the top level knob.
> >>
> >> What do you mean by "top level knob"? I assume
> >> /sys/kernel/mm/transparent_hugepage/enabled ?
> >
> > Yes.
> >
> >>
> >> If so, that's not really a thing in its own right; its just the legacy=
 PMD-size
> >> THP control, and we only take any notice of it if a per-size control i=
s set to
> >> "inherit". So if we have:
> >>
> >> # echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/e=
nabled
> >>
> >> Then by design, /sys/kernel/mm/transparent_hugepage/enabled should be =
ignored.
> >>
> >>> But the above setting
> >>> sounds confusing, can we disable the top level knob, but enable it on
> >>> a per-order basis? TBH, it sounds weird and doesn't make too much
> >>> sense to me.
> >>
> >> Well that's the design and that's how its documented. It's done this w=
ay for
> >> back-compat. All controls are now per-size. But at boot, we default al=
l per-size
> >> controls to "never" except for the PMD-sized control, which is default=
ed to
> >> "inherit". That way, an unenlightened user-space can still control PMD=
-sized THP
> >> via the legacy (top-level) control. But enlightened apps can directly =
control
> >> per-size.
> >
> > OK, good to know.
> >
> >>
> >> I'm not sure how your way would work, because you would have 2 control=
s
> >> competing to do the same thing?
> >
> > I don't see how they compete if they are 2-level knobs.
>
> I'm not sure I understand exactly how your 2-level proposal works. Could =
you
> explain in more detail?
>
> The problem as I see it, is that the control can take multiple values; "n=
ever",
> "always" or "madvise". In a two-level scheme, what do we do when top leve=
l says
> "always" but per-size control says "madvise", or vice-versa? The scheme w=
e
> adopted has clear and obvious (to me at least) semantics in this case.
>
> The other problem is that the top-level control is still used to control =
file
> memory collapse (when CONFIG_READ_ONLY_THP_FOR_FS is configured). If you'=
re
> advocating for a scheme where the top-level is set to the most permissive=
 you
> want to allow, then the per-size controls are only able to further restri=
ct,
> that would make it impossible to, for instance set all 2M THP (inc file-b=
acked)
> to madvise, but set all 64K THP to always.

If we really have such usecases having different orders to have
different modes (always or madvise), I think the top level knob can be
actually simplified to on/off mode. For example, always/madvise maps
to on, never maps to off since the allocation decision (shall allocate
THP or not, and how hard to try) is actually done on a per order
basis. The Memcached usecase actually doesn't care about always or
madvise, as long as it is not never Memcached will manage memory in
huge page granularity.

This might be useful, for example, having high order (i.e. 2M) set to
madvise, low order (i.e. 64K) set to always. This may be able to
achieve some balance between performance and memory usage.

>
> > And I failed
> > to see how it achieved back-compat. For example, memcached reads
> > /sys/kernel/mm/transparent_hugepage/enabled to determine whether it
> > should manage memory in huge page (2M) granularity. If the setting is
> > set to :
> >
> > # echo never > /sys/kernel/mm/transparent_hugepage/enabled
> > # echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/en=
abled
> >
> > memcached will manage memory in 4K granularity, but 2M THP is actually
> > enabled unless memcached checks the per-order knobs.
> >
> > If we use 2-level mode, memcached doesn't need check per-order setting
> > at all in order to know whether THP is enabled or not. And it actually
> > doesn't care about what orders are enabled, it assumes THP size is 2M
> > (or PMD size). Even though 2M is not enabled but lower orders are
> > enabled, memcached still can fully utilize the mTHP since the memory
> > chunk managed by memcached is still 2M aligned in this setting. So
> > unenlightened applications still can work well. Jemalloc should do the
> > similar thing if I remember correctly.
>
> I wonder why we didn't decide to just make
> /sys/kernel/mm/transparent_hugepage/enabled an alias for
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled ? That may h=
ave
> solved this problem more cleanly? But that would have made it difficult t=
o
> introduce "auto" in future (the idea was to set all per-size to 'inherit'=
 and
> then set top-level to 'auto').
>
>
> >
> >>
> >>>
> >>>>
> >>>> --
> >>>> Cheers,
> >>>>
> >>>> David / dhildenb
> >>>>
> >>>>
> >>
>


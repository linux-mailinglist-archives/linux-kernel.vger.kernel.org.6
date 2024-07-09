Return-Path: <linux-kernel+bounces-245426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C692B265
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303C82831B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D1153BC3;
	Tue,  9 Jul 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9z+EV4v"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F812C481
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514448; cv=none; b=RNS4twQpuPuMQ+MHdW/3eD9antyk7AnVFxQYWxQyA+gd+MP4odiRw7J/EdYWEIQe7W4lrgTeSjlRUDFt9wuk907l43r02yu2AweS5nQuO2Kjozc/zFOFY8ItmciR1kfJn3as3exNA222DpdCzJula56gzvQXOwyNcdpZ/OJufWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514448; c=relaxed/simple;
	bh=yQM+Bx2dUaAwvUispGARUQ+dK6sfm3N+ZAZulo489eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOo/qzxNwGsvUvPJbu5ukmgKuP9VROaUaprNwutcYI6UprbVaJLJ/OsLmbcxkL8FxyQVPW59XiV18ytgcjTGJCjA4AjTnmQR6UtCPCL4f6wbnSkMMha0XPkxuFWvmHjJgJTzKW/sgefXDqG7qkFneD1Zjm1EIVTKnAOhmKxFiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9z+EV4v; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4eb02c0c851so1612589e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720514445; x=1721119245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wkf5PEVVroZQU0ibXyGfvUtBNP42hby94wuGeZsbdJI=;
        b=i9z+EV4vGbl1cYwA/8MhQgv4mcqMWeai9KAWB4GV6jnDBo7mgUefDbR5ZTXLSBFjDX
         aSQBC73tQlJaclrmWGk4xTl4gSdWeD8HvGbkCPMClnRgXF+u4ykNl5J383D9kOp8Uzsf
         hdmpaoWXfTM1r8JWoT7S5f8PuX4pYoS+Bn2o0xLvcR/F3z/TT/1hl1jxP8c30wYzhkR1
         9eBqz2+eL0wiDlsBrI2bhsyO72ltck8sQiLODI2Q/zLNMjrMlJgyzVOeQhQJl8EOC43r
         lup45oaFOe9cTXcFG8mDraJ1kqfrWqVXp31V4PQwEPvMbrPsGSFd/+GA8Xg9A6ejcskB
         rxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720514445; x=1721119245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wkf5PEVVroZQU0ibXyGfvUtBNP42hby94wuGeZsbdJI=;
        b=PntfxmEbrofBKoTixGFRUzn6NhksK82OYF37L7P0gysDETrak2BnnqFZAciFc6aeot
         6P3IPJ6jTZaIvMmi+wnh4Az9B4dZUC6zGeDcbbjS+T3+FXKXNGltIBj2JJ2vf3yOksxg
         mlOywUe/s/SxDRQ5mzdqPDRvrJb1yj3apzXPXXnPVR64Rr+S//rg7DxHch1DJkIxcudS
         4OANSjS8sY1QfsI7G2d7/9MoZFR5YqN0BvxYEXE35P0diYuqUb4OkLq4mg1rCnP9Xglb
         hOjJF8+mbf+ajSn1I0ffCD36+3Idzm8snLKx11DsC5ORIAgKxcxiTT5etyGnc592fNzX
         Q2ow==
X-Forwarded-Encrypted: i=1; AJvYcCUAOpgfBCg0FPRdzV8fWb2lOUWdLO7hk2VaTKkqbqSQPeiYU9GMBPsrlAgcn1lIBe4EbHNEkmio4oSYbRg+o61xJO/0zd5Yiu8aAWua
X-Gm-Message-State: AOJu0YxtQKeFF9szqY6hGLMTh2xVhFVRj+GQ9QXT4x2gRQ4NPGxTrexE
	JiVQKDaCxHqeT4fX2++FMngz16en1PPTYcnUIPNpkigWkrXCbSxgTuW1pryaY6be1tF6HBph7WJ
	HEBizyIMdMpP9X6c7zzIJpBI0nmE=
X-Google-Smtp-Source: AGHT+IER5vkOK60vv6XIdWIjwHRWJBQA/EhroFdyPhSSlIy1AfhdGNlsYTeFuCt45vUBeMHALngq0jYU27SITCjg3Eo=
X-Received: by 2002:a05:6122:1350:b0:4f2:ffa9:78b5 with SMTP id
 71dfb90a1353d-4f33f2f7b89mr2189231e0c.11.1720514445409; Tue, 09 Jul 2024
 01:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com> <20240709014413.18044-1-21cnbao@gmail.com>
 <70ac8a5d-f6cf-41e6-b295-cd40b81fa85e@arm.com> <CAGsJ_4xy+ADGF2te4Xh=DMABDGEAAp-7QGPgJF6MstOYXVNYtA@mail.gmail.com>
 <ca200353-da41-4f2e-b036-f22ab4bbf1b6@arm.com>
In-Reply-To: <ca200353-da41-4f2e-b036-f22ab4bbf1b6@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Jul 2024 20:40:33 +1200
Message-ID: <CAGsJ_4zCW41Vr6cwc_Y2Be3-z-WA2Uv3koGJ4HLmw9tV9go1-Q@mail.gmail.com>
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, corbet@lwn.net, 
	da.gomez@samsung.com, david@redhat.com, hughd@google.com, ioworker0@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:35=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 09/07/2024 09:13, Barry Song wrote:
> > On Tue, Jul 9, 2024 at 7:55=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 09/07/2024 02:44, Barry Song wrote:
> >>> On Tue, Jul 9, 2024 at 12:30=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> On 08/07/2024 12:36, Barry Song wrote:
> >>>>> On Mon, Jul 8, 2024 at 11:24=E2=80=AFPM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> >>>>>>
> >>>>>> The legacy PMD-sized THP counters at /proc/vmstat include
> >>>>>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, wh=
ich
> >>>>>> rather confusingly refer to shmem THP and do not include any other=
 types
> >>>>>> of file pages. This is inconsistent since in most other places in =
the
> >>>>>> kernel, THP counters are explicitly separated for anon, shmem and =
file
> >>>>>> flavours. However, we are stuck with it since it constitutes a use=
r ABI.
> >>>>>>
> >>>>>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
> >>>>>> anonymous shmem") added equivalent mTHP stats for shmem, keeping t=
he
> >>>>>> same "file_" prefix in the names. But in future, we may want to ad=
d
> >>>>>> extra stats to cover actual file pages, at which point, it would a=
ll
> >>>>>> become very confusing.
> >>>>>>
> >>>>>> So let's take the opportunity to rename these new counters "shmem_=
"
> >>>>>> before the change makes it upstream and the ABI becomes immutable.
> >>>>>
> >>>>> Personally, I think this approach is much clearer. However, I recal=
l
> >>>>> we discussed this
> >>>>> before [1], and it seems that inconsistency is a concern?
> >>>>
> >>>> Embarrassingly, I don't recall that converstation at all :-| but at =
least what I
> >>>> said then is consistent with what I've done in this patch.
> >>>>
> >>>> I think David's conclusion from that thread was to call them FILE_, =
and add both
> >>>> shmem and pagecache counts to those counters, meaning we can keep th=
e same name
> >>>> as legacy THP counters. But those legacy THP counters only count shm=
em, and I
> >>>> don't think we would get away with adding pagecache counts to those =
at this
> >>>> point? (argument: they have been around for long time and there is a=
 risk that
> >>>> user space relies on them and if they were to dramatically increase =
due to
> >>>> pagecache addition now that could break things). In that case, there=
 is still
> >>>> inconsistency, but its worse; the names are consistent but the seman=
tics are
> >>>> inconsistent.
> >>>>
> >>>> So my vote is to change to SHMEM_ as per this patch :)
> >>>
> >>> I have no objections. However, I dislike the documentation for
> >>> thp_file_*. Perhaps we can clean it all up together ?
> >>
> >> I agree that we should clean this documentation up and I'm happy to ro=
ll it into
> >> v2. However, I don't think what you have suggested is quite right.
> >>
> >> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge *only* =
count
> >> shmem. They don't count pagecache. So perhaps the change should be "..=
.every
> >> time a shmem huge page (dispite being named after "file", the counter =
measures
> >> only shmem) is..."?
> >
> > I understand what you are saying, and I know that thp_file_* has only
> > included shmem so far. My question is whether it will include regular
> > files in the future? If not, I am perfectly fine with your approach.
>
> My whole reasoning for this patch is based on the assertion that since
> THP_FILE_ALLOC has been there for 8 years and in all that time has only c=
ounted
> shmem, then its highly likely that someone is depending on that semantic =
and we
> can't change it. I don't have any actual evidence of code that relies on =
it though.
>
> I propose I change the docs to reflect what's actually happening today (i=
.e.
> shmem *only*). If we later decide we want to also report page cache numbe=
rs
> through that same counter, then we can change the docs at that point. But=
 if I
> get my way, we'll soon have mTHP counters for FILE, which is solely for p=
age
> cache. So You'll be able to get all the fine-grained info out of those an=
d there
> will be no need to mess with the legacy counters.

Make sense to me. I'd rather we go to

/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/file_*
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/shmem_*

if we later have 2MiB file counters.

>
> >
> > READ_ONLY_THP_FOR_FS isn't applicable in this path as it is created
> > by khugepaged collapse.
> >
> >>
> >> thp_file_mapped includes both file and shmem, so agree with your chang=
e there.
> >>
> >> What do you think?
> >>
> >>
> >>>
> >>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentati=
on/admin-guide/mm/transhuge.rst
> >>> index 709fe10b60f4..65df48cb3bbb 100644
> >>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>> @@ -417,21 +417,22 @@ thp_collapse_alloc_failed
> >>>       the allocation.
> >>>
> >>>  thp_file_alloc
> >>> -     is incremented every time a file huge page is successfully
> >>> -     allocated.
> >>> +     is incremented every time a file (including shmem) huge page is
> >>> +     successfully allocated.
> >>>
> >>>  thp_file_fallback
> >>> -     is incremented if a file huge page is attempted to be allocated
> >>> -     but fails and instead falls back to using small pages.
> >>> +     is incremented if a file (including shmem) huge page is attempt=
ed
> >>> +     to be allocated but fails and instead falls back to using small
> >>> +     pages.
> >>>
> >>>  thp_file_fallback_charge
> >>> -     is incremented if a file huge page cannot be charged and instea=
d
> >>> -     falls back to using small pages even though the allocation was
> >>> -     successful.
> >>> +     is incremented if a file (including shmem) huge page cannot be
> >>> +     charged and instead falls back to using small pages even though
> >>> +     the allocation was successful.
> >>>
> >>>  thp_file_mapped
> >>> -     is incremented every time a file huge page is mapped into
> >>> -     user address space.
> >>> +     is incremented every time a file (including shmem) huge page is
> >>> +     mapped into user address space.
> >>>
> >>>  thp_split_page
> >>>       is incremented every time a huge page is split into base
> >>>
> >>>>
> >>>>>
> >>>>> [1] https://lore.kernel.org/linux-mm/05d0096e4ec3e572d1d52d33a31a66=
1321ac1551.1713755580.git.baolin.wang@linux.alibaba.com/
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>>> ---
> >>>>>>
> >>>>>> Hi All,
> >>>>>>
> >>>>>> Applies on top of today's mm-unstable (2073cda629a4) and tested wi=
th mm
> >>>>>> selftests; no regressions observed.
> >>>>>>
> >>>>>> The backstory here is that I'd like to introduce some counters for=
 regular file
> >>>>>> folio allocations to observe how often large folio allocation succ=
eeds, but
> >>>>>> these shmem counters are named "file" which is going to make thing=
s confusing.
> >>>>>> So hoping to solve that before commit 66f44583f9b6 ("mm: shmem: ad=
d mTHP
> >>>>>> counters for anonymous shmem") goes upstream (it is currently in m=
m-stable).
> >>>>>>
> >>>>>> Admittedly, this change means the mTHP stat names are not the same=
 as the legacy
> >>>>>> PMD-size THP names, but I think that's a smaller issue than having=
 "file_" mTHP
> >>>>>> stats that only count shmem, then having to introduce "file2_" or =
"pgcache_"
> >>>>>> stats for the regular file memory, which is even more inconsistent=
 IMHO. I guess
> >>>>>> the alternative is to count both shmem and file in these mTHP stat=
s (that's how
> >>>>>> they were documented anyway) but I think it's better to be able to=
 consider them
> >>>>>> separately like we do for all the other counters.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Ryan
> >>>>>>
> >>>>>>  Documentation/admin-guide/mm/transhuge.rst | 12 ++++++------
> >>>>>>  include/linux/huge_mm.h                    |  6 +++---
> >>>>>>  mm/huge_memory.c                           | 12 ++++++------
> >>>>>>  mm/shmem.c                                 |  8 ++++----
> >>>>>>  4 files changed, 19 insertions(+), 19 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Document=
ation/admin-guide/mm/transhuge.rst
> >>>>>> index 747c811ee8f1..8b891689fc13 100644
> >>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>>>> @@ -496,16 +496,16 @@ swpout_fallback
> >>>>>>         Usually because failed to allocate some continuous swap sp=
ace
> >>>>>>         for the huge page.
> >>>>>>
> >>>>>> -file_alloc
> >>>>>> -       is incremented every time a file huge page is successfully
> >>>>>> +shmem_alloc
> >>>>>> +       is incremented every time a shmem huge page is successfull=
y
> >>>>>>         allocated.
> >>>>>>
> >>>>>> -file_fallback
> >>>>>> -       is incremented if a file huge page is attempted to be allo=
cated
> >>>>>> +shmem_fallback
> >>>>>> +       is incremented if a shmem huge page is attempted to be all=
ocated
> >>>>>>         but fails and instead falls back to using small pages.
> >>>>>>
> >>>>>> -file_fallback_charge
> >>>>>> -       is incremented if a file huge page cannot be charged and i=
nstead
> >>>>>> +shmem_fallback_charge
> >>>>>> +       is incremented if a shmem huge page cannot be charged and =
instead
> >>>>>>         falls back to using small pages even though the allocation=
 was
> >>>>>>         successful.
> >>>>>>
> >>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>>>> index acb6ac24a07e..cff002be83eb 100644
> >>>>>> --- a/include/linux/huge_mm.h
> >>>>>> +++ b/include/linux/huge_mm.h
> >>>>>> @@ -269,9 +269,9 @@ enum mthp_stat_item {
> >>>>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>>>>         MTHP_STAT_SWPOUT,
> >>>>>>         MTHP_STAT_SWPOUT_FALLBACK,
> >>>>>> -       MTHP_STAT_FILE_ALLOC,
> >>>>>> -       MTHP_STAT_FILE_FALLBACK,
> >>>>>> -       MTHP_STAT_FILE_FALLBACK_CHARGE,
> >>>>>> +       MTHP_STAT_SHMEM_ALLOC,
> >>>>>> +       MTHP_STAT_SHMEM_FALLBACK,
> >>>>>> +       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> >>>>>>         MTHP_STAT_SPLIT,
> >>>>>>         MTHP_STAT_SPLIT_FAILED,
> >>>>>>         MTHP_STAT_SPLIT_DEFERRED,
> >>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>>> index 9ec64aa2be94..f9696c94e211 100644
> >>>>>> --- a/mm/huge_memory.c
> >>>>>> +++ b/mm/huge_memory.c
> >>>>>> @@ -568,9 +568,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTH=
P_STAT_ANON_FAULT_FALLBACK);
> >>>>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_=
FAULT_FALLBACK_CHARGE);
> >>>>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >>>>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK)=
;
> >>>>>> -DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >>>>>> -DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >>>>>> -DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBA=
CK_CHARGE);
> >>>>>> +DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
> >>>>>> +DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
> >>>>>> +DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALL=
BACK_CHARGE);
> >>>>>>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> >>>>>>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> >>>>>>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >>>>>> @@ -581,9 +581,9 @@ static struct attribute *stats_attrs[] =3D {
> >>>>>>         &anon_fault_fallback_charge_attr.attr,
> >>>>>>         &swpout_attr.attr,
> >>>>>>         &swpout_fallback_attr.attr,
> >>>>>> -       &file_alloc_attr.attr,
> >>>>>> -       &file_fallback_attr.attr,
> >>>>>> -       &file_fallback_charge_attr.attr,
> >>>>>> +       &shmem_alloc_attr.attr,
> >>>>>> +       &shmem_fallback_attr.attr,
> >>>>>> +       &shmem_fallback_charge_attr.attr,
> >>>>>>         &split_attr.attr,
> >>>>>>         &split_failed_attr.attr,
> >>>>>>         &split_deferred_attr.attr,
> >>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>>>>> index 921d59c3d669..f24dfbd387ba 100644
> >>>>>> --- a/mm/shmem.c
> >>>>>> +++ b/mm/shmem.c
> >>>>>> @@ -1777,7 +1777,7 @@ static struct folio *shmem_alloc_and_add_fol=
io(struct vm_fault *vmf,
> >>>>>>                         if (pages =3D=3D HPAGE_PMD_NR)
> >>>>>>                                 count_vm_event(THP_FILE_FALLBACK);
> >>>>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>>> -                       count_mthp_stat(order, MTHP_STAT_FILE_FALL=
BACK);
> >>>>>> +                       count_mthp_stat(order, MTHP_STAT_SHMEM_FAL=
LBACK);
> >>>>>>  #endif
> >>>>>>                         order =3D next_order(&suitable_orders, ord=
er);
> >>>>>>                 }
> >>>>>> @@ -1804,8 +1804,8 @@ static struct folio *shmem_alloc_and_add_fol=
io(struct vm_fault *vmf,
> >>>>>>                                 count_vm_event(THP_FILE_FALLBACK_C=
HARGE);
> >>>>>>                         }
> >>>>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>>> -                       count_mthp_stat(folio_order(folio), MTHP_S=
TAT_FILE_FALLBACK);
> >>>>>> -                       count_mthp_stat(folio_order(folio), MTHP_S=
TAT_FILE_FALLBACK_CHARGE);
> >>>>>> +                       count_mthp_stat(folio_order(folio), MTHP_S=
TAT_SHMEM_FALLBACK);
> >>>>>> +                       count_mthp_stat(folio_order(folio), MTHP_S=
TAT_SHMEM_FALLBACK_CHARGE);
> >>>>>>  #endif
> >>>>>>                 }
> >>>>>>                 goto unlock;
> >>>>>> @@ -2181,7 +2181,7 @@ static int shmem_get_folio_gfp(struct inode =
*inode, pgoff_t index,
> >>>>>>                         if (folio_test_pmd_mappable(folio))
> >>>>>>                                 count_vm_event(THP_FILE_ALLOC);
> >>>>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>>> -                       count_mthp_stat(folio_order(folio), MTHP_S=
TAT_FILE_ALLOC);
> >>>>>> +                       count_mthp_stat(folio_order(folio), MTHP_S=
TAT_SHMEM_ALLOC);
> >>>>>>  #endif
> >>>>>>                         goto alloced;
> >>>>>>                 }
> >>>>>> --
> >>>>>> 2.43.0
> >>>>>>
> >>>>>
> >

Thanks
Barry


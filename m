Return-Path: <linux-kernel+bounces-245379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAFE92B1DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EF22815BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF2E15219B;
	Tue,  9 Jul 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4MxP9ul"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06D150989
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512806; cv=none; b=SZOUc07n80mQ1q2J0ICH9xHDkUHy0iwyVerCCGYDxCsNldS8jy0N/+wPR2vMp3KH9/QvjeQq+1zp/yScP6ArbKaAtYSFbY6UCjbRfIxghbLoSyFzymqMDnvhBfSEFHQS4ov94y9bbuMUX6DNgucKb1JgDN7rthYOjC9nfloQ5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512806; c=relaxed/simple;
	bh=l+0JA4AQdekPuGSCKlsPlOhzaLYjpGdIwXuJeuUHWMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9AA3+HgMBhZKTugO+xcBkS0SRFgjfi7oohBVinCl9Fl8Bh1UzKe6l9VZdhaWMruHiBzssDQXgbApHCv9D4pfLymWMNJ3BNNBTyOHwYJRjDMgDwpXkok9dQOGv7sbP0Mg2/9iK1bOMeoUsM5NJ4ivlodLP1ByAPAS635Fj/prUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4MxP9ul; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f2e1093abeso1844765e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720512804; x=1721117604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab5Y1VUQuoOzyq8nuVbYD/Ed9ffD45Te09SgAn6tRXo=;
        b=M4MxP9ulwmmb07+3imR7CzhTHNt8YXxXOr94EF15mZeMUoQbv0ZpNjldShBCjHvABT
         zwQIIsBQsb52Vbv+I697v2xYLcWY7pYBut1Lq5QH/urkkCzcYGkgBooN0HHjuif3vNAz
         tL+V70k1kZwHSunvxt6zUQERhr28D5u9RJUrxw0QUxSf5xlLA8EbmZqvEsHfJtuNMPoo
         faFoT/iIsPcdPklYX3HMhTUMqBHk2Kl4F6LZ8NEWvWQO/JA3qJ0GPHxQZ5OklnW/reS9
         z/cQj2qYY7ghKeLI3469bj+Zpirf9mp4w1WLhNK4V+97V+Iek8TkM7/Eo0qmbp/w0sfH
         F4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720512804; x=1721117604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab5Y1VUQuoOzyq8nuVbYD/Ed9ffD45Te09SgAn6tRXo=;
        b=KUmiIJ1rvLpYEuRttVo5/GDw0r8aIF+8lA2yIbZUsESnEOlMW4CDm4vTz9lOwbU5By
         6rQGVVYm1ZushfF7LzjCHruiBbS2ScGSOdQB0UbZsAVwa+FRAMTF57Jl+g3AHTvsBnbQ
         pSZWYUGXn9pc2RivRArxLFBtyXQcww1S3nEiXbWxG6oBRBW6jEyafPWF/Af1RTY+zCSW
         BeitHqYl7Kn5Q1gZHXrCcsqmvYJdoiYnBK4jV64zqEa/2UKT7zLaOmdFQXkszY3XpT4L
         IYqqEllI5uajBUrxkgLh8Kn/uknepOcbhpjjCUXzdcZTOPg0/Y1Pz6yOSCCdz6JY2Nvi
         rJOg==
X-Forwarded-Encrypted: i=1; AJvYcCWEpd/bUCw4/e8vrtJv4GCFtPX17KraeEcD90MPwAjd9DFPHyyMxa6827BF9Ws+eye4Z5hBEW7QxB7ozgD/56ADfR8tWabuFBsAcyjm
X-Gm-Message-State: AOJu0YzTAolPzozzm20Cy18ngHXchvHz3yY2Ia876X7KMVcYrAAghREZ
	bMZoj0Njw172Jjm6ZAPv2fSjgHOCQdrLiNQ0xgq0cJSlPbQlaEN/S6Rnb9PLaM6/615+PbMw2sW
	WRuPdyyeSXu+a3U8hWhsWY2eZImM=
X-Google-Smtp-Source: AGHT+IHYObEmYfEECsSxwORrF9H7EXEX//ZVvH5n3ik1g0i4zYI7j1Iiv05il1fPKrHOmh6dzKmsRS1cnkI7Hj9ZGGc=
X-Received: by 2002:a05:6122:218d:b0:4ed:36f:9b38 with SMTP id
 71dfb90a1353d-4f33f29bc51mr2165474e0c.9.1720512802064; Tue, 09 Jul 2024
 01:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com> <20240709014413.18044-1-21cnbao@gmail.com>
 <70ac8a5d-f6cf-41e6-b295-cd40b81fa85e@arm.com>
In-Reply-To: <70ac8a5d-f6cf-41e6-b295-cd40b81fa85e@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Jul 2024 20:13:10 +1200
Message-ID: <CAGsJ_4xy+ADGF2te4Xh=DMABDGEAAp-7QGPgJF6MstOYXVNYtA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, corbet@lwn.net, 
	da.gomez@samsung.com, david@redhat.com, hughd@google.com, ioworker0@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:55=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 09/07/2024 02:44, Barry Song wrote:
> > On Tue, Jul 9, 2024 at 12:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 08/07/2024 12:36, Barry Song wrote:
> >>> On Mon, Jul 8, 2024 at 11:24=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> The legacy PMD-sized THP counters at /proc/vmstat include
> >>>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, whic=
h
> >>>> rather confusingly refer to shmem THP and do not include any other t=
ypes
> >>>> of file pages. This is inconsistent since in most other places in th=
e
> >>>> kernel, THP counters are explicitly separated for anon, shmem and fi=
le
> >>>> flavours. However, we are stuck with it since it constitutes a user =
ABI.
> >>>>
> >>>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
> >>>> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
> >>>> same "file_" prefix in the names. But in future, we may want to add
> >>>> extra stats to cover actual file pages, at which point, it would all
> >>>> become very confusing.
> >>>>
> >>>> So let's take the opportunity to rename these new counters "shmem_"
> >>>> before the change makes it upstream and the ABI becomes immutable.
> >>>
> >>> Personally, I think this approach is much clearer. However, I recall
> >>> we discussed this
> >>> before [1], and it seems that inconsistency is a concern?
> >>
> >> Embarrassingly, I don't recall that converstation at all :-| but at le=
ast what I
> >> said then is consistent with what I've done in this patch.
> >>
> >> I think David's conclusion from that thread was to call them FILE_, an=
d add both
> >> shmem and pagecache counts to those counters, meaning we can keep the =
same name
> >> as legacy THP counters. But those legacy THP counters only count shmem=
, and I
> >> don't think we would get away with adding pagecache counts to those at=
 this
> >> point? (argument: they have been around for long time and there is a r=
isk that
> >> user space relies on them and if they were to dramatically increase du=
e to
> >> pagecache addition now that could break things). In that case, there i=
s still
> >> inconsistency, but its worse; the names are consistent but the semanti=
cs are
> >> inconsistent.
> >>
> >> So my vote is to change to SHMEM_ as per this patch :)
> >
> > I have no objections. However, I dislike the documentation for
> > thp_file_*. Perhaps we can clean it all up together ?
>
> I agree that we should clean this documentation up and I'm happy to roll =
it into
> v2. However, I don't think what you have suggested is quite right.
>
> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge *only* cou=
nt
> shmem. They don't count pagecache. So perhaps the change should be "...ev=
ery
> time a shmem huge page (dispite being named after "file", the counter mea=
sures
> only shmem) is..."?

I understand what you are saying, and I know that thp_file_* has only
included shmem so far. My question is whether it will include regular
files in the future? If not, I am perfectly fine with your approach.

READ_ONLY_THP_FOR_FS isn't applicable in this path as it is created
by khugepaged collapse.

>
> thp_file_mapped includes both file and shmem, so agree with your change t=
here.
>
> What do you think?
>
>
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 709fe10b60f4..65df48cb3bbb 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -417,21 +417,22 @@ thp_collapse_alloc_failed
> >       the allocation.
> >
> >  thp_file_alloc
> > -     is incremented every time a file huge page is successfully
> > -     allocated.
> > +     is incremented every time a file (including shmem) huge page is
> > +     successfully allocated.
> >
> >  thp_file_fallback
> > -     is incremented if a file huge page is attempted to be allocated
> > -     but fails and instead falls back to using small pages.
> > +     is incremented if a file (including shmem) huge page is attempted
> > +     to be allocated but fails and instead falls back to using small
> > +     pages.
> >
> >  thp_file_fallback_charge
> > -     is incremented if a file huge page cannot be charged and instead
> > -     falls back to using small pages even though the allocation was
> > -     successful.
> > +     is incremented if a file (including shmem) huge page cannot be
> > +     charged and instead falls back to using small pages even though
> > +     the allocation was successful.
> >
> >  thp_file_mapped
> > -     is incremented every time a file huge page is mapped into
> > -     user address space.
> > +     is incremented every time a file (including shmem) huge page is
> > +     mapped into user address space.
> >
> >  thp_split_page
> >       is incremented every time a huge page is split into base
> >
> >>
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/05d0096e4ec3e572d1d52d33a31a6613=
21ac1551.1713755580.git.baolin.wang@linux.alibaba.com/
> >>>
> >>>
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>
> >>>> Hi All,
> >>>>
> >>>> Applies on top of today's mm-unstable (2073cda629a4) and tested with=
 mm
> >>>> selftests; no regressions observed.
> >>>>
> >>>> The backstory here is that I'd like to introduce some counters for r=
egular file
> >>>> folio allocations to observe how often large folio allocation succee=
ds, but
> >>>> these shmem counters are named "file" which is going to make things =
confusing.
> >>>> So hoping to solve that before commit 66f44583f9b6 ("mm: shmem: add =
mTHP
> >>>> counters for anonymous shmem") goes upstream (it is currently in mm-=
stable).
> >>>>
> >>>> Admittedly, this change means the mTHP stat names are not the same a=
s the legacy
> >>>> PMD-size THP names, but I think that's a smaller issue than having "=
file_" mTHP
> >>>> stats that only count shmem, then having to introduce "file2_" or "p=
gcache_"
> >>>> stats for the regular file memory, which is even more inconsistent I=
MHO. I guess
> >>>> the alternative is to count both shmem and file in these mTHP stats =
(that's how
> >>>> they were documented anyway) but I think it's better to be able to c=
onsider them
> >>>> separately like we do for all the other counters.
> >>>>
> >>>> Thanks,
> >>>> Ryan
> >>>>
> >>>>  Documentation/admin-guide/mm/transhuge.rst | 12 ++++++------
> >>>>  include/linux/huge_mm.h                    |  6 +++---
> >>>>  mm/huge_memory.c                           | 12 ++++++------
> >>>>  mm/shmem.c                                 |  8 ++++----
> >>>>  4 files changed, 19 insertions(+), 19 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentat=
ion/admin-guide/mm/transhuge.rst
> >>>> index 747c811ee8f1..8b891689fc13 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -496,16 +496,16 @@ swpout_fallback
> >>>>         Usually because failed to allocate some continuous swap spac=
e
> >>>>         for the huge page.
> >>>>
> >>>> -file_alloc
> >>>> -       is incremented every time a file huge page is successfully
> >>>> +shmem_alloc
> >>>> +       is incremented every time a shmem huge page is successfully
> >>>>         allocated.
> >>>>
> >>>> -file_fallback
> >>>> -       is incremented if a file huge page is attempted to be alloca=
ted
> >>>> +shmem_fallback
> >>>> +       is incremented if a shmem huge page is attempted to be alloc=
ated
> >>>>         but fails and instead falls back to using small pages.
> >>>>
> >>>> -file_fallback_charge
> >>>> -       is incremented if a file huge page cannot be charged and ins=
tead
> >>>> +shmem_fallback_charge
> >>>> +       is incremented if a shmem huge page cannot be charged and in=
stead
> >>>>         falls back to using small pages even though the allocation w=
as
> >>>>         successful.
> >>>>
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index acb6ac24a07e..cff002be83eb 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -269,9 +269,9 @@ enum mthp_stat_item {
> >>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>>         MTHP_STAT_SWPOUT,
> >>>>         MTHP_STAT_SWPOUT_FALLBACK,
> >>>> -       MTHP_STAT_FILE_ALLOC,
> >>>> -       MTHP_STAT_FILE_FALLBACK,
> >>>> -       MTHP_STAT_FILE_FALLBACK_CHARGE,
> >>>> +       MTHP_STAT_SHMEM_ALLOC,
> >>>> +       MTHP_STAT_SHMEM_FALLBACK,
> >>>> +       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> >>>>         MTHP_STAT_SPLIT,
> >>>>         MTHP_STAT_SPLIT_FAILED,
> >>>>         MTHP_STAT_SPLIT_DEFERRED,
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 9ec64aa2be94..f9696c94e211 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -568,9 +568,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_=
STAT_ANON_FAULT_FALLBACK);
> >>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FA=
ULT_FALLBACK_CHARGE);
> >>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> >>>> -DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >>>> -DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >>>> -DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK=
_CHARGE);
> >>>> +DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
> >>>> +DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
> >>>> +DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBA=
CK_CHARGE);
> >>>>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> >>>>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> >>>>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >>>> @@ -581,9 +581,9 @@ static struct attribute *stats_attrs[] =3D {
> >>>>         &anon_fault_fallback_charge_attr.attr,
> >>>>         &swpout_attr.attr,
> >>>>         &swpout_fallback_attr.attr,
> >>>> -       &file_alloc_attr.attr,
> >>>> -       &file_fallback_attr.attr,
> >>>> -       &file_fallback_charge_attr.attr,
> >>>> +       &shmem_alloc_attr.attr,
> >>>> +       &shmem_fallback_attr.attr,
> >>>> +       &shmem_fallback_charge_attr.attr,
> >>>>         &split_attr.attr,
> >>>>         &split_failed_attr.attr,
> >>>>         &split_deferred_attr.attr,
> >>>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>>> index 921d59c3d669..f24dfbd387ba 100644
> >>>> --- a/mm/shmem.c
> >>>> +++ b/mm/shmem.c
> >>>> @@ -1777,7 +1777,7 @@ static struct folio *shmem_alloc_and_add_folio=
(struct vm_fault *vmf,
> >>>>                         if (pages =3D=3D HPAGE_PMD_NR)
> >>>>                                 count_vm_event(THP_FILE_FALLBACK);
> >>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>> -                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBA=
CK);
> >>>> +                       count_mthp_stat(order, MTHP_STAT_SHMEM_FALLB=
ACK);
> >>>>  #endif
> >>>>                         order =3D next_order(&suitable_orders, order=
);
> >>>>                 }
> >>>> @@ -1804,8 +1804,8 @@ static struct folio *shmem_alloc_and_add_folio=
(struct vm_fault *vmf,
> >>>>                                 count_vm_event(THP_FILE_FALLBACK_CHA=
RGE);
> >>>>                         }
> >>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>> -                       count_mthp_stat(folio_order(folio), MTHP_STA=
T_FILE_FALLBACK);
> >>>> -                       count_mthp_stat(folio_order(folio), MTHP_STA=
T_FILE_FALLBACK_CHARGE);
> >>>> +                       count_mthp_stat(folio_order(folio), MTHP_STA=
T_SHMEM_FALLBACK);
> >>>> +                       count_mthp_stat(folio_order(folio), MTHP_STA=
T_SHMEM_FALLBACK_CHARGE);
> >>>>  #endif
> >>>>                 }
> >>>>                 goto unlock;
> >>>> @@ -2181,7 +2181,7 @@ static int shmem_get_folio_gfp(struct inode *i=
node, pgoff_t index,
> >>>>                         if (folio_test_pmd_mappable(folio))
> >>>>                                 count_vm_event(THP_FILE_ALLOC);
> >>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>> -                       count_mthp_stat(folio_order(folio), MTHP_STA=
T_FILE_ALLOC);
> >>>> +                       count_mthp_stat(folio_order(folio), MTHP_STA=
T_SHMEM_ALLOC);
> >>>>  #endif
> >>>>                         goto alloced;
> >>>>                 }
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>

Thanks
Barry


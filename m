Return-Path: <linux-kernel+bounces-280141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E894C648
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F6E1C21F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB015AD86;
	Thu,  8 Aug 2024 21:27:22 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051E145B26
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152441; cv=none; b=KwLeMOxBZVgyRfl9kmEq69pB6KOD4ke6odfWBCHNSkrPYKbenVOMikB9EfSs9uczi4OuJiZUtd4K906m3JJA9y8b2KCcz+68Fp7d2y4ytyYRqIjQluazdBIC0JecLxbpJK867PSmaeCdA9oNfVt73C6rrbsHOck9UwBrPgDwJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152441; c=relaxed/simple;
	bh=esTsMZH/9LTxlDA6EfUCPLlaoA+PCJ3wujUfPX8GBZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfczxtoAbOHvkcrETky7ESZZ7/FUYhCwFeqnb8PAdIfLSqOZpuZlDjOf/VTKdZwbT/p0kDSjFXoTORUaGHmLhVcRzosISYuLvlJze3PC0zo2NN7zfKx+qWFxCtvXThgHszisxmUiX1ww5o+qgmwnlTCEjmfJ2FArqYf9qtUlo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f6e36ea1ebso516891e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152439; x=1723757239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEM57bMsGd2LiGZ0cIQMWRGCVKM7YmCar5qKtXQlN9k=;
        b=fGa9Ra+1X82V+L4bYbnUWDxnzPgch1XnQOIHp+ChP23t8zMgIXr8l1yzOoygAwykW3
         ChMcOhDQJQQ5NWn6K5EBS5Hm3jArhVr+zIYolfs05isuLv7YoxbStfn8pBoLYqSiA0jg
         9F++rmevVoQoUcabKr/6Sn00cTcqDCXJCXsZbgGo8qC2l3hF1aoELzssBgax5XJ1gMnq
         ZY1/av6T/V8GtxBCAcdQgWs5WN+jefocBrSP/90qUjIimZhSnRw7W/bYOejRE7PG3u07
         TF0G0C4CdyR41zC/TuneAnHxUd0fYNoUK+aoJZS02xRiFX/s937HUAn2DeC+277iZmUZ
         j3JA==
X-Forwarded-Encrypted: i=1; AJvYcCX0lJarTJE9bwDibxmu/PAcd1rdIVDEoJmaf79TkG2lwfXXH1wnagQCGK4WDRsFqz/HbO4nSRW6Ift2h0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlt9ptMmcsFpAT2ybfEI8VLOtlFe3dPNKX17N36FmFmC78lSUj
	q8Dc2FIvFJpXqvUm05so1p2yovidNvnp01Gdl9T5BV0IQ9nzVwr5h4GyAQZ2Ll1ezTXpAX7ZPXS
	GMP3/zeHYcKW5kbC33XamZPYrCcc=
X-Google-Smtp-Source: AGHT+IGvb9pCgRYsaz2IEjIApJeKm08lIzCGEkMhAVgb0cxFbJ9uUz9M9p+UragOiOloOJ8i4KCrmsIlJAi9ti4hdI0=
X-Received: by 2002:a05:6122:3bce:b0:4f2:ffa9:78b5 with SMTP id
 71dfb90a1353d-4f9027b9526mr3945389e0c.11.1723152438543; Thu, 08 Aug 2024
 14:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-2-ioworker0@gmail.com>
 <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com> <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
 <CAK1f24=rC+iEHkwAHmPBk=SUQ9HRHLA+Q7aKcADdO3uQSs9pnA@mail.gmail.com> <71fdab06-0442-4c55-811b-b38d3b024c85@arm.com>
In-Reply-To: <71fdab06-0442-4c55-811b-b38d3b024c85@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 09:27:07 +1200
Message-ID: <CAGsJ_4zO52_xGpbJ5MrJLqoxbGShgrwLChWCcr8O6Q6oHzceDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 8:16=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 30/06/2024 12:34, Lance Yang wrote:
> > Hi Barry,
> >
> > Thanks for following up!
> >
> > On Sun, Jun 30, 2024 at 5:48=E2=80=AFPM Barry Song <baohua@kernel.org> =
wrote:
> >>
> >> On Thu, Apr 25, 2024 at 3:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>>
> >>> + Barry
> >>>
> >>> On 24/04/2024 14:51, Lance Yang wrote:
> >>>> At present, the split counters in THP statistics no longer include
> >>>> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP sp=
lit
> >>>> counters to monitor the frequency of mTHP splits. This will assist
> >>>> developers in better analyzing and optimizing system performance.
> >>>>
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >>>>         split_page
> >>>>         split_page_failed
> >>>>         deferred_split_page
> >>>>
> >>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>> ---
> >>>>  include/linux/huge_mm.h |  3 +++
> >>>>  mm/huge_memory.c        | 14 ++++++++++++--
> >>>>  2 files changed, 15 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index 56c7ea73090b..7b9c6590e1f7 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -272,6 +272,9 @@ enum mthp_stat_item {
> >>>>       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>>       MTHP_STAT_ANON_SWPOUT,
> >>>>       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> >>>> +     MTHP_STAT_SPLIT_PAGE,
> >>>> +     MTHP_STAT_SPLIT_PAGE_FAILED,
> >>>> +     MTHP_STAT_DEFERRED_SPLIT_PAGE,
> >>>>       __MTHP_STAT_COUNT
> >>>>  };
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 055df5aac7c3..52db888e47a6 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_=
STAT_ANON_FAULT_FALLBACK);
> >>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FA=
ULT_FALLBACK_CHARGE);
> >>>>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >>>>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_F=
ALLBACK);
> >>>> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> >>>> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILE=
D);
> >>>> +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT=
_PAGE);
> >>>>
> >>>>  static struct attribute *stats_attrs[] =3D {
> >>>>       &anon_fault_alloc_attr.attr,
> >>>> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] =3D {
> >>>>       &anon_fault_fallback_charge_attr.attr,
> >>>>       &anon_swpout_attr.attr,
> >>>>       &anon_swpout_fallback_attr.attr,
> >>>> +     &split_page_attr.attr,
> >>>> +     &split_page_failed_attr.attr,
> >>>> +     &deferred_split_page_attr.attr,
> >>>>       NULL,
> >>>>  };
> >>>>
> >>>> @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
> >>>>       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, ne=
w_order);
> >>>>       struct anon_vma *anon_vma =3D NULL;
> >>>>       struct address_space *mapping =3D NULL;
> >>>> -     bool is_thp =3D folio_test_pmd_mappable(folio);
> >>>> +     int order =3D folio_order(folio);
> >>>>       int extra_pins, ret;
> >>>>       pgoff_t end;
> >>>>       bool is_hzp;
> >>>> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct p=
age *page, struct list_head *list,
> >>>>               i_mmap_unlock_read(mapping);
> >>>>  out:
> >>>>       xas_destroy(&xas);
> >>>> -     if (is_thp)
> >>>> +     if (order >=3D HPAGE_PMD_ORDER)
> >>>>               count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_=
FAILED);
> >>>> +     count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> >>>> +                                   MTHP_STAT_SPLIT_PAGE_FAILED);
> >>>>       return ret;
> >>>>  }
> >>>>
> >>>> @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
> >>>>       if (list_empty(&folio->_deferred_list)) {
> >>>>               if (folio_test_pmd_mappable(folio))
> >>>>                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >>>> +             count_mthp_stat(folio_order(folio),
> >>>> +                             MTHP_STAT_DEFERRED_SPLIT_PAGE);
> >>>
> >>> There is a very long conversation with Barry about adding a 'global "=
mTHP became
> >>> partially mapped 1 or more processes" counter (inc only)', which term=
inates at
> >>> [1]. There is a lot of discussion about the required semantics around=
 the need
> >>> for partial map to cover alignment and contiguity as well as whether =
all pages
> >>> are mapped, and to trigger once it becomes partial in at least 1 proc=
ess.
> >>>
> >>> MTHP_STAT_DEFERRED_SPLIT_PAGE is giving much simpler semantics, but l=
ess
> >>> information as a result. Barry, what's your view here? I'm guessing t=
his doesn't
> >>> quite solve what you are looking for?
> >>
> >> This doesn't quite solve what I am looking for but I still think the
> >> patch has its value.
> >>
> >> I'm looking for a solution that can:
> >>
> >>   *  Count the amount of memory in the system for each mTHP size.
> >>   *  Determine how much memory for each mTHP size is partially unmappe=
d.
> >>
> >> For example, in a system with 16GB of memory, we might find that we ha=
ve 3GB
> >> of 64KB mTHP, and within that, 512MB is partially unmapped, potentiall=
y wasting
> >> memory at this moment.  I'm uncertain whether Lance is interested in
> >> this job :-)
> >
> > Nice, that's an interesting/valuable job for me ;)
> >
> > Let's do it separately, as 'split' and friends probably can=E2=80=99t b=
e the
> > solution you
> > mentioned above, IMHO.
> >
> > Hmm... I don't have a good idea about the solution for now, but will
> > think it over
> > and come back to discuss it here.
>
> I have a grad starting in a couple of weeks and I had been planning to in=
itially
> ask him to look at this to help him get up to speed on mTHP/mm stuff. But=
 I have
> plenty of other things for him to do if Lance wants to take this :)

Hi Ryan, Lance,

My performance profiling is pending on the mTHP size and partially
unmapped mTHP size issues (understanding the distribution of folio
sizes within the system), so I'm not waiting for either Ryan's grad
or Lance. I've sent an RFC for this, and both of you are CC'd:

https://lore.kernel.org/all/20240808010457.228753-1-21cnbao@gmail.com/

Apologies for not waiting.  You are still warmly welcomed to participate
in the discussion and review.

>
> >
> >>
> >> Counting deferred_split remains valuable as it can signal whether the =
system is
> >> experiencing significant partial unmapping.
> >
> > Have a nice weekend!
> > Lance
> >
> >>
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/6cc7d781-884f-4d8f-a175-8609732b=
87eb@arm.com/
> >>>
> >>> Thanks,
> >>> Ryan
> >>>
> >>>>               list_add_tail(&folio->_deferred_list, &ds_queue->split=
_queue);
> >>>>               ds_queue->split_queue_len++;
> >>>>  #ifdef CONFIG_MEMCG
> >>>
> >>

Thanks
Barry


Return-Path: <linux-kernel+bounces-236099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8791DD5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F78B2624A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDC84DEB;
	Mon,  1 Jul 2024 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMDaQUrH"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014D2AD05
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831620; cv=none; b=bDX5378kCC/sHo+f9q+sMWfs7Rh4/dP44jRJi3p/sq+aJKUbLiBwuU9Wt9/pRkoamPFhd+CwLUOly0daCrkL2N6JTdPp1TLFzUxiO1fh8vy7UYlbXM1Bb4yXOIxaoyfEhqOdu43Aiekus/LsMhgbCrfqkE+y94qj285yQfkbCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831620; c=relaxed/simple;
	bh=I+YMfdvVAOPpLwxFIG8c83CKXpkBOQpKWFBy6bnWEDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqbWpwK1PLz3uRfMkr2v8JiwBJBRkDws0fv6hFgsT3s3j/Z2SM/+iYU2QRiBPgAtI8Yfybc22blhqRcwEGT99OXxyZfezKrCtmymCDAuAD3lK030v5/HW6aV/8IkCALrnFl4vF5Evbi8EmOuucQEBGTXC2gM1U/KgmikEV9T2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMDaQUrH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7245453319so450038366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831616; x=1720436416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eilfgo/WFYvAUHuhr+FjQdAbZbTLEYISEvXN5pfKZT8=;
        b=FMDaQUrHETMYppjd3rHCgGDEHFmTVyLU2M7qXGxmTLAGFxcwlvGlGdDkBnJFZbpAAy
         idQG7I7eEvAZrQ/wS5GAwIsM+iCSdqv+19TznePcS4vQLwzZ991SyKyKecNOKT4zVUA0
         2L7JonM4Mc/q8K0yNcWs0Bm05km1+Q8vk/STZSngjg8scWDRi4eEE3J/2Yb80RsPShWp
         6oLEWu1v75B1MSQSTU4FMtkeAkpu0o9NAXi6fatlRvEj0+w5IkJGO7XOxfqtcvZdNw9z
         SAPjePhVpFh13FWXNU5ao3Hqp6VabPP8xT6rtZfo2RHWJqqu74upsh8GdG0Mcel/KTlp
         Tdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831616; x=1720436416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eilfgo/WFYvAUHuhr+FjQdAbZbTLEYISEvXN5pfKZT8=;
        b=A32herFDklXnLMk4aJNpVJJ68ycta0j5/i3JaCyT7bCPy75jjBsnMGeCOydcDpU+yy
         /J8aVx7Ii4LnPgxNOZZ41+A+MRWgmMVgDq6U/xK7ReFbODnqA0NnxkdhPU84G5eHxZdC
         wq6KVZXunvjrHI01YdnZyZOezb0rjy7AcXR4BNbGhL3JR76GjWD2N+fziJywPp7X0HYA
         3euGP9v9d3KrdJzGKFI0jwvwRNOH91UX4vA8dBrEhiPkA3Xu0PW7aidGMRjbr/ovJDI5
         +s+niWNDr6TS9A9BQPQcgEmUjX2rFw6bf/AWKj9mejpSS6UYvktAggWP60eN7QUxCObM
         qtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWqDiLNwGIxIpb4c1z7wVJzLbCIN6eZ1FkjtC73lk5lsC1AwuUDASY60aEt/PYNfLu5qpXaSjPdu2r7XEmWksnswzThKJM06Z9f+xB
X-Gm-Message-State: AOJu0YxKIgFLcwaNDY06tCvNLZ/m/jrSXzJgYzCM8mmNp7vOWK5fAuOx
	r27UPnXI+Ke1t2LdJZsVwahgNp1myyGYCxE08Gz2K4wB9Tmbm+HaGVlrFaip8UVatFpiV0x+m2V
	hbhhXnfYWzvQHnuZG2nqGj+4k4CM=
X-Google-Smtp-Source: AGHT+IFBCdDHbvRPeNgJqM+hIuyqa2hJ4ELc8punHtVTKYOYBDOg78q7oj5Pis1yYOd+RfJd5sIESd/P+UJzAJswQNk=
X-Received: by 2002:a17:906:c141:b0:a72:b3e0:b7f9 with SMTP id
 a640c23a62f3a-a72b3e0b93fmr639741266b.37.1719831616198; Mon, 01 Jul 2024
 04:00:16 -0700 (PDT)
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
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 1 Jul 2024 19:00:04 +0800
Message-ID: <CAK1f24ntDqp6-yYGdyV+YR7QFsd5mD0iB5VvG6tsE=ezi6TNLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <baohua@kernel.org>, akpm@linux-foundation.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:16=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
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

I'm very happy to do that, but it doesn't have to be just me - anyone
with a better
idea can take it on ;)

Thanks,
Lance

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
> >> Thanks
> >> Barry
>


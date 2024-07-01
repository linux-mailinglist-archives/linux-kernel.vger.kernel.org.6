Return-Path: <linux-kernel+bounces-236160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A891DE41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CF9286EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68E142E97;
	Mon,  1 Jul 2024 11:43:33 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA72B9C6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834212; cv=none; b=G+EHoO1ixeSuW21wXJiLGnbtKO1clCjXMWMZK1EBskY6FtiRZnYPmGT8Lo5y+XlNfn29TzBWQp7RtoiIrvX6tvJaLIIEH2xQw6qzbOk+dOHi/A8as3+vr4xcTKUBXrkpeIpuVr9VfaadaS7C8+M+Y1mbKsvN2FxNx6IIcchs3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834212; c=relaxed/simple;
	bh=goHcqtijtG1XyNtclQwebczzV2o/vVd6U3D5n6IMn64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8S+0Y1HMJ2Z49s0jYu5WwIb2dGiW/tl51MS021mKOpkIjlVn4kNzDVUCktObWi6Xgr5HIDa+d042cNZ9+JSJQuhq+G0TwJl+R+1JSzdGmHx5w/kF/B0BCyhrdQHVfE7J9TZafOyriUyvUL9ih4sGjq05zFK2gxNwioAqyesFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48f4b637d9eso978811137.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834210; x=1720439010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3G2470eEcFw6UmTCJCkRFBtzP0Jm2JNeBFsu5sbpgU=;
        b=GR6N+hfZyrALBrVh4TO27GtSmLwc7Fsl8rkRVE9iLnPcKcCdfmcU5iZb3MxfhJalGP
         d97daqaJfkcYAwRpUdhK5FDBy3CFp+MXM5Rxg9ZvFqdz2KAGk2nEUANOFLPYFubxteiK
         BZAvpedK9Eg5cm7SC57pL3p6mzxXO/w5UN3QUKXY2iaI9UbU9R/s7yCWZ6sAiaA3spL5
         QgWuQFqnBzYGYY/iZ4uyGFcy7lc+7YnhDGbZpGUBdwgFmWtlB78H50wUFRogIi8VEAS0
         1V/zG+FlYluGUcfRiwhsKKR1Ch8q7U1yr10sY9przofYgn4PykFA0+M0KrFwY2WKMWVR
         kJSg==
X-Forwarded-Encrypted: i=1; AJvYcCUjXCqFMQDhUWksCIiaWn6sEASViA1hMPzE4yK2sgbtV7cAO37HEuCdiCnR5ydnKFOVNHs/YroY9Dq7X3NRBuvqXRxXilAAb0a3oAJv
X-Gm-Message-State: AOJu0YzlZQ7WFIX2pselrmEHn8BUV3ecARBb4qyCLCCEI8VSLUf2+o/h
	XI24mQiKYSko0sx4HruAWvMczsYJYHn1bZOoI4GpEWeyDmGNISDUimwixKO+gi2UJxjQzKj74Ux
	Bwgxc8iNUjL1MbvVkGohG6BASCFU=
X-Google-Smtp-Source: AGHT+IEDZS7gSYGlmjbUcIFIwK0quGafVLdoo7CxJsDY1cT+P4Ph9iT34Fl4Ad+wmGxvTxQfG4tdB/0AfRSRNpFvpHQ=
X-Received: by 2002:a05:6102:290b:b0:48f:a4ee:6d73 with SMTP id
 ada2fe7eead31-48faf09ba65mr6548706137.11.1719834209928; Mon, 01 Jul 2024
 04:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-2-ioworker0@gmail.com>
 <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com> <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
 <23d9f708-b1fd-4b10-b755-b7ef6aa683e8@redhat.com>
In-Reply-To: <23d9f708-b1fd-4b10-b755-b7ef6aa683e8@redhat.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 1 Jul 2024 23:43:18 +1200
Message-ID: <CAGsJ_4zz9KKpz51hgmLEv0v=rh1niB1DWqeEPrRrgRVO_0o+-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 8:56=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 30.06.24 11:48, Barry Song wrote:
> > On Thu, Apr 25, 2024 at 3:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> + Barry
> >>
> >> On 24/04/2024 14:51, Lance Yang wrote:
> >>> At present, the split counters in THP statistics no longer include
> >>> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP spl=
it
> >>> counters to monitor the frequency of mTHP splits. This will assist
> >>> developers in better analyzing and optimizing system performance.
> >>>
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >>>          split_page
> >>>          split_page_failed
> >>>          deferred_split_page
> >>>
> >>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>> ---
> >>>   include/linux/huge_mm.h |  3 +++
> >>>   mm/huge_memory.c        | 14 ++++++++++++--
> >>>   2 files changed, 15 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>> index 56c7ea73090b..7b9c6590e1f7 100644
> >>> --- a/include/linux/huge_mm.h
> >>> +++ b/include/linux/huge_mm.h
> >>> @@ -272,6 +272,9 @@ enum mthp_stat_item {
> >>>        MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>        MTHP_STAT_ANON_SWPOUT,
> >>>        MTHP_STAT_ANON_SWPOUT_FALLBACK,
> >>> +     MTHP_STAT_SPLIT_PAGE,
> >>> +     MTHP_STAT_SPLIT_PAGE_FAILED,
> >>> +     MTHP_STAT_DEFERRED_SPLIT_PAGE,
> >>>        __MTHP_STAT_COUNT
> >>>   };
> >>>
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 055df5aac7c3..52db888e47a6 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_S=
TAT_ANON_FAULT_FALLBACK);
> >>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FA=
ULT_FALLBACK_CHARGE);
> >>>   DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >>>   DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_F=
ALLBACK);
> >>> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> >>> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED=
);
> >>> +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_=
PAGE);
> >>>
> >>>   static struct attribute *stats_attrs[] =3D {
> >>>        &anon_fault_alloc_attr.attr,
> >>> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] =3D {
> >>>        &anon_fault_fallback_charge_attr.attr,
> >>>        &anon_swpout_attr.attr,
> >>>        &anon_swpout_fallback_attr.attr,
> >>> +     &split_page_attr.attr,
> >>> +     &split_page_failed_attr.attr,
> >>> +     &deferred_split_page_attr.attr,
> >>>        NULL,
> >>>   };
> >>>
> >>> @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
> >>>        XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, ne=
w_order);
> >>>        struct anon_vma *anon_vma =3D NULL;
> >>>        struct address_space *mapping =3D NULL;
> >>> -     bool is_thp =3D folio_test_pmd_mappable(folio);
> >>> +     int order =3D folio_order(folio);
> >>>        int extra_pins, ret;
> >>>        pgoff_t end;
> >>>        bool is_hzp;
> >>> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
> >>>                i_mmap_unlock_read(mapping);
> >>>   out:
> >>>        xas_destroy(&xas);
> >>> -     if (is_thp)
> >>> +     if (order >=3D HPAGE_PMD_ORDER)
> >>>                count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_=
FAILED);
> >>> +     count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> >>> +                                   MTHP_STAT_SPLIT_PAGE_FAILED);
> >>>        return ret;
> >>>   }
> >>>
> >>> @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
> >>>        if (list_empty(&folio->_deferred_list)) {
> >>>                if (folio_test_pmd_mappable(folio))
> >>>                        count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >>> +             count_mthp_stat(folio_order(folio),
> >>> +                             MTHP_STAT_DEFERRED_SPLIT_PAGE);
> >>
> >> There is a very long conversation with Barry about adding a 'global "m=
THP became
> >> partially mapped 1 or more processes" counter (inc only)', which termi=
nates at
> >> [1]. There is a lot of discussion about the required semantics around =
the need
> >> for partial map to cover alignment and contiguity as well as whether a=
ll pages
> >> are mapped, and to trigger once it becomes partial in at least 1 proce=
ss.
> >>
> >> MTHP_STAT_DEFERRED_SPLIT_PAGE is giving much simpler semantics, but le=
ss
> >> information as a result. Barry, what's your view here? I'm guessing th=
is doesn't
> >> quite solve what you are looking for?
> >
> > This doesn't quite solve what I am looking for but I still think the
> > patch has its value.
> >
> > I'm looking for a solution that can:
> >
> >    *  Count the amount of memory in the system for each mTHP size.
> >    *  Determine how much memory for each mTHP size is partially unmappe=
d.
> >
> > For example, in a system with 16GB of memory, we might find that we hav=
e 3GB
> > of 64KB mTHP, and within that, 512MB is partially unmapped, potentially=
 wasting
> > memory at this moment.  I'm uncertain whether Lance is interested in
> > this job :-)
> >
> > Counting deferred_split remains valuable as it can signal whether the s=
ystem is
> > experiencing significant partial unmapping.
>
> I'll note that, especially without subpage mapcounts, in the future we
> won't have that information (how much is currently mapped) readily
> available in all cases. To obtain that information on demand, we'd have
> to scan page tables or walk the rmap.

I'd like to keep things simple. We can ignore the details about how
the folio is partially
unmapped. For example, whether 15 out of 16 subpages are unmapped or just 1=
 is
unmapped doesn't matter. When we add a folio to the deferred_list, we
increase the
count by 1. When we remove a folio from the deferred_list (for any
reason, such as
a real split), we decrease the count by 1.

If we find that (partial_unmap mTHP * 100) / all mTHP for this size
shows a large
number, it is a strong indication that userspace needs some tuning.

>
> Something to keep in mind: we don't want to introduce counters that will
> be expensive to maintain longterm.
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


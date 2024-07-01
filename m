Return-Path: <linux-kernel+bounces-236104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C726E91DD77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C628142C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C652513C68A;
	Mon,  1 Jul 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltoYlwSQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F10376E7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831992; cv=none; b=gdZtCJXg8xOYPvIQPpp0igTBaKoV5S3iMz5TbuH1gnn4yqPh3BYtcGJ2kAA9O5pVOJTMsddo5W1kciFOmNM1KyC52kW6lr1oQ5Gz5whZKSlXbOJ3GfWTjyYjpsVkmU5ZUg00H7Wtf+9EHG3bkeDyaN+eK+vlVDJi+feg/7nPF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831992; c=relaxed/simple;
	bh=f2o9kwIDhvlj9Lu6AS5DCzydKAe6dw1U4piN2Z/v38A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD3IJ7LBzYKnHqU9QunO0EAcLNVQmIYMVbwLSKZ1dnV3USO3i3wc4PewqFHlmY0utYB+6tw4MdVwliVroJnb/yrIP1CMcJTmoKxaxYo4O4shiq+4gJkjgYdWS22rjcrLpBUnNWW/wYCTRivodiotqu0PbuAKmneq/+E/yJsKzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltoYlwSQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7523f0870cso124871866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831988; x=1720436788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w+BuytsqZsO9Y4U62aqCkkMYRmrN9tWjBqBOSV8o8E=;
        b=ltoYlwSQaBrAivr0r5Z4DN2hl2XaTlpKYdfp6TCkx++OAvvw1kr4CXGtIoifr/t4Ck
         w4pQ3VQF3WwmA8VROm5a0y5ohxX4sNWXUF6U3oj1cZev9M6SVx+gFApE4wqhxP8yLFY8
         nCrZfrS25WUd8SUvXT72imyabvG+YrZBTyRwy9HfAU4xG1b8tPB7Tgl+9k2x7MgZ1ae3
         zm8E+xeXH1AxH53tckTfFhlsXK3GWSdvtyRJokqgvVfSosI4MMxd3z9gK7Y/sLojI21A
         Dc4XvL+jeqRvdNw67QOLafcaByz6uBiOcdj/tTokBROfFhdZD0Lv3UHyjwNadUAE98xu
         h9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831988; x=1720436788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w+BuytsqZsO9Y4U62aqCkkMYRmrN9tWjBqBOSV8o8E=;
        b=lq861sv76oPpcXOaBEGvEnfogEm9vCzWQegeYDPpNsr3qhzrPIZpZei2fiGw2qKbKg
         W7NUfcmsRzP04ioMd3nzH+POzNlgp0sslaXizC5tvMdxwYREO8dhpRasIB2RkJTNw684
         b+ad5GbKC77uuP7qQZKvc1McHf/BJYKuJqilQAsSYhe0ryGmvM+FNB4m/iFsQvm/DzEo
         llNq4oMsvWHR6ecQsscFmhKvMKh+gQfAAXP/JuoG+xeP0qZueFgJ+b8SvBhz1LgGCcKa
         C2KrSJeQCw3c5XXtGgIqFkxSw2ZNpCBt2kCjB26SGMcJ5qMA8SMmdvHo1HBYDJvy1OkM
         C4kA==
X-Forwarded-Encrypted: i=1; AJvYcCVfDEInxk5oU1Th6rRQT4rE7pqHOa9zVNZ7/MEULC24wtFQhooY6vu/yXYER281u10UJ1jOMYPikVUDGbiCz3phtEzlGoelhDZQhaWu
X-Gm-Message-State: AOJu0YwSK4ZFsfQ2Gx9psxj5E6t8yMjraByYBptrBQOiK2W90p83HLl6
	RlRgnwsvAul8gzuB0CszyoJ1QFHzY8JqtQLNI0fkhHzGSg6zK+EOPa3F89oEpYGpfoNmmMuIv2Z
	6Czi5Y2z1nEiQ/gTr12OGZoFfoZM=
X-Google-Smtp-Source: AGHT+IH3AwtXoQhsT2XM4WG0pj8HTzz9DV2+IYdPpTxsPR1gEqvC7acYO+KtfcCMhgBy2tZXWynkk7ky0Y3BJIpXVAw=
X-Received: by 2002:a17:906:d152:b0:a6f:ab9c:7780 with SMTP id
 a640c23a62f3a-a751440f01bmr345735966b.31.1719831988212; Mon, 01 Jul 2024
 04:06:28 -0700 (PDT)
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
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 1 Jul 2024 19:06:17 +0800
Message-ID: <CAK1f24=59+MRvnKLFww1seu==tEWg8FmJrEY5-Uaaf_kwUWWtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Jul 1, 2024 at 4:56=E2=80=AFPM David Hildenbrand <david@redhat.com>=
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

Thanks for pointing that out!

>
> Something to keep in mind: we don't want to introduce counters that will
> be expensive to maintain longterm.

I'll keep that in mind as we move forward with any new implementations.

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>


Return-Path: <linux-kernel+bounces-235162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8254391D0E7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0461C2084D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798F512E1E9;
	Sun, 30 Jun 2024 09:48:22 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2C12C54B
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719740902; cv=none; b=qvTJGALzpUswoQk/YoCfkvIFu6lnPTwZUbJwKUJm/YU5NPX13QK1viuL+o6aRP9WIW9sFO9+OGyiQqw6wMERurjwcSGpx+i5uMZzLc5Ooc06IO9DWW4Q1PkZAWLUVJLEqMNCcHkE4CGgfFLUsocR5DUv4tY/RDxkg8vrUF4BET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719740902; c=relaxed/simple;
	bh=uLdXFmFfmby71EnKktoAxwS4yolwqS7L8AzRQ8EN+pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwVNrnilMESj+SNecUrlzAt7hMbU9BG4lj/yjq800qqkrTu6Qa/SrqyaLesyf5v9Evt0wEjzKrQOnJw0F/mJMD/J6bmQoaNgDks09hwqhNUUfAwJgAXx/nGcY9E6Oamyz+DWb0S9uMNJwQNhTtk5QEXhkGChbemx93JgStFFW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f284e7bb99so1498406e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 02:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719740899; x=1720345699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFrtMqH3ZrUfnW427gKSLTo7U4KD5qBOM6cmzFydm9Y=;
        b=s8rzrrEKVdML21IPH4liYLmYLltqAdAdYf3A4geoCDLsnPqQemHFFtOG2kxgcrIOYN
         R7jWWoMBtyEvlmX1BOntoR4/8CFRZzkhqxOSqbtDopzM7VmfN76Jo73zUkCwLu9zYFFq
         FHihHJejvRazCykGItJ1RxGTZxyXAsJdPBsBi3FTjO9A2H8M3ImBVHL3W8542LjNLtJ2
         jw+FSMJhc+mAOTOav9rebqz0DNLMQtPqSZGhESRWmFrKz4H8SuHXg7Z2RrMIRkuwzNMM
         5KyqK2wS+ZrNTzyQrhK8au3UgGST+9Bkhr709TPznBPtNlSls1yaS0ddziwsVfnEuPLF
         RkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXHdaX14quaTG1CnBOSus72UVz96A6Iemy8eqMCcd9T4p8rkWYwJK0v9X0cE7YGk7Uacd9bovDmaAwyVaRJLs2GBjDRO4UzdZuj5vn
X-Gm-Message-State: AOJu0YzLxUhClph8kmx/uH/Rv3V+ClYS01JCyxs5ZN464PtE+xLqZ5xw
	qJkNJyI4zrXM+KcX9EjSxUbODk2IA7Rra04Q9XXrvQFJxnowu6EaRYczLhwHvGUsnChQm5BmWjw
	NVHh/u+KHmN+nhIP1Uaq+IDSE1oo=
X-Google-Smtp-Source: AGHT+IE5SdNT9qY7dxXVg4Ns8VNIqAhbnKccDdiO7J7M/eMA3pBIGP8i+4I9KditRbtebOKPrX4H1UgcPSeRVwAaXVk=
X-Received: by 2002:a05:6122:2899:b0:4e9:7f5c:88ae with SMTP id
 71dfb90a1353d-4f2a566c5f8mr1409265e0c.1.1719740898972; Sun, 30 Jun 2024
 02:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-2-ioworker0@gmail.com>
 <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com>
In-Reply-To: <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 30 Jun 2024 21:48:07 +1200
Message-ID: <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> + Barry
>
> On 24/04/2024 14:51, Lance Yang wrote:
> > At present, the split counters in THP statistics no longer include
> > PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
> > counters to monitor the frequency of mTHP splits. This will assist
> > developers in better analyzing and optimizing system performance.
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >         split_page
> >         split_page_failed
> >         deferred_split_page
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h |  3 +++
> >  mm/huge_memory.c        | 14 ++++++++++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 56c7ea73090b..7b9c6590e1f7 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -272,6 +272,9 @@ enum mthp_stat_item {
> >       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >       MTHP_STAT_ANON_SWPOUT,
> >       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> > +     MTHP_STAT_SPLIT_PAGE,
> > +     MTHP_STAT_SPLIT_PAGE_FAILED,
> > +     MTHP_STAT_DEFERRED_SPLIT_PAGE,
> >       __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 055df5aac7c3..52db888e47a6 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STA=
T_ANON_FAULT_FALLBACK);
> >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT=
_FALLBACK_CHARGE);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALL=
BACK);
> > +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> > +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
> > +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PA=
GE);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >       &anon_fault_alloc_attr.attr,
> > @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] =3D {
> >       &anon_fault_fallback_charge_attr.attr,
> >       &anon_swpout_attr.attr,
> >       &anon_swpout_fallback_attr.attr,
> > +     &split_page_attr.attr,
> > +     &split_page_failed_attr.attr,
> > +     &deferred_split_page_attr.attr,
> >       NULL,
> >  };
> >
> > @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_o=
rder);
> >       struct anon_vma *anon_vma =3D NULL;
> >       struct address_space *mapping =3D NULL;
> > -     bool is_thp =3D folio_test_pmd_mappable(folio);
> > +     int order =3D folio_order(folio);
> >       int extra_pins, ret;
> >       pgoff_t end;
> >       bool is_hzp;
> > @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >               i_mmap_unlock_read(mapping);
> >  out:
> >       xas_destroy(&xas);
> > -     if (is_thp)
> > +     if (order >=3D HPAGE_PMD_ORDER)
> >               count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAI=
LED);
> > +     count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> > +                                   MTHP_STAT_SPLIT_PAGE_FAILED);
> >       return ret;
> >  }
> >
> > @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
> >       if (list_empty(&folio->_deferred_list)) {
> >               if (folio_test_pmd_mappable(folio))
> >                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> > +             count_mthp_stat(folio_order(folio),
> > +                             MTHP_STAT_DEFERRED_SPLIT_PAGE);
>
> There is a very long conversation with Barry about adding a 'global "mTHP=
 became
> partially mapped 1 or more processes" counter (inc only)', which terminat=
es at
> [1]. There is a lot of discussion about the required semantics around the=
 need
> for partial map to cover alignment and contiguity as well as whether all =
pages
> are mapped, and to trigger once it becomes partial in at least 1 process.
>
> MTHP_STAT_DEFERRED_SPLIT_PAGE is giving much simpler semantics, but less
> information as a result. Barry, what's your view here? I'm guessing this =
doesn't
> quite solve what you are looking for?

This doesn't quite solve what I am looking for but I still think the
patch has its value.

I'm looking for a solution that can:

  *  Count the amount of memory in the system for each mTHP size.
  *  Determine how much memory for each mTHP size is partially unmapped.

For example, in a system with 16GB of memory, we might find that we have 3G=
B
of 64KB mTHP, and within that, 512MB is partially unmapped, potentially was=
ting
memory at this moment.  I'm uncertain whether Lance is interested in
this job :-)

Counting deferred_split remains valuable as it can signal whether the syste=
m is
experiencing significant partial unmapping.

>
> [1] https://lore.kernel.org/linux-mm/6cc7d781-884f-4d8f-a175-8609732b87eb=
@arm.com/
>
> Thanks,
> Ryan
>
> >               list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
> >               ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
>

Thanks
Barry


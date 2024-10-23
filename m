Return-Path: <linux-kernel+bounces-378539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCC9AD20A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090EB1C25AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299FB1CFEA6;
	Wed, 23 Oct 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGyhsVb1"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E81CEEAB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702643; cv=none; b=cWnNDwGxyqYmd2OHAljg8y1kMDbSTt9yd8+vim4rY8/2OJTjB4LORPkbB17eM2w33bhrh7ZkB3mzYkOZFQQaH4tTKu5w11sB/Tc1bEYtTgsrVBwUhj+CtkJlWHmMFvitV9hexKk4PRBpEP2+QBDgMtcOkBe6ZHP+vtD1VfYd4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702643; c=relaxed/simple;
	bh=PN3PI30mlWJZbmmYTwqKM1tqjl4S+h/wwTjNa0FVzeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wfl2CDNXxwnWXky2tnNfzUyA3rNIv+7nSy67Ggm3yMeJz69GWzjNro1bcz6NT8iF7BVlEvR7fKZntFx/EM5di5yY1KaF3SW3f9vQLtE+0ktw3pOMrOx6V9rsFDWDw6WNS3Fc5hHbgKSaAFnHOP227F6rWfOZxpCeYsTa177zI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGyhsVb1; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47ec4ef2cso1822800137.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729702640; x=1730307440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/rVx4xhU3buqF3s0gjUuJjCcbEqwnGQ1z7b5w2uvVo=;
        b=MGyhsVb1wb8I8SyZmZzjI+eKd3eL0J04qtSAN4rGcQZtkxkum92IDThx8i7JneXusQ
         wyTrlsJOUeux2bZSZ0lsbYyI0FjxVBH3oa77KIhki4xSEGhflWXD3ihWqrQh/HF0BYZ5
         BSQtybQbAuUvF2yFmLJxksuk98pczC2QfqfoRJYeagr4ORWmaMiZ6wGvwQSgbKMOdJVg
         40VFN4J1x/8OTcSiP1ZrDVyc2B+t5HaMZJpQ3GjtGBtw04oxfwnfB45D5qq2QlxvWhc8
         5JMwPgcyjCCA6npZ4nzLdxLk9fKNRQihQr9ZUTanYe5lViRfSjYjUb9Zw1JobaqkSZXU
         EG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702640; x=1730307440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/rVx4xhU3buqF3s0gjUuJjCcbEqwnGQ1z7b5w2uvVo=;
        b=sa794TIhf8ukbkOHwFctZPzmaLuqMQKbpfK0P+L5Yorz0pi6LaxjmekQ/gSI7iWDap
         E4FrCS1beq/QNZbv5Rv7QjXxZnGV7h2pLkkRxlXnSTbvT3V1Xbls+ml7Zafc/C9T+B3q
         pNXCYU6Sp2KxUa4s3px19//gRuwEv0qCyVE+mT4wf4wWbxu3X7pC2QRq5BW7t6qGGrNp
         3RgXCyI0Sp55eJ895QKdZl1LnoPqbiX4pfO8tq6uT+4VJmX4czLvj9U2tuQ44i7HxpQ8
         oNS9zRcePoo2SpWl/TOqE+Z5zGIviagUafwy2bQpUF6Fda07XGFppInzDwu/tYj8pIDk
         F1/w==
X-Forwarded-Encrypted: i=1; AJvYcCUJip3Wwypn8zfely9K6ysi20wn1G3hF++coWRkXdhCg7YhIW9OlVrSKt03qfU7uxhCijuhLKbFVG0gD9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYp4E4qEtlKqAYTZAlE8sMBpcRlLY2rODjYzW4S7n+BI2GIwAA
	jGSc+liaglQ9CFVQaL98WRqM/8bLO63qE39jm0si3sGb8u11Kez85T+rQ9zr3DqG0ghqtpi8kAQ
	z8VsrhqhwN9SLKzNZ53TK8P2I945csz1M5wIZ
X-Google-Smtp-Source: AGHT+IGSJeWtcRaA8iYuESb6rplWy4Of3qzkk0PG4kshEpuHBGh03Nt3K4ZeA5mV5+18EYLdAnexB7Ty55xQ1ZXT/Bc=
X-Received: by 2002:a05:6102:3709:b0:492:a93d:7cab with SMTP id
 ada2fe7eead31-4a751a7ee61mr3970593137.1.1729702640436; Wed, 23 Oct 2024
 09:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-3-usamaarif642@gmail.com> <4B7449C4-D2B8-4285-973C-97178C09CE7E@nvidia.com>
 <27d04537-ebda-4462-b008-878390d4b211@gmail.com>
In-Reply-To: <27d04537-ebda-4462-b008-878390d4b211@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 23 Oct 2024 10:56:43 -0600
Message-ID: <CAOUHufZeWWs8f4-BokLBgy_oSbT-pfjFpJFNZ+tW0qW9RifX0A@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
To: Usama Arif <usamaarif642@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, david@redhat.com, npache@redhat.com, 
	baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org, 
	cerasuolodomenico@gmail.com, ryncsn@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com, 
	Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:51=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
> On 23/10/2024 17:21, Zi Yan wrote:
> > On 30 Aug 2024, at 6:03, Usama Arif wrote:
> >
> >> From: Yu Zhao <yuzhao@google.com>
> >>
> >> Here being unused means containing only zeros and inaccessible to
> >> userspace. When splitting an isolated thp under reclaim or migration,
> >> the unused subpages can be mapped to the shared zeropage, hence saving
> >> memory. This is particularly helpful when the internal
> >> fragmentation of a thp is high, i.e. it has many untouched subpages.
> >>
> >> This is also a prerequisite for THP low utilization shrinker which wil=
l
> >> be introduced in later patches, where underutilized THPs are split, an=
d
> >> the zero-filled pages are freed saving memory.
> >>
> >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> >> Tested-by: Shuang Zhai <zhais@google.com>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  include/linux/rmap.h |  7 ++++-
> >>  mm/huge_memory.c     |  8 ++---
> >>  mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++-----=
-
> >>  mm/migrate_device.c  |  4 +--
> >>  4 files changed, 75 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> >> index 91b5935e8485..d5e93e44322e 100644
> >> --- a/include/linux/rmap.h
> >> +++ b/include/linux/rmap.h
> >> @@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
> >>  int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgof=
f_t pgoff,
> >>                    struct vm_area_struct *vma);
> >>
> >> -void remove_migration_ptes(struct folio *src, struct folio *dst, bool=
 locked);
> >> +enum rmp_flags {
> >> +    RMP_LOCKED              =3D 1 << 0,
> >> +    RMP_USE_SHARED_ZEROPAGE =3D 1 << 1,
> >> +};
> >> +
> >> +void remove_migration_ptes(struct folio *src, struct folio *dst, int =
flags);
> >>
> >>  /*
> >>   * rmap_walk_control: To control rmap traversing for specific needs
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 0c48806ccb9a..af60684e7c70 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struct=
 *vma, unsigned long addr,
> >>      return false;
> >>  }
> >>
> >> -static void remap_page(struct folio *folio, unsigned long nr)
> >> +static void remap_page(struct folio *folio, unsigned long nr, int fla=
gs)
> >>  {
> >>      int i =3D 0;
> >>
> >> @@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio, unsi=
gned long nr)
> >>      if (!folio_test_anon(folio))
> >>              return;
> >>      for (;;) {
> >> -            remove_migration_ptes(folio, folio, true);
> >> +            remove_migration_ptes(folio, folio, RMP_LOCKED | flags);
> >>              i +=3D folio_nr_pages(folio);
> >>              if (i >=3D nr)
> >>                      break;
> >> @@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
> >>
> >>      if (nr_dropped)
> >>              shmem_uncharge(folio->mapping->host, nr_dropped);
> >> -    remap_page(folio, nr);
> >> +    remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : =
0);
> >>
> >>      /*
> >>       * set page to its compound_head when split to non order-0 pages,=
 so
> >> @@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>              if (mapping)
> >>                      xas_unlock(&xas);
> >>              local_irq_enable();
> >> -            remap_page(folio, folio_nr_pages(folio));
> >> +            remap_page(folio, folio_nr_pages(folio), 0);
> >>              ret =3D -EAGAIN;
> >>      }
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 6f9c62c746be..d039863e014b 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio, =
struct list_head *list)
> >>      return true;
> >>  }
> >>
> >> +static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk=
 *pvmw,
> >> +                                      struct folio *folio,
> >> +                                      unsigned long idx)
> >> +{
> >> +    struct page *page =3D folio_page(folio, idx);
> >> +    bool contains_data;
> >> +    pte_t newpte;
> >> +    void *addr;
> >> +
> >> +    VM_BUG_ON_PAGE(PageCompound(page), page);
> >
> > This should be:
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index e950fd62607f..7ffdbe078aa7 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -206,7 +206,8 @@ static bool try_to_map_unused_to_zeropage(struct pa=
ge_vma_mapped_walk *pvmw,
> >         pte_t newpte;
> >         void *addr;
> >
> > -       VM_BUG_ON_PAGE(PageCompound(page), page);
> > +       if (PageCompound(page))
> > +               return false;
> >         VM_BUG_ON_PAGE(!PageAnon(page), page);
> >         VM_BUG_ON_PAGE(!PageLocked(page), page);
> >         VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> >
> > Otherwise, splitting anonymous large folios to non order-0 ones just
> > triggers this BUG_ON.
> >
>
> That makes sense, would you like to send the fix?
>
> Adding Yu Zhao to "To" incase he has any objections.

LGTM. Thanks!


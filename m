Return-Path: <linux-kernel+bounces-288604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94962953C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B687285BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493E14901F;
	Thu, 15 Aug 2024 21:06:39 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEE41C85;
	Thu, 15 Aug 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755999; cv=none; b=hiFzRnv7Qg0K8Xx14V7UV1r0qIfxNNf6Xb7pVSQQd9Xed/PZstNV1jsRB0/yJywVyX90g5HmO0zgc7IKYx/oH8MMksPXBhXcHysCHzXFYxS9ibO+QE0xH/4rkKfXg0WyGoMtRMtq0e2g+tQqeUuQLY5n5BkoT7XTVgZ0zj/I0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755999; c=relaxed/simple;
	bh=EzOAYe4LK27j5lWRZxhIkw6AuTK21D1lVkjyX6zaMPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4iOdFCBPb6OZQzBs1SjaEiIa8cOGiuM/QO1apupbGcLYf6Ii/nHspIs/v+2LpC+h2CCRGbWcf1WQqSaudyP/4yJ8r36ulw9+JfgIjhbQ6zqHjZyrJsUOYVPcYxeq8H6+9hFj//+VMSuwGfyq6xIwWp5B0ZGJy7Y69peJ/1UkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5c7f24372so871580eaf.0;
        Thu, 15 Aug 2024 14:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755997; x=1724360797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBVHLny5yK9Q2nKOUSqphhaawlBVWCd0AIRG3t50TKw=;
        b=iQx8zwpDYukpb5gDuaOY0U3nKWnDtwqByrZaExRLl/nIU0zCiaWwMsE1WqrS8D6bji
         +kTzY2rkTnGH+nxDuJAuPehGGaQ8O3GgGrpN7Jh4oV4eJJ30/F/l2E9WvXcrF62igiTU
         AcxnY5z9tFrV3eSpO0q9JVF686YvQrEyQ2GH0y0ZIxWz5oVIgiXu7+hqPxTbk67v8ihk
         9/dCZrOyUwqk7qMxfEepz9AYAFPd5OMueJjFhWbDbZ2TVJd1Z5a7zAwktlRUJ3F999SQ
         zVFRv61a3+P42F0Te52F4Ly246GuspUIZc0iJDZ5jXQP8BTU82kjaEUKheqrCfGp2K34
         A7tw==
X-Forwarded-Encrypted: i=1; AJvYcCWbZTtfE/6mR6sl1FmSo6EeTp2Y7Isc6pEE7k1Selp7tKaIw2TMIDLIlijX1fz84z/o7AQs+lzuSXXERZ+fz0vYh0A2qlHszjhF4/JC6NZGXnaEJP2G68ac5lAfN5NM0Hy3xBFq3GhN
X-Gm-Message-State: AOJu0Yx7LCJ4CQS6jGMwA4oN2vIX2hcbaaQgTPjKacjZBkcNBVXDPt+2
	+uUzAcqxKJyshMXOaYGBgTG+v77s8Tz5yvG/q5Ju3vAhn4GarGVDT6Ge+v3srfy0ZstwwBExlUQ
	Amgq09bhrW61y/nlwM2uLMsb9vGs=
X-Google-Smtp-Source: AGHT+IFFWlPCy7bquLwJlr+dwtVXggyxh5k2BGEL/yS7SoLWSNhHUDwl6p6DKB/qYAbJxARNC2n/1UXH14Z8b0MFwHA=
X-Received: by 2002:a05:6218:260d:b0:1ad:471:9b7 with SMTP id
 e5c5f4694b2df-1b3931bfd1amr147959255d.18.1723755996967; Thu, 15 Aug 2024
 14:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com> <ee0bae67-17b8-4807-a9b2-9a08df00987a@redhat.com>
 <d7433859-6217-483c-9d48-bb6de97b09f7@gmail.com>
In-Reply-To: <d7433859-6217-483c-9d48-bb6de97b09f7@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 16 Aug 2024 09:06:25 +1200
Message-ID: <CAGsJ_4w13QMqXe8CL280CoHAeVSqHuoSgL0ubNVbGyABuhtGcQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, yuzhao@google.com, ryan.roberts@arm.com, 
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:10=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 15/08/2024 17:33, David Hildenbrand wrote:
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 6df0e9f4f56c..c024ab0f745c 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>                * page_deferred_list.
> >>                */
> >>               list_del_init(&folio->_deferred_list);
> >> +            folio_clear_partially_mapped(folio);
> >>           }
> >>           spin_unlock(&ds_queue->split_queue_lock);
> >>           if (mapping) {
> >> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio=
 *folio)
> >>       if (!list_empty(&folio->_deferred_list)) {
> >>           ds_queue->split_queue_len--;
> >>           list_del_init(&folio->_deferred_list);
> >> +        folio_clear_partially_mapped(folio);
> >>       }
> >>       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >>   }
> >>   -void deferred_split_folio(struct folio *folio)
> >> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >>   {
> >     /* We lost race with folio_put() */>            list_del_init(&foli=
o->_deferred_list);
>
> Was there some comment here? I just see ">" remove from the start of /* W=
e lost race with folio_put() */
>
> >> +            folio_clear_partially_mapped(folio);
> >>               ds_queue->split_queue_len--;
> >>           }
> >>           if (!--sc->nr_to_scan)
> >> @@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
> >>   next:
> >>           folio_put(folio);
> >>       }
> >> -
> >>       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >>       list_splice_tail(&list, &ds_queue->split_queue);
> >>       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 1fdd9eab240c..2ae2d9a18e40 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(stru=
ct hstate *h,
> >>           free_gigantic_folio(folio, huge_page_order(h));
> >>       } else {
> >>           INIT_LIST_HEAD(&folio->_deferred_list);
> >> +        folio_clear_partially_mapped(folio);
> >>           folio_put(folio);
> >>       }
> >>   }
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index 52f7fc4e8ac3..d64546b8d377 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page=
 *page, unsigned int order)
> >>       atomic_set(&folio->_entire_mapcount, -1);
> >>       atomic_set(&folio->_nr_pages_mapped, 0);
> >>       atomic_set(&folio->_pincount, 0);
> >> -    if (order > 1)
> >> +    if (order > 1) {
> >>           INIT_LIST_HEAD(&folio->_deferred_list);
> >> +        folio_clear_partially_mapped(folio);
> >
> > Can we use the non-atomic version here?
> >
>
> I believe we can use the non-atomic version in all places where set/clear=
 is done as all set/clear are protected by ds_queue->split_queue_lock. So b=
asically could replace all folio_set/clear_partially_mapped with __folio_se=
t/clear_partially_mapped.
>

right. That is why I thought the below is actually safe.
but i appreciate a test_set of course(and non-atomic):

+               if (!folio_test_partially_mapped(folio)) {
+                       folio_set_partially_mapped(folio);
+                       if (folio_test_pmd_mappable(folio))
+                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+                       count_mthp_stat(folio_order(folio),
MTHP_STAT_SPLIT_DEFERRED);
+               }


> But I guess its likely not going to make much difference? I will do it an=
yways in the next revision, rather than sending a fix patch. There haven't =
been any reviews for patch 5 so will wait a few days for any comments on th=
at.
>
> Thanks

Thanks
Barry


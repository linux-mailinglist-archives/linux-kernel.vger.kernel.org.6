Return-Path: <linux-kernel+bounces-292931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77B95769B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22F7284115
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7615A4B0;
	Mon, 19 Aug 2024 21:35:13 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57E3BBF6;
	Mon, 19 Aug 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103312; cv=none; b=rRg+3VQ0YYZcA56CYxziw6nAS8K69M6P0AKOIi638/i83ReGDGXhGaWmIw2eVCcF7qChB63yT0cBRJDVWuKjFdHwflh3YNIBuFWrHkRqq0DDNYMO7VCeK+xv+HVmX7PeTGtCjiGTm3B6ujAfuIDDsVFS5wO1s82Fyc7zbeJlmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103312; c=relaxed/simple;
	bh=yMxTog0+cCYyEdwVDFc6VEDfNhZOgBN24vNoL96R9UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXRT7SJZQTw+OctneefO3j0cGWkeOUMnFGqkQtDBNeJ9ctz/1WAvGYGC83jVTldKIpm3/imY5N7PUVIWBl6kfW0BsKimz/Mekr7ORw4OP4q4iFTmkox+jC9X/RGcTOAXIMrgeSpdyhWmzkJM2XuzLxAb8SxPXyonkUqq93GuN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0bf677e0feso4957654276.1;
        Mon, 19 Aug 2024 14:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103309; x=1724708109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2Fa97VOpmKXu2KcqUq3KAv9vO209RmoS1OhIQtYunY=;
        b=slqYe/DvDGo+BRvJRq1vmvUydgth412SPDg9+PjJLp31Fdh8/PXn1/J8mxv1L6if51
         zsK9xjRPSh7lDPvKxoxB/RF+dO/F24ZG42HkKauWpS1qm/VKtsWzjiut5Oikw7tDZmIM
         +p4NNJo/JT33sZXBl3nm4VpUSlrIBeF3SGDqbX7RfuwHsMFX10/MUWIjmRfySO9ZuQ4d
         LhTWjYvzcFgDSdBFKUSkxdPf3v0K+zkMMnC9QuFbX+lX/KnG8IolfCSOCM6LDEiInqef
         45SFCYiBYzKkFhJPNf9mag8qCh7u7jetjMO5jL+iZbkS+A+5L8DTmbqH53xBLC0z/uUW
         ovnA==
X-Forwarded-Encrypted: i=1; AJvYcCUaUPLmcELLUt9nERnCH1QSRai848VhIyHo7h8yfmVDyYB2aQ7mm9mroF1B+x8Sj3Gs9vnD1oaG42VNVDwtVndza+GY39WIkxkKBCkPjOw3kF10LennhYDSpmq2vAZ7rqLu2yTbed0a
X-Gm-Message-State: AOJu0YzS1iMJ+tRJ4iSouILCjYUEht6u//li+ItKmge2LNAvyjOTxQJb
	f00UPa9ORzp9fNHEQEnIf0DxWYa+tFHcCNcCL9QTnpB40H59IRR2wfG6a2n/p+FfCkw8582nQkz
	Oixz/F0nJKmW2VrVzUDa88yP59u4=
X-Google-Smtp-Source: AGHT+IFucDWUvZCR2f1GfJJq3VCGE/0nUAGOVSRdrDd7MzMnspllL+9vskjBcsXpDj9ABN1M3/nOBY9RTn8iHF+Wbz0=
X-Received: by 2002:a05:6902:2612:b0:e11:7f99:f75b with SMTP id
 3f1490d57ef6-e16513bf2e8mr449851276.42.1724103309362; Mon, 19 Aug 2024
 14:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com> <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com> <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
 <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com>
In-Reply-To: <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Aug 2024 09:34:53 +1200
Message-ID: <CAGsJ_4xiG+oGkjt3nf0Zh2rdztz8h_AaahZWs4N3UARhw7DcgQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:16=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 19/08/2024 20:00, Barry Song wrote:
> > On Tue, Aug 20, 2024 at 2:17=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 19/08/2024 09:29, Barry Song wrote:
> >>> Hi Usama,
> >>>
> >>> I feel it is much better now! thanks!
> >>>
> >>> On Mon, Aug 19, 2024 at 2:31=E2=80=AFPM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> >>>>
> >>>> Currently folio->_deferred_list is used to keep track of
> >>>> partially_mapped folios that are going to be split under memory
> >>>> pressure. In the next patch, all THPs that are faulted in and collap=
sed
> >>>> by khugepaged are also going to be tracked using _deferred_list.
> >>>>
> >>>> This patch introduces a pageflag to be able to distinguish between
> >>>> partially mapped folios and others in the deferred_list at split tim=
e in
> >>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> >>>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> >>>> possible to distinguish between partially mapped folios and others i=
n
> >>>> deferred_split_scan.
> >>>>
> >>>> Eventhough it introduces an extra flag to track if the folio is
> >>>> partially mapped, there is no functional change intended with this
> >>>> patch and the flag is not useful in this patch itself, it will
> >>>> become useful in the next patch when _deferred_list has non partiall=
y
> >>>> mapped folios.
> >>>>
> >>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>> ---
> >>>>  include/linux/huge_mm.h    |  4 ++--
> >>>>  include/linux/page-flags.h | 11 +++++++++++
> >>>>  mm/huge_memory.c           | 23 ++++++++++++++++-------
> >>>>  mm/internal.h              |  4 +++-
> >>>>  mm/memcontrol.c            |  3 ++-
> >>>>  mm/migrate.c               |  3 ++-
> >>>>  mm/page_alloc.c            |  5 +++--
> >>>>  mm/rmap.c                  |  5 +++--
> >>>>  mm/vmscan.c                |  3 ++-
> >>>>  9 files changed, 44 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index 4c32058cacfe..969f11f360d2 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *p=
age)
> >>>>  {
> >>>>         return split_huge_page_to_list_to_order(page, NULL, 0);
> >>>>  }
> >>>> -void deferred_split_folio(struct folio *folio);
> >>>> +void deferred_split_folio(struct folio *folio, bool partially_mappe=
d);
> >>>>
> >>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >>>>                 unsigned long address, bool freeze, struct folio *fo=
lio);
> >>>> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *p=
age)
> >>>>  {
> >>>>         return 0;
> >>>>  }
> >>>> -static inline void deferred_split_folio(struct folio *folio) {}
> >>>> +static inline void deferred_split_folio(struct folio *folio, bool p=
artially_mapped) {}
> >>>>  #define split_huge_pmd(__vma, __pmd, __address)        \
> >>>>         do { } while (0)
> >>>>
> >>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >>>> index a0a29bd092f8..c3bb0e0da581 100644
> >>>> --- a/include/linux/page-flags.h
> >>>> +++ b/include/linux/page-flags.h
> >>>> @@ -182,6 +182,7 @@ enum pageflags {
> >>>>         /* At least one page in this folio has the hwpoison flag set=
 */
> >>>>         PG_has_hwpoisoned =3D PG_active,
> >>>>         PG_large_rmappable =3D PG_workingset, /* anon or file-backed=
 */
> >>>> +       PG_partially_mapped =3D PG_reclaim, /* was identified to be =
partially mapped */
> >>>>  };
> >>>>
> >>>>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> >>>> @@ -861,8 +862,18 @@ static inline void ClearPageCompound(struct pag=
e *page)
> >>>>         ClearPageHead(page);
> >>>>  }
> >>>>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> >>>> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>>> +/*
> >>>> + * PG_partially_mapped is protected by deferred_split split_queue_l=
ock,
> >>>> + * so its safe to use non-atomic set/clear.
> >>>> + */
> >>>> +__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>>> +__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>>>  #else
> >>>>  FOLIO_FLAG_FALSE(large_rmappable)
> >>>> +FOLIO_TEST_FLAG_FALSE(partially_mapped)
> >>>> +__FOLIO_SET_FLAG_NOOP(partially_mapped)
> >>>> +__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
> >>>>  #endif
> >>>>
> >>>>  #define PG_head_mask ((1UL << PG_head))
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 2d77b5d2291e..70ee49dfeaad 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -3398,6 +3398,7 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
> >>>>                          * page_deferred_list.
> >>>>                          */
> >>>>                         list_del_init(&folio->_deferred_list);
> >>>> +                       __folio_clear_partially_mapped(folio);
> >>>>                 }
> >>>>                 spin_unlock(&ds_queue->split_queue_lock);
> >>>>                 if (mapping) {
> >>>> @@ -3454,11 +3455,13 @@ void __folio_undo_large_rmappable(struct fol=
io *folio)
> >>>>         if (!list_empty(&folio->_deferred_list)) {
> >>>>                 ds_queue->split_queue_len--;
> >>>>                 list_del_init(&folio->_deferred_list);
> >>>> +               __folio_clear_partially_mapped(folio);
> >>>
> >>> is it possible to make things clearer by
> >>>
> >>>  if (folio_clear_partially_mapped)
> >>>     __folio_clear_partially_mapped(folio);
> >>>
> >>> While writing without conditions isn't necessarily wrong, adding a co=
ndition
> >>> will improve the readability of the code and enhance the clarity of m=
y mTHP
> >>> counters series. also help decrease smp cache sync if we can avoid
> >>> unnecessary writing?
> >>>
> >>
> >> Do you mean if(folio_test_partially_mapped(folio))?
> >>
> >> I don't like this idea. I think it makes the readability worse? If I w=
as looking at if (test) -> clear for the first time, I would become confuse=
d why its being tested if its going to be clear at the end anyways?
> >
> > In the pmd-order case, the majority of folios are not partially mapped.
> > Unconditional writes will trigger cache synchronization across all
> > CPUs (related to the MESI protocol), making them more costly. By
> > using conditional writes, such as "if(test) write," we can avoid
> > most unnecessary writes, which is much more efficient. Additionally,
> > we only need to manage nr_split_deferred when the condition
> > is met. We are carefully evaluating all scenarios to determine
> > if modifications to the partially_mapped flag are necessary.
> >
>
>
> Hmm okay, as you said its needed for nr_split_deferred anyways. Something=
 like below is ok to fold in?
>
> commit 4ae9e2067346effd902b342296987b97dee29018 (HEAD)
> Author: Usama Arif <usamaarif642@gmail.com>
> Date:   Mon Aug 19 21:07:16 2024 +0100
>
>     mm: Introduce a pageflag for partially mapped folios fix
>
>     Test partially_mapped flag before clearing it. This should
>     avoid unnecessary writes and will be needed in the nr_split_deferred
>     series.
>
>     Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5d67d3b3c1b2..ccde60aaaa0f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3479,7 +3479,8 @@ void __folio_undo_large_rmappable(struct folio *fol=
io)
>         if (!list_empty(&folio->_deferred_list)) {
>                 ds_queue->split_queue_len--;
>                 list_del_init(&folio->_deferred_list);
> -               __folio_clear_partially_mapped(folio);
> +               if (folio_test_partially_mapped(folio))
> +                       __folio_clear_partially_mapped(folio);
>         }
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  }
> @@ -3610,7 +3611,8 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
>                 } else {
>                         /* We lost race with folio_put() */
>                         list_del_init(&folio->_deferred_list);
> -                       __folio_clear_partially_mapped(folio);
> +                       if (folio_test_partially_mapped(folio))
> +                               __folio_clear_partially_mapped(folio);
>                         ds_queue->split_queue_len--;
>                 }
>                 if (!--sc->nr_to_scan)
>

Do we also need if (folio_test_partially_mapped(folio)) in
split_huge_page_to_list_to_order()?

I recall that in Yu Zhao's TAO, there=E2=80=99s a chance of splitting (shat=
tering)
non-partially-mapped folios. To be future-proof, we might want to handle
both cases equally.

By the way, we might not need to clear the flag for a new folio. This diffe=
rs
from the init_list, which is necessary. If a new folio has the partially_ma=
pped
flag, it indicates that we failed to clear it when freeing the folio to
the buddy system, which is a bug we need to fix in the free path.

Thanks
Barry


Return-Path: <linux-kernel+bounces-294586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF3958FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642BB1C21CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44F1C463F;
	Tue, 20 Aug 2024 21:30:37 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA128FA;
	Tue, 20 Aug 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189436; cv=none; b=MjYuZtNEVYfGjw75jCG6g6aoLqSBlJAFqfB5B6VF6XVn3iqXiqIDzbCHhxOa5qpvGbevmuT2xOUcBsErd7lijU2InimXOKAsf9n4YuGv/rVt2GzN/E8aZbGKphMnjSbSCBG5tDadbxXrBGBtyFCxJydoGJFb0ZheFjaWhkoEsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189436; c=relaxed/simple;
	bh=Wf4v/OxN9egKtXMuH2WLio6W1C7MsLtd52NbyIDOAec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQAiUBhSw9WUeGKk6MKMl4kjiKACWxNVa1udI4xPCnYv9CCHdxsHoqWXrSqNRF6/fcfUGkAw3Eg1/uULa2ibNmnnn8WqNFwca82wXhnr1FCcTAIuKuUYEkgIRBQ2cqbTGhLDqPK9yysE4gnq1ZW0eBqRjVOtkFOZsTa+2TRdh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4fc9cc29d33so1097808e0c.3;
        Tue, 20 Aug 2024 14:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189433; x=1724794233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5MbvUEZo2RanWzcPSim4NJ31aZ7A+5iQj3+e1UdIIE=;
        b=Co6lMmY+/U21ABfE5953/ALbKFAUZAmlmQyV/f6taSga/GWMNfvRyF7H91Ap2hTmTp
         MLH84RBc9OrfVpA+9cMRJGkaCwjmZ/RJVE3HOTgNEvVDZMIgJxpJCzbHpwk0iA9dznsy
         kisQC70YP6sRo56vmClZniuFFvzxAHSb1qiTPX8hoYtUPttkKeVzx2ucsniCJQ8uXudC
         h8H08VjdfSFyGNiMUMrHcNxV1VLye1BpyAOR2pOaiw9+frU2rZQhdA7D92R7sHOUCInH
         dxv84xODWhtFnkWufRON3dl/XM89lSwGnmovO/uDUdZcwmHuYNBQY5QeyqCvhDC2gHHI
         scmg==
X-Forwarded-Encrypted: i=1; AJvYcCVZTS0ddsY16oesqF72WzJ7RRQbhfvAPGgu3sQrfCL9Xb8zkAQDZvWOvozH3yLqalm4AtPADCdsyM8=@vger.kernel.org, AJvYcCXlUFsFzEc/V+P7LBfbDntTsNC+lR01pPpdAkemG4XhzjX9hxfkuT8RWvPRY6xpdEvG4eYRjg+eIFrS7TvZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoR5qyk8gAsew0TCWW8IsJY8lG8xXAGFtIVjdWHgAjqX+t2MR
	i6GMq2cHOMLLiHVpdG+LhjggcjsFutTPOAScn8EnxO6WwnpHNsCjZJ8VNt8jICRHYOH64FRXZe7
	RnV0vjLf0Rx09HE2e/DVvLDuAXi4=
X-Google-Smtp-Source: AGHT+IGS1cSsfYG4SOT7yH5qcDXTg2Z5iUpMCjN0fGTIGWP4vGyQH5TLoU/ZJtMssIUYrTB3BJn2WNp4oI9Z1jNmoMI=
X-Received: by 2002:a05:6122:4698:b0:4fc:e713:6572 with SMTP id
 71dfb90a1353d-4fcf1b98922mr912204e0c.11.1724189433182; Tue, 20 Aug 2024
 14:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com> <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com> <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
 <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com> <CAGsJ_4xiG+oGkjt3nf0Zh2rdztz8h_AaahZWs4N3UARhw7DcgQ@mail.gmail.com>
 <CAGsJ_4z2YL01wvVgsFsbzGAQ5KowXgxLcj=Y7DSX7ODOF5MUvw@mail.gmail.com> <953d398d-58be-41c6-bf30-4c9df597de77@gmail.com>
In-Reply-To: <953d398d-58be-41c6-bf30-4c9df597de77@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 21 Aug 2024 09:30:21 +1200
Message-ID: <CAGsJ_4y49c8-hDgjNuqMZnNWfUT-ktxeqkfX0EQz4-Pu3x9-Dg@mail.gmail.com>
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

On Wed, Aug 21, 2024 at 7:35=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 19/08/2024 22:55, Barry Song wrote:
> > On Tue, Aug 20, 2024 at 9:34=E2=80=AFAM Barry Song <baohua@kernel.org> =
wrote:
> >>
> >> On Tue, Aug 20, 2024 at 8:16=E2=80=AFAM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>>
> >>>
> >>>
> >>> On 19/08/2024 20:00, Barry Song wrote:
> >>>> On Tue, Aug 20, 2024 at 2:17=E2=80=AFAM Usama Arif <usamaarif642@gma=
il.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 19/08/2024 09:29, Barry Song wrote:
> >>>>>> Hi Usama,
> >>>>>>
> >>>>>> I feel it is much better now! thanks!
> >>>>>>
> >>>>>> On Mon, Aug 19, 2024 at 2:31=E2=80=AFPM Usama Arif <usamaarif642@g=
mail.com> wrote:
> >>>>>>>
> >>>>>>> Currently folio->_deferred_list is used to keep track of
> >>>>>>> partially_mapped folios that are going to be split under memory
> >>>>>>> pressure. In the next patch, all THPs that are faulted in and col=
lapsed
> >>>>>>> by khugepaged are also going to be tracked using _deferred_list.
> >>>>>>>
> >>>>>>> This patch introduces a pageflag to be able to distinguish betwee=
n
> >>>>>>> partially mapped folios and others in the deferred_list at split =
time in
> >>>>>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> >>>>>>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't b=
e
> >>>>>>> possible to distinguish between partially mapped folios and other=
s in
> >>>>>>> deferred_split_scan.
> >>>>>>>
> >>>>>>> Eventhough it introduces an extra flag to track if the folio is
> >>>>>>> partially mapped, there is no functional change intended with thi=
s
> >>>>>>> patch and the flag is not useful in this patch itself, it will
> >>>>>>> become useful in the next patch when _deferred_list has non parti=
ally
> >>>>>>> mapped folios.
> >>>>>>>
> >>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>>>>> ---
> >>>>>>>  include/linux/huge_mm.h    |  4 ++--
> >>>>>>>  include/linux/page-flags.h | 11 +++++++++++
> >>>>>>>  mm/huge_memory.c           | 23 ++++++++++++++++-------
> >>>>>>>  mm/internal.h              |  4 +++-
> >>>>>>>  mm/memcontrol.c            |  3 ++-
> >>>>>>>  mm/migrate.c               |  3 ++-
> >>>>>>>  mm/page_alloc.c            |  5 +++--
> >>>>>>>  mm/rmap.c                  |  5 +++--
> >>>>>>>  mm/vmscan.c                |  3 ++-
> >>>>>>>  9 files changed, 44 insertions(+), 17 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>>>>> index 4c32058cacfe..969f11f360d2 100644
> >>>>>>> --- a/include/linux/huge_mm.h
> >>>>>>> +++ b/include/linux/huge_mm.h
> >>>>>>> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page=
 *page)
> >>>>>>>  {
> >>>>>>>         return split_huge_page_to_list_to_order(page, NULL, 0);
> >>>>>>>  }
> >>>>>>> -void deferred_split_folio(struct folio *folio);
> >>>>>>> +void deferred_split_folio(struct folio *folio, bool partially_ma=
pped);
> >>>>>>>
> >>>>>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >>>>>>>                 unsigned long address, bool freeze, struct folio =
*folio);
> >>>>>>> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page=
 *page)
> >>>>>>>  {
> >>>>>>>         return 0;
> >>>>>>>  }
> >>>>>>> -static inline void deferred_split_folio(struct folio *folio) {}
> >>>>>>> +static inline void deferred_split_folio(struct folio *folio, boo=
l partially_mapped) {}
> >>>>>>>  #define split_huge_pmd(__vma, __pmd, __address)        \
> >>>>>>>         do { } while (0)
> >>>>>>>
> >>>>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flag=
s.h
> >>>>>>> index a0a29bd092f8..c3bb0e0da581 100644
> >>>>>>> --- a/include/linux/page-flags.h
> >>>>>>> +++ b/include/linux/page-flags.h
> >>>>>>> @@ -182,6 +182,7 @@ enum pageflags {
> >>>>>>>         /* At least one page in this folio has the hwpoison flag =
set */
> >>>>>>>         PG_has_hwpoisoned =3D PG_active,
> >>>>>>>         PG_large_rmappable =3D PG_workingset, /* anon or file-bac=
ked */
> >>>>>>> +       PG_partially_mapped =3D PG_reclaim, /* was identified to =
be partially mapped */
> >>>>>>>  };
> >>>>>>>
> >>>>>>>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> >>>>>>> @@ -861,8 +862,18 @@ static inline void ClearPageCompound(struct =
page *page)
> >>>>>>>         ClearPageHead(page);
> >>>>>>>  }
> >>>>>>>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> >>>>>>> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>>>>>> +/*
> >>>>>>> + * PG_partially_mapped is protected by deferred_split split_queu=
e_lock,
> >>>>>>> + * so its safe to use non-atomic set/clear.
> >>>>>>> + */
> >>>>>>> +__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>>>>>> +__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>>>>>>  #else
> >>>>>>>  FOLIO_FLAG_FALSE(large_rmappable)
> >>>>>>> +FOLIO_TEST_FLAG_FALSE(partially_mapped)
> >>>>>>> +__FOLIO_SET_FLAG_NOOP(partially_mapped)
> >>>>>>> +__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
> >>>>>>>  #endif
> >>>>>>>
> >>>>>>>  #define PG_head_mask ((1UL << PG_head))
> >>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>>>> index 2d77b5d2291e..70ee49dfeaad 100644
> >>>>>>> --- a/mm/huge_memory.c
> >>>>>>> +++ b/mm/huge_memory.c
> >>>>>>> @@ -3398,6 +3398,7 @@ int split_huge_page_to_list_to_order(struct=
 page *page, struct list_head *list,
> >>>>>>>                          * page_deferred_list.
> >>>>>>>                          */
> >>>>>>>                         list_del_init(&folio->_deferred_list);
> >>>>>>> +                       __folio_clear_partially_mapped(folio);
> >>>>>>>                 }
> >>>>>>>                 spin_unlock(&ds_queue->split_queue_lock);
> >>>>>>>                 if (mapping) {
> >>>>>>> @@ -3454,11 +3455,13 @@ void __folio_undo_large_rmappable(struct =
folio *folio)
> >>>>>>>         if (!list_empty(&folio->_deferred_list)) {
> >>>>>>>                 ds_queue->split_queue_len--;
> >>>>>>>                 list_del_init(&folio->_deferred_list);
> >>>>>>> +               __folio_clear_partially_mapped(folio);
> >>>>>>
> >>>>>> is it possible to make things clearer by
> >>>>>>
> >>>>>>  if (folio_clear_partially_mapped)
> >>>>>>     __folio_clear_partially_mapped(folio);
> >>>>>>
> >>>>>> While writing without conditions isn't necessarily wrong, adding a=
 condition
> >>>>>> will improve the readability of the code and enhance the clarity o=
f my mTHP
> >>>>>> counters series. also help decrease smp cache sync if we can avoid
> >>>>>> unnecessary writing?
> >>>>>>
> >>>>>
> >>>>> Do you mean if(folio_test_partially_mapped(folio))?
> >>>>>
> >>>>> I don't like this idea. I think it makes the readability worse? If =
I was looking at if (test) -> clear for the first time, I would become conf=
used why its being tested if its going to be clear at the end anyways?
> >>>>
> >>>> In the pmd-order case, the majority of folios are not partially mapp=
ed.
> >>>> Unconditional writes will trigger cache synchronization across all
> >>>> CPUs (related to the MESI protocol), making them more costly. By
> >>>> using conditional writes, such as "if(test) write," we can avoid
> >>>> most unnecessary writes, which is much more efficient. Additionally,
> >>>> we only need to manage nr_split_deferred when the condition
> >>>> is met. We are carefully evaluating all scenarios to determine
> >>>> if modifications to the partially_mapped flag are necessary.
> >>>>
> >>>
> >>>
> >>> Hmm okay, as you said its needed for nr_split_deferred anyways. Somet=
hing like below is ok to fold in?
> >>>
> >>> commit 4ae9e2067346effd902b342296987b97dee29018 (HEAD)
> >>> Author: Usama Arif <usamaarif642@gmail.com>
> >>> Date:   Mon Aug 19 21:07:16 2024 +0100
> >>>
> >>>     mm: Introduce a pageflag for partially mapped folios fix
> >>>
> >>>     Test partially_mapped flag before clearing it. This should
> >>>     avoid unnecessary writes and will be needed in the nr_split_defer=
red
> >>>     series.
> >>>
> >>>     Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 5d67d3b3c1b2..ccde60aaaa0f 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -3479,7 +3479,8 @@ void __folio_undo_large_rmappable(struct folio =
*folio)
> >>>         if (!list_empty(&folio->_deferred_list)) {
> >>>                 ds_queue->split_queue_len--;
> >>>                 list_del_init(&folio->_deferred_list);
> >>> -               __folio_clear_partially_mapped(folio);
> >>> +               if (folio_test_partially_mapped(folio))
> >>> +                       __folio_clear_partially_mapped(folio);
> >>>         }
> >>>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >>>  }
> >>> @@ -3610,7 +3611,8 @@ static unsigned long deferred_split_scan(struct=
 shrinker *shrink,
> >>>                 } else {
> >>>                         /* We lost race with folio_put() */
> >>>                         list_del_init(&folio->_deferred_list);
> >>> -                       __folio_clear_partially_mapped(folio);
> >>> +                       if (folio_test_partially_mapped(folio))
> >>> +                               __folio_clear_partially_mapped(folio)=
;
> >>>                         ds_queue->split_queue_len--;
> >>>                 }
> >>>                 if (!--sc->nr_to_scan)
> >>>
> >>
> >> Do we also need if (folio_test_partially_mapped(folio)) in
> >> split_huge_page_to_list_to_order()?
> >>
> >> I recall that in Yu Zhao's TAO, there=E2=80=99s a chance of splitting =
(shattering)
> >> non-partially-mapped folios. To be future-proof, we might want to hand=
le
> >> both cases equally.
> >
> > we recall we also have a real case which can split entirely_mapped
> > folio:
> >
> > mm: huge_memory: enable debugfs to split huge pages to any order
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfc4d182316bd5309b4066fd9ef21529ea397a7d4
> >
> >>
> >> By the way, we might not need to clear the flag for a new folio. This =
differs
> >> from the init_list, which is necessary. If a new folio has the partial=
ly_mapped
> >> flag, it indicates that we failed to clear it when freeing the folio t=
o
> >> the buddy system, which is a bug we need to fix in the free path.
> >>
> >> Thanks
> >> Barry
>
> I believe the below fixlet should address all concerns:

Hi Usama,
thanks! I can't judge if we need this partially_mapped flag. but if we
need, the code
looks correct to me. I'd like to leave this to David and other experts to a=
ck.

an alternative approach might be two lists? one for entirely_mapped,
the other one
for split_deferred. also seems ugly ?

On the other hand, when we want to extend your patchset to mTHP other than =
PMD-
order, will the only deferred_list create huge lock contention while
adding or removing
folios from it?

>
>
> From 95492a51b1929ea274b4e5b78fc74e7736645d58 Mon Sep 17 00:00:00 2001
> From: Usama Arif <usamaarif642@gmail.com>
> Date: Mon, 19 Aug 2024 21:07:16 +0100
> Subject: [PATCH] mm: Introduce a pageflag for partially mapped folios fix
>
> Test partially_mapped flag before clearing it. This should
> avoid unnecessary writes and will be needed in the nr_split_deferred
> series.
> Also no need to clear partially_mapped prepping compound head, as it
> should start with already being cleared.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/page-flags.h | 2 +-
>  mm/huge_memory.c           | 9 ++++++---
>  mm/internal.h              | 4 +---
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index c3bb0e0da581..f1602695daf2 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1182,7 +1182,7 @@ static __always_inline void __ClearPageAnonExclusiv=
e(struct page *page)
>   */
>  #define PAGE_FLAGS_SECOND                                              \
>         (0xffUL /* order */             | 1UL << PG_has_hwpoisoned |    \
> -        1UL << PG_large_rmappable)
> +        1UL << PG_large_rmappable      | 1UL << PG_partially_mapped)
>
>  #define PAGE_FLAGS_PRIVATE                             \
>         (1UL << PG_private | 1UL << PG_private_2)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5d67d3b3c1b2..402b9d933de0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3422,7 +3422,8 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>                          * page_deferred_list.
>                          */
>                         list_del_init(&folio->_deferred_list);
> -                       __folio_clear_partially_mapped(folio);
> +                       if (folio_test_partially_mapped(folio))
> +                               __folio_clear_partially_mapped(folio);
>                 }
>                 spin_unlock(&ds_queue->split_queue_lock);
>                 if (mapping) {
> @@ -3479,7 +3480,8 @@ void __folio_undo_large_rmappable(struct folio *fol=
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
> @@ -3610,7 +3612,8 @@ static unsigned long deferred_split_scan(struct shr=
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
> diff --git a/mm/internal.h b/mm/internal.h
> index 27cbb5365841..52f7fc4e8ac3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -662,10 +662,8 @@ static inline void prep_compound_head(struct page *p=
age, unsigned int order)
>         atomic_set(&folio->_entire_mapcount, -1);
>         atomic_set(&folio->_nr_pages_mapped, 0);
>         atomic_set(&folio->_pincount, 0);
> -       if (order > 1) {
> +       if (order > 1)
>                 INIT_LIST_HEAD(&folio->_deferred_list);
> -               __folio_clear_partially_mapped(folio);
> -       }
>  }
>
>  static inline void prep_compound_tail(struct page *head, int tail_idx)
> --
> 2.43.5
>
>

Thanks
Barry


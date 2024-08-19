Return-Path: <linux-kernel+bounces-292954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F69576EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D02281D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC591DC491;
	Mon, 19 Aug 2024 21:56:08 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69571898E7;
	Mon, 19 Aug 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104567; cv=none; b=f1lHvCbh+Nv5jr/sHs4lsVpNlgzshWUVuM4H2MeTz6MLh99lPnoGea72Nk5oPCXtgMR8fhgHswr9E1RKDg6+OiN57Han7OQYAvxKnWsuGNBkUVpsF5vmcNL9KdfT1gFG/G1cEszVRtDrVk18Eq6X5hQVj+8BgYZXWxgO3/fWIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104567; c=relaxed/simple;
	bh=TmkekAM5jlfjmMrWHESQvgf0yK9ZI7F0wPA+OBf51uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsftzT245OQhNn8ECX282xC4EOJr3lNl057A6oW7zWcVPriuUBj19GcIjNL5gReSjcPT/3ozGlrgDd34dEPCFqwPDffRsB9ooRuzeHDK1FuRqZdKpjRqyk2eXbVq31BYYULMyMq6B85WWRSniobsQcaEDdpBPABQsfGZGcRRAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4fc7bd8763cso806428e0c.2;
        Mon, 19 Aug 2024 14:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104565; x=1724709365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68jtH1gMT0hvORY1A0IXRpMKwJhK5A/kT7YX0AeFdQk=;
        b=at2bkFWjyO3yxrcwE0lpeVYT/py4gKkQLgJxGN9w/TkFhBnbVv52ykBKXBaS9HsVoU
         uxMKOOVFx4bXppNoirhfkm69uxER9e+lOU9ecaMU+OzBfTGdEVWfSOcQfs+fUB2kNhaH
         uE4IlS5euYQADcpV8CSBamXdARsmcfoug98vGtl+s1hcmPe09SLpFKcQsboizJD2tRVg
         HhaG0Qe2dKvBh9vluaaDmIGaQdiAU4AEA9GazyApwmXx2esVUF0bECi3fZZ6S6QM2z3E
         1pg+Ptu2nQJE/anvxlHsi6gEXxXxMthUxzQd90qhCNnyLUAhkBujhcqmHKSYUK/aZGC3
         yUcA==
X-Forwarded-Encrypted: i=1; AJvYcCU+zHjQU+AXpi7CStA4W1oOkFl161eGPBbzXIOMVnzkn8N+YW6UxXlSPVDqV44OpFZXMoXJT5XkYL1wJvm6rvFZmMXiqsBsWqNZOSfjQSsDFH97lQDmJSGOm5K4eOs0JgjZzjKm3O0A
X-Gm-Message-State: AOJu0YwU0X3H3IHyMWY9vOmdpTkYjpilppz5bkMFdIifGc3XWk1GQ7yI
	7Wh/7XOHDzcJZmWWL1Xndg0/B3lPPESTLt0Q3fSCnLOazdOhiyWSDEzRWdc6QLryPxCEGlw/5Tz
	/JXKGu3rZIb34Ll7grSB7jXS2oxk=
X-Google-Smtp-Source: AGHT+IEZIdw8wpoXSQOM21Stk7hHbJ3kSdIpE6PCXQlMRY/gGlOQJDe11aHF960J0st3NKJdV4kLVgMJRI2OLtGqyp4=
X-Received: by 2002:a05:6122:2193:b0:4f6:b094:80b1 with SMTP id
 71dfb90a1353d-4fc6c9fff96mr10350034e0c.11.1724104564640; Mon, 19 Aug 2024
 14:56:04 -0700 (PDT)
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
In-Reply-To: <CAGsJ_4xiG+oGkjt3nf0Zh2rdztz8h_AaahZWs4N3UARhw7DcgQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Aug 2024 09:55:49 +1200
Message-ID: <CAGsJ_4z2YL01wvVgsFsbzGAQ5KowXgxLcj=Y7DSX7ODOF5MUvw@mail.gmail.com>
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

On Tue, Aug 20, 2024 at 9:34=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, Aug 20, 2024 at 8:16=E2=80=AFAM Usama Arif <usamaarif642@gmail.co=
m> wrote:
> >
> >
> >
> > On 19/08/2024 20:00, Barry Song wrote:
> > > On Tue, Aug 20, 2024 at 2:17=E2=80=AFAM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> > >>
> > >>
> > >>
> > >> On 19/08/2024 09:29, Barry Song wrote:
> > >>> Hi Usama,
> > >>>
> > >>> I feel it is much better now! thanks!
> > >>>
> > >>> On Mon, Aug 19, 2024 at 2:31=E2=80=AFPM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> > >>>>
> > >>>> Currently folio->_deferred_list is used to keep track of
> > >>>> partially_mapped folios that are going to be split under memory
> > >>>> pressure. In the next patch, all THPs that are faulted in and coll=
apsed
> > >>>> by khugepaged are also going to be tracked using _deferred_list.
> > >>>>
> > >>>> This patch introduces a pageflag to be able to distinguish between
> > >>>> partially mapped folios and others in the deferred_list at split t=
ime in
> > >>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> > >>>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> > >>>> possible to distinguish between partially mapped folios and others=
 in
> > >>>> deferred_split_scan.
> > >>>>
> > >>>> Eventhough it introduces an extra flag to track if the folio is
> > >>>> partially mapped, there is no functional change intended with this
> > >>>> patch and the flag is not useful in this patch itself, it will
> > >>>> become useful in the next patch when _deferred_list has non partia=
lly
> > >>>> mapped folios.
> > >>>>
> > >>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > >>>> ---
> > >>>>  include/linux/huge_mm.h    |  4 ++--
> > >>>>  include/linux/page-flags.h | 11 +++++++++++
> > >>>>  mm/huge_memory.c           | 23 ++++++++++++++++-------
> > >>>>  mm/internal.h              |  4 +++-
> > >>>>  mm/memcontrol.c            |  3 ++-
> > >>>>  mm/migrate.c               |  3 ++-
> > >>>>  mm/page_alloc.c            |  5 +++--
> > >>>>  mm/rmap.c                  |  5 +++--
> > >>>>  mm/vmscan.c                |  3 ++-
> > >>>>  9 files changed, 44 insertions(+), 17 deletions(-)
> > >>>>
> > >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > >>>> index 4c32058cacfe..969f11f360d2 100644
> > >>>> --- a/include/linux/huge_mm.h
> > >>>> +++ b/include/linux/huge_mm.h
> > >>>> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page =
*page)
> > >>>>  {
> > >>>>         return split_huge_page_to_list_to_order(page, NULL, 0);
> > >>>>  }
> > >>>> -void deferred_split_folio(struct folio *folio);
> > >>>> +void deferred_split_folio(struct folio *folio, bool partially_map=
ped);
> > >>>>
> > >>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> > >>>>                 unsigned long address, bool freeze, struct folio *=
folio);
> > >>>> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page =
*page)
> > >>>>  {
> > >>>>         return 0;
> > >>>>  }
> > >>>> -static inline void deferred_split_folio(struct folio *folio) {}
> > >>>> +static inline void deferred_split_folio(struct folio *folio, bool=
 partially_mapped) {}
> > >>>>  #define split_huge_pmd(__vma, __pmd, __address)        \
> > >>>>         do { } while (0)
> > >>>>
> > >>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags=
.h
> > >>>> index a0a29bd092f8..c3bb0e0da581 100644
> > >>>> --- a/include/linux/page-flags.h
> > >>>> +++ b/include/linux/page-flags.h
> > >>>> @@ -182,6 +182,7 @@ enum pageflags {
> > >>>>         /* At least one page in this folio has the hwpoison flag s=
et */
> > >>>>         PG_has_hwpoisoned =3D PG_active,
> > >>>>         PG_large_rmappable =3D PG_workingset, /* anon or file-back=
ed */
> > >>>> +       PG_partially_mapped =3D PG_reclaim, /* was identified to b=
e partially mapped */
> > >>>>  };
> > >>>>
> > >>>>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> > >>>> @@ -861,8 +862,18 @@ static inline void ClearPageCompound(struct p=
age *page)
> > >>>>         ClearPageHead(page);
> > >>>>  }
> > >>>>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> > >>>> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> > >>>> +/*
> > >>>> + * PG_partially_mapped is protected by deferred_split split_queue=
_lock,
> > >>>> + * so its safe to use non-atomic set/clear.
> > >>>> + */
> > >>>> +__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> > >>>> +__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> > >>>>  #else
> > >>>>  FOLIO_FLAG_FALSE(large_rmappable)
> > >>>> +FOLIO_TEST_FLAG_FALSE(partially_mapped)
> > >>>> +__FOLIO_SET_FLAG_NOOP(partially_mapped)
> > >>>> +__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
> > >>>>  #endif
> > >>>>
> > >>>>  #define PG_head_mask ((1UL << PG_head))
> > >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > >>>> index 2d77b5d2291e..70ee49dfeaad 100644
> > >>>> --- a/mm/huge_memory.c
> > >>>> +++ b/mm/huge_memory.c
> > >>>> @@ -3398,6 +3398,7 @@ int split_huge_page_to_list_to_order(struct =
page *page, struct list_head *list,
> > >>>>                          * page_deferred_list.
> > >>>>                          */
> > >>>>                         list_del_init(&folio->_deferred_list);
> > >>>> +                       __folio_clear_partially_mapped(folio);
> > >>>>                 }
> > >>>>                 spin_unlock(&ds_queue->split_queue_lock);
> > >>>>                 if (mapping) {
> > >>>> @@ -3454,11 +3455,13 @@ void __folio_undo_large_rmappable(struct f=
olio *folio)
> > >>>>         if (!list_empty(&folio->_deferred_list)) {
> > >>>>                 ds_queue->split_queue_len--;
> > >>>>                 list_del_init(&folio->_deferred_list);
> > >>>> +               __folio_clear_partially_mapped(folio);
> > >>>
> > >>> is it possible to make things clearer by
> > >>>
> > >>>  if (folio_clear_partially_mapped)
> > >>>     __folio_clear_partially_mapped(folio);
> > >>>
> > >>> While writing without conditions isn't necessarily wrong, adding a =
condition
> > >>> will improve the readability of the code and enhance the clarity of=
 my mTHP
> > >>> counters series. also help decrease smp cache sync if we can avoid
> > >>> unnecessary writing?
> > >>>
> > >>
> > >> Do you mean if(folio_test_partially_mapped(folio))?
> > >>
> > >> I don't like this idea. I think it makes the readability worse? If I=
 was looking at if (test) -> clear for the first time, I would become confu=
sed why its being tested if its going to be clear at the end anyways?
> > >
> > > In the pmd-order case, the majority of folios are not partially mappe=
d.
> > > Unconditional writes will trigger cache synchronization across all
> > > CPUs (related to the MESI protocol), making them more costly. By
> > > using conditional writes, such as "if(test) write," we can avoid
> > > most unnecessary writes, which is much more efficient. Additionally,
> > > we only need to manage nr_split_deferred when the condition
> > > is met. We are carefully evaluating all scenarios to determine
> > > if modifications to the partially_mapped flag are necessary.
> > >
> >
> >
> > Hmm okay, as you said its needed for nr_split_deferred anyways. Somethi=
ng like below is ok to fold in?
> >
> > commit 4ae9e2067346effd902b342296987b97dee29018 (HEAD)
> > Author: Usama Arif <usamaarif642@gmail.com>
> > Date:   Mon Aug 19 21:07:16 2024 +0100
> >
> >     mm: Introduce a pageflag for partially mapped folios fix
> >
> >     Test partially_mapped flag before clearing it. This should
> >     avoid unnecessary writes and will be needed in the nr_split_deferre=
d
> >     series.
> >
> >     Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 5d67d3b3c1b2..ccde60aaaa0f 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3479,7 +3479,8 @@ void __folio_undo_large_rmappable(struct folio *f=
olio)
> >         if (!list_empty(&folio->_deferred_list)) {
> >                 ds_queue->split_queue_len--;
> >                 list_del_init(&folio->_deferred_list);
> > -               __folio_clear_partially_mapped(folio);
> > +               if (folio_test_partially_mapped(folio))
> > +                       __folio_clear_partially_mapped(folio);
> >         }
> >         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >  }
> > @@ -3610,7 +3611,8 @@ static unsigned long deferred_split_scan(struct s=
hrinker *shrink,
> >                 } else {
> >                         /* We lost race with folio_put() */
> >                         list_del_init(&folio->_deferred_list);
> > -                       __folio_clear_partially_mapped(folio);
> > +                       if (folio_test_partially_mapped(folio))
> > +                               __folio_clear_partially_mapped(folio);
> >                         ds_queue->split_queue_len--;
> >                 }
> >                 if (!--sc->nr_to_scan)
> >
>
> Do we also need if (folio_test_partially_mapped(folio)) in
> split_huge_page_to_list_to_order()?
>
> I recall that in Yu Zhao's TAO, there=E2=80=99s a chance of splitting (sh=
attering)
> non-partially-mapped folios. To be future-proof, we might want to handle
> both cases equally.

we recall we also have a real case which can split entirely_mapped
folio:

mm: huge_memory: enable debugfs to split huge pages to any order
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dfc4d182316bd5309b4066fd9ef21529ea397a7d4

>
> By the way, we might not need to clear the flag for a new folio. This dif=
fers
> from the init_list, which is necessary. If a new folio has the partially_=
mapped
> flag, it indicates that we failed to clear it when freeing the folio to
> the buddy system, which is a bug we need to fix in the free path.
>
> Thanks
> Barry


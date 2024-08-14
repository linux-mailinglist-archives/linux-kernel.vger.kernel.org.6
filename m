Return-Path: <linux-kernel+bounces-286335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EE99519CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B655DB2256E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592651AED2E;
	Wed, 14 Aug 2024 11:23:55 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3B1442F7;
	Wed, 14 Aug 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634634; cv=none; b=sWO1AGWbdZOpG0RFwg6tccDj1v8JvqlsIRTY1WX4ub4MEsCmiNUPxFykl3JhxLCk4ZbOGyN5UpisVfGlcl1r/PtIg6S9/LOu6yOJZEKRZCbyyoPhhJbA0M0wuPAmj5ApZTGuPq0vd1BbZiEP6Sumn1aHrYWw3Lj4tJcy9izDRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634634; c=relaxed/simple;
	bh=3bbpPCVD912nzTkYXBBNXx67AoP31V8lFtjaD9zHmXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhjX55F8sTnql2NQyZQN9C3Qkxc1bEfaLYSTY9h41u0muXjDqiV1QkELxVWmqBieiA9dmwMQDQiYg+GWfB7bS3I0NViK6/MLllOsWdwlv8YcIFppu0e9J+ypirhknbpQ1136yR5+C7tR0bM0AtotoNya9mhKfwFhvqdJBVWomRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-842eee4ad03so161522241.0;
        Wed, 14 Aug 2024 04:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723634632; x=1724239432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVSCZnAx0ph5xRRQ7GkxGxeOGoX+028zxOSJgCS/ioo=;
        b=GHg7WrYeAV5V0MU5vTzMxydrBLfK0ngEYEM2BqRtK5WJBOuG1qnJ8OYjGq8sH4xTel
         Y3LMS6Trt4Oa/K3gGSNgyWLY4l3HDYEA77pz/80ieGL/m86GXqcKjR+11LbuQQBHRIbP
         ixzTNly0N+ocP51/LbPViCcrvqQzALRm+kFFkuZQblJWS/AGOfYNes2Z2Cje3CpkeggY
         0GjMiZ1SQxcSHtytBEiuF1u8aZuyeWMPsJQ/YvoyiJQmKYVewPMgLQq3oB5NpCWZpldP
         6OkzPAM8FYGpPBtMe8nZ3h7/iRZ+IgYhNSkJX9+kFmyviF+rQcz61wo4XmtUh4xQOadk
         oFKA==
X-Forwarded-Encrypted: i=1; AJvYcCVuPYpSk1+XL8ujkR2e+yWNt8kpMEvBwemhxFzTUluUkJ1GV1AaWNXWDZBPpSr6H3aTCDRht+t30AIfIlZshmt3Gp9HU2NgRCLIZ9aPHVjbB7ouzy59BFMSR4r5VY0AkOjWgneuj2L/
X-Gm-Message-State: AOJu0Yzx+hoQ7wBkpMNoo+D0D0MZOg9iD2G8fVIFGLtoRt3m9/nXFllG
	YxIgaHc2Cjoytx/L8lfgv/qTZ36Q8MdEYtzSRI/V/9mjcnHQFj4aTJmrSdfeobDis8P4BMh+aZl
	zS7Fbjm7+kOdUfa3UJywTomUp3Ng=
X-Google-Smtp-Source: AGHT+IGzXOqu6YISJ0i99DXmN81woLtBhlIOuPVGW1ZKvhROMtCyKZYDSVe8tw/itbg3NcFMozoG/Mw+kcLTlwZIMsQ=
X-Received: by 2002:a05:6102:3907:b0:48f:23b4:1d96 with SMTP id
 ada2fe7eead31-4975990e713mr2530052137.16.1723634631767; Wed, 14 Aug 2024
 04:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com> <CAGsJ_4ySxmhQCXT5Nw09tdGJA+j9=ZEMEuPa6jgX__tM+EMqXw@mail.gmail.com>
 <59725862-f4fc-456c-bafb-cbd302777881@gmail.com>
In-Reply-To: <59725862-f4fc-456c-bafb-cbd302777881@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 14 Aug 2024 23:23:40 +1200
Message-ID: <CAGsJ_4zT0R_QcHCvPW7EozY86Skbo_3BtgcJz_fd-tipXZJxTQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:20=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 14/08/2024 12:10, Barry Song wrote:
> > On Wed, Aug 14, 2024 at 12:03=E2=80=AFAM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>
> >> Currently folio->_deferred_list is used to keep track of
> >> partially_mapped folios that are going to be split under memory
> >> pressure. In the next patch, all THPs that are faulted in and collapse=
d
> >> by khugepaged are also going to be tracked using _deferred_list.
> >>
> >> This patch introduces a pageflag to be able to distinguish between
> >> partially mapped folios and others in the deferred_list at split time =
in
> >> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> >> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> >> possible to distinguish between partially mapped folios and others in
> >> deferred_split_scan.
> >>
> >> Eventhough it introduces an extra flag to track if the folio is
> >> partially mapped, there is no functional change intended with this
> >> patch and the flag is not useful in this patch itself, it will
> >> become useful in the next patch when _deferred_list has non partially
> >> mapped folios.
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  include/linux/huge_mm.h    |  4 ++--
> >>  include/linux/page-flags.h |  3 +++
> >>  mm/huge_memory.c           | 21 +++++++++++++--------
> >>  mm/hugetlb.c               |  1 +
> >>  mm/internal.h              |  4 +++-
> >>  mm/memcontrol.c            |  3 ++-
> >>  mm/migrate.c               |  3 ++-
> >>  mm/page_alloc.c            |  5 +++--
> >>  mm/rmap.c                  |  3 ++-
> >>  mm/vmscan.c                |  3 ++-
> >>  10 files changed, 33 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 4c32058cacfe..969f11f360d2 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *pag=
e)
> >>  {
> >>         return split_huge_page_to_list_to_order(page, NULL, 0);
> >>  }
> >> -void deferred_split_folio(struct folio *folio);
> >> +void deferred_split_folio(struct folio *folio, bool partially_mapped)=
;
> >>
> >>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >>                 unsigned long address, bool freeze, struct folio *foli=
o);
> >> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *pag=
e)
> >>  {
> >>         return 0;
> >>  }
> >> -static inline void deferred_split_folio(struct folio *folio) {}
> >> +static inline void deferred_split_folio(struct folio *folio, bool par=
tially_mapped) {}
> >>  #define split_huge_pmd(__vma, __pmd, __address)        \
> >>         do { } while (0)
> >>
> >> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >> index a0a29bd092f8..cecc1bad7910 100644
> >> --- a/include/linux/page-flags.h
> >> +++ b/include/linux/page-flags.h
> >> @@ -182,6 +182,7 @@ enum pageflags {
> >>         /* At least one page in this folio has the hwpoison flag set *=
/
> >>         PG_has_hwpoisoned =3D PG_active,
> >>         PG_large_rmappable =3D PG_workingset, /* anon or file-backed *=
/
> >> +       PG_partially_mapped, /* was identified to be partially mapped =
*/
> >>  };
> >>
> >>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> >> @@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page =
*page)
> >>         ClearPageHead(page);
> >>  }
> >>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> >> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>  #else
> >>  FOLIO_FLAG_FALSE(large_rmappable)
> >> +FOLIO_FLAG_FALSE(partially_mapped)
> >>  #endif
> >>
> >>  #define PG_head_mask ((1UL << PG_head))
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 6df0e9f4f56c..c024ab0f745c 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>                          * page_deferred_list.
> >>                          */
> >>                         list_del_init(&folio->_deferred_list);
> >> +                       folio_clear_partially_mapped(folio);
> >>                 }
> >>                 spin_unlock(&ds_queue->split_queue_lock);
> >>                 if (mapping) {
> >> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio=
 *folio)
> >>         if (!list_empty(&folio->_deferred_list)) {
> >>                 ds_queue->split_queue_len--;
> >>                 list_del_init(&folio->_deferred_list);
> >> +               folio_clear_partially_mapped(folio);
> >>         }
> >>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >>  }
> >>
> >> -void deferred_split_folio(struct folio *folio)
> >> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >>  {
> >>         struct deferred_split *ds_queue =3D get_deferred_split_queue(f=
olio);
> >>  #ifdef CONFIG_MEMCG
> >> @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
> >>         if (folio_test_swapcache(folio))
> >>                 return;
> >>
> >> -       if (!list_empty(&folio->_deferred_list))
> >> -               return;
> >> -
> >>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >> +       if (partially_mapped)
> >> +               folio_set_partially_mapped(folio);
> >> +       else
> >> +               folio_clear_partially_mapped(folio);
> >>         if (list_empty(&folio->_deferred_list)) {
> >> -               if (folio_test_pmd_mappable(folio))
> >> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DE=
FERRED);
> >> +               if (partially_mapped) {
> >> +                       if (folio_test_pmd_mappable(folio))
> >> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE=
);
> >> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_=
SPLIT_DEFERRED);
> >
> > This code completely broke MTHP_STAT_SPLIT_DEFERRED for PMD_ORDER. It
> > added the folio to the deferred_list as entirely_mapped
> > (partially_mapped =3D=3D false).
> > However, when partially_mapped becomes true, there's no opportunity to
> > add it again
> > as it has been there on the list. Are you consistently seeing the count=
er for
> > PMD_ORDER as 0?
> >
>
> Ah I see it, this should fix it?
>
> -void deferred_split_folio(struct folio *folio)
> +/* partially_mapped=3Dfalse won't clear PG_partially_mapped folio flag *=
/
> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  {
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(foli=
o);
>  #ifdef CONFIG_MEMCG
> @@ -3485,14 +3488,14 @@ void deferred_split_folio(struct folio *folio)
>         if (folio_test_swapcache(folio))
>                 return;
>
> -       if (!list_empty(&folio->_deferred_list))
> -               return;
> -
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -       if (list_empty(&folio->_deferred_list)) {
> +       if (partially_mapped) {
> +               folio_set_partially_mapped(folio);
>                 if (folio_test_pmd_mappable(folio))
>                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>                 count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFER=
RED);
> +       }
> +       if (list_empty(&folio->_deferred_list)) {
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
>

not enough. as deferred_split_folio(true) won't be called if folio has been
deferred_list in __folio_remove_rmap():

        if (partially_mapped && folio_test_anon(folio) &&
            list_empty(&folio->_deferred_list))
                deferred_split_folio(folio, true);

so you will still see 0.

Thanks
Barry


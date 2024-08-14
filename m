Return-Path: <linux-kernel+bounces-286340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB99519D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDAF281807
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79F1AED31;
	Wed, 14 Aug 2024 11:26:46 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A633D8;
	Wed, 14 Aug 2024 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634805; cv=none; b=jpI6p62d2vHxi/fYGrmqbMtwbhtVdhCkRYQ20AhsmSPLFyuVT2dOKSGdipQ6r7VEoNoeIHezmgSq5/OUPPdcg4pZoMkQWf6SAA73t+xccGXuskFiAMgkAdjL4r+gLYBbEAXEA81mIoDlWgZamGXyKNSorVceS5xjz83r5SJlXn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634805; c=relaxed/simple;
	bh=WNnLpnSd8521bJcbd963UvRtqugOYmoPkwrQGUc6MeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5doa5ggHFyVmEDPLnfl858is/K6fQD2mb5VSFszzvKeZidZ+1Q/NcCnPW4zZs5VVXLdT6mAZuoYV0luAQA9anz9Z2sYEXWtcrGaZxMzVHuuSMA45le0lIEP2zbREN1su5qNU1q2QFJm9HJ1zqEYqChpIGIY5b5jXfbvGbmL/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e11693fbebaso14191276.3;
        Wed, 14 Aug 2024 04:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723634803; x=1724239603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT5lH3llt5yDkNep7VtRwo9nhgK6w5OeNlkSRKQDgNM=;
        b=JHCxDNoG1Z5pJRwDRoD15xKBpny/KgusxpZvEIh6okWouGO+528koRPDR5xoZHEJW7
         Bx06cbpeiXkYyMWwWiPKDmWvhAduMig25KgvyrxTRqnM96Ur/cczXDijAz2OtWsYjcLc
         yGbeGhkChsdhLRTTelPnaW6JUKZr77oeWb84hjKylB9IX0Vl7hKAK96WMgNkY36BQCBN
         A1c6bmaCAXC1oSoJ/l5fRFm8a7zA675ICJ6mJ3g3e555TLa0nxIMKyG4DRl63E4wE8Nv
         +G9sUWWlO+OUIy9OpFWReRHJR14uGswHjLqd9qoeAtLNhql3AfiVeSvTkgCCUfwvX+Hg
         Hr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6xlWHaV3WLZDg+nwy429JXe1iAyK84ZxGdpoBi1BD47ft7WORFuSPfazNc6zJCmULMpIaI5K0/z/o/ccFtuav5p+Rbsl/e9vHHVsr1QihO01VXT0lX/GYctTt53QvMFb+ZJ4M8qLt
X-Gm-Message-State: AOJu0YwPpgGVxCgA7Kv/EmiD5IMgrmxk4Z104i7QatONkdLvDg0Mpudz
	0uTHt/G7CUGivX6ZCTOvoR3F6o5p1sRM8o9zC7/lzdCAbsbM5osn7LWvpOYP2QLcjKB6R1vfdwt
	Tok4H/2DBNgSbks3Rx7aTtSpDfapWxu9u
X-Google-Smtp-Source: AGHT+IEUrQU/dg9fEllqiVqvnBpeUzrMN0ffa9RSbvtQprtqwh52oiIaJzndd44+fVCD4mrALJuUP1cJ1bRsKi3Djtk=
X-Received: by 2002:a05:6902:140c:b0:e0b:fcb9:28d6 with SMTP id
 3f1490d57ef6-e1155a4758emr2565796276.9.1723634802922; Wed, 14 Aug 2024
 04:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com> <CAGsJ_4x+5fiCoWv4G0NsYq+aJRqZsrCEHO_DF+CnNFdqx0VgMQ@mail.gmail.com>
 <925804e4-0b33-45eb-905d-e00f67192828@gmail.com> <CAGsJ_4x4Ha5jDZuhNxXvbYU6WXtR9A-o3QxYUHkcUzrzoNWaMw@mail.gmail.com>
In-Reply-To: <CAGsJ_4x4Ha5jDZuhNxXvbYU6WXtR9A-o3QxYUHkcUzrzoNWaMw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 14 Aug 2024 23:26:31 +1200
Message-ID: <CAGsJ_4zYRFnj3npBE9U031Rs-1iaXzmN+ZaMrNA=mruVZM50EA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:20=E2=80=AFPM Barry Song <baohua@kernel.org> wro=
te:
>
> On Wed, Aug 14, 2024 at 11:11=E2=80=AFPM Usama Arif <usamaarif642@gmail.c=
om> wrote:
> >
> >
> >
> > On 14/08/2024 11:44, Barry Song wrote:
> > > On Wed, Aug 14, 2024 at 12:03=E2=80=AFAM Usama Arif <usamaarif642@gma=
il.com> wrote:
> > >>
> > >> Currently folio->_deferred_list is used to keep track of
> > >> partially_mapped folios that are going to be split under memory
> > >> pressure. In the next patch, all THPs that are faulted in and collap=
sed
> > >> by khugepaged are also going to be tracked using _deferred_list.
> > >>
> > >> This patch introduces a pageflag to be able to distinguish between
> > >> partially mapped folios and others in the deferred_list at split tim=
e in
> > >> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> > >> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> > >> possible to distinguish between partially mapped folios and others i=
n
> > >> deferred_split_scan.
> > >>
> > >> Eventhough it introduces an extra flag to track if the folio is
> > >> partially mapped, there is no functional change intended with this
> > >> patch and the flag is not useful in this patch itself, it will
> > >> become useful in the next patch when _deferred_list has non partiall=
y
> > >> mapped folios.
> > >>
> > >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > >> ---
> > >>  include/linux/huge_mm.h    |  4 ++--
> > >>  include/linux/page-flags.h |  3 +++
> > >>  mm/huge_memory.c           | 21 +++++++++++++--------
> > >>  mm/hugetlb.c               |  1 +
> > >>  mm/internal.h              |  4 +++-
> > >>  mm/memcontrol.c            |  3 ++-
> > >>  mm/migrate.c               |  3 ++-
> > >>  mm/page_alloc.c            |  5 +++--
> > >>  mm/rmap.c                  |  3 ++-
> > >>  mm/vmscan.c                |  3 ++-
> > >>  10 files changed, 33 insertions(+), 17 deletions(-)
> > >>
> > >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > >> index 4c32058cacfe..969f11f360d2 100644
> > >> --- a/include/linux/huge_mm.h
> > >> +++ b/include/linux/huge_mm.h
> > >> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *p=
age)
> > >>  {
> > >>         return split_huge_page_to_list_to_order(page, NULL, 0);
> > >>  }
> > >> -void deferred_split_folio(struct folio *folio);
> > >> +void deferred_split_folio(struct folio *folio, bool partially_mappe=
d);
> > >>
> > >>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> > >>                 unsigned long address, bool freeze, struct folio *fo=
lio);
> > >> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *p=
age)
> > >>  {
> > >>         return 0;
> > >>  }
> > >> -static inline void deferred_split_folio(struct folio *folio) {}
> > >> +static inline void deferred_split_folio(struct folio *folio, bool p=
artially_mapped) {}
> > >>  #define split_huge_pmd(__vma, __pmd, __address)        \
> > >>         do { } while (0)
> > >>
> > >> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > >> index a0a29bd092f8..cecc1bad7910 100644
> > >> --- a/include/linux/page-flags.h
> > >> +++ b/include/linux/page-flags.h
> > >> @@ -182,6 +182,7 @@ enum pageflags {
> > >>         /* At least one page in this folio has the hwpoison flag set=
 */
> > >>         PG_has_hwpoisoned =3D PG_active,
> > >>         PG_large_rmappable =3D PG_workingset, /* anon or file-backed=
 */
> > >> +       PG_partially_mapped, /* was identified to be partially mappe=
d */
> > >>  };
> > >>
> > >>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> > >> @@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct pag=
e *page)
> > >>         ClearPageHead(page);
> > >>  }
> > >>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> > >> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> > >>  #else
> > >>  FOLIO_FLAG_FALSE(large_rmappable)
> > >> +FOLIO_FLAG_FALSE(partially_mapped)
> > >>  #endif
> > >>
> > >>  #define PG_head_mask ((1UL << PG_head))
> > >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > >> index 6df0e9f4f56c..c024ab0f745c 100644
> > >> --- a/mm/huge_memory.c
> > >> +++ b/mm/huge_memory.c
> > >> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
> > >>                          * page_deferred_list.
> > >>                          */
> > >>                         list_del_init(&folio->_deferred_list);
> > >> +                       folio_clear_partially_mapped(folio);
> > >>                 }
> > >>                 spin_unlock(&ds_queue->split_queue_lock);
> > >>                 if (mapping) {
> > >> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct fol=
io *folio)
> > >>         if (!list_empty(&folio->_deferred_list)) {
> > >>                 ds_queue->split_queue_len--;
> > >>                 list_del_init(&folio->_deferred_list);
> > >> +               folio_clear_partially_mapped(folio);
> > >>         }
> > >>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> > >>  }
> > >>
> > >> -void deferred_split_folio(struct folio *folio)
> > >> +void deferred_split_folio(struct folio *folio, bool partially_mappe=
d)
> > >>  {
> > >>         struct deferred_split *ds_queue =3D get_deferred_split_queue=
(folio);
> > >>  #ifdef CONFIG_MEMCG
> > >> @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *foli=
o)
> > >>         if (folio_test_swapcache(folio))
> > >>                 return;
> > >>
> > >> -       if (!list_empty(&folio->_deferred_list))
> > >> -               return;
> > >> -
> > >>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> > >> +       if (partially_mapped)
> > >> +               folio_set_partially_mapped(folio);
> > >> +       else
> > >> +               folio_clear_partially_mapped(folio);
> > >
> > > Hi Usama,
> > >
> > > Do we need this? When can a partially_mapped folio on deferred_list b=
ecome
> > > non-partially-mapped and need a clear? I understand transferring from
> > > entirely_map
> > > to partially_mapped is a one way process? partially_mapped folios can=
't go back
> > > to entirely_mapped?
> > >
> > Hi Barry,
> >
> > deferred_split_folio function is called in 3 places after this series, =
at fault, collapse and partial mapping. partial mapping can only happen aft=
er fault/collapse, and we have FOLIO_FLAG_FALSE(partially_mapped), i.e. fla=
g initialized to false, so technically its not needed. A partially_mapped f=
olio on deferred list wont become non-partially mapped.
> >
> > I just did it as a precaution if someone ever changes the kernel and ca=
lls deferred_split_folio with partially_mapped set to false after it had be=
en true. The function arguments of deferred_split_folio make it seem that p=
assing partially_mapped=3Dfalse as an argument would clear it, which is why=
 I cleared it as well. I could change the patch to something like below if =
it makes things better? i.e. add a comment at the top of the function:
> >
>
> to me, it seems a BUG to call with false after a folio has been
> partially_mapped. So I'd rather
> VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
>
> The below should also fix the MTHP_STAT_SPLIT_DEFERRED
> counter this patch is breaking?
>
> @@ -3515,16 +3522,18 @@ void deferred_split_folio(struct folio *folio,
> bool partially_mapped)
>                 return;
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -       if (partially_mapped)
> -               folio_set_partially_mapped(folio);
> -       else
> -               folio_clear_partially_mapped(folio);
> -       if (list_empty(&folio->_deferred_list)) {
> -               if (partially_mapped) {
> +       if (partially_mapped) {
> +               if (!folio_test_set_partially_mapped(folio)) {
> +                       mod_mthp_stat(folio_order(folio),
> +                               MTHP_STAT_NR_SPLIT_DEFERRED, 1);
>                         if (folio_test_pmd_mappable(folio))
>                                 count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>                         count_mthp_stat(folio_order(folio),
> MTHP_STAT_SPLIT_DEFERRED);
>                 }
> +       }
> +       VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);

sorry, I mean:
VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio) &&
!partially_mapped, folio);

> +
> +       if (list_empty(&folio->_deferred_list)) {
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
>
>
> >
> > -void deferred_split_folio(struct folio *folio)
> > +/* partially_mapped=3Dfalse won't clear PG_partially_mapped folio flag=
 */
> > +void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >  {
> >         struct deferred_split *ds_queue =3D get_deferred_split_queue(fo=
lio);
> >  #ifdef CONFIG_MEMCG
> > @@ -3485,14 +3488,15 @@ void deferred_split_folio(struct folio *folio)
> >         if (folio_test_swapcache(folio))
> >                 return;
> >
> > -       if (!list_empty(&folio->_deferred_list))
> > -               return;
> > -
> >         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> > +       if (partially_mapped)
> > +               folio_set_partially_mapped(folio);
> >         if (list_empty(&folio->_deferred_list)) {
> > -               if (folio_test_pmd_mappable(folio))
> > -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> > -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEF=
ERRED);
> > +               if (partially_mapped) {
> > +                       if (folio_test_pmd_mappable(folio))
> > +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE)=
;
> > +                       count_mthp_stat(folio_order(folio), MTHP_STAT_S=
PLIT_DEFERRED);
> > +               }
> >                 list_add_tail(&folio->_deferred_list, &ds_queue->split_=
queue);
> >                 ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
> >
> >
> > > I am trying to rebase my NR_SPLIT_DEFERRED counter on top of your
> > > work, but this "clear" makes that job quite tricky. as I am not sure
> > > if this patch
> > > is going to clear the partially_mapped flag for folios on deferred_li=
st.
> > >
> > > Otherwise, I can simply do the below whenever folio is leaving deferr=
ed_list
> > >
> > >         ds_queue->split_queue_len--;
> > >         list_del_init(&folio->_deferred_list);
> > >         if (folio_test_clear_partially_mapped(folio))
> > >                 mod_mthp_stat(folio_order(folio),
> > > MTHP_STAT_NR_SPLIT_DEFERRED, -1);
> > >
> >
>
> Thanks
> Barry


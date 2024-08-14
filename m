Return-Path: <linux-kernel+bounces-286333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E69519C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F0EB232B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3F1AED49;
	Wed, 14 Aug 2024 11:20:34 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5A1AED44;
	Wed, 14 Aug 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634433; cv=none; b=aXW5AjVJsImWUQzFGjZHo4wSpD2lkViNn6pPY4fZR2/i65WMn85cfgenOqSCiJg6SJ0kySZ7EVQJX2Bd5r4QhnygKs16i0G/N5Y5U9hursJelW9UdpA562/GRdiYIcUdMVUAq8j/iw2yQvfNUu/gqTGTRDWCVbnf4MQAvyHL8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634433; c=relaxed/simple;
	bh=SCJT+KqodhgeHH0K9pZ51pKh3r58R39YG/owjwZ/4pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALustxy42nGelkzbLZIG+jdICjZSIenBTvIssJqJzBlxNurr1QQJzgSqyCyxrVgqftAkLDmrLO4aLfzfpLk+qURIDTW5j7DkO0D/zAeAPL6JWf/YC5VaaqWcerQtryD2mPSV3s47roE0GAFTN0kAcTa2DSgSk/vx/R+jtSmLkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f6c136a947so2942243e0c.1;
        Wed, 14 Aug 2024 04:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723634431; x=1724239231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT8/yxCSMEel7SFnMznHXl6VK4SxHxcbluAHjtHcqO8=;
        b=vXVC2w0D56u5N+lGUAk9awNh8UUqDWTS73zr/jKiBPpe79ezNUrOjUWGs1ZLtc3p1E
         /lxmrDlNT09gQHd/jgid/JeW+QxSNW/PPpgZzxziPsoekVWPRqUqkQQ3/JJNCEymGnpU
         edKp6OFm/XIFGbwcXRF6bn7B3ERpwoeY/BSFtFD/somLShZfPf2s1eab+o2sxRNJ74v1
         nAjtajo0d42aqwmbzAUSkBDd5PmJO+iio0xpMTeotgEqt6TOLn8q66897X/kDCCVnyFK
         NzQ0kGuQnayCbpaOnqiVV4Ehb98qiKfiWNHFGeZGBveiLMIQ5gJ61tcAGpm1FpYAZOUR
         qxVg==
X-Forwarded-Encrypted: i=1; AJvYcCXdYkeWAN2wsFNkD7K5lU6btqD4fJfmaJH2Fr6KFUFq3/4PbHFGcGc6rdLCTUzW9GYaL0eWR7K7oy4zhYZ8UDFarNxXUTN4cUP6caBRv/7494C8fCC4tCw4nx8cqUTCdh7433q4JL24
X-Gm-Message-State: AOJu0YxCNXkiRG5ngjSi7TeCDxEvOALpQVsA0JHG5HCbp01ZcN1bxZgb
	feKSqPDCByq+elCmlCOcd0UCx2clvQ+ch3C3ew6s7pWcw1FNuFksggfymWLy5ZXtXhVbT4gPOie
	n8gbIdCHWpRDwbOOTkGLPEzrvoKQ=
X-Google-Smtp-Source: AGHT+IHu4oujxvSrHv7gWoSezqByQGV6UEbbHSBKelGeoAa0pI/ooMvt8mHWIk+5v8opzsRKxJLHBnrWZalaZ5rnalE=
X-Received: by 2002:a05:6122:130a:b0:4ed:12b:ec99 with SMTP id
 71dfb90a1353d-4fad1b0fdafmr3105204e0c.3.1723634430926; Wed, 14 Aug 2024
 04:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com> <CAGsJ_4x+5fiCoWv4G0NsYq+aJRqZsrCEHO_DF+CnNFdqx0VgMQ@mail.gmail.com>
 <925804e4-0b33-45eb-905d-e00f67192828@gmail.com>
In-Reply-To: <925804e4-0b33-45eb-905d-e00f67192828@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 14 Aug 2024 23:20:19 +1200
Message-ID: <CAGsJ_4x4Ha5jDZuhNxXvbYU6WXtR9A-o3QxYUHkcUzrzoNWaMw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:11=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 14/08/2024 11:44, Barry Song wrote:
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
> >
> > Hi Usama,
> >
> > Do we need this? When can a partially_mapped folio on deferred_list bec=
ome
> > non-partially-mapped and need a clear? I understand transferring from
> > entirely_map
> > to partially_mapped is a one way process? partially_mapped folios can't=
 go back
> > to entirely_mapped?
> >
> Hi Barry,
>
> deferred_split_folio function is called in 3 places after this series, at=
 fault, collapse and partial mapping. partial mapping can only happen after=
 fault/collapse, and we have FOLIO_FLAG_FALSE(partially_mapped), i.e. flag =
initialized to false, so technically its not needed. A partially_mapped fol=
io on deferred list wont become non-partially mapped.
>
> I just did it as a precaution if someone ever changes the kernel and call=
s deferred_split_folio with partially_mapped set to false after it had been=
 true. The function arguments of deferred_split_folio make it seem that pas=
sing partially_mapped=3Dfalse as an argument would clear it, which is why I=
 cleared it as well. I could change the patch to something like below if it=
 makes things better? i.e. add a comment at the top of the function:
>

to me, it seems a BUG to call with false after a folio has been
partially_mapped. So I'd rather
VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);

The below should also fix the MTHP_STAT_SPLIT_DEFERRED
counter this patch is breaking?

@@ -3515,16 +3522,18 @@ void deferred_split_folio(struct folio *folio,
bool partially_mapped)
                return;

        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-       if (partially_mapped)
-               folio_set_partially_mapped(folio);
-       else
-               folio_clear_partially_mapped(folio);
-       if (list_empty(&folio->_deferred_list)) {
-               if (partially_mapped) {
+       if (partially_mapped) {
+               if (!folio_test_set_partially_mapped(folio)) {
+                       mod_mthp_stat(folio_order(folio),
+                               MTHP_STAT_NR_SPLIT_DEFERRED, 1);
                        if (folio_test_pmd_mappable(folio))
                                count_vm_event(THP_DEFERRED_SPLIT_PAGE);
                        count_mthp_stat(folio_order(folio),
MTHP_STAT_SPLIT_DEFERRED);
                }
+       }
+       VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
+
+       if (list_empty(&folio->_deferred_list)) {
                list_add_tail(&folio->_deferred_list, &ds_queue->split_queu=
e);
                ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG


>
> -void deferred_split_folio(struct folio *folio)
> +/* partially_mapped=3Dfalse won't clear PG_partially_mapped folio flag *=
/
> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  {
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(foli=
o);
>  #ifdef CONFIG_MEMCG
> @@ -3485,14 +3488,15 @@ void deferred_split_folio(struct folio *folio)
>         if (folio_test_swapcache(folio))
>                 return;
>
> -       if (!list_empty(&folio->_deferred_list))
> -               return;
> -
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> +       if (partially_mapped)
> +               folio_set_partially_mapped(folio);
>         if (list_empty(&folio->_deferred_list)) {
> -               if (folio_test_pmd_mappable(folio))
> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFER=
RED);
> +               if (partially_mapped) {
> +                       if (folio_test_pmd_mappable(folio))
> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPL=
IT_DEFERRED);
> +               }
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
>
>
> > I am trying to rebase my NR_SPLIT_DEFERRED counter on top of your
> > work, but this "clear" makes that job quite tricky. as I am not sure
> > if this patch
> > is going to clear the partially_mapped flag for folios on deferred_list=
.
> >
> > Otherwise, I can simply do the below whenever folio is leaving deferred=
_list
> >
> >         ds_queue->split_queue_len--;
> >         list_del_init(&folio->_deferred_list);
> >         if (folio_test_clear_partially_mapped(folio))
> >                 mod_mthp_stat(folio_order(folio),
> > MTHP_STAT_NR_SPLIT_DEFERRED, -1);
> >
>

Thanks
Barry


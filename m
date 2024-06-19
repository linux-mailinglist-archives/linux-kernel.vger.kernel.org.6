Return-Path: <linux-kernel+bounces-220692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2634090E56C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31771F21A32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C779945;
	Wed, 19 Jun 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="criy/wC7"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BBD224D4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785256; cv=none; b=ANfg5Dzd5WPq7WuCcYBY8sVJdzdmHFMRJFeDsqW3I/27FqaNKQkoIa3BtPQPggFHB52KwHDNqVH3iPi4BLGR7cssnV0MBokIxVW4rPBSh1q2gwl1gN2LAbwmh48Xils9E4pGsmJxEt8Lo098mAiivNeWJMgvkYgeKsdPi0UL5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785256; c=relaxed/simple;
	bh=1XzMdBx9KiZ5Y3DFOztoYlLG5dQMfkCSdbxeEzHCg3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9SnMFbs4TL67y+exx1JsRt9Tv2rvu47PmWX1+Rp+ODQcIWTauYfTmzS1yz8f5obagHwdFL7gOW45b/ob9T5gPngKnwEHO4aIGVZBTUd3kswjJ1l3UYypfxHxTC+Ilnrq/EdEzH162LPOEpeHTdjQIo1YS4rRrQOqJIQpzRyeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=criy/wC7; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80f4f1e7cc3so433606241.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718785253; x=1719390053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He+zo0Tp/RNYugMKckmaumklLbi/HraZr7oLDXy9GoY=;
        b=criy/wC7fudJesIPqrmNt7CnkbRul9oFVKz/5CfPQHZ7+ea7fdRmyMqPgoWJsdSfY6
         b5DbigwFD9/hdrvdzyj5H02KZff21F44/um+5xTQ9OQGS9O1nGjYSAIDfjr50yxtT6K/
         frsrw745ppZJVdXPh/i6HJHrbd6893DSEw9ZB0E723PZCUd4F7stCokc8oGNo+lVpE14
         OcTbDDrjIAXD51nFR/74x8uApbg/mjB88gtH9u9IRnSR4A9WLMeTbm7vw3B8n6eU/T6A
         DFlvitlMD8B+HPMvzupmPxQI8fA1RPNNC1oEKCEUzzfa9W9l8bSBDxLeQOPES4etHh2n
         AKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785253; x=1719390053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He+zo0Tp/RNYugMKckmaumklLbi/HraZr7oLDXy9GoY=;
        b=iF9s+e4C7IzdX0249D0MrLwm/OXiW4hSp59NvJLSJM5/FE+vnMPbkJxdWO3okT3DnR
         3T07zwJU/lxva5punSLF66SN6YjTPcr22osyzeo/bq0U2LIGnF3SNZFtO8QbqoQI9VjR
         7lEsLGsTOGtFmyusN/s9DquLQBOB8ff8z8XA6ySM1CQf97D3xDyXQFhMYgPdFxHXE3Ih
         D+DSRZT2Jlqoewkoz+UP+YqoKHLgOwPq/9v9fbau5C3tr/gqvGdQgaZGmHTQrvGt/ccV
         pQ2eWQ7NObdBbRBK8xEww8UcigtW5jhReXjuKZVaIb01InNiAFndBovT6rA4XQeOPgyH
         ztOw==
X-Forwarded-Encrypted: i=1; AJvYcCXiHn95IGzlRA/zrpMH0O7uQsBWgU8vYoRCYk2ytnK+CVXugcOkDcvWygYLogS4nCITpYP+U3QLv1JIa3A38H9x+RtbmVUQ//bYiXEF
X-Gm-Message-State: AOJu0Yx687iwAyYp3hlI3laZ6L9rPI5/9NEVogIJ3fN46UpS0B95gcDV
	w7lK8g4Ewyup8p2N324635+Uvef5UDy4Ah6DF+EAwz/1tbLFToXRVsBvQitm1l9kAZa0m5PTGRy
	bJMSN1sgoEVnoOsdkPZbZyP5pnByXmUsT
X-Google-Smtp-Source: AGHT+IED0gDtzjRvMQIpWzZyTu8UVlVPUsyrecgQhzqb2lDXDEQzZ1IHEjrloriju+gLcFWUfpsXPzrdjfC0I9qAeUw=
X-Received: by 2002:a05:6102:3a76:b0:48d:4dc2:9b18 with SMTP id
 ada2fe7eead31-48f130d06e4mr1987402137.33.1718785253366; Wed, 19 Jun 2024
 01:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4zvG7gwukioZnqN+GpWHbpK1rkC0Jeqo5VFVL_RLACkaw@mail.gmail.com>
 <2e3a3a3f-737c-ed01-f820-87efee0adc93@126.com> <9b227c9d-f59b-a8b0-b353-7876a56c0bde@126.com>
 <CAGsJ_4ynfvjXsr6QFBA_7Gzk3PaO1pk+6ErKZaNCt4H+nuwiJw@mail.gmail.com>
 <4482bf69-eb07-0ec9-f777-28ce40f96589@126.com> <CAGsJ_4ytYTpvRVgR1EoazsH=QxZCDE2e8H0BeXrY-6zWFD0kCg@mail.gmail.com>
 <69414410-4e2d-c04c-6fc3-9779f9377cf2@126.com> <CAGsJ_4xHpHVKwqcSFqRQ_DxsehNh0Wp=P-MTGA2b_iy=KUW1Bw@mail.gmail.com>
 <d082f7e0-cbb9-f21a-e08d-47b5abd9e91d@126.com> <b1b108d5-0008-4681-97cc-253992e18c3b@126.com>
In-Reply-To: <b1b108d5-0008-4681-97cc-253992e18c3b@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 19 Jun 2024 20:20:40 +1200
Message-ID: <CAGsJ_4xh3Bsd8RZ9v8Am=TmFWPfo_T4UVgptq4gVH9=QOHnDvw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Ge Yang <yangge1116@126.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:35=E2=80=AFPM Ge Yang <yangge1116@126.com> wrote:
>
>
>
> =E5=9C=A8 2024/6/18 15:51, yangge1116 =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2024/6/18 =E4=B8=8B=E5=8D=882:58, Barry Song =E5=86=99=E9=81=
=93:
> >> On Tue, Jun 18, 2024 at 6:56=E2=80=AFPM yangge1116 <yangge1116@126.com=
> wrote:
> >>>
> >>>
> >>>
> >>> =E5=9C=A8 2024/6/18 =E4=B8=8B=E5=8D=8812:10, Barry Song =E5=86=99=E9=
=81=93:
> >>>> On Tue, Jun 18, 2024 at 3:32=E2=80=AFPM yangge1116 <yangge1116@126.c=
om> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> =E5=9C=A8 2024/6/18 =E4=B8=8A=E5=8D=889:55, Barry Song =E5=86=99=E9=
=81=93:
> >>>>>> On Tue, Jun 18, 2024 at 9:36=E2=80=AFAM yangge1116 <yangge1116@126=
.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> =E5=9C=A8 2024/6/17 =E4=B8=8B=E5=8D=888:47, yangge1116 =E5=86=99=
=E9=81=93:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> =E5=9C=A8 2024/6/17 =E4=B8=8B=E5=8D=886:26, Barry Song =E5=86=99=
=E9=81=93:
> >>>>>>>>> On Tue, Jun 4, 2024 at 9:15=E2=80=AFPM <yangge1116@126.com> wro=
te:
> >>>>>>>>>>
> >>>>>>>>>> From: yangge <yangge1116@126.com>
> >>>>>>>>>>
> >>>>>>>>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP
> >>>>>>>>>> list for
> >>>>>>>>>> THP-sized allocations") no longer differentiates the migration
> >>>>>>>>>> type
> >>>>>>>>>> of pages in THP-sized PCP list, it's possible to get a CMA
> >>>>>>>>>> page from
> >>>>>>>>>> the list, in some cases, it's not acceptable, for example,
> >>>>>>>>>> allocating
> >>>>>>>>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
> >>>>>>>>>>
> >>>>>>>>>> The patch forbids allocating non-CMA THP-sized page from
> >>>>>>>>>> THP-sized
> >>>>>>>>>> PCP list to avoid the issue above.
> >>>>>>>>>
> >>>>>>>>> Could you please describe the impact on users in the commit log=
?
> >>>>>>>>
> >>>>>>>> If a large number of CMA memory are configured in the system (fo=
r
> >>>>>>>> example, the CMA memory accounts for 50% of the system memory),
> >>>>>>>> starting
> >>>>>>>> virtual machine with device passthrough will get stuck.
> >>>>>>>>
> >>>>>>>> During starting virtual machine, it will call
> >>>>>>>> pin_user_pages_remote(...,
> >>>>>>>> FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area,
> >>>>>>>> pin_user_pages_remote() will migrate the page from CMA area to
> >>>>>>>> non-CMA
> >>>>>>>> area because of FOLL_LONGTERM flag. If non-movable allocation
> >>>>>>>> requests
> >>>>>>>> return CMA memory, pin_user_pages_remote() will enter endless
> >>>>>>>> loops.
> >>>>>>>>
> >>>>>>>> backtrace:
> >>>>>>>> pin_user_pages_remote
> >>>>>>>> ----__gup_longterm_locked //cause endless loops in this function
> >>>>>>>> --------__get_user_pages_locked
> >>>>>>>> --------check_and_migrate_movable_pages //always check fail and
> >>>>>>>> continue
> >>>>>>>> to migrate
> >>>>>>>> ------------migrate_longterm_unpinnable_pages
> >>>>>>>> ----------------alloc_migration_target // non-movable allocation
> >>>>>>>>
> >>>>>>>>> Is it possible that some CMA memory might be used by non-movabl=
e
> >>>>>>>>> allocation requests?
> >>>>>>>>
> >>>>>>>> Yes.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> If so, will CMA somehow become unable to migrate, causing
> >>>>>>>>> cma_alloc()
> >>>>>>>>> to fail?
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> No, it will cause endless loops in __gup_longterm_locked(). If
> >>>>>>>> non-movable allocation requests return CMA memory,
> >>>>>>>> migrate_longterm_unpinnable_pages() will migrate a CMA page to
> >>>>>>>> another
> >>>>>>>> CMA page, which is useless and cause endless loops in
> >>>>>>>> __gup_longterm_locked().
> >>>>>>
> >>>>>> This is only one perspective. We also need to consider the impact =
on
> >>>>>> CMA itself. For example,
> >>>>>> when CMA is borrowed by THP, and we need to reclaim it through
> >>>>>> cma_alloc() or dma_alloc_coherent(),
> >>>>>> we must move those pages out to ensure CMA's users can retrieve th=
at
> >>>>>> contiguous memory.
> >>>>>>
> >>>>>> Currently, CMA's memory is occupied by non-movable pages, meaning =
we
> >>>>>> can't relocate them.
> >>>>>> As a result, cma_alloc() is more likely to fail.
> >>>>>>
> >>>>>>>>
> >>>>>>>> backtrace:
> >>>>>>>> pin_user_pages_remote
> >>>>>>>> ----__gup_longterm_locked //cause endless loops in this function
> >>>>>>>> --------__get_user_pages_locked
> >>>>>>>> --------check_and_migrate_movable_pages //always check fail and
> >>>>>>>> continue
> >>>>>>>> to migrate
> >>>>>>>> ------------migrate_longterm_unpinnable_pages
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>>>>>>>>> THP-sized allocations")
> >>>>>>>>>> Signed-off-by: yangge <yangge1116@126.com>
> >>>>>>>>>> ---
> >>>>>>>>>>      mm/page_alloc.c | 10 ++++++++++
> >>>>>>>>>>      1 file changed, 10 insertions(+)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>>>>>>>>> index 2e22ce5..0bdf471 100644
> >>>>>>>>>> --- a/mm/page_alloc.c
> >>>>>>>>>> +++ b/mm/page_alloc.c
> >>>>>>>>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
> >>>>>>>>>> *preferred_zone,
> >>>>>>>>>>             WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order
> >>>>>>>>>> > 1));
> >>>>>>>>>>
> >>>>>>>>>>             if (likely(pcp_allowed_order(order))) {
> >>>>>>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>>>>>>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags &
> >>>>>>>>>> ALLOC_CMA ||
> >>>>>>>>>> +                                               order !=3D
> >>>>>>>>>> HPAGE_PMD_ORDER) {
> >>>>>>>>>> +                       page =3D rmqueue_pcplist(preferred_zon=
e,
> >>>>>>>>>> zone,
> >>>>>>>>>> order,
> >>>>>>>>>> +                                               migratetype,
> >>>>>>>>>> alloc_flags);
> >>>>>>>>>> +                       if (likely(page))
> >>>>>>>>>> +                               goto out;
> >>>>>>>>>> +               }
> >>>>>>>>>
> >>>>>>>>> This seems not ideal, because non-CMA THP gets no chance to use
> >>>>>>>>> PCP.
> >>>>>>>>> But it
> >>>>>>>>> still seems better than causing the failure of CMA allocation.
> >>>>>>>>>
> >>>>>>>>> Is there a possible approach to avoiding adding CMA THP into
> >>>>>>>>> pcp from
> >>>>>>>>> the first
> >>>>>>>>> beginning? Otherwise, we might need a separate PCP for CMA.
> >>>>>>>>>
> >>>>>>>
> >>>>>>> The vast majority of THP-sized allocations are GFP_MOVABLE, avoid=
ing
> >>>>>>> adding CMA THP into pcp may incur a slight performance penalty.
> >>>>>>>
> >>>>>>
> >>>>>> But the majority of movable pages aren't CMA, right?
> >>>>>
> >>>>>> Do we have an estimate for
> >>>>>> adding back a CMA THP PCP? Will per_cpu_pages introduce a new
> >>>>>> cacheline, which
> >>>>>> the original intention for THP was to avoid by having only one
> >>>>>> PCP[1]?
> >>>>>>
> >>>>>> [1]
> >>>>>> https://patchwork.kernel.org/project/linux-mm/patch/20220624125423=
.6126-3-mgorman@techsingularity.net/
> >>>>>>
> >>>>>
> >>>>> The size of struct per_cpu_pages is 256 bytes in current code
> >>>>> containing
> >>>>> commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>>>> THP-sized
> >>>>> allocations").
> >>>>> crash> struct per_cpu_pages
> >>>>> struct per_cpu_pages {
> >>>>>        spinlock_t lock;
> >>>>>        int count;
> >>>>>        int high;
> >>>>>        int high_min;
> >>>>>        int high_max;
> >>>>>        int batch;
> >>>>>        u8 flags;
> >>>>>        u8 alloc_factor;
> >>>>>        u8 expire;
> >>>>>        short free_count;
> >>>>>        struct list_head lists[13];
> >>>>> }
> >>>>> SIZE: 256
> >>>>>
> >>>>> After revert commit 5d0a661d808f ("mm/page_alloc: use only one PCP
> >>>>> list
> >>>>> for THP-sized allocations"), the size of struct per_cpu_pages is
> >>>>> 272 bytes.
> >>>>> crash> struct per_cpu_pages
> >>>>> struct per_cpu_pages {
> >>>>>        spinlock_t lock;
> >>>>>        int count;
> >>>>>        int high;
> >>>>>        int high_min;
> >>>>>        int high_max;
> >>>>>        int batch;
> >>>>>        u8 flags;
> >>>>>        u8 alloc_factor;
> >>>>>        u8 expire;
> >>>>>        short free_count;
> >>>>>        struct list_head lists[15];
> >>>>> }
> >>>>> SIZE: 272
> >>>>>
> >>>>> Seems commit 5d0a661d808f ("mm/page_alloc: use only one PCP list fo=
r
> >>>>> THP-sized allocations") decrease one cacheline.
> >>>>
> >>>> the proposal is not reverting the patch but adding one CMA pcp.
> >>>> so it is "struct list_head lists[14]"; in this case, the size is sti=
ll
> >>>> 256?
> >>>>
> >>>
> >>> Yes, the size is still 256. If add one PCP list, we will have 2 PCP
> >>> lists for THP. One PCP list is used by MIGRATE_UNMOVABLE, and the oth=
er
> >>> PCP list is used by MIGRATE_MOVABLE and MIGRATE_RECLAIMABLE. Is that
> >>> right?
> >>
> >> i am not quite sure about MIGRATE_RECLAIMABLE as we want to
> >> CMA is only used by movable.
> >> So it might be:
> >> MOVABLE and NON-MOVABLE.
> >
> > One PCP list is used by UNMOVABLE pages, and the other PCP list is used
> > by MOVABLE pages, seems it is feasible. UNMOVABLE PCP list contains
> > MIGRATE_UNMOVABLE pages and MIGRATE_RECLAIMABLE pages, and MOVABLE PCP
> > list contains MIGRATE_MOVABLE pages.
> >
>
> Is the following modification feasiable?
>
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define NR_PCP_THP 1
> +#define NR_PCP_THP 2
> +#define PCP_THP_MOVABLE 0
> +#define PCP_THP_UNMOVABLE 1
>   #else
>   #define NR_PCP_THP 0
>   #endif
>
>   static inline unsigned int order_to_pindex(int migratetype, int order)
>   {
> +       int pcp_type =3D migratetype;
> +
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>          if (order > PAGE_ALLOC_COSTLY_ORDER) {
>                  VM_BUG_ON(order !=3D HPAGE_PMD_ORDER);
> -               return NR_LOWORDER_PCP_LISTS;
> +
> +               if (migratetype !=3D MIGRATE_MOVABLE)
> +                       pcp_type =3D PCP_THP_UNMOVABLE;
> +               else
> +                       pcp_type =3D PCP_THP_MOVABLE;
> +
> +               return NR_LOWORDER_PCP_LISTS + pcp_type;
>          }
>   #else
>          VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>   #endif
>
> -       return (MIGRATE_PCPTYPES * order) + migratetype;
> +       return (MIGRATE_PCPTYPES * order) + pcp_type;
>   }
>

a minimum change might be, then you can drop most new code.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 120a317d0938..cfe1e0625e38 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -588,6 +588,7 @@ static void bad_page(struct page *page, const char *rea=
son)

 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+       bool __maybe_unused movable;
 #ifdef CONFIG_CMA
        /*
         * We shouldn't get here for MIGRATE_CMA if those pages don't
@@ -600,7 +601,8 @@ static inline unsigned int order_to_pindex(int
migratetype, int order)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
        if (order > PAGE_ALLOC_COSTLY_ORDER) {
                VM_BUG_ON(order !=3D pageblock_order);
-               return NR_LOWORDER_PCP_LISTS;
+               movable =3D migratetype =3D=3D MIGRATE_MOVABLE;
+               return NR_LOWORDER_PCP_LISTS + movable;
        }
 #else
        VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);


>
>
> @@ -521,7 +529,7 @@ static inline int pindex_to_order(unsigned int pindex=
)
>          int order =3D pindex / MIGRATE_PCPTYPES;
>
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -       if (pindex =3D=3D NR_LOWORDER_PCP_LISTS)
> +       if (order > PAGE_ALLOC_COSTLY_ORDER)
>                  order =3D HPAGE_PMD_ORDER;
>   #else
>          VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>
>
>
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>> Commit 1d91df85f399 takes a similar approach to filter, and I mai=
nly
> >>>>>>> refer to it.
> >>>>>>>
> >>>>>>>
> >>>>>>>>>> +#else
> >>>>>>>>>>                     page =3D rmqueue_pcplist(preferred_zone,
> >>>>>>>>>> zone, order,
> >>>>>>>>>>                                            migratetype,
> >>>>>>>>>> alloc_flags);
> >>>>>>>>>>                     if (likely(page))
> >>>>>>>>>>                             goto out;
> >>>>>>>>>> +#endif
> >>>>>>>>>>             }
> >>>>>>>>>>
> >>>>>>>>>>             page =3D rmqueue_buddy(preferred_zone, zone, order=
,
> >>>>>>>>>> alloc_flags,
> >>>>>>>>>> --
> >>>>>>>>>> 2.7.4
> >>>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>> Barry
> >>>>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>
> >>>
>


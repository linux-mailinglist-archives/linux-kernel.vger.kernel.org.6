Return-Path: <linux-kernel+bounces-218716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A971090C48E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B023F1C21052
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D413C91C;
	Tue, 18 Jun 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0COYh7P"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719D73459
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693942; cv=none; b=HjDTaTLdQL8Vdds0RrzD2ke7JPFjDAXNlbmK7+kx7VaeuWQFef9IA6qcd1yCeCHzQi10eBTierZevLNxo2hhTwZF1xlKUK9vvzy9arqiIAEOsEjdCqtXcgG5wTYR37zWls4tpr96FBuVQJkpqfpMSZuKiqzl7LtKMEvc6Jl/Nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693942; c=relaxed/simple;
	bh=EdCDS6y0ryrJe0owVltoyJilJCpjHc1HDUTycsjv8G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah2Qel+Soo8/LKYnJTA/UA09taBFqXs9A+gIDwPtEz+sIK454Q4R8SC5Sa57IZMUJ2obVB5pzl2JRkjL3IfBBpm6QSzF5tE1pujtGY1L4cCO7gYlWBkFjOhUFKgtHsTlKJ1pSmdVwf375TkFXbcb8cV4ZVMmAxY8sHoOe5qUllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0COYh7P; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48c4268adfeso1717670137.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718693939; x=1719298739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2jjBp+8k+j2TWVQUReaXEDw6XqYxCZh6m2WzO1uqGw=;
        b=Q0COYh7PIHTRRLMB5MaRUN+QJ+u6gp0CdboeacjVVUdhzskZblL8OmPH5zoUwjxQl3
         HYwbHid+5v0l+x6ri8PfjpaOveRVSgktSz38lM9fU5UEpDGHQ9ItOMhzAxlxTLNWsAGa
         dHCNbyZhe1UeGPYm0rTzwmM0BgGXjtNTQtPVohNam6W1jOIjLIJvxPNcku0bVnKIdVo1
         xpEXDa4QwwXkLa1PDuqZDsUZD4sBmozQVVExslvBZwGAuHH84n9vSNuBMu3rJxkoNrE4
         TYTAScyeUKOq3nbfPzoARy/hy0Bv2MjDD+7KxGSgyUrwWAxlVx/nMOWuzEa1EGgGvggM
         OcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718693939; x=1719298739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2jjBp+8k+j2TWVQUReaXEDw6XqYxCZh6m2WzO1uqGw=;
        b=diNisCKXm0ytthMhp/N3yRR435NKX35wmEsBSkEnif4GHffnkUmVzwF0/dz28OeFct
         rHsL/10mM1IvJ9f0uCM3qYaxVhvploozgdnehHE76g2VO8h/0zUaKZMg3VPzDMMe+5Fv
         XNZ32VLUbqdUtI5jcPvaydUb7sh5/cGwKfJmFgOehDuVhR5ku3dIAC4Fj6wpkR6A4BNC
         nbqZ8UfHzUA18nlf4+tSg4TBocVYEcbiqaQwvKG3gdyUXsy/gb9PTjSVnyeWA8awDO5Y
         QbB36KTpXJ0QxQfbIWtTRqCWttUdnFzZ3rycAzAyKDl1UCrQdDlF03nTaGew4sJUQCE9
         AY9g==
X-Forwarded-Encrypted: i=1; AJvYcCU0unTe4gfcGrPP/SikNfq+2G8lKwM40RdLl3kscqrG1uRGb3kfHeoYfKyLYcYckoEtCEIzMekpPOUUn4JJ/j2LYhH5AxNuT9KhPGEZ
X-Gm-Message-State: AOJu0YzRQfQELt831preW9PbMz51znM9cLAF4HqiFURau3hLAiqx0Ss6
	JatnHUYWPqVhsocj1wVM5Z7cKl4DhdOTT5MjJ2CvbW/xPnsR1ZuOa5NS7iT3+E5RULJsogKTwfh
	qPSZ4EUrwZ4rp1wb96ZLxVrlHbV0=
X-Google-Smtp-Source: AGHT+IFmsnI6AMDsbfyONzno99n8eGEbPAuRjzCGNZ7yFklxYgmDfbiHJ40dch6XOkILknENdt18TDzSI1L3YFSqK9I=
X-Received: by 2002:a05:6102:94a:b0:48e:f039:19ee with SMTP id
 ada2fe7eead31-48ef0391a64mr6246905137.15.1718693939221; Mon, 17 Jun 2024
 23:58:59 -0700 (PDT)
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
 <69414410-4e2d-c04c-6fc3-9779f9377cf2@126.com>
In-Reply-To: <69414410-4e2d-c04c-6fc3-9779f9377cf2@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Jun 2024 18:58:47 +1200
Message-ID: <CAGsJ_4xHpHVKwqcSFqRQ_DxsehNh0Wp=P-MTGA2b_iy=KUW1Bw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: yangge1116 <yangge1116@126.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:56=E2=80=AFPM yangge1116 <yangge1116@126.com> wro=
te:
>
>
>
> =E5=9C=A8 2024/6/18 =E4=B8=8B=E5=8D=8812:10, Barry Song =E5=86=99=E9=81=
=93:
> > On Tue, Jun 18, 2024 at 3:32=E2=80=AFPM yangge1116 <yangge1116@126.com>=
 wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/6/18 =E4=B8=8A=E5=8D=889:55, Barry Song =E5=86=99=E9=81=
=93:
> >>> On Tue, Jun 18, 2024 at 9:36=E2=80=AFAM yangge1116 <yangge1116@126.co=
m> wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/6/17 =E4=B8=8B=E5=8D=888:47, yangge1116 =E5=86=99=E9=
=81=93:
> >>>>>
> >>>>>
> >>>>> =E5=9C=A8 2024/6/17 =E4=B8=8B=E5=8D=886:26, Barry Song =E5=86=99=E9=
=81=93:
> >>>>>> On Tue, Jun 4, 2024 at 9:15=E2=80=AFPM <yangge1116@126.com> wrote:
> >>>>>>>
> >>>>>>> From: yangge <yangge1116@126.com>
> >>>>>>>
> >>>>>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list =
for
> >>>>>>> THP-sized allocations") no longer differentiates the migration ty=
pe
> >>>>>>> of pages in THP-sized PCP list, it's possible to get a CMA page f=
rom
> >>>>>>> the list, in some cases, it's not acceptable, for example, alloca=
ting
> >>>>>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
> >>>>>>>
> >>>>>>> The patch forbids allocating non-CMA THP-sized page from THP-size=
d
> >>>>>>> PCP list to avoid the issue above.
> >>>>>>
> >>>>>> Could you please describe the impact on users in the commit log?
> >>>>>
> >>>>> If a large number of CMA memory are configured in the system (for
> >>>>> example, the CMA memory accounts for 50% of the system memory), sta=
rting
> >>>>> virtual machine with device passthrough will get stuck.
> >>>>>
> >>>>> During starting virtual machine, it will call pin_user_pages_remote=
(...,
> >>>>> FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area,
> >>>>> pin_user_pages_remote() will migrate the page from CMA area to non-=
CMA
> >>>>> area because of FOLL_LONGTERM flag. If non-movable allocation reque=
sts
> >>>>> return CMA memory, pin_user_pages_remote() will enter endless loops=
.
> >>>>>
> >>>>> backtrace:
> >>>>> pin_user_pages_remote
> >>>>> ----__gup_longterm_locked //cause endless loops in this function
> >>>>> --------__get_user_pages_locked
> >>>>> --------check_and_migrate_movable_pages //always check fail and con=
tinue
> >>>>> to migrate
> >>>>> ------------migrate_longterm_unpinnable_pages
> >>>>> ----------------alloc_migration_target // non-movable allocation
> >>>>>
> >>>>>> Is it possible that some CMA memory might be used by non-movable
> >>>>>> allocation requests?
> >>>>>
> >>>>> Yes.
> >>>>>
> >>>>>
> >>>>>> If so, will CMA somehow become unable to migrate, causing cma_allo=
c()
> >>>>>> to fail?
> >>>>>
> >>>>>
> >>>>> No, it will cause endless loops in __gup_longterm_locked(). If
> >>>>> non-movable allocation requests return CMA memory,
> >>>>> migrate_longterm_unpinnable_pages() will migrate a CMA page to anot=
her
> >>>>> CMA page, which is useless and cause endless loops in
> >>>>> __gup_longterm_locked().
> >>>
> >>> This is only one perspective. We also need to consider the impact on
> >>> CMA itself. For example,
> >>> when CMA is borrowed by THP, and we need to reclaim it through
> >>> cma_alloc() or dma_alloc_coherent(),
> >>> we must move those pages out to ensure CMA's users can retrieve that
> >>> contiguous memory.
> >>>
> >>> Currently, CMA's memory is occupied by non-movable pages, meaning we
> >>> can't relocate them.
> >>> As a result, cma_alloc() is more likely to fail.
> >>>
> >>>>>
> >>>>> backtrace:
> >>>>> pin_user_pages_remote
> >>>>> ----__gup_longterm_locked //cause endless loops in this function
> >>>>> --------__get_user_pages_locked
> >>>>> --------check_and_migrate_movable_pages //always check fail and con=
tinue
> >>>>> to migrate
> >>>>> ------------migrate_longterm_unpinnable_pages
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>>>
> >>>>>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>>>>>> THP-sized allocations")
> >>>>>>> Signed-off-by: yangge <yangge1116@126.com>
> >>>>>>> ---
> >>>>>>>     mm/page_alloc.c | 10 ++++++++++
> >>>>>>>     1 file changed, 10 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>>>>>> index 2e22ce5..0bdf471 100644
> >>>>>>> --- a/mm/page_alloc.c
> >>>>>>> +++ b/mm/page_alloc.c
> >>>>>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
> >>>>>>> *preferred_zone,
> >>>>>>>            WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1)=
);
> >>>>>>>
> >>>>>>>            if (likely(pcp_allowed_order(order))) {
> >>>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>>>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags &
> >>>>>>> ALLOC_CMA ||
> >>>>>>> +                                               order !=3D
> >>>>>>> HPAGE_PMD_ORDER) {
> >>>>>>> +                       page =3D rmqueue_pcplist(preferred_zone, =
zone,
> >>>>>>> order,
> >>>>>>> +                                               migratetype,
> >>>>>>> alloc_flags);
> >>>>>>> +                       if (likely(page))
> >>>>>>> +                               goto out;
> >>>>>>> +               }
> >>>>>>
> >>>>>> This seems not ideal, because non-CMA THP gets no chance to use PC=
P.
> >>>>>> But it
> >>>>>> still seems better than causing the failure of CMA allocation.
> >>>>>>
> >>>>>> Is there a possible approach to avoiding adding CMA THP into pcp f=
rom
> >>>>>> the first
> >>>>>> beginning? Otherwise, we might need a separate PCP for CMA.
> >>>>>>
> >>>>
> >>>> The vast majority of THP-sized allocations are GFP_MOVABLE, avoiding
> >>>> adding CMA THP into pcp may incur a slight performance penalty.
> >>>>
> >>>
> >>> But the majority of movable pages aren't CMA, right?
> >>
> >>> Do we have an estimate for
> >>> adding back a CMA THP PCP? Will per_cpu_pages introduce a new cacheli=
ne, which
> >>> the original intention for THP was to avoid by having only one PCP[1]=
?
> >>>
> >>> [1] https://patchwork.kernel.org/project/linux-mm/patch/2022062412542=
3.6126-3-mgorman@techsingularity.net/
> >>>
> >>
> >> The size of struct per_cpu_pages is 256 bytes in current code containi=
ng
> >> commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-siz=
ed
> >> allocations").
> >> crash> struct per_cpu_pages
> >> struct per_cpu_pages {
> >>       spinlock_t lock;
> >>       int count;
> >>       int high;
> >>       int high_min;
> >>       int high_max;
> >>       int batch;
> >>       u8 flags;
> >>       u8 alloc_factor;
> >>       u8 expire;
> >>       short free_count;
> >>       struct list_head lists[13];
> >> }
> >> SIZE: 256
> >>
> >> After revert commit 5d0a661d808f ("mm/page_alloc: use only one PCP lis=
t
> >> for THP-sized allocations"), the size of struct per_cpu_pages is 272 b=
ytes.
> >> crash> struct per_cpu_pages
> >> struct per_cpu_pages {
> >>       spinlock_t lock;
> >>       int count;
> >>       int high;
> >>       int high_min;
> >>       int high_max;
> >>       int batch;
> >>       u8 flags;
> >>       u8 alloc_factor;
> >>       u8 expire;
> >>       short free_count;
> >>       struct list_head lists[15];
> >> }
> >> SIZE: 272
> >>
> >> Seems commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >> THP-sized allocations") decrease one cacheline.
> >
> > the proposal is not reverting the patch but adding one CMA pcp.
> > so it is "struct list_head lists[14]"; in this case, the size is still
> > 256?
> >
>
> Yes, the size is still 256. If add one PCP list, we will have 2 PCP
> lists for THP. One PCP list is used by MIGRATE_UNMOVABLE, and the other
> PCP list is used by MIGRATE_MOVABLE and MIGRATE_RECLAIMABLE. Is that righ=
t?

i am not quite sure about MIGRATE_RECLAIMABLE as we want to
CMA is only used by movable.
So it might be:
MOVABLE and NON-MOVABLE.

>
> >
> >>
> >>>
> >>>> Commit 1d91df85f399 takes a similar approach to filter, and I mainly
> >>>> refer to it.
> >>>>
> >>>>
> >>>>>>> +#else
> >>>>>>>                    page =3D rmqueue_pcplist(preferred_zone, zone,=
 order,
> >>>>>>>                                           migratetype, alloc_flag=
s);
> >>>>>>>                    if (likely(page))
> >>>>>>>                            goto out;
> >>>>>>> +#endif
> >>>>>>>            }
> >>>>>>>
> >>>>>>>            page =3D rmqueue_buddy(preferred_zone, zone, order, al=
loc_flags,
> >>>>>>> --
> >>>>>>> 2.7.4
> >>>>>>
> >>>>>> Thanks
> >>>>>> Barry
> >>>>>>
> >>>>
> >>>>
> >>
>


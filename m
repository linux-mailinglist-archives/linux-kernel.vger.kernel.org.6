Return-Path: <linux-kernel+bounces-217251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587990AD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F69283C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A119538A;
	Mon, 17 Jun 2024 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/HahEGD"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA2195381
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625336; cv=none; b=CsghzD85MPht9kTII7L0emAJ2E6kMA+ksqCiOPYBkx3K9Bc3ucjxZqxC31ieE5/5qZu1vRp4r7N8P9kOBqC4HEpbNUys09aO9aRRWLCY5SmBGmrJrOUuiHVxSWYL2d7rRRo/hUqtPGla1m4YAjZi47p6TT37d003fTTjh3SRjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625336; c=relaxed/simple;
	bh=NffCHPh04kxLV1M+4sDkfZRGJ0KtbpqGWJtIcQ8WSyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMfZ4Cdf9Id1QXMEFVODbiIieYMfAzqBk9cHhRvjTl7O6bHCOvkdHKDn6FqnwvdaHGbDODefKwmzoa5pQf/yGOGnr+/weULut+VtH/mApgKC5UHdJYVbNJ3I9vF8L2DOKhyfayrmi0aMlSdYXuCbj/sMZ/pYXM+E8oFFAp8YRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/HahEGD; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80b8d0d19e8so1086276241.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718625334; x=1719230134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV8Tu4yudfofDqv7fDAng14xyMI6FIAAjDu0Vw4P4zQ=;
        b=J/HahEGDyl+QRvnTQhAyXZX5FJAZLg0XFwd9Adj703lSMOnEub2HivEXqHBo6OgEuK
         R8qlatYseEpH4gWKRJ68oCYMEIUz5CZOweTlaqyJIL+xfPv64M41a0DGeb3YniE6Q4Qa
         iEMjbtYUo8mYWgYw85TLw5i/IzjlWVzNyW96/XL1IHSeV62SK/YI98pJi4xH95+SbLmB
         kpcQI5c14D7wX63tF93v4QiO7I6AOAgOKqh3uu9LWIcAP6Phf3JRS5JF9/TsBBZWeaHy
         C687GyJv+3IO/hNcgOlGAmUsGmS5SGXBIDapgpJxsbyLB4apsT1Fb6c3grwa3jzAkmz2
         uJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625334; x=1719230134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV8Tu4yudfofDqv7fDAng14xyMI6FIAAjDu0Vw4P4zQ=;
        b=RiErH+VogbbKNPM4SHQz/5L/IuL32bpGPdoMoUw4GZ9REYtC0EtgWCxr9cFAtLseQF
         3XJR5yfyQCeyaMqz427DF+4FyVjca9uQOd5ADJZ0bX2fczOWkSawIu/q5DgQiudAfNXw
         nfXZyclIYyEFU3zRiFfGZuDJ8vt27TNJrHMrJWQnoNYuAzXJhOLOp8Fv+oaUHkt7g7/B
         YlAu40+xUKJUCKujFrj8PLeF1+hjNMjcOeexZPR9darQ3o4RK8hxEKw16B3pZAlYa9Gl
         YQFtMqysVJpnFjM3i0duLV3qDSbEH+xcdjbTdx6wlwfc7BuL311jTLT734B0sG4EkgL8
         u9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQIk019EbrnVGtqkQkdpApzY3njrbyTehz0BxNm2fY2hQQAJ+TEzEKTWDh3zXYVM3HjyzjDB6yiYUxxVeFxouCDLc1J2LxKU67St3
X-Gm-Message-State: AOJu0Yx3ioykT7j7LjryCpi6+oSNnIXl44BOwrR4ru9kmKdDCnGSqho7
	TQN49zSPLCo+n1ZwLPXgqaVZjumwlOSlWNo2XFc2K/pchISsd7dlGrCb2tat/Hc+gD1hzFk0oHC
	HVNVW7VUWOfv9gGxw+xHvWIiiCqU=
X-Google-Smtp-Source: AGHT+IEIyYlMDM5bd9lCVKySv9/fFUx+T5N0Y5Y7EVhWkghUKBG4aDI1IEd6aEgK4ezk3W516XFLIS5iH7N3r5dKZ7A=
X-Received: by 2002:a05:6102:3b85:b0:48d:bd49:1fe with SMTP id
 ada2fe7eead31-48dbd490291mr5131098137.1.1718625333769; Mon, 17 Jun 2024
 04:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com> <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
 <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com> <CAGsJ_4xgqDrTsQRYB_VKn+KC6rvYeJF6TQwhT5JnLi-b4nFTOQ@mail.gmail.com>
 <6dc8df31-eb01-4382-8467-c5510f75531e@linux.alibaba.com>
In-Reply-To: <6dc8df31-eb01-4382-8467-c5510f75531e@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 19:55:21 +0800
Message-ID: <CAGsJ_4zOOK0-AiLsN0Sw_q3ikPNuk8ofZHsYfV1WkK_6-QsmVw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: yangge1116 <yangge1116@126.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, liuzixing@hygon.cn, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:36=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/6/17 18:43, Barry Song wrote:
> > On Thu, Jun 6, 2024 at 3:07=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 2024/6/4 20:36, yangge1116 wrote:
> >>>
> >>>
> >>> =E5=9C=A8 2024/6/4 =E4=B8=8B=E5=8D=888:01, Baolin Wang =E5=86=99=E9=
=81=93:
> >>>> Cc Johannes, Zi and Vlastimil.
> >>>>
> >>>> On 2024/6/4 17:14, yangge1116@126.com wrote:
> >>>>> From: yangge <yangge1116@126.com>
> >>>>>
> >>>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list fo=
r
> >>>>> THP-sized allocations") no longer differentiates the migration type
> >>>>> of pages in THP-sized PCP list, it's possible to get a CMA page fro=
m
> >>>>> the list, in some cases, it's not acceptable, for example, allocati=
ng
> >>>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
> >>>>>
> >>>>> The patch forbids allocating non-CMA THP-sized page from THP-sized
> >>>>> PCP list to avoid the issue above.
> >>>>>
> >>>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>>>> THP-sized allocations")
> >>>>> Signed-off-by: yangge <yangge1116@126.com>
> >>>>> ---
> >>>>>    mm/page_alloc.c | 10 ++++++++++
> >>>>>    1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>>>> index 2e22ce5..0bdf471 100644
> >>>>> --- a/mm/page_alloc.c
> >>>>> +++ b/mm/page_alloc.c
> >>>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
> >>>>> *preferred_zone,
> >>>>>        WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> >>>>>        if (likely(pcp_allowed_order(order))) {
> >>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>> +        if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> >>>>> +                        order !=3D HPAGE_PMD_ORDER) {
> >>>>
> >>>> Seems you will also miss the non-CMA THP from the PCP, so I wonder i=
f
> >>>> we can add a migratetype comparison in __rmqueue_pcplist(), and if
> >>>> it's not suitable, then fallback to buddy?
> >>>
> >>> Yes, we may miss some non-CMA THPs in the PCP. But, if add a migratet=
ype
> >>> comparison in __rmqueue_pcplist(), we may need to compare many times
> >>> because of pcp batch.
> >>
> >> I mean we can only compare once, focusing on CMA pages.
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 3734fe7e67c0..960a3b5744d8 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -2973,6 +2973,11 @@ struct page *__rmqueue_pcplist(struct zone *zon=
e,
> >> unsigned int order,
> >>                   }
> >>
> >>                   page =3D list_first_entry(list, struct page, pcp_lis=
t);
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +               if (order =3D=3D HPAGE_PMD_ORDER &&
> >> !is_migrate_movable(migratetype) &&
> >> +                   is_migrate_cma(get_pageblock_migratetype(page)))
> >> +                       return NULL;
> >> +#endif
> >
> > This doesn't seem ideal either. It's possible that the PCP still has ma=
ny
> > non-CMA folios, but due to bad luck, the first entry is "always" CMA.
> > In this case,
> > allocations with is_migrate_movable(migratetype) =3D=3D false will alwa=
ys lose the
> > chance to use the PCP.   It also appears to incur a PCP spin lock/unloc=
k.
>
> Yes, just some ideas to to mitigate the issue...
>
> >
> > I don't see an ideal solution unless we bring back the CMA PCP :-)
>
> Tend to agree, and adding a CMA PCP seems the overhead can be acceptable?

yes. probably. Hi Ge,

Could we printk the size before and after adding 1 to NR_PCP_LISTS?
Does it increase one cacheline?

struct per_cpu_pages {
spinlock_t lock; /* Protects lists field */
int count; /* number of pages in the list */
int high; /* high watermark, emptying needed */
int high_min; /* min high watermark */
int high_max; /* max high watermark */
int batch; /* chunk size for buddy add/remove */
u8 flags; /* protected by pcp->lock */
u8 alloc_factor; /* batch scaling factor during allocate */
#ifdef CONFIG_NUMA
u8 expire; /* When 0, remote pagesets are drained */
#endif
short free_count; /* consecutive free count */

/* Lists of pages, one per migrate type stored on the pcp-lists */
struct list_head lists[NR_PCP_LISTS];
} ____cacheline_aligned_in_smp;


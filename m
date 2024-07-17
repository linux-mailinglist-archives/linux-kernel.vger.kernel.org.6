Return-Path: <linux-kernel+bounces-255372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33854933FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571A51C21845
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB76181BBD;
	Wed, 17 Jul 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhqXBuaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA2181BA0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230880; cv=none; b=nvKKpIrtg6yp2XQiz8pYruS2JbZscpGXf2T3Xorry2Ib9x7ILPa2+FWmR0wydYVgdL9MhuxMqU8NlpVS5kHNoSu0cA5TReR8j/50oVN9JL73lYRb02xPE1R2lPjCK2qCCip2TnokUXXYgxEeIVs9AXoATzvbsASE5EnmASBMks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230880; c=relaxed/simple;
	bh=EuMByBYI4GvVXdH3HAA8IPngULWSivXMEw1aCXbhPWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOyS/IRKirP5HDrcxy65I6OPWBSBi2y/cMXNw3bi++i3dfckM+YAOtLvch0BD7GnySBI1gXw6R53mEwwI3a15pI9X/5t+kb5DHL8c4h2zqVk59Rb9bQsmadHbKx13YSmXxyETMrEXVVfdqcUHUDahDsPiJ+jjcRrYxTTcMkS0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhqXBuaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7DAC4AF15
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721230880;
	bh=EuMByBYI4GvVXdH3HAA8IPngULWSivXMEw1aCXbhPWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AhqXBuaU9ZaJE1RYkUGN3nsTNQPDzpYnq3aWMZhJ0unuCKtrGFKARTS2SsoQpQApF
	 voycjubCBrHCuisCG1DKWRBaJasrLox+LYdf+x5Qv91Y/YjGsUP0SPi7ifRlLxFpGg
	 Dp3ojZDHxVwr49JeM9fOWXlzVmuv3PZqp66wooSIQyCux2po+X97aFt8L6yxUVa8bP
	 4807ApCuaQT7cqDaiCfDEAvc59Y07jUdVM+B0Mjdqvt0xOVi11u2HCcUD0WJD/dF+4
	 5l6ytrGBKMMk4Na7qvRkQgYCSmEn2m1/Yyn+SmDrCjmdSG8b2UNi7JQIL3u4HcS/Ja
	 oghWwrbnjMcaQ==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfdb6122992so5813289276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:41:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXms3+9E7/gtdRaSyV6z8QvXj638tahpPelp0+dFUlH46/kgwSL48byqcQsXDzAXl5zCA0gmPX9koxBXtprnjUxhhxi853dEp6EwuWJ
X-Gm-Message-State: AOJu0Yze4iaIU/xi+TSM5WsMSrQU94ORtD6b1YKJlmCVhu0qngP6QxBm
	29QSQssUijg5926AjHvDaDtjo7htVijIFr+UmBbU8GpZMfLz6ian4Mgkvbe970JQ7AQdtDX3LqG
	kwmpKydftQwz5Kb/DojGTk8VBxI4bMTmj5GgppA==
X-Google-Smtp-Source: AGHT+IE46+Y5BsCedo2Ch5l6lEGtIu7LVNdH0RIePa4eM3BT3zdt+a5EBe78MyU/25uykGBHZqqR/r45rzX/86gDDwM=
X-Received: by 2002:a05:6902:c0b:b0:dfe:4ab9:1cc1 with SMTP id
 3f1490d57ef6-e05ed796dcfmr2261823276.40.1721230879397; Wed, 17 Jul 2024
 08:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org> <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
 <CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com> <b4b31314-1125-40ee-b784-20abc78bd468@arm.com>
In-Reply-To: <b4b31314-1125-40ee-b784-20abc78bd468@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jul 2024 08:41:07 -0700
X-Gmail-Original-Message-ID: <CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
Message-ID: <CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 16/07/2024 23:46, Chris Li wrote:
> > On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 11/07/2024 08:29, Chris Li wrote:
> >>> Track the nonfull cluster as well as the empty cluster
> >>> on lists. Each order has one nonfull cluster list.
> >>>
> >>> The cluster will remember which order it was used during
> >>> new cluster allocation.
> >>>
> >>> When the cluster has free entry, add to the nonfull[order]
> >>> list.  When the free cluster list is empty, also allocate
> >>> from the nonempty list of that order.
> >>>
> >>> This improves the mTHP swap allocation success rate.
> >>>
> >>> There are limitations if the distribution of numbers of
> >>> different orders of mTHP changes a lot. e.g. there are a lot
> >>> of nonfull cluster assign to order A while later time there
> >>> are a lot of order B allocation while very little allocation
> >>> in order A. Currently the cluster used by order A will not
> >>> reused by order B unless the cluster is 100% empty.
> >>>
> >>> Signed-off-by: Chris Li <chrisl@kernel.org>
> >>> ---
> >>>  include/linux/swap.h |  4 ++++
> >>>  mm/swapfile.c        | 34 +++++++++++++++++++++++++++++++---
> >>>  2 files changed, 35 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> index e9be95468fc7..db8d6000c116 100644
> >>> --- a/include/linux/swap.h
> >>> +++ b/include/linux/swap.h
> >>> @@ -254,9 +254,11 @@ struct swap_cluster_info {
> >>>                                */
> >>>       u16 count;
> >>>       u8 flags;
> >>> +     u8 order;
> >>>       struct list_head list;
> >>>  };
> >>>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> >>> +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
> >>>
> >>>
> >>>  /*
> >>> @@ -296,6 +298,8 @@ struct swap_info_struct {
> >>>       unsigned long *zeromap;         /* vmalloc'ed bitmap to track z=
ero pages */
> >>>       struct swap_cluster_info *cluster_info; /* cluster info. Only f=
or SSD */
> >>>       struct list_head free_clusters; /* free clusters list */
> >>> +     struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> >>> +                                     /* list of cluster that contain=
s at least one free slot */
> >>>       unsigned int lowest_bit;        /* index of first free in swap_=
map */
> >>>       unsigned int highest_bit;       /* index of last free in swap_m=
ap */
> >>>       unsigned int pages;             /* total of usable pages of swa=
p */
> >>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>> index f70d25005d2c..e13a33664cfa 100644
> >>> --- a/mm/swapfile.c
> >>> +++ b/mm/swapfile.c
> >>> @@ -361,14 +361,21 @@ static void swap_cluster_schedule_discard(struc=
t swap_info_struct *si,
> >>>       memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >>>                       SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> >>>
> >>> -     list_add_tail(&ci->list, &si->discard_clusters);
> >>> +     if (ci->flags)
> >>
> >> I'm not sure this is future proof; what happens if a flag is added in =
future
> >> that does not indicate that the cluster is on a list. Perhaps explicit=
ly check
> >> CLUSTER_FLAG_NONFULL? Or `if (!list_empty(&ci->list))`.
> >
> > Currently flags are only used to track which list it is on.
>
> Yes, I get that it works correctly at the moment. I just don't think it's=
 wise
> for the code to assume that any flag being set means its on a list; that =
feels
> fragile for future.

ACK.

>
> > BTW, this
> > line has changed to check for explicite which list in patch 3 the big
> > rewrite. I can move that line change to patch 2 if you want.
>
> That would get my vote; let's make every patch as good as it can be.

Done.

>
> >
> >>
> >>> +             list_move_tail(&ci->list, &si->discard_clusters);
> >>> +     else
> >>> +             list_add_tail(&ci->list, &si->discard_clusters);
> >>> +     ci->flags =3D 0;
> >>
> >> Bug: (I think?) the cluster ends up on the discard_clusters list and
> >> swap_do_scheduled_discard() calls __free_cluster() which will then cal=
l
> >
> > swap_do_scheduled_discard() delete the entry from discard list.
>
> Ahh yes, my bad!
>
> > The flag does not track the discard list state.
> >
> >> list_add_tail() to put it on the free_clusters list. But since it is o=
n the
> >> discard_list at that point, shouldn't it call list_move_tail()?
> >
> > See above. Call list_move_tail() would be a mistake.
> >
> >>
> >>>       schedule_work(&si->discard_work);
> >>>  }
> >>>
> >>>  static void __free_cluster(struct swap_info_struct *si, struct swap_=
cluster_info *ci)
> >>>  {
> >>> +     if (ci->flags & CLUSTER_FLAG_NONFULL)
> >>> +             list_move_tail(&ci->list, &si->free_clusters);
> >>> +     else
> >>> +             list_add_tail(&ci->list, &si->free_clusters);
> >>>       ci->flags =3D CLUSTER_FLAG_FREE;
> >>> -     list_add_tail(&ci->list, &si->free_clusters);
> >>>  }
> >>>
> >>>  /*
> >>> @@ -491,7 +498,12 @@ static void dec_cluster_info_page(struct swap_in=
fo_struct *p, struct swap_cluste
> >>>       ci->count--;
> >>>
> >>>       if (!ci->count)
> >>> -             free_cluster(p, ci);
> >>> +             return free_cluster(p, ci);
> >>
> >> nit: I'm not sure what the kernel style guide says about this, but I'm=
 not a
> >> huge fan of returning void. I'd find it clearer if you just turn the b=
elow `if`
> >> into an `else if`.
> >
> > I try to avoid 'else if' if possible.
> > Changed to
> > if (!ci->count) {
> >               free_cluster(p, ci);
> >               return;
> > }
>
> ok
>
> >
> >>
> >>> +
> >>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> >>> +             list_add_tail(&ci->list, &p->nonfull_clusters[ci->order=
]);
> >>
> >> I find the transitions when you add and remove a cluster from the
> >> nonfull_clusters list a bit strange (if I've understood correctly): It=
 is added
> >> to the list whenever there is at least one free swap entry if not alre=
ady on the
> >> list. But you take it off the list when assigning it as the current cl=
uster for
> >> a cpu in scan_swap_map_try_ssd_cluster().
> >>
> >> So you could have this situation:
> >>
> >>   - cpuA allocs cluster from free list (exclusive to that cpu)
> >>   - cpuA allocs 1 swap entry from current cluster
> >>   - swap entry is freed; cluster added to nonfull_clusters
> >>   - cpuB "allocs" cluster from nonfull_clusters
> >>
> >> At this point both cpuA and cpuB share the same cluster as their curre=
nt
> >> cluster. So why not just put the cluster on the nonfull_clusters list =
at
> >> allocation time (when removed from free_list) and only remove it from =
the
> >
> > The big rewrite on patch 3 does that, taking it off the free list and
> > moving it into nonfull.
>
> Oh, from the title, "RFC: mm: swap: seperate SSD allocation from
> scan_swap_map_slots()" I assumed that was just a refactoring of the code =
to
> separate the SSD and HDD code paths. Personally I'd prefer to see the
> refactoring separated from behavioural changes.

It is not a refactoring. It is a big rewrite of the swap allocator
using the cluster. Behavior change is expected. The goal is completely
removing the brute force scanning of swap_map[] array for cluster swap
allocation.

>
> Since the patch was titled RFC and I thought it was just refactoring, I w=
as
> deferring review. But sounds like it is actually required to realize the =
test
> results quoted on the cover letter?

Yes, required because it handles the previous fall out case try_ssd()
failed. This big rewrite has gone through a lot of testing and bug
fix. It is pretty stable now. The only reason I keep it as RFC is
because it is not feature complete. Currently it does not do swap
cache reclaim. The next version will have swap cache reclaim and
remove the RFC.

>
> > I am only making the minimal change in this step so the big rewrite can=
 land.
> >
> >> nonfull_clusters list when it is completely full (or at least definite=
ly doesn't
> >> have room for an `order` allocation)? Then you allow "stealing" always=
 instead
> >> of just sometimes. You would likely want to move the cluster to the en=
d of the
> >> nonfull list when selecting it in scan_swap_map_try_ssd_cluster() to r=
educe the
> >> chances of multiple CPUs using the same cluster.
> >
> > For nonfull clusters it is less important to avoid multiple CPU
> > sharing the cluster. Because the cluster already has previous swap
> > entries allocated from the previous CPU.
>
> But if 2 CPUs have the same cluster, isn't there a pathalogical case wher=
e cpuA
> could be slightly ahead of cpuB so that cpuA allocates all the free pages=
 and

That happens to exist per cpu next pointer already. When the other CPU
advances to the next cluster pointer, it can cross with the other
CPU's next cluster pointer.

> cpuB just ends up scanning and finding nothing to allocate. I think do wa=
nt to
> share the cluster when you really need to, but try to avoid it if there a=
re
> other options, and I think moving the cluster to the end of the list migh=
t be a
> way to help that?

Simply moving to the end of the list can create a possible deadloop
when all clusters have been scanned and not available swap range
found.

We have tried many different approaches including moving to the end of
the list. It can cause more fragmentation because each CPU allocates
their swap slot cache (64 entries) from a different cluster.

> > Those behaviors will be fine
> > tuned after the patch 3 big rewrite. Try to make this patch simple.

Again, I want to keep it simple here so patch 3 can land.

> >> Another potential optimization (which was in my hacked version IIRC) i=
s to only
> >> add/remove from nonfull list when `total - count` crosses the (1 << or=
der)
> >> boundary rather than when becoming completely full. You definitely won=
't be able
> >> to allocate order-2 if there are only 3 pages available, for example.
> >
> > That is in patch 3 as well. This patch is just doing the bare minimum
> > to introduce the nonfull list.
> >
> >>
> >>> +             ci->flags |=3D CLUSTER_FLAG_NONFULL;
> >>> +     }
> >>>  }
> >>>
> >>>  /*
> >>> @@ -550,6 +562,18 @@ static bool scan_swap_map_try_ssd_cluster(struct=
 swap_info_struct *si,
> >>>       if (tmp =3D=3D SWAP_NEXT_INVALID) {
> >>>               if (!list_empty(&si->free_clusters)) {
> >>>                       ci =3D list_first_entry(&si->free_clusters, str=
uct swap_cluster_info, list);
> >>> +                     list_del(&ci->list);
> >>> +                     spin_lock(&ci->lock);
> >>> +                     ci->order =3D order;
> >>> +                     ci->flags =3D 0;
> >>> +                     spin_unlock(&ci->lock);
> >>> +                     tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTE=
R;
> >>> +             } else if (!list_empty(&si->nonfull_clusters[order])) {
> >>> +                     ci =3D list_first_entry(&si->nonfull_clusters[o=
rder], struct swap_cluster_info, list);
> >>> +                     list_del(&ci->list);
> >>> +                     spin_lock(&ci->lock);
> >>> +                     ci->flags =3D 0;
> >>> +                     spin_unlock(&ci->lock);
> >>>                       tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTE=
R;
> >>>               } else if (!list_empty(&si->discard_clusters)) {
> >>>                       /*
> >>> @@ -964,6 +988,7 @@ static void swap_free_cluster(struct swap_info_st=
ruct *si, unsigned long idx)
> >>>       ci =3D lock_cluster(si, offset);
> >>>       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >>>       ci->count =3D 0;
> >>> +     ci->order =3D 0;
> >>>       ci->flags =3D 0;
> >>
> >> Wonder if it would be better to put this in __free_cluster()?
> >
> > Both flags and order were moved to __free_cluster() in patch 3 of this
> > series. The order is best assigned together with flags when the
> > cluster changes the list.
> >
> > Thanks for the review. The patch 3 big rewrite is the heavy lifting.
>
> OK, but sounds like patch 3 isn't really RFC after all, but a crucial par=
t of
> the series? I'll try to take a look at it today.

Yes, it is the cluster swap allocator big rewrite.

Thank you for taking a look.

Chris


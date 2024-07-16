Return-Path: <linux-kernel+bounces-254528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA4933457
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6005B2174B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669713DB90;
	Tue, 16 Jul 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDL8I59d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744841B812
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721170007; cv=none; b=Lj95I62B3iYttwqvp8ntDW+Nq54wfyE6yFv3wRuCgTIwWIVG6gtQgEvGPJffo+7r3qAI3CYX7TwZSB61V7/sVP17qKeO0PemTx8tpPN/0R/88nIFf1Rq0z3uMNUX1oSmt4+bdE1MlWfcr3LvWEzDxKiFoPRASh9GrGTCzPvahXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721170007; c=relaxed/simple;
	bh=GA9SNgbQAkIoUb4fXSF3J9Gl1sMSuCtk8ODQx8kGpNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgSX8rTvfFR3KWTIAthokHlcKNQcMeHfgoC124jEq0b3oDSk1uLSKyphC3RKQhKn6+HMts5ZQy6MoATn6GrakqosAGdyk1wFjMx7Q0RZu50wGfvndv5PRbk57Lx2N5CcIAXQGIa5Tea3et93dYqO6MMYOd0Z6wVyytg0UauWmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDL8I59d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F306FC4AF0F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721170006;
	bh=GA9SNgbQAkIoUb4fXSF3J9Gl1sMSuCtk8ODQx8kGpNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DDL8I59dR/Y5Z8H4zGXdLQ8NVtkz/qfeF2FxrOvcQvGfuMgLoHUWjuFkBo4CWH5l5
	 mHSF9EoLkaF6AkVhbiGlJP5QjFqnPaKdYEBk8W1CZg5hCCOm+0g0jr9sIaCxVoC3A0
	 a1ORT5NZ7Uls+vr9w7iAqflYjSb75XJBBLpFdDHdYd2e5lX0qT4qArfMYxHkPiFaMq
	 MBi/UIovFtt0tc8m1CwDb9iCoDtI020S8nQ5iiVG1ztxVcf/3vefvR8tghm7H0cktu
	 /o+15MgLS2KbKzbADg4IJvJLHGn76KcTdEsQalUJxjElmnxGAyHHn+mXcNZ0qapjYW
	 74HSOiMCmxN/g==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66498fd4f91so4961807b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:46:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKM8A3ISA9haPP5zCvBM282wqdwHf83zHi+ahXeRnp5y05ZR7vtMtiJogBBwOM7Kdgt6fOrv3936zVdxT8ON0xF1AwPAQVKrQgppqJ
X-Gm-Message-State: AOJu0Yz1HTLcokXhuyAmYMb4LMxCI9ccO9I9Sa/qNqn/5xSPXsL9NkVD
	YZtbMne8LwRjrYe950ac/3Ao+uhdeYaPLw7kOgPWq6W3d4GvX+Z3KUabRwb0exDF+eHnggr7XSp
	m4ql74r187zhyXy1sllq5pjpg1ev6FwEi/SYv/w==
X-Google-Smtp-Source: AGHT+IGzlDUr83jT+R5TE01QYZtc+QLOCeCqPvcitOy/eeEH+W2VrT5O9Nvo9iItDmsJoO6h53iHxK80S7CFW/VqjB0=
X-Received: by 2002:a05:6902:c0c:b0:e05:616c:5e7f with SMTP id
 3f1490d57ef6-e05d56d2bd8mr5147694276.29.1721170005215; Tue, 16 Jul 2024
 15:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org> <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
In-Reply-To: <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Jul 2024 15:46:34 -0700
X-Gmail-Original-Message-ID: <CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
Message-ID: <CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/07/2024 08:29, Chris Li wrote:
> > Track the nonfull cluster as well as the empty cluster
> > on lists. Each order has one nonfull cluster list.
> >
> > The cluster will remember which order it was used during
> > new cluster allocation.
> >
> > When the cluster has free entry, add to the nonfull[order]
> > list.  When the free cluster list is empty, also allocate
> > from the nonempty list of that order.
> >
> > This improves the mTHP swap allocation success rate.
> >
> > There are limitations if the distribution of numbers of
> > different orders of mTHP changes a lot. e.g. there are a lot
> > of nonfull cluster assign to order A while later time there
> > are a lot of order B allocation while very little allocation
> > in order A. Currently the cluster used by order A will not
> > reused by order B unless the cluster is 100% empty.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> >  include/linux/swap.h |  4 ++++
> >  mm/swapfile.c        | 34 +++++++++++++++++++++++++++++++---
> >  2 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index e9be95468fc7..db8d6000c116 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -254,9 +254,11 @@ struct swap_cluster_info {
> >                                */
> >       u16 count;
> >       u8 flags;
> > +     u8 order;
> >       struct list_head list;
> >  };
> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> > +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
> >
> >
> >  /*
> > @@ -296,6 +298,8 @@ struct swap_info_struct {
> >       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zer=
o pages */
> >       struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
> >       struct list_head free_clusters; /* free clusters list */
> > +     struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> > +                                     /* list of cluster that contains =
at least one free slot */
> >       unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
> >       unsigned int highest_bit;       /* index of last free in swap_map=
 */
> >       unsigned int pages;             /* total of usable pages of swap =
*/
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index f70d25005d2c..e13a33664cfa 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -361,14 +361,21 @@ static void swap_cluster_schedule_discard(struct =
swap_info_struct *si,
> >       memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                       SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> >
> > -     list_add_tail(&ci->list, &si->discard_clusters);
> > +     if (ci->flags)
>
> I'm not sure this is future proof; what happens if a flag is added in fut=
ure
> that does not indicate that the cluster is on a list. Perhaps explicitly =
check
> CLUSTER_FLAG_NONFULL? Or `if (!list_empty(&ci->list))`.

Currently flags are only used to track which list it is on. BTW, this
line has changed to check for explicite which list in patch 3 the big
rewrite. I can move that line change to patch 2 if you want.

>
> > +             list_move_tail(&ci->list, &si->discard_clusters);
> > +     else
> > +             list_add_tail(&ci->list, &si->discard_clusters);
> > +     ci->flags =3D 0;
>
> Bug: (I think?) the cluster ends up on the discard_clusters list and
> swap_do_scheduled_discard() calls __free_cluster() which will then call

swap_do_scheduled_discard() delete the entry from discard list.
The flag does not track the discard list state.

> list_add_tail() to put it on the free_clusters list. But since it is on t=
he
> discard_list at that point, shouldn't it call list_move_tail()?

See above. Call list_move_tail() would be a mistake.

>
> >       schedule_work(&si->discard_work);
> >  }
> >
> >  static void __free_cluster(struct swap_info_struct *si, struct swap_cl=
uster_info *ci)
> >  {
> > +     if (ci->flags & CLUSTER_FLAG_NONFULL)
> > +             list_move_tail(&ci->list, &si->free_clusters);
> > +     else
> > +             list_add_tail(&ci->list, &si->free_clusters);
> >       ci->flags =3D CLUSTER_FLAG_FREE;
> > -     list_add_tail(&ci->list, &si->free_clusters);
> >  }
> >
> >  /*
> > @@ -491,7 +498,12 @@ static void dec_cluster_info_page(struct swap_info=
_struct *p, struct swap_cluste
> >       ci->count--;
> >
> >       if (!ci->count)
> > -             free_cluster(p, ci);
> > +             return free_cluster(p, ci);
>
> nit: I'm not sure what the kernel style guide says about this, but I'm no=
t a
> huge fan of returning void. I'd find it clearer if you just turn the belo=
w `if`
> into an `else if`.

I try to avoid 'else if' if possible.
Changed to
if (!ci->count) {
              free_cluster(p, ci);
              return;
}

>
> > +
> > +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> > +             list_add_tail(&ci->list, &p->nonfull_clusters[ci->order])=
;
>
> I find the transitions when you add and remove a cluster from the
> nonfull_clusters list a bit strange (if I've understood correctly): It is=
 added
> to the list whenever there is at least one free swap entry if not already=
 on the
> list. But you take it off the list when assigning it as the current clust=
er for
> a cpu in scan_swap_map_try_ssd_cluster().
>
> So you could have this situation:
>
>   - cpuA allocs cluster from free list (exclusive to that cpu)
>   - cpuA allocs 1 swap entry from current cluster
>   - swap entry is freed; cluster added to nonfull_clusters
>   - cpuB "allocs" cluster from nonfull_clusters
>
> At this point both cpuA and cpuB share the same cluster as their current
> cluster. So why not just put the cluster on the nonfull_clusters list at
> allocation time (when removed from free_list) and only remove it from the

The big rewrite on patch 3 does that, taking it off the free list and
moving it into nonfull.
I am only making the minimal change in this step so the big rewrite can lan=
d.

> nonfull_clusters list when it is completely full (or at least definitely =
doesn't
> have room for an `order` allocation)? Then you allow "stealing" always in=
stead
> of just sometimes. You would likely want to move the cluster to the end o=
f the
> nonfull list when selecting it in scan_swap_map_try_ssd_cluster() to redu=
ce the
> chances of multiple CPUs using the same cluster.

For nonfull clusters it is less important to avoid multiple CPU
sharing the cluster. Because the cluster already has previous swap
entries allocated from the previous CPU. Those behaviors will be fine
tuned after the patch 3 big rewrite. Try to make this patch simple.

> Another potential optimization (which was in my hacked version IIRC) is t=
o only
> add/remove from nonfull list when `total - count` crosses the (1 << order=
)
> boundary rather than when becoming completely full. You definitely won't =
be able
> to allocate order-2 if there are only 3 pages available, for example.

That is in patch 3 as well. This patch is just doing the bare minimum
to introduce the nonfull list.

>
> > +             ci->flags |=3D CLUSTER_FLAG_NONFULL;
> > +     }
> >  }
> >
> >  /*
> > @@ -550,6 +562,18 @@ static bool scan_swap_map_try_ssd_cluster(struct s=
wap_info_struct *si,
> >       if (tmp =3D=3D SWAP_NEXT_INVALID) {
> >               if (!list_empty(&si->free_clusters)) {
> >                       ci =3D list_first_entry(&si->free_clusters, struc=
t swap_cluster_info, list);
> > +                     list_del(&ci->list);
> > +                     spin_lock(&ci->lock);
> > +                     ci->order =3D order;
> > +                     ci->flags =3D 0;
> > +                     spin_unlock(&ci->lock);
> > +                     tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
> > +             } else if (!list_empty(&si->nonfull_clusters[order])) {
> > +                     ci =3D list_first_entry(&si->nonfull_clusters[ord=
er], struct swap_cluster_info, list);
> > +                     list_del(&ci->list);
> > +                     spin_lock(&ci->lock);
> > +                     ci->flags =3D 0;
> > +                     spin_unlock(&ci->lock);
> >                       tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
> >               } else if (!list_empty(&si->discard_clusters)) {
> >                       /*
> > @@ -964,6 +988,7 @@ static void swap_free_cluster(struct swap_info_stru=
ct *si, unsigned long idx)
> >       ci =3D lock_cluster(si, offset);
> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >       ci->count =3D 0;
> > +     ci->order =3D 0;
> >       ci->flags =3D 0;
>
> Wonder if it would be better to put this in __free_cluster()?

Both flags and order were moved to __free_cluster() in patch 3 of this
series. The order is best assigned together with flags when the
cluster changes the list.

Thanks for the review. The patch 3 big rewrite is the heavy lifting.

Chris


Return-Path: <linux-kernel+bounces-209304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EC90323D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C739F28129E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FBF171083;
	Tue, 11 Jun 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhoPF+nR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E717085D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086213; cv=none; b=GG+wybcmDcS2of4uijlWLRTlzYRtx6IeTjI0zYJZAC/+g3Fefn1c8V8wzHI/Ps9UXYcHl3baXMfZa8gqyKcWoRB7gwB+lx3A2Un1GVsNZKdjOLuUfCjZoQ91ytQmc6fPjZnsnILZhmJi9tHOAbe/ougPGi/fSOWhslR8GF0bfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086213; c=relaxed/simple;
	bh=Yuw99668wOEhPSThoprKdIPZsIWjDDEClOsSI4PigHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAR/hdRwPEeGTGcjqVPRm62tykUbpW8QY2wYxZxxxYXfBqugANCewvP6Tc2sYFiEppdvpwTUeGQCQ1QhAFLeKC3dsn9sxgOnQz900lqD8Kt368MKICd6v1r5p68GZqpFwjL5OQclVEZwcC0yRHeR+hzdP/nckvVeJyA1P9FUsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhoPF+nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88165C4AF49
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718086212;
	bh=Yuw99668wOEhPSThoprKdIPZsIWjDDEClOsSI4PigHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UhoPF+nRRgZZzSziqE0i+JjmcXcdR6t65t9nTFgGm76iOUbD/QrTbsSCQ/LFvY7BS
	 cSdF59/Y86mjG9qSmerbAONs76vPERL/WybrSkkpQm0CKEWdpipswKPgPGFxoB/aFO
	 MrvFj2RPn1vvjg0IINAoUkYtnFwZssb1OogZxuEFv6zgLdyQhWqvjSQ5mmUVHd3jHe
	 gGIA8b75bgAmJomndGFUyzGII991DnjrxBX7CleUi990KN61+dWfc2Uj2HPzBcXsXf
	 27ywXTBt0WtViMcSPL4P69v8h1J+BRcx9DX3pHRdHEHMDbG2RBT7HwuuTUeAyK1kCR
	 1EoA77L7NAsTw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebdfe26242so24110891fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0xxQGRdI+WlESqzKxqtWzZ3/S90tTSWJjtF6VD5ZagHzpxsDfbykOu/uPvbHsfJ1mMK+5nPn+TyHBQYVUqXgdpNknM18dgCtEMDQA
X-Gm-Message-State: AOJu0YzqNQVCgC1mCDfnNQIHO5sivqAFisQawbKv6uqNiY0EMzGNzRHW
	Ukix8d70MTHQmD8bgpvkIM+XjWhxHhYCDzEQPMJSf26DcCLlHb+Hr7Qan7is77lm11E8YjiNFQl
	95KpGh+hv0n1UvZ9u730d78QGYw==
X-Google-Smtp-Source: AGHT+IFbcrFF9hiNs/fzMAfI2BxdHr4afPhgmogiOngYT0ChBvCoIRUvhEQgMWRYs5pFh7LcScHoULkfbOokIW20FWA=
X-Received: by 2002:a2e:a410:0:b0:2eb:d77a:8508 with SMTP id
 38308e7fff4ca-2ebd77a88a0mr46229841fa.3.1718086211167; Mon, 10 Jun 2024
 23:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <20240524-swap-allocator-v1-2-47861b423b26@kernel.org> <edb439ea-4754-4d63-8d5f-edc116465d7b@arm.com>
 <CANeU7Q=uT-sZjwvcL4EJUbkZ8dbhnVpQEfNndMXvhBwZOSyr0Q@mail.gmail.com> <64a5020e-72cf-49f4-89d7-833cc7a12827@arm.com>
In-Reply-To: <64a5020e-72cf-49f4-89d7-833cc7a12827@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 10 Jun 2024 23:09:58 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=HB7xiePT98DHSP_brukhU6OQ9123xaaOmz+i6aFZ1wg@mail.gmail.com>
Message-ID: <CANeU7Q=HB7xiePT98DHSP_brukhU6OQ9123xaaOmz+i6aFZ1wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: swap: mTHP allocate swap entries from nonfull list
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 4:18=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 07/06/2024 21:52, Chris Li wrote:
> > On Fri, Jun 7, 2024 at 3:35=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> > Stealing other CPU's *current* cluster is not the intent. The intent
> > is after all current per-cpu done with this cluster(full), those full
> > clusters are not tracked by any per-cpu struct. When those full
> > clusters become non-full. Track it in the global nonfull cluster list.
> > The per-cpu allocation can take a cluster from that nonfull cluster
> > list and start allocating from it.
> >
> > The V1 code does not specifically check for the stealing behavior, the
> > V2 code will prevent that from happening. Basically each cluster has 4
> > states and owners:
> > 1) empty, owned by a global free cluster list.
> > 2) per cpu allocating. owned by per CPU current.
> > 3) nonfull (also non empty). own global nonfull list.
> > 4) full, currently not tracked, we can track it under global full list.
> >
> > When the per cpu runs out of free cluster, it can take a cluster from
> > 3) and move it to 2).
>
> OK, sorry for my misunderstanding, and thanks for the explanaiton. I've t=
aken a
> proper look at the patch and with this explanation now understand the int=
ent.
>
> I guess in effect, this is a scanning approach, but you are limiting the
> clusters that you scan to those that were originally allocated for the re=
quired
> order and which are known to have some free space.

Yes, not only some free space. When we swap in the same size as the
swap out size, we can have the cluster dedicated to that order. Avoid
mixing order in that cluster.

>
> I guess this will work more effectively with Barry's series that swaps in=
 a
> whole large folio in one go, because it is more likely that holes of the
> required size will appear in the non-full clusters. But previous discussi=
ons

Ack.

> concluded that it was not always going to be the right approach to swap-i=
n large
> folios in one go (certainly not for higer orders). So I don't think you c=
an

We need to start from somewhere. Right now it is still too early to
say which approach will win out. I think it is beneficial to try out
swapin the same size as swap out, and see how the data play out. 4K is
too small and 2M is too big. Maybe one of the mTHP size would be the
sweet spot.

> (yet) rely on swap slots being freed as order-sized blocks. That said I s=
till
> think that your approach should improve the situation even without Barry'=
s series.

Agree.

> In fact, why don't you put the cluster on the non-full list at cluster
> allocation time? Then you can also allow a cpu to steal from another cpu'=
s

That would be the reservation approach. If we know how much swap space
we want for that order in advance. We can make the reservation at swap
on time, then that order will only allocate from the reserved cluster.

> current cluster (as I initially thought you were doing). I think this sho=
uld

For stealing from other cpu's current order cluster, we can have a
global list of clusters for per_cpu[order] for the cluster. It's
better to track it separately as the other nonfull cluster. We only
steal from other CPU when we run out of global nonfull clusters. The
current patch allows stealing from other CPU as well. Just might
happen before it runs out of the nonfull cluster. Might not be too big
a deal.

> work with pretty much the same logic? And improve chances of allocation w=
ithout
> increasing chances of fragmentation? (more on this below).
>
> >
> >>
> >> If that's the intent, couldn't that be done just by iterating over the=
 per-cpu,
> >> per-order cluster pointers? Then you don't need all the linked list ch=
urn
> >
> > Again, that is not the intent.
> >
> >> (althogh I like the linked list changes as a nice cleanup, I'm not sur=
e the
> >> churn is neccessary for this change?). There would likely need to be s=
ome
> >> locking considerations, but it would also allow you to get access to t=
he next
> >> entry within the cluster for allocation.
> >>
> >> However, fundamentally, I don't think this change solves the problem; =
it just
> >> takes a bit longer before the allocation fails. The real problem is
> >> fragmentation due to freeing individual pages from swap entries at dif=
ferent times.
> >
> > It definitely helps to find nonfull clusters quicker. Please take a
> > look at my above comment and read the patch again.
> >
> >>
> >> Wouldn't it be better to just extend scanning to support high order al=
locations?
> >> Then we can steal a high order block from any cluster, even clusters t=
hat were
> >
> > Steal from higher order causes the higher order harder to allocate,
> > that is downside.
> > In my mind, ideally have some high order cluster reservation scheme so
> > the high order one doesn't mix with the low order one.
>
> Yes, that would make sense; you could limit the number of clusters alloca=
ted for
> each order at any given time.
>
> Order-0 stealing will still cause problems. You could probably just remov=
e that
> and limit order-0 scanning/stealing to clusters that were originally allo=
cated
> for order-0 too, using the same logic.

Yes, that is the plan.

If we reserve some space for higher order, then order-0 can't steal
from the reserved higher order cluster.

>
> >
> >> previously full, just like we currently do for order-0. Given we are a=
lready
> >> falling back to this path for order-0, I don't think it would be any m=
ore
> >> expensive; infact its less expensive because we only scan once for the=
 high
> >> order block, rather than scan for every split order-0 page.
> >>
> >> Of course that still doesn't solve the proplem entirely; if swap is so
> >> fragmented that there is no contiguous block of the required order the=
n you
> >> still have to fall back to splitting. As an extra optimization, you co=
uld store
> >
> > Exactly. That is why I think some high order cluster reservation
> > scheme is needed for a short term solution.
> > The change itself is not too complicated if we can agree on this approa=
ch.
> >
> >> the largest contiguous free space available in each cluster to avoid s=
canning in
> >> case its too small?
> >
> > Avoid scanning does just get to the non available high order result qui=
cker.
> > Does not seem to help increase the high order allocation success rate.
> >
> >>
> >>
> >>>
> >>> There are limitations if the distribution of numbers of
> >>> different orders of mTHP changes a lot. e.g. there are a lot
> >>> of nonfull cluster assign to order A while later time there
> >>> are a lot of order B allocation while very little allocation
> >>> in order A. Currently the cluster used by order A will not
> >>> reused by order B unless the cluster is 100% empty.
> >>>
> >>> This situation is best addressed by the longer term "swap
> >>> buddy allocator", in future patches.
> >>> ---
> >>>  include/linux/swap.h |  4 ++++
> >>>  mm/swapfile.c        | 25 +++++++++++++++++++++++--
> >>>  2 files changed, 27 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> index 0d3906eff3c9..1b7f0794b9bf 100644
> >>> --- a/include/linux/swap.h
> >>> +++ b/include/linux/swap.h
> >>> @@ -255,10 +255,12 @@ struct swap_cluster_info {
> >>>                                * cluster
> >>>                                */
> >>>       unsigned int count:16;
> >>> +     unsigned int order:8;
> >>>       unsigned int flags:8;
> >>>       struct list_head next;
> >>>  };
> >>>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> >>> +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
> >>>
> >>>
> >>>  /*
> >>> @@ -297,6 +299,8 @@ struct swap_info_struct {
> >>>       unsigned char *swap_map;        /* vmalloc'ed array of usage co=
unts */
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
> >>> index 205a60c5f9cb..51923aba500e 100644
> >>> --- a/mm/swapfile.c
> >>> +++ b/mm/swapfile.c
> >>> @@ -363,8 +363,11 @@ static void swap_cluster_schedule_discard(struct=
 swap_info_struct *si,
> >>>
> >>>  static void __free_cluster(struct swap_info_struct *si, struct swap_=
cluster_info *ci)
> >>>  {
> >>> +     if (ci->flags & CLUSTER_FLAG_NONFULL)
> >>> +             list_move_tail(&ci->next, &si->free_clusters);
> >>> +     else
> >>> +             list_add_tail(&ci->next, &si->free_clusters);
> >>>       ci->flags =3D CLUSTER_FLAG_FREE;
> >>> -     list_add_tail(&ci->next, &si->free_clusters);
> >>>  }
> >>>
> >>>  /*
> >>> @@ -486,7 +489,12 @@ static void dec_cluster_info_page(struct swap_in=
fo_struct *p, struct swap_cluste
> >>>       ci->count--;
> >>>
> >>>       if (!ci->count)
> >>> -             free_cluster(p, ci);
> >>> +             return free_cluster(p, ci);
> >>> +
> >>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> >>> +             list_add_tail(&ci->next, &p->nonfull_clusters[ci->order=
]);
> >>> +             ci->flags |=3D CLUSTER_FLAG_NONFULL;
> >>> +     }
> >>>  }
> >>>
> >>>  /*
> >>> @@ -547,6 +555,14 @@ static bool scan_swap_map_try_ssd_cluster(struct=
 swap_info_struct *si,
> >>>                       ci =3D list_first_entry(&si->free_clusters, str=
uct swap_cluster_info, next);
> >>>                       list_del(&ci->next);
> >>>                       spin_lock(&ci->lock);
> >>> +                     ci->order =3D order;
> >>> +                     ci->flags =3D 0;
> >>> +                     spin_unlock(&ci->lock);
> >>> +                     tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUS=
TER;
> >>> +             } else if (!list_empty(&si->nonfull_clusters[order])) {
>
> You are preferring to scan the nonfull clusters over doing discard and
> allocating a newly freed cluster; wouldn't it be better to prefer discard=
 over
> nonfull scanning?

My consideration is that issuing a discard command takes some IO time.
If we have an alternative path to move forward, e.g. using another
nonfull cluster, we should do that to avoid latency penalty.

>
> >>> +                     ci =3D list_first_entry(&si->nonfull_clusters[o=
rder], struct swap_cluster_info, next);
> >>> +                     list_del(&ci->next);
>
> I'm struggling a bit with what the value of the nonfull_clusters linked l=
ist is.

Assume we have the swap in size the same as swap out size. The
nonfull_clusters will get to the cluster in the desired order quicker.

> I wonder if it would be simpler to just track the number of free slots in=
 the
> cluster and iterate over the clusters, scanning the ones with the desired=
 order
> and which have at least (1 << order) free slots? I guess this list is giv=
ing you

That would be slower than this approach. We would likely repeatedly
scan over a lot of lower order clusters which can't find a big enough
free range. We can cache it and speed it up by avoiding repeat
scanning the unfitting cluster over and over again, that effectively
turns into a buddy allocator approach then. It can work but is more
complex.

> an ordering such that the cluster you pull off the list first had its fir=
st slot
> freed longest ago so it is most likely to have most space?

Yes, that is one of the considerations as well.

Chris


Return-Path: <linux-kernel+bounces-206742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B741E900D37
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC15D1C21203
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2B14E2FF;
	Fri,  7 Jun 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqYHaafS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED06155306
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793562; cv=none; b=RBjNr4b+V80HYTZQlhoWnGmBbLEqW2TodGLAQ6Y9E0M2lVo0Nu8qohLssoAzuMkqXtlVNFm3ey8iMFi3lxiqbsqH2LJDt9CjaTc0WrRoNG8iL7w1wxM0tsDtS8D6CaDwO1KcImsIxQ2iCGMLAcfKD+GqR4Z2anupSZacVULb28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793562; c=relaxed/simple;
	bh=BQd8RqE6IZSOpkmclld0hJT5agAAj8nejebKe2Iu0Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8D3FO1bLZbpFcUJEFSKTmNVfwrKWKlmREk22uOpDLM+PXqnIWldVFw1JCztALAmCn0nzzQRry3HC/QzkiVZdPi5GZyq6osdBFxOS8dv4+gBPXzB8JcCGIEkOPJv9ZI4MbVj9SbFmHiI0WmXT2BYsGMaVrTmjqaLofoMqs7MHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqYHaafS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0293C4AF09
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717793560;
	bh=BQd8RqE6IZSOpkmclld0hJT5agAAj8nejebKe2Iu0Hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WqYHaafSIYyUEg8cm3l1pzPcWlSAobp4YW9v78voQeKR/oYrnys0E4d4Jj45VxqiI
	 aoftDLxoQy76oouU6fzaVS3fXeq0bBX8IeUNGdF1FkMhKAj+3WPMRK50d9+SKcd6Xb
	 okTQ0H75VnYLSMxlnRT3qwE0y8ii75DelnJwgrF4KYX0wz/hQFWyRvaKntSKarYAsy
	 D0yEWN4VXmKtD4BWKjCuJoNBDi7EcXvtPtDaSEwfcjNFUutH48X2iq6i/cji1LHyhs
	 ZMaUXF0zIZ6zAQ7VTXR/uzTYsw2CmDKRjRguiQ2bk+9T57S/Wa7SKKnnR2H3gFmpPz
	 00X0VrDUNGpIA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e73441edf7so27498301fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:52:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgo58F1VCBQqqrkvTqgNr4ACOOVWvZKNOOCzxWoSYv3Ii/itJBTw9hwEaasv9CoVLHF6lnBByOQ/wH5KN48QYMkgNnpyt4Z62NThgo
X-Gm-Message-State: AOJu0YyrPxpYhIKtqYF9P8Zs/Frcn2NwfYcnVSTKH4iTBez2lIxO0q+o
	63iIU5v+i/syGUqSBHfnHmHJ46V1D0WzDnX8nZro451vByHXvi6Uwzw0QKgItcqJBJn11qNERc8
	3sXXcvxp0alCOB2OjfeiA9gViFQ==
X-Google-Smtp-Source: AGHT+IFFJg+gfdfADcrhnvLq8SOfK65V/VQUrBajLwy3wF5T77NloRFZYLbXzty6dFfPasKEaqjIRaHFEEJD5mddRq4=
X-Received: by 2002:a2e:93d6:0:b0:2ea:f719:318b with SMTP id
 38308e7fff4ca-2eaf7287cb8mr7198351fa.7.1717793559536; Fri, 07 Jun 2024
 13:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <20240524-swap-allocator-v1-2-47861b423b26@kernel.org> <edb439ea-4754-4d63-8d5f-edc116465d7b@arm.com>
In-Reply-To: <edb439ea-4754-4d63-8d5f-edc116465d7b@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 7 Jun 2024 13:52:27 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=uT-sZjwvcL4EJUbkZ8dbhnVpQEfNndMXvhBwZOSyr0Q@mail.gmail.com>
Message-ID: <CANeU7Q=uT-sZjwvcL4EJUbkZ8dbhnVpQEfNndMXvhBwZOSyr0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: swap: mTHP allocate swap entries from nonfull list
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 3:35=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 24/05/2024 18:17, Chris Li wrote:
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
>
> If I've understood correctly, the aim here is to link all the current per=
-cpu
> clusters for a given order together so that if a cpu can't allocate a new
> cluster for a given order, then it can steal another CPU's current cluste=
r for
> that order?

Stealing other CPU's *current* cluster is not the intent. The intent
is after all current per-cpu done with this cluster(full), those full
clusters are not tracked by any per-cpu struct. When those full
clusters become non-full. Track it in the global nonfull cluster list.
The per-cpu allocation can take a cluster from that nonfull cluster
list and start allocating from it.

The V1 code does not specifically check for the stealing behavior, the
V2 code will prevent that from happening. Basically each cluster has 4
states and owners:
1) empty, owned by a global free cluster list.
2) per cpu allocating. owned by per CPU current.
3) nonfull (also non empty). own global nonfull list.
4) full, currently not tracked, we can track it under global full list.

When the per cpu runs out of free cluster, it can take a cluster from
3) and move it to 2).

>
> If that's the intent, couldn't that be done just by iterating over the pe=
r-cpu,
> per-order cluster pointers? Then you don't need all the linked list churn

Again, that is not the intent.

> (althogh I like the linked list changes as a nice cleanup, I'm not sure t=
he
> churn is neccessary for this change?). There would likely need to be some
> locking considerations, but it would also allow you to get access to the =
next
> entry within the cluster for allocation.
>
> However, fundamentally, I don't think this change solves the problem; it =
just
> takes a bit longer before the allocation fails. The real problem is
> fragmentation due to freeing individual pages from swap entries at differ=
ent times.

It definitely helps to find nonfull clusters quicker. Please take a
look at my above comment and read the patch again.

>
> Wouldn't it be better to just extend scanning to support high order alloc=
ations?
> Then we can steal a high order block from any cluster, even clusters that=
 were

Steal from higher order causes the higher order harder to allocate,
that is downside.
In my mind, ideally have some high order cluster reservation scheme so
the high order one doesn't mix with the low order one.

> previously full, just like we currently do for order-0. Given we are alre=
ady
> falling back to this path for order-0, I don't think it would be any more
> expensive; infact its less expensive because we only scan once for the hi=
gh
> order block, rather than scan for every split order-0 page.
>
> Of course that still doesn't solve the proplem entirely; if swap is so
> fragmented that there is no contiguous block of the required order then y=
ou
> still have to fall back to splitting. As an extra optimization, you could=
 store

Exactly. That is why I think some high order cluster reservation
scheme is needed for a short term solution.
The change itself is not too complicated if we can agree on this approach.

> the largest contiguous free space available in each cluster to avoid scan=
ning in
> case its too small?

Avoid scanning does just get to the non available high order result quicker=
.
Does not seem to help increase the high order allocation success rate.

>
>
> >
> > There are limitations if the distribution of numbers of
> > different orders of mTHP changes a lot. e.g. there are a lot
> > of nonfull cluster assign to order A while later time there
> > are a lot of order B allocation while very little allocation
> > in order A. Currently the cluster used by order A will not
> > reused by order B unless the cluster is 100% empty.
> >
> > This situation is best addressed by the longer term "swap
> > buddy allocator", in future patches.
> > ---
> >  include/linux/swap.h |  4 ++++
> >  mm/swapfile.c        | 25 +++++++++++++++++++++++--
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 0d3906eff3c9..1b7f0794b9bf 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -255,10 +255,12 @@ struct swap_cluster_info {
> >                                * cluster
> >                                */
> >       unsigned int count:16;
> > +     unsigned int order:8;
> >       unsigned int flags:8;
> >       struct list_head next;
> >  };
> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> > +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
> >
> >
> >  /*
> > @@ -297,6 +299,8 @@ struct swap_info_struct {
> >       unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
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
> > index 205a60c5f9cb..51923aba500e 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -363,8 +363,11 @@ static void swap_cluster_schedule_discard(struct s=
wap_info_struct *si,
> >
> >  static void __free_cluster(struct swap_info_struct *si, struct swap_cl=
uster_info *ci)
> >  {
> > +     if (ci->flags & CLUSTER_FLAG_NONFULL)
> > +             list_move_tail(&ci->next, &si->free_clusters);
> > +     else
> > +             list_add_tail(&ci->next, &si->free_clusters);
> >       ci->flags =3D CLUSTER_FLAG_FREE;
> > -     list_add_tail(&ci->next, &si->free_clusters);
> >  }
> >
> >  /*
> > @@ -486,7 +489,12 @@ static void dec_cluster_info_page(struct swap_info=
_struct *p, struct swap_cluste
> >       ci->count--;
> >
> >       if (!ci->count)
> > -             free_cluster(p, ci);
> > +             return free_cluster(p, ci);
> > +
> > +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> > +             list_add_tail(&ci->next, &p->nonfull_clusters[ci->order])=
;
> > +             ci->flags |=3D CLUSTER_FLAG_NONFULL;
> > +     }
> >  }
> >
> >  /*
> > @@ -547,6 +555,14 @@ static bool scan_swap_map_try_ssd_cluster(struct s=
wap_info_struct *si,
> >                       ci =3D list_first_entry(&si->free_clusters, struc=
t swap_cluster_info, next);
> >                       list_del(&ci->next);
> >                       spin_lock(&ci->lock);
> > +                     ci->order =3D order;
> > +                     ci->flags =3D 0;
> > +                     spin_unlock(&ci->lock);
> > +                     tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
> > +             } else if (!list_empty(&si->nonfull_clusters[order])) {
> > +                     ci =3D list_first_entry(&si->nonfull_clusters[ord=
er], struct swap_cluster_info, next);
> > +                     list_del(&ci->next);
> > +                     spin_lock(&ci->lock);
> >                       ci->flags =3D 0;
> >                       spin_unlock(&ci->lock);
> >                       tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
>
> This looks wrong to me; if the cluster is on the nonfull list then it wil=
l have
> had some entries already allocated (by another cpu). So pointing tmp to t=
he
> first block in the cluster will never yield a free block. The cpu from wh=
ich you

I believe it will scan until it finds a free block with alignment down
in the offset < max loop.

while (offset < max) {
    if (swap_range_empty(si->swap_map, offset, nr_pages))
        break;
    offset +=3D nr_pages;
}

> are stealing the cluster stores the next free block location in its per-c=
pu
> structure. So perhaps iterating over the other cpu's `struct percpu_clust=
er`s is
> a better approach than the nonfull list?

No, stealing is not the intent. The intent is  quickly finding the non
full cluster NOT in other per cpu allocation.

>
> Additionally, this cluster will be stored back to this cpu's current clus=
ter at
> the bottom of the function. That may or may not be what you intended.

That is what I intended. It remembers the current allocating cluster,
in case this cluster has more than one high order swap entries.

Chris

>
> > @@ -578,6 +594,7 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
> >                               break;
> >                       tmp +=3D nr_pages;
> >               }
> > +             WARN_ONCE(ci->order !=3D order, "expecting order %d got %=
d", order, ci->order);
> >               unlock_cluster(ci);
> >       }
> >       if (tmp >=3D max) {
> > @@ -956,6 +973,7 @@ static void swap_free_cluster(struct swap_info_stru=
ct *si, unsigned long idx)
> >       ci =3D lock_cluster(si, offset);
> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >       ci->count =3D 0;
> > +     ci->order =3D 0;
> >       ci->flags =3D 0;
> >       free_cluster(si, ci);
> >       unlock_cluster(ci);
> > @@ -2882,6 +2900,9 @@ static int setup_swap_map_and_extents(struct swap=
_info_struct *p,
> >       INIT_LIST_HEAD(&p->free_clusters);
> >       INIT_LIST_HEAD(&p->discard_clusters);
> >
> > +     for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> > +             INIT_LIST_HEAD(&p->nonfull_clusters[i]);
> > +
> >       for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> >               unsigned int page_nr =3D swap_header->info.badpages[i];
> >               if (page_nr =3D=3D 0 || page_nr > swap_header->info.last_=
page)
> >
>


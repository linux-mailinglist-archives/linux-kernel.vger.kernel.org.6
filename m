Return-Path: <linux-kernel+bounces-254512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020DD93341B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8351F2184A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25813D502;
	Tue, 16 Jul 2024 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arnnlhzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEC1860
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167884; cv=none; b=KNi2vjCAVgOxybhh22rkUaL4owDXRKHkfd7fVSBkpciIPPRk9H3qC1aKaz7ijEuPq7eAxvxvA318x2FUauVY6VTK3sDzAHoYXgO+OwNDRZ6t1nfGe/TmitO24yamuCOYAEAiOwauJl1EEdep+QEjUdwDPcwiUfvrOId+J7y0/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167884; c=relaxed/simple;
	bh=jkit7lrj/eutSeJ8+YD6347YTfW6YZddsieqFSpQl2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umzhKXniWbwIigTg4y4Hsk6jgkgQ+hX7+I/fE9TaIvA2q3QmJi6m2oX3U0NIBjU3RWlmVAvFopAeLp0Sqy7EGy+x9abgNO+R0QOOHHLZd/8I2dNfJxox3plZqSl+GvxN0zt+0kuM5U9U/DHWijoyAW8jQfHPM4EOrs9ApRovGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arnnlhzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22500C116B1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721167884;
	bh=jkit7lrj/eutSeJ8+YD6347YTfW6YZddsieqFSpQl2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=arnnlhzoTfDZv+ZmtbGuzkVrb0WDDLIRq9D/Q/t6V4Nfe2orb0+1+qRWJfq/IgVRX
	 d0+O1oA32J9M8ck8dHyaQ6XH+QLxlxnsZeIIP8C3oIsfMZj7+K9U7KjfDZgEjhwzk8
	 8WtzDj5/q3EtkOxDxgVTXmtadF/yNkVbEdklmW9S3qttKhkkqeOmqY7t6trL18nRVb
	 /DYRueedHs9nGp7ccnEepXbKBB70O6P28qJyYBu2b1Yv6P49+FR1uRBteu5+fBTQPa
	 fGSDwqRoL6tKKLjEdj2FSS02pVICvSpuTHpVMueOedjaKUyqmOvqlITCC0cYPCTMuA
	 lIWuljocwSUtQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66493332ebfso4256187b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDmhQ3VnqJ477C01tyvSGwDsDH4YoLjuq80AX2fCVbLj7AXyk6Rs2Ge8lqB1uDiR96vfdlV8zIu3ZX3UMx1xNj25Gq5kBGsSUU0/EA
X-Gm-Message-State: AOJu0Yy3Frr6W/2ah2VIfvDCtu5dT1Vt2jE+aqRftwFVKMMnMkJDx8Bq
	wVzZ4wZLngc2fdimUss7W52aN77Yb1DpDfwVD9D5nh4KJMmppEW6gyZ1P0aM2TqFkwdayg6lRwR
	M5HeWZGhn9mNWVrblv+Azn5kXEDCGHc3xSVVW1w==
X-Google-Smtp-Source: AGHT+IE5Wx+roaRIRuClLNXY90CAgKhQytg4Kcc4N1f0NPra6AGhPeG6XcyXYGBcjcusnOsYhG1GHxEd/Ve0tXtpvfA=
X-Received: by 2002:a0d:de06:0:b0:63b:d055:6a7f with SMTP id
 00721157ae682-66380f17553mr37622527b3.38.1721167883266; Tue, 16 Jul 2024
 15:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-1-0295a4d4c7aa@kernel.org> <301b2399-a834-4c34-89cf-1425062c91ff@arm.com>
In-Reply-To: <301b2399-a834-4c34-89cf-1425062c91ff@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Jul 2024 15:11:11 -0700
X-Gmail-Original-Message-ID: <CACePvbX4F7QDjDzEsad4c_QVyxRRJf3W8LtQNP18GShtkv4q3A@mail.gmail.com>
Message-ID: <CACePvbX4F7QDjDzEsad4c_QVyxRRJf3W8LtQNP18GShtkv4q3A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: swap: swap cluster switch to double link list
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:57=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/07/2024 08:29, Chris Li wrote:
> > Previously, the swap cluster used a cluster index as a pointer
> > to construct a custom single link list type "swap_cluster_list".
> > The next cluster pointer is shared with the cluster->count.
> > It prevents puting the non free cluster into a list.
> >
> > Change the cluster to use the standard double link list instead.
> > This allows tracing the nonfull cluster in the follow up patch.
> > That way, it is faster to get to the nonfull cluster of that order.
> >
> > Remove the cluster getter/setter for accessing the cluster
> > struct member.
> >
> > The list operation is protected by the swap_info_struct->lock.
> >
> > Change cluster code to use "struct swap_cluster_info *" to
> > reference the cluster rather than by using index. That is more
> > consistent with the list manipulation. It avoids the repeat
> > adding index to the cluser_info. The code is easier to understand.
> >
> > Remove the cluster next pointer is NULL flag, the double link
> > list can handle the empty list pretty well.
> >
> > The "swap_cluster_info" struct is two pointer bigger, because
> > 512 swap entries share one swap struct, it has very little impact
> > on the average memory usage per swap entry. For 1TB swapfile, the
> > swap cluster data structure increases from 8MB to 24MB.
> >
> > Other than the list conversion, there is no real function change
> > in this patch.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> >  include/linux/swap.h |  26 +++---
> >  mm/swapfile.c        | 225 ++++++++++++++-----------------------------=
--------
> >  2 files changed, 70 insertions(+), 181 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index e473fe6cfb7a..e9be95468fc7 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -243,22 +243,21 @@ enum {
> >   * free clusters are organized into a list. We fetch an entry from the=
 list to
> >   * get a free cluster.
> >   *
> > - * The data field stores next cluster if the cluster is free or cluste=
r usage
> > - * counter otherwise. The flags field determines if a cluster is free.=
 This is
> > - * protected by swap_info_struct.lock.
> > + * The flags field determines if a cluster is free. This is
> > + * protected by cluster lock.
> >   */
> >  struct swap_cluster_info {
> >       spinlock_t lock;        /*
> >                                * Protect swap_cluster_info fields
> > -                              * and swap_info_struct->swap_map
> > -                              * elements correspond to the swap
> > -                              * cluster
> > +                              * other than list, and swap_info_struct-=
>swap_map
> > +                              * elements correspond to the swap cluste=
r.
>
> nit: correspond -> corresponding

Done.

>
> >                                */
> > -     unsigned int data:24;
> > -     unsigned int flags:8;
> > +     u16 count;
>
> Just to make sure I've understood correctly; count can safely be 16 bit (=
down
> from previous 24 bit) because the max it will ever be is the number of sw=
ap

Yes. The count does not need to point to a cluster index any more.
It just needs to hold whatever swap entries in the cluster.

> entries in the cluster, and that's currently no bigger than 512, and in f=
uture
> we wouldn't expect it to ever get bigger than 8192 (number of pages in PM=
D-order
> for arm64 64K base pages). 8192 is represented in 14 bits.

We can change the cluster bigger than the PMD order if we want to, we
just need to make sure the count can hold the number of swap entries
in a cluster.

>
> > +     u8 flags;
> > +     struct list_head list;
> >  };
> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster *=
/
> > +
>
> nit: why the blank line?

Good catch. Removed.

>
> >
> >  /*
> >   * The first page in the swap file is the swap header, which is always=
 marked
> > @@ -283,11 +282,6 @@ struct percpu_cluster {
> >       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
> >  };
> >
> > -struct swap_cluster_list {
> > -     struct swap_cluster_info head;
> > -     struct swap_cluster_info tail;
> > -};
> > -
> >  /*
> >   * The in-memory structure used to track swap areas.
> >   */
> > @@ -301,7 +295,7 @@ struct swap_info_struct {
> >       unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
> >       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zer=
o pages */
> >       struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
> > -     struct swap_cluster_list free_clusters; /* free clusters list */
> > +     struct list_head free_clusters; /* free clusters list */
> >       unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
> >       unsigned int highest_bit;       /* index of last free in swap_map=
 */
> >       unsigned int pages;             /* total of usable pages of swap =
*/
> > @@ -332,7 +326,7 @@ struct swap_info_struct {
> >                                        * list.
> >                                        */
> >       struct work_struct discard_work; /* discard worker */
> > -     struct swap_cluster_list discard_clusters; /* discard clusters li=
st */
> > +     struct list_head discard_clusters; /* discard clusters list */
> >       struct plist_node avail_lists[]; /*
> >                                          * entries in swap_avail_heads,=
 one
> >                                          * entry per node.
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index f7224bc1320c..f70d25005d2c 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -290,62 +290,15 @@ static void discard_swap_cluster(struct swap_info=
_struct *si,
> >  #endif
> >  #define LATENCY_LIMIT                256
> >
> > -static inline void cluster_set_flag(struct swap_cluster_info *info,
> > -     unsigned int flag)
> > -{
> > -     info->flags =3D flag;
> > -}
> > -
> > -static inline unsigned int cluster_count(struct swap_cluster_info *inf=
o)
> > -{
> > -     return info->data;
> > -}
> > -
> > -static inline void cluster_set_count(struct swap_cluster_info *info,
> > -                                  unsigned int c)
> > -{
> > -     info->data =3D c;
> > -}
> > -
> > -static inline void cluster_set_count_flag(struct swap_cluster_info *in=
fo,
> > -                                      unsigned int c, unsigned int f)
> > -{
> > -     info->flags =3D f;
> > -     info->data =3D c;
> > -}
> > -
> > -static inline unsigned int cluster_next(struct swap_cluster_info *info=
)
> > -{
> > -     return info->data;
> > -}
> > -
> > -static inline void cluster_set_next(struct swap_cluster_info *info,
> > -                                 unsigned int n)
> > -{
> > -     info->data =3D n;
> > -}
> > -
> > -static inline void cluster_set_next_flag(struct swap_cluster_info *inf=
o,
> > -                                      unsigned int n, unsigned int f)
> > -{
> > -     info->flags =3D f;
> > -     info->data =3D n;
> > -}
> > -
> >  static inline bool cluster_is_free(struct swap_cluster_info *info)
> >  {
> >       return info->flags & CLUSTER_FLAG_FREE;
> >  }
> >
> > -static inline bool cluster_is_null(struct swap_cluster_info *info)
> > -{
> > -     return info->flags & CLUSTER_FLAG_NEXT_NULL;
> > -}
> > -
> > -static inline void cluster_set_null(struct swap_cluster_info *info)
> > +static inline unsigned int cluster_index(struct swap_info_struct *si,
> > +                                      struct swap_cluster_info *ci)
> >  {
> > -     info->flags =3D CLUSTER_FLAG_NEXT_NULL;
> > -     info->data =3D 0;
> > +     return ci - si->cluster_info;
> >  }
> >
> >  static inline struct swap_cluster_info *lock_cluster(struct swap_info_=
struct *si,
> > @@ -394,65 +347,11 @@ static inline void unlock_cluster_or_swap_info(st=
ruct swap_info_struct *si,
> >               spin_unlock(&si->lock);
> >  }
> >
> > -static inline bool cluster_list_empty(struct swap_cluster_list *list)
> > -{
> > -     return cluster_is_null(&list->head);
> > -}
> > -
> > -static inline unsigned int cluster_list_first(struct swap_cluster_list=
 *list)
> > -{
> > -     return cluster_next(&list->head);
> > -}
> > -
> > -static void cluster_list_init(struct swap_cluster_list *list)
> > -{
> > -     cluster_set_null(&list->head);
> > -     cluster_set_null(&list->tail);
> > -}
> > -
> > -static void cluster_list_add_tail(struct swap_cluster_list *list,
> > -                               struct swap_cluster_info *ci,
> > -                               unsigned int idx)
> > -{
> > -     if (cluster_list_empty(list)) {
> > -             cluster_set_next_flag(&list->head, idx, 0);
> > -             cluster_set_next_flag(&list->tail, idx, 0);
> > -     } else {
> > -             struct swap_cluster_info *ci_tail;
> > -             unsigned int tail =3D cluster_next(&list->tail);
> > -
> > -             /*
> > -              * Nested cluster lock, but both cluster locks are
> > -              * only acquired when we held swap_info_struct->lock
> > -              */
> > -             ci_tail =3D ci + tail;
> > -             spin_lock_nested(&ci_tail->lock, SINGLE_DEPTH_NESTING);
>
> Just to confirm my understanding, there was never previously any list
> manipulation where the si->lock wasn't held, so this ensuring that both c=
lusters
> were locked for list manipulation was unnecessary? I don't see any extra =
places
> where you are taking si->lock, so I guess that must be the case (or your =
new
> regime is unsafe...).

Yes, and some of my later patch assertions on si->lock are taken on
those code paths.

The reason for change is that adding the cluster to the list head will
need to change more than just the current cluster. It will also change
the cluster before and after that. So the cluster->lock protecting the
cluster->list field can't be true any more. It is actually depending
on the si->lock to protect the list head.

>
> > -             cluster_set_next(ci_tail, idx);
> > -             spin_unlock(&ci_tail->lock);
> > -             cluster_set_next_flag(&list->tail, idx, 0);
> > -     }
> > -}
> > -
> > -static unsigned int cluster_list_del_first(struct swap_cluster_list *l=
ist,
> > -                                        struct swap_cluster_info *ci)
> > -{
> > -     unsigned int idx;
> > -
> > -     idx =3D cluster_next(&list->head);
> > -     if (cluster_next(&list->tail) =3D=3D idx) {
> > -             cluster_set_null(&list->head);
> > -             cluster_set_null(&list->tail);
> > -     } else
> > -             cluster_set_next_flag(&list->head,
> > -                                   cluster_next(&ci[idx]), 0);
> > -
> > -     return idx;
> > -}
> > -
> >  /* Add a cluster to discard list and schedule it to do discard */
> >  static void swap_cluster_schedule_discard(struct swap_info_struct *si,
> > -             unsigned int idx)
> > +             struct swap_cluster_info *ci)
> >  {
> > +     unsigned int idx =3D cluster_index(si, ci);
> >       /*
> >        * If scan_swap_map_slots() can't find a free cluster, it will ch=
eck
> >        * si->swap_map directly. To make sure the discarding cluster isn=
't
> > @@ -462,17 +361,14 @@ static void swap_cluster_schedule_discard(struct =
swap_info_struct *si,
> >       memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                       SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> >
> > -     cluster_list_add_tail(&si->discard_clusters, si->cluster_info, id=
x);
> > -
> > +     list_add_tail(&ci->list, &si->discard_clusters);
> >       schedule_work(&si->discard_work);
> >  }
> >
> > -static void __free_cluster(struct swap_info_struct *si, unsigned long =
idx)
> > +static void __free_cluster(struct swap_info_struct *si, struct swap_cl=
uster_info *ci)
> >  {
> > -     struct swap_cluster_info *ci =3D si->cluster_info;
> > -
> > -     cluster_set_flag(ci + idx, CLUSTER_FLAG_FREE);
> > -     cluster_list_add_tail(&si->free_clusters, ci, idx);
> > +     ci->flags =3D CLUSTER_FLAG_FREE;
> > +     list_add_tail(&ci->list, &si->free_clusters);
> >  }
> >
> >  /*
> > @@ -481,24 +377,25 @@ static void __free_cluster(struct swap_info_struc=
t *si, unsigned long idx)
> >  */
> >  static void swap_do_scheduled_discard(struct swap_info_struct *si)
> >  {
> > -     struct swap_cluster_info *info, *ci;
> > +     struct swap_cluster_info *ci;
> >       unsigned int idx;
> >
> > -     info =3D si->cluster_info;
> > -
> > -     while (!cluster_list_empty(&si->discard_clusters)) {
> > -             idx =3D cluster_list_del_first(&si->discard_clusters, inf=
o);
> > +     while (!list_empty(&si->discard_clusters)) {
> > +             ci =3D list_first_entry(&si->discard_clusters, struct swa=
p_cluster_info, list);
> > +             list_del(&ci->list);
> > +             idx =3D cluster_index(si, ci);
> >               spin_unlock(&si->lock);
> >
> >               discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
> >                               SWAPFILE_CLUSTER);
> >
> >               spin_lock(&si->lock);
> > -             ci =3D lock_cluster(si, idx * SWAPFILE_CLUSTER);
> > -             __free_cluster(si, idx);
> > +
> > +             spin_lock(&ci->lock);
> > +             __free_cluster(si, ci);
> >               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                               0, SWAPFILE_CLUSTER);
> > -             unlock_cluster(ci);
> > +             spin_unlock(&ci->lock);
> >       }
> >  }
> >
> > @@ -521,20 +418,20 @@ static void swap_users_ref_free(struct percpu_ref=
 *ref)
> >       complete(&si->comp);
> >  }
> >
> > -static void alloc_cluster(struct swap_info_struct *si, unsigned long i=
dx)
> > +static struct swap_cluster_info *alloc_cluster(struct swap_info_struct=
 *si, unsigned long idx)
> >  {
> > -     struct swap_cluster_info *ci =3D si->cluster_info;
> > +     struct swap_cluster_info *ci =3D list_first_entry(&si->free_clust=
ers, struct swap_cluster_info, list);
>
> nit: long line; consider separating the variable declaration and assignme=
nt?
Done.

>
> >
> > -     VM_BUG_ON(cluster_list_first(&si->free_clusters) !=3D idx);
> > -     cluster_list_del_first(&si->free_clusters, ci);
> > -     cluster_set_count_flag(ci + idx, 0, 0);
> > +     VM_BUG_ON(cluster_index(si, ci) !=3D idx);
> > +     list_del(&ci->list);
> > +     ci->count =3D 0;
> > +     ci->flags =3D 0;
> > +     return ci;
> >  }
> >
> > -static void free_cluster(struct swap_info_struct *si, unsigned long id=
x)
> > +static void free_cluster(struct swap_info_struct *si, struct swap_clus=
ter_info *ci)
> >  {
> > -     struct swap_cluster_info *ci =3D si->cluster_info + idx;
> > -
> > -     VM_BUG_ON(cluster_count(ci) !=3D 0);
> > +     VM_BUG_ON(ci->count !=3D 0);
> >       /*
> >        * If the swap is discardable, prepare discard the cluster
> >        * instead of free it immediately. The cluster will be freed
> > @@ -542,11 +439,11 @@ static void free_cluster(struct swap_info_struct =
*si, unsigned long idx)
> >        */
> >       if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) =3D=3D
> >           (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
> > -             swap_cluster_schedule_discard(si, idx);
> > +             swap_cluster_schedule_discard(si, ci);
> >               return;
> >       }
> >
> > -     __free_cluster(si, idx);
> > +     __free_cluster(si, ci);
> >  }
> >
> >  /*
> > @@ -559,15 +456,15 @@ static void add_cluster_info_page(struct swap_inf=
o_struct *p,
> >       unsigned long count)
> >  {
> >       unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> > +     struct swap_cluster_info *ci =3D cluster_info + idx;
> >
> >       if (!cluster_info)
> >               return;
> > -     if (cluster_is_free(&cluster_info[idx]))
> > +     if (cluster_is_free(ci))
> >               alloc_cluster(p, idx);
> >
> > -     VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CL=
USTER);
> > -     cluster_set_count(&cluster_info[idx],
> > -             cluster_count(&cluster_info[idx]) + count);
> > +     VM_BUG_ON(ci->count + count > SWAPFILE_CLUSTER);
> > +     ci->count +=3D count;
> >  }
> >
> >  /*
> > @@ -581,24 +478,20 @@ static void inc_cluster_info_page(struct swap_inf=
o_struct *p,
> >  }
> >
> >  /*
> > - * The cluster corresponding to page_nr decreases one usage. If the us=
age
> > - * counter becomes 0, which means no page in the cluster is in using, =
we can
> > - * optionally discard the cluster and add it to free cluster list.
> > + * The cluster ci decreases one usage. If the usage counter becomes 0,
> > + * which means no page in the cluster is in using, we can optionally d=
iscard
>
> nit: "in using" -> "in use"

Done. BTW, the "in using" in from the original code before my patch :-)

>
> > + * the cluster and add it to free cluster list.
> >   */
> > -static void dec_cluster_info_page(struct swap_info_struct *p,
> > -     struct swap_cluster_info *cluster_info, unsigned long page_nr)
> > +static void dec_cluster_info_page(struct swap_info_struct *p, struct s=
wap_cluster_info *ci)
> >  {
> > -     unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> > -
> > -     if (!cluster_info)
> > +     if (!p->cluster_info)
> >               return;
> >
> > -     VM_BUG_ON(cluster_count(&cluster_info[idx]) =3D=3D 0);
> > -     cluster_set_count(&cluster_info[idx],
> > -             cluster_count(&cluster_info[idx]) - 1);
> > +     VM_BUG_ON(ci->count =3D=3D 0);
> > +     ci->count--;
> >
> > -     if (cluster_count(&cluster_info[idx]) =3D=3D 0)
> > -             free_cluster(p, idx);
> > +     if (!ci->count)
> > +             free_cluster(p, ci);
> >  }
> >
> >  /*
> > @@ -611,10 +504,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_in=
fo_struct *si,
> >  {
> >       struct percpu_cluster *percpu_cluster;
> >       bool conflict;
> > -
> > +     struct swap_cluster_info *first =3D list_first_entry(&si->free_cl=
usters, struct swap_cluster_info, list);
>
> nit: long line; consider splitting variable declaration and assignment.

Done.

>
> nit: You're removed the blank line between variable declarations and stat=
ements;
> did you run checkpatch.pl?

Not yet. I will make sure I run it on the next revision. Thanks for
the reminder.

Chris


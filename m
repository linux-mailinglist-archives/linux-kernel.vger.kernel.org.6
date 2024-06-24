Return-Path: <linux-kernel+bounces-227536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEC9152EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C87D1C21F20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125519D094;
	Mon, 24 Jun 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtyj7RHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3721D53C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244372; cv=none; b=k/1b9MFWex2ttv8vkyfcI+bPrnQ9Z3cPkX1JhQ6U3TNuNh+T9KhdRYgrNrfMxPGz1BFqbT/Qgpp1/k+IQbZRpTRTumTCBDv6NgprY7UF1GgWXlkW9Y3dX0vAfYPT193/ULkJljKXLHex7RLJ5PAkMi0vXR0Gr8vuwaxyWHYr9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244372; c=relaxed/simple;
	bh=TQfopF/zrcGdwQcrzzrEq1eMSoXn+DsmazRq9ZGPLWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4FJ/IXyh3+cZru60g4qusyijhybZLOojkP7mq6llIqwh2QzOu200udTai6qdhXwnASPGI5DU7+FsFqYCd1EybXjJ1QQWqfTM5pzzv/L8u505L6wsUKONzeLnOayMuj3v3fLygNfsL4HI5zS5ks/+887fo8X+BQIKyIkpd1oJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtyj7RHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0C0C32789
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719244372;
	bh=TQfopF/zrcGdwQcrzzrEq1eMSoXn+DsmazRq9ZGPLWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dtyj7RHwWckbVLy+yUw1bX/OfxSAIoqC8dU19dwXv1nQA8hPF4dgHb0V6THJ9Qwz4
	 F4E6NJhNI8ChwGk38rC7Uqnh9dDP0TmdXrXl7ofnzEBsa6Nf+hQGk7J1iGuVxrUun+
	 kYrGp19I7/YzTgV+A+eWs8OqzJbUTYQ0BiJp3KjjWKmbkJMPG8VxlW6A5jc6vdihFF
	 mnsFEdLdrjiq1SGzXnKFgWetLsY3ahg/SFMM6oHF7Z9QPWbJO5TlVzo3Bng5fnlzAa
	 40Zn3org30u2QCJ1F/X7q1kv1t67XBcf+KAtI+52MleG1UdMkijyLOIDDxYOFblvfz
	 02k813kZYwtng==
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-376266a65c8so16821135ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0ztLTZ4CyjN3BQCN31yn9AkvslPtSDdFIJHphUI4ixtlR/dpcKviHzKGlIxHeBHbdHA/SoXa9QfVO5nw28mBUt4vSnWV46dtOaJpp
X-Gm-Message-State: AOJu0YxPeUEWYlgmnFAZSBM+jzqYzJMuXH58ksu2skQF/RlIIvALiLx4
	LQvKEfe5z5pHVauw9grQy1UxdYOgZT5v02JHFlQtQsccz4nD431XHsW8a/5B+6ZlT5JeqonEKMv
	Teq+L7lq5OqHguAhEwvLw2KNeFb/+mACCi6Y4
X-Google-Smtp-Source: AGHT+IEAcSX2aQzRshAnZJc/VUaZ9sWgamIba+2XZ9xhdtkNpxvs+vZuGEc8plS4wKPtR8o4Ft0SR5/SsXVBqF/8zFg=
X-Received: by 2002:a05:6e02:1d87:b0:375:dad7:a645 with SMTP id
 e9e14a558f8ab-3763f6c1fc8mr58122455ab.27.1719244371273; Mon, 24 Jun 2024
 08:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
 <20240619-swap-allocator-v3-1-e973a3102444@kernel.org> <87o77v0zn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuM+Zg=T9xqOdX-5MtVkcWE4AL7pyu0+=6DvPFBp7DgPLQ@mail.gmail.com> <87sex2zlux.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sex2zlux.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 24 Jun 2024 08:52:38 -0700
X-Gmail-Original-Message-ID: <CAF8kJuODzsG5iHw_XoatzyoBscXoJW_2GTZdbXMRWVbFRkiecA@mail.gmail.com>
Message-ID: <CAF8kJuODzsG5iHw_XoatzyoBscXoJW_2GTZdbXMRWVbFRkiecA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: swap: swap cluster switch to double link list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:18=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Thu, Jun 20, 2024 at 8:01=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > Previously, the swap cluster used a cluster index as a pointer
> >> > to construct a custom single link list type "swap_cluster_list".
> >> > The next cluster pointer is shared with the cluster->count.
> >> > It prevents puting the non free cluster into a list.
> >> >
> >> > Change the cluster to use the standard double link list instead.
> >> > This allows tracing the nonfull cluster in the follow up patch.
> >> > That way, it is faster to get to the nonfull cluster of that order.
> >> >
> >> > Remove the cluster getter/setter for accessing the cluster
> >> > struct member.
> >> >
> >> > The list operation is protected by the swap_info_struct->lock.
> >> >
> >> > Change cluster code to use "struct swap_cluster_info *" to
> >> > reference the cluster rather than by using index. That is more
> >> > consistent with the list manipulation. It avoids the repeat
> >> > adding index to the cluser_info. The code is easier to understand.
> >> >
> >> > Remove the cluster next pointer is NULL flag, the double link
> >> > list can handle the empty list pretty well.
> >> >
> >> > The "swap_cluster_info" struct is two pointer bigger, because
> >> > 512 swap entries share one swap struct, it has very little impact
> >> > on the average memory usage per swap entry. For 1TB swapfile, the
> >> > swap cluster data structure increases from 8MB to 24MB.
> >> >
> >> > Other than the list conversion, there is no real function change
> >> > in this patch.
> >> >
> >> > Signed-off-by: Chris Li <chrisl@kernel.org>
> >> > ---
> >> >  include/linux/swap.h |  26 +++---
> >> >  mm/swapfile.c        | 227 ++++++++++++++--------------------------=
-----------
> >> >  2 files changed, 70 insertions(+), 183 deletions(-)
> >> >
> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> > index 3df75d62a835..690a04f06674 100644
> >> > --- a/include/linux/swap.h
> >> > +++ b/include/linux/swap.h
> >> > @@ -243,22 +243,21 @@ enum {
> >> >   * free clusters are organized into a list. We fetch an entry from =
the list to
> >> >   * get a free cluster.
> >> >   *
> >> > - * The data field stores next cluster if the cluster is free or clu=
ster usage
> >> > - * counter otherwise. The flags field determines if a cluster is fr=
ee. This is
> >> > - * protected by swap_info_struct.lock.
> >> > + * The flags field determines if a cluster is free. This is
> >> > + * protected by cluster lock.
> >> >   */
> >> >  struct swap_cluster_info {
> >> >       spinlock_t lock;        /*
> >> >                                * Protect swap_cluster_info fields
> >> > -                              * and swap_info_struct->swap_map
> >> > -                              * elements correspond to the swap
> >> > -                              * cluster
> >> > +                              * other than list, and swap_info_stru=
ct->swap_map
> >> > +                              * elements correspond to the swap clu=
ster.
> >> >                                */
> >> > -     unsigned int data:24;
> >> > -     unsigned int flags:8;
> >> > +     u16 count;
> >> > +     u8 flags;
> >> > +     struct list_head list;
> >> >  };
> >> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> >> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluste=
r */
> >> > +
> >> >
> >> >  /*
> >> >   * The first page in the swap file is the swap header, which is alw=
ays marked
> >> > @@ -283,11 +282,6 @@ struct percpu_cluster {
> >> >       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation o=
ffset */
> >> >  };
> >> >
> >> > -struct swap_cluster_list {
> >> > -     struct swap_cluster_info head;
> >> > -     struct swap_cluster_info tail;
> >> > -};
> >> > -
> >> >  /*
> >> >   * The in-memory structure used to track swap areas.
> >> >   */
> >> > @@ -300,7 +294,7 @@ struct swap_info_struct {
> >> >       unsigned int    max;            /* extent of the swap_map */
> >> >       unsigned char *swap_map;        /* vmalloc'ed array of usage c=
ounts */
> >> >       struct swap_cluster_info *cluster_info; /* cluster info. Only =
for SSD */
> >> > -     struct swap_cluster_list free_clusters; /* free clusters list =
*/
> >> > +     struct list_head free_clusters; /* free clusters list */
> >> >       unsigned int lowest_bit;        /* index of first free in swap=
_map */
> >> >       unsigned int highest_bit;       /* index of last free in swap_=
map */
> >> >       unsigned int pages;             /* total of usable pages of sw=
ap */
> >> > @@ -331,7 +325,7 @@ struct swap_info_struct {
> >> >                                        * list.
> >> >                                        */
> >> >       struct work_struct discard_work; /* discard worker */
> >> > -     struct swap_cluster_list discard_clusters; /* discard clusters=
 list */
> >> > +     struct list_head discard_clusters; /* discard clusters list */
> >> >       struct plist_node avail_lists[]; /*
> >> >                                          * entries in swap_avail_hea=
ds, one
> >> >                                          * entry per node.
> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> > index 9c6d8e557c0f..0b11c437f9cc 100644
> >> > --- a/mm/swapfile.c
> >> > +++ b/mm/swapfile.c
> >> > @@ -290,64 +290,11 @@ static void discard_swap_cluster(struct swap_i=
nfo_struct *si,
> >> >  #endif
> >> >  #define LATENCY_LIMIT                256
> >> >
> >> > -static inline void cluster_set_flag(struct swap_cluster_info *info,
> >> > -     unsigned int flag)
> >> > -{
> >> > -     info->flags =3D flag;
> >> > -}
> >> > -
> >> > -static inline unsigned int cluster_count(struct swap_cluster_info *=
info)
> >> > -{
> >> > -     return info->data;
> >> > -}
> >> > -
> >> > -static inline void cluster_set_count(struct swap_cluster_info *info=
,
> >> > -                                  unsigned int c)
> >> > -{
> >> > -     info->data =3D c;
> >> > -}
> >> > -
> >> > -static inline void cluster_set_count_flag(struct swap_cluster_info =
*info,
> >> > -                                      unsigned int c, unsigned int =
f)
> >> > -{
> >> > -     info->flags =3D f;
> >> > -     info->data =3D c;
> >> > -}
> >> > -
> >> > -static inline unsigned int cluster_next(struct swap_cluster_info *i=
nfo)
> >> > -{
> >> > -     return info->data;
> >> > -}
> >> > -
> >> > -static inline void cluster_set_next(struct swap_cluster_info *info,
> >> > -                                 unsigned int n)
> >> > -{
> >> > -     info->data =3D n;
> >> > -}
> >> > -
> >> > -static inline void cluster_set_next_flag(struct swap_cluster_info *=
info,
> >> > -                                      unsigned int n, unsigned int =
f)
> >> > -{
> >> > -     info->flags =3D f;
> >> > -     info->data =3D n;
> >> > -}
> >> > -
> >> >  static inline bool cluster_is_free(struct swap_cluster_info *info)
> >> >  {
> >> >       return info->flags & CLUSTER_FLAG_FREE;
> >> >  }
> >> >
> >> > -static inline bool cluster_is_null(struct swap_cluster_info *info)
> >> > -{
> >> > -     return info->flags & CLUSTER_FLAG_NEXT_NULL;
> >> > -}
> >> > -
> >> > -static inline void cluster_set_null(struct swap_cluster_info *info)
> >> > -{
> >> > -     info->flags =3D CLUSTER_FLAG_NEXT_NULL;
> >> > -     info->data =3D 0;
> >> > -}
> >> > -
> >> >  static inline struct swap_cluster_info *lock_cluster(struct swap_in=
fo_struct *si,
> >> >                                                    unsigned long off=
set)
> >> >  {
> >> > @@ -394,65 +341,11 @@ static inline void unlock_cluster_or_swap_info=
(struct swap_info_struct *si,
> >> >               spin_unlock(&si->lock);
> >> >  }
> >> >
> >> > -static inline bool cluster_list_empty(struct swap_cluster_list *lis=
t)
> >> > -{
> >> > -     return cluster_is_null(&list->head);
> >> > -}
> >> > -
> >> > -static inline unsigned int cluster_list_first(struct swap_cluster_l=
ist *list)
> >> > -{
> >> > -     return cluster_next(&list->head);
> >> > -}
> >> > -
> >> > -static void cluster_list_init(struct swap_cluster_list *list)
> >> > -{
> >> > -     cluster_set_null(&list->head);
> >> > -     cluster_set_null(&list->tail);
> >> > -}
> >> > -
> >> > -static void cluster_list_add_tail(struct swap_cluster_list *list,
> >> > -                               struct swap_cluster_info *ci,
> >> > -                               unsigned int idx)
> >> > -{
> >> > -     if (cluster_list_empty(list)) {
> >> > -             cluster_set_next_flag(&list->head, idx, 0);
> >> > -             cluster_set_next_flag(&list->tail, idx, 0);
> >> > -     } else {
> >> > -             struct swap_cluster_info *ci_tail;
> >> > -             unsigned int tail =3D cluster_next(&list->tail);
> >> > -
> >> > -             /*
> >> > -              * Nested cluster lock, but both cluster locks are
> >> > -              * only acquired when we held swap_info_struct->lock
> >> > -              */
> >> > -             ci_tail =3D ci + tail;
> >> > -             spin_lock_nested(&ci_tail->lock, SINGLE_DEPTH_NESTING)=
;
> >> > -             cluster_set_next(ci_tail, idx);
> >> > -             spin_unlock(&ci_tail->lock);
> >> > -             cluster_set_next_flag(&list->tail, idx, 0);
> >> > -     }
> >> > -}
> >> > -
> >> > -static unsigned int cluster_list_del_first(struct swap_cluster_list=
 *list,
> >> > -                                        struct swap_cluster_info *c=
i)
> >> > -{
> >> > -     unsigned int idx;
> >> > -
> >> > -     idx =3D cluster_next(&list->head);
> >> > -     if (cluster_next(&list->tail) =3D=3D idx) {
> >> > -             cluster_set_null(&list->head);
> >> > -             cluster_set_null(&list->tail);
> >> > -     } else
> >> > -             cluster_set_next_flag(&list->head,
> >> > -                                   cluster_next(&ci[idx]), 0);
> >> > -
> >> > -     return idx;
> >> > -}
> >> > -
> >> >  /* Add a cluster to discard list and schedule it to do discard */
> >> >  static void swap_cluster_schedule_discard(struct swap_info_struct *=
si,
> >> > -             unsigned int idx)
> >> > +             struct swap_cluster_info *ci)
> >> >  {
> >> > +     unsigned int idx =3D ci - si->cluster_info;
> >>
> >> IIRC, we have reached consensus that we will add a helper for this
> >> pattern.
> >
> > Yes, sorry about that. When I drop the V2 fixup branch, I forget to upd=
ate that.
> >
> >
> >>
> >> > -     while (!cluster_list_empty(&si->discard_clusters)) {
> >> > -             idx =3D cluster_list_del_first(&si->discard_clusters, =
info);
> >> > +     while (!list_empty(&si->discard_clusters)) {
> >> > +             ci =3D list_first_entry(&si->discard_clusters, struct =
swap_cluster_info, list);
> >> > +             list_del(&ci->list);
> >> > +             idx =3D ci - si->cluster_info;
> >> >               spin_unlock(&si->lock);
> >> >
> >> >               discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
> >> >                               SWAPFILE_CLUSTER);
> >> >
> >> >               spin_lock(&si->lock);
> >> > -             ci =3D lock_cluster(si, idx * SWAPFILE_CLUSTER);
> >> > -             __free_cluster(si, idx);
> >> > +
> >> > +             spin_lock(&ci->lock);
> >>
> >> If you really don't like lock_cluster(), please replace unlock_cluster=
()
> >> below with spin_unlock() too.
> >>
> >
> > Done. Switch to spin_unlock().
> >
> >
> >
> >> > +             __free_cluster(si, ci);
> >> >               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >> >                               0, SWAPFILE_CLUSTER);
> >> >               unlock_cluster(ci);
> >> > @@ -521,20 +412,20 @@ static void swap_users_ref_free(struct percpu_=
ref *ref)
> >> >       complete(&si->comp);
> >> >  }
> >> >
> >> > -static void alloc_cluster(struct swap_info_struct *si, unsigned lon=
g idx)
> >> > +static struct swap_cluster_info *alloc_cluster(struct swap_info_str=
uct *si, unsigned long idx)
> >> >  {
> >> > -     struct swap_cluster_info *ci =3D si->cluster_info;
> >> > +     struct swap_cluster_info *ci =3D list_first_entry(&si->free_cl=
usters, struct swap_cluster_info, list);
> >> >
> >> > -     VM_BUG_ON(cluster_list_first(&si->free_clusters) !=3D idx);
> >> > -     cluster_list_del_first(&si->free_clusters, ci);
> >> > -     cluster_set_count_flag(ci + idx, 0, 0);
> >> > +     VM_BUG_ON(ci - si->cluster_info !=3D idx);
> >> > +     list_del(&ci->list);
> >> > +     ci->count =3D 0;
> >> > +     ci->flags =3D 0;
> >> > +     return ci;
> >> >  }
> >> >
> >> > -static void free_cluster(struct swap_info_struct *si, unsigned long=
 idx)
> >> > +static void free_cluster(struct swap_info_struct *si, struct swap_c=
luster_info *ci)
> >> >  {
> >> > -     struct swap_cluster_info *ci =3D si->cluster_info + idx;
> >> > -
> >> > -     VM_BUG_ON(cluster_count(ci) !=3D 0);
> >> > +     VM_BUG_ON(ci->count !=3D 0);
> >> >       /*
> >> >        * If the swap is discardable, prepare discard the cluster
> >> >        * instead of free it immediately. The cluster will be freed
> >> > @@ -542,11 +433,11 @@ static void free_cluster(struct swap_info_stru=
ct *si, unsigned long idx)
> >> >        */
> >> >       if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) =3D=3D
> >> >           (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
> >> > -             swap_cluster_schedule_discard(si, idx);
> >> > +             swap_cluster_schedule_discard(si, ci);
> >> >               return;
> >> >       }
> >> >
> >> > -     __free_cluster(si, idx);
> >> > +     __free_cluster(si, ci);
> >> >  }
> >> >
> >> >  /*
> >> > @@ -559,15 +450,15 @@ static void add_cluster_info_page(struct swap_=
info_struct *p,
> >> >       unsigned long count)
> >> >  {
> >> >       unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> >> > +     struct swap_cluster_info *ci =3D cluster_info + idx;
> >> >
> >> >       if (!cluster_info)
> >> >               return;
> >> > -     if (cluster_is_free(&cluster_info[idx]))
> >> > +     if (cluster_is_free(ci))
> >> >               alloc_cluster(p, idx);
> >> >
> >> > -     VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE=
_CLUSTER);
> >> > -     cluster_set_count(&cluster_info[idx],
> >> > -             cluster_count(&cluster_info[idx]) + count);
> >> > +     VM_BUG_ON(ci->count + count > SWAPFILE_CLUSTER);
> >> > +     ci->count +=3D count;
> >> >  }
> >> >
> >> >  /*
> >> > @@ -581,24 +472,20 @@ static void inc_cluster_info_page(struct swap_=
info_struct *p,
> >> >  }
> >> >
> >> >  /*
> >> > - * The cluster corresponding to page_nr decreases one usage. If the=
 usage
> >> > - * counter becomes 0, which means no page in the cluster is in usin=
g, we can
> >> > - * optionally discard the cluster and add it to free cluster list.
> >> > + * The cluster ci decreases one usage. If the usage counter becomes=
 0,
> >> > + * which means no page in the cluster is in using, we can optionall=
y discard
> >> > + * the cluster and add it to free cluster list.
> >> >   */
> >> > -static void dec_cluster_info_page(struct swap_info_struct *p,
> >> > -     struct swap_cluster_info *cluster_info, unsigned long page_nr)
> >> > +static void dec_cluster_info_page(struct swap_info_struct *p, struc=
t swap_cluster_info *ci)
> >> >  {
> >> > -     unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> >> > -
> >> > -     if (!cluster_info)
> >> > +     if (!p->cluster_info)
> >> >               return;
> >> >
> >> > -     VM_BUG_ON(cluster_count(&cluster_info[idx]) =3D=3D 0);
> >> > -     cluster_set_count(&cluster_info[idx],
> >> > -             cluster_count(&cluster_info[idx]) - 1);
> >> > +     VM_BUG_ON(ci->count =3D=3D 0);
> >> > +     ci->count--;
> >> >
> >> > -     if (cluster_count(&cluster_info[idx]) =3D=3D 0)
> >> > -             free_cluster(p, idx);
> >> > +     if (!ci->count)
> >> > +             free_cluster(p, ci);
> >> >  }
> >> >
> >> >  /*
> >> > @@ -611,10 +498,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap=
_info_struct *si,
> >> >  {
> >> >       struct percpu_cluster *percpu_cluster;
> >> >       bool conflict;
> >> > -
> >> > +     struct swap_cluster_info *first =3D list_first_entry(&si->free=
_clusters, struct swap_cluster_info, list);
> >> >       offset /=3D SWAPFILE_CLUSTER;
> >> > -     conflict =3D !cluster_list_empty(&si->free_clusters) &&
> >> > -             offset !=3D cluster_list_first(&si->free_clusters) &&
> >> > +     conflict =3D !list_empty(&si->free_clusters) &&
> >> > +             offset !=3D  first - si->cluster_info &&
> >> >               cluster_is_free(&si->cluster_info[offset]);
> >> >
> >> >       if (!conflict)
> >> > @@ -655,10 +542,14 @@ static bool scan_swap_map_try_ssd_cluster(stru=
ct swap_info_struct *si,
> >> >       cluster =3D this_cpu_ptr(si->percpu_cluster);
> >> >       tmp =3D cluster->next[order];
> >> >       if (tmp =3D=3D SWAP_NEXT_INVALID) {
> >> > -             if (!cluster_list_empty(&si->free_clusters)) {
> >> > -                     tmp =3D cluster_next(&si->free_clusters.head) =
*
> >> > -                                     SWAPFILE_CLUSTER;
> >> > -             } else if (!cluster_list_empty(&si->discard_clusters))=
 {
> >> > +             if (!list_empty(&si->free_clusters)) {
> >> > +                     ci =3D list_first_entry(&si->free_clusters, st=
ruct swap_cluster_info, list);
> >> > +                     list_del(&ci->list);
> >>
> >> IIRC, we shouldn't delete the cluster from the free list here, because
> >> we will delete it later in alloc_cluster().
> >>
> >> > +                     spin_lock(&ci->lock);
> >> > +                     ci->flags =3D 0;
> >>
> >> And also shouldn't set ci->flags here too.  Because the cluster may be
> >> kept in free list if scan_swap_map_ssd_cluster_conflict() returns true=
.
> >
> > If we both delete the cluster from the free list and clear the flag
> > here. alloc_cluster() will not see this cluster because the flags have
> > been cleared.
> > Will that work?
>
> You are right.  This works.

Thanks for the confirmation.

> However, I think that it's better to change as less as possible except
> converting cluster list implementation.  If we don't delete the cluster
> from the free cluster list here and leave it to alloc_cluster(), does it
> work?  If so, we can make the patch smaller and focused.  If necessary,
> we can make the change in the later patch of the series.

Agree. I later came to the same conclusion. Let me do just that in the
next version.

Thanks for the review and suggestion.

Chris


Return-Path: <linux-kernel+bounces-195955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF38D54D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E181C22175
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44019183089;
	Thu, 30 May 2024 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClUmtzAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A628249B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105753; cv=none; b=UtT/L29DlohdgcxDl7etTEK36/b02Pj+HKOLIhzlTkxkO9i3+iu69zoZugE5lKZXpHwssa/UiWaBjREd8K8EAzPinzdFvwsedOEITUcGsiLtLMpRPn9hnDL7t8/1VlQPhRoGMYarGhj/9gXq2zywf80/1y/8L9b6XEqMEVcNsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105753; c=relaxed/simple;
	bh=OdMUW9ZM4x5ElH/aEIeypumDC42YmrQxbmogk1zluY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ty8kNhoAzhrOJ18fGsrNbQhsg3K4pB15iDAZ0n6RRrI5XZDa7XYx8vn4xg2ZRaYKfLnwE+DWT60EvP5QDxxEVQJb7IOIasKFzSyqQFMQW4JlSJWMkepO+Nec44WnHVQrSo4E3yYN8Wv7afXJYoow4esCRH55x6gCo3ZfPX1pSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClUmtzAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F251C2BBFC
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717105753;
	bh=OdMUW9ZM4x5ElH/aEIeypumDC42YmrQxbmogk1zluY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ClUmtzAHn4P27jfvcIfd6sOR9jbgPuMh9UdRkhXrQuGbNjJTrRAOhJRwYt8q25k4u
	 G+y6ZE5Gy15Qm4XxayiQiBHxX8n/OejtkKeb88NlK9dc4CLKxDvVb77oU7z9kztZkN
	 hIH5pGHFNXCxTvAn6t6JbsnPIeTk5pOufxE/U6dSxu2r22xhYez18Ymv1A+RRnUsqt
	 2N/IuoysfNXf5Gk0YTCmBzwhBwnzM0HjcENkEERcn4ea9RJrQHfdUxjzn7T0hHFTnI
	 Mb8oox4TXjpppSt5cdLLEfCUEPWAx4c0LVPfR2+02t3XqWmBU1KwdYX82UVWo965pT
	 X7sTAuWRf1gIw==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3737b31f67dso5769715ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:49:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPB9ZfPUtiafDL7eRareChd2YbptY8M+4NA1kNV1yw9KZ3aHbZk9Ayh132oJvIk1AyhXOd0SZ/fSQyaABQOCFE+fZg2bWn4uJEG0QY
X-Gm-Message-State: AOJu0YxL3mnoc3LclNQpG0vWXhg6LHkPJl/jwg9a9fUO7MDoL262rshh
	8aFhnaavlyhcWtHD02Q7XLzDJOOW2XnGSirLJMzFI8DkQjcjjCLGap0Ktl795ehy0PUqa2cbe0a
	9scITh1aCS1yDUUd5EbyNNLCeF9HVLYgS+HPs
X-Google-Smtp-Source: AGHT+IH8u9T/JoYWp21cy1QePfb+HJ8Z8SlzUT1A6L4zVZ7TtocGk5oY/M5F0d/cLt1kU0BArK59TLcuxbmpUO0ekKM=
X-Received: by 2002:a05:6e02:12e2:b0:374:7fb7:7e32 with SMTP id
 e9e14a558f8ab-3748b8f234amr2082435ab.0.1717105752276; Thu, 30 May 2024
 14:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <20240524-swap-allocator-v1-1-47861b423b26@kernel.org> <87h6eh57kg.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87h6eh57kg.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 30 May 2024 14:49:00 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPYvUP+JZQo6dS-iTf0EePb8FWh67Ac8ARUZ87YZwhoZQ@mail.gmail.com>
Message-ID: <CAF8kJuPYvUP+JZQo6dS-iTf0EePb8FWh67Ac8ARUZ87YZwhoZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: swap cluster switch to double link list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 1:48=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > Previously, the swap cluster used a cluster index as a pointer
> > to construct a custom single link list type "swap_cluster_list".
> > The next cluster pointer is shared with the cluster->count.
> > The assumption is that only the free cluster needs to be put
> > on the list.
> >
> > That assumption is not true for mTHP allocators any more.
>
> I think that the words aren't correct here.  mTHP swap entry allocators
> can work with current cluster definition.

The current behavior is very problematic though:

If we only allocate and free order 4 swap entries, nothing else. After
a while, the free cluster will be used up, the swap entry allocation
will fail even though there is a lot of swap space left.

> > Need to track the non full cluster on the list as well.  Move the
> > current cluster single link list into standard double link list.
>
> It's an optimization to track non-full cluster with a list.
>
> I understand that you want to change cluster list definition.  I just

In my mind, I was changing the list implementation so it can be
tracked non free cluster as well.

> feel the wording isn't accurate.

Help me improve it. I am happy to adjust the wording in V2, you can
provide more feedback then.

>
> > Remove the cluster getter/setter for accessing the cluster
> > struct member.  Move the cluster locking in the caller function
> > rather than the getter/setter function. That way the locking can
> > protect more than one member, e.g. cluster->flag.
>
> Sorry, I don't understand the locking in above words.  I don't find that
> we lock/unlock in the original getter/setter functions.  I found that
> the cluster locking rule for cluster list is changed.  Better to make
> this explicit.

The original cluster single link list add/remove will require si->lock
protection as well, because the list head and tail pointer are outside
of the cluster pointer.
In this regard, the cluster double link list locking rule is very
similar. Yes, I move the list_del() outside of the cluster lock, is
that what you are referring to as the locking change?

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
> > on the average memory usage per swap entry.  Other than the list
> > conversion, there is no real function change in this patch.
>
> On 64bit platform, the size of swap_cluster_info increases from 8 bytes
> to 24 bytes.  For a 1TB swap device, the memory usage will increase from
> 4MB to 12MB.  This looks OK for me.

Will add the size change calculation in V2 and have you review it again.

>
> Another choice is to use a customized double linked list using "unsigned
> int" as pointer to cluster.  That will reduce the size of cluster to 16
> bytes.  But it may be not necessary to do that.

We can always do that as a follow up step to optimize the 24 byte to
16 byte, at the price of more code complicity.
The trick part is the link list head, it is not part of the cluster
array, it does not have an index, and will need a special handle for
that.

>
> Anyway, I think that it's better to add more calculation in changelog
> for memory usage increment.

Sure, I will adjust the commit message in V2.

Chris

>
> > ---
> >  include/linux/swap.h |  14 ++--
> >  mm/swapfile.c        | 231 ++++++++++++++-----------------------------=
--------
> >  2 files changed, 68 insertions(+), 177 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 11c53692f65f..0d3906eff3c9 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -254,11 +254,12 @@ struct swap_cluster_info {
> >                                * elements correspond to the swap
> >                                * cluster
> >                                */
> > -     unsigned int data:24;
> > +     unsigned int count:16;
> >       unsigned int flags:8;
>
> If we use 16bits and 8 bits in bit fields, why not just use u8 and u16
> instead?
Not sure about the

>
> > +     struct list_head next;
>
> "next" isn't a good naming because prev pointer is in list_head too.
> The common naming is "list".

Sure, I can change it to "list".

>
> Need to revise comments for swap_cluster_info.lock and add the locking
> rule comments for swap_cluster_info.next.

Will do.

>
> >  };
> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster *=
/
> > +
> >
> >  /*
> >   * The first page in the swap file is the swap header, which is always=
 marked
> > @@ -283,11 +284,6 @@ struct percpu_cluster {
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
> > @@ -300,7 +296,7 @@ struct swap_info_struct {
> >       unsigned int    max;            /* extent of the swap_map */
> >       unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
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
> > @@ -333,7 +329,7 @@ struct swap_info_struct {
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
> > index 4f0e8b2ac8aa..205a60c5f9cb 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -290,64 +290,11 @@ static void discard_swap_cluster(struct swap_info=
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
> > -{
> > -     info->flags =3D CLUSTER_FLAG_NEXT_NULL;
> > -     info->data =3D 0;
> > -}
> > -
> >  static inline struct swap_cluster_info *lock_cluster(struct swap_info_=
struct *si,
> >                                                    unsigned long offset=
)
> >  {
> > @@ -394,65 +341,11 @@ static inline void unlock_cluster_or_swap_info(st=
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
> > +     unsigned int idx =3D ci - si->cluster_info;
> >       /*
> >        * If scan_swap_map_slots() can't find a free cluster, it will ch=
eck
> >        * si->swap_map directly. To make sure the discarding cluster isn=
't
> > @@ -462,17 +355,16 @@ static void swap_cluster_schedule_discard(struct =
swap_info_struct *si,
> >       memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                       SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> >
> > -     cluster_list_add_tail(&si->discard_clusters, si->cluster_info, id=
x);
> > -
> > +     spin_lock_nested(&ci->lock, SINGLE_DEPTH_NESTING);
>
> If we don't use ci->lock to protect ci->next, we don't need spin_lock her=
e.

Good point. Thanks.

>
> > +     list_add_tail(&ci->next, &si->discard_clusters);
> > +     spin_unlock(&ci->lock);
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
> > +     list_add_tail(&ci->next, &si->free_clusters);
> >  }
> >
> >  /*
> > @@ -481,21 +373,21 @@ static void __free_cluster(struct swap_info_struc=
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
p_cluster_info, next);
> > +             idx =3D ci - si->cluster_info;
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
> >               unlock_cluster(ci);
> > @@ -521,20 +413,20 @@ static void swap_users_ref_free(struct percpu_ref=
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
ers, struct swap_cluster_info, next);
> >
> > -     VM_BUG_ON(cluster_list_first(&si->free_clusters) !=3D idx);
> > -     cluster_list_del_first(&si->free_clusters, ci);
> > -     cluster_set_count_flag(ci + idx, 0, 0);
> > +     VM_BUG_ON(ci - si->cluster_info !=3D idx);
> > +     list_del(&ci->next);
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
> > @@ -542,11 +434,11 @@ static void free_cluster(struct swap_info_struct =
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
> > @@ -559,15 +451,15 @@ static void add_cluster_info_page(struct swap_inf=
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
> > @@ -581,24 +473,20 @@ static void inc_cluster_info_page(struct swap_inf=
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
> > @@ -611,10 +499,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_in=
fo_struct *si,
> >  {
> >       struct percpu_cluster *percpu_cluster;
> >       bool conflict;
> > -
> > +     struct swap_cluster_info *first =3D list_first_entry(&si->free_cl=
usters, struct swap_cluster_info, next);
> >       offset /=3D SWAPFILE_CLUSTER;
> > -     conflict =3D !cluster_list_empty(&si->free_clusters) &&
> > -             offset !=3D cluster_list_first(&si->free_clusters) &&
> > +     conflict =3D !list_empty(&si->free_clusters) &&
> > +             offset !=3D  first - si->cluster_info &&
> >               cluster_is_free(&si->cluster_info[offset]);
> >
> >       if (!conflict)
> > @@ -655,10 +543,14 @@ static bool scan_swap_map_try_ssd_cluster(struct =
swap_info_struct *si,
> >       cluster =3D this_cpu_ptr(si->percpu_cluster);
> >       tmp =3D cluster->next[order];
> >       if (tmp =3D=3D SWAP_NEXT_INVALID) {
> > -             if (!cluster_list_empty(&si->free_clusters)) {
> > -                     tmp =3D cluster_next(&si->free_clusters.head) *
> > -                                     SWAPFILE_CLUSTER;
> > -             } else if (!cluster_list_empty(&si->discard_clusters)) {
> > +             if (!list_empty(&si->free_clusters)) {
> > +                     ci =3D list_first_entry(&si->free_clusters, struc=
t swap_cluster_info, next);
> > +                     list_del(&ci->next);
> > +                     spin_lock(&ci->lock);
> > +                     ci->flags =3D 0;
> > +                     spin_unlock(&ci->lock);
> > +                     tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
> > +             } else if (!list_empty(&si->discard_clusters)) {
> >                       /*
> >                        * we don't have free cluster but have some clust=
ers in
> >                        * discarding, do discard now and reclaim them, t=
hen
> > @@ -670,7 +562,8 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
> >                       goto new_cluster;
> >               } else
> >                       return false;
> > -     }
> > +     } else
> > +             ci =3D si->cluster_info + tmp;
> >
> >       /*
> >        * Other CPUs can use our cluster if they can't find a free clust=
er,
> > @@ -1062,8 +955,9 @@ static void swap_free_cluster(struct swap_info_str=
uct *si, unsigned long idx)
> >
> >       ci =3D lock_cluster(si, offset);
> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> > -     cluster_set_count_flag(ci, 0, 0);
> > -     free_cluster(si, idx);
> > +     ci->count =3D 0;
> > +     ci->flags =3D 0;
> > +     free_cluster(si, ci);
> >       unlock_cluster(ci);
> >       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> >  }
> > @@ -1336,7 +1230,7 @@ static void swap_entry_free(struct swap_info_stru=
ct *p, swp_entry_t entry)
> >       count =3D p->swap_map[offset];
> >       VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
> >       p->swap_map[offset] =3D 0;
> > -     dec_cluster_info_page(p, p->cluster_info, offset);
> > +     dec_cluster_info_page(p, ci);
> >       unlock_cluster(ci);
> >
> >       mem_cgroup_uncharge_swap(entry, 1);
> > @@ -2985,8 +2879,8 @@ static int setup_swap_map_and_extents(struct swap=
_info_struct *p,
> >
> >       nr_good_pages =3D maxpages - 1;   /* omit header page */
> >
> > -     cluster_list_init(&p->free_clusters);
> > -     cluster_list_init(&p->discard_clusters);
> > +     INIT_LIST_HEAD(&p->free_clusters);
> > +     INIT_LIST_HEAD(&p->discard_clusters);
> >
> >       for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> >               unsigned int page_nr =3D swap_header->info.badpages[i];
> > @@ -3037,14 +2931,15 @@ static int setup_swap_map_and_extents(struct sw=
ap_info_struct *p,
> >       for (k =3D 0; k < SWAP_CLUSTER_COLS; k++) {
> >               j =3D (k + col) % SWAP_CLUSTER_COLS;
> >               for (i =3D 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_=
COLS); i++) {
> > +                     struct swap_cluster_info *ci;
> >                       idx =3D i * SWAP_CLUSTER_COLS + j;
> > +                     ci =3D cluster_info + idx;
> >                       if (idx >=3D nr_clusters)
> >                               continue;
> > -                     if (cluster_count(&cluster_info[idx]))
> > +                     if (ci->count)
> >                               continue;
> > -                     cluster_set_flag(&cluster_info[idx], CLUSTER_FLAG=
_FREE);
> > -                     cluster_list_add_tail(&p->free_clusters, cluster_=
info,
> > -                                           idx);
> > +                     ci->flags =3D CLUSTER_FLAG_FREE;
> > +                     list_add_tail(&ci->next, &p->free_clusters);
> >               }
> >       }
> >       return nr_extents;
>
> --
> Best Regards,
> Huang, Ying
>


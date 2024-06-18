Return-Path: <linux-kernel+bounces-218642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC690C302
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E924284281
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDC1B970;
	Tue, 18 Jun 2024 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ2eVkq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB817C7F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687198; cv=none; b=ENfZ2hK6Rx/0n462pLj/bZvsd08HrKf4V4OBewfhKLfEhs/M3IsPs6RyTEMBvMPqsJo/5TwkkbSw17F/H+oCFGKyzXDTJTARAsBP1wh58ISIil9ISfbV/KGhSPsvSD8/YZKkfJyxFKuX/Lh0yTv2VoGUW6/j76tLgNLv44rL+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687198; c=relaxed/simple;
	bh=vKcpzlA/Lk5YmTJbcaXAPo7ISyjfiSZf74loSRHFS80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm+RsfsArMvT9B1Ycr6L1GRg9QQqud26Bd7fCxyD3IWRWuc46Q9FIqNJSTeYz1ihc2NaRNR8mS5EWQNY8KtFgwdm4Fb24JXABdgBOl7c/VgQKpD+kFQh+dkxhAxpg0xU/wfrsva+XuV8Eyao1nUxop8ChY8mrNc1IkBbVHina5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ2eVkq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8868C4AF50
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718687197;
	bh=vKcpzlA/Lk5YmTJbcaXAPo7ISyjfiSZf74loSRHFS80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JZ2eVkq0dLujBfgy9vpOCLQ9fRCzJpaYRf3XbrA7kfuK7zN8NHH6lE29cQRGd4WsD
	 Ic/CTZFI2OqnXFQQQryU4oAjt3Da5qWq5dPxKVZeGGsjk+GKtHGuoCRJqLwRoKhPHT
	 aj9C2WxW4NUAUmX4YvwtzGHClf4gqOfOKcYXEyGuloH9SvOfoyfmmou1Q2woGdqTDl
	 mPy1Bgd7m6gzO5irBIac7NHMLYrOXDE9ukyNBT6yKAdXMjAifbCUY8O5Dj4iJyMKbS
	 btQjV40Xd5gkTuu23zdkAns4v8mceyQH7kCvy8zOt9blwZHKd55iz3Tl4Gbt0nfD68
	 4bNL6tMrPaaiA==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-37588517095so18962215ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:06:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEB+FlBhIbEi1TxOtRcCW1fAX84WWlJCP82VUMz76Rrb7Zcb7yJBODwEcHI9eXX4/K8DF0HkBIl+8gktu/906RYGaCusWlt8n6cu7G
X-Gm-Message-State: AOJu0YxTYiUOXR2UDQDMoNOe9df29rdKCDvP10CWnzqVKmtGkb6uEpwA
	WdtP40qwqG0MSgmabjBynTwxDnkXlmWpQ5/w3va5VUYJLjObuh5o3PAh9xh0FOztuGFB0wRQM7/
	FJUoCOq/KvZF5urbJI5pITFUEEebZdAlt3PIe
X-Google-Smtp-Source: AGHT+IFCUzFWJxN/nnospyldJteUJQxqxe5kdHQquNXJ1t6vLsht4HvM7jdmrP5DnNMEMJ0JKa68t+J0GNymAowPzq4=
X-Received: by 2002:a05:6e02:17c9:b0:36c:4688:85aa with SMTP id
 e9e14a558f8ab-375e0e44edbmr143405955ab.10.1718687195910; Mon, 17 Jun 2024
 22:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
 <20240614-swap-allocator-v2-1-2a513b4a7f2f@kernel.org> <87frtc5bxm.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frtc5bxm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 17 Jun 2024 22:06:23 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMTAuGN6Zt-=Nb-4TPZ4aNBX17W6eop5LPVHYTakV+LHw@mail.gmail.com>
Message-ID: <CAF8kJuMTAuGN6Zt-=Nb-4TPZ4aNBX17W6eop5LPVHYTakV+LHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: swap: swap cluster switch to double link list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 11:21=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Hi, Chris,
>
> Chris Li <chrisl@kernel.org> writes:
>
> > Previously, the swap cluster used a cluster index as a pointer
> > to construct a custom single link list type "swap_cluster_list".
> > The next cluster pointer is shared with the cluster->count.
> > It prevents puting the non free cluster into a list.
> > Change the cluster to use the standard double link list instead.
> > This allows tracing the nonfull cluster in the follow up patch.
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
>
> The above is more about "what" instead of "why".  We can identify "what"
> from the patch itself.  I expect more "why".  I guess that we can reduce
> swap_map[] scanning if we have lists of non-full/non-free clusters.

In my mind, the "why" is captured by " This allows tracing the nonfull
cluster in the follow up patch.".
If you want to ask "why" we want the "nonfull cluster list". It is to
get to the suitable candidate cluster with that order quicker than
scanning swap_map[].

>
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
> >  include/linux/swap.h |  28 +++----
> >  mm/swapfile.c        | 227 +++++++++++++------------------------------=
--------
> >  2 files changed, 70 insertions(+), 185 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 3df75d62a835..cd9154a3e934 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -242,23 +242,22 @@ enum {
> >   * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk=
. All
> >   * free clusters are organized into a list. We fetch an entry from the=
 list to
> >   * get a free cluster.
> > - *
> > - * The data field stores next cluster if the cluster is free or cluste=
r usage
> > - * counter otherwise. The flags field determines if a cluster is free.=
 This is
> > - * protected by swap_info_struct.lock.
> >   */
> >  struct swap_cluster_info {
> >       spinlock_t lock;        /*
> > -                              * Protect swap_cluster_info fields
> > -                              * and swap_info_struct->swap_map
> > +                              * Protect swap_cluster_info count and st=
ate
>
> Protect swap_cluster_info fields except 'list' ?

I change it to protect the swap_cluster_info bitfields in the second patch.
>
> > +                              * field and swap_info_struct->swap_map
> >                                * elements correspond to the swap
> >                                * cluster
> >                                */
> > -     unsigned int data:24;
> > -     unsigned int flags:8;
> > +     unsigned int count:12;
> > +     unsigned int state:3;
>
> I still prefer normal data type over bit fields.  How about
>
>         u16 usage;
>         u8  state;

I don't mind the "count" rename to "usage". That is probably a better
name. However I have another patch intended to add more bit fields in
the cluster info struct. The second patch adds "order" and the later
patch will add more. That is why I choose bitfield to be more condense
with bits.

>
> And, how about use 'usage' instead of 'count'?  Personally I think that
> it is more clear.  But I don't have strong opinions on this.
>
> > +     struct list_head list;  /* Protected by swap_info_struct->lock */
> >  };
> > -#define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster *=
/
> > +
> > +#define CLUSTER_STATE_FREE   1 /* This cluster is free */
>
> Can we use swap_cluster_info->count =3D=3D 0?

It is not as good considering the second patch starts to track the
state of the cluster of per cpu struct. We will be comparing both the
cluster->count and cluster->state.

>
> > +#define CLUSTER_STATE_PER_CPU        2 /* This cluster on per_cpu_clus=
ter  */
> > +
>
> There's no users of this state in this patch.  IMHO, it's better to

Yes, there is usage of this state in this patch in the sense that, if
you remove that state definition,
the code can't compile due to assignment of CLUSTER_STATE_PER_CPU.
There is a code test if a cluster state is not a free state, which
excludes "CLUSTER_STATE_PER_CPU".

> introduce a symbol with its users, otherwise, it's hard to understand
> why do we need it and how to use it.  And, IIUC, the state isn't
> maintained properly, it should be changed when we move the cluster off
> the per-cpu cluster.

I am actually following the same usage principle as you suggested
here. Only the second patch starts to use the off per cpu state
(SCANNED). That is why I introduce it there.

>
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
> > @@ -300,7 +294,7 @@ struct swap_info_struct {
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
> > @@ -331,7 +325,7 @@ struct swap_info_struct {
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
> > index 9c6d8e557c0f..2f878b374349 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -290,62 +290,9 @@ static void discard_swap_cluster(struct swap_info_=
struct *si,
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
> > -     return info->flags & CLUSTER_FLAG_FREE;
> > -}
> > -
> > -static inline bool cluster_is_null(struct swap_cluster_info *info)
> > -{
> > -     return info->flags & CLUSTER_FLAG_NEXT_NULL;
> > -}
> > -
> > -static inline void cluster_set_null(struct swap_cluster_info *info)
> > -{
> > -     info->flags =3D CLUSTER_FLAG_NEXT_NULL;
> > -     info->data =3D 0;
> > +     return info->state =3D=3D CLUSTER_STATE_FREE;
> >  }
> >
> >  static inline struct swap_cluster_info *lock_cluster(struct swap_info_=
struct *si,
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
>
> I see this multiple times in the patch, can we define a helper for this?
Ack.

>
> >       /*
> >        * If scan_swap_map_slots() can't find a free cluster, it will ch=
eck
> >        * si->swap_map directly. To make sure the discarding cluster isn=
't
> > @@ -462,17 +355,14 @@ static void swap_cluster_schedule_discard(struct =
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
> > +     ci->state =3D CLUSTER_STATE_FREE;
> > +     list_add_tail(&ci->list, &si->free_clusters);
> >  }
> >
> >  /*
> > @@ -481,21 +371,22 @@ static void __free_cluster(struct swap_info_struc=
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
>
> Personally, I still prefer to use lock_cluster(), which is more readable
> and matches unlock_cluster() below.

lock_cluster() uses an index which is not matching unlock_cluster()
which is using a pointer to cluster.
When you get the cluster from the list, you have a cluster pointer. I
feel it is unnecessary to convert to index then back convert to
cluster pointer inside lock_cluster(). I actually feel using indexes
to refer to the cluster is error prone because we also have offset.


>
> > +             __free_cluster(si, ci);
> >               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                               0, SWAPFILE_CLUSTER);
> >               unlock_cluster(ci);
> > @@ -521,20 +412,19 @@ static void swap_users_ref_free(struct percpu_ref=
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
> >
> > -     VM_BUG_ON(cluster_list_first(&si->free_clusters) !=3D idx);
> > -     cluster_list_del_first(&si->free_clusters, ci);
> > -     cluster_set_count_flag(ci + idx, 0, 0);
> > +     VM_BUG_ON(ci - si->cluster_info !=3D idx);
> > +     list_del(&ci->list);
> > +     ci->count =3D 0;
>
> Do we need this now?  If we keep CLUSTER_STATE_FREE, we need to change
> it here.

Good catch, thanks for catching that. Now I realized this is actually
problematic and tricky to get it right. Let me work on that.

>
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
> > @@ -542,11 +432,11 @@ static void free_cluster(struct swap_info_struct =
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
> > @@ -559,15 +449,15 @@ static void add_cluster_info_page(struct swap_inf=
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
> > @@ -581,24 +471,20 @@ static void inc_cluster_info_page(struct swap_inf=
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
> > @@ -611,10 +497,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_in=
fo_struct *si,
> >  {
> >       struct percpu_cluster *percpu_cluster;
> >       bool conflict;
> > -
>
> Usually we use one blank line after local variable declaration.
Ack.

>
> > +     struct swap_cluster_info *first =3D list_first_entry(&si->free_cl=
usters, struct swap_cluster_info, list);
> >       offset /=3D SWAPFILE_CLUSTER;
> > -     conflict =3D !cluster_list_empty(&si->free_clusters) &&
> > -             offset !=3D cluster_list_first(&si->free_clusters) &&
> > +     conflict =3D !list_empty(&si->free_clusters) &&
> > +             offset !=3D  first - si->cluster_info &&
> >               cluster_is_free(&si->cluster_info[offset]);
> >
> >       if (!conflict)
> > @@ -655,10 +541,14 @@ static bool scan_swap_map_try_ssd_cluster(struct =
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
t swap_cluster_info, list);
> > +                     list_del(&ci->list);
>
> The free cluster is deleted from si->free_clusters now.  But later you
> will call scan_swap_map_ssd_cluster_conflict() and may abandon the
> cluster.  And in alloc_cluster() later, it may be deleted again.

Yes, that is a bug. Thanks for catching that.

>
> > +                     spin_lock(&ci->lock);
> > +                     ci->state =3D CLUSTER_STATE_PER_CPU;
>
> Need to change ci->state when move a cluster off the percpu_cluster.

In the next patch. This patch does not use the off state yet.

>
> > +                     spin_unlock(&ci->lock);
> > +                     tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
> > +             } else if (!list_empty(&si->discard_clusters)) {
> >                       /*
> >                        * we don't have free cluster but have some clust=
ers in
> >                        * discarding, do discard now and reclaim them, t=
hen
> > @@ -1062,8 +952,8 @@ static void swap_free_cluster(struct swap_info_str=
uct *si, unsigned long idx)
> >
> >       ci =3D lock_cluster(si, offset);
> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> > -     cluster_set_count_flag(ci, 0, 0);
> > -     free_cluster(si, idx);
> > +     ci->count =3D 0;
> > +     free_cluster(si, ci);
> >       unlock_cluster(ci);
> >       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> >  }
> > @@ -1336,7 +1226,7 @@ static void swap_entry_free(struct swap_info_stru=
ct *p, swp_entry_t entry)
> >       count =3D p->swap_map[offset];
> >       VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
> >       p->swap_map[offset] =3D 0;
> > -     dec_cluster_info_page(p, p->cluster_info, offset);
> > +     dec_cluster_info_page(p, ci);
> >       unlock_cluster(ci);
> >
> >       mem_cgroup_uncharge_swap(entry, 1);
> > @@ -3003,8 +2893,8 @@ static int setup_swap_map_and_extents(struct swap=
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
> > @@ -3055,14 +2945,15 @@ static int setup_swap_map_and_extents(struct sw=
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
> > +                     ci->state =3D CLUSTER_STATE_FREE;
> > +                     list_add_tail(&ci->list, &p->free_clusters);
> >               }
> >       }
> >       return nr_extents;

Thank you for the review and spotting the bug.

Chris


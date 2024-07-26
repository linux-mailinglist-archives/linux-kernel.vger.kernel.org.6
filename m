Return-Path: <linux-kernel+bounces-262846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7293CDCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315441C20643
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523F14F10F;
	Fri, 26 Jul 2024 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLTREvHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40A14EC7D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972831; cv=none; b=FigVgFXayL8wUmwJt2MxA+CUfCQMspN2z3MLhY8c3yxVbd6DuZDNA2scTVjywjHpu6cRI9b61hLwzoCn4OqjcioJdPUofcnIC+KeIg098laiRWTCk7vKsogC6SALCWpWzy9nl8vVbmuXXPg/ZsbRLxLF54XuO7XHn/KatfYcFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972831; c=relaxed/simple;
	bh=jzXRQdZILYBiNWgUjKvYd4TcxNu6JVgcbdTV+F5qY90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEOfFtAAMpI8JE61N0bzDNI0GSRB2katrTiUTRTnORIu/DABzMX36WCRzSoOa49yEl3b2yh1o+isic14kys0okdCwgxHvTx7vqJOnNJpbOfiqH7KKWLt4qD/XsAy4cBBV+2NnFdo2aRTm2VBUf1XnKrfFIZHwXKZrR7NCxjX/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLTREvHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DCC32786
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721972830;
	bh=jzXRQdZILYBiNWgUjKvYd4TcxNu6JVgcbdTV+F5qY90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OLTREvHUqn8M7BF5YjpTrJI0B7sSf4rrTSTHZHCNKTt5R0nNdCejehKrzOTWWRZG/
	 gpTPatS3J5oQENvlsVC/H3uDCMSKFVqji1XodK9+TUEf8T4ZkrQE2vPMraE25XSxc/
	 Bpvq/agwGPbCXtdmJ3HT4v5LeenSDYQFzuqsM6Du5sj88ZDfXyfKXdVo2GaF8cI62o
	 JlYgl+Y+9O9q0nfUgGdetQcxGefuO5X3wulQD4fwWoWPm/9kHkokcwCk+R1h3KFtfv
	 WUklyVYKEWU2CEeumePqxg3ygehpMk4ZUOMBs5IZKdFwQkIqqzTtjOPPx/f7m9Sxct
	 /UwA8XztFstPQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-65f9708c50dso17272757b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:47:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXN1hnJK1/b49V35rvxmyCZtjx37JbBdmhtUB9QjguSJyN6Jj40eaauyV+7zsECL4BqQDLw8PitnpG/8nhqQyGddbrEnn5ME6Y4xfl1
X-Gm-Message-State: AOJu0Yzs2ffiRUYPOApxSAUoCfoo/K9+yZsUqrEY/AxGMm4butgxSW3Q
	nJ/feMT2EEpflqMB+8TSmeBVT0uymaztjo+dnlHl8llNeoIWLs4VkrV/6AWt+mXWP7V6v5nKyzj
	3Vl94gW7iw02enbiBLOHdfbYiE5Bw4+pblOz7AQ==
X-Google-Smtp-Source: AGHT+IGZXwmARv4KcIzaeE7p/e4xS4n17b1cEa/WIcBrWNhDRn5dC49mxeEnC5kRB/94lLkTqy/URdXO8G8jJqRRXZI=
X-Received: by 2002:a81:ab4d:0:b0:62c:f82b:553f with SMTP id
 00721157ae682-67514c47c2emr53368467b3.31.1721972829909; Thu, 25 Jul 2024
 22:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-1-0295a4d4c7aa@kernel.org> <878qxzxlkv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878qxzxlkv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jul 2024 22:46:59 -0700
X-Gmail-Original-Message-ID: <CACePvbVZdy5EroDwC2hWxq2E_WOx74poLp-zSa7L=DtEqvkLPw@mail.gmail.com>
Message-ID: <CACePvbVZdy5EroDwC2hWxq2E_WOx74poLp-zSa7L=DtEqvkLPw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: swap: swap cluster switch to double link list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:29=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
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
>                              ~~~~
>                              swap_cluster_info ?

Did not see this email earlier. Done.

>
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
> >                                */
> > -     unsigned int data:24;
> > -     unsigned int flags:8;
> > +     u16 count;
> > +     u8 flags;
> > +     struct list_head list;
> >  };
> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster *=
/
> > +
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
> >       offset /=3D SWAPFILE_CLUSTER;

Ah, here it changes the meaning of the offset variable. The offset
holds a cluster index rather than offset.
That is why I miss it.

> > -     conflict =3D !cluster_list_empty(&si->free_clusters) &&
> > -             offset !=3D cluster_list_first(&si->free_clusters) &&
> > +     conflict =3D !list_empty(&si->free_clusters) &&
> > +             offset !=3D  first - si->cluster_info &&
>
> offset !=3D cluster_index(si, first) ?

Done.

Chris


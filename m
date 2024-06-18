Return-Path: <linux-kernel+bounces-219016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F590C8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B2728340F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4CC20E63E;
	Tue, 18 Jun 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfPy7L9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830820E638
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704917; cv=none; b=ClaDnnWwQKVYpQEoxk6++50tK3iZ6wRtHP/ezQjVIGDzH+o2AOvSP1fud56zy0R9E3rYjfQMVb2wsvzTGBW0fdi3xgxLBNhdTJTMhF04/15TOkJ5T59f+cuvMPw5cvD3Tnq9BjN+V51R8yV0HLv7y6dGyua2JmMwiTfdzza0KII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704917; c=relaxed/simple;
	bh=eZXLyQ6qZiMzTeMLvVQO2AiPyzlRneLmPbpIVa+F7Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMLVq3W5KXJBeEYKKWvMGWtBy2Ni2JdiFGVvBAwwuKS0fII2IAh0gLzsEzu9nFAqIuQuDFR7W0KswR7gAQcPYf3EdI8xIrhBFkOhxVILKBQerqNTR3kHbahc//QplaFE35qSogMJi/0USlfhjwFZfUImgfclTtUp4UpQl3XInpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfPy7L9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83C0C4AF4D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718704916;
	bh=eZXLyQ6qZiMzTeMLvVQO2AiPyzlRneLmPbpIVa+F7Pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pfPy7L9+Z5xFhTjxIFEQag7lZAvcLCMjfUjSWw1aHKeO+CeZHgqyxZ3Ow8TRkecVM
	 SDkMITp/R/bGS96NZ5TEVpvCh1b6MUPTxRtx2CVlCQoSdIG1XdrGq2m3u7wwWEjLQO
	 BCncLMJ4UAD86EwzUzKVEmbvRz6/qzte+L42ziGCKcLrNzwU3imjeyXi2JTlR/2abm
	 1bhigH+XBdBV4bYiTbBFeAEvZL2yr3/LeuADjigdvHQC585O9bbb9DY3funYfRJtod
	 cdiPC/Mea9PZHMZffysBf1EzYNOQgxYzrQ0z4pYYUJLNdR3NWJ2Cmlnnw6ODb4iWHN
	 sonHViRsmB45g==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-371c97913cdso20041945ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:01:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6Sejex8OQJK2C+NsYXbSYuAIyXWhpD1HjIFgHHPm24FND5aYmDBaDoce/cQTHEF9NWTP62qMmbAg7BcZyF5ShLdkPq9MZdLRg4/87
X-Gm-Message-State: AOJu0YyadHrF57OsQSLzhZ8vZ1YzpUMjHrtAxbepdWEVrNM3edSdxId5
	TnETPVHuKKzUjKEroWI48B2VzHLApnJFtQURHyki30XsyFB35Dn8Sp7s59GzOomZKEiBas298uP
	0Vo//bwBVqnyGvwU9XpXuESgvM51phq4SouJG
X-Google-Smtp-Source: AGHT+IHHEFMSRP4glx1tXfN+NSVxCVMX4VQuCqJaBkQfnPLzXPe9QTPIGBRVeL7ljbc/oQ3a31XW9VCa7T9GjeoJgOs=
X-Received: by 2002:a05:6e02:12ed:b0:374:ac3a:e32c with SMTP id
 e9e14a558f8ab-375e0e28a43mr3010235ab.16.1718704915833; Tue, 18 Jun 2024
 03:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
 <20240614-swap-allocator-v2-1-2a513b4a7f2f@kernel.org> <87frtc5bxm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuMTAuGN6Zt-=Nb-4TPZ4aNBX17W6eop5LPVHYTakV+LHw@mail.gmail.com> <87y1724re8.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y1724re8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 18 Jun 2024 03:01:42 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPqTWdxdUnU_0b4JNY06S6qdc5rEDwtr6M6NV9PhmHVUw@mail.gmail.com>
Message-ID: <CAF8kJuPqTWdxdUnU_0b4JNY06S6qdc5rEDwtr6M6NV9PhmHVUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: swap: swap cluster switch to double link list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:56=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Sun, Jun 16, 2024 at 11:21=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>
> >> Hi, Chris,
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > Previously, the swap cluster used a cluster index as a pointer
> >> > to construct a custom single link list type "swap_cluster_list".
> >> > The next cluster pointer is shared with the cluster->count.
> >> > It prevents puting the non free cluster into a list.
> >> > Change the cluster to use the standard double link list instead.
> >> > This allows tracing the nonfull cluster in the follow up patch.
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
> >>
> >> The above is more about "what" instead of "why".  We can identify "wha=
t"
> >> from the patch itself.  I expect more "why".  I guess that we can redu=
ce
> >> swap_map[] scanning if we have lists of non-full/non-free clusters.
> >
> > In my mind, the "why" is captured by " This allows tracing the nonfull
> > cluster in the follow up patch.".
> > If you want to ask "why" we want the "nonfull cluster list". It is to
> > get to the suitable candidate cluster with that order quicker than
> > scanning swap_map[].
>
> Good.  Please add that into the patch description.  And I think that we
> can reduce the description about "what" too.

Sure.

>
> >>
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
> >> >  include/linux/swap.h |  28 +++----
> >> >  mm/swapfile.c        | 227 +++++++++++++---------------------------=
-----------
> >> >  2 files changed, 70 insertions(+), 185 deletions(-)
> >> >
> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> > index 3df75d62a835..cd9154a3e934 100644
> >> > --- a/include/linux/swap.h
> >> > +++ b/include/linux/swap.h
> >> > @@ -242,23 +242,22 @@ enum {
> >> >   * space with SWAPFILE_CLUSTER pages long and naturally aligns in d=
isk. All
> >> >   * free clusters are organized into a list. We fetch an entry from =
the list to
> >> >   * get a free cluster.
> >> > - *
> >> > - * The data field stores next cluster if the cluster is free or clu=
ster usage
> >> > - * counter otherwise. The flags field determines if a cluster is fr=
ee. This is
> >> > - * protected by swap_info_struct.lock.
> >> >   */
> >> >  struct swap_cluster_info {
> >> >       spinlock_t lock;        /*
> >> > -                              * Protect swap_cluster_info fields
> >> > -                              * and swap_info_struct->swap_map
> >> > +                              * Protect swap_cluster_info count and=
 state
> >>
> >> Protect swap_cluster_info fields except 'list' ?
> >
> > I change it to protect the swap_cluster_info bitfields in the second pa=
tch.
>
> Although I still prefer my version, I will not insist on that.

Sure, I actually don't have a strong preference about that. It is just comm=
ents.

>
> >>
> >> > +                              * field and swap_info_struct->swap_ma=
p
> >> >                                * elements correspond to the swap
> >> >                                * cluster
> >> >                                */
> >> > -     unsigned int data:24;
> >> > -     unsigned int flags:8;
> >> > +     unsigned int count:12;
> >> > +     unsigned int state:3;
> >>
> >> I still prefer normal data type over bit fields.  How about
> >>
> >>         u16 usage;
> >>         u8  state;
> >
> > I don't mind the "count" rename to "usage". That is probably a better
> > name. However I have another patch intended to add more bit fields in
> > the cluster info struct. The second patch adds "order" and the later
> > patch will add more. That is why I choose bitfield to be more condense
> > with bits.
>
> We still have space for another "u8" for "order".  It appears trivial to
> change it to bit fields when necessary in the future.

We can, I don't see it necessary to change from bit field to u8 and
back to bit field in the future. It is more of a personal preference
issue.

> >>
> >> And, how about use 'usage' instead of 'count'?  Personally I think tha=
t
> >> it is more clear.  But I don't have strong opinions on this.
> >>
> >> > +     struct list_head list;  /* Protected by swap_info_struct->lock=
 */
> >> >  };
> >> > -#define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> >> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluste=
r */
> >> > +
> >> > +#define CLUSTER_STATE_FREE   1 /* This cluster is free */
> >>
> >> Can we use swap_cluster_info->count =3D=3D 0?
> >
> > It is not as good considering the second patch starts to track the
> > state of the cluster of per cpu struct. We will be comparing both the
> > cluster->count and cluster->state.
> >
> >>
> >> > +#define CLUSTER_STATE_PER_CPU        2 /* This cluster on per_cpu_c=
luster  */
> >> > +
> >>
> >> There's no users of this state in this patch.  IMHO, it's better to
> >
> > Yes, there is usage of this state in this patch in the sense that, if
> > you remove that state definition,
> > the code can't compile due to assignment of CLUSTER_STATE_PER_CPU.
>
> Sorry, my words were confusing, we can move both the assignment and the
> state itself to the second patch.
>
> > There is a code test if a cluster state is not a free state, which
> > excludes "CLUSTER_STATE_PER_CPU".
>
> You mean the functionality that is equivalent to original
> cluster_set_count_flag(0, 0) and cluster_is_free()?  I think
> CLUSTER_STATE_PER_CPU cannot catch all.  If so, I suggest you to keep
> swap_cluster_info.flags and CLUSTER_FLAG_FREE in this patch and change
> it in the 2nd patch.  That will make this patch more focused and easier
> to be reviewed.

That is one way to do it.

>
> In general, please try to keep this patch as simple as possible to help
> reviewers.  Because it's quite long.  For example, just convert the list
> implementation and keep other stuff as much as possible.
>
Let me think about it. Thanks.

> >> introduce a symbol with its users, otherwise, it's hard to understand
> >> why do we need it and how to use it.  And, IIUC, the state isn't
> >> maintained properly, it should be changed when we move the cluster off
> >> the per-cpu cluster.
> >
> > I am actually following the same usage principle as you suggested
> > here. Only the second patch starts to use the off per cpu state
> > (SCANNED). That is why I introduce it there.
> >
> >>
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
> >> > index 9c6d8e557c0f..2f878b374349 100644
> >> > --- a/mm/swapfile.c
> >> > +++ b/mm/swapfile.c
> >> > @@ -290,62 +290,9 @@ static void discard_swap_cluster(struct swap_in=
fo_struct *si,
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
> >> > -     return info->flags & CLUSTER_FLAG_FREE;
> >> > -}
> >> > -
> >> > -static inline bool cluster_is_null(struct swap_cluster_info *info)
> >> > -{
> >> > -     return info->flags & CLUSTER_FLAG_NEXT_NULL;
> >> > -}
> >> > -
> >> > -static inline void cluster_set_null(struct swap_cluster_info *info)
> >> > -{
> >> > -     info->flags =3D CLUSTER_FLAG_NEXT_NULL;
> >> > -     info->data =3D 0;
> >> > +     return info->state =3D=3D CLUSTER_STATE_FREE;
> >> >  }
> >> >
> >> >  static inline struct swap_cluster_info *lock_cluster(struct swap_in=
fo_struct *si,
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
> >> I see this multiple times in the patch, can we define a helper for thi=
s?
> > Ack.
> >
> >>
> >> >       /*
> >> >        * If scan_swap_map_slots() can't find a free cluster, it will=
 check
> >> >        * si->swap_map directly. To make sure the discarding cluster =
isn't
> >> > @@ -462,17 +355,14 @@ static void swap_cluster_schedule_discard(stru=
ct swap_info_struct *si,
> >> >       memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >> >                       SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> >> >
> >> > -     cluster_list_add_tail(&si->discard_clusters, si->cluster_info,=
 idx);
> >> > -
> >> > +     list_add_tail(&ci->list, &si->discard_clusters);
> >> >       schedule_work(&si->discard_work);
> >> >  }
> >> >
> >> > -static void __free_cluster(struct swap_info_struct *si, unsigned lo=
ng idx)
> >> > +static void __free_cluster(struct swap_info_struct *si, struct swap=
_cluster_info *ci)
> >> >  {
> >> > -     struct swap_cluster_info *ci =3D si->cluster_info;
> >> > -
> >> > -     cluster_set_flag(ci + idx, CLUSTER_FLAG_FREE);
> >> > -     cluster_list_add_tail(&si->free_clusters, ci, idx);
> >> > +     ci->state =3D CLUSTER_STATE_FREE;
> >> > +     list_add_tail(&ci->list, &si->free_clusters);
> >> >  }
> >> >
> >> >  /*
> >> > @@ -481,21 +371,22 @@ static void __free_cluster(struct swap_info_st=
ruct *si, unsigned long idx)
> >> >  */
> >> >  static void swap_do_scheduled_discard(struct swap_info_struct *si)
> >> >  {
> >> > -     struct swap_cluster_info *info, *ci;
> >> > +     struct swap_cluster_info *ci;
> >> >       unsigned int idx;
> >> >
> >> > -     info =3D si->cluster_info;
> >> > -
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
> >> Personally, I still prefer to use lock_cluster(), which is more readab=
le
> >> and matches unlock_cluster() below.
> >
> > lock_cluster() uses an index which is not matching unlock_cluster()
> > which is using a pointer to cluster.
>
> lock_cluster()/unlock_cluster() are pair and fit original design
> well.  They use different parameter because swap cluster is optional.
>
> > When you get the cluster from the list, you have a cluster pointer. I
> > feel it is unnecessary to convert to index then back convert to
> > cluster pointer inside lock_cluster(). I actually feel using indexes
> > to refer to the cluster is error prone because we also have offset.
>
> I don't think so, it's common to use swap offset.

Swap offset is not an issue, it is all over the place. The cluster
index(offset/512) is the one I try to avoid.
I have made some mistakes myself on offset vs index.

>
> >
> >>
> >> > +             __free_cluster(si, ci);
> >> >               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >> >                               0, SWAPFILE_CLUSTER);
> >> >               unlock_cluster(ci);
> >> > @@ -521,20 +412,19 @@ static void swap_users_ref_free(struct percpu_=
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
> >>
> >> Do we need this now?  If we keep CLUSTER_STATE_FREE, we need to change
> >> it here.
> >
> > Good catch, thanks for catching that. Now I realized this is actually
> > problematic and tricky to get it right. Let me work on that.
> >
> >>
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
> >> > @@ -542,11 +432,11 @@ static void free_cluster(struct swap_info_stru=
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
> >> > @@ -559,15 +449,15 @@ static void add_cluster_info_page(struct swap_=
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
> >> > @@ -581,24 +471,20 @@ static void inc_cluster_info_page(struct swap_=
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
> >> > @@ -611,10 +497,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap=
_info_struct *si,
> >> >  {
> >> >       struct percpu_cluster *percpu_cluster;
> >> >       bool conflict;
> >> > -
> >>
> >> Usually we use one blank line after local variable declaration.
> > Ack.
> >
> >>
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
> >> > @@ -655,10 +541,14 @@ static bool scan_swap_map_try_ssd_cluster(stru=
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
> >> The free cluster is deleted from si->free_clusters now.  But later you
> >> will call scan_swap_map_ssd_cluster_conflict() and may abandon the
> >> cluster.  And in alloc_cluster() later, it may be deleted again.
> >
> > Yes, that is a bug. Thanks for catching that.
> >
> >>
> >> > +                     spin_lock(&ci->lock);
> >> > +                     ci->state =3D CLUSTER_STATE_PER_CPU;
> >>
> >> Need to change ci->state when move a cluster off the percpu_cluster.
> >
> > In the next patch. This patch does not use the off state yet.
>
> But that is confusing to use wrong state name, the really meaning is
> something like CLUSTER_STATE_NON_FREE.  But as I suggested above, we can

It can be FREE and on the per cpu pointer as well. That is the tricky part.
It can happen on the current code as well.

> keep swap_cluster_info.flags and CLUSTER_FLAG_FREE in this patch.

Maybe. Will consider that.

>
> >>
> >> > +                     spin_unlock(&ci->lock);
> >> > +                     tmp =3D (ci - si->cluster_info) * SWAPFILE_CLU=
STER;
> >> > +             } else if (!list_empty(&si->discard_clusters)) {
> >> >                       /*
> >> >                        * we don't have free cluster but have some cl=
usters in
> >> >                        * discarding, do discard now and reclaim them=
, then
> >> > @@ -1062,8 +952,8 @@ static void swap_free_cluster(struct swap_info_=
struct *si, unsigned long idx)
> >> >
> >> >       ci =3D lock_cluster(si, offset);
> >> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >> > -     cluster_set_count_flag(ci, 0, 0);
> >> > -     free_cluster(si, idx);
> >> > +     ci->count =3D 0;
> >> > +     free_cluster(si, ci);
> >> >       unlock_cluster(ci);
> >> >       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> >> >  }
> >> > @@ -1336,7 +1226,7 @@ static void swap_entry_free(struct swap_info_s=
truct *p, swp_entry_t entry)
> >> >       count =3D p->swap_map[offset];
> >> >       VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
> >> >       p->swap_map[offset] =3D 0;
> >> > -     dec_cluster_info_page(p, p->cluster_info, offset);
> >> > +     dec_cluster_info_page(p, ci);
> >> >       unlock_cluster(ci);
> >> >
> >> >       mem_cgroup_uncharge_swap(entry, 1);
> >> > @@ -3003,8 +2893,8 @@ static int setup_swap_map_and_extents(struct s=
wap_info_struct *p,
> >> >
> >> >       nr_good_pages =3D maxpages - 1;   /* omit header page */
> >> >
> >> > -     cluster_list_init(&p->free_clusters);
> >> > -     cluster_list_init(&p->discard_clusters);
> >> > +     INIT_LIST_HEAD(&p->free_clusters);
> >> > +     INIT_LIST_HEAD(&p->discard_clusters);
> >> >
> >> >       for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> >> >               unsigned int page_nr =3D swap_header->info.badpages[i]=
;
> >> > @@ -3055,14 +2945,15 @@ static int setup_swap_map_and_extents(struct=
 swap_info_struct *p,
> >> >       for (k =3D 0; k < SWAP_CLUSTER_COLS; k++) {
> >> >               j =3D (k + col) % SWAP_CLUSTER_COLS;
> >> >               for (i =3D 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUST=
ER_COLS); i++) {
> >> > +                     struct swap_cluster_info *ci;
> >> >                       idx =3D i * SWAP_CLUSTER_COLS + j;
> >> > +                     ci =3D cluster_info + idx;
> >> >                       if (idx >=3D nr_clusters)
> >> >                               continue;
> >> > -                     if (cluster_count(&cluster_info[idx]))
> >> > +                     if (ci->count)
> >> >                               continue;
> >> > -                     cluster_set_flag(&cluster_info[idx], CLUSTER_F=
LAG_FREE);
> >> > -                     cluster_list_add_tail(&p->free_clusters, clust=
er_info,
> >> > -                                           idx);
> >> > +                     ci->state =3D CLUSTER_STATE_FREE;
> >> > +                     list_add_tail(&ci->list, &p->free_clusters);
> >> >               }
> >> >       }
> >> >       return nr_extents;
> >
> > Thank you for the review and spotting the bug.
>
> My pleasure!

Thanks!

Chris


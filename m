Return-Path: <linux-kernel+bounces-192748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3698D2193
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53712B20E79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4B172BAD;
	Tue, 28 May 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5sfaVEA"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29353DDBE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913457; cv=none; b=CRmBB5C+caPDJuxnvX5iPkbSJU5ZlaCZDdAzQh6JlHhwI16XFhf3f9ev4brOfKL+78g+94kSqOg0u91sl64h0iXyzD5gEUatoJqClTWOXOREHJIptb0fp/Gi93mFacfGk64LSQmzX68qKwFR2vocD3uyfyhkNeV0fO+9BfkryIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913457; c=relaxed/simple;
	bh=DxGV99Xa8/dCpzXzp0jvvSr9NlETrjEmdNIl1Tnegzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2m24+RCys6GpPQxZEBGsRUU2NQIk+d4nKiDvunkqs5PSxDIN+msGNsBbqgAgqk3ZZtM50rUcw9N4XBRQgaWF+wCKDq+w6NXZuwUKgD02xILYcIgO/EVCK8os+kMBlYOkUrKIMxwLtBxy7od8MxyO2yGaBXHG4j8X+jxAL1NnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5sfaVEA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so14963901fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716913453; x=1717518253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K1NcP1gNiKql5AFPYIjz+Lx6ua8I5KPiZ7xub6bfgA=;
        b=B5sfaVEAwv0BuDsuH4egdqI+12D9Vf8hsduVx31Pa6bSvrU7JmUIp+u45uKww5j+jB
         nPy9SRseqDq7sze8RJ7wL61VgnQ4m/M0qdjt4XAhjiLhpGD91He2VHwSUBtniNyD4PAl
         enCgx1Kae6JgS0cTq1hmgkbBPFH+IJ5AqxUwdAnaby7XMdPVEmWPE38OEyRxWTN8Q0rJ
         iFt0vO+D4cUvQZ8B5VYhntV7OjVuTy0foechielhgImxHHRW+BkEv7/PihuY/ccy13Qk
         nYdK2/lenMGJFH2LnX4r3Xe72zwBZtl6QhYyrPcGCHF4psLSrbnSV4IVWccAB87C4xLI
         baUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913453; x=1717518253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K1NcP1gNiKql5AFPYIjz+Lx6ua8I5KPiZ7xub6bfgA=;
        b=rX/l+3xY/Ss9A3Q/53lhoqv2w0OW7om5lP+s9ZYTRhSzvyCnHZ8fDs5pS7uTNvAKfV
         M/fC6TbXFauXkbAF/H9WF5tSfq1bp3ho+Q06bjkg4b6Gi5A0AlTgVgZlV8dLr9YBmEfO
         07l4UEbmU1OKKC8qNGuN2+cKAwPietweKHFuvpU5CLyRZknZSNxC4PbLXKAD9TTX6kWR
         9SOitx7/eVfz8o/FkxJdc0tDCm0yUmGhLiYpG3FaPb2FT0bfYKmiIxSzLjlwStdhKbvW
         83NQYkr+R9davuWo/A4/3ZAQfuD8TD6d57ayzlU9+F4JPyyLZ17ZSyrEtRwGILsVE95H
         tBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWveLu09/X1kj9RorVPovHFMYkazduszN150ydMzR1rHYfoprLiOmqkZqb05ekHTVdLHOXOAqNQECSQOPURr9FuK+pCuJN4zs7cxuid
X-Gm-Message-State: AOJu0Yx+ajw/tn1I6VYCbR6u1117KxL1yMbidJNEgsyir5YtCO0VVK7y
	v5lRVeDvwBV/rTgUEt9SEGL/G169H+mHTpkNPHZjKPo/983BDrDpvKc2vaWUBtwJKGZvxvcxG4K
	wSAF3LVb/cdyzyxfwE9laxAJ8tVM=
X-Google-Smtp-Source: AGHT+IGbkx+Zs1rkN2Q2Vw1FKtdeZBcQnzdvDq/Y8D0rJJCGXeTsuHg/7uIOvTn47GJ4wk3rhK1vFg8/ZOloQDIu1IA=
X-Received: by 2002:a2e:901a:0:b0:2e9:8b34:1163 with SMTP id
 38308e7fff4ca-2e98b34121fmr14777961fa.37.1716913452795; Tue, 28 May 2024
 09:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org> <20240524-swap-allocator-v1-1-47861b423b26@kernel.org>
In-Reply-To: <20240524-swap-allocator-v1-1-47861b423b26@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 May 2024 00:23:56 +0800
Message-ID: <CAMgjq7BXBrHZxCKgmQxe5TsCxuumaz1PMxauQ-fuBbTw4Vzs_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: swap cluster switch to double link list
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 1:17=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Previously, the swap cluster used a cluster index as a pointer
> to construct a custom single link list type "swap_cluster_list".
> The next cluster pointer is shared with the cluster->count.
> The assumption is that only the free cluster needs to be put
> on the list.
>
> That assumption is not true for mTHP allocators any more. Need
> to track the non full cluster on the list as well.  Move the
> current cluster single link list into standard double link list.
>
> Remove the cluster getter/setter for accessing the cluster
> struct member.  Move the cluster locking in the caller function
> rather than the getter/setter function. That way the locking can
> protect more than one member, e.g. cluster->flag.
>
> Change cluster code to use "struct swap_cluster_info *" to
> reference the cluster rather than by using index. That is more
> consistent with the list manipulation. It avoids the repeat
> adding index to the cluser_info. The code is easier to understand.
>
> Remove the cluster next pointer is NULL flag, the double link
> list can handle the empty list pretty well.
>
> The "swap_cluster_info" struct is two pointer bigger, because
> 512 swap entries share one swap struct, it has very little impact
> on the average memory usage per swap entry.  Other than the list
> conversion, there is no real function change in this patch.
> ---
>  include/linux/swap.h |  14 ++--
>  mm/swapfile.c        | 231 ++++++++++++++-------------------------------=
------
>  2 files changed, 68 insertions(+), 177 deletions(-)
>

Hi Chris,

Thanks for this very nice clean up, the code is much easier to read.

> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..0d3906eff3c9 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -254,11 +254,12 @@ struct swap_cluster_info {
>                                  * elements correspond to the swap
>                                  * cluster
>                                  */
> -       unsigned int data:24;
> +       unsigned int count:16;
>         unsigned int flags:8;
> +       struct list_head next;
>  };
>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
> +
>
>  /*
>   * The first page in the swap file is the swap header, which is always m=
arked
> @@ -283,11 +284,6 @@ struct percpu_cluster {
>         unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
>  };
>
> -struct swap_cluster_list {
> -       struct swap_cluster_info head;
> -       struct swap_cluster_info tail;
> -};
> -
>  /*
>   * The in-memory structure used to track swap areas.
>   */
> @@ -300,7 +296,7 @@ struct swap_info_struct {
>         unsigned int    max;            /* extent of the swap_map */
>         unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
>         struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
> -       struct swap_cluster_list free_clusters; /* free clusters list */
> +       struct list_head free_clusters; /* free clusters list */
>         unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
>         unsigned int highest_bit;       /* index of last free in swap_map=
 */
>         unsigned int pages;             /* total of usable pages of swap =
*/
> @@ -333,7 +329,7 @@ struct swap_info_struct {
>                                          * list.
>                                          */
>         struct work_struct discard_work; /* discard worker */
> -       struct swap_cluster_list discard_clusters; /* discard clusters li=
st */
> +       struct list_head discard_clusters; /* discard clusters list */
>         struct plist_node avail_lists[]; /*
>                                            * entries in swap_avail_heads,=
 one
>                                            * entry per node.
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4f0e8b2ac8aa..205a60c5f9cb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -290,64 +290,11 @@ static void discard_swap_cluster(struct swap_info_s=
truct *si,
>  #endif
>  #define LATENCY_LIMIT          256
>
> -static inline void cluster_set_flag(struct swap_cluster_info *info,
> -       unsigned int flag)
> -{
> -       info->flags =3D flag;
> -}
> -
> -static inline unsigned int cluster_count(struct swap_cluster_info *info)
> -{
> -       return info->data;
> -}
> -
> -static inline void cluster_set_count(struct swap_cluster_info *info,
> -                                    unsigned int c)
> -{
> -       info->data =3D c;
> -}
> -
> -static inline void cluster_set_count_flag(struct swap_cluster_info *info=
,
> -                                        unsigned int c, unsigned int f)
> -{
> -       info->flags =3D f;
> -       info->data =3D c;
> -}
> -
> -static inline unsigned int cluster_next(struct swap_cluster_info *info)
> -{
> -       return info->data;
> -}
> -
> -static inline void cluster_set_next(struct swap_cluster_info *info,
> -                                   unsigned int n)
> -{
> -       info->data =3D n;
> -}
> -
> -static inline void cluster_set_next_flag(struct swap_cluster_info *info,
> -                                        unsigned int n, unsigned int f)
> -{
> -       info->flags =3D f;
> -       info->data =3D n;
> -}
> -
>  static inline bool cluster_is_free(struct swap_cluster_info *info)
>  {
>         return info->flags & CLUSTER_FLAG_FREE;
>  }
>
> -static inline bool cluster_is_null(struct swap_cluster_info *info)
> -{
> -       return info->flags & CLUSTER_FLAG_NEXT_NULL;
> -}
> -
> -static inline void cluster_set_null(struct swap_cluster_info *info)
> -{
> -       info->flags =3D CLUSTER_FLAG_NEXT_NULL;
> -       info->data =3D 0;
> -}
> -
>  static inline struct swap_cluster_info *lock_cluster(struct swap_info_st=
ruct *si,
>                                                      unsigned long offset=
)
>  {
> @@ -394,65 +341,11 @@ static inline void unlock_cluster_or_swap_info(stru=
ct swap_info_struct *si,
>                 spin_unlock(&si->lock);
>  }
>
> -static inline bool cluster_list_empty(struct swap_cluster_list *list)
> -{
> -       return cluster_is_null(&list->head);
> -}
> -
> -static inline unsigned int cluster_list_first(struct swap_cluster_list *=
list)
> -{
> -       return cluster_next(&list->head);
> -}
> -
> -static void cluster_list_init(struct swap_cluster_list *list)
> -{
> -       cluster_set_null(&list->head);
> -       cluster_set_null(&list->tail);
> -}
> -
> -static void cluster_list_add_tail(struct swap_cluster_list *list,
> -                                 struct swap_cluster_info *ci,
> -                                 unsigned int idx)
> -{
> -       if (cluster_list_empty(list)) {
> -               cluster_set_next_flag(&list->head, idx, 0);
> -               cluster_set_next_flag(&list->tail, idx, 0);
> -       } else {
> -               struct swap_cluster_info *ci_tail;
> -               unsigned int tail =3D cluster_next(&list->tail);
> -
> -               /*
> -                * Nested cluster lock, but both cluster locks are
> -                * only acquired when we held swap_info_struct->lock
> -                */
> -               ci_tail =3D ci + tail;
> -               spin_lock_nested(&ci_tail->lock, SINGLE_DEPTH_NESTING);
> -               cluster_set_next(ci_tail, idx);
> -               spin_unlock(&ci_tail->lock);
> -               cluster_set_next_flag(&list->tail, idx, 0);
> -       }
> -}
> -
> -static unsigned int cluster_list_del_first(struct swap_cluster_list *lis=
t,
> -                                          struct swap_cluster_info *ci)
> -{
> -       unsigned int idx;
> -
> -       idx =3D cluster_next(&list->head);
> -       if (cluster_next(&list->tail) =3D=3D idx) {
> -               cluster_set_null(&list->head);
> -               cluster_set_null(&list->tail);
> -       } else
> -               cluster_set_next_flag(&list->head,
> -                                     cluster_next(&ci[idx]), 0);
> -
> -       return idx;
> -}
> -
>  /* Add a cluster to discard list and schedule it to do discard */
>  static void swap_cluster_schedule_discard(struct swap_info_struct *si,
> -               unsigned int idx)
> +               struct swap_cluster_info *ci)
>  {
> +       unsigned int idx =3D ci - si->cluster_info;
>         /*
>          * If scan_swap_map_slots() can't find a free cluster, it will ch=
eck
>          * si->swap_map directly. To make sure the discarding cluster isn=
't
> @@ -462,17 +355,16 @@ static void swap_cluster_schedule_discard(struct sw=
ap_info_struct *si,
>         memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>                         SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>
> -       cluster_list_add_tail(&si->discard_clusters, si->cluster_info, id=
x);
> -
> +       spin_lock_nested(&ci->lock, SINGLE_DEPTH_NESTING);
> +       list_add_tail(&ci->next, &si->discard_clusters);
> +       spin_unlock(&ci->lock);
>         schedule_work(&si->discard_work);
>  }
>
> -static void __free_cluster(struct swap_info_struct *si, unsigned long id=
x)
> +static void __free_cluster(struct swap_info_struct *si, struct swap_clus=
ter_info *ci)
>  {
> -       struct swap_cluster_info *ci =3D si->cluster_info;
> -
> -       cluster_set_flag(ci + idx, CLUSTER_FLAG_FREE);
> -       cluster_list_add_tail(&si->free_clusters, ci, idx);
> +       ci->flags =3D CLUSTER_FLAG_FREE;
> +       list_add_tail(&ci->next, &si->free_clusters);
>  }
>
>  /*
> @@ -481,21 +373,21 @@ static void __free_cluster(struct swap_info_struct =
*si, unsigned long idx)
>  */
>  static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  {
> -       struct swap_cluster_info *info, *ci;
> +       struct swap_cluster_info *ci;
>         unsigned int idx;
>
> -       info =3D si->cluster_info;
> -
> -       while (!cluster_list_empty(&si->discard_clusters)) {
> -               idx =3D cluster_list_del_first(&si->discard_clusters, inf=
o);
> +       while (!list_empty(&si->discard_clusters)) {
> +               ci =3D list_first_entry(&si->discard_clusters, struct swa=
p_cluster_info, next);
> +               idx =3D ci - si->cluster_info;
>                 spin_unlock(&si->lock);
>
>                 discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
>                                 SWAPFILE_CLUSTER);
>
>                 spin_lock(&si->lock);
> -               ci =3D lock_cluster(si, idx * SWAPFILE_CLUSTER);
> -               __free_cluster(si, idx);
> +
> +               spin_lock(&ci->lock);
> +               __free_cluster(si, ci);
>                 memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>                                 0, SWAPFILE_CLUSTER);
>                 unlock_cluster(ci);
> @@ -521,20 +413,20 @@ static void swap_users_ref_free(struct percpu_ref *=
ref)
>         complete(&si->comp);
>  }
>
> -static void alloc_cluster(struct swap_info_struct *si, unsigned long idx=
)
> +static struct swap_cluster_info *alloc_cluster(struct swap_info_struct *=
si, unsigned long idx)
>  {
> -       struct swap_cluster_info *ci =3D si->cluster_info;
> +       struct swap_cluster_info *ci =3D list_first_entry(&si->free_clust=
ers, struct swap_cluster_info, next);
>
> -       VM_BUG_ON(cluster_list_first(&si->free_clusters) !=3D idx);
> -       cluster_list_del_first(&si->free_clusters, ci);
> -       cluster_set_count_flag(ci + idx, 0, 0);
> +       VM_BUG_ON(ci - si->cluster_info !=3D idx);
> +       list_del(&ci->next);
> +       ci->count =3D 0;
> +       ci->flags =3D 0;
> +       return ci;
>  }
>
> -static void free_cluster(struct swap_info_struct *si, unsigned long idx)
> +static void free_cluster(struct swap_info_struct *si, struct swap_cluste=
r_info *ci)
>  {
> -       struct swap_cluster_info *ci =3D si->cluster_info + idx;
> -
> -       VM_BUG_ON(cluster_count(ci) !=3D 0);
> +       VM_BUG_ON(ci->count !=3D 0);
>         /*
>          * If the swap is discardable, prepare discard the cluster
>          * instead of free it immediately. The cluster will be freed
> @@ -542,11 +434,11 @@ static void free_cluster(struct swap_info_struct *s=
i, unsigned long idx)
>          */
>         if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) =3D=3D
>             (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
> -               swap_cluster_schedule_discard(si, idx);
> +               swap_cluster_schedule_discard(si, ci);
>                 return;
>         }
>
> -       __free_cluster(si, idx);
> +       __free_cluster(si, ci);
>  }
>
>  /*
> @@ -559,15 +451,15 @@ static void add_cluster_info_page(struct swap_info_=
struct *p,
>         unsigned long count)
>  {
>         unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> +       struct swap_cluster_info *ci =3D cluster_info + idx;
>
>         if (!cluster_info)
>                 return;
> -       if (cluster_is_free(&cluster_info[idx]))
> +       if (cluster_is_free(ci))
>                 alloc_cluster(p, idx);
>
> -       VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CL=
USTER);
> -       cluster_set_count(&cluster_info[idx],
> -               cluster_count(&cluster_info[idx]) + count);
> +       VM_BUG_ON(ci->count + count > SWAPFILE_CLUSTER);
> +       ci->count +=3D count;
>  }
>
>  /*
> @@ -581,24 +473,20 @@ static void inc_cluster_info_page(struct swap_info_=
struct *p,
>  }
>
>  /*
> - * The cluster corresponding to page_nr decreases one usage. If the usag=
e
> - * counter becomes 0, which means no page in the cluster is in using, we=
 can
> - * optionally discard the cluster and add it to free cluster list.
> + * The cluster ci decreases one usage. If the usage counter becomes 0,
> + * which means no page in the cluster is in using, we can optionally dis=
card
> + * the cluster and add it to free cluster list.
>   */
> -static void dec_cluster_info_page(struct swap_info_struct *p,
> -       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static void dec_cluster_info_page(struct swap_info_struct *p, struct swa=
p_cluster_info *ci)
>  {
> -       unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> -
> -       if (!cluster_info)
> +       if (!p->cluster_info)
>                 return;
>
> -       VM_BUG_ON(cluster_count(&cluster_info[idx]) =3D=3D 0);
> -       cluster_set_count(&cluster_info[idx],
> -               cluster_count(&cluster_info[idx]) - 1);
> +       VM_BUG_ON(ci->count =3D=3D 0);
> +       ci->count--;
>
> -       if (cluster_count(&cluster_info[idx]) =3D=3D 0)
> -               free_cluster(p, idx);
> +       if (!ci->count)
> +               free_cluster(p, ci);
>  }
>
>  /*
> @@ -611,10 +499,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info=
_struct *si,
>  {

This whole scan_swap_map_ssd_cluster_conflict function seems not
needed now. free_clusters is a double linked list, so using a cluster
in the middle won't corrupt the list. The comments are still for the
old list design.

>         struct percpu_cluster *percpu_cluster;
>         bool conflict;
> -
> +       struct swap_cluster_info *first =3D list_first_entry(&si->free_cl=
usters, struct swap_cluster_info, next);
>         offset /=3D SWAPFILE_CLUSTER;
> -       conflict =3D !cluster_list_empty(&si->free_clusters) &&
> -               offset !=3D cluster_list_first(&si->free_clusters) &&
> +       conflict =3D !list_empty(&si->free_clusters) &&
> +               offset !=3D  first - si->cluster_info &&
>                 cluster_is_free(&si->cluster_info[offset]);
>
>         if (!conflict)
> @@ -655,10 +543,14 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
>         cluster =3D this_cpu_ptr(si->percpu_cluster);
>         tmp =3D cluster->next[order];
>         if (tmp =3D=3D SWAP_NEXT_INVALID) {
> -               if (!cluster_list_empty(&si->free_clusters)) {
> -                       tmp =3D cluster_next(&si->free_clusters.head) *
> -                                       SWAPFILE_CLUSTER;
> -               } else if (!cluster_list_empty(&si->discard_clusters)) {
> +               if (!list_empty(&si->free_clusters)) {
> +                       ci =3D list_first_entry(&si->free_clusters, struc=
t swap_cluster_info, next);
> +                       list_del(&ci->next);
> +                       spin_lock(&ci->lock);

Shouldn't this list_del also be protected by ci->lock? It was
protected in alloc_cluster before, keeping the flag synced with
cluster status so cluster_is_free won't return false positive.

> +                       ci->flags =3D 0;
> +                       spin_unlock(&ci->lock);
> +                       tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
> +               } else if (!list_empty(&si->discard_clusters)) {
>                         /*
>                          * we don't have free cluster but have some clust=
ers in
>                          * discarding, do discard now and reclaim them, t=
hen
> @@ -670,7 +562,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap=
_info_struct *si,
>                         goto new_cluster;
>                 } else
>                         return false;
> -       }
> +       } else
> +               ci =3D si->cluster_info + tmp;

This "else ci =3D ..." seems wrong, tmp is not an array index, and not
needed either.

>
>         /*
>          * Other CPUs can use our cluster if they can't find a free clust=
er,
> @@ -1062,8 +955,9 @@ static void swap_free_cluster(struct swap_info_struc=
t *si, unsigned long idx)
>
>         ci =3D lock_cluster(si, offset);
>         memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> -       cluster_set_count_flag(ci, 0, 0);
> -       free_cluster(si, idx);
> +       ci->count =3D 0;
> +       ci->flags =3D 0;
> +       free_cluster(si, ci);
>         unlock_cluster(ci);
>         swap_range_free(si, offset, SWAPFILE_CLUSTER);
>  }
> @@ -1336,7 +1230,7 @@ static void swap_entry_free(struct swap_info_struct=
 *p, swp_entry_t entry)
>         count =3D p->swap_map[offset];
>         VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
>         p->swap_map[offset] =3D 0;
> -       dec_cluster_info_page(p, p->cluster_info, offset);
> +       dec_cluster_info_page(p, ci);
>         unlock_cluster(ci);
>
>         mem_cgroup_uncharge_swap(entry, 1);
> @@ -2985,8 +2879,8 @@ static int setup_swap_map_and_extents(struct swap_i=
nfo_struct *p,
>
>         nr_good_pages =3D maxpages - 1;   /* omit header page */
>
> -       cluster_list_init(&p->free_clusters);
> -       cluster_list_init(&p->discard_clusters);
> +       INIT_LIST_HEAD(&p->free_clusters);
> +       INIT_LIST_HEAD(&p->discard_clusters);
>
>         for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
>                 unsigned int page_nr =3D swap_header->info.badpages[i];
> @@ -3037,14 +2931,15 @@ static int setup_swap_map_and_extents(struct swap=
_info_struct *p,
>         for (k =3D 0; k < SWAP_CLUSTER_COLS; k++) {
>                 j =3D (k + col) % SWAP_CLUSTER_COLS;
>                 for (i =3D 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_=
COLS); i++) {
> +                       struct swap_cluster_info *ci;
>                         idx =3D i * SWAP_CLUSTER_COLS + j;
> +                       ci =3D cluster_info + idx;
>                         if (idx >=3D nr_clusters)
>                                 continue;
> -                       if (cluster_count(&cluster_info[idx]))
> +                       if (ci->count)
>                                 continue;
> -                       cluster_set_flag(&cluster_info[idx], CLUSTER_FLAG=
_FREE);
> -                       cluster_list_add_tail(&p->free_clusters, cluster_=
info,
> -                                             idx);
> +                       ci->flags =3D CLUSTER_FLAG_FREE;
> +                       list_add_tail(&ci->next, &p->free_clusters);
>                 }
>         }
>         return nr_extents;
>
> --
> 2.45.1.288.g0e0cd299f1-goog
>
>


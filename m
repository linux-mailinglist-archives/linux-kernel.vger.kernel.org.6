Return-Path: <linux-kernel+bounces-550322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F5AA55DF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAF27A4AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D832188CB1;
	Fri,  7 Mar 2025 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLEONpMb"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635C7E9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316113; cv=none; b=K6gGtyOJS8hkxXoYhUAKRPL489tXDQwurnePQc9UI80LsfLUW/wbCv+tl0vYBvmWmqyfWaTmNyDmzUrISj/rKenNSf3PA7OqU4G+ddhi94jv5G7pj7cbGZW0EhOlXn8gOM7VGUFAINlFUbasEqnQ7JkzPTRZPA9cohi3ox6gzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316113; c=relaxed/simple;
	bh=VBq2IgZI9D0AKAe6ooC3x4gOmHJkfFymfM7DJQ6d2Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQVTLbgchDD0pA1wSVE7RmRPqC+JD1SbCoYo3tWJLthbM52zLtddtfk0o2nUxgEBKm+2DMyDubY/rA7gdKx5wwuIisiiFyWFSSG8OLM80xvunG+PFm/a5pXL4pUPZBNbMa2nF5z5LIn9LstQbXyOmDS87dWVS+NPSQGyjuEeFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLEONpMb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54298ec925bso2130242e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 18:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741316109; x=1741920909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN5pGxv27rMK93LrFT9jrycN+OHSc/LcBOR7eKQ5OKA=;
        b=WLEONpMbo3qRiegDdYUanShDl1mXXQzdiSunfXNf6VREteL1VjE0BuFkl6pQAJgC6A
         6uAyvffkiZwlPVILoR/j93mvTmbPSwRX0wELo/34nBS/+lwyu4VP6WEeKrcMBixGy6dj
         AsDdyAIipjGBysKX4Vo1yy4avFQeWQa5mHYuRtRAloDFxexiyVBjJrAfaLfqKfXnnc9D
         L3hhkfjpqrLR82Y7I0P8pz8dcqhW1Xi4qE7URYwFwVNVEHBwbRUG/sMu/YheJvrLe4j7
         G12KJc4UfPhy452B/xvUxTfF+XufD7uPgL0oMa0244eEA3MkxX5Nf0LU0pitSYjxvGTJ
         Rf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741316109; x=1741920909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VN5pGxv27rMK93LrFT9jrycN+OHSc/LcBOR7eKQ5OKA=;
        b=RX49f5o2t81YcyMdERmNJ1Krv6eKojf+V7CAO/kWAGkANyIfjcLwM6JnS2+MpPL8Ex
         1CurjBEez+tnWIfNdqXExJySfBx+9P37L2M1oKmbky57l923x7AqUk+B8jNSTaiGcmi9
         Ei7ljSF2f6zE4QbX9cOICUHDZkECmSC1FZXZSfNlNNgojYsgC1KA5IZW0wQRlOVY5gsy
         Ee035dCB3mSgK40XP8hB99WT5KBajRxjHV9ODdDanEKfn7BYd3lPaT8+9pt935E+eb1/
         RsgC8fegcgXTW/7CeefuVBS7Kr4L9ZHpdkVIjo5tqVjfa8WzZuvwI9Z+CfXgl53YuEil
         Nxkw==
X-Forwarded-Encrypted: i=1; AJvYcCXecqoZgEiADOOQ8AYfWtT49JDcCP7wLZvMOYmyPksaIcUZZBs30GQGqz8n2lCknMK6idbzoOCUWUOlJBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWr7PMr/7XVemozekmeV6K6hRr48IBVjlLPcwYkmDj1hr3CsG
	uo0zDq3fC0guu1CEy5orz8iGcw49KmMDlUBHwMunhIX47uwAfWKsNgMclsc7noVBssIAt/yHr88
	2Ew9Sn+gI6HE4Bg5Y71m2pNErtS0=
X-Gm-Gg: ASbGncsnUuiW879/XT/ZprQwR+f04706cU/ZQnqfB40h9RsQlph8GPCejoMAXeKOZkQ
	8qrWskdBIhAqXyf+XUY8DpnG1E4QJYUlPoXnoE/AMU9W1rLz1jhSPIWbYtUZPtV/pseLqLRgnbm
	/F6uiUxdxu5vJq6Jt1ALOg16y+KQ==
X-Google-Smtp-Source: AGHT+IG1Quu/CAIbmiDVApj6Ycq7SILX5FBBMwib1CJAPLOffS+9Ob9igHMO8fRt+EiDfihBeXa8pKJe2Fs0CRTOnz4=
X-Received: by 2002:a05:6512:281b:b0:545:2c40:ec1d with SMTP id
 2adb3069b0e04-549910d721dmr515928e87.44.1741316109039; Thu, 06 Mar 2025
 18:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224180212.22802-1-ryncsn@gmail.com> <20250224180212.22802-6-ryncsn@gmail.com>
In-Reply-To: <20250224180212.22802-6-ryncsn@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 7 Mar 2025 10:54:52 +0800
X-Gm-Features: AQ5f1JpfoeQtaOACR7LCx-R8WU-mOtOoshrIjrK21jHGDTWrf10WFIb8Xaj0XTo
Message-ID: <CAMgjq7AkRmb5ote-VZErM_2UdEC575j9WcrstcQOypEb+T-DLA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] mm, swap: use percpu cluster as allocation fast path
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Current allocation workflow first traverses the plist with a global lock
> held, after choosing a device, it uses the percpu cluster on that swap
> device. This commit moves the percpu cluster variable out of being tied
> to individual swap devices, making it a global percpu variable, and will
> be used directly for allocation as a fast path.
>
> The global percpu cluster variable will never point to a HDD device, and
> allocations on a HDD device are still globally serialized.
>
> This improves the allocator performance and prepares for removal of the
> slot cache in later commits. There shouldn't be much observable behavior
> change, except one thing: this changes how swap device allocation
> rotation works.
>
> Currently, each allocation will rotate the plist, and because of the
> existence of slot cache (one order 0 allocation usually returns 64
> entries), swap devices of the same priority are rotated for every 64
> order 0 entries consumed. High order allocations are different, they
> will bypass the slot cache, and so swap device is rotated for every
> 16K, 32K, or up to 2M allocation.
>
> The rotation rule was never clearly defined or documented, it was changed
> several times without mentioning.
>
> After this commit, and once slot cache is gone in later commits, swap
> device rotation will happen for every consumed cluster. Ideally non-HDD
> devices will be rotated if 2M space has been consumed for each order.
> Fragmented clusters will rotate the device faster, which seems OK.
> HDD devices is rotated for every allocation regardless of the allocation
> order, which should be OK too and trivial.
>
> This commit also slightly changes allocation behaviour for slot cache.
> The new added cluster allocation fast path may allocate entries from
> different device to the slot cache, this is not observable from user
> space, only impact performance very slightly, and slot cache will be
> just gone in next commit, so this can be ignored.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h |  11 ++--
>  mm/swapfile.c        | 136 +++++++++++++++++++++++++++++--------------
>  2 files changed, 95 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2fe91c293636..374bffc87427 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -284,12 +284,10 @@ enum swap_cluster_flags {
>  #endif
>
>  /*
> - * We assign a cluster to each CPU, so each CPU can allocate swap entry =
from
> - * its own cluster and swapout sequentially. The purpose is to optimize =
swapout
> - * throughput.
> + * We keep using same cluster for rotational device so IO will be sequen=
tial.
> + * The purpose is to optimize SWAP throughput on these device.
>   */
> -struct percpu_cluster {
> -       local_lock_t lock; /* Protect the percpu_cluster above */
> +struct swap_sequential_cluster {
>         unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
>  };
>
> @@ -315,8 +313,7 @@ struct swap_info_struct {
>         atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];
>         unsigned int pages;             /* total of usable pages of swap =
*/
>         atomic_long_t inuse_pages;      /* number of those currently in u=
se */
> -       struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap=
 location */
> -       struct percpu_cluster *global_cluster; /* Use one global cluster =
for rotating device */
> +       struct swap_sequential_cluster *global_cluster; /* Use one global=
 cluster for rotating device */
>         spinlock_t global_cluster_lock; /* Serialize usage of global clus=
ter */
>         struct rb_root swap_extent_root;/* root of the swap extent rbtree=
 */
>         struct block_device *bdev;      /* swap device or bdev of swap fi=
le */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index db836670c334..7caaaea95408 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -116,6 +116,18 @@ static atomic_t proc_poll_event =3D ATOMIC_INIT(0);
>
>  atomic_t nr_rotate_swap =3D ATOMIC_INIT(0);
>
> +struct percpu_swap_cluster {
> +       struct swap_info_struct *si[SWAP_NR_ORDERS];
> +       unsigned long offset[SWAP_NR_ORDERS];
> +       local_lock_t lock;
> +};
> +
> +static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) =
=3D {
> +       .si =3D { NULL },
> +       .offset =3D { SWAP_ENTRY_INVALID },
> +       .lock =3D INIT_LOCAL_LOCK(),
> +};
> +
>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>  {
>         if (type >=3D MAX_SWAPFILES)
> @@ -539,7 +551,7 @@ static bool swap_do_scheduled_discard(struct swap_inf=
o_struct *si)
>                 ci =3D list_first_entry(&si->discard_clusters, struct swa=
p_cluster_info, list);
>                 /*
>                  * Delete the cluster from list to prepare for discard, b=
ut keep
> -                * the CLUSTER_FLAG_DISCARD flag, there could be percpu_c=
luster
> +                * the CLUSTER_FLAG_DISCARD flag, percpu_swap_cluster cou=
ld be
>                  * pointing to it, or ran into by relocate_cluster.
>                  */
>                 list_del(&ci->list);
> @@ -805,10 +817,12 @@ static unsigned int alloc_swap_scan_cluster(struct =
swap_info_struct *si,
>  out:
>         relocate_cluster(si, ci);
>         unlock_cluster(ci);
> -       if (si->flags & SWP_SOLIDSTATE)
> -               __this_cpu_write(si->percpu_cluster->next[order], next);
> -       else
> +       if (si->flags & SWP_SOLIDSTATE) {
> +               __this_cpu_write(percpu_swap_cluster.si[order], si);
> +               __this_cpu_write(percpu_swap_cluster.offset[order], next)=
;
> +       } else {
>                 si->global_cluster->next[order] =3D next;
> +       }
>         return found;
>  }
>
> @@ -862,9 +876,8 @@ static void swap_reclaim_work(struct work_struct *wor=
k)
>  }
>
>  /*
> - * Try to get swap entries with specified order from current cpu's swap =
entry
> - * pool (a cluster). This might involve allocating a new cluster for cur=
rent CPU
> - * too.
> + * Try to allocate swap entries with specified order and try set a new
> + * cluster for current CPU too.
>   */
>  static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *s=
i, int order,
>                                               unsigned char usage)
> @@ -872,18 +885,12 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>         struct swap_cluster_info *ci;
>         unsigned int offset, found =3D 0;
>
> -       if (si->flags & SWP_SOLIDSTATE) {
> -               /* Fast path using per CPU cluster */
> -               local_lock(&si->percpu_cluster->lock);
> -               offset =3D __this_cpu_read(si->percpu_cluster->next[order=
]);
> -       } else {
> +       if (!(si->flags & SWP_SOLIDSTATE)) {
>                 /* Serialize HDD SWAP allocation for each device. */
>                 spin_lock(&si->global_cluster_lock);
>                 offset =3D si->global_cluster->next[order];
> -       }
> -
> -       if (offset) {
>                 ci =3D lock_cluster(si, offset);
> +
>                 /* Cluster could have been used by another order */
>                 if (cluster_is_usable(ci, order)) {
>                         if (cluster_is_empty(ci))
> @@ -973,9 +980,7 @@ static unsigned long cluster_alloc_swap_entry(struct =
swap_info_struct *si, int o
>                 }
>         }
>  done:
> -       if (si->flags & SWP_SOLIDSTATE)
> -               local_unlock(&si->percpu_cluster->lock);
> -       else
> +       if (!(si->flags & SWP_SOLIDSTATE))
>                 spin_unlock(&si->global_cluster_lock);
>         return found;
>  }
> @@ -1196,6 +1201,49 @@ static bool get_swap_device_info(struct swap_info_=
struct *si)
>         return true;
>  }
>
> +/*
> + * Fast path try to get swap entries with specified order from current
> + * CPU's swap entry pool (a cluster).
> + */
> +static int swap_alloc_fast(swp_entry_t entries[],
> +                          unsigned char usage,
> +                          int order, int n_goal)
> +{
> +       struct swap_cluster_info *ci;
> +       struct swap_info_struct *si;
> +       unsigned int offset, found;
> +       int n_ret =3D 0;
> +
> +       n_goal =3D min(n_goal, SWAP_BATCH);
> +
> +       /*
> +        * Once allocated, swap_info_struct will never be completely free=
d,
> +        * so checking it's liveness by get_swap_device_info is enough.
> +        */
> +       si =3D __this_cpu_read(percpu_swap_cluster.si[order]);
> +       offset =3D __this_cpu_read(percpu_swap_cluster.offset[order]);
> +       if (!si || !offset || !get_swap_device_info(si))
> +               return 0;

Found one issue with this intermediate patch, "si" will be reused upon
swapoff & swapon again. So after the reuse, get_swap_device_info()
returns true and `offset` is not 0, but `offset` is invalid, it could
point to a value larger than si->max if the previous device is larger.

To fix it, need to squash this onto it:

(also include a code fix for cluster_is_usable check, this code error
is fixed by 7/7 but shouldn't be here in the first place)
(replacing __this_cpu_xx with this_cpu_xx because the swapoff flush
will access other CPU's variable now)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7caaaea95408..68b40e74be93 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -818,8 +818,8 @@ static unsigned int alloc_swap_scan_cluster(struct
swap_info_struct *si,
        relocate_cluster(si, ci);
        unlock_cluster(ci);
        if (si->flags & SWP_SOLIDSTATE) {
-               __this_cpu_write(percpu_swap_cluster.si[order], si);
-               __this_cpu_write(percpu_swap_cluster.offset[order], next);
+               this_cpu_write(percpu_swap_cluster.si[order], si);
+               this_cpu_write(percpu_swap_cluster.offset[order], next);
        } else {
                si->global_cluster->next[order] =3D next;
        }
@@ -1220,15 +1220,17 @@ static int swap_alloc_fast(swp_entry_t entries[],
         * Once allocated, swap_info_struct will never be completely freed,
         * so checking it's liveness by get_swap_device_info is enough.
         */
-       si =3D __this_cpu_read(percpu_swap_cluster.si[order]);
-       offset =3D __this_cpu_read(percpu_swap_cluster.offset[order]);
+       si =3D this_cpu_read(percpu_swap_cluster.si[order]);
+       offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
        if (!si || !offset || !get_swap_device_info(si))
                return 0;

        while (offset) {
                ci =3D lock_cluster(si, offset);
-               if (!cluster_is_usable(ci, order))
+               if (!cluster_is_usable(ci, order)) {
+                       unlock_cluster(ci);
                        break;
+               }
                if (cluster_is_empty(ci))
                        offset =3D cluster_offset(si, ci);
                found =3D alloc_swap_scan_cluster(si, ci, offset, order, us=
age);
@@ -1237,7 +1239,7 @@ static int swap_alloc_fast(swp_entry_t entries[],
                entries[n_ret++] =3D swp_entry(si->type, found);
                if (n_ret =3D=3D n_goal)
                        break;
-               offset =3D __this_cpu_read(percpu_swap_cluster.offset[order=
]);
+               offset =3D this_cpu_read(percpu_swap_cluster.offset[order])=
;
        }

        put_swap_device(si);
@@ -2660,6 +2662,27 @@ static void wait_for_allocation(struct
swap_info_struct *si)
        }
 }

+/*
+ * Called after swap devices reference count is dead, so
+ * neither scan or allocation will go into it.
+ */
+static void flush_percpu_swap_cluster(struct swap_info_struct *si)
+{
+       int cpu;
+       struct swap_info_struct **pcp_si;
+
+       for_each_possible_cpu(cpu) {
+               pcp_si =3D per_cpu_ptr(percpu_swap_cluster.si, cpu);
+               /*
+                * Invalidate the percpu swap cluster, si->users
+                * is dead, so no new users will point to it, flush any
+                * existing cache is enough.
+                */
+               cmpxchg(pcp_si, si, NULL);
+       }
+}
+
+
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
        struct swap_info_struct *p =3D NULL;
@@ -2761,6 +2784,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, special=
file)

        flush_work(&p->discard_work);
        flush_work(&p->reclaim_work);
+       flush_percpu_swap_cluster(p);

        destroy_swap_extents(p);
        if (p->flags & SWP_CONTINUED)

---

There will be minor conflict in the next commit after this squash, I
will send a V3 shortly to resolve this if there is no objection on
this.


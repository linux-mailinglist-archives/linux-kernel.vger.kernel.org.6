Return-Path: <linux-kernel+bounces-177257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A28C3C10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016BF1F21A14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2FA146A91;
	Mon, 13 May 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdgExmYV"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5B146A83
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585416; cv=none; b=gOTxirbMd4VKeSCq28XWBnieul+pYquO4X/VgXSWgvK93Yyu7eHCyVeoH+fg9Jt5i+f2jOY5C1qPSeqbm3BRbz9LzILvHZCBmkelO9pPn92k23kbWe4nA0GSyLv8FQ2TGEVQlOviHFRL/0WeHaYD6VHRvqcwm2Nyxmwdet8ZhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585416; c=relaxed/simple;
	bh=gmqcycdpcxsqPnN7dUR+5NQEwcRYje18enSyOPPyee4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5XXLQw50swqFWYaF5EP9DLibfcTb7O1wf+Ilbhr78UKtKJCx6w8v0wZVruiG658Tci5Yul1mhwT+BsVyZSSPCWHLukDfwhs5HLlB2SNp4Kqi3EAgIIy5qgqLVAaJd8Gu5Z7eMq0SEUfq8eFJPQz9TWp6VeMDymDevljMD9kV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdgExmYV; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4df9b70d647so567560e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715585413; x=1716190213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7MVXlasaqRqBxvZbiRSfdDxfyGfaNmZTQnwh8eaaqw=;
        b=MdgExmYV2hGKYQmeXH69Kfgzmg6/wq6FcwIZRQZSSouJgF9b2CO85R+xRUS68ciXVF
         i0zpr/HWjyhOx2v+5tmTFax6jNzcoxGS7kJegYL+8J4tTpXYbYRNVva+vvrUveKGQdhv
         /1CUBACrnEMhxJRiWtSXTCa3HSS7cKZn6V7wkrvsDw331ODuwyv21T2RbOwAOyW5oiz3
         lPzOrKOhDdJV2HP/y/V34D59ht/Zhtigjvo31bKu8nt63OyGRSi1A6xliTxUdGsuE9r3
         x01k9CSXfG0MjxjtgYIa/zvytdT0CY9XPH0AlNcOD3WlQHZDKKnPSWoBNcwhZ/jNCzSK
         mnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585413; x=1716190213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7MVXlasaqRqBxvZbiRSfdDxfyGfaNmZTQnwh8eaaqw=;
        b=d7t32+pKJv+h8fPMw3cF5CpnfIq4IcUxl1Ydbgz5AKmPycihhuXxKjvhXRcT5BfjVH
         XrX44OjfPE2yGhJVggdlfZEEn3e7KltaC+eUKS1zvvKwHkmYLMZC9l3rjSvghpu9CC5Q
         pBv9V+k+jWj9TQVCNXbLpWOi+hq5bLE2Sz+7nSbNBSAY6uDYChCLrEnK/RUSv8ThUZxq
         S0waIxuM0hQSwUOQAyv8a+PYn2YwPobaXVHv6gsFhLOZCTfex1wnmH+v9eIFrhfzaJjZ
         iXZ8XVLAr23nR3TKfF4CztCDLht0tTaeA5FbWhq/iGptBtvlbyC3ao5+8tpRTYRaIuy7
         8ZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMEtPEfObsDieACqgC+4iZNYVD/YElPZGRErQ5xbQx5wYrQYbxCIbVJ+DuOVuisewfk+daPpWgKE3QQyALY1ptJYjP/8ILtN77tRPj
X-Gm-Message-State: AOJu0YzBzbRJWA6BKu2+1roYnWlJH/nN60qidu3MzBIMoX+U+uH5zdrV
	1b9d7wGfzfKPQbSpNPUispdwvj4IfRt4HhKXdEMVdhoTP2B8FmYkSIEF8L3UMx3jQR+KN9UXTNF
	OkObWd6EQqHpzF1AKl/uGasJCcQQ=
X-Google-Smtp-Source: AGHT+IGcbdFURUIeIMJzz8DQU6sH8nqQvbEoyc5/RnSKRlLbEyNg2Vf5Jgf84i+r0BLPqSo+pEewAdeLgXSocNcQwaY=
X-Received: by 2002:a05:6122:98b:b0:4d3:3b1b:aa92 with SMTP id
 71dfb90a1353d-4df8833c02bmr6757057e0c.11.1715585412835; Mon, 13 May 2024
 00:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408183946.2991168-1-ryan.roberts@arm.com> <20240408183946.2991168-6-ryan.roberts@arm.com>
In-Reply-To: <20240408183946.2991168-6-ryan.roberts@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 13 May 2024 19:30:01 +1200
Message-ID: <CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] mm: swap: Allow storage of all mTHP orders
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> Multi-size THP enables performance improvements by allocating large,
> pte-mapped folios for anonymous memory. However I've observed that on an
> arm64 system running a parallel workload (e.g. kernel compilation)
> across many cores, under high memory pressure, the speed regresses. This
> is due to bottlenecking on the increased number of TLBIs added due to
> all the extra folio splitting when the large folios are swapped out.
>
> Therefore, solve this regression by adding support for swapping out mTHP
> without needing to split the folio, just like is already done for
> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
> and when the swap backing store is a non-rotating block device. These
> are the same constraints as for the existing PMD-sized THP swap-out
> support.
>
> Note that no attempt is made to swap-in (m)THP here - this is still done
> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
> prerequisite for swapping-in mTHP.
>
> The main change here is to improve the swap entry allocator so that it
> can allocate any power-of-2 number of contiguous entries between [1, (1
> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> order and allocating sequentially from it until the cluster is full.
> This ensures that we don't need to search the map and we get no
> fragmentation due to alignment padding for different orders in the
> cluster. If there is no current cluster for a given order, we attempt to
> allocate a free cluster from the list. If there are no free clusters, we
> fail the allocation and the caller can fall back to splitting the folio
> and allocates individual entries (as per existing PMD-sized THP
> fallback).
>
> The per-order current clusters are maintained per-cpu using the existing
> infrastructure. This is done to avoid interleving pages from different
> tasks, which would prevent IO being batched. This is already done for
> the order-0 allocations so we follow the same pattern.
>
> As is done for order-0 per-cpu clusters, the scanner now can steal
> order-0 entries from any per-cpu-per-order reserved cluster. This
> ensures that when the swap file is getting full, space doesn't get tied
> up in the per-cpu reserves.
>
> This change only modifies swap to be able to accept any order mTHP. It
> doesn't change the callers to elide doing the actual split. That will be
> done in separate changes.
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h |   8 ++-
>  mm/swapfile.c        | 162 ++++++++++++++++++++++++-------------------
>  2 files changed, 98 insertions(+), 72 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b888e1080a94..11c53692f65f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>   */
>  #define SWAP_NEXT_INVALID      0
>
> +#ifdef CONFIG_THP_SWAP
> +#define SWAP_NR_ORDERS         (PMD_ORDER + 1)
> +#else
> +#define SWAP_NR_ORDERS         1
> +#endif
> +
>  /*
>   * We assign a cluster to each CPU, so each CPU can allocate swap entry =
from
>   * its own cluster and swapout sequentially. The purpose is to optimize =
swapout
>   * throughput.
>   */
>  struct percpu_cluster {
> -       unsigned int next; /* Likely next allocation offset */
> +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
>  };
>
>  struct swap_cluster_list {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d2e3d3cd439f..148ef08f19dd 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -551,10 +551,12 @@ static void free_cluster(struct swap_info_struct *s=
i, unsigned long idx)
>
>  /*
>   * The cluster corresponding to page_nr will be used. The cluster will b=
e
> - * removed from free cluster list and its usage counter will be increase=
d.
> + * removed from free cluster list and its usage counter will be increase=
d by
> + * count.
>   */
> -static void inc_cluster_info_page(struct swap_info_struct *p,
> -       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static void add_cluster_info_page(struct swap_info_struct *p,
> +       struct swap_cluster_info *cluster_info, unsigned long page_nr,
> +       unsigned long count)
>  {
>         unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
>
> @@ -563,9 +565,19 @@ static void inc_cluster_info_page(struct swap_info_s=
truct *p,
>         if (cluster_is_free(&cluster_info[idx]))
>                 alloc_cluster(p, idx);
>
> -       VM_BUG_ON(cluster_count(&cluster_info[idx]) >=3D SWAPFILE_CLUSTER=
);
> +       VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CL=
USTER);
>         cluster_set_count(&cluster_info[idx],
> -               cluster_count(&cluster_info[idx]) + 1);
> +               cluster_count(&cluster_info[idx]) + count);
> +}
> +
> +/*
> + * The cluster corresponding to page_nr will be used. The cluster will b=
e
> + * removed from free cluster list and its usage counter will be increase=
d by 1.
> + */
> +static void inc_cluster_info_page(struct swap_info_struct *p,
> +       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +{
> +       add_cluster_info_page(p, cluster_info, page_nr, 1);
>  }
>
>  /*
> @@ -595,7 +607,7 @@ static void dec_cluster_info_page(struct swap_info_st=
ruct *p,
>   */
>  static bool
>  scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> -       unsigned long offset)
> +       unsigned long offset, int order)
>  {
>         struct percpu_cluster *percpu_cluster;
>         bool conflict;
> @@ -609,24 +621,39 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info=
_struct *si,
>                 return false;
>
>         percpu_cluster =3D this_cpu_ptr(si->percpu_cluster);
> -       percpu_cluster->next =3D SWAP_NEXT_INVALID;
> +       percpu_cluster->next[order] =3D SWAP_NEXT_INVALID;
> +       return true;
> +}
> +
> +static inline bool swap_range_empty(char *swap_map, unsigned int start,
> +                                   unsigned int nr_pages)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (swap_map[start + i])
> +                       return false;
> +       }
> +
>         return true;
>  }
>
>  /*
> - * Try to get a swap entry from current cpu's swap entry pool (a cluster=
). This
> - * might involve allocating a new cluster for current CPU too.
> + * Try to get swap entries with specified order from current cpu's swap =
entry
> + * pool (a cluster). This might involve allocating a new cluster for cur=
rent CPU
> + * too.
>   */
>  static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> -       unsigned long *offset, unsigned long *scan_base)
> +       unsigned long *offset, unsigned long *scan_base, int order)
>  {
> +       unsigned int nr_pages =3D 1 << order;
>         struct percpu_cluster *cluster;
>         struct swap_cluster_info *ci;
>         unsigned int tmp, max;
>
>  new_cluster:
>         cluster =3D this_cpu_ptr(si->percpu_cluster);
> -       tmp =3D cluster->next;
> +       tmp =3D cluster->next[order];
>         if (tmp =3D=3D SWAP_NEXT_INVALID) {
>                 if (!cluster_list_empty(&si->free_clusters)) {
>                         tmp =3D cluster_next(&si->free_clusters.head) *
> @@ -647,26 +674,27 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
>
>         /*
>          * Other CPUs can use our cluster if they can't find a free clust=
er,
> -        * check if there is still free entry in the cluster
> +        * check if there is still free entry in the cluster, maintaining
> +        * natural alignment.
>          */
>         max =3D min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLU=
STER));
>         if (tmp < max) {
>                 ci =3D lock_cluster(si, tmp);
>                 while (tmp < max) {
> -                       if (!si->swap_map[tmp])
> +                       if (swap_range_empty(si->swap_map, tmp, nr_pages)=
)
>                                 break;
> -                       tmp++;
> +                       tmp +=3D nr_pages;
>                 }
>                 unlock_cluster(ci);
>         }
>         if (tmp >=3D max) {
> -               cluster->next =3D SWAP_NEXT_INVALID;
> +               cluster->next[order] =3D SWAP_NEXT_INVALID;
>                 goto new_cluster;
>         }
>         *offset =3D tmp;
>         *scan_base =3D tmp;
> -       tmp +=3D 1;
> -       cluster->next =3D tmp < max ? tmp : SWAP_NEXT_INVALID;
> +       tmp +=3D nr_pages;
> +       cluster->next[order] =3D tmp < max ? tmp : SWAP_NEXT_INVALID;
>         return true;
>  }
>
> @@ -796,13 +824,14 @@ static bool swap_offset_available_and_locked(struct=
 swap_info_struct *si,
>
>  static int scan_swap_map_slots(struct swap_info_struct *si,
>                                unsigned char usage, int nr,
> -                              swp_entry_t slots[])
> +                              swp_entry_t slots[], int order)
>  {
>         struct swap_cluster_info *ci;
>         unsigned long offset;
>         unsigned long scan_base;
>         unsigned long last_in_cluster =3D 0;
>         int latency_ration =3D LATENCY_LIMIT;
> +       unsigned int nr_pages =3D 1 << order;
>         int n_ret =3D 0;
>         bool scanned_many =3D false;
>
> @@ -817,6 +846,25 @@ static int scan_swap_map_slots(struct swap_info_stru=
ct *si,
>          * And we let swap pages go all over an SSD partition.  Hugh
>          */
>
> +       if (order > 0) {
> +               /*
> +                * Should not even be attempting large allocations when h=
uge
> +                * page swap is disabled.  Warn and fail the allocation.
> +                */
> +               if (!IS_ENABLED(CONFIG_THP_SWAP) ||
> +                   nr_pages > SWAPFILE_CLUSTER) {
> +                       VM_WARN_ON_ONCE(1);
> +                       return 0;
> +               }
> +
> +               /*
> +                * Swapfile is not block device or not using clusters so =
unable
> +                * to allocate large entries.
> +                */
> +               if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
> +                       return 0;
> +       }
> +
>         si->flags +=3D SWP_SCANNING;
>         /*
>          * Use percpu scan base for SSD to reduce lock contention on
> @@ -831,8 +879,11 @@ static int scan_swap_map_slots(struct swap_info_stru=
ct *si,
>
>         /* SSD algorithm */
>         if (si->cluster_info) {
> -               if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_bas=
e))
> +               if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_bas=
e, order)) {

Hi Ryan,

Sorry for bringing up an old thread.

During the initial hour of utilizing an Android phone with 64KiB mTHP,
we noticed that the
anon_swpout_fallback rate was less than 10%. However, after several
hours of phone
usage, we observed a significant increase in the anon_swpout_fallback
rate, reaching
100%.

As I checked the code of scan_swap_map_try_ssd_cluster(),

static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
        unsigned long *offset, unsigned long *scan_base, int order)
{
        unsigned int nr_pages =3D 1 << order;
        struct percpu_cluster *cluster;
        struct swap_cluster_info *ci;
        unsigned int tmp, max;

new_cluster:
        cluster =3D this_cpu_ptr(si->percpu_cluster);
        tmp =3D cluster->next[order];
        if (tmp =3D=3D SWAP_NEXT_INVALID) {
                if (!cluster_list_empty(&si->free_clusters)) {
                        tmp =3D cluster_next(&si->free_clusters.head) *
                                        SWAPFILE_CLUSTER;
                } else if (!cluster_list_empty(&si->discard_clusters)) {
                        /*
                         * we don't have free cluster but have some cluster=
s in
                         * discarding, do discard now and reclaim them, the=
n
                         * reread cluster_next_cpu since we dropped si->loc=
k
                         */
                        swap_do_scheduled_discard(si);
                        *scan_base =3D this_cpu_read(*si->cluster_next_cpu)=
;
                        *offset =3D *scan_base;
                        goto new_cluster;
                } else
                        return false;
        }
..

}

Considering the cluster_list_empty() checks, is it necessary to have
free_cluster to
ensure a continuous allocation of swap slots for large folio swap out?
For instance,
if numerous clusters still possess ample free swap slots, could we
potentially miss
out on them due to a lack of execution of a slow scan?

I'm not saying your patchset has problems, just that I have some questions.

Thanks
Barry


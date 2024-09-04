Return-Path: <linux-kernel+bounces-315991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8A96C98C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EAC1F266F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA2154BFF;
	Wed,  4 Sep 2024 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2PXI04D"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC43139D0B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485388; cv=none; b=Bx9cAwRLYTacd+6VAkzc/mEqPlndUhCyXVmgYsT1rHIGTeabV/vgYn0XPunByPh6eDtZq9xenc7ZyPnZT0iIAPuK+8titZFO3U+cESobZuJPXjUq3OoqCSNurNmRI6lOKaXH6ldrAtb89yNTSsflWfI+gGNhdfQzu1Wm9yVlYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485388; c=relaxed/simple;
	bh=CEFBBPjg6Dn00LpBavXK7p/gsO5NGfzlhXh214OclEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQZIn2sYD8oyvq+bmsQysyzkMV0v9B5iOGCth2WcWCeXjUpnRpzdvZGqOUYRfCi0qTiCJUXE5ULXXFk3wf8qeT845dX3wghn5wt8QuffnXIoSr3DdUS4z6UGmHQpcuroz7eeIOZ88z2ix96k19oQK4I7TgrlVmcaP4Q47XCWmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2PXI04D; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86abbd68ffso16691766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725485385; x=1726090185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPzCdvACsk+Zmurggn6HViLqvwkxy/s9QdT779lcBgY=;
        b=H2PXI04DdXMb0hEW9snJITtXpZXYq9Mf4CbI/r9h4r4rirsd7GHp2USOM8udoEUWuB
         PiLfC9Qe15MJOELpb4FHcREGxcu9EKI/dviEklGBepUgVTM1MKcfSB/kV0s4cguDOPOd
         a5xinqrqB95x+hbPmyNV25lWN7tEYbOr0/GuIlv4r440DUJDH3z4jV3fmC03q273FgdH
         PEU9cq37gSHlfBqna8VLOV4YCPUWmwte0EoHdirpZg67h9jXN8QH8dguumY+TVM3suog
         UznDFMpB+txEARrY1dFczOI7wPegPlpbKNKU4NJj9pkQA4P97bjYlWICwLxQlU2tkgU8
         t/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725485385; x=1726090185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPzCdvACsk+Zmurggn6HViLqvwkxy/s9QdT779lcBgY=;
        b=Zs74a6NuLUwze/KeOCRJeH4O3TUTPMbeXeQzZAH8U1G8xVl6aCg5bPBBhuGmtmfXTr
         JfiHW2WLmpKBnRsZJbIND1GfWFM+cAllAsT7vhbmr2nvfRI2gosIdl0F5+s0U4USWdVy
         MeBfC2Q3H8Lzxg/Yh4plyoYMC/+EHT2rbvblAZAYF0YjH7wQKDPV+zme3NonUuvQBv7C
         tkew3lrUu1JY5N3f6IvFQ7Pdm55yHs7HrSmH3YK7HsUtMBFL/xpTdiHP47rFCSfU6BSm
         fS7NQzSiBWAkllXaIntVO51p+yvg2r9q3bio5ekVbt1EOmCoGxrXhkCk9h4SRNaUyCt9
         mwLg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjqF/8oLWCxQGRTSUbqrPbCicAlS7DQJtBvFxwbjvUYCdNRk1oFjC4NVy8Kj5K2iHQmvXNRYussJ4qbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysUXrLi+95BbPGv9rqfCgEh73hJ+pnJGAWcdv1rES+2NuHU7RU
	P58cxx1gfCB+cmc3prC19AiznXe0rg5gsuDS9XQQnuIdSQd0Dbsmw4Vlw7UvfRprDoCAC8i58ap
	6hMDZUtF3dISJie2784VSFD1cwDPhIrmKrSRT
X-Google-Smtp-Source: AGHT+IFjzs/ukVqBdpAhaTS+2TK0e9/GZmzx60hOnSXxNVOe61C7h55BdbAOuOX+5o+K6ncCeF1fTMb/73d6Tamj6W8=
X-Received: by 2002:a17:907:3da1:b0:a86:aac8:53ad with SMTP id
 a640c23a62f3a-a8a430914d8mr334469466b.16.1725485384064; Wed, 04 Sep 2024
 14:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904162740.1043168-1-dave@stgolabs.net>
In-Reply-To: <20240904162740.1043168-1-dave@stgolabs.net>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 14:29:08 -0700
Message-ID: <CAJD7tkbksw1GquBout-JnLg=kCXmK6OUTvpu+8v7eyKQFUqsyQ@mail.gmail.com>
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
	rientjes@google.com, hannes@cmpxchg.org, almasrymina@google.com, 
	roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu, 
	a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:28=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.net> =
wrote:
>
> This adds support for allowing proactive reclaim in general on a
> NUMA system. A per-node interface extends support for beyond a
> memcg-specific interface, respecting the current semantics of
> memory.reclaim: respecting aging LRU and not supporting
> artificially triggering eviction on nodes belonging to non-bottom
> tiers.
>
> This patch allows userspace to do:
>
>      echo 512M swappiness=3D10 > /sys/devices/system/node/nodeX/reclaim
>
> One of the premises for this is to semantically align as best as
> possible with memory.reclaim. During a brief time memcg did
> support nodemask until 55ab834a86a9 (Revert "mm: add nodes=3D
> arg to memory.reclaim"), for which semantics around reclaim
> (eviction) vs demotion were not clear, rendering charging
> expectations to be broken.
>
> With this approach:
>
> 1. Users who do not use memcg can benefit from proactive reclaim.
>
> 2. Proactive reclaim on top tiers will trigger demotion, for which
> memory is still byte-addressable. Reclaiming on the bottom nodes
> will trigger evicting to swap (the traditional sense of reclaim).
> This follows the semantics of what is today part of the aging process
> on tiered memory, mirroring what every other form of reclaim does
> (reactive and memcg proactive reclaim). Furthermore per-node proactive
> reclaim is not as susceptible to the memcg charging problem mentioned
> above.
>
> 3. Unlike memcg, there should be no surprises of callers expecting
> reclaim but instead got a demotion. Essentially relying on behavior
> of shrink_folio_list() after 6b426d071419 (mm: disable top-tier
> fallback to reclaim on proactive reclaim), without the expectations
> of try_to_free_mem_cgroup_pages().
>
> 4. Unlike the nodes=3D arg, this interface avoids confusing semantics,
> such as what exactly the user wants when mixing top-tier and low-tier
> nodes in the nodemask. Further per-node interface is less exposed to
> "free up memory in my container" usecases, where eviction is intended.
>
> 5. Users that *really* want to free up memory can use proactive reclaim
> on nodes knowingly to be on the bottom tiers to force eviction in a
> natural way - higher access latencies are still better than swap.
> If compelled, while no guarantees and perhaps not worth the effort,
> users could also also potentially follow a ladder-like approach to
> eventually free up the memory. Alternatively, perhaps an 'evict' option
> could be added to the parameters for both memory.reclaim and per-node
> interfaces to force this action unconditionally.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>
> This topic has been brought up in the past without much resolution.
> But today, I believe a number of semantics and expectations have become
> clearer (per the changelog), which could merit revisiting this.
>
>  Documentation/ABI/stable/sysfs-devices-node |  11 ++
>  drivers/base/node.c                         |   2 +
>  include/linux/swap.h                        |  16 ++
>  mm/vmscan.c                                 | 154 ++++++++++++++++----
>  4 files changed, 156 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/=
ABI/stable/sysfs-devices-node
> index 402af4b2b905..5d69ee956cf9 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -221,3 +221,14 @@ Contact:   Jiaqi Yan <jiaqiyan@google.com>
>  Description:
>                 Of the raw poisoned pages on a NUMA node, how many pages =
are
>                 recovered by memory error recovery attempt.
> +
> +What:          /sys/devices/system/node/nodeX/reclaim
> +Date:          September 2024
> +Contact:       Linux Memory Management list <linux-mm@kvack.org>
> +Description:
> +               This is write-only nested-keyed file which accepts the nu=
mber of
> +               bytes to reclaim as well as the swappiness for this parti=
cular
> +               operation. Write the amount of bytes to induce memory rec=
laim in
> +               this node. When it completes successfully, the specified =
amount
> +               or more memory will have been reclaimed, and -EAGAIN if l=
ess
> +               bytes are reclaimed than the specified amount.
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index eb72580288e6..d8ed19f8565b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -626,6 +626,7 @@ static int register_node(struct node *node, int num)
>         } else {
>                 hugetlb_register_node(node);
>                 compaction_register_node(node);
> +               reclaim_register_node(node);
>         }
>
>         return error;
> @@ -642,6 +643,7 @@ void unregister_node(struct node *node)
>  {
>         hugetlb_unregister_node(node);
>         compaction_unregister_node(node);
> +       reclaim_unregister_node(node);
>         node_remove_accesses(node);
>         node_remove_caches(node);
>         device_unregister(&node->dev);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 248db1dd7812..456e3aedb964 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -423,6 +423,22 @@ extern unsigned long shrink_all_memory(unsigned long=
 nr_pages);
>  extern int vm_swappiness;
>  long remove_mapping(struct address_space *mapping, struct folio *folio);
>
> +#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
> +extern int reclaim_register_node(struct node *node);
> +extern void reclaim_unregister_node(struct node *node);
> +
> +#else
> +
> +static inline int reclaim_register_node(struct node *node)
> +{
> +       return 0;
> +}
> +
> +static inline void reclaim_unregister_node(struct node *node)
> +{
> +}
> +#endif /* CONFIG_SYSFS && CONFIG_NUMA */
> +
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim_mode;
>  extern int sysctl_min_unmapped_ratio;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5dc96a843466..56ddf54366e4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -56,6 +56,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/rculist_nulls.h>
>  #include <linux/random.h>
> +#include <linux/parser.h>
>
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -92,10 +93,8 @@ struct scan_control {
>         unsigned long   anon_cost;
>         unsigned long   file_cost;
>
> -#ifdef CONFIG_MEMCG
>         /* Swappiness value for proactive reclaim. Always use sc_swappine=
ss()! */
>         int *proactive_swappiness;
> -#endif
>
>         /* Can active folios be deactivated as part of reclaim? */
>  #define DEACTIVATE_ANON 1
> @@ -266,6 +265,9 @@ static bool writeback_throttling_sane(struct scan_con=
trol *sc)
>
>  static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *mem=
cg)
>  {
> +       if (sc->proactive && sc->proactive_swappiness)
> +               return *sc->proactive_swappiness;
> +

This code is already upstream, right?

>         return READ_ONCE(vm_swappiness);
>  }
>  #endif
> @@ -7470,36 +7472,28 @@ static unsigned long node_pagecache_reclaimable(s=
truct pglist_data *pgdat)
>  /*
>   * Try to free up some pages from this node through reclaim.
>   */
> -static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, uns=
igned int order)
> +static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask,
> +                         unsigned long nr_pages, struct scan_control *sc=
)
>  {
> -       /* Minimum pages needed in order to stay on node */
> -       const unsigned long nr_pages =3D 1 << order;
>         struct task_struct *p =3D current;
>         unsigned int noreclaim_flag;
> -       struct scan_control sc =3D {
> -               .nr_to_reclaim =3D max(nr_pages, SWAP_CLUSTER_MAX),
> -               .gfp_mask =3D current_gfp_context(gfp_mask),
> -               .order =3D order,
> -               .priority =3D NODE_RECLAIM_PRIORITY,
> -               .may_writepage =3D !!(node_reclaim_mode & RECLAIM_WRITE),
> -               .may_unmap =3D !!(node_reclaim_mode & RECLAIM_UNMAP),
> -               .may_swap =3D 1,
> -               .reclaim_idx =3D gfp_zone(gfp_mask),
> -       };
>         unsigned long pflags;
>
> -       trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
> -                                          sc.gfp_mask);
> +       trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, sc->order,
> +                                          sc->gfp_mask);
>
>         cond_resched();
> -       psi_memstall_enter(&pflags);
> +
> +       if (!sc->proactive)
> +               psi_memstall_enter(&pflags);
> +
>         delayacct_freepages_start();
> -       fs_reclaim_acquire(sc.gfp_mask);
> +       fs_reclaim_acquire(sc->gfp_mask);
>         /*
>          * We need to be able to allocate from the reserves for RECLAIM_U=
NMAP
>          */
>         noreclaim_flag =3D memalloc_noreclaim_save();
> -       set_task_reclaim_state(p, &sc.reclaim_state);
> +       set_task_reclaim_state(p, &sc->reclaim_state);
>
>         if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages=
 ||
>             node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) > pgdat->=
min_slab_pages) {
> @@ -7508,24 +7502,38 @@ static int __node_reclaim(struct pglist_data *pgd=
at, gfp_t gfp_mask, unsigned in
>                  * priorities until we have enough memory freed.
>                  */
>                 do {
> -                       shrink_node(pgdat, &sc);
> -               } while (sc.nr_reclaimed < nr_pages && --sc.priority >=3D=
 0);
> +                       shrink_node(pgdat, sc);
> +               } while (sc->nr_reclaimed < nr_pages && --sc->priority >=
=3D 0);
>         }
>
>         set_task_reclaim_state(p, NULL);
>         memalloc_noreclaim_restore(noreclaim_flag);
> -       fs_reclaim_release(sc.gfp_mask);
> -       psi_memstall_leave(&pflags);
> +       fs_reclaim_release(sc->gfp_mask);
>         delayacct_freepages_end();
>
> -       trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
> +       if (!sc->proactive)
> +               psi_memstall_leave(&pflags);
> +
> +       trace_mm_vmscan_node_reclaim_end(sc->nr_reclaimed);
>
> -       return sc.nr_reclaimed >=3D nr_pages;
> +       return sc->nr_reclaimed;
>  }
>
>  int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int=
 order)
>  {
>         int ret;
> +       /* Minimum pages needed in order to stay on node */
> +       const unsigned long nr_pages =3D 1 << order;
> +       struct scan_control sc =3D {
> +               .nr_to_reclaim =3D max(nr_pages, SWAP_CLUSTER_MAX),
> +               .gfp_mask =3D current_gfp_context(gfp_mask),
> +               .order =3D order,
> +               .priority =3D NODE_RECLAIM_PRIORITY,
> +               .may_writepage =3D !!(node_reclaim_mode & RECLAIM_WRITE),
> +               .may_unmap =3D !!(node_reclaim_mode & RECLAIM_UNMAP),
> +               .may_swap =3D 1,
> +               .reclaim_idx =3D gfp_zone(gfp_mask),
> +       };
>
>         /*
>          * Node reclaim reclaims unmapped file backed pages and
> @@ -7560,7 +7568,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t g=
fp_mask, unsigned int order)
>         if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
>                 return NODE_RECLAIM_NOSCAN;
>
> -       ret =3D __node_reclaim(pgdat, gfp_mask, order);
> +       ret =3D __node_reclaim(pgdat, gfp_mask, nr_pages, &sc) >=3D nr_pa=
ges;
>         clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
>
>         if (ret)
> @@ -7617,3 +7625,95 @@ void check_move_unevictable_folios(struct folio_ba=
tch *fbatch)
>         }
>  }
>  EXPORT_SYMBOL_GPL(check_move_unevictable_folios);
> +
> +#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
> +
> +enum {
> +       MEMORY_RECLAIM_SWAPPINESS =3D 0,
> +       MEMORY_RECLAIM_NULL,
> +};
> +
> +static const match_table_t tokens =3D {
> +       { MEMORY_RECLAIM_SWAPPINESS, "swappiness=3D%d"},
> +       { MEMORY_RECLAIM_NULL, NULL },
> +};
> +
> +static ssize_t reclaim_store(struct device *dev,
> +                            struct device_attribute *attr,
> +                            const char *buf, size_t count)
> +{
> +       int nid =3D dev->id;
> +       gfp_t gfp_mask =3D GFP_KERNEL;
> +       struct pglist_data *pgdat =3D NODE_DATA(nid);
> +       unsigned long nr_to_reclaim, nr_reclaimed =3D 0;
> +       unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
> +       int swappiness =3D -1;
> +       char *old_buf, *start;
> +       substring_t args[MAX_OPT_ARGS];
> +       struct scan_control sc =3D {
> +               .gfp_mask =3D current_gfp_context(gfp_mask),
> +               .reclaim_idx =3D gfp_zone(gfp_mask),
> +               .priority =3D DEF_PRIORITY,
> +               .may_writepage =3D !laptop_mode,
> +               .may_unmap =3D 1,
> +               .may_swap =3D 1,
> +               .proactive =3D 1,
> +       };
> +
> +       buf =3D strstrip((char *)buf);
> +
> +       old_buf =3D (char *)buf;
> +       nr_to_reclaim =3D memparse(buf, (char **)&buf) / PAGE_SIZE;
> +       if (buf =3D=3D old_buf)
> +               return -EINVAL;
> +
> +       buf =3D strstrip((char *)buf);
> +
> +       while ((start =3D strsep((char **)&buf, " ")) !=3D NULL) {
> +               if (!strlen(start))
> +                       continue;
> +               switch (match_token(start, tokens, args)) {
> +               case MEMORY_RECLAIM_SWAPPINESS:
> +                       if (match_int(&args[0], &swappiness))
> +                               return -EINVAL;
> +                       if (swappiness < MIN_SWAPPINESS || swappiness > M=
AX_SWAPPINESS)
> +                               return -EINVAL;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       sc.nr_to_reclaim =3D max(nr_to_reclaim, SWAP_CLUSTER_MAX);
> +       while (nr_reclaimed < nr_to_reclaim) {
> +               unsigned long reclaimed;
> +
> +               if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags)=
)
> +                       return -EAGAIN;

Can the PGDAT_RECLAIM_LOCKED check be moved into __node_reclaim()?
They are duplicated in node_reclaim().

> +
> +               /* does cond_resched() */
> +               reclaimed =3D __node_reclaim(pgdat, gfp_mask,
> +                                          nr_to_reclaim - nr_reclaimed, =
&sc);
> +
> +               clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
> +
> +               if (!reclaimed && !nr_retries--)
> +                       break;
> +
> +               nr_reclaimed +=3D reclaimed;
> +       }

In the memcg code (i.e. memory_reclaim()) we also check for pending
signals, and drain the LRUs before the last iteration. Do we need this
here as well?

This leads to my next question: there is a lot of common code with
memory_reclaim(). Should we refactor some of it? At least the
arguments parsing part looks almost identical.

> +
> +       return nr_reclaimed < nr_to_reclaim ? -EAGAIN : count;
> +}
> +
> +static DEVICE_ATTR_WO(reclaim);
> +int reclaim_register_node(struct node *node)
> +{
> +       return device_create_file(&node->dev, &dev_attr_reclaim);
> +}
> +
> +void reclaim_unregister_node(struct node *node)
> +{
> +       return device_remove_file(&node->dev, &dev_attr_reclaim);
> +}
> +#endif
> --
> 2.39.2
>


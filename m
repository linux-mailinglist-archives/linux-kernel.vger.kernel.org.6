Return-Path: <linux-kernel+bounces-277031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087AA949B57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADAD1C22AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9B171E61;
	Tue,  6 Aug 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce26DRAA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316177F08
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983684; cv=none; b=fOtiq/orxSf8y7o5qAIYzZbcUzINhR0WhGHW1cRQTt/c1tzc9AuqRIyPnasp9RMAMRLb64GnaQkagwj4BEd3N0eY1S7j63Q670pQbA2uSSJoiMoZTsZE4ZkyIPmdaSqzimV0uKclGLgmno8CTSYl6U1DKIjxLm8ZVySQvlH5Da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983684; c=relaxed/simple;
	bh=9BlY4E4ePvcqdL3NfePTvsR45IVw/d8Fz6LDj7H9RBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBiNHanhpsaRhsSRZYOOtKRVDCMhPmt984QwIDW3aH/rVs7ltSH0rUkrHVNE0Z4it0jJKBmUi5G86RdU7A6j8f1VcLcH5PwB+OSktSIYrCfzyujDatFr34VQxXTNYDEDJKXA67Idy92SELvut4iKd8rVSECjfsQKRT0e0HEGux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce26DRAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C3AC4AF13
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722983684;
	bh=9BlY4E4ePvcqdL3NfePTvsR45IVw/d8Fz6LDj7H9RBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ce26DRAA2QktSyXF1AY8jMhGFqkZwVcts2a6Q1y32J+GiSb58jfjAPuI7ObFShw2B
	 7c6aiZbKy+Jt307cEJiq/rKQyoAv07c2luf8kcfFUYw5+3sJhEI45r057eKZqrD6+n
	 kEFy/d0wTLdlXonnmqA1dW158Z1v4/UznOoC76BZq0rgJKQGhXHTPLyBMsSqxyQcBM
	 P1o9iMCRag2QSMD1J+TTFhFoLHr28wwgW2UnDzDYCk7oKuToXnd2Ax4uwui5gxr62p
	 RItnGS+uG5UqjoTKppWCWEQCu8kEQKQPWwDc9SGRgpWokviaBW7BytmA9pvQpb9YdL
	 9eCQ081Z2xzDw==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66599ca3470so11337537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:34:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHCtLlXDTABkDPCuehOoSFBQ/XfMiBn9/K913kXfWuJHVXUzjDQiv/3MhKZ87WhKm///hyDJLgTh4E1OrXfrVR8ah9dP2J7BROOHAc
X-Gm-Message-State: AOJu0Yw/k63dfdjwEPk/FoBwO9QUv6tPrFjGLdlTIfzLyvg6GrJ5+HkN
	gmOCzS8WyYPxGRUi0P/Aw5a6rMEAMNw5yal9e5zBJW+FTxiw9TQhjVk15DX9E3CpMau/v2u3yS2
	3BKY9iw3XFtHH7iKMpVrGJatXJHjUC+23eEqX/w==
X-Google-Smtp-Source: AGHT+IFiBMsu3fWxP/K3m1+Xw/7hHrC5c717yoPMVlHbK3V3UYpoQx3AO/lciznPhQDf8j/nyvj8UrcjGH6sJ0yQ6JA=
X-Received: by 2002:a0d:efc3:0:b0:65f:93c1:fee9 with SMTP id
 00721157ae682-6895f60d519mr176196097b3.9.1722983683257; Tue, 06 Aug 2024
 15:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org> <20240730-swap-allocator-v5-8-cb9c148b9297@kernel.org>
In-Reply-To: <20240730-swap-allocator-v5-8-cb9c148b9297@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 6 Aug 2024 15:34:32 -0700
X-Gmail-Original-Message-ID: <CACePvbU9NUgfD-QC-hdYEmeMbLc5whOKeW4hb2ijcPonZ4i6mg@mail.gmail.com>
Message-ID: <CACePvbU9NUgfD-QC-hdYEmeMbLc5whOKeW4hb2ijcPonZ4i6mg@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] mm: swap: relaim the cached parts that got scanned
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

On Tue, Jul 30, 2024 at 11:49=E2=80=AFPM <chrisl@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> This commit implements reclaim during scan for cluster allocator.
>
> Cluster scanning were unable to reuse SWAP_HAS_CACHE slots, which
> could result in low allocation success rate or early OOM.
>
> So to ensure maximum allocation success rate, integrate reclaiming
> with scanning. If found a range of suitable swap slots but fragmented
> due to HAS_CACHE, just try to reclaim the slots.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h |   1 +
>  mm/swapfile.c        | 140 +++++++++++++++++++++++++++++++++++++++------=
------
>  2 files changed, 110 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 5a14b6c65949..9eb740563d63 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -302,6 +302,7 @@ struct swap_info_struct {
>                                         /* list of cluster that contains =
at least one free slot */
>         struct list_head frag_clusters[SWAP_NR_ORDERS];
>                                         /* list of cluster that are fragm=
ented or contented */
> +       unsigned int frag_cluster_nr[SWAP_NR_ORDERS];
>         unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
>         unsigned int highest_bit;       /* index of last free in swap_map=
 */
>         unsigned int pages;             /* total of usable pages of swap =
*/
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index eb3e387e86b2..50e7f600a9a1 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -513,6 +513,10 @@ static void free_cluster(struct swap_info_struct *si=
, struct swap_cluster_info *
>         VM_BUG_ON(ci->count !=3D 0);
>         lockdep_assert_held(&si->lock);
>         lockdep_assert_held(&ci->lock);
> +
> +       if (ci->flags & CLUSTER_FLAG_FRAG)
> +               si->frag_cluster_nr[ci->order]--;
> +
>         /*
>          * If the swap is discardable, prepare discard the cluster
>          * instead of free it immediately. The cluster will be freed
> @@ -572,31 +576,84 @@ static void dec_cluster_info_page(struct swap_info_=
struct *p,
>
>         if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>                 VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
> -               if (ci->flags & CLUSTER_FLAG_FRAG)
> +               if (ci->flags & CLUSTER_FLAG_FRAG) {
> +                       p->frag_cluster_nr[ci->order]--;
>                         list_move_tail(&ci->list, &p->nonfull_clusters[ci=
->order]);
> -               else
> +               } else {
>                         list_add_tail(&ci->list, &p->nonfull_clusters[ci-=
>order]);
> +               }
>                 ci->flags =3D CLUSTER_FLAG_NONFULL;
>         }
>  }
>
> -static inline bool cluster_scan_range(struct swap_info_struct *si, unsig=
ned int start,
> -                                     unsigned int nr_pages)
> +static bool cluster_reclaim_range(struct swap_info_struct *si,
> +                                 struct swap_cluster_info *ci,
> +                                 unsigned long start, unsigned long end)
>  {
> -       unsigned char *p =3D si->swap_map + start;
> -       unsigned char *end =3D p + nr_pages;
> +       unsigned char *map =3D si->swap_map;
> +       unsigned long offset;
> +
> +       spin_unlock(&ci->lock);
> +       spin_unlock(&si->lock);
> +
> +       for (offset =3D start; offset < end; offset++) {
> +               switch (READ_ONCE(map[offset])) {
> +               case 0:
> +                       continue;
> +               case SWAP_HAS_CACHE:
> +                       if (__try_to_reclaim_swap(si, offset, TTRS_ANYWAY=
 | TTRS_DIRECT) > 0)
> +                               continue;
> +                       goto out;
> +               default:
> +                       goto out;
> +               }
> +       }
> +out:
> +       spin_lock(&si->lock);
> +       spin_lock(&ci->lock);
>
> -       while (p < end)
> -               if (*p++)
> +       /*
> +        * Recheck the range no matter reclaim succeeded or not, the slot
> +        * could have been be freed while we are not holding the lock.
> +        */
> +       for (offset =3D start; offset < end; offset++)
> +               if (READ_ONCE(map[offset]))
>                         return false;
>
>         return true;
>  }
>
> +static bool cluster_scan_range(struct swap_info_struct *si,
> +                              struct swap_cluster_info *ci,
> +                              unsigned long start, unsigned int nr_pages=
)
> +{
> +       unsigned long offset, end =3D start + nr_pages;
> +       unsigned char *map =3D si->swap_map;
> +       bool need_reclaim =3D false;
>
> -static inline void cluster_alloc_range(struct swap_info_struct *si, stru=
ct swap_cluster_info *ci,
> -                                               unsigned int start, unsig=
ned char usage,
> -                                               unsigned int order)
> +       for (offset =3D start; offset < end; offset++) {
> +               switch (READ_ONCE(map[offset])) {
> +               case 0:
> +                       continue;
> +               case SWAP_HAS_CACHE:
> +                       if (!vm_swap_full())
> +                               return false;
> +                       need_reclaim =3D true;
> +                       continue;
> +               default:
> +                       return false;
> +               }
> +       }
> +
> +       if (need_reclaim)
> +               return cluster_reclaim_range(si, ci, start, end);
> +
> +       return true;
> +}
> +
> +static void cluster_alloc_range(struct swap_info_struct *si, struct swap=
_cluster_info *ci,
> +                               unsigned int start, unsigned char usage,
> +                               unsigned int order)
>  {
>         unsigned int nr_pages =3D 1 << order;
>
> @@ -615,6 +672,8 @@ static inline void cluster_alloc_range(struct swap_in=
fo_struct *si, struct swap_
>         if (ci->count =3D=3D SWAPFILE_CLUSTER) {
>                 VM_BUG_ON(!(ci->flags &
>                           (CLUSTER_FLAG_FREE | CLUSTER_FLAG_NONFULL | CLU=
STER_FLAG_FRAG)));
> +               if (ci->flags & CLUSTER_FLAG_FRAG)
> +                       si->frag_cluster_nr[ci->order]--;
>                 list_del(&ci->list);
>                 ci->flags =3D 0;
>         }
> @@ -640,7 +699,7 @@ static unsigned int alloc_swap_scan_cluster(struct sw=
ap_info_struct *si, unsigne
>         }
>
>         while (offset <=3D end) {
> -               if (cluster_scan_range(si, offset, nr_pages)) {
> +               if (cluster_scan_range(si, ci, offset, nr_pages)) {
>                         cluster_alloc_range(si, ci, offset, usage, order)=
;
>                         *foundp =3D offset;
>                         if (ci->count =3D=3D SWAPFILE_CLUSTER) {
> @@ -668,9 +727,8 @@ static unsigned long cluster_alloc_swap_entry(struct =
swap_info_struct *si, int o
>                                               unsigned char usage)
>  {
>         struct percpu_cluster *cluster;
> -       struct swap_cluster_info *ci, *n;
> +       struct swap_cluster_info *ci;
>         unsigned int offset, found =3D 0;
> -       LIST_HEAD(fraged);
>
>  new_cluster:
>         lockdep_assert_held(&si->lock);
> @@ -690,25 +748,42 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>         }
>
>         if (order < PMD_ORDER) {
> -               list_for_each_entry_safe(ci, n, &si->nonfull_clusters[ord=
er], list) {
> -                       list_move_tail(&ci->list, &fraged);
> +               unsigned int frags =3D 0;
> +
> +               while (!list_empty(&si->nonfull_clusters[order])) {
> +                       ci =3D list_first_entry(&si->nonfull_clusters[ord=
er],
> +                                             struct swap_cluster_info, l=
ist);
> +                       list_move_tail(&ci->list, &si->frag_clusters[orde=
r]);
>                         ci->flags =3D CLUSTER_FLAG_FRAG;
> +                       si->frag_cluster_nr[order]++;
>                         offset =3D alloc_swap_scan_cluster(si, cluster_of=
fset(si, ci),
>                                                          &found, order, u=
sage);
> +                       frags++;
>                         if (found)
>                                 break;
>                 }

One minor nitpick here.
We removed the line  "list_splice_tail(&fraged,
&si->frag_clusters[order]);" in the later part of the patch.
We can simplify this goto as:

if (found)
          goto done;

>
>                 if (!found) {

Then we can remove this test because the above goto done.
Save one level of indentation.

No functional change, we can address this in the next iteration.

> -                       list_for_each_entry_safe(ci, n, &si->frag_cluster=
s[order], list) {
> +                       /*
> +                        * Nonfull clusters are moved to frag tail if we =
reached
> +                        * here, count them too, don't over scan the frag=
 list.
> +                        */
> +                       while (frags < si->frag_cluster_nr[order]) {
> +                               ci =3D list_first_entry(&si->frag_cluster=
s[order],
> +                                                     struct swap_cluster=
_info, list);
> +                               /*
> +                                * Rotate the frag list to iterate, they =
were all failing
> +                                * high order allocation or moved here du=
e to per-CPU usage,
> +                                * this help keeping usable cluster ahead=
.
> +                                */
> +                               list_move_tail(&ci->list, &si->frag_clust=
ers[order]);
>                                 offset =3D alloc_swap_scan_cluster(si, cl=
uster_offset(si, ci),
>                                                                  &found, =
order, usage);
> +                               frags++;
>                                 if (found)
>                                         break;
>                         }
>                 }
> -
> -               list_splice_tail(&fraged, &si->frag_clusters[order]);

This is the line that gets removed so we can use "goto done" instead.

Chris

>         }
>
>         if (found)
> @@ -729,25 +804,28 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>
>         /* Order 0 stealing from higher order */
>         for (int o =3D 1; o < PMD_ORDER; o++) {
> -               if (!list_empty(&si->frag_clusters[o])) {
> +               /*
> +                * Clusters here have at least one usable slots and can't=
 fail order 0
> +                * allocation, but reclaim may drop si->lock and race wit=
h another user.
> +                */
> +               while (!list_empty(&si->frag_clusters[o])) {
>                         ci =3D list_first_entry(&si->frag_clusters[o],
>                                               struct swap_cluster_info, l=
ist);
> -                       offset =3D alloc_swap_scan_cluster(si, cluster_of=
fset(si, ci), &found,
> -                                                        0, usage);
> -                       VM_BUG_ON(!found);
> -                       goto done;
> +                       offset =3D alloc_swap_scan_cluster(si, cluster_of=
fset(si, ci),
> +                                                        &found, 0, usage=
);
> +                       if (found)
> +                               goto done;
>                 }
>
> -               if (!list_empty(&si->nonfull_clusters[o])) {
> -                       ci =3D list_first_entry(&si->nonfull_clusters[o],=
 struct swap_cluster_info,
> -                                             list);
> +               while (!list_empty(&si->nonfull_clusters[o])) {
> +                       ci =3D list_first_entry(&si->nonfull_clusters[o],
> +                                             struct swap_cluster_info, l=
ist);
>                         offset =3D alloc_swap_scan_cluster(si, cluster_of=
fset(si, ci),
>                                                          &found, 0, usage=
);
> -                       VM_BUG_ON(!found);
> -                       goto done;
> +                       if (found)
> +                               goto done;
>                 }
>         }
> -
>  done:
>         cluster->next[order] =3D offset;
>         return found;
> @@ -3053,6 +3131,7 @@ static int setup_swap_map_and_extents(struct swap_i=
nfo_struct *p,
>         for (i =3D 0; i < SWAP_NR_ORDERS; i++) {
>                 INIT_LIST_HEAD(&p->nonfull_clusters[i]);
>                 INIT_LIST_HEAD(&p->frag_clusters[i]);
> +               p->frag_cluster_nr[i] =3D 0;
>         }
>
>         for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> @@ -3096,7 +3175,6 @@ static int setup_swap_map_and_extents(struct swap_i=
nfo_struct *p,
>         if (!cluster_info)
>                 return nr_extents;
>
> -
>         /*
>          * Reduce false cache line sharing between cluster_info and
>          * sharing same address space.
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>


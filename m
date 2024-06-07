Return-Path: <linux-kernel+bounces-206745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2029900D40
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60077B235E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB2154C17;
	Fri,  7 Jun 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPgHGwLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F0154BE8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793635; cv=none; b=GywnQWfUYyfNr+JKF/DN8XoOlrHr6jt2sMSMk71paIFLR0SgBCSUFQQjWfPqRfnPkNz9cYKL6PlmXUqmsft1tn2mdAqO4iwSWQ/IILtPp0rKrL9G2P4LKkLkHQsN9o7CQKMmGnL/Ponu9qocJHMNJTbr8FgoSbskrq5+tDR6YGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793635; c=relaxed/simple;
	bh=avewfcmQ7CB+Yb+fS4ik3EM951PHP/5+YssVD0HIb+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTDJCgqowm9zWUx6eNHlDsattH8iAIUb8XmpCNLqoAPyeDtnWGSGJlv2RPqy+6fyq8Q82Nnyuo2JjGDj5xtBg5n0xK9IVDqgasK186BwvWdi9nS+yqLnkk2x5ievDXvzH/SCSrQiJ3J8uN+8kjyBw/hpkSAopE4e0MTgFM6Cx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPgHGwLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22F4C4AF07
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717793634;
	bh=avewfcmQ7CB+Yb+fS4ik3EM951PHP/5+YssVD0HIb+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZPgHGwLDaPkQ+LTVQMHVna3B1Ld6ZfDJf2qI4MfEZk2ddyA+spt1Gjd8MjC155Oex
	 Xoj8pe3Xfk/2zSlHVQX8EnTl1N3jkbzVXltS4xDk8B9kfRt2FxRhanVp7OfWBUU5uv
	 HDJZs5vB2gXLKJu79iFMj6gJOOm0bOGnhffyHV9+ftVRMWhtkhjQNjM/3hZki95kdu
	 7bu/hf7jd1XuHYCpYQ3zs1wigOQGCyhmcAqp/1g01mnK5xgkJqS9fg0e+oAco+P/g1
	 CNj5j/lkhpc5XUldxTFJOjVNPEL3kmBECL7l3L3bVfGCKnmzxEtfsJA9qlC2yxFJRT
	 C0WJXhggEVeLw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso1123323e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:53:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaYSUqN+T4q3UQfTP4XvrEh0Nwoio0PaqL3dSEB5DL8+nH39hH+V4qwfWSpff7O8361D2TZf/Vh14lTQtkQAg1Iu1Rw9cw4c9rTZz6
X-Gm-Message-State: AOJu0YyOHalCb/Cu7dzyutOFloBEWXM/QcF57bwZf8GUQ2t5oT1TisGm
	6gnU68xnXzaLEZpm1UPimBzcVZBzjb2V41Gl6yGRyTEIqjiE6SMLmqOif7zu6Rx2eaQP6X3vqP4
	9ckXRNpM4PhNrFMfR7+ktGSlTPw==
X-Google-Smtp-Source: AGHT+IHlIQlmBZ1VRtIH2vz8lF+cm9+XRwbHfHQ+4KfNbDR7QfOMHMYyGA/Klg+v/l3fmFL9XHof+VCpnONXF/wrYkk=
X-Received: by 2002:a2e:8049:0:b0:2de:74b1:6007 with SMTP id
 38308e7fff4ca-2eadce727c9mr25564341fa.36.1717793633425; Fri, 07 Jun 2024
 13:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <20240524-swap-allocator-v1-2-47861b423b26@kernel.org> <edb439ea-4754-4d63-8d5f-edc116465d7b@arm.com>
 <7553070e-630e-4e86-b64e-66cfce1ee125@arm.com>
In-Reply-To: <7553070e-630e-4e86-b64e-66cfce1ee125@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 7 Jun 2024 13:53:41 -0700
X-Gmail-Original-Message-ID: <CANeU7Qm6xMXDEY5HtAL7M6WimhW48bqbWGjdu0zU-_KntZkXpw@mail.gmail.com>
Message-ID: <CANeU7Qm6xMXDEY5HtAL7M6WimhW48bqbWGjdu0zU-_KntZkXpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: swap: mTHP allocate swap entries from nonfull list
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 3:57=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 07/06/2024 11:35, Ryan Roberts wrote:
> > On 24/05/2024 18:17, Chris Li wrote:
> >> Track the nonfull cluster as well as the empty cluster
> >> on lists. Each order has one nonfull cluster list.
> >>
> >> The cluster will remember which order it was used during
> >> new cluster allocation.
> >>
> >> When the cluster has free entry, add to the nonfull[order]
> >> list.  When the free cluster list is empty, also allocate
> >> from the nonempty list of that order.
> >>
> >> This improves the mTHP swap allocation success rate.
> >
> > If I've understood correctly, the aim here is to link all the current p=
er-cpu
> > clusters for a given order together so that if a cpu can't allocate a n=
ew
> > cluster for a given order, then it can steal another CPU's current clus=
ter for
> > that order?
> >
> > If that's the intent, couldn't that be done just by iterating over the =
per-cpu,
> > per-order cluster pointers? Then you don't need all the linked list chu=
rn
> > (althogh I like the linked list changes as a nice cleanup, I'm not sure=
 the
> > churn is neccessary for this change?). There would likely need to be so=
me
> > locking considerations, but it would also allow you to get access to th=
e next
> > entry within the cluster for allocation.
> >
> > However, fundamentally, I don't think this change solves the problem; i=
t just
> > takes a bit longer before the allocation fails. The real problem is
> > fragmentation due to freeing individual pages from swap entries at diff=
erent times.
> >
> > Wouldn't it be better to just extend scanning to support high order all=
ocations?
> > Then we can steal a high order block from any cluster, even clusters th=
at were
> > previously full, just like we currently do for order-0. Given we are al=
ready
> > falling back to this path for order-0, I don't think it would be any mo=
re
> > expensive; infact its less expensive because we only scan once for the =
high
> > order block, rather than scan for every split order-0 page.
> >
> > Of course that still doesn't solve the proplem entirely; if swap is so
> > fragmented that there is no contiguous block of the required order then=
 you
> > still have to fall back to splitting. As an extra optimization, you cou=
ld store
> > the largest contiguous free space available in each cluster to avoid sc=
anning in
> > case its too small?
> >
> >
> >>
> >> There are limitations if the distribution of numbers of
> >> different orders of mTHP changes a lot. e.g. there are a lot
> >> of nonfull cluster assign to order A while later time there
> >> are a lot of order B allocation while very little allocation
> >> in order A. Currently the cluster used by order A will not
> >> reused by order B unless the cluster is 100% empty.
> >>
> >> This situation is best addressed by the longer term "swap
> >> buddy allocator", in future patches.
> >> ---
> >>  include/linux/swap.h |  4 ++++
> >>  mm/swapfile.c        | 25 +++++++++++++++++++++++--
> >>  2 files changed, 27 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index 0d3906eff3c9..1b7f0794b9bf 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -255,10 +255,12 @@ struct swap_cluster_info {
> >>                               * cluster
> >>                               */
> >>      unsigned int count:16;
> >> +    unsigned int order:8;
> >>      unsigned int flags:8;
> >>      struct list_head next;
> >>  };
> >>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> >> +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
> >>
> >>
> >>  /*
> >> @@ -297,6 +299,8 @@ struct swap_info_struct {
> >>      unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
> >>      struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
> >>      struct list_head free_clusters; /* free clusters list */
> >> +    struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> >> +                                    /* list of cluster that contains =
at least one free slot */
> >>      unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
> >>      unsigned int highest_bit;       /* index of last free in swap_map=
 */
> >>      unsigned int pages;             /* total of usable pages of swap =
*/
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index 205a60c5f9cb..51923aba500e 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -363,8 +363,11 @@ static void swap_cluster_schedule_discard(struct =
swap_info_struct *si,
> >>
> >>  static void __free_cluster(struct swap_info_struct *si, struct swap_c=
luster_info *ci)
> >>  {
> >> +    if (ci->flags & CLUSTER_FLAG_NONFULL)
> >> +            list_move_tail(&ci->next, &si->free_clusters);
> >> +    else
> >> +            list_add_tail(&ci->next, &si->free_clusters);
> >>      ci->flags =3D CLUSTER_FLAG_FREE;
> >> -    list_add_tail(&ci->next, &si->free_clusters);
> >>  }
> >>
> >>  /*
> >> @@ -486,7 +489,12 @@ static void dec_cluster_info_page(struct swap_inf=
o_struct *p, struct swap_cluste
> >>      ci->count--;
> >>
> >>      if (!ci->count)
> >> -            free_cluster(p, ci);
> >> +            return free_cluster(p, ci);
> >> +
> >> +    if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> >> +            list_add_tail(&ci->next, &p->nonfull_clusters[ci->order])=
;
> >> +            ci->flags |=3D CLUSTER_FLAG_NONFULL;
> >> +    }
> >>  }
> >>
> >>  /*
> >> @@ -547,6 +555,14 @@ static bool scan_swap_map_try_ssd_cluster(struct =
swap_info_struct *si,
> >>                      ci =3D list_first_entry(&si->free_clusters, struc=
t swap_cluster_info, next);
> >>                      list_del(&ci->next);
> >>                      spin_lock(&ci->lock);
> >> +                    ci->order =3D order;
> >> +                    ci->flags =3D 0;
> >> +                    spin_unlock(&ci->lock);
> >> +                    tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
> >> +            } else if (!list_empty(&si->nonfull_clusters[order])) {
> >> +                    ci =3D list_first_entry(&si->nonfull_clusters[ord=
er], struct swap_cluster_info, next);
> >> +                    list_del(&ci->next);
> >> +                    spin_lock(&ci->lock);
> >>                      ci->flags =3D 0;
> >>                      spin_unlock(&ci->lock);
> >>                      tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
> >
> > This looks wrong to me; if the cluster is on the nonfull list then it w=
ill have
> > had some entries already allocated (by another cpu). So pointing tmp to=
 the
> > first block in the cluster will never yield a free block. The cpu from =
which you
> > are stealing the cluster stores the next free block location in its per=
-cpu
> > structure. So perhaps iterating over the other cpu's `struct percpu_clu=
ster`s is
> > a better approach than the nonfull list?
>
> Ahh; of course the cluster scan below will move this along to a free bloc=
k.

You mean the (offset < max) loop, right?

Agree.

Chris

>
> >
> > Additionally, this cluster will be stored back to this cpu's current cl=
uster at
> > the bottom of the function. That may or may not be what you intended.
> >
> >> @@ -578,6 +594,7 @@ static bool scan_swap_map_try_ssd_cluster(struct s=
wap_info_struct *si,
> >>                              break;
> >>                      tmp +=3D nr_pages;
> >>              }
> >> +            WARN_ONCE(ci->order !=3D order, "expecting order %d got %=
d", order, ci->order);
> >>              unlock_cluster(ci);
> >>      }
> >>      if (tmp >=3D max) {
> >> @@ -956,6 +973,7 @@ static void swap_free_cluster(struct swap_info_str=
uct *si, unsigned long idx)
> >>      ci =3D lock_cluster(si, offset);
> >>      memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >>      ci->count =3D 0;
> >> +    ci->order =3D 0;
> >>      ci->flags =3D 0;
> >>      free_cluster(si, ci);
> >>      unlock_cluster(ci);
> >> @@ -2882,6 +2900,9 @@ static int setup_swap_map_and_extents(struct swa=
p_info_struct *p,
> >>      INIT_LIST_HEAD(&p->free_clusters);
> >>      INIT_LIST_HEAD(&p->discard_clusters);
> >>
> >> +    for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> >> +            INIT_LIST_HEAD(&p->nonfull_clusters[i]);
> >> +
> >>      for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> >>              unsigned int page_nr =3D swap_header->info.badpages[i];
> >>              if (page_nr =3D=3D 0 || page_nr > swap_header->info.last_=
page)
> >>
> >
>


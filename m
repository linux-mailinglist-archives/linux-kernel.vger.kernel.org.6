Return-Path: <linux-kernel+bounces-289245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF66954396
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FBA281DED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D97BAF4;
	Fri, 16 Aug 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km7r/Z7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87718EAD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795314; cv=none; b=bjlppJfLnNVdT7idJYmwfI8DN8wFOz7NeewcoGhczQ+0l/PwQLDKKlExtpX57lnZP3bVDCMJfKd9h+EP/x5dxqYDKYh2Qbfl2tjwOvfI8Ou3vOK9qf53n1e0CgSZAuunZH6aL53h5pWirKHhhFz2Djgmi+JodPXgA04Z+skhcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795314; c=relaxed/simple;
	bh=PqiXV8v2CEz2TTGEV4fB+NpOMuGJApvPrzEMwpopwTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG+N9r72hxAIHCfN9ejdwUAaA3IKwOWxLKlLqd4hN+3KpJPjwzFGclIP33vO7TGLB7sqx2KpjnhNJd8K39/mcXka8YUOKcxEnwtG6pV1EmWzonIs2EBtPGrlHC0QU/6GskeT0V46BUfmeciKMaunA8iO5A9K4JETEpGBXLqhTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km7r/Z7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C92AC4AF14
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723795313;
	bh=PqiXV8v2CEz2TTGEV4fB+NpOMuGJApvPrzEMwpopwTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Km7r/Z7QSTFPfgzJaMSAW1d9fQIf7mcCOS7di8SwgTz/fJPRrpsXPahCKukWl9KAV
	 wBbjiiNpLr5weLVjaNKE41r+2ppmmYko/G/USmR6txW/j0TOI5aZrKH6/2ZzJLaORR
	 MoLlF4CdZF83W6Rtx+5UbDxh1qF6/B8SximwWfKP64RLSnS0i0s/jd1MFaoQCmNJBu
	 a1m5nC+DLq7sbiJYhJbsFYrH1KWwdTPJlFPevZg2JMbuMbYDjRHGrQi+GTalSlLA2F
	 YAjXGeBK5+WAm6mVJdLyNGPlP535pXykjSZAT6G0XJ5uLCiRNE0nWM1OJ+MtxKoIIL
	 IRkOAOTb228Iw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-66a048806e6so18096387b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:01:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBS/kE7bmxOrjiv0KXW6zvE+KXsTUXV4OhPB30NyFm3V0gJNG/FXANsggkcwXY0yR9ctibpwEgYQaM1qUodH27IkWbhYFFyBDU9snk
X-Gm-Message-State: AOJu0YzorYQSoFfru6F3vD0AZR4LiGut2nrHWDbvfBKemt/7gylbBCWd
	EAvk89ZvH/j7kMLJEG381jg5YLGtMjflO6IxGV8XNiOvtNtKCrnLWLn/2mbx/p9OE+vPniHHGr0
	sCRpUI3ZfKWyBmcPA783N+wybTeHN8rIDic8Z+A==
X-Google-Smtp-Source: AGHT+IFEZusVZzrM/+uEeHMOCidiTmtG6ke4RPG56HzV8fpFJseWcNqnS9L/ESv3a1uiFxePrdIQz+DgvTmf/LYF+Vo=
X-Received: by 2002:a05:690c:7690:b0:65f:ca0b:451c with SMTP id
 00721157ae682-6b1b890e704mr23973577b3.21.1723795312597; Fri, 16 Aug 2024
 01:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <20240730-swap-allocator-v5-2-cb9c148b9297@kernel.org> <87bk23250r.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bk23250r.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 16 Aug 2024 01:01:41 -0700
X-Gmail-Original-Message-ID: <CACePvbX1M8tfqj__nvMwvD0P0abEjbju2gQDEea9BPZ6eUuRuQ@mail.gmail.com>
Message-ID: <CACePvbX1M8tfqj__nvMwvD0P0abEjbju2gQDEea9BPZ6eUuRuQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:14=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > Track the nonfull cluster as well as the empty cluster
> > on lists. Each order has one nonfull cluster list.
> >
> > The cluster will remember which order it was used during
> > new cluster allocation.
> >
> > When the cluster has free entry, add to the nonfull[order]
> > list.  When the free cluster list is empty, also allocate
> > from the nonempty list of that order.
> >
> > This improves the mTHP swap allocation success rate.
> >
> > There are limitations if the distribution of numbers of
> > different orders of mTHP changes a lot. e.g. there are a lot
> > of nonfull cluster assign to order A while later time there
> > are a lot of order B allocation while very little allocation
> > in order A. Currently the cluster used by order A will not
> > reused by order B unless the cluster is 100% empty.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> >  include/linux/swap.h |  4 ++++
> >  mm/swapfile.c        | 38 +++++++++++++++++++++++++++++++++++---
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index edafd52d7ac4..6716ef236766 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -254,9 +254,11 @@ struct swap_cluster_info {
> >                                */
> >       u16 count;
> >       u8 flags;
> > +     u8 order;
> >       struct list_head list;
> >  };
> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> > +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
> >
> >  /*
> >   * The first page in the swap file is the swap header, which is always=
 marked
> > @@ -295,6 +297,8 @@ struct swap_info_struct {
> >       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zer=
o pages */
> >       struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
> >       struct list_head free_clusters; /* free clusters list */
> > +     struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> > +                                     /* list of cluster that contains =
at least one free slot */
> >       unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
> >       unsigned int highest_bit;       /* index of last free in swap_map=
 */
> >       unsigned int pages;             /* total of usable pages of swap =
*/
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index bceead7f9e3c..dcf09eb549db 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -361,14 +361,22 @@ static void swap_cluster_schedule_discard(struct =
swap_info_struct *si,
> >       memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >                       SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> >
> > -     list_add_tail(&ci->list, &si->discard_clusters);
> > +     VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
> > +     if (ci->flags & CLUSTER_FLAG_NONFULL)
> > +             list_move_tail(&ci->list, &si->discard_clusters);
> > +     else
> > +             list_add_tail(&ci->list, &si->discard_clusters);
> > +     ci->flags =3D 0;
>
> As Ryan pointed out before, it's better to clear the specific bit
> instead of assigning 0.  This will make code future proof.
Ack.

BTW, I plan to change the bit to a list number in the future.I can
define a list bit mask for now.

>
> >       schedule_work(&si->discard_work);
> >  }
> >
> >  static void __free_cluster(struct swap_info_struct *si, struct swap_cl=
uster_info *ci)
> >  {
> > +     if (ci->flags & CLUSTER_FLAG_NONFULL)
> > +             list_move_tail(&ci->list, &si->free_clusters);
> > +     else
> > +             list_add_tail(&ci->list, &si->free_clusters);
> >       ci->flags =3D CLUSTER_FLAG_FREE;
> > -     list_add_tail(&ci->list, &si->free_clusters);
> >  }
> >
> >  /*
> > @@ -491,8 +499,15 @@ static void dec_cluster_info_page(struct swap_info=
_struct *p, struct swap_cluste
> >       VM_BUG_ON(ci->count =3D=3D 0);
> >       ci->count--;
> >
> > -     if (!ci->count)
> > +     if (!ci->count) {
> >               free_cluster(p, ci);
> > +             return;
> > +     }
> > +
> > +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> > +             list_add_tail(&ci->list, &p->nonfull_clusters[ci->order])=
;
> > +             ci->flags |=3D CLUSTER_FLAG_NONFULL;
> > +     }
> >  }
> >
> >  /*
> > @@ -553,6 +568,19 @@ static bool scan_swap_map_try_ssd_cluster(struct s=
wap_info_struct *si,
> >       if (tmp =3D=3D SWAP_NEXT_INVALID) {
> >               if (!list_empty(&si->free_clusters)) {
> >                       ci =3D list_first_entry(&si->free_clusters, struc=
t swap_cluster_info, list);
> > +                     list_del(&ci->list);
> > +                     spin_lock(&ci->lock);
> > +                     ci->order =3D order;
> > +                     ci->flags =3D 0;
> > +                     spin_unlock(&ci->lock);
> > +                     tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
> > +             } else if (!list_empty(&si->nonfull_clusters[order])) {
> > +                     ci =3D list_first_entry(&si->nonfull_clusters[ord=
er],
> > +                                           struct swap_cluster_info, l=
ist);
> > +                     list_del(&ci->list);
> > +                     spin_lock(&ci->lock);
> > +                     ci->flags =3D 0;
> > +                     spin_unlock(&ci->lock);
> >                       tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
> >               } else if (!list_empty(&si->discard_clusters)) {
>
> We should check discard_clusters before nonfull clusters.

And the reason behind that is?

I see the discard_cluster can take a long time. It will take a
synchronous wait for the issuing the discard command. Why not just use
the  nonfull list and return immediately. When the discard command
finished. It will show up in the free list anyway.

BTW, what is your take on my  previous analysis of the current SSD
prefer write new cluster can wear out the SSD faster?
I think it might be useful to provide users an option to choose to
write a non full list first. The trade off is more friendly to SSD
wear out than preferring to write new blocks. If you keep doing the
swap long enough, there will be no new free cluster anyway.

The example I give in this email:

https://lore.kernel.org/linux-mm/CACePvbXGBNC9WzzL4s2uB2UciOkV6nb4bKKkc5TBZ=
P6QuHS_aQ@mail.gmail.com/

Chris
>
> >                       /*
> > @@ -967,6 +995,7 @@ static void swap_free_cluster(struct swap_info_stru=
ct *si, unsigned long idx)
> >       ci =3D lock_cluster(si, offset);
> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >       ci->count =3D 0;
> > +     ci->order =3D 0;
> >       ci->flags =3D 0;
> >       free_cluster(si, ci);
> >       unlock_cluster(ci);
> > @@ -2922,6 +2951,9 @@ static int setup_swap_map_and_extents(struct swap=
_info_struct *p,
> >       INIT_LIST_HEAD(&p->free_clusters);
> >       INIT_LIST_HEAD(&p->discard_clusters);
> >
> > +     for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> > +             INIT_LIST_HEAD(&p->nonfull_clusters[i]);
> > +
> >       for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> >               unsigned int page_nr =3D swap_header->info.badpages[i];
> >               if (page_nr =3D=3D 0 || page_nr > swap_header->info.last_=
page)
>
> --
> Best Regards,
> Huang, Ying


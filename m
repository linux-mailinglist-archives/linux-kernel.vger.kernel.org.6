Return-Path: <linux-kernel+bounces-220741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE77190E67A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD09B219FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBCD7E56C;
	Wed, 19 Jun 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EobCimQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D1224D4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787799; cv=none; b=AU0SRatYEdZ3y181Xi8TqqZUPaI0dImv/MraTMdY8POrD2vVbhLs/v/H32TBwmBA2QwxwTkco6OON+s9mjIrUs4Ect+HMlf19vD0MwlNLSxMxQekYi1oWOaHRSCphJCZFiLWhFBVPTsdFCxQ0bx3+3RL9cOlQOqiotn7V96QLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787799; c=relaxed/simple;
	bh=JbBH3S104EQeGS0iLj4NUJU7t2tF7dtaAplk8RZ/iWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcNoaAzfJaw1mK7uNm84trECQp5o+B4XiMR6o2GeZn/W9TRKkYhVPQLp9VMRqyhuNKcdaB27Ap+nAYMtrxevOPA3a6khvISyq61ITQQtPEECodtUYZYh9k/p5Snn/PgTcmAYVrDBn3R9a7NrYBxelvtE/8XfZOHZmeLc5CeWicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EobCimQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95117C4AF51
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718787798;
	bh=JbBH3S104EQeGS0iLj4NUJU7t2tF7dtaAplk8RZ/iWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EobCimQmbeR6hU1uWmZ/N8wUqGdGj6/Atp9MgZMZCFN/az6FM3KKN0ziSDc/tXSi8
	 mAQ8cMHvNtV04jYuSU3r+UQd3H5PYnFjvYePpC09PCDZofb/TXZlMEBYQqSX2hniSm
	 DBz8YjWPR+4c3fvtTo5QWPywZNxx0D55YqRk6in/sf05YDHnRARLJgCufUcGcmNdj7
	 AXE3vm06YuiYGC1VNnLE5A5VTWVjrD39YjWk8M4ZxttroBma35y+4gn7dljZNvvRY2
	 xu+A8KfeUZqWgUdhvTzx5qGCcJ1vZFPDCXpr5Daw5vQFzCTv0va9WwXAVctkAdwvPL
	 SXii+Z8zh0WOg==
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3761f8d689fso2234185ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:03:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbv3x6CslyV0mvbjSZ0UQBZ4LRIeRgSaBeWP6apxdrHXJ3FM4mZIzfAAjTeVufvJsoKcbk7djIcNhhIY59GF6URm7htjNIbLuuI2Nu
X-Gm-Message-State: AOJu0YwDyikX8MQcMJYb24rjpyQIDHeq5PC/Qoml63gwJx8pSRRmHUr1
	5yiCz2PTfX1H5mq9Zx5abOgNOa0AVLVQUp2ljqrO2eKn3Jp0eZ7X4Xlm8VC7Z72sM9GyQ4SPwOs
	q0OGxcvy8bNUa+iXeVdm4KnuqHRjOh7xOcu92
X-Google-Smtp-Source: AGHT+IFO25qdvGFeh7yc2Mt2mOE+VvHaS6U1XJjuIk4I5bm/bruh1Rs3HtLeD0snMLUL9L9xhraymvvncI73EgEKXI8=
X-Received: by 2002:a05:6e02:1c2a:b0:375:a6cd:dff2 with SMTP id
 e9e14a558f8ab-3761d65728emr22019775ab.5.1718787797822; Wed, 19 Jun 2024
 02:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
 <20240614-swap-allocator-v2-1-2a513b4a7f2f@kernel.org> <87frtc5bxm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuMTAuGN6Zt-=Nb-4TPZ4aNBX17W6eop5LPVHYTakV+LHw@mail.gmail.com>
 <87y1724re8.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuPqTWdxdUnU_0b4JNY06S6qdc5rEDwtr6M6NV9PhmHVUw@mail.gmail.com>
 <87le314bgy.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87le314bgy.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 19 Jun 2024 02:03:05 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPrQ=0EVEQSEuz7F=0iY+tzKQZF1gk3dR6nQx1sMDOXtw@mail.gmail.com>
Message-ID: <CAF8kJuPrQ=0EVEQSEuz7F=0iY+tzKQZF1gk3dR6nQx1sMDOXtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: swap: swap cluster switch to double link list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 12:53=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Tue, Jun 18, 2024 at 12:56=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > On Sun, Jun 16, 2024 at 11:21=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
> >> >>
> >> >> Hi, Chris,
> >> >>
> >> >> Chris Li <chrisl@kernel.org> writes:
>
> [snip]
>
> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> > index 3df75d62a835..cd9154a3e934 100644
> >> >> > --- a/include/linux/swap.h
> >> >> > +++ b/include/linux/swap.h
> >> >> > @@ -242,23 +242,22 @@ enum {
> >> >> >   * space with SWAPFILE_CLUSTER pages long and naturally aligns i=
n disk. All
> >> >> >   * free clusters are organized into a list. We fetch an entry fr=
om the list to
> >> >> >   * get a free cluster.
> >> >> > - *
> >> >> > - * The data field stores next cluster if the cluster is free or =
cluster usage
> >> >> > - * counter otherwise. The flags field determines if a cluster is=
 free. This is
> >> >> > - * protected by swap_info_struct.lock.
> >> >> >   */
> >> >> >  struct swap_cluster_info {
> >> >> >       spinlock_t lock;        /*
> >> >> > -                              * Protect swap_cluster_info fields
> >> >> > -                              * and swap_info_struct->swap_map
> >> >> > +                              * Protect swap_cluster_info count =
and state
> >> >>
> >> >> Protect swap_cluster_info fields except 'list' ?
> >> >
> >> > I change it to protect the swap_cluster_info bitfields in the second=
 patch.
> >>
> >> Although I still prefer my version, I will not insist on that.
> >
> > Sure, I actually don't have a strong preference about that. It is just =
comments.
> >
> >>
> >> >>
> >> >> > +                              * field and swap_info_struct->swap=
_map
> >> >> >                                * elements correspond to the swap
> >> >> >                                * cluster
> >> >> >                                */
> >> >> > -     unsigned int data:24;
> >> >> > -     unsigned int flags:8;
> >> >> > +     unsigned int count:12;
> >> >> > +     unsigned int state:3;
> >> >>
> >> >> I still prefer normal data type over bit fields.  How about
> >> >>
> >> >>         u16 usage;
> >> >>         u8  state;
> >> >
> >> > I don't mind the "count" rename to "usage". That is probably a bette=
r
> >> > name. However I have another patch intended to add more bit fields i=
n
> >> > the cluster info struct. The second patch adds "order" and the later
> >> > patch will add more. That is why I choose bitfield to be more conden=
se
> >> > with bits.
> >>
> >> We still have space for another "u8" for "order".  It appears trivial =
to
> >> change it to bit fields when necessary in the future.
> >
> > We can, I don't see it necessary to change from bit field to u8 and
> > back to bit field in the future. It is more of a personal preference
> > issue.
>
> I have to say that I don't think that it's just a personal preference.
> IMO, if it's unnecessary, we shouldn't use bit fields.  You cannot
> guarantee that your future changes will be merged in its current state.
> So, I still think that it's better to avoid bit fields for now.

That is surprising to hear, I am not dependent on any hardware
physical bit location.
Anyway, not too big a deal for me. I changed it to u16/u8.

> >> > When you get the cluster from the list, you have a cluster pointer. =
I
> >> > feel it is unnecessary to convert to index then back convert to
> >> > cluster pointer inside lock_cluster(). I actually feel using indexes
> >> > to refer to the cluster is error prone because we also have offset.
> >>
> >> I don't think so, it's common to use swap offset.
> >
> > Swap offset is not an issue, it is all over the place. The cluster
> > index(offset/512) is the one I try to avoid.
> > I have made some mistakes myself on offset vs index.
>
> Yes.  That's not good, but it's hard to be avoided too.  Can we make the
> variable name more consistent?  index: cluster index, offset: swap
> offset.
>
> And, in fact, swap offset is the parameter of lock_cluster() instead of
> cluster index.

Right, when you get the cluster pointer from the list, it can't
directly use lock_cluster().

>
> >> >
> >> >>
> >> >> > +             __free_cluster(si, ci);
> >> >> >               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >> >> >                               0, SWAPFILE_CLUSTER);
> >> >> >               unlock_cluster(ci);
> >> >> > @@ -521,20 +412,19 @@ static void swap_users_ref_free(struct perc=
pu_ref *ref)
> >> >> >       complete(&si->comp);
> >> >> >  }
> >> >> >
>
> [snip]
>
> >> >> > @@ -611,10 +497,10 @@ scan_swap_map_ssd_cluster_conflict(struct s=
wap_info_struct *si,
> >> >> >  {
> >> >> >       struct percpu_cluster *percpu_cluster;
> >> >> >       bool conflict;
> >> >> > -
> >> >>
> >> >> Usually we use one blank line after local variable declaration.
> >> > Ack.
> >> >
> >> >>
> >> >> > +     struct swap_cluster_info *first =3D list_first_entry(&si->f=
ree_clusters, struct swap_cluster_info, list);
> >> >> >       offset /=3D SWAPFILE_CLUSTER;
> >> >> > -     conflict =3D !cluster_list_empty(&si->free_clusters) &&
> >> >> > -             offset !=3D cluster_list_first(&si->free_clusters) =
&&
> >> >> > +     conflict =3D !list_empty(&si->free_clusters) &&
> >> >> > +             offset !=3D  first - si->cluster_info &&
> >> >> >               cluster_is_free(&si->cluster_info[offset]);
> >> >> >
> >> >> >       if (!conflict)
> >> >> > @@ -655,10 +541,14 @@ static bool scan_swap_map_try_ssd_cluster(s=
truct swap_info_struct *si,
> >> >> >       cluster =3D this_cpu_ptr(si->percpu_cluster);
> >> >> >       tmp =3D cluster->next[order];
> >> >> >       if (tmp =3D=3D SWAP_NEXT_INVALID) {
> >> >> > -             if (!cluster_list_empty(&si->free_clusters)) {
> >> >> > -                     tmp =3D cluster_next(&si->free_clusters.hea=
d) *
> >> >> > -                                     SWAPFILE_CLUSTER;
> >> >> > -             } else if (!cluster_list_empty(&si->discard_cluster=
s)) {
> >> >> > +             if (!list_empty(&si->free_clusters)) {
> >> >> > +                     ci =3D list_first_entry(&si->free_clusters,=
 struct swap_cluster_info, list);
> >> >> > +                     list_del(&ci->list);
> >> >>
> >> >> The free cluster is deleted from si->free_clusters now.  But later =
you
> >> >> will call scan_swap_map_ssd_cluster_conflict() and may abandon the
> >> >> cluster.  And in alloc_cluster() later, it may be deleted again.
> >> >
> >> > Yes, that is a bug. Thanks for catching that.
> >> >
> >> >>
> >> >> > +                     spin_lock(&ci->lock);
> >> >> > +                     ci->state =3D CLUSTER_STATE_PER_CPU;
> >> >>
> >> >> Need to change ci->state when move a cluster off the percpu_cluster=
.
> >> >
> >> > In the next patch. This patch does not use the off state yet.
> >>
> >> But that is confusing to use wrong state name, the really meaning is
> >> something like CLUSTER_STATE_NON_FREE.  But as I suggested above, we c=
an
> >
> > It can be FREE and on the per cpu pointer as well. That is the tricky p=
art.
> > It can happen on the current code as well.
>
> cluster_set_count_flag(0, 0) is called in alloc_cluster().  So, it's not
> an issue in current code.  If you need more, that shouldn't be done in
> this patch.

Revert to V1 like using the flags.

Chris


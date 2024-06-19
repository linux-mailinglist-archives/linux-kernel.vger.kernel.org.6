Return-Path: <linux-kernel+bounces-220650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51A90E4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681A4B227C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA077110;
	Wed, 19 Jun 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E35xSU1F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BED73441
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783585; cv=none; b=U9+nhUbLQOxF4p2Sg6T7jUvtGGu+jug3OmpK9mXOwVapyToBVQM0bbsa5SclKjX2qs76w2et8zH7v5wlV5yr5qABMbG5RROBfHlRo8IJc4C0wW5zrm66tEWV2IDqk3+q3jhvTrveMyON5ypJp/2xHJIOeO3AYuQBxLjB5AAWDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783585; c=relaxed/simple;
	bh=HqAayMXfsb3bAlmNU8C06hZ7IHnX6K11yuzyPkwsHy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1Nmafs/zU2OXLvfl2sztknQUujvYtTX+yoHQwrgk8vSfGqxjdbIuzMpwi5aj0SE4FZbQaHaHosddar5TBRocQF7eWEREoCdNghZBlgr68OlbtlxMJJ9OFK5WOpUWvfS0a536DMjnQN4qkt1ByG6xiHpMvOksGpW0TaIx6oSRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E35xSU1F; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718783584; x=1750319584;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=HqAayMXfsb3bAlmNU8C06hZ7IHnX6K11yuzyPkwsHy0=;
  b=E35xSU1FUfzXapcjTZXLIDs3WDyTUXvx7C8Nf5Vjk4ONb7Z6zhTsTCg+
   kNm90hhjsPxRijPlBfcbqENuiNpOJSRetYMjElcTiPzfhITAqoAu+oHq4
   ucNyyhQry8qC7M6ODvK8Fnp60WpUAvVfaeQj6D34CusR6GdJJ0oU+bjVy
   AmRZWc1n3fWKWQWF6Q6HMJK4Rc0RwbtZBx/Y0qhcRJIPAz1zrSjOpdAfM
   RKbdqoCQu9IjBgeQaJEQjpLSNTIMuLffzvAkvIXNRAyGAtx7pVftQ3xLR
   1MYMhW5JSl2sPTmsHeRsLL8NHUhxXJUtIXChQ9Nqp3Ywz9DvnY77TC/LC
   g==;
X-CSE-ConnectionGUID: I9hAKW2lSyS13OgW5jJnqQ==
X-CSE-MsgGUID: zzYC/XtzT3OeZcsdcRNl3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15846955"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15846955"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:53:03 -0700
X-CSE-ConnectionGUID: zfLGzj9NQCe8JAkYt4MAxg==
X-CSE-MsgGUID: G1L5H5Z0R2ic3jRkOdIBbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="41978623"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:53:00 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 1/2] mm: swap: swap cluster switch to double link list
In-Reply-To: <CAF8kJuPqTWdxdUnU_0b4JNY06S6qdc5rEDwtr6M6NV9PhmHVUw@mail.gmail.com>
	(Chris Li's message of "Tue, 18 Jun 2024 03:01:42 -0700")
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
	<20240614-swap-allocator-v2-1-2a513b4a7f2f@kernel.org>
	<87frtc5bxm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuMTAuGN6Zt-=Nb-4TPZ4aNBX17W6eop5LPVHYTakV+LHw@mail.gmail.com>
	<87y1724re8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuPqTWdxdUnU_0b4JNY06S6qdc5rEDwtr6M6NV9PhmHVUw@mail.gmail.com>
Date: Wed, 19 Jun 2024 15:51:09 +0800
Message-ID: <87le314bgy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> On Tue, Jun 18, 2024 at 12:56=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Sun, Jun 16, 2024 at 11:21=E2=80=AFPM Huang, Ying <ying.huang@intel=
.com> wrote:
>> >>
>> >> Hi, Chris,
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:

[snip]

>> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> >> > index 3df75d62a835..cd9154a3e934 100644
>> >> > --- a/include/linux/swap.h
>> >> > +++ b/include/linux/swap.h
>> >> > @@ -242,23 +242,22 @@ enum {
>> >> >   * space with SWAPFILE_CLUSTER pages long and naturally aligns in =
disk. All
>> >> >   * free clusters are organized into a list. We fetch an entry from=
 the list to
>> >> >   * get a free cluster.
>> >> > - *
>> >> > - * The data field stores next cluster if the cluster is free or cl=
uster usage
>> >> > - * counter otherwise. The flags field determines if a cluster is f=
ree. This is
>> >> > - * protected by swap_info_struct.lock.
>> >> >   */
>> >> >  struct swap_cluster_info {
>> >> >       spinlock_t lock;        /*
>> >> > -                              * Protect swap_cluster_info fields
>> >> > -                              * and swap_info_struct->swap_map
>> >> > +                              * Protect swap_cluster_info count an=
d state
>> >>
>> >> Protect swap_cluster_info fields except 'list' ?
>> >
>> > I change it to protect the swap_cluster_info bitfields in the second p=
atch.
>>
>> Although I still prefer my version, I will not insist on that.
>
> Sure, I actually don't have a strong preference about that. It is just co=
mments.
>
>>
>> >>
>> >> > +                              * field and swap_info_struct->swap_m=
ap
>> >> >                                * elements correspond to the swap
>> >> >                                * cluster
>> >> >                                */
>> >> > -     unsigned int data:24;
>> >> > -     unsigned int flags:8;
>> >> > +     unsigned int count:12;
>> >> > +     unsigned int state:3;
>> >>
>> >> I still prefer normal data type over bit fields.  How about
>> >>
>> >>         u16 usage;
>> >>         u8  state;
>> >
>> > I don't mind the "count" rename to "usage". That is probably a better
>> > name. However I have another patch intended to add more bit fields in
>> > the cluster info struct. The second patch adds "order" and the later
>> > patch will add more. That is why I choose bitfield to be more condense
>> > with bits.
>>
>> We still have space for another "u8" for "order".  It appears trivial to
>> change it to bit fields when necessary in the future.
>
> We can, I don't see it necessary to change from bit field to u8 and
> back to bit field in the future. It is more of a personal preference
> issue.

I have to say that I don't think that it's just a personal preference.
IMO, if it's unnecessary, we shouldn't use bit fields.  You cannot
guarantee that your future changes will be merged in its current state.
So, I still think that it's better to avoid bit fields for now.

>> >>
>> >> And, how about use 'usage' instead of 'count'?  Personally I think th=
at
>> >> it is more clear.  But I don't have strong opinions on this.
>> >>
>> >> > +     struct list_head list;  /* Protected by swap_info_struct->loc=
k */
>> >> >  };
>> >> > -#define CLUSTER_FLAG_FREE 1 /* This cluster is free */
>> >> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next clust=
er */
>> >> > +
>> >> > +#define CLUSTER_STATE_FREE   1 /* This cluster is free */
>> >>

[snip]

>> >> >  /*
>> >> > @@ -481,21 +371,22 @@ static void __free_cluster(struct swap_info_s=
truct *si, unsigned long idx)
>> >> >  */
>> >> >  static void swap_do_scheduled_discard(struct swap_info_struct *si)
>> >> >  {
>> >> > -     struct swap_cluster_info *info, *ci;
>> >> > +     struct swap_cluster_info *ci;
>> >> >       unsigned int idx;
>> >> >
>> >> > -     info =3D si->cluster_info;
>> >> > -
>> >> > -     while (!cluster_list_empty(&si->discard_clusters)) {
>> >> > -             idx =3D cluster_list_del_first(&si->discard_clusters,=
 info);
>> >> > +     while (!list_empty(&si->discard_clusters)) {
>> >> > +             ci =3D list_first_entry(&si->discard_clusters, struct=
 swap_cluster_info, list);
>> >> > +             list_del(&ci->list);
>> >> > +             idx =3D ci - si->cluster_info;
>> >> >               spin_unlock(&si->lock);
>> >> >
>> >> >               discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
>> >> >                               SWAPFILE_CLUSTER);
>> >> >
>> >> >               spin_lock(&si->lock);
>> >> > -             ci =3D lock_cluster(si, idx * SWAPFILE_CLUSTER);
>> >> > -             __free_cluster(si, idx);
>> >> > +
>> >> > +             spin_lock(&ci->lock);
>> >>
>> >> Personally, I still prefer to use lock_cluster(), which is more reada=
ble
>> >> and matches unlock_cluster() below.
>> >
>> > lock_cluster() uses an index which is not matching unlock_cluster()
>> > which is using a pointer to cluster.
>>
>> lock_cluster()/unlock_cluster() are pair and fit original design
>> well.  They use different parameter because swap cluster is optional.
>>
>> > When you get the cluster from the list, you have a cluster pointer. I
>> > feel it is unnecessary to convert to index then back convert to
>> > cluster pointer inside lock_cluster(). I actually feel using indexes
>> > to refer to the cluster is error prone because we also have offset.
>>
>> I don't think so, it's common to use swap offset.
>
> Swap offset is not an issue, it is all over the place. The cluster
> index(offset/512) is the one I try to avoid.
> I have made some mistakes myself on offset vs index.

Yes.  That's not good, but it's hard to be avoided too.  Can we make the
variable name more consistent?  index: cluster index, offset: swap
offset.

And, in fact, swap offset is the parameter of lock_cluster() instead of
cluster index.

>> >
>> >>
>> >> > +             __free_cluster(si, ci);
>> >> >               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>> >> >                               0, SWAPFILE_CLUSTER);
>> >> >               unlock_cluster(ci);
>> >> > @@ -521,20 +412,19 @@ static void swap_users_ref_free(struct percpu=
_ref *ref)
>> >> >       complete(&si->comp);
>> >> >  }
>> >> >

[snip]

>> >> > @@ -611,10 +497,10 @@ scan_swap_map_ssd_cluster_conflict(struct swa=
p_info_struct *si,
>> >> >  {
>> >> >       struct percpu_cluster *percpu_cluster;
>> >> >       bool conflict;
>> >> > -
>> >>
>> >> Usually we use one blank line after local variable declaration.
>> > Ack.
>> >
>> >>
>> >> > +     struct swap_cluster_info *first =3D list_first_entry(&si->fre=
e_clusters, struct swap_cluster_info, list);
>> >> >       offset /=3D SWAPFILE_CLUSTER;
>> >> > -     conflict =3D !cluster_list_empty(&si->free_clusters) &&
>> >> > -             offset !=3D cluster_list_first(&si->free_clusters) &&
>> >> > +     conflict =3D !list_empty(&si->free_clusters) &&
>> >> > +             offset !=3D  first - si->cluster_info &&
>> >> >               cluster_is_free(&si->cluster_info[offset]);
>> >> >
>> >> >       if (!conflict)
>> >> > @@ -655,10 +541,14 @@ static bool scan_swap_map_try_ssd_cluster(str=
uct swap_info_struct *si,
>> >> >       cluster =3D this_cpu_ptr(si->percpu_cluster);
>> >> >       tmp =3D cluster->next[order];
>> >> >       if (tmp =3D=3D SWAP_NEXT_INVALID) {
>> >> > -             if (!cluster_list_empty(&si->free_clusters)) {
>> >> > -                     tmp =3D cluster_next(&si->free_clusters.head)=
 *
>> >> > -                                     SWAPFILE_CLUSTER;
>> >> > -             } else if (!cluster_list_empty(&si->discard_clusters)=
) {
>> >> > +             if (!list_empty(&si->free_clusters)) {
>> >> > +                     ci =3D list_first_entry(&si->free_clusters, s=
truct swap_cluster_info, list);
>> >> > +                     list_del(&ci->list);
>> >>
>> >> The free cluster is deleted from si->free_clusters now.  But later you
>> >> will call scan_swap_map_ssd_cluster_conflict() and may abandon the
>> >> cluster.  And in alloc_cluster() later, it may be deleted again.
>> >
>> > Yes, that is a bug. Thanks for catching that.
>> >
>> >>
>> >> > +                     spin_lock(&ci->lock);
>> >> > +                     ci->state =3D CLUSTER_STATE_PER_CPU;
>> >>
>> >> Need to change ci->state when move a cluster off the percpu_cluster.
>> >
>> > In the next patch. This patch does not use the off state yet.
>>
>> But that is confusing to use wrong state name, the really meaning is
>> something like CLUSTER_STATE_NON_FREE.  But as I suggested above, we can
>
> It can be FREE and on the per cpu pointer as well. That is the tricky par=
t.
> It can happen on the current code as well.

cluster_set_count_flag(0, 0) is called in alloc_cluster().  So, it's not
an issue in current code.  If you need more, that shouldn't be done in
this patch.

>> keep swap_cluster_info.flags and CLUSTER_FLAG_FREE in this patch.
>
> Maybe. Will consider that.
>
>>
>> >>
>> >> > +                     spin_unlock(&ci->lock);
>> >> > +                     tmp =3D (ci - si->cluster_info) * SWAPFILE_CL=
USTER;
>> >> > +             } else if (!list_empty(&si->discard_clusters)) {
>> >> >                       /*
>> >> >                        * we don't have free cluster but have some c=
lusters in
>> >> >                        * discarding, do discard now and reclaim the=
m, then
>> >> > @@ -1062,8 +952,8 @@ static void swap_free_cluster(struct swap_info=
_struct *si, unsigned long idx)
>> >> >
>> >> >       ci =3D lock_cluster(si, offset);
>> >> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>> >> > -     cluster_set_count_flag(ci, 0, 0);
>> >> > -     free_cluster(si, idx);
>> >> > +     ci->count =3D 0;
>> >> > +     free_cluster(si, ci);
>> >> >       unlock_cluster(ci);
>> >> >       swap_range_free(si, offset, SWAPFILE_CLUSTER);
>> >> >  }

[snip]

--
Best Regards,
Huang, Ying


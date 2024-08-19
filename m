Return-Path: <linux-kernel+bounces-291657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CFF956549
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD471C217C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14515B0E0;
	Mon, 19 Aug 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NE8lOIfr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE415820F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055111; cv=none; b=UYuSfpKnjwh6NM/BSUK+J4DSR6d5ROyWWwjSbW5KkrcbVd1VWLVJdu9/zSQgiU/RL/We/jRCIjdTqUwOGJrTJa1d7u9oPsYQtC6fIc8pFQD95v8UXlVtHCYsB1XRiPaVQzxLXtXW8k4dMpvh8hmc9ZMervMwNUH9VGmVw1yfoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055111; c=relaxed/simple;
	bh=OlCQ4pCbcBp88IFPvk0RuBMjUfqiKABSHivfoTg8meo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVftYxS7iukgrYGfl3hqt3MM95DcwbmXsdPTNeWWIEXwUNJDdnefY2YjAsqyTgHPgGVSq41+cwubLDcvtvi29JOS7ocOs+erKxC3Swx6Mp/ABlbWhBk2NuU51JUDv6uu1btUzxnGrihDHVTLqiAWzhOnu3OoAA8WwO5kCPkrVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NE8lOIfr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724055109; x=1755591109;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=OlCQ4pCbcBp88IFPvk0RuBMjUfqiKABSHivfoTg8meo=;
  b=NE8lOIfrvGM/7pZ14yqnJguS/qvFXgdeNuYfX/o3RRmBIYSLBMwwbGSC
   2ipL0mfaUwLRsN7t2/ycjdf4y20rx6BFiegJ9QZVtwqAl3JlEq4OxqIYL
   HwD093MBaa4+2CTzVAxs0ANVBbw1l6hd7RprqX9RYcnYUatsDwxg5Ln1+
   z5VHRiJS5fO6ySfrllLK6wisyq1DEja/k6MmqAmXVDTKA+r9Oo8tl0Euh
   vLf7PDRfq2pOm97TrJa3AxLNNUQm5Gw+7HKScqo7kf5XfpfitsN/sP+hq
   KhLsrDN9KfwL24LoUsNgHzaY9v3B5bL5fHGaixap8rO9vW0Tbaeuzkt46
   Q==;
X-CSE-ConnectionGUID: SDzZr2pYSkyBq4titxEQ1w==
X-CSE-MsgGUID: AX5SKjoNSVSNwbOXUvAfRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22104648"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22104648"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:11:48 -0700
X-CSE-ConnectionGUID: l1pTCZ3nSXa2SDrwZJV1OA==
X-CSE-MsgGUID: KDNXLOrqQgi6J07Pje1Oyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60285744"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:11:36 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Hugh Dickins <hughd@google.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v5 2/9] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <CACePvbX1M8tfqj__nvMwvD0P0abEjbju2gQDEea9BPZ6eUuRuQ@mail.gmail.com>
	(Chris Li's message of "Fri, 16 Aug 2024 01:01:41 -0700")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
	<20240730-swap-allocator-v5-2-cb9c148b9297@kernel.org>
	<87bk23250r.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CACePvbX1M8tfqj__nvMwvD0P0abEjbju2gQDEea9BPZ6eUuRuQ@mail.gmail.com>
Date: Mon, 19 Aug 2024 16:08:03 +0800
Message-ID: <871q2lhr4s.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Aug 7, 2024 at 6:14=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>

[snip]

>> >
>> >  /*
>> > @@ -553,6 +568,19 @@ static bool scan_swap_map_try_ssd_cluster(struct =
swap_info_struct *si,
>> >       if (tmp =3D=3D SWAP_NEXT_INVALID) {
>> >               if (!list_empty(&si->free_clusters)) {
>> >                       ci =3D list_first_entry(&si->free_clusters, stru=
ct swap_cluster_info, list);
>> > +                     list_del(&ci->list);
>> > +                     spin_lock(&ci->lock);
>> > +                     ci->order =3D order;
>> > +                     ci->flags =3D 0;
>> > +                     spin_unlock(&ci->lock);
>> > +                     tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
>> > +             } else if (!list_empty(&si->nonfull_clusters[order])) {
>> > +                     ci =3D list_first_entry(&si->nonfull_clusters[or=
der],
>> > +                                           struct swap_cluster_info, =
list);
>> > +                     list_del(&ci->list);
>> > +                     spin_lock(&ci->lock);
>> > +                     ci->flags =3D 0;
>> > +                     spin_unlock(&ci->lock);
>> >                       tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
>> >               } else if (!list_empty(&si->discard_clusters)) {
>>
>> We should check discard_clusters before nonfull clusters.
>
> And the reason behind that is?
>
> I see the discard_cluster can take a long time. It will take a
> synchronous wait for the issuing the discard command. Why not just use
> the  nonfull list and return immediately. When the discard command
> finished. It will show up in the free list anyway.

I think that you are right.  We don't need to wait for discard here.

> BTW, what is your take on my  previous analysis of the current SSD
> prefer write new cluster can wear out the SSD faster?

No.  I don't agree with you on that.  However, my knowledge on SSD
wearing out algorithm is quite limited.

> I think it might be useful to provide users an option to choose to
> write a non full list first. The trade off is more friendly to SSD
> wear out than preferring to write new blocks. If you keep doing the
> swap long enough, there will be no new free cluster anyway.

It depends on workloads.  Some workloads may demonstrate better spatial
locality.

> The example I give in this email:
>
> https://lore.kernel.org/linux-mm/CACePvbXGBNC9WzzL4s2uB2UciOkV6nb4bKKkc5T=
BZP6QuHS_aQ@mail.gmail.com/
>
> Chris
>>
>> >                       /*
>> > @@ -967,6 +995,7 @@ static void swap_free_cluster(struct swap_info_str=
uct *si, unsigned long idx)
>> >       ci =3D lock_cluster(si, offset);
>> >       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>> >       ci->count =3D 0;
>> > +     ci->order =3D 0;
>> >       ci->flags =3D 0;
>> >       free_cluster(si, ci);
>> >       unlock_cluster(ci);
>> > @@ -2922,6 +2951,9 @@ static int setup_swap_map_and_extents(struct swa=
p_info_struct *p,
>> >       INIT_LIST_HEAD(&p->free_clusters);
>> >       INIT_LIST_HEAD(&p->discard_clusters);
>> >
>> > +     for (i =3D 0; i < SWAP_NR_ORDERS; i++)
>> > +             INIT_LIST_HEAD(&p->nonfull_clusters[i]);
>> > +
>> >       for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
>> >               unsigned int page_nr =3D swap_header->info.badpages[i];
>> >               if (page_nr =3D=3D 0 || page_nr > swap_header->info.last=
_page)

--
Best Regards,
Huang, Ying


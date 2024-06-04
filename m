Return-Path: <linux-kernel+bounces-200159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00BB8FAC14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B243B234E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A668914199C;
	Tue,  4 Jun 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9JRVmVd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD31411F4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486160; cv=none; b=GZnp5DOUAfyfZbtITToQ5eX9ASDJ2Xsk36bDThTglvBLTZksIRQyz/W28RVTdqTbHfC2vjkNgC1nkOt36gPH4nryA7KA1tYw3WgzY6m3nx8QUKxc38SugzcGbdk2MqU8u3mYWzrenATDkLriin9Msx5aMG6RyLrBgoxS/7jNpF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486160; c=relaxed/simple;
	bh=M3ZJ1uTI0ViwBLZWES2skfKCKpFt9Qmq5SM/24HXduY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CBL6HB1eygsUWtY6FmRi0Uuo1/jf/tBiu5Jn1IVMMJUuZ89+qUXgyG2x33ZvTQ2pcv6sDip8UtMup3bOm2jtw/50sfGN8tW1GVYGOgGegrPx7b/Ln+Y+L/xKPKuxLwbJMXioa88XTXJ6r0dWuaiW7rdrqHyhjIZF8SGw/3bdomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9JRVmVd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717486158; x=1749022158;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=M3ZJ1uTI0ViwBLZWES2skfKCKpFt9Qmq5SM/24HXduY=;
  b=Y9JRVmVdhTUkmlGMxKfbT9seCHjXKQoN+MMRJQdTkFSkYOiT4m9lS594
   KbRmoYgpRmhs7k8xwuiD+fjnl0vCQ6VhpXrBqLTMW/Mn0I+/VEc9ZxxM7
   XAgFDaAC4fjQTmjB1QBk71+gOaOAbnJUoTH3J5KAmL6SETbGnnSJeRP4Z
   ClS5gWWP5lZGca+Yhd8wV8NGNzgvExiwaBvXwr5Q4+OtHBBkGYVP7/Je/
   brbkP7pGup1E4KEmbhMqxYSRIS6vWZkrUAvPzZ+4WlAaZD2xW6AQ7hnqO
   yzXkMV6KvHyDTHRWhiJaR7+347YU/Q6gnfJdHLG0X7mdsIxyoTtF5BbUI
   g==;
X-CSE-ConnectionGUID: AlrmMXquSw6+OQ/3AIK4xg==
X-CSE-MsgGUID: QR34go5fT+GxT19dDstkOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13960829"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13960829"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 00:29:17 -0700
X-CSE-ConnectionGUID: W6Z9teJ6QwGgAXsAry/lcw==
X-CSE-MsgGUID: iSpJryjGTKCgWXy0FqUdzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37086174"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 00:29:15 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CAMgjq7C+rtbbnH+utGkUmwaTzB82zrO8qvotPx9Z6A4fMiO_4A@mail.gmail.com>
	(Kairui Song's message of "Fri, 31 May 2024 20:40:11 +0800")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
	<87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
	<875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
	<87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7C+rtbbnH+utGkUmwaTzB82zrO8qvotPx9Z6A4fMiO_4A@mail.gmail.com>
Date: Tue, 04 Jun 2024 15:27:23 +0800
Message-ID: <87frttcgmc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Fri, May 31, 2024 at 10:37=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > On Wed, May 29, 2024 at 7:54=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Chris Li <chrisl@kernel.org> writes:
>> >>
>> >> > Hi Ying,
>> >> >
>> >> > On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Chris Li <chrisl@kernel.org> writes:
>> >> >>
>> >> >> > I am spinning a new version for this series to address two issues
>> >> >> > found in this series:
>> >> >> >
>> >> >> > 1) Oppo discovered a bug in the following line:
>> >> >> > +               ci =3D si->cluster_info + tmp;
>> >> >> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
>> >> >> > That is a serious bug but trivial to fix.
>> >> >> >
>> >> >> > 2) order 0 allocation currently blindly scans swap_map disregard=
ing
>> >> >> > the cluster->order.
>> >> >>
>> >> >> IIUC, now, we only scan swap_map[] only if
>> >> >> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_cluste=
rs[order]).
>> >> >> That is, if you doesn't run low swap free space, you will not do t=
hat.
>> >> >
>> >> > You can still swap space in order 0 clusters while order 4 runs out=
 of
>> >> > free_cluster
>> >> > or nonfull_clusters[order]. For Android that is a common case.
>> >>
>> >> When we fail to allocate order 4, we will fallback to order 0.  Still
>> >> don't need to scan swap_map[].  But after looking at your below reply=
, I
>> >> realized that the swap space is almost full at most times in your cas=
es.
>> >> Then, it's possible that we run into scanning swap_map[].
>> >> list_empty(&si->free_clusters) &&
>> >> list_empty(&si->nonfull_clusters[order]) will become true, if we put =
too
>> >> many clusters in si->percpu_cluster.  So, if we want to avoid to scan
>> >> swap_map[], we can stop add clusters in si->percpu_cluster when swap
>> >> space runs low.  And maybe take clusters out of si->percpu_cluster
>> >> sometimes.
>> >
>> > One idea after reading your reply. If we run out of the
>> > nonfull_cluster[order], we should be able to use other cpu's
>> > si->percpu_cluster[] as well. That is a very small win for Android,
>>
>> This will be useful in general.  The number CPU may be large, and
>> multiple orders may be used.
>>
>> > because android does not have too many cpu. We are talking about a
>> > handful of clusters, which might not justify the code complexity. It
>> > does not change the behavior that order 0 can pollut higher order.
>>
>> I have a feeling that you don't really know why swap_map[] is scanned.
>> I suggest you to do more test and tracing to find out the reason.  I
>> suspect that there are some non-full cluster collection issues.
>>
>> >> Another issue is nonfull_cluster[order1] cannot be used for
>> >> nonfull_cluster[order2].  In definition, we should not fail order 0
>> >> allocation, we need to steal nonfull_cluster[order>0] for order 0
>> >> allocation.  This can avoid to scan swap_map[] too.  This may be not
>> >> perfect, but it is the simplest first step implementation.  You can
>> >> optimize based on it further.
>> >
>> > Yes, that is listed as the limitation of this cluster order approach.
>> > Initially we need to support one order well first. We might choose
>> > what order that is, 16K or 64K folio. 4K pages are too small, 2M pages
>> > are too big. The sweet spot might be some there in between.  If we can
>> > support one order well, we can demonstrate the value of the mTHP. We
>> > can worry about other mix orders later.
>> >
>> > Do you have any suggestions for how to prevent the order 0 polluting
>> > the higher order cluster? If we allow that to happen, then it defeats
>> > the goal of being able to allocate higher order swap entries. The
>> > tricky question is we don't know how much swap space we should reserve
>> > for each order. We can always break higher order clusters to lower
>> > order, but can't do the reserves. The current patch series lets the
>> > actual usage determine the percentage of the cluster for each order.
>> > However that seems not enough for the test case Barry has. When the
>> > app gets OOM kill that is where a large swing of order 0 swap will
>> > show up and not enough higher order usage for the brief moment. The
>> > order 0 swap entry will pollute the high order cluster. We are
>> > currently debating a "knob" to be able to reserve a certain % of swap
>> > space for a certain order. Those reservations will be guaranteed and
>> > order 0 swap entry can't pollute them even when it runs out of swap
>> > space. That can make the mTHP at least usable for the Android case.
>>
>> IMO, the bottom line is that order-0 allocation is the first class
>> citizen, we must keep it optimized.  And, OOM with free swap space isn't
>> acceptable.  Please consider the policy we used for page allocation.
>>
>> > Do you see another way to protect the high order cluster polluted by
>> > lower order one?
>>
>> If we use high-order page allocation as reference, we need something
>> like compaction to guarantee high-order allocation finally.  But we are
>> too far from that.
>>
>> For specific configuration, I believe that we can get reasonable
>> high-order swap entry allocation success rate for specific use cases.
>> For example, if we only do limited maximum number order-0 swap entries
>> allocation, can we keep high-order clusters?
>
> Isn't limiting order-0 allocation breaks the bottom line that order-0
> allocation is the first class citizen, and should not fail if there is
> space?

Sorry for confusing words.  I mean limiting maximum number order-0 swap
entries allocation in workloads, instead of limiting that in kernel.

> Just my two cents...
>
> I had a try locally based on Chris's work, allowing order 0 to use
> nonfull_clusters as Ying has suggested, and starting with low order
> and increase the order until nonfull_cluster[order] is not empty, that
> way higher order is just better protected, because unless we ran out
> of free_cluster and nonfull_cluster, direct scan won't happen.
>
> More concretely, I applied the following changes, which didn't change
> the code much:
> - In scan_swap_map_try_ssd_cluster, check nonfull_cluster first, then
> free_clusters, then discard_cluster.
> - If it's order 0, also check for (int i =3D 0; i < SWAP_NR_ORDERS; ++i)
> nonfull_clusters[i] cluster before scan_swap_map_try_ssd_cluster
> returns false.
>
> A quick test still using the memtier test, but decreased the swap
> device size from 10G to 8g for higher pressure.
>
> Before:
> hugepages-32kB/stats/swpout:34013
> hugepages-32kB/stats/swpout_fallback:266
> hugepages-512kB/stats/swpout:0
> hugepages-512kB/stats/swpout_fallback:77
> hugepages-2048kB/stats/swpout:0
> hugepages-2048kB/stats/swpout_fallback:1
> hugepages-1024kB/stats/swpout:0
> hugepages-1024kB/stats/swpout_fallback:0
> hugepages-64kB/stats/swpout:35088
> hugepages-64kB/stats/swpout_fallback:66
> hugepages-16kB/stats/swpout:31848
> hugepages-16kB/stats/swpout_fallback:402
> hugepages-256kB/stats/swpout:390
> hugepages-256kB/stats/swpout_fallback:7244
> hugepages-128kB/stats/swpout:28573
> hugepages-128kB/stats/swpout_fallback:474
>
> After:
> hugepages-32kB/stats/swpout:31448
> hugepages-32kB/stats/swpout_fallback:3354
> hugepages-512kB/stats/swpout:30
> hugepages-512kB/stats/swpout_fallback:33
> hugepages-2048kB/stats/swpout:2
> hugepages-2048kB/stats/swpout_fallback:0
> hugepages-1024kB/stats/swpout:0
> hugepages-1024kB/stats/swpout_fallback:0
> hugepages-64kB/stats/swpout:31255
> hugepages-64kB/stats/swpout_fallback:3112
> hugepages-16kB/stats/swpout:29931
> hugepages-16kB/stats/swpout_fallback:3397
> hugepages-256kB/stats/swpout:5223
> hugepages-256kB/stats/swpout_fallback:2351
> hugepages-128kB/stats/swpout:25600
> hugepages-128kB/stats/swpout_fallback:2194
>
> High order (256k) swapout rate are significantly higher, 512k is now
> possible, which indicate high orders are better protected, lower
> orders are sacrificed but seems worth it.

Yes.  I think that this reflects another aspect of the problem.  In some
situations, it's better to steal one high-order cluster and use it for
order-0 allocation instead of scattering order-0 allocation in random
high-order clusters.

--
Best Regards,
Huang, Ying


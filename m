Return-Path: <linux-kernel+bounces-277500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCF94A24E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B424B29481
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC811C7B7C;
	Wed,  7 Aug 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+IRDqlW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C81C8227
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017569; cv=none; b=ODzPdavsLGd7RRETcD8jEk0hxkzVEy7ud//Ju+RkZ6lVQJz3gq+pGY6m3kgXo10G1GL+lef+InVwh4sjd5rqFHTKL5twwEQBIV/j2D81d3OoscC52gJAPZ2Kqy/0bURj/r2T4c50D2LU7Mhlc4my5iLj4HiDiBHO5U2KGi0tgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017569; c=relaxed/simple;
	bh=12GS+nDBmzZQFOZS2bgRKrUvAl/dh19rOZ4zOyzhDgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H4hayISiaIfLi6sewL+BdDxKbZeVOKghz1y7IW7pOQyUYssr6yHiewts9UTgBD5aZ4DOIssFaGLZvmm224qezi2wQj5PChogaTl+V2r88LG1NEAn2Tc2f7u1u1Y9rCIJVv5iNsM+KBrAt8vLd29kwPF30YIptnkM2ngarA765O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+IRDqlW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723017567; x=1754553567;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=12GS+nDBmzZQFOZS2bgRKrUvAl/dh19rOZ4zOyzhDgE=;
  b=L+IRDqlWleoz7YnaOSo1OuExzBVFi5ib43ip+mSZeekZoZ1yNsWRd2x4
   6sAD7vFM9IuQil4jHCa92CQuNCgzUIkVf+7arkkYWvh1VQ9F3eiTtDYW9
   82EjkFRq2IJa6yCl4V/k088x0tvB0r7EWH9+Vu+6bKS0FrY5OVQ4uGHwx
   2OsiwgaHxsNgRO2WkTQA2XuzTWpM8s3FoBLbGfPjTtRvbOuzHuwr0HhpP
   OTxpARF0bHNzkMjk8FnWvBhWXfsapiuVMZ2yAygggxutDfU85ORDSHH1o
   +XzTH+l7taPBSVbMoMFFrsKATuo8s6zB+vtuMD/4/854m0h4VNJC75+WC
   Q==;
X-CSE-ConnectionGUID: yII9TtrhT5Slgiz6/0IcHA==
X-CSE-MsgGUID: ZCYz0vQpQQ2UEdpkYvMdqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="12897384"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="12897384"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 00:59:26 -0700
X-CSE-ConnectionGUID: Jcy5rzWZTJ6arVzWA/2GbA==
X-CSE-MsgGUID: vUh1secxQJqPqISHtLJIjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61708564"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 00:59:24 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org> (Chris
	Li's message of "Tue, 30 Jul 2024 23:49:12 -0700")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
Date: Wed, 07 Aug 2024 15:55:50 +0800
Message-ID: <87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Chris,

Chris Li <chrisl@kernel.org> writes:

> This is the short term solutions "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.
>
> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> orders" is introduced, it only allocates the mTHP swap entries
> from the new empty cluster list. =C2=A0It has a fragmentation issue
> reported by Barry.
>
> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah=
+NSgNQ@mail.gmail.com/
>
> The reason is that all the empty clusters have been exhausted while
> there are plenty of free swap entries in the cluster that are
> not 100% free.
>
> Remember the swap allocation order in the cluster.
> Keep track of the per order non full cluster list for later allocation.
>
> This series gives the swap SSD allocation a new separate code path
> from the HDD allocation. The new allocator use cluster list only
> and do not global scan swap_map[] without lock any more.

This sounds good.  Can we use SSD allocation method for HDD too?
We may not need a swap entry allocator optimized for HDD.

Hi, Hugh,

What do you think about this?

> This streamline the swap allocation for SSD. The code matches the
> execution flow much better.
>
> User impact: For users that allocate and free mix order mTHP swapping,
> It greatly improves the success rate of the mTHP swap allocation after the
> initial phase.
>
> It also performs faster when the swapfile is close to full, because the
> allocator can get the non full cluster from a list rather than scanning
> a lot of swap_map entries.=C2=A0

Do you have some test results to prove this?  Or which test below can
prove this?

> With Barry's mthp test program V2:
>
> Without:
> $ ./thp_swap_allocator_test -a
> Iteration 1: swpout inc: 32, swpout fallback inc: 192, Fallback percentag=
e: 85.71%
> Iteration 2: swpout inc: 0, swpout fallback inc: 231, Fallback percentage=
: 100.00%
> Iteration 3: swpout inc: 0, swpout fallback inc: 227, Fallback percentage=
: 100.00%
> ...
> Iteration 98: swpout inc: 0, swpout fallback inc: 224, Fallback percentag=
e: 100.00%
> Iteration 99: swpout inc: 0, swpout fallback inc: 215, Fallback percentag=
e: 100.00%
> Iteration 100: swpout inc: 0, swpout fallback inc: 222, Fallback percenta=
ge: 100.00%
>
> $ ./thp_swap_allocator_test -a -s
> Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage=
: 100.00%
> Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage=
: 100.00%
> Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage=
: 100.00%
> ..
> Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentag=
e: 100.00%
> Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentag=
e: 100.00%
> Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percenta=
ge: 100.00%
>
> $ ./thp_swap_allocator_test -s
> Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage=
: 100.00%
> Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage=
: 100.00%
> Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage=
: 100.00%
> ..
> Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentag=
e: 100.00%
> Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentag=
e: 100.00%
> Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percenta=
ge: 100.00%
>
> $ ./thp_swap_allocator_test
> Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage=
: 100.00%
> Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage=
: 100.00%
> Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage=
: 100.00%
> ..
> Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentag=
e: 100.00%
> Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentag=
e: 100.00%
> Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percenta=
ge: 100.00%
>
> With: # with all 0.00% filter out
> $ ./thp_swap_allocator_test -a | grep -v "0.00%"
> $ # all result are 0.00%
>
> $ ./thp_swap_allocator_test -a -s | grep -v "0.00%"
> ./thp_swap_allocator_test -a -s | grep -v "0.00%"=20
> Iteration 14: swpout inc: 223, swpout fallback inc: 3, Fallback percentag=
e: 1.33%
> Iteration 19: swpout inc: 219, swpout fallback inc: 7, Fallback percentag=
e: 3.10%
> Iteration 28: swpout inc: 225, swpout fallback inc: 1, Fallback percentag=
e: 0.44%
> Iteration 29: swpout inc: 227, swpout fallback inc: 1, Fallback percentag=
e: 0.44%
> Iteration 34: swpout inc: 220, swpout fallback inc: 8, Fallback percentag=
e: 3.51%
> Iteration 35: swpout inc: 222, swpout fallback inc: 11, Fallback percenta=
ge: 4.72%
> Iteration 38: swpout inc: 217, swpout fallback inc: 4, Fallback percentag=
e: 1.81%
> Iteration 40: swpout inc: 222, swpout fallback inc: 6, Fallback percentag=
e: 2.63%
> Iteration 42: swpout inc: 221, swpout fallback inc: 2, Fallback percentag=
e: 0.90%
> Iteration 43: swpout inc: 215, swpout fallback inc: 7, Fallback percentag=
e: 3.15%
> Iteration 47: swpout inc: 226, swpout fallback inc: 2, Fallback percentag=
e: 0.88%
> Iteration 49: swpout inc: 217, swpout fallback inc: 1, Fallback percentag=
e: 0.46%
> Iteration 52: swpout inc: 221, swpout fallback inc: 8, Fallback percentag=
e: 3.49%
> Iteration 56: swpout inc: 224, swpout fallback inc: 4, Fallback percentag=
e: 1.75%
> Iteration 58: swpout inc: 214, swpout fallback inc: 5, Fallback percentag=
e: 2.28%
> Iteration 62: swpout inc: 220, swpout fallback inc: 3, Fallback percentag=
e: 1.35%
> Iteration 64: swpout inc: 224, swpout fallback inc: 1, Fallback percentag=
e: 0.44%
> Iteration 67: swpout inc: 221, swpout fallback inc: 1, Fallback percentag=
e: 0.45%
> Iteration 75: swpout inc: 220, swpout fallback inc: 9, Fallback percentag=
e: 3.93%
> Iteration 82: swpout inc: 227, swpout fallback inc: 1, Fallback percentag=
e: 0.44%
> Iteration 86: swpout inc: 211, swpout fallback inc: 12, Fallback percenta=
ge: 5.38%
> Iteration 89: swpout inc: 226, swpout fallback inc: 2, Fallback percentag=
e: 0.88%
> Iteration 93: swpout inc: 220, swpout fallback inc: 1, Fallback percentag=
e: 0.45%
> Iteration 94: swpout inc: 224, swpout fallback inc: 1, Fallback percentag=
e: 0.44%
> Iteration 96: swpout inc: 221, swpout fallback inc: 6, Fallback percentag=
e: 2.64%
> Iteration 98: swpout inc: 227, swpout fallback inc: 1, Fallback percentag=
e: 0.44%
> Iteration 99: swpout inc: 227, swpout fallback inc: 3, Fallback percentag=
e: 1.30%
>
> $ ./thp_swap_allocator_test=20=20=20=20=20=20
> ./thp_swap_allocator_test=20
> Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 131, swpout fallback inc: 101, Fallback percenta=
ge: 43.53%
> Iteration 3: swpout inc: 71, swpout fallback inc: 155, Fallback percentag=
e: 68.58%
> Iteration 4: swpout inc: 55, swpout fallback inc: 168, Fallback percentag=
e: 75.34%
> Iteration 5: swpout inc: 35, swpout fallback inc: 191, Fallback percentag=
e: 84.51%
> Iteration 6: swpout inc: 25, swpout fallback inc: 199, Fallback percentag=
e: 88.84%
> Iteration 7: swpout inc: 23, swpout fallback inc: 205, Fallback percentag=
e: 89.91%
> Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percentage=
: 96.05%
> Iteration 9: swpout inc: 13, swpout fallback inc: 213, Fallback percentag=
e: 94.25%
> Iteration 10: swpout inc: 12, swpout fallback inc: 216, Fallback percenta=
ge: 94.74%
> Iteration 11: swpout inc: 16, swpout fallback inc: 213, Fallback percenta=
ge: 93.01%
> Iteration 12: swpout inc: 10, swpout fallback inc: 210, Fallback percenta=
ge: 95.45%
> Iteration 13: swpout inc: 16, swpout fallback inc: 212, Fallback percenta=
ge: 92.98%
> Iteration 14: swpout inc: 12, swpout fallback inc: 212, Fallback percenta=
ge: 94.64%
> Iteration 15: swpout inc: 15, swpout fallback inc: 211, Fallback percenta=
ge: 93.36%
> Iteration 16: swpout inc: 15, swpout fallback inc: 200, Fallback percenta=
ge: 93.02%
> Iteration 17: swpout inc: 9, swpout fallback inc: 220, Fallback percentag=
e: 96.07%
>
> $ ./thp_swap_allocator_test -s
>  ./thp_swap_allocator_test -s
> Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 97, swpout fallback inc: 135, Fallback percentag=
e: 58.19%
> Iteration 3: swpout inc: 42, swpout fallback inc: 192, Fallback percentag=
e: 82.05%
> Iteration 4: swpout inc: 19, swpout fallback inc: 214, Fallback percentag=
e: 91.85%
> Iteration 5: swpout inc: 12, swpout fallback inc: 213, Fallback percentag=
e: 94.67%
> Iteration 6: swpout inc: 11, swpout fallback inc: 217, Fallback percentag=
e: 95.18%
> Iteration 7: swpout inc: 9, swpout fallback inc: 214, Fallback percentage=
: 95.96%
> Iteration 8: swpout inc: 8, swpout fallback inc: 213, Fallback percentage=
: 96.38%
> Iteration 9: swpout inc: 2, swpout fallback inc: 223, Fallback percentage=
: 99.11%
> Iteration 10: swpout inc: 2, swpout fallback inc: 228, Fallback percentag=
e: 99.13%
> Iteration 11: swpout inc: 4, swpout fallback inc: 214, Fallback percentag=
e: 98.17%
> Iteration 12: swpout inc: 5, swpout fallback inc: 226, Fallback percentag=
e: 97.84%
> Iteration 13: swpout inc: 3, swpout fallback inc: 212, Fallback percentag=
e: 98.60%
> Iteration 14: swpout inc: 0, swpout fallback inc: 222, Fallback percentag=
e: 100.00%
> Iteration 15: swpout inc: 3, swpout fallback inc: 222, Fallback percentag=
e: 98.67%
> Iteration 16: swpout inc: 4, swpout fallback inc: 223, Fallback percentag=
e: 98.24%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Kernel compile under tmpfs with cgroup memory.max =3D 470M.
> 12 core 24 hyperthreading, 32 jobs. 10 Run each group
>
> SSD swap 10 runs average, 20G swap partition:
> With:
> user    2929.064
> system  1479.381 : 1376.89 1398.22 1444.64 1477.39 1479.04 1497.27
> 1504.47 1531.4 1532.92 1551.57
> real    1441.324
>
> Without:
> user    2910.872
> system  1482.732 : 1440.01 1451.4 1462.01 1467.47 1467.51 1469.3
> 1470.19 1496.32 1544.1 1559.01
> real    1580.822
>
> Two zram swap: zram0 3.0G zram1 20G.
>
> The idea is forcing the zram0 almost full then overflow to zram1:
>
> With:
> user    4320.301
> system  4272.403 : 4236.24 4262.81 4264.75 4269.13 4269.44 4273.06
> 4279.85 4285.98 4289.64 4293.13
> real    431.759
>
> Without
> user    4301.393
> system  4387.672 : 4374.47 4378.3 4380.95 4382.84 4383.06 4388.05
> 4389.76 4397.16 4398.23 4403.9
> real    433.979
>
> ------ more test result from Kaiui ----------
>
> Test with build linux kernel using a 4G ZRAM, 1G memory.max limit on top =
of shmem:
>
> System info: 32 Core AMD Zen2, 64G total memory.
>
> Test 3 times using only 4K pages:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> With:
> -----
> 1838.74user 2411.21system 2:37.86elapsed 2692%CPU (0avgtext+0avgdata 8470=
60maxresident)k
> 1839.86user 2465.77system 2:39.35elapsed 2701%CPU (0avgtext+0avgdata 8470=
60maxresident)k
> 1840.26user 2454.68system 2:39.43elapsed 2693%CPU (0avgtext+0avgdata 8470=
60maxresident)k
>
> Summary (~4.6% improment of system time):
> User: 1839.62
> System: 2443.89: 2465.77 2454.68 2411.21
> Real: 158.88
>
> Without:
> --------
> 1837.99user 2575.95system 2:43.09elapsed 2706%CPU (0avgtext+0avgdata 8465=
20maxresident)k
> 1838.32user 2555.15system 2:42.52elapsed 2709%CPU (0avgtext+0avgdata 8465=
20maxresident)k
> 1843.02user 2561.55system 2:43.35elapsed 2702%CPU (0avgtext+0avgdata 8465=
20maxresident)k
>
> Summary:
> User: 1839.78
> System: 2564.22: 2575.95 2555.15 2561.55
> Real: 162.99
>
> Test 5 times using enabled all mTHP pages:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> With:
> -----
> 1796.44user 2937.33system 2:59.09elapsed 2643%CPU (0avgtext+0avgdata 8469=
36maxresident)k
> 1802.55user 3002.32system 2:54.68elapsed 2750%CPU (0avgtext+0avgdata 8470=
72maxresident)k
> 1806.59user 2986.53system 2:55.17elapsed 2736%CPU (0avgtext+0avgdata 8470=
92maxresident)k
> 1803.27user 2982.40system 2:54.49elapsed 2742%CPU (0avgtext+0avgdata 8467=
96maxresident)k
> 1807.43user 3036.08system 2:56.06elapsed 2751%CPU (0avgtext+0avgdata 8464=
88maxresident)k
>
> Summary (~8.4% improvement of system time):
> User: 1803.25
> System: 2988.93: 2937.33 3002.32 2986.53 2982.40 3036.08
> Real: 175.90
>
> mTHP swapout status:
> /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout:347721
> /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout_fallback:=
3110
> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/stats/swpout:3365
> /sys/kernel/mm/transparent_hugepage/hugepages-512kB/stats/swpout_fallback=
:8269
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/swpout:24
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/swpout_fallbac=
k:3341
> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/stats/swpout:145
> /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/stats/swpout_fallbac=
k:5038
> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout:322737
> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback:=
36808
> /sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout:380455
> /sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout_fallback:=
1010
> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/stats/swpout:24973
> /sys/kernel/mm/transparent_hugepage/hugepages-256kB/stats/swpout_fallback=
:13223
> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/stats/swpout:197348
> /sys/kernel/mm/transparent_hugepage/hugepages-128kB/stats/swpout_fallback=
:80541
>
> Without:
> --------
> 1794.41user 3151.29system 3:05.97elapsed 2659%CPU (0avgtext+0avgdata 8467=
04maxresident)k
> 1810.27user 3304.48system 3:05.38elapsed 2759%CPU (0avgtext+0avgdata 8466=
36maxresident)k
> 1809.84user 3254.85system 3:03.83elapsed 2755%CPU (0avgtext+0avgdata 8469=
52maxresident)k
> 1813.54user 3259.56system 3:04.28elapsed 2752%CPU (0avgtext+0avgdata 8468=
48maxresident)k
> 1829.97user 3338.40system 3:07.32elapsed 2759%CPU (0avgtext+0avgdata 8470=
24maxresident)k
>
> Summary:
> User: 1811.61
> System: 3261.72 : 3151.29 3304.48 3254.85 3259.56 3338.40
> Real: 185.356
>
> mTHP swapout status:
> hugepages-32kB/stats/swpout:35630
> hugepages-32kB/stats/swpout_fallback:1809908
> hugepages-512kB/stats/swpout:523
> hugepages-512kB/stats/swpout_fallback:55235
> hugepages-2048kB/stats/swpout:53
> hugepages-2048kB/stats/swpout_fallback:17264
> hugepages-1024kB/stats/swpout:85
> hugepages-1024kB/stats/swpout_fallback:24979
> hugepages-64kB/stats/swpout:30117
> hugepages-64kB/stats/swpout_fallback:1825399
> hugepages-16kB/stats/swpout:42775
> hugepages-16kB/stats/swpout_fallback:1951123
> hugepages-256kB/stats/swpout:2326
> hugepages-256kB/stats/swpout_fallback:170165
> hugepages-128kB/stats/swpout:17925
> hugepages-128kB/stats/swpout_fallback:1309757
>
> Reported-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v5:
> - Suggestion and fix up from v4 discussion thread from Yinm and Ryan.
> - Adding Kairui's swap cache reclaim patches on top of patch 3.
> - Link to v4: https://lore.kernel.org/r/20240711-swap-allocator-v4-0-0295=
a4d4c7aa@kernel.org
>
> Changes in v4:
> - Remove a warning in patch 2.
> - Allocating from the free cluster list before the nonfull list. Revert t=
he v3 behavior.
> - Add cluster_index and cluster_offset function.
> - Patch 3 has a new allocating path for SSD.
> - HDD swap allocation does not need to consider clusters any more.
>
> Changes in v3:
> - Using V1 as base.
> - Rename "next" to "list" for the list field, suggested by Ying.
> - Update comment for the locking rules for cluster fields and list,
>   suggested by Ying.
> - Allocate from the nonfull list before attempting free list, suggested
>   by Kairui.
> - Link to v2: https://lore.kernel.org/r/20240614-swap-allocator-v2-0-2a51=
3b4a7f2f@kernel.org
>
> Changes in v2:
> - Abandoned.
> - Link to v1: https://lore.kernel.org/r/20240524-swap-allocator-v1-0-4786=
1b423b26@kernel.org
>
> ---
> Chris Li (3):
>       mm: swap: swap cluster switch to double link list
>       mm: swap: mTHP allocate swap entries from nonfull list
>       mm: swap: separate SSD allocation from scan_swap_map_slots()
>
> Kairui Song (6):
>       mm: swap: clean up initialization helper
>       mm: swap: skip slot cache on freeing for mTHP
>       mm: swap: allow cache reclaim to skip slot cache
>       mm: swap: add a fragment cluster list
>       mm: swap: relaim the cached parts that got scanned
>       mm: swap: add a adaptive full cluster cache reclaim
>
>  include/linux/swap.h |  34 ++-
>  mm/swapfile.c        | 840 ++++++++++++++++++++++++++++++---------------=
------
>  2 files changed, 514 insertions(+), 360 deletions(-)
> ---
> base-commit: ff3a648ecb9409aff1448cf4f6aa41d78c69a3bc
> change-id: 20240523-swap-allocator-1534c480ece4
>

--
Best Regards,
Huang, Ying


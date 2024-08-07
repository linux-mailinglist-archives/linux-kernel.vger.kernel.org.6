Return-Path: <linux-kernel+bounces-278534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4E94B18A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E80282917
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A674C145FF9;
	Wed,  7 Aug 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLWnHy6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925182D66
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063354; cv=none; b=uUV9rQ5xWJJ1vCnzPF6o2uHubnypP8K3Xr28N5UjcWYPRaN5mdFlMDY9HB0aO+mwrMKHT7BBdXryG6uv+yd+sQQXXjBDWKysu+scJB/uJ8yYdd4bk7Eek8I+aHAHahGFSQ50964gqUTWop3dhtV07kBVX8JYDWA93Uwj1+lBqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063354; c=relaxed/simple;
	bh=tyackwCEq0zxvFKelz07tCXSPQbnHm8M5puBgIhSkvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6cqjomtNQ9xxDeKkWYbwGUfzKXEwBExV9qKx4pZOsK9xYC+Z4+H39kWCFPdwK5D20fZtNNGD8rH1BjKm0QDF7jXWpy0vNwotH/yF7qKS9+XtTg+w5Q8MViJTdaUNbLqObBeHsPlKB6RGxI955i2J2hirvgRu/pVMKgiOOlIeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLWnHy6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0495C4AF14
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723063353;
	bh=tyackwCEq0zxvFKelz07tCXSPQbnHm8M5puBgIhSkvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FLWnHy6dcfUxHkCQCbxVZ96hy2/g3dVnJvQnVCDyarhwWyyXukh3hhKYHA16VmqWd
	 YDGs0MC6QOoLu5+9M/YmUb/n7i2yrI7X/HpVC+cRDdbHjl2blp+/f+XJf3WfB5R0+9
	 kH0TfsIGwBy4kQDMerCP2798mOiay3pKVxivZpMobWaselmrSZ7UmSuHhA0hBrwq5Q
	 gBnmbz6IPvsTq4n5qukpbvy6PBt99Vt5e+cfWuQxY7DU0dPoJ3qAEaaImqvH8qkWLI
	 Hu+ZBkSuSZCl10topudUgj7ULZu5xT0uRvLVvYz8ttgdLFUFqAMUFHCvAkf1xtbqtO
	 fiVNCZym1EG0w==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-65fe1239f12so2370187b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:42:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQQeYlZ5ZOEJXHRAjPj2zWCurW4SzF2kedQEJMF4NxXCjA//rvy3Ii0TqsSF2BofPdRwCzbNNFzWE3lN2ExltZxcp3rhk6x5OuyW3N
X-Gm-Message-State: AOJu0Yzn7Te2vknPbi70MgxDbP6IaQZzUb7b7ZNGiicXAvnna/Yjouol
	1BAi6gmFoM13B6CFhdVYRSTg4Gh7wuXobGaA3iFiAlJZCPQBULjZtOufHneQK0B2G8TZGUe8Oa6
	zzRdPfZkJ+723WDaIziV0neqLAdypOwo3iw31og==
X-Google-Smtp-Source: AGHT+IF6+iz/qROk6eySa5jM6oXuJ3F0y8c8esXbhe4ApcTGSEOfoTFQgMxF+oFO1eoL7P7HVa0x+pK0vsA0/QrBB8E=
X-Received: by 2002:a0d:da42:0:b0:65f:7deb:de59 with SMTP id
 00721157ae682-689613224f7mr186335707b3.21.1723063352839; Wed, 07 Aug 2024
 13:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org> <87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87h6bw3gxl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 7 Aug 2024 13:42:20 -0700
X-Gmail-Original-Message-ID: <CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
Message-ID: <CACePvbXH8b9SOePQ-Ld_UBbcAdJ3gdYtEkReMto5Hbq9WAL7JQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:59=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Chris,
>
> Chris Li <chrisl@kernel.org> writes:
>
> > This is the short term solutions "swap cluster order" listed
> > in my "Swap Abstraction" discussion slice 8 in the recent
> > LSF/MM conference.
> >
> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> > orders" is introduced, it only allocates the mTHP swap entries
> > from the new empty cluster list.  It has a fragmentation issue
> > reported by Barry.
> >
> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+=
Ah+NSgNQ@mail.gmail.com/
> >
> > The reason is that all the empty clusters have been exhausted while
> > there are plenty of free swap entries in the cluster that are
> > not 100% free.
> >
> > Remember the swap allocation order in the cluster.
> > Keep track of the per order non full cluster list for later allocation.
> >
> > This series gives the swap SSD allocation a new separate code path
> > from the HDD allocation. The new allocator use cluster list only
> > and do not global scan swap_map[] without lock any more.
>
> This sounds good.  Can we use SSD allocation method for HDD too?
> We may not need a swap entry allocator optimized for HDD.

Yes, that is the plan as well. That way we can completely get rid of
the old scan_swap_map_slots() code.
However, considering the size of the series, let's focus on the
cluster allocation path first, get it tested and reviewed.

For HDD optimization, mostly just the new block allocations portion
need some separate code path from the new cluster allocator to not do
the per cpu allocation.  Allocating from the non free list doesn't
need to change too much.
>
> Hi, Hugh,
>
> What do you think about this?
>
> > This streamline the swap allocation for SSD. The code matches the
> > execution flow much better.
> >
> > User impact: For users that allocate and free mix order mTHP swapping,
> > It greatly improves the success rate of the mTHP swap allocation after =
the
> > initial phase.
> >
> > It also performs faster when the swapfile is close to full, because the
> > allocator can get the non full cluster from a list rather than scanning
> > a lot of swap_map entries.
>
> Do you have some test results to prove this?  Or which test below can
> prove this?

The two zram tests are already proving this. The system time
improvement is about 2% on my low CPU count machine.
Kairui has a higher core count machine and the difference is higher
there. The theory is that higher CPU count has higher contentions.

The 2% system time number does not sound like much. But consider this
two factors:
1) swap allocator only takes a small percentage of the overall workload.
2) The new allocator does more work.
The old allocator has a time tick budget. It will abort and fail to
find an entry when it runs out of time budget, even though there are
still some free entries on the swapfile.
The new allocator can get to the last few free swap entries if it is
available. If not then, the new swap allocator will work harder on
swap cache reclaim.

From the swap cache reclaim aspect, it is very hard to optimize the
swap cache reclaim in the old allocation path because the scan
position is randomized.
The full list and frag list both design to help reduce the repeat
reclaim attempt of the swap cache.

>
> > With Barry's mthp test program V2:
> >
> > Without:
> > $ ./thp_swap_allocator_test -a
> > Iteration 1: swpout inc: 32, swpout fallback inc: 192, Fallback percent=
age: 85.71%
> > Iteration 2: swpout inc: 0, swpout fallback inc: 231, Fallback percenta=
ge: 100.00%
> > Iteration 3: swpout inc: 0, swpout fallback inc: 227, Fallback percenta=
ge: 100.00%
> > ...
> > Iteration 98: swpout inc: 0, swpout fallback inc: 224, Fallback percent=
age: 100.00%
> > Iteration 99: swpout inc: 0, swpout fallback inc: 215, Fallback percent=
age: 100.00%
> > Iteration 100: swpout inc: 0, swpout fallback inc: 222, Fallback percen=
tage: 100.00%
> >
> > $ ./thp_swap_allocator_test -a -s
> > Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percenta=
ge: 100.00%
> > Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percenta=
ge: 100.00%
> > Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percenta=
ge: 100.00%
> > ..
> > Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percent=
age: 100.00%
> > Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percent=
age: 100.00%
> > Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percen=
tage: 100.00%
> >
> > $ ./thp_swap_allocator_test -s
> > Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percenta=
ge: 100.00%
> > Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percenta=
ge: 100.00%
> > Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percenta=
ge: 100.00%
> > ..
> > Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percent=
age: 100.00%
> > Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percent=
age: 100.00%
> > Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percen=
tage: 100.00%
> >
> > $ ./thp_swap_allocator_test
> > Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percenta=
ge: 100.00%
> > Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percenta=
ge: 100.00%
> > Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percenta=
ge: 100.00%
> > ..
> > Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percent=
age: 100.00%
> > Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percent=
age: 100.00%
> > Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percen=
tage: 100.00%
> >
> > With: # with all 0.00% filter out
> > $ ./thp_swap_allocator_test -a | grep -v "0.00%"
> > $ # all result are 0.00%
> >
> > $ ./thp_swap_allocator_test -a -s | grep -v "0.00%"
> > ./thp_swap_allocator_test -a -s | grep -v "0.00%"
> > Iteration 14: swpout inc: 223, swpout fallback inc: 3, Fallback percent=
age: 1.33%
> > Iteration 19: swpout inc: 219, swpout fallback inc: 7, Fallback percent=
age: 3.10%
> > Iteration 28: swpout inc: 225, swpout fallback inc: 1, Fallback percent=
age: 0.44%
> > Iteration 29: swpout inc: 227, swpout fallback inc: 1, Fallback percent=
age: 0.44%
> > Iteration 34: swpout inc: 220, swpout fallback inc: 8, Fallback percent=
age: 3.51%
> > Iteration 35: swpout inc: 222, swpout fallback inc: 11, Fallback percen=
tage: 4.72%
> > Iteration 38: swpout inc: 217, swpout fallback inc: 4, Fallback percent=
age: 1.81%
> > Iteration 40: swpout inc: 222, swpout fallback inc: 6, Fallback percent=
age: 2.63%
> > Iteration 42: swpout inc: 221, swpout fallback inc: 2, Fallback percent=
age: 0.90%
> > Iteration 43: swpout inc: 215, swpout fallback inc: 7, Fallback percent=
age: 3.15%
> > Iteration 47: swpout inc: 226, swpout fallback inc: 2, Fallback percent=
age: 0.88%
> > Iteration 49: swpout inc: 217, swpout fallback inc: 1, Fallback percent=
age: 0.46%
> > Iteration 52: swpout inc: 221, swpout fallback inc: 8, Fallback percent=
age: 3.49%
> > Iteration 56: swpout inc: 224, swpout fallback inc: 4, Fallback percent=
age: 1.75%
> > Iteration 58: swpout inc: 214, swpout fallback inc: 5, Fallback percent=
age: 2.28%
> > Iteration 62: swpout inc: 220, swpout fallback inc: 3, Fallback percent=
age: 1.35%
> > Iteration 64: swpout inc: 224, swpout fallback inc: 1, Fallback percent=
age: 0.44%
> > Iteration 67: swpout inc: 221, swpout fallback inc: 1, Fallback percent=
age: 0.45%
> > Iteration 75: swpout inc: 220, swpout fallback inc: 9, Fallback percent=
age: 3.93%
> > Iteration 82: swpout inc: 227, swpout fallback inc: 1, Fallback percent=
age: 0.44%
> > Iteration 86: swpout inc: 211, swpout fallback inc: 12, Fallback percen=
tage: 5.38%
> > Iteration 89: swpout inc: 226, swpout fallback inc: 2, Fallback percent=
age: 0.88%
> > Iteration 93: swpout inc: 220, swpout fallback inc: 1, Fallback percent=
age: 0.45%
> > Iteration 94: swpout inc: 224, swpout fallback inc: 1, Fallback percent=
age: 0.44%
> > Iteration 96: swpout inc: 221, swpout fallback inc: 6, Fallback percent=
age: 2.64%
> > Iteration 98: swpout inc: 227, swpout fallback inc: 1, Fallback percent=
age: 0.44%
> > Iteration 99: swpout inc: 227, swpout fallback inc: 3, Fallback percent=
age: 1.30%
> >
> > $ ./thp_swap_allocator_test
> > ./thp_swap_allocator_test
> > Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 131, swpout fallback inc: 101, Fallback percen=
tage: 43.53%
> > Iteration 3: swpout inc: 71, swpout fallback inc: 155, Fallback percent=
age: 68.58%
> > Iteration 4: swpout inc: 55, swpout fallback inc: 168, Fallback percent=
age: 75.34%
> > Iteration 5: swpout inc: 35, swpout fallback inc: 191, Fallback percent=
age: 84.51%
> > Iteration 6: swpout inc: 25, swpout fallback inc: 199, Fallback percent=
age: 88.84%
> > Iteration 7: swpout inc: 23, swpout fallback inc: 205, Fallback percent=
age: 89.91%
> > Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percenta=
ge: 96.05%
> > Iteration 9: swpout inc: 13, swpout fallback inc: 213, Fallback percent=
age: 94.25%
> > Iteration 10: swpout inc: 12, swpout fallback inc: 216, Fallback percen=
tage: 94.74%
> > Iteration 11: swpout inc: 16, swpout fallback inc: 213, Fallback percen=
tage: 93.01%
> > Iteration 12: swpout inc: 10, swpout fallback inc: 210, Fallback percen=
tage: 95.45%
> > Iteration 13: swpout inc: 16, swpout fallback inc: 212, Fallback percen=
tage: 92.98%
> > Iteration 14: swpout inc: 12, swpout fallback inc: 212, Fallback percen=
tage: 94.64%
> > Iteration 15: swpout inc: 15, swpout fallback inc: 211, Fallback percen=
tage: 93.36%
> > Iteration 16: swpout inc: 15, swpout fallback inc: 200, Fallback percen=
tage: 93.02%
> > Iteration 17: swpout inc: 9, swpout fallback inc: 220, Fallback percent=
age: 96.07%
> >
> > $ ./thp_swap_allocator_test -s
> >  ./thp_swap_allocator_test -s
> > Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
> > Iteration 2: swpout inc: 97, swpout fallback inc: 135, Fallback percent=
age: 58.19%
> > Iteration 3: swpout inc: 42, swpout fallback inc: 192, Fallback percent=
age: 82.05%
> > Iteration 4: swpout inc: 19, swpout fallback inc: 214, Fallback percent=
age: 91.85%
> > Iteration 5: swpout inc: 12, swpout fallback inc: 213, Fallback percent=
age: 94.67%
> > Iteration 6: swpout inc: 11, swpout fallback inc: 217, Fallback percent=
age: 95.18%
> > Iteration 7: swpout inc: 9, swpout fallback inc: 214, Fallback percenta=
ge: 95.96%
> > Iteration 8: swpout inc: 8, swpout fallback inc: 213, Fallback percenta=
ge: 96.38%
> > Iteration 9: swpout inc: 2, swpout fallback inc: 223, Fallback percenta=
ge: 99.11%
> > Iteration 10: swpout inc: 2, swpout fallback inc: 228, Fallback percent=
age: 99.13%
> > Iteration 11: swpout inc: 4, swpout fallback inc: 214, Fallback percent=
age: 98.17%
> > Iteration 12: swpout inc: 5, swpout fallback inc: 226, Fallback percent=
age: 97.84%
> > Iteration 13: swpout inc: 3, swpout fallback inc: 212, Fallback percent=
age: 98.60%
> > Iteration 14: swpout inc: 0, swpout fallback inc: 222, Fallback percent=
age: 100.00%
> > Iteration 15: swpout inc: 3, swpout fallback inc: 222, Fallback percent=
age: 98.67%
> > Iteration 16: swpout inc: 4, swpout fallback inc: 223, Fallback percent=
age: 98.24%
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Kernel compile under tmpfs with cgroup memory.max =3D 470M.
> > 12 core 24 hyperthreading, 32 jobs. 10 Run each group
> >
> > SSD swap 10 runs average, 20G swap partition:
> > With:
> > user    2929.064
> > system  1479.381 : 1376.89 1398.22 1444.64 1477.39 1479.04 1497.27
> > 1504.47 1531.4 1532.92 1551.57
> > real    1441.324
> >
> > Without:
> > user    2910.872
> > system  1482.732 : 1440.01 1451.4 1462.01 1467.47 1467.51 1469.3
> > 1470.19 1496.32 1544.1 1559.01
> > real    1580.822
> >
> > Two zram swap: zram0 3.0G zram1 20G.
> >
> > The idea is forcing the zram0 almost full then overflow to zram1:
> >
> > With:
> > user    4320.301
> > system  4272.403 : 4236.24 4262.81 4264.75 4269.13 4269.44 4273.06
> > 4279.85 4285.98 4289.64 4293.13
> > real    431.759
> >
> > Without
> > user    4301.393
> > system  4387.672 : 4374.47 4378.3 4380.95 4382.84 4383.06 4388.05

system time 4272 vs 4387. That is about a 2% difference.

Chris

> > 4389.76 4397.16 4398.23 4403.9
> > real    433.979
> >
> > ------ more test result from Kaiui ----------
> >
> > Test with build linux kernel using a 4G ZRAM, 1G memory.max limit on to=
p of shmem:
> >
> > System info: 32 Core AMD Zen2, 64G total memory.
> >
> > Test 3 times using only 4K pages:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > With:
> > -----
> > 1838.74user 2411.21system 2:37.86elapsed 2692%CPU (0avgtext+0avgdata 84=
7060maxresident)k
> > 1839.86user 2465.77system 2:39.35elapsed 2701%CPU (0avgtext+0avgdata 84=
7060maxresident)k
> > 1840.26user 2454.68system 2:39.43elapsed 2693%CPU (0avgtext+0avgdata 84=
7060maxresident)k
> >
> > Summary (~4.6% improment of system time):
> > User: 1839.62
> > System: 2443.89: 2465.77 2454.68 2411.21
> > Real: 158.88
> >
> > Without:
> > --------
> > 1837.99user 2575.95system 2:43.09elapsed 2706%CPU (0avgtext+0avgdata 84=
6520maxresident)k
> > 1838.32user 2555.15system 2:42.52elapsed 2709%CPU (0avgtext+0avgdata 84=
6520maxresident)k
> > 1843.02user 2561.55system 2:43.35elapsed 2702%CPU (0avgtext+0avgdata 84=
6520maxresident)k
> >
> > Summary:
> > User: 1839.78
> > System: 2564.22: 2575.95 2555.15 2561.55
> > Real: 162.99
> >
> > Test 5 times using enabled all mTHP pages:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > With:
> > -----
> > 1796.44user 2937.33system 2:59.09elapsed 2643%CPU (0avgtext+0avgdata 84=
6936maxresident)k
> > 1802.55user 3002.32system 2:54.68elapsed 2750%CPU (0avgtext+0avgdata 84=
7072maxresident)k
> > 1806.59user 2986.53system 2:55.17elapsed 2736%CPU (0avgtext+0avgdata 84=
7092maxresident)k
> > 1803.27user 2982.40system 2:54.49elapsed 2742%CPU (0avgtext+0avgdata 84=
6796maxresident)k
> > 1807.43user 3036.08system 2:56.06elapsed 2751%CPU (0avgtext+0avgdata 84=
6488maxresident)k
> >
> > Summary (~8.4% improvement of system time):
> > User: 1803.25
> > System: 2988.93: 2937.33 3002.32 2986.53 2982.40 3036.08
> > Real: 175.90
> >
> > mTHP swapout status:
> > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout:347721
> > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout_fallbac=
k:3110
> > /sys/kernel/mm/transparent_hugepage/hugepages-512kB/stats/swpout:3365
> > /sys/kernel/mm/transparent_hugepage/hugepages-512kB/stats/swpout_fallba=
ck:8269
> > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/swpout:24
> > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/swpout_fallb=
ack:3341
> > /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/stats/swpout:145
> > /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/stats/swpout_fallb=
ack:5038
> > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout:322737
> > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallbac=
k:36808
> > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout:380455
> > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout_fallbac=
k:1010
> > /sys/kernel/mm/transparent_hugepage/hugepages-256kB/stats/swpout:24973
> > /sys/kernel/mm/transparent_hugepage/hugepages-256kB/stats/swpout_fallba=
ck:13223
> > /sys/kernel/mm/transparent_hugepage/hugepages-128kB/stats/swpout:197348
> > /sys/kernel/mm/transparent_hugepage/hugepages-128kB/stats/swpout_fallba=
ck:80541
> >
> > Without:
> > --------
> > 1794.41user 3151.29system 3:05.97elapsed 2659%CPU (0avgtext+0avgdata 84=
6704maxresident)k
> > 1810.27user 3304.48system 3:05.38elapsed 2759%CPU (0avgtext+0avgdata 84=
6636maxresident)k
> > 1809.84user 3254.85system 3:03.83elapsed 2755%CPU (0avgtext+0avgdata 84=
6952maxresident)k
> > 1813.54user 3259.56system 3:04.28elapsed 2752%CPU (0avgtext+0avgdata 84=
6848maxresident)k
> > 1829.97user 3338.40system 3:07.32elapsed 2759%CPU (0avgtext+0avgdata 84=
7024maxresident)k
> >
> > Summary:
> > User: 1811.61
> > System: 3261.72 : 3151.29 3304.48 3254.85 3259.56 3338.40
> > Real: 185.356
> >
> > mTHP swapout status:
> > hugepages-32kB/stats/swpout:35630
> > hugepages-32kB/stats/swpout_fallback:1809908
> > hugepages-512kB/stats/swpout:523
> > hugepages-512kB/stats/swpout_fallback:55235
> > hugepages-2048kB/stats/swpout:53
> > hugepages-2048kB/stats/swpout_fallback:17264
> > hugepages-1024kB/stats/swpout:85
> > hugepages-1024kB/stats/swpout_fallback:24979
> > hugepages-64kB/stats/swpout:30117
> > hugepages-64kB/stats/swpout_fallback:1825399
> > hugepages-16kB/stats/swpout:42775
> > hugepages-16kB/stats/swpout_fallback:1951123
> > hugepages-256kB/stats/swpout:2326
> > hugepages-256kB/stats/swpout_fallback:170165
> > hugepages-128kB/stats/swpout:17925
> > hugepages-128kB/stats/swpout_fallback:1309757
> >
> > Reported-by: Barry Song <21cnbao@gmail.com>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > Changes in v5:
> > - Suggestion and fix up from v4 discussion thread from Yinm and Ryan.
> > - Adding Kairui's swap cache reclaim patches on top of patch 3.
> > - Link to v4: https://lore.kernel.org/r/20240711-swap-allocator-v4-0-02=
95a4d4c7aa@kernel.org
> >
> > Changes in v4:
> > - Remove a warning in patch 2.
> > - Allocating from the free cluster list before the nonfull list. Revert=
 the v3 behavior.
> > - Add cluster_index and cluster_offset function.
> > - Patch 3 has a new allocating path for SSD.
> > - HDD swap allocation does not need to consider clusters any more.
> >
> > Changes in v3:
> > - Using V1 as base.
> > - Rename "next" to "list" for the list field, suggested by Ying.
> > - Update comment for the locking rules for cluster fields and list,
> >   suggested by Ying.
> > - Allocate from the nonfull list before attempting free list, suggested
> >   by Kairui.
> > - Link to v2: https://lore.kernel.org/r/20240614-swap-allocator-v2-0-2a=
513b4a7f2f@kernel.org
> >
> > Changes in v2:
> > - Abandoned.
> > - Link to v1: https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47=
861b423b26@kernel.org
> >
> > ---
> > Chris Li (3):
> >       mm: swap: swap cluster switch to double link list
> >       mm: swap: mTHP allocate swap entries from nonfull list
> >       mm: swap: separate SSD allocation from scan_swap_map_slots()
> >
> > Kairui Song (6):
> >       mm: swap: clean up initialization helper
> >       mm: swap: skip slot cache on freeing for mTHP
> >       mm: swap: allow cache reclaim to skip slot cache
> >       mm: swap: add a fragment cluster list
> >       mm: swap: relaim the cached parts that got scanned
> >       mm: swap: add a adaptive full cluster cache reclaim
> >
> >  include/linux/swap.h |  34 ++-
> >  mm/swapfile.c        | 840 ++++++++++++++++++++++++++++++-------------=
--------
> >  2 files changed, 514 insertions(+), 360 deletions(-)
> > ---
> > base-commit: ff3a648ecb9409aff1448cf4f6aa41d78c69a3bc
> > change-id: 20240523-swap-allocator-1534c480ece4
> >
>
> --
> Best Regards,
> Huang, Ying


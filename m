Return-Path: <linux-kernel+bounces-193091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782C8D26B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B45B1F238D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781C17B41A;
	Tue, 28 May 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4Xp1GuF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F316F0F9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930287; cv=none; b=bfFpLz9sruIxlmmz16YEs2J5uXVLhDKSxk08ZDGLllfrtjotORoGl1wqLADqYyzcScyMibv4Gf28SSJfMutknu87w4BWf2V6tr2CmOmigAVCSRj9GcJdPgh3PAcJRBK+3iz+b4cOc6kQCPQ1TG+/z3w65SF4fFSRfYfVy/cBxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930287; c=relaxed/simple;
	bh=FQKBHUMwkBg9cm1I18Hsi7G/Wdg85FGQc52gDleKmxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjfyztETXnnNAvbXL0dbhWhyM/K+XkNVugW6dnmVR+u6y3izRE3BAzYgridPnF8/emIn41Nbxa6IHE0JpRoCujmSEPxwfhbPDwqVkGLq1BUx+5YR5CC7hD0mtVLBK1uNebOmkDRef3CcMyFHdVVt2k+iwIq60oNkvJRcat9ZN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4Xp1GuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280D6C32786
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716930287;
	bh=FQKBHUMwkBg9cm1I18Hsi7G/Wdg85FGQc52gDleKmxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T4Xp1GuFRLL1ToWfAXx3Vlkk8rqfejFmIbHOhFcF6hSyyQvD35ztsF5bT2Yd5323b
	 zR7FQ0fsmYUofuujnDdqOyvVoGdu1DfeW8xv7kDLiAMffzbkWRlYitLhCPoDa0NnVL
	 iEqX6qOV45rEhiQdjHnMjm9FHwFG4+97bikGcatC1yRwpuOnTdNRszefS3yUSatWvU
	 uYVXppjby84a9DvpMjV7NWFm4hdNGh2gUuQfUJhhb+LkGZioNK/PTEPUeOqoa2Qn0g
	 HrpCWdsMDL+95zhnYS6PhfFUIRY0epr4j8roW6Pcm2tu+bqGWJlcGsMKlhadQXFU35
	 88EVuw5HQupgg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-529644ec0ebso2129992e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:04:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVbIbTfg3ygozkE520nTehY0QqXzgblC4xlaaOOSg2zsqcgDyvlCc3ygwljgwaZcX+iJ4mnAX8QTBF2VtbqQyxYQAESkOMAyNtpL52
X-Gm-Message-State: AOJu0YyHccuSD1G8XqchsGdupISUx32EQ9+iUcRjmXU/tqZLHY2ufjkB
	z6SxoR9lpsiJNxTEysYQ/9uVo5/JYIoUyX3h5ktCGBscE9eg9FKuD00XZCfjiFTicl57UHknsqI
	YqkGp6DD5zAuavoyR3YDZuQoHRQ==
X-Google-Smtp-Source: AGHT+IH3r7x8C5fW6foR+0V0Ga6GIwmxLEEA8CoeTj8OnCZQxMuj6eV2dscFklGcPHU6QnPqmT9Ohamn038HopG4uso=
X-Received: by 2002:a19:8c1d:0:b0:51b:9254:91e7 with SMTP id
 2adb3069b0e04-529679322a3mr10216024e87.61.1716930285747; Tue, 28 May 2024
 14:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
In-Reply-To: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 28 May 2024 14:04:34 -0700
X-Gmail-Original-Message-ID: <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
Message-ID: <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am spinning a new version for this series to address two issues
found in this series:

1) Oppo discovered a bug in the following line:
+               ci =3D si->cluster_info + tmp;
Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
That is a serious bug but trivial to fix.

2) order 0 allocation currently blindly scans swap_map disregarding
the cluster->order. Given enough order 0 swap allocations(close to the
swap file size) the order 0 allocation head will eventually sweep
across the whole swapfile and destroy other cluster order allocations.

The short term fix is just skipping clusters that are already assigned
to higher orders.

In the long term, I want to unify the non-SSD to use clusters for
locking and allocations as well, just try to follow the last
allocation (less seeking) as much as possible.

Chris



On Fri, May 24, 2024 at 10:17=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> This is the short term solutiolns "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.
>
> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> orders" is introduced, it only allocates the mTHP swap entries
> from new empty cluster list. That works well for PMD size THP,
> but it has a serius fragmentation issue reported by Barry.
>
> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah=
+NSgNQ@mail.gmail.com/
>
> The mTHP allocation failure rate raises to almost 100% after a few
> hours in Barry's test run.
>
> The reason is that all the empty cluster has been exhausted while
> there are planty of free swap entries to in the cluster that is
> not 100% free.
>
> Address this by remember the swap allocation order in the cluster.
> Keep track of the per order non full cluster list for later allocation.
>
> This greatly improve the sucess rate of the mTHP swap allocation.
> While I am still waiting for Barry's test result. I paste Kairui's test
> result here:
>
> I'm able to reproduce such an issue with a simple script (enabling all or=
der of mthp):
>
> modprobe brd rd_nr=3D1 rd_size=3D$(( 10 * 1024 * 1024))
> swapoff -a
> mkswap /dev/ram0
> swapon /dev/ram0
>
> rmdir /sys/fs/cgroup/benchmark
> mkdir -p /sys/fs/cgroup/benchmark
> cd /sys/fs/cgroup/benchmark
> echo 8G > memory.max
> echo $$ > cgroup.procs
>
> memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 32 -B bi=
nary &
>
> /usr/local/bin/memtier_benchmark -S /tmp/memcached.socket \
>         -P memcache_binary -n allkeys --key-minimum=3D1 \
>         --key-maximum=3D18000000 --key-pattern=3DP:P -c 1 -t 32 \
>         --ratio 1:0 --pipeline 8 -d 1024
>
> Before:
> Totals      48805.63         0.00         0.00         5.26045         1.=
19100        38.91100        59.64700     51063.98
> After:
> Totals      71098.84         0.00         0.00         3.60585         0.=
71100        26.36700        39.16700     74388.74
>
> And the fallback ratio dropped by a lot:
> Before:
> hugepages-32kB/stats/anon_swpout_fallback:15997
> hugepages-32kB/stats/anon_swpout:18712
> hugepages-512kB/stats/anon_swpout_fallback:192
> hugepages-512kB/stats/anon_swpout:0
> hugepages-2048kB/stats/anon_swpout_fallback:2
> hugepages-2048kB/stats/anon_swpout:0
> hugepages-1024kB/stats/anon_swpout_fallback:0
> hugepages-1024kB/stats/anon_swpout:0
> hugepages-64kB/stats/anon_swpout_fallback:18246
> hugepages-64kB/stats/anon_swpout:17644
> hugepages-16kB/stats/anon_swpout_fallback:13701
> hugepages-16kB/stats/anon_swpout:18234
> hugepages-256kB/stats/anon_swpout_fallback:8642
> hugepages-256kB/stats/anon_swpout:93
> hugepages-128kB/stats/anon_swpout_fallback:21497
> hugepages-128kB/stats/anon_swpout:7596
>
> (Still collecting more data, the success swpout was mostly done early, th=
en the fallback began to increase, nearly 100% failure rate)
>
> After:
> hugepages-32kB/stats/swpout:34445
> hugepages-32kB/stats/swpout_fallback:0
> hugepages-512kB/stats/swpout:1
> hugepages-512kB/stats/swpout_fallback:134
> hugepages-2048kB/stats/swpout:1
> hugepages-2048kB/stats/swpout_fallback:1
> hugepages-1024kB/stats/swpout:6
> hugepages-1024kB/stats/swpout_fallback:0
> hugepages-64kB/stats/swpout:35495
> hugepages-64kB/stats/swpout_fallback:0
> hugepages-16kB/stats/swpout:32441
> hugepages-16kB/stats/swpout_fallback:0
> hugepages-256kB/stats/swpout:2223
> hugepages-256kB/stats/swpout_fallback:6278
> hugepages-128kB/stats/swpout:29136
> hugepages-128kB/stats/swpout_fallback:52
>
> Reported-by: Barry Song <21cnbao@gmail.com>
> Tested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Chris Li (2):
>       mm: swap: swap cluster switch to double link list
>       mm: swap: mTHP allocate swap entries from nonfull list
>
>  include/linux/swap.h |  18 ++--
>  mm/swapfile.c        | 252 +++++++++++++++++----------------------------=
------
>  2 files changed, 93 insertions(+), 177 deletions(-)
> ---
> base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
> change-id: 20240523-swap-allocator-1534c480ece4
>
> Best regards,
> --
> Chris Li <chrisl@kernel.org>
>


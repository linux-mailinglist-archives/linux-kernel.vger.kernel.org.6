Return-Path: <linux-kernel+bounces-194839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8093B8D42C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CEB1C210AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E589175AA;
	Thu, 30 May 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EezWnhBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC117545
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031627; cv=none; b=aQNqQiCov2d6sAGkUu9Qbs3LzIRsPAPe3Qa3dZsEGuEy11GDQbDXQOa9me232OKiKNv0VhSdlSX8WZm1GlN19weOZMa2mJzfB+JEcl0EtfkUWgjSb5KCPgPSAAfTsll102mEQqajfgrr6yTSKpslmHgz0PS9ZJuZRWLJLAw8yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031627; c=relaxed/simple;
	bh=lcfwicAIhv+K0jpxdsaL8YKqGVirMg2TDZNQUpc39lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDkoSXfNg9gp5vCbodmcYxR3svBEtKGyp38pyZhrcPq8q5RuuYtWA4A/Lf5ZwZDQNh/q3iXVIIrkPNVz/vvehCYAo2C1piUb/TpAx57tLzBCLYI+jRwFJi/JwGhkeOATVgYwbySOis2bf2CdGRcoicXDpNHs9ntsOUSyQosOsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EezWnhBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEAEC113CC
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717031627;
	bh=lcfwicAIhv+K0jpxdsaL8YKqGVirMg2TDZNQUpc39lk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EezWnhBVWI+faDkkufEkaa6+L3V4/PGXv7l/i9xzhdTyWur/63vBrPFySd73ylpOt
	 mNbhvKPCpuhXgp1uEiACJHtNoi2r93fVyUEew11XhXDv/OhwGlYKoGX84LnYFG9Uw1
	 hftqJS7tDZuri6oPiErTSZTmUvJwpIxrIYQAmAeWjXNENjXWsqpRiKLCnGlULzAqOa
	 EqYkN9hvLxxndn9zerf3Vwwa2uH7iWDT+OyP/sfE9G8ojUReJtHtWwYppUGeA54JzS
	 hp5wb8m5369TK2QwWCYOpYJD5pKrBQ8JW9N2qALY8Qm+fagsiMv41nvk+3n/PQI7Z3
	 ZjfDMndSFqy+g==
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e8dcad116fso21571139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:13:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKv5t9kO9VkWytwBJtiUJiTL7e3+02OIGpSI2ldJ9pIEbxoFOaD6GZWDY9jIW0TvHuQ2sbspjrxGd1JmtElEZUucCA2ehZymM5y9iO
X-Gm-Message-State: AOJu0Yw4gkJdfUkT/rXwK+lvQTlKAQfWbk+zmg6ZzQ6vxBAhf8eT8Wcs
	1sf1bBWwaEjuOnLk80L+T4/LaxZRzyk5vplCiEW07TP3At21zwXXM620KVDFlQkONYbX7ch3v/m
	9qJLZKpO2y1WcmqfOu4o/Zd7KJPjVBbeabpmY
X-Google-Smtp-Source: AGHT+IFJlbAmTUHyMZPyp0uxyaBN5bKFFMlEsD8pvP89Kez4hnrjtLgIpLQMGASW/1AJqfbpoEBzJzNmRO1vToTUEwM=
X-Received: by 2002:a05:6602:29c5:b0:7dd:c59c:83a5 with SMTP id
 ca18e2360f4ac-7eaf6d2e5f4mr47171039f.9.1717031626540; Wed, 29 May 2024
 18:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com> <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 29 May 2024 18:13:33 -0700
X-Gmail-Original-Message-ID: <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
Message-ID: <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > I am spinning a new version for this series to address two issues
> > found in this series:
> >
> > 1) Oppo discovered a bug in the following line:
> > +               ci =3D si->cluster_info + tmp;
> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
> > That is a serious bug but trivial to fix.
> >
> > 2) order 0 allocation currently blindly scans swap_map disregarding
> > the cluster->order.
>
> IIUC, now, we only scan swap_map[] only if
> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_clusters[orde=
r]).
> That is, if you doesn't run low swap free space, you will not do that.

You can still swap space in order 0 clusters while order 4 runs out of
free_cluster
or nonfull_clusters[order]. For Android that is a common case.

>
> > Given enough order 0 swap allocations(close to the
> > swap file size) the order 0 allocation head will eventually sweep
> > across the whole swapfile and destroy other cluster order allocations.
> >
> > The short term fix is just skipping clusters that are already assigned
> > to higher orders.
>
> Better to do any further optimization on top of the simpler one.  Need
> to evaluate whether it's necessary to add more complexity.

I agree this needs more careful planning and discussion. In Android's
use case, the swapfile is always almost full. It will run into this
situation after long enough swap time.
Once the order 0 swap entry starts to pollute the higher order
cluster, there is no going back(until the whole cluster is 100% free).

> > In the long term, I want to unify the non-SSD to use clusters for
> > locking and allocations as well, just try to follow the last
> > allocation (less seeking) as much as possible.
>
> I have thought about that too.  Personally, I think that it's good to
> remove swap_map[] scanning.  The implementation can be simplified too.

Agree. I look at the commit that introduces the SSD cluster. The
commit message indicates a lot of CPU time spent in swap_map scanning,
especially when the swapfile is almost full. The main motivation to
introduce the cluster in HDD is to simplify and unify the code.

> I don't know whether do we need to consider the performance of HDD swap
> now.

I am not sure about that either. We can make the best effort to reduce the =
seek.

Chris

> --
> Best Regards,
> Huang, Ying
>
> > On Fri, May 24, 2024 at 10:17=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> >>
> >> This is the short term solutiolns "swap cluster order" listed
> >> in my "Swap Abstraction" discussion slice 8 in the recent
> >> LSF/MM conference.
> >>
> >> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> >> orders" is introduced, it only allocates the mTHP swap entries
> >> from new empty cluster list. That works well for PMD size THP,
> >> but it has a serius fragmentation issue reported by Barry.
> >>
> >> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp=
+Ah+NSgNQ@mail.gmail.com/
> >>
> >> The mTHP allocation failure rate raises to almost 100% after a few
> >> hours in Barry's test run.
> >>
> >> The reason is that all the empty cluster has been exhausted while
> >> there are planty of free swap entries to in the cluster that is
> >> not 100% free.
> >>
> >> Address this by remember the swap allocation order in the cluster.
> >> Keep track of the per order non full cluster list for later allocation=
.
> >>
> >> This greatly improve the sucess rate of the mTHP swap allocation.
> >> While I am still waiting for Barry's test result. I paste Kairui's tes=
t
> >> result here:
> >>
> >> I'm able to reproduce such an issue with a simple script (enabling all=
 order of mthp):
> >>
> >> modprobe brd rd_nr=3D1 rd_size=3D$(( 10 * 1024 * 1024))
> >> swapoff -a
> >> mkswap /dev/ram0
> >> swapon /dev/ram0
> >>
> >> rmdir /sys/fs/cgroup/benchmark
> >> mkdir -p /sys/fs/cgroup/benchmark
> >> cd /sys/fs/cgroup/benchmark
> >> echo 8G > memory.max
> >> echo $$ > cgroup.procs
> >>
> >> memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 32 -B=
 binary &
> >>
> >> /usr/local/bin/memtier_benchmark -S /tmp/memcached.socket \
> >>         -P memcache_binary -n allkeys --key-minimum=3D1 \
> >>         --key-maximum=3D18000000 --key-pattern=3DP:P -c 1 -t 32 \
> >>         --ratio 1:0 --pipeline 8 -d 1024
> >>
> >> Before:
> >> Totals      48805.63         0.00         0.00         5.26045        =
 1.19100        38.91100        59.64700     51063.98
> >> After:
> >> Totals      71098.84         0.00         0.00         3.60585        =
 0.71100        26.36700        39.16700     74388.74
> >>
> >> And the fallback ratio dropped by a lot:
> >> Before:
> >> hugepages-32kB/stats/anon_swpout_fallback:15997
> >> hugepages-32kB/stats/anon_swpout:18712
> >> hugepages-512kB/stats/anon_swpout_fallback:192
> >> hugepages-512kB/stats/anon_swpout:0
> >> hugepages-2048kB/stats/anon_swpout_fallback:2
> >> hugepages-2048kB/stats/anon_swpout:0
> >> hugepages-1024kB/stats/anon_swpout_fallback:0
> >> hugepages-1024kB/stats/anon_swpout:0
> >> hugepages-64kB/stats/anon_swpout_fallback:18246
> >> hugepages-64kB/stats/anon_swpout:17644
> >> hugepages-16kB/stats/anon_swpout_fallback:13701
> >> hugepages-16kB/stats/anon_swpout:18234
> >> hugepages-256kB/stats/anon_swpout_fallback:8642
> >> hugepages-256kB/stats/anon_swpout:93
> >> hugepages-128kB/stats/anon_swpout_fallback:21497
> >> hugepages-128kB/stats/anon_swpout:7596
> >>
> >> (Still collecting more data, the success swpout was mostly done early,=
 then the fallback began to increase, nearly 100% failure rate)
> >>
> >> After:
> >> hugepages-32kB/stats/swpout:34445
> >> hugepages-32kB/stats/swpout_fallback:0
> >> hugepages-512kB/stats/swpout:1
> >> hugepages-512kB/stats/swpout_fallback:134
> >> hugepages-2048kB/stats/swpout:1
> >> hugepages-2048kB/stats/swpout_fallback:1
> >> hugepages-1024kB/stats/swpout:6
> >> hugepages-1024kB/stats/swpout_fallback:0
> >> hugepages-64kB/stats/swpout:35495
> >> hugepages-64kB/stats/swpout_fallback:0
> >> hugepages-16kB/stats/swpout:32441
> >> hugepages-16kB/stats/swpout_fallback:0
> >> hugepages-256kB/stats/swpout:2223
> >> hugepages-256kB/stats/swpout_fallback:6278
> >> hugepages-128kB/stats/swpout:29136
> >> hugepages-128kB/stats/swpout_fallback:52
> >>
> >> Reported-by: Barry Song <21cnbao@gmail.com>
> >> Tested-by: Kairui Song <kasong@tencent.com>
> >> Signed-off-by: Chris Li <chrisl@kernel.org>
> >> ---
> >> Chris Li (2):
> >>       mm: swap: swap cluster switch to double link list
> >>       mm: swap: mTHP allocate swap entries from nonfull list
> >>
> >>  include/linux/swap.h |  18 ++--
> >>  mm/swapfile.c        | 252 +++++++++++++++++-------------------------=
---------
> >>  2 files changed, 93 insertions(+), 177 deletions(-)
> >> ---
> >> base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
> >> change-id: 20240523-swap-allocator-1534c480ece4
> >>
> >> Best regards,
> >> --
> >> Chris Li <chrisl@kernel.org>
> >>
>


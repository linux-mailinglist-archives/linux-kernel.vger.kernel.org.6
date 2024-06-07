Return-Path: <linux-kernel+bounces-206610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F20900C08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A4B22F88
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B713F440;
	Fri,  7 Jun 2024 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8VJrH9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22361FF6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786119; cv=none; b=sogXktZac/MbQQiDnABLr6+0+pK8VIsO0tWlZIdssIvUMvp7XulSNdy7y3L2kEy5c/2b9C3jtN0McN08BEqgxRYfXUIQnIcEcjV9vW0sKKLGK5QnLv2UmzVi/j2JGYLERuf+fkfSkKZS97r/kVWAe4OtZpVL3Kb79cNHKpbnQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786119; c=relaxed/simple;
	bh=6HjJD5Rfq1iZGExUbZIjDq3pW6coSBgd6qbR3D0SB9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGUFOaOo0r7W7qBMjyQJOvZwq+Yohfbj1uCbqtxWJEibYpkOU/6kLJY3DyafPQSbjhcVPYpAh02m69Yrl2Q9Qn4Rr3QjLzZZLW68b3Ao9nPBnhaVHv4kgHTeXhX7+7H9WKrbH/cpo+q29H5P4LVcswe9QQ3aJfcn4P/w/KejQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8VJrH9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480BFC32786
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717786119;
	bh=6HjJD5Rfq1iZGExUbZIjDq3pW6coSBgd6qbR3D0SB9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g8VJrH9XAilIFtygwg0/l11LeAt9g97Q0R733xO1qJjdCYOgZiymXsfBl7MYrtctv
	 QLoBG4d//8mIpO1NyHbLwWeapw0NUb1mYMN+GhUYmvnS3huFcJ7WGLwFm/DCCFLXHv
	 1irUgQYlM79yWlNTVT98hdLlPpaTqgTwDGOkBs4I1pHasCZ6buc3g9oxfHYDUDVFnU
	 tGN5NzYQ0/QKWBwjI3KO0ZTc6Lur6bXrBn4nhMOKI5Foo4yemeQHFhFuKRkouf9j+d
	 ikq/GY2OwOHzn6AAQ5rFgo3mB/Mi0PCuBiEcMN36wlpux2Dfbrc/SSDjLbaW3U7etu
	 EA4UFaGUCxocw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b90so28916241fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:48:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMBxcxMwnt6NenamcTSVEMm7HdD2ANN1chXb9X/9iVlX4Yxi+JfDpy8gSy5c2kgv7Gz932NaHiumD6FmQ29AnJwjjg7Xm8FGT0sP7v
X-Gm-Message-State: AOJu0YxCpD1gknkcrrFXM8uZBH2XEDKURkn07omf1tunTuzg+8m++SbA
	+gvqh8Y34mr144XeZvox/Gwcq7SlnuZ6ryjkQPCp1uyplmKiHAVhRVsrIzfSii3WjMXy0WGiZmC
	NTWMrxm5qc4vAdj+oYFd9gvCSvA==
X-Google-Smtp-Source: AGHT+IFuD7yf3GOn3Evtk26a81S7Sxc1Jdov6cTCU48u0NRhdgA7f/DSjrkJM9u73de6sHPluMzw4ZEdcpnElQv3Fi0=
X-Received: by 2002:a2e:8049:0:b0:2de:74b1:6007 with SMTP id
 38308e7fff4ca-2eadce727c9mr24332951fa.36.1717786117911; Fri, 07 Jun 2024
 11:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org> <968fec1a-9a54-4b2d-a54c-653d84393c82@arm.com>
In-Reply-To: <968fec1a-9a54-4b2d-a54c-653d84393c82@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 7 Jun 2024 11:48:26 -0700
X-Gmail-Original-Message-ID: <CANeU7QnVzqGKXp9pKDLWiuhqTvBxXupgFCRXejYhshAjw6uDyQ@mail.gmail.com>
Message-ID: <CANeU7QnVzqGKXp9pKDLWiuhqTvBxXupgFCRXejYhshAjw6uDyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 2:43=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> Sorry I'm late to the discussion - I've been out for the last 3.5 weeks a=
nd just
> getting through my mail now...

No problem at all, please take it easy.

>
>
> On 24/05/2024 18:17, Chris Li wrote:
> > This is the short term solutiolns "swap cluster order" listed
> > in my "Swap Abstraction" discussion slice 8 in the recent
> > LSF/MM conference.
>
> I've read the article on lwn and look forward to watching the video once
> available. The longer term plans look interesting.
>
> >
> > When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> > orders" is introduced, it only allocates the mTHP swap entries
> > from new empty cluster list. That works well for PMD size THP,
> > but it has a serius fragmentation issue reported by Barry.
>
> Yes, that was a deliberate initial approach to be conservative, just like=
 the
> original PMD-size THP support. I'm glad to see work to improve the situat=
ion!
>
> >
> > https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+=
Ah+NSgNQ@mail.gmail.com/
> >
> > The mTHP allocation failure rate raises to almost 100% after a few
> > hours in Barry's test run.
> >
> > The reason is that all the empty cluster has been exhausted while
> > there are planty of free swap entries to in the cluster that is
> > not 100% free.
> >
> > Address this by remember the swap allocation order in the cluster.
> > Keep track of the per order non full cluster list for later allocation.
>
> I don't immediately see how this helps because memory is swapped back in
> per-page (currently), so just because a given cluster was initially fille=
d with

That is not the case for Barry's setup, he has some other patch series
to swap in mTHP as a whole. Especially in for the mTHP store in the
zsmalloc as bigger than 4K pages.
https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.com/

> entries of a given order, doesn't mean that those entries are freed in at=
omic
> units; only specific pages could have been swapped back in, meaning the h=
oles
> are not of the required order. Additionally, scanning could lead to order=
-0
> pages being populated in random places.

Yes, that is a problem we need to address. The proposed short term
solution is to have an isolation scheme preventing the high order swap
entry mix with the lower order one inside one cluster. That is easy to
do and has some test results confirming the reservation/isolation
effect.

>
> My naive assumption was that the obvious way to solve this problem in the=
 short
> term would be to extend the scanning logic to be able to scan for an arbi=
trary
> order. That way you could find an allocation of the required order in any=
 of the
> clusters, even a cluster that was not originally allocated for the requir=
ed order.
>
> I guess I should read your patches to understand exactly what you are doi=
ng
> rather than making assumptions...

Scanning is not enough. We need to have some way to prevent the
fragmentation from happening.
Once the fragmentation has happened, it can't be easily reversed.
Scanning does not help the fragmentation aspect.

Chris

>
> Thanks,
> Ryan
>
> >
> > This greatly improve the sucess rate of the mTHP swap allocation.
> > While I am still waiting for Barry's test result. I paste Kairui's test
> > result here:
> >
> > I'm able to reproduce such an issue with a simple script (enabling all =
order of mthp):
> >
> > modprobe brd rd_nr=3D1 rd_size=3D$(( 10 * 1024 * 1024))
> > swapoff -a
> > mkswap /dev/ram0
> > swapon /dev/ram0
> >
> > rmdir /sys/fs/cgroup/benchmark
> > mkdir -p /sys/fs/cgroup/benchmark
> > cd /sys/fs/cgroup/benchmark
> > echo 8G > memory.max
> > echo $$ > cgroup.procs
> >
> > memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 32 -B =
binary &
> >
> > /usr/local/bin/memtier_benchmark -S /tmp/memcached.socket \
> >         -P memcache_binary -n allkeys --key-minimum=3D1 \
> >         --key-maximum=3D18000000 --key-pattern=3DP:P -c 1 -t 32 \
> >         --ratio 1:0 --pipeline 8 -d 1024
> >
> > Before:
> > Totals      48805.63         0.00         0.00         5.26045         =
1.19100        38.91100        59.64700     51063.98
> > After:
> > Totals      71098.84         0.00         0.00         3.60585         =
0.71100        26.36700        39.16700     74388.74
> >
> > And the fallback ratio dropped by a lot:
> > Before:
> > hugepages-32kB/stats/anon_swpout_fallback:15997
> > hugepages-32kB/stats/anon_swpout:18712
> > hugepages-512kB/stats/anon_swpout_fallback:192
> > hugepages-512kB/stats/anon_swpout:0
> > hugepages-2048kB/stats/anon_swpout_fallback:2
> > hugepages-2048kB/stats/anon_swpout:0
> > hugepages-1024kB/stats/anon_swpout_fallback:0
> > hugepages-1024kB/stats/anon_swpout:0
> > hugepages-64kB/stats/anon_swpout_fallback:18246
> > hugepages-64kB/stats/anon_swpout:17644
> > hugepages-16kB/stats/anon_swpout_fallback:13701
> > hugepages-16kB/stats/anon_swpout:18234
> > hugepages-256kB/stats/anon_swpout_fallback:8642
> > hugepages-256kB/stats/anon_swpout:93
> > hugepages-128kB/stats/anon_swpout_fallback:21497
> > hugepages-128kB/stats/anon_swpout:7596
> >
> > (Still collecting more data, the success swpout was mostly done early, =
then the fallback began to increase, nearly 100% failure rate)
> >
> > After:
> > hugepages-32kB/stats/swpout:34445
> > hugepages-32kB/stats/swpout_fallback:0
> > hugepages-512kB/stats/swpout:1
> > hugepages-512kB/stats/swpout_fallback:134
> > hugepages-2048kB/stats/swpout:1
> > hugepages-2048kB/stats/swpout_fallback:1
> > hugepages-1024kB/stats/swpout:6
> > hugepages-1024kB/stats/swpout_fallback:0
> > hugepages-64kB/stats/swpout:35495
> > hugepages-64kB/stats/swpout_fallback:0
> > hugepages-16kB/stats/swpout:32441
> > hugepages-16kB/stats/swpout_fallback:0
> > hugepages-256kB/stats/swpout:2223
> > hugepages-256kB/stats/swpout_fallback:6278
> > hugepages-128kB/stats/swpout:29136
> > hugepages-128kB/stats/swpout_fallback:52
> >
> > Reported-by: Barry Song <21cnbao@gmail.com>
> > Tested-by: Kairui Song <kasong@tencent.com>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > Chris Li (2):
> >       mm: swap: swap cluster switch to double link list
> >       mm: swap: mTHP allocate swap entries from nonfull list
> >
> >  include/linux/swap.h |  18 ++--
> >  mm/swapfile.c        | 252 +++++++++++++++++--------------------------=
--------
> >  2 files changed, 93 insertions(+), 177 deletions(-)
> > ---
> > base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
> > change-id: 20240523-swap-allocator-1534c480ece4
> >
> > Best regards,
>


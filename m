Return-Path: <linux-kernel+bounces-563160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C3A637A5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677D37A630F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85701DDA15;
	Sun, 16 Mar 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2EiO66l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02605E55B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742162437; cv=none; b=fTfMc8EB0T4mBAhLk0oncJ/4DOQs8XhEiyhmh8Q8io5u9sQAe1mG+tGQueuTatEJIgoZryGsvHMXw67M3Gdw2a4Dz2AwpvGTK0EegkAkNJM/PADuNjvP8adJV7DRAdeFev+OiOhaUTWSrmA1/+2s2HQIZ5Rh4gnmbjfgkdNHmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742162437; c=relaxed/simple;
	bh=K+EJYSih8x64YhI8l+emXtzt668arKXEfcATb93lxzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leshQjodCdiuDMm4VCcE/c559GFz8hsEP8kbggGDqT889isQAKIqdv+TYNj75dP/3urDAzLOXj4J+yXVlwcDUAtxHK5ErrOFLFxtvq122A+BVoN9GpXe3SZo8zgdTPa4CNNTeqADb79tYw/PCf55SQ9y3fv1QIZDHDA7+ODmJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2EiO66l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C290C4CEDD;
	Sun, 16 Mar 2025 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742162436;
	bh=K+EJYSih8x64YhI8l+emXtzt668arKXEfcATb93lxzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2EiO66lW7Q3Hjwhxwp+VODsqXp/rP70z6CezgGFcmtzVDoOWASpPC5yjtpiuimcI
	 nU6aYATmJJciNRC8ZIMuollCkGi3semkAzRUxSYSFGlSXylLx5FP2R+ozVV/OiRKj/
	 dIoWYody6FMh1pXEPB6wWENSv0tGCEPfZLtz6YN24Zq1AQZV6TwPyeUpMWIuhY/UI6
	 72vARCj0cMJX2lxKUfGGN1rxJQr8rrpSQyaSlRlEeMUVCL8hjh2GP0OG1v4Q763O8J
	 HkAbt20VgR9dZz+ct0QCPNQKVNhyD3A71rO5j9Pbs4Aec3meLCE8yHPzdiYllKeumt
	 9tgOq2ruaLHtA==
From: SeongJae Park <sj@kernel.org>
To: Bharata B Rao <bharata@amd.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	AneeshKumar.KizhakeVeetil@arm.com,
	Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com,
	Michael.Day@amd.com,
	akpm@linux-foundation.org,
	dave.hansen@intel.com,
	david@redhat.com,
	feng.tang@intel.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	honggyu.kim@sk.com,
	hughd@google.com,
	jhubbard@nvidia.com,
	k.shutemov@gmail.com,
	kbusch@meta.com,
	kmanaouil.dev@gmail.com,
	leesuyeon0506@gmail.com,
	leillc@google.com,
	liam.howlett@oracle.com,
	mgorman@techsingularity.net,
	mingo@redhat.com,
	nadav.amit@gmail.com,
	nphamcs@gmail.com,
	peterz@infradead.org,
	raghavendra.kt@amd.com,
	riel@surriel.com,
	rientjes@google.com,
	rppt@kernel.org,
	shivankg@amd.com,
	shy828301@gmail.com,
	vbabka@suse.cz,
	weixugc@google.com,
	willy@infradead.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	dave@stgolabs.net,
	yuanchu@google.com,
	hyeonggon.yoo@sk.com,
	Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot pages
Date: Sun, 16 Mar 2025 15:00:34 -0700
Message-Id: <20250316220034.38121-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306054532.221138-1-bharata@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Harry, who was called Hyeonggon before.

Hello,


Thank you very much for sharing this great patchset.

On Thu, 6 Mar 2025 11:15:28 +0530 Bharata B Rao <bharata@amd.com> wrote:

> Hi,
> 
> This is an attempt towards having a single subsystem that accumulates
> hot page information from lower memory tiers and does hot page
> promotion.

That is one of DAMON's goal, too.  DAMON aims to be a kernel subsystem that can
provide access information that accumulated from multiple sources and can be
useful for multiple use cases including profiling and access aware system
operations.

Hot pages information and promotioning those are one of such information and
operations.  SK hynix developed their CXL memory tiering solution[1] using
DAMON.  I also shared auto-tuning based memory tiering solution idea[2] before.
On LSFMMBPF 2025, I may share its prototype implementation and evaluation
results on CXL memory devices that I recentily gained access.

Of course, DAMON is still in the middle of its journey towards the northern
star.  I'm looking for what are really required to DAMON for the goal, what are
[not] available with today's DAMON, and what should be the good future plans.
My LSFMMBPF 2025 topic proposals are for those.

Hence, this patchset is very helpful to me at showing what can be added and
improved on DAMON.  I specifically understand support of access information
sources other than Page tables' accessed bits such as AMD IBS as the main
thing.  I admit the fact that DAMON of today is supporting only page tables'
accessed bit as the primary source of the information.  But DAMON of future
would be different.  Let me share more thoughts below.

> 
> At the heart of this subsystem is a kernel daemon named kpromoted that
> does the following:
> 
> 1. Exposes an API that other subsystems which detect/generate memory
>    access information can use to inform the daemon about memory
>    accesses from lower memory tiers.

DAMON also provides such API, namely, its monitoring operations set layer
interface[3].  Nevertheless, only page tables accessed bit use cases exist
today.  Hence the interface may have have hidden problems at extending for
other sources.

> 2. Maintains the list of hot pages and attempts to promote them to
>    toptiers.

DAMON provides its another half, DAMOS[4], for this kind of usages.

> 
> Currently I have added AMD IBS driver as one source that provides
> page access information as an example. This driver feeds info to
> kpromoted in this RFC patchset. More sources were discussed in a
> similar context here at [1].

I was imagining how I would be able to do this with DAMON via operations set
layer interface.  And I find thee current interface is not very optimized for
AMD IBS like sources that catches the access on the line.  That is, in a way,
we could say AMD IBS like primitives as push-oriented, while page tables'
accessed bits information are pull-oriented.  DAMON operations set layer
interface is easier to be used in pull-oriented case.  I don't think it cannot
be used for push-oriented case, but definitely the interface would better to be
more optimized for the use case.

I'm curious if you also tried doing this by extending DAMON, and if some hidden
problems you found.

> 
> This is just an early attempt to check what it takes to maintain
> a single source of page hotness info and also separate hot page
> detection mechanisms from the promotion mechanism. There are too
> many open ends right now and I have listed a few of them below.
> 
> - The API that is provided to register memory access expects
>   the PFN, NID and time of access at the minimum. This is
>   described more in patch 2/4. This API currently can be called
>   only from contexts that allow sleeping and hence this rules
>   out using it from PTE scanning paths. The API needs to be
>   more flexible with respect to this.
> - Some sources like PTE A bit scanning can't provide the precise
>   time of access or the NID that is accessing the page. The latter
>   has been an open problem to which I haven't come across a good
>   and acceptable solution.

Agree.  PTE A bit scanning could be useful in many cases, but not every case.
There was an RFC patchset[7] that extends DAMON for NID.  I'm planning to do
that again using DAMON operations layer interface.  My current plan is to
implement the prototype using prot_none page faults, and later extend for AMD
IBS like h/w features.  Hopefully I will share a prototype or at least more
detailed idea on LSFMMBPF 2025.

> - The way the hot page information is maintained is pretty
>   primitive right now. Ideally we would like to store hotness info
>   in such a way that it should be easily possible to lookup say N
>   most hot pages.

DAMON provides a feature for lookup of N most hotpages, namely DAMOS quotas'
access pattern based regions prioritization[5].

> - If PTE A bit scanners are considered as hotness sources, we will
>   be bombarded with accesses. Do we want to accomodate all those
>   accesses or just go with hotness info for fixed number of pages
>   (possibly as a ratio of lower tier memory capacity)?

I understand you're saying about memory space overhead.  Correct me if I'm
wrong, please.

Isn't same issue exists for current implementation of the sampling frequency is
high, and/or aggregation window is long?

To me, hence, this looks like not a problem of the information source, but how
to maintain the information.  Current implementation maintains it per page, so
I think the problem is inherent.

DAMON maintains the information in region abstraction that can save multiple
pages with one data structure.  The maximum number of regions can be set by
users, so the space overhead can be controlled.

> - Undoubtedly the mechanism to classify a page as hot and subsequent
>   promotion needs to be more sophisticated than what I have right now.

DAMON provides aim-based DAMOS aggressiveness auto-tuning[6] and monitoring
intervals auto-tuning[8] for this purpose.

> 
> This is just an early RFC posted now to ignite some discussion
> in the context of LSFMM [2].

This is really helpful.  Appreciate, and looking forward to more discussions on
LSFMM and mailing lists.

> 
> I am also working with Raghu to integrate his kmmdscan [3] as the
> hotness source and use kpromoted for migration.

Raghu also mentioned he would try to take a time to look into DAMON if there is
anything that he could reuse for the purpose.  I'm curious if he was able to
find something there.

> 
> Also, I had posted the IBS driver ealier as an alternative to
> hint faults based NUMA Balancing [4]. However here I am using
> it as generic page hotness source.

This will also be very helpful for understanding how IBS can be used.
Appreciate!

> 
> [1] https://lore.kernel.org/linux-mm/de31971e-98fc-4baf-8f4f-09d153902e2e@amd.com/
> [2] https://lore.kernel.org/linux-mm/20250123105721.424117-1-raghavendra.kt@amd.com/
> [3] https://lore.kernel.org/all/20241201153818.2633616-1-raghavendra.kt@amd.com/
> [3] https://lore.kernel.org/lkml/20230208073533.715-2-bharata@amd.com/


[1] https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion
[2] https://lore.kernel.org/all/20231112195602.61525-1-sj@kernel.org/
[3] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#operations-set-layer
[4] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#operation-schemes
[5] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#prioritization
[6] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#aim-oriented-feedback-driven-auto-tuning
[7] https://lore.kernel.org/linux-mm/cover.1645024354.git.xhao@linux.alibaba.com/
[8] https://origin.kernel.org/doc/html/next/mm/damon/design.html#monitoring-intervals-auto-tuning


Thank,
SJ

> 
> Regards,
> Bharata.
> 
> Bharata B Rao (4):
>   mm: migrate: Allow misplaced migration without VMA too
>   mm: kpromoted: Hot page info collection and promotion daemon
>   x86: ibs: In-kernel IBS driver for memory access profiling
>   x86: ibs: Enable IBS profiling for memory accesses
> 
>  arch/x86/events/amd/ibs.c           |  11 +
>  arch/x86/include/asm/entry-common.h |   3 +
>  arch/x86/include/asm/hardirq.h      |   2 +
>  arch/x86/include/asm/ibs.h          |   9 +
>  arch/x86/include/asm/msr-index.h    |  16 ++
>  arch/x86/mm/Makefile                |   3 +-
>  arch/x86/mm/ibs.c                   | 344 ++++++++++++++++++++++++++++
>  include/linux/kpromoted.h           |  54 +++++
>  include/linux/mmzone.h              |   4 +
>  include/linux/vm_event_item.h       |  30 +++
>  mm/Kconfig                          |   7 +
>  mm/Makefile                         |   1 +
>  mm/kpromoted.c                      | 305 ++++++++++++++++++++++++
>  mm/migrate.c                        |   5 +-
>  mm/mm_init.c                        |  10 +
>  mm/vmstat.c                         |  30 +++
>  16 files changed, 831 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/include/asm/ibs.h
>  create mode 100644 arch/x86/mm/ibs.c
>  create mode 100644 include/linux/kpromoted.h
>  create mode 100644 mm/kpromoted.c
> 
> -- 
> 2.34.1


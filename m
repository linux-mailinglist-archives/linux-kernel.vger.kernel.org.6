Return-Path: <linux-kernel+bounces-440173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404919EB9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343EA165B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424BE21420B;
	Tue, 10 Dec 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Rxzeue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F22046BB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856840; cv=none; b=f1My0RgCH3xDZxWUrTMPg0s3FFpx0xTLoYyeOxsYHE0tS0PtF8+0e0aaWp4Iae0vuzDKI/T6tFgDld+bNT3iScvrZgPeVys6QCB8HWSEovnYDkPZvU0i1hZ/EXbxiNAfwRlhDN9COAHnnmsbGpfITWemEQeVQPhVcUBFS4RB/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856840; c=relaxed/simple;
	bh=Z/5SHQmsNqHlJAYNjAylaK9pqmWXlMUYJvhbFpO0HXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FK4bcWekEa3mRK99XAsy1bDw5n5+Nu0B90dr22jIzLitsQ7QW2B079ktvg9iJBGfgQWISV1aNcxgq8JR98VttWtwPDybKtrBFXBJ5x7uAm5rxu2FxvxSxERdx6YlT+7+PHfUNmasBgreB3R+DNjj66i+R001/0VT8ED4287hXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Rxzeue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E62C4CED6;
	Tue, 10 Dec 2024 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856840;
	bh=Z/5SHQmsNqHlJAYNjAylaK9pqmWXlMUYJvhbFpO0HXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1Rxzeueb/f6Nvc9aMBU3yWGwd/enV6/2wNSpnKR1Cd3OYzVJEL70SFmof/1PbCiJ
	 xX6sRrwb7fvgt7N2bIlnOy4Wd+w+c/IGcVSh5lZOGASO1QJdYiVV9qsWCUwqXjK3w2
	 nFATD5whxjizhlyQCwBny3xavtS63lXLo86FOD+spwDTvljduhcXUTh2z7R58+7p45
	 fJvlUaOeAVlAgYI0kVIGtykSkLoPa3aZD+t/G0Xnodwcs4xPCSJcUiqKyiuaz1OixB
	 jZeN3WEb29SHz1xLOCD+np5xVvHDNxsqVv42j7Kye/3JKnswC3B90+J4hwX1YbgQVQ
	 Gr9ErNjdJUhKQ==
From: SeongJae Park <sj@kernel.org>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gourry@gourry.net,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	feng.tang@intel.com,
	kbusch@meta.com,
	bharata@amd.com,
	Hasan.Maruf@amd.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com,
	mgorman@techsingularity.net,
	vbabka@suse.cz,
	hughd@google.com,
	rientjes@google.com,
	shy828301@gmail.com,
	Liam.Howlett@Oracle.com,
	peterz@infradead.org,
	mingo@redhat.com
Subject: Re: [RFC PATCH V0 0/10] mm: slowtier page promotion based on PTE A bit
Date: Tue, 10 Dec 2024 10:53:57 -0800
Message-Id: <20241210185357.81214-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241201153818.2633616-1-raghavendra.kt@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Raghavendra,


Thank you for posting this nice patch series.  I gave you some feedback
offline.  Adding those here again for transparency on this grateful public
discussion.

On Sun, 1 Dec 2024 15:38:08 +0000 Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Introduction:
> =============
> This patchset is an outcome of an ongoing collaboration between AMD and Meta.
> Meta wanted to explore an alternative page promotion technique as they
> observe high latency spikes in their workloads that access CXL memory.
> 
> In the current hot page promotion, all the activities including the
> process address space scanning, NUMA hint fault handling and page
> migration is performed in the process context. i.e., scanning overhead is
> borne by applications.

Yet another approach is using DAMON.  DAMON does access monitoring, and further
allows users to request access pattern-driven system operations in name of
DAMOS (Data Access Monitoring-based Operation Schemes).  Using it, users can
request DAMON to find hot pages and promote, while finding cold pages and
demote.  SK hynix has made their CXL-based memory capacity expansion solution
in the way (https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion).  We
collaboratively developed new DAMON features for that, and those are all
in the mainline since Linux v6.11.

I also proposed an idea for advancing it using DAMOS auto-tuning on more
general (>2 tiers) setup
(https:lore.kernel.org/20231112195602.61525-1-sj@kernel.org).  I haven't had a
time to further implement and test the idea so far, though.

> 
> This is an early RFC patch series to do (slow tier) CXL page promotion.
> The approach in this patchset assists/addresses the issue by adding PTE
> Accessed bit scanning.
> 
> Scanning is done by a global kernel thread which routinely scans all
> the processes' address spaces and checks for accesses by reading the
> PTE A bit. It then migrates/promotes the pages to the toptier node
> (node 0 in the current approach).
> 
> Thus, the approach pushes overhead of scanning, NUMA hint faults and
> migrations off from process context.

DAMON also uses PTE A bit as major source of the access information.  And DAMON
does both access monitoring and promotion/demotion in a global kernel thread,
namely kdamond.  Hence the DAMON-based approach would also offload the
overheads from process context.  So I feel your approach has a sort of
similarity with DAMON-based one in a way, and we might have a chance to avoid
unnecessary duplicates.

[...]
> 
> Limitations:
> ===========
> PTE A bit scanning approach lacks information about exact destination
> node to migrate to.

This is same for DAMON-based approach, since DAMON also uses PTE A bit as the
major source of the information.  We aim to extend DAMON to aware of the access
source CPU, and use it for solving this problem, though.  Utilizing page faults
or AMD IBS-like h/w features are on the table of the ideas.

> 
> Notes/Observations on design/Implementations/Alternatives/TODOs...
> ================================
> 1. Fine-tuning scan throttling

DAMON allows users set the upper-limit of monitoring overhead, using
max_nr_regions parameter.  Then it provides its best-effort accuracy.  We also
have ongoing projects for making it more accurate and easier to tune.

> 
> 2. Use migrate_balanced_pgdat() to balance toptier node before migration
>  OR Use migrate_misplaced_folio_prepare() directly.
>  But it may need some optimizations (for e.g., invoke occasionaly so
> that overhead is not there for every migration).
> 
> 3. Explore if a separate PAGE_EXT flag is needed instead of reusing
> PAGE_IDLE flag (cons: complicates PTE A bit handling in the system),
> But practically does not look good idea.
> 
> 4. Use timestamp information-based migration (Similar to numab mode=2).
> instead of migrating immediately when PTE A bit set.
> (cons:
>  - It will not be accurate since it is done outside of process
> context.
>  - Performance benefit may be lost.)

DAMON provides a sort of time-based aggregated monitoring results.  And DAMOS
provides prioritization of pages based on the access temperature.  Hence,
DAMON-based apparoach can also be used for a similar purpose (promoting not
every accessed pages but pages that more frequently used for longer time).

> 
> 5. Explore if we need to use PFN information + hash list instead of
> simple migration list. Here scanning is directly done with PFN belonging
> to CXL node.

DAMON supports physical address space monitoring, and maintains the access
monitoring results in its own data structure called damon_region.  So I think
similar benefit can be achieved using DAMON?

[...]
> 8. Using DAMON APIs OR Reusing part of DAMON which already tracks range of
> physical addresses accessed.

My biased humble opinion is that it would be very nice to explore this
opportunity, since I show some similarities and opportunities to solve some of
challenges on your approach in an easier way.  Even if it turns out that DAMON
cannot be used for your use case, failing earlier is a good thing, I'd say :)

> 
> 9. Gregory has nicely mentioned some details/ideas on different approaches in
> [1] : development notes, in the context of promoting unmapped page cache folios.

DAMON supports monitoring accesses to unmapped page cache folios, so hopefully
DAMON-based approaches can also solve this issue.

> 
> 10. SJ had pointed about concerns about kernel-thread based approaches as in
> kstaled [2]. So current patchset has tried to address the issue with simple
> algorithms to reduce CPU overhead. Migration throttling, Running the daemon
> in NICE priority, Parallelizing migration with scanning could help further.
> 
> 11. Toptier pages scanned can be used to assist current NUMAB by providing information
> on hot VMAs.
> 
> Credits
> =======
> Thanks to Bharata, Joannes, Gregory, SJ, Chris for their valuable comments and
> support.

I also learned many things from the great discussions, thank you :)

[...]
> 
> Links:
> [1] https://lore.kernel.org/lkml/20241127082201.1276-1-gourry@gourry.net/
> [2] kstaled: https://lore.kernel.org/lkml/1317170947-17074-3-git-send-email-walken@google.com/#r
> [3] https://lore.kernel.org/lkml/Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net/
> 
> I might have CCed more people or less people than needed
> unintentionally.


Thanks,
SJ

[...]


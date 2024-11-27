Return-Path: <linux-kernel+bounces-423711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B79DABC7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173E6B23336
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B9200B9C;
	Wed, 27 Nov 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UvNv9RQA"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143420012C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724925; cv=none; b=nsh88SAl+3KULtLp+ZcXEe/QAC42xW6pPmtffCyoN21yO4Snhlyin97QkxjFHntGy3gSB53GAZYivmn3IOtAO6FgnUHqN1aK3kdoddChlK5Nw0KbzT6sxP1XjLUSkfNk2UXCWLkT4xJNajhVgXB9Z2A/nL9ZfAteIQa8HWoVfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724925; c=relaxed/simple;
	bh=WUWF4Vjq402ZyBsS+7pXmO6pg9cyqBYRJGSPweCpn+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0WP+DiT6dBt58tv00XderT5yCLe3Ig9FfDe+kR4xQmQFqW4StIkxyt/CeogpXnJWgxlSylJfO8ag6e/46atWQvrZbF4DO4Xr0Gv5LEP1AZZTg+SsRVyX/HwudPe/MzrsqZKB0x8rS1j0cbbtWgUIJBatPTTZEYj6/SKAa05ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UvNv9RQA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-466a0ac9211so19253961cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732724921; x=1733329721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PidIsjj04A/ARWCx+XzUxVHyBAs8knKmMO+m1Fk3cqA=;
        b=UvNv9RQAKvZb6uryKP9pTaB3k5g18RUGiEzOKhSBgbcYqhZ5Woblyb9CqcmCN86ld4
         TJtyLcmEVTk4Jet128kzm/aRX2GT2hqt6Gr2BDt/rf27czf4A9G68j9ovuwigx8cxrec
         XramGhzCHk7H+0Kmh37BQsxCJg0noTdphhJpde3wBN3j6O+AsUgJFQdDGdbA6JZJ3pCW
         J42B6dysxLtPgFpt3dq9EjA1aZ+8YMJG8rilOETyLXqy0yyCGZicDfBak9GQ2cs6ebru
         WOIPQzm+TImKB9/uMffQuLYWPl96nhBxaJdO7MorLKdHa76xblbAoQLqXg9CRDA9iRlE
         h/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724921; x=1733329721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PidIsjj04A/ARWCx+XzUxVHyBAs8knKmMO+m1Fk3cqA=;
        b=HMk0KZJ5ciPKIqiuhEsTdAiavyZV4LVyDDpGNDkEHugFwRxm/HkSmF07x+jnorT11J
         BbhxsaA4kQEF1oE7qdP3UWehh/1Gh9WAzGTAjnXS3aJzpzxYXCMqVaT8bhbAMOAiXLsW
         DRgfay67Uo6heD62luWnMGMpCF+QMT8sRA1TyMKpkIVfbmHJmIx/gdu5P1jEv6vd+X6T
         MZephsgR1YYf1zFKbjZIp6/SQTHsjE+5BC+Ug2OQREh86puOwgPjOSexdmto8iGe3ibv
         2Kev3u5XDH38scZsR+erZY8njC3qgV4V/kY9eqtuejEaE1xyJhTzymyGU9Olh7/VEvFB
         WSqw==
X-Gm-Message-State: AOJu0YwwwyNRMrH0ldcTNGXTtKeH8LMxmwbTGz65AHY30tEBZeJqFdqo
	Z0XhBRcMblHXWItiDNa38Hom1dkOJLU81bah+IQJFDjIZRlm24tGXyfjh2fWjGo=
X-Gm-Gg: ASbGnct4RDZGsqBkktF21IBHpfaQ6iFG2nYxFdvJpnCPjECTsbY/jlKjFfsMzdRPkL+
	ZGc39SL/Z5SMKR78PObTYyHWAciu4GcfTiUT+0WwGCmZMCghU3ZyBovmepYRZCScGWhj7ya8fra
	4+d2+rU0Y/H1BW0Hjq2u6UPiXnL/RIu+uIyjXYZVRkkMlAkkbilyb9IdAs0SW1qE2APUed3MQNI
	rN+0es2k5DxFtD6cgn/il3h7NFG+CgDQ0wLOsrfS/up0XVda85buREFA4afNEm+VaWlka4nYLlp
	alZRck+m2rknpUeVbtK7iXuhTiqZhBkefJM=
X-Google-Smtp-Source: AGHT+IGGApAGUvMNEr0AbpDJx2A33CElkNGtekBcaVAFSVLKR6Fp2ZQohXY235rN2n8AmCeZqHUtbw==
X-Received: by 2002:ac8:5a86:0:b0:466:a060:a484 with SMTP id d75a77b69052e-466b35264a8mr56878511cf.27.1732724921198;
        Wed, 27 Nov 2024 08:28:41 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466871721c2sm45002921cf.17.2024.11.27.08.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:40 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	feng.tang@intel.com,
	kbusch@meta.com
Subject: [RFC PATCH 0/4] Promotion of Unmapped Page Cache Folios.
Date: Wed, 27 Nov 2024 03:21:57 -0500
Message-ID: <20241127082201.1276-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unmapped page cache pages can be demoted to low-tier memory, but
they can presently only be promoted in two conditions:
    1) The page is fully swapped out and re-faulted
    2) The page becomes mapped (and exposed to NUMA hint faults)

This RFC proposes promoting unmapped page cache pages by using
folio_mark_accessed as a hotness hint for unmapped pages.

Patches 1 & 2
	allow NULL as valid input to migration prep interfaces
	for vmf/vma - which is not present in unmapped folios.
Patch 3
	adds NUMA_HINT_PAGE_CACHE to vmstat
Patch 4
	adds the promotion mechanism, along with a sysfs
	extension which defaults the behavior to off.
	/sys/kernel/mm/numa/pagecache_promotion_enabled

Functional test showed that we are able to reclaim some performance
in canned scenarios (a file gets demoted and becomes hot with 
relatively little contention).  See test/overhead section below.

Open Questions:
======
   1) Should we also add a limit to how much can be forced onto
      a single task's promotion list at any one time? This might
      piggy-back on the existing TPP promotion limit (256MB?) and
      would simply add something like task->promo_count.

      Technically we are limited by the batch read-rate before a
      TASK_RESUME occurs.

   2) Should we exempt certain forms of folios, or add additional
      knobs/levers in to deal with things like large folios?

   3) We added NUMA_HINT_PAGE_CACHE to differentiate hint faults
      so we could validate the behavior works as intended. Should
      we just call this a NUMA_HINT_FAULT and not add a new hint?

   4) Benchmark suggestions that can pressure 1TB memory. This is
      not my typical wheelhouse, so if folks know of a useful
      benchmark that can pressure my 1TB (768 DRAM / 256 CXL) setup,
      I'd like to add additional measurements here.

Development Notes
=================

During development, we explored the following proposals:

1) directly promoting within folio_mark_accessed (FMA)
   Originally suggested by Johannes Weiner
   https://lore.kernel.org/all/20240803094715.23900-1-gourry@gourry.net/

   This caused deadlocks due to the fact that the PTL was held
   in a variety of cases - but in particular during task exit.
   It also is incredibly inflexible and causes promotion-on-fault.
   It was discussed that a deferral mechanism was preferred.


2) promoting in filemap.c locations (calls of FMA)
   Originally proposed by Feng Tang and Ying Huang
   https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/patch/?id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329

   First, we saw this as less problematic than directly hooking FMA,
   but we realized this has the potential to miss data in a variety of
   locations: swap.c, memory.c, gup.c, ksm.c, paddr.c - etc.

   Second, we discovered that the lock state of pages is very subtle,
   and that these locations in filemap.c can be called in an atomic
   context.  Prototypes lead to a variety of stalls and lockups.


3) a new LRU - originally proposed by Keith Busch
   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/patch/?id=6616afe9a722f6ebedbb27ade3848cf07b9a3af7

   There are two issues with this approach: PG_promotable and reclaim.

   First - PG_promotable has generally be discouraged.

   Second - Attach this mechanism to an LRU is both backwards and
   counter-intutive.  A promotable list is better served by a MOST
   recently used list, and since LRUs are generally only shrank when
   exposed to pressure it would require implementing a new promotion
   list shrinker that runs separate from the existing reclaim logic.


4) Adding a separate kthread - suggested by many

   This is - to an extent - a more general version of the LRU proposal.
   We still have to track the folios - which likely requires the
   addition of a page flag.  Additionally, this method would actually
   contend pretty heavily with LRU behavior - i.e. we'd want to
   throttle addition to the promotion candidate list in some scenarios.


5) Doing it in task work

   This seemed to be the most realistic after considering the above.

   We observe the following:
    - FMA is an ideal hook for this and isolation is safe here
    - the new promotion_candidate function is an ideal hook for new
      filter logic (throttling, fairness, etc).
    - isolated folios are either promoted or putback on task resume,
      there are no additional concurrency mechanics to worry about
    - The mechanic can be made optional via a sysfs hook to avoid
      overhead in degenerate scenarios (thrashing).

   We also piggy-backed on the numa_hint_fault_latency timestamp to
   further throttle promotions to help avoid promotions on one or
   two time accesses to a particular page.


Test:
======

Environment:
    1.5-3.7GHz CPU, ~4000 BogoMIPS, 
    1TB Machine with 768GB DRAM and 256GB CXL
    A 64GB file being linearly read by 6-7 Python processes

Goal:
   Generate promotions. Demonstrate stability and measure overhead.

System Settings:
   echo 1 > /sys/kernel/mm/numa/demotion_enabled
   echo 1 > /sys/kernel/mm/numa/pagecache_promotion_enabled
   echo 2 > /proc/sys/kernel/numa_balancing
   
Each process took up ~128GB each, with anonymous memory growing and
shrinking as python filled and released buffers with the 64GB data.
This causes DRAM pressure to generate demotions, and file pages to
"become hot" - and therefore be selected for promotion.

First we ran with promotion disabled to show consistent overhead as
a result of forcing a file out to CXL memory. We first ran a single
reader to see uncontended performance, launched many readers to force
demotions, then droppedb back to a single reader to observe.

Single-reader DRAM: ~16.0-16.4s
Single-reader CXL (after demotion):  ~16.8-17s

Next we turned promotion on with only a single reader running.

Before promotions:
    Node 0 MemFree:        636478112 kB
    Node 0 FilePages:      59009156 kB
    Node 1 MemFree:        250336004 kB
    Node 1 FilePages:      14979628 kB

After promotions:
    Node 0 MemFree:        632267268 kB
    Node 0 FilePages:      72204968 kB
    Node 1 MemFree:        262567056 kB
    Node 1 FilePages:       2918768 kB

Single-reader (after_promotion): ~16.5s

Turning the promotion mechanism on when nothing had been demoted
produced no appreciable overhead (memory allocation noise overpowers it)

Read time did not change after turning promotion off after promotion
occurred, which implies that the additional overhead is not coming from
the promotion system itself - but likely other pages still trapped on
the low tier.  Either way, this at least demonstrates the mechanism is
not particularly harmful when there are no pages to promote - and the
mechanism is valuable when a file actually is quite hot.

Notability, it takes some time for the average read loop to come back
down, and there still remains unpromoted file pages trapped in pagecache.
This isn't entirely unexpected, there are many files which may have been
demoted, and they may not be very hot.


Overhead
======
When promotion was tured on we saw a loop-runtime increate temporarily

before: 16.8s
during:
  17.606216192245483
  17.375206470489502
  17.722095489501953
  18.230552434921265
  18.20712447166443
  18.008254528045654
  17.008427381515503
  16.851454257965088
  16.715774059295654
stable: ~16.5s

We measured overhead with a separate patch that simply measured the
rdtsc value before/after calls in promotion_candidate and task work.

e.g.:
+       start = rdtsc();
        list_for_each_entry_safe(folio, tmp, promo_list, lru) {
                list_del_init(&folio->lru);
                migrate_misplaced_folio(folio, NULL, nid);
+               count++;
        }
+       atomic_long_add(rdtsc()-start, &promo_time);
+       atomic_long_add(count, &promo_count);

numa_migrate_prep: 93 - time(3969867917) count(42576860)
migrate_misplaced_folio_prepare: 491 - time(3433174319) count(6985523)
migrate_misplaced_folio: 1635 - time(11426529980) count(6985523)

Thoughts on a good throttling heuristic would be appreciated here.


Suggested-by: Huang Ying <ying.huang@intel.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Keith Busch <kbusch@meta.com>
Suggested-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (4):
  migrate: Allow migrate_misplaced_folio APIs without a VMA
  memory: allow non-fault migration in numa_migrate_check path
  vmstat: add page-cache numa hints
  migrate,sysfs: add pagecache promotion

 .../ABI/testing/sysfs-kernel-mm-numa          | 20 +++++++
 include/linux/memory-tiers.h                  |  2 +
 include/linux/migrate.h                       |  5 ++
 include/linux/sched.h                         |  3 +
 include/linux/sched/numa_balancing.h          |  5 ++
 include/linux/vm_event_item.h                 |  2 +
 init/init_task.c                              |  1 +
 kernel/sched/fair.c                           | 27 ++++++++-
 mm/memory-tiers.c                             | 27 +++++++++
 mm/memory.c                                   | 41 ++++++++-----
 mm/mempolicy.c                                | 25 +++++---
 mm/migrate.c                                  | 59 ++++++++++++++++++-
 mm/swap.c                                     |  3 +
 mm/vmstat.c                                   |  2 +
 14 files changed, 196 insertions(+), 26 deletions(-)

-- 
2.43.0



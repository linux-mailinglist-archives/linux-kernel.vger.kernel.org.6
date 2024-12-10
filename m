Return-Path: <linux-kernel+bounces-440339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7489EBBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7593167977
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCFA238721;
	Tue, 10 Dec 2024 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P0ov8iTE"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A8237A29
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866691; cv=none; b=ckT6Xl73YTVtN5/51qX84DFkGIqdMk0hL94NVE/jZ/sqOdIM8JsVLxDuImN4/gXtjxM+QQ1qmwIatGB8AVU7iCj+i9XPXWWVxGAQlf9VQdAFiiUAssKZyR4h+zmX1+2UejGPd1lYH1ncFLXxVbJJh9hD1ChflYrKnWxtIeUq/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866691; c=relaxed/simple;
	bh=R2MMt3n16I+/LqzKawiSHeP5h56m1Cl7RVFg0XuM+5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohI/n8QKNw9+32iE9p/XVLiJP6px9nLfi7Rcdw74au3I14Q8PowkVp9KBrtQiZ9RrwkGMpKoloVm1NLZUcMcAv84Ka2/on/sUNo6nQvAKuHrlSbKKtNBGnO+MZHCy0MeUtnMfz4fDfLL92Zu2MgVecbEgeKKMtYTN6SdCON3FRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P0ov8iTE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4674c597f2eso20005271cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733866688; x=1734471488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZdq/UsD7TyngKHwHzlXM4cYkZjAFz4x6rdkvANzCaw=;
        b=P0ov8iTEDWn2Vr+NDQ2s+bi2JMyFVRh7Ef70dSFnJ3ELwqIj66QNdZufroICujiOKa
         Ur5hXx+/7LPu8IWmiEDhvnCueK/M2B509EWpUAr5RoLqoKKTZ/zpW1Aqx0bCBuXYTxav
         QiC3TRvTojxIaR8rtRV1rk52Wn/QQ/8MfgTFswQxdapFJcUiM/rnqfJbn33EEyQIp/Gx
         U7h9RygOv98SnDfoyfhDlDw0kWNiXTBQd6eCqHAnW4ZaR1e/Ib2xTsSIFl5jMoaIL891
         KdS3sZJX399GdkpwM233LJvf/8XxrwBoUYLWaxg8CAqs2kQcl6YP0z6ovw///c4ABVCC
         GYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866688; x=1734471488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZdq/UsD7TyngKHwHzlXM4cYkZjAFz4x6rdkvANzCaw=;
        b=hVac2+ehfwSRRn829VoOU3/m/koVrrflJj6Y9sxLJB8oxhViMUlpQx+nRHf+WrSJR4
         Co24ERYvWTL54uxONGDBn/NQH4O7Ab4o4XbURGy2Pq7PpPCU43CoDsxCzKynWkPno9zf
         IKMoJTu/j9RqFIBLMgiwkkr3TH8FgdPSQ+S6GmaKnmjCaZ46e3M3g/9EvhUpkq1e1x/7
         x0/mNHiD7aPZQ9la+uwCVjPfBhx9weIOi9sa6hT6G1noS3HT/wX7NK6HfGHuPxQbOsk6
         gKKixYqRvU/spUyfuJgtH4aBvpdAPEV/o85XX0kCkr8xtLmIF48DF79dPEv7SdlFEiE1
         YgSw==
X-Gm-Message-State: AOJu0YzEIuHjfxWgj8eAmB2ClOx4CJ+nxlZM2T1+5sy2LZ6r1bEx0z2T
	ywu1iii0LBrU1+mnkU8bSWyxorltI7eb/As4Vd6i9fdt9zj8wbyUAkl2wGWdfMo=
X-Gm-Gg: ASbGncu3unQic0NhHe6hCmngQKNvAF0ceHsc3d3GDZjZnvA1Udd/dkBwLAaO3OUSg9q
	YJ1MLzdbmva/Quy6q3zpYL0VKWVqR59tOiiv4/jEsgI4/wxio8cBjKEYHrI69siNoE1BbNlCRSC
	AvOpYyUHAJhulr0ULD9gfkN1d06VDNR7D6CuaHSa5WsOxb84OReHoeJ5VSahlGmkp+dZDEfmptu
	UfWzEZZhRaJcQzktwixlgmKSmI+rKg9rqvdThUm6iLl215z4PAB+qM8QAFlxYvXKqVe3j33R1zI
	NBeUynwTf+nfyTqP3CJnWngkHJWGL30xI22R+AI=
X-Google-Smtp-Source: AGHT+IF3STy4JQEZRAPjNUq338yxYvMyJYYh65oB9kh5zvxnD+SeScIdjQ8RjjK1DIBynL8RO06p5Q==
X-Received: by 2002:ac8:5dc8:0:b0:467:67db:ef7f with SMTP id d75a77b69052e-4678939d708mr11310171cf.39.1733866687948;
        Tue, 10 Dec 2024 13:38:07 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296f61f6sm65978991cf.43.2024.12.10.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:38:07 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	kbusch@meta.com,
	ying.huang@linux.alibaba.com,
	Feng Tang <feng.tang@intel.com>
Subject: [RFC v2 PATCH 0/5] Promotion of Unmapped Page Cache Folios.
Date: Tue, 10 Dec 2024 16:37:39 -0500
Message-ID: <20241210213744.2968-1-gourry@gourry.net>
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

Patches 1-3
	allow NULL as valid input to migration prep interfaces
	for vmf/vma - which is not present in unmapped folios.
Patch 4
	adds NUMA_HINT_PAGE_CACHE to vmstat
Patch 5
	adds the promotion mechanism, along with a sysfs
	extension which defaults the behavior to off.
	/sys/kernel/mm/numa/pagecache_promotion_enabled

Functional test showed that we are able to reclaim some performance
in canned scenarios (a file gets demoted and becomes hot with 
relatively little contention).  See test/overhead section below.

v2
- cleanup first commit to be accurate and take Ying's feedback
- cleanup NUMA_HINT_ define usage
- add NUMA_HINT_ type selection macro to keep code clean
- mild comment updates

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

Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Keith Busch <kbusch@meta.com>
Suggested-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (5):
  migrate: Allow migrate_misplaced_folio_prepare() to accept a NULL VMA.
  memory: move conditionally defined enums use inside ifdef tags
  memory: allow non-fault migration in numa_migrate_check path
  vmstat: add page-cache numa hints
  migrate,sysfs: add pagecache promotion

 .../ABI/testing/sysfs-kernel-mm-numa          | 20 ++++++
 include/linux/memory-tiers.h                  |  2 +
 include/linux/migrate.h                       |  2 +
 include/linux/sched.h                         |  3 +
 include/linux/sched/numa_balancing.h          |  5 ++
 include/linux/vm_event_item.h                 |  8 +++
 init/init_task.c                              |  1 +
 kernel/sched/fair.c                           | 26 +++++++-
 mm/memory-tiers.c                             | 27 ++++++++
 mm/memory.c                                   | 32 +++++-----
 mm/mempolicy.c                                | 25 +++++---
 mm/migrate.c                                  | 61 ++++++++++++++++++-
 mm/swap.c                                     |  3 +
 mm/vmstat.c                                   |  2 +
 14 files changed, 193 insertions(+), 24 deletions(-)

-- 
2.43.0


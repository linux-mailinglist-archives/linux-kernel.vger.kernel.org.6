Return-Path: <linux-kernel+bounces-242996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECD929005
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14274B21F27
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75F9C156;
	Sat,  6 Jul 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEAGgVmv"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76F8468;
	Sat,  6 Jul 2024 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232737; cv=none; b=RtpY3xGgV2dqJfv7VQyxgzv64O3831ec//NQY/qzqm7HhDMwQWwMUXgC9ZDmkNUP/ex4eZ0Kun5D+Kw83gLwOQNPkfjvI960rV2X7+ZSxo1mNIYAdYTXFiI4fFe1qgWbMS7AZ0CAFbaC6i/rIonjEkfL5UPSO6jddUpgTfYE03E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232737; c=relaxed/simple;
	bh=vmD3Mq3r43gYowa35AtzlDS/ut13hjGb0sCLcYUD9EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oeX55aCI2s/3e5OgXoaOdMKKm3SNvbO7vDZPt64oOU1uK8hvxIaU0ZXksD5N9VEjuIngo31W4iLnrU/TjUfmjZbezDHllj9GbN+nlfJcyYtugp+8rIKIBhsuycyV1hvoIwlrqAF0u0EB78CfiP0HAYVXGwxzmxaAFw2ilvFwCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEAGgVmv; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7035d5c08a8so400548a34.0;
        Fri, 05 Jul 2024 19:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720232734; x=1720837534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ee2T4acbvTWLzCvTllAAlP7d987awgNgDS6bEXL0uyc=;
        b=dEAGgVmvWT/CUmOoDrVz6Q0NA5rrF6aw7LJUwUWyQudxRpdKLCrmZOaGrgibNXrxvD
         uHs1M5qYza1/Ei/6HXYFXcHIx9rkYkiSjK+yOoZC558rdNeU/+RSk6XwENvsVyF0w0Fn
         ENreBzUmopxaLFKUN6GyvET90FqMsGKMHMY2XXNOTD3PFLiFr/LDMQyZ4u3+v8owFtPg
         Tti2m2Whay4wfOYgkj5MJdKUTSnyjOIk1U3Deso1W3l0vDbCCW4E4V7gmCLVQcXiDW8B
         Kdy6A57aqSWx/MYtyhDUiJRWCsBdS95UF4HfeKCqLZVWB89zLQjpPn1Y+DGTPPQdKWCu
         ASSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720232734; x=1720837534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ee2T4acbvTWLzCvTllAAlP7d987awgNgDS6bEXL0uyc=;
        b=xRp3WKy2KcH9wWU+Ccp0PLj5JHT3gH+Pdes9K+pecq51UhEIgj8o37Q2dGlydeSEKD
         1C3PI4hh4d1W9vg9BhZeRDoECMW66ktyEnaiKqLwkhX8F68xLIbxtsClrhCQqT/de49/
         QFC1LT4dAGMq40XPTLf4rn0AAScSIOzY/mnFhV35Rc0hNpvXVFTyNnibW//Epx+QNnge
         B5cmnGj/Bmva5pMLs5UnOyoIwRI6Lvv4fAfOg3iJ/c7Mh31LegrpyKIxZsGqhRmJZGUT
         VwhVMQHapKm9JnfvxAkSHRaLG/21QEYN/iTx/NfFXS5zlWwD37I3a0zPUyrFssjCnRbB
         3xzA==
X-Forwarded-Encrypted: i=1; AJvYcCXE0/1zjVf1mLX8DgsyL0Nyt8svvHH1RpV1msHgHKQsVeFuucG7NI9yfURcI+a+4UI7vaDBjs19LBDcsd7bnJr9LwNiozNmPoBBg2Hw18EuU2GJLEsZ8vbFluiooVhNlty9CtA+TTxG
X-Gm-Message-State: AOJu0YwGsRVVvi5uxfZZdkmXe5m12dUlBU7mFHCaJOwEKeZDlbmWiIKT
	aFWeWNfs/mdyscoJgR/ayDD2LB2e2g18KAIuRzSuZp5R7Fi2o1Zwrjg/KMIr
X-Google-Smtp-Source: AGHT+IHQPg0GcfL4p61Tnzs8LnxFjUAyXE9Fyn5TVFI/gjVtPiaUCH+n0OljT7EUyl8FNa/U0MQpXg==
X-Received: by 2002:a05:6358:88d:b0:1aa:bad6:2ba7 with SMTP id e5c5f4694b2df-1aabad62e40mr5313055d.25.1720232734199;
        Fri, 05 Jul 2024 19:25:34 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15417a7bsm971274b3a.205.2024.07.05.19.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 19:25:33 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
Date: Sat,  6 Jul 2024 02:25:16 +0000
Message-ID: <20240706022523.1104080-1-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This series addresses some issues and introduces a minor improvement in
the zswap global shrinker.

This version addresses issues discovered during the review of v1:
https://lore.kernel.org/linux-mm/20240608155316.451600-1-flintglass@gmail.com/
and includes three additional patches to fix another issue uncovered by
applying v1.

Changes in v2:
- Added 3 patches to reduce resource contention.
mm: zswap: fix global shrinker memcg iteration:
- Change the loop style (Yosry, Nhat, Shakeel)
- To not skip online memcg, save zswap_last_shrink to detect cursor change by cleaner.  (Yosry, Nhat, Shakeel)
mm: zswap: fix global shrinker error handling logic:
- Change error code for no-writeback memcg. (Yosry)
- Use nr_scanned to check if lru is empty. (Yosry)

Changes in v1:
mm: zswap: fix global shrinker memcg iteration:
- Drop and reacquire spinlock before skipping a memcg.
- Add some comment to clarify the locking mechanism.
mm: zswap: proactive shrinking before pool size limit is hit:
- Remove unneeded check before scheduling work.
- Change shrink start threshold to accept_thr_percent + 1%.


Patches
===============================

1. Fix the memcg iteration logic that abort iteration on offline memcgs.
2. Fix the error path that aborts on expected error codes.
3. Add proactive shrinking at accept threshold + 1%.
4. Drop the global shrinker workqueue WQ_MEM_RECLAIM flag to not block
   pageout.
5. Store incompressible pages as-is to accept all pages.
6. Interrupt the shrinker to avoid blocking page-in/out.

Patches 1 to 3 should be applied in this order to avoid potential loops
caused by the first issue. Patch 3 and later can be applied
independently, but the first two issues must be resolved to ensure the
shrinker can evict pages. Patches 4 to 6 address resource contention
issues in the current shrinker uncovered by applying patch 3.

With this series applied, the shrinker will continue to evict pages
until the accept_threshold_percent proactively, as documented in patch
3. As a side effect of changes in the hysteresis logic, zswap will no
longer reject pages under the max pool limit.

The series is rebased on mainline 6.10-rc6.

Proactive shrinking (Patch 1 to 3)
===============================

Visible issue to resolve
-------------------------------
The visible issue with the current global shrinker is that pageout/in
operations from active processes are slow when zswap is near its max
pool size. This is particularly significant on small memory systems
where total swap usage exceeds what zswap can store. This results in old
pages occupying most of the zswap pool space, with recent pages using
the swap disk directly.

Root cause of the issue
-------------------------------
This issue is caused by zswap maintaining the pool size near 100%. Since
the shrinker fails to shrink the pool to accept_threshold_percent, zswap
rejects incoming pages more frequently than it should. The rejected
pages are directly written to disk while zswap protects old pages from
eviction, leading to slow pageout/in performance for recent pages.

Changes to resolve the issue
-------------------------------
If the pool size were shrunk proactively, rejection by pool limit hits
would be less likely. New incoming pages could be accepted as the pool
gains some space in advance, while older pages are written back in the
background. zswap would then be filled with recent pages, as expected
in the LRU logic.

Patches 1 and 2 ensure the shrinker reduces the pool to the
accept_threshold_percent. Without patch 2, shrink_worker() stops
evicting pages on the 16th encounter with a memcg that has no stored
pages (e.g., tiny services managed under systemd).
Patch 3 makes zswap_store() trigger the shrinker before reaching the max
pool size.

With this series, zswap will prepare some space to reduce the
probability of problematic pool_limit_hit situations, thus reducing slow
reclaim and the page priority inversion against LRU.

Visible changes
-------------------------------
Once proactive shrinking reduces the pool size, pageouts complete
instantly as long as the space prepared by proactive shrinking can store
the reclaimed pages. If an admin sees a large pool_limit_hit, lowering
the accept_threshold_percent will improve active process performance.
The optimal point depends on the tradeoff between active process
pageout/in performance and background services' pagein performance.

Benchmark
-------------------------------
The benchmark below observes active process performance under memory
pressure, coexisting with background services occupying the zswap pool.

The tests were run on a vm with 2 vCPU, 1GB RAM + 4GB swap.  20% max
pool and 50% accept threshould (about 100MB proactive shrink),
zsmalloc/lz4.  This test prefer active process than background process
to demonstrate my intended workload.

It runs `apt -qq update` 10 times under a 60MB memcg memory.max
constraint to emulate an active process running under pressure. The
zswap pool is filled prior to the test by allocating a large memory
(~1.5GB) to emulate background inactive services.

The counters below are from vmstat and zswap debugfs stats. The times
are average seconds using /usr/bin/time -v.

pre-patch, 6.10-rc4
|                    | Start       | End         | Delta      |
|--------------------|-------------|-------------|------------|
| pool_limit_hit     | 845         | 845         | 0          |
| pool_total_size    | 201539584   | 201539584   | 0          |
| stored_pages       | 63138       | 63138       | 0          |
| written_back_pages | 12          | 12          | 0          |
| pswpin             | 387         | 32412       | 32025      |
| pswpout            | 153078      | 197138      | 44060      |
| zswpin             | 0           | 0           | 0          |
| zswpout            | 63150       | 63150       | 0          |
| zswpwb             | 12          | 12          | 0          |

| Time              |              |
|-------------------|--------------|
| elapsed           | 8.473        |
| user              | 1.881        |
| system            | 0.814        |

post-patch, 6.10-rc4 with patch 1 to 5
|                    | Start       | End         | Delta      |
|--------------------|-------------|-------------|------------|
| pool_limit_hit     | 81861       | 81861       | 0          |
| pool_total_size    | 75001856    | 87117824    | 12115968   |
| reject_reclaim_fail| 0           | 32          | 32         |
| same_filled_pages  | 135         | 135         | 0          |
| stored_pages       | 23919       | 27549       | 3630       |
| written_back_pages | 97665       | 106994      | 10329      |
| pswpin             | 4981        | 8223        | 3242       |
| pswpout            | 179554      | 188883      | 9329       |
| zswpin             | 293863      | 590014      | 296151     |
| zswpout            | 455338      | 764882      | 309544     |
| zswpwb             | 97665       | 106994      | 10329      |

| Time              |              |
|-------------------|--------------|
| elapsed           | 4.525        |
| user              | 1.839        |
| system            | 1.467        |

Although the pool_limit_hit is not increased in both cases,
zswap_store() rejected pages before this patch. Note that, before this
series, zswap_store() did not increment pool_limit_hit on rejection by
limit hit hysteresis (only the first few hits were counted).

From the pre-patch result, the existing zswap global shrinker cannot
write back effectively and locks the old pages in the pool. The
pswpin/out indicates the active process uses the swap device directly.

From the post-patch result, zswpin/out/wb are increased as expected,
indicating the active process uses zswap and the old pages of the
background services are evicted from the pool. pswpin/out are
significantly reduced from pre-patch results.


System responsiveness issue (patch 4 to 6)
===============================
After applying patches 1 to 3, I encountered severe responsiveness
degradation while zswap global shrinker is running under heavy memory
pressure.

Visible issue to resolve
-------------------------------
The visible issue happens with patches 1 to 3 applied when a large
amount of memory allocation happens and zswap cannot store the incoming
pages.
While global shrinker is writing back pages, system stops responding as
if under heavy memory thrashing.

This issue is less likely to happen without patches 1 to 3 or zswap is
disabled. I believe this is because the global shrinker could not write
back a meaningful amount of pages, as described in patch 2.

Root cause and changes to resolve the issue
-------------------------------
It seems that zswap shrinker blocking IO for memory reclaim and faults
is the root cause of this responsiveness issue. I introduced three
patches to reduce possible blocking in the following problematic
situations:

1. Contention on workqueue thread pools by shrink_worker() using
WQ_MEM_RECLAIM unnecessarily.

Although the shrinker runs simultaneously with memory reclaim, shrinking
is not required to reclaim memory since zswap_store() can reject pages
without interfering with memory reclaim progress. shrink_worker() should
not use WQ_MEM_RECLAIM and should be delayed when another work in
WQ_MEM_RECLAIM is reclaiming memory. The existing code requires
allocating memory inside shrink_worker(), potentially blocking other
latency-sensitive reclaim work.

2. Contention on swap IO.

Since zswap_writeback_entry() performs write IO in 4KB pages, it
consumes a lot of IOPS, increasing the IO latency of swapout/in. We
should not perform IO for background shrinking while zswap_store() is
rejecting pages or zswap_load() is failing to find stored pages. This
series implements two mitigation logics to reduce the IO contention:

2-a. Do not reject pages in zswap_store().
This is mostly achieved by patch 3. With patch 3, zswap can prepare
space proactively and accept pages while the global shrinker is running.

To avoid rejection further, patch 5 (store incompressible pages) is
added. This reduces rejection by storing incompressible pages. When
zsmalloc is used, we can accept incompressible pages with small memory
overhead. It is a minor optimization, but I think it is worth
implementing. This does not improve performance on current zbud but does
not incur a performance penalty.

2-b. Interrupt writeback while pagein/out.
Once zswap runs out of prepared space, we cannot accept incoming pages,
incurring direct writes to the swap disk. At this moment, the shrinker
is proactively evicting pages, leading to IO contention with memory
reclaim.

Performing low-priority IO is straightforward but requires
reimplementing a low-priority version of __swap_writepage(). Instead, in
patch 6, I implemented a heuristic, delaying the next zswap writeback
based on the elapsed time since zswap_store() rejected a page.

When zswap_store() hits the max pool size and rejects pages,
swap_writepage() immediately performs the writeback to disk. The time
jiffies is saved to tell shrink_worker() to sleep up to
ZSWAP_GLOBAL_SHRINK_DELAY msec.

The same logic applied to zswap_load(). When zswap cannot find a page in
the stored pool, pagein requires read IO from the swap device. The
global shrinker should be interrupted here.

This patch proposes a constant delay of 500 milliseconds, aligning with
the mq-deadline target latency.

Visible change
-------------------------------
With patches 4 to 6, the global shrinker pauses the writeback while
pagein/out operations are using the swap device. This change reduces
resource contention and makes memory reclaim/faults complete faster,
thereby reducing system responsiveness degradation. 

Intended scenario for memory reclaim:
1. zswap pool < accept_threshold as the initial state. This is achieved
   by patch 3, proactive shrinking.
2. Active processes start allocating pages. Pageout is buffered by zswap
   without IO.
3. zswap reaches shrink_start_threshold. zswap continues to buffer
   incoming pages and starts writeback immediately in the background.
4. zswap reaches max pool size. zswap interrupts the global shrinker and
   starts rejecting pages. Write IO for the rejected page will consume
   all IO resources.
5. Active processes stop allocating pages. After the delay, the shrinker
   resumes writeback until the accept threshold.

Benchmark
-------------------------------
To demonstrate that the shrinker writeback is not interfering with
pagein/out operations, I measured the elapsed time of allocating 2GB of
3/4 compressible data by a Python script, averaged over 10 runs:

|                      | elapsed| user  | sys   |
|----------------------|--------|-------|-------|
| With patches 1 to 3  | 13.10  | 0.183 | 2.049 |
| With all patches     | 11.17  | 0.116 | 1.490 |
| zswap off (baseline) | 11.81  | 0.149 | 1.381 |

Although this test cannot distinguish responsiveness issues caused by
zswap writeback from normal memory thrashing between plain pagein/out,
the difference from the baseline indicates that the patches reduced
performance degradation on pageout caused by zswap writeback.

The tests were run on kernel 6.10-rc5 on a VM with 1GB RAM (idling Azure
VM with persistent block swap device), 2 vCPUs, zsmalloc/lz4, 25% max
pool, and 50% accept threshold.

---


Takero Funaki (6):
  mm: zswap: fix global shrinker memcg iteration
  mm: zswap: fix global shrinker error handling logic
  mm: zswap: proactive shrinking before pool size limit is hit
  mm: zswap: make writeback run in the background
  mm: zswap: store incompressible page as-is
  mm: zswap: interrupt shrinker writeback while pagein/out IO

 Documentation/admin-guide/mm/zswap.rst |  17 +-
 mm/zswap.c                             | 264 ++++++++++++++++++++-----
 2 files changed, 219 insertions(+), 62 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-308508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93E965DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268F02886B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C017B50B;
	Fri, 30 Aug 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRWoMmch"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BC166F19;
	Fri, 30 Aug 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012284; cv=none; b=PRqX8DUWRQdmdb6lPnLGwniiQKCtuR8UN+uZebp7cwPEIiotfJUeJPb+YibC2p+YJm7fS7LAgSyI3Eqa5q14WQaAN2EzJuY/U8ZVJonAW1ZFgFNWVvIzRKIZR+Q3Oxz+sxUxVSrKScpqK5xQpOZGyg4JDxyRVqb1AldEd2wJRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012284; c=relaxed/simple;
	bh=0LW3yeEbyckH6/EaCbbCABoLyU+izR0YfBDyxWISs7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JK42wmKTH/hIwbkSyJHUIf/fa7u7SLyt6AccdSiMmXQ1gECF8GesE1AAmDB1UemiN4wSgAuUmpn2jqzlqZFNIRPfBkSReR+bUGElbnhy8zNZs3tXuGceUOkMmnvudIAnDuqQ+kG4kFL5YNAsLp61xL9REo1Pvw1O/1j9K8A7oSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRWoMmch; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a8049d4a4cso105243085a.0;
        Fri, 30 Aug 2024 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012281; x=1725617081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLKphNpkkCp+J9O7l+uUUFl357u8bBkR0pEv7i+vcZQ=;
        b=HRWoMmchPIKEL4WrYrDspEVWKyRpSIslBR7Y74+oqMY9UH9EeLUalHd++4lMRRcc/x
         kHR/CBXiiyiE+bH5seCan5SVkc9UWmYqN9dZUqVKYh855tpJGXvz2IEoV4r2IgYq+LmJ
         YUJbl7xXr/hCeyh9h0vvtQ1dbiFDKUh0QuusMxkmErReCmCHwRRFbByI9uVPwvepy5LD
         eS34Ab2/s3e09pBNf8ElxVVPUxVML9B5BUjEfGr1JPhgMkNVDfb3CrJfAZc6R2EPMDKp
         7VAiUElfx3ZTxOZGLSM2rf9Onkz+Y+eB63paB2rFVxNieRkabIRgdSLU52WJItvotdAS
         fgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012281; x=1725617081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLKphNpkkCp+J9O7l+uUUFl357u8bBkR0pEv7i+vcZQ=;
        b=GEV6i/NUI7OgcDE5X8Zv+Y9sNARQn03/foVZwQ7+1hmR33tnMd2qIS4IYAAi0ttclu
         pv5mOjl7hmnHNXOCUQALIksofCbVEZyr7V28++9GgiwMrCDc/BJuuV5lS0bB4RWo30Zb
         uq2gd4+/OOe+vJ/2G2zgwhVODTzXHlB8+FwvGKejYMZDH2lcCsjigDeXqMMvm1dIx+nU
         B/5K+lbLOMLdxl9EaUZUOCPg+k3eyib+xzjJx95gWyD4ekfKN4jhwlwX43pfds7hzxNL
         nej/mJwwlNgrQqOgSaBjg3iq7ZBDjtdxnd5wV6LCZbI+mh8FAdapNv+IzbHHkejeGDzO
         KNgA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3M9E7NB9kbMJ1NYCdblnUoP99mDJrd8cnXwqMRpO2dfJWFea+uZWL2y2Z9K4NEyPA0FKJZTtvyM=@vger.kernel.org, AJvYcCVSjmKU38egmsdNzqCs30deDXbN67vUwSwXiqVNK5J1xCkh0VO47FqWHoMrfdtyKZmhR3ORN21Q+JSgeV54@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkPamWp9JlFV/pK0cK4YHhtNk1Moi/6rSTgxvXZbq86fJOfSv
	+XJ+8UV5crCiDQs6kJF4zTdjDn2TCILxBMHtygFoOqd6xXpObveAijJJBuhJ
X-Google-Smtp-Source: AGHT+IFMKbL7pEYm24WeSLEu9sCq4QqQ9Qp4Fm8CPC+4jsuJQakmX0eaui3K7I12XoanfSpCSgwB+A==
X-Received: by 2002:a05:620a:254b:b0:7a7:df01:f949 with SMTP id af79cd13be357-7a8041ca9f7mr648369785a.33.1725012280883;
        Fri, 30 Aug 2024 03:04:40 -0700 (PDT)
Received: from localhost (fwdproxy-ash-003.fbsv.net. [2a03:2880:20ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3be38sm128888085a.79.2024.08.30.03.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:40 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	npache@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 0/6] mm: split underused THPs
Date: Fri, 30 Aug 2024 11:03:34 +0100
Message-ID: <20240830100438.3623486-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current upstream default policy for THP is always. However, Meta
uses madvise in production as the current THP=always policy vastly
overprovisions THPs in sparsely accessed memory areas, resulting in
excessive memory pressure and premature OOM killing.
Using madvise + relying on khugepaged has certain drawbacks over
THP=always. Using madvise hints mean THPs aren't "transparent" and
require userspace changes. Waiting for khugepaged to scan memory and
collapse pages into THP can be slow and unpredictable in terms of performance
(i.e. you dont know when the collapse will happen), while production
environments require predictable performance. If there is enough memory
available, its better for both performance and predictability to have
a THP from fault time, i.e. THP=always rather than wait for khugepaged
to collapse it, and deal with sparsely populated THPs when the system is
running out of memory.

This patch-series is an attempt to mitigate the issue of running out of
memory when THP is always enabled. During runtime whenever a THP is being
faulted in or collapsed by khugepaged, the THP is added to a list.
Whenever memory reclaim happens, the kernel runs the deferred_split
shrinker which goes through the list and checks if the THP was underused,
i.e. how many of the base 4K pages of the entire THP were zero-filled.
If this number goes above a certain threshold, the shrinker will attempt
to split that THP. Then at remap time, the pages that were zero-filled are
mapped to the shared zeropage, hence saving memory. This method avoids the
downside of wasting memory in areas where THP is sparsely filled when THP
is always enabled, while still providing the upside THPs like reduced TLB
misses without having to use madvise.

Meta production workloads that were CPU bound (>99% CPU utilzation) were
tested with THP shrinker. The results after 2 hours are as follows:

                            | THP=madvise |  THP=always   | THP=always
                            |             |               | + shrinker series
                            |             |               | + max_ptes_none=409
-----------------------------------------------------------------------------
Performance improvement     |      -      |    +1.8%      |     +1.7%
(over THP=madvise)          |             |               |
-----------------------------------------------------------------------------
Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
-----------------------------------------------------------------------------
max_ptes_none=409 means that any THP that has more than 409 out of 512
(80%) zero filled filled pages will be split.

To test out the patches, the below commands without the shrinker will
invoke OOM killer immediately and kill stress, but will not fail with
the shrinker:

echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
mkdir /sys/fs/cgroup/test
echo $$ > /sys/fs/cgroup/test/cgroup.procs
echo 20M > /sys/fs/cgroup/test/memory.max
echo 0 > /sys/fs/cgroup/test/memory.swap.max
# allocate twice memory.max for each stress worker and touch 40/512 of
# each THP, i.e. vm-stride 50K.
# With the shrinker, max_ptes_none of 470 and below won't invoke OOM
# killer.
# Without the shrinker, OOM killer is invoked immediately irrespective
# of max_ptes_none value and kills stress.
stress --vm 1 --vm-bytes 40M --vm-stride 50K

---
v4 -> v5:
- rebase on top of latest mm-unstable. This includes Barrys'
  anon mTHP accounting series. All merge conflicts should be resolved
  with the patches on mailing list. This also means all places
  where partially_mapped flag is set is first tested for it (Barry).
- uint64_t to unsigned long for rss_anon function in selftest.
- convert PageMlocked to folio_test_mlocked in
  try_to_map_unused_to_zeropage.

v3 -> v4:
- do not clear partially_mapped flag on hugeTLB folios (Yu Zhao).
- fix condition for calling deferred_folio_split in partially mapped case
  and count for partially mapped vm events (Barry Song).
- use non-atomic versions of set/clear partially_mapped flags
  (David Hildenbrand)
- use PG_partially_mapped = PG_reclaim (Matthew Wilcox)
- delete folio from lru list and folio_batch_add "new_folio" instead
  of folio in __split_huge_page. (Kairui Song)
- fix deadlock in deferred_split_scan by not doing folio_put while
  holding split_queue_lock (Hugh Dickins)
- underutilized to underused and thp_low_util_shrinker to shrink_underused
  (Hugh Dickins)

v2 -> v3:
- Use my_zero_pfn instead of page_to_pfn(ZERO_PAGE(..)) (Johannes)
- Use flags argument instead of bools in remove_migration_ptes (Johannes)
- Use a new flag in folio->_flags_1 instead of folio->_partially_mapped
  (David Hildenbrand).
- Split out the last patch of v2 into 3, one for introducing the flag,
  one for splitting underutilized THPs on _deferred_list and one for adding
  sysfs entry to disable splitting (David Hildenbrand).

v1 -> v2:
- Turn page checks and operations to folio versions in __split_huge_page.
  This means patches 1 and 2 from v1 are no longer needed.
  (David Hildenbrand)
- Map to shared zeropage in all cases if the base page is zero-filled.
  The uffd selftest was removed.
  (David Hildenbrand).
- rename 'dirty' to 'contains_data' in try_to_map_unused_to_zeropage
  (Rik van Riel).
- Use unsigned long instead of uint64_t (kernel test robot).

Alexander Zhu (1):
  mm: selftest to verify zero-filled pages are mapped to zeropage

Usama Arif (3):
  mm: Introduce a pageflag for partially mapped folios
  mm: split underused THPs
  mm: add sysfs entry to disable splitting underused THPs

Yu Zhao (2):
  mm: free zapped tail pages when splitting isolated thp
  mm: remap unused subpages to shared zeropage when splitting isolated
    thp

 Documentation/admin-guide/mm/transhuge.rst    |  16 ++
 include/linux/huge_mm.h                       |   4 +-
 include/linux/khugepaged.h                    |   1 +
 include/linux/page-flags.h                    |  13 +-
 include/linux/rmap.h                          |   7 +-
 include/linux/vm_event_item.h                 |   1 +
 mm/huge_memory.c                              | 163 ++++++++++++++++--
 mm/khugepaged.c                               |   3 +-
 mm/memcontrol.c                               |   3 +-
 mm/migrate.c                                  |  75 ++++++--
 mm/migrate_device.c                           |   4 +-
 mm/page_alloc.c                               |   5 +-
 mm/rmap.c                                     |   5 +-
 mm/vmscan.c                                   |   3 +-
 mm/vmstat.c                                   |   1 +
 .../selftests/mm/split_huge_page_test.c       |  71 ++++++++
 tools/testing/selftests/mm/vm_util.c          |  22 +++
 tools/testing/selftests/mm/vm_util.h          |   1 +
 18 files changed, 358 insertions(+), 40 deletions(-)

-- 
2.43.5



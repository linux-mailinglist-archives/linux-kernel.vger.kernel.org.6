Return-Path: <linux-kernel+bounces-291345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F11956112
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7914E2817C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C7624B2F;
	Mon, 19 Aug 2024 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnItzEFx"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F96947A;
	Mon, 19 Aug 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034713; cv=none; b=JiEWnPSFWn9aCB0x1SCQTX1fz9jZouLarE5swX2GLrSfTaS6pyd5sQeSwX0r8Q11Ne+iUdbhgvVZSdb94dWYzPv18MFdztxQpmIGGHwF+qA4TrEce6amCvT3yYn2wckejlUNyfcQZcoPr+Qu1GES3CnOEh7UVjAuo8uADGP0RJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034713; c=relaxed/simple;
	bh=i22NReUCAGRVIO9ztXnTIHHfnZxFlPoPg8WtvDLG2uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1C7YbntwrK7Log6XuedJswj8Yfm5jj+672dB6H5AzBgJ1q7oY/AxrODKXksI+NzqpxWuBvJ30HhBCfz6RW+LWt9Qql1Xu1Awd0mBFpESaBOBhJ3lC4GwuacnjFF1UF2qCa0GRfUljRIKK7LVDAu9AxZVS1108sc8iIufrIrS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnItzEFx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fe58fcf29so21906201cf.2;
        Sun, 18 Aug 2024 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724034710; x=1724639510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr/MNKOihCdmGfPcRIsChyQtOWVhC+v3g1s4BetNL5w=;
        b=bnItzEFxM0aS3ahJs1AmObCIuR9UJN4mJB1UZjwPwrKr14LHU07a459JLDIRBSrFaX
         FfvZLzVf2BLvdrpoeWV3n3ddZC55arxH3OeHSC4CYziTBgZBvk4ibnB1myT+b+qqMMby
         /oXAKC0H8Ibd7PWdj+g805+oYYB9Op4br/BKTs+mgVM4+pUVW1uwuseYUbPTlfZMAWFG
         A/Cslyhuhx7nIpnRI7NMGcwnBjZVlJVbSAmDvJSFEZ6j6tNPAfmNLRXmit/17GXa4nPY
         8Nf5wcXaGYSHmp74sQkvx2YCBDvQ1RUS43XEC7SgKvszueglk7Da72144SRkRW2AnDsv
         vYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724034710; x=1724639510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hr/MNKOihCdmGfPcRIsChyQtOWVhC+v3g1s4BetNL5w=;
        b=NacZ75BgbMd7scaR5sSnVZDRBsz24XYLZFayw8GicRyNgV400rQTxA+ckuQbF3upL1
         BQCM5vpe5hdVWk7xKUZzchEwzmi2Es91FvM9UYDix+HrdYjWtQLUCqqJolvOfUt2h2xC
         72fwfVFV98Xsq6HJZEyi4uUcDdQF60q/650j+HdTMJUduegtLU0OXya1t7rtab2HcqBB
         OmzYnBzc1RW3zC7FxcsIRJICE0ZHeDKYvZe4e7SMHZPa8LSh2Ib94gJSx0Ky6O9Q9AK0
         l17GTLHYl++pfRdOkylSynJfI5HdyQKNv1XeO1xnn93hOs2CIAyDhPOCBKJCsY2EGKka
         Ferg==
X-Forwarded-Encrypted: i=1; AJvYcCWJlgXojn43TNCYNlXC29ywJnFsaiA+NDHJodMCEeuY2/bgPCY/mGjoJgwB+BqSMLa9pJe/twc147EwUYeuGPN71ezooAY0Yz5Z9Xx70uZaUE17S8UG/e+9pxfZgHJdguEyBMpN76dx
X-Gm-Message-State: AOJu0Yxh7M0osPdcrrVubdQs6mRoHDeMZ/xvvGzcemuj/TgPVumRNpLT
	MyR0+q68xE4JT5XJfmS7EhChY62bTXWzdei4DmQtZiG3GUKSJ1ob
X-Google-Smtp-Source: AGHT+IHVANl7x8pILhez9TXzw1mYBL1esgGeTHkXNUwc7tgVJVgV88kUbwZwUzm2+nOxxHI53iA4EQ==
X-Received: by 2002:a05:622a:2b45:b0:453:5eae:fa23 with SMTP id d75a77b69052e-453741b5e87mr119763431cf.4.1724034710136;
        Sun, 18 Aug 2024 19:31:50 -0700 (PDT)
Received: from localhost (fwdproxy-ash-113.fbsv.net. [2a03:2880:20ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072683sm36252731cf.85.2024.08.18.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:31:49 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
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
Subject: [PATCH v4 0/6] mm: split underused THPs
Date: Mon, 19 Aug 2024 03:30:53 +0100
Message-ID: <20240819023145.2415299-1-usamaarif642@gmail.com>
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
 include/linux/page-flags.h                    |  11 ++
 include/linux/rmap.h                          |   7 +-
 include/linux/vm_event_item.h                 |   1 +
 mm/huge_memory.c                              | 145 ++++++++++++++++--
 mm/internal.h                                 |   4 +-
 mm/khugepaged.c                               |   3 +-
 mm/memcontrol.c                               |   3 +-
 mm/migrate.c                                  |  75 +++++++--
 mm/migrate_device.c                           |   4 +-
 mm/page_alloc.c                               |   5 +-
 mm/rmap.c                                     |   5 +-
 mm/vmscan.c                                   |   3 +-
 mm/vmstat.c                                   |   1 +
 .../selftests/mm/split_huge_page_test.c       |  71 +++++++++
 tools/testing/selftests/mm/vm_util.c          |  22 +++
 tools/testing/selftests/mm/vm_util.h          |   1 +
 19 files changed, 346 insertions(+), 36 deletions(-)

-- 
2.43.5



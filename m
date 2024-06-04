Return-Path: <linux-kernel+bounces-200411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F938FAFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7B8B2270F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CE71448E2;
	Tue,  4 Jun 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tt3STTYS"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8E29401
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496295; cv=none; b=SXUrMhSVZrcTDenqerxA0qAb5KNrwbFXRi1nYaLr0AEeh8hsUlw+CFSODI+q4xZl7GUp0sprozG3pA5uM9/uhR9ka+xAn7FbXRUPJxZPUVoDfuNkUglupuSt+MOGHmuXF50cAAu8ihyuI0gSTH2i/ZSyC7DX1t0PA1Aeuvji2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496295; c=relaxed/simple;
	bh=6Ba0jHQlk20yaKMJpdzDBs24PEJzekkm35Wy+//eGRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/gMWRk3KZBzQQEou/YIHoEf6SHzaKR9evrc5dCb8rknXql2aRzrCWMKI6Hugq87HhYeLCwUkbGkVkLTk3OH08WdbHFkFnL8qNUhGqhKs74JzxhA0aqNUpvbMp/4w3s/TZnNSJKZ+Ln2cBtdui56zQhLnUuEM5MlewPBzpHmWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tt3STTYS; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717496285; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vLFyufJhWaexguoRjjuFto4LoceeEWV5l7eBCt2gI6k=;
	b=Tt3STTYSmIOs8W0SA/tP9gpatb4WKikKAVUUXX9pZYks2+pPSoDzQHSs6S+Qy04qEzA4FeWSEjzq7QnlZPZNvicpdxPe4Ts/Mb7WNbHdgx52oXbK2vdnYKJDh+bImCJiGViHoAjx+im8zFA7ENuSG1XNRzd6g3E29wkLJPccjvk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7qsp.k_1717496283;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qsp.k_1717496283)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 18:18:04 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] add mTHP support for anonymous shmem
Date: Tue,  4 Jun 2024 18:17:44 +0800
Message-Id: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Anonymous pages have already been supported for multi-size (mTHP) allocation
through commit 19eaf44954df, that can allow THP to be configured through the
sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.

However, the anonymous shmem will ignore the anonymous mTHP rule configured
through the sysfs interface, and can only use the PMD-mapped THP, that is not
reasonable. Many implement anonymous page sharing through mmap(MAP_SHARED |
MAP_ANONYMOUS), especially in database usage scenarios, therefore, users expect
to apply an unified mTHP strategy for anonymous pages, also including the
anonymous shared pages, in order to enjoy the benefits of mTHP. For example,
lower latency than PMD-mapped THP, smaller memory bloat than PMD-mapped THP,
contiguous PTEs on ARM architecture to reduce TLB miss etc.

As discussed in the bi-weekly MM meeting[1], the mTHP controls should control
all of shmem, not only anonymous shmem, but support will be added iteratively.
Therefore, this patch set starts with support for anonymous shmem.

The primary strategy is similar to supporting anonymous mTHP. Introduce
a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
which can have almost the same values as the top-level
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
additional "inherit" option and dropping the testing options 'force' and
'deny'. By default all sizes will be set to "never" except PMD size, which
is set to "inherit". This ensures backward compatibility with the anonymous
shmem enabled of the top level, meanwhile also allows independent control of
anonymous shmem enabled for each mTHP.

Use the page fault latency tool to measure the performance of 1G anonymous shmem
with 32 threads on my machine environment with: ARM64 Architecture, 32 cores,
125G memory:
base: mm-unstable
user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
0.04s        3.10s         83516.416                  2669684.890

mm-unstable + patchset, anon shmem mTHP disabled
user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
0.02s        3.14s         82936.359                  2630746.027

mm-unstable + patchset, anon shmem 64K mTHP enabled
user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
0.08s        0.31s         678630.231                 17082522.495

From the data above, it is observed that the patchset has a minimal impact when
mTHP is not enabled (some fluctuations observed during testing). When enabling 64K
mTHP, there is a significant improvement of the page fault latency.

[1] https://lore.kernel.org/all/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com/

Changes from v3:
 - Drop 'force' and 'deny' testing options for each mTHP.
 - Use new helper update_mmu_tlb_range(), per Lance.
 - Update documentation to drop "anonymous thp" terminology, per David.
 - Initialize the 'suitable_orders' in shmem_alloc_and_add_folio(),
   reported by kernel test robot.
 - Fix the highest mTHP order in shmem_get_unmapped_area().
 - Update some commit message.

Changes from v2:
 - Rebased to mm/mm-unstable.
 - Remove 'huge' parameter for shmem_alloc_and_add_folio(), per Lance.

Changes from v1:
 - Drop the patch that re-arranges the position of highest_order() and
   next_order(), per Ryan.
 - Modify the finish_fault() to fix VA alignment issue, per Ryan and
   David.
 - Fix some building issues, reported by Lance and kernel test robot.
 - Update some commit message.

Changes from RFC:
 - Rebase the patch set against the new mm-unstable branch, per Lance.
 - Add a new patch to export highest_order() and next_order().
 - Add a new patch to align mTHP size in shmem_get_unmapped_area().
 - Handle the uffd case and the VMA limits case when building mapping for
   large folio in the finish_fault() function, per Ryan.
 - Remove unnecessary 'order' variable in patch 3, per Kefeng.
 - Keep the anon shmem counters' name consistency.
 - Modify the strategy to support mTHP for anonymous shmem, discussed with
   Ryan and David.
 - Add reviewed tag from Barry.
 - Update the commit message.

Baolin Wang (6):
  mm: memory: extend finish_fault() to support large folio
  mm: shmem: add THP validation for PMD-mapped THP related statistics
  mm: shmem: add multi-size THP sysfs interface for anonymous shmem
  mm: shmem: add mTHP support for anonymous shmem
  mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
  mm: shmem: add mTHP counters for anonymous shmem

 Documentation/admin-guide/mm/transhuge.rst |  23 ++
 include/linux/huge_mm.h                    |  23 ++
 mm/huge_memory.c                           |  17 +-
 mm/memory.c                                |  57 +++-
 mm/shmem.c                                 | 344 ++++++++++++++++++---
 5 files changed, 403 insertions(+), 61 deletions(-)

-- 
2.39.3



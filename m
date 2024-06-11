Return-Path: <linux-kernel+bounces-209614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C1903879
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824E5283A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C571017966E;
	Tue, 11 Jun 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="coBKcjYZ"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B79176ACE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100687; cv=none; b=f3Ka104MIdcp6GIVOeYqtC/TYwHQZdMLvgfzFF+orgR1JWRnBpfrjnhqoELTMVG06k1wFhIeiahjhq+PRS15tET5HInzRQjphPIG4np0rqo8M/uhZQJYIPhX9PH4Jn+VPqf01a0rXGDMY7rcHe1ufJkhL+WNSp6uWa6xXVqJaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100687; c=relaxed/simple;
	bh=hcr3QntiY1hJlMED7LNJYXLvbYdUvoN0GePDdH6BPEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4yXtJsgykp/PJjOAsdEzbu2scpnSdZdTpul6uGq2nQ1e9bRYk7nbR+x7R3Teym40PG34J26nJmjOQzGt8k1mvaoC1zGaqdB+W+sZtnMIyXYwn0nLZMACk9HNbiWXrCqGagbYnyeqy6cqK8psFusehnrlltmWoM3gKmD6TuyVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=coBKcjYZ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718100677; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UejwwPwOxMBtGoIPmc4qXddgYNZAKKSFUqrAwuYbAKM=;
	b=coBKcjYZJuRgPrLe/z93e9HzV5S7p5gDKHtFBCn9YWFi5oX02mL/RnClw0mlBzIf0Q6qMsXc76i2sgkkqLAn5Qlbl9rRsjXGQ0xyfPWvg8r7jXm91NC0JYnvi6kVlBdgkv8Zxvi+pDhfgdLTsRXxGWdJdrUr+I2YyQP2q8nP6qI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8G1Jpi_1718100674;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8G1Jpi_1718100674)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 18:11:15 +0800
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
Subject: [PATCH v5 0/6] add mTHP support for anonymous shmem
Date: Tue, 11 Jun 2024 18:11:04 +0800
Message-Id: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
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

Changes from v4:
 - Fix the unused variable warning reported by kernel test robot.
 - Drop the 'anon' prefix for variables and functions, per Daniel.

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



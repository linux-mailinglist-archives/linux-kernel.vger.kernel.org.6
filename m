Return-Path: <linux-kernel+bounces-169519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF88BC9E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37AB1F21275
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CD1422A7;
	Mon,  6 May 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t+giJnFs"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F436CDAC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985210; cv=none; b=Rcs2Wi0db9b1OMjKhouR7y/sL0P3Yby1rAhLdDDjmqdQGALmitKntz/4itFVylOC+H1nKviXSQ7h1EBaCh7D4aU/nAtVF5ZlEqRyr32EmruQPCq8HydyPeN7srSLo2zfVud3blZtGA2Mjto2b8DEghiuP85arwW7GGC9lNSJxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985210; c=relaxed/simple;
	bh=JfeAJymU4yclhfki48TSElNWkbKidXuqoRMYMzoW13A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HG9zWNaZW+DnhxbwRr6/BWLlyQAqsrTtbDB/9UMRFcDYzbnw0qwGvV8njAmKOtvkNmE3jVc+CrfW3t5LSPhtm3cXEbPOe1lbYY5g++kvx/PLHUhiNI2ayQUx68cqSrv0F73i9hEhuezHS2V2Eh4LxOcMr6/sQDejLJIOuBqCtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t+giJnFs; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714985205; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aUMYxLX2kFmWpJjpY9eym1HX2xADFAvHPfRUdrhEgnE=;
	b=t+giJnFs/al3gDway/V6kd19m2l895VJ+FuYqCZ1CpSWSVS02mED7ZGrywBOnwV8VzjxqOCIdORk+mAJlUVYelBowf97LIV18Flnq+j6cbOaP+RxyDmBBlTFxahp9cYUjynce9Q74TBbIob5ZPZLNK8qqW3xwX/JEtvwNQTNmcY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W5weiIc_1714985202;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5weiIc_1714985202)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 16:46:43 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] add mTHP support for anonymous shmem
Date: Mon,  6 May 2024 16:46:24 +0800
Message-Id: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
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

However, the anonymous shared pages will ignore the anonymous mTHP rule
configured through the sysfs interface, and can only use the PMD-mapped
THP, that is not reasonable. Many implement anonymous page sharing through
mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
therefore, users expect to apply an unified mTHP strategy for anonymous pages,
also including the anonymous shared pages, in order to enjoy the benefits of
mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.

The primary strategy is similar to supporting anonymous mTHP. Introduce
a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
which can have all the same values as the top-level
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
additional "inherit" option. By default all sizes will be set to "never"
except PMD size, which is set to "inherit". This ensures backward compatibility
with the shmem enabled of the top level, meanwhile also allows independent
control of shmem enabled for each mTHP.

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

TODO:
 - Support mTHP for tmpfs.
 - Do not split the large folio when share memory swap out.
 - Can swap in a large folio for share memory.

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

Baolin Wang (8):
  mm: move highest_order() and next_order() out of the THP config
  mm: memory: extend finish_fault() to support large folio
  mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
  mm: shmem: add THP validation for PMD-mapped THP related statistics
  mm: shmem: add multi-size THP sysfs interface for anonymous shmem
  mm: shmem: add mTHP support for anonymous shmem
  mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
  mm: shmem: add mTHP counters for anonymous shmem

 Documentation/admin-guide/mm/transhuge.rst |  29 ++
 include/linux/huge_mm.h                    |  35 ++-
 mm/huge_memory.c                           |  17 +-
 mm/memory.c                                |  43 ++-
 mm/shmem.c                                 | 335 ++++++++++++++++++---
 5 files changed, 387 insertions(+), 72 deletions(-)

-- 
2.39.3



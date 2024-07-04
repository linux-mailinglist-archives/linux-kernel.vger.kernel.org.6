Return-Path: <linux-kernel+bounces-240958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94F927513
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F9B243BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AED11AD40D;
	Thu,  4 Jul 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cokb6ypV"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326111ABCC4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092320; cv=none; b=lEiIFq0vtOF7gd0rI5p6hSG0VfOKgjzkX1TUxN2ztOKP6knApt0FB1zF+kCLX//a1WA3qXJYPHBaz/i7IfnZzZlx/2Gn16pFa/KRiK4+A9ypRKfx27SMtrYAbGGZk4Qmj9soCGrM+zgX1A6BelVBTD1p1XWh7rU0+O7XdXdYrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092320; c=relaxed/simple;
	bh=1X2ZfEGo4/55mtWS4y1X8CFqjNN5ZRK+aDjdXCxyty0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WsJpoMIrWBd7oeuTOad9PtBg9b6QOwVro7DVIYBIz0GosPa9HAwEw6J58OiPvuTjdGXqkaeLp4Cpb1U2FjDh8vZjPiQqXLGt3xSdZezJppIc8iPo9pVgM1Uf6JROwPPIxbcKjw5JM0hx0/KSbtj9Y7AVEOzkj6sEyHomVj61k6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cokb6ypV; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092309; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=O9qIRjAHBzIZT+8EnwoZqAhzP4xcW4fjSuW9RePEmE0=;
	b=cokb6ypVmP1mG4Jqor4PP0xzMDc/TVdqvb6sRorOx9qmmAIJ416pbmcfosIHAGrq9rn2bBAkhgZ4gBQflcgDGgO/BbX4qIKpdPwKUHlHOya2RLaSMtnwIWeyARi7IF4APaWm3bTvQOs0pv8PcWfnM+YrqO95h30R5q2L8IXfctY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qjOvo_1720092306;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qjOvo_1720092306)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:07 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
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
Subject: [PATCH v3 00/10] support large folio swap-out and swap-in for shmem
Date: Thu,  4 Jul 2024 19:24:49 +0800
Message-Id: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shmem will support large folio allocation [1] [2] to get a better performance,
however, the memory reclaim still splits the precious large folios when trying
to swap-out shmem, which may lead to the memory fragmentation issue and can not
take advantage of the large folio for shmeme.

Moreover, the swap code already supports for swapping out large folio without
split, and large folio swap-in[3] series is queued into mm-unstable branch.
Hence this patch set also supports the large folio swap-out and swap-in for
shmem.

Note: this series is targeted for v6.12. Please help to review. Thanks.

Functional testing
==================
I use the latest mm-unstable branch to test with reverting Chris's
"mm: swap: mTHP swap allocator base on swap cluster order" series which
can cause some problems (Hugh also reported in [4]).

Machine environment: 32 Arm cores, 120G memory and 50G swap device.

1. Run xfstests suite to test tmpfs filesystem, and I did not catch any
regressions with this patch set.
FSTYP=tmpfs
export TEST_DIR=/mnt/tempfs_mnt
export TEST_DEV=/mnt/tempfs_mnt
export SCRATCH_MNT=/mnt/scratchdir
export SCRATCH_DEV=/mnt/scratchdir

2. Run all mm selftests in tools/testing/selftests/mm/, and no
regressions found.

3. I also wrote several shmem swap test cases, including shmem splitting,
shmem swapout, shmem swapin, swapoff during shmem swapout, shmem reclaim,
shmem swapin replacement, etc. I tested these cases under 4K and 64K
shmem folio sizes with a swap device, and shmem swap functionality works
well on my machine.

[1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
[3] https://lore.kernel.org/all/20240508224040.190469-6-21cnbao@gmail.com/T/
[4] https://lore.kernel.org/all/8db63194-77fd-e0b8-8601-2bbf04889a5b@google.com/

Chagens from v2:
 - Add new patch to split large swap entry if swapin folio is order 0
 folio.
 - Update some commit message.

Changes from v1:
 - Remove useless 'order' variable in shmem_partial_swap_usage(), per Daniel.
 - Add a new patch to return number of pages beeing freed in shmem_free_swap(),
 per Daniel.
 - Drop 'orders' parameter for find_get_entries() and find_lock_entries().
 - Round down the index when adding the swapin folio into the pagecache,
 suggested by Hugh.
 - Fix the reference issue when removing folio from pagecache in patch 8.
 - Fix replacing old folio in swap cache in patch 7.

Changes from RFC:
 - Rebased to the latest mm-unstable.
 - Drop the counter name fixing patch, which was queued into mm-hotfixes-stable
 branch.

Baolin Wang (9):
  mm: vmscan: add validation before spliting shmem large folio
  mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM
    flag setting
  mm: shmem: extend shmem_partial_swap_usage() to support large folio
    swap
  mm: filemap: use xa_get_order() to get the swap entry order
  mm: shmem: use swap_free_nr() to free shmem swap entries
  mm: shmem: support large folio allocation for shmem_replace_folio()
  mm: shmem: drop folio reference count using 'nr_pages' in
    shmem_delete_from_page_cache()
  mm: shmem: split large entry if the swapin folio is not large
  mm: shmem: support large folio swap out

Daniel Gomez (1):
  mm: shmem: return number of pages beeing freed in shmem_free_swap

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |   1 +
 include/linux/swap.h                      |   4 +-
 include/linux/writeback.h                 |   1 +
 mm/filemap.c                              |   4 +
 mm/shmem.c                                | 203 +++++++++++++++++-----
 mm/swapfile.c                             |  98 ++++++-----
 mm/vmscan.c                               |  22 ++-
 7 files changed, 238 insertions(+), 95 deletions(-)

-- 
2.39.3



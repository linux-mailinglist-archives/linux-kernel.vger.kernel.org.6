Return-Path: <linux-kernel+bounces-277462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6894A1C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946F41F21D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E671C7B91;
	Wed,  7 Aug 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="juCQ0qyl"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98789144D29
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015894; cv=none; b=i3JX0IozVwd4CZTfuwfaEtFBzFcUxpjVuarwDAivuZfumhwEBTAa1mD7/PKm44UOI37O7QWKlpx72Uu/PimIiHsMtxPZVv+in2Q4n0ffg/lbKyzRy0g6z+TaeYa0RSj43pdvzUs9Lk7O5GmXFKB4+06uT6pXvmuRjdjSakzHEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015894; c=relaxed/simple;
	bh=56LbMWriAwJIQseweaatGZx311jJHUarBa3NxBGW/uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=deuUYMlkAgTbTgLgkaHOcfkcOpix2kkqw1P/S6mEB8e3uWa0sMgtIKnmgO7stVU6efK52DGOzGPGIf8AHrX8ZVBnb8C3EulzHBboXMy55yB5i7rFaGPbP8SwgXPfj3Un05ZtWke69sS7nhpS/RJfJ8EpHG1oqXjOHL3wn8DkiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=juCQ0qyl; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015888; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fgC4UpxOa1kazOGGbsj2FlTe7jmly3f8dNHIGq7Om28=;
	b=juCQ0qylQ7mXNJlhJZwqK9cWzFV08Hz9RK667y8hAr2bCfGx9ytL9XxY8vFfOsa8MtFh9FIhnF5T2fy82rhtOrHtv4lM1Hlb994xKGG8hwUm59V1qY4iU4/PQIWZNZKnJg3L0HKSETt7EjBIXk1zQu4CigE1xGhiLIRp/lnqtY8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI3gdm_1723015886;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI3gdm_1723015886)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:27 +0800
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
Subject: [PATCH v4 00/10] support large folio swap-out and swap-in for shmem
Date: Wed,  7 Aug 2024 15:31:05 +0800
Message-Id: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
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

Please help to review. Thanks.

Functional testing
==================
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

Changes from v3:
 - Rebase to the latest mm-unstable.
 - Simplify patch 2 based on Barry's patch:
 https://lkml.kernel.org/r/20240730071339.107447-2-21cnbao@gmail.com

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
 mm/shmem.c                                | 208 +++++++++++++++++-----
 mm/swapfile.c                             |   4 +-
 mm/vmscan.c                               |  22 ++-
 7 files changed, 194 insertions(+), 50 deletions(-)

-- 
2.39.3



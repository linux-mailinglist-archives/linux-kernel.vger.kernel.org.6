Return-Path: <linux-kernel+bounces-282728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316BC94E7FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBC51F23D71
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7515B0E2;
	Mon, 12 Aug 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GgFzvq5h"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0B1474D3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448549; cv=none; b=HlAifpApYwMvwy65shi7IG+23utGLgCMVxq7gbcKC4WTPDIdizZMCKcThPLAebfUCCmhwzSLBD2l8A9Rl+z+q1KboWmlXXJyfig88XbjhB+XWqboEtNYf2lA+IeMvSuOmSxz+xufzpcEJX6ZyLzQeoIurGasi88kFah4FJoHr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448549; c=relaxed/simple;
	bh=YA26iM8KAvq6Gw3OnkRrjMkA88/IptdkckubsnCHiXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmfnrTXSMnrFWd/lhXLbJejvpqI3+Tou2//U9EKJ3W3ITMn54I5Vyw/EXWlxE+FdrGA+c6lL4HmfE5HnxAswYx/dNNdHOO/EJRpyBHmwEKlSvFHDsfmYI/0c1ZGtdF5iCNU9R3eWSlBlmdI2LwvwhC0hW7jmGnanCnh7uiJe6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GgFzvq5h; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723448539; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qDA/WcF+N7bRZ8xnTFUSXzMx22fwcCPeP/T81buhQT0=;
	b=GgFzvq5hpStqDw/IfRpnl5Rxi2TeiqjyWsZgwsQ9CAH96BysfyrMzny4liABsEwXVEmzOUhGsiUPbQcGkgtJRbIGdjHFOJ35WolmFahrIp62GijMK9JnxhIbBYiLf/1CUr4TJZkEtGNhG6LIxeofgEI32dH+pX2nxqMBo6mNnNU=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCbU5t2_1723448537)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 15:42:17 +0800
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
Subject: [PATCH v5 0/9] support large folio swap-out and swap-in for shmem
Date: Mon, 12 Aug 2024 15:42:01 +0800
Message-Id: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
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

Changes from v4:
 - Add reviewed tag from Barry. Thanks.
 - Drop patch 1 and move shmem split to shmem_writepage(), which can avoid
 other unnecessary split, per David.

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

Baolin Wang (8):
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
 include/linux/writeback.h                 |   4 +
 mm/filemap.c                              |   4 +
 mm/shmem.c                                | 217 +++++++++++++++++-----
 mm/swapfile.c                             |   4 +-
 mm/vmscan.c                               |  32 +++-
 7 files changed, 209 insertions(+), 57 deletions(-)

-- 
2.39.3



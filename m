Return-Path: <linux-kernel+bounces-218705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2181590C426
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E66282444
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610712B17C;
	Tue, 18 Jun 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lKyP5K6G"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66F7602D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693679; cv=none; b=pv4sNqZo6VoIh8R8A/ABxz4Zw//2+uc0Y5ZlZFClFWiFlETLWBy/CauQ6XAYBPmBvCeHfWIp3YqWdzyuY77ebWN+00EYkeqmUyfaKfs7m9Vneuu1p5t7G0KE15um4M3mibI6qygP2FedkWC3JzXqS12ajdjfFD6OTM+O4cY4JWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693679; c=relaxed/simple;
	bh=S2sGp3wlH/b5kYZp5cjkHur9G9Zz83kTTmfnbJALzzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQDu99PvewjhWWPwAzeuIlfhb24g/XykaeSiAOJnGPfcwu/BfrkHbvKF6DnVbhCaWphQHqH3DR4GfjIR6vN+A/QvkPWItITiThbH0vT5Ydn4AcJ3weq6XDUERIfzEtoczf809gE1tH6BMF3mGfWJmMQAR0+6qriBAIzBSvdqV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lKyP5K6G; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693669; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DxaCp5bOC4hyWB6FKdEFK/JUDfrUbLNO+z6WPPrt+Vw=;
	b=lKyP5K6GrpOdFAsIyYXpaiCuDU374+QUNURhr/XPZCF+8FPwIySdQw/WvEGbMsPKQ+ixoQcitc8FRFXCTWtotN5k1kYCqwOqX/GR6q3UaakDo0C+hZDjz8WNI9c3voRHTi9hRDpqZp2q/eD59pqSwZMWJ5ppnTtzXElN5xs0U0s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8jFFIj_1718693666;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8jFFIj_1718693666)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:54:27 +0800
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
Subject: [PATCH v2 0/9] support large folio swap-out and swap-in for shmem
Date: Tue, 18 Jun 2024 14:54:12 +0800
Message-Id: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
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
well on my machine (I can share these test cases if needed).

Hugh, I think this version has fixed the reference issue you pointed out
before, and I have also fixed some issues related to shmem swapin replacement.
So could you help to take a look at this series when you find some time?
Thanks a lot.

[1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
[3] https://lore.kernel.org/all/20240508224040.190469-6-21cnbao@gmail.com/T/
[4] https://lore.kernel.org/all/8db63194-77fd-e0b8-8601-2bbf04889a5b@google.com/

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
  mm: shmem: support large folio swap out

Daniel Gomez (1):
  mm: shmem: return number of pages beeing freed in shmem_free_swap

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |   1 +
 include/linux/swap.h                      |   4 +-
 include/linux/writeback.h                 |   1 +
 mm/filemap.c                              |   4 +
 mm/shmem.c                                | 107 +++++++++++++---------
 mm/swapfile.c                             |  98 ++++++++++----------
 mm/vmscan.c                               |  22 ++++-
 7 files changed, 142 insertions(+), 95 deletions(-)

-- 
2.39.3



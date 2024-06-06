Return-Path: <linux-kernel+bounces-204214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562DB8FE5EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D345AB2387A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62219596E;
	Thu,  6 Jun 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="caBHPkLo"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325444DA14
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675156; cv=none; b=XMhGGbQ64yH6d3JRWjE8pvrZfjWnIG9nAB+NCjPkccyKVRq5wOcRD4l4IuPzIh2CmWnlL4eHoI3J0tWOA2DEwIXEM7Aho8ucPei/PeePsx8XzB3RqqQxG3qQfmBX6NG6Ph95zaooF9uaJeHqtWNgkJbbkq4OWxEq7rAwC1TuP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675156; c=relaxed/simple;
	bh=DafEl+bQ3wLqzbq8YRcPrHFmGq29QWdzWlhvrhemJRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SRdT5bHi4UJPgxdA3Kg3cpKp76hJZ537qexsZzudAKwk83mIyvP3pIGsez1RsiwpUDiIhnsj9B/4LQVbwVhvI4iWCEMOcYXEupYl55I4SoFyblqaISesCvtCKdTtp2nvKTkzI3RaVSAMiUqtGkufgE2lf4F4HtfF8nXk1FZqny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=caBHPkLo; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717675152; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jM6eZe4x6k+egILzv89K9Z+MG/ZZ4Ym9gSqYkloSOdc=;
	b=caBHPkLoL3jvQRFWoUk1n7jQa2VhnnEQ3W+UrXZ/KD30aG/PpOHfr+cKCRw1p3Q4OEmkC2hK+otsiYm29dbiAamhy/ID3UUHMdJh0eQeorCVN8f8Iqab4nrEn5NlcvWWYT0TzgY/mpGWTRRY3v0pSv55Mmnr0AiGD234jaD1FgI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W7y6tom_1717675149;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7y6tom_1717675149)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:59:10 +0800
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
Subject: [PATCH 0/7] support large folio swap-out and swap-in for shmem
Date: Thu,  6 Jun 2024 19:58:50 +0800
Message-Id: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
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

[1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
[3] https://lore.kernel.org/all/20240508224040.190469-6-21cnbao@gmail.com/T/

Changes from RFC:
 - Rebased to the latest mm-unstable.
 - Drop the counter name fixing patch, which was queued into mm-hotfixes-stable
 branch.

Baolin Wang (7):
  mm: vmscan: add validation before spliting shmem large folio
  mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM
    flag setting
  mm: shmem: support large folio allocation for shmem_replace_folio()
  mm: shmem: extend shmem_partial_swap_usage() to support large folio
    swap
  mm: add new 'orders' parameter for find_get_entries() and
    find_lock_entries()
  mm: shmem: use swap_free_nr() to free shmem swap entries
  mm: shmem: support large folio swap out

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
 include/linux/swap.h                      |  4 +-
 include/linux/writeback.h                 |  1 +
 mm/filemap.c                              | 27 ++++++-
 mm/internal.h                             |  4 +-
 mm/shmem.c                                | 58 ++++++++------
 mm/swapfile.c                             | 98 ++++++++++++-----------
 mm/truncate.c                             |  8 +-
 mm/vmscan.c                               | 22 ++++-
 9 files changed, 140 insertions(+), 83 deletions(-)

-- 
2.39.3



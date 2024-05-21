Return-Path: <linux-kernel+bounces-184849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11BA8CAD02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004F5B22503
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B686757ED;
	Tue, 21 May 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bcS6VBAi"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9655783
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289422; cv=none; b=UpnO8IEGndDcVhtvfDsNCfFcU7oGchxyPgE5nevGU1S4WZnD9cHFiogJf3HAmB5Oj7mMZMLRWliuH7oU83peuFl/o/0aUyQJHEMZpgohqql9bRwbat5oPSsx6DhHZyzNeC9S0uWvKkFrgzzQaBlEOh+JkoufV9Y1BO1W0fGtgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289422; c=relaxed/simple;
	bh=OBDNnfmWkTXAdsmRLyEDkT79uCe2OHj6j4IoKgPuUL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Osew9UjXI7/YFiXKAz8kus3qy7hHXH6SL/5duhDrlh8amw8IVvpGAcNKnIv7nJ6fdWDm6G4XCDwqbBJ3Ly605R6HtBcve1WMjxv0Ec/P88sOA5csrbqpDfoYk5xQg/BOXY0KCSpDie4Tn5m+e4IWxwWnchx0+WtFSzbDcRG39H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bcS6VBAi; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716289412; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5PqxFNloiLvIbMcW2Zx5xktZCjoV+unTt+9oQbRXBcI=;
	b=bcS6VBAigZpKUVZ+EMCB8SDxCff+FtxiDsUPwv5kJjdsO7zLUcUxKTTxNI6xr3dnUTs84ioV9BFq/BlVVP8Lqz+QaKXWZRZiyDcoAEja6p1XQPPKBGAohjHp209fzGHhK80oV1LBh/+B9UOl3cvjEbhuuaPfvuQ48WITYUiZAqo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W6xl93X_1716289408;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6xl93X_1716289408)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 19:03:29 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	hrisl@kernel.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] support large folio swap-out and swap-in for shmem
Date: Tue, 21 May 2024 19:03:10 +0800
Message-Id: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
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
split, and large folio swap-in[3] is under reviewing. Hence this patch set also
supports the large folio swap-out and swap-in for shmem.

Note: this patch set is currently just to show some thoughts and gather some
suggestionsis, and it is based on Barry's large folio swap-in patch set [3] and
my anon shmem mTHP patch set [1].

[1] https://lore.kernel.org/all/cover.1715571279.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
[3] https://lore.kernel.org/all/20240508224040.190469-6-21cnbao@gmail.com/T/

Baolin Wang (8):
  mm: fix shmem swapout statistic
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
 mm/page_io.c                              |  4 +-
 mm/shmem.c                                | 59 ++++++++------
 mm/swapfile.c                             | 98 ++++++++++++-----------
 mm/truncate.c                             |  8 +-
 mm/vmscan.c                               | 22 ++++-
 10 files changed, 143 insertions(+), 85 deletions(-)

-- 
2.39.3



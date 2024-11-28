Return-Path: <linux-kernel+bounces-424341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7839DB33B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911B7B21C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E314884D;
	Thu, 28 Nov 2024 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mjTshkSJ"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D29146A71
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779662; cv=none; b=nTwSRAN/Df9UjA++TLLrc2QM3lBJFvMTctC8gb9dQSWOwrAQcb4TtNM3zEqsuee8lNwPlPtF7FWJnH+i4EcL49UTLQVgr76Pkb2zXUJwkzCRuQung09uk9TwuZhDTbhiHkKTH6EdPArkNFN9gDeqcC+kEHCxUNyP2MYdFzrGV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779662; c=relaxed/simple;
	bh=jOZ1lPdBZGddgI8YWlsY8FvjpwuvCZRHhDPuoonVNz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qcWmkh75s4tYEKW/Z2A3BU5ZZD75UhXr5vOJR2x+WIGNi/gSm+oiG9hxnojas8NG1r8B6POYgxswXrCNHz6VfIqjVtYJcXlUAMlPwoAPa2fR0j6rHSZglyh0IVZc+InUR+tbPSyLyiBx9eTR00U8ENodcEBPrxMO4QJe2RBP0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mjTshkSJ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732779656; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=l/8YEYXsPcAmCqwYYFhuOOdFVbEqO8knORxafeXmAJ4=;
	b=mjTshkSJ6G1z8dkZrT+cAhPc0/qzGoFawe3OudBiAAdiqGcB/hMnzCAfNdcq7O+Z6P15AvQbYdEVNYDtjPTqgOyod4PlU/+MZdQ2LJN83pR4JpMOUIj8j/eclPI3N5ssKPrfiBNC9pm1JQ8z6Mgumwn5Yd2gUeKENjT22pUt0o8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKP.Wj5_1732779653 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 15:40:54 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Support large folios for tmpfs
Date: Thu, 28 Nov 2024 15:40:38 +0800
Message-Id: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Traditionally, tmpfs only supported PMD-sized large folios. However nowadays
with other file systems supporting any sized large folios, and extending
anonymous to support mTHP, we should not restrict tmpfs to allocating only
PMD-sized large folios, making it more special. Instead, we should allow
tmpfs can allocate any sized large folios.

Considering that tmpfs already has the 'huge=' option to control the PMD-sized
large folios allocation, we can extend the 'huge=' option to allow any sized
large folios. The semantics of the 'huge=' mount option are:

huge=never: no any sized large folios
huge=always: any sized large folios
huge=within_size: like 'always' but respect the i_size
huge=advise: like 'always' if requested with madvise()

Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
allocate the PMD-sized large folios if huge=always/within_size/advise is set.

Moreover, the 'deny' and 'force' testing options controlled by
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
semantics. The 'deny' can disable any sized large folios for tmpfs, while
the 'force' can enable PMD sized large folios for tmpfs.

Any comments and suggestions are appreciated. Thanks.

Changes from v2:
 - Collect reviewed tags. Thanks.
 - Add a new patch to drop fadvise from the docs.
 - Drop the 'MAX_PAGECACHE_ORDER' check in shmem_huge_global_enabled(),
   per David.
 - Update the commit message, per Daniel.
 - Rebase on the latest mm-unstable branch.

Changes from v1:
 - Add reviewed tag from Barry and David. Thanks.
 - Fix building warnings reported by kernel test robot.
 - Add a new patch to control the default huge policy for tmpfs.

Changes from RFC v3:
 - Drop the huge=write_size option.
 - Allow any sized huge folios for 'hgue' option.
 - Update the documentation, per David.

Changes from RFC v2:
 - Drop mTHP interfaces to control huge page allocation, per Matthew.
 - Add a new helper to calculate the order, suggested by Matthew.
 - Add a new huge=write_size option to allocate large folios based on
   the write size.
 - Add a new patch to update the documentation.

Changes from RFC v1:
 - Drop patch 1.
 - Use 'write_end' to calculate the length in shmem_allowable_huge_orders().
 - Update shmem_mapping_size_order() per Daniel.

Baolin Wang (5):
  mm: factor out the order calculation into a new helper
  mm: shmem: change shmem_huge_global_enabled() to return huge order
    bitmap
  mm: shmem: add large folio support for tmpfs
  mm: shmem: add a kernel command line to change the default huge policy
    for tmpfs
  docs: tmpfs: drop 'fadvise()' from the documentation

David Hildenbrand (1):
  docs: tmpfs: update the large folios policy for tmpfs and shmem

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/mm/transhuge.rst    |  72 ++++++---
 include/linux/pagemap.h                       |  16 +-
 mm/shmem.c                                    | 150 ++++++++++++++----
 4 files changed, 188 insertions(+), 57 deletions(-)

-- 
2.39.3



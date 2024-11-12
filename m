Return-Path: <linux-kernel+bounces-405324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C29C4FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148481F21683
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C720A5F7;
	Tue, 12 Nov 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LOzHq/2O"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A6205E37
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397561; cv=none; b=P5gix2fuwpNmeckvF99rQETruTBLd5PSYhx1qxY2LfIpKvkNMYzuDNlr9kir2WNE2ORvWVKTJPxpfOZOBJILuQfBRw8xKjNteohOB5M+e2mxILMlKgPla7C6HmFmD9Ra6NkA8CY8tAFmnxLEQw/Zc6SEKgi8U1yCWr2AK0maiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397561; c=relaxed/simple;
	bh=eBiuIt2a7mdjKmvjBYkWXOV8hgkGe+0Dp4qs0mZqoos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDEURlZv9vi51cYQMp5Zih8SgetkrSvAzv78lnV2BaR+9rOWaZ3ZkkBYfsx2SAv4wy4pZHx4LYrBj/XDmFlHH//8Qe6ByblR+BT5eRDVu9Tv+FDZ1Jzq7+gscyjrIxFwV84q4d3p9YaGGOE+n008WD1GdZ/ubVKyA2EeNy/lYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LOzHq/2O; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731397556; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZYC5bpSYWv5P3qsOnKs0Y3rLvkMWTCSi3IfFbvJXsAg=;
	b=LOzHq/2OG+X8tAF0ItcO5D93f6PNh4gUSQsHNrF+CTVvzoHjXVjzigpJ2Drq9yhGwFpH60vutJ44LWDSUPlogLDQKFWFG01RmXuurH/L5oY3wHW+PronidhFYhsCic4MaoTcH+p9PnKIYOluUgPddEJEdomN60u89iPvjUaiMvY=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJGDWmE_1731397554 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 15:45:54 +0800
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
Subject: [PATCH v2 0/5] Support large folios for tmpfs
Date: Tue, 12 Nov 2024 15:45:47 +0800
Message-Id: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Traditionally, tmpfs only supported PMD-sized huge folios. However nowadays
with other file systems supporting any sized large folios, and extending
anonymous to support mTHP, we should not restrict tmpfs to allocating only
PMD-sized huge folios, making it more special. Instead, we should allow
tmpfs can allocate any sized large folios.

Considering that tmpfs already has the 'huge=' option to control the huge
folios allocation, we can extend the 'huge=' option to allow any sized huge
folios. The semantics of the 'huge=' mount option are:

huge=never: no any sized huge folios
huge=always: any sized huge folios
huge=within_size: like 'always' but respect the i_size
huge=advise: like 'always' if requested with fadvise()/madvise()

Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
allocate the PMD-sized huge folios if huge=always/within_size/advise is set.

Moreover, the 'deny' and 'force' testing options controlled by
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
semantics. The 'deny' can disable any sized large folios for tmpfs, while
the 'force' can enable PMD sized large folios for tmpfs.

Any comments and suggestions are appreciated. Thanks.

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

Baolin Wang (4):
  mm: factor out the order calculation into a new helper
  mm: shmem: change shmem_huge_global_enabled() to return huge order
    bitmap
  mm: shmem: add large folio support for tmpfs
  mm: shmem: add a kernel command line to change the default huge policy
    for tmpfs

David Hildenbrand (1):
  docs: tmpfs: update the huge folios policy for tmpfs and shmem

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/mm/transhuge.rst    |  64 ++++++--
 include/linux/pagemap.h                       |  16 +-
 mm/shmem.c                                    | 148 ++++++++++++++----
 4 files changed, 183 insertions(+), 52 deletions(-)

-- 
2.39.3



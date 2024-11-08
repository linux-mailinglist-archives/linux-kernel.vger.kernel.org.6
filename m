Return-Path: <linux-kernel+bounces-401043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D99C1552
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4C11C212FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75E1CF7D6;
	Fri,  8 Nov 2024 04:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MtYIpng6"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7E1CEACB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039214; cv=none; b=fu8Xp7DOp4rkCZaEa0hSkvolwyzXLwLopeqlpsVPdrPzZg4XdQ0mdfbIpY7p6bwIPEO1T04F1J/bgJALBCuhzx/iuYRAS3TtUjvf0Y9RpjhVNMr5oBcG6TmYG5fhrDsCMhUgJAvLSOtR0MsHudoGk4jfE9zWz9ffmWVEJkgqd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039214; c=relaxed/simple;
	bh=zVYAMOpbziW/W6wKNZDHuzrEWJWaINAHxirRiw/PToE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MS2ExwEAHwU5Z7+gBWHW+g609lcZnoDAuzk7Bpbx2Q16Cz4WQsmee9qSBDCMInjH4NqBq6i90HX5iHEvP0qhc+Hodqxdfl24/o/3GnnH/i7DQwIaA0uNl9HRTaQlP8A3oFfoHYLytSISJcl3MA5MnqF01IyCESWwmYmQCFS7Y3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MtYIpng6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731039204; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EkuPdbEJs10NbPrHB3oDX2u1XBW62xxYxS7y55GIsZw=;
	b=MtYIpng6iPQjJGg7/FFCN657t0SdNbf9ud/uGev07abrMzuhKcdG0svH88LJDK8a9QqQi15jP8rYwxL2KMdBCohQT7Q3OvbodVzK4bv02eM74Lb2wR/7ic3r8fBjze0jSGvZJYB9FYOi5VvP5UJkIE0stF8XOcQKbEy1MkUvHg0=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIxXGhC_1731039201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 12:13:22 +0800
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
Subject: [PATCH 0/4] Support large folios for tmpfs
Date: Fri,  8 Nov 2024 12:12:54 +0800
Message-Id: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
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

Hi David,
I did not add a new Kconfig option to control the default behavior of 'huge='
in the current version. I have not changed the default behavior at this
time, and let's see if there is a need for this.

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

Baolin Wang (3):
  mm: factor out the order calculation into a new helper
  mm: shmem: change shmem_huge_global_enabled() to return huge order
    bitmap
  mm: shmem: add large folio support for tmpfs

David Hildenbrand (1):
  docs: tmpfs: update the huge folios policy for tmpfs and shmem

 Documentation/admin-guide/mm/transhuge.rst |  52 ++++++---
 include/linux/pagemap.h                    |  16 ++-
 mm/shmem.c                                 | 128 ++++++++++++++++-----
 3 files changed, 146 insertions(+), 50 deletions(-)

-- 
2.39.3



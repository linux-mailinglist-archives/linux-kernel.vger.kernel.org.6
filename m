Return-Path: <linux-kernel+bounces-253852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4F9327E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C8D281C39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438D19B3D6;
	Tue, 16 Jul 2024 13:59:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F03199E91
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138358; cv=none; b=CuNGrE8aEZDPMyRNQzbdEgU3iiapWvBcjsYOUYIi6pDkdxv9VodS7fCacxzlWXfVbm8QO4Hz02llAgaCscHV7nNvJRQNrY5XXN88n1+wL/29V+eOVLWpSPlnaCXalkyUElhS8ThREYLVTkh1hEUnVLCZsBGl7R9VWC6gU4cU0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138358; c=relaxed/simple;
	bh=WLGMI5biP9wC0bAA4fv1QtHA1ydybUCxQPHQetQ9FPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSleIv4F8LC1otr4SgmHy+u9S8i7X+InWEzip1cE0F6UAmQKNmUh34nMMQcQsLHPRvfA2OiBMBsr0XIjskpv66TymgcHwfMv+4xFMEnz3i6LUi1/OAB9o+j+gBP7Q+BjBXzPIc4FJeirGc0Bousxj1luikOcivQ1biOyV6GwsrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121D51063;
	Tue, 16 Jul 2024 06:59:41 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474593F762;
	Tue, 16 Jul 2024 06:59:14 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/3] mTHP allocation stats for file-backed memory
Date: Tue, 16 Jul 2024 14:59:03 +0100
Message-ID: <20240716135907.4047689-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

With the mTHP shmem stat names cleaned up [2], we can now introduce real "file_"
stats for file-backed memory. This series does that. The stats are useful to
give visibility into how file-backed memory is being allocated. I'm planning to
build upon this with controls to restrict the folio sizes that can be allocatd
for pagecache (subject to test results that demonstrate the value).

---
This applies on top of today's mm-unstable (650b6752c8a3). All mm selftests have
been run; no regressions were observed.

Changes since v1 [1]
====================

  - Added patch 2 to tidy up shmem controls; now exposed for order-1, and not
    exposed for any unsupported high orders.
  - Simplified "stats" subdirectory management with sysfs_merge_group().
  - Added R-b/A-b to patch 1; thanks to David, Barry, Baolin, Lance

[1] https://lore.kernel.org/linux-mm/20240711072929.3590000-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20240710095503.3193901-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (3):
  mm: Cleanup count_mthp_stat() definition
  mm: Tidy up shmem mTHP controls and stats
  mm: mTHP stats for pagecache folio allocations

 Documentation/admin-guide/mm/transhuge.rst |  13 +++
 include/linux/huge_mm.h                    |  73 +++++++------
 include/linux/pagemap.h                    |  16 ++-
 mm/filemap.c                               |   6 +-
 mm/huge_memory.c                           | 117 +++++++++++++++------
 mm/memory.c                                |   2 -
 mm/shmem.c                                 |   6 --
 7 files changed, 156 insertions(+), 77 deletions(-)

--
2.43.0



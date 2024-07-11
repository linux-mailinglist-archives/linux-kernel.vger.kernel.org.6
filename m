Return-Path: <linux-kernel+bounces-248699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F2392E0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA451F2263A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8120A14884C;
	Thu, 11 Jul 2024 07:29:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D03130A47
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682983; cv=none; b=nF/ZXRZj8gIwKKF6ysuIpupclt2JT3aF+9wmzjcl5nGlJr/8m/hNKLDeeSJDqYCVW8hCwqTeOODvY38e3VWjUbXil3O1Yag71xNcniwbGS9nDJjBC30/5V1g+8/lHl1IC7d9X/slUPUJaoKDdOYPgBY44TugoR/7/I6RFiwcFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682983; c=relaxed/simple;
	bh=Ukv64mVCGG8OXe2HfpgUCo6WHgAzG8kwSGbSrZ29fNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9lG9zP5Wi6W426bj6Gsb3AOEuPxerPoY+z/FPyg9P9Xp5wDCkk45MbZK3xyaT/yUZ8XniydZz44eLu3wuDV+LYZDOpYeDYA95vnUHwCGfya0AObtbhA/7ZrRrlKN+qdBFGrxtNEJUgBRDBJ1Uh4VskGI/UodvmMxsAtKpkc5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2918E1007;
	Thu, 11 Jul 2024 00:30:04 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC573F762;
	Thu, 11 Jul 2024 00:29:37 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 0/2] mTHP allocation stats for file-backed memory
Date: Thu, 11 Jul 2024 08:29:23 +0100
Message-ID: <20240711072929.3590000-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

With the mTHP shmem stat names cleaned up [1], we can now introduce real "file_"
stats for file-backed memory. This series does that. The stats are useful to
give visibility into how file-backed memory is being allocated. I'm planning to
build upon this with controls to restrict the folio sizes that can be allocatd
for pagecache (subject to test results that demonstrate the value).

---
This applies on top of today's mm-unstable (46790522e333). All mm selftests have
been run; no regressions were observed.

[1] https://lore.kernel.org/linux-mm/20240710095503.3193901-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (2):
  mm: Cleanup count_mthp_stat() definition
  mm: mTHP stats for pagecache folio allocations

 Documentation/admin-guide/mm/transhuge.rst |  13 +++
 include/linux/huge_mm.h                    |  76 ++++++-------
 include/linux/pagemap.h                    |  17 ++-
 mm/filemap.c                               |   6 +-
 mm/huge_memory.c                           | 117 ++++++++++++++++-----
 mm/memory.c                                |   2 -
 mm/shmem.c                                 |   6 --
 7 files changed, 163 insertions(+), 74 deletions(-)

--
2.43.0



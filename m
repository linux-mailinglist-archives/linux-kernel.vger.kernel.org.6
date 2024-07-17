Return-Path: <linux-kernel+bounces-254793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADB9337A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC6BB23810
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F71CD0C;
	Wed, 17 Jul 2024 07:13:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4E1C680
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200389; cv=none; b=MebMdGUDdu/hT8rA5XVNCEMtOXECC34HZz8ahydPHke1ucjMN4NBuUqWVZ5n11K+kXiVVVJ2YUtJQaWtGjR91DJFewZ6ytUtrCJIELMmUwshRCqvdBD6d+NXMvTgq0oShAM9BZJFgk6Baf67evMPTykjaDQeP9iqd0q90i24M8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200389; c=relaxed/simple;
	bh=vS8OBRzRP/QrYMlLYVEMa8fWcFRYY54ETbzZs9LEcrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cq0zxwkqc8oXTUMdBxKmPf5OE8mAYV7t70miD2qDea+RrDb4UWF520pqKwr8OH1xHa/cOf7wjjJjO/5MoPTkkXe3F+6h7+btUNrxoeoFUW727GkpGReXy+Y+jW8JRiX2vUxfcbYbbPkBN1h7BbzIoof/FUcOcP7fqJV6VuVBjSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 431ED1063;
	Wed, 17 Jul 2024 00:13:32 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402523F762;
	Wed, 17 Jul 2024 00:13:05 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 0/4] Control folio sizes used for page cache memory
Date: Wed, 17 Jul 2024 08:12:52 +0100
Message-ID: <20240717071257.4141363-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series is an RFC that adds sysfs and kernel cmdline controls to configure
the set of allowed large folio sizes that can be used when allocating
file-memory for the page cache. As part of the control mechanism, it provides
for a special-case "preferred folio size for executable mappings" marker.

I'm trying to solve 2 separate problems with this series:

1. Reduce pressure in iTLB and improve performance on arm64: This is a modified
approach for the change at [1]. Instead of hardcoding the preferred executable
folio size into the arch, user space can now select it. This decouples the arch
code and also makes the mechanism more generic; it can be bypassed (the default)
or any folio size can be set. For my use case, 64K is preferred, but I've also
heard from Willy of a use case where putting all text into 2M PMD-sized folios
is preferred. This approach avoids the need for synchonous MADV_COLLAPSE (and
therefore faulting in all text ahead of time) to achieve that.

2. Reduce memory fragmentation in systems under high memory pressure (e.g.
Android): The theory goes that if all folios are 64K, then failure to allocate a
64K folio should become unlikely. But if the page cache is allocating lots of
different orders, with most allocations having an order below 64K (as is the
case today) then ability to allocate 64K folios diminishes. By providing control
over the allowed set of folio sizes, we can tune to avoid crucial 64K folio
allocation failure. Additionally I've heard (second hand) of the need to disable
large folios in the page cache entirely due to latency concerns in some
settings. These controls allow all of this without kernel changes.

The value of (1) is clear and the performance improvements are documented in
patch 2. I don't yet have any data demonstrating the theory for (2) since I
can't reproduce the setup that Barry had at [2]. But my view is that by adding
these controls we will enable the community to explore further, in the same way
that the anon mTHP controls helped harden the understanding for anonymous
memory.

---
This series depends on the "mTHP allocation stats for file-backed memory" series
at [3], which itself applies on top of yesterday's mm-unstable (650b6752c8a3). All
mm selftests have been run; no regressions were observed.

[1] https://lore.kernel.org/linux-mm/20240215154059.2863126-1-ryan.roberts@arm.com/
[2] https://www.youtube.com/watch?v=ht7eGWqwmNs&list=PLbzoR-pLrL6oj1rVTXLnV7cOuetvjKn9q&index=4
[3] https://lore.kernel.org/linux-mm/20240716135907.4047689-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (4):
  mm: mTHP user controls to configure pagecache large folio sizes
  mm: Introduce "always+exec" for mTHP file_enabled control
  mm: Override mTHP "enabled" defaults at kernel cmdline
  mm: Override mTHP "file_enabled" defaults at kernel cmdline

 .../admin-guide/kernel-parameters.txt         |  16 ++
 Documentation/admin-guide/mm/transhuge.rst    |  66 +++++++-
 include/linux/huge_mm.h                       |  61 ++++---
 mm/filemap.c                                  |  26 ++-
 mm/huge_memory.c                              | 158 +++++++++++++++++-
 mm/readahead.c                                |  43 ++++-
 6 files changed, 329 insertions(+), 41 deletions(-)

--
2.43.0



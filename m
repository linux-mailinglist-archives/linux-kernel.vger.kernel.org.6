Return-Path: <linux-kernel+bounces-280807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B056594CF7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB1C282F07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0402D193071;
	Fri,  9 Aug 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZABbTSJ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF115FA66
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204148; cv=none; b=tNnP2lBpnihYHwYbYVfTfuDAi5+3AqgtYWVmaITw/zUlTJvv+wposu6555JPtF7g3IBHwGg/0OcY1KHn/t/rYgrY1/CT8007ExopJXeZm7YvjyQgIwts1pTAXauFjAGuFhp7dQ152N4A1WIwhhDJn78mhuM9FT58hHOHPDz2RQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204148; c=relaxed/simple;
	bh=1o1J8Vu+Z9sKKxcoPCgjjMgniFAdKVo4MC3MNb32AIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUQ5R9XT2C5Dj4hsBqSyCcX7LWQ4EIPAoiSjl6W15jkhtwHSSvGu6hX+prCZmuXwWkCQz2ONAqTgokhnILx74qO6pdOvvnu/uUlUmgsms3OiXTczrM8zvsSXgHDuc4+JU7YwEVioJXbpyaPwfyNTBgCY40kCiYwE225RG0RCAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZABbTSJ8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204147; x=1754740147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1o1J8Vu+Z9sKKxcoPCgjjMgniFAdKVo4MC3MNb32AIY=;
  b=ZABbTSJ8JLfcHYEiygf50TNkYGU/O9+DA3lqBUpGeJkungg0F77/6hPC
   po5RhJN0DHPxvDFCCvbLY545Wb++zweBSY6Kh6HUMaDrT/JMptayi6gn1
   2tvNqe5AtbJgltvTGaSil9+FfIYcBFrEjtewviSDPOtvSeOfizmCipg9v
   LnbLLvAuYXUQcS3NxY8fANFiOIDy+tglQN19pvWbFiRIehFmgD9AmtFde
   EUT+kbLcBOApoIk83Nfr2wyumAJkTi6m84lMJ5sB9oCY/h69UCRFFIVxo
   B92Z2VOdK3NOlGDE+IesDHJpyAJn3QwjcNk7ygLSY9spECk+FtZRwV4TO
   g==;
X-CSE-ConnectionGUID: SaBwSICGRPueJ0D9EA9x5w==
X-CSE-MsgGUID: Oqtu+Mm1TSOh3b/6n/UgrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31999733"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="31999733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:06 -0700
X-CSE-ConnectionGUID: 1+AYzhGXTDiXjMiOmX9Oyw==
X-CSE-MsgGUID: PUt3CqcmTP6PUJa7xZHW5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="58108812"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 09 Aug 2024 04:49:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2277A538; Fri, 09 Aug 2024 14:49:01 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/8] mm: Fix several issues with unaccepted memory
Date: Fri,  9 Aug 2024 14:48:46 +0300
Message-ID: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset addresses several issues related to unaccepted memory.

It replaces "mm: fix endless reclaim on machines with unaccepted
memory" commit which is in mm-unstable now.

The most severe issue is a kswapd hang, which is fixed by patch 1/8.

Pach 2/8 preparatory cleanup.

Patch 3/8 ensures that __alloc_pages_bulk() will not exhaust all
accepted memory without accepting more.

Patches 4/8-6/8 are preparations for patch 7/8, which fixes
alloc_config_page() on machines with unaccepted memory. This allows, for
example, the allocation of gigantic pages at runtime.

Patch 8/8 enable the kernel to accept memory up to the promo watermark.

I believe only the first patch deserves backporting.

Please review. Any feedback is welcome.

Kirill A. Shutemov (8):
  mm: Fix endless reclaim on machines with unaccepted memory
  mm: Reduce deferred struct page init ifdeffery
  mm: Accept memory in __alloc_pages_bulk().
  mm: Introduce PageUnaccepted() page type
  mm: Rework accept memory helpers
  mm: Add a helper to accept page
  mm: page_isolation: Handle unaccepted memory isolation
  mm: Accept to promo watermark

 arch/x86/boot/compressed/misc.c               |   2 +-
 arch/x86/boot/compressed/misc.h               |   2 +-
 drivers/firmware/efi/libstub/efistub.h        |   2 +-
 .../firmware/efi/libstub/unaccepted_memory.c  |   3 +-
 drivers/firmware/efi/unaccepted_memory.c      |  18 +--
 include/linux/mm.h                            |  12 +-
 include/linux/page-flags.h                    |   8 ++
 mm/internal.h                                 |   8 ++
 mm/memblock.c                                 |   2 +-
 mm/mm_init.c                                  |   2 +-
 mm/page_alloc.c                               | 128 ++++++++++--------
 mm/page_isolation.c                           |   8 ++
 tools/testing/memblock/internal.h             |   2 +-
 13 files changed, 122 insertions(+), 75 deletions(-)

-- 
2.43.0



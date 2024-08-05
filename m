Return-Path: <linux-kernel+bounces-274838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C407947D66
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1171C21D41
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6231591ED;
	Mon,  5 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUgjEIng"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B4149000
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869993; cv=none; b=UHxqb/D32lXE0x/cXr+x+0aG2XP3VSqqg8te7rQ+rBdACAt63kTIL4JgkvaAd92VQvq7SDHA2utt5zNa2tCRH8MlUGlicQ4MFtepEgHNJ7uKfH76DvNbPPYBMz38DKaysZjis6sYaeOSFPf3EOENbPLtpshwkk4cIxx3p3mb0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869993; c=relaxed/simple;
	bh=7X435WczsEmRL6VpGibfG1L5GuZ0H8/W4kHprLJ2b3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMLv1/4NXqe9vBftW374MwA3A/BqixegdxffoFkCRAfSSVcdScHF2BQJfcjfrcXD3PqrRi48hwErE1SM3Si/8UzSyxNfxUC5HBqVjlhqT7fRc/cMQxrNaJkFWAfIbElewboDYPnjbGvhRKNW8MsVsEUncgcJtTMpU2baophQ1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUgjEIng; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869992; x=1754405992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7X435WczsEmRL6VpGibfG1L5GuZ0H8/W4kHprLJ2b3A=;
  b=gUgjEIng5/N33BHAWTVpdv1K/yqAdzvlj1+ao8HDFmaFoEaP+tu2QShp
   7PNps8mVkQvgSLTd8TdwEkeo/QmkNyrYaLeljQRz4CVw61HpOQj9FOY5I
   7Dq5GewTQtRoTu3pnGFZaMhnzKwY7VyxQUMX//WS/y03VIMDtqxETkJHj
   Z0SkIbyRzC++MaOOXFfqHjrnski05MQxiFcGKsLRK7i3gZfvl7fdlR+B1
   lmH32NR4sv5RhMqObq/jTN7JWzO3ijddDBXZs6t1cRy8A0Lv1QKpcVBwe
   w4zeWVu5bA9Fuy76frfIy3lg9I3B+/6ba7d8x4hZNAWzdoPQ8FvtjDYS/
   Q==;
X-CSE-ConnectionGUID: 7lfj+eVaQxe/sFsiohOx9A==
X-CSE-MsgGUID: K60CakPNSOasbyyCP4stMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20980931"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20980931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:50 -0700
X-CSE-ConnectionGUID: UGm1Ne6IS5WrGP2obYvY5A==
X-CSE-MsgGUID: ju1lLjKVQXKk9VIdXEcFVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61157247"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 07:59:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4B7B1144; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 0/8] mm: Fix several issues with unaccepted memory
Date: Mon,  5 Aug 2024 17:59:32 +0300
Message-ID: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset addresses several issues related to unaccepted memory.

The most severe issue is a kswapd hang, which is fixed by patch 1/8.

Patch 2/8 ensures that __alloc_pages_bulk() will not exhaust all
accepted memory without accepting more.

Patches 3/8-5/8 are preparations for patch 6/8, which fixes
alloc_config_page() on machines with unaccepted memory. This allows, for
example, the allocation of gigantic pages at runtime.

Patches 7/8-8/8 enable the kernel to accept memory up to the promo
watermark.

I believe only the first patch deserves backporting.

Please review. Any feedback is welcome.

Kirill A. Shutemov (8):
  mm: Fix endless reclaim on machines with unaccepted memory
  mm: Accept memory in __alloc_pages_bulk().
  mm: Introduce PageUnaccepted() page type
  mm: Rename accept_page() to accept_page_memory()
  mm: Add a helper to accept page
  mm: page_isolation: Handle unaccepted memory isolation
  mm: Introduce promo_wmark_pages()
  mm: Accept to promo watermark

 include/linux/mmzone.h     |   1 +
 include/linux/page-flags.h |   3 +
 kernel/sched/fair.c        |   2 +-
 mm/internal.h              |   8 +++
 mm/page_alloc.c            | 120 ++++++++++++++++++++++++-------------
 mm/page_isolation.c        |   8 +++
 mm/vmscan.c                |   2 +-
 7 files changed, 100 insertions(+), 44 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-320900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6F69711C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A39F1C2208E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA3C1B375B;
	Mon,  9 Sep 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWBcZtaE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE351B3750
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870015; cv=none; b=NyKH+LFZDIn526tkOiMrHzY6oQzpsfSn2l8Qxmx7AuCQo/JcScHdZ1+/nbjk7zQaSUp8OqMyK+pfL2x9fYZVyiL1mHGVy+KmW7DWCZkSJIDPiC5xT2ieSXTWlmm5U+YVBgk6Q8lRVJylSF8i2okwcjtzzIKDSB+d4NcGmr447p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870015; c=relaxed/simple;
	bh=X6pB2HHRIQejAr+9yLlXcbuG95AUzeNHZnMkvWYEHjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K28KmNcWKSpXb42eTewDG9kDOlkAIXBmoTBeI3tOJOe0aqD/X0iVP7ar8I2E+o8SN9/Z8InZa+8qAJCk+PQ/2o5RMXd0oJwiQEaVHMxpRPuUjnQ1IGy+2LYiXqGaJ7VWZfOJ/8G+q/YplTrKB8gG5O6MclFOCNgnqQPl2avF0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWBcZtaE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725870013; x=1757406013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X6pB2HHRIQejAr+9yLlXcbuG95AUzeNHZnMkvWYEHjo=;
  b=aWBcZtaEXRKcW5zmmc1Xw8pi8ShZJYnsX9QFdwQBD7cnQVvohl6qk5Qe
   EOMlAM6FfYlb8+iYCDGw+YpWKjAEfnsNYsSrQj8MEcFcRImcuiYpwBLB2
   Xsp2d6tssBrDG42EcaRkCSLiqPCPwh5l3a1EI1QbOppK9ykgzUV+0K8nb
   Ao4MDobslYMbvTqZ0bkNBgadJbJbsLG/izFs5BYA32E4XnLt5V04h3SBZ
   +X+Kpa0amnAqLMTdsv+mhzwSTFJ9hJ4U/EDTzKJQdOTTrfxvRGTGazMBN
   4lQwmxz+z9FnIaEtC5rEWzuGXO0xIFXfMUlUGOy35O/xM1RbO5wyC7GQh
   g==;
X-CSE-ConnectionGUID: DIS9n9cfTRSC4iioI13+Yg==
X-CSE-MsgGUID: gK9JgbWYTfaLyEXJkgk3yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35142408"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35142408"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:19:40 -0700
X-CSE-ConnectionGUID: dD8Ct4TXScmAeylJLkR5og==
X-CSE-MsgGUID: PsMRUtW4Q6+A1KLnCX4bHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66636245"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 09 Sep 2024 01:19:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 68E30297; Mon, 09 Sep 2024 11:19:36 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/page: Drop has_unaccepted_memory() helper
Date: Mon,  9 Sep 2024 11:19:30 +0300
Message-ID: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

has_unaccepted_memory() has the only caller -- cond_accept_memory().

Remove the helper and check zones_with_unaccepted_pages directly in
cond_accept_memory().

It also fixes warning with clang 18 when kernel is compiled without
unaccepted memory support:

 mm/page_alloc.c:7043:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409061101.Jlx5z2fI-lkp@intel.com/
---
 mm/page_alloc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91ace8ca97e2..7fc5af7cb387 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -288,7 +288,6 @@ EXPORT_SYMBOL(nr_online_nodes);
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
 static bool cond_accept_memory(struct zone *zone, unsigned int order);
-static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
 int page_group_by_mobility_disabled __read_mostly;
@@ -6975,7 +6974,7 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	long to_accept;
 	bool ret = false;
 
-	if (!has_unaccepted_memory())
+	if (!static_branch_unlikely(&zones_with_unaccepted_pages))
 		return false;
 
 	if (list_empty(&zone->unaccepted_pages))
@@ -6997,11 +6996,6 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	return ret;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return static_branch_unlikely(&zones_with_unaccepted_pages);
-}
-
 static bool __free_unaccepted(struct page *page)
 {
 	struct zone *zone = page_zone(page);
@@ -7040,11 +7034,6 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	return false;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return false;
-}
-
 static bool __free_unaccepted(struct page *page)
 {
 	BUILD_BUG();
-- 
2.45.2



Return-Path: <linux-kernel+bounces-280810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CF594CF81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D5B1F2293C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AF192B80;
	Fri,  9 Aug 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loxPrx2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176619309D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204153; cv=none; b=jYpAYTBWU17VvwyjTgmAzVxAtGqIjsFejj4L/wnX+Mb9GXB/IuMgFBF7HCs4e3+SLRa8ZMBHW7FAEXAvk6cK15FteY0LJsTDbvR7FMqf/oxHRpVVBO1m6Nko8cJK09HuYTpreEYCrREUClGdAyJ7kTazp8ZBEACSKC37ciI3dqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204153; c=relaxed/simple;
	bh=0wj6Qv7exseEtKqqNf9edLNjDoFKcqwOubwV0S+NfTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdP01JIORky9AudrvVR1SX38b0ijeArgMm5YhbfKPjhRrcLLQ/XaqWKvZFlhi3JlXNKkOBXzGj4fDWYvr6IvDqfo3IV3DwQDkbz5yt8iQlT5ZIaBCi6ees6FNLt/YI5Glrn+21tFGk+fGibtYm4znNY799ZhR+PbntnRWwgYPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loxPrx2s; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204152; x=1754740152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0wj6Qv7exseEtKqqNf9edLNjDoFKcqwOubwV0S+NfTY=;
  b=loxPrx2soxdki14sx6bpfJMb9sbq/c4UymUu8fhpSJCMbMD0WUhygc2p
   xDOau+qsAhPhqkW56AxdpHpUwO1eTI4TdX4EMmCVEiBnDFxbt2vmsu47v
   sgS2vLYzm19cQANZSU4FB4A/9V4h7qVk9e1C7BUpYlGSBsgkch8vMP5QX
   uulb1oUruBsf707yWhjx84TfRhNssndIHltR89S576/IJpzFALC2g2j3v
   AYq/qB3Fu63O5rbAhvGx0ANOLGCZqUah3MyKUy/XnPMk7dfzMjxaJ39v1
   gRPzprYVfR8bcOIwXKBPJSTZiwBURB7eh1dr78JcD9/DdzlJTVkFnJPC6
   Q==;
X-CSE-ConnectionGUID: qQTMyzRISNmuG8t/6yN2Wg==
X-CSE-MsgGUID: VuEuG2U2SNqhTmk8WuPQOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280309"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280309"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:10 -0700
X-CSE-ConnectionGUID: ZY8VDZEHSQ+33d93qhtE2Q==
X-CSE-MsgGUID: kj1qNfb1Q1qGIzf4Di2OXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57423601"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 04:49:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 48B0097E; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
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
Subject: [PATCHv2 3/8] mm: Accept memory in __alloc_pages_bulk().
Date: Fri,  9 Aug 2024 14:48:49 +0300
Message-ID: <20240809114854.3745464-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the kernel only accepts memory in get_page_from_freelist(),
but there is another path that directly takes pages from free lists -
__alloc_page_bulk(). This function can consume all accepted memory and
will resort to __alloc_pages_noprof() if necessary.

Conditionally accepted in __alloc_pages_bulk().

The same issue may arise due to deferred page initialization. Kick the
deferred initialization machinery before abandoning the zone, as the
kernel does in get_page_from_freelist().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f7bb885aab07..ed62ecd6775f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4613,12 +4613,23 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			goto failed;
 		}
 
+		cond_accept_memory(zone, 0);
+retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
 		if (zone_watermark_fast(zone, 0,  mark,
 				zonelist_zone_idx(ac.preferred_zoneref),
 				alloc_flags, gfp)) {
 			break;
 		}
+
+		if (cond_accept_memory(zone, 0))
+			goto retry_this_zone;
+
+		/* Try again if zone has deferred pages */
+		if (deferred_pages_enabled()) {
+			if (_deferred_grow_zone(zone, 0))
+				goto retry_this_zone;
+		}
 	}
 
 	/*
-- 
2.43.0



Return-Path: <linux-kernel+bounces-291338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF25C956107
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC4281430
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96F3A8D0;
	Mon, 19 Aug 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ji42KxEE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88812241E7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033787; cv=none; b=s4En2qyu2NWhW9i50GxtghXGG+vTPRCFcUUW327tG6KDbaGMY7GwEVHphOuXlWrJ+rQilCdg7I7dCpPeRRC2+fcdQzSYRVcJgVDLcrRqajLqN26RFAWmwAVo/bxpBrzvZ5C/EF7mI110KJ0eGlmh7kyjWFUPSS8CiiJoZKfKmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033787; c=relaxed/simple;
	bh=pCqID+ibJQzADFduLDZJx6IU2iRBnr8hLVZlnSUbIa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GChpgQVq0TgP4mu76EH0VFBwIzOMvs37cjpVpD6Q2WXuKB26l7D80jMTNOylGrJkwpx1gAbAv3HseiWW/gaqqqTzRtVCEWyaV8B1EhDWQSqDBweVN3/3czBnySowPJq1BWwZB1o1Gsd539hqHgn7jfkHX+nXdhqnoWRMl9jY+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ji42KxEE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724033786; x=1755569786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pCqID+ibJQzADFduLDZJx6IU2iRBnr8hLVZlnSUbIa4=;
  b=Ji42KxEE0LBNRE0J2WS2u0DJbJ4HEKB8LheSYEUITu6qXq/hsW94xTan
   tvc/BoxtPxue+xiKADQGGv1JUvPXBSe983SPDkhlayfvrNpSwl4mLFvkI
   djYOlLbSkMGWU2dgIBw97FDAg3HrPJe13TRXMtmvLGiz0vakRf+SgObHv
   pPHtPZG0DSC90Y6v0/O4ayldrSBfc35sIEDmZ/h+RcV835+tfbH+wT0dL
   kARMddRnV7JBsOU6iPlPBU79nbC7ausOLKgg7zipOqG1Sl5Nzx7VBe+4K
   b+LvPbUfzew/1Wo/o03Yul9dOKOcnFCOvAuiqxpPMP48PSIG3+VPqB5sp
   A==;
X-CSE-ConnectionGUID: cDtzaNE6RS2iywyUnKjnwg==
X-CSE-MsgGUID: TWWlKg/3RY+5aQiWcHhQpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="44782972"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="44782972"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 19:16:24 -0700
X-CSE-ConnectionGUID: rdbxAd1TSN20Iehf1fk1wQ==
X-CSE-MsgGUID: 2WIPODmDRpS0GbvMDmwXxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64610277"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa005.fm.intel.com with ESMTP; 18 Aug 2024 19:16:22 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v4 3/4] mm: Add MTHP_STAT_ZSWPOUT to sysfs per-order mthp stats.
Date: Sun, 18 Aug 2024 19:16:20 -0700
Message-Id: <20240819021621.29125-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new MTHP_STAT_ZSWPOUT entry to the sysfs mTHP stats so that
per-order mTHP folio ZSWAP stores can be accounted.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/huge_mm.h | 1 +
 mm/huge_memory.c        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4c32058cacfe..19d3e26eb276 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -118,6 +118,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cf8e34f62976..73b8ad255d8b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -587,6 +587,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -603,6 +604,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
 #ifndef CONFIG_SHMEM
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -633,6 +635,7 @@ static struct attribute_group file_stats_attr_grp = {
 
 static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
-- 
2.27.0



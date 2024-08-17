Return-Path: <linux-kernel+bounces-290542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06BD95557E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D63D1F239C7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6013774A;
	Sat, 17 Aug 2024 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsNhL8zk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F684A31
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723871373; cv=none; b=QWGpua7t8ujSg3LzcMn9n86Ijns1H3ccvAPrAqyMdCPrBsoI+iYHkWlL03Alk6kjwz44mK8LiggFdGHfzghIDMEc3hlqjFHS1txoqVBr4vq0gEW5f2TJF5gmNZaUYDy3W1EXzpzT/LFlI1Vj0MFONm5UbDpxOkDSjr7FqaPjKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723871373; c=relaxed/simple;
	bh=Rhd+o6cIvQZsonqH5BjtpwXRBNEn4sYl6ZxLr6ObqFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BO01vjGjpSgppYlXBoGP46I/I7OXjfS682TP3ESPjwCl2TePak9mikLPc2P9uBUabsMhuP0IitO0dbGkk62B8NjYtH+cHtTvLQfs3eEt/2TmQbRsXZxdMB/15ss7AlPHtpMcfMKqBlwkVfq9onVPBhpI4kwa5mSgTAHSD9v5mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsNhL8zk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723871372; x=1755407372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rhd+o6cIvQZsonqH5BjtpwXRBNEn4sYl6ZxLr6ObqFU=;
  b=ZsNhL8zkBlfN76rfgr0HQUP+SEPtbQ0tx7oIcjxSuKLAS2GPl0zikari
   o+dLOFYpAEq9uiu4o7A5DA7x7UELr5uSOWNH3rLCDNCGPdAMkYQIuT0nO
   VnIg3D0/21wrnSSjF+H93pONS61mpRPhDFplCYMRAbCadJzpf8Xw9w85d
   ftc6+OLehPPqQZdQP/y6i5pDVwn3Z5NorQvGFKlldnfsPzAzq0hLDtpMN
   q5risecZ0ICw0vxa3LSk8Z7+ee9MKMl4I1wafKqfGCfVKY4qVSV1tfieG
   mbYfLrdhXo0UFnw2jzCWn6TMYqj7MksDoKlhGe/bFRLHzb0GwpARhfIsX
   Q==;
X-CSE-ConnectionGUID: aNx2WiFaSKqnJxuzwFWf4g==
X-CSE-MsgGUID: U3MjBQ7ZRzid4lMdlDmN1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25929478"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="25929478"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 22:09:21 -0700
X-CSE-ConnectionGUID: ZSoOEOTiSpKi7SFuA8U4wg==
X-CSE-MsgGUID: xlveTXNuQU62fSdNy5hU2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60141498"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa006.jf.intel.com with ESMTP; 16 Aug 2024 22:09:21 -0700
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
Subject: [PATCH v3 3/4] mm: Add MTHP_STAT_ZSWPOUT to sysfs per-order mthp stats.
Date: Fri, 16 Aug 2024 22:09:20 -0700
Message-Id: <20240817050921.18462-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
References: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
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
 mm/huge_memory.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..44609d84f2dd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -273,6 +273,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..7e97b6ed6ff1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -574,6 +574,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
@@ -587,6 +588,7 @@ static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 	&shmem_alloc_attr.attr,
-- 
2.27.0



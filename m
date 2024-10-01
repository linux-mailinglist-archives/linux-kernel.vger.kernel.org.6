Return-Path: <linux-kernel+bounces-345256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E498B3B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CC3B2144D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC31BC06C;
	Tue,  1 Oct 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Be1+Yeju"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD711B9B50
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761031; cv=none; b=NpUVCZvctFk1CA/RgfNzb44dObFuOy9V1o6B8Qwqqjhown400sOinWhvzPxY1rkeDxqxVZJcXILwAY3G9F+8bKqgHNrsqZt9iYiJiDzg6jc3eQ359lTTXUVEcK0UT3xbD3xrseiNjfCvBkWs9ztkaRjOI8j9QMmBIuI35+oQ8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761031; c=relaxed/simple;
	bh=RXFigHVvqX66h0CgnEPMdbPUVdZNL13x+vDE/BJrhj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNEwB8iq34nHrDVZrMZIHJ6McR5+0u/Mj45yTyfgGOKLqJFiiCRAVq3SNldUI1KUTSf6XT357RsU9if9TU5XCPVP5VuIloYzw1DRaY0y4AbxmiS3qwsstk8PFcAk6Gg8m2ysKXaJ1vce0IiFIKEwZcw0t3nM8CURUtUjSxDSki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Be1+Yeju; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727761030; x=1759297030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXFigHVvqX66h0CgnEPMdbPUVdZNL13x+vDE/BJrhj8=;
  b=Be1+YejuQ6+pSY8wua0nZOPkZXH7Q1djpHUlVH/AsBhssl5zQ7a+CRCx
   fWEgSotZ3orib/LX5jK/0C42L011Ja009txFCqXksCr2UuJ7l/wA4S7Ag
   wxyl+s840haFz2WQFjv/qV94cUQHCVFOJbRJT+40hKTBXg/LjKclckteY
   i4S+2g71AJAyj6B7UlVbQzHaTGfuETDx0JAn3uDdPIvNi4w8WqpiFPV8q
   ali21ggtn71pEJQM21aIL3whLfz2w0mRjpRBupwgmrLHgBsfkjPjw5BKw
   aC3Kke2GnehHoiP/V6dpxgFhDPIDZ9NqZBaZxIbmuXZmPv1ujCHFrV23H
   g==;
X-CSE-ConnectionGUID: JdQ0KIhgRNG+KRSRbiNzRQ==
X-CSE-MsgGUID: fGE4abNsTkiBx0lM+fPkfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37465092"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37465092"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 22:32:25 -0700
X-CSE-ConnectionGUID: 8AwPM96ESfa4/3bCeF/HBQ==
X-CSE-MsgGUID: +JTWy565Q2O8jcvuOpSgUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73205801"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2024 22:32:24 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v10 3/7] mm: zswap: Rename zswap_pool_get() to zswap_pool_tryget().
Date: Mon, 30 Sep 2024 22:32:18 -0700
Message-Id: <20241001053222.6944-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the name of the existing zswap_pool_get() to zswap_pool_tryget()
to be representative of the call it makes to percpu_ref_tryget().
A subsequent patch will introduce a new zswap_pool_get() that calls
percpu_ref_get().

The intent behind this change is for higher level zswap API such as
zswap_store() to call zswap_pool_tryget() to check upfront if the pool's
refcount is "0" (which means it could be getting destroyed) and to handle
this as an error condition. zswap_store() would proceed only if
zswap_pool_tryget() returns success, and any additional pool refcounts that
need to be obtained for compressing sub-pages in a large folio could simply
call zswap_pool_get().

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index fd7a8c14457a..0f281e50a034 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -403,7 +403,7 @@ static void __zswap_pool_empty(struct percpu_ref *ref)
 	spin_unlock_bh(&zswap_pools_lock);
 }
 
-static int __must_check zswap_pool_get(struct zswap_pool *pool)
+static int __must_check zswap_pool_tryget(struct zswap_pool *pool)
 {
 	if (!pool)
 		return 0;
@@ -441,7 +441,7 @@ static struct zswap_pool *zswap_pool_current_get(void)
 	rcu_read_lock();
 
 	pool = __zswap_pool_current();
-	if (!zswap_pool_get(pool))
+	if (!zswap_pool_tryget(pool))
 		pool = NULL;
 
 	rcu_read_unlock();
@@ -462,7 +462,7 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 		if (strcmp(zpool_get_type(pool->zpool), type))
 			continue;
 		/* if we can't get it, it's about to be destroyed */
-		if (!zswap_pool_get(pool))
+		if (!zswap_pool_tryget(pool))
 			continue;
 		return pool;
 	}
-- 
2.27.0



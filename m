Return-Path: <linux-kernel+bounces-342313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8C988D83
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8CC1C20298
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30142A81;
	Sat, 28 Sep 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lw1e5ogQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB31C286
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489787; cv=none; b=hKXE1w1Yyda49LweQ+ylnAgD80PLSIrWDKXL0btpY5fqq06pjB4L+b3fUs9aADYz1qLDYSYsfcqz8SA1ZlstgHQyCnGSAFy3hKB9w0qBPa1z78opObHC2pcjLQHEevwKRmTHT8bj3+bFWn6+V2HtqbZsE3znYHonCSKU7WnrCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489787; c=relaxed/simple;
	bh=/WDA8F+aPpzJk3yIqLIwiWFiov3kl+WxDzwsHsiRG30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1emX7miWVZEFmiycLC3kedBToqpmA/2FDBIVvRLs4mIoxVuda0mufVc8yq3rDi0+nwKPEK9bmapxJagt+6NIkDUATwuNQxpLCR9QbTkJlU43wmeT8eBUqHfQI5FUiREm2c+Jm40gdRnrptpdhfcwsb7PIifEsDH46T8rqaIKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lw1e5ogQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727489785; x=1759025785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/WDA8F+aPpzJk3yIqLIwiWFiov3kl+WxDzwsHsiRG30=;
  b=Lw1e5ogQ09COCWG4Q3ij/cExfzmu1au+xeO/bccIRuZqlnnaVK9tzA60
   4cN2lSBdpVdfooYo1mhVVML9xpOYKcTnPDmA6omEMgvGVqLcaH4zbpDhZ
   HNoIUgVWy6Z4dSqz/CwiFiHR9IdUy5LbPxtzXLpEVu133zQrpHal81Qvl
   Jkx5iLzQbKyowCr54NVIxpXbDb66Pf3h2jXZ7BKum+74yLD9hfy4T5WuW
   U5JPzKBiyudT0ss7BnY9YTtfoTHfUC8CqMFwqmDj4unn1cfrP5EfCIQAN
   mhBxGpJ53sxNXf/Km3Cc5YSlXdPBDLf1uD1lXUaGSl86d4ffINGHeDfmr
   g==;
X-CSE-ConnectionGUID: 52O2MEFQQ4aGqwncK01rBg==
X-CSE-MsgGUID: zgoFGUyMQcCAVrilnnPsPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="29526875"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="29526875"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:16:21 -0700
X-CSE-ConnectionGUID: H4RpcxvRRyKCBU3hp5OkjA==
X-CSE-MsgGUID: hIO6QzIVRNS6vQR5jZoNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73507119"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:16:21 -0700
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
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to zswap_pool_tryget().
Date: Fri, 27 Sep 2024 19:16:15 -0700
Message-Id: <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
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



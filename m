Return-Path: <linux-kernel+bounces-344914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850098AFA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F741C22CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A4188A1E;
	Mon, 30 Sep 2024 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQfjH29b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76618859C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734348; cv=none; b=PmIIMfbSBjG2PF2skgAhkPOPpz2Y9RFyv5ulcLCqBktOExR9MU2zDG2vwgAgXSSJ1jnXvyUjyOjqSunxtzRPJbu3NUFFxeEKSds3fvSE3kON0H0yOcDvbQ0IRdJcJc1z8+gzQtFjqM6M9avTg5K/3Tix7ZHWG1ATyvK3IfDBVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734348; c=relaxed/simple;
	bh=RXFigHVvqX66h0CgnEPMdbPUVdZNL13x+vDE/BJrhj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmcEPLKkXOJMw0OHfhhUubX+s+GmweBwDTYbEV7FQOEApA1WtAYo3d/mfenMog2xbv3lVLenOUjySZp9rayAeltZCrdw7ldenQqI7OPXGC2pMKnVbNo/mxYrOllXNYiR1gxBJsy8kuqqq9EvmSRevGZ53leEaufUnNCSbe4et9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQfjH29b; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727734347; x=1759270347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXFigHVvqX66h0CgnEPMdbPUVdZNL13x+vDE/BJrhj8=;
  b=EQfjH29b+nCKO3CjieYxRtfN9HsD07cErUFxYqSoscCE1bV73oh+8SZp
   +Pj/qBMjWOa3UwMUa/sVqptj2gKEot11KRlXnsiTN2fDt7TEqlQmFGjqW
   rw1XbWM5oQcR99ocRBirBzGKCN15LQ2SCWamRfJ3x9YoAv08Neyu+6hxW
   cDByk0Xa3JTNQVxIiIkpmntuYZUJpNI95l3LP+pTJJX5lkTLhbZ7YUTox
   ZKBcQfnROLkO/l/y79TjA/9mTi640t296ybDYLeKcdoI9WE30vPKj/noK
   DAdH/D7P81klR2IZrpGIjOqW5N1pwb8cqhVGhUXvSs3xnpp/OP3t9qxkE
   w==;
X-CSE-ConnectionGUID: GrrdvxAWSKS7jnJS59i1vQ==
X-CSE-MsgGUID: utGjk7QVQw2a9g+xYYsHzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49368416"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="49368416"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:12:24 -0700
X-CSE-ConnectionGUID: hJw5AqQZTyiDIxFOb3lmSA==
X-CSE-MsgGUID: 6Tdm742SSzSKOCczqo9KXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="77985579"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 15:12:23 -0700
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
Subject: [PATCH v9 3/7] mm: zswap: Rename zswap_pool_get() to zswap_pool_tryget().
Date: Mon, 30 Sep 2024 15:12:17 -0700
Message-Id: <20240930221221.6981-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
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



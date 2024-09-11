Return-Path: <linux-kernel+bounces-324281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ECB974A90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C7C1F260DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E96139D19;
	Wed, 11 Sep 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U13N2Ppw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655F80604
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037176; cv=none; b=YYM1ACotUU5qju/bU7cCVsE+T8iGetqpgqOiIOdH+RS98TTZRFGRJuZwRjSqTQ+Z2OeyA4wAFH2Ff+JuUw3GJMFmr8uIcj8RMVbK5ceq4BSRhpXRxN9ccsv5nAHoxi4EVPPq+60tyaoLGnZ591wLUekHy15S4vTh2cADBNuo9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037176; c=relaxed/simple;
	bh=Q3PpnMMnKbBe2tGhLr5Y8UQvjMtp65YK3pg5VOQk5Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frqF/Z4ahlVtq1PKLuhOe1OH6FGJJ9J+K/bt2Q6AYAAh6Ch/8ynz7D2K9w0cgdTn9ivUmLbISn7IxD1ipgzj4SAVV/PxULIqMhTbnyaIKxazmsPvcZLX2TKv4ByOFqo/DDY0Cg3+pb0UbL8hZ+1jSHUnw3Q82mNpc95x/NZM1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U13N2Ppw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726037175; x=1757573175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3PpnMMnKbBe2tGhLr5Y8UQvjMtp65YK3pg5VOQk5Ag=;
  b=U13N2PpwWWJ9ARVgvbe/V8DjBGtANSSM9ayTKbWKJC2DmqUxN9MVb4U5
   wl16WYlDH7kX5BKcTVEPt7pOGyM2eyQ/aZE+ZHUAL95X66QtlMGB/026D
   v4dMZYsV/+sep/9M9O+HyD5wxbR7XLq3Zzv/NS3al5sSyGf3S21iBUXps
   s4PBGaWWc+iaYfkwzrsyOTZznf2dS4SVptIAi3SqjcYMrUciZMStUeQaG
   KBFZkMPCVVDdRLHdG9WruamypiFKVYAJ/EW8e2fKV07cOrylj8tk9BbWA
   o9kBNN0nCfa+l6Is4XWXN0Nnx9QgvRp6qq8BUw3dI3SY2Ea4QclET+PT0
   g==;
X-CSE-ConnectionGUID: ernaZeNfRwSau4+XhE7CBQ==
X-CSE-MsgGUID: 4lH4vjrHSICVFThBQITE/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36173002"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="36173002"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:46:00 -0700
X-CSE-ConnectionGUID: TlC0q2XjRdmz/RXKu5H2YA==
X-CSE-MsgGUID: ouEYEDaZRMK+unGJAsKkGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67771491"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2024 23:45:50 -0700
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 2/5] mm/slub: Consider kfence case for get_orig_size()
Date: Wed, 11 Sep 2024 14:45:32 +0800
Message-Id: <20240911064535.557650-3-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911064535.557650-1-feng.tang@intel.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'orig_size' of kmalloc object is enabled by debug option, it
should either contains the actual requested size or the cache's
'object_size'.

But it's not true if that object is a kfence-allocated one, and its
'orig_size' in metadata could be zero or other values. This is not
a big issue for current 'orig_size' usage, as init_object() and
check_object() during alloc/free process will be skipped for kfence
addresses.

As 'orig_size' will be used by some function block like krealloc(),
handle it by returning the 'object_size' in get_orig_size() for
kfence addresses.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 87c95f170f13..021991e17287 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -768,7 +768,7 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
 
-	if (!slub_debug_orig_size(s))
+	if (!slub_debug_orig_size(s) || is_kfence_address(object))
 		return s->object_size;
 
 	p += get_info_end(s);
-- 
2.34.1



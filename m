Return-Path: <linux-kernel+bounces-320490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E4970B39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C88281ED0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03CD12B64;
	Mon,  9 Sep 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDz1jhGK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE718AEA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845413; cv=none; b=XMty7dsgFKSzMJgWQETLJIDOJNuPgI5pKIHBc4/6Hjxbe0Xu6wIFUMEFew0mxDzqn4ZH/5H5700vVdcmikP0sD3b2punQKvoHZLjyRGXIf/EK8pwMfCWmaXKNj2rA5Go6uAhxDTgTCJnWEyY2w4gr79/8ndRn36GKg5yeqiMk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845413; c=relaxed/simple;
	bh=XQhb14NwobzgpHBJToS+EBksbjOmwkl1vy/zAbUzlvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkp/Bn7cAiuUmPpPEzfpgiauehAtCmtH6V62S9uIdOhhyJAWR5n5f4ey/R0/79a0AnpUOWAD/6dbLU4zZ97uZTKIoHEXc3FyB/8cZzaQebFntV+hXBoH/xH0A5x8CCxAlq3VmvrdrpMII2hXhsoIgHWeyRCcgqQDsWaMS3MqX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDz1jhGK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725845412; x=1757381412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQhb14NwobzgpHBJToS+EBksbjOmwkl1vy/zAbUzlvA=;
  b=jDz1jhGKJRnFkH03NhfTiJFMUEeUKuQN+DywzQYCi97G1/3rDoI9F0OC
   fchBMfq/m+xf+Fq10auRWA0nI6TYwrfQupIkZh7NntObMpNWtadoNobBP
   PMLkTXus+s2cwDuSW6xicI+FqG+1/IUfcb8oGveUV33vSKDiZisVTMhhD
   tdIcwFVTgdnZUYVlKW/I+2P1dPX9ZVVkDpVnMQWClQLtYtm88xnZpwvCo
   LeBH3YRR1WUgt2lKnYx2fGNmjp7D1af8TfhoMhDCjba2/WsNdOXqg/OdN
   yyO8qx7Iv0MMXf/6RDkX8xKcTY8jiL7fZGXW3yT8ToOmYQBzo9e+Vj4jE
   A==;
X-CSE-ConnectionGUID: QPrWmUqvRcyovYxwCx7YiQ==
X-CSE-MsgGUID: 74ZVgdGhTaqa4g5jb70Fcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28258114"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28258114"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:30:11 -0700
X-CSE-ConnectionGUID: DjU4Ii44RO+mC+79SYUM9Q==
X-CSE-MsgGUID: wZvquO98SZKlH1AaBHu3rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66486450"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2024 18:30:07 -0700
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
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/5] mm/slub: Consider kfence case for get_orig_size()
Date: Mon,  9 Sep 2024 09:29:55 +0800
Message-Id: <20240909012958.913438-3-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909012958.913438-1-feng.tang@intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
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
index 996a72fa6f62..4cb3822dba08 100644
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



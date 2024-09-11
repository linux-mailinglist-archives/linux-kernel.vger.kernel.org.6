Return-Path: <linux-kernel+bounces-324277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A437E974A88
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BA81F2686E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CDD7DA68;
	Wed, 11 Sep 2024 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgKnDlte"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F42F4ED
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037144; cv=none; b=M174e+WXmBVXvhCh7bvYthnVx9B7atv/DHSfqJpbbDuGxYF3SsWf4OQxg3fqtF6iJ1Eymy1cbM7HXUJ8OjV/8mz5qd9HbNOhwF3OYQwzYpgwdOPOEvhteDGcS0kZScA08Wy2g6rVKAwTMwongI9N3bm6gd1jXVSIRfw3qgGDiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037144; c=relaxed/simple;
	bh=Q3lqKoiLjbmmga3F3S8RdhTiuakRNQeqwNeOT2Bp6GA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TE1rChUgm2W8sTQwNLfGgFw1slE6UqpnHgRRWOwPbyWOOrpShqXQgOkVlF7pgUDkFeXofN2sw5Y+VYb8Nen/u6QsnIuTtbnj0Woa4+SAEJwboSafS6nsxWZe0q56IXF2Hrt21ybk/wtCuJSggFNOtfayUB3bdwB473iwwxVkbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgKnDlte; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726037143; x=1757573143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q3lqKoiLjbmmga3F3S8RdhTiuakRNQeqwNeOT2Bp6GA=;
  b=FgKnDltenY3/g7dBgily3xDJKs9VJre5yLtXersxUaBlmZONebJofdbW
   Vtyq6sZz7MlzNuVyeXPqFCDGZELJ1zWpVhJDQs9eoNk6nIeszZSSOGtAs
   N3MyxdOGiZ2Jszw58B/aOF+OBrFH62gUyFaHwT0miEiATDgsZCec/zPVJ
   ZdZBXKmciLaJXQ5UQ1CPz5W2ccLj3osOHYqyQ7Z6AuP0hVaFO7oQUJQA/
   Ighr4U0Ng3SMZ6zqT3Ley4Cw5bHYNn1zhwVgwyhnNU/vzAaDgkrp+c18s
   0MrkMs8kCYRqC7+SWgS5LOZglQDJfAsMjsZd9UVIUPtX0Hp0aNZhidPJK
   A==;
X-CSE-ConnectionGUID: lFgiA2QSSwa+GbTMujUwZw==
X-CSE-MsgGUID: ppy7i2XxQGKsBNqHYB7bcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36172960"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="36172960"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:45:40 -0700
X-CSE-ConnectionGUID: 7FRSoTDrQNOS2pFrzeWgDA==
X-CSE-MsgGUID: dO/k+wvZRJCKQ0Bk9A0CJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67771470"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2024 23:45:36 -0700
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
Subject: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when orig_size is enabled  
Date: Wed, 11 Sep 2024 14:45:30 +0800
Message-Id: <20240911064535.557650-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Danilo Krummrich's patch [1] raised one problem about krealloc() that
its caller doesn't pass the old request size, say the object is 64
bytes kmalloc one, but caller originally only requested 48 bytes. Then
when krealloc() shrinks or grows in the same object, or allocate a new
bigger object, it lacks this 'original size' information to do accurate
data preserving or zeroing (when __GFP_ZERO is set).

Thus with slub debug redzone and object tracking enabled, parts of the
object after krealloc() might contain redzone data instead of zeroes,
which is violating the __GFP_ZERO guarantees. Good thing is in this
case, kmalloc caches do have this 'orig_size' feature, which could be
used to improve the situation here.

To make the 'orig_size' accurate, we adjust some kasan/slub meta data
handling. Also add a slub kunit test case for krealloc().

This patchset has dependency over patches in both -mm tree and -slab
trees, so it is written based on linux-next tree '20240910' version.

[1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/

Thanks,
Feng

Changelog:

  Since v1:
  * Drop the patch changing generic kunit code from this patchset,
    and will send it separately.
  * Separate the krealloc moving form slab_common.c to slub.c to a 
    new patch for better review (Danilo/Vlastimil)
  * Improve commit log and comments (Vlastimil/Danilo) 
  * Rework the kunit test case to remove its dependency over
    slub_debug (which is incomplete in v1) (Vlastimil)
  * Add ack and review tag from developers.

Feng Tang (5):
  mm/kasan: Don't store metadata inside kmalloc object when
    slub_debug_orig_size is on
  mm/slub: Consider kfence case for get_orig_size()
  mm/slub: Move krealloc() and related code to slub.c
  mm/slub: Improve redzone check and zeroing for krealloc()
  mm/slub, kunit: Add testcase for krealloc redzone and zeroing

 lib/slub_kunit.c   |  42 +++++++++++++++
 mm/kasan/generic.c |   7 ++-
 mm/slab.h          |   6 +++
 mm/slab_common.c   |  84 ------------------------------
 mm/slub.c          | 125 ++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 160 insertions(+), 104 deletions(-)

-- 
2.34.1



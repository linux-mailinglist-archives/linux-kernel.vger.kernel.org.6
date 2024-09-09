Return-Path: <linux-kernel+bounces-320488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C5970B33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A9F281E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610210A19;
	Mon,  9 Sep 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJs0937A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC59125B9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845406; cv=none; b=MH1sKjCsZTqpuVqAWq0jDElJlcv5qz2Cf/DajsRrk6UmLGIrITVewNMOhxzmT4XdqFwDvYgD/F+kkJ3MQCFcnFKnpFWl5nlbXqgbLZvd2d687tlPifFrxqnBmq/6Od+braxaDBLbi3tsb2aWmgGnvZ23lUJW1qbJfeJIEjCTX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845406; c=relaxed/simple;
	bh=kaFwsBPUt5dOciyztfnnE0RsS7JQQKck/kQLtcflZiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iiyo20kmW1/Smwtm+8ltQI/kqa9bJ3QQg9anIeCY7FqcaOBEEU8qUfkl25XX3kK/wNjfw5L0bubCUrFUP3LEce4FgkF/nw9WwdE4CWV7GeSEKJR8NtU1V2eBe2lyxuXcmPxWQ18Pc4Ck7LRxPqwwGe1YFxOyiI0TP9l79Me9JwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJs0937A; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725845404; x=1757381404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kaFwsBPUt5dOciyztfnnE0RsS7JQQKck/kQLtcflZiA=;
  b=eJs0937A5cyU8S5IrZGbGcR+0eb9S+bilJ2ApX+EGShoOMC8UipB1RBi
   vsTibVaq0oCMWChpIoYxaMz2zq5FxjJ6nm1896yt5lKvL+OdUA4LdaHV1
   qKjJCGMACvjgbcI/v6/luBgbZS/c7ySBTZ7PK0UhSUU4ZlE4ykgFRSjrq
   qHqzohLEB1fe1JDirN+JT4nZK5ZsSv+/HkU7wlbEPQC1DNK9LlCHnJrv8
   Oc2HU22wo+CMnzeKg8ZHd4kKGb+7H6qX1udYZFA2uhIYxMLnmebVhzzXE
   pjqkKEhSzjKnVM70ofLItCAPV3QYzhT5H10ocCpkHauTNED1RniQR+wHS
   A==;
X-CSE-ConnectionGUID: iWkeT0ISQP+yq2u0q+OfUw==
X-CSE-MsgGUID: 2KaY/1f4QD6X63R5GdyhqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28258086"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28258086"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:30:03 -0700
X-CSE-ConnectionGUID: SV4/OxYHS6GhuvQL9jNidA==
X-CSE-MsgGUID: WgxXmmB/SiuN1T0gsJyu7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66486421"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2024 18:29:59 -0700
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
Subject: [PATCH 0/5] mm/slub: Improve data handling of krealloc() when orig_size is enabled 
Date: Mon,  9 Sep 2024 09:29:53 +0800
Message-Id: <20240909012958.913438-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Danilo Krummrich's patch [1] raised one problem about krealloc() that
its caller doesn't know what's the actual request size, say the object
is 64 bytes kmalloc one, but the original caller may only requested 48
bytes. And when krealloc() shrinks or grows in the same object, or
allocate a new bigger object, it lacks this 'original size' information
to do accurate data preserving or zeroing (when __GFP_ZERO is set).

And when some slub debug option is enabled, kmalloc caches do have this
'orig_size' feature. As suggested by Vlastimil, utilize it to do more
accurate data handling, as well as enforce the kmalloc-redzone sanity check.

To make the 'orig_size' accurate, we adjust some kasan/slub meta data
handling. Also add a slub kunit test case for krealloc().

This patchset has dependency over patches in both -mm tree and -slab
trees, so it is written based on linux-next tree '20240905' version.

[1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/

Thanks,
Feng

Feng Tang (5):
  mm/kasan: Don't store metadata inside kmalloc object when
    slub_debug_orig_size is on
  mm/slub: Consider kfence case for get_orig_size()
  mm/slub: Improve redzone check and zeroing for krealloc()
  kunit: kfence: Make KFENCE_TEST_REQUIRES macro available for all kunit
    case
  mm/slub, kunit: Add testcase for krealloc redzone and zeroing

 include/kunit/test.h    |   6 ++
 lib/slub_kunit.c        |  46 +++++++++++++++
 mm/kasan/generic.c      |   5 +-
 mm/kfence/kfence_test.c |   9 +--
 mm/slab.h               |   6 ++
 mm/slab_common.c        |  84 ---------------------------
 mm/slub.c               | 125 ++++++++++++++++++++++++++++++++++------
 7 files changed, 171 insertions(+), 110 deletions(-)

-- 
2.34.1



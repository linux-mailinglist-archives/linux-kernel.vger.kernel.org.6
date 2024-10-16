Return-Path: <linux-kernel+bounces-368344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765A9A0EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589821C21922
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B020E029;
	Wed, 16 Oct 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daQwXQP/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913318C920
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093319; cv=none; b=rW8l/fJe9YmVZAgyyC8elGqAcUTDWDHtJpN6LstOO5NK6iTb72cHHWxIE914FJ2KMEpeUXUQ50w0h2geRvTKa4gMKKEdhepLMIZQhJ895ihFoipKeebuChujD+9H3bUGWkvlSsaceNq1h/DG5pOkRQT1foDJOxI755gbS86Bq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093319; c=relaxed/simple;
	bh=/grc185rxLSFdU+ikEexjliKOiRIJIi6ABacyFR+WqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sF9GckcY2NEc9dxdxpZ5zUcBO2o2VwP0bhuLEaznVfAJL8ODhiAvR+SdsBquMBItiLeKGd+A1OSC6BCr+i6aS348YWCLEpezPx1E3JvsZnm5tXzERgdi+6Sk/8dHoABnRmB1hRBbpKj2VZTQndQl5atb0Do6qlu5fi18EAqg8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daQwXQP/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729093318; x=1760629318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/grc185rxLSFdU+ikEexjliKOiRIJIi6ABacyFR+WqQ=;
  b=daQwXQP/f2Key1ypklz7/84Q00hohOBd/4kP7HDmBs57EBoYJ+X+71Ja
   A40e1IDT46T1Qg9gTc1rRFBW93/LQJnHrEBZUHeM5YC343wY7/GrRjSTz
   gX9nZaCeemPmsL/Nh2Or34iqgZTT19LILI2UP4KZlzwje3jnBUFlcQE0C
   cPArndzwFcrm2ETQ8xMerqsCz6rFWotmPCprySgTd5cxRD6axHXQoGRjU
   n1ezaT/J/RcoukyM9ErMSDG55E3J+IznF3fck1CufxywLuvDfawyPNkET
   oArmqbTk7m8mzonz9dKeisqn5J1vNGgskZCX8gNd9LEYFQeK+4gSnHKAV
   w==;
X-CSE-ConnectionGUID: oGSZ8RhLRWWbE51YBgKlxA==
X-CSE-MsgGUID: W0+JBSL2S1u7hkfoWaATCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46021326"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46021326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 08:41:57 -0700
X-CSE-ConnectionGUID: Hg18HRddRDSTDV4mNZenXA==
X-CSE-MsgGUID: Ej/vS7TOQlqpQHn2zNunUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="109018894"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2024 08:41:53 -0700
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
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Narasimhan.V@amd.com
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 0/3] mm/slub: Improve data handling of krealloc() when orig_size is enabled  
Date: Wed, 16 Oct 2024 23:41:49 +0800
Message-Id: <20241016154152.1376492-1-feng.tang@intel.com>
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

Many thanks to syzbot and V, Narasimhan for detecting issues of the
v2 patches.

This is again linux-slab tree's 'for-6.13/fixes' branch

[1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/

Thanks,
Feng

Changelog:

  Since v2:
  * Fix NULL pointer issue related to big kmalloc object which has
    no associated slab (V, Narasimhan, syzbot)
  * Fix issue related handling for kfence allocated object (syzbot,
    Marco Elver)
  * drop the 0001 and 0003 patch whch have been merged to slab tree

  Since v1:
  * Drop the patch changing generic kunit code from this patchset,
    and will send it separately.
  * Separate the krealloc moving form slab_common.c to slub.c to a 
    new patch for better review (Danilo/Vlastimil)
  * Improve commit log and comments (Vlastimil/Danilo) 
  * Rework the kunit test case to remove its dependency over
    slub_debug (which is incomplete in v1) (Vlastimil)
  * Add ack and review tag from developers.



Feng Tang (3):
  mm/slub: Consider kfence case for get_orig_size()
  mm/slub: Improve redzone check and zeroing for krealloc()
  mm/slub, kunit: Add testcase for krealloc redzone and zeroing

 lib/slub_kunit.c | 42 +++++++++++++++++++++++
 mm/slub.c        | 87 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 105 insertions(+), 24 deletions(-)

-- 
2.27.0



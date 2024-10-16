Return-Path: <linux-kernel+bounces-368345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 591FE9A0EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC088B2198F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAD920F5BB;
	Wed, 16 Oct 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub8EXjkf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A020F5A6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093325; cv=none; b=WCK1uCn5BsA50d4YeXColy/GU3dzsNo9Aa9/h7BVRWoLsHblq+pEO7QwMkOWm+fzgbXyo6Z2JVvU5iqWVkCmpfQzl9W971Jru1q89H48VupMe0Ua9KlfjCSPUIklpmpDwIpdoawT0tyaXtmsiVzSd4aypu0n6G7kgkpu0nD/igk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093325; c=relaxed/simple;
	bh=1yohiX8Mia2wqWhVgM9lhouT0M30SjIN3hnB+Hq2y3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2v8GgFOUKL3DNTjhrnLAmUarceDAH6NRdeAicwcHnlTtCfiM/CG5pwFZ/0UKOX7jGtb3dj2TcEuXc6qVaCMHfJdnFB9mpcaAgzkPthySPeGXdtkOkrOR3Huezd3OXOUd8YG0FOkjB1Sm878U8kDUcLp9riOGZy+Xk2vSl5QNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub8EXjkf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729093321; x=1760629321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1yohiX8Mia2wqWhVgM9lhouT0M30SjIN3hnB+Hq2y3E=;
  b=Ub8EXjkfy0zoiUfR4IL2j6LuO2K/NIcQskBfFi9G71uMIEV8nP2o4kkY
   5HpQ9qjyqu6eqtoZvYdptPiVpKvaY90mJUeyQh6N1z79YtcbOGsaHwuQh
   8Yl2vWAlFaoNCpqBk30bUJh+NNjhxgD8b2Y+RaKBi0iHK3c9DcePgZzmd
   8nmVpArYT+DqEmkeXQVQ8n+mCfL02qI0G+SjIl2AlPRPG0OGgBwGv8K1X
   M3lGunRt16VLDRbIChIKv+dDt3NSOVcVzUQwDj6/yMsHdjJc/hxZ6FQrz
   I4EGp8YWH7aVe39taDis7/HvG/MQF3hpe61aWxZXGGohkz89+v1tYV/m+
   Q==;
X-CSE-ConnectionGUID: wXESo4/CS+SiGJyS/ARBQg==
X-CSE-MsgGUID: 03KJrPNiTo+qnEkWDwqcYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46021342"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46021342"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 08:42:01 -0700
X-CSE-ConnectionGUID: +cn8A2teRjqp+D+KyviP2Q==
X-CSE-MsgGUID: 8UoO9yu/TrqGqxq22dttoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="109018906"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2024 08:41:57 -0700
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
Subject: [PATCH v3 1/3] mm/slub: Consider kfence case for get_orig_size()
Date: Wed, 16 Oct 2024 23:41:50 +0800
Message-Id: <20241016154152.1376492-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016154152.1376492-1-feng.tang@intel.com>
References: <20241016154152.1376492-1-feng.tang@intel.com>
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

But it's not true if that object is a kfence-allocated one, and the
data at 'orig_size' offset of metadata could be zero or other values.
This is not a big issue for current 'orig_size' usage, as init_object()
and check_object() during alloc/free process will be skipped for kfence
addresses. But it could cause trouble for other usage in future.

Use the existing kfence helper kfence_ksize() which can return the
real original request size.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index af9a80071fe0..1d348899f7a3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -768,6 +768,9 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
 
+	if (is_kfence_address(object))
+		return kfence_ksize(object);
+
 	if (!slub_debug_orig_size(s))
 		return s->object_size;
 
-- 
2.27.0



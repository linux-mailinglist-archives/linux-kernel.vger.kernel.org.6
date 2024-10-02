Return-Path: <linux-kernel+bounces-348027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319998E1AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA10B273F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B021D151E;
	Wed,  2 Oct 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzCLFgVD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F41854
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890331; cv=none; b=mxOx+nFwWNUm3nb3D0WlkAoVVAYu+4qpjB/aRFZ7S+JrkBPCq/KWaK9/eBVdyl7rJrqzD//1mxNR6dSIpmxKI8Cq80OftZRl+Wr8C3N2a0jWpj9NxGGsgofEfKomd6Bc17Eo9A9WKFOTj0dRRswCMkXo7XJb/xICo072OXH1WGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890331; c=relaxed/simple;
	bh=I33o0xVmYyUdjVeqsNLlOpesXSnvzz1G93m9pm4UFxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s9W37FcvFZ4d9RmMd6xCPrekBlnBIE162uZl+HkIrfHKxSh/tzSbqwVBJAj47jfIwFspbDZWjRG6rKDjfUCG/h70U48+3I8RHU3hshDT9QvoasLfyMMIYb7HxqAzdmYLYYyPV/OmKprS4cS5apMY7Um4hu52LiBVHGTeEVS/aS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzCLFgVD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727890330; x=1759426330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I33o0xVmYyUdjVeqsNLlOpesXSnvzz1G93m9pm4UFxs=;
  b=lzCLFgVD+seYtRvjQaUUc0NXBU3QvJtk2slw5d0djdZ+dBJdcYVwYRXz
   xt+KgExtlCK25Mjkf8TzadtPFY7bYQFCTWFb5aH/Dv0fbvhdHWPj26YO3
   dlH2TdKRLG83WdWST+Y+iVGOdX9BU/QjSGmJXtfvJ1RB4Viy1hG5YT9hO
   Pu9F+7x6u/rVyL54mKzZuYlV5gwy0L5Iqtncs7Fi1kZPlm2m4tpwggCmv
   8mShH7NDxk/Z4xC3QQrKctmitWml+74q44oxZsUcU/PLJMX8Wv2d5U312
   nycxd7ksayc1L8nccS0RjE9q2284Dkq1gd2+fqcYRm2joncNneHQuf2gk
   A==;
X-CSE-ConnectionGUID: eg+Pk5+DQxO7POiebSeAGw==
X-CSE-MsgGUID: 06vtOGmoSs2D2ndDzq85yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30860414"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30860414"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:32:09 -0700
X-CSE-ConnectionGUID: 5Z0VmGfXSJKNoyLROl76AQ==
X-CSE-MsgGUID: w1X6BDA0TPKcpMd1nwjiPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="104854948"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa001.fm.intel.com with ESMTP; 02 Oct 2024 10:32:08 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1] mm: zswap: Delete comments for "value" member of 'struct zswap_entry'.
Date: Wed,  2 Oct 2024 10:32:08 -0700
Message-Id: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Made a minor edit in the comments for 'struct zswap_entry' to delete
the description of the 'value' member that was deleted in commit
20a5532ffa53d6ecf41ded920a7b0ff9c65a7dcf ("mm: remove code to handle
same filled pages").

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 09aaf70f95c6..c3e257904b36 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
  *              section for context.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
- * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
  */
-- 
2.27.0



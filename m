Return-Path: <linux-kernel+bounces-446763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A79F28DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DFC1885420
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121E315852F;
	Mon, 16 Dec 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sea4W1Fm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A2219FC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734320498; cv=none; b=nIyDcjx3FvDGzkdDHe3/r7fQXjOrEEZ7n9A9/AfFR/Gh8nCIypmrK8hN9nxauplZChqKJGbPRvMSdhP1oAJjFtJFYH0tMHx+fqPxkykzE3uH6Yt25/i6l6VPQ7FJnasuPyNymMsTN07N6Yjd7cGH4eL5cLvPUuo/8Ar6bnCSs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734320498; c=relaxed/simple;
	bh=UxrO/dxoV1TqrOkh2j5DR4ODWbCM2/uyXJREJrXqwJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URKQKEmdqe4b5mxIdfl6x4WAETq4uCmYJ/JiRaH/3BDsBVyJfWfA2Na7FV3jEuoejcakYdZ5CPnjtXkzruIpbUjLuS0Q0wSBhpIMquO59IXotZW7N8ymIS1+PVE9Ib26OyWKQSnuLJgRSDSWEghxYU/L23ElHK/WjGDEIs6uNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sea4W1Fm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734320496; x=1765856496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UxrO/dxoV1TqrOkh2j5DR4ODWbCM2/uyXJREJrXqwJI=;
  b=Sea4W1Fm70zHqBHgFdWSOFy8TGw2sUNtyvUWWpOW2APFzVYDQNgX2M55
   JNGIZabexOUVmaMVy3na4soTvxg6pTVMNTDgYY+iL+3iq3+cCWssco21a
   MZ367Zl2S6ovn/2A/B1W+1eKAgDT9Z/1NdZi4BZoQN/KgFfbKU4pchvkn
   5xruYGD1JEB8PUy6GCvTqMaj+E2xNyNPU2HSwVh9ltSls1ULYq8nTEmZE
   v5DIUY84GOE+oRrLEShac5ORQ91rQ4AQ5oJRnVhmbFLwahZKTZsF6fpYE
   f0XKuZNI1VknyfDvjQGAW63/7hqkOMPj9YQMtpsuJJIb3zPlAx8WYG8y6
   g==;
X-CSE-ConnectionGUID: DtLXF6K8TnigcUMD+iNqnw==
X-CSE-MsgGUID: PcTqq1epQDylN48b6BZt2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="45302025"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="45302025"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 19:41:36 -0800
X-CSE-ConnectionGUID: P4jW3cMWS7u531Rj08mkCQ==
X-CSE-MsgGUID: LUrZTns3SkmdAlFWxMPrTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97127154"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 19:41:33 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	yi.l.liu@intel.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
Date: Mon, 16 Dec 2024 11:38:09 +0800
Message-Id: <20241216033809.170366-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache tag invalidation requests for a domain are accumulated until a
different iommu unit is found when traversing the cache_tags linked list.
But cache tags of same iommu unit can be distributed in the linked list,
this make batched flush less efficient. E.g., one device backed by iommu0
is attached to a domain in between two devices attaching backed by iommu1.

Group cache tags together for same iommu unit in cache_tag_assign() to
maximize the performance of batched flush.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/cache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e5b89f728ad3..726052a841e0 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -48,6 +48,8 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 	struct intel_iommu *iommu = info->iommu;
 	struct cache_tag *tag, *temp;
 	unsigned long flags;
+	struct cache_tag *temp2 = list_entry(&domain->cache_tags,
+					     struct cache_tag, node);
 
 	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
 	if (!tag)
@@ -73,8 +75,15 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 			trace_cache_tag_assign(temp);
 			return 0;
 		}
+		if (temp->iommu == iommu)
+			temp2 = temp;
 	}
-	list_add_tail(&tag->node, &domain->cache_tags);
+	/*
+	 * Link cache tags of same iommu unit together, so consponding
+	 * flush ops can be batched for iommu unit.
+	 */
+	list_add(&tag->node, &temp2->node);
+
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 	trace_cache_tag_assign(tag);
 
-- 
2.34.1



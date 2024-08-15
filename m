Return-Path: <linux-kernel+bounces-287581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37395298B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907DB286BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E616198E71;
	Thu, 15 Aug 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8JhGG0C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCA17A597
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704813; cv=none; b=BYt0uRP2+WUEYWmtVsOfHyx/tf7rEpDPyx6MP8j0/r6KweNq34ThE8Uo4kFhao2NRDjeSUPS/Vk39zp2CVWYrTQBi0D6rBfHhGl0BShYecaUijbA/0IntxiMEKeShomm50CgiiKBrb0/XooQHYLEArKmsKs8R+j3Xtk61x9009A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704813; c=relaxed/simple;
	bh=LfGSL2s3OqRer5h+/wGQYpRy+Iut/M0xOkkSLN974M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mv+z7Q2/Ke3dp1v0lIGP3nfmsFDeECnmYip3rsKyBRsfUM2Tn8L0M3Zpk9XmSlqMRRWJXaPdfFLuQgdaeBWWUWlwvDxc6pQzT8Aa+PDdkh0Wr3cr0/wIyIytJVfMDNzB8tJpXOoPyWUZD8PrWcEIYouQzhIJqVK/zqXwWjH9SQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8JhGG0C; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723704811; x=1755240811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LfGSL2s3OqRer5h+/wGQYpRy+Iut/M0xOkkSLN974M4=;
  b=I8JhGG0CymNM3irXhfmMiZEQIHvQqL4w/ob/J6f0uluirf/kZ+yGOea7
   DK97PCyD4Swl9JskjS8YLxjpKv4OW4pZrDrF5WMphiwm/7N89KDQhU1Ah
   p+Gspi1U1mX1xFFVPC/uVTWRwGUFE+EzbK3oOSalz5IVD5nT4SZv2PS1D
   RRqlTMZwRPUabaYy7tm7Lb7Qot9EHKvYbZC+hqux+hxWjSrPVuZoPPAZ7
   r3uBu/kpUhKVs5y1H8M5iMeKRg1uLY/7K0vwVKqyGVtwIWvKnuX+Acnje
   vNz0c+3ZX0C0UPsGMGjlaH8R3HTj7eHCwMGUwhmG9xeYL/F5XUpXETXYD
   Q==;
X-CSE-ConnectionGUID: qZZGGaIrQmS7i0IXvrbsPw==
X-CSE-MsgGUID: Kgr6YmibRleuakgJUG20yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32528290"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32528290"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:53:30 -0700
X-CSE-ConnectionGUID: bUACLD1mSDCgVXMOcQCgTQ==
X-CSE-MsgGUID: 3XMDrh4bQxWgbZc3PNHQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="82471574"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2024 23:53:29 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 3/4] iommu/vt-d: Add qi_batch for dmar_domain
Date: Thu, 15 Aug 2024 14:52:20 +0800
Message-Id: <20240815065221.50328-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815065221.50328-1-tina.zhang@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduces a qi_batch structure to hold batched cache invalidation
descriptors on a per-dmar_domain basis. A fixed-size descriptor
array is used for simplicity. The qi_batch is allocated when the
first cache tag is added to the domain and freed during
iommu_free_domain().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/cache.c  |  7 +++++++
 drivers/iommu/intel/iommu.c  |  1 +
 drivers/iommu/intel/iommu.h  | 14 ++++++++++++++
 drivers/iommu/intel/nested.c |  1 +
 drivers/iommu/intel/svm.c    |  5 ++++-
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 08f7ce2c16c3b..21485c86e7381 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -190,6 +190,13 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
 	u16 did = domain_get_id_for_dev(domain, dev);
 	int ret;
 
+	/* domain->qi_bach will be freed in iommu_free_domain() path. */
+	if (!domain->qi_batch) {
+		domain->qi_batch = kzalloc(sizeof(struct qi_batch), GFP_KERNEL);
+		if (!domain->qi_batch)
+			return -ENOMEM;
+	}
+
 	ret = __cache_tag_assign_domain(domain, did, dev, pasid);
 	if (ret || domain->domain.type != IOMMU_DOMAIN_NESTED)
 		return ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 14020414af892..cde5ed4d0fede 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1586,6 +1586,7 @@ static void domain_exit(struct dmar_domain *domain)
 	if (WARN_ON(!list_empty(&domain->devices)))
 		return;
 
+	kfree(domain->qi_batch);
 	kfree(domain);
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 74634805abd19..d21eca94cb8f9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -584,6 +584,19 @@ struct iommu_domain_info {
 					 * to VT-d spec, section 9.3 */
 };
 
+/*
+ * We start simply by using a fixed size for the batched descriptors. This
+ * size is currently sufficient for our needs. Future improvements could
+ * involve dynamically allocating the batch buffer based on actual demand,
+ * allowing us to adjust the batch size for optimal performance in different
+ * scenarios.
+ */
+#define QI_MAX_BATCHED_DESC_COUNT 16
+struct qi_batch {
+	struct qi_desc descs[QI_MAX_BATCHED_DESC_COUNT];
+	unsigned int index;
+};
+
 struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
@@ -608,6 +621,7 @@ struct dmar_domain {
 
 	spinlock_t cache_lock;		/* Protect the cache tag list */
 	struct list_head cache_tags;	/* Cache tag list */
+	struct qi_batch *qi_batch;	/* Batched QI descriptors */
 
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 36a91b1b52be3..433c58944401f 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -83,6 +83,7 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	spin_lock(&s2_domain->s1_lock);
 	list_del(&dmar_domain->s2_link);
 	spin_unlock(&s2_domain->s1_lock);
+	kfree(dmar_domain->qi_batch);
 	kfree(dmar_domain);
 }
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0e3a9b38bef21..3421813995db8 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -184,7 +184,10 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static void intel_mm_free_notifier(struct mmu_notifier *mn)
 {
-	kfree(container_of(mn, struct dmar_domain, notifier));
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
+
+	kfree(domain->qi_batch);
+	kfree(domain);
 }
 
 static const struct mmu_notifier_ops intel_mmuops = {
-- 
2.34.1



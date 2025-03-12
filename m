Return-Path: <linux-kernel+bounces-557945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A98A5DFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD78174021
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7E24E011;
	Wed, 12 Mar 2025 15:01:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580EB139CE3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791697; cv=none; b=lOD+vpGrf6MOEZvwAywkmatnXSgw9sQz3yYMMoqlntQPpZhHKZZS0sz8+bq3bMRRuuYXnaja94pAPFo/oi53sZ7HzhOP6o3PtKM1ux2uyVrWU3BN0TBmD3I4Ix3TnvKm29PYjbT25fPS+AuBHlQkfoAne+TG9O0D/U4POAn8+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791697; c=relaxed/simple;
	bh=6IHehec40qCsWmemmMPCEWYYN1ipc033hnVyk21xAxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RsRcsryFqfWEjvj/HfdKt6mpuDlfuWN1KfiTY1N4EzWiyDay0sqSMbgD8uuv4PitgjLDrHHHzlbCF/aN5mqQ5+rkAtuDDuI9F243tBjWTCYq4vBSY6zqLiFp75Np1Ank3l0Mje9lrzvMIvDvk0SA6TYOYkkdb/SAI9UT4lmoZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 725D61515;
	Wed, 12 Mar 2025 08:01:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08E593F5A1;
	Wed, 12 Mar 2025 08:01:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baolu.lu@linux.intel.com
Subject: [PATCH] iommu: Don't warn prematurely about dodgy probes
Date: Wed, 12 Mar 2025 15:01:31 +0000
Message-Id: <72a4853e7ef36e7c1c4ca171ed4ed8e1a463a61a.1741791691.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The warning for suspect probe conditions inadvertently got moved too
early in a prior respin - it happened to work out OK for fwspecs, but in
general still needs to be after the ops->probe_device call so drivers
which filter devices for themselves have a chance do do that.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c6d40abe577e..15a6b3c59ba6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -437,12 +437,6 @@ static int iommu_init_device(struct device *dev)
 		ret = -ENODEV;
 		goto err_free;
 	}
-	/*
-	 * And if we do now see any replay calls, they would indicate someone
-	 * misusing the dma_configure path outside bus code.
-	 */
-	if (dev->driver)
-		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -565,6 +559,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	ret = iommu_init_device(dev);
 	if (ret)
 		return ret;
+	/*
+	 * And if we do now see any replay calls, they would indicate someone
+	 * misusing the dma_configure path outside bus code.
+	 */
+	if (dev->driver)
+		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
 
 	group = dev->iommu_group;
 	gdev = iommu_group_alloc_device(group, dev);
-- 
2.39.2.101.g768bb238c484.dirty



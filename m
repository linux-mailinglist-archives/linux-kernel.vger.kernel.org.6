Return-Path: <linux-kernel+bounces-350821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D1990A14
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082F81C2221D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413B11C3021;
	Fri,  4 Oct 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fmxRHCZu"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622621E378D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062624; cv=none; b=lW+JJLTZqUJbV6cX45PbBSMB5zA3zwhw2RSfS81lr+O6qcPeN+H6tCGoe3aeawHKcTzwmYQLgeAu2ro7rfMCLZ+XUcRMzLH86+hFe0G/wJ/6WHbTzC9/hnT4SkBoATxtpRiaZMpxEWD3ZzqDk8OnSvF10jdrDzSpIK7LjZluwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062624; c=relaxed/simple;
	bh=fgHaoikfsRBStlU0bGSvmpaGxBdQYiG8RsEgE0RudNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiXdHIjGOiu/w2ZBzXDgjfDNdAEyCd0HGBQTYI0z5OUk3uq6jnKyfsSGkLJQLX27jhRA9/zeEDEGeJfdduraW8jH73ptLIsGQ8vvmD28iJdePWW0pH7Gpo/UGC1KvD9xCxN5RIa443CsGo6gUCagYFv/4rHAZ07dG52Ahc/mhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fmxRHCZu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.176])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA01720DB372;
	Fri,  4 Oct 2024 10:23:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA01720DB372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728062622;
	bh=1YbPP75pGZfs6660HAPrOyUhcs0kb5K2kzLWLPdt6zM=;
	h=From:To:Cc:Subject:Date:From;
	b=fmxRHCZuzH3vOlH8LRH2P74niodZNV++3gBPU4pKo5uPmtrefCfQExxbgeuJF+EHL
	 +Px8cKn/RNyoY5j9ymRA0W4pkrb9kzLfMd7A8I+RXQvLLyxRp8wGscNchK62UAqS/6
	 Yhf6xvmbUd8wFvGRO7F3BMGmAuAC0dZzPJY5o/bU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Russell King <linux@armlinux.org.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen Haonan <chen.haonan2@zte.com.cn>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
	linux-kernel@vger.kernel.org (open list)
Cc: jacob.pan@linux.microsoft.com
Subject: [PATCH] ARM/dma-mapping: Disambiguate ops from iommu_ops in IOMMU core
Date: Fri,  4 Oct 2024 17:23:31 +0000
Message-ID: <20241004172335.386904-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The architecture dma ops collides with the struct iommu_ops {} defined in
/include/linux/iommu.h. This isn't a major issue, just a nagging annoyance.

Rename iommu_ops to arm_dma_iommu_ops to disambiguate and better match the
other architectures. No functional changes intended.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 arch/arm/mm/dma-mapping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 88c2d68a69c9e..51b5319e8f519 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1510,7 +1510,7 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
-static const struct dma_map_ops iommu_ops = {
+static const struct dma_map_ops arm_dma_iommu_ops = {
 	.alloc		= arm_iommu_alloc_attrs,
 	.free		= arm_iommu_free_attrs,
 	.mmap		= arm_iommu_mmap_attrs,
@@ -1680,7 +1680,7 @@ int arm_iommu_attach_device(struct device *dev,
 	if (err)
 		return err;
 
-	set_dma_ops(dev, &iommu_ops);
+	set_dma_ops(dev, &arm_dma_iommu_ops);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
@@ -1734,7 +1734,7 @@ static void arm_setup_iommu_dma_ops(struct device *dev)
 		return;
 	}
 
-	set_dma_ops(dev, &iommu_ops);
+	set_dma_ops(dev, &arm_dma_iommu_ops);
 }
 
 static void arm_teardown_iommu_dma_ops(struct device *dev)
-- 
2.43.0



Return-Path: <linux-kernel+bounces-556392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6FA5C64A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19FB189B8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7C25F960;
	Tue, 11 Mar 2025 15:19:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE4725F7A4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706374; cv=none; b=GvXsVEM2MRak4GzyA8BNntl2Od2bVyR3Pliu/yIcy50alQEHBH9frvtzz3Hsi+D3Xon68WRO2j4lj7bFftxjzGWi6RzWEBCYNG8mZrpAIZDa8cy+CfdpPSwuPWrB6/BvrMJrkXROwF629Nqz2vCKguc5eHkZ4hUmwjBInNJmL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706374; c=relaxed/simple;
	bh=gJWQfmISO6ERM+tVeKhihrJylxXq8bhx0BWJ8FnYsqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q97qGhFHkL0N180c8Ax4xwtiEFgHagS5JsbiLRrfQjryZCbYfSFoQy55Bh2UyUs07rrSgx2QIRyNTyQeuy51szwAHPPtf34D0Kuqt9SJRdnWI4nKDcnoSkcHqCbUJgnmdbcCsVQPYWXU5pW/8uw8dnlAtD1iKOeGbYnzXab+atA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D4CE152B;
	Tue, 11 Mar 2025 08:19:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49C043F694;
	Tue, 11 Mar 2025 08:19:31 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH] iommu: Avoid introducing more races
Date: Tue, 11 Mar 2025 15:19:25 +0000
Message-Id: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the lock-juggling is only a temporary workaround, we don't want
it to make things avoidably worse. Jason was right to be nervous, since
bus_iommu_probe() doesn't care *which* IOMMU instance it's probing for,
so it probably is possible for one walk to finish a probe which a
different walk started, thus we do want to check for that.

Also there's no need to drop the lock just to have of_iommu_configure()
do nothing when a fwspec already exists; check that directly and avoid
opening a window at all in that (still somewhat likely) case.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
I was rather expecting to send a v3 of "iommu: Get DT/ACPI parsing into
the proper probe path", so I'm grateful that v2 was picked up, thanks!
This is the difference as a fix/squash commit instead.
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d824fa5166e3..c6d40abe577e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -415,13 +415,15 @@ static int iommu_init_device(struct device *dev)
 	 * is buried in the bus dma_configure path. Properly unpicking that is
 	 * still a big job, so for now just invoke the whole thing. The device
 	 * already having a driver bound means dma_configure has already run and
-	 * either found no IOMMU to wait for, or we're in its replay call right
-	 * now, so either way there's no point calling it again.
+	 * found no IOMMU to wait for, so there's no point calling it again.
 	 */
-	if (!dev->driver && dev->bus->dma_configure) {
+	if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
 		mutex_unlock(&iommu_probe_device_lock);
 		dev->bus->dma_configure(dev);
 		mutex_lock(&iommu_probe_device_lock);
+		/* If another instance finished the job for us, skip it */
+		if (!dev->iommu || dev->iommu_group)
+			return -ENODEV;
 	}
 	/*
 	 * At this point, relevant devices either now have a fwspec which will
-- 
2.39.2.101.g768bb238c484.dirty



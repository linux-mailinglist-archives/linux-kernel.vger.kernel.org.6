Return-Path: <linux-kernel+bounces-207902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7684901DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1828548C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D4F82498;
	Mon, 10 Jun 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5ixajlR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80570823C8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009961; cv=none; b=jjkceryJs/2ZrFsPIOA+kaxES+VtbHfaRlSsHfdyVyNKAulme4hVNBlteRjutoF8MZhPwnTSru6lk/iNo1SiN2kdOARGsQjs04K6KEyGwCZrLWLfenw6WipbAKM89LRRTYvcTLToc1GBaSPW61WdIcpBdhxiX80lAzj4ugj5i18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009961; c=relaxed/simple;
	bh=kDJcZN33ntEvZZurzXrpsoEVgCNzk8vicnqImPO/kUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYPRzqpta1+6Hp9hwHhQM4DVpNLt1jJAvjUcev9QVUux8oh+tPBGspnx3W/wc1vcb8HymmLkLbMb+0CuTyzQjUur9xhMbht+Xkwx2xzcNs8+U4ffl/hmdH5GpAXq8GhnNEp18L+uf4xPD79MIS4G7wNnQ3vhUgC67RC4TTjmSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5ixajlR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009960; x=1749545960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kDJcZN33ntEvZZurzXrpsoEVgCNzk8vicnqImPO/kUg=;
  b=d5ixajlR0VlEDAD6p0Trd1HWwg/4Sbfztg9worcJAzO8YDfzHnxb3Y5k
   s61SUUaRqBL49HF/pGhwZznQJlLTeI+tsZNFRoxLNrxDpGBNXBjX6Ix7m
   l3wee7jXg9tCmbobH+UCUyRlQIgQtILlKZbth2hBz0j+X7YV70+zW6ZlG
   M8i/ueETI0KBA1kG0eDjEzLXZglEl5wJ+RfwSlFoX+5LRHXKM+IgIPVEO
   WWELbQkISUvlUC0XgyNgxukbCeBkF78ZLBQGU26IABHSRbt8fTgtoIaE1
   zu0nmZIk5xvLiAC+SltQHO8DhZyXt9UuVJB+8hrqwlWYKUP7G0qG/+Kj4
   w==;
X-CSE-ConnectionGUID: yR8fbHLPQ4GQ6EGhOw9ZjQ==
X-CSE-MsgGUID: FsyRLOtBTU6RW2SjUzGmsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581797"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581797"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:18 -0700
X-CSE-ConnectionGUID: NfOkwSpKThicZbLMfICvvA==
X-CSE-MsgGUID: AQGFlrAZSA+rn/BX4z4/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432718"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 12/21] remoteproc: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:46 +0800
Message-Id: <20240610085555.88197-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommu domain is allocated in rproc_enable_iommu() and is attached to
rproc->dev.parent in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f276956f2c5c..eb66f78ec8b7 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc *rproc)
 		return 0;
 	}
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain) {
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain)) {
 		dev_err(dev, "can't alloc iommu domain\n");
-		return -ENOMEM;
+		return PTR_ERR(domain);
 	}
 
 	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
-- 
2.34.1



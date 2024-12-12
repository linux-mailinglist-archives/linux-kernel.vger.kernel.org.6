Return-Path: <linux-kernel+bounces-442499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F02B9EDD82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EA9188A65C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC11304BA;
	Thu, 12 Dec 2024 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzlHaoH6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60DA2A1CA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969832; cv=none; b=aOJOQZE33IwIN4EZ/IjLc6Sn9C83EorINe3SF8RsLPf0nuqTkrXbNJh4UVtUCZtNQjROFIEJFd7USq38UTc8N2sTeK3/D/60b8uXkbFLgi++KoMK287Ou/k3m/ap91yQ/GNpJwdp0dsTZ6Oavivx7JUHXX/7YwKTiKYZ15gSWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969832; c=relaxed/simple;
	bh=Kq6/fEnAxpqAtJaALn2RzgIOhJL5MZj63K/gz0fiX7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2qnbnzucSCNCEtXueTrN0cWshLvLVYvG+8oylOeSlXr1bNXFmYd3RcpuTonFOL2tK0PXaHOoBMYMR4f/4HHwIZ3isr2LXUC93Q0isQlvdBTwIc8o13f1XTXEJI34G2ZjevLSPsssCwPBmcShI1iCRAPa39922Bt+8y3gqYhWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzlHaoH6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733969830; x=1765505830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kq6/fEnAxpqAtJaALn2RzgIOhJL5MZj63K/gz0fiX7Y=;
  b=PzlHaoH6uSUEDDhuhd3+O+HVBVWgl5bRjNp+iAYOX5lCBN8t2uOYwWA5
   r/Rq9Mxh85zIM+WfjBdxfJ3/Oqv2toO2buqDB6tBCwK7dSGFIjAgX1isF
   WfKfzzi78L8dflA/ydXM3M+fKsXuW/LE/7joXlF7YVLrnvQqOij0ttdEo
   omMUr2UymE44oooef2igIk292aEdCmNJgAGKLdnFi2AKrzftyVXaHS4+R
   g6xmYNyri37sGZu6fnRGvow5BGEBBqiERJDleS04BCAn9OxLy5nBWc0vI
   if7cjQrNsctbUFP2dt54oLW84zTbnl3v+cDZ7TofkfpyOag0PU5Ex0E5K
   A==;
X-CSE-ConnectionGUID: z9sInKqTSZasD8RCjdANcg==
X-CSE-MsgGUID: /IwKPq/9RUawduX64H5mVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33687012"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="33687012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 18:17:09 -0800
X-CSE-ConnectionGUID: VCQut5AORZm3f/yeSAbYTw==
X-CSE-MsgGUID: Wr68SmgLQyeGPSxrSiJ34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96866320"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa008.jf.intel.com with ESMTP; 11 Dec 2024 18:17:07 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Avoid draining PRQ in sva mm release path
Date: Thu, 12 Dec 2024 10:15:29 +0800
Message-ID: <20241212021529.1104745-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PASID is used for SVA by a device, it's possible that the PASID
entry is cleared before the device flushes all ongoing DMA requests and
removes the SVA domain. This can occur when an exception happens and the
process terminates before the device driver stops DMA and calls the
iommu driver to unbind the PASID.

There's no need to drain the PRQ in the mm release path. Instead, the PRQ
will be drained in the SVA unbind path.

Unfortunately, commit c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain
removed from RID") changed this behavior by unconditionally draining the
PRQ in intel_pasid_tear_down_entry(). This can lead to a potential
sleeping-in-atomic-context issue.

Smatch static checker warning:

	drivers/iommu/intel/prq.c:95 intel_iommu_drain_pasid_prq()
	warn: sleeping in atomic context

To avoid this issue, prevent draining the PRQ in the SVA mm release path
and restore the previous behavior.

Fixes: c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from RID")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-iommu/c5187676-2fa2-4e29-94e0-4a279dc88b49@stanley.mountain/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0f2a926d3bd5..5b7d85f1e143 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -265,7 +265,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
-	intel_iommu_drain_pasid_prq(dev, pasid);
+	if (!fault_ignore)
+		intel_iommu_drain_pasid_prq(dev, pasid);
 }
 
 /*
-- 
2.43.0



Return-Path: <linux-kernel+bounces-401810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9119C1F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13441F260CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6CA1F4FDD;
	Fri,  8 Nov 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dh7NHJMO"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07311F4FC1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076640; cv=none; b=EQOLgyGplNiJc4TabUe2A27phUlbbg/wvWr1pfaOKp1oFK4cFCDmQxYCL0prq3kqF8Pul/y3eu913w9BaxZdmTyCWtzdfHs0+cdhPZFQS09H7PbNTfoFu00e7uCjtQ7lI7pAOemw31fYCgNRitzdNqbazbbaxuyfWEpL72KSYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076640; c=relaxed/simple;
	bh=1A34qr/APEC80riqfQKTvRpRMCkPJxNtskfpCbTb0wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Te7n05eec+mGcVMu85zZjaZRXgnu6Go4hSS59HWVFDjTU2EbqnyV2HIMTAKh2Gm0WUuj8pkxei265ndvjfXmiW2XCBDkpcqiKVfU1hJNecoTlULGEDo12w1cOUUp+CoZSpHWaRv3iilGBQIiCjow1s1sXgLnnMHL30TcFlrLjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dh7NHJMO; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731076634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puMK3tZ6hX81FClc+8KRmHVrx6kvND1x2bgZSkomJhE=;
	b=Dh7NHJMOoT/k5c5YYk+R8acRm+PFutkIehud0L1v/wUCXkEzklRXPa1fVJY0D7wxA7PuLd
	PpwHal/CxzP3fSefKEO3qpZNhEKfILHqDmrNVJWItXTUZcwsFamT7wPmEz00UNeJccr4Zk
	CRiiZJPrpzYsvzEs88jNTKQvcSm79xM=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 2/2] drm/etnaviv: Remove the etnaviv_iommuv2_ensure_stlb()
Date: Fri,  8 Nov 2024 22:36:58 +0800
Message-Id: <20241108143658.2229786-2-sui.jingfeng@linux.dev>
In-Reply-To: <20241108143658.2229786-1-sui.jingfeng@linux.dev>
References: <20241108143658.2229786-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The etnaviv_iommuv2_ensure_stlb() function have been replaced by the
etnaviv_iommuv2_ensure_stlb_new(), remove it.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c | 24 ----------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
index fa6eed1ae1be..65b91eabb278 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
@@ -113,30 +113,6 @@ static void etnaviv_iommuv2_free(struct etnaviv_iommu_context *context)
 	vfree(v2_context);
 }
 
-static int
-etnaviv_iommuv2_ensure_stlb(struct etnaviv_iommuv2_context *v2_context,
-			    int stlb)
-{
-	if (v2_context->stlb_cpu[stlb])
-		return 0;
-
-	v2_context->stlb_cpu[stlb] =
-			dma_alloc_wc(v2_context->base.global->dev, SZ_4K,
-				     &v2_context->stlb_dma[stlb],
-				     GFP_KERNEL);
-
-	if (!v2_context->stlb_cpu[stlb])
-		return -ENOMEM;
-
-	memset32(v2_context->stlb_cpu[stlb], MMUv2_PTE_EXCEPTION,
-		 SZ_4K / sizeof(u32));
-
-	v2_context->mtlb_cpu[stlb] =
-			v2_context->stlb_dma[stlb] | MMUv2_PTE_PRESENT;
-
-	return 0;
-}
-
 static int etnaviv_iommuv2_map(struct etnaviv_iommu_context *context,
 			       unsigned long iova, phys_addr_t paddr,
 			       size_t size, int prot)
-- 
2.34.1



Return-Path: <linux-kernel+bounces-395481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE19BBE83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034C71C2110C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9C1D31A2;
	Mon,  4 Nov 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MxMUUdvX"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E81D4324
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750660; cv=none; b=up8IpMC8t5yaHo0iJ/hA2W4NHyFwMi1uKdnl87Re9C3j4bX8J7W41qAQ7viLdHW9J3i++uVHm8Giwx7+XPCGAQv8CP6AfhAy8iS+a2Wt+aWwVCqNZKfNMWmNHgKfItTVwffVE0A95vYL8PCFo4UAeIeU8g75ro/6O9TZeQ6e4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750660; c=relaxed/simple;
	bh=vN8WJL6gCebeft0hTPZTd7oA0FPQi9OEojwwTsZ86mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z4umwQ9PObvmLB48sc+wmtJLpw2IOxLW5K7HnQ2n22MgiAU6KnCHd5002gcsQ8RuDH4mvpiRyI9IIsfmu4sxWuHIuSw0lTAQv7XnS1rUjtI0bwB01nszdYMcovDCiLlXILo6+obvPLXae87yAMrbQkScPck/PxGCR/N27O3xXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MxMUUdvX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730750656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap8kfns4e0QzWlHcRchP0CB0jDssm0nIfPQZQM5uY6E=;
	b=MxMUUdvXRP8ULES+/xmT/L4Q70mtUkTb/nb0vQC46GxLEq5UVRT/iNZW0D2IG6LGIreX41
	xiAODPKtPhzT/YmwYfHOD9w7PbyF7Kemi6kPB1rnMjPq3B3dXXIIDyc7wEF79nJGcqlFzI
	UILx1Gt7bCbMwaeinYTxk+GRX7bNEqE=
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
Subject: [etnaviv-next v2 3/3] drm/etnaviv: Improve VA, PA, SIZE alignment checking
Date: Tue,  5 Nov 2024 04:03:54 +0800
Message-Id: <20241104200354.656525-4-sui.jingfeng@linux.dev>
In-Reply-To: <20241104200354.656525-1-sui.jingfeng@linux.dev>
References: <20241104200354.656525-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We only need checking the alignment on the upper caller function, if those
address and/or sizes are pass the check. Those address will certainly pass
the same test under the etnaviv_context_unmap() function.

Remove redundant alignment tests in etnaviv_context_unmap() and move the
alignment tests to the upper caller etnaviv_iommu_map() function. Which
reduce some extra overhead.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 05021848126e..56ae2de76e15 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -19,12 +19,6 @@ static void etnaviv_context_unmap(struct etnaviv_iommu_context *context,
 	size_t unmapped_page, unmapped = 0;
 	size_t pgsize = SZ_4K;
 
-	if (!IS_ALIGNED(iova | size, pgsize)) {
-		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%zx\n",
-		       iova, size, pgsize);
-		return;
-	}
-
 	while (unmapped < size) {
 		unmapped_page = context->global->ops->unmap(context, iova,
 							    pgsize);
@@ -45,12 +39,6 @@ static int etnaviv_context_map(struct etnaviv_iommu_context *context,
 	size_t orig_size = size;
 	int ret = 0;
 
-	if (!IS_ALIGNED(iova | paddr | size, pgsize)) {
-		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%zx\n",
-		       iova, &paddr, size, pgsize);
-		return -EINVAL;
-	}
-
 	while (size) {
 		ret = context->global->ops->map(context, iova, paddr, pgsize,
 						prot);
@@ -88,6 +76,14 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context,
 
 		VERB("map[%d]: %08x %pap(%x)", i, da, &pa, bytes);
 
+		if (!IS_ALIGNED(iova | pa | bytes, SZ_4K)) {
+			dev_err(context->global->dev,
+				"unaligned: iova 0x%x pa %pa size 0x%x\n",
+				iova, &pa, bytes);
+			ret = -EINVAL;
+			goto fail;
+		}
+
 		ret = etnaviv_context_map(context, da, pa, bytes, prot);
 		if (ret)
 			goto fail;
-- 
2.34.1



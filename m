Return-Path: <linux-kernel+bounces-385335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295879B35BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21092811C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D71DED62;
	Mon, 28 Oct 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VRVTOLDM"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F721DE8B7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131574; cv=none; b=bv2lW2L9bRGYNemte5uh4mMLsHsvf+RCQ2fz2jwN7o7Pah6pkqFgwm+n0qlpqKJVQAgakbgadYRtHV2eCqvO4nd/TlaYI4Cy9WAQj7sWzzDdTnePYNWe+kQ354ZTASbEpz+aGA+e1jHemL3txgS/YWLZnoj9O29zBHUKcz3QGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131574; c=relaxed/simple;
	bh=2dSjKxth56J35iXDn7ng8V2GgE4VBo26H1/nY40YFA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAF02r8ek4x8H4iYwFqtd/ft8tsYaU99D/BHCCMyBD1iLgztm0h+E/R1csuNk4OmdC5+X7B9znlxgSuknoOpUTO6b+Q374aZeC8VAknrNX3AF+O1TDjP1riTBwgOtqz+mgU/NDsq/pKh+/LUqqEy0/9TClIYg566Am7diWkBO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VRVTOLDM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730131570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fgCoZ4y8qaSWJDKKpZIzzsuVRy80/hcDc4rWHf1ZQg=;
	b=VRVTOLDMo6HNt4BGNxUImZTt1Xb2NCdCwPIOTa539wo2OUqKTlX5ysy4s2eWAAJGWNnvSc
	6uMk0SAsQKR0z0OYWRllvzWjMewpTWRIWt/9AXaaW/ZvKNsaU6eTZWTYsLCq8sFQ25qiQD
	Tn7Vv55bk4uC0sSf5kzK4OadFSPT8qI=
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
Subject: [PATCH 2/2] drm/etnaviv: Fix the debug log for the mmu map/unmap procudure
Date: Tue, 29 Oct 2024 00:05:55 +0800
Message-Id: <20241028160555.1006559-2-sui.jingfeng@linux.dev>
In-Reply-To: <20241028160555.1006559-1-sui.jingfeng@linux.dev>
References: <20241028160555.1006559-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The 'iova' variable is invarant within one invoke of the
etnaviv_iommu_unmap()/etnaviv_iommu_unmap(), which means that the
debug log always print the same GPU virtual address while mapping
or unmaping.

Made the GPU virtual address being printed increment with real GPUVA
being mapped or unmapped.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 4ee9ed96b1d8..f6c997c459ca 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -83,7 +83,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
 		dma_addr_t pa = sg_dma_address(sg) + sg->offset;
 		unsigned int bytes = sg_dma_len(sg) - sg->offset;
 
-		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);
+		VERB("map[%d]: %08x %pap(%x)", i, da, &pa, bytes);
 
 		ret = etnaviv_context_map(context, da, pa, bytes, prot);
 		if (ret)
@@ -113,7 +113,7 @@ static void etnaviv_iommu_unmap(struct etnaviv_iommu_context *context, u32 iova,
 
 		etnaviv_context_unmap(context, da, bytes);
 
-		VERB("unmap[%d]: %08x(%x)", i, iova, bytes);
+		VERB("unmap[%d]: %08x(%x)", i, da, bytes);
 
 		BUG_ON(!PAGE_ALIGNED(bytes));
 
-- 
2.34.1



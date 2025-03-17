Return-Path: <linux-kernel+bounces-564173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59972A64F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F807172052
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD323BD1F;
	Mon, 17 Mar 2025 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="dacbRXwo"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B11239082
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215385; cv=pass; b=Sm/Pdgffp/HLZxglvImSc4qei+AgV75PZFyLsf8gnMY1p/prno/QBKby1pFjo26Cx5h7d0pVDP+EPoSGosanYIIiPrO+gQkuorHf6lAd9gjwZd9C0wK7z+pibXXCgaYR/HMCHcwzCtToJ+wATFDQ4Sk8ddHqT/firO3h+lz2FUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215385; c=relaxed/simple;
	bh=p++KVk3Fw8pgMe8xXWu7SiuG6QOWrS2JQmXG3WQYqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn19wuAHRlSFzmc61gn2sQO009DowkvW4haPeEjWSxhGBRkVr+1xb3K+TDUngE7qu0whF/zEhLFCjgtqWk/5PIymtvpBU1gu5PEwFAOJPfLJ7Du1xDtdiWRiGxxRomI5athTrtathoWBOGEKkjWZd1AFx4qv3TM2XFgduOJTPPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=dacbRXwo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742215365; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UtHINESV9YTxkr2/+vQCTAHdO++gSSJqmLPXPlChJocg7K4mPsmNo+YchOX0/sOv6tafgqypUTd85z8PaSrKJ2ZKqo85eUmD+dsjaB2jEQX6cZzO4LFb6cIwCJKssGeEW6trgH4JgsEaTTOnX7/Fg8wsJiOlIo5/G8t/t3IAocw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742215365; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ghqsESCSlYDpPWVp7MysrBKDg3K0+nOb0GO49Q1Vkh8=; 
	b=e8hbFK0BobAV181EI8/EYUCHTnPIcEXROL4Wweo/5RrY6yey2t92I1c2DeJrw4pL/6evsBlunxNsykHfa1KCpx5uaPob6D5rZQGxdere786IsWXvrxUNHK/H1iNE+4qiw0ff2Jgbmn6BY1R92bNVz5P1TKI2ByNYguaE2+8+gg0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742215365;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ghqsESCSlYDpPWVp7MysrBKDg3K0+nOb0GO49Q1Vkh8=;
	b=dacbRXwo2UICmQD7zrje2dDVP8xDaUYCZgquBXUUIRxpoOrbT0RCWx7jDWyD4jXz
	uXcARvBD1xL88K8qyAO4qYMLfSgAdTdrzdwoA4zSZMVgmVWqQfzHqjtg4cQusYBvIQD
	pI3t9IBDdPD2RPWZUGi6AuD8Hu1s0jsjZ/wyhZNA=
Received: by mx.zohomail.com with SMTPS id 1742215364198105.23374534580853;
	Mon, 17 Mar 2025 05:42:44 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	angelogioacchino.delregno@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v3 1/6] drm/panfrost: Set IOMMU_CACHE flag
Date: Mon, 17 Mar 2025 09:40:39 -0300
Message-ID: <20250317124044.16257-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
References: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Panfrost does not support uncached mappings, so flag them properly. Also
flag the pages that are mapped as response to a page fault as cached.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index b91019cd5acb1..9e6f198ef5c1b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -327,7 +327,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	struct drm_gem_object *obj = &shmem->base;
 	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
 	struct sg_table *sgt;
-	int prot = IOMMU_READ | IOMMU_WRITE;
+	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
 
 	if (WARN_ON(mapping->active))
 		return 0;
@@ -528,7 +528,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		goto err_map;
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
-		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
+		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
 
 	bomapping->active = true;
 	bo->heap_rss_size += SZ_2M;
-- 
2.47.2



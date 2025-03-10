Return-Path: <linux-kernel+bounces-554993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BD3A5A444
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A3189358E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F461DE3CF;
	Mon, 10 Mar 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="XI445Uks"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACB1D6DC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636821; cv=pass; b=tjaaUw4b4koSPghSqphJGE3ZdQmT3bBrIFQzT+Mez4MIRpyZI1zfL6ccEErRMjLNfR0m3D6Ar4rt7I9zUtlteiEmk74CYCwAKYJpJ6zhFSAvza1dHYcjLChCThRPLww+xfXNFZvu66/bfS4iQzP5k1Szt2ihNJ6zU5sHrDSPsow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636821; c=relaxed/simple;
	bh=icVzu0P56YexPcBpsrn3nRweSxvIYRZleDuf27NcNAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zzow2CCrpmgoEJ+v+mzcD3zwWbrK3M1pMjb9Gdv+WYE+IYxz0rxEVAUoE256pJXfN/4QlH1X4c/Ki0rg8V8gRsEcZz6GU9wkZ96ZSWNmDcsY7O7a4yTRQ00nqxuRShIjwRugRfwkH9c4nu8OeSStk26s7Y82//4/LesTX3RUozY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=XI445Uks; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741636795; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dTbDcDa5VbZ+n/fO3/EG23vIfbAUbjH25Kvi/6G6UUkf9B43GNk7v0B7XujY+vgRKc3ULX22Xv3G4igq7lXUoOo/WQurSmKjK3HqG6bV+YDybro145U301lWUoF7vXQeAvx2aiZvFlAHswL8uk0nZO+XBJlTBQNCkkKvLNutkgw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741636795; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zCHAjF0Z7uci82elReH6b009mfaaTOtclxm2AxNJYSk=; 
	b=Zor3RI1wzM02pifNC+UKbVhP3LMu419DTQ6JeJaQXGI5c4XaYrBC2B0SdsNGfsgCc9DWhMS20zCfTKuJjtATdDv3exkFIJFd3q9Oc1gPKBLQOgPlYFUqAGEowUm8IT8x/gHOSohvzqJXBFjhlgnfa1tPcqB5XElnEQPPwu38eRo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741636795;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zCHAjF0Z7uci82elReH6b009mfaaTOtclxm2AxNJYSk=;
	b=XI445Uks/5ycTftE+M/lmMubk4qJ8c0Uwss88U2YMIF6ZD4lb49GiMzzbHjg7q8R
	BfE3kRH59JTzpaClDZF2aD5Nt9r2z2fDIv7Nxje+yCiBZlZwIurfowMnOcwedYI8EQ7
	8Y7qkXZXIlQThT8OIqSbQU4Jp4371e6FP0p7cY3s=
Received: by mx.zohomail.com with SMTPS id 1741636791693559.3943284745002;
	Mon, 10 Mar 2025 12:59:51 -0700 (PDT)
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
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v1 1/6] drm/panfrost: Set IOMMU_CACHE flag
Date: Mon, 10 Mar 2025 16:59:16 -0300
Message-ID: <20250310195921.157511-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
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



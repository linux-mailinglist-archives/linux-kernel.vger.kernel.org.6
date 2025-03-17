Return-Path: <linux-kernel+bounces-564414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BDA65475
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE85170CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2892451F1;
	Mon, 17 Mar 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="V1PXNDfx"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301DE245036
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223317; cv=pass; b=s1v9dS3KP/rGUz/T1sm8aIvc8VBvXN5nFikxiHR6Cu0NaIutJNErhKMqeVlkm21HGHg2CaTzxDbpepqyWtKdw+EG1myOnQXGLXzmPrW/OEt7C2UeDSuGmo4Q29rIRuHqOakI2rg4o1zBpTZh1BbVxJhFwz2htkTJDMCGllvF2IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223317; c=relaxed/simple;
	bh=p++KVk3Fw8pgMe8xXWu7SiuG6QOWrS2JQmXG3WQYqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw6XbKk9Db2iJTD8txRw+6Nq1+cQWvBMJcM7gia7ScqhfZnI7BkoFJ7rCR1wjChDKK1fQyMkdCyv/2YJAxB9aQ9VOyw3RRKalzBv1B9Ev1Ul6S/EmOw31vwl3J193bwNxnv1rOhyuYKAj235rvyTde2HFmY5NxIxIpGVsHtxWOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=V1PXNDfx; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742223281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dYXXGQQjsfNskKNzVqrsKLtbHXhDUpN4fipplacHGiUzDBJod+GA1ymIghAbNon5ua1Zo5T4BIkd0DKy/jqZskFcD5bd2lcjgux0mDaA3G/RAIF3HfH+Enho9nqeoNR6t07UTC6HaO8nWMCilus0ntqPuunaqBAYshdKQZ2rvuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742223281; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ghqsESCSlYDpPWVp7MysrBKDg3K0+nOb0GO49Q1Vkh8=; 
	b=PYVFp119xTy9IZvjO3S4RvqTBMZlNgEA7urYyVJXPjwcYoas6GbDfINSBNMDp7UYhJkSdrPdjuRdbBU74jPWqN3674QD89IwCEl2gfW7VdtZc0JfvPKW6i2vKc/kwcvYh3CUmpIknqVcSp/olMszoXPYgZz3EUgUr8xE6xot5YM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742223281;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ghqsESCSlYDpPWVp7MysrBKDg3K0+nOb0GO49Q1Vkh8=;
	b=V1PXNDfxm8wyHzYvS0jE/ZfNXLgxUCSr3ha3eE4G8O7l3ih0tHsBbbOBSmP8oTXP
	ua3Wm9kknci7cqbWpndkEr67E+FbOlXzgRLf8h2/sCbUyd4XdP6KcP7sKOHq5BbdZm2
	aGyH9H1wpYstlFGmzvGyi3Ahe3iA8YWp8Sv8BlEA=
Received: by mx.zohomail.com with SMTPS id 1742223278617649.9613964999113;
	Mon, 17 Mar 2025 07:54:38 -0700 (PDT)
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
Subject: [PATCH v4 1/6] drm/panfrost: Set IOMMU_CACHE flag
Date: Mon, 17 Mar 2025 11:52:40 -0300
Message-ID: <20250317145245.910566-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317145245.910566-1-ariel.dalessandro@collabora.com>
References: <20250317145245.910566-1-ariel.dalessandro@collabora.com>
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



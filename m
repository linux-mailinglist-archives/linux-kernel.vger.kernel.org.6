Return-Path: <linux-kernel+bounces-564174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E9BA64F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F61C16BB64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A223AE96;
	Mon, 17 Mar 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="DKNPygum"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07975239082
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215390; cv=pass; b=MR4ZIUKPyQiNlXSdoWStLA2OgorFzgaAETvRThmXlEQjCEw+bbstniAqgkoMmY8QxKRoPguSr7sUL9UUr382ROz8cQ++1Ht1gWXHR3fBN/8MxbMZ3+8yeQPHkhOGIlD42h0SfpdJQXzM6VWUneupWY1dhNsCerWvAoKJp508TyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215390; c=relaxed/simple;
	bh=gHVTeA8ZKBzXQJtxC6nUm9Sao4M4+5Gwf69LjvsllNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/mhDCGekcuauRzypb0u5cUnYRu3tAwkBGDEnH/QWwb0UB2hN++HyDEQSgsLpcEnVC1a59rWoQ4S4gEVjUwnGoiWlO2pMyEKaBX6iR5rDGNolJUOjUInjBa8T8o9NNH8jZjnasgEn+k0hoVtL/lM942x+ZJs9JcuybOQ1H1cz44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=DKNPygum; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742215371; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G8DDGbZ+IlF2b9695W1hwupMzkb9Nucy0zawdFDixib1lDthguQXS4PKV1maLLqou6GbXcRYg2dvoM2oxg3z/iae3D5OSkqPYwRntcX1j5mKnhcYe0O6AzdEAm+2c6WxrIq3sjahjaeIw0CijrtR+s50O+KkltgkKHzflE/Wk+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742215371; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/36wnDksYJenqr18EDga6w9FrfsLJVGTJJNpjssiTcY=; 
	b=As8jHquR7mRhjmOpRolwTj0EWi0tUAdxULCg0wQoo0EcG9FKI39ugqBRLF8XjuNzjx3Af1HPZlN/fcT5sJmB58LnbpyXHpBZNAXWX/b6O8nl8Doc5fWjI2DIKAHPzIUFyLpkgKa9pJ1SH9smRtIqqTp+TzO0TLtM26sQ7qqvwfQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742215371;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/36wnDksYJenqr18EDga6w9FrfsLJVGTJJNpjssiTcY=;
	b=DKNPygumuknEnDxNzRQ9b77EvexjWFjQx6761bVGX4fg1E6LVXRzqWQ16LWDVvBu
	6ZtgaI8P5URVSe3iXzAFJSaW7DHobmCOoEC7WQeQydtUaRGgbw6fmTGm0v1WJgKNRJB
	kHc9SDeqv3o4rD8kFdltoot7BcGQvQjMFxGZfeJc=
Received: by mx.zohomail.com with SMTPS id 1742215369726449.59679267388674;
	Mon, 17 Mar 2025 05:42:49 -0700 (PDT)
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
Subject: [PATCH v3 2/6] drm/panfrost: Use GPU_MMU_FEATURES_VA_BITS/PA_BITS macros
Date: Mon, 17 Mar 2025 09:40:40 -0300
Message-ID: <20250317124044.16257-3-ariel.dalessandro@collabora.com>
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

As done in panthor, define and use these GPU_MMU_FEATURES_* macros,
which makes code easier to read and reuse.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c  | 6 ++++--
 drivers/gpu/drm/panfrost/panfrost_regs.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 9e6f198ef5c1b..294f86b3c25e7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -615,6 +615,8 @@ static void panfrost_drm_mm_color_adjust(const struct drm_mm_node *node,
 
 struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
 {
+	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(pfdev->features.mmu_features);
+	u32 pa_bits = GPU_MMU_FEATURES_PA_BITS(pfdev->features.mmu_features);
 	struct panfrost_mmu *mmu;
 
 	mmu = kzalloc(sizeof(*mmu), GFP_KERNEL);
@@ -633,8 +635,8 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
 
 	mmu->pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= SZ_4K | SZ_2M,
-		.ias		= FIELD_GET(0xff, pfdev->features.mmu_features),
-		.oas		= FIELD_GET(0xff00, pfdev->features.mmu_features),
+		.ias		= va_bits,
+		.oas		= pa_bits,
 		.coherent_walk	= pfdev->coherent,
 		.tlb		= &mmu_tlb_ops,
 		.iommu_dev	= pfdev->dev,
diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
index c7bba476ab3f3..b5f279a19a084 100644
--- a/drivers/gpu/drm/panfrost/panfrost_regs.h
+++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
@@ -16,6 +16,8 @@
 #define   GROUPS_L2_COHERENT		BIT(0)	/* Cores groups are l2 coherent */
 
 #define GPU_MMU_FEATURES		0x014	/* (RO) MMU features */
+#define  GPU_MMU_FEATURES_VA_BITS(x)	((x) & GENMASK(7, 0))
+#define  GPU_MMU_FEATURES_PA_BITS(x)	(((x) >> 8) & GENMASK(7, 0))
 #define GPU_AS_PRESENT			0x018	/* (RO) Address space slots present */
 #define GPU_JS_PRESENT			0x01C	/* (RO) Job slots present */
 
-- 
2.47.2



Return-Path: <linux-kernel+bounces-564412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCAA65471
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D24A18944BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931142459D5;
	Mon, 17 Mar 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="CuOvvq35"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9E24397A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223309; cv=pass; b=U4QYIOpcKM3llLZoxHesSRrcDZ6zcHIj2w6cCsIuaSEC7IsiOYnuFKi4scRVX4dvfwNicrJiPgZNyEES7eM1qq1rhAzNkLXDfSsLoHoNXXUXQekzrpNc7RN0U6q+PSEVpXghwD5hPfvYMuH0X2Zy3qOCh3Qmdkt5yMsoQIPcNbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223309; c=relaxed/simple;
	bh=gHVTeA8ZKBzXQJtxC6nUm9Sao4M4+5Gwf69LjvsllNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFre1EOFUKnG6ifm2jwmqEG5EvUB8++8ceNKLi0/xoshq08u4T+dbrR0hRXawVr8xQs0ZPLt2Jq4CRO1WTuwF3B5Q8LsEvZj+H1G5i34/aaJgToiEO1Uffn0Pr6FjE9JI2Euzx+kfu+yYr5vKkHemHJZVtGU5x6SV4mzXDi8RSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=CuOvvq35; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742223287; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OTSg/VC2IGga6wDSSNvyVK/Xmjg+hUW1YRb4w27FyEinA0QlN0hozBlg4TTygJdO6DZGMhhOeDCCLlZPDJJUbjqrsW/SyWP5ha3XilYHFoow4eqt2uO1HB5ZNHFjENmBXo2rLpe0xN9qlpMvILg6gbyOuwzwEyuq2GWUmdqjA4E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742223287; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/36wnDksYJenqr18EDga6w9FrfsLJVGTJJNpjssiTcY=; 
	b=H2zA7WCgXkM2Cezbua7rNecG0myfsyvSL6R6GFlvEVhZzYw70lCf6QQqbE/l+sczZoTSQeeeWUtFJ35aO/WnNZZV+JgO388TOIzT8b/5W5N0pjab6+s6pL81Fp/tjcZvLV7Q8jvIE1lKDQkHJAFhemgXc56OCMuH6wEcBYEM4p8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742223287;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/36wnDksYJenqr18EDga6w9FrfsLJVGTJJNpjssiTcY=;
	b=CuOvvq35QjzOPELMyDcL4nxs1MfcloU97Xivbii8B68wmIhiERaYHjtbqopQhMHR
	3ZFYk9D9y9eyiOBACh6sJfAXG1CLevr7/cdRQHoVcdgDdJy3tL052v28bT3GXxjljsG
	i5gf3NwWHdDr144Ov9ZYYbZ7N/ALXxdbyIXhancA=
Received: by mx.zohomail.com with SMTPS id 1742223283714299.71380915725615;
	Mon, 17 Mar 2025 07:54:43 -0700 (PDT)
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
Subject: [PATCH v4 2/6] drm/panfrost: Use GPU_MMU_FEATURES_VA_BITS/PA_BITS macros
Date: Mon, 17 Mar 2025 11:52:41 -0300
Message-ID: <20250317145245.910566-3-ariel.dalessandro@collabora.com>
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



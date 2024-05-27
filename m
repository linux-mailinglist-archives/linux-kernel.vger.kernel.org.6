Return-Path: <linux-kernel+bounces-190316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027B8CFCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1581D1F24342
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD9139D12;
	Mon, 27 May 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GRHZOFIy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024413A3E1;
	Mon, 27 May 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801923; cv=none; b=XdbdhWOgcZPecEhq8U+BFdCgCF1lokWZevXF8vwCBVm1Olswm1iX/PEForPthjoWIYCTo4im9mhZmPzDmtbnOHz3+G3BEVPNYgVdTy9Y064ErHFrcKnV38gbUonZ9n13ohfTncce8pYgyxMyICA2ovmN/NJQLxst5NstXuXVbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801923; c=relaxed/simple;
	bh=8GuiXIytBzEOOq1loh/sdanwydxd8B84OUGGGBmQrxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meHHvmjeIDsnT9+Cr0oO+lmCFhrXpEFWN90JWHEqhu+8adPsRDJ/Q8+XWTSfAWTwVTkEDuQbbc+yLlmd4hKsOnyOUHrLxW3M3vypPLeTS1KqLrIkgdTUOIKFuJCud+gHKbyXWStuGySmaKvFBFZONCWoi9Wk3TJiOceRxZGc2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GRHZOFIy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716801919;
	bh=8GuiXIytBzEOOq1loh/sdanwydxd8B84OUGGGBmQrxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRHZOFIy40cxzRCBKR+sKYr7lZcoxq9hRzQ2jzpd8M6DvzTEaVIX6Vk1n7lI7Fmoo
	 /X//2fYrJWzFYjgzijs9LgplhhSayI/QI3ZGX6zgqv+kDMADoxaQ4IcJ8o8CyXQQg3
	 OUdqIGwhHgFE5VBgqip57mhY7reXuhzqc85uWcMtTneQiA7lfyjbnOQPx4S6+M2vtZ
	 sqkxPWIo90IaEUn6gKN70T0Tia8+bjrmtM08QGqOHLAPprDDSitINYaFG96sanzRb8
	 3/u04bga92Pbq6Uv39DFL+kPW1BTqmUWwxxZIgh2+GOhI7ZBzhDnaWp5CFtmnDrDFC
	 XvUpWaLKBS+Cg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 631A1378212E;
	Mon, 27 May 2024 09:25:18 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: boris.brezillon@collabora.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	steven.price@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] drm/panfrost: Add support for Mali on the MT8188 SoC
Date: Mon, 27 May 2024 11:25:13 +0200
Message-ID: <20240527092513.91385-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527092513.91385-1-angelogioacchino.delregno@collabora.com>
References: <20240527092513.91385-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek MT8188 has a Mali-G57 MC3 (Valhall-JM): add a new
compatible and platform data using the same supplies and the
same power domain lists as MT8183 (one regulator, three power
domains).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index ef9f6c0716d5..4e2d9f671a0d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -777,6 +777,14 @@ static const struct panfrost_compatible mediatek_mt8186_data = {
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
 };
 
+static const struct panfrost_compatible mediatek_mt8188_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
+	.supply_names = mediatek_mt8183_b_supplies,
+	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
+	.pm_domain_names = mediatek_mt8183_pm_domains,
+	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
+};
+
 static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
 static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
 							   "core3", "core4" };
@@ -808,6 +816,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
 	{ .compatible = "mediatek,mt8183b-mali", .data = &mediatek_mt8183_b_data },
 	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
+	{ .compatible = "mediatek,mt8188-mali", .data = &mediatek_mt8188_data },
 	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
 	{}
 };
-- 
2.45.1



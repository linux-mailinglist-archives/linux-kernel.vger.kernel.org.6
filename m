Return-Path: <linux-kernel+bounces-200618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2FC8FB274
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC1E1C24D66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038C1487D4;
	Tue,  4 Jun 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MuUCaa2O"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE1146D6B;
	Tue,  4 Jun 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504771; cv=none; b=IPMjUWrRamqXEfWw+i60i/Eblfr/m/eYTWqaNiE+bgF1oDb4M0tszQNMsK6fKpq/hpNhL4bo0QhpElSC7x/BFuBvpX4R9CMmXAlk8uNUnykT9DhQB7wgMDfgisg27Sv0rNCoPo75+xZ6r+NYLIIYfPFYffVGA5kvuQBzbud63WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504771; c=relaxed/simple;
	bh=8GuiXIytBzEOOq1loh/sdanwydxd8B84OUGGGBmQrxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm5ZxudNRuxOGFCUKZpa5KQVPLlHh0YHY6fAstcNx9tSzMIR8fRywvBh8N5dlcT6N4TA+A5r1RmPXe3IYgi3ayW7UyIMwqtwKgQLIRtafl5eLaoCFJsz5YKcZiLz70uGl5I+D1sNtP+JwxYEx7gvsee3Lkew2AyF3ELSq3Cpu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MuUCaa2O; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504768;
	bh=8GuiXIytBzEOOq1loh/sdanwydxd8B84OUGGGBmQrxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuUCaa2O/d75m45tHK6ensCCO3PlYnhkaWl+8S0AGUp85xfKyffI56SDFAq9YjuGd
	 xSw2vFMNE8A413ZNTo4Lg4yAw5Zix4P4OF/t5b1IhIFB+Mor2coDVhI/Ln2cG2t8+h
	 wjXVsw+e2M0jtLWBIcT4oQ7RwPFKndylW6VrGm7dlNAsADputoz4hE3jNH+CTmTCKT
	 zI+cBBOkU0QuDBqKWfVWFq2qLd2097HkDodMD3znfYg+5dGCsNvhwGcpiwJeOFbPfL
	 4NUqOV0I1TZrHtmGZ1PKl/8v1qHe/q4Kz5l7J+jL/3zVWq3/QsvEv1+zK4OYAeAn3g
	 IMHm2Zv6Uytiw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C4C837821F4;
	Tue,  4 Jun 2024 12:39:27 +0000 (UTC)
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
Subject: [PATCH v2 2/2] drm/panfrost: Add support for Mali on the MT8188 SoC
Date: Tue,  4 Jun 2024 14:39:22 +0200
Message-ID: <20240604123922.331469-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com>
References: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com>
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



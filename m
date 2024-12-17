Return-Path: <linux-kernel+bounces-449513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554359F5015
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C746162671
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC21FCCF3;
	Tue, 17 Dec 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="axBs+uXE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF11F76D4;
	Tue, 17 Dec 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450276; cv=none; b=UIRstvMb4VTjymXY+VkxrUHL3aZA0INASytGlniFHcpQlF/t5ks+JH/8E37pNxFbaVxFgmkdJZZ4PBgEqppLgHfdg89Qjgyrm9DQi+NtI9t5SfixlLgKuH/tIBN5Ye+ZVdZ04cvSvKk0cQ5I0kQduKMKAq4X7qhq5ilQmp6fcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450276; c=relaxed/simple;
	bh=nk+T6mGbta3uFbBTUcwr8oOg6JCm9jb4c3aHijKlJKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKLvMSDUVIPAsiKAGIqX52a1tTtT++PrUEA8TGyd74LQZ1fOQmgxvdbjr6cygdHeg8sNrAKZuq1CXw0H7uOL3aDyrZcu/MD81w6/kMCa/3944fvqK1jrgVWZqsA9WNuTwW37DaMTsaM81SwfqeWHvcibPAkkS3kdVNW2vToMcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=axBs+uXE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450272;
	bh=nk+T6mGbta3uFbBTUcwr8oOg6JCm9jb4c3aHijKlJKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axBs+uXErEUeUxFH2SAkZpeyQgl5scWJEFrBqUx3XvwxsdMObyHVeCPRU8W6b6/dp
	 f7WwBFn08/LFuq0PeHOjTjQnreMAla9bS8GGOhvxxBvaA58FU1/6rKHRadMu/1MKwD
	 hPl7yQJ0LDWZs9Y9RcaxYsYeedGMYRWzBXHERPqSno9I/pn2ophCqGQu9DP3YONTT2
	 yBhwTPjE0OVFqjnQM5kyQFZdaqs5ugAubtdRHYM7iLZhSyxgyuAgyLje9Rt7DxXM+8
	 gUKY3S9O36JvGxfqGrnL5uMc35fXMhGx3MMcnUgjIKG5Pvg7ct7/ovttDe5nGGfT2m
	 xnE8xDK8vZDJA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A8FD17E37C6;
	Tue, 17 Dec 2024 16:44:31 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	dmitry.baryshkov@linaro.org
Subject: [PATCH v3 29/33] drm/mediatek: mtk_hdmi_common: Assign DDC adapter pointer to bridge
Date: Tue, 17 Dec 2024 16:43:41 +0100
Message-ID: <20241217154345.276919-30-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
References: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the new HDMI TX v2 IP driver, assign the
pointer to the DDC adapter to struct drm_bridge during probe.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index c7ccbd117487..153d7f7d5da2 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -406,6 +406,7 @@ struct mtk_hdmi *mtk_hdmi_common_probe(struct platform_device *pdev)
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
 			 | DRM_BRIDGE_OP_HPD;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	hdmi->bridge.ddc = hdmi->ddc_adpt;
 	hdmi->bridge.vendor = "MediaTek";
 	hdmi->bridge.product = "On-Chip HDMI";
 
-- 
2.47.0



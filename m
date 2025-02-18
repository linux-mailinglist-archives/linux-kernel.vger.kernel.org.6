Return-Path: <linux-kernel+bounces-518963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4065A396D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E9D3BC3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700022F164;
	Tue, 18 Feb 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WijSGcAC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266D154C12;
	Tue, 18 Feb 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869475; cv=none; b=ZsfOzxwCRmJWKM9m3lGA9y12IHmyeJkypLxTvOb3qbJ0HFjnj7Pk6QFiPp7TtCbA/oqd2+CHtZtCp5FJ4Xa5qwc489joc/YokDDFAvVnYczMjInYn0EvQWz0j5KhsSDqfeWY4dIWRd7fkgABmCbeeuYsHD1/g22XiRKmdiL8Sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869475; c=relaxed/simple;
	bh=IoSrMv71ID9ekjkacGKInTn1Qnx2Ah1BUMPVIHvGazY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSuNFyXzkCXurejO1Q9KqDB+t2hzYWSE+yzGBKumIMTBjUij4d4dqnwsZP0DQSh/bzJl/kpLyHoE3YUoBfc81o5V+FHEQU929P9Q4epQjbqpA6m7+bQuW3pPyNL+h3XSmrZAflqeAdYq8Nf4dkyUAvsXFdmILBrv43/atF99CDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WijSGcAC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739869471;
	bh=IoSrMv71ID9ekjkacGKInTn1Qnx2Ah1BUMPVIHvGazY=;
	h=From:To:Cc:Subject:Date:From;
	b=WijSGcACUlEnBBBHl8nT/4Mfk4xzfBSRXR9zDgaGaZAuN+hz5zIunMgnkpZxb6KzL
	 2hsGGvmV9bxvViftYTpmr1oaVMM2GEhSn+0Hd1BuK+Hn6KwmhjjICZMwp9qQbkq/Ez
	 4IaGG6UYhQcfcuxWOgL+fxElV6KG/pDFZEsVwlrpaTFfFdoliFJWGAdPuSxIPTo+xC
	 EiNpnrIdrdjKgbUoKTiCaEPuOc9RKl8+LR5mQCvh7gB2mG1zDydpBrdxhCGf100yVv
	 pp6clctCSE9HALXCRLZ7/H3cjLILN+m3VVgNMoSti06dTFSZ+CD0nRHPITe8/+AIuM
	 qc2Qkrlwgc1Zw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 90FDC17E154A;
	Tue, 18 Feb 2025 10:04:30 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH] dt-bindings: display: mediatek: dsc: Add MT8188 compatible
Date: Tue, 18 Feb 2025 10:04:27 +0100
Message-ID: <20250218090427.20318-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for Display Stream Compression (DSC) IP found in
the display controller of the MT8188 SoC.

This IP is fully compatible with the one found on MT8195.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,dsc.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
index 846de6c17d93..a5b88eb97e3b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
@@ -22,6 +22,9 @@ properties:
     oneOf:
       - enum:
           - mediatek,mt8195-disp-dsc
+      - items:
+          - const: mediatek,mt8188-disp-dsc
+          - const: mediatek,mt8195-disp-dsc
 
   reg:
     maxItems: 1
-- 
2.48.1



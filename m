Return-Path: <linux-kernel+bounces-353080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128EB99282A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7BF1C20BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A218BC17;
	Mon,  7 Oct 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rl9JPHYj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29018133C;
	Mon,  7 Oct 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293488; cv=none; b=tetrZOI3EMCFDOxpOSa6ScHlwMvk9PGoVr/BZZ59Xevi0AR2xk7YvI4Z9ysexXymBbsyhgP8+V1V1MXdZKb5bkwfG0Nz/sbLjBhIFRjI8GeC0H0bmETMa4fXW3RqGq9g8nKIAD72TmaHPtNMVpwZZeIo2UOf1O5E3qyTNlQTOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293488; c=relaxed/simple;
	bh=Cq3dZsX1iPH2sUqY98fTwu1oiCm4WlLKa+tNu4ZQhh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCXjOEsiZUlhXy7fk8veJhRj+NFn0zdyvZsFjDq0XVH+V3U1lRFmh/EjjL3LHM8eYnqg/SNamS5yINML3m6kgzD6gVXSiijHMHGdLIGTjIyGa23ap8cHby48HINCHsPWlHPhJtMjcs1iHG/0qbX8uGvLgwDsiZROR+WLgOw6dFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rl9JPHYj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728293485;
	bh=Cq3dZsX1iPH2sUqY98fTwu1oiCm4WlLKa+tNu4ZQhh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rl9JPHYjIZd0tS46aW8UOpJdXV8lVIFbat8Q2LhOaYmjerUc2DuftBaCD5g98a7hY
	 EG9YRDl2A5t/FdlrFG5QOwsSw30zq+4D4BqxvUCSu/R+G8PLaHmIhFpCg1vf8GUj57
	 L9LT9APmemNmBom5XfWya27IvgaKXAPz070ySfFDQoryd/q7kOzf5x8WZwvJE0AiaH
	 IWQ7qZVYOkA69ojAPgnxzONhEFU8eaWfVqpIhhy1SIc+DHsTAGx6xd8fYbU2aaGGF7
	 lOFu0Za2kiyjfEya22fZnXf+9tjwXwSn4tppUqKltmD4Bj2qAHIMQiEc4TLTJ2Oqvv
	 ne6t82cLPG1bA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 300A817E11E2;
	Mon,  7 Oct 2024 11:31:24 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	yu-chang.lee@mediatek.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com,
	sui.jingfeng@linux.dev,
	michael@walle.cc,
	sjoerd@collabora.com,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v11 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
Date: Mon,  7 Oct 2024 11:31:13 +0200
Message-ID: <20241007093114.35332-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007093114.35332-1-angelogioacchino.delregno@collabora.com>
References: <20241007093114.35332-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
per HW instance (so potentially up to six displays for multi-vdo SoCs).

The MMSYS or VDOSYS is always the first component in the DDP pipeline,
so it only supports an output port with multiple endpoints - where each
endpoint defines the starting point for one of the (currently three)
possible hardware paths.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Tested-by: Michael Walle <mwalle@kernel.org> # on kontron-sbc-i1200
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/arm/mediatek/mediatek,mmsys.yaml | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index b3c6888c1457..3f4262e93c78 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -93,6 +93,34 @@ properties:
   '#reset-cells':
     const: 1
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Output port node. This port connects the MMSYS/VDOSYS output to
+      the first component of one display pipeline, for example one of
+      the available OVL or RDMA blocks.
+      Some MediaTek SoCs support multiple display outputs per MMSYS.
+    properties:
+      endpoint@0:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the primary display pipeline
+
+      endpoint@1:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the secondary display pipeline
+
+      endpoint@2:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the tertiary display pipeline
+
+    anyOf:
+      - required:
+          - endpoint@0
+      - required:
+          - endpoint@1
+      - required:
+          - endpoint@2
+
 required:
   - compatible
   - reg
-- 
2.46.1



Return-Path: <linux-kernel+bounces-415758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F279D3B07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAE1282DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612331AA795;
	Wed, 20 Nov 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AR7BdQV6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F921A7265;
	Wed, 20 Nov 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106730; cv=none; b=mv7L8OuZzYV7M9M3AdgswgQiAyN65W9Q4shYO7sptWUncXexDeNB7RLuqeZvJi4KMIrHbPJ2rTK28HNcfJxl/fiGIxI36bPJvB3UVdhaykHIKW0l+YKE5G8dZSOgAsr82kFqayly47CHTQpf4b0P6uLbQD15AqYyv7KvHPBPLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106730; c=relaxed/simple;
	bh=UyJFg0KvktCszyds8d+I13c8+erp0r61a3XVIvkerjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaoZA94qXITbBIzJt5f+Cnu7Eyj+5o9toUX71FecY4EKXq33J2lR6yFuRIPsxd+VLWOy7PyUaqtgESP6WP0q/Ku9osKuNPXq4TIDwA0IITCY6Rn/9DKqZdLOf4AUqro1DeTaYggGQlFslz/Q/4dR4tWGHEpMu0YLvcDVac/poWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AR7BdQV6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732106727;
	bh=UyJFg0KvktCszyds8d+I13c8+erp0r61a3XVIvkerjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AR7BdQV6AP9JY6YRfGI7IZL3eXmVVfbvQANOtdWchno5bGd98hQH8H0Wic2mxWVj6
	 pjvXisJd7N1LCouosLyZsCVh+54HyZmW0lDEZe5pEtJYDB4yq4GI3WHJimmQxEfUIY
	 L65UNtsvtXRUUWCEruu5upb+QCKUeYq42hrLJTMGg664BwS6TB+1wM6rGKgi7E+eTA
	 jOZZmDFK+GqpXpPkcpg8Knnnl80zsgobJTyWrxEKOd38VaNLEKWFRo+wurd8uwK5IZ
	 Bm7r6Nm9QRj6fSlrz2ig0YvEZqXMH0iFID+56CDnTkZy6B5kyfOMmb+lTVJ3kJxFP6
	 Do69uLYBTEEVA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 60DEB17E3663;
	Wed, 20 Nov 2024 13:45:26 +0100 (CET)
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
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 1/7] dt-bindings: display: mediatek: Add binding for HDMIv2 DDC
Date: Wed, 20 Nov 2024 13:45:06 +0100
Message-ID: <20241120124512.134278-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for the Display Data Channel (DDC) IP in MediaTek
SoCs with version 2 HDMI TX IP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
new file mode 100644
index 000000000000..d85e8ed2ffa7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek HDMI Display Data Channel (DDC) v2
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+  - CK Hu <ck.hu@mediatek.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt8195-hdmi-ddc
+      - items:
+          - const: mediatek,mt8188-hdmi-ddc
+          - const: mediatek,mt8195-hdmi-ddc
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi {
+        hdmi_ddc: i2c {
+            compatible = "mediatek,mt8195-hdmi-ddc";
+            clocks = <&clk26m>;
+        };
+    };
+...
-- 
2.47.0



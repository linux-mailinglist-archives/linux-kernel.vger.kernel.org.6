Return-Path: <linux-kernel+bounces-523487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A2A3D77D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33416189D96A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980991F1913;
	Thu, 20 Feb 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IbJbv7Zd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201171EE032;
	Thu, 20 Feb 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048948; cv=none; b=dSaQCkUQ9MGhqxrH4wMFLr/SLLG7ANCXMolyI0KJePgZjHKxJx/qFsI6RFMcAaUw1yzX6ZaTptK0rXAtm0THKxB8pXL6dnEybdvGVGZpx/ZvEe0csuE4Ww84sqnSvDWPD63/SwEiVb2uugul6UCrrLG545NnFowxX434jQFa5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048948; c=relaxed/simple;
	bh=f2rxjrxNyDjW9jW41agW0DUC3PfepPxgabZ7lkxtmWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2jJyPAzA0e1wETvoTyHMiWX8CQyPnMCNJNtIFW0iuAb12nu+ZupONChLmJXoEBlhaPPIfGx/QrN75tJ++MJEQzAauv6eXZhyi+XSILxupb4cWOUDMrHIWSADpyVbBioDr/TNoD0NfNTTYIaERvW5KCG3kJBDrCBWaW/JCiK0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IbJbv7Zd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740048944;
	bh=f2rxjrxNyDjW9jW41agW0DUC3PfepPxgabZ7lkxtmWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbJbv7Zdchqyk4XjqtZbLFVggpFmVfCDpPkJVFyi1wyOhbJBWyei11xfOcnIlIqxw
	 Jwgfi0kc9GBaHYj5p84rT99IFlADPJrnFr96N7R9ak0Uln3q357Gk7L3AeIy2WT64O
	 +c1RTjKkQmTV8JQ+7Gu+P1/Oa5DJ2h6e9PP9lvo+KDVow8Zsic5LKOF7vfbbaOTx6y
	 K1g4Acaui0mCOizaIJVQ9mHkSQfBfGmpU7/Y3QeggBY+dpcXKrFVAAXl1m8Q/PahNH
	 2wgkVvHDrOWHGzjlfOo9kITL0CbS8ZzzJkkGoBOBfhky52ZgIn4AdwfMMpq7pVdFU+
	 qLWfq3/4J/qpQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A12F717E1569;
	Thu, 20 Feb 2025 11:55:43 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v3 1/3] dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP
Date: Thu, 20 Feb 2025 11:55:12 +0100
Message-ID: <20250220105514.43107-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a port used to connect the SuperSpeed output endpoint to a
Type-C connector.

Note that the MediaTek XHCI controllers are always in front of a
different controller handling the USB HS (usually, MTU3), so the
only port that this controller provides is SuperSpeed, while the
HighSpeed one comes from elsewhere.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index ef3143f4b794..004d3ebec091 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -106,6 +106,10 @@ properties:
       - description: USB3/SS(P) PHY
       - description: USB2/HS PHY
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Super Speed (SS) Output endpoint to a Type-C connector
+
   vusb33-supply:
     description: Regulator of USB AVDD3.3v
 
-- 
2.48.1



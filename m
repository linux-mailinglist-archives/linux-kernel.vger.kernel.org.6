Return-Path: <linux-kernel+bounces-402224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC69C252A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC1F284C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FC51C460A;
	Fri,  8 Nov 2024 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gxZ8JrRO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5B1C1F21;
	Fri,  8 Nov 2024 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091960; cv=none; b=KySmEuJrmcGTKCjF/zXNB9Sxx5AZYyBE1cw28e1ovI8oMA7qwV6A6rQenJhKPVdHRaaj+TiNlrowwVdm1r/21ZMftyKUctBbnHk23nS0S5ryGkOCRFpAPMK1CRG6y157vQ8D0YtMUAVPpvS4s3cFGgRnZdtidvkxnM/g8Iq/ExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091960; c=relaxed/simple;
	bh=69F+XwHGUM8j8Npu0CVV/bvnKz12bT/JSO/FqsNELcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6BoXTh3vREmKh8k64c8NWVwr8o7lViCOJBL2szBFOjJ4doKEGNtQLSfTVXOAiQ77JwiNAWo4PrnEwp0kXxWoi6XFgft1SCDDor+QI0lrXneBKQr/FeQNLHNPXAn22uegay1nkplEdEX612txMRLe5PKlPy8Q67jHNC2zIpHE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gxZ8JrRO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731091957;
	bh=69F+XwHGUM8j8Npu0CVV/bvnKz12bT/JSO/FqsNELcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxZ8JrRO6t3KYBAYrnFkHOPCL/5Yxe3jqsw9SPxYt2ta/JHJB6SkhPQBfiqMcr44y
	 P4+zIAAi2twZ/QxYywjpghDPcuDArxlYYzT9MtPWwL86l9BQ6gorsdxHj8zqUo5ROL
	 /w1ky90u+sQrBJcWsGKcBjPOj9npFAIAoxvQKAeBgquDfpu8RqBXsou5TaDQFopVcD
	 ILQvaX8nUA/rLvjrjQn+5Rspwrex5SUdCdt6JHTcVNYiBD/FWFFPBZTjWDLFQaycc0
	 GdWqS0J2qpDMJyO8l85plGqYlVCcKHuzOmrhpi4dx/FfEXbHTGxyMUgE+CQtF+xuX/
	 fjYO3xBTMPFug==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4088D17E3770;
	Fri,  8 Nov 2024 19:52:34 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko Stubner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Alexey Charkov <alchark@gmail.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 3/3] dt-bindings: display: vop2: Add VP clock resets
Date: Fri,  8 Nov 2024 13:50:41 -0500
Message-ID: <20241108185212.198603-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108185212.198603-1-detlev.casanova@collabora.com>
References: <20241108185212.198603-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation for VOP2 video ports reset clocks.
One reset can be set per video port.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../display/rockchip/rockchip-vop2.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index 2531726af306..5b59d91de47b 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -65,6 +65,26 @@ properties:
       - const: dclk_vp3
       - const: pclk_vop
 
+  resets:
+    minItems: 5
+    items:
+      - description: AXI clock reset.
+      - description: AHB clock reset.
+      - description: Pixel clock reset for video port 0.
+      - description: Pixel clock reset for video port 1.
+      - description: Pixel clock reset for video port 2.
+      - description: Pixel clock reset for video port 3.
+
+  reset-names:
+    minItems: 5
+    items:
+      - const: aclk
+      - const: hclk
+      - const: dclk_vp0
+      - const: dclk_vp1
+      - const: dclk_vp2
+      - const: dclk_vp3
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -128,6 +148,11 @@ allOf:
         clock-names:
           minItems: 7
 
+        resets:
+          minItems: 6
+        reset-names:
+          minItems: 6
+
         ports:
           required:
             - port@0
@@ -152,6 +177,11 @@ allOf:
         clock-names:
           maxItems: 5
 
+        resets:
+          maxItems: 5
+        reset-names:
+          maxItems: 5
+
         ports:
           required:
             - port@0
@@ -183,6 +213,16 @@ examples:
                               "dclk_vp0",
                               "dclk_vp1",
                               "dclk_vp2";
+                resets = <&cru SRST_A_VOP>,
+                         <&cru SRST_H_VOP>,
+                         <&cru SRST_VOP0>,
+                         <&cru SRST_VOP1>,
+                         <&cru SRST_VOP2>;
+                reset-names = "aclk",
+                              "hclk",
+                              "dclk_vp0",
+                              "dclk_vp1",
+                              "dclk_vp2";
                 power-domains = <&power RK3568_PD_VO>;
                 iommus = <&vop_mmu>;
                 vop_out: ports {
-- 
2.47.0



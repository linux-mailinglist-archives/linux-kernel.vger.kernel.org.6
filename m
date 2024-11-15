Return-Path: <linux-kernel+bounces-410994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B349CF217
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF3AB4741E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49111D6190;
	Fri, 15 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ggbk3HKo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8E1D517F;
	Fri, 15 Nov 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687698; cv=none; b=t0MT0EiGu1UcwVKGMuM5/4JD1NOxDSV/g8ccJa+1qSHcZLX1PC5kMZ8ne4QUgfuLobvjBKA5dwXSH6tNiDPpm1VVqJCPrP/5UsRxCrqoT7aHDHjz/Ji/authmGCCLwuUVOzxBdmisMlB7o3wUjqjkbuhER7dBP3m92kJCqTpXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687698; c=relaxed/simple;
	bh=t8QOMvicQTdBi3HEc3pXhANKEj297lR7+tmr8+awtJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJSoGtQpNsw1Qn4/fwxCMWb7paglYnWOjwKz1vcND2NDtrZd4z2tOdfgsgxU5KDmSBnx7+tPATlX44oZAw3GQWWWhxJK4yPNAhyAIkOyGo9ekbapfJe5uHgHOZMgXhJ1aHRh1zOP3lnFq3YNcC2OVAZclxp71RU4xVFakZ/pnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ggbk3HKo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731687689;
	bh=t8QOMvicQTdBi3HEc3pXhANKEj297lR7+tmr8+awtJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ggbk3HKo6LYr9TppFbMl87GhuGstk7MN+7cbv64SY8d0AgULJiOtVrATmrzgtnB2k
	 790RKIi56ZKOuLQCneAhgucS8gP31bVFm73yMVUDvxzhA64B2XxvzsnpPQUQ1zfyjM
	 rgN0gIRMgi8E4MGuANUsLsCxOtrQSbhNFc62jhmKtbnTsxyMHNAAhwLzzioCJpbBpn
	 NixWT2W91JFLDY3XJ1llXNK3qGJlmgBgNmGpeLKjxjEZAWTwEpvAvKs1e3TbZ9MPp+
	 ZJlvtJDBD5IB9rFb2GYrIAR/+whOIbcaUvfQShn4NV2Y1ZIdC6Mpn6S/0xrez6ZaZb
	 PCjFXJ3IOepKQ==
Received: from bootstrap.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB5E817E374C;
	Fri, 15 Nov 2024 17:21:26 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Alexey Charkov <alchark@gmail.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: display: vop2: Add VP clock resets
Date: Fri, 15 Nov 2024 11:20:40 -0500
Message-ID: <20241115162120.83990-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115162120.83990-1-detlev.casanova@collabora.com>
References: <20241115162120.83990-1-detlev.casanova@collabora.com>
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
index 2531726af306b..5b59d91de47bd 100644
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



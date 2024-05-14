Return-Path: <linux-kernel+bounces-178855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C552A8C58AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82ABB282E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEBA17F39F;
	Tue, 14 May 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tV5Hda4A"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AF17F387;
	Tue, 14 May 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700265; cv=none; b=SwK8X0S6Heq58XjrsVkZoHQDCQF3EcUcMxIFBAFKwlg3RXqpDdTY20xr8+mbSKskPxcWyqFHJWvFZJRLZtRDckyvahEp7dv8EXC9uj9JDU8WdQLWBBopd1zoJepbCCxaR0yqRT3micXsQYq/czCrug8HJmqWHVTeGx7sGfyhoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700265; c=relaxed/simple;
	bh=p7nTz/Irz77RiCSjoigxmGbDz02q1CnibFJajp5cPw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beQQc+i2TeelctHN/agtTK1iXmyCN/ScAHiBkS8jSsv9tlXB2F+4ignaIplNzc700nYv/4BlcP/yfvhAajsGCVdz1AedpEX0mvJnN4k+iVwZwYQNYTP7HwQvbgO3tRvYsLImtPyVEGvIi2DKVUMPgEn0Arv8ajDbcqVSlKFYBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tV5Hda4A; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715700262;
	bh=p7nTz/Irz77RiCSjoigxmGbDz02q1CnibFJajp5cPw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tV5Hda4AXXSV+gBLPGXMrdFGL33+gcnuSGI60CBLFQtOcWSaYTb6XDVRRmGy4DC0E
	 08XVWtEfv8Unohji+Dqq4bAHaP2tmtAJMuAnPGHSFOHpmbjAA8rsGbveIBC14tUv9y
	 7uFM+yfjX/p8jWMKLEi/e9CXy3IBXc/IKg0WqXq3EowUuanIJZkCyjWfd8yr39kIG7
	 XT2tsD6I6RZ6bCCa3bc9g6V6lMmvQLE03pNbrU/XP9C9iat4iqBmSc4uYU8irRpcfn
	 zFZcoZwSWXhU7f098rg64RxI0HHBz+kyPTx1e62LNMDWfyH6PUOZ6vpopQCMLIQm2b
	 1HmBeCp4zPvJQ==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 98D883782198;
	Tue, 14 May 2024 15:24:18 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 3/3] dt-bindings: display: vop2: Add VP clock resets
Date: Tue, 14 May 2024 11:19:47 -0400
Message-ID: <20240514152328.21415-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514152328.21415-1-detlev.casanova@collabora.com>
References: <20240514152328.21415-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation for VOP2 video ports reset clocks.
One reset can be set per video port.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../display/rockchip/rockchip-vop2.yaml       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index 2531726af306b..941fd059498d4 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -65,6 +65,22 @@ properties:
       - const: dclk_vp3
       - const: pclk_vop
 
+  resets:
+    minItems: 3
+    items:
+      - description: Pixel clock reset for video port 0.
+      - description: Pixel clock reset for video port 1.
+      - description: Pixel clock reset for video port 2.
+      - description: Pixel clock reset for video port 3.
+
+  reset-names:
+    minItems: 3
+    items:
+      - const: dclk_vp0
+      - const: dclk_vp1
+      - const: dclk_vp2
+      - const: dclk_vp3
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -128,6 +144,11 @@ allOf:
         clock-names:
           minItems: 7
 
+        resets:
+          minItems: 4
+        reset-names:
+          minItems: 4
+
         ports:
           required:
             - port@0
@@ -183,6 +204,12 @@ examples:
                               "dclk_vp0",
                               "dclk_vp1",
                               "dclk_vp2";
+                resets = <&cru SRST_VOP0>,
+                         <&cru SRST_VOP1>,
+                         <&cru SRST_VOP2>;
+                reset-names = "dclk_vp0",
+                              "dclk_vp1",
+                              "dclk_vp2";
                 power-domains = <&power RK3568_PD_VO>;
                 iommus = <&vop_mmu>;
                 vop_out: ports {
-- 
2.43.2



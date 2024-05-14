Return-Path: <linux-kernel+bounces-178533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8B88C4F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C4F1F22212
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB57F13A3F3;
	Tue, 14 May 2024 09:53:15 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A413A242;
	Tue, 14 May 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680395; cv=none; b=HImkhkv6fV7C3339SMISNndiTy1ktxnWM4Uqmgt8ewWH6Hj9jILJspTp8K9spDuG1gMteL6CrxlOR216HrNZioROT7ZVZZBCuCd1MWfK419dnaM34EugES/GoLkLLdvhZ6H8T2RpJ7DNdVg+Hy07C2dSCxNJOxN4XORSRWNIVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680395; c=relaxed/simple;
	bh=N1Be/lHX9le8mgGi3YYkU+QV7lUMRQix+T57VbFccns=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=KjL8mm7E7EfCs7xVFNokU5y8ueLDcQqRuS5xA8GiaVYsB8dk8WClIYe7M5munIOk+GGM4/nzq16w2ZPie4yZgr6ood2va3o4cN1MWeF2B5rEF1x2mJxndkA2sBsGWTUy5puYPjLX+Dwr6ylN4/2/7Yodb1FP97ZB1WKWKoKiCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DBD320192A;
	Tue, 14 May 2024 11:53:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F267200BC5;
	Tue, 14 May 2024 11:53:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BCA39180226C;
	Tue, 14 May 2024 17:52:57 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller sub-node
Date: Tue, 14 May 2024 17:33:27 +0800
Message-Id: <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Audio Block Control contains clock distribution and gating
controls, as well as reset handling to several of the AUDIOMIX
peripherals. Especially the reset controls for Enhanced Audio
Return Channel (EARC) PHY and Controller.

So Audio Block Control is a Multi-Function Devices.

Add reset-controller sub node which is a reset provider for EARC.
Add compatible string "syscon", "simple-mfd" which make Audio
Block Control device support reset-controller sub-node.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/clock/imx8mp-audiomix.yaml         | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
index 0a6dc1a6e122..a403ace4d11f 100644
--- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
@@ -15,7 +15,10 @@ description: |
 
 properties:
   compatible:
-    const: fsl,imx8mp-audio-blk-ctrl
+    items:
+      - const: fsl,imx8mp-audio-blk-ctrl
+      - const: syscon
+      - const: simple-mfd
 
   reg:
     maxItems: 1
@@ -44,6 +47,11 @@ properties:
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8mp-clock.h
       for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
 
+  reset-controller:
+    type: object
+    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
+    description: The child reset devices of AudioMIX Block Control.
+
 required:
   - compatible
   - reg
@@ -60,7 +68,7 @@ examples:
     #include <dt-bindings/clock/imx8mp-clock.h>
 
     clock-controller@30e20000 {
-        compatible = "fsl,imx8mp-audio-blk-ctrl";
+        compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon", "simple-mfd";
         reg = <0x30e20000 0x10000>;
         #clock-cells = <1>;
         clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
@@ -74,6 +82,11 @@ examples:
                       "sai1", "sai2", "sai3",
                       "sai5", "sai6", "sai7";
         power-domains = <&pgc_audio>;
+
+        reset-controller {
+            compatible = "fsl,imx8mp-audiomix-reset";
+            #reset-cells = <1>;
+        };
     };
 
 ...
-- 
2.34.1



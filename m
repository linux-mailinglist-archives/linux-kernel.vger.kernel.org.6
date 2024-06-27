Return-Path: <linux-kernel+bounces-232108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C457291A38B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA1EB217F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289713E025;
	Thu, 27 Jun 2024 10:10:43 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0713C821;
	Thu, 27 Jun 2024 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483043; cv=none; b=ceZzWyvBofyaHBPpmJ18oYvuOemJernIKvM2sT0GpyIEfGQRxNBPNQWB3zBX960GkMPV40VUj8GUML110saujwEcFbpDH/ExJZB2EHUYPve6p259VjK/bReBr5VOOQmpD1NZzSe5MTLq/RMgEfMPpY+DPtk8s6sCdpF84A7OYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483043; c=relaxed/simple;
	bh=u1jXzy6eJUUrBURLV54AXqkx4za7RrQWtNms2ROxIdw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=VJl0CJEqZusut03T+FhxxyA40SvbYfIWKQ8P7d37O5Lcy5d+F2ATudcxpK21vUWkSsA47z4vK9rrVuEbPmEJY7Tkt7hdsyjpwy7BNbQ081uR/j96GTbDyXchDQOaMAOUQ8osZn09H9k/wTJP4cWSnC0bfauemZkQdS4hrh0mlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F1555201934;
	Thu, 27 Jun 2024 12:10:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3135201924;
	Thu, 27 Jun 2024 12:10:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E9A03180222C;
	Thu, 27 Jun 2024 18:10:31 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
Date: Thu, 27 Jun 2024 17:52:59 +0800
Message-Id: <1719481981-4069-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
References: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On i.MX8MP, there are 3 interrupts, the third interrupt is
SPDIF wakeup interrupt from PHY

Add ref: dai-common.yaml for #sound-dai-cells is needed and
XCVR is a DAI device.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
index 197ae8ba9c30..5e2801014221 100644
--- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
@@ -42,6 +42,7 @@ properties:
     items:
       - description: WAKEUPMIX Audio XCVR Interrupt 1
       - description: WAKEUPMIX Audio XCVR Interrupt 2
+      - description: SPDIF wakeup interrupt from PHY
     minItems: 1
 
   clocks:
@@ -88,6 +89,7 @@ required:
   - dma-names
 
 allOf:
+  - $ref: dai-common.yaml#
   - if:
       properties:
         compatible:
@@ -112,7 +114,8 @@ allOf:
     else:
       properties:
         interrupts:
-          maxItems: 1
+          minItems: 3
+          maxItems: 3
 
   - if:
       properties:
@@ -128,7 +131,7 @@ allOf:
         clock-names:
           maxItems: 4
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -143,7 +146,9 @@ examples:
                  <0x30cc0c00 0x080>,
                  <0x30cc0e00 0x080>;
            reg-names = "ram", "regs", "rxfifo", "txfifo";
-           interrupts = <0x0 128 IRQ_TYPE_LEVEL_HIGH>;
+           interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
            clocks = <&audiomix_clk IMX8MP_CLK_AUDIOMIX_EARC_IPG>,
                     <&audiomix_clk IMX8MP_CLK_AUDIOMIX_EARC_PHY>,
                     <&audiomix_clk IMX8MP_CLK_AUDIOMIX_SPBA2_ROOT>,
-- 
2.34.1



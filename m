Return-Path: <linux-kernel+bounces-194892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A58D43CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F41F23C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04961EA84;
	Thu, 30 May 2024 02:47:28 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DB1BC44;
	Thu, 30 May 2024 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037248; cv=none; b=HlyytbLLzLfIxyFTEgj5BBnnHv14qfPXLU4JNeL+rvjcK+hbQWcRUGmkLYoa/+3ix0DUZHQs1PB+nTSPZEIwRzoYoTCkNa1re5bRjmIKziX3AgbSgXVewZBGGk5ceW+7AA2f6V/3vx5yqEL0RcUIMwykfp9YMHMe4ZQf2d4bjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037248; c=relaxed/simple;
	bh=vwhl2TItuSUrCzO5vdVWYedHOQAkUkhYVgTV88cG0tI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=XQeaAsHzj9pGrRJVZTk5+0X0n1d+vXVFEOHzptds34IclsvjWlzFiaTvsNipmtj0Wcw7spHl0PRWo/AzD/J0ZSzmw5E8C7/UBGxBV4FvvXBeP9XF9SCNcHGfh7BRqF3pQV3Pw2ikY1kLLDLqROxVvJgWHQRftfp7AtgyyupKNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDA3E200968;
	Thu, 30 May 2024 04:47:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A156B2012FC;
	Thu, 30 May 2024 04:47:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4890C180222A;
	Thu, 30 May 2024 10:47:22 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: p.zabel@pengutronix.de,
	abelvesa@kernel.org,
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
	shengjiu.wang@gmail.com
Subject: [PATCH v6 1/5] dt-bindings: clock: imx8mp: Add #reset-cells property
Date: Thu, 30 May 2024 10:31:14 +0800
Message-Id: <1717036278-3515-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
References: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
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

So make Audio Block Control a reset provider for EARC, which
is one of modules in this audio subsystem.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
index 0a6dc1a6e122..6588a17a7d9a 100644
--- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
@@ -44,6 +44,9 @@ properties:
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8mp-clock.h
       for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
 
+  '#reset-cells':
+    const: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1



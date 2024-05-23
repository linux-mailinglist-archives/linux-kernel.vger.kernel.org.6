Return-Path: <linux-kernel+bounces-187323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FA8CD031
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA67B21FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A6144D29;
	Thu, 23 May 2024 10:20:13 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0B1411D6;
	Thu, 23 May 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459613; cv=none; b=oyZ7jpe23N6DdELDBt47qN2m5S3/6r4R2O7lvgjvKtXg98vEzkjF3SdhLhrqbNUjizNenyAE619xs61OI3+maIr7bKfEneCCSj1zkJFJksMg5Ut0gBuiXCmNqUnzWwpSGjPbHN28jbBAQOe85J7yCTaRE4bRxJ+6bCAy9Zr5y3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459613; c=relaxed/simple;
	bh=vwhl2TItuSUrCzO5vdVWYedHOQAkUkhYVgTV88cG0tI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=AwEoP/9Yl0SnjrpTG3JDlmYJNUzMTC5lCEXRGHgIsk9Efr+c6lcNBESPjCKvaD/p+2mjQzZif8cCe1D8qEyFDAmSOI+n8Xvjl4dOdpwr696SmKNofu+/3Dne8oG8DfWXhmeb1weZ6LgwhOvPGFOPiGqlaRVmNRUsJVemlTCzcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0955B1A092D;
	Thu, 23 May 2024 12:20:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B2DDA1A1269;
	Thu, 23 May 2024 12:20:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B4F4180222A;
	Thu, 23 May 2024 18:20:01 +0800 (+08)
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
Subject: [PATCH v5 1/5] dt-bindings: clock: imx8mp: Add #reset-cells property
Date: Thu, 23 May 2024 17:59:46 +0800
Message-Id: <1716458390-20120-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
References: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
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



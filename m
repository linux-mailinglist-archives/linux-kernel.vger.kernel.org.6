Return-Path: <linux-kernel+bounces-169299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F638BC67A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B082818F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0F4EB23;
	Mon,  6 May 2024 04:17:45 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CA3E462;
	Mon,  6 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969064; cv=none; b=sXin694aHw2As7vVFxRIliATnqfPyX0UwFy8azztQp7pISDTvJbwUizKPCP8f12hS7jYgYZUDX8trFsxkidKQdd1QmdLNbZu810/A3FYs1PXsV18x7DtcEpk1cZeAkwXh/lZ9OWDlQ3kPDInd31oqud24NdQfm1fcb9+eD5T5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969064; c=relaxed/simple;
	bh=TzUV4Bs4H8jIHBvaoHFp0CU+YT2lsaLKJRDLCI8Oy0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GdHceooJrHdt5AnogoIiEXqrw9Eh8OxWz3iBRCela8LmDlWBsgaCr31qYxMxTVheGgGLjdvFRJ2xnEuiy4Xy5yDkbmcp5UA8RR6tSy8GLyseAL96D/IbQZWDXklhfjYuopgl+aMXb/auLN5SUHIDfSYmKI3j2QRS7m//dpG2zZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 36A9B200370;
	Mon,  6 May 2024 06:08:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DDA5520032E;
	Mon,  6 May 2024 06:08:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 90088181D0F9;
	Mon,  6 May 2024 12:08:14 +0800 (+08)
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
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: clock: imx8mp: Add #reset-cells property
Date: Mon,  6 May 2024 11:49:16 +0800
Message-Id: <1714967359-27905-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
References: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Make audiomix block control a reset provider for
Enhanced Audio Return Channel (eARC).

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
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



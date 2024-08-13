Return-Path: <linux-kernel+bounces-284376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37B950050
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2F11C2281B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BA16DEA9;
	Tue, 13 Aug 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="IDsCo+jb"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA513B580;
	Tue, 13 Aug 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539009; cv=none; b=G9ydso+cjtJ5/w2nj24BWa6ucolzOAA8ePmaiUX23AEZGofosWJFGq09AO4er45pJubPtRWIb8PNccLZa7CS1yJ8fWirOK2QMKiEq0xaC/JrmHb47g2sUfq4C2pKbhyoqJudisegpW8RGgv4QqJrYOJkfmncArsKQyw6jYKsnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539009; c=relaxed/simple;
	bh=jJO6TiU8v5MPa36WU+qLw2FnLGLUyK/LG6D/HML3jJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS5icAFgySRe3szkaHFPl9+QZkg5qHCY72/Ks5GzrgXK8nH7XfuKVVglhD+oNecG5T9afRaU/6VCJ6fPQLxA+Q+MtlfGI9ANWNxqUwrk++jl+eGBsC4M11UviAiCVdS3jyTvuFdSXWJuOyi2tIFrrIhqZNl0lQkZGGCfDyD9IhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=IDsCo+jb; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42B62BFB45;
	Tue, 13 Aug 2024 10:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1723538998; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3wIUxIh2OIZTg+ViSACcdyDkRvUVlg0IoTUZUZNrvQ4=;
	b=IDsCo+jbOWuFvT62SkyixzRGhofRSxJTiGUy05j3AskoayGSWCSx+BEi7hMk8EcLBlNMbH
	MZVWHXqLVtGUnWGtLZuaMDmPmdq1Of1Vplh0fYRpVXbOBz2C90cHp29TKl/F0QgHZCmlda
	f24layMmxywIxD6v4PqDm/K7wfP3kSIEi8oUu8nY+Ye7pli8S57Eb9rdm0d8mc6tPoPoQy
	645bz6icUyKbtG5rg4zPTbp907BYRp5PFGaS9FvZD6cYVQgHutz3yWa6SVCP0e/AxaFVrs
	mWofQTMnjIl/jcFn2TFjTQRfyIJ/HuLWJjaq4H8a0I9So/A/1P1TxNvra+X7Kw==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@denx.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
Date: Tue, 13 Aug 2024 10:49:04 +0200
Message-ID: <20240813084934.46004-2-frieder@fris.de>
In-Reply-To: <20240813084934.46004-1-frieder@fris.de>
References: <20240813084934.46004-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add the bindings for the Kontron i.MX93 OSM-S SoM and BL carrier
board.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v5:
* none

Changes for v4:
* none

Changes for v3:
* none

Changes for v2:
* add tag from Krzysztof (thanks!)
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 80747d79418a0..bd0326efad407 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1344,6 +1344,12 @@ properties:
           - const: variscite,var-som-mx93
           - const: fsl,imx93
 
+      - description: Kontron OSM-S i.MX93 SoM based boards
+        items:
+          - const: kontron,imx93-bl-osm-s # Kontron BL i.MX93 OSM-S board
+          - const: kontron,imx93-osm-s    # Kontron OSM-S i.MX93 SoM
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.46.0



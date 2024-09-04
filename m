Return-Path: <linux-kernel+bounces-314602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20E96B599
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2941C244B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF91CC16B;
	Wed,  4 Sep 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="a6iFfkgH"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1151922CF;
	Wed,  4 Sep 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440135; cv=none; b=LS08tggw67H/SWdiJz/983Vp2qpaYfYizhpZ7w83DMy7aqSGMO1xjgdts3Qk8rdeRefdGAh913htsILIk+FoAPiZjZhJwAJKKDEJ+EhOubmhbMRCGNJZ6F4VMfSIGPkKo3uk5GRpy+xr2aPmoyo2DUdRLTNPTfGwXK43ww9Neeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440135; c=relaxed/simple;
	bh=Wvl/bIksF8DK+3tbNIKTjI25SpTz1Z5eyj3KATrqD2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvLBlBymZki0z3a2upwToYjiEFQPF+Ez7htv0EtOvUdMFR9VUxnR8JErk6+b3R8tSAA4CpF5QiQs1wtPgAVcgLX1yd3Svt5K0r7gAUVzFFDG9vbNYrbOZCikCo6Otv53iZgnXwv9fmSEBRyOvCFfw/qGrbYx1o7GsHETprIg5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=a6iFfkgH; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1530BFB47;
	Wed,  4 Sep 2024 10:55:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1725440124; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9oD4W7qGq/P/NFW5oQk5wHNgnqK4g4K9ByZpjl2LbUQ=;
	b=a6iFfkgHVBRUddMl2LwZhJBwd/IAeU94VhgV8OB7K2C+rksM8lO0+Pgyo0ZzxI2WyQyjol
	NPUQOWbf+gNPo1H0tW45GNg5ZNyDk1pXV26eKIL0LESEm/dTyBmb42kiiTgFkjDQlNXjkM
	7A93ba1PCbblAcu3k4gQ1mnNuKA+SslkBt0pDKbWCPnLsK2MMtGctnsJs/DmWpwgE9J+Nm
	CxlTbXu5u1Qp4aPZiXcPWjCkjim5SXApwZG1FTb3AzKpZci4ddTlyxZDbTMwjwvudO8xz7
	73IkENbjj1WUIldvxZdJNpG+fofHQh9Ms8JbYpBLNDdO2aii9RTMtbQp9UDn/g==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@denx.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
Date: Wed,  4 Sep 2024 10:53:19 +0200
Message-ID: <20240904085415.645031-2-frieder@fris.de>
In-Reply-To: <20240904085415.645031-1-frieder@fris.de>
References: <20240904085415.645031-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add the bindings for the Kontron i.MX8MP OSM-S SoM and carrier
boards.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v3:
* none

Changes for v2:
* Add tags from Krzysztof and Conor (thanks!)
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 80747d79418a0..b59449f435ebd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1113,6 +1113,19 @@ properties:
           - const: engicam,icore-mx8mp             # i.MX8MP Engicam i.Core MX8M Plus SoM
           - const: fsl,imx8mp
 
+      - description: Kontron i.MX8MP OSM-S SoM based Boards
+        items:
+          - const: kontron,imx8mp-bl-osm-s  # Kontron BL i.MX8MP OSM-S Board
+          - const: kontron,imx8mp-osm-s     # Kontron i.MX8MP OSM-S SoM
+          - const: fsl,imx8mp
+
+      - description: Kontron i.MX8MP SMARC based Boards
+        items:
+          - const: kontron,imx8mp-smarc-eval-carrier  # Kontron i.MX8MP SMARC Eval Carrier
+          - const: kontron,imx8mp-smarc               # Kontron i.MX8MP SMARC Module
+          - const: kontron,imx8mp-osm-s               # Kontron i.MX8MP OSM-S SoM
+          - const: fsl,imx8mp
+
       - description: PHYTEC phyCORE-i.MX8MP SoM based boards
         items:
           - const: phytec,imx8mp-phyboard-pollux-rdk # phyBOARD-Pollux RDK
-- 
2.46.0



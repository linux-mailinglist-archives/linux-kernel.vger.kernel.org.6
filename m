Return-Path: <linux-kernel+bounces-277760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B694A648
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694B9B2B35C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0DF1E6758;
	Wed,  7 Aug 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="D+fEYxpl"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07891E4841;
	Wed,  7 Aug 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027349; cv=none; b=e7Rn+0qrJPEmQMDAATdTrjmbENtBk4Juys/VZkYXjxW70SpCGAN2xjQhHRGv9FkozJuTZZEIfdJQYBFW07Up31Wtt9yY36BAodNPBxIZU9NtCHXw3sI7TqX28zlWpcSC7zhFmddO88r4y9RIbbz/Y1LOo2LBPAEjH64HSlhVUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027349; c=relaxed/simple;
	bh=waNHKA2uzC0vxrj0pMN29P6krV3hCTl5j7ikwLi1rIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFgqw820pjfJfArLtO7rAD/kGUnVxsoElPM1KJImYrZjsamnUPR931NvBFKuQFEg0jzMj/Fu5xW0lunftOz3ScZBIVvLa0VaDIaAYwgHUgvOx7IixJKwiMZ/AGC6Gehjnif5z4SpKwuQ6iAut9GGIwM8bWfB2ry4cUjJH0exhII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=D+fEYxpl; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1484BFB97;
	Wed,  7 Aug 2024 12:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1723027345; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9OIk9rPnKFQ2Uk5AdeHzKm6lreUPBGp+UK9fDOA/8wc=;
	b=D+fEYxplb94PHjEDqrQzyKzHxNcGA8LeH2Ep8eTvym7jTTs4fOAstxxRdTW4jITwqxUkua
	psd0eZcYMMPY02HELxCF+pMWRUEUHaUQz5Lu1qY+1r/vaXfRkYh6PA/ANIIt2gJvhfH9+E
	TwBfOylEbW+/8uNXHKDgUIMzSm7FlOqsepXU5ziL3QIEJMsxPj8DPyjtEOR6FfmxyTqUfg
	g3d2OjAegcL5vXpIhSd4jFM14hpqhKvuqjE6LrpGcJxqme6UBpYDC5lMI9+WM7ArUh0nxr
	P/vXKyDLzVtrBRP7KpcrJOm09jSWXYkz9o0/+08kGQPzXA3Ehz05lPXnfJjyWg==
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
Date: Wed,  7 Aug 2024 12:38:46 +0200
Message-ID: <20240807104137.558741-2-frieder@fris.de>
In-Reply-To: <20240807104137.558741-1-frieder@fris.de>
References: <20240807104137.558741-1-frieder@fris.de>
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
2.45.2



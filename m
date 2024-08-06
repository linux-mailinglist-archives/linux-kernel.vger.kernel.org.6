Return-Path: <linux-kernel+bounces-276561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5994956B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DCBB32610
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81838396;
	Tue,  6 Aug 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="JVb6PJ7O"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8445C18;
	Tue,  6 Aug 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960435; cv=none; b=mNQvn4Nrdq57phs7IuU7d7CvDqpdcETHADeIHLB3Am5X1hbHilEGYGf82JKpwAmlkyoIdz5LyZ8OTWFZ8L+2oOOQuuj+L66YQ5Ipopmre4uoYB5+aFhA3k6it2XDqFvNhlafSd1K7RBjSELbUtBRuoWZsZygomEDvUD208jEt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960435; c=relaxed/simple;
	bh=/ba2+rUW9QL4XfN840Tme+RQyD7mAPCf1hHMSsTJC8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3swFYVRw9oIA8M0I6DVym5oafY6Y6m1ncqj3Dxrzh4feor1b1HFm6SLlhFeAwmppdZQ52MlUY8+hWf9WVYb3N8ZDStXLAA8eLB73MmhHSS+8qz0qyHan39uN6EDZNpaQQauxY7aKXEEPX9KeshqfMrRCmgmxrdQYm3HY6Bv7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=JVb6PJ7O; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFA4FBFB2F;
	Tue,  6 Aug 2024 18:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1722960431; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6EVzCbKtozSLJ7Lyg5O12v8ANyfq7tMin8yoUXMrTNY=;
	b=JVb6PJ7OdNTaZs5qs5fzf1KheFJQipHzU9fDAxkq2pB0CjrSuoODvy7cFW9xsr/1WnjEra
	qHaKaujVmoiSQxPyM1I/8YQorJ7LsDJr4ArsHVJnxM70nnyrSKDIkls9wAKAhX575KGbgL
	MbsBoR3LARxp1nFoe7Lu53iMe4PCoqm/eajQIpyxtdkM9TxUybSFndkc62hwzqm3X6wE3E
	Ki185dR6hMUXh9RV/2lgrRYkYOynvBTSH7JHYHuVeR5QPhM9rozacZM7ezh9wCHJqlHYkY
	x/QeK5hdwBmE8KokmZqzNl7wIt638sl5jvlOIffnqPLHxW7fKNIX2nQke16eYQ==
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
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
Date: Tue,  6 Aug 2024 18:02:41 +0200
Message-ID: <20240806160353.823785-2-frieder@fris.de>
In-Reply-To: <20240806160353.823785-1-frieder@fris.de>
References: <20240806160353.823785-1-frieder@fris.de>
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
2.45.2



Return-Path: <linux-kernel+bounces-265783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15793F5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454BFB21F50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507714B07E;
	Mon, 29 Jul 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="RngoSN8b"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35A145354;
	Mon, 29 Jul 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257522; cv=none; b=p15R8cFrnrB0tviSUOkpJSDrV1d2WKqSbDQrpRLLcEqFXYbfl749e0MJlfie1yeiZVwhcHNxSd794z/R0Jd5AGWsySpHMSTdk0jb91ZUr7uC5KQhDi5FRGrQOSw8HenfT5is3Cdjm2BlZCfvM+ogUlJcz3cyPB4rJXlQVJtZXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257522; c=relaxed/simple;
	bh=2s3K+W2K5BwzRal/dCUG0Wez9p5BZSGi6Z2ofCfRdgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE05UXTviay8sQTFWximoEeSvhzx8MReV4U+T5L+sGp4afVhA+R9WJtxVlgUfma8Z/16xKBqaQahkD6nG/M5rbOXcENTuuP1zKmp7SMvkptouJqU0mmvrJSDJ6rQpHd/VJrIGKpus2mhnukPf6SMjJNaVNdBbJ0kXFLcmTyddjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=RngoSN8b; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFEFCBFB46;
	Mon, 29 Jul 2024 14:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1722257165; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=/FKYJ5kU6AojfpsXieGPiN1ZzrwwUqLmFvFw3Qx/Km4=;
	b=RngoSN8bAL6iZXmXfFu4cZlDUuf12KsGTHjewTL62JyqTtKzKVuZzImTe5i6ucDqLhU2Lu
	v/Yw64pgt+hsKknqhpQoCPogSoh3untTu7/Zh7/m39Bg0kSjH//G82uWsPegAsH4OM/aMG
	onMlPhCwxjYh7jdlDhTdlq/wEFKVcNMbt4fr+3nB0P8zVotx+Jdjwiaf8X8isB4EsK/PHK
	wctT/pOnXkX5IyPVSDHSa9ipkp0EXYqGHFKxG0bYW0bhafjRdInDWueNaoTofzyg94GgWk
	JOvM7107lZNAWnaBrgbrY3OcOK2zEcwWmppqB/Xmcp3nA8FbP/9jEw7Rhpy72w==
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
	Conor Dooley <conor.dooley@microchip.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
Date: Mon, 29 Jul 2024 14:44:23 +0200
Message-ID: <20240729124450.118497-2-frieder@fris.de>
In-Reply-To: <20240729124450.118497-1-frieder@fris.de>
References: <20240729124450.118497-1-frieder@fris.de>
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



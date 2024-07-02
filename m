Return-Path: <linux-kernel+bounces-238052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872B9242B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF201C24115
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D61BC093;
	Tue,  2 Jul 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="vvb/W2Rk"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BF16131A;
	Tue,  2 Jul 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935092; cv=none; b=i3i8Yy2Mw6v5XFLg0H92Ktg40jeHUHIa/LiFqy4FHjO1dPYf+94TH5HGcfMTAEH9J6a4gedK1IAotxeb24l+5dNucLGF/WmwgIafUNKJOxSYyTYR8FxIbTLBO3IZ7vjYyd/wlNnyF6j765p5Xr4i8eXYwx66Kjy7bJX5b7hbx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935092; c=relaxed/simple;
	bh=U1JugdT9aRR+ZYAfw5Cj2rCc6yrbD8hnLYZbgelYAuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p87NyXifDqw3OkmbtGmbAl460CgvhIEg8cI3O8rtsJVPmmV2QTW0jZb1cSDn6UpBTNC/Kn5NS1my3NViiSVNYr6SDlviiMo+drSN4FbDRZmHymsx8BtU8iRe5Cnq6pEceeDq/SddvRzZ3x8GywaQ7N1ODcJMtLItIEn/dyCqvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=vvb/W2Rk; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7344ABFB3F;
	Tue,  2 Jul 2024 17:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1719935089; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=b/k/G5ujt6jXc1BK9KQvcPh4+PBbMuNUK3X7txcMX/k=;
	b=vvb/W2Rks4cnvNe9hMDB1l9gTjP+rkjMTVFzqmxBYxhftjhPVJyu+zG5FBo7fOsPlbyUiJ
	Gyx/T35iCB53tFZ0l28b0SP7GiQ298lMPARcV/+ywdfg/9koDYBFyJjAVJE5PqC2ajuw1e
	MpS/wLjR0Bs1Jsyk6aMsGobyt5m+VoFWWldLbGxhX8XSE8lDrWvTFjH7RpJWCMoclEV3+k
	LA1zIXY6mM9aVheitaW9Ypb+M59ZiGxJZKu3tWKiMD0ia2yVttGd2G/mY3sVmsfR6TnumO
	Irt+h27RCRzpajOdxmv6TrlsfhqWtymQF4F/oqo3RWrKDguxC9mE/MWwWr5T9A==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/3] dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
Date: Tue,  2 Jul 2024 17:43:19 +0200
Message-ID: <20240702154413.968044-2-frieder@fris.de>
In-Reply-To: <20240702154413.968044-1-frieder@fris.de>
References: <20240702154413.968044-1-frieder@fris.de>
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
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6ae..0bda153c38705 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1095,6 +1095,19 @@ properties:
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



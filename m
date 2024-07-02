Return-Path: <linux-kernel+bounces-237611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FC923B78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFF71C22200
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D6158A3E;
	Tue,  2 Jul 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="vunU46Ag"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF414F106;
	Tue,  2 Jul 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916388; cv=none; b=e7WWfxhpCP61ExRZdOOXZ2bJrUGn0jHHeT+iR2PmPychMa6G9ngzFdkIwOKgvNKqS/PHO5wxCOHWaCCBKXP7GLib73MVP3WDFxgnTPFjiuxjgwclyVE7X90KbAK9rtmSyXUTyw/urk+ZmOufllcYTk2fJQrYZ0VOWOAkmef4g7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916388; c=relaxed/simple;
	bh=IIdrde44xCAX9clc1/uANi5UWVhvF/4jtVO3weo17XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpgFIHzOTqr+1vGW8/I3k03g5PZtpvpzW4bHcdxY0nVtI1rUYUMBRxzFcw1L2WoOjXPzoIqorLD+hTFoR+pZ7sG/32YaMVR19EcQMODyAacwNCWpMeVTKcLq566TlcwUIlT0bRum7i7hCFbb4N6XIWtCvWi2r69cc9rL7YrKfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=vunU46Ag; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59518BFC13;
	Tue,  2 Jul 2024 12:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1719916381; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=A+JqgQw0YHH82MPAAJQ1B0axOEVCaxmxVuscKJ4O+LA=;
	b=vunU46Ag3somu7du4+5nmdkiI1xishO9OnCS9aCtY7IYqLp105EbAu40k9ypG+StwrdE6o
	R3x3wb8bs9nj0sHG/xCfw5eWRTk/pc9HmySPqJ1SVF5HmkWXqbBW5JEQ/5zfKPfHro6Caa
	1Hoh652FJXgQBTf1hic8UylAlHbT5itu15GysbxqFpFIKeXPXX+h2pO3xWsJ6cStn8k6zi
	KrWBCdRpjHdL1zVryMKG84g3GF8L6ifx/vsnW4WOcbD1ecmaJUKH+oiOWcnKKqSCCcy/0M
	/paUbkLUkzcNkmv3I9Tp/L8syoUcZpiPNMjsVw9WtppBCi/9cIW8Z/YDfijChQ==
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
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 5/7] dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
Date: Tue,  2 Jul 2024 12:31:17 +0200
Message-ID: <20240702103155.321855-6-frieder@fris.de>
In-Reply-To: <20240702103155.321855-1-frieder@fris.de>
References: <20240702103155.321855-1-frieder@fris.de>
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
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6ae..5fa1494435011 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1318,6 +1318,12 @@ properties:
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



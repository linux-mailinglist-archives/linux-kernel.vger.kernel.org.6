Return-Path: <linux-kernel+bounces-265784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443793F5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0968D1F22B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E356149E1B;
	Mon, 29 Jul 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="CqF08xnD"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AC146D6D;
	Mon, 29 Jul 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257522; cv=none; b=pd5R5xjnLi4PCAnO67EUC2tDf92Z3/ofnB8PJHkUyrF/OjE3QuJ2B2BBT8x8yPOnf9H1JacODipWY+vYzZlbavE1URLWw0lo81I/6sVpPgZIMbPepXUDh2kVlkAUiXLUEF+WI/Cj+qku4Ug937raSebA+CoaeEETcw+FR2NYV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257522; c=relaxed/simple;
	bh=sVol7CCKvMaaj4cV778tSQMTceaUobuUv8VI8vIyV3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5NfQvjQjQOp92jTIzNfqXRX5Wl/51Fl1Y1tlNhyr0msRf2zkFFRLDvm+VkT1RQn/dKWUKAfeTblUoP7mBUkkH9i7JKOvqvmWcwSB8iwE2ZDlBjhewZn0kLhH3ueHv01+Axcrw2ueIaFGwyrXXMjlLoNNCbSZxxHDApM2bRgx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=CqF08xnD; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0A45BFB30;
	Mon, 29 Jul 2024 14:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1722257163; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=41E+2ee+3+BIiOkpYpN0gRFPVvr9+0trL/IaKGKh1Wo=;
	b=CqF08xnD+Uqyq5EmLVxFgp85xs1ioES7Ka2TTSncaPdpw62pTTBqxMHZCxDR4mUORcAX8w
	Bo3QTJ9LjRpYft4T/SNhR02m4GvYd1VxpPo/IgwJSRmYlbqi6F2eyXu2PLFOEDTBf+SlaK
	sv+5vhIyRu6RNqpyZu6f08XYLDa8ENOrHeebWUVKb5LB/2I0S0quuyJzzO0EOHLH1Aysiu
	F4TJozOmmtHjsNx/70u6tmYKRQZbLcRro2UNe6ZSSuNuwKirGPoHBGFett2FAAkmjBIlPL
	g+ZvuhEt/UaDQgVUfdtygeu1HqMmq1b+jT8SRKiKK6RiNDj9zvPK8KoO7ctVWA==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 0/2] Add support for Kontron OSM-S i.MX93 SoM and carrier board
Date: Mon, 29 Jul 2024 14:44:22 +0200
Message-ID: <20240729124450.118497-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Patch 1: board DT bindings
Patch 2: add devicetrees

Changes for v2:
* remove applied patches
* rebase onto v6.11-rc1

Frieder Schrempf (2):
  dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
  arm64: dts: Add support for Kontron i.MX93 OSM-S SoM and BL carrier
    board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 165 ++++++
 .../dts/freescale/imx93-kontron-osm-s.dtsi    | 547 ++++++++++++++++++
 4 files changed, 719 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi

-- 
2.45.2



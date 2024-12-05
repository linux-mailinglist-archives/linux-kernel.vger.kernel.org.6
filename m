Return-Path: <linux-kernel+bounces-433510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE929E595F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC51649CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C64218EB8;
	Thu,  5 Dec 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cktHtQo4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XhQLwN4s"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6431B0F22;
	Thu,  5 Dec 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411332; cv=none; b=AU39NHWZeMoyooZv7Uf0CXNiZh5sG0qZRx8NiGPml8R9ZwPXtpYShhped37qZpTNzARPreKEy5YcpD9kLjcKIYtgY8kKg+QYgbjvniDXhKqYv9gi4NBIfux5EJJeXPMvDAkZFkbfWLDXwyQeBqpqYcGsUKgEaYOUZan3tAsDg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411332; c=relaxed/simple;
	bh=v3fjsmmgBzQzwJmDqA8Iowx2TwoGzK5mAty+gspRrqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e29CfHaIx+4XGfVEztoR1cb5gf5a1pML44gOkVasctB8bYIVyxO7kEewmYMs1d/5Ik9HnMcMQdTJQbmyLxKyx25c3+R+Dy0gI3gcqhVz3wPtgb9obhLbuGdHGe/z9l8wVO96E0QYZBUS3X8OJ4mAmDGglV0IEbI8X1H4YXVnqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cktHtQo4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XhQLwN4s reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733411329; x=1764947329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=owlbvx/kRHzonFJ8nb841FHj32M/qOU85thSp1YvB0Y=;
  b=cktHtQo4o2BMoNJEhvnjJIxddOwUx3mySH/lhEYRYs4u42W/kEI8Kbrp
   i3pQvxxBHQ+q8vijPiDzSS1Yozd2GNDj0F7xlVD8zGpeqjhuxSErnaZuq
   A9NMLGr9skFlzisefTgG63FOcodT2sdxKGDYWLSBh66EOSGjK+R/rQlty
   nzYLdlNz2XwZhMqGezNplMhQi4BX92MfOabKPC80vng/E/S6lyq6l8cFo
   a3Omw4hCI48djIElCpok6Y4K9Z/iGnbqd1/3ILWM7/j2UhqS/8wPwxB+G
   d/Nc2w1b2ViZwBeR6huj7tPWi1KoWviW2x0JawMiReXvichCEUBqnz1AA
   A==;
X-CSE-ConnectionGUID: mHFpWIMnS024qwk9ZfiRkA==
X-CSE-MsgGUID: Lz2SSl9LR267uOFsz5wzCg==
X-IronPort-AV: E=Sophos;i="6.12,210,1728943200"; 
   d="scan'208";a="40434849"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Dec 2024 16:07:38 +0100
X-CheckPoint: {6751C1BA-1-90CD5875-E0265C0B}
X-MAIL-CPID: DB51403153CCC72A33CFE8CA058B14B7_3
X-Control-Analysis: str=0001.0A682F26.6751C1BA.006F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2481160B1E;
	Thu,  5 Dec 2024 16:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733411253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=owlbvx/kRHzonFJ8nb841FHj32M/qOU85thSp1YvB0Y=;
	b=XhQLwN4sHvUZEtt/WhvaA0p7WZP7JzhIUjPBjgx+6tojBH6drdnfW52cxErD322YWkBtMA
	2Vrsz2wEUkomorScQng+8HwMx3C1oL2Dtz+2wKIw9yk+LAZ9myudh6cTcNGIbNZPrGYlVM
	MO8CP3r9Uawz95K+9StQ1cXeoe83uiIxiK4tHgUkAjI66Xx/vCzkDWQH7CPUFO5kg6u5Bj
	l1kdxOSOuVc8LfvwMb3Y3o+5+oISvgG9SvR4lrQkFMlRY89n7eBkAcHErdcNTb4KBmJN5p
	t4PYASIHcCFpAb3nP2sPtelD1mhQoYOp0+IkQzYc1dxezkHnluZWwyT7pidi0g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/2] arm64: dt: imx93-tqma9352-mba93xxca: enable Open Drain for MDIO
Date: Thu,  5 Dec 2024 16:07:28 +0100
Message-Id: <20241205150730.3132807-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The board has a pull-up resistor for MDIO pin per PHY design guide.
When MDIO is idle, it needs to be high and open drain is better
to be used here for power saving.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Update commit message

 .../arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 599df32976e24..8e939d716aac8 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -627,8 +627,8 @@ pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			/* PD | FSEL_2 | DSE X4 */
 			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x51e
-			/* SION | HYS | FSEL_2 | DSE X4 */
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x4000111e
+			/* SION | HYS | ODE | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x4000191e
 			/* HYS | FSEL_0 | DSE no drive */
 			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x1000
 			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x1000
@@ -659,8 +659,8 @@ pinctrl_fec: fecgrp {
 		fsl,pins = <
 			/* PD | FSEL_2 | DSE X4 */
 			MX93_PAD_ENET2_MDC__ENET1_MDC			0x51e
-			/* SION | HYS | FSEL_2 | DSE X4 */
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x4000111e
+			/* SION | HYS | ODE | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x4000191e
 			/* HYS | FSEL_0 | DSE no drive */
 			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x1000
 			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x1000
-- 
2.34.1



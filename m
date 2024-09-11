Return-Path: <linux-kernel+bounces-324316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5DD974B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A301C23D67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660513B7AE;
	Wed, 11 Sep 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HSBXOIYh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PX9Bu95a"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793D13B284;
	Wed, 11 Sep 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038861; cv=none; b=cAO4a2Pmn0dO6EdsoNbO/kKyfTI1I/CmWrhpfDFAohb8bWGNl0QIh2lED+ec8qBnt/yYYVUcX+JMaq8vAhF8bwrTVPKi3GSF8w1g0fEFvkneub1dQBsvkIymT18sfDfQaRfIUmhP+BxJe9feeWhF/izEzGHC8nT63qHKdHDRHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038861; c=relaxed/simple;
	bh=VA5dureEmxFcu/FUaV7IedgCxYgv0y8+e5/Q17EGoro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TfMDyW3H8eGHZcoDRA5K4FUGYYUW5Lg0oL8L69tjhYOCl5Nhjoc8LheRDninJcQCzq9NkHx5jL6QWVfw21sgmCPUqFJtiw1pzvfTFTqQxKZrBB2QfSfs5KsT0mG4KoXv8tHfy3eLjdmxgQfsMqlV85661jBqjyNgNRLFqfaWUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HSBXOIYh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PX9Bu95a reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726038859; x=1757574859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pLwl7PjxbyclbLwugzxSxt4q8mheb5QQ1d2tg3yLFYo=;
  b=HSBXOIYh8tcEGrR+8fKp7sTYOOFYn8zPL/E8O86UUTylSrU7fy00oLRx
   9CEze2URVhQeA0fNmbz36FoPCPHt3E8GznG6/cyU/QsneD6Q6RsJZsuRb
   IkcSGKUbcyi4WhRtipltoc3GSQRgeZDfJZ7I8/yWgweot00LUNqrFgqMn
   tim7Db4HWpGzbvqPblFHygPtJWE3GUAJyO00hDh8K6bgDzUV8ehkEoZqM
   NdjiHUgGHsjRWYYnVsgYy+LVb3jNpLhGkG/CY4eB/4crdQd+LxR8L21Vq
   nxwXMScnv3MB22YZbjTAwE+hLZB3IWHcker4v+mU1dnA/RT10YaJwhrsr
   A==;
X-CSE-ConnectionGUID: DIZZy+MQQw+IUAQkqAjX6Q==
X-CSE-MsgGUID: ast7DkavRa2t1Wak+21qdQ==
X-IronPort-AV: E=Sophos;i="6.10,219,1719871200"; 
   d="scan'208";a="38878854"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Sep 2024 09:14:11 +0200
X-CheckPoint: {66E14343-2E-E520F13A-D17B83D9}
X-MAIL-CPID: 9295D6CC141ACF1FB26C1E0DBB020CE6_2
X-Control-Analysis: str=0001.0A782F1B.66E14343.0192,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7D9A16C843;
	Wed, 11 Sep 2024 09:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726038847; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pLwl7PjxbyclbLwugzxSxt4q8mheb5QQ1d2tg3yLFYo=;
	b=PX9Bu95ag1wZiUFkU3Ehp5wBUgNOKZTfgsF1wmr+g3Ywqq5wH2n7lSsPgs8Mq3HAD8RaRk
	mvQVfkfjVm8sHMJqU36RBaQWwKtM0241brGjpyEBHVG5jxRiCJzlKaoVre5TyJKepyxMdQ
	d4TUsRhCGQDl0Kr1GuYGqtnO5z6aruU7jeZlIXpjBAFKGTP2hw9r6DwOZ0EnmLj3aOzMaD
	QbBtvE/XbKfSA9HwHOrwAsPj2p9M9Y1/Ez//On6gcvT5ee3isgkm3RFftdkewpWozhB9HU
	F4sf26z2GN/Gv4grsuWxVvwGr/4nWjnoG1Jpn6QDw+Q14WYABvc4b6aGEzSKIA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dt: imx93-tqma9352-mba93xxla: enable Open Drain for MDIO
Date: Wed, 11 Sep 2024 09:13:59 +0200
Message-Id: <20240911071359.2971191-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911071359.2971191-1-alexander.stein@ew.tq-group.com>
References: <20240911071359.2971191-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Follow suggestion from hardware team.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 0b4b3bb866d06..2e953a05c590e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -597,8 +597,8 @@ pinctrl_eqos: eqosgrp {
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
@@ -629,8 +629,8 @@ pinctrl_fec: fecgrp {
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



Return-Path: <linux-kernel+bounces-324315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D0974B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A98E2865F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3D913B2A8;
	Wed, 11 Sep 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bXuIOEwF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MWmRfGTu"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0B1386B4;
	Wed, 11 Sep 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038858; cv=none; b=YAmYdzV9h3ae5nKgld7RuaIvbrkQPU7VORClK1fypqRJElAzxyTe0tmFWCASY4nKJQmyilL+Bap0CErbkV9HgsewxWjSgGOu2VRLZxURY1psGuybVMIB2e/kh9SLylndC5Af9jDlthkuYBTyoEH/IavF9aMNtUuePsmdR7H0Sx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038858; c=relaxed/simple;
	bh=hr89wgB1/J8rGaT1KmZR7XdxXWNUsD+DfbxPG36o13E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gPlsxvqKEhX8ZMc65R5zMGtDYJ2wnqDulbKvRd5642WBViL87eC0DDPHiUSohFgbAIexyTPEjmDP7dWDgyUNsXNHyzoQBNezx0pdSq0Kp/ysHH8D0DGzQSu1vqOmhZ5qgb/UXIFJIHe27YWUjqKj5UmfU4JIYyoaprYZRBEGRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bXuIOEwF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MWmRfGTu reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726038855; x=1757574855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J9sQqcrdzpZAVwyHKOUoU2D7ORIOhT10mqYSK6NkKtc=;
  b=bXuIOEwFmjHDWnKynnn2Tt0N1D12v3MLNdped2Dhiurzx4nG/gj57FHo
   5I3dyHavmCreutAZ2j2GAIDsv5kCDCABaN0R3F6nLHq6Mz4zMswCEYPRg
   WlnIghzNhGO2A42soUhIh7idu7dPdtMFyUMv1/EWYkLDvmVnyZPUuhKXm
   m/tofvPwPgMTGyOBSMeT+1Hm5CluGJ4N4XcKSFGcKb4Naey5M7n91VhJN
   CapDklj7khEa9ykMdEyK5b9/yUgoAQazbpbQCGsenAh+8+dlyzVfVo4Py
   LQF2auR49METUebt+GQyePlm3zHFG3TlCxlzjTSx6RltHWlH0sXVdDSRC
   w==;
X-CSE-ConnectionGUID: Y7K8uoWbSh2Tt/QJfUZt4A==
X-CSE-MsgGUID: ZbiedCMZSoyn1YRzzbbZ8w==
X-IronPort-AV: E=Sophos;i="6.10,219,1719871200"; 
   d="scan'208";a="38878851"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Sep 2024 09:14:06 +0200
X-CheckPoint: {66E1433E-33-6568578B-E2E34638}
X-MAIL-CPID: C9E3A4EAFBEE2948462E6A21019540DF_3
X-Control-Analysis: str=0001.0A782F18.66E1433E.01BC,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59CC516B90C;
	Wed, 11 Sep 2024 09:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726038842; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=J9sQqcrdzpZAVwyHKOUoU2D7ORIOhT10mqYSK6NkKtc=;
	b=MWmRfGTuheecwPIuGi2d9YweWFu7aj3rukcUsrUyJY376u7Yi5YvtPBTIxPOaTsg888PIr
	zpUGHOnDeFA/PAlSUKcjeKEoJes9u2zMQZOPMxYBnV/q7y9ht4zp1D9Q/fsUbnxXNHSiuk
	xtFcVFlk/58U6AzYbrX70Liv2zkQ8XthfLJtNFKCK106FlwYOPZFIx6oDX9hSOEZJPGkID
	c7gmym7VE5HyhNWZYDjq2D5yoYemNkDvJX+VdOZc+AR//Eo4aW3LYsx8he9sLX7nJ53wEx
	bg5xu2wGFrK4ryTc9qJp7I2sscJsCBxAxq6ILC0tCk+gbOBQJbk3X+4bH+qb/Q==
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
Subject: [PATCH 1/2] arm64: dt: imx93-tqma9352-mba93xxca: enable Open Drain for MDIO
Date: Wed, 11 Sep 2024 09:13:58 +0200
Message-Id: <20240911071359.2971191-1-alexander.stein@ew.tq-group.com>
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

Follow suggestion from hardware team.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
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



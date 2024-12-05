Return-Path: <linux-kernel+bounces-433511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB729E5961
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670712850C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921621A42B;
	Thu,  5 Dec 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Uxa2Bdeq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DJRRMfH0"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8221C17A;
	Thu,  5 Dec 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411336; cv=none; b=dRZ0vXn4xqoBMTVC0S4NQKO4ehJN4x/FmePnh9hGtckFzVoU9VjZq/A8oFL63/g8nrkxoCWQUCC9hYy5F9U7NUORFWIW63hHbY/RcRRTXbJufrHEuunFkOfAyQh1H9ZAlJgQz6/KCchYA5OCCChfO0fdL2a81VzybeJAC3mZ8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411336; c=relaxed/simple;
	bh=wUItljh0wOLzIOQydlmjVTP6wmRh+MNoE9QFAebbE4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmIQMqU0+FU+FyhEk87i+eXE4c6U6Gmw5cOdK+K9Ceqc/23KqkHocdKBHJ7NzUe2TE+Ik3fGhIJq16uyfrySmdb2WTS6nkBiWM2ceEcIN4/jGfPwb3X+1e/vlmWB7g2idLjNiHrj+OmncV2/9yQwt+aysBX5NYxFpHn3tEPC9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Uxa2Bdeq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DJRRMfH0 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733411333; x=1764947333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smbLgrckE25I2ak+4aah04Lb2EF2OUKb5fz0/VhJ75I=;
  b=Uxa2Bdeq4pxrFy+g5DTP/PwQ7wFKt9R3K3BUWxBEywGr4hwGvJgnspOT
   hVlpfqc/e5MFsTKyIV44hWr6STW3INURLyls/MO2CYi5i0fvEEHWZdSkT
   NDEKMTGfgXSkaOSpo4HrFjBkNiBK/rWnI9C/gvFD4AK3ogj+rP+Zoa/P9
   V/5pUOlinMAyAJ20K75zPMPsMzHL9SyeHBCs5d4HzoVgdEez98bfNXOm8
   Zl5umSbP1B6857oa2+NI+6bvHhzD+vIZtgJvg+EGzifc2FXFwwRRgu5cV
   bEbpkoIQhI1sl2ocKQ4XvxQsTNNGl9uvex1A4iZ8Wkgl+054ijbjnrp9e
   w==;
X-CSE-ConnectionGUID: Lq1MR0QGQ86NvTiQJl2PRw==
X-CSE-MsgGUID: DbLBHJfeT9am2vHox1kHow==
X-IronPort-AV: E=Sophos;i="6.12,210,1728943200"; 
   d="scan'208";a="40434854"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Dec 2024 16:07:43 +0100
X-CheckPoint: {6751C1BF-25-D31EDE1A-D52D6119}
X-MAIL-CPID: 24AF9B8854DF14342AD0D1FA9D6FBB27_5
X-Control-Analysis: str=0001.0A682F18.6751C1BF.00B9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBF08163400;
	Thu,  5 Dec 2024 16:07:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733411259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smbLgrckE25I2ak+4aah04Lb2EF2OUKb5fz0/VhJ75I=;
	b=DJRRMfH0BmXxQ69J9qzYp6PivF8XSEGNBASYXXiYuJd/rZqoSRiRQc1vQVCVSCckroofek
	2Y8KOGe+A5QoRIg027e2s+hwKjzUnPPUAS2W2OVOGhzDUoITPb6b+E+YMhWDPRSnQp/JzL
	wEnsUQGdXNPEYScdC/+ckaEQneDO/ksHM18vHH+pEDGhxonL/64pnerxGivO5R39U7G5jp
	xma5cK8UsJFf9aV79vD5hqmp95CZYM/c/gi8vRrq/XUZncy/ABR5sFa6ASBiRxb4bzCChz
	OhtDoF/iHQqHvRqdUwXXWNO44K3DI/irQWT7Hrf7JE9d4vKVRyQTJSUkV0J7OQ==
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
Subject: [PATCH v2 2/2] arm64: dt: imx93-tqma9352-mba93xxla: enable Open Drain for MDIO
Date: Thu,  5 Dec 2024 16:07:29 +0100
Message-Id: <20241205150730.3132807-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205150730.3132807-1-alexander.stein@ew.tq-group.com>
References: <20241205150730.3132807-1-alexander.stein@ew.tq-group.com>
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



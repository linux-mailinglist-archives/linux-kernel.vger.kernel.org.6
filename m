Return-Path: <linux-kernel+bounces-304926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B49626CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE3B1C225DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C901176AB1;
	Wed, 28 Aug 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="m8CDlVVK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Vi3Bpf5K"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17FE175D2F;
	Wed, 28 Aug 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847620; cv=none; b=XNPiT8OPM/bUT+dSxX/dfJR3l1w952KnfBqqrbnyokVoEPO2wf+CA6BdFK/LkohAEzcC/DzPCiy1BMRKaq3zigm+LnTLUp9R8QCUMCuX2XOeWYB+mot1TDGt+8bCRUD9FeT9Rkl4OpWLvfQlEoRxGwAcyHGLn2U7grO1y+jaf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847620; c=relaxed/simple;
	bh=FduBlH+PbhQgMyjTUPw/uepnj8ZIQdPKqM7bwXQHil0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJi/NJs6S2ZMP2YLTp/GkXtnxzlhmiaYCk8PUNODTxe5O3clVu71gclFl7rYcVHvCdm2phDEywub7cd69ar1/kzeVvqQWmVUPR+X+KIVnow6ugw2PM/FE34dtf4GuU7tLt5FTSfIQAiYluWx7TimOMz2s5oJyGYmdGGsg4llWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=m8CDlVVK; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Vi3Bpf5K reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724847617; x=1756383617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qnq8KAYSyATof497gV1nsPlICYuLSZT7I3WHHgBegTI=;
  b=m8CDlVVKW1/fm9xLHIikBICI1izrF3PDu9uIeDV4ze7PQtunJrUgak4Y
   bciZq4p+4rJOHolqzw8C1qhvC3aPZvtckP2P0o7KarrYkWMXmTMkLvLu4
   gLEE5frU6jkjWWFtjDro+HMdLRMOOaXoxdfe8IQOJU+UAfUQGNpPoxlkD
   upI2tmP+ITWm836RDregy/5gDC/4mP526ZQ5Kv5IlRCHBbjy+SeTco6m2
   Azan8jKiiOi+SgaRCUvjJmtGEp+VWB3y0MrjH8t8LtDR38MXLejQLufly
   ro5gNhMerL6Ll796G8NKsu/JXT66EL+64+BrVUMXsgtHTCQhmriMcOL8C
   A==;
X-CSE-ConnectionGUID: +XqLlMaCQ0mq8K8sIKyQIw==
X-CSE-MsgGUID: 8ZBtYJt+Qo6KNo7/6bZUgg==
X-IronPort-AV: E=Sophos;i="6.10,182,1719871200"; 
   d="scan'208";a="38635570"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2024 14:20:15 +0200
X-CheckPoint: {66CF15FE-18-22BB8E18-F5F6D0B4}
X-MAIL-CPID: A8EDD58F619F58CD113694072C0EDC59_5
X-Control-Analysis: str=0001.0A782F1A.66CF15FE.010A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE371167A1C;
	Wed, 28 Aug 2024 14:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724847610; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Qnq8KAYSyATof497gV1nsPlICYuLSZT7I3WHHgBegTI=;
	b=Vi3Bpf5KSlreXRmTk1Wj+B6Mx3lyXWxLuk+hHyJgpgWqMzwQajJNjLFyX1r4AvRZ/yY4v9
	xiQnrdw4D1+9E7fdxhia1aJ4ayAp27NBUIjgp+z76RzDrVlSr5m/0x+nfVN7aEVTk0P0BJ
	I2x18dXQTCVEHy9qMA/F8LEHMb4MVST3EY1Ca5P/VbbBgAnDtNJ2a7jACczKCYaa7ecsd/
	fcVkWdNTBfr2mCDjzbzZ8Vd1fCmXNWTtg1GwGjme7BhvRwW7kJ6mGLxCF3X1kvkfdCv7c2
	3xJ+1jDtHUUnTICIVbkfL3EH7E/bCsBE6KlBnJ9Z8UjD2sJTQmmPJ1HFRXfDpA==
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 1/4] ARM: dts: imx6qdl-tqma6: move i2c3 pinmux to imx6qdl-tqma6b
Date: Wed, 28 Aug 2024 14:19:56 +0200
Message-Id: <20240828121959.1268463-2-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828121959.1268463-1-Markus.Niebel@ew.tq-group.com>
References: <20240828121959.1268463-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Move the pinmux entries to the variant where they are actual
used. No functional changes.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi  | 14 --------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
index 344ea935c7dac..6152a9ed47682 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
@@ -59,20 +59,6 @@ MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27 0x4001b899
 		>;
 	};
 
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b899
-			MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b899
-		>;
-	};
-
-	pinctrl_i2c3_recovery: i2c3recoverygrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__GPIO1_IO05 0x4001b899
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x4001b899
-		>;
-	};
-
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10 0x1b099 /* PMIC irq */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
index aeba0a2736002..53e78f1aed385 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
@@ -33,3 +33,19 @@ eeprom@50 {
 		vcc-supply = <&reg_3p3v>;
 	};
 };
+
+&iomuxc {
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b899
+			MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b899
+		>;
+	};
+
+	pinctrl_i2c3_recovery: i2c3recoverygrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05 0x4001b899
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x4001b899
+		>;
+	};
+};
-- 
2.34.1



Return-Path: <linux-kernel+bounces-284209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72994FE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743E11C22A72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDB6770E2;
	Tue, 13 Aug 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ewMWNSmZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="h5a21ssW"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1056766;
	Tue, 13 Aug 2024 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533436; cv=none; b=FPU0TLpCrAEhqD5XsfTSh32Q7wL3SE5cI4EsffVXuwLKNZTHnLEEkjmXA/VuqhjsU8jVTETe/y/BTpSdXszH0IktxWBCsM6iavuiCb/PHJLulVyjP0jDx5xxFl6/knaMaWidw7P+mCSpg/FkfTModt+8JFlC6qzPdwr4EDxFRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533436; c=relaxed/simple;
	bh=yN5hciNCtrPYkD40AnFPqU1ClpazLUxvTKGvjfEfBSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcHXUJeMuvFKl7YYNqA1zPcSljTo5dCJpD7pkv+cvWCKVPYYT2EW5ZXAZmIEZYEkTgyavVLJxoaul870+TMRRYA+CLUwB3B8Egfyu5M6FY2j3OFUqeN1wU1xAxV9iEI+AqlpOwxKuxNrGDq7xUoeEBEImahwVyBTgfSzod06484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ewMWNSmZ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=h5a21ssW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533434; x=1755069434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CAoIspGxuFawan3Rq9OWHfZxHd5dmwSq3gMPV66B9Uo=;
  b=ewMWNSmZACigFyK/KXA2wRzlzhRla4TY/nXbH02WyveK1yplh98LznIM
   KMAxj5gdQ25R8AeG5bDMf4T2BBpNYS8FD5Scb5tuiFf4ufrUlPuJSgMa9
   6FiPOA7IoWFFnns0CnIYyQ6kKLk89yzdm9PUtrE6ImuH/k9r8jqsuw3SA
   tDPMpTcEBfoJKHLHHTfnko6Hslf3Ayg+sdCWH0JG2AdEfklPuOjKckoNs
   Z8uStQFzY4eYUAXNGgQHCcA35QELpx5o8VoK1BIMNOMWvcnyaX0B2+6/9
   ovhhy1zvkQHnfqFFYsA1so/x3VBoBMD8g1Px0xJztcm7mfSXRplZJWKa6
   w==;
X-CSE-ConnectionGUID: iw0N9FErRoSNQrXp1EyGUQ==
X-CSE-MsgGUID: JqynubtMTmyvgjAFwo0ZgQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375833"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:12 +0200
X-CheckPoint: {66BB0878-13-E9ED6009-C4B0BEC8}
X-MAIL-CPID: 0D6E200814FB3F5FE839F13136258E73_3
X-Control-Analysis: str=0001.0A782F19.66BB0878.0171,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16B7216A128;
	Tue, 13 Aug 2024 09:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533428; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CAoIspGxuFawan3Rq9OWHfZxHd5dmwSq3gMPV66B9Uo=;
	b=h5a21ssWuuqTiwHmS2kbsyeit6aerFjmppUrR+4QjYuAHWmGO8URg2gmMNTB38y3k/0kej
	fnCkxP9LfeL34vENO8O0uupoYfcaCH3KEel9rjo4udxdcpvVIAidK4GS1SB+Rp6NUSK+8/
	kmfutg8r5SpXGEN2HMLr7BVyibZ0K5ueDc2PFkBSDP639fB7i5D/ry+a8H1JFuDmc07SBn
	Do8O00fmE+XkP7P+JcB9Z6bWvasnw23QHbUNKBgKIUZHMDniXWlR1Q3GwF1vShK7uVn+Nt
	Fmu6SsxptsXI2N0tAPYCHOfu6TZDUuEQSXjZliMQUwEpKyKEA4WmvKjRyyqbWA==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] ARM: dts: tqma7: change licenses to use the same as imx7
Date: Tue, 13 Aug 2024 09:16:27 +0200
Message-Id: <20240813071637.72528-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
References: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

commit 241f76b24b6ea ("ARM: dts: imx: Switch to SPDX identifier")
change licenses of imx7s.dtsi and imx7d.dtsi to
"GPL-2.0-or-later OR MIT license".
Change licenses to use the same licenses for tqma7 device trees.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index 52869e68f833..a25376296f64 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 OR X11
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Device Tree Include file for TQ-Systems MBa7 carrier board.
  *
diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
index 028961eb7108..95602ed1e6c5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 OR X11
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Device Tree Include file for TQ-Systems TQMa7x boards with full mounted PCB.
  *
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
index 0443faa3dfae..e9a49777d19d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 OR X11
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Device Tree Source for TQ-Systems TQMa7D board on MBa7 carrier board.
  *
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
index 3ee2017c1ab3..a7c701bb56b4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 OR X11
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Device Tree Include file for TQ-Systems TQMa7D board with NXP i.MX7Dual SoC.
  *
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts b/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
index 8e4cf589c92c..cdcb4097ce8c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 OR X11
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Device Tree Source for TQ-Systems TQMa7S board on MBa7 carrier board.
  *
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
index 7a190fdb2d30..125db5cd1528 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 OR X11
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Device Tree Include file for TQ-Systems TQMa7S board with NXP i.MX7Solo SoC.
  *
-- 
2.33.0



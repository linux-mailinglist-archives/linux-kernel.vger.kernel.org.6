Return-Path: <linux-kernel+bounces-531676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1462A4438A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5594E3B2050
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F826E63A;
	Tue, 25 Feb 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="KrQmyzr/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="oEpbFiQ2"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649726E63E;
	Tue, 25 Feb 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494690; cv=none; b=tqCJ0+f7dsO9gFaSntwxTYMut+0GDRQnUEG+4d8BJ7cOh7idGsXO9N6/iUUU6sbpP1CgiiuxBwPmgklO/mfWWhrkogAcZ/nsSEoqZaz0wXZf/eeHNETpsdkwtoMJo0sW1poxGpU009DEg9YJijH0teYmCkv9AUW66FOLjTjMve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494690; c=relaxed/simple;
	bh=RIGf/G7C8iEdc/bId+fmLRVOqiywa1rCJ49vSacvFyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1i52f6wTSJzC5IPH4PMbPDh9+Si8Mb1waoWEmQD/gWZvYzuUZvMdRhTLfRJkF9+dctcwlgyetyeXh9P/RzrrDEjfmmcesJJFxWSU2IJDPhX1VWq/CXwmTWesRWqZyuNQLGib2dsFBfs40Do1G06NcptH9FDlNbP3oQTJ42GSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=KrQmyzr/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=oEpbFiQ2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740494687; x=1772030687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FT06o2miAnw5cPfmTWHZubI3xiHqfvO2xjSPX/KMN8k=;
  b=KrQmyzr/5GnyC4xNH3vZPHfRwTLc9MSvYRyEslG6YR7QVQtvX51hr+0b
   akZGc6/QH7WKwZwkopoxeo5i8PZFvM/MB29DO/PiiFaKx5rT4NnF45fD0
   yOjXSdLLcsyOpfAHS0wvmyaHHqnwdt85/OBvs91B5SA1Oz0KuUFUGeHJ3
   0Ga0Qzf8ypBfWGk9rZOerNvldjMdvsCzEfaF/IxRTtVY/frsosCWOgSCA
   tZdiZCB8VSP4FhZJg6wnDZkn/MRzmB9tep9rzQbMN7FCK1gJYppWbBOIe
   qgwups4gQE53Koe2IS2MD/j4p915YSY96BTgcxNVUhxjbWWlENkBDk/iN
   g==;
X-CSE-ConnectionGUID: eMXG0DpYQMSKImBvzpP0Wg==
X-CSE-MsgGUID: 94+PQPA/SaK4M7yxwKY14Q==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42075197"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 15:44:44 +0100
X-CheckPoint: {67BDD75C-26-28232521-C0C2250B}
X-MAIL-CPID: BE2FC7B59292282D81112299F45E8048_4
X-Control-Analysis: str=0001.0A002104.67BDD75D.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1B93167F5D;
	Tue, 25 Feb 2025 15:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740494680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FT06o2miAnw5cPfmTWHZubI3xiHqfvO2xjSPX/KMN8k=;
	b=oEpbFiQ27AGv0uiOoRWVCP5DmMFCUNUSa7/mBeB+Y3tVOOvCqEB6WWbvS6fuoRy8vHtgDu
	nEVHAi0EMMgLl9TdyQs6iHdOGGPNtuk3omCD8zu0St1RonxIR+ZZGl94X79nA3QxPAShU4
	FH+hOSbwqGRTHUIYZs/skx8p9bLxBXjU5Ym3yCoPCCRH+NEPBmjM9J59AneyKjJdM68hpJ
	zQfL3bVjHTeolFWUwZO063f1zqhXwQsT4qUT4Ev8SU4RGqC5pVEdsLk+3gLd6E6ETPJEYd
	DBwiYebuaRYyeMys+EzaJF6/Bxf7XZ+lSxi3Ou+kNwPp/WitHRWvCVQJTOFdjg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: imx6ul-tqma6ul1: Change include order to disable fec2 node
Date: Tue, 25 Feb 2025 15:44:35 +0100
Message-ID: <20250225144436.813645-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Max Merchel <Max.Merchel@ew.tq-group.com>

TQMa6UL1 has only one FEC which needs to be disabled as one of the last
steps.
imx6ul-tqma6ul2.dtsi can't be included in imx6ul-tqma6ul1.dtsi as the
defaults from imx6ul.dtsi will be applied again.

Fixes: 7b8861d8e627 ("ARM: dts: imx6ul: add TQ-Systems MBa6ULx device trees")
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts | 3 ++-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi        | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
index f2a5f17f312e5..2e7b96e7b791d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
@@ -6,8 +6,9 @@
 
 /dts-v1/;
 
-#include "imx6ul-tqma6ul1.dtsi"
+#include "imx6ul-tqma6ul2.dtsi"
 #include "mba6ulx.dtsi"
+#include "imx6ul-tqma6ul1.dtsi"
 
 / {
 	model = "TQ-Systems TQMa6UL1 SoM on MBa6ULx board";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
index 24192d012ef7e..79c8c5529135a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
@@ -4,8 +4,6 @@
  * Author: Markus Niebel <Markus.Niebel@tq-group.com>
  */
 
-#include "imx6ul-tqma6ul2.dtsi"
-
 / {
 	model = "TQ-Systems TQMa6UL1 SoM";
 	compatible = "tq,imx6ul-tqma6ul1", "fsl,imx6ul";
-- 
2.43.0



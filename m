Return-Path: <linux-kernel+bounces-257922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0359380E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6C1F21E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3484E1E;
	Sat, 20 Jul 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Eu9BHq8G"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB06376E5;
	Sat, 20 Jul 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721473517; cv=none; b=TDYOb6VtwSx+G4XIAJGdzvvTW9h37ewyGRqcMJcEcKij2TCgp2TA8IcYS2+U+hHdXnV9AZzvWCcLJolfavAbEPanSlBjUZxni/bufwkEn/ujej4JCqS04g2/O/jPaNqT+ox8Y6Lpsrc3yrpoxUvlFV9a6aLFDeuKCjF9OBwxox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721473517; c=relaxed/simple;
	bh=ofE3w0NbQkPgm638fzcyaRxRsAkwnj4uj6sNyKDLlj8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VoC5Yes1TUnqOISGk9nAm2JktSnQCE7y5M7b54X6Z3d7t/R202VuinF4gkgZRMiicivpaETC4jAQrpind9bDpkglEDvEIlNyBog4ZK5j7Z2lBkmLLgs2T22aohU4uoU5wEFa769Tjj45blg0mt8LdiEQwkbSNO48KvuRaieND+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Eu9BHq8G; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46KB4xJA003268;
	Sat, 20 Jul 2024 06:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721473499;
	bh=w8/U6d+p968EovP8vT5UxOg0spebu7g8lnn121bQwlY=;
	h=From:To:CC:Subject:Date;
	b=Eu9BHq8GUGyrqsy8HNRD1aci2wNzOvsZoISY1ngf90ftDwBNdFVfpZ2ZJODBS4LXD
	 pRyf1AID4F8IGnB8nhBzEIhNMakf7pOgoI9MMo3G5mgT1k5qzX/h2vchEnCUvaY+14
	 1QWPPS067pW+owbg0u5vBZqeemaMXvTW79LST5C8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46KB4xqm103162
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 20 Jul 2024 06:04:59 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 20
 Jul 2024 06:04:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 20 Jul 2024 06:04:59 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46KB4t58050410;
	Sat, 20 Jul 2024 06:04:56 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-evm: Use 4 lanes for PCIe0 on EVM
Date: Sat, 20 Jul 2024 16:34:55 +0530
Message-ID: <20240720110455.3043327-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The PCIe0 instance of the PCIe controller on J784S4 SoC supports up to 4
lanes. Additionally, all 4 lanes of PCIe0 can be utilized on J784S4-EVM
via SERDES1. Since SERDES1 is not being used by any peripheral apart
from PCIe0, use all 4 lanes of SERDES1 for PCIe0.

Fixes: 27ce26fe52d4 ("arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240715.
Patch has been tested on J784S4-EVM. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/2b9b1196ff6b9eac895a7986e5ff4456
NOTE: Patch applies cleanly on Mainline Linux's latest commit
3c3ff7be9729 Merge tag 'powerpc-6.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index ffa38f41679d..ea27519d7b89 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1407,10 +1407,11 @@ &serdes1 {
 
 	serdes1_pcie0_link: phy@0 {
 		reg = <0>;
-		cdns,num-lanes = <2>;
+		cdns,num-lanes = <4>;
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_PCIE>;
-		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
+		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>,
+			 <&serdes_wiz1 3>, <&serdes_wiz1 4>;
 	};
 };
 
-- 
2.40.1



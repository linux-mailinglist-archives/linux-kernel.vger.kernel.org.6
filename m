Return-Path: <linux-kernel+bounces-265167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF0393ED82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1EEB21513
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355F84037;
	Mon, 29 Jul 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KNl9ANpG"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783433CD2;
	Mon, 29 Jul 2024 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234862; cv=none; b=IcypXn0vKpWNgIusI/TmAv8/VoI3ZdpMRpKkVJUFD5Slvh3Gi3BIADiK/vCqCGhu6rqEB3xiOFohRF2ltarHx76VmdlFCjs3D4E7pVnt628mkLc3m0TP1YrXWuFE/1SY774GIPpKsRwqAgqJ2bVca301KExnY/RnyCugPhb90yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234862; c=relaxed/simple;
	bh=3dHiRbwH3bN9gn8SCfPtk6+fmPWvFLhjAdlYKzlUWPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5z5LMko9D5pxUztoR6Kd3XitPIcc6+W27TAgWHBXXbrU1LGkNR5R4UHESKtSEb1a3TcY2C2frI4gjIAn6At9Ukr/YNvsdhvasp4Cc4iL187Lh1p9UKOktJvc+uXva1ttir7UKkFYJSqqJqZb4UOGvpAv+TP2epmD2+j2PfjnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KNl9ANpG; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T6YEAu111623;
	Mon, 29 Jul 2024 01:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722234854;
	bh=QO7X/3U3g7cKFrb8iu//E//6dWDBXxQY5QT9URMxyIg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KNl9ANpGe+ByymsYArjmJkuGZqxFUBX8QgSK7F6JiRwWfTmpyhzxFOAfWjAMDbH/c
	 iCeoT8HW6P2UfVrzZ8Mno5ZLuLFWxuGpgrf1POC5PXMDL+lJ8UAOgJHUgvuU0GCqaK
	 cTN1IsnG8kO6HgYV/PcCLBfdOZ69KSrQUaEfs9Mw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T6YEQZ013434
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 01:34:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 01:34:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 01:34:14 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T6YDXJ078190;
	Mon, 29 Jul 2024 01:34:13 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721s2-som-p0: Update mux-controller node name
Date: Mon, 29 Jul 2024 12:04:10 +0530
Message-ID: <20240729063411.1570930-2-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729063411.1570930-1-b-kapoor@ti.com>
References: <20240729063411.1570930-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

There are 2 mux-controller nodes in J721S2 which are responsible for
transferring can signals to the can phy but same node names for both
the mux-controllers led to errors while setting up both mux-controllers
for can phys simultaneously.
Thus, update node names for these mux-controller.

Fixes: 98f3b667e1de ("arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in main domain")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 82aacc01e8fe..36136db26a47 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -134,13 +134,13 @@ rtos_ipc_memory_region: ipc-memories@a8000000 {
 		};
 	};
 
-	mux0: mux-controller {
+	mux0: mux-controller-0 {
 		compatible = "gpio-mux";
 		#mux-state-cells = <1>;
 		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
 	};
 
-	mux1: mux-controller {
+	mux1: mux-controller-1 {
 		compatible = "gpio-mux";
 		#mux-state-cells = <1>;
 		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
-- 
2.34.1



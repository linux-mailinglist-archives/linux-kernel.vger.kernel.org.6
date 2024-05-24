Return-Path: <linux-kernel+bounces-188526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A558CE30D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8816AB210FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C6129E95;
	Fri, 24 May 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CfgpjrhF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285542AA0;
	Fri, 24 May 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541796; cv=none; b=pG4+MzhXvSgGEeMLoDT6WclkXWPT7QI9sjBJdGlif/8DQO/lodqBKQzV7mcwe5H9u7YRbGkEZPCC0y++EIDvMiIEvrtSiaFFT8uG2o+87E0W4cA0roloH8IQjOioQGY8Q9lzJJRtNl+Wh50BZoU9o1TLcrxBj3DhfhGO7PlJ4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541796; c=relaxed/simple;
	bh=UyJXOFvXCuKXrxVR4X/0AOzG4msi71UdQXvrD03dlk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbR+15SzlU53JviyuIY2GZ4+htqoE3efvfaMJXs/pb9HxNFEUCy82Rwu90dWZzejKI+4XU/mgb0Wd7yzUMCyWcCNSOzBhCQT2R55EFpeDdXe1ewOhCgVky+ShuIe3KTKCjd6lu5PYnYmKMG3+wZtkG/pXuWeRq8v9t99ywQwrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CfgpjrhF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O95ge5054220;
	Fri, 24 May 2024 04:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716541542;
	bh=0vvthN20lN+WXz+n5AK/7aVBNF87CbaFIzew0BHEqkU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CfgpjrhFkA1w4+1D3BK1LOmeumYYLzYqxfnym9dvCxXDHNjPKT9rnQ0xwKHlk9efn
	 ICc5ZzHTcmZ2oR3lcA3Yqf1ZmKHCCQeRiNd0KG3g83jNtWB1rpyQivUSHczpWl941O
	 NuppQPF0dhMWSDTC/5TfcXRM66BGmMiSqraLJtI8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O95f1l095760
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:05:41 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:05:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:05:41 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O95F7K017455;
	Fri, 24 May 2024 04:05:37 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 5/7] arm64: dts: ti: k3-j722s: Add lane mux for Serdes1
Date: Fri, 24 May 2024 14:35:12 +0530
Message-ID: <20240524090514.152727-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524090514.152727-1-s-vadapalli@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The Serdes1 instance of Serdes on J722S SoC can be muxed between PCIe0
and SGMII1. Update the "serdes_ln_ctrl" node adding support for the lane
mux of Serdes1. Additionally, set the default muxing for Serdes1 Lane0 to
PCIe0.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Current patch is v1. No changelog.

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 3 ++-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index a3bda39cc223..16c6ab8ee07e 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -401,7 +401,8 @@ &sdhci1 {
 };
 
 &serdes_ln_ctrl {
-	idle-states = <J722S_SERDES0_LANE0_USB>;
+	idle-states = <J722S_SERDES0_LANE0_USB>,
+		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
 };
 
 &serdes0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index b069cecebfd9..48b77e476c77 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -96,8 +96,9 @@ usb1: usb@31200000{
 &main_conf {
 	serdes_ln_ctrl: mux-controller@4080 {
 		compatible = "reg-mux";
-		reg = <0x4080 0x4>;
+		reg = <0x4080 0x14>;
 		#mux-control-cells = <1>;
-		mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
+		mux-reg-masks = <0x0 0x3>, /* SERDES0 lane0 select */
+				<0x10 0x3>; /* SERDES1 lane0 select */
 	};
 };
-- 
2.40.1



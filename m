Return-Path: <linux-kernel+bounces-220806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3AC90E766
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1371C214A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24181ABB;
	Wed, 19 Jun 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WxzymvKB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1021A0D;
	Wed, 19 Jun 2024 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790786; cv=none; b=sH3AmwpVPwYa9qeYmfMSt4uMeydj3N/b68cOMGx3bkqhD1t+aYzfDXSdDiClMQMOAl7zzLz9YRe3y23OWMD/zDUIVw472RT5zxcpiMvBCzY+9mdDDTwZ0udQirc5oH74PsVhfGOvR2m5PYFd/7Jc1+OZC7ljz9dRPYTcDTuyatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790786; c=relaxed/simple;
	bh=wcjoggQnKnkILRHsrqetqeasiV1DiZ7zjaVoxPqWPMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/5Myr7kZmHCv92spqWXC3EsCOloOWkx68dwfABnwBHElr9G+hEAyrv/iOANn4LPNa36Yoo82WSnut/34DBD76nq2jfLzCbi6B30UOlXPgtxgODo+LUjn8ln84HeGmxibvHwNfxFfowNjZULXdaIUHN6xf7n5C9e3tJgL/e0Nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WxzymvKB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45J9qvXm074995;
	Wed, 19 Jun 2024 04:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718790777;
	bh=zd7O+fP0Ooz7IpvvUv/JMgQVOWIJh4bPjekEX4ZqlGo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WxzymvKBBGgfaxtbvwKjtj3ScIoDavqM5HoeqD2vpjzEcRbNCmcmBpcKJjQCAa0fu
	 OGVmpKv9niAseavxdkKipHa6YfQHiVncsW32G70gGRcUuo0xQDGqo9/fsdqn+veCBM
	 isxAQZD3EA1kwS2rzw9ZU0bY1qnCVRNGoh5/xDNA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45J9qv4Z066808
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 04:52:57 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 04:52:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 04:52:57 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45J9quo2099672;
	Wed, 19 Jun 2024 04:52:57 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j784s4-main: Add audio_refclk node
Date: Wed, 19 Jun 2024 15:22:52 +0530
Message-ID: <20240619095253.290552-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619095253.290552-1-j-choudhary@ti.com>
References: <20240619095253.290552-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On J784S4 SoC, the AUDIO_REFCLK1 can be used as input to external
peripherals when configured through CTRL_MMR.
Add audio_refclk1 node which would be used as system clock for
audio codec PCM3168A.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 96085dc7bc18..4ea7d89ca4a8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -115,6 +115,15 @@ usb_serdes_mux: mux-controller@4000 {
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 3 mux */
 		};
+
+		audio_refclk1: clock@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 34>;
+			assigned-clocks = <&k3_clks 157 34>;
+			assigned-clock-parents = <&k3_clks 157 63>;
+			#clock-cells = <0>;
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
2.25.1



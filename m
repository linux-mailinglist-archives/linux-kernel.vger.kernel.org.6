Return-Path: <linux-kernel+bounces-228734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C891663E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9825284FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B29149DF4;
	Tue, 25 Jun 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WyGuHvT2"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E314D29B;
	Tue, 25 Jun 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315192; cv=none; b=ZI1QHz+G5pu87FuDWDH1sHM0C4Tv3ItebVe7TCA11MWSTjqDzNet4OYpiG3sIE8MVFZn5mWM5DPgPme5aznYvFRiB/vx+rlhnn+UD56WHMNrTjClgD4MQCNhzFcCu+1uBL1lLDvy3UBLuQ4bypP47FnTt3PP1d9DEJeRawTZJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315192; c=relaxed/simple;
	bh=QRc3Uh0Fn4bEsopHW7LGZOLpKVn9pnlKfqdjEINKODM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRo1DRiV+wSHBa2Qa/ezIrUMLcYR5RyJHOt2lTD2Zp0dQ+GbwyUenPoYpO88zYhjfDbdDYiQzqHef4keU1+wbAksWUZ3v4kspmCY6P6amOI3NwWTe9L2NOJmVRk1zLlLqRlLoox7ulLD8yoiA7hR7kLIL/KvtabcV11y0cyu7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WyGuHvT2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PBX59L012299;
	Tue, 25 Jun 2024 06:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719315185;
	bh=kd6H54Mg61MKFK9NNB+xqFavtmR1yT+IlyPziynAQbk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WyGuHvT2McnEtQ1ODFoJLsaA3KirtT0/rNOPbCRYMVDxZF6cq+vo7NuTDvOuVs2Ok
	 5AuhldeTt4bIAkYKt2GLJFXKL7n8dmbcWulDrYSu5GWCTfdMKjlhlT0gl3cwBXUOvW
	 i2CccmRffnmyCaUP/LDIhG2tQ3v5v2sa/42a2Njk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PBX5I3024563
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 06:33:05 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 06:33:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 06:33:05 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PBX4w9099546;
	Tue, 25 Jun 2024 06:33:04 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-j722s-main: Add audio_refclk node
Date: Tue, 25 Jun 2024 17:03:00 +0530
Message-ID: <20240625113301.217369-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625113301.217369-1-j-choudhary@ti.com>
References: <20240625113301.217369-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On J722S SoC, the AUDIO_REFCLK1 can be used as input to external
peripherals when configured through CTRL_MMR.
Add audio_refclk1 node which would be used as system clock for the
audio codec TLV320AIC3106.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 228c6c89245c..a6b7817d35bc 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -163,6 +163,15 @@ serdes_ln_ctrl: mux-controller@4080 {
 		mux-reg-masks = <0x00 0x3>, /* SERDES0 lane0 select */
 				<0x10 0x3>; /* SERDES1 lane0 select */
 	};
+
+	audio_refclk1: clock@82e4 {
+		compatible = "ti,am62-audio-refclk";
+		reg = <0x82e4 0x4>;
+		clocks = <&k3_clks 157 18>;
+		assigned-clocks = <&k3_clks 157 18>;
+		assigned-clock-parents = <&k3_clks 157 33>;
+		#clock-cells = <0>;
+	};
 };
 
 &wkup_conf {
-- 
2.25.1



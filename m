Return-Path: <linux-kernel+bounces-211408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F6905143
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04521F222ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50A16F0E2;
	Wed, 12 Jun 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YCj2/Ca6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD471534EA;
	Wed, 12 Jun 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191396; cv=none; b=VlfE3rzCRGlS430m1vPYtxKY9YTbTLVTdedu4uLXkHy5HgyPJvbMkWwoHa1ZrOCeuBvBvce1q7/3mXQhtdSGQuGG1leTV+Yo6mv48Vml2ZW6TfkyVyBMfzXpeU87N6F1aAgCSAMR2ntHBTwLru2Aqqfi7KrwHbNic04IbG863fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191396; c=relaxed/simple;
	bh=1wUBgueOjI1BytFrGkHYP3KfTEqUo/lYCFPSMUVT+l8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMvGqCHhU0ZOVeNjVwkAoPjIQjxMc9slaRFY4sm1SDKwL01QQB3alFx3dHbaE/6J/5SXhlPf2sIW+2gwDgpz/2M8AIq2l+9PSH0mLQGA8oCqo7Ec7FVODUUhHNdBQQSYb6eSBX6SFv7ETH5rZ8K3A6EoJOQychPqKPF1R+jzTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YCj2/Ca6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CBN8jO045847;
	Wed, 12 Jun 2024 06:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718191388;
	bh=DlWmeBChXX90LjxZUr3kBbM7iSYW8tAoDGjC+yAvZV4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YCj2/Ca6LgJ6kQcsukvSAy/q5H6Cr1ryOC7whW1hP5XYT5SANaJJsyU9lBdCW9Mas
	 0XheUKHpQp2wxl/6KTxdJNYXITsRMqDtd/+E95YhpwsYOMq46GTqnrLDydS3dgkuH2
	 gQkVNDBpTHBt2GorVMdCP/JGxWzR6yz/o15Uczbs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CBN87O125669
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 06:23:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 06:23:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 06:23:07 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CBMxe3120263;
	Wed, 12 Jun 2024 06:23:04 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote processor nodes
Date: Wed, 12 Jun 2024 16:52:58 +0530
Message-ID: <20240612112259.1131653-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612112259.1131653-1-b-padhi@ti.com>
References: <20240612112259.1131653-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Apurva Nandan <a-nandan@ti.com>

The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
in MAIN voltage domain. Add the DT nodes to support Inter-Processor
Communication.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
[ refactoring changes to k3-j722s-main.dtsi ]
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 61 +++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index b16f3a7cb1097..1ca3f656a7209 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -153,6 +153,67 @@ usb1: usb@31200000{
 			dr_mode = "otg";
 		};
 	};
+
+	main_r5fss0: r5fss@78400000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x78400000 0x00 0x78400000 0x8000>,
+			 <0x78500000 0x00 0x78500000 0x8000>;
+		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		main_r5fss0_core0: r5f@78400000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x78400000 0x00008000>,
+			      <0x78500000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <262>;
+			ti,sci-proc-ids = <0x04 0xff>;
+			resets = <&k3_reset 262 1>;
+			firmware-name = "j722s-main-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	c7x_0: dsp@7e000000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e000000 0x00 0x00200000>;
+		reg-names = "l2sram";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <208>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 208 1>;
+		firmware-name = "j722s-c71_0-fw";
+		status = "disabled";
+	};
+
+	c7x_1: dsp@7e200000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e200000 0x00 0x00200000>;
+		reg-names = "l2sram";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <268>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 268 1>;
+		firmware-name = "j722s-c71_1-fw";
+		status = "disabled";
+	};
+};
+
+/* MCU domain overrides */
+
+&mcu_r5fss0_core0 {
+	firmware-name = "j722s-mcu-r5f0_0-fw";
+};
+
+/* Wakeup domain overrides */
+
+&wkup_r5fss0_core0 {
+	firmware-name = "j722s-wkup-r5f0_0-fw";
 };
 
 &main_conf {
-- 
2.34.1



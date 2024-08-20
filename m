Return-Path: <linux-kernel+bounces-293793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B89584DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B551F27ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1701318EFD3;
	Tue, 20 Aug 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h0+MPihU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5918E34B;
	Tue, 20 Aug 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150449; cv=none; b=WDbJn50sWZGgYieRmuXFyBkV92zO1pR6IuC4N19fZ6+6zccM6FP1bgkx/VvKcBOKhfGQ8nLfcLDKCN4fLiyNYH3nZlE0U6eEdyLMLmEsZWNXSXbkC6AebBP1K7KxlrqdJbdWrcHTenwq9jbl0VT7KTG5Cu5c5x9uRnhvTQNrKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150449; c=relaxed/simple;
	bh=5RVPzMy/QPSlQXb8jYE2+R+rK4CFR75JBYXWa2TedWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkOI6t6TaZGNZkR0YkUWSWBZl1m29J0zCogzKoUtFAwtRC3qfU1v3PaMhWrWKK+3bmhpxt5Vz7J03gm2GqRX5oJbY3FDL2i+mfLHIWlM2lFgsTOpxXDfqLxg5rQeqSEawspjpcwgvj8TeiePNYCFXs5ZqW4XrUuCeQfROp5emgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h0+MPihU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KAeZGN102476;
	Tue, 20 Aug 2024 05:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724150435;
	bh=lRj86cxU3Xj9ynRAeceeFgH8EJzU6nWYxAQZqFM/a68=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h0+MPihUUH5Cwmi48eZyBE4Ul802LPUuN+Wl3thM8Hm9vULHBCBuPcjhcCAPXQ7Ai
	 fSPTg8MsQBcXsSdM67oRnr8WNTExg+XtMIf7jGK/RUSOqIWgrrtyKpw4s554cqzUnx
	 E9LBd1mI21adcOkIqKP0an/nW/mLvf9j8tLu6di0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KAeZw5072467
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 05:40:35 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 05:40:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 05:40:35 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KAeYoL003145;
	Tue, 20 Aug 2024 05:40:35 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <bb@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/4] arm64: dts: k3-am62a-mcu: Add R5F remote proc node
Date: Tue, 20 Aug 2024 05:40:32 -0500
Message-ID: <20240820104034.15607-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240820104034.15607-1-hnagalla@ti.com>
References: <20240820104034.15607-1-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

AM62A SoCs have a single R5F core in the MCU voltage domain. The MCU
domain also has a 512KB sram memory, the R5F core can use for
applications needing fast memory access.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 8c36e56f4138..803da3cce336 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -6,6 +6,17 @@
  */
 
 &cbass_mcu {
+	mcu_ram: sram@79100000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x79100000 0x00 0x80000>;
+		ranges = <0x00 0x00 0x79100000 0x80000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		mcu1-sram@0 {
+			reg = <0x0 0x80000>;
+		};
+	};
 	mcu_pmx0: pinctrl@4084000 {
 		compatible = "pinctrl-single";
 		reg = <0x00 0x04084000 0x00 0x88>;
@@ -167,4 +178,28 @@ mcu_mcan1: can@4e18000 {
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 		status = "disabled";
 	};
+
+	mcu_r5fss0: r5fss@79000000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x79000000 0x00 0x79000000 0x8000>,
+			 <0x79020000 0x00 0x79020000 0x8000>;
+		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
+		mcu_r5fss0_core0: r5f@79000000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x79000000 0x00008000>,
+				<0x79020000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <9>;
+			ti,sci-proc-ids = <0x03 0xff>;
+			resets = <&k3_reset 9 1>;
+			firmware-name = "am62a-mcu-r5f0_0-fw";
+			ti,atcm-enable = <0>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <0>;
+			sram = <&mcu_ram>;
+		};
+	};
 };
-- 
2.34.1



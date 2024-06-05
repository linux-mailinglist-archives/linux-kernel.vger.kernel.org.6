Return-Path: <linux-kernel+bounces-202638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0788FCF0C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFD61C2505E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948801A188C;
	Wed,  5 Jun 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YLZhOLJ2"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C9195FC9;
	Wed,  5 Jun 2024 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591749; cv=none; b=MZ/dMabxl4qN2z2hAHpdSa2yRocMGa0gzfBmDU81sSndreJBmhognqln/Ro/53dR99YkVZpUax3dNFHf3iQMYAhbTYUokT+/dVz9p1V+JyK33QZr1ISctfJ2YdANQBMAxEZthoanXadTu+QXf3U0/ejabeBGc9IPcYMven620CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591749; c=relaxed/simple;
	bh=5RVPzMy/QPSlQXb8jYE2+R+rK4CFR75JBYXWa2TedWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4S4bLxK+O51UxsQ2D0AJVW3SBDNDeoNzzmYglYe9E6stIRLgTW6Hq5sXDVeB3GqOdtyaCsWhTDVqM0Xq1Q7nEuHFFBZDUWDwcBoKPRaCFBKkAWsZ01JNttDPVcHvnehkTcctuAVRcJ090zaYgruRDerFFvJgm0HQ1PFWY3OqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YLZhOLJ2; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455Cn03a118483;
	Wed, 5 Jun 2024 07:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717591740;
	bh=lRj86cxU3Xj9ynRAeceeFgH8EJzU6nWYxAQZqFM/a68=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YLZhOLJ2K8bFPoqlSuE84Fdjg0XCBg/zFi/lzjFTcc4pqwMXHVLz5px/Cj5Yd65wF
	 6r1DPgm4P7nv4lPdpq8P2WsSaDZbht+sBknX3sbUn9C2v3IIs/jPGjoAe4tq7ac/Po
	 ej9dTk0WcwgX2blGHqxVW90CYlWMHb7ck8F1Z0rM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455Cn0Z5006783
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 07:49:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 07:49:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 07:49:00 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455Cn0tD108876;
	Wed, 5 Jun 2024 07:49:00 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/4] arm64: dts: k3-am62a-mcu: Add R5F remote proc node
Date: Wed, 5 Jun 2024 07:48:57 -0500
Message-ID: <20240605124859.3034-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605124859.3034-1-hnagalla@ti.com>
References: <20240605124859.3034-1-hnagalla@ti.com>
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



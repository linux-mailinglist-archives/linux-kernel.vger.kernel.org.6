Return-Path: <linux-kernel+bounces-219952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88090DAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E83A1C2328E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B913E143C4D;
	Tue, 18 Jun 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Am2S/ph+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E379FD;
	Tue, 18 Jun 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731894; cv=none; b=VjKgtuVLS80Gjy5ZZK73WXSFN4+ZuZMoTEvjvt0EtO++8SNGDPdUrxtWShyR0WIUk8F2yPPqEkujS/QFOiKWqzdT59YUJweyGgVwmFqpa0hDk1YUpSdqPkCtfjT4yf2XalLDWM/pZw34qaN42GRvi1oaaNw/AV9s2z1+glypLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731894; c=relaxed/simple;
	bh=GgC/RgGBqPcE9JOI2cHsAqwui9SvFFMMRYbHB0SOCRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGtXvTJaq/4zlNWINqZtrQMTbYJxWmWXRbPs1B7xz/jlvkpHqH1ODKDBLsptTAWlwwhZ8t+6TEjpR/35OkdvN9ZydmNy6Q3jaaks2YrTiup8D18upQnvo3UCH/DVUyNU3GaTvlaVpfxUcpYkESlj8njNbtkpA8al/wcTnxX7j98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Am2S/ph+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVQaR007033;
	Tue, 18 Jun 2024 12:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718731886;
	bh=6OBs4PindOmgv8UHdb5SG3claVFLiZWM8QbmIIwYyn8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Am2S/ph+sy+iwyjTJqBVAAwqwz/ZAeYKL3y+L06mZpEk//WQJlH4xGATJNSEGRz4d
	 I45sbet+cR9zYkkZEAs5dQwA0q+9cqnVoiCh1VhK6FWKuOvurFKnu0NmFwSan8kWHa
	 r+cKzkW47gy0QgDwKp8D5Vj3VX0VCZcAFM51s4tI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IHVQoV042987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 12:31:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 12:31:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 12:31:25 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVPb5043311;
	Tue, 18 Jun 2024 12:31:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Vaishnav
 Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62p: Add gpio-ranges properties
Date: Tue, 18 Jun 2024 12:31:22 -0500
Message-ID: <20240618173123.2592074-3-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618173123.2592074-1-nm@ti.com>
References: <20240618173123.2592074-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On the AM62P platform we have no single 1:1 relation regarding index
of GPIO and pin controller. The GPIOs and pin controller registers
have mapping and holes in the map. These have been extracted from the
AM62P data sheet.

Mux mode input is selected as it is bi-directional. In case a specific
pull type or a specific pin level drive setting is desired, the board
device tree files will have to explicitly mux those pins for the GPIO
with the desired setting.

Ref: AM62P Data sheet https://www.ti.com/lit/gpn/am62p

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Note: this generates a 'too large' warning for
pinctrl-single,gpio-ranges -
https://lore.kernel.org/r/20240618165102.2380159-1-nm@ti.com/ for more
details

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi  | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index eed06506f617..573c85486db1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -258,7 +258,17 @@ main_pmx0: pinctrl@f4000 {
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
+		pinctrl-single,gpio-range =
+			<&main_pmx0_range 0 32 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+			<&main_pmx0_range 33 92 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+			<&main_pmx0_range 137 5 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+			<&main_pmx0_range 143 3 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+			<&main_pmx0_range 149 2 (PIN_INPUT | PIN_GPIO_MUX_MODE)>;
 		bootph-all;
+
+		main_pmx0_range: gpio-range {
+			#pinctrl-single,gpio-range-cells = <3>;
+		};
 	};
 
 	main_esm: esm@420000 {
@@ -543,6 +553,8 @@ main_gpio0: gpio@600000 {
 		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 77 0>;
 		clock-names = "gpio";
+		gpio-ranges = <&main_pmx0 0 0 32>, <&main_pmx0 32 33 38>,
+				<&main_pmx0 70 72 22>;
 	};
 
 	main_gpio1: gpio@601000 {
@@ -560,6 +572,8 @@ main_gpio1: gpio@601000 {
 		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 78 0>;
 		clock-names = "gpio";
+		gpio-ranges = <&main_pmx0 0 94 32>, <&main_pmx0 42 137 5>,
+				<&main_pmx0 47 143 3>, <&main_pmx0 50 149 2>;
 	};
 
 	sdhci0: mmc@fa10000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
index b973b550eb9d..a27dd12b44ac 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
@@ -11,7 +11,15 @@ mcu_pmx0: pinctrl@4084000 {
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
+		pinctrl-single,gpio-range =
+			<&mcu_pmx_range 0 21 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+			<&mcu_pmx_range 23 1 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+			<&mcu_pmx_range 32 2 (PIN_INPUT | PIN_GPIO_MUX_MODE)>;
 		bootph-all;
+
+		mcu_pmx_range: gpio-range {
+			#pinctrl-single,gpio-range-cells = <3>;
+		};
 	};
 
 	mcu_esm: esm@4100000 {
@@ -137,6 +145,8 @@ mcu_gpio0: gpio@4201000 {
 		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 79 0>;
 		clock-names = "gpio";
+		gpio-ranges = <&mcu_pmx0 0 0 21>, <&mcu_pmx0 21 23 1>,
+				<&mcu_pmx0 22 32 2>;
 	};
 
 	mcu_rti0: watchdog@4880000 {
-- 
2.43.0



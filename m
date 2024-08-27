Return-Path: <linux-kernel+bounces-303144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F03960800
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059781C22948
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C419F478;
	Tue, 27 Aug 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MloyMNoT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFC19E7FF;
	Tue, 27 Aug 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756222; cv=none; b=PU/82qLer/rnE9xGhU0aBRUqw3hCNSESBFGnurGBxQqlrsnW4oClIuC1wERQc+vJKbS7PdOPHYgkCuXaUE4LCeji7cucmcdKYATGcpSwOocagwmFgAfY5MAnxWIvJgC4Suf7y4qg1g2p14PIci1rRCj1C7vJQWh48K52FgXK/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756222; c=relaxed/simple;
	bh=tx0g7NhvrM+O/NA3qD141c9tzZma0yfUmDnIeJKoP84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfGFmBRnCcqvbvuJyRlXJ5a5fPfC52sWbaCuzdogvs1SVAfGnAXExZruc4+ul24uz6tCN8Tg7kCXeNoLfgteoctB+mnW9WJgo+QJsQlXe5JNlHMZRFYy9hs6aQC3/LwQ7eOpz7mBBtyl+6A/c/BtmlF6fnuuqFBAb3MWn1GoqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MloyMNoT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RAun1G068796;
	Tue, 27 Aug 2024 05:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724756209;
	bh=zPbib7xbMUlrnvdopHSHphG/Tp3WBjra4xzF/7bFHgw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MloyMNoTQ8DwDwnalFLbExTUodOpCNW4hozGyUef6EG0XLQ8eoqEXHoDqjzx2Bl8j
	 ugMA6OtiJZVRQAQ4fHJqplqN7hpLxCpaRLGIYnXM3AkMXwhYn1kGw0546SKMmO+q33
	 1UV/DKmSUeAyeT4NHIqKoKPu9M6+dxEuXvf4imPA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RAunxP128162
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 05:56:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 05:56:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 05:56:49 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RAumpu051333;
	Tue, 27 Aug 2024 05:56:48 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j722s-evm: Describe main_uart5
Date: Tue, 27 Aug 2024 16:26:44 +0530
Message-ID: <20240827105644.575862-3-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827105644.575862-1-b-kapoor@ti.com>
References: <20240827105644.575862-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

System firmware uses main_uart5 in J722S EVM for trace data.
Thus, describe it in device tree for completeness,
adding the pinmux and mark it as reserved.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Link to v1: https://lore.kernel.org/all/20240822053538.10475-1-b-kapoor@ti.com/

changelog v1->v2:
	- Modified commit message to be more clear
	- provide documentation on why main_uart5 is reserved

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 8daa47a245aa..41c36f82a3c5 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -20,6 +20,7 @@ / {
 	aliases {
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
+		serial3 = &main_uart5;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
@@ -211,6 +212,13 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
 		bootph-all;
 	};
 
+	main_uart5_pins_default: main-uart5-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0108, PIN_INPUT, 3)       /* (J27) UART5_RXD */
+			J722S_IOPAD(0x010c, PIN_OUTPUT, 3)      /* (H27) UART5_TXD */
+		>;
+	};
+
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
@@ -330,6 +338,13 @@ &main_uart0 {
 	bootph-all;
 };
 
+&main_uart5 {
+	/* MAIN UART 5 is used by System firmware */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart5_pins_default>;
+	status = "reserved";
+};
+
 &mcu_pmx0 {
 
 	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
-- 
2.34.1



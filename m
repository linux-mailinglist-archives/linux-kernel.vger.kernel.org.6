Return-Path: <linux-kernel+bounces-192021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C468D175A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5CF284C59
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510E916A38B;
	Tue, 28 May 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="roJyxgCE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A456E611;
	Tue, 28 May 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889173; cv=none; b=B4hf2hCjJpdJ7i+oF/6pL7bQzG6nF696RCVDfZh0Z1aX7j0wfqF71bLirV0RkhTbsYMdvjsnp7wQ2n2U61F6imE6q4plB3bpiOvK5I/cQ2WEQldHcsjdA7AqhJPRtlypAMbNGElkT/aVl7c0HSF8g27+dFqfV4gOcYrjw702kiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889173; c=relaxed/simple;
	bh=BV23nrWwcUZ81xYYOa58bjn33Hmk4B056pZo1YuJe9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nrJD3zXtXaOiz5+Pv9sgwCrvdOsvMEBDkEBQGyeDafCyp8EydopdcM/nPqqnEQLn7ooxCmys8gaEdQr3E943xNhEE/i5h4D+0tiJNMLW13xXw8rrVLXli0IPwz72iYZYp9yoz+f3QHZ4Mt6YP8cNMmdGhpWqDOnHodYinkRQfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=roJyxgCE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S9dDjY031689;
	Tue, 28 May 2024 04:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716889153;
	bh=focKs81VgYdLLbkCANUI0lOf4MSxv0z3hdKvDtcsNZg=;
	h=From:To:CC:Subject:Date;
	b=roJyxgCEvJTO54W6LjMli6Huo5/o+jMMSsfWnA4rs31KoHpmHNvBujhCgUBAeMZLt
	 UETkw5VwB0FcJoy9z6/t2lUZLWp2I517YdlMuEmwqJ/i/Jj/gWemOECG8dqr+M71fO
	 k0IsxHujTXKRg3tj9tOydZ7P6lUnuRDUJdDKRaN0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S9dDwb100659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 04:39:13 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 04:39:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 04:39:12 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S9dBS6040351;
	Tue, 28 May 2024 04:39:12 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable main_uart5
Date: Tue, 28 May 2024 15:09:11 +0530
Message-ID: <20240528093911.47786-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

main_uart5 node defined in the SoC dtsi file is incomplete
and will not be functional unless it is extended with pinmux
information at board integration level.

Thus, add pinmux for main_uart5 in the board dts file and
enable it to make it functional.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index bf3c246d13d1..e3892a6f2fab 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -18,6 +18,7 @@ / {
 	aliases {
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
+		serial3 = &main_uart5;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
@@ -142,6 +143,14 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
 		bootph-all;
 	};
 
+	main_uart5_pins_default: main-uart5-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0108, PIN_INPUT, 3)	/* (J27) UART5_RXD */
+			J722S_IOPAD(0x010c, PIN_OUTPUT, 3)	/* (H27) UART5_TXD */
+		>;
+		bootph-all;
+	};
+
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
@@ -240,6 +249,13 @@ &main_uart0 {
 	bootph-all;
 };
 
+&main_uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart5_pins_default>;
+	status = "okay";
+	bootph-all;
+};
+
 &mcu_pmx0 {
 
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
-- 
2.34.1



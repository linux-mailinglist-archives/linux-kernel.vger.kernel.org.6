Return-Path: <linux-kernel+bounces-205852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349F90014B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6551F24D43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9018629E;
	Fri,  7 Jun 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mYzvl6HA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038461FCE;
	Fri,  7 Jun 2024 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757777; cv=none; b=DlTesZVlteK0IuRD5/Nbq/uYHsyAlGOYp+8dWn+gnUhmvR38p4KuVby3S8cDmvF6/BijU+LSX2INm4NwuLIcNvsN8KnxsGgBaUS5x8P1AFbzAJU78lSj2v52NhJf75zgwhpIeVAwv/ecBuFrWOItpVEG4/qmU49jkbhdPypnJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757777; c=relaxed/simple;
	bh=XujjUnM9DMu7rqTP8DTZ2UrETk/uV5hu6vJfTxFT4/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0hZjaCx18MVNE2eTNhjAEMvfrYz/SWWFLtGASOnAGWqpr0KZ6xl2XG21z2fqQ8nKN4EVE8VDOFUJuGy4Lii4HFrNCpJ1a+4iUmq/plACcoMQLBy9YBC0bX5qsQLPsEaUfXPY/zl8q/uIDi5W+ZlfJ6KlUYsRsCxd7Wd00r3PuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mYzvl6HA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457Au3GT067900;
	Fri, 7 Jun 2024 05:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717757763;
	bh=a5GAfS7C0Tj1XfUzuRZMBoPPEFIo9QtsKjJsgSeV/9k=;
	h=From:To:CC:Subject:Date;
	b=mYzvl6HARgzoK2WyuRNbgqzRjlGFvAXndX6jNlfEvwCc6uZD/YHfSfFieMJpb5ElB
	 n5f2pSuPjJkLzWpjMPA8Ifjf8sNSYgG875YXn/7pVIMCMz3j+lbdKGDyrv9NAa1jAl
	 9ys2ihkjtPxDG2ctYfX6FT8RWL81eFSOGBv79ca8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457Au3Kq125057
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 05:56:03 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 05:56:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 05:56:03 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457AtxSV129722;
	Fri, 7 Jun 2024 05:56:00 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <tony@atomide.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7xx: Change timer nodes status to reserved
Date: Fri, 7 Jun 2024 16:25:59 +0530
Message-ID: <20240607105559.771080-1-b-padhi@ti.com>
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

The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
use timers. Therefore, change the status of the timer nodes to
"reserved" to avoid any clash.

This change is already incorporated for timer nodes in the MCU voltage
domain.

Fixes: 835d04422f9d ("arm64: dts: ti: k3-j721s2: Add general purpose timers")

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi  |  7 +++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  6 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 10 ++++++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f68..22351a4f3da6e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1254,6 +1254,7 @@ main_timer0: timer@2400000 {
 		assigned-clock-parents = <&k3_clks 49 2>;
 		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer1: timer@2410000 {
@@ -1266,6 +1267,7 @@ main_timer1: timer@2410000 {
 		assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 313 1>;
 		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer2: timer@2420000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0da785be80ff4..944bdbb98e910 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1102,6 +1102,7 @@ main_timer0: timer@2400000 {
 		assigned-clock-parents = <&k3_clks 49 2>;
 		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer1: timer@2410000 {
@@ -1114,6 +1115,7 @@ main_timer1: timer@2410000 {
 		assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 327 1>;
 		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer2: timer@2420000 {
@@ -1126,6 +1128,7 @@ main_timer2: timer@2420000 {
 		assigned-clock-parents = <&k3_clks 51 2>;
 		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer3: timer@2430000 {
@@ -1246,6 +1249,7 @@ main_timer12: timer@24c0000 {
 		assigned-clock-parents = <&k3_clks 63 2>;
 		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer13: timer@24d0000 {
@@ -1258,6 +1262,7 @@ main_timer13: timer@24d0000 {
 		assigned-clock-parents = <&k3_clks 64 2>, <&k3_clks 333 1>;
 		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer14: timer@24e0000 {
@@ -1270,6 +1275,7 @@ main_timer14: timer@24e0000 {
 		assigned-clock-parents = <&k3_clks 65 2>;
 		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer15: timer@24f0000 {
@@ -1282,6 +1288,7 @@ main_timer15: timer@24f0000 {
 		assigned-clock-parents = <&k3_clks 66 2>, <&k3_clks 334 1>;
 		power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer16: timer@2500000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 9ed6949b40e9d..c8e49454bd9b0 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -225,6 +225,7 @@ main_timer0: timer@2400000 {
 		assigned-clock-parents = <&k3_clks 63 2>;
 		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer1: timer@2410000 {
@@ -237,6 +238,7 @@ main_timer1: timer@2410000 {
 		assigned-clock-parents = <&k3_clks 64 2>;
 		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer2: timer@2420000 {
@@ -249,6 +251,7 @@ main_timer2: timer@2420000 {
 		assigned-clock-parents = <&k3_clks 65 2>;
 		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer3: timer@2430000 {
@@ -261,6 +264,7 @@ main_timer3: timer@2430000 {
 		assigned-clock-parents = <&k3_clks 66 2>;
 		power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer4: timer@2440000 {
@@ -273,6 +277,7 @@ main_timer4: timer@2440000 {
 		assigned-clock-parents = <&k3_clks 67 2>;
 		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer5: timer@2450000 {
@@ -285,6 +290,7 @@ main_timer5: timer@2450000 {
 		assigned-clock-parents = <&k3_clks 68 2>;
 		power-domains = <&k3_pds 68 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer6: timer@2460000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6a4554c6c9c13..d62859c52514e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -170,6 +170,7 @@ main_timer0: timer@2400000 {
 		assigned-clock-parents = <&k3_clks 97 3>;
 		power-domains = <&k3_pds 97 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer1: timer@2410000 {
@@ -182,6 +183,7 @@ main_timer1: timer@2410000 {
 		assigned-clock-parents = <&k3_clks 98 3>;
 		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer2: timer@2420000 {
@@ -194,6 +196,7 @@ main_timer2: timer@2420000 {
 		assigned-clock-parents = <&k3_clks 99 3>;
 		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer3: timer@2430000 {
@@ -206,6 +209,7 @@ main_timer3: timer@2430000 {
 		assigned-clock-parents = <&k3_clks 100 3>;
 		power-domains = <&k3_pds 100 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer4: timer@2440000 {
@@ -218,6 +222,7 @@ main_timer4: timer@2440000 {
 		assigned-clock-parents = <&k3_clks 101 3>;
 		power-domains = <&k3_pds 101 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer5: timer@2450000 {
@@ -230,6 +235,7 @@ main_timer5: timer@2450000 {
 		assigned-clock-parents = <&k3_clks 102 3>;
 		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer6: timer@2460000 {
@@ -242,6 +248,7 @@ main_timer6: timer@2460000 {
 		assigned-clock-parents = <&k3_clks 103 3>;
 		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer7: timer@2470000 {
@@ -254,6 +261,7 @@ main_timer7: timer@2470000 {
 		assigned-clock-parents = <&k3_clks 104 3>;
 		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer8: timer@2480000 {
@@ -266,6 +274,7 @@ main_timer8: timer@2480000 {
 		assigned-clock-parents = <&k3_clks 105 3>;
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer9: timer@2490000 {
@@ -278,6 +287,7 @@ main_timer9: timer@2490000 {
 		assigned-clock-parents = <&k3_clks 106 3>;
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
 		ti,timer-pwm;
+		status = "reserved";
 	};
 
 	main_timer10: timer@24a0000 {
-- 
2.34.1



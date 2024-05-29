Return-Path: <linux-kernel+bounces-193541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3D8D2D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA581F27386
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC116728A;
	Wed, 29 May 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KNTZnjRe"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C11667C1;
	Wed, 29 May 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965076; cv=none; b=LfIOHGka61mQeJB+6HjAo4NXqVcQ58wXR1jqQCHb7o47SMBwV4NVjXo4Gli/x2QRajUYtepdizmPS1psKPWLaR9WiEouvmx1RZHi9IqdrhgCTfi9s+U9Trql3UfODcnIfEsW/X5MnbIsi63UXMAJsTe5I6EzNYdf8/63P0rCn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965076; c=relaxed/simple;
	bh=akXeNdI+303EoOETffQO7Wi4rNE6H00HXeardRyN75I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2lMMiZs/Rx2QlxAc8nNMMtZ6u6KF3ExQG4tlZkfgS9a0MyPHN58VY56xYP4tR5Mm4vIxpWIm44zeSraH2BOOu1koAHShL+MAZQrSUdgH4P1dA6jXT/Ki3cloXeSSc46tKMoPsmDGn8KSURfecWz7DaNAbTQIcZ3ZGUp7wmT4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KNTZnjRe; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T6iQYL128517;
	Wed, 29 May 2024 01:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716965066;
	bh=sg4O15UMTb7j5f+XOAfXyJJeGfN/dRtXAZ0NO3HOZF4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KNTZnjRen09H+hp55MP7L5kD2N4MBbuyUWwhjUZ/a43x85sZpK6nEaZ4P7dRuB5nc
	 +QtFO8jraLIeZR42WTaXkw6+mJIF5Go7lJNCV2aUHQFrw2XNl1KjOB6pdxaAUcYZDq
	 /QvZits+FaFVKCJEofqe7L8yy05sn+bBePtqTDMA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T6iQFt069200
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 01:44:26 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 01:44:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 01:44:26 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T6iQNn013472;
	Wed, 29 May 2024 01:44:26 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44T6iPd2015800;
	Wed, 29 May 2024 01:44:25 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am65-main: Add PRU system events for virtio
Date: Wed, 29 May 2024 12:14:19 +0530
Message-ID: <20240529064420.571615-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529064420.571615-1-danishanwar@ti.com>
References: <20240529064420.571615-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Suman Anna <s-anna@ti.com>

A PRU system event "vring" has been added to each PRU and RTU
node in each of the ICSSG0, ICSSG1 and ICSSG2 remote processor
subsystems to enable the virtio/rpmsg communication between MPU
and that PRU/RTU core. The additions are done in the base
k3-am65-main.dtsi, and so are inherited by all the K3 AM65x
boards.

The PRU system events is the preferred approach over using TI
mailboxes, as it eliminates an external peripheral access from
the PRU/RTU-side, and keeps the interrupt generation internal to
the ICSSG. The difference from MPU would be minimal in using one
versus the other.

Mailboxes can still be used if desired, but currently there is
no support on firmware-side for K3 SoCs to use mailboxes. Either
approach would require that an appropriate firmware image is
loaded/booted on the PRU.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index ed71561c5bd9..1af3dedde1f6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1185,6 +1185,9 @@ pru0_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_0: rtu@4000 {
@@ -1194,6 +1197,9 @@ rtu0_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_0: txpru@a000 {
@@ -1212,6 +1218,9 @@ pru0_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_1: rtu@6000 {
@@ -1221,6 +1230,9 @@ rtu0_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_1: txpru@c000 {
@@ -1339,6 +1351,9 @@ pru1_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_0: rtu@4000 {
@@ -1348,6 +1363,9 @@ rtu1_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_0: txpru@a000 {
@@ -1366,6 +1384,9 @@ pru1_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_1: rtu@6000 {
@@ -1375,6 +1396,9 @@ rtu1_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_1: txpru@c000 {
@@ -1493,6 +1517,9 @@ pru2_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru2_0-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu2_0: rtu@4000 {
@@ -1502,6 +1529,9 @@ rtu2_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu2_0-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru2_0: txpru@a000 {
@@ -1520,6 +1550,9 @@ pru2_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru2_1-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu2_1: rtu@6000 {
@@ -1529,6 +1562,9 @@ rtu2_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu2_1-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru2_1: txpru@c000 {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-193539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2518D2D87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D051C2570B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E031667DA;
	Wed, 29 May 2024 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xAMB1rPD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F01649BE;
	Wed, 29 May 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965074; cv=none; b=dTQDJimfhpJ2S8B5g0vexGCoQeB9JFCK2kp8riZIGyFMRSVVW6/ufxM3zWaq+3iBf0K3OEI2bdv7R5K4SDtAxs89MPEHEjHlcVnUQCsRt71Eog4gDfflwGlPPJR+7Iwc3XZs3RXV3rupi3wNd9vow9LqFJhiWPPKo+1Wd1SLaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965074; c=relaxed/simple;
	bh=0AU0WfbhyhjWL4oF3uwShX+yi9Xbsm5hWWtgZpZt9ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m39lc+VfZg+dD/fbrp2tlslXJQ0aZRkgr0aLrpnOM8lFcKenCLv6o7bOCNdiz33WVmDyM45doI4o5Lur+JKyOn+C0exJDymc1GkzUVFyHim9FaJo+pdcgIX2KDupVrKCon+9qsjmSow4R/H2IinfW55aHGUt/xbWVSte6NDpA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xAMB1rPD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T6iOrk128512;
	Wed, 29 May 2024 01:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716965064;
	bh=Z/MWhRRgW7xSmp4jcS9MP7RtV6SNVCKc91bB8jxd5fo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xAMB1rPDmbhM61yJnoFqBU0R/y7/hk2uyYvxKwpUPcFd5g0KLkOz/cZ6bbdmD6NzG
	 CtWmpYztPQoZkvSZ6gr4FL8L2lzkkZ3j1VCOtMT/EV6M2H6UPlD03E4S57MKR9HX/B
	 FJxpcr5yV4rtvJ1N6Y30JLsOiYUbysJP8Kk3vPYE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T6iOiW004159
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 01:44:24 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 01:44:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 01:44:24 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T6iOiq054034;
	Wed, 29 May 2024 01:44:24 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44T6iN6K015795;
	Wed, 29 May 2024 01:44:23 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-am64-main: Add PRU system events for virtio
Date: Wed, 29 May 2024 12:14:18 +0530
Message-ID: <20240529064420.571615-2-danishanwar@ti.com>
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

PRU system events "vring" have been added to each PRU and RTU node
in each of the ICSSG0 and ICSSG1 remote processor subsystems to
enable the virtio/rpmsg communication between MPU and that PRU/RTU core.
No events have been added to the Tx_PRU cores at present. The
additions are done in the base k3-am64main.dtsi, and so are inherited
by all the K3 AM64x boards.

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
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 6f9aa5e02138..f8370dd03350 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1283,6 +1283,9 @@ pru0_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_0: rtu@4000 {
@@ -1292,6 +1295,9 @@ rtu0_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_0: txpru@a000 {
@@ -1310,6 +1316,9 @@ pru0_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_1: rtu@6000 {
@@ -1319,6 +1328,9 @@ rtu0_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_1: txpru@c000 {
@@ -1436,6 +1448,9 @@ pru1_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_0: rtu@4000 {
@@ -1445,6 +1460,9 @@ rtu1_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_0: txpru@a000 {
@@ -1463,6 +1481,9 @@ pru1_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_1: rtu@6000 {
@@ -1472,6 +1493,9 @@ rtu1_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_1: txpru@c000 {
-- 
2.34.1



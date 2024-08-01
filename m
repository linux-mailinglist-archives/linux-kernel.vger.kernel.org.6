Return-Path: <linux-kernel+bounces-271708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B473945247
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2471C2103C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8011BC9F6;
	Thu,  1 Aug 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cXiMsT1o"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C461B4C49;
	Thu,  1 Aug 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534617; cv=none; b=cPufW6gkEETvVtA0y+JwvaCElVy2B8Wd+YmZe44hPviDVCVyU15OjRimvkN5ra79xiXIYfHwUwLyrdRui3fKRrE1rhh3c+/BZrgkJqWwA2t5XsMyVOOz1C0y55a7VZ1PRpxXLRvuCH+/bCI9uTP477nxZY0K5g/VJeMbUPRTJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534617; c=relaxed/simple;
	bh=VUjBkOTLLEenOZBbD9TlAxfiFafmMMHYA38GkifZpd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjnHtFcG9C+Q5hg70/wgXymDVx7QtO3K1amTfzGMKhEqz5ZF8WSwwe0kwLt6q+XlwXskDoP2jdfuea/Zkw1TQeusnn7EBu3gS+oZnlQn7Ww21jEKVMmUKicOZdMjNZCIVJh0ioOwBEK1/FNOjVYW0KApP5VE0qlWRaGoYEXS8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cXiMsT1o; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471HnjUx124005;
	Thu, 1 Aug 2024 12:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722534585;
	bh=VeX6B6WBQ46KXMvyCe3WTGgD7pbQWfOlU3CB4tfqfFk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cXiMsT1oAhuDaT67rE/hUcBmv7a5/9+mWcaW4VvTOAqY4Zg02fajH3m7TGqGXzZ0q
	 VxGI3x7mrLX2CWRWEkASkqg7xT8B/NdHPhI5hOiYRJdmRXP4OArehBNKtZmv+argft
	 7ifCRvlekhZ1sCaRpdOw/z8JQJqm2ZGf6uKXH0Kw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471Hni3e027462
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 12:49:44 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 12:49:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 12:49:44 -0500
Received: from localhost.localdomain ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471Hngkk067627;
	Thu, 1 Aug 2024 12:49:44 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Humphreys <j-humphreys@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-j784s4: Include entire FSS region in ranges
Date: Thu, 1 Aug 2024 12:49:41 -0500
Message-ID: <20240801174941.41002-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240801174941.41002-1-afd@ti.com>
References: <20240801174941.41002-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add FSS regions at 0x50000000, 0x400000000, and 0x600000000. Although
not used currently by the Linux FSS driver, these regions belong to
the FSS and should be included in the ranges mapping.

While here, a couple of these numbers had missing zeros which was
hidden by odd alignments, fix both these issues.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi            |  8 +++-----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index f3a6ed1c979d0..ad199ce2edacb 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -678,16 +678,16 @@ fss: bus@47000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
-			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
-			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
-			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
-			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
+		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00000100>, /* FSS Control */
+			 <0x00 0x47040000 0x00 0x47040000 0x00 0x00000100>, /* OSPI0 Control */
+			 <0x00 0x47050000 0x00 0x47050000 0x00 0x00000100>, /* OSPI1 Control */
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* OSPI0/1 Memory Region 1 */
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* OSPI0/1 Memory Region 0/3 */
 
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x00 0x47040000 0x00 0x100>,
-			      <0x05 0x0000000 0x01 0x0000000>;
+			      <0x05 0x00000000 0x01 0x00000000>;
 			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
@@ -705,7 +705,7 @@ ospi0: spi@47040000 {
 		ospi1: spi@47050000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x00 0x47050000 0x00 0x100>,
-			      <0x07 0x0000000 0x01 0x0000000>;
+			      <0x07 0x00000000 0x01 0x00000000>;
 			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 73cc3c1fec08d..f3f57da6cefa8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -271,8 +271,7 @@ cbass_main: bus@100000 {
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
 			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
 			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
-			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
-			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
 
 		cbass_mcu_wakeup: bus@28380000 {
 			bootph-all;
@@ -289,9 +288,8 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
 				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
-				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
-				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS OSPI0/1 data region 0/3 */
 		};
 	};
 
-- 
2.39.2



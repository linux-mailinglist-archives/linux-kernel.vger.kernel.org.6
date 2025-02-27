Return-Path: <linux-kernel+bounces-536716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0309A4835A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC5D3B84B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0837426F46F;
	Thu, 27 Feb 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="eClDNJsW"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2112.outbound.protection.outlook.com [40.107.21.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693A26E96F;
	Thu, 27 Feb 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670852; cv=fail; b=NnBWKeL4qs9p//Vssmj5SENf8uI7dxc9GarjryS5Jz6Fj3eqc2Bmr9NNSkgZBxVLBlJxupdAEGc8bbbsDPSEPaxsJA1BOg8Jeez2VHsdArYICGF5cajNyCw7Q6usYMd/EBw/BnIN9VGrGwAS1Hl190iIw4T5JFrXg1Tq4RQgUh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670852; c=relaxed/simple;
	bh=KaeG9Zq3wFQp4DJRU1MQPwQpcv0TudYzFCP3H5B3+vA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNrizXyCNbcT7Aii1GFSJhxeNMBX7elsyooUFf1CQn9enSbsFfvpzobXpMCMr1OApG2m3IsBrOIMkuSfUTGWJwjNI3yPuOvpmuVdgv5UpL+OFdNWZp6dzoQ0ba9nK0g/PeeSY08y/yIq46wPdh4q/m5R7vVr5dABB2vobok8CQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=eClDNJsW; arc=fail smtp.client-ip=40.107.21.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK4XSuBa8bD7soo3mdeGtY8G+dXev0vehrESdxJx82qyb/nuu3mZIMuS0qigJZLzZofeSBSyzcxxWrXELoprzglf+hXXp2NuP8hRcCnWcI9r/qRGcT7zWEM4BSIjZsCRF+Mdv6lkggHM6bbHohHK4H4y1uELj3ySs6429KHrrLc1AFNHxNDhfRX1zgdUPAKBSptnEclCf17Flndw74IaD1x4Y7eeA7+GzW1sBS7GXRtQhSBLVHfSLsFJV7sral79DzXjhRvh9BbPGoVh5AO8Gpl4zBWCXOBqZblAaUw78TUUHi1rtQcMa7FwWmWOqxe5105buKy6r3IH5fmK84g+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MHKeVQmckj9LWliyWJoJlMe5edoRVM/MNJ06Otj8SQ=;
 b=sy9JbFSX3zdJMRcTVj3oc+Q5flHxY8nyxpntXNoGKOBgD84RZ9cWOJblEL+6FYLg/zVR5VzBV70iZGUcE2kIwiyR9NfmCLqTxOJm8SNILyqXux3NPCbY9lxNTenSaqw95vYjloWGFsuukK6u1v97fn0sZBfhfiCCGratAAPd54ZzgMMM/iqxkIKRj4wIVysHLFcCb2S7/HJB4PYIFwoh4lCM3LIoHi4SeQKKqCxEDYfOJ/APArNNSyS1571a7n/QAYxRTKxV6iUT6+CJoMM0lovdbwqG62XsBBiJG5vcSG/H38G/HNu2P1/IjUJggw428qoyCN+PIN2wZjjHFMtKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MHKeVQmckj9LWliyWJoJlMe5edoRVM/MNJ06Otj8SQ=;
 b=eClDNJsWKnGOKLw5IKE1nezgAZ6XHB6S7dV4m6ECZnODF63oRAvkxeVHdP4BhLHQwe677+tLsxHKfIqYq93HN2Pu2VT/xkmDubVDvAsqtPfrkgqdj1/vI9zWrjPsVHIzjeNdhuA7qsQYiIidOCcsT5ps0HWneBrCliWmcGGVrjk=
Received: from AS9PR06CA0546.eurprd06.prod.outlook.com (2603:10a6:20b:485::7)
 by PAVP195MB2232.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 15:40:44 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:485:cafe::34) by AS9PR06CA0546.outlook.office365.com
 (2603:10a6:20b:485::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 15:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:40:44 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:18 +0100
Received: from Florix.phytec.de (172.25.0.13) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:18 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 27 Feb 2025 16:40:18 +0100
Received: from localhost.localdomain ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025022716401798-93 ;
          Thu, 27 Feb 2025 16:40:17 +0100 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH 10/11] ARM: dts: stm32: phyboard-sargas and phycore: Fix coding style issues
Date: Thu, 27 Feb 2025 16:40:11 +0100
Message-ID: <20250227154012.259566-11-c.parant@phytec.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227154012.259566-1-c.parant@phytec.fr>
References: <20250227154012.259566-1-c.parant@phytec.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.02.2025 16:40:18,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.02.2025 16:40:18
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|PAVP195MB2232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad0fd0c-5fcf-4a46-9bba-08dd5745190a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c9wKtLxkhMJ4b4QHYWTxz1wq6j7g1BhAzBX988awGnukFvvK/gD9pqzD7LlS?=
 =?us-ascii?Q?pECn8ojzR+9lTnj8x3mEPmdxSSav9nQQohVkl61/1uIWm1Qel/zKamc4CZKw?=
 =?us-ascii?Q?JP+R0Ib1ON3ejqx9u1p3cQUnmPwFPOUta0X/x7SDZ0Nm8o5yPb7tpmnD7q01?=
 =?us-ascii?Q?XuBqFGwaLWFvFwNqXHlzzrI9mC8Ju7SmwRk86xfu3bZXvONQK58F4grxDBvN?=
 =?us-ascii?Q?ZiuharBAmLQLXE5OhOjMIMct5ZtKJqWHQi3Z+cqxFtC4e9tGwhOrynF+PeTF?=
 =?us-ascii?Q?D0vydimnL2rTHR2N1KLCbq1vbHy51zkaN99LOlLhIOFJKEn4zG/1hYOtppjf?=
 =?us-ascii?Q?acszHs0KMfO74L2+OtdrHi/WwqlrzQ4SrU2H90S3YoygdGr7h+al+WGoQNzR?=
 =?us-ascii?Q?bg/5WSey1CI51rkrqTK4Adx5rdioByv1dmKjNglWDbE7RM3z5fhBK6gRBfLa?=
 =?us-ascii?Q?JuEpcf81OqUaTkrQQ0W5VqVJcSvUxgdbLO7FaG+d1qaLjssIhAfq/x6bZZqw?=
 =?us-ascii?Q?6AtyMcF3JBfiKpkDop8UliBOiZe45KM+i2Yg0URBr6pmLqQLthD22uGjDktH?=
 =?us-ascii?Q?JST6yU7d07mPEC8TwQi8ZKRTeRCq75QZJdEEDzqg01IISJpiRGTuy8km8ya2?=
 =?us-ascii?Q?xOyVD3eEkpttAGAEtn5KQf6vDz5d0KzB1qT58BbwpzidXEoQur2nBZFPxvye?=
 =?us-ascii?Q?qW/kuybAtAoPt9LoQIS2zMjQHmCn0nqYE6wCzAQktkzBcTnWgI212jJRV6aa?=
 =?us-ascii?Q?tMON14aaNaDBWLhhHCETRPIJUzK7EA5u4ZLiy7ayKWqyOjSLJjYugMWJ+5hD?=
 =?us-ascii?Q?wX3Jp20XsSmzKjuMaB6tgSqC1fmATKOHMEdaDU9scOcmYuQabutNCLIR5Zt/?=
 =?us-ascii?Q?dJLyXfH+4RAA6lgq+2peZgbiphYL48ioyovkYjEgiFqe4l0swpMR9WeX0wbl?=
 =?us-ascii?Q?Bg/ggBqFVlbnxOum5+pWVf1O/21vHUzo80V8LVeGdSKDR8oMsGS4DImLRSyp?=
 =?us-ascii?Q?+ZoAHK8GK/kZlNaDObKdwZhuOguDOyXf0NiheXAp6bdM6IGjBzvEC+SCracX?=
 =?us-ascii?Q?HWWaMNjrqn8vtXmXS99z/xjMet7YftXH7E65Amn9xSShQSu6x8VteHrLij8G?=
 =?us-ascii?Q?c45fYrqUR5p8qx2x0NIuyof9/9g2t/7wS1q08wcwtpAeWidT2o0ETvDcprSf?=
 =?us-ascii?Q?5eMTHTG1r36QwabYW2DkxY80hGU11WWlfvmpA/s+gvS3N2HwPBxhJ6Bn5qZj?=
 =?us-ascii?Q?Uzcwzv1lB7YQUd+pIkJbPpiHh65X2ZOFTgCF9bkKE+rfWvlZ5HBMgcyBruhg?=
 =?us-ascii?Q?4h7stnu8R8meQghJwZJeix9Ozja5lo21vSccnTuYfJXOyUaKmtCw6RidePi4?=
 =?us-ascii?Q?/08r1Z4moou/Ep1LL+rXBEhIXHoOx62a1GqGE0/6qFxiTZkgSAQ3nCNvWVNb?=
 =?us-ascii?Q?447m00If/DL6TEMLstuaPkdwGKCtE/4G6qSQUuLXvbGDdzmQy2XGhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:40:44.0651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad0fd0c-5fcf-4a46-9bba-08dd5745190a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2232

- Remove "stm32-pinfunc.h" include as it is already include in
"stm32mp15-pinctrl.dtsi" file.
- reserved-memory: reorder the memory sections (lower to higher
  addresses).
- Move vendor properties (go last).
- Remove useless compatible values:
  - QSPI flash: remove the winbond compatible. jedec is enought as the
    NOR flahses are detectable.
  - EEPROM: "atmel,24c32" is enought.
- Use uppercase for regulator-name properties.
- In pmic node: use the names from the PHYTEC SoM schematics.
- stmpe811 touch: fix dts schema to comply with st,stmpe.yaml.
- Fix one "multiple blank lines" detected by checkpatch.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 .../st/stm32mp157c-phyboard-sargas-rdk.dts    |  1 -
 .../dts/st/stm32mp15xx-phyboard-sargas.dtsi   | 13 ++--
 .../boot/dts/st/stm32mp15xx-phycore-som.dtsi  | 64 +++++++++----------
 3 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts b/arc=
h/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
index c9870f94ac1f..9a6270e68c6c 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
@@ -6,7 +6,6 @@
=20
 /dts-v1/;
=20
-#include <dt-bindings/pinctrl/stm32-pinfunc.h>
 #include "stm32mp157.dtsi"
 #include "stm32mp15xc.dtsi"
 #include "stm32mp15xx-phycore-som.dtsi"
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi b/arch/a=
rm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
index 3d62f9e4d0cd..729a97f82538 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
@@ -5,7 +5,6 @@
  * Author: Dom VOVARD <dom.vovard@linrt.com>.
  */
=20
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/leds/common.h>
@@ -101,13 +100,13 @@ touch@44 {
 		interrupt-parent =3D <&gpioi>;
 		vio-supply =3D <&v3v3>;
 		vcc-supply =3D <&v3v3>;
+		st,sample-time =3D <4>;
+		st,mod-12b =3D <1>;
+		st,ref-sel =3D <0>;
+		st,adc-freq =3D <1>;
=20
 		touchscreen {
 			compatible =3D "st,stmpe-ts";
-			st,sample-time =3D <4>;
-			st,mod-12b =3D <1>;
-			st,ref-sel =3D <0>;
-			st,adc-freq =3D <1>;
 			st,ave-ctrl =3D <1>;
 			st,touch-det-delay =3D <2>;
 			st,settling =3D <2>;
@@ -159,10 +158,10 @@ &sai2 {
=20
 &sai2a {
 	dma-names =3D "rx";
-	st,sync =3D <&sai2b 2>;
 	clocks =3D <&rcc SAI2=5FK>, <&sai2b>;
 	clock-names =3D "sai=5Fck", "MCLK";
 	#clock-cells =3D <0>;
+	st,sync =3D <&sai2b 2>;
=20
 	sai2a=5Fport: port {
 		sai2a=5Fendpoint: endpoint {
@@ -195,9 +194,9 @@ &sdmmc1 {
 	pinctrl-2 =3D <&sdmmc1=5Fb4=5Fsleep=5Fpins=5Fb>;
 	cd-gpios =3D <&gpiof 3 GPIO=5FACTIVE=5FLOW>;
 	disable-wp;
-	st,neg-edge;
 	bus-width =3D <4>;
 	vmmc-supply =3D <&v3v3>;
+	st,neg-edge;
 	status =3D "okay";
 };
=20
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index 3f60f184978c..0689967b8c56 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -36,18 +36,6 @@ reserved-memory {
 		#size-cells =3D <1>;
 		ranges;
=20
-		retram: retram@38000000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x38000000 0x10000>;
-			no-map;
-		};
-
-		mcuram: mcuram@30000000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x30000000 0x40000>;
-			no-map;
-		};
-
 		mcuram2: mcuram2@10000000 {
 			compatible =3D "shared-dma-pool";
 			reg =3D <0x10000000 0x40000>;
@@ -71,11 +59,22 @@ vdev0buffer: vdev0buffer@10042000 {
 			reg =3D <0x10042000 0x4000>;
 			no-map;
 		};
+		mcuram: mcuram@30000000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x30000000 0x40000>;
+			no-map;
+		};
+
+		retram: retram@38000000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x38000000 0x10000>;
+			no-map;
+		};
 	};
=20
 	regulator=5Fvin: regulator {
 		compatible =3D "regulator-fixed";
-		regulator-name =3D "vin";
+		regulator-name =3D "VIN";
 		regulator-min-microvolt =3D <5000000>;
 		regulator-max-microvolt =3D <5000000>;
 		regulator-always-on;
@@ -102,11 +101,11 @@ phy0: ethernet-phy@1 {
 			reg =3D <1>;
 			interrupt-parent =3D <&gpiog>;
 			interrupts =3D <12 IRQ=5FTYPE=5FEDGE=5FFALLING>;
+			enet-phy-lane-no-swap;
 			ti,rx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
 			ti,tx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
 			ti,fifo-depth =3D <DP83867=5FPHYCR=5FFIFO=5FDEPTH=5F4=5FB=5FNIB>;
 			ti,min-output-impedance;
-			enet-phy-lane-no-swap;
 			ti,clk-output-sel =3D <DP83867=5FCLK=5FO=5FSEL=5FOFF>;
 		};
 	};
@@ -144,7 +143,7 @@ regulators {
 			pwr=5Fsw2-supply =3D <&bst=5Fout>;
=20
 			vddcore: buck1 {
-				regulator-name =3D "vddcore";
+				regulator-name =3D "VDD=5FCORE";
 				regulator-min-microvolt =3D <1200000>;
 				regulator-max-microvolt =3D <1350000>;
 				regulator-always-on;
@@ -152,7 +151,7 @@ vddcore: buck1 {
 			};
=20
 			vdd=5Fddr: buck2 {
-				regulator-name =3D "vdd=5Fddr";
+				regulator-name =3D "VDD=5FDDR";
 				regulator-min-microvolt =3D <1350000>;
 				regulator-max-microvolt =3D <1350000>;
 				regulator-always-on;
@@ -160,7 +159,7 @@ vdd=5Fddr: buck2 {
 			};
=20
 			vdd: buck3 {
-				regulator-name =3D "vdd";
+				regulator-name =3D "VDD";
 				regulator-min-microvolt =3D <3300000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-always-on;
@@ -169,7 +168,7 @@ vdd: buck3 {
 			};
=20
 			v3v3: buck4 {
-				regulator-name =3D "v3v3";
+				regulator-name =3D "VDD=5FBUCK4";
 				regulator-min-microvolt =3D <3300000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-always-on;
@@ -177,7 +176,7 @@ v3v3: buck4 {
 			};
=20
 			v1v8=5Faudio: ldo1 {
-				regulator-name =3D "v1v8=5Faudio";
+				regulator-name =3D "VDD=5FLDO1";
 				regulator-min-microvolt =3D <1800000>;
 				regulator-max-microvolt =3D <1800000>;
 				regulator-always-on;
@@ -186,7 +185,7 @@ v1v8=5Faudio: ldo1 {
 			};
=20
 			vdd=5Feth=5F2v5: ldo2 {
-				regulator-name =3D "dd=5Feth=5F2v5";
+				regulator-name =3D "VDD=5FETH=5F2V5";
 				regulator-min-microvolt =3D <2500000>;
 				regulator-max-microvolt =3D <2500000>;
 				regulator-always-on;
@@ -195,7 +194,7 @@ vdd=5Feth=5F2v5: ldo2 {
 			};
=20
 			vtt=5Fddr: ldo3 {
-				regulator-name =3D "vtt=5Fddr";
+				regulator-name =3D "VTT=5FDDR";
 				regulator-min-microvolt =3D <500000>;
 				regulator-max-microvolt =3D <750000>;
 				regulator-always-on;
@@ -203,12 +202,12 @@ vtt=5Fddr: ldo3 {
 			};
=20
 			vdd=5Fusb: ldo4 {
-				regulator-name =3D "vdd=5Fusb";
+				regulator-name =3D "VDD=5FUSB";
 				interrupts =3D <IT=5FCURLIM=5FLDO4 0>;
 			};
=20
 			vdda: ldo5 {
-				regulator-name =3D "vdda";
+				regulator-name =3D "VDDA";
 				regulator-min-microvolt =3D <2900000>;
 				regulator-max-microvolt =3D <2900000>;
 				interrupts =3D <IT=5FCURLIM=5FLDO5 0>;
@@ -216,7 +215,7 @@ vdda: ldo5 {
 			};
=20
 			vdd=5Feth=5F1v0: ldo6 {
-				regulator-name =3D "vdd=5Feth=5F1v0";
+				regulator-name =3D "VDD=5FETH=5F1V0";
 				regulator-min-microvolt =3D <1000000>;
 				regulator-max-microvolt =3D <1000000>;
 				regulator-always-on;
@@ -225,23 +224,23 @@ vdd=5Feth=5F1v0: ldo6 {
 			};
=20
 			vref=5Fddr: vref=5Fddr {
-				regulator-name =3D "vref=5Fddr";
+				regulator-name =3D "VDD=5FREFDDR";
 				regulator-always-on;
 			};
=20
 			bst=5Fout: boost {
-				regulator-name =3D "bst=5Fout";
+				regulator-name =3D "BST=5FOUT";
 				interrupts =3D <IT=5FOCP=5FBOOST 0>;
 			};
=20
 			vbus=5Fotg: pwr=5Fsw1 {
-				regulator-name =3D "vbus=5Fotg";
+				regulator-name =3D "VBUS=5FOTG";
 				interrupts =3D <IT=5FOCP=5FOTG 0>;
 				regulator-active-discharge =3D <1>;
 			};
=20
 			vbus=5Fsw: pwr=5Fsw2 {
-				regulator-name =3D "vbus=5Fsw";
+				regulator-name =3D "VBUS=5FSW";
 				interrupts =3D <IT=5FOCP=5FSWOUT 0>;
 				regulator-active-discharge =3D <1>;
 			};
@@ -262,8 +261,7 @@ watchdog {
 	};
=20
 	i2c4=5Feeprom: eeprom@50 {
-		compatible =3D "microchip,24c32",
-			     "atmel,24c32";
+		compatible =3D "atmel,24c32";
 		reg =3D <0x50>;
 		status =3D "disabled";
 	};
@@ -312,13 +310,11 @@ &qspi=5Fbk1=5Fsleep=5Fpins=5Fa
 	status =3D "disabled";
=20
 	flash0: flash@0 {
-		compatible =3D "winbond,w25q128", "jedec,spi-nor";
+		compatible =3D "jedec,spi-nor";
 		reg =3D <0>;
 		spi-rx-bus-width =3D <4>;
 		spi-max-frequency =3D <50000000>;
 		m25p,fast-read;
-		#address-cells =3D <1>;
-		#size-cells =3D <1>;
 	};
 };
=20
@@ -342,10 +338,10 @@ &sdmmc2 {
 	non-removable;
 	no-sd;
 	no-sdio;
-	st,neg-edge;
 	bus-width =3D <8>;
 	vmmc-supply =3D <&v3v3>;
 	vqmmc-supply =3D <&v3v3>;
 	mmc-ddr-3=5F3v;
+	st,neg-edge;
 	status =3D "disabled";
 };
--=20
2.34.1



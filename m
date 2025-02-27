Return-Path: <linux-kernel+bounces-536707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C9A48346
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14853B6805
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF726E145;
	Thu, 27 Feb 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="A1U9XxnF"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2130.outbound.protection.outlook.com [40.107.103.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A926AA86;
	Thu, 27 Feb 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670822; cv=fail; b=FK48w8Pu2F3ouw0NoqB82IBhwYROVdhGriMUdBcl6OXS5wbOkSbqmlHjGajdemfPE911fEZp1sonGV2S0FEN4EYJKGAkJG1iqSjprBl6mOhHhe2zBfXVGd/34s4ida309durZnYOqwSiOlOK4CF1eZBrj0ePqSaegbSEUQL0nek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670822; c=relaxed/simple;
	bh=Pu8oDNVyQsZRuzyXX/DE0sHUlYP/+BoweNPMRP3ZhAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wio28KBqA/CPcN2x2Nx0TCeG2pWyzJ0b4dSTap5hVmrTqFAfz9QRU9ffp7lqRJl8BYCdInIKD/cgH0wszdrhLMKzCO+unhe0Jx1zV+VPoRxhvdcY8p1I8OCI1kNf/HnVqIluVpt391tXcNyqVJ3htk0cswsW9r/rmER/dNSHizU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=A1U9XxnF; arc=fail smtp.client-ip=40.107.103.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUDRQLKw5YZX+gbH4wjmqz16TpJ922zAhatWDb08dN/hJmHzTqM7jXa90IDHHm2Ki9KYaE0SKFR/Y+esAOlCA0e9fhCRIlPwkktlVJfEWfbBW1Ee8MHooM7jUgP9oxbabJNHy/DUqdMAZ5ZwoW0S3/v3/oz8BEb9d6SmyC+O1LTQLYWWzUtKA1SSRSjvRRcGR5JvSm/G3oOFHCfjo2YQtcbDhcJQb6p/L6Gk0t2xkMgfzUDLPXqTykuN6uyucPo5yDfN/0hEr5x605JoqvnJD2ENO2wMARCYUWdbow9h9/PTXrFNeU86h/N2Rv7sI9rQYXvKdKyZ/ydyZifVH8+K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl6Ki9DEGT5choe27M1bsc5lfZ/VeCFcHJhhxs6rYGs=;
 b=T+W+n4nEJVsJnY5GJ6rzzQkFXuMJ+9r04MhnIPqVCq/qEKuUJYDRMxELR4ibq4ykeKObzHxNspaslNfsBupjmAJ9D82fyfsaWbQcTCI+8Fk4ymTiYiWDuayWV1Jmh6CnhU6RU8klcDxHd2RJYCWXqNP8YaOHMkNvmtE0ZwgQ5Jq+ZwAHSdsZEFV5PZuNWG9Q9cDIp015OrzYiTSXYruBRKA39+AnIrx+X4UFExkw0VOH5J2LQnI4dRGoIqHiWXbmgOSUVfUau78PRQtcENR0PSPgn87CDRtVyn6LNGta3KrmIVg9J7eCADlDCW47Wo9dqs1SGJyVqD3VUBFsid6/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl6Ki9DEGT5choe27M1bsc5lfZ/VeCFcHJhhxs6rYGs=;
 b=A1U9XxnF60/nnBNcSRLZXIRmIW6vhuGBguUFHVvqYMxWHZ5OKJ4keGJw8txPfy/kfOtoffDaxkpynZ2GGheLopw22bFLLlhEPjwRynLrf4n3AbzUKYOC547olBUBvS8Se13Z+rCAXt+/ACJIcv4/JybObMjAJUxiv9sNkPIeKLY=
Received: from AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::11)
 by PR3P195MB0571.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 15:40:14 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::ff) by AS4PR10CA0030.outlook.office365.com
 (2603:10a6:20b:5d8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 15:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:40:14 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:14 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:13 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 27 Feb 2025 16:40:13 +0100
Received: from localhost.localdomain ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025022716401376-85 ;
          Thu, 27 Feb 2025 16:40:13 +0100 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH 02/11] ARM: dts: stm32: phyboard-sargas: Introduce SoM device tree
Date: Thu, 27 Feb 2025 16:40:03 +0100
Message-ID: <20250227154012.259566-3-c.parant@phytec.fr>
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
 27.02.2025 16:40:13,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.02.2025 16:40:13
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|PR3P195MB0571:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e7c205-db14-4a7b-8539-08dd5745079b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykoSey5GQy/Y2hCvcGkL16MRDbayTrE12styd8MhqO9F7p7BTBA0gwkKgji7?=
 =?us-ascii?Q?UkC0+r1aHgvsdY17DqK79K44L53o+Yf0bUfGbFok+ga2/dcUhk9tFbobHQ72?=
 =?us-ascii?Q?UjA39xjxULdPyuuoCNJTW0QqHFClI4r4HMViQ1qguOtKxejn24YXaxEJthai?=
 =?us-ascii?Q?T3chYjxBQdlOYJFJAb5kvz8h3G5cgUOYgFSq1hHhILwjWaI6hbtOMnTWeesA?=
 =?us-ascii?Q?/bSt8V6OucENLaMJbJIG9UNeVLHNd/uGAfUuXFVgDibjIy0NjZNH0jO28mNo?=
 =?us-ascii?Q?7XkbVolxKszKWl4IkZuRoDDa1FI6WtGKdRqfcn8HIK3CxZV/r3p1u+v8Sx36?=
 =?us-ascii?Q?p1Ezzv0ym2aRBDTWKjr77udKjQqbjTTTn4Se4zCQ/lwov52z/HW3v0EfqSbf?=
 =?us-ascii?Q?76qaA4zsZCiqQRDxsJ8DfCV/E7lTF9Dv8HNP1mt4c7v+Ay2gYxcsmxjp3dAh?=
 =?us-ascii?Q?xcf1JHgnfAXp4cjrE/s2bqqSlDhcxh/Q98c9fRQ0Q63hSuZkRSQNzxLQuJut?=
 =?us-ascii?Q?UTeW2/+q9XHfSuIzH6gmvdwWIisdy1Mf1A4Nld4cMbYg5TmTiLR5IIFo01ja?=
 =?us-ascii?Q?M7Qg6x+I8io0erkTyMfdhRWUkiY6IKA+z72YQZRbiyPuxP98YOQAzpBvbIDi?=
 =?us-ascii?Q?v1reW7ktR2/84e0AMQe8C8I2t/MmV10nBcMFC2wk7rthqcUch9f5dbUYtUVq?=
 =?us-ascii?Q?Jqi8cA7owdLgmkxIPfDH6QGsddH4AMrDq1DCJGebFHl1D5rOyhqpTbsPLbPN?=
 =?us-ascii?Q?3J0tyS2pz3y1gF5lTLrLdW21AUFE/UYGLGS/jg3MPw2SQ+6AP3/rrtggxR7x?=
 =?us-ascii?Q?+cM0/chBozQY50PlsZugErC9CUlkAJhtWo1gfeR6Tovs16P19RZSOVWRIRi+?=
 =?us-ascii?Q?uxxhMdr+CfZDHqHNjDluv5croj9xlV+H6TdqU5eqjcu4Py+RrTqbbmyhX/CE?=
 =?us-ascii?Q?K92bfOVX3peA0tKKU2tt7T9FmPZr+6t29ZVLIdiLbleBpARNvcXpzwYw3uGJ?=
 =?us-ascii?Q?EViUe3/eoTMT4j5B0FClN5D+8lDq4+2WcMgqa3qns1zc5CUH9hjGMVn7hZF/?=
 =?us-ascii?Q?KvmEaRpZPxi/iS0sfQsQ90G/xcmXtJLCd4+yUJPxpZToRVQeRoDTt6td0fC+?=
 =?us-ascii?Q?txknoBFhj/b/oGPO58k7rkoLfzs/GkbncxN5XW0FXFMRH3NF49oCyYp7czmA?=
 =?us-ascii?Q?+uklMGpyKljLRu4NTgNwAVEXbh/yKIuI5Az6+1BuWieRjj+VI5vQ5n2npM3n?=
 =?us-ascii?Q?vc28wN4AR42a9aKCwwiW4E/B3wOG9/iU77w7vNkoTmKH86LM2u4VYh+hd4Wz?=
 =?us-ascii?Q?t/F68qQZUTzl1DZUrEUOwl++sMx71VWGMgpmQo6Md5kpartHqXHTI+Mye4Bh?=
 =?us-ascii?Q?0fWbDw/3+Z1wwEPIlv4dmDWfM2mn+g93PTzbI+kvfiPTezuD/5odBFgKa+es?=
 =?us-ascii?Q?AzVhsTn9NJJCKTO3AE4opAiIlrGwlc40/qqF7U7kE3qweFf5Oh9jrvMYBdCN?=
 =?us-ascii?Q?egkX0HrKUvMrYbM=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:40:14.8158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e7c205-db14-4a7b-8539-08dd5745079b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0571

Add stm32mp15xx-phycore-som.dtsi device tree file to slit hardware
features between the phyBOARD (baseboard) and the phyCORE (SoM).

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 .../st/stm32mp157c-phyboard-sargas-rdk.dts    |   2 +-
 .../dts/st/stm32mp15xx-phyboard-sargas.dtsi   | 317 +----------------
 .../boot/dts/st/stm32mp15xx-phycore-som.dtsi  | 329 ++++++++++++++++++
 3 files changed, 331 insertions(+), 317 deletions(-)
 create mode 100644 arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi

diff --git a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts b/arc=
h/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
index cb5a55798036..43592234573c 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
@@ -9,7 +9,7 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 #include "stm32mp157.dtsi"
 #include "stm32mp15xc.dtsi"
-#include "stm32mp15xxac-pinctrl.dtsi"
+#include "stm32mp15xx-phycore-som.dtsi"
 #include "stm32mp15xx-phyboard-sargas.dtsi"
=20
 / {
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi b/arch/a=
rm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
index ebbb82c09a1e..2fdab99fc562 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
@@ -5,23 +5,13 @@
  * Author: Dom VOVARD <dom.vovard@linrt.com>.
  */
=20
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/mfd/st,stpmic1.h>
-#include <dt-bindings/net/ti-dp83867.h>
-#include "stm32mp15-pinctrl.dtsi"
=20
 / {
-	aliases {
-		ethernet0 =3D &ethernet0;
-		rtc0 =3D &i2c4=5Frtc;
-		rtc1 =3D &rtc;
-	};
-
 	chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
@@ -42,48 +32,6 @@ key-enter {
 		};
 	};
=20
-	reserved-memory {
-		#address-cells =3D <1>;
-		#size-cells =3D <1>;
-		ranges;
-
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
-		mcuram2: mcuram2@10000000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x10000000 0x40000>;
-			no-map;
-		};
-
-		vdev0vring0: vdev0vring0@10040000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x10040000 0x1000>;
-			no-map;
-		};
-
-		vdev0vring1: vdev0vring1@10041000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x10041000 0x1000>;
-			no-map;
-		};
-
-		vdev0buffer: vdev0buffer@10042000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x10042000 0x4000>;
-			no-map;
-		};
-	};
-
 	sound {
 		compatible =3D "audio-graph-card";
 		label =3D "STM32MP1-PHYCORE";
@@ -93,44 +41,6 @@ sound {
 		dais =3D <&sai2b=5Fport>,
 		       <&sai2a=5Fport>;
 	};
-
-	regulator=5Fvin: regulator {
-		compatible =3D "regulator-fixed";
-		regulator-name =3D "vin";
-		regulator-min-microvolt =3D <5000000>;
-		regulator-max-microvolt =3D <5000000>;
-		regulator-always-on;
-	};
-};
-
-&ethernet0 {
-	pinctrl-0 =3D <&ethernet0=5Frgmii=5Fpins=5Fd>;
-	pinctrl-1 =3D <&ethernet0=5Frgmii=5Fsleep=5Fpins=5Fd>;
-	pinctrl-names =3D "default", "sleep";
-	phy-mode =3D "rgmii-id";
-	max-speed =3D <1000>;
-	phy-handle =3D <&phy0>;
-	st,eth-clk-sel;
-	status =3D "okay";
-
-	mdio {
-		#address-cells =3D <1>;
-		#size-cells =3D <0>;
-		compatible =3D "snps,dwmac-mdio";
-
-		phy0: ethernet-phy@1 {
-			compatible =3D "ethernet-phy-ieee802.3-c22";
-			reg =3D <1>;
-			interrupt-parent =3D <&gpiog>;
-			interrupts =3D <12 IRQ=5FTYPE=5FEDGE=5FFALLING>;
-			ti,rx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
-			ti,tx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
-			ti,fifo-depth =3D <DP83867=5FPHYCR=5FFIFO=5FDEPTH=5F4=5FB=5FNIB>;
-			ti,min-output-impedance;
-			enet-phy-lane-no-swap;
-			ti,clk-output-sel =3D <DP83867=5FCLK=5FO=5FSEL=5FOFF>;
-		};
-	};
 };
=20
 &i2c1 {
@@ -222,176 +132,6 @@ led-2 {
 	};
 };
=20
-&i2c4 {
-	pinctrl-names =3D "default", "sleep";
-	pinctrl-0 =3D <&i2c4=5Fpins=5Fa>;
-	pinctrl-1 =3D <&i2c4=5Fsleep=5Fpins=5Fa>;
-	i2c-scl-rising-time-ns =3D <185>;
-	i2c-scl-falling-time-ns =3D <20>;
-	status =3D "okay";
-
-	pmic@33 {
-		compatible =3D "st,stpmic1";
-		reg =3D <0x33>;
-		interrupts-extended =3D <&gpioa 0 IRQ=5FTYPE=5FEDGE=5FFALLING>;
-		interrupt-controller;
-		#interrupt-cells =3D <2>;
-
-		regulators {
-			compatible =3D "st,stpmic1-regulators";
-			buck1-supply =3D <&regulator=5Fvin>;
-			buck2-supply =3D <&regulator=5Fvin>;
-			buck3-supply =3D <&regulator=5Fvin>;
-			buck4-supply =3D <&regulator=5Fvin>;
-			ldo1-supply =3D <&v3v3>;
-			ldo2-supply =3D <&v3v3>;
-			ldo3-supply =3D <&vdd=5Fddr>;
-			ldo4-supply =3D <&regulator=5Fvin>;
-			ldo5-supply =3D <&v3v3>;
-			ldo6-supply =3D <&v3v3>;
-			boost-supply =3D <&regulator=5Fvin>;
-			pwr=5Fsw1-supply =3D <&bst=5Fout>;
-			pwr=5Fsw2-supply =3D <&bst=5Fout>;
-
-			vddcore: buck1 {
-				regulator-name =3D "vddcore";
-				regulator-min-microvolt =3D <1200000>;
-				regulator-max-microvolt =3D <1350000>;
-				regulator-always-on;
-				regulator-initial-mode =3D <0>;
-			};
-
-			vdd=5Fddr: buck2 {
-				regulator-name =3D "vdd=5Fddr";
-				regulator-min-microvolt =3D <1350000>;
-				regulator-max-microvolt =3D <1350000>;
-				regulator-always-on;
-				regulator-initial-mode =3D <0>;
-			};
-
-			vdd: buck3 {
-				regulator-name =3D "vdd";
-				regulator-min-microvolt =3D <3300000>;
-				regulator-max-microvolt =3D <3300000>;
-				regulator-always-on;
-				st,mask-reset;
-				regulator-initial-mode =3D <0>;
-			};
-
-			v3v3: buck4 {
-				regulator-name =3D "v3v3";
-				regulator-min-microvolt =3D <3300000>;
-				regulator-max-microvolt =3D <3300000>;
-				regulator-always-on;
-				regulator-initial-mode =3D <0>;
-			};
-
-			v1v8=5Faudio: ldo1 {
-				regulator-name =3D "v1v8=5Faudio";
-				regulator-min-microvolt =3D <1800000>;
-				regulator-max-microvolt =3D <1800000>;
-				regulator-always-on;
-				interrupts =3D <IT=5FCURLIM=5FLDO1 0>;
-
-			};
-
-			vdd=5Feth=5F2v5: ldo2 {
-				regulator-name =3D "dd=5Feth=5F2v5";
-				regulator-min-microvolt =3D <2500000>;
-				regulator-max-microvolt =3D <2500000>;
-				regulator-always-on;
-				interrupts =3D <IT=5FCURLIM=5FLDO2 0>;
-
-			};
-
-			vtt=5Fddr: ldo3 {
-				regulator-name =3D "vtt=5Fddr";
-				regulator-min-microvolt =3D <500000>;
-				regulator-max-microvolt =3D <750000>;
-				regulator-always-on;
-				regulator-over-current-protection;
-			};
-
-			vdd=5Fusb: ldo4 {
-				regulator-name =3D "vdd=5Fusb";
-				interrupts =3D <IT=5FCURLIM=5FLDO4 0>;
-			};
-
-			vdda: ldo5 {
-				regulator-name =3D "vdda";
-				regulator-min-microvolt =3D <2900000>;
-				regulator-max-microvolt =3D <2900000>;
-				interrupts =3D <IT=5FCURLIM=5FLDO5 0>;
-				regulator-boot-on;
-			};
-
-			vdd=5Feth=5F1v0: ldo6 {
-				regulator-name =3D "vdd=5Feth=5F1v0";
-				regulator-min-microvolt =3D <1000000>;
-				regulator-max-microvolt =3D <1000000>;
-				regulator-always-on;
-				interrupts =3D <IT=5FCURLIM=5FLDO6 0>;
-
-			};
-
-			vref=5Fddr: vref=5Fddr {
-				regulator-name =3D "vref=5Fddr";
-				regulator-always-on;
-			};
-
-			bst=5Fout: boost {
-				regulator-name =3D "bst=5Fout";
-				interrupts =3D <IT=5FOCP=5FBOOST 0>;
-			};
-
-			vbus=5Fotg: pwr=5Fsw1 {
-				regulator-name =3D "vbus=5Fotg";
-				interrupts =3D <IT=5FOCP=5FOTG 0>;
-				regulator-active-discharge =3D <1>;
-			};
-
-			vbus=5Fsw: pwr=5Fsw2 {
-				regulator-name =3D "vbus=5Fsw";
-				interrupts =3D <IT=5FOCP=5FSWOUT 0>;
-				regulator-active-discharge =3D <1>;
-			};
-		};
-
-		onkey {
-			compatible =3D "st,stpmic1-onkey";
-			interrupts =3D <IT=5FPONKEY=5FF 0>,
-				     <IT=5FPONKEY=5FR 0>;
-			interrupt-names =3D "onkey-falling",
-					  "onkey-rising";
-			power-off-time-sec =3D <10>;
-		};
-
-		watchdog {
-			compatible =3D "st,stpmic1-wdt";
-		};
-	};
-
-	i2c4=5Feeprom: eeprom@50 {
-		compatible =3D "microchip,24c32",
-			     "atmel,24c32";
-		reg =3D <0x50>;
-	};
-
-	i2c4=5Frtc: rtc@52 {
-		compatible =3D "microcrystal,rv3028";
-		reg =3D <0x52>;
-	};
-};
-
-&ipcc {
-	status =3D "okay";
-};
-
-&iwdg2 {
-	timeout-sec =3D <32>;
-	status =3D "okay";
-};
-
 &m=5Fcan2 {
 	pinctrl-names =3D "default", "sleep";
 	pinctrl-0 =3D <&m=5Fcan2=5Fpins=5Fa>;
@@ -399,46 +139,6 @@ &m=5Fcan2 {
 	status =3D "okay";
 };
=20
-&m4=5Frproc {
-	memory-region =3D <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
-			<&vdev0vring1>, <&vdev0buffer>;
-	mboxes =3D <&ipcc 0>, <&ipcc 1>, <&ipcc 2>, <&ipcc 3>;
-	mbox-names =3D "vq0", "vq1", "shutdown", "detach";
-	interrupt-parent =3D <&exti>;
-	interrupts =3D <68 1>;
-	status =3D "okay";
-};
-
-&pwr=5Fregulators {
-	vdd-supply =3D <&vdd>;
-	vdd=5F3v3=5Fusbfs-supply =3D <&vdd=5Fusb>;
-};
-
-&qspi {
-	pinctrl-names =3D "default", "sleep";
-	pinctrl-0 =3D <&qspi=5Fclk=5Fpins=5Fa &qspi=5Fbk1=5Fpins=5Fa>;
-	pinctrl-1 =3D <&qspi=5Fclk=5Fsleep=5Fpins=5Fa &qspi=5Fbk1=5Fsleep=5Fpins=
=5Fa>;
-	status =3D "okay";
-
-	flash0: flash@0 {
-		compatible =3D "winbond,w25q128", "jedec,spi-nor";
-		reg =3D <0>;
-		spi-rx-bus-width =3D <4>;
-		spi-max-frequency =3D <50000000>;
-		m25p,fast-read;
-		#address-cells =3D <1>;
-		#size-cells =3D <1>;
-	};
-};
-
-&rng1 {
-	status =3D "okay";
-};
-
-&rtc {
-	status =3D "okay";
-};
-
 &sai2 {
 	clocks =3D <&rcc SAI2>, <&rcc PLL3=5FQ>, <&rcc PLL3=5FR>;
 	clock-names =3D "pclk", "x8k", "x11k";
@@ -492,21 +192,6 @@ &sdmmc1 {
 	status =3D "okay";
 };
=20
-&sdmmc2 {
-	pinctrl-names =3D "default", "opendrain", "sleep";
-	pinctrl-0 =3D <&sdmmc2=5Fb4=5Fpins=5Fa &sdmmc2=5Fd47=5Fpins=5Fe>;
-	pinctrl-1 =3D <&sdmmc2=5Fb4=5Fod=5Fpins=5Fa &sdmmc2=5Fd47=5Fpins=5Fe>;
-	pinctrl-2 =3D <&sdmmc2=5Fb4=5Fsleep=5Fpins=5Fa &sdmmc2=5Fd47=5Fsleep=5Fpi=
ns=5Fe>;
-	non-removable;
-	no-sd;
-	no-sdio;
-	st,neg-edge;
-	bus-width =3D <8>;
-	vmmc-supply =3D <&v3v3>;
-	vqmmc-supply =3D <&v3v3>;
-	mmc-ddr-3=5F3v;
-};
-
 &spi1 {
 	pinctrl-names =3D "default", "sleep";
 	pinctrl-0 =3D <&spi1=5Fpins=5Fa>;
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
new file mode 100644
index 000000000000..660cdc260963
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) Phytec GmbH 2019-2020 - All Rights Reserved
+ * Author: Dom VOVARD <dom.vovard@linrt.com>
+ * Copyright (C) 2022-2023 Steffen Trumtrar <kernel@pengutronix.de>
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Christophe Parant <c.parant@phytec.fr>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/st,stpmic1.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
+
+/ {
+
+	aliases {
+		ethernet0 =3D &ethernet0;
+		rtc0 =3D &i2c4=5Frtc;
+		rtc1 =3D &rtc;
+	};
+
+	reserved-memory {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges;
+
+		retram: retram@38000000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x38000000 0x10000>;
+			no-map;
+		};
+
+		mcuram: mcuram@30000000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x30000000 0x40000>;
+			no-map;
+		};
+
+		mcuram2: mcuram2@10000000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x10000000 0x40000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@10040000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x10040000 0x1000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@10041000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x10041000 0x1000>;
+			no-map;
+		};
+
+		vdev0buffer: vdev0buffer@10042000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x10042000 0x4000>;
+			no-map;
+		};
+	};
+
+	regulator=5Fvin: regulator {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vin";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		regulator-always-on;
+	};
+};
+
+&ethernet0 {
+	pinctrl-0 =3D <&ethernet0=5Frgmii=5Fpins=5Fd>;
+	pinctrl-1 =3D <&ethernet0=5Frgmii=5Fsleep=5Fpins=5Fd>;
+	pinctrl-names =3D "default", "sleep";
+	phy-mode =3D "rgmii-id";
+	max-speed =3D <1000>;
+	phy-handle =3D <&phy0>;
+	st,eth-clk-sel;
+	status =3D "okay";
+
+	mdio {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		compatible =3D "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@1 {
+			compatible =3D "ethernet-phy-ieee802.3-c22";
+			reg =3D <1>;
+			interrupt-parent =3D <&gpiog>;
+			interrupts =3D <12 IRQ=5FTYPE=5FEDGE=5FFALLING>;
+			ti,rx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
+			ti,tx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
+			ti,fifo-depth =3D <DP83867=5FPHYCR=5FFIFO=5FDEPTH=5F4=5FB=5FNIB>;
+			ti,min-output-impedance;
+			enet-phy-lane-no-swap;
+			ti,clk-output-sel =3D <DP83867=5FCLK=5FO=5FSEL=5FOFF>;
+		};
+	};
+};
+
+&i2c4 {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&i2c4=5Fpins=5Fa>;
+	pinctrl-1 =3D <&i2c4=5Fsleep=5Fpins=5Fa>;
+	i2c-scl-rising-time-ns =3D <185>;
+	i2c-scl-falling-time-ns =3D <20>;
+	status =3D "okay";
+
+	pmic@33 {
+		compatible =3D "st,stpmic1";
+		reg =3D <0x33>;
+		interrupts-extended =3D <&gpioa 0 IRQ=5FTYPE=5FEDGE=5FFALLING>;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+
+		regulators {
+			compatible =3D "st,stpmic1-regulators";
+			buck1-supply =3D <&regulator=5Fvin>;
+			buck2-supply =3D <&regulator=5Fvin>;
+			buck3-supply =3D <&regulator=5Fvin>;
+			buck4-supply =3D <&regulator=5Fvin>;
+			ldo1-supply =3D <&v3v3>;
+			ldo2-supply =3D <&v3v3>;
+			ldo3-supply =3D <&vdd=5Fddr>;
+			ldo4-supply =3D <&regulator=5Fvin>;
+			ldo5-supply =3D <&v3v3>;
+			ldo6-supply =3D <&v3v3>;
+			boost-supply =3D <&regulator=5Fvin>;
+			pwr=5Fsw1-supply =3D <&bst=5Fout>;
+			pwr=5Fsw2-supply =3D <&bst=5Fout>;
+
+			vddcore: buck1 {
+				regulator-name =3D "vddcore";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <1350000>;
+				regulator-always-on;
+				regulator-initial-mode =3D <0>;
+			};
+
+			vdd=5Fddr: buck2 {
+				regulator-name =3D "vdd=5Fddr";
+				regulator-min-microvolt =3D <1350000>;
+				regulator-max-microvolt =3D <1350000>;
+				regulator-always-on;
+				regulator-initial-mode =3D <0>;
+			};
+
+			vdd: buck3 {
+				regulator-name =3D "vdd";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-always-on;
+				st,mask-reset;
+				regulator-initial-mode =3D <0>;
+			};
+
+			v3v3: buck4 {
+				regulator-name =3D "v3v3";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-always-on;
+				regulator-initial-mode =3D <0>;
+			};
+
+			v1v8=5Faudio: ldo1 {
+				regulator-name =3D "v1v8=5Faudio";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-always-on;
+				interrupts =3D <IT=5FCURLIM=5FLDO1 0>;
+
+			};
+
+			vdd=5Feth=5F2v5: ldo2 {
+				regulator-name =3D "dd=5Feth=5F2v5";
+				regulator-min-microvolt =3D <2500000>;
+				regulator-max-microvolt =3D <2500000>;
+				regulator-always-on;
+				interrupts =3D <IT=5FCURLIM=5FLDO2 0>;
+
+			};
+
+			vtt=5Fddr: ldo3 {
+				regulator-name =3D "vtt=5Fddr";
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <750000>;
+				regulator-always-on;
+				regulator-over-current-protection;
+			};
+
+			vdd=5Fusb: ldo4 {
+				regulator-name =3D "vdd=5Fusb";
+				interrupts =3D <IT=5FCURLIM=5FLDO4 0>;
+			};
+
+			vdda: ldo5 {
+				regulator-name =3D "vdda";
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <2900000>;
+				interrupts =3D <IT=5FCURLIM=5FLDO5 0>;
+				regulator-boot-on;
+			};
+
+			vdd=5Feth=5F1v0: ldo6 {
+				regulator-name =3D "vdd=5Feth=5F1v0";
+				regulator-min-microvolt =3D <1000000>;
+				regulator-max-microvolt =3D <1000000>;
+				regulator-always-on;
+				interrupts =3D <IT=5FCURLIM=5FLDO6 0>;
+
+			};
+
+			vref=5Fddr: vref=5Fddr {
+				regulator-name =3D "vref=5Fddr";
+				regulator-always-on;
+			};
+
+			bst=5Fout: boost {
+				regulator-name =3D "bst=5Fout";
+				interrupts =3D <IT=5FOCP=5FBOOST 0>;
+			};
+
+			vbus=5Fotg: pwr=5Fsw1 {
+				regulator-name =3D "vbus=5Fotg";
+				interrupts =3D <IT=5FOCP=5FOTG 0>;
+				regulator-active-discharge =3D <1>;
+			};
+
+			vbus=5Fsw: pwr=5Fsw2 {
+				regulator-name =3D "vbus=5Fsw";
+				interrupts =3D <IT=5FOCP=5FSWOUT 0>;
+				regulator-active-discharge =3D <1>;
+			};
+		};
+
+		onkey {
+			compatible =3D "st,stpmic1-onkey";
+			interrupts =3D <IT=5FPONKEY=5FF 0>,
+				     <IT=5FPONKEY=5FR 0>;
+			interrupt-names =3D "onkey-falling",
+					  "onkey-rising";
+			power-off-time-sec =3D <10>;
+		};
+
+		watchdog {
+			compatible =3D "st,stpmic1-wdt";
+		};
+	};
+
+	i2c4=5Feeprom: eeprom@50 {
+		compatible =3D "microchip,24c32",
+			     "atmel,24c32";
+		reg =3D <0x50>;
+	};
+
+	i2c4=5Frtc: rtc@52 {
+		compatible =3D "microcrystal,rv3028";
+		reg =3D <0x52>;
+	};
+};
+
+&ipcc {
+	status =3D "okay";
+};
+
+&iwdg2 {
+	timeout-sec =3D <32>;
+	status =3D "okay";
+};
+
+&m4=5Frproc {
+	memory-region =3D <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
+			<&vdev0vring1>, <&vdev0buffer>;
+	mboxes =3D <&ipcc 0>, <&ipcc 1>, <&ipcc 2>, <&ipcc 3>;
+	mbox-names =3D "vq0", "vq1", "shutdown", "detach";
+	interrupt-parent =3D <&exti>;
+	interrupts =3D <68 1>;
+	status =3D "okay";
+};
+
+&pwr=5Fregulators {
+	vdd-supply =3D <&vdd>;
+	vdd=5F3v3=5Fusbfs-supply =3D <&vdd=5Fusb>;
+};
+
+&qspi {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&qspi=5Fclk=5Fpins=5Fa &qspi=5Fbk1=5Fpins=5Fa>;
+	pinctrl-1 =3D <&qspi=5Fclk=5Fsleep=5Fpins=5Fa &qspi=5Fbk1=5Fsleep=5Fpins=
=5Fa>;
+	status =3D "okay";
+
+	flash0: flash@0 {
+		compatible =3D "winbond,w25q128", "jedec,spi-nor";
+		reg =3D <0>;
+		spi-rx-bus-width =3D <4>;
+		spi-max-frequency =3D <50000000>;
+		m25p,fast-read;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+	};
+};
+
+&rng1 {
+	status =3D "okay";
+};
+
+&rtc {
+	status =3D "okay";
+};
+
+&sdmmc2 {
+	pinctrl-names =3D "default", "opendrain", "sleep";
+	pinctrl-0 =3D <&sdmmc2=5Fb4=5Fpins=5Fa &sdmmc2=5Fd47=5Fpins=5Fe>;
+	pinctrl-1 =3D <&sdmmc2=5Fb4=5Fod=5Fpins=5Fa &sdmmc2=5Fd47=5Fpins=5Fe>;
+	pinctrl-2 =3D <&sdmmc2=5Fb4=5Fsleep=5Fpins=5Fa &sdmmc2=5Fd47=5Fsleep=5Fpi=
ns=5Fe>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+	bus-width =3D <8>;
+	vmmc-supply =3D <&v3v3>;
+	vqmmc-supply =3D <&v3v3>;
+	mmc-ddr-3=5F3v;
+};
--=20
2.34.1



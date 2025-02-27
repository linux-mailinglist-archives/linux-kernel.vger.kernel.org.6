Return-Path: <linux-kernel+bounces-536714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB853A48352
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D2A17237A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5626F445;
	Thu, 27 Feb 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="gWhZl5Wn"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2120.outbound.protection.outlook.com [40.107.105.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0226D5C6;
	Thu, 27 Feb 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670848; cv=fail; b=osUTjsHirUF01hhjZitzuMrTZvw0GkUhMgw7B2S5QKyzoU38gjtkk3MlORu7W62WmLE8KnG5/jKPD+ftt6UM7qOtF1YzR7tr4Dp3iH1ulpK9rjcEi+sMVuN8tJ5EVTksGmQurZ8i4FP4qmtFAVxoXzIsc8apS6ZpDSarM3zeW7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670848; c=relaxed/simple;
	bh=DoxnBcTb6e4T5fwm+rpjFTfvTI0UnjUKaMjxBnLlnBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2f9aJS+EnfKluVL58mz5ojB4rqPfH5RW2AxUrBlgm3SAbMuWnl48FdpdL055VnEh4SLsYHoyEic/9I9FSDXhUea9yQxnoiC/8SWg0p3Ywwlphv9dBayV/CNcAvoFcpBdLQmGvUmBV6i2hGcrNtyjZ5YZagDsRhQczun02z4QPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=gWhZl5Wn; arc=fail smtp.client-ip=40.107.105.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u82zp7cZmlT470sc2JqUStlc1BKb3gLsKH2XBAIwXzYckGrf132aQtMQszXc3TPr8pKjvwxblQbAao+8soAIj63lkyAt/1QWxPztsydeRjMO2awEtq8Gx73S9ODja8HEzBJTvSDwMYnbvU2uDMEgeydV0YMTIr14ymwQpwwxtJmDyBGCWrLYGwraPBKZGSKWNxdB+792zx8G0dJXADPLqJ5YjhBhdAq9B/ZC5e3QUqWEDsbYGRqkGhWKlmMJNrgi0SVo9A/m7oC9xDl2KQ3vSjcLawZaDuKErqOAreWPQ7oQUkgjdRvhWGfyLzQViq5k/+EPPBcsI9E6fB9VhINrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd3dTLedqb5GA2DtXcI0Oi5n0dqfuJJDV7nWzFjTFlI=;
 b=ynpOrUq4s57XOl/YzobbUnV0RUvrJfmHAaAXMPpnFyzfxOcz5Ll5KRAWd+PulTu9wU7jysmJYNZ0UAXAOeFcjpCrovE9+3Aoc0lUF+DOmI/LGaMx+BDHZLCuf/iDeFnJKrI/lzCnafYNct5ZXIgh2SqfPU05wu7Gdu63EuvTY4gceGPQ5SwcTJ6fEih2h1i+tht4xeT8RmH7daR9x7gKr3WsYJfYSwlWrb8qXvw/+dIWOeDOyr5NweYkuagnDScKgc/eRbcDZ0qLlC7xAmnCQHqOV2S84JKvluwh+er+yPmv9RDIKgTgynMWHH4Hx8HSk9AzmohKSQQxS0ORRe4fbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd3dTLedqb5GA2DtXcI0Oi5n0dqfuJJDV7nWzFjTFlI=;
 b=gWhZl5WnF1JEHiYJATzHxO72TqKwWxu7DZ2kprasFKdkNzwJ7UvZ30SnZybyvgLoQz8/82C4oCUFAaalHi4/82OwRXBRSmP4NaBm+7DnzaQPsg6/sPA2pMkFKS/njlJ/boIlJXCtJTdBibs3iCU+LKM7SKsbudhTcYbsoNGJJ0U=
Received: from AS9PR06CA0563.eurprd06.prod.outlook.com (2603:10a6:20b:485::28)
 by DBAP195MB1004.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 15:40:43 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:485:cafe::d9) by AS9PR06CA0563.outlook.office365.com
 (2603:10a6:20b:485::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Thu,
 27 Feb 2025 15:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:40:43 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:17 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 27 Feb 2025 16:40:17 +0100
Received: from localhost.localdomain ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025022716401750-92 ;
          Thu, 27 Feb 2025 16:40:17 +0100 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH 09/11] ARM: dts: stm32: phycore-stm32mp15: Disable optional SoM peripherals
Date: Thu, 27 Feb 2025 16:40:10 +0100
Message-ID: <20250227154012.259566-10-c.parant@phytec.fr>
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
 27.02.2025 16:40:17,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.02.2025 16:40:17
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|DBAP195MB1004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4fca1c-88b8-495a-6490-08dd574518b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DAhC6+bC2tL1dW1E8kK3V5be50SU0lxwXall8m8yoa7S3GrHAy5x4mksAvhU?=
 =?us-ascii?Q?6h5oIFPRNcm5teoRqAgIfVjt0lvpgJedvXSPpR82Oa2JOwcSKaEGqLyVZMpo?=
 =?us-ascii?Q?jYeX7qtVwawxASB61dBG1e7ysMTLITqpyIPJXS71ecA+12ENBeQykGStHBsv?=
 =?us-ascii?Q?Dkz9CeViqjlX1V2IxNDZy4lQ60+XH/qqAP1s/Fh9R85rSm7dkAeeHhWbFOw1?=
 =?us-ascii?Q?uPvevX0Q6KUfHZLgy6s2f9MLYDVxTZTYjiT4JUtL9yWORmi7LaYzwHWuxUor?=
 =?us-ascii?Q?QhY19VYekjXEDwXWLMY/zxTjNZFCprAzp+fwdT9PKS7xsTHo+VGJIIzWyDnl?=
 =?us-ascii?Q?KtM+auMMElWPLmyZREwSlLSEUd9AsOR3wUYXTqIuw/SPIbXWSw+JZD57++2o?=
 =?us-ascii?Q?YrY/y+bfp6oLMWbZdok9uVguwnUqcBkaoVD5ItqMkHKbrhCbBZGhL53uNh8S?=
 =?us-ascii?Q?IA+wf5vWLm90zD5T5v+n+suf2vysu6W+y6eAJgGv0fQKzswJc76ljv7qtNOS?=
 =?us-ascii?Q?eCgTp4MppdjW4kaqdhVkNqqqt2tNBZnFQFX3EYQSI/dZH0CQWUYJyCYqSBzm?=
 =?us-ascii?Q?9oSKDLSrIo5zK6R1d+bGb9t3d7ty+fJ4NXDstH70M3pZNdy5QWBS143kA5su?=
 =?us-ascii?Q?mWVfkrdvnKYXerb/FM2sZ3C5IhtnPYNBOnv41274zN2jIqoZKPYTo6SLyVPy?=
 =?us-ascii?Q?fXqUmlURUqQilu2JXp2N/6F+GE6Cw6U2zkBt36nmzMJMAo57k/2GBW8vqB6J?=
 =?us-ascii?Q?DsRiRGL5IEGLF5EGnh2sYtGckCYcVUtlHgIzvn9/tpF6wAjmTgTImes136zA?=
 =?us-ascii?Q?MZfxWClIqXy+ijNfKw5/y86onrTl4laRVAYCAPypQKLx75E2KL0RLfkzP1uQ?=
 =?us-ascii?Q?5G6+g/OpWr7vk/Il0NBxZgT0yoo9hXOI/Ma1O9C2RVjLAlSA/Bvv9AKnvGS4?=
 =?us-ascii?Q?fxqba+zu9VIgaN+FOpbW0vRlAnu80lB1p1ZlldWUXyHIzkVDxGIGDOyuf8sw?=
 =?us-ascii?Q?coEFEzMJonY9XFKw9/d7EZIDg9mE672M11mEaXnwwJ0ctnrpOs3kxFmo6zrE?=
 =?us-ascii?Q?mqQknBCVMUO6+2dNBzWwYovMus0EshvfYBLodE2UkpDPJhAzzR7sLflWsJZw?=
 =?us-ascii?Q?o4jLW2mCldlQSmYVYFcpfqN6ZzaUc95UdD0yJ/8T678bql431JPHDNSA306n?=
 =?us-ascii?Q?dO0EknS/vWTmBV1TKCbtmLemiFw29wp8b7GgrZw+faVrzcqKaUcXvZwleNw6?=
 =?us-ascii?Q?8Ncp0qirtA7V9fh/JOoAwOouRjQCfa3MZUcG2n39u4IeAg5d/JFSzYrOJliM?=
 =?us-ascii?Q?T8/Y3CzE8I5UE6CtmP9A6OMgDvDCBH5aI09KEvRo88nPnKYVtwlTzIv5eigf?=
 =?us-ascii?Q?xUia+IWs+FLrabvTUbOio03TAjLFo4+rgv1gRoPFdW/D8wQw0xe6g4jPZoST?=
 =?us-ascii?Q?BBpQLNWBMj5FWlRROsecLq+9JB8MRecuZJJVw64cX30Ek7qEF3eOAbelCeKg?=
 =?us-ascii?Q?2qIZEZluVIjndkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:40:43.4870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4fca1c-88b8-495a-6490-08dd574518b2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1004

Following peripherals are optional on phyCORE-STM32MP15x following
PHYTEC standard SoM variants: external RTC, EEPROM, SPI NOR.
Also NAND (fmc) can be populated instead of eMMC (sdmmc2).

So disable those peripherals on SoM dtsi file and enable them on board
dts file.
Additionally, enable by default the "DTS" SoC IP on common SoM dtsi file
as it is not an optional IP in STM32MP15x SoC.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts | 8 --------
 arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi        | 9 ++++++++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts b/arc=
h/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
index 462c89e68e2c..c9870f94ac1f 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
@@ -22,14 +22,6 @@ &cryp1 {
 	status =3D "okay";
 };
=20
-&dts {
-	status =3D "okay";
-};
-
-&fmc {
-	status =3D "disabled";
-};
-
 &gpu {
 	status =3D "okay";
 };
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index ce859b94ae26..3f60f184978c 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -265,11 +265,13 @@ i2c4=5Feeprom: eeprom@50 {
 		compatible =3D "microchip,24c32",
 			     "atmel,24c32";
 		reg =3D <0x50>;
+		status =3D "disabled";
 	};
=20
 	i2c4=5Frtc: rtc@52 {
 		compatible =3D "microcrystal,rv3028";
 		reg =3D <0x52>;
+		status =3D "disabled";
 	};
 };
=20
@@ -307,7 +309,7 @@ &qspi=5Fbk1=5Fsleep=5Fpins=5Fa
 		     &qspi=5Fcs1=5Fsleep=5Fpins=5Fa>;
 	reg =3D <0x58003000 0x1000>,
 	      <0x70000000 0x1000000>;
-	status =3D "okay";
+	status =3D "disabled";
=20
 	flash0: flash@0 {
 		compatible =3D "winbond,w25q128", "jedec,spi-nor";
@@ -328,6 +330,10 @@ &rtc {
 	status =3D "okay";
 };
=20
+&dts {
+	status =3D "okay";
+};
+
 &sdmmc2 {
 	pinctrl-names =3D "default", "opendrain", "sleep";
 	pinctrl-0 =3D <&sdmmc2=5Fb4=5Fpins=5Fa &sdmmc2=5Fd47=5Fpins=5Fe>;
@@ -341,4 +347,5 @@ &sdmmc2 {
 	vmmc-supply =3D <&v3v3>;
 	vqmmc-supply =3D <&v3v3>;
 	mmc-ddr-3=5F3v;
+	status =3D "disabled";
 };
--=20
2.34.1



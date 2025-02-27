Return-Path: <linux-kernel+bounces-536712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D90A48348
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F517A73ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5880626E642;
	Thu, 27 Feb 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="iq2j5O3I"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2099.outbound.protection.outlook.com [40.107.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB026E148;
	Thu, 27 Feb 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670826; cv=fail; b=J3J/E1rSi27I9RzrC9kfbgRGSNHnpyqIR/pBMFNSnynzXB/MotseWuPlkT0pNp2/pP7AoO3zkTENXeQprT3VLIXHJ0aOzuJV9waCW0H3+5l3SIpe+9uEtIEdAxVPr0WxAP3fgpxYPvGmUmkIaV/EHNfStJgFzFtwD5U4+serf04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670826; c=relaxed/simple;
	bh=8xtJHPR675V8A2hRc6+qTS0QTbxosSuG4SCyJZFBt1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRZcdcSagGW3rniEnjlth6KmDrh0VM4YhMnapFv5NOJlhL2d5uKJ8rGl4EaWbJKU9Y+MEID7GuKtl5AP1l+3g9zfGsSw7jwTotktbQxjzwH+n6lDHnmA0yQiLth5HYgJk0Usk3WyKwDimsZ7xDX9q4fC40SspfjqeooM8W5yPkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=iq2j5O3I; arc=fail smtp.client-ip=40.107.22.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb4Hv6axWuZXrLHqHIGsjqS2i2ybN+bMTRNGH5zJmDSZJIjlfxNf2Q4EYek1Z3/rodnbvcfJ/3W0CLFx4HjUdbumyID3zoQZMFkjXxB7oItf/U4C3Xz6+Mmb4x1rdijOYGQl2Nszi/KTsnURqYMX39FD8jB59IqVfnQbajRQhGN4cfDxB0W9sItfK62/ULVhP6GA31bmrXyJdmcS1JumUJN8nbEcYUw867csO9cCIQEJWjN+cimQ5/0ECsRz6nBoxySWTMf1fL8hMTN639IyF0LcHozQG+Exv006xvvYVgILGNK0EKY9Pc9khqzCxi+qltnDPqyctFXHNzg+u68NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4yCW7fz9of7ZgzbQksuVUmuVzW7uYUrdorMcsIVtvo=;
 b=Tt2V7J2CpQ2XXuI9Zu9jwgeohXG8YHk5DICOKYCR44XrFI4qpIK4oMXh4Ut1YM6QmKZ9+BZFoEZ7bd42vqtOBGfpWUdYlz/zlLNkoQIcTQmagJJPSlcOKjq5KNSV5Q2dFO6i4f+azIBR0kySZOZgnBe/vDDs53jJI1tdspZiCRc0zUnFcNfmzt1x7DpdyxAHbY1JvF8d9hDznimJwNjvejqlrDXoBHplF+NsL6ja1PToO0FZFDFTpaaDJQUyikLo1Sz/8FopFiUk6u7v4C2zCHtMR2W9D6LO81b08qZfwbWwGq4Wp5DSMSXp3HQDauHzaZfuJScdleFTtQS/ca+mbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4yCW7fz9of7ZgzbQksuVUmuVzW7uYUrdorMcsIVtvo=;
 b=iq2j5O3I1iV9/K9ViGPgwCT0hB9Errm990Uoti06BplqwWlFawOd6ZV++O8cDWvpD503bVQPSllisaXs3V+b4CxPowm9VlYnC5kZK8pcvuOxOVyAwnRIlFJIamix1J/kPF33USR0UvlptcOuK/F6JfmCkslpgyC3y8IW5UEQB5g=
Received: from CWLP123CA0073.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::13)
 by AM9P195MB1095.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 15:40:18 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:401:5b:cafe::5e) by CWLP123CA0073.outlook.office365.com
 (2603:10a6:401:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 15:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:40:17 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:17 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 27 Feb 2025 16:40:17 +0100
Received: from localhost.localdomain ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025022716401705-91 ;
          Thu, 27 Feb 2025 16:40:17 +0100 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH 08/11] ARM: dts: stm32: phyboard-sargas: Move aliases from dts to dtsi
Date: Thu, 27 Feb 2025 16:40:09 +0100
Message-ID: <20250227154012.259566-9-c.parant@phytec.fr>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|AM9P195MB1095:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c32d62-be0d-4b74-e870-08dd5745097b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJqKKzsh2rkCyfkorVasNKAtIPsNbQLsfZqYIKwSGtUflaWYfC7zwXdC5f1O?=
 =?us-ascii?Q?bVEszJQgZGKXOqTb12h+FdCmf+9gLotuCFMX2uOvyFBoRqTAuUneMjRuOPFP?=
 =?us-ascii?Q?LHghR5EG5Lzo9KPK+wotTlq4141Nf4yJslMVQmeDuay8U3m762n5deLzh+ni?=
 =?us-ascii?Q?8A8EfV/oRPffvAWKLe9k3mo6rovc4UPtM36DgtKChFPi5919hhPyD1P6voxb?=
 =?us-ascii?Q?zanBGEhtonFc4FbwnyjpGNNWZViqIa6fvyNGpFY9zDBJYUirWBEQv/nS8PrO?=
 =?us-ascii?Q?tfxFGB8HRvv8GHOQKiJR8YGg6CCdgebT8vrTJbNDN5yHYrdPt4MAeIiyBRX7?=
 =?us-ascii?Q?etr7ZqdSzEBhPYwENPcoi0jNHHC/FVUyMA35idup3yanuNPvQ/PiRBM166zI?=
 =?us-ascii?Q?WS0McOL8g0ZP0L8napgH3BeiTqGqXhgQViMGpmtWMKpDTu0gYoUI8xyWplWt?=
 =?us-ascii?Q?06VqEOsgq/G0Q6VG7SSi9OUljuoFl4lcGjH3VrKtFvuNYG4kISNUE0rDhU38?=
 =?us-ascii?Q?+J9HpCO9oSW3sN8PHXqY0dWDIHpHz1oRw5rTgFNwTdMCkN0Y3tJwrmcy9lWm?=
 =?us-ascii?Q?E+LhYe8m3aYeKOEOm1I6HfIhtcLB0TFGGiaN/6c6AsWWm64ywI8SunT5/seX?=
 =?us-ascii?Q?1+hXBbx/Py4DwIspdTo1xsAewCivT7LWHpeMWcNy/ByLalSw38ea/jwY8wzs?=
 =?us-ascii?Q?DWFfGg+fq1MtfFG2op93wFCfVZB9Ynredb50me/Ud3EJUxenxaUvmZgkeW5e?=
 =?us-ascii?Q?oYkiKE7MbqjvunpEE4BtRSBsLylL6QLwAWo5yJndWREuZDVug355xZI1ZVTP?=
 =?us-ascii?Q?3BLfcEzMGQZ6ltSRU4lNBVSADkLbyvx627kAWYlmFKP5pf3FskW/gUSRtuvB?=
 =?us-ascii?Q?+1uHpeLjJryeSYG0igt1adNp4zIAW/szYTQWFPgmTZ27H8Y5KJe2YNpBip3A?=
 =?us-ascii?Q?93ztJgjovXxlXO1VztPpy/tAJCQLbQY+B6MupwaeRvea+0Sv6lRQH+Sal2At?=
 =?us-ascii?Q?qSc+PPpmblL51QEZg/st5qmygw2pPsVU858LIS8pULDT1TiG5T2ErHTDTXxF?=
 =?us-ascii?Q?9PXS1YfqGA9rtt4EN0b48n3R4pdd+saXqPBd5I8PQhSdWz/QdGe8kA80E58k?=
 =?us-ascii?Q?p0RNKcw9yCY8hzWs1JXVrqCTp14ZkjHRb0ZKFxF2puvrkVFXRBuRBmJxBAaZ?=
 =?us-ascii?Q?PLRUTYjTNrpCY9q/jBmpMObqFh2djXJhIABhF6b0EdYBvJdTwO8jIXxMGSX3?=
 =?us-ascii?Q?p3NwZ5XY10Bu+pnYSF+9f51YpUXXcUz25xNkjHXRSWP3yrQYlyofZ4FDaKRp?=
 =?us-ascii?Q?ujbJ4mtX4gBRV4qKlWqERQaHzLewpTeRMOWWNs8SWI4AgTebITlR2Uv8qh1w?=
 =?us-ascii?Q?eZk7oBhxXutIkPvOa1CjRmHIXRHPjwHv90O+tzxC/PyWbe3Y8zSLC8C/QESE?=
 =?us-ascii?Q?90rkyzQXtX3aYqNNBoKpm9bNOfHtSn7zJzD+oMPcEcXutJOmKO8bsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:40:17.9485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c32d62-be0d-4b74-e870-08dd5745097b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1095

aliases are common to every phyboard-sargas version. So move it to
the common phyboard dtsi file.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts | 9 ---------
 arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi    | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts b/arc=
h/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
index 43592234573c..462c89e68e2c 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
@@ -16,15 +16,6 @@ / {
 	model =3D "PHYTEC phyBOARD-Sargas STM32MP157C";
 	compatible =3D "phytec,stm32mp157c-phyboard-sargas-rdk",
 		     "phytec,stm32mp157c-phycore-som", "st,stm32mp157";
-
-	aliases {
-		mmc0 =3D &sdmmc1;
-		mmc1 =3D &sdmmc2;
-		mmc2 =3D &sdmmc3;
-		serial0 =3D &uart4;
-		serial1 =3D &usart3;
-		serial2 =3D &usart1;
-	};
 };
=20
 &cryp1 {
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi b/arch/a=
rm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
index 564b2607bb9d..3d62f9e4d0cd 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
@@ -12,6 +12,15 @@
 #include <dt-bindings/leds/leds-pca9532.h>
=20
 / {
+	aliases {
+		mmc0 =3D &sdmmc1;
+		mmc1 =3D &sdmmc2;
+		mmc2 =3D &sdmmc3;
+		serial0 =3D &uart4;
+		serial1 =3D &usart3;
+		serial2 =3D &usart1;
+	};
+
 	chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
--=20
2.34.1



Return-Path: <linux-kernel+bounces-536715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE7A48358
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F111A3B75AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71C26D5D9;
	Thu, 27 Feb 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="bC/jyi7r"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2103.outbound.protection.outlook.com [40.107.249.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2D26D5C9;
	Thu, 27 Feb 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670850; cv=fail; b=OTRh6q9VA8VD7r4diOjQaaJFdzjM3LJYMkNLtTah75L4FGSZwStMucyVuhu9+4cKMjrmThzuAr25DPF7JdCGCIRHATJg2KmLFRez3PdVejkSKPip/IhmeNxPwsRP/LtG8DKk3pqqPSH/vL6WmdDwgrzB6QjEwQMLMqz86iE+csA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670850; c=relaxed/simple;
	bh=QIGumHuzOuFByIk23NwGQT9wjo2KluyTfFEgVl2h0H0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANPchsJ1wJzvZxymLBKBCAng5h2iqsBmRrmL78oJ1SQVbRElApHKlY0QJatJQ7Vb0saER2voxq6uMKvn3/MClzSgUzg2GnZlhuuYcLWyRTXiF2wf4EHZdpUqnFQn1SP/iC7/kJNpUpiNATIS8q3FaEWTJJxO8DGTU3Q65/A3j5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=bC/jyi7r; arc=fail smtp.client-ip=40.107.249.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiBw6q1teh63Gguy4Jd9mI4SghgKvwWuYrwTDoDzqq3E3U7H2t01elng+rjkThBpHY0YLDQNwcC57SuG2H+Q28Bl1ZCihPEil/j+nPgBh1n/8xilwZyqo6vXKMUPbAsRUaMy525sY5awbE3RqOtf39S8fDzcWAdvwh17Wair7pE8HvV9AsXQZ3tg+Zw3VSd7dkZinK1CPsR99LRngqQpnVp+VCeMZIDbhYxbeX6yz2+bLXr5BFzxQD3m+u1eRc/Wbh6/4sy2kNeHqfFVUDUtoFXSg8e6Iu5RD/LLXASrROWC+7sPr1mWgG3g48yRk7+jnHuqzAMw0cRmd8G04QA/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUaaNVMIbYFYhrdJ2Pk2u7iyn7Wb4raVvhxQrePvTzE=;
 b=kPOEPIWYFAEMrvK5bx2uWdS1nRDSWa+XFN7Cllrkuo79XTB5wrYuetMSEOJwKBr12Oova/oQqlkyEmuD2xv79oHh7VikA1wNOlpv/1buRwiCYIUBIQivIOuuddUaYeAxXZT8ULVa5YKOQlFE6SX8SV5XB1IAxOoVw0Q+nfxHA7Vu5DFcvAW6nnGB08Rpx1eIOpMRkZ/M10HiPvqA1cHmOpxPW+mwMbg9aJ0/4vask+8XsftCC6cIeOFb+tkDZ3ySd67tOVqbtrjsERWdyumvOeBfgblzRnzvtvFFRvOMe9ph4inIJYYD+bmmIZbJOj7wyIHE1jhLX3Hl9TrhJH+Xeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUaaNVMIbYFYhrdJ2Pk2u7iyn7Wb4raVvhxQrePvTzE=;
 b=bC/jyi7rVyiVZ0Qt00J2TcXaC6gM0bIiwfB1zgpWqcGNfOtyf+ni4RF2zzBE1O5F9eMNQIlKNZj+y3pRsnVW0COdJW5a1dPlrGLIaSx3jkpqcY5NRUyUeyaPJ5MLineqx7U8G9X7pI1ksGmsKNwPHk/pvKhYLXmyIu/8bQ1lsBQ=
Received: from AS9PR06CA0563.eurprd06.prod.outlook.com (2603:10a6:20b:485::28)
 by DB9P195MB2156.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 15:40:44 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:485:cafe::a2) by AS9PR06CA0563.outlook.office365.com
 (2603:10a6:20b:485::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Thu,
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
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:18 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 27 Feb 2025 16:40:18 +0100
Received: from localhost.localdomain ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025022716401842-94 ;
          Thu, 27 Feb 2025 16:40:18 +0100 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH 11/11] ARM: dts: stm32: phyboard-sargas and phycore: Add optional interfaces
Date: Thu, 27 Feb 2025 16:40:12 +0100
Message-ID: <20250227154012.259566-12-c.parant@phytec.fr>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|DB9P195MB2156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c367ded-1fc8-4af1-d43d-08dd57451943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LN3tR+EzHi53CgEu8SiFXVtgzjJRQASuijyb69n9pBdij+zdYioJ4vgTCTxO?=
 =?us-ascii?Q?FRse0xus4jYRQk+mqCo/YU2rCAXzqWnVPdG2haujv/45kgzWPOIOei3TW3p3?=
 =?us-ascii?Q?HbvlbGjmF9v+r5RU2LGYl7M/tP7MC3mFDv0KpUPb9Dodr97n2gF5Z73GcwKn?=
 =?us-ascii?Q?5iYpKb4RJqPgu+9zIxyLofhvrNWtbbITHi6C+ou+MY0y5unl8n/t9RiIZb3q?=
 =?us-ascii?Q?NpK2KMAtI9ybzFOkp9tshzxEn0rW344URbsd0nXbpDmH7LK/IstJWqwb9Av6?=
 =?us-ascii?Q?erUpwdUXrt9ReYrMaWM6NYxiVzgUPBIZ/eRFbmiy4ZCwvUpZIHryf2MpoD7r?=
 =?us-ascii?Q?a2B+rksAGphb+XL3CVpvHhFf4rdRe9iXlFjTZI7WTDeTnPcPu0Yk7R0z6oHu?=
 =?us-ascii?Q?O7xz23xjDzbpWt6rXOgq5TR5aHj1brf0Dgo+Wtg9XTGsFPyah4NQ9BLBvTie?=
 =?us-ascii?Q?5+JZV3PBcj0eionCAyt2Hb3+Wgmd2xFavYOk03FwqSRM+PQRd22fmACA1f5M?=
 =?us-ascii?Q?BFj1YYAZB33F5rMI0CApg+mctFOnggsLN7Jxyqgh1NrlBhj7B6xgGYZpfsXA?=
 =?us-ascii?Q?wiEOwkAedkOM1Rb1ERU66bnNqP3iX0xaFDWOor/nVrOiQlVqLhTpOIUpWkdC?=
 =?us-ascii?Q?S+toSG9vNge7r+OrK6l7OUGBiebW24XIJ5FEbDHCiaioWzgvNVySPxqOFa51?=
 =?us-ascii?Q?6v854cS8vOa0gitap0l6+YJbCyLYIkJkDLsJnUGAPyiGSMZZhsolXLSM2u/0?=
 =?us-ascii?Q?BrZMgtIOjcKjZGRDEjvFrong2cu89uC031S5jZiggLS/O6SyPNOE6R2n6Dhc?=
 =?us-ascii?Q?m1R9O5A/p4RgEzTuJ6AC3Lxx5ca3pNFprf02YDbw2etnErMSRU0UshIqInxU?=
 =?us-ascii?Q?jBXI6oCI/j2asrQRxRsYxKpDgVKxeMXazjsghoVZR74sdsIIc356YZZvKtTU?=
 =?us-ascii?Q?fWOJrCT6tvHqmDHWCMJvQHUBEeL8tvDmDdieof42NBXwK2ajCQt64ocmcllN?=
 =?us-ascii?Q?baPyv/lOnQcqIIL2H97+YOKolNWxBYdIpCsZ6iF1x86Q5LI0csxZ3HiGSizu?=
 =?us-ascii?Q?IhKkM3GUNSdVVq23AJqDXgXYpsYj+2XbrC5XDw2VamM77kLDYGriKAcprPcN?=
 =?us-ascii?Q?WIXEpr1Gw5W7wO4Q7pBS1+iMH0WZ11Obezk1VxLtRD8dB3w2Re4llCxlpwG7?=
 =?us-ascii?Q?4/ZkWqS1QEe9LFjVCAyE7+b3bFpH40wntcG9vHsxRkC/Myv2LWUkqOWAX+gS?=
 =?us-ascii?Q?lmHooSrZs1bY08vG1Bhk+P5riqJhd8DAXc9ZekXbzVY9DUfGqe7+PZ/zNUG9?=
 =?us-ascii?Q?Eir/LHBU1rdXLE5nIcQOfdWvidb17JRcHOgEmOuZT4TIENi9uPeejXpfS7gR?=
 =?us-ascii?Q?eN970o+7Hnh/kiCF7XJkyGn3ipFPlraP1fjQWUXZNnjzlnw79xqd2qQlLDsv?=
 =?us-ascii?Q?sv+z2UQu10Nv2+8xGF0Kgj3YTVped3lMIgVBjJ5TpJpe1c1/jMY0FlOvgTaj?=
 =?us-ascii?Q?c4OyOp1/XxMrwMo=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:40:44.4401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c367ded-1fc8-4af1-d43d-08dd57451943
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2156

- stm32mp15xx-phycore-som: add NAND device on FMC interface to support
the SoM version equipped with NAND flash instead of eMMC.

- stm32mp15xx-phyboard-sargas: define pinctrl for PWM5, LTDC and DCMI
interfaces used on phyBOARD-Sargas. Those interfaces are not enabled by
default as PHYTEC displays and PHYTEC cameras are enabled and configured
throught device tree overlays.
PWM5 is used for LCD backlight command.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 .../dts/st/stm32mp15xx-phyboard-sargas.dtsi   | 23 +++++++++++++++++++
 .../boot/dts/st/stm32mp15xx-phycore-som.dtsi  | 16 +++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi b/arch/a=
rm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
index 729a97f82538..2f351adc5986 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
@@ -260,3 +260,26 @@ &usbphyc=5Fport0 {
 &usbphyc=5Fport1 {
 	phy-supply =3D <&vdd=5Fusb>;
 };
+
+&timers5 {
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	pwm5: pwm {
+		pinctrl-names =3D "default", "sleep";
+		pinctrl-0 =3D <&pwm5=5Fpins=5Fc>;
+		pinctrl-1 =3D <&pwm5=5Fsleep=5Fpins=5Fc>;
+	};
+};
+
+&ltdc {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&ltdc=5Fpins=5Ff>;
+	pinctrl-1 =3D <&ltdc=5Fsleep=5Fpins=5Ff>;
+};
+
+&dcmi {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&dcmi=5Fpins=5Fd>;
+	pinctrl-1 =3D <&dcmi=5Fsleep=5Fpins=5Fd>;
+};
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index 0689967b8c56..23db635c39a1 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -345,3 +345,19 @@ &sdmmc2 {
 	st,neg-edge;
 	status =3D "disabled";
 };
+
+&fmc {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&fmc=5Fpins=5Fa>;
+	pinctrl-1 =3D <&fmc=5Fsleep=5Fpins=5Fa>;
+	status =3D "disabled";
+
+	nand-controller@4,0 {
+		nand0: nand@0 {
+			reg =3D <0>;
+			nand-on-flash-bbt;
+			nand-ecc-strength =3D <4>;
+			nand-ecc-step-size =3D <512>;
+		};
+	};
+};
--=20
2.34.1



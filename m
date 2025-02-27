Return-Path: <linux-kernel+bounces-536708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC4A48345
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB7D3ADA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7C26BD90;
	Thu, 27 Feb 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="TALp83rw"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2131.outbound.protection.outlook.com [40.107.105.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344926AA88;
	Thu, 27 Feb 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670823; cv=fail; b=Lds4OD9XpfsxXgbnqozqGtpAODJRY1axSBGEWrviQ5uwvbKsMm1B+u009HMArUj3wdBAwMC5Z5h9RakX7zITpGPgDCqVoBzkpw/0Hu37T2ihGg2vz0qFcWIPvbziAsgkJGvQeOm7kbrnVzM9QwWIFrJTUOZ4n4gXKHQPIAKrvGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670823; c=relaxed/simple;
	bh=pMZ71rhqbUw+58ahMOUpmxNYB5IVz4Mkm+LmZShBSis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juc6jvW//+AEbOCqZHGf0uyacBu+sbGKLNoiT0C+OEwG9XoqHQnOmF/Gb7Pv/TAvtJaZ1N1Rh0vVzBXogmEVy5oXZfjsvbfrjr91wdrDGATzb3RbvhgcMBfpi2gwmNhoOtbgz2qJBLfVsa4OxwJYWT1tV5T4sIexKDWyNNEdmzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=TALp83rw; arc=fail smtp.client-ip=40.107.105.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKA4nzPzjRnzjyjMJTWeMC7/DE4Vgzo8jN5AW/A4dQ76d/op2hIk79DIzGTb4SGwPxmPKC05OSCj8+wv1YsfxSTPjqa+ukO4Uz8nffcppB4yn5c6SIY6GswIQ18uR7ZDuVpKIUGkjtTe9uPnF6BI+BkzDX5yVH0M8mmZAOJDUPHtiTQhMkXHyTzg1SVFX/TL3N2st0A0koI+oDVoeMVHnzydHeShhn4pUcNV8lpGRiLIWM6Uc7OZArqnvoAlTYcbq76VD8hrQRfbN/dzzv7+wu9HeX2NA4ujDVjay+AMeqXnEg6gz0KPiEPJa5LkHzePAs8B0KtMuNcvCaV5FBMDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyfGDNf1BUXv5TskihyMGhR7ipgLkBQ2c4yd1xoBs3s=;
 b=yVyDIPhdxlizN3dHEiv+78ckS83Qho3VqpUgdwNjrthOJj/3QE7BJaWwm/byDGfkfZ0TglPr+9mo2WIyoKZvj+n1+hUNohDUPZvJR1m1MKM9azsQiM5CVE6QC5LyIZVKHOItGgvHqSybsH+cLKmgEapS4XdP4dwnPgFlw1Zbt14G61401/ACraY0e4A7Fo6Jmq0UiCnBI4OVSm3pgqjt0B1Z8AFS3d1NGBmDoGgbJzxzu/jXkXgkbR2CUJCSz86q5+Hv0V1OTmR3eHT1hTk9XsnExkvdU1tRRl6o61aztJJokuR+C4dNg93lgltYqLKv46y6KSoaZFm7OB3We9/jOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyfGDNf1BUXv5TskihyMGhR7ipgLkBQ2c4yd1xoBs3s=;
 b=TALp83rwrmwlqH3CId0Uaf/VaWeego2wbGmmiKnCNjd91H2Z8w+HbP5j7BeFeJz0K1V3iJuFG5lBQwaAyrZKKcraP1B9Aa99HBIHkG54+KwPVBeYwymod7nxnWTArbcxx+fzFordim2XvALgVCg0GnoYroBfDxh2xd9OrvUEh+8=
Received: from AS4PR10CA0025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::14)
 by AS2P195MB2250.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:59d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 15:40:15 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::5b) by AS4PR10CA0025.outlook.office365.com
 (2603:10a6:20b:5d8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Thu,
 27 Feb 2025 15:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:40:15 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:15 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 27 Feb
 2025 16:40:14 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 27 Feb 2025 16:40:14 +0100
Received: from localhost.localdomain ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025022716401483-87 ;
          Thu, 27 Feb 2025 16:40:14 +0100 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH 04/11] ARM: dts: stm32: Add new pinmux groups for phyboard-sargas and phycore
Date: Thu, 27 Feb 2025 16:40:05 +0100
Message-ID: <20250227154012.259566-5-c.parant@phytec.fr>
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
 27.02.2025 16:40:14,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.02.2025 16:40:14
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|AS2P195MB2250:EE_
X-MS-Office365-Filtering-Correlation-Id: ab505bb6-8d0e-4110-091e-08dd57450821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oilnypw5Dnv5s4spSnvtm+3dAE7AJA9WI8hIHpWuRlq0fD8hIZX3uHxilbih?=
 =?us-ascii?Q?Mn+seiTqTw0YIeKCssDvXnQcJb0dm7ja3SgHPsTeZ0c2LUVygNrZcXUy4KKS?=
 =?us-ascii?Q?VJnI6dhCx0id3E49k55t1YzmqUj0O5LKpN4rlGTf/9iD6JXAp7ydNSprZ3AL?=
 =?us-ascii?Q?zcDJefFpxoHxZTuDC3RSTFiRHoi903LuWP+jy92Z2OHtPnIXC18+Ibh7tvFl?=
 =?us-ascii?Q?ezUHXLJBqQhwlnFlIC2LuRBDkh/La8/247+wqevxQBdByHjuzwMmaFZPrFMi?=
 =?us-ascii?Q?SjrgRM6lMuKytf1Ksno8xscBgl+sfSO2CDWx6yIVyRM112rur8VdjzFncd01?=
 =?us-ascii?Q?ZmfYuSJ/lMe0TaFmyKTk1GkUCha9MZbbhy20rIJGcGl8FjdDqjxmhn/FYJYZ?=
 =?us-ascii?Q?Kk1fJJy/C8YcmPnc/cdOrXXWPfRohSOW9Kh8Ywzlgx/YzlAAda77KiNAmes9?=
 =?us-ascii?Q?+1UQNxUR51FDRMb96Oun5INhLPimoqA0emFQUuG3F+ACgupvNgk5G3Sey4Lr?=
 =?us-ascii?Q?Ba+zuSWVg3ZSsDg/L4T18ElLSFo7MY8LxWpkvIS8qrGelj3eJ47W8MnSm5L8?=
 =?us-ascii?Q?vI+41JX1Fd/azY6paQnUwe1Q3k8w4auKXVqdEfJrZjOnYdh5cizkS5NP8yNC?=
 =?us-ascii?Q?uvi8cAPpKpEnFM2uU/2hrvfs1NbKMemmBlrSvHqcl6Ra0ZgACGmH/4R28RT3?=
 =?us-ascii?Q?lxxj3Gjpqsh/ThZbSWAhi+WWD4lc2D7LhUI4Df3EI8vMGSx2hvYSq+f5dXbS?=
 =?us-ascii?Q?iwvEuD6gXZ1FxIMOiLjvLlaaXISeW6EikCo12wLtWdu8O9DZdzIC774JOXta?=
 =?us-ascii?Q?JJDY22wLGNC1aCWxdc0mjMAfG4m6oeqngM9vCgV9ZDL/71Xm6AGqgdmuc4cb?=
 =?us-ascii?Q?rNtrwkEVdUBUfjGYG1Lf4pDWwGuq+euPQw1mMD4ZLfhqoVifooJV2A9wO9Dq?=
 =?us-ascii?Q?GsBs/WLgbKOhhB/3ok/0DGPGrBNSSWqv1nTIn+nAWoYn77+N8nnKPOJz8c38?=
 =?us-ascii?Q?37ocdnOSFRqz+XRNvKu7hv8wWscZLGnnUA20L0Jw/nadg4UG/tBVyTInQ5F1?=
 =?us-ascii?Q?8yJx+7K3gxBAZhhe2uGwzhisGn9KUWzoTIx3tnoFpZZ5ol8Z7FlIch1PtVlr?=
 =?us-ascii?Q?X7F4wWat/zjv2NBwWtUC1SWXGStDwEk40BVaLFJOT0ywjfPbMo8hzSno/To+?=
 =?us-ascii?Q?Wvd/cHegxqbgGX810qrzxy5ADFs2K06fvXSyH+nTB272/Fn6x71J9KmZx/o/?=
 =?us-ascii?Q?rbZ80n1dMtnLXMfmmpGe5dmx1+QhO7HnwsG1KSbKZmhOlZd3/gnCJT7VaxSA?=
 =?us-ascii?Q?YG/Fq52J1cW89fuhRz7GY2pUYtZstcdFq9saklQS0E3kFAvHRqvdQOY+eEOK?=
 =?us-ascii?Q?SHOzTKti3/44WjgeIqArsPdJ8TPNQ7D6SpzeHndezCbW/3RA9h2B5q6tTE+f?=
 =?us-ascii?Q?J8xku9mx8eb8LQH1lEGKa/rsq1lpp5nn9qEVvOpwwh8GlM05YyygtR0ri5Lw?=
 =?us-ascii?Q?lLzBsHpt8WjOHbA=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:40:15.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab505bb6-8d0e-4110-091e-08dd57450821
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2250

Add add alternate pinmux for following interfaces used on
phyBOARD-Sargas:
- UART4
- LTDC
- DCMI
- TIM5
- SAI2

Fix "ethernet0=5Frgmii=5Fpins=5Fd" pinmux used on phyCORE-STM32MP15x:
ETH=5FRGMII=5FGTX=5FCLK pin was missing.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 164 ++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dt=
s/st/stm32mp15-pinctrl.dtsi
index 95fafc51a1c8..963d8616f3c1 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -216,6 +216,45 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	dcmi=5Fpins=5Fd: dcmi-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('H', 8,  AF13)>,/* DCMI=5FHSYNC */
+				 <STM32=5FPINMUX('B', 7,  AF13)>,/* DCMI=5FVSYNC */
+				 <STM32=5FPINMUX('A', 6,  AF13)>,/* DCMI=5FPIXCLK */
+				 <STM32=5FPINMUX('H', 9,  AF13)>,/* DCMI=5FD0 */
+				 <STM32=5FPINMUX('C', 7,  AF13)>,/* DCMI=5FD1 */
+				 <STM32=5FPINMUX('E', 0,  AF13)>,/* DCMI=5FD2 */
+				 <STM32=5FPINMUX('E', 1,  AF13)>,/* DCMI=5FD3 */
+				 <STM32=5FPINMUX('H', 14, AF13)>,/* DCMI=5FD4 */
+				 <STM32=5FPINMUX('I', 4,  AF13)>,/* DCMI=5FD5 */
+				 <STM32=5FPINMUX('E', 5,  AF13)>,/* DCMI=5FD6 */
+				 <STM32=5FPINMUX('I', 7,  AF13)>,/* DCMI=5FD7 */
+				 <STM32=5FPINMUX('I', 1,  AF13)>,/* DCMI=5FD8 */
+				 <STM32=5FPINMUX('H', 7,  AF13)>;/* DCMI=5FD9 */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	dcmi=5Fsleep=5Fpins=5Fd: dcmi-sleep-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('H', 8,  ANALOG)>,/* DCMI=5FHSYNC */
+				 <STM32=5FPINMUX('B', 7,  ANALOG)>,/* DCMI=5FVSYNC */
+				 <STM32=5FPINMUX('A', 6,  ANALOG)>,/* DCMI=5FPIXCLK */
+				 <STM32=5FPINMUX('H', 9,  ANALOG)>,/* DCMI=5FD0 */
+				 <STM32=5FPINMUX('C', 7,  ANALOG)>,/* DCMI=5FD1 */
+				 <STM32=5FPINMUX('E', 0,  ANALOG)>,/* DCMI=5FD2 */
+				 <STM32=5FPINMUX('E', 1,  ANALOG)>,/* DCMI=5FD3 */
+				 <STM32=5FPINMUX('H', 14, ANALOG)>,/* DCMI=5FD4 */
+				 <STM32=5FPINMUX('I', 4,  ANALOG)>,/* DCMI=5FD5 */
+				 <STM32=5FPINMUX('E', 5,  ANALOG)>,/* DCMI=5FD6 */
+				 <STM32=5FPINMUX('I', 7,  ANALOG)>,/* DCMI=5FD7 */
+				 <STM32=5FPINMUX('I', 1,  ANALOG)>,/* DCMI=5FD8 */
+				 <STM32=5FPINMUX('H', 7,  ANALOG)>;/* DCMI=5FD9 */
+		};
+	};
+
 	/omit-if-no-ref/
 	ethernet0=5Frgmii=5Fpins=5Fa: rgmii-0 {
 		pins1 {
@@ -379,6 +418,7 @@ pins1 {
 	ethernet0=5Frgmii=5Fpins=5Fd: rgmii-3 {
 		pins1 {
 			pinmux =3D <STM32=5FPINMUX('G', 5, AF11)>, /* ETH=5FRGMII=5FCLK125 */
+				 <STM32=5FPINMUX('G', 4, AF11)>, /* ETH=5FRGMII=5FGTX=5FCLK */
 				 <STM32=5FPINMUX('G', 13, AF11)>,	/* ETH=5FRGMII=5FTXD0 */
 				 <STM32=5FPINMUX('G', 14, AF11)>,	/* ETH=5FRGMII=5FTXD1 */
 				 <STM32=5FPINMUX('C', 2, AF11)>, /* ETH=5FRGMII=5FTXD2 */
@@ -1220,6 +1260,65 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	ltdc=5Fpins=5Ff: ltdc-5 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('G', 7,  AF14)>, /* LCD=5FCLK */
+				 <STM32=5FPINMUX('I', 10, AF14)>, /* LCD=5FHSYNC */
+				 <STM32=5FPINMUX('I', 9,  AF14)>, /* LCD=5FVSYNC */
+				 <STM32=5FPINMUX('E', 13, AF14)>, /* LCD=5FDE */
+				 <STM32=5FPINMUX('C', 10, AF14)>, /* LCD=5FR2 */
+				 <STM32=5FPINMUX('B', 0,   AF9)>, /* LCD=5FR3 */
+				 <STM32=5FPINMUX('H', 10, AF14)>, /* LCD=5FR4 */
+				 <STM32=5FPINMUX('H', 11, AF14)>, /* LCD=5FR5 */
+				 <STM32=5FPINMUX('H', 12, AF14)>, /* LCD=5FR6 */
+				 <STM32=5FPINMUX('E', 15, AF14)>, /* LCD=5FR7 */
+				 <STM32=5FPINMUX('H', 13, AF14)>, /* LCD=5FG2 */
+				 <STM32=5FPINMUX('E', 11, AF14)>, /* LCD=5FG3 */
+				 <STM32=5FPINMUX('H', 15, AF14)>, /* LCD=5FG4 */
+				 <STM32=5FPINMUX('H', 4,   AF9)>, /* LCD=5FG5 */
+				 <STM32=5FPINMUX('I', 11,  AF9)>, /* LCD=5FG6 */
+				 <STM32=5FPINMUX('I', 2,  AF14)>, /* LCD=5FG7 */
+				 <STM32=5FPINMUX('G', 10, AF14)>, /* LCD=5FB2 */
+				 <STM32=5FPINMUX('G', 11, AF14)>, /* LCD=5FB3 */
+				 <STM32=5FPINMUX('E', 12, AF14)>, /* LCD=5FB4 */
+				 <STM32=5FPINMUX('I', 5,  AF14)>, /* LCD=5FB5 */
+				 <STM32=5FPINMUX('B', 8,  AF14)>, /* LCD=5FB6 */
+				 <STM32=5FPINMUX('D', 8,  AF14)>; /* LCD=5FB7 */
+			bias-disable;
+			drive-push-pull;
+			slew-rate =3D <1>;
+		};
+	};
+
+	/omit-if-no-ref/
+	ltdc=5Fsleep=5Fpins=5Ff: ltdc-sleep-5 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('G', 7,  ANALOG)>, /* LCD=5FCLK */
+				 <STM32=5FPINMUX('I', 10, ANALOG)>, /* LCD=5FHSYNC */
+				 <STM32=5FPINMUX('I', 9,  ANALOG)>, /* LCD=5FVSYNC */
+				 <STM32=5FPINMUX('E', 13, ANALOG)>, /* LCD=5FDE */
+				 <STM32=5FPINMUX('C', 10, ANALOG)>, /* LCD=5FR2 */
+				 <STM32=5FPINMUX('B', 0,  ANALOG)>, /* LCD=5FR3 */
+				 <STM32=5FPINMUX('H', 10, ANALOG)>, /* LCD=5FR4 */
+				 <STM32=5FPINMUX('H', 11, ANALOG)>, /* LCD=5FR5 */
+				 <STM32=5FPINMUX('H', 12, ANALOG)>, /* LCD=5FR6 */
+				 <STM32=5FPINMUX('E', 15, ANALOG)>, /* LCD=5FR7 */
+				 <STM32=5FPINMUX('H', 13, ANALOG)>, /* LCD=5FG2 */
+				 <STM32=5FPINMUX('E', 11, ANALOG)>, /* LCD=5FG3 */
+				 <STM32=5FPINMUX('H', 15, ANALOG)>, /* LCD=5FG4 */
+				 <STM32=5FPINMUX('H', 4,  ANALOG)>, /* LCD=5FG5 */
+				 <STM32=5FPINMUX('I', 11, ANALOG)>, /* LCD=5FG6 */
+				 <STM32=5FPINMUX('I', 2,  ANALOG)>, /* LCD=5FG7 */
+				 <STM32=5FPINMUX('G', 10, ANALOG)>, /* LCD=5FB2 */
+				 <STM32=5FPINMUX('G', 11, ANALOG)>, /* LCD=5FB3 */
+				 <STM32=5FPINMUX('E', 12, ANALOG)>, /* LCD=5FB4 */
+				 <STM32=5FPINMUX('I', 5,  ANALOG)>, /* LCD=5FB5 */
+				 <STM32=5FPINMUX('B', 8,  ANALOG)>, /* LCD=5FB6 */
+				 <STM32=5FPINMUX('D', 8,  ANALOG)>; /* LCD=5FB7 */
+		};
+	};
+
 	/omit-if-no-ref/
 	mco1=5Fpins=5Fa: mco1-0 {
 		pins {
@@ -1543,6 +1642,23 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	pwm5=5Fpins=5Fc: pwm5-2 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 0, AF2)>; /* TIM5=5FCH4 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate =3D <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm5=5Fsleep=5Fpins=5Fc: pwm5-sleep-2 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 0, ANALOG)>; /* TIM5=5FCH4 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm8=5Fpins=5Fa: pwm8-0 {
 		pins {
@@ -1768,6 +1884,21 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	sai2a=5Fpins=5Fd: sai2a-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 6, AF10)>; /* SAI2=5FSD=5FA */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	sai2a=5Fsleep=5Fpins=5Fd: sai2a-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 6, ANALOG)>; /* SAI2=5FSD=5FA */
+		};
+	};
+
 	/omit-if-no-ref/
 	sai2b=5Fpins=5Fa: sai2b-0 {
 		pins1 {
@@ -2600,6 +2731,39 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	uart4=5Fpins=5Fe: uart4-4 {
+		pins1 {
+			pinmux =3D <STM32=5FPINMUX('B', 9, AF8)>; /* UART4=5FTX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate =3D <0>;
+		};
+		pins2 {
+			pinmux =3D <STM32=5FPINMUX('B', 2, AF8)>; /* UART4=5FRX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4=5Fidle=5Fpins=5Fe: uart4-idle-4 {
+		pins1 {
+			pinmux =3D <STM32=5FPINMUX('B', 9, ANALOG)>; /* UART4=5FTX */
+		};
+		pins2 {
+			pinmux =3D <STM32=5FPINMUX('B', 2, AF8)>; /* UART4=5FRX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4=5Fsleep=5Fpins=5Fe: uart4-sleep-4 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('B', 9, ANALOG)>, /* UART4=5FTX */
+				 <STM32=5FPINMUX('B', 2, ANALOG)>; /* UART4=5FRX */
+		};
+	};
+
 	/omit-if-no-ref/
 	uart5=5Fpins=5Fa: uart5-0 {
 		pins1 {
--=20
2.34.1



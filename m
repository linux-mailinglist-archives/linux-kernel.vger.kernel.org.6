Return-Path: <linux-kernel+bounces-289386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35129545B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E83EB217DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070D15AD99;
	Fri, 16 Aug 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="0VzRKQwf"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2063.outbound.protection.outlook.com [40.107.117.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D0144307;
	Fri, 16 Aug 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800364; cv=fail; b=ICPNljTBAbecPbSCeV46izXPJSv5ZBpxXSBWC/qAs0SpPbf6+pfWxTWhP4mdzr9sehUTBZaM7qc2ZJyLFhpv0BouKi2fQbl2uS1JuQV/XOvIx8h5SLmp5KxzRVqmxXEcMuBMX4w+F/cyhKjWPHbPO/Et88JFH92RXzokpLhn3mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800364; c=relaxed/simple;
	bh=Gb1cMubfab+esZE2lUZ8pmnTHC5wWT80/mJF+02OPjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/i1VbiRmZORDKZDOH1wLFrihRvgYgBXysejvvc4nX5ViPfLCDg0EDGdZqOUWvmyykShcQaqw3sRDpYgEc2qSPRLnq9xG+s255HgP+KjLmQ0j7xEIooYNbphLHM503MpkA4ezxSoq5ij8Uolqsm1n+QPR4zhzjf+2B2P9wA4yYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=0VzRKQwf; arc=fail smtp.client-ip=40.107.117.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8mKBTegZjfApWPJioHd43IInsz1UDR9pjTNxdgT1v3S0F3s+WCekI2V0E3Ci5/QwvEENIjjR74NP4FRvEYRz+ruea38Q7/BIFPBtbhf9CpRf4hHCH+PZc/tziPJy6VDKNr3q/D180au6rT7My7kw4YWeWzeOY+XgmHaVQjh0LE43xMs4va+FnLdn570oCwP+XkSVVBbYxaBF6QmPYn9M/g8+K10zS5rXFjr2dPJ39NsYK0UWPuVUBMYISY7IPB2xdmmEJWHW8+1WoCGbY/8t0pw7Q4IqZ/lpWXy0Zy8d2B46NT5hLZetY+meF/RQyPJkpvyR9B9BZlDXiw1Las4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=bjx7s+jpujFGl4WAZy4lD0ayXPaIiV/OoqtFCZtkPPZTIXzxPQtVAsBzxgQcF5TUeKTpP5qznAjvvvLddJnVXf4nUmXIgiRScOqmySAEPqdygGiLxtJPryoHGFrbxgjYbA0HJuE7RjMNcg1uyzNGe+jDrxyLD5sANxWPzmXdUzcq20Ez88nxy0UIqtWr/2XHUTEVK402eVYzPkge4Uo+sE0AO/BxXHUclcj0X4SsiNUFRRbOFM4D8S5F4JpQEH1Tfss5HB/5brd6cnjJpQMsk50af2abHPOOx2KtmA4H3H5ijIA80ddsE4pIK80IdzP7f1pYGs+wLeci5hHuWABW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=0VzRKQwfnYGBDd3E3nyyEKx6faV1Qbk8aDcOYTuzQONnQ9rtAwy2vZLWF1RwQckIqC5HrQRKHxlyNKQmuHJp49E3cXTWh+TNNckYbJ6ullVJ2xqJE4KOwNFoAN0Sv/POnNY7UHe1z2RPrVgLaPdgQG8iePzD/6QhJaUYKSbl6MxUC0xRWPDAb4CPITXuF7bR+CzkZxX7y7QhtzVeEVIyjk0k9oEcW6NEQG40nO6JUK68IEXGVc8s+vffW1ikYg1L7JHA4Mxx2I9eBq/E9nYExMSPok9UHSjRJdaDZimEx1OcThF25bWzYw0mot11H/ASJSijDgtIHaSI95Tl+yBxew==
Received: from SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) by TYSPR04MB8320.apcprd04.prod.outlook.com
 (2603:1096:405:c9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:25:57 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::8a) by SI2PR01CA0037.outlook.office365.com
 (2603:1096:4:193::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:56
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 20/28] ARM: dts: aspeed: yosemite4: support medusa board adc sensors
Date: Fri, 16 Aug 2024 17:24:07 +0800
Message-Id: <20240816092417.3651434-21-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYSPR04MB8320:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3652ee59-e84e-4dd0-b6ef-08dcbdd56f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKnpY6ytGR5l2S56xq8UQnPRtQQ6tqobDgihhB2g4X+C6+pMPA4qI7b4F7IY?=
 =?us-ascii?Q?hVXKRr4xD6Lcwt/VeRd4/6L/CB3USp+f1M5ogXqF65NKwMrF9lF1QSM+Xj4h?=
 =?us-ascii?Q?VAP2rGkf85BN6+sSdnTaOHK8LyCCCZaKYwVGCEpqNKkWm7eT9KUKJbWLZq8j?=
 =?us-ascii?Q?iQspA9QmC5PvfEQUYNaeHNNs7gvdB2zxrz+rY101+cRDJ0HGvF/KtGySZvLl?=
 =?us-ascii?Q?t7E8Q/PYJgme9qZ9Wp8XsX9qRXB2OvEhq5JyDVmIF60qetTdQHJUF7qrwgaV?=
 =?us-ascii?Q?5YgYSJgpGwNR3lWJZD2qAZPaMZ+MzkumuwAcBeUQlypzQRY3PzDmTKL4nqDp?=
 =?us-ascii?Q?j3icND+mhIBX6hzGchCWmIwO8j3rSJTrW3UDrSLD9do9Hau/uPSFtDchbOpQ?=
 =?us-ascii?Q?oOhf+hg9aCsKaqrSvkmgIOoFKf+R05OjXY1diKf2mleb40QIV2L3+nfr3Ihm?=
 =?us-ascii?Q?WSzOLSP+Lfpwdw8HfYqwUGRkNE11OStXlUSHkofYZGk6zBmi2Cu1qajf88sY?=
 =?us-ascii?Q?/nu1Dzc49aYK73K1hY11uDfVDlLr9dB74Y/z2KJYLSrLIrihQEPL4YVT46dY?=
 =?us-ascii?Q?z3OLKrMqL2sUueKgvnf8vHB2R8GDaGiCULiP68j8atfl50AFgcwUXhg8PWoi?=
 =?us-ascii?Q?+tU2e2AWfSbGyNCZkgEq3NEI5LswTJrLhGuMGc2DCLJweOuPhW6dEhHjstlE?=
 =?us-ascii?Q?XYuYcDTuiYFotbt0VN7NW4xe92fcoI4+1jzgyacwvazUsfu2wdOSlfepwsjl?=
 =?us-ascii?Q?0HMEAbELpCwten4Xx+klTjdAD3hSN1ieIPk6UbKWrIo4d+4rhidyJEcx0dsu?=
 =?us-ascii?Q?qoXsw69eeOVLMK2wwtG9EaO00x3ML+dFcL3PiBmCI0N4zaETZD+/MxJy1kic?=
 =?us-ascii?Q?q4bmpOli26Lt5wxq/dLcD5AUj3cKsxPRBpn5tQCzTkCQIwOa47bQxoEHwUky?=
 =?us-ascii?Q?zvccTiZR36dozLs6m75aRQog1PXs2dchkUxnsfRGFhXmp/TGJrTwb16qhot7?=
 =?us-ascii?Q?YyT9KAH9EUXUs/JnWBvHF1Pj08K6DA1Sj4Jpm21I6nET3/0k/x97qdzYmN6Q?=
 =?us-ascii?Q?b/uitp0TDPofl4miRMFs+NbJ9ZySf83bFYac+6CcVUBONb3Cxv6mVUUFuriv?=
 =?us-ascii?Q?NVkFw0c5gogwkXm2KlcUiS/i/VCnogMM8hCs/LKcZZ1kYzwdLsUceGJWOQ+I?=
 =?us-ascii?Q?N34JyKrd6QHXksLAiGlXODzbUNjNaRl+3vC28EsKtUh7MRVhCm4ZaENVLYCq?=
 =?us-ascii?Q?zCh737M7EjAlPmIG5fSi+K+WG+hoaW/faifdEDAOTM494oJO4l4DfcL6BjFu?=
 =?us-ascii?Q?klfJsUBvo2JxNpawUJWKOU2cvv9RBQ+pAxndKRzwno51eo0rWWNRG6En5WEN?=
 =?us-ascii?Q?PuXrDgiohRu23Roi09/bCMPyZhSCqonIDy7VOCWO2aT3fl8y/5A8RBaE/qhT?=
 =?us-ascii?Q?vt8jiihOTAZ4a+aJHs3Nqqck9/TKjK7x?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:56.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3652ee59-e84e-4dd0-b6ef-08dcbdd56f43
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8320

Add ina233/ina28 support for medusa board adc sensors

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98eeee49b082..49500db53a13 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -915,6 +915,19 @@ power-sensor@40 {
 		reg = <0x40>;
 	};
 
+	power-sensor@41 {
+			compatible = "ti,ina233";
+			resistor-calibration = /bits/ 16 <0x0a00>;
+			current-lsb= /bits/ 16 <0x0001>;
+			reg = <0x41>;
+	};
+
+	power-sensor@44 {
+			compatible = "ti,ina238";
+			shunt-resistor = <1000>;
+			reg = <0x44>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
-- 
2.25.1



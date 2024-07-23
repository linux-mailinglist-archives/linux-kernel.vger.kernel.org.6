Return-Path: <linux-kernel+bounces-259820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4F939DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4593B1F22CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2014EC42;
	Tue, 23 Jul 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="R0E1ev7y"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010002.outbound.protection.outlook.com [52.101.128.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AD14D420;
	Tue, 23 Jul 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726668; cv=fail; b=Qnwjkcu9A+6wqTfDq3aUncYkxhVoaNQJcUUW/7nVWj382FcjQQ3cMkel2FCs7VRuJ6xFRhiWONQKEMtvrmlEWcUXpAmr/CHondYdkGrjQSZOPcPcuDkCQZmc9RrDscES9+HrSMA1aKvik251TiVd5zGxfrs2fOjIpZ1TenN0jg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726668; c=relaxed/simple;
	bh=IjUBTAVCU5Y6ChjiBa/OvcgHFZFxyyiZfGefmSk6xyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnKoDHnLwu6s9Z4Sob1MbQzwMBK4EJkE8w1lQIy0+dsXA6Cb4mWXmnGjgS/tZKMrz5Hry2O2Li5orCIU0mu6OHBUP747/L0lPSRQVvMT1NhYWaG3rPwRnKC0xURlwNPRjGwIYwc56oQ8qKIQ5ce+IRInc6mAV06PgqaAd49c1t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=R0E1ev7y; arc=fail smtp.client-ip=52.101.128.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEkgEBQ2WhIAqhGdE6pXU+G1emIH6z9aeokb1UeDMlNySuOd9X+/t+gltaEdxrdhxlpaNLWaft0EGlasAcuds5QlKUeQw6RXfVtW73iq5evm7jsibN7Z5pWI8Ss60ctyDhlXVBTvHyGBsl/hlCMOHSm+U1UimmFDPCXLHuNhqf3I4SrGp+Z8h68u7ba3bN6ljcXX3u2J9NCsnqoLPvY5zSARCSkWUVcXCR3cCp1HgPzZbqbvjbr7DfzrvIDksEhi+LGAoTy3vtfZk6pobQJpO4wlHE0ixUjzbc6/45lJMvvIVVB4weThOE1qig5KSahI43wFWeKGsUOoZO0JvIp2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgFXoaC/5DtSawXO9Z49kR8+2OHTKZslFpSvIDp6jkY=;
 b=QDc76rJLSmN/N84Soov1/+DVATNPgwH6mI0e5Lx1IdH8HqaISDdZNFbZs2OJI+XgQIWs4NIkxlLX+Nr6fNxgvj3o5UId29nX5FZw5m0ipoENWTen2MB1dB0J6ADPZwUvyPoG7khowtfANw3xcgD81goNsycAOMjdmo2upEY8oO97n4/djsf726vVKebtwRgc7rh9ckxwNCji8G0oDll2JEmEgNzXJ0NfOpYaIYtLuKtxQ12gP+CsA66SeQQBJps28g742knd61QocdeK0dlr5eYvgVlFmWABIbkeGX9HtXGijsT7Oj6DA3Bcf5xZTOsAtRV7fZduVcN4Y6t2r5aQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgFXoaC/5DtSawXO9Z49kR8+2OHTKZslFpSvIDp6jkY=;
 b=R0E1ev7yWhLU/xYoldzq43avzVA7sEAAIvhy7iZIEcCG4d9EXBkdROmIAvkmoJcfEt564W1zUSLJfdfHMSdCGk7XBcLUrRljrKnw3WMBmmrbvPRojtfg8tTe+cLYZ2CdkfOZzfn49jlfBUxPUFb+mvWx17+IRgwFxQUtbl/sriwN0qq0nAVtUBPKwIK1SyrHJvaISQEj+U88GfBQg4k0/fQ25WUWZEu71YSzxJ0YsT5SRo9Tn3Mj8AjO61FiUn07sbHVYst8qS7ebBoczn2NzQyegu81MLGJgcEbajSVzLARIpXo6o0IJDy7BtcxyWbtniB7tBsluBia15Lld7HIrw==
Received: from PS1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::19) by SEZPR04MB7796.apcprd04.prod.outlook.com
 (2603:1096:101:221::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Tue, 23 Jul
 2024 09:24:20 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::38) by PS1PR01CA0007.outlook.office365.com
 (2603:1096:300:75::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:19
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
Subject: [PATCH v11 17/27] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Tue, 23 Jul 2024 17:22:58 +0800
Message-Id: <20240723092310.3565410-18-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB7796:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 76de35c7-c085-4529-95ee-08dcaaf93b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DWFLsfcNv98cKeVBfTIhAk5LzjW68W7KWhn+ApbIq6NrmtZywiXqj57LQA82?=
 =?us-ascii?Q?uVDvi832jBGbKj9hNEJw2ZRQXQwIiblFJCJXj3PZpX1/q4f/Pdw+xAVkP/Uo?=
 =?us-ascii?Q?6e96zntCPbb9Txb8zjIGGiom0L3/xSoRN7HpD0vkDeqmp1UFG6NQfRWsGDSU?=
 =?us-ascii?Q?ktldBt3bJIHF6HvLsI2fhw9PhAsfS9NfPFJ6buMOJ1MSvoxPyrEJrdO+ubII?=
 =?us-ascii?Q?rA8zqUyMbnoQyG9x6M8M/qL3G591vI3Opd2mtdJoE1GFm1LjTISUC1hRl1UR?=
 =?us-ascii?Q?ofNmV15yO2a53B2z9+EMpEEaKOnAqXg47fahDsx1ShMuGIs5izTSNey1ILtW?=
 =?us-ascii?Q?n6mb3Ynb2ien1iDhY5UdzHsSuQicBmCu3J8Wi39YCghuzBdgB3MmSzroBE3l?=
 =?us-ascii?Q?LkGo8gSbyKdZjzipB06ua/7SmQ1ltDcmqKxsTouZRw7plmwaJufe1ERjGSCw?=
 =?us-ascii?Q?9ujPji71p/hvxxCNfaSwimCy/6KBY+S3BZ5r+ZHDOVB0sZnmz/AsNKDKyKpo?=
 =?us-ascii?Q?hFMWhpfxHgK/QMw61sCBbnxwsBLfrvWAFeCl14m4OdwwFpHRGr+LmfEn3lNe?=
 =?us-ascii?Q?C/It6gE4m1XTCcswItkhr7Kqxb779KPkrFKAbJlQZPMFBehRsCiMpfDJn3Bu?=
 =?us-ascii?Q?PaJB0Oqe7wTrCbCoSShU9i18+7rLR9evhSHB/gIVDvs2JF6FUlyUzDhe7iYN?=
 =?us-ascii?Q?WYF7CeAjg2ozRRsuxJOg9ju5X/WcKUnRyRBXR4aDdUFp2u05hnrpfVek9g9S?=
 =?us-ascii?Q?nq7jLohygnxofBihs5BCsJyHTW8NDIq00m3l0bzYzXmf/12rn3XGpuEhMPh2?=
 =?us-ascii?Q?8c3TYIkH/2iq1GJQx6ie2WnHftGVTSxv8jgzOhX8wqaPq9PXZAgvTYtFDDXC?=
 =?us-ascii?Q?PtSjIGJff8xxHEHk6AtjgALHkv+7IEiTyHC67Z0TF6rn7VLT4iRiDok5nC3n?=
 =?us-ascii?Q?xKts+4lDVAeeqzXGr1mYk26KWw7H4SELanIZfcGMU/O3atmTK0clmQbXKQ1n?=
 =?us-ascii?Q?Ji4kmyW5lrWA2KlT0Ohbkl4tqQVtWoerxQr75dIoD8T1WQlXLtKRNqF1w6Vz?=
 =?us-ascii?Q?MmY1rVRiz96KwD5l39KY8NZdSOw38vCjH93vbPYZYBG1uoSLFGYbUq/FhelT?=
 =?us-ascii?Q?1X0n2qf5s9ZqAYnv6TE6MscWF8o9XSB1jHTX4iJR0kH/or8UZ5hyLNR6YzsZ?=
 =?us-ascii?Q?0RFpcBGD6Jld4wOrXUQ2MmVllRepL/RbydJxCrJvCREOmOhXrzIGq35uxi4b?=
 =?us-ascii?Q?caKjtuxuA5TVjzuUPiGog7kNoOTcd6MGwF0mru0d4a5j6kGUenmu9shpZYkZ?=
 =?us-ascii?Q?RScrq3oFLMTehEmT4hHrCJ6R1DM0dY4SFw4lHCYMciEUd+itWAFgz1Q7b0ZP?=
 =?us-ascii?Q?7UzxzGMiYbkqKQQMm4k5u5dLxeEBziQ/9W9c0BCe/RkYGnWE+nJVagcQmgpk?=
 =?us-ascii?Q?IxcUrBPuHXRbbwj1DftwoJJd4d1d35iu?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:19.3477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76de35c7-c085-4529-95ee-08dcaaf93b25
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7796

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 60743f9829a5..b46a0b9940e2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1103,8 +1103,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1116,8 +1126,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
@@ -1153,8 +1173,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1166,8 +1196,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
-- 
2.25.1



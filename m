Return-Path: <linux-kernel+bounces-353426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE300992DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03551C21EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC211D432C;
	Mon,  7 Oct 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="UK6dH9ad"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF788199235;
	Mon,  7 Oct 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308675; cv=fail; b=KCc0c3OyBzRKa2MQigUJxs1hVq3EZmWaVhAvuODRSiXxTtMXeP7o3Zi1D9nu8i+L0yYv16QcPpPcFJV2uAsqbAj4mUggmdeAvalCgVVWB+lHLReWKut8T5qnvTq64q5iv5jbtO5Tm74ZxKlZXFybchEG4pEp//I5lpBpz20zW3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308675; c=relaxed/simple;
	bh=zupFJ8wfa+/IFXdpa/AXC6qDDDnI8PDChzrzyD6TA6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RcNV/zve/y0NY0G5OstCBP9SBWUGCU0JZgXDC37lXT0XpPvDczqrENmMLJ1QzPF2DhvTRJiFCJKWvzHG8LQ0pE0LmsWjr2xwzKhm6pn69TF8ZWsTf1YiQtg9B37Vdp+505OsCLc26AkQIuAahLriS7+EQPVSIjMMXF0gca/lV7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=UK6dH9ad; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpXWZewhr1hPxpA3DAEt4advVKNTUhUW1a4jV75eHckuNGvPedzbjd3rLYtfILEpmFf6CXGS/7ccZMJmhOkqywBnk4vztdeiJx8MP+QLvFzoDc8WwoW0sc2nwssUS9+wyKS+6F1OVBkS+vqg6noGiGX5HoNXJlarI4JHPzyFK5Yt7fjlQtosL9Rm96jQUFwQHPsWeycifzP/v/sJBKVBNcPii3dgRmXbaAop74T5/uZULG0cIiIdO+myuTZ7oHFJ3lVZIP365jZ2gD6LcJDaWUbcIt+3tp2B2Nxyi1prLpAsBHf2fvPqmotv6zAI8tfE4yd0tRKk5rYeDZnIwi/Vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+fU6G3+5GFgUiaUylVlZ8udTBxmuBU8bJvLHgkFwDI=;
 b=giFAiNmXsw3Bsqtf+3lubhCPiyBd5G78iFBsOCaw8LGAjSMDdRyOz3Zpr7LlZW6v9wHIqqewZiiaST0yhLrSqHEUvhyW8yr7teRAOqvaZFXQWq4ic/ylPN8pXW0lRPyVP58oTyEDd8go7YNuvHGx1A01iH/g3kwP1UNupo54CFTFCazQpOy2OGljDmwEuVmxVpMoBi0l60qsNlBL2Bm3Ky+4/y2mdy+R7mlA6CHqDl0hfXgOQOItoGdYBMRFvZ3/ecPte4ADhd6RTx/kjpvoBziBO2jH4SEYmW5DqRN5cGuXCIl4mer1zzyAL6IS58ufxOxiSp3AAdD46IqH+H4eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+fU6G3+5GFgUiaUylVlZ8udTBxmuBU8bJvLHgkFwDI=;
 b=UK6dH9adRWt8gsGTdgtbLD6ubCxoFnsrWla1p5mRRVYgTkbObQJg1iOwmMG03/OgyzhdcuR78ENfurs8ZNYqbocjuMPxgCww6DPSllu65+7Mg+kqm0AvkzZqVRPxxXVp0taToGMryiICCnmxxFEKosSf4jeqrIU+UX5g8cl3jy4=
Received: from DUZP191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::16)
 by PR3PR06MB7067.eurprd06.prod.outlook.com (2603:10a6:102:81::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:44:29 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::a3) by DUZP191CA0006.outlook.office365.com
 (2603:10a6:10:4f9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 13:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 13:44:28 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 7 Oct 2024 15:44:28 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH] arm64: dts: imx8mp: add cpuidle state "cpu-pd-wait"
Date: Mon,  7 Oct 2024 15:44:24 +0200
Message-Id: <20241007134424.859467-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Oct 2024 13:44:28.0399 (UTC) FILETIME=[07AA67F0:01DB18BF]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|PR3PR06MB7067:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad3fd595-99f9-4048-7487-08dce6d62a5f
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1aelITKC0c1MpL0OdNIr9i6caAAxZEw6MtQyYv9biTYY0hzOXAKAOEDpkhpL?=
 =?us-ascii?Q?N8K5AMFBdKVNcCo/CAHIuRQbW5/1vI8Ho0QzXf9Vm0pauc1xfDB1tmcearH1?=
 =?us-ascii?Q?DWTFQJVGKedWxImERlzx2VuQ1pW26w0wGWW2E9N3FB9r5yZoY3BoP2GQ0gKk?=
 =?us-ascii?Q?EBF2TGvbvD2qTS44ScMqBd6D/rZU4hGX3FyN2TmhxriJuzStHtEni7VxOXce?=
 =?us-ascii?Q?VhFnlUksTZ2ZE+0McKGvfQyL9IlG9EhzFX8dPXzGXGn2xbcOFzgEJbHidbek?=
 =?us-ascii?Q?Q6vbqd0tZGhxr77dA09nZKbdDXsDmeeHKSArYJTtBu739D+cXvtNNIJupBTl?=
 =?us-ascii?Q?FPLViFczJ0myxz1kOSIcszDtWuFUVk6Cm8VIVMfij7kO1Lt6OlUI9OYroVRn?=
 =?us-ascii?Q?xL/ltDYI8xe8Dxq7LlH4r4BzklorZHonkj9PZ/apGnv0IHR2Q7VrjOwfwops?=
 =?us-ascii?Q?MEXNdpqI+/+v8u9CGxCbUhMzg1KU+PsnC9bpGRtoaP91Ioee15cYKJMcMOpl?=
 =?us-ascii?Q?DcOp6HXSMVCXdBogbRHqhBWISCx4Y95YNtWAkImnYXZm4osWNQ15vzHOB1Vk?=
 =?us-ascii?Q?IHoMeUf66KUJi7h1LCGHkkRQpLISODUVMV/JUZGkxHQ6ielI5Q/GpDt0Qtr1?=
 =?us-ascii?Q?7FVALHB8R4/Qt+Ajl+fMei+vq+yyEAwGDFjWQyVEihnjv9lxYfy+MtzhTsl5?=
 =?us-ascii?Q?ov20bKxAd0ablU5G6z/Gz48Zyl8VpI3zOeTSlaZ0/OwFj4MOljs836ZOkqJV?=
 =?us-ascii?Q?3P6wgQOkonrFD+VAYewkCsPVnvrHdy74HTWtoIFOiARTjGCD4PRTk7YFmwn8?=
 =?us-ascii?Q?7nKlyDWWkyE5KStAyphxjweKn1k3f25ebKeB3G6BU5jHeoAWheucDHfoHpkl?=
 =?us-ascii?Q?REW1Z97tWqYKk2Ilrdh1uEhozSzfmoF2XPq8tkcTxWk5q+tpHQHsNcFxXtpf?=
 =?us-ascii?Q?ulG8dZus8ZVsCi7sYwWXEfjHRx2o/IwG+G7ED9JdJ7PX9fm0NYeVoxVZZUgG?=
 =?us-ascii?Q?v6sOklA/J5sCHpw+idVb79sJrKXndE72VI8N1n4Pavkaw66hAcerJexa2oc5?=
 =?us-ascii?Q?51RUEGAnwdOy68uMyhrcykOgtDX07IUWG1Z6MevHAYJDDiJU9lyQK/BqECba?=
 =?us-ascii?Q?B2svR+FWoTPSewfoFK5yDfgUCy2MYCbLOY+pTpy13y+AwLDW3MMXsKFD1ChO?=
 =?us-ascii?Q?qkfubtQr8GXaN4cyqJ11UcHhiBXE+MgvhdUSLn6ggz7LxN9XMy4K8rlqIrgU?=
 =?us-ascii?Q?E1SVOa3jpBDnjpRJ9S6rCwrl4egqlx+PdkZjY2jwQVoVnPw9UGX4egi4hBDh?=
 =?us-ascii?Q?mjofkBmtZSQf7m5NqDPV3qBAqx+0ZEp1ruVqNApIMtcTLQt/WPbPf1HxI3Ek?=
 =?us-ascii?Q?cOS5rGN34d+xFKAhOle3sxWwqmxA?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:44:28.6650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3fd595-99f9-4048-7487-08dce6d62a5f
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7067

So far, only WFI is supported on i.MX8mp platform. Add support for
deeper cpuidle state "cpu-pd-wait" that would allow for better power
usage during runtime. This is a port from NXP downstream kernel.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index f3531cfb0d79..8b1e0ca248d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -47,6 +47,20 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+				wakeup-latency-us = <1500>;
+			};
+		};
+
 		A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
@@ -65,6 +79,7 @@ A53_0: cpu@0 {
 			nvmem-cell-names = "speed_grade";
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_1: cpu@1 {
@@ -83,6 +98,7 @@ A53_1: cpu@1 {
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_2: cpu@2 {
@@ -101,6 +117,7 @@ A53_2: cpu@2 {
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_3: cpu@3 {
@@ -119,6 +136,7 @@ A53_3: cpu@3 {
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_L2: l2-cache0 {

base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1



Return-Path: <linux-kernel+bounces-345475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3E98B6C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC331F2256E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4619D09D;
	Tue,  1 Oct 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="KMJpPApV"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010015.outbound.protection.outlook.com [52.101.128.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9F19D07D;
	Tue,  1 Oct 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770881; cv=fail; b=ZGRgZzVCfAaLB4bPf6iqitJXEbhRt/LgyE5yT2LaBXC02oFmd1YI5QlFYK1HqB0c4QEa1+zyiJuNDFBAbG3U/pvCDvM8/zywzax+uwev5PONxrtjkYBKMbU0kshc26f0RApFrRL6BTwFTXXJFO0F9C51UUQNNXVw25oAYluUxkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770881; c=relaxed/simple;
	bh=O0WJphXTV3j9GIsdLGcv/LGK27aFvp5yORc8SPExwaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnDAAXiv4z5rTCIskE/ruOLx4RKCUg9MFeerErBETqRqAXZVhCmqFhYC3GL+oX3frStPrpoX53r63HPVWSx6FiFg+u4/5McZsLvXsgSS5nqtdxn8Rfo6EFuP94BrfNJyO1Jdu3o7V6f9nGWs0FtcB0sMfJyNV9uG0+dVyVH2Vq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=KMJpPApV; arc=fail smtp.client-ip=52.101.128.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY6T6cGpMjW+eqLn8yrpNrRzTmLytV66Z5GuWF2o8J4kVTsukueOTDSNs31vQlZWzURZvc/WgnuMdsTR+L2qaNZI1ZvYC4sD4EE97N7Evki0WvYVwgEwVp2sQPzw4H3iwc40MP2ZcAFWhCweTZFcuZvHQTB2hRln2n7w2/Outf2c3hZGtxm/IGilhW2eKgIucqO+b73aClPEyOXWRz7IpN9POFxEFR2VL8hPzsMZpHfLkPhd2B8eB1xz7xlDTS/MUUbTLp5A7KxgMQcZ13ozGWBnvTxQUPqKGbb9ZbYyOWWtgI8/4yn58LaSR+wEZS78/2CGCtSnd//fzIKjs80X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivrqsajO5y+H8fEYP5imlDfZPWpEYCC2oO58apcqliw=;
 b=SKpckb8fANXlDX5XQVIztvNRn1VIk2wE5J56HoMzu3Tm2WWN2mi8UcwU+F52FIgYRZpXSYqk8N2SLWwnvx3b8yDOJNOltyOwn3ilEqj15qZyxKlHm1Ulzfc3OC6tLU4QgmpEKOvQCV5PYoai5lgUNgV64Kv+rDJoZg0mDoGT0ku1F7I3vcpWoBHGbfrxddf0gvGRnmw67SwDNSL8tjwrubyJIC+RYVesEMllb7P2xhgMxlqh/H8Kc1rHw5YGIl+dKbdQhyb3jPES4JENaezmORmxC+zzXsa98cPJZDJ5KHx2IyOd793e1Rl/0ZhEXISUUydaQ21U069DUec0cvFSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivrqsajO5y+H8fEYP5imlDfZPWpEYCC2oO58apcqliw=;
 b=KMJpPApVH2iCUCMseITV0GUKEvrNDUV7gUks2o2NzgDeQtY9QmTqcZSLdL5LShGCSRMEVkYJKLs/kv1haVM2AC4kcEJlJYXOAl2bGaV8xs4VAo9FHzapsmqAysMD8iYemewfHJHDcCEW5VaR2ywG3nKqRID9SU37e44xHdGXEuNlPAQwIoNImPlbGJcZ3qPwIoIyJKIVgUcdcm1rd+NLbclBJZ1+pOkcr3wR79Q+IOOOUT2x+q7VpzGqF9uNKoARSfcOag1dRqgqZwqOK4BVpu9hpJxHAI3gKEL7F/BAHdI+tn81ULXr6tdrRvi7hvYBAfhJ4WI0qYDJYBf9IdbNdQ==
Received: from PS2PR02CA0096.apcprd02.prod.outlook.com (2603:1096:300:5c::36)
 by SEZPR04MB7930.apcprd04.prod.outlook.com (2603:1096:101:231::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:21:09 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::9c) by PS2PR02CA0096.outlook.office365.com
 (2603:1096:300:5c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:21:09
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] ARM: dts: aspeed: yosemite4: Revise address of i2c-mux for two fan boards
Date: Tue,  1 Oct 2024 16:20:48 +0800
Message-Id: <20241001082053.3455836-7-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB7930:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b2a8e448-ec7f-460d-0d5c-08dce1f20107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/NFFkp5Vw0d+7XWn9wJx4TRAdTuNBbDI7occ9RH1pr+NRw/3Y8C2gTvfK+U?=
 =?us-ascii?Q?QM7CoBPDxKC0WllmwU/D/H650oeSdhZ5thgrMHOq5rydfTCSOgNXIDROo7kP?=
 =?us-ascii?Q?3cMRrFiNzwUjJ5PpxoloRqOjVyfScC3Z5KY/zG/9d95zNxlwP6YUImjMW/hE?=
 =?us-ascii?Q?nH8S7CP+O/IZpUaEINxK4YjY6tqPixgkNz3LOLWHKzZ0vj2v2B5SYLTLVDwL?=
 =?us-ascii?Q?I1szc6+x9kv1GZeRW9LhjaiMr/tH1ihhU81a6Q1C838NXPKo/tw8DMSzpKAy?=
 =?us-ascii?Q?aL7HlJbFI/6EOccjYy2kRufgX+UYx7TtRQ6JOMunej6mve6+oP6cXEk+TPpf?=
 =?us-ascii?Q?CGuxPWCZYNNmB9FVtYM/nUyGIfus6BEtbZxDpxf6jNU+MBUU0+ZShkQdSZB0?=
 =?us-ascii?Q?V60EIb6cx0Mk24Q+0iTV/dFC5vt7ZyimSEAoVx6L0LMKG3xysnqj+6L/YvnL?=
 =?us-ascii?Q?VV3c1WZKckJYj9vR69XLbifdcKNGpQc8aABIayzb7gDwvaiww8SGslC1fEdT?=
 =?us-ascii?Q?0BKpzvEb3ChQCxqjWU1OVhC1ZZl8rf8V3S8BiP5eScc4KKjTGZh0s5hYHIw5?=
 =?us-ascii?Q?RmRrNwgRatUOhiwCl2g65NELik4bp5vRmno/sFefRQMHolesgLy83CW3q2IH?=
 =?us-ascii?Q?HJhT4MRd/+FKfBxzdc47YE6eAr2pcUoyrlqL1VoAEEYEm+qmRWbofzwZp68k?=
 =?us-ascii?Q?xVn8XabN7Afl5MsrRXopjLRFGKgbvoDGG0tQthjFQ9AQCXWh+g8llOYkI/Mw?=
 =?us-ascii?Q?j6FJJEjt/3qtZbyOdQVrCjwIcQUeHKIdhhXBUXKaNqxlniXuwL1YqNNNDYDo?=
 =?us-ascii?Q?p2A6Q542jBYdfnQVT4jp/Rx4Dnl8W8ViNucUSog974Z3djqQV0N+alusgQJT?=
 =?us-ascii?Q?yOI5R54WZiY0/9dTGmkpYM0K04B7HN5NZePi5HI2cNa6Xen+en+jM4ndzAOh?=
 =?us-ascii?Q?Q2Ab+gM+wZ8h0FxoEz2+eun/QjaptsVJmtAFVKn08/BZTyDPx3Hr5yNrM83J?=
 =?us-ascii?Q?B/A6X1qz+KAvj9fUt6m5rcsXoXQCk8iORnVn35wqJyrBdunXLojuw3WSZlEi?=
 =?us-ascii?Q?CDDor1TAMZm4HSlN3nXW1IN6KWwmcv4E7aC7EYisAglI2K9mERedEGYkUZ6S?=
 =?us-ascii?Q?cnCV6H5bvQKBXRF9Uxepjy7QSSFyaCuFnfsGDjWpte44gHU3KOZdPzUxyTsp?=
 =?us-ascii?Q?aFTkDOfu/I7tQXINdZLBah373iGirR+M1n/gM+ljWOKzXzfk9ndGwOwoQeNf?=
 =?us-ascii?Q?XgtTqybQCKmpjlh7mcIah1ueOD1FRxviK62hDAwcdl4JjX0IaqasRmJ4DMTB?=
 =?us-ascii?Q?vxVN+DBhmlNoa1vUJcIglgbh1aeHWwxyOMXTvC8U1v/+HSLzVhtpi1M/2mjC?=
 =?us-ascii?Q?qMW6ysJ+LlC/U6am2+ascIlky5I/fjQirL8lo6MykZX6h/j5EGvRuMQDN7Uv?=
 =?us-ascii?Q?hWDWJumtPLg8kFfuC1UCrE0IINdN9uAQ?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:21:09.2998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a8e448-ec7f-460d-0d5c-08dce1f20107
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7930

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of the I2C mux for two fan boards to 0x74
according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 76 ++++++++++---------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 3ff22ec8de02..ecf012c9cbbc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -32,6 +32,8 @@ aliases {
 		i2c27 = &imux27;
 		i2c28 = &imux28;
 		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -1062,6 +1064,8 @@ gpio@23 {
 };
 
 &i2c14 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	adc@1d {
@@ -1122,20 +1126,50 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9846";
+	i2c-mux@73 {
+		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x73>;
 
 		i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
 
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+	};
+
+	i2c-mux@74 {
+		compatible = "nxp,pca9546";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux30: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
@@ -1183,10 +1217,10 @@ gpio@61 {
 			};
 		};
 
-		i2c@1 {
+		imux31: i2c@1 {
+			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
 
 			adc@1f {
 				compatible = "ti,adc128d818";
@@ -1235,38 +1269,6 @@ gpio@61 {
 			};
 		};
 	};
-
-	i2c-mux@73 {
-		compatible = "nxp,pca9544";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
-		reg = <0x73>;
-
-		i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			adc@35 {
-				compatible = "maxim,max11617";
-				reg = <0x35>;
-			};
-		};
-
-		i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			adc@35 {
-				compatible = "maxim,max11617";
-				reg = <0x35>;
-			};
-		};
-	};
 };
 
 &i2c15 {
-- 
2.25.1



Return-Path: <linux-kernel+bounces-345470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B2B98B6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3378AB21FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4519ADBF;
	Tue,  1 Oct 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="zX1UCXxF"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010035.outbound.protection.outlook.com [52.101.128.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468619AD8B;
	Tue,  1 Oct 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770868; cv=fail; b=nk1LeLEcZvlHzPXYflRoQn7HoeVc83qHmCuVPOjpkeZxEY28Me7yyM/CPmEdBeE9VbGFkAedQMNLdM8782/9fQbjEl2f9mySRHSZ3irQrQBHTpTeon3N5KQjt2ydKAgCE4V3gVofKrwxiFCZmvE93mAPvgoKqsF1RPmA80R26Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770868; c=relaxed/simple;
	bh=SYU92OKfkk5hgHfIVa5x7kCsTnmZWZVDSJSDZSujxjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvSvW2mhUhZV8mRMH/zhmjDL42F/Jee8wKD95TpfdJmR/t4owFFovZY4fHBnb0tMhpUOX36khxhhVVB6fqd5tAenFg58lszkriEV8VdySXikn/nYXZwc8erSumRM9MYr3vu0wVFv1zPv8ABVEkoJYmCO8ftXJNbxoO8te6opv8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=zX1UCXxF; arc=fail smtp.client-ip=52.101.128.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD/nBjGUn0t07EGr4M6FCkhr4oEZOb4qbLgFRq8ZBmOFAdsxAttV8VGrlAyIY+aGqEkftfdvctMPCxg02jX9ExhPJyE1ljzeDw0Z/ajBiTBvF/Sa2rBTAOxdNBY+Hjxzfh9yr+kAwxjDpTAWamFM/NRjHW9VKz7F7Nc0nkiCq7TZT41bCDm9UZLP2/asXIaHgaQIcqj+u54PssDLsynFhXEi3HKBAkCsJ41djdzOpYyFHz4RMB04FYPz9LNpJYE3mE3vAl5Pufnh2sTJLhd1NXNMc8tgW+cCVWfUYswOtZWN4mINpJdzWbI+YwMheCMIhLfODt4THlZ83nKGIypk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4TnwL8e302OeGu3LMGeH+f4Vbx4ULsswRUWS5OFeNU=;
 b=CuYgPvgoScJ5jck/pHQFTDtJzzeHcuttpvEkEpXVoqkXb4BT6/jv9Q6K0Q2NfPqpT+i5fbPtvQ6qSPNtlfJtWqO2l/upYWn7+NxRSTa9CKe7IFDR3sS9kFzT7Eke8YuBQuaOH+n4T4giHGx/Zwig+kOOnRTbQUkxpO9esj2bwyAEccwpAYjPMfwu5IbrK3WrgSUd6u5QAHfBP00ZVdFz6F1f+cF275bctsO7ip+MALuEiEhm6XS4PSI/VMqglhW2HOJutUpthGB7VmSVVV6wPjm9NT+5eQR2sWnVQOOSy3BjTHwwOXJqMGtZyyvetiyHI0CahaCCPK97BCc4N30mNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4TnwL8e302OeGu3LMGeH+f4Vbx4ULsswRUWS5OFeNU=;
 b=zX1UCXxF/k3lURFgxMS8hhUhslUXtLVq0Mpu5RSu2VgB7nDHtPOJrsO4bAWRSm/RsG1iJ0TB5fPvla41PUN/CrUF/tl6AXqjIVXSzRrlWBsIupYPnRbpGuV7Qtf+mzF2/AMPPW9VXTRkd+OOliBiB/GQHJYQ2f+wiFrkXYynzGzRHlFolxdCJbz2WtTAXCtdjqZnx3jWaAWKCGpvTVofbFQIZLOxkAnm/e4eFmJoPXay80N5R6RsrVvw85RBwrl8hxhQAXuLwADBpmD+QrDKWr05mejH/Hpki0lLM008lhVDzziGt43lZkmbyXoKFItD4aoAG3ivE+cudB/gPSgB3g==
Received: from PS2PR02CA0091.apcprd02.prod.outlook.com (2603:1096:300:5c::31)
 by SEZPR04MB8139.apcprd04.prod.outlook.com (2603:1096:101:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 08:20:58 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::d2) by PS2PR02CA0091.outlook.office365.com
 (2603:1096:300:5c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:20:57
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
Subject: [PATCH v2 01/10] ARM: dts: aspeed: yosemite4: add i2c-mux for all Server Board slots
Date: Tue,  1 Oct 2024 16:20:43 +0800
Message-Id: <20241001082053.3455836-2-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB8139:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26dba6d6-204a-479e-a801-08dce1f1fa2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wdjs4/tFaC0a3GSV1mWzS03/831Z5yBQVeT49ZLiL4njECHxjHzRMpYg/iQH?=
 =?us-ascii?Q?oGPMXVcrzE//vDRnJKuzXSDyh50qvjMatkt/iEpJmNwQCMDASP5odr9zMUSz?=
 =?us-ascii?Q?NzOwgsG0J4/WBZiCFzJqZQg24+fX4v6bP+8lJ08rN/31vtQcmw2rJo6reAgq?=
 =?us-ascii?Q?R2PK4knmeHvmjsQruLDi89EaFbJ5bCttw3p5+jciaZi8lswqb5AVcyt5yqSG?=
 =?us-ascii?Q?a6l3VitQZnXG1Mc/isvlJQCebXfWGXAi8JurtHYKGWdjFDKbcY4RHpcQH/Wt?=
 =?us-ascii?Q?9pNvAELpbOdiFFVi39HnlxYQeOHWqCJY2YjYI1iCBPQx0Uz1PCodgKIrbtp8?=
 =?us-ascii?Q?mzQNhJ9TeKBXQSvVQIOembvGoSpQhzafSpjYSHfyH2ogXrr95JydBlKRDXus?=
 =?us-ascii?Q?ktGbfqFX7qr0xr2kgNOM+7HcBWejEXiMTlZ41RqVNsVucq44SnN1BkChWuEO?=
 =?us-ascii?Q?6lJ/Q1sN5fwaMgbJM47GZ65RRVEGhytjvQa2597ytKpjAautHtTa587uINU2?=
 =?us-ascii?Q?xOTZ8uL7ZvXoL43g2l7JH3yJECVCsii+2mulaW5DfRU+znJW9AvrgV3cvbvt?=
 =?us-ascii?Q?dIx4b5gTU8sWHdAjVNn+UrTRuIei0OUmDrgLqzSv8IDeUYjeA3R1fZ7T//Nm?=
 =?us-ascii?Q?4u7AwpWOKZ4vaWQtnEUxC0t8AQum/QQOeRXjST82UHsLbeIF+GPlm0/G5bc0?=
 =?us-ascii?Q?y95mJf+dLpxIL9wi7GdhU2qLtTWTSN9tCrXl12Wt+3E44r5lEygSvdjVjVJQ?=
 =?us-ascii?Q?8peUvJXtvGfZZ/S+KvOW8qcoFfMFcchNUyFGJaMFBxpvkNsCpo0s8e4zx/B5?=
 =?us-ascii?Q?x5u0H4h9ZfjDdv5/XqKPYhEMmlJhontAK6b+dTD+e8ztfWjerDc62hGaXl8c?=
 =?us-ascii?Q?sAVTXslbKsYNkXIa54kWLllJ1y7hRySTILkkpr6t90mkkLfCu90cpantOdqB?=
 =?us-ascii?Q?WQNOgYmIwx2Y8wCHySkabVbg9/mW7LlKJCvPfA/0PsASU1quVEVW0XSvFQmU?=
 =?us-ascii?Q?uoXqDd5zQobDM0SYi65hRDrhuQZ/mlHijKy9X6zD2AjRUrJS0ldK6RDP0e8i?=
 =?us-ascii?Q?+EQEYts5VoSfyEAm133+/RoXNoHjPInByuNHBnutw77ETyO16MVvUaahI0js?=
 =?us-ascii?Q?0urOtFvUl0nHJlc4UtqWftBVPg2511Uccm+wak/JznJb83urKfKBDlkEFC9j?=
 =?us-ascii?Q?AW8tlx1aUnbBaA+qyvkqdpQGbGwyrhMKaUlJE7zGp4Qlb74ipU+1K4pLsJBq?=
 =?us-ascii?Q?y6kQn3aqrBdPpGoqSJ7PMdBmRBeMo9eToozvwlg0G3eMYrka7WkYnpM17R2b?=
 =?us-ascii?Q?VbEtXAaEV6MTOiY7f8eb5ShrTqdf8ZpSh7JPtMjxOga7YjlJEB8/spXCMBD2?=
 =?us-ascii?Q?j/DVh8w=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:20:57.7684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dba6d6-204a-479e-a801-08dce1f1fa2e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8139

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c mux to 8 slots of server board and add the io expanders and
eeprom for the slots.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 238 +++++++++++++++++-
 1 file changed, 234 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b6566e2ca274..dbc992a625b7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -18,6 +18,14 @@ aliases {
 		serial7 = &uart8;
 		serial8 = &uart9;
 
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -517,24 +525,246 @@ power-sensor@40 {
 };
 
 &i2c8 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
 		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux17: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux18: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux19: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
 &i2c9 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
 		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux20: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux21: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux22: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux23: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
-- 
2.25.1



Return-Path: <linux-kernel+bounces-295261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E41F959921
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F591C2190D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B61FE1AD;
	Wed, 21 Aug 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="wo3gB3Ra"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2083.outbound.protection.outlook.com [40.107.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755E1ACDF8;
	Wed, 21 Aug 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233373; cv=fail; b=UxtD6CmP44Ov/x1BbR5Hv3hlcS9bNN81+GG4mZb94mGEDv/bsPBUmycEYqfa9/fPEuJWWRzHmi8E+SMJisjp5F7h0EB6ZEwCcmz2f3vq1+mYC7gMDYXZiuDiO5xilPVa7u4ED4riBasCi948BaAZqZ4hm38DrG+QA0P4TSELvdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233373; c=relaxed/simple;
	bh=cikm2FC6auBIaOh1vJuCHO/icFMbB2u/ZGK8PRDbfM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/chj2s1bvTCl36+vJj9MZsn+SVJwSXB9dhhU1UepOr1zk3nYzkJ5gmbVZMfKOo00wQ3DZ+ENRxFL5UYnXNZ5hw2CSuFqRp661f0p1SJoiIxg8WosBgw0MK3peKc2UIfvaYb85sgvKwhi7SFx6g6gWrVddxwyx5/IM9Kr8jK5o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=wo3gB3Ra; arc=fail smtp.client-ip=40.107.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEVAA5m0OHmvXXTBnUlmvwL0Sf1xL6svk0jU7AhXxzH7nSzt2GAFzfi43JzCrqDTTQlHfEkjdpMKWS+aMRHW7yRnJudl//j8nJcZ+CtLWkYx9Y5Zzv7ZWIqk0SREqg6Z3CGzu/8gtN4krPV9OdpxwVYUoMUA2As1H2vFh9bt8WB/OM10ywcVpQQ7PebCTpjv57SVED4NblOhUirzBWUjne88YXKyWrrmlqz3ATHnCzzdifg+XU1NbL3clSJ9jJ6I3BV1jh1wprEHLdoZmInlB8BDdhhMB4HNyXPZG7DKcq3T7032SBqjY5vjgNxRm5JMdPFawhJLt6Fqu8tOYjauaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=X5mrpToIRs8guGjnRzgcZ9th1uJ2jBKueI6OQbFLmtqJzJWp0r+ilMOA5QfKIiZ5hpgIBpfYuY3OLavj9pMTtnrIbvFOmm64Na+fHKDj+LhYq7js3Lh7OE9HrX4a9gHCdY3xhxE2OBoLeboQGUqtU09goVqc4+1YarHJUE37bZNHmMbnv6lWt3bIQ31xm7PC/9XnveRqL/py1k7i+p79nOO+u9rEVqXGQEJ5uiVuRrVanv2y1sNJ7ylm99T0UFmMqNRVwtu+RTcFVyjWE3w9vrtJuR+H/jaVUwMDTvKwC4sCd5FsItCXz6DdZQGcG65qhtFDbnBvXqPinjfxV5//1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=wo3gB3Raf5nPST4vBebGYv37AuMcsBYjipyQjHePvgGpF4WkuZoFmsyLWrsN7XuM4AYqmhyXQtIR++4h1JjyC2gurm0UR9ki+74ZrBIru21Aju6YZWffJb7XUk6v177fbmWR4KoWTtBmxqv3qDyNMgzCzwwuZomhWOsD19+m6kU6jc3l18un/23fvB6qlcUpAF9MX3BTKywwDVPAJ4Ej8DlegzbQ7C7rRl/l19qcRSl1I5nwCfnGDM77FP544XCp1QJPb6RgUWRDIzlXzIeJ72RlLDlz9L5ztL/6plS0w+FYkcFWddLTkvx8yH212I44KsO3s7ZkrlrR2SZ7f2MC/g==
Received: from SI2PR02CA0032.apcprd02.prod.outlook.com (2603:1096:4:195::12)
 by TYZPR04MB6954.apcprd04.prod.outlook.com (2603:1096:400:333::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:42:48 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::50) by SI2PR02CA0032.outlook.office365.com
 (2603:1096:4:195::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:47 +0000
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
Subject: [PATCH v13 19/29] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Wed, 21 Aug 2024 17:40:30 +0800
Message-Id: <20240821094043.4126132-20-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR04MB6954:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34a711c1-9a05-4a36-d200-08dcc1c59db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DFjqefbiJZSuSDlN9KR0RR/wp+5olDYBZ2thScBjkwRunybGkharVPaDJuqQ?=
 =?us-ascii?Q?7wu3fwRlxFextovym6+vk6pKyXBB3BIwE6a0BpppYQejYuooBnOOMLfgdRZJ?=
 =?us-ascii?Q?C68D8nOXD+/nLQJ3zGtJlHbUGDJDTujUiROirKP6xTqyHEGcQSCl6WR56tuk?=
 =?us-ascii?Q?p3Hd5fLMgX5ukkyD7Reqk8VhMe1hUIWkGa+rmJ8zWd3hVOuudtRMJHclhq+m?=
 =?us-ascii?Q?FFkfqYhGSpAGMbiaXLnj4if4bn3VDDVeH8yydlcVVk/yWxAflr98gE2B8jKl?=
 =?us-ascii?Q?XR8rsq/iQ48Hdj86bBvgUY2IsZQGFg3w7l1oyX7Lw2FIgpfY3msMaYo1CGRR?=
 =?us-ascii?Q?NgDAIdThm6jbi5/QPd8BmbyaHhKGgGEAJHAKMcR7uQSWVMVWKmUo2XzE+k9R?=
 =?us-ascii?Q?b3qBRRbgrSHDzUAPhw8gkQHvWWm8BPcSGuhUONauhyq35Mimn+XBBB7XrYCp?=
 =?us-ascii?Q?ew8naSl9yP+GOj2WhKh/WXyErVNZoxHocCwMvy70cM+XRJKK6x9L4+5XGKqN?=
 =?us-ascii?Q?nRtIuH5bU5YNjKcXPznXMk5GmfrjAVBf5MVUxpRQ/B5rjEvK6qbWqcDGaVxf?=
 =?us-ascii?Q?KSj7sk6qktNepw3d66rZXoabNlVi4QuaWBvljxLob6WemiT0Ns7mtbiwAMdL?=
 =?us-ascii?Q?Jy9M5aRzVAFmYcbbbYU5aJ0sIhtiquTSUb5fmReArg9oXt/M1T5HcYei4DdW?=
 =?us-ascii?Q?uYaH7XOiNTxlY6j1UKG2MR9/Jr9SU7G767uV77+aFakVKOpVDm4ODv2lFB78?=
 =?us-ascii?Q?3gwh9skCTxJYnGKLTDRCFkkL9TUmxlUtCFqeeM7KgDa1QfuU7Ua3st3Sz8/t?=
 =?us-ascii?Q?NhTKkMFlmlTPdPeYdCSK7D/wN3IoRZCcJNeudK+YFqc/uBbJhUPTAvbObDN6?=
 =?us-ascii?Q?WGdeKM3LTRuZYijb96ytQCjl8oNWwD8oGUfgrIc7ZeFQTwg7tdoqV7/+VOuv?=
 =?us-ascii?Q?utPtMLh1beEXzeQLj24kyDuUa5dty+SG2yxlnpcDjrpTiiWjZf7tO+rw8YXB?=
 =?us-ascii?Q?8MSTf4gl+jiJAZEzyR99Z+TDlttaGpRJkAQ7FK2yid9f9eOop9JvCamFWpfu?=
 =?us-ascii?Q?h8uYlQpxaqG5szpK9/jQCzJu8zvPBDCtrGeretLoFmWNipS+Wu2cAduLpCWJ?=
 =?us-ascii?Q?ekPK7Y/SK9c92g2zC231/fNzv1QID8fYFjLd4kDWl4qZ9hcTTSqc4xPiA6sK?=
 =?us-ascii?Q?abNrORBmfu6ytNX+pr/BdQye9MNwvcPE5C80of7fuQnZUdXE+X/TSlPuftCq?=
 =?us-ascii?Q?9brKTOGR3jvFEZ/04jJJ4OQ1F2bFW9RKP2ExuUVxYt7Pv5pL3P71PRe3nPvj?=
 =?us-ascii?Q?ebP/DGiQ0DdwilR9B8ZDDORZikS2dbYRm3rtjU9DDE+b3hZ+vy9xG1ubMkPG?=
 =?us-ascii?Q?AZoTkkMjL2org+taMvLnWaGnWdBEf9CYs4222GJdTAZ1TbqFKrIsP40rnyGa?=
 =?us-ascii?Q?g7+PY7SJfxBWFL0hHVyr0t0EiaLayLEe?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:47.1378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a711c1-9a05-4a36-d200-08dcc1c59db0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6954

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7b8a2384d99d..98eeee49b082 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -36,6 +36,10 @@ aliases {
 		i2c31 = &imux31;
 		i2c32 = &imux32;
 		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -951,24 +955,54 @@ &i2c12 {
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor@48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x70>;
 
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			rtc@6f {
+				compatible = "nuvoton,nct3018y";
+				reg = <0x6f>;
+			};
+		};
+
+		imux35: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux36: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux37: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
-- 
2.25.1



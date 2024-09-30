Return-Path: <linux-kernel+bounces-343442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE8F989AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222EAB21FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF1155738;
	Mon, 30 Sep 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="b1iOi69F"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DC1547DB;
	Mon, 30 Sep 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679921; cv=fail; b=erUIo1EEYBdCzgPED+wYo4g47ZVzHsBoJQWDpKasf1ixir4XU7UKZ3r39spOfpkYk9IfbV4aCmI/aFo+QVK1eMMSKyCuk9RBC1Nt2hz7cKtBtvLJyUdTLsebezrUmS3tSukuND2mqVnUV/NVzSJpwFPtSpM8QMLQxDN0Rw0tT4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679921; c=relaxed/simple;
	bh=1LvMo3He5RNtNM5CxTw6nJ5ILjpxrNim+jJ0pLDiNqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ejlokx7U0cb2IliWZ95iQ3dld1mD3Z0jBdLrtjMmIF+7WeUFGVTS8QTE5TMns5MHkL9WnylwSY6cR5NLRicf73pGR9t9VSIxfp1aPCELAOBevJRQE43eYMzlvDSiOjHrazBvH7E1Doy1Q/U0x8+MnEWz7WcuY8uAUCgPac5Z4j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=b1iOi69F; arc=fail smtp.client-ip=40.107.215.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jax3CpBfOMYrewiAmxRT9Mv6eNpodq+S7tRFw4znRqPDk7bFFLEQ+IeivhLgPGYGgpSo7+v4GSroulUq1DHkDv7eYRLpcEfIw1XBfBTxZc9K2tbPvQbf9sjsmfmD456+ie1W4J+aphRShufYj7c25upo0fBuKk1Nlu3d2kz3UMYakbYpvbSFiqhxiyYus17je0xK1VpZ8+RGUm3xpwDfBRDYuCnD2eGpA0mHYePf08o4dV3diePdTWCIKPUweWrSvugyEDyfaJV0hqpzeC89uWbXxMpScCPRtCagM1IZI1HfOpgNdE9ejKYu+89azomWXybqgiQInL+a3LjPFehsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUtJNp7JnJVBjateeIMFt9NVSk9vKIdUSLKphIGiMNc=;
 b=WvOFlLTcNsL8wArMvda/QWN+XiAaUIhPEYDbxM5rBv3tnEpQWk9ldIfqxc4vjm4BDUlz8nzPqm8RQ5TTTdH7l16xZTBMsWwqLqY2ZzmbxK4bMoLpiDfi6J36W4B5pkH0vAxIQ8D1E4m0Zz4+3vwqeZsVQGcIRdahFk8RlSBs0/m3nbkJMXoc1IlZsu9BuXLdfwVi/OOgpXscKHt+JiyCSZcIdbnoZgEjmpG49M3MoO/1MMYjDMvYDU5/dLN9Odn4zqQuikawCjsChyiGRGAVvqNkwWVHrByuwL6rZNqmHpnuohPcs3Fe9hbDiMKfV2mCEHFxzEmXuuxJ80eajicS0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUtJNp7JnJVBjateeIMFt9NVSk9vKIdUSLKphIGiMNc=;
 b=b1iOi69FBfjZdDuwsJipxn1khQbaz9jM2vAcTAjgFYKMeuV/aU4DXdqjLr+y6wbXE6Udc4F1yCna02o6B4+KzqI5yJflO7GWVCHVvA3CflqzgP3EexbRSN8z1hJZ0ipnHYzEjkkTFIkM22rQQYqWp12m491XMybK571dw8eobD1eaq14bsByy6FOu4bbtbqGqOs0UUs2MbRLyusBi574XqqtVjyduwgoDtYaw4rHOgySq49ZFE7wBSiGWTZz3Ct5KaLUacKUvv82QWn7UV1b/QflEY2kJ6p91chXy0HkKln0pQ4q9UXD5lh+9Hpr4V5cPmHo/FIQfxecR2kgWr4rGg==
Received: from SI1PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:1f5::17)
 by SEYPR04MB7332.apcprd04.prod.outlook.com (2603:1096:101:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Mon, 30 Sep
 2024 07:05:13 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::43) by SI1PR02CA0060.outlook.office365.com
 (2603:1096:4:1f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 30 Sep 2024 07:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024
 07:05:12 +0000
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
Subject: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
Date: Mon, 30 Sep 2024 15:04:53 +0800
Message-Id: <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|SEYPR04MB7332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ef01137-1f0c-4d78-89a1-08dce11e3ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HPg+2fiJOF/WtJ80gDRYtcFocb11KI42b4VJHwk7U1leyljs/kwLH3J24BRp?=
 =?us-ascii?Q?0UiG7m0bJcEO5aeLqLc5WTsl6pJOlvs0HLJNHa3oILi0zyL6ObGhgh2wDwOS?=
 =?us-ascii?Q?J29pqQxpSyrTTTkelhHrFkJFvbNdrLf5KKREhkdSRvPLI3cv+4zBwtOVXFw9?=
 =?us-ascii?Q?CcWx+OyDQCrdBaMviXf/1+AvaiRVzw2wCRKh6BNNLjrU9Z97M/dXcu6vgCdL?=
 =?us-ascii?Q?abuW2bHfO6IkecV7ehI0f9vSVdNX5DvHW+fKZkQlkwONuNKNxHmohmDZIvOQ?=
 =?us-ascii?Q?OpA1TrPEWabmIqy95uAnGFV1phMnx+xYUTXdZ85OdT3KoIhcrpFHzd8ecpPU?=
 =?us-ascii?Q?bxjISYZzT+CBOfUXJMhU4VHxGGJnAcklhljq81qNEdZMw9QvlowVqwYG08qF?=
 =?us-ascii?Q?WhjGKO1Hw2u/eigwgOlrnpZ2Qy19UtNb81HFW94NOh3mOdCfRI6ucmByMwiW?=
 =?us-ascii?Q?o1FEoHGdd/TBnXz4aNRyIrwQQFufCEKhQiJXnwqHT0KDOfl9KaHgWVk/mw4H?=
 =?us-ascii?Q?LtoMsut+IrbStfUqDcNd0cpwecmf+t41ntXRxDz7JjriQJ99sEW8kvutKHk2?=
 =?us-ascii?Q?ouDRcqNosESoCSuLlUmmQcrYSIZZTO4nz6z1Dtv9M0auA8TbwL7JuPXVe2+S?=
 =?us-ascii?Q?CDxsMiDE1/Yr55jV7hXVi+KBsC871AArTTtkDRhZ0wYhWrGyAIPCq2QtLqvX?=
 =?us-ascii?Q?wujJDF/8D7KirXk3hQiiMTonnCiADjp8b7JSLxJw0HIx0I6vXmsKV8jNyBIU?=
 =?us-ascii?Q?765HhCKj42eCEuHc7CSgsl5E6ECtnn0Ej5NhVPbsjmo4EyrFcTGZ3GWI6aHn?=
 =?us-ascii?Q?ICL7t+Za+Rbqj4c0yCfRu3EuOzfN7XDUdFZFRX1cH6gyJ74iOwbCN6ElGZeU?=
 =?us-ascii?Q?IqMSammr59en1zgHN2bSCctuHvJabcX1/NxOyxQ1bteUvHpzlnLR/v52q69K?=
 =?us-ascii?Q?TnAdMiKj4DufM14RSi7w1jLP0M+MZ1WoVLRY0e4cqPp2iVZep9bIkrgYlomc?=
 =?us-ascii?Q?zw2UW+nXO/Fbmu+fix5wmQQjsL7jzviSwvbDzDz0Dn3AMnG5hrjeLgEvKiit?=
 =?us-ascii?Q?RxxES/omrd/k3r+ULIp1MIa4HPewEkxXnWtpR6cTcmjd9R04tlwRs2enWrV9?=
 =?us-ascii?Q?wcUjtBWCmNVFuHpFMu44KV3lQUKZWH7LoOnanNmQ1LCbVPjoDxniyUbpkhXC?=
 =?us-ascii?Q?v92VNrfyvOgIYlISAo6HCHqg73x/WT93V34JVq0kH6AwKP2gmz9toM+0t6D7?=
 =?us-ascii?Q?ckEwBwXMLdAc78Se+yQwzhYet20I1JApnZ+bwVJwT0XlA5K2yeiBzKxGTlOr?=
 =?us-ascii?Q?S63KF0ubZGrGR8XY64MmXh/e6xOPRpIgadP660Bsl4B1CQ/v9xi0ErbltIwu?=
 =?us-ascii?Q?quzVPvC9c5I0b5w+XEZEYmS/Qv9QPU2kLpkOTNUrsjJIVHkem2yx/3nqBGup?=
 =?us-ascii?Q?mb1xl9br9x5cRxCb/aReovk6Pnz9K95k?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 07:05:12.5561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef01137-1f0c-4d78-89a1-08dce11e3ada
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7332

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c-mux on Spider board for four NICs and add the temperature sensor
and EEPROM for the NICs.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 75 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dbc992a625b7..b813140b3c5b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -26,6 +26,10 @@ aliases {
 		i2c21 = &imux21;
 		i2c22 = &imux22;
 		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -1196,8 +1200,9 @@ adc@35 {
 };
 
 &i2c15 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -1208,9 +1213,73 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux24: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux25: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux26: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux27: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
 	};
 };
 
-- 
2.25.1



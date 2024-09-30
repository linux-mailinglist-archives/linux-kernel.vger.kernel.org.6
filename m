Return-Path: <linux-kernel+bounces-343441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22C989AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5317A1F218F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D72A481A3;
	Mon, 30 Sep 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="t8usJxHf"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2068.outbound.protection.outlook.com [40.107.255.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672329CE8;
	Mon, 30 Sep 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679919; cv=fail; b=EaHUpDyaVeoSXkhe2abFnvpUO7744RTs5yazKFEN5M9KLYkd5F/52j5ISuo6zPNgHOjBBf8LgP9MkqTv8l/Wg+FQq7Iviggor3f4Dbq5HgvU5uHybLcBE2tfUzRrk6w5iM40gJTcXkeq3q+VF+tq4ABFiwbrFfK7awKp5WwCdzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679919; c=relaxed/simple;
	bh=SYU92OKfkk5hgHfIVa5x7kCsTnmZWZVDSJSDZSujxjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xul8bsO1yDHl4hpdqWfTYjM8Lnb2qjIkZra5gvuCiS0geTOb6u8gh5SFMnUajVcoriUVDy3ZWSisngnNCALr/bY0EeCuUhHu6+Tf88jXr0MVbsfHMrAUX+Xq0K7SSghxWvgLkSAvw/JCWpnXNgcOWk/AZk84UVwn0P+N2YGlb9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=t8usJxHf; arc=fail smtp.client-ip=40.107.255.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7BqMBdP5+tAIquhllM5BntR2VmTTeCfniAyyucTkpXAGojevltuopCIFj7dcG6Sb5Wp/h2MlFEmFAobVmObjYQVlWsg4V9th4yVzHh7MgkaG1kTKVF3LGvLHOuDA9kt0nijJc7AKPBaj83qEzBO6cZuDhniXS64hRDW1PNWRKbDymKtALE9e2Hc4mod8iFoIFqvm5HY/oqk3k23AySB1JpjvaghYip04l9pFEEYlEF59Vg532M8ofvlE5EaVDqEG4ZsBrraa7///7hHWn+dgbBvSxLfHshGGkAZgPl2YHd3Aj2xhuraJ1JH83FwYoBjMoI0470JBB9HFC+d30mzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4TnwL8e302OeGu3LMGeH+f4Vbx4ULsswRUWS5OFeNU=;
 b=gAmJ3gfwr8ia4pjHYsw71GQA+6ESinu2w3eomboo3Zffu+D7IkrvEHoaSM6bOwZ4R13SeJ4hCR4f/J9x9bv4bby8hUDATTCnnaoombVRspItS6uPHV1jMXxlvyNM0TCMFK+3vMVGNm6NnmvIilLkzA5a/cBvs7jsjS9PLCxYjyV5IEDTHFhdHyxQEiPPKktimoo3aBAPngVgvAY9qaDE05TGAexyfP7keXLlax2PBDRXfXid5NpvMnTNscuKqehkfwpasUhL/tFaAdFWzKaLdkmMFRfhObCzU9oegjSk6HScFk9rhbc+Rvr6/Yf4KF0PnbZws9hWxgT+RSpI6L3QtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4TnwL8e302OeGu3LMGeH+f4Vbx4ULsswRUWS5OFeNU=;
 b=t8usJxHfDkGBy9i+sA4pFbJkQGX7Kc3WltTEMIKc/f0QKjDtUTTVHs9eUHk6+XV0P+D8uflt2XHRtO/9/sYFKo5HLJsKRflplUIICRsDcJKveb8x7bzCTIRdVRDkw/l6qt+oKHyne5vqgsWUxG7zNgP828gFpixp+BUFW+Jc/pwI7+7aKrBAK543qPmyoKvdkuFjEIYnj914RjnzM2shfWDKGeYBCxtgdCRJF6nxkQVvDmXs5aySogCeoSl83GQ67laByvYgny+zHiDNBp5c7rYFtfN6u9vkkYUy6z175rVTcYkIAC0WYX28VTNf1qfNoQnh3d6IqtYyjouuF9NVwQ==
Received: from SI1PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:1f5::12)
 by SEZPR04MB7356.apcprd04.prod.outlook.com (2603:1096:101:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Mon, 30 Sep
 2024 07:05:07 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::a1) by SI1PR02CA0050.outlook.office365.com
 (2603:1096:4:1f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 30 Sep 2024 07:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024
 07:05:05 +0000
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
Subject: [PATCH v1 1/8] ARM: dts: aspeed: yosemite4: add i2c-mux for all Server Board slots
Date: Mon, 30 Sep 2024 15:04:52 +0800
Message-Id: <20240930070500.3174431-2-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|SEZPR04MB7356:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d8940809-404c-4993-e3c0-08dce11e3685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tG7o3VmMopb8iWjiqi/2PEZK/rJBgiBtwElDykvhUkGk6kfIzEmpf2wgKDUL?=
 =?us-ascii?Q?kynaVqVfAXxTE3iRiU9FfSUlQ+FL1W1Oxwixx1oc3D7Pv185scQ9arXPlVlH?=
 =?us-ascii?Q?bsxYWt7CeJEEFgEauzmq9S7AEXDsdbnCIef6DAfSP/o2QzGKW1PlM6u9easl?=
 =?us-ascii?Q?ThuA9GcAZhlSEtxba7budiRkZgitn09ZudQ7rn7Qiy+UTzToBp4W95LXN66g?=
 =?us-ascii?Q?YG514Z+riI2nTGvBb/R8NxMVoOTugEFHjIg9fOzu9pDbjDNGTkqFb3xjNLoE?=
 =?us-ascii?Q?495uIUrKsc0JtI93i9Uk8tYrGP/4BpMtkS/f2SX/nPQKa30y2C9pH5X7f9GA?=
 =?us-ascii?Q?voIjgFQjPxsbnjHjCH7ueqawUZPdx8Axu0PUX0ZpykT2GG6vF0nEQL3xVoBL?=
 =?us-ascii?Q?z2CALskIHBDA0e7TKAOnkYw1oUoI4Z99xAJJmUxn+68sbeRUorA5fix0saG7?=
 =?us-ascii?Q?yquj7Ypjz42CBQ0FWpMrvTjL5VseoeU/giVAAU9v4RuUk082OEhce+x0BFot?=
 =?us-ascii?Q?KrLCZfjT86E+wCstD6JYqBhptKEx7JY1US26ZWJhVOjVGWEiuOE16TXoRae8?=
 =?us-ascii?Q?4Ysdkxs+4Vt1Y+M4twlrXUQ4EJmfiMAlhPt3ZtozF5a7XbuDEJMXf5PuLtDT?=
 =?us-ascii?Q?VOXvOjqWJUvOD8fmMYFSkAADkdMUtzZ/b+jbH4wJYz9jNp5Mgm+5cmDCQNXo?=
 =?us-ascii?Q?ecF+s9l5twvCKFKa7YKpleNKv5YR9Mt9HnTGF8wWhEnzVi6iTXPwsv8D3iTi?=
 =?us-ascii?Q?zFh5hmwUGdgpTKIQkMBB+y7A7WD0mNwQSVzJAJlIZ2VHZ4q+CYGlpWPdT+o9?=
 =?us-ascii?Q?8axaxupAeIdK2ZO9AzDofqbMG1lZMrlpe6fvZ2mPK2CYe/+Ydb3+NHdjtnkJ?=
 =?us-ascii?Q?edPq4/Z+wfHCOYuzHIkJRXZIQsfME202ad/uDtyhrBIm5CAPQS/9Eu+Iw3qG?=
 =?us-ascii?Q?3GAN/Vb2z2wM/Bl5pZIGjx8050VHoFW4Gm3wa3bpNHDR7v3MY3Pf9fsLkax0?=
 =?us-ascii?Q?gAIVtQKYpCJCbS1T0YyVEQ0PojhCamKneQ7sgHgqb/P0uptlLlds4XGDsANp?=
 =?us-ascii?Q?mpX64YYlG6wmrQfUOMMrNNHJg8UokNrqCANolqJsOV2qbzmojbTuVDMHXo0v?=
 =?us-ascii?Q?C80L+YSA6ucLItHU8JMf10XseVOAiOMS+Udg+LUlIGEgcCgYkSwBdiQXvq7k?=
 =?us-ascii?Q?AjhQTo5F4yTIiE+vsQkUnxTKMyrPWzhg9keHU2DQ6IgMtAD98VPKmqYSyeJc?=
 =?us-ascii?Q?DI+PizNxcQXs5s15jiG7OuIv3T1WVMp11YkY1zZYvpLmEIFv3txvhoRH1ehA?=
 =?us-ascii?Q?JCssxjbdja8ep4Bn3McMZgJCe9GMr/37W5ZTFqsx4nRlIHvCunq1jwyP3MFx?=
 =?us-ascii?Q?LWRELAo=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 07:05:05.2905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8940809-404c-4993-e3c0-08dce11e3685
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7356

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



Return-Path: <linux-kernel+bounces-187146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB0E8CCDBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D26283374
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEECF13CFBA;
	Thu, 23 May 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NklGK4U/"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010000.outbound.protection.outlook.com [52.101.128.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97B13CF9F;
	Thu, 23 May 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451441; cv=fail; b=tCmQNS1X7CKSTv4hjHyHPgCx7HqUL9poJUxhJOG9peqP9dp5FZu1W4GPMOJ7AFskaZLE3TUVOq8W09mCEA6+r5sjnCtJ2WoAX6g7rEZjxnUiwToMTOCAj/La2R+BdQdv+qifWu3UfaJZ+ZeKHWd+8E+Z7/uQ6PK2b8GUqLDUmXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451441; c=relaxed/simple;
	bh=qye1+odmSLvcZWpLGZXShZcJWroDKnJ7ydMvngFvmyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0QaTzr2D/TjVOcHWusgjOO3BJyLgVUNa1epyo/h25VxkUMRLaAFk9YgeN/8KATe5kYq6X2fDKWc1Td2uG6xyMy5QhhLSLIsHJx+pbb2Ead5a+GPmZNPBjvkzZrfWbKYuAoJovn2heEqFu5VCm8YoG2a6BKFAljmEb/9che3g2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NklGK4U/; arc=fail smtp.client-ip=52.101.128.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/8HWgf5Yo8a0Qaoml/v3ixUIEVp3gnf1P05ygKgmlp4PNEWEIkgbQEoKslo94O4pS9wv0IDH94cTY90TB5yIC5XHOjrmRv0ct0s3msOsJa+p5QJozhXbCQD6UACZ9kZ8ed2zr72RdMkxPNAOm1vZjrZI1fOYPSBvTUgXKtcwiFmTTlv8kOLpaDCMbhqryguslZ/uhCkAa41D1FuH2/D0ONgfSbYITjlR7M8J6P3xh/8b50nD8lzXMIVpE9tXj387i8SybWQVui6pRoylkTbw7ePGcvkdjXJllub7Vetu56GhZ1djfEtHcoDrDii6zoD54j+zISu3TBtcvdwLyQGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF4Vr+mnAo6sL4NqnPknKFu4wSGhcaCxskXcr5n8QwA=;
 b=V82DGAiUeq+G14tiMLvNY/8iht4IXhbqCBzY+C6jWBGK5b5ghsMs1DB/qKW636efl4shUhs38MmO6GYUKC5Vr5j3BPSKjoiK0PNRUU7o13q5Ou/yitqD6nvIuC2krlHa+lvKoIginEg18hizRKwkacFxKm6c4NRWvU4PsCdvXkw/5ijy+H9qkitoMyOI2oubNzA9QxBtAGkTahm/S/xECip/knskvuGcdNvcyKTPmCNNgr55PJe2FxfoIA47dAgOx+GtdYEIQdx2f5g2XGY/NoMHa0Q/urquYYpDTSUV0EHNbZblblXF3T7lUde/xUMbxIyFyXZnrcGzssv29VEr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF4Vr+mnAo6sL4NqnPknKFu4wSGhcaCxskXcr5n8QwA=;
 b=NklGK4U/knsSN+2Clqd12/vu6xBn//i+vojTl0vXkeRBuANyWJL0NOKnfqaZ7g+YYFmIxFuFY+2Xlj89k6C44quEyZ8tkAPiOT0Kfk5upz/Dx7RwOYo7WmAKH9foTOGX6XwDdQBcyKPiDRSagX1qLMeTuLdMkp6HjSfqL1pVsYPjmpUfeOcVgHenW8iTMmI/kVw6RKQDPkSY1Ja7oeq2mxuneGM9vx4NADjhcsPNbi7YLMUpa5XlVXgE8roTcP22P1NBnxyFJI68YJl1fsqnk3geK/klV3E7toiW4bBcuZkuqUF/DwKYjdQYyV36Ps0krc3+FWLS8h0GXXgOpg1otQ==
Received: from SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29) by
 JH0PR04MB7250.apcprd04.prod.outlook.com (2603:1096:990:3e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Thu, 23 May 2024 08:03:55 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::84) by SG2PR04CA0167.outlook.office365.com
 (2603:1096:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:03:55 +0000
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
Subject: [PATCH v8 01/23] ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
Date: Thu, 23 May 2024 16:03:06 +0800
Message-Id: <20240523080330.1860074-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|JH0PR04MB7250:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f0ce14ad-864c-4390-3ef7-08dc7afee4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?khR6qEITg0UXIbH+ai+WiL+TmNwjGXLzDIOebQ/yzSgS+k3hAff+jq39ucK8?=
 =?us-ascii?Q?GYjOX2R450NoPEeGZ1mI+w+e8CrSSxI7u6z7n55tx3ad9UsG3cT2vq0cx9h/?=
 =?us-ascii?Q?Mbys6wqKpAAMF19eOyEI+mUStlFjentOD5xtzsd8n3XnkgX4XvUC6GLus0+G?=
 =?us-ascii?Q?BVDvwuoc1ZP+Pq2EJXOFjfPZghx+TdRngYW6Rs0CSLQtEfwJ0kfHy3d5uGyv?=
 =?us-ascii?Q?Noj0uU7p4b3YgaVabjASGhbXPppa7NFlrIRvvztkb9z9eN/oAGnYe5zJPZpu?=
 =?us-ascii?Q?3ifzvwOjlltz+nvwIJwHK+TA4cfNM561T9zvAr8Hhj/V9wceY1PN9umCtBtD?=
 =?us-ascii?Q?bnNFSXp0ZAvSTzHjs8D4xyjWSc8mm3JNknlaJk4/ygmpzViWzISjNcvC8UML?=
 =?us-ascii?Q?+IEcjQ6mNMl7vB9BwSBoIrKaoUstVaW9q/wJkAtdCjgaPCLv4P1GQ3AUTFJh?=
 =?us-ascii?Q?qHQj5u4yoL0DS6VzNr23sY+Ijfryj1jMKA356zhXPi769laDUb2ga32escYo?=
 =?us-ascii?Q?Z86tfq7timePXzHI7UKRz0VWrK2Ebskeoim+YSt+exf1uIbdy1OomqlNiSmV?=
 =?us-ascii?Q?pQS8ez+9GTxq8J3/xfGYX6o7etwu+aO59pt3czHRHjpEj4U/nYU5LyYtPadw?=
 =?us-ascii?Q?fTxtiU8vqnBTp/xwzOKTca11oYAG0fZoIoWTgPYTLMQ6tZXglkXFYlbORjpv?=
 =?us-ascii?Q?fE04jzlTJydYdI9V/ndtviJCwQy5ao/arQcg1MwkSz+RaezBM9ONN8iFpGA7?=
 =?us-ascii?Q?ewB7C9TnRNY2U53JVWAE7AahLoIq0oFr7B2FfM9ZWl0qFFv4uJp0iaGRqoTP?=
 =?us-ascii?Q?vJf9mMVpS/XHmH246EIooU60tqbkMP+5K/63XwS/juyTWQxCtHRru+hJCC1J?=
 =?us-ascii?Q?Ss7QFs9PWGAFWTIwqlj/wDZldveIogXbx9QlcY2bFrsXEmBkDvj92FDeSprA?=
 =?us-ascii?Q?y2Elh6f+6K+FDpkkwVE84z640dw+Jpf8xBNAqYu7RkuKPp1UTJBHJtrHT7iG?=
 =?us-ascii?Q?H3lnpUYkVp79pWQ7Qlt4sTxwCNBt8rH8GC/SO/Fzq7tCCPQk7FoSVS/mVEQS?=
 =?us-ascii?Q?l0MmsdubCqiKjZlBPNTwIG5yn3l9v1oE3fa/P5kd94Uy325eXgso2zq7k3ZB?=
 =?us-ascii?Q?v/Np+BvFNc/dbs2vLE5ycne23dRKlW8564c9MqmL9rIGLDgh6BVM5Lx/j0Lq?=
 =?us-ascii?Q?4JFuDDyOFmaRNhQaetO8cAGrV6qThotn/OnraHfqf9ol+GfPPsE8QIfOAKir?=
 =?us-ascii?Q?ur3pWqMClKJ5SHL/MQjcHHh2yA7m+7rlK+lJ8nw8iFK0d6gcnr64oODf+sYP?=
 =?us-ascii?Q?2g3xVjfzDI0rmX67NpvNojUeAmtDIVNjE2jaqO4VDTBhpUNsei7plyol6EeH?=
 =?us-ascii?Q?fQ5gf7I=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:03:55.2339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ce14ad-864c-4390-3ef7-08dc7afee4d0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7250

Revise Yosemite 4 devicetree for devices behind i2c-mux
- Add gpio and eeprom behind i2c-mux
- Remove redundant idle-state setting for i2c-mux

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 381 ++++++++++++++++--
 1 file changed, 347 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..66855efa0b4b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,25 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
 	};
 
 	chosen {
@@ -259,9 +278,109 @@ &i2c8 {
 	bus-frequency = <400000>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x70>;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
 
@@ -270,15 +389,174 @@ &i2c9 {
 	bus-frequency = <400000>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x71>;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
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
 
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x74>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9506";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names =
+				"","","","",
+				"NIC0-MAIN-PWR-EN","NIC1-MAIN-PWR-EN",
+				"NIC2-MAIN-PWR-EN","NIC3-MAIN-PWR-EN",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
+			};
+		};
+
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
 };
 
 &i2c11 {
@@ -440,16 +718,14 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9846";
+	i2c-mux@74 {
+		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x74>;
 
-		i2c@0 {
+		imux30: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -457,26 +733,26 @@ i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -499,34 +775,34 @@ gpio@61 {
 			};
 		};
 
-		i2c@1 {
+		imux31: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -554,12 +830,10 @@ i2c-mux@73 {
 		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x73>;
 
-		i2c@0 {
+		imux32: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -570,10 +844,10 @@ adc@35 {
 			};
 		};
 
-		i2c@1 {
+		imux33: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@35 {
 				compatible = "maxim,max11617";
@@ -596,9 +870,48 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x72>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
 	};
 };
 
-- 
2.25.1



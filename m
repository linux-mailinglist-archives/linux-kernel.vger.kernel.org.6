Return-Path: <linux-kernel+bounces-187166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C58CCDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059DB283BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D714B945;
	Thu, 23 May 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Op0gQTWS"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2089.outbound.protection.outlook.com [40.107.117.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301113CF95;
	Thu, 23 May 2024 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451515; cv=fail; b=qMz57ziz5w6nlAKiz5XOseMSAomR4Ydovpf+Ix25Wl1pfeRHTeol8XeL33zuCtu4gnK9n1PFyBLJkrr28WZdZjqd9p/EbdXPfpgFB8YnRnafQzWEfDzKQj+p6W4mlUjLyEZSceknMuWvmInRDSeHyuGJGHtDCaf8uAMf+PzaK0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451515; c=relaxed/simple;
	bh=B/oZeUxM7Bov5AMZhp/ruSmD6wW9/+CYr54R4FGw1nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcjcLKIQGBSNPmxeU3CAEXVgu2laQPF7C83b6pE3Q+TmMGA56K8LT00V9lPDa+sOKY2Lr6+DFEevKxjnYDUsKWoZNlawKswagSMDt73CSZreBWxxOSMH1rAPaHDqOmWgg1KZ4CxaS8cCHjUMmMVCjz0naLrfBwXLdsPEmBYS+QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Op0gQTWS; arc=fail smtp.client-ip=40.107.117.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn4r1qHU8BOF6BRjvEPYD94QDEbRWSCHD5lWi//oPXjc3CmKY3/Ws+Uc9uFM5STUc1kEvyXsESI1n+QuO+XLmV2ZTF0mziDQNFcioX86RNzWwJfMHFOU3lT/2H+d80SH4wJf7qnQxHfaDNI1hXNeaYRIAZhq/kC673U18Q+AVJajG8cOsjPX2UZmtpmNHbvvwaJNdNTCormhQDFrtA/aYOdlVtJH+OJOET/Hp7NNbSJF8fIl4NO2Bk/y+L+1/9QS5ePkpBspMvDymIQhHSEAc8o8ZNRP2o+ck6rOU9t10V6sgoyP7BPeGAiTTVxcru2UAASgimaOSUwlFfvZuPrq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5nLOGzr+7KZfcZvwMsTgIEus1J7dxSLeXUDVhNOLW4=;
 b=jvy/oMV5t3LVGHsYY+r6JO8iisOxHQEIivcG05jo8Tr5EoVGEtszye+lXsy/X4lFJAyMUTWzHyvqfkBZIcoqZzKXVbflQhbSkgKhkNYw9QNKKMRENpWxDCKgvE9hKiBj1pE9dO41r/wORUnIpZ9mdQh+x6vbUFh5ekTAfIFvaX7TrUHMb90lPDv9z07hTd6VuhOvthPvZ/liiNce7bugCh23jOy6E0NupHnGPDEcKQzD2ffjtSjs5cQaMVaiobY54WbVIIuI3rdfyA7j2Z4wTvkzN/1YwzWTVjIRGcOl8T1rtv5s2zMehqlP7NwmmIm1YCOGRK2wp1K6726Vztiqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5nLOGzr+7KZfcZvwMsTgIEus1J7dxSLeXUDVhNOLW4=;
 b=Op0gQTWSyi7kAUt8ZfhPYgMN0J/uW/Jq+oBwrjb7ToKWm14TjyG8/DjrovFmf80NbkG/DVo9vmuypMBIeon/oMpVIJ1xAU9zaH6+FCjNuXuJ3W002JT9b5lhYEp8+mS2nBETZFsPB3m/+oH6UAogrX6VktE6U8pkvzN8al1UY/34rjJJ2Xh7HNZGWXWm+fvjGsJ0XWMxBqUxFbwosJQehbJQ1Tl3tmgfxnPp1f8XP3tIDAFyUIfVVE5Qw6IZ20Q2P2WoDpLksaeEsJ1qhoN6eHc30BDBUpRTqFM2PsFNrwD2GAajmw6kb8Jo0+Bi+0QVCvcif4c/5nPWeanMGefrkA==
Received: from SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32) by
 SI6PR04MB7956.apcprd04.prod.outlook.com (2603:1096:4:246::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Thu, 23 May 2024 08:05:09 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::b5) by SG2PR04CA0170.outlook.office365.com
 (2603:1096:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:05:08 +0000
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
Subject: [PATCH v8 21/23] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Thu, 23 May 2024 16:03:26 +0800
Message-Id: <20240523080330.1860074-22-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SI6PR04MB7956:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed0615d7-ed20-464d-cdbc-08dc7aff107b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|7416005|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8GoxVSaVouauDKA7CSYH/KK605nFAsFpBWDEf6FoxDTPzer4q1VrNrVQm1B?=
 =?us-ascii?Q?0S7cLopotnhNldM/d0tSiIwEhfi1x+oE6Tnfd/XRFGqgcOM2R2+HSxnQO5E+?=
 =?us-ascii?Q?VZXmFR6Cvfita5o/grST3uQ+MFOx9RV8156PVliahxFh3VHvuEqj//2xrQlN?=
 =?us-ascii?Q?Z5SwqOWIjFEGnfREevngWjpASQoILY88BVzkgcC1ieensPeOIfxqNMpslt+p?=
 =?us-ascii?Q?Mz6fLCmnTdrwNglKg1ifQhQQyt3Ji291SSXVQouqOF1AgebJw+W/KxmMpWJn?=
 =?us-ascii?Q?/ZOkzxOFOQx7ZkKEnErPX4vLWlQXG0UcHe9mQHwJtPy460jQO+CLOlh/WuLF?=
 =?us-ascii?Q?e9YIXOybyi2i5gWUQKLaeacagDY5IWdcmDQQ/WSYao8uPnu5vncBPDKhJupn?=
 =?us-ascii?Q?vP7tDC8tYACpi/UVfM3fWEXC77p6q/5B7qYtr2UypTew7F50y9Ux2Vgw5Ty3?=
 =?us-ascii?Q?Fd3UdZ2WWSh2FdlBppfis6UaNgikR72bwRvHrZ5sRv4snxUOWaRQyZiD9U9c?=
 =?us-ascii?Q?4yYKjmSLGdVUeP/3SyW5YAA8r+5WRZ0QiuNlT1A+ImqdrHagwmJJH1aBB1U/?=
 =?us-ascii?Q?3whdPp4cD6tbAUFATN0fxPXSw1ED2dhqXqdSPsMA1FQLGTwpLsQn3/sn166g?=
 =?us-ascii?Q?vokvgPEhERzpiBvDbxbVD9PCCVgOQvJ/D4EeUkdaaUCK/XkUx2+zSPBxdYT1?=
 =?us-ascii?Q?J2oQEbtgL1Xt+Y0mollciR1K9/MabAZa864Pk4PkM36UzaI/9GJaFHWgtcBp?=
 =?us-ascii?Q?QqswyXt3Sv3mU/67EulEFWXyIqIFjXJK0u2G2G/CLqSDe3lI/ehG4RC2ylOz?=
 =?us-ascii?Q?5GGnPr6r11LtSNeo98yXdy/lG3DscpHzJoh4Gl6KBU3CbV5w4tS9lfIfUB5i?=
 =?us-ascii?Q?gNv5bu3dny9brv7mU/WMn+XV0oSTNTjX2Nyo7rtQVfrG30NOfsGkaupPKR2S?=
 =?us-ascii?Q?pbO5nUflFFa4s55vcwtX6grlGE0ypbM/ykZg9uIvnnrPs1uMx3GXEI2U8Xvh?=
 =?us-ascii?Q?SPjRyPa8Veye2vGwviVA5H1v9yNZ7Dh3D4ezYcb4iLnFMVMRA1oe8F1PnUhp?=
 =?us-ascii?Q?0iYhDCEqLkh9YVKGWf9QCSJUGUjD7C5Hb0Sj2nJhf37Q8S97z5O+nXxCbc+v?=
 =?us-ascii?Q?6Mu3U7gIoT5b7d1QsloLu8ErZ7xgW8V769wu/Z7LDlTx0aB3JSxWg59CCRzx?=
 =?us-ascii?Q?XHeSZj/pptGJqE3YD5NfBZQy2uiN/rh1DgAEcYYgACyAc/dEQBf19Htr9VLm?=
 =?us-ascii?Q?aHtGHy/tFFTtsM1ItPkLVYvnoNpY6gc3IbdQvaAxk9Tm/iFecC/e6EEoPeQF?=
 =?us-ascii?Q?53BZJtzbHxO716uyJqXSNlMU+LCSaJoOdLFn8GDWCT2taZFwJGP8KK7Kkjyv?=
 =?us-ascii?Q?3r0mP+ml1HasIcU7lc3CCnw9YuQk?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:05:08.1722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0615d7-ed20-464d-cdbc-08dc7aff107b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7956

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bacaa2208734..62dfe935cbcd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1338,6 +1338,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
@@ -1354,6 +1359,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
@@ -1370,6 +1380,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
@@ -1386,6 +1401,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1



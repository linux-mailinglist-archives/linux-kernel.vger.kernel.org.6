Return-Path: <linux-kernel+bounces-345471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078A98B6B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FA21C2216C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954C19B3D7;
	Tue,  1 Oct 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="3RMrUrjS"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1D8199384;
	Tue,  1 Oct 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770869; cv=fail; b=Cb/HmmrnMJ8o73KV9llbtA/9Y+3nzsEuwp07JOmSS5ZUQT8wK25DkkYg8KombPH8Pxs1xgzhHXdnNntzkqb5yygOi7iZgx8+LbsCZyjO/FwlXxGj0F3lzQow41jEkRgc/o7fCjb6GHKETYDw5dspjNnKofAtQTE9/c+NIbJDpEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770869; c=relaxed/simple;
	bh=c2OXfTCU+KTq0kVh5bwQDKBlqQp9Uayh+okcD/v+b9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/Yc97shsn+3Gh5X87cT8cFRRXI3rGjQLlWRuGVy1P5xAVgsjvyjh7NiIGnqg8MpDcE372fjby2DBxrzGrEhBd+YT9RA7IhsbwU+SvYETKY5scrDGIGlYQ+6G4p659XgAKHEaLzaVCNNIBlsBgfNVQWBED9T1X/2FWRSK7r8GJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=3RMrUrjS; arc=fail smtp.client-ip=40.107.255.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIyU5d48J2CgrMVjW4YHOLPgAQZLoKHOX+ODn6NpCrzCYMp+g6umOWkRJ+N/1XrF9I0TNr9dncs2UPbMYLa8YFAaRgeRjWBFuQO7lj0eOgMDm8HYeiHLALOnBr7lcWUPcDFVuELV48XQbT+WSREEJIKyeujoi6b/sHpDA6BtahIO0OMpedCT4QWeL0dR/LoyKr2Fa80orDucTUxa4LHvqyd7wL4QaXILuSjMhqW532H2/UoYZh0FUSIr+Xiwf2LMJZKZOc4WZL1aK/jK9yT0A3lCNCrqvJ7cvRzLhojHWOr2W9Cnxr+XYoyz6kIvg20YNsRyeerOUL4JgLlXuBth/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhYTzX4RPmb9y+i3998259q/Da2L24KaCmKevldQmdc=;
 b=Q9p55LqS9FyAhE9GWl+gZqszfbEEVHrVULH+kYObpHfSlRkhj3YS44dlxpPlL8ivJ/eDOkc7oPdwfVjGvFZpkDxgmMV168BDiIIfbO1cqSrkfANSqrm+ovFlFELer4BnuEEJDrewQK/C65aKJPvEH+IYyVCVDoOiGnE6FXxmJJLDdNd72RHPxc63P5uz5++3yQ9MNidPHvE7hjPc3WkNhntzNjCPcbJ0gOQiY0pTFEd5IxvlQxjhKDj1Bf85wbQK8yZob//Ye3FWmt4Gr9IOaDuDy1odu55ia8xS26s66TY2y6md/aRnjKuZT1vqtFT5bMEhWkx4+RwyOl4lVvWLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhYTzX4RPmb9y+i3998259q/Da2L24KaCmKevldQmdc=;
 b=3RMrUrjSm/oS7sDCe5ccKkblRsvCLzHfeeeNmsmlKg5Y+rjnYzLFAR385X438DHqyPvmXnpWuhd2A52QSFHKWeUfUTSxDp/VlCxGVq07lgFlMunFTFzT3LG8xJZ+FWG6BennpLZb6Rr+mOpIEEE2g3SGwz5qLeql56YekPDzAngSOEwUQavBLmsJEZmSjYFckwjnmcLjJCAV8w/83jRUSwVL8d174aUhnZ8BpdMyi8ePeabyZgOK5/1Ng6Wg+VAnW/pr2U1dFbaeqsVCZSJLn2NmQ8BbGeMcL/bdat867K3dOVVPTKmZyaIUYzX8ae75dANKLGKP6Rcs6Nql1F3ODg==
Received: from PS2PR02CA0073.apcprd02.prod.outlook.com (2603:1096:300:5c::13)
 by TYZPR04MB5736.apcprd04.prod.outlook.com (2603:1096:400:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 08:21:03 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::19) by PS2PR02CA0073.outlook.office365.com
 (2603:1096:300:5c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:21:02
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
Subject: [PATCH v2 03/10] ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
Date: Tue,  1 Oct 2024 16:20:45 +0800
Message-Id: <20241001082053.3455836-4-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB5736:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce532714-6db7-41a0-6213-08dce1f1fcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R5mk/9wwNcS9UkAE+TMlnPVnImWgDw14q79DOd33WoYVw1NIlBsizE1BFh1o?=
 =?us-ascii?Q?HLSpnOMl7LaJG/i0oSh80ekQAjv4LWFyC9r2a9T8hZa1kVDewzEsbX9+O/pK?=
 =?us-ascii?Q?4yG80dMLLoQuzUVh3Mg38xyutNEhkNCXAZIQUDgW7AU1DM22dLGYV4k6Ys/O?=
 =?us-ascii?Q?RrDZNNU51Q3wAjWRFs3Faoc3f+oTcmfEBfTXaKOyDfioIh5lAA+xTYQQTugK?=
 =?us-ascii?Q?M8/6qRSDnUkTXSH385YMwJ6eHblUgplPDK8Ua5BDkrH/EqXB3ti3iEfRMo1V?=
 =?us-ascii?Q?T3Uf3Rl1CnLVFz1tNH0V6pQp+0gO5DgrTAx5JYfR/Spo0ZHWhnaBloplanXu?=
 =?us-ascii?Q?p1Rx9zNLMXqKuegyiaeZBZktVsl9HsAyP7hIApMO4s2hsIJJ4ti1s/9XDlSV?=
 =?us-ascii?Q?ZQlf5mfVzfhjpdxnFsoLg33McpHoYWD3989x+4nKbRh9jm9qwIyD6ZFE7Ygo?=
 =?us-ascii?Q?aeZXLfVmT0Di1jVjNoDPgduXMHp+mmO4ifcW5njmfOpoCW6ECeKbuqfew9cl?=
 =?us-ascii?Q?pCWeKTEz/zcMf+c7dBaik6QjSaVweFmS+TdNgm2/7OqNpYkSUiJoly3h2TWy?=
 =?us-ascii?Q?17GFURxmdahAQG2Ci3KRP1S/s7zeWffdFVIr+9rBZtBohY7NX84ZtsJYH8a9?=
 =?us-ascii?Q?a3Y+SQwXQ8lT2CB72Bvvp6BBGDDDcCi7AwbK58ex25NIW54eGEqO+XCCdxfs?=
 =?us-ascii?Q?PzhWoJ88Yg6ZwmM8QNQRTiipVNovLLtFH8UDEoZ2RxW9DX1DijtAhWoTBkpa?=
 =?us-ascii?Q?8tsbcKePBW9WoQAB609jXpIE0F+vjIpwENfsS2RBenHscW23e2IDVo4eWpJf?=
 =?us-ascii?Q?Rc4VED6GT5G5TU8ZNWf+SnfT/uU35NH31Kj+pVnLIfQDKyDdQfrScEl0J8+b?=
 =?us-ascii?Q?Hw6Tzn1+bol5UQOg7FFD+zVvk+w5ViTtEmfUxmhJkU5JwDik9atE1xH71JxD?=
 =?us-ascii?Q?P4w6qBbr/3f4SDqWCJGOEcRLD/AZ74sGWlYTim63vkPuDHEXPxdTl4NU/4dX?=
 =?us-ascii?Q?v4E7+HtufyrC8BKnxH2iCQoQ2k+lv5k7z67wsvUnD7u4YXs3EW+ckZIDRzg/?=
 =?us-ascii?Q?1+pdXaVQbWu9Qs2+eq7mUHxaC4h2livTI7Jf6putmagAvMopH4T1g98k8XNB?=
 =?us-ascii?Q?/bA6NIbr91zour8wQfL2IB/VNJ9VGwYIWcgYegW6qUK0lgA0/TmSINw2crHZ?=
 =?us-ascii?Q?l8Nz8EAf6Jqa58som4Hpn8+Fj15YUWOn7tRi3Ynqr/iaE2ADNB3TWoY+hJTi?=
 =?us-ascii?Q?K36Z211k2yOdvrfD3BRSwxBhKDN54cM7pwuOogRkX183VZdBOUJbqqLP7Eyp?=
 =?us-ascii?Q?LNltqzM4zv6Ngk3z/OpxvT1GgDwtET44TlQ3z1dT8iqfcRcqk55Xsv2O0fLY?=
 =?us-ascii?Q?3C94aEj8Y5QSAP/tPC1KMGXHf+ep5RTl8pVy0IxN1pKAT4hWRTYCbOfuGjEd?=
 =?us-ascii?Q?cL7NLpOjbEmh/4KeAd8uZ9ep1ZARQJRR?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:21:02.4247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce532714-6db7-41a0-6213-08dce1f1fcf0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5736

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c-mux on Spider board for four NICs and add the temperature sensor
and EEPROM for the NICs.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 74 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ad119e484bb4..b813140b3c5b 100644
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
@@ -1196,6 +1200,8 @@ adc@35 {
 };
 
 &i2c15 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	multi-master;
 	bus-frequency = <400000>;
@@ -1207,9 +1213,73 @@ mctp@10 {
 
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



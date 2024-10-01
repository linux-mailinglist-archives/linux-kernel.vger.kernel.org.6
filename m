Return-Path: <linux-kernel+bounces-345473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C698B6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145421F222E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E819CD01;
	Tue,  1 Oct 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="QhvdSsh1"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BB19C565;
	Tue,  1 Oct 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770873; cv=fail; b=ZHG5yvl6uTJuB47NE0woksZG5rUYWVUkMIaFohDc2GiYdkmvITGA7dFIUADYPzk7/IL9AhsRkeNdYmr/jUIJ+MgNaW2aZdHpxCpzdLyLVdUl8HuyRaAN4B4nVhcha1YmRQQJEcLq+fKySi0wpd/BVtg/zYe1zMQ4cuKR7nUQwGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770873; c=relaxed/simple;
	bh=HL0V5yOnLqxJXd6SimEot16We7CZxS3PIUa6J5H00J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3T08ppxbV74GjUgAvnLjwsnJPRKs7z5Yt9MV4CfXXTLMusOliHO9kEbJLPXHaSDYqFvW6hs0uR1g8Or8jgfmUbQlr9fk04lZA5jG0ciQF/yxAlSlkYvuLTA2VZCvjOeC9B697u7NorjTAFqut9VH1Zw9/jgI6z9xz45R8cJCnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=QhvdSsh1; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz9B7yaNY3/e6eaQ7rZJ26jrippH3H8oh7G1ek0tUQVjwP9b14crd074LhoFjac5ckrmB9ZbgHW1nhJFD8lwRq+AMz8+hgOsFV+tkXgQeZLxEj/j88VXcUcdwXftP/EyLp0YOW5cXpYGg9P//frpN/04vhEFOrbILuhXBX1JM3kmSvGg/6nfF9wNNuJjFVkoe63K6ac2RYowEtS48JiGBFfaVe6P72dIBmrd2whKRFtlCvSfFQMWpChC8CHRhAW0mHvCi3RQfzUrqBcFJOmCgy51WYcNBLm2sSMZZfuFyN/icWuaWdnoGlEN1J+YQAujMwQGipYY+ZtsEzg0hQzYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUGE0c6dj/0KvOdqbYZVG4+GhmYitlAvvfCAtm8XrEg=;
 b=cSEOjlb22UeJoLW96fuRfkpgcHOOVUs/2+xOMl4nlY/j5+Kkj2srp/7WpRUHXGlS3rJnRl/DOxvhDlMkD/FL6k73BwbUIKxX/0BnwD5FmF8DQfromhTQmoj5rGYVwYeTpkOJ2hmTY5XmCdz72EDztBg5JENrPuVuYSt+/H4MHq2Bg5pQGSa1q3Z3PTV3l4Epq06+L2HD1tBSCunvPthEZLTXJo0R8954xOZdYfoXk8U/2EW+R6a673ldKeJfRoQckJim4+j4JX/8E0KGWZSgbgzK24XrcJIBvk51O0AUCJIeHsa663d82gVfCYEP9XfIeNg4qkNnXRSyMZzvQSwang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUGE0c6dj/0KvOdqbYZVG4+GhmYitlAvvfCAtm8XrEg=;
 b=QhvdSsh1nAMLZjXKwA6tSG5y6tVXXloex/vRu6H8FymFEnw/NiYGxaP0/TwwS6fCcuJ6ujNUEi6K5eBW9dYA8N5rxksX0XENa1++YLl94Tzq5P2XAAJyJE2kNDEhRXlIYaLGrPW+WT92CKXFXyfaB3gpGOBVH7v3ZFDhIN0Vi3BsTDtdXtIoSPTijmYcWGdKydaRjnWkuflm6Z3BsOEuzkAYCR1S+/hZZNy3DVgKSkze/h8SCVpFEHTRAptv6EapKlFJu5J2dBb20zetJi6SykpuraHWfdtLmebM/9LiRM3rWNiPWw004+MWmRmc201514CgaXfru+tngiC8hiLydw==
Received: from PS2PR02CA0094.apcprd02.prod.outlook.com (2603:1096:300:5c::34)
 by SEZPR04MB7793.apcprd04.prod.outlook.com (2603:1096:101:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:21:05 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::8) by PS2PR02CA0094.outlook.office365.com
 (2603:1096:300:5c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:21:04
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
Subject: [PATCH v2 04/10] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE on Spider Board
Date: Tue,  1 Oct 2024 16:20:46 +0800
Message-Id: <20241001082053.3455836-5-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB7793:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1bd8dce-4f56-47be-b5d9-08dce1f1fe47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?klvPOOHkXwNONGYTUUDgEQsiZ0gQb4xiAtjd4GeeljxRTxNn7rb137qy4DN+?=
 =?us-ascii?Q?OTjfAK/kHumuw6MZr8N+fWeUbzHLn6Rlgf2+cBn33qZurGLBqtyKJIVAowrU?=
 =?us-ascii?Q?ObYV7jXyu28OoRsodICExrHOf6jT8njryefkP1e9r/00YM23yoOH5qzHeDTJ?=
 =?us-ascii?Q?AZHdh/3YNTv0Lskg5CgzGVWEaXddzF0m70hIVcDn2STZYEhtrxWdnDH2jb39?=
 =?us-ascii?Q?fhmT/UFRNNVAfoOnL2xrGXcnPr7jVhwNS6GGIJzXodF7aFAhwZMVZww/mmt7?=
 =?us-ascii?Q?Q0wdDyYwSTZUJIqrgewGQ1rHKj3LdpjWO6U/uUE0Vj5ZxdAvfKlTuUC+Xqmi?=
 =?us-ascii?Q?nVMOIh94wEDnO87OfzGQtSSKsrkzMEVF2oEWd0sREY4T+9b5i6gIWvA+pp1D?=
 =?us-ascii?Q?Gl6BKKzA4wZmdezEmstLNzmm5Vu8yEGVTM1nkgggCdEmN7T1OTPJQzKn2gMo?=
 =?us-ascii?Q?IgbAIJtJPxruVqj7sjjnJkGVvFELOkJW50Kq8aEZ8kfnOJdpe+H0ygidbnsn?=
 =?us-ascii?Q?yAmIV2BkvBjFlAJCJT4miRTdWkkk0uyrD+E9Xu8ABqJqTyqVV8sUndmJ4IMt?=
 =?us-ascii?Q?OiPiVAgoHiLlarScvwlOn35Q5z0BL6GVy9ERlwu/2kUCAJc99/WQgkTLH2DA?=
 =?us-ascii?Q?nVMKBWDI+z/ayVE2EHHe1f6Jkyf+0/WuJgwnBJ3HdpF+XQryp9UK+FTHR9E9?=
 =?us-ascii?Q?I3JZLf2X85tDzjf8lkBLDc2Pj/jA8XuLqTi1KlW/RhjKwqX+wRPDkJ3/07y9?=
 =?us-ascii?Q?uVSMLRyTohMib7lKM6LzTJlw5pbGA3f8NYIrsD5wNDl0xvdLI4txO+fxQeCk?=
 =?us-ascii?Q?cQmTFLoVqYLJcbK/jPRqgSlh5v71KbJdJ8s3BmDDU05hm2nBNEqaHwcTkQQx?=
 =?us-ascii?Q?GqrktaA3zZrNwLslj4by7RSECnB7MMsnSSJYcqbFwQDLfpUfY5NGoGWnSSlK?=
 =?us-ascii?Q?FBNFyAy0D3nr+tIeKSXdTsjQ1czCMjo6xJejYbDkG5vt91s6H+y+DxNRcYFH?=
 =?us-ascii?Q?fIstO9gXZSxX4hGpdxVJmFhnjhT7NLvMZVcupUfX61yOVMfC1+RR9tTNAMan?=
 =?us-ascii?Q?Tws42VkaLKqZ5UD9nnU3qgUBbAyqFpsrFXTmV5edfjLZLAnENHQQw79CBHxh?=
 =?us-ascii?Q?cpejLjVmefFuVYrqC4Tc9r0sTfMdo4Fjlsy7Z9uChbL1jWbPyOtT5Dd+M8ie?=
 =?us-ascii?Q?EAtVHak1+BnzDZP37WYPII0aYPpHjDflMh9xYxXKktlq04HxGNo6JQYhfTeS?=
 =?us-ascii?Q?NcjN8etl5KzaSg1cGwNpSSMIn97DgFeLg341GqTi3k3XT5zwLK8swxDwLqAr?=
 =?us-ascii?Q?zhkTz9JxbIKfMGM4qqsQ1TkR/oZBJoI/HHFaWUiUMuo5+mHZNWoPGP8SJ5Lo?=
 =?us-ascii?Q?W5htHR/BygM/Wf/5wOcCH/YBb0kc2xwpYjLyN3wc8alLFGlhpKL1Jdgk6vUw?=
 =?us-ascii?Q?WVAjYpEXt1L/CxVual+boVGCAw3vxwMo?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:21:04.6904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bd8dce-4f56-47be-b5d9-08dce1f1fe47
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7793

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add I2C mux for CPLD IOE on Spider Board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b813140b3c5b..26e0fcbed8d2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -30,6 +30,8 @@ aliases {
 		i2c25 = &imux25;
 		i2c26 = &imux26;
 		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -773,8 +775,72 @@ eeprom@54 {
 };
 
 &i2c10 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux28: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+				gpio-line-names = "","","","",
+						  "NIC0_MAIN_PWR_EN",
+						  "NIC1_MAIN_PWR_EN",
+						  "NIC2_MAIN_PWR_EN",
+						  "NIC3_MAIN_PWR_EN",
+						  "","","","","","","","",
+						  "","","","","","","","",
+						  "","","","","","","","";
+			};
+		};
+
+		imux29: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
 
 &i2c11 {
-- 
2.25.1



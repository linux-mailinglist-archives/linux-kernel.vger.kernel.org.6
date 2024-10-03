Return-Path: <linux-kernel+bounces-348690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7656698EA9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A502285988
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE7812C465;
	Thu,  3 Oct 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="VeV30Vh2"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010036.outbound.protection.outlook.com [52.101.128.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F313213A;
	Thu,  3 Oct 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941385; cv=fail; b=kysGpG/fRbuJuDqkkFOMK25pU/8QRUoz6iRsG3+ffRMG73tuyrI9RtQNoazVRlJ4xxbshLBoNoKzk6WZaZz5CMTp/ed77m7NAdCx59IvM4JOLc8RVLc6L5B15dgvcPB3MdR+fHAP9I4Jj+AwqnW9peNtjmWQLehnjzTSwhfLnnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941385; c=relaxed/simple;
	bh=g1adGF3lwHHdB1ffQqcV5iTbFfc2kZLf5HVOpt7Q53w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTmCy9lyEXMTSdeg2oW70hz3Y2O2C2xl5OLFLeMxhoMN4mDjeFMsqfrYSmQs2wg7PDoqZGfC5c+56Xt/PXGdSYhW2OXgg4AH6fA/b246Y0eqH7rqCTOXB/pVqr7OjIS72yM9Zm2k0sa63B30MnRQ0hC/C5pWOd5i71zyOyA8gIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=VeV30Vh2; arc=fail smtp.client-ip=52.101.128.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGUDw2k0zx8+l/940bTJcuC4nop6MuyytlRndbOkZTaUxy7zFw2RbAaXvP3H6Tybg9GE4a7j59ZtzcRhlCtsCj41tobHJkmDm8hHYamNNdHoVTcMABvAYDGTGUJnHhtPYoO7dBX895NdOoeR6MdUB8hpQlEXKNwBcwQe+/p1pQuKlNdEjWNMcfXrS95dua6DCxHL8ytVq9oq7vbvz0o/TlOqtsVXSlzGb8vWi9SDPUP7Vr1Hr+XDy2k8IdYB1b+k6T74YaKpoo9FzoAwbjDUenON2a38arKWc1swHo0A/BXlfHAoUedlc8P0ygCIjS+jiL9OmYSEAolTT0bM5sxDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F47+lFr35OElbtxQgaskMYGMxuTeq9ED4Q9Z3sufvu4=;
 b=XsArM+ODnjjbzkJ2wh6cmBkne8Am/sqnVgsNk2/zZVg7LC8iuATFS/pHYERJtruSDaR0uQwOtDhBU6FXTXMkFqUxhKyC7arg+dI3uKoMvsR+AC/JhTArrn6ELx7k9HMP0ncC5/QnfRru6eAOELHbwMfhyeNQ+aVtlR9IMgT1ygjVAE7oLQAZHjJYm9QiZuYuCVlPI/bNI1bPem8AS6X4palS8GaSuOmOv+XyQKhUF69hHxEJ85r0D088/+Zu5mDaZloPXj83HonGxatX2IPZ7gQ3q8KOPPafEIcrJz/asEhD1Ql0fwwio5wZR7w6Z7yP021r6EhTlvKcxyb2LwD1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F47+lFr35OElbtxQgaskMYGMxuTeq9ED4Q9Z3sufvu4=;
 b=VeV30Vh2rxkcZ1q4M5HO2wOkvUeQdqG7xLCywjRJiAhrgmsp2y5chK8M+yQ7ax7ygvCBM8MnDDUdXMIjWXpNiYppbFi3+voUK5mhmbvTJ1i6K4nhqju9aTHQSKWVQiunnkKWM6kx1otdbXVGGtcP7E/LYgVI5UWmvRpxHOOCzYC+KO/EuewcRPjHk2JmWQAZ56w4pym3rncaj2+g7mFqRSRGFRmbMDxVNS0lNAgPbZKar5acOs8M7u6XUIMwqd/PdjVUK4zgozGRgpOvCxtzm9oOJjvbKNhDrIB5SEowz6tAKJjDWL0RXTRXCVsIt+x76GO7ChaI2k3ftW86BdC62Q==
Received: from SI2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:4:194::22)
 by JH0PR04MB8065.apcprd04.prod.outlook.com (2603:1096:990:9a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Thu, 3 Oct
 2024 07:42:56 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::d) by SI2PR02CA0002.outlook.office365.com
 (2603:1096:4:194::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:42:55
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
Subject: [PATCH v3 1/9] ARM: dts: aspeed: yosemite4: add i2c-mux for all Server Board slots
Date: Thu,  3 Oct 2024 15:42:42 +0800
Message-Id: <20241003074251.3818101-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|JH0PR04MB8065:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9d09091-1323-4fe7-4d77-08dce37eff2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hplh5HOR5W62UeCBqhNEBZO60IwI/9LloX4vmIc7xsqnp+77HDwBw+IRzVsJ?=
 =?us-ascii?Q?RJPzQ818O8tBAWr2vnC/wpMQow8rr7twCPfs5QqtBdshNIke9KqOp59hhLE+?=
 =?us-ascii?Q?QfjIFAHqgIKidXo+QxjdIeCjb5mMDra8hgJQm7JTrZbI4cx7uv+XvfZORhz8?=
 =?us-ascii?Q?ImsXP5QUyWclS+aLbBFb8DUjBh+f/g7yOGUqzBkwedFLvbGxZx+2pD0vnePv?=
 =?us-ascii?Q?6UsAD4x4xs8VtdJFOGEVxJtkSspyp4BYmWfw3xSNX+kkSS//1zobeyFhktAh?=
 =?us-ascii?Q?rCD/nnJ4d7rtIRaN48TdtPt1qGZBR12KRQME+H5ktSWXmukYRs95VjMn0JY1?=
 =?us-ascii?Q?6GgXT1BJ4o5ZMeER4LJWS8o5i0QR5pUm61jZi8bRX6qjAhrY7tAH32Ciid1S?=
 =?us-ascii?Q?I+KzDyPQKD5FL89m3h35pkIfS0vi913ZeFLm5craOQvIn2rDxbdyveCP5Mwk?=
 =?us-ascii?Q?c1yG5r1YteaTgVT3lsdNDm9lp0UWezNt5r5s0QyDC/VCpvmJp0GETvrYQCYO?=
 =?us-ascii?Q?jNC16Cx98yybdg6NzHgUVDBRmj5PyDj2SnSlbgvo2cKGzh1fP+dE3anOjvi6?=
 =?us-ascii?Q?XsOljrQfiuQcZq3HW/Jx7RHzRRFjzsuHAvMr49WP189BOEZP2KlnvL+BWR4u?=
 =?us-ascii?Q?vtiDiPAcvmcrSuGg+qMnGMkwTY1Cx35AWKYqdaP46uzXhGtX8BitdAOApMoE?=
 =?us-ascii?Q?20qhIoCKd2MdjIBRlkW4ccGy8L5xPGwNUKTywfWcaZuGolUn04nPby1qezIT?=
 =?us-ascii?Q?dq0oRt7pXVvByCRXWEN0s4YvEJng5RE+0AT4eWXaDfIxLAAfSiwJdeHqByTa?=
 =?us-ascii?Q?I4OAt8hW4JD8ekX20ta3zqio01cAoGBCGCyIowH6JXxBqXETAcNN+za/fsw3?=
 =?us-ascii?Q?FF8ebO4rGpX3nbooNA6Bwl92qt2yl/nwvK6qeww2TYxCbaaokeJ3mtKxoY9K?=
 =?us-ascii?Q?LxYXjA7pejDBvp4aWXTVUWHf7ppR8z0cHQh4fHWrbaJxmPI8w2UMr8OC068h?=
 =?us-ascii?Q?0zwk+cf6aU92JNZG/tpXg+zh6+Qb8Q61rWaQyixMpK0DKR2jy4BQ6FSEgand?=
 =?us-ascii?Q?6GXyReB1/85lnHWfs98vuuw6AOlIIvSXoXjgP6k+JCaLaQwq9DF1S/ivhdCK?=
 =?us-ascii?Q?gbOPrFDoRssO5bFXy68k8quSoR4bwaOoAeyo1iBdGGCy/iBmC0ZzwEzGJ/6V?=
 =?us-ascii?Q?JwWbzEMfg3MuSXh2td4n4KyUcC5IHHyh02/hHL+EgLT3h64pyC+QDBXzMxi7?=
 =?us-ascii?Q?GeqgVmcEIpTJeNXFDNKV9QU/aqCIu0aAspkdv6ywPBS0baCTTcdXJAaNyIyU?=
 =?us-ascii?Q?cPhWL5lVKCkXeJ5tCba/kZcpZkj6l09Xqbsk9JYbMT0yyZf6cxHTBihMWB2Z?=
 =?us-ascii?Q?Bzr3uhs=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:42:55.8992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d09091-1323-4fe7-4d77-08dce37eff2b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8065

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c mux to 8 slots of server board and add the io expanders and
eeprom for the slots.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 238 +++++++++++++++++-
 1 file changed, 234 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ae2a2ed603ff..5d623d0355df 100644
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



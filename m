Return-Path: <linux-kernel+bounces-318516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAF596EF11
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09953288078
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417381C870A;
	Fri,  6 Sep 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ITLjExHF"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04141459FD;
	Fri,  6 Sep 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614698; cv=fail; b=AtaxnQJ7VjQ58cS84G8wNtyuTDrx5iR0pz0uN2Stxmsx8ImZzekje0vd+0NhZyTl7MWQn3ZKLU3Ebxg5Im6RxP+z+bSgeBP7Zh/iX7ricA+U9aSJ0HVj6xr+aBIwH/SMPAVOEO5ZKZUI+05CgdbU/vbLYxjIlz4643coudXaG/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614698; c=relaxed/simple;
	bh=W6UZMei+ar9+3SvhLYK+7SkpTNNLKByd5tTcybdEaUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNCuIkn0R59xlnwagg3PTo/0uztDHpSZxOrN8cNUI3B1sIVhAVCew4jHqQgTITbGedWTEiGIudrJHepx45LFf0bMRx6bDMYsssbyKorybpiHtrpo29uwYUdX3BebyzfaJztMj3E7/Modo8CRHLyW+yjey7f7hkXdTC9qnmuTrxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ITLjExHF; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFXyMhUbE8w6NVe6QStgWPjxGxJzFxBJT2UOcmkXvl0SLETIdQMLCUT9bp+rZu2wzsJHuoI59OqzD/T8PMWiGiqGyf1l0UIPSaZpxhRUdicCojYDU/eNn9beObS7mOSCwjAcrZ9iuaKlfUUx3+/XNHRWKNarqFcy4k6ZudE/aRyyjzLJ5upwEXMzAWR0y0HKxnzlWRwI8LqRcqc9IWR+l/GQ4tm8+dzvyxJFydh5bllBSD1IcPm2+ev+avM9PjyT4Hr7RGZOMNOnlP4WQVwEecoTXgghOUnPyWLzoj8CgR1Q2RX7C6zt4+E+mn4P82ayUhVXvD6MOCK5aKBgcCPAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK1CZ67tbESXAFSt5cUXs7bqD4h7ZJeDmdQmYlqAfWU=;
 b=t06Yu5PfhIUGIOS0qCdyquTSBzG0FWNSLGx8YBtPZ00/lPbnvo4T4qFLg6eA/zCVyRjA1ZEnnR+/zRbMu+MKtbQp4JjTSi5r8upuA1AeLpVMx1N0oxM3E3jOXYGIde4zhZmY7a13E9qiP0xdAbYk6t3zkj1sj3StYWwCX+bGen6boVXt7MtUINy/eQmgrYkRBxBu2VNsVv3O1dQ484+l6kBI9ndhDPTVPkgaj9+H04tF10FDlmpP5R9G/JFcBB5wDoTR88VBcJy0j7IJw4l7piLYMhibLW2ar45UkG7O5DaibkuJCNZcbY1FCRbANmOQO6H1AQS3x7L4+IK0xxXXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK1CZ67tbESXAFSt5cUXs7bqD4h7ZJeDmdQmYlqAfWU=;
 b=ITLjExHFQVs5z0ys5FwcZARsdIFDeIeCraYWR2eVdv18LGQ21hflrRNrE0VrKumIaUg/ACQ9e3YjGt0aHxwpRvZCKZlnX5eBAKfIcTyALlcWh0Lz+8QUJLpZczlRgOlW+CiUheofiOtf8xXTb9PvzqVbH5i6SMQcm/PW8RXZLy8FyTKwfMA0p38mJAQHHF0UBtgYYlnBFi8m9uRKKcyEWOIhLqZSFeThwkqwKHquelAnyZpHB5mheqJOqJnpfy3Jg2Cx+6U5Ip4BkKVG2UlhbWSjlAu7FucEJtJ2ixLsfqxNUCZCFcPjgT6652JvAf/5WysN6tIN1fhHEIKiE7pXsA==
Received: from SI1PR02CA0030.apcprd02.prod.outlook.com (2603:1096:4:1f4::8) by
 TYZPR04MB6474.apcprd04.prod.outlook.com (2603:1096:400:282::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 09:24:49 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::ae) by SI1PR02CA0030.outlook.office365.com
 (2603:1096:4:1f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:24:48
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v16 2/3] ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
Date: Fri,  6 Sep 2024 17:24:36 +0800
Message-Id: <20240906092438.1047225-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TYZPR04MB6474:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 014ce49f-7fcb-4632-8c3d-08dcce55c172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8ypBBTDzs3lO835Onog24u532io9BnQyjZmntTZqWOZFDJFU+ETHOAF60ad?=
 =?us-ascii?Q?AzAYMbh3gmxyXajxECCR4RqPo6SFGPOaJra5aKQmZ/payeryT5i0zce2XclV?=
 =?us-ascii?Q?bMBL+VOtHV8tz4sbqnI1JOgC4fuYp2b405AsDi04F/8ueRDjrzVTsMUc/G6w?=
 =?us-ascii?Q?db7FnNAzIyZC7ziLhhK/4xqtXNd4U5tN0khWxWAgK3svhx4vBrImDFUP8UAG?=
 =?us-ascii?Q?MUq/hgJFmOd9Eq9EDlPGDtB80Z9rdBsoHh4fAWPfiJYqoWKIv7gbmhmb9I0R?=
 =?us-ascii?Q?bxAEZU/fpHWtzXjvd21uwal8Ty7aGmXCXEMatCQTlcl1YYaBVn4mHm7U+ZrV?=
 =?us-ascii?Q?HshuJLvpN58+LtWLRerzEwt956CVJtbQfAshw4Sx3hV2XbkPDJpK3sKAmnvA?=
 =?us-ascii?Q?fIbhS7YlUFf3cuZn5PjhzhaA/yE57xJlbPU31RjfdOg5DdptJDzoSY5d3RNo?=
 =?us-ascii?Q?k7gHBJsQyiveIMnGHWEY6gi/oIpHjqWQJgnvxp+5G+mra9ZHrnPIjx7LIBOs?=
 =?us-ascii?Q?aTiOcszhU0WrJpd/1HakY/tnyoru+CIRyFuTUuANh585ZeYHt5+Mx68Wdk4C?=
 =?us-ascii?Q?Sy7kqB8f6USaGg5x5zR46qQMEu0QAkZhJ8RR9159ktphia7WCYoZPrn0ORPk?=
 =?us-ascii?Q?qN3Bl6kSF7GVsG1lyA8dPt6hIwWgizdjtSNXZMuL1d5U8uOnSFN+NCBiMNiz?=
 =?us-ascii?Q?l3NQiDyYr2MqZ8Ta3/UKffltFPAmtbr3UBo3reXCt1OzGjkFwXXxQ3tP0m8G?=
 =?us-ascii?Q?jbOqPL5kK0lKP0Ynp+cWAlny7wwSafGa7kJ8tf3Ii4sJt7fJko583sZefU74?=
 =?us-ascii?Q?bjF+l3ALyXYQHoTOu8LE9CNH3he23HmNOdjX/0ygIDlbsPVNlz6GCoL4+WzP?=
 =?us-ascii?Q?LLYuf1A3mHuXmPmEnCzBVFLtVBnnVhyVgj1qnYAa8ETU3MRgXv2UxIihuZhg?=
 =?us-ascii?Q?kp2eTyr3Z/oOzFHvR60wJO0jmIm5bcRvzQicKaanT86J6X41jAlW2RQyqrqw?=
 =?us-ascii?Q?5T9Uo2ZWyYjIjZNvuluD46CLl29m+VFmyjNDok8y5gZC+ScNY/874Au7ETdP?=
 =?us-ascii?Q?dbA6QvUQh+5NA0kLys+CrQpfQD10882MOXds4znSFxAlAXqZBmFO4JnuJjz2?=
 =?us-ascii?Q?RuA7nKV6LxlgEb9P4oIlMpk0LIDMxdZ5Zz7oyXZlmjQGs/T6b6g8R3HHgOf6?=
 =?us-ascii?Q?KjRp6duENea0rOduuls05acm+lKz8UaRbIa4P9wcUzG0ovCZh8XQwPeAME/f?=
 =?us-ascii?Q?eYQgbSRIOG72xAc4cQwKiQKGDk3wUVhOlJFAa7ywCPdVBJyCrEGE3tbzbArR?=
 =?us-ascii?Q?3G3h+koJe+XQpOj3fDrwLN/fF0brXYF0IMWarWwYvyT/LbVPjDrf1GdmWYY0?=
 =?us-ascii?Q?wvojrhWt6Y4mbUhNbMSaL6OLGJ+o9yO6e8Widp80eLWOHMwn2a7G0VFPgLJx?=
 =?us-ascii?Q?sHKgzGHJnIrnZsiDN1+hD0fJOXpXlwYt?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:24:48.6100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 014ce49f-7fcb-4632-8c3d-08dcce55c172
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6474

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

- Add MCTP config for NIC and remove the unnecessary MCTP config on bus
15.
- Add 2nd source temperature sensors EMC1403 for NIC.
- Add eeprom for NIC.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 96039ffbf8ef..9ddeccf650cd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -918,7 +918,6 @@ adc@35 {
 
 &i2c15 {
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -936,40 +935,88 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
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


